// variables.net.tf

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Private Endpoint Subnet Id for Storage account"
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "List of Private DNS Zone Id for Storage account"
}
