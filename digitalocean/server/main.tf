locals {
  sizes = {
    # Get the full list:
    #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/sizes" | jq .
    small = {
      impl = "s-1vcpu-2gb-intel"
    }
    normal = {
      impl = "s-1vcpu-2gb-intel"
    }
    big = {
      impl = "s-2vcpu-4gb-intel"
    }
  }

  sshd_config = templatefile("${path.module}/../../etc/sshd_config", {
    port  = var.config.ssh_port
    users = [var.config.user]
  })
  user_data = templatefile("${path.module}/../../etc/cloud-init.yml", {
    user        = var.config.user
    ssh_keys    = var.config.ssh_keys
    sshd_config = local.sshd_config
  })
}

resource "digitalocean_droplet" "this" {
  region = var.zone
  name   = var.name
  image  = var.image
  size   = local.sizes[var.size].impl

  ipv6     = false
  vpc_uuid = var.network.vpc_id

  user_data = local.user_data

  monitoring        = true
  droplet_agent     = false
  graceful_shutdown = true

  volume_ids = [for disk in var.storage : disk.disk_id]

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
