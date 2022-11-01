module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 4.0"

    project_id   = var.google_project_id
    network_name = "${var.app_name}-${var.app_namespace}-${var.tfenv}-cluster-vpc"
    ## ASK: Routing Mode Differences?
    routing_mode = "GLOBAL"

    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
    ## TODO: Configure region expansion in the future
    subnets = [
      for subnet in module.subnet_addrs.networks :
        {
            subnet_name           = subnet.name
            subnet_ip             = subnet.cidr_block
            subnet_region         = var.google_region
            subnet_private_access = "true"
            subnet_flow_logs      = try(var.network_logging_configuration.subnet_flow_logs.enabled, var.tfenv == "prod*" ? true : false)
            ## TODO: Add additional flow log configurations:
            # subnet_flow_logs_interval = "INTERVAL_10_MIN"
            # subnet_flow_logs_sampling = 0.7
            # subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        }
    ]

    ## ASK: Secondary Range Use Case?
    secondary_ranges = {
        # subnet-01 = [
        #     {
        #         range_name    = "subnet-01-secondary-01"
        #         ip_cidr_range = "192.168.64.0/24"
        #     },
        # ]

        # subnet-02 = []
    }

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        }
    ]
}

module "subnet_addrs" {
  source  = "hashicorp/subnets/cidr"
  version = "1.0.0"

  base_cidr_block = local.base_cidr
  networks = [
    {
      name     = "public-1"
      new_bits = var.vpc_subnet_configuration.subnet_bit_interval.public
    },
    {
      name     = "public-2"
      new_bits = var.vpc_subnet_configuration.subnet_bit_interval.public
    },
    {
      name     = "public-3"
      new_bits = var.vpc_subnet_configuration.subnet_bit_interval.public
    },
    {
      name     = "private-1"
      new_bits = var.vpc_subnet_configuration.subnet_bit_interval.private
    },
    {
      name     = "private-2"
      new_bits = var.vpc_subnet_configuration.subnet_bit_interval.private
    },
    {
      name     = "private-3"
      new_bits = var.vpc_subnet_configuration.subnet_bit_interval.private
    },
  ]
}