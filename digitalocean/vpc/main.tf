resource "digitalocean_vpc" "this" {
  region = var.zone

  name = "${var.prefix}-vpc"
}
