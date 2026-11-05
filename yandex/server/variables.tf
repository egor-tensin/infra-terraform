variable "zone" {
  type = string

  # The full list is at https://yandex.cloud/ru/docs/overview/concepts/geo-scope
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

variable "size" {
  type = string

  validation {
    condition     = contains(["small", "normal", "big"], var.size)
    error_message = "Must be one of 'small', 'normal', 'big'"
  }
}

variable "network" {
  type = object({
    vpc_id     = string
    ip_address = string
  })
}

variable "storage" {
  type = list(object({
    disk_id   = string
    disk_name = optional(string)
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
