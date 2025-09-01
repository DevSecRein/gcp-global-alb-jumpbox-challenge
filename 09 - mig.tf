# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones
# Datasource: Get a list of Google Compute zones that are UP in a region
data "google_compute_zones" "privatezone" {
  status                     = "UP"
  region                     = var.private_region
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager
# Resource: Managed Instance Group
resource "google_compute_region_instance_group_manager" "bundalover" {
  depends_on                = [google_compute_router_nat.privatenat]
  name                      = "bam5-${var.private_subnet_name}-mig"
  base_instance_name        = "bam5-private-vm"
  region                    = var.private_region

  # Compute zones to be used for VM creation
  distribution_policy_zones = data.google_compute_zones.privatezone.names

  # Instance Template
  version {
    instance_template       = google_compute_region_instance_template.latam_template.id
  }

  # Named Port
  named_port {
    name                    = "graciebon"
    port                    = 80
  }

  # Autohealing Config
  auto_healing_policies {
    health_check            = google_compute_health_check.apphc1.id
    initial_delay_sec       = 300
  }
}