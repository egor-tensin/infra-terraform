data "digitalocean_account" "this" {
}

resource "digitalocean_monitor_alert" "cpu" {
  alerts {
    email = [data.digitalocean_account.this.email]
  }

  description = "CPU utilization on ${digitalocean_droplet.this.name}"
  window      = "5m"
  type        = "v1/insights/droplet/cpu"
  compare     = "GreaterThan"
  value       = var.alert_cpu_threshold
  enabled     = true
  entities    = [digitalocean_droplet.this.id]

  count = var.alert_cpu_enable ? 1 : 0
}

resource "digitalocean_monitor_alert" "loadavg1" {
  alerts {
    email = [data.digitalocean_account.this.email]
  }

  description = "1-min load avg on ${digitalocean_droplet.this.name}"
  window      = "5m"
  type        = "v1/insights/droplet/load_1"
  compare     = "GreaterThan"
  value       = var.alert_loadavg1_threshold
  enabled     = true
  entities    = [digitalocean_droplet.this.id]

  count = var.alert_loadavg1_enable ? 1 : 0
}
