infra-terraform
===============

Some common Terraform modules used by me to manage things.

Usage
-----

An example for the digitalocean/domain module:

```
module "domain" {
  source = "github.com/egor-tensin/infra-terraform//digitalocean/domain?ref=v1.0.0"

  name       = "example.com"
  ip_address = digitalocean_floating_ip.server.ip_address
  project_id = digitalocean_project.this.id

  aliases = ["sub1", "sub2"]
}
```

License
-------

Distributed under the MIT License.
See [LICENSE.txt] for details.

[LICENSE.txt]: LICENSE.txt
