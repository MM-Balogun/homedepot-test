provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo docker run -d -p 80:80 nginx
  EOF
}

data "google_compute_image" "debian" {
  family  = "debian-10"
  project = "debian-cloud"
}

variable "project_id" {
  description = "The ID of the project in which to create the instance."
  type        = string
}

variable "region" {
  description = "The region in which to create the instance."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which to create the instance."
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "The name of the instance."
  type        = string
  default     = "terraform-instance"
}

variable "machine_type" {
  description = "The machine type to use for the instance."
  type        = string
  default     = "e2-medium"
}

output "instance_name" {
  description = "The name of the instance."
  value       = google_compute_instance.default.name
}

output "instance_self_link" {
  description = "The self-link of the instance."
  value       = google_compute_instance.default.self_link
}

output "instance_external_ip" {
  description = "The external IP address of the instance."
  value       = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}
