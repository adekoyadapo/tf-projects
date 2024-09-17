
resource "google_compute_region_backend_service" "backend-service" {
  project               = var.project
  region                = var.region
  name                  = "${var.prefix}-region-service"
  protocol              = "HTTP"
  load_balancing_scheme = "INTERNAL_MANAGED"

  backend {
    group           = google_compute_region_network_endpoint_group.cloudrun_neg.id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_health_check" "health-check" {
  name = "${var.prefix}-health-check"
  http_health_check {
    port = 80
  }
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "${var.prefix}-cloudrun-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_v2_service.main.name
  }
}

resource "google_compute_region_url_map" "regionurlmap" {
  project         = var.project
  name            = "${var.prefix}-regionurlmap"
  description     = "Created with Terraform"
  region          = var.region
  default_service = google_compute_region_backend_service.backend-service.id
}

resource "google_compute_region_target_http_proxy" "targethttpproxy" {
  project = var.project
  region  = var.region
  name    = "${var.prefix}-targethttpproxy"
  url_map = google_compute_region_url_map.regionurlmap.id
}

resource "google_compute_forwarding_rule" "forwarding_rule" {
  name                  = "${var.prefix}-forwarding-rule"
  provider              = google-beta
  region                = var.region
  project               = var.project
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  ip_address            = google_compute_address.lb_internal_ip.address
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.targethttpproxy.id
  network               = module.vpc.network_name
  subnetwork            = [for i, j in module.subnets.subnets : j.name][0]

  depends_on = [module.subnets]
}