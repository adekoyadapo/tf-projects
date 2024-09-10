terraform {
  backend "gcs" {
    bucket = "elastic-customer-eng-tfstate"
    prefix = "terraform/cloudrun_lb"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.36.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.36.0"
    }
  }
}