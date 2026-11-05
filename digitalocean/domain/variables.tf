variable "name" {
  type = string
}
variable "ip_address" {
  type = string
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "project_id" {
  type = string
}
