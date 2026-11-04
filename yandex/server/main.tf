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

resource "yandex_compute_instance" "this" {
  zone        = var.zone
  platform_id = var.platform

  name     = var.name
  hostname = var.name

  resources {
    cores         = var.cores
    core_fraction = var.core_fraction
    memory        = var.memory
  }

  boot_disk {
    initialize_params {
      size     = var.disk_size
      image_id = var.image

      # As of Nov '26, HDDs seem to be the default, and it's not 90's anymore.
      type = "network-ssd"
    }
  }

  network_interface {
    subnet_id      = var.subnet_id
    nat            = true
    nat_ip_address = var.ip_address
  }

  metadata = {
    user-data = local.user_data
  }

  allow_stopping_for_update = true

  dynamic "secondary_disk" {
    for_each = var.attached_disks

    content {
      disk_id     = secondary_disk.value.id
      device_name = secondary_disk.value.name
      auto_delete = false
    }
  }

  timeouts {
    create = "3m"
    update = "5m"
    delete = "3m"
  }
}
