# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
resource "google_compute_router" "privaterouter" {
  name    = "${var.private_subnet_name}-router"
  region  = var.private_region
  network = google_compute_network.latam.id
}

resource "google_compute_router" "publicrouter" {
  name    = "${var.public_subnet_name}-router"
  region  = var.public_region
  network = google_compute_network.latam.id
}