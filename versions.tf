terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source   = "hashicorp/google"
      version  = "~> 4.41"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.18"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.14"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}