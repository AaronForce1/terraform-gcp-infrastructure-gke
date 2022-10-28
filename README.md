# infrastructure-terraform-eks

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

A custom-built terraform module, leveraging terraform to create a managed Kubernetes cluster on GKE. In addition to provisioning simply an GKE cluster, this module alongside additional components to complete an entire end-to-end base stack for a functional kubernetes cluster for development and production level environments, including a base set of software that can/should be commonly used across all clusters. Primary integrated sub-modules include:

## Assumptions

* You want to create an EKS cluster and an autoscaling group of workers for the cluster.
* You want these resources to exist within security groups that allow communication and coordination.
* You want to generate an accompanying Virtual Private Cloud (VPC) and subnets where the EKS resources will reside. 
* You want specific security provisions in place, including the use of private subnets for all nodes.
* The base ingress controller to be used is Nginx-Ingress Controller with internet-facing network load balancers. 

## Important note

The `cluster_version` is the required variable. Kubernetes is evolving a lot, and each major version includes new features, fixes, or changes.

**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**

An example of harming update was the removal of several commonly used, but deprecated  APIs, in Kubernetes 1.16. More information on the API removals, see the [Kubernetes blog post](https://kubernetes.io/blog/2019/07/18/api-deprecations-in-1-16/).


## Usage

### Provisioning Sequence

## Other documentation

## Doc generation

Code formatting and documentation for variables and outputs is generated using [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) which uses [terraform-docs](https://github.com/segmentio/terraform-docs).

Follow [these instructions](https://github.com/antonbabenko/pre-commit-terraform#how-to-install) to install pre-commit locally.

And install `terraform-docs` with `go get github.com/segmentio/terraform-docs` or `brew install terraform-docs`.

## Contributing


## Change log


## Authors

Created by [Aaron Baideme](https://github.com/aaronforce1)

## License

GPL Licensed. See [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) for full details.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

T<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
