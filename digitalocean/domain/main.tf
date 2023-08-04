resource "digitalocean_domain" "this" {
  name = var.name
}

resource "digitalocean_project_resources" "domain" {
  project   = var.project_id
  resources = [digitalocean_domain.this.urn]
}

resource "digitalocean_record" "a" {
  type   = "A"
  domain = digitalocean_domain.this.id
  value  = var.ip_address
  name   = "@"
  ttl    = 3600
}

resource "digitalocean_record" "cname" {
  type   = "CNAME"
  domain = digitalocean_domain.this.id
  value  = "@"
  name   = each.value

  for_each = toset(var.aliases)
}
