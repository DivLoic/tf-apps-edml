data "template_file" "ksql_server_properties" {

  template = file("${path.module}/util/ksql-server.properties")

  vars = {

    global_prefix        = var.project_prefix
    broker_list          = var.confluent_cloud_configuration["broker_list"]
    access_key           = var.confluent_cloud_configuration["access_key"]
    secret_key           = var.confluent_cloud_configuration["secret_key"]
    sr_access_key        = var.confluent_cloud_configuration["sr_access_key"]
    sr_secret_key        = var.confluent_cloud_configuration["sr_secret_key"]
    confluent_home_value = "/etc/confluent/confluent-${var.confluent_version}"

    schema_registry_url        = var.confluent_cloud_configuration["schema_registry_url"]
    schema_registry_basic_auth = var.confluent_cloud_configuration["schema_registry_basic_auth"]
  }
}

data "template_file" "ksql_server_bootstrap" {

  template = file("${path.module}/util/ksql-server.sh")

  vars = {

    confluent_home_value        = "/etc/confluent/confluent-${var.confluent_version}"
    ksql_server_properties      = data.template_file.ksql_server_properties.rendered
    confluent_platform_location = "http://packages.confluent.io/archive/${substr(var.confluent_version, 0, 3)}/confluent-${var.confluent_version}-2.12.zip"
  }
}