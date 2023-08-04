variable "region" {
  type = string
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
  default = "debian-12-x64"
}
variable "size" {
  type    = string
  default = "s-1vcpu-2gb"
}
