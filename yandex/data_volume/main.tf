resource "yandex_compute_disk" "this" {
  zone = var.zone
  name = var.name
  size = var.size
  type = "network-ssd"

  lifecycle {
    prevent_destroy = true
  }
}
