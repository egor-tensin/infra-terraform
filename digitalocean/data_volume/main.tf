resource "digitalocean_volume" "this" {
  region                   = var.region
  name                     = var.name
  size                     = var.size
  initial_filesystem_type  = "ext4"
  initial_filesystem_label = "data"

  lifecycle {
    prevent_destroy = true
  }
}

resource "digitalocean_project_resources" "this" {
  project   = var.project_id
  resources = [digitalocean_volume.this.urn]
}
