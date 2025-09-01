resource "google_compute_instance" "keniaos" {
  name         = "keniaos"
  machine_type = var.rdp_machine_type
  zone         = "${var.public_region}-a"

  tags = [var.rdp_access_tag]

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2022"
    }
  }

  // Local SSD disk
#   scratch_disk {
#     interface = "NVME"
#   }

  network_interface {
    subnetwork   = google_compute_subnetwork.public-subnet.id

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

}
