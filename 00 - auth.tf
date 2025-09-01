# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.project_name
  region  = var.project_region
  credentials = var.key_name
}