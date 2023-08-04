variable "name" {
  type = string
}
variable "open_ports" {
  type    = list(string)
  default = ["22"]
}
variable "droplet_ids" {
  type = list(string)
}
