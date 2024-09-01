provider "google" {
  credentials = var.GOOGLE_CREDENTIALS
  project = var.project_id
  region  = var.region
}

# Enable the Compute Engine API
resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}