variable "prefix" {
  type = string
}
variable "zone" {
  type = string
  # Get the full list:
  #     curl -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/regions" | jq .
}
