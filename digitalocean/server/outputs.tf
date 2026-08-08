output "droplet_id" {
  value = digitalocean_droplet.this.id
}
output "droplet_ip" {
  value = digitalocean_droplet.this.ipv4_address
}
