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

variable "deploy_private_endpoints" {
  type        = bool
  description = "Flag to deploy the private endpoints"
  default     = true
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Subnet ID for the private endpoint"
}
