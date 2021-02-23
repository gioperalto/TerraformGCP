output "id" {
  value = google_compute_instance.vm_instance.id
}

output "instance_id" {
  value = google_compute_instance.vm_instance.instance_id
}

output "networkID" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}

