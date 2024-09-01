provider "google" {
  credentials = var.GOOGLE_CREDENTIALS
  project = var.project_id
  region  = var.region
}

resource "google_apigee_organization" "my-test-org" {
  name         = "my-test-org"
  display_name = "Example Organization"
}

resource "google_apigee_environment" "my-test-env" {
  org_id      = google_apigee_organization.my-test-org.name
  name        = "test"
  display_name = "Test Environment"
}

resource "google_apigee_environment_group" "env-group" {
  name           = "test-env-group"
  display_name    = "Example Environment Group"
  environments    = [google_apigee_environment.my-test-env.name]
}