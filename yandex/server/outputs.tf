output "instance_id" {
  value = yandex_compute_instance.this.id
}
output "instance_ip" {
  value = yandex_compute_instance.this.network_interface.0.nat_ip_address
}
