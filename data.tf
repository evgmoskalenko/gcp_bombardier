data "http" "workstation_external_ip" {
  url = "https://api.ipify.org"
}

locals {
  workstation_external_cidr = "${chomp(data.http.workstation_external_ip.body)}/32"
}

data "google_compute_zones" "available" {}
