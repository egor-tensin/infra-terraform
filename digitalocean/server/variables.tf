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
variable "image" {
  type = string

  # Note to self: don't use Ubuntu, Canonical people are completely insane with
  # (among other things) their AppArmor craziness.
  default = "debian-13-x64"

  # Get the full list:
  #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/images?type=distribution" | jq .
}

variable "size" {
  type = string

  validation {
    condition     = contains(["small", "normal", "big"], var.size)
    error_message = "Must be one of 'small', 'normal', 'big'"
  }
}

variable "network" {
  type = object({
    vpc_id = string
  })
}

variable "storage" {
  type = list(object({
    disk_id = string
  }))

  default = []
}

variable "config" {
  type = object({
    user     = string
    ssh_keys = list(string)
    ssh_port = optional(string, "22")
  })
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
