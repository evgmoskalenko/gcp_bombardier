resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "vm" {
  count        = var.vm_count
  name         = format("vm-bombardier-%s-%s", random_id.instance_id.hex, count.index)
  machine_type = var.vm_machine_type
  zone         = data.google_compute_zones.available.names[0]
  tags         = ["allow-vm"]

  metadata_startup_script = file("${path.module}/user_data/user_data.sh")

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}

resource "google_compute_firewall" "allow-vm" {
  name    = "default-vm-allow-access"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = [
    local.workstation_external_cidr,
  ]
  target_tags = ["allow-vm"]
}
