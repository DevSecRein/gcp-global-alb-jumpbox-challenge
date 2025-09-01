# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_template
# https://developer.hashicorp.com/terraform/language/functions/file
# Google Compute Engine: Regional Instance Template
resource "google_compute_region_instance_template" "latam_template" {
  name         = "zone-sensitive-template"
  description  = "startup script differs per zone"
  region       = var.private_region
  machine_type = var.linux_server_machine_type
  tags = [var.private_access_tag]

  # Create a new disk from an image and set as boot disk
  disk {
    source_image = "debian-cloud/debian-12"
    boot         = true
  }

  # Network Configurations 
  network_interface {
    subnetwork = google_compute_subnetwork.private-subnet.id
    # access_config {
    #   # Include this section to give the VM an external IP address
    # }
  }

  # Install Webserver using file() function
  metadata_startup_script = file("./scripts/zsri.sh")
}