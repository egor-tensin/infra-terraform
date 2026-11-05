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
  image  = var.image
  name   = var.name
  region = var.zone
  size   = var.size

  ipv6     = false
  vpc_uuid = var.networking.vpc_id

  user_data = local.user_data

  monitoring        = true
  droplet_agent     = false
  graceful_shutdown = true

  volume_ids = [for disk in var.attached_disks : disk.id]

  timeouts {
    create = "3m"
    update = "5m"
    delete = "3m"
  }
}

resource "digitalocean_project_resources" "this" {
  project   = var.project_id
  resources = [digitalocean_droplet.this.urn]
}
