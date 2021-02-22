# Provider
provider "google" {
  credentials = file("gcp-basic-305608-beca51c5855c.json")
  project     = "gcp-basic-305608"
  region      = "us-central1"
  zone        = "us-central1-c"
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}


#VPC creation
resource "google_compute_network" "vpc_network" {
  name = "${var.resource_name}-vpc"
}
#VM creation 
resource "google_compute_instance" "vm_instance" {
  name         = "${var.resource_name}-instance"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
#Subnetwork creation
resource "google_compute_subnetwork" "subnet-1" {
  name          = "${var.resource_name}-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}