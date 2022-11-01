locals {
  module_version = chomp(data.local_file.terraform-module-version.content)
}

locals {
  name_prefix = var.cluster_name != "" ? var.cluster_name : "${var.app_name}-${var.app_namespace}-${var.tfenv}"
  base_tags = {
    Environment                      = var.tfenv
    Terraform                        = "true"
    Version                          = local.module_version
    Namespace                        = var.app_namespace
    Billingcustomer                  = var.billingcustomer
    Product                          = var.app_name
    terraform-aws-infrastructure-eks = local.module_version
  }

  base_cidr = var.vpc_subnet_configuration.autogenerate ? format(var.vpc_subnet_configuration.base_cidr, random_integer.cidr_vpc[0].result) : var.vpc_subnet_configuration.base_cidr

  namespaces = concat(
    var.custom_namespaces,
    ["monitoring"],
    (var.helm_installations.vault_consul ? ["hashicorp"] : []),
    (var.helm_installations.argocd ? ["argocd"] : [])
  )
}

resource "random_integer" "cidr_vpc" {
  count = var.vpc_subnet_configuration.autogenerate ? 1 : 0
  min   = 0
  max   = 255
  keepers = {
    name = "${var.app_name}-${var.app_namespace}-${var.tfenv}-vpc"
  }
}
