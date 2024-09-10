resource "google_project_service" "project" {
  for_each = toset(var.service)
  project  = var.project
  service  = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

module "service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.2"
  project_id = var.project
  prefix     = "tfaccount"
  names      = ["sa"]
  project_roles = [
    "${var.project}=>roles/owner"
  ]
  display_name  = "Terraform Service Account"
  description   = "For terraform based activities"
  generate_keys = true
}

resource "local_sensitive_file" "sa_keys" {
  content  = module.service_accounts.keys["sa"]
  filename = "${path.module}/sa.json"
}

module "cloud_storage" {
  source          = "terraform-google-modules/cloud-storage/google"
  version         = "~> 6.0.0"
  names           = ["${var.project}-tfstate"]
  project_id      = var.project
  location        = "us"
  set_admin_roles = true
  storage_class   = "STANDARD"
  force_destroy = {
    "${var.project}-tfstate" = true
  }
  versioning = {
    enabled = true
  }
  admins     = ["serviceAccount:${module.service_accounts.email}"]
  depends_on = [google_project_service.project]
}

