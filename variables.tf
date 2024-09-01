variable "GOOGLE_CREDENTIALS" {
    type = string
    description = "JSON GCP credentials"
}

variable "TF_CLI_ARGS_plan" {
  type = string
  default = ""
}

variable "project_id" {
    description = "GCP project id"
    type = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}