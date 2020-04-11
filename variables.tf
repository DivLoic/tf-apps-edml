variable "gcp_project" {}

variable "gcp_region" {
  default = "europe-west2"
}

variable "service_account_id" {}

variable "confluent_cloud_configuration" {}

variable "project_prefix" {
  default = "edml"
}