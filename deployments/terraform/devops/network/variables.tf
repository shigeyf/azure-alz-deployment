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

variable "deploy_network" {
  type        = bool
  description = "Flag to deploy the network resources"
  default     = true
}

variable "network" {
  description = "Network configurations"
  type = object({
    vnet_address_prefix             = string
    private_endpoints_subnet_prefix = string
    bastion_subnet_prefix           = string
    jumpbox_subnet_prefix           = string
  })
}
