variable "GOOGLE_CREDENTIALS" {
    type = string
    description = "JSON GCP credentials"
}

variable "project_id" {
    description = "GCP project id"
    type = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}