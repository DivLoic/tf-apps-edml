variable "project_prefix" {}

variable "gcp_project" {}

variable "gcp_region" {}

variable "gcp_network" {}

variable "ksql_instance_count" {
  type = number
  default = 1
}

variable "gcp_availability_zones" {
  type = set(string)
}

variable "confluent_version" {
  default = "5.4.1"
}

variable "confluent_cloud_configuration" {
  type = map(string)
}

