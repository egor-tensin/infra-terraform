locals {
  sizes = {
    small = {
      cores         = 2
      core_fraction = 50
      memory        = 2
      disk_size     = 10
    }
    normal = {
      cores         = 2
      core_fraction = 100
      memory        = 2
      disk_size     = 20
    }
    big = {
      cores         = 2
      core_fraction = 100
      memory        = 4
      disk_size     = 20
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

resource "yandex_compute_instance" "this" {
  zone        = var.zone
  platform_id = "standard-v2"
  # ^^^ The least common denominator.

  # The full list is at https://yandex.cloud/ru/docs/compute/concepts/vm-platforms
  # Please notice that some platforms are unavailable in certain zones.

  name     = var.name
  hostname = var.name

  resources {
    cores         = local.sizes[var.size].cores
    core_fraction = local.sizes[var.size].core_fraction
    memory        = local.sizes[var.size].memory
  }

  boot_disk {
    initialize_params {
      size     = local.sizes[var.size].disk_size
      image_id = var.image

      # As of Nov '26, HDDs seem to be the default, and it's not 90's anymore.
      #type = "network-ssd"
      # Actually, scratch that thing above, it seems like it's still the 90s.
      # When actually tried (the same Nov '26), it said something stupid like
      #
      #     The limit on total size of network-ssd disks has exceeded for zone "ru-central1-d"
      #
    }
  }

  network_interface {
    subnet_id      = var.network.vpc_id
    nat            = true
    nat_ip_address = var.network.ip_address
  }

  metadata = {
    user-data = local.user_data
  }

  allow_stopping_for_update = true

  dynamic "secondary_disk" {
    for_each = var.storage

    content {
      disk_id     = secondary_disk.value.disk_id
      device_name = secondary_disk.value.disk_name
      auto_delete = false
    }
  }

  timeouts {
    create = "3m"
    update = "5m"
    delete = "3m"
  }
}
