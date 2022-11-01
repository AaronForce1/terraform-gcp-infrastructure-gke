data "local_file" "terraform-module-version" {
  filename = "${path.module}/VERSION"
}

data "google_compute_zones" "available" {
  region = var.google_region
  status = "UP"
}