variable "region" {
  type = string
  # Get the full list:
  #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/regions" | jq .
}
variable "project_id" {
  type = string
}

variable "name" {
  type = string
}
variable "size" {
  type    = number
  default = 10
}
