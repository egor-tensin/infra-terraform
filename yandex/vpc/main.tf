resource "yandex_vpc_network" "this" {
  name = "${var.prefix}-vpc"
}

resource "yandex_vpc_subnet" "this" {
  zone = var.zone

  network_id = yandex_vpc_network.this.id

  name = "${var.prefix}-subnet"

  # The mask was chosen randomly:
  v4_cidr_blocks = ["10.0.0.0/22"]
}
