terraform {
  required_version = ">= 1.1"
}

provider "google" {
  credentials = file("credentials.json")
  project     = var.project_id
  region      = var.region
}
