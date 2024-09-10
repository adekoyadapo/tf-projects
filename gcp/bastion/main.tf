data "terraform_remote_state" "local" {
  backend = "local"
  config = {
    path = "../base/terraform.tfstate"
  }
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
      subnet_private_access = true
    }
  ]
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

resource "google_storage_bucket_object" "default" {
  name         = local_file.random_paragraph_pet_file.filename
  source       = local_file.random_paragraph_pet_file.filename
  content_type = "text/plain"
  bucket       = module.bucket.name
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 6.1"

  name       = "gcs-${var.network_name}-${var.region}"
  project_id = var.project
  location   = var.region

  force_destroy = true

  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "serviceAccount:${module.iap_bastion.service_account}"
  }]
}

# Define a random string resource
resource "random_string" "random_paragraph" {
  length  = 200
  special = false
}

# Write the random paragraph to a text file
resource "local_file" "random_paragraph_file" {
  filename = "random_paragraph.txt"
  content  = random_string.random_paragraph.result

  # Local provisioner to remove the file on delete
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${self.filename}"
  }
}

# Generate random words simulating a paragraph
resource "random_pet" "random_paragraph_pet" {
  length = 10
}

# Combine random pet words into a paragraph and write to a text file
resource "local_file" "random_paragraph_pet_file" {
  filename = "random_pet_paragraph.txt"
  content  = join(" ", random_pet.random_paragraph_pet.*.id)

  # Local provisioner to remove the file on delete
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${self.filename}"
  }
}
