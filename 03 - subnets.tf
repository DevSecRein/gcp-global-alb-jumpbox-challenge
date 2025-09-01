# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private-subnet" {
  name                     = "${var.private_subnet_name}-subnet"
  ip_cidr_range            = var.private_cidr
  region                   = var.private_region
  network                  = google_compute_network.latam.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "public-subnet" {
  name                     = "${var.public_subnet_name}-subnet"
  ip_cidr_range            = var.public_cidr
  region                   = var.public_region
  network                  = google_compute_network.latam.id
  private_ip_google_access = true
}