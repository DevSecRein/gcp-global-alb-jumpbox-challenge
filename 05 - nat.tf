# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "privatenat" {
  name   = "${var.private_subnet_name}-nat"
  router = google_compute_router.privaterouter.name
  region = var.private_region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.privatenataddress.self_link]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
resource "google_compute_address" "privatenataddress" {
  name         = "${var.private_subnet_name}-nat-address"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region       = var.private_region
#   depends_on = [google_project_service.compute]
}
#------------------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "publicnat" {
  name   = "${var.public_subnet_name}-nat"
  router = google_compute_router.publicrouter.name
  region = var.public_region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.public-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.publicnataddress.self_link]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
resource "google_compute_address" "publicnataddress" {
  name         = "${var.public_subnet_name}-nat-address"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  region       = var.public_region

#   depends_on = [google_project_service.compute]
}

#------------------------------------------------------------------------
