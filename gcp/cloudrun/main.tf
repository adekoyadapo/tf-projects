data "google_project" "project" {
  project_id = var.project
}

resource "google_iap_client" "iap_client" {
  display_name = var.iap_oauth2_client_name
  brand        = var.iap_brand_name
}

resource "google_iap_web_iam_member" "iap_iam" {
  project = var.project
  role    = "roles/iap.httpsResourceAccessor"
  member  = "user:${var.iap_email}"
}

resource "google_project_service_identity" "iap_sa" {
  provider = google-beta
  project  = var.project
  service  = "iap.googleapis.com"
}

module "lb-http" {
  source  = "terraform-google-modules/lb-http/google//modules/serverless_negs"
  version = "11.0.0"

  name    = "${var.prefix}-lb"
  project = var.project
  labels  = var.labels

  ssl                             = true
  managed_ssl_certificate_domains = ["iap.aade.me"]

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
        enable               = true
        oauth2_client_id     = google_iap_client.iap_client.client_id
        oauth2_client_secret = google_iap_client.iap_client.secret
      }
      log_config = {
        enable = false
        # sample_rate = 0.5
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
    service = google_cloud_run_v2_service.main.name
  }
}

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
    containers {
      image = var.image_url

      ports {
        container_port = var.container_port
      }
      env {
        name  = "CLOUD_ID"
        value = var.cloud_id
      }
      env {
        name  = "ES_API_KEY"
        value = var.es_api_key
      }
      env {
        name  = "AZURE_OPENAI_API_KEY"
        value = var.azure_openai_api_key
      }
      env {
        name  = "AZURE_OPENAI_ENDPOINT"
        value = var.azure_openai_endpoint
      }
      env {
        name  = "AZURE_OPENAI_DEPLOYMENT_NAME"
        value = var.azure_openai_deployment_name
      }

      resources {
        limits = {
          memory = "512Mi"
          cpu    = "1"
        }
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

resource "google_cloud_run_v2_service_iam_member" "public-access" {
  location = google_cloud_run_v2_service.main.location
  project  = google_cloud_run_v2_service.main.project
  name     = google_cloud_run_v2_service.main.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-iap.iam.gserviceaccount.com"
}
