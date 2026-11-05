variable "zone" {
  type = string

  # The full list is at https://yandex.cloud/ru/docs/overview/concepts/geo-scope
}
variable "platform" {
  type    = string
  default = "standard-v2"
  # ^^^ The least common denominator.

  # The full list is at https://yandex.cloud/ru/docs/compute/concepts/vm-platforms
  # Please notice that some platforms are unavailable in certain zones.
}

variable "name" {
  type = string
}
variable "image" {
  type = string

  # Ubuntu 26.04
  default = "fd8mce1h218lk70kbfk3"

  # The full list is at https://cloud.yandex.com/en/marketplace?categories=os
  # The image IDs seem to change over time for some reason, and they don't seem
  # to have image names or whatever.
}

variable "networking" {
  type = object({
    vpc_id     = string
    ip_address = string
  })
}

variable "config" {
  type = object({
    user     = string
    ssh_keys = list(string)
    ssh_port = optional(string, "22")
  })
}

variable "cores" {
  type    = number
  default = 2
}
variable "core_fraction" {
  type    = number
  default = 100
}
variable "memory" {
  type    = number
  default = 2
}
variable "disk_size" {
  type    = number
  default = 10
}

variable "attached_disks" {
  type = list(object({
    id   = string
    name = optional(string)
  }))

  default = []
}
