locals {
  sshd_config = templatefile("${path.module}/../../etc/sshd_config", {
    port  = var.ssh_port
    users = [var.user]
  })
  user_data = templatefile("${path.module}/../../etc/cloud-init.cfg", {
    user        = var.user
    ssh_keys    = var.ssh_keys
    sshd_config = local.sshd_config
  })
}

resource "digitalocean_droplet" "this" {
  image             = var.image
  name              = var.name
  region            = var.region
  size              = var.size
  monitoring        = true
  ipv6              = false
  vpc_uuid          = var.vpc_id
  user_data         = local.user_data
  volume_ids        = var.volume_ids
  droplet_agent     = false
  graceful_shutdown = true
}

resource "digitalocean_project_resources" "this" {
  project   = var.project_id
  resources = [digitalocean_droplet.this.urn]
}

resource "digitalocean_floating_ip_assignment" "this" {
  ip_address = var.ip_address
  droplet_id = digitalocean_droplet.this.id
}
