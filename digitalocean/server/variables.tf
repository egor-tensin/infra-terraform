variable "region" {
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
variable "vpc_id" {
  type = string
}
variable "ip_address" {
  type = string
}
variable "volume_ids" {
  type    = list(string)
  default = []
}

variable "user" {
  type = string
}
variable "ssh_keys" {
  type = list(string)
}
variable "ssh_port" {
  type    = string
  default = "22"
}

variable "image" {
  type    = string
  default = "debian-13-x64"
  # Get the full list:
  #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/images?type=distribution" | jq .
}
variable "size" {
  type    = string
  default = "s-1vcpu-2gb"
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
