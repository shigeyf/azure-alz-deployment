// variables.tf

variable "naming_conventions" {
  type = object({
    suffix = list(string)
  })
  description = "Naming conventions for this deployment"
}

variable "location" {
  type        = string
  description = "Resource location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Flag to enable public network access"
  default     = false
}

variable "deploy_private_endpoints" {
  type        = bool
  description = "Flag to deploy the private endpoints"
  default     = true
}

variable "virtual_network_id" {
  type        = string
  description = "Virtual network ID for the private endpoint"
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Subnet ID for the private endpoint"
}
