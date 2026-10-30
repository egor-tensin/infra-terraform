variable "zone" {
  type = string

  # The full list is at https://yandex.cloud/ru/docs/overview/concepts/geo-scope
}

variable "name" {
  type = string
}
variable "size" {
  type    = number
  default = 10
}
