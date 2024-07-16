provider "google" {
  version     = "~> 4.80.0"
  credentials = file("~/.gcloud/credentials.json")
  project     = var.project_id
  region      = var.region
}
