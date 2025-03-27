// variables.tf

variable "naming_suffix" {
  type        = list(string)
  description = "Naming suffix for this module"
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

variable "vnet_configs" {
  description = "Virtual Network configurations"
  type = object({
    address_prefix = string # Address prefix for the private vnet
    subnets = map(object({
      name                  = string # Subnet name
      address_prefix        = string # Subnet address prefix
      naming_prefix_enabled = bool
    }))
  })
}
