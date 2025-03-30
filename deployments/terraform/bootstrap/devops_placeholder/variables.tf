// variables.tf

variable "naming_suffix" {
  type        = list(string)
  description = "Naming suffix for this module"
}

variable "location" {
  type        = string
  description = "Resource location"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

// Subnet Index names
variable "vnet_private_endpoints_subnet_index" {
  type        = string
  description = "Subnet index name for VM"
}

// Virtual Network configurations
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

// Service Principal Object Id
variable "terraform_service_principal_object_id" {
  type        = string
  description = "Service Principal Object Id for Terraform deployment"
}
