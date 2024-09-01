provider "google" {
  credentials = var.GOOGLE_CREDENTIALS
  project = var.project_id
  region  = var.region
}

# Enable the Cloud Resource Manager API
resource "google_project_service" "gcp_resource_manager_api" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}