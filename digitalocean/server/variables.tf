variable "zone" {
  type = string

  # Get the full list, along with available droplet sizes:
  #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/regions" | jq .
}
variable "project_id" {
  type = string
}

variable "name" {
  type = string
}

variable "networking" {
  type = object({
    vpc_id = string
  })
}

variable "config" {
  type = object({
    user     = string
    ssh_keys = list(string)
    ssh_port = optional(string, "22")
  })
}

variable "attached_disks" {
  type = list(object({
    id = string
  }))

  default = []
}

variable "image" {
  type = string

  #default = "debian-12-x64"
  #default = "debian-13-x64"
  #default = "ubuntu-22-04-x64"
  #default = "ubuntu-24-04-x64"
  default = "ubuntu-26-04-x64"

  # Get the full list:
  #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/images?type=distribution" | jq .
}
variable "size" {
  type = string

  default = "s-1vcpu-2gb-intel"

  # Get the full list:
  #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/sizes" | jq .
}

variable "alert_cpu_enable" {
  type    = bool
  default = true
}
variable "alert_cpu_threshold" {
  type    = number
  default = 80
}
variable "alert_loadavg1_enable" {
  type    = bool
  default = true
}
variable "alert_loadavg1_threshold" {
  type    = number
  default = 5
}
