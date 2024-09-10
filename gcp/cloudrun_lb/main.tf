module "lb-http" {
  source  = "terraform-google-modules/lb-http/google//modules/serverless_negs"
  version = "11.0.0"

  name    = "${var.prefix}-lb"
  project = var.project
  labels  = var.labels

  backends = {
    default = {
      description = "Cloudrun services"
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn = false

      iap_config = {
        enable = false
      }
      log_config = {
        enable = false
      }
    }
  }
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  name                  = "${var.prefix}-serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  project               = var.project
  cloud_run {
    service = google_cloud_run_service.main.name
  }
}

resource "google_cloud_run_service" "main" {
  name     = "${var.prefix}-cloudrun"
  location = var.region
  project  = var.project

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }
  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "all"
    }
  }
}

resource "google_cloud_run_service_iam_member" "public-access" {
  location = google_cloud_run_service.main.location
  project  = google_cloud_run_service.main.project
  service  = google_cloud_run_service.main.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

module "service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.2"
  project_id = var.project
  prefix     = "ecs-sa"
  names      = ["ecs"]
  project_roles = [
    "${var.project}=>roles/monitoring.metricWriter",
    "${var.project}=>roles/serviceusage.serviceUsageViewer",
    "${var.project}=>roles/pubsub.subscriber",
    "${var.project}=>roles/pubsub.viewer",
  ]
  display_name  = "ECS Service Account"
  description   = "For log based activities"
  generate_keys = true
}
