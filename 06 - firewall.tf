# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
resource "google_compute_firewall" "latamhttp" {
  name    = "latamhttp"
  network = google_compute_network.latam.name

  allow {
    protocol      = "tcp"
    ports         = ["80"]
    
  }
source_ranges = ["0.0.0.0/0"]
source_tags = [var.rdp_access_tag]
target_tags = [var.private_access_tag]

}

resource "google_compute_firewall" "latamssh" {
  name    = "latamssh"
  network = google_compute_network.latam.name

  allow {
    protocol      = "tcp"
    ports         = ["22"]
  }

source_ranges = ["0.0.0.0/0"]
source_tags = [var.rdp_access_tag]
target_tags = [var.private_access_tag]
}

resource "google_compute_firewall" "latamicmp" {
  name    = "latamicmp"
  network = google_compute_network.latam.name

  allow {
    protocol      = "icmp"
  }

source_ranges = ["0.0.0.0/0"]
source_tags = [var.rdp_access_tag]
target_tags = [var.private_access_tag]
}

resource "google_compute_firewall" "latamrdp" {
  name    = "latamrdp"
  network = google_compute_network.latam.name

  allow {
    protocol      = "tcp"
    ports         = ["3389"]
  }

source_ranges = ["0.0.0.0/0"]
target_tags = [var.rdp_access_tag]
}