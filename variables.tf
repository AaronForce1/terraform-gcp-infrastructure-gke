variable "google_region" {
  description = "Google Region for all primary configurations"
}

variable "google_secondary_region" {
  description = "Google Secondary Region for certain redundant GCP components"
}

variable "google_project_id" {
  description = "Google Project ID"
}

variable "tech_email" {
  description = "Tech Contact E-Mail for services such as LetsEncrypt"
  default = "tech@example.com"
}

######################################
##           Base Tagging           ##
######################################
variable "app_name" {
  description = "Application Name"
  default     = "gke"
}

variable "app_namespace" {
  description = "Tagged App Namespace"
}

variable "tfenv" {
  description = "Environment"
}

variable "billingcustomer" {
  description = "Which Billingcustomer, aka Cost Center, is responsible for this infra provisioning"
}

variable "cluster_name" {
  description = "Custom Cluster and Resource Naming conventions instead of standard {app}-{namespace}-{env}"
  default = ""
}

######################################
##        VPC Configurations        ##
######################################
variable "vpc_subnet_configuration" {
  type = object({
    base_cidr = string
    subnet_bit_interval = object({
      public  = number
      private = number
    })
    autogenerate = optional(bool)
  })
  description = "Configure VPC CIDR and relative subnet intervals for generating a VPC. If not specified, default values will be generated."
  default = {
    base_cidr = "172.%s.0.0/16"
    subnet_bit_interval = {
      public  = 6
      private = 2
    }
    autogenerate = true
  }
}

variable "network_logging_configuration" {
  description = "Manually configure various VPC/Subnet/Network flow logs; Please note, for production, these are enabled by default otherwise they will be disabled; setting a value for this object will override all defaults regardless of environment"
  type = object({
    subnet_flow_logs = optional(object({
      enabled = bool
      interval = optional(string)
      sampling = optional(string)
      metadata = optional(string)
    }))
  })
  default = {}
}

variable "custom_namespaces" {
  description = "Adding namespaces to a default cluster provisioning process"
  type        = list(string)
  default     = []
}

variable "helm_installations" {
  type = object({
    dashboard         = bool
    gitlab_runner     = bool
    gitlab_k8s_agent  = bool
    vault_consul      = bool
    ingress           = bool
    elasticstack      = bool
    monitoring        = bool
    argocd            = bool
    stakater_reloader = bool
    metrics_server    = bool
  })
  default = {
    dashboard         = false
    gitlab_runner     = false
    gitlab_k8s_agent  = false
    vault_consul      = false
    ingress           = true
    elasticstack      = false
    monitoring        = true
    argocd            = false
    stakater_reloader = false
    metrics_server    = true
  }
}