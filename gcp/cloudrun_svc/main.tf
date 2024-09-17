resource "google_cloud_run_v2_service" "main" {
  name     = "${var.prefix}-cloudrun"
  location = var.region
  project  = var.project
  ingress  = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
    # vpc_access {
    #   network_interfaces {
    #     network    = module.vpc.network_name
    #     subnetwork = [for i, j in module.subnets.subnets : j.name][1]
    #   }
    # }
    containers {
      image = var.image_url

      volume_mounts {
        name       = "nginxconfig"
        mount_path = "/etc/nginx/conf.d/"
      }
      volume_mounts {
        name       = "webfiles"
        mount_path = "/usr/share/nginx/html/content"
      }
      ports {
        container_port = var.container_port
      }
      resources {
        limits = {
          memory = "512Mi"
          cpu    = "1"
        }
      }
    }
    dynamic "volumes" {
      for_each = toset(var.buckets)
      content {
        name = volumes.key
        gcs {
          bucket    = module.bucket[volumes.key].name
          read_only = false
        }
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
  labels = var.labels
}

resource "google_cloud_run_v2_service_iam_member" "public-access" {
  location = google_cloud_run_v2_service.main.location
  project  = google_cloud_run_v2_service.main.project
  name     = google_cloud_run_v2_service.main.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

module "bucket" {
  for_each = toset(var.buckets)
  source   = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version  = "~> 6.1"

  name       = "gcs-${each.key}-${var.region}"
  project_id = var.project
  location   = var.region

  force_destroy = true

  labels = var.labels
  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
  }]
}


data "terraform_remote_state" "local" {
  backend = "local"
  config = {
    path = "../base/terraform.tfstate"
  }
}

data "google_project" "project" {
  project_id = var.project
}


module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 9.1"

  project_id   = var.project
  network_name = var.network_name
}


module "subnets" {
  source  = "terraform-google-modules/network/google//modules/subnets"
  version = "~> 9.1"

  project_id   = var.project
  network_name = module.vpc.network_name

  subnets = [for i in var.subnets :
    {
      subnet_name           = i.name
      subnet_ip             = i.cidr
      subnet_region         = var.region
      description           = "${i.name} subnet"
      subnet_private_access = i.purpose == "REGIONAL_MANAGED_PROXY" || i.purpose == "GLOBAL_MANAGED_PROXY" ? false : true
      purpose               = i.purpose
      role                  = i.purpose == "REGIONAL_MANAGED_PROXY" || i.purpose == "GLOBAL_MANAGED_PROXY" ? "ACTIVE" : null
    }
  ]
}

resource "google_compute_address" "lb_internal_ip" {
  name         = "${var.prefix}-lb-internal-ip"
  subnetwork   = [for i, j in module.subnets.subnets : j.self_link][0]
  address_type = "INTERNAL"
  address      = cidrhost([for i, j in var.subnets : j.cidr][0], -4)
  region       = [for i, j in module.subnets.subnets : j.region][0]
}

module "iap_bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "6.0.0"

  project               = var.project
  zone                  = "${var.region}-a"
  network               = module.vpc.network_self_link
  subnet                = [for i, j in module.subnets.subnets : j.self_link][0]
  service_account_email = data.terraform_remote_state.local.outputs.service_account_email
  members               = values(data.terraform_remote_state.local.outputs.service_accounts)
  machine_type          = var.machine_type
  disk_size_gb          = var.disk_size_gb
  startup_script        = templatefile("${path.module}/startup.sh", {})
  labels                = var.labels

}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project
  name    = "allow-bastion-ssh"
  network = module.vpc.network_self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion.service_account]
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 5.0"
  project_id                         = var.project
  region                             = var.region
  router                             = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_router" "router" {
  project = var.project
  name    = "${var.network_name}-nat-router"
  network = module.vpc.network_name
  region  = var.region
}


resource "google_storage_bucket_object" "upload" {
  name         = "file.conf"
  source       = "${path.module}/nginx/file.conf"
  content_type = "text/plain"
  bucket       = module.bucket["nginxconfig"].name
}