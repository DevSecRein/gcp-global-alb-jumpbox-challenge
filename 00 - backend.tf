# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = var.gcp_tf_bucket
    prefix = "terraform/state"
    credentials = var.key_name
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}