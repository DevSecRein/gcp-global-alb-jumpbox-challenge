resource "google_compute_global_forwarding_rule" "entry-point1"{
    name                  = "tsa-gateway"
    ip_protocol           = "TCP"
    load_balancing_scheme = "EXTERNAL_MANAGED"
    port_range            = "80"
    target                = google_compute_target_http_proxy.proxy-1.id
    depends_on            = [google_compute_subnetwork.private-subnet]
}

resource "google_compute_target_http_proxy" "proxy-1"{
    name                  = "proximity"
    url_map               = google_compute_url_map.url-1.id
}

resource "google_compute_url_map" "url-1" {
    name                  = "theodoramoutinha"
    default_service       = google_compute_backend_service.distro-1.id
}

resource "google_compute_backend_service" "distro-1"{
    name                  = "musaamira"
    protocol              = "HTTP"
    load_balancing_scheme = "EXTERNAL_MANAGED"
    timeout_sec           = 10
    health_checks         = [google_compute_health_check.apphc1.id]
    enable_cdn            = true
    backend{
        group = google_compute_region_instance_group_manager.bundalover.instance_group
        balancing_mode  = "UTILIZATION"
        capacity_scaler = 1.0
    }
}