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
  value       = 70
  enabled     = true
  entities    = [digitalocean_droplet.this.id]
}

resource "digitalocean_monitor_alert" "load1" {
  alerts {
    email = [data.digitalocean_account.this.email]
  }
  description = "1-min load avg on ${digitalocean_droplet.this.name}"
  window      = "5m"
  type        = "v1/insights/droplet/load_1"
  compare     = "GreaterThan"
  value       = 5
  enabled     = true
  entities    = [digitalocean_droplet.this.id]
}
