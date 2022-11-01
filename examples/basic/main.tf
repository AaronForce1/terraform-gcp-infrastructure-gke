module "terraform-gcp-infrastructure-gke" {
  source = "../../"

  google_region = "asia-east2"
  google_secondary_region = "asia-east1"
  google_project_id = "146485093961"
  
  billingcustomer = "test"
  app_namespace = "testing"
  tfenv = "basic"
}