variable "zone" {
  type = string
}

variable "name" {
  type = string
}
variable "image" {
  type = string
  # Debian 11
  #default = "fd8fccvfosff76l4g9cu"
  # Debian 12
  default = "fd8k2ecv2i5bmiblro64"
  # Ubuntu 20.04
  #default = "fd8e4du4rapbt83p6c7i"
  # Ubuntu 22.04
  #default = "fd8oik3g61qm14kcklca"
  # Ubuntu 24.04
  #default = "fd8cc75vi959cul95ra1"
  # The full list is at https://cloud.yandex.com/en/marketplace?categories=os
}
variable "subnet_id" {
  type = string
}
variable "ip_address" {
  type = string
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
