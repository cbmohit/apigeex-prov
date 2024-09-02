provider "google" {
  credentials = var.GOOGLE_CREDENTIALS
  project = var.project_id
  region  = var.region
}

# This is to Enable the Service networking API
resource "google_project_service" "servicenetworking" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"
}

# Enable the apigee API
resource "google_project_service" "apigeeapi" {
  project = var.project_id
  service = "apigee.googleapis.com"
}

resource "google_compute_network" "apigee_network" {
  name       = "apigee-network"
  depends_on = [
    google_project_service.servicenetworking,
    google_project_service.apigeeapi
  ]
}

resource "google_compute_global_address" "apigee_range" {
  name          = "apigee-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.apigee_network.id
  depends_on = [
    google_project_service.servicenetworking,
    google_project_service.apigeeapi
  ]
}

resource "google_service_networking_connection" "apigee_vpc_connection" {
  network                 = google_compute_network.apigee_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.apigee_range.name]
  depends_on = [
    google_project_service.servicenetworking,
    google_project_service.apigeeapi
  ]
}

resource "google_apigee_organization" "my-test-org" {
  analytics_region   = "us-central1"
  project_id         = var.project_id
  authorized_network = google_compute_network.apigee_network.id
  depends_on         = [
    google_project_service.servicenetworking,
    google_project_service.apigeeapi,
    google_service_networking_connection.apigee_vpc_connection
  ]
}