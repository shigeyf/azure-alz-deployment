// variables.vnet.tf

variable "vnet_configs" {
  description = "Virtual Network configurations"
  type = object({
    address_prefix     = string                # Address prefix for the private vnet
    enable_nat_gateway = optional(bool, false) # Enable NAT Gateway
    subnets = map(object({
      name                  = string # Subnet name
      address_prefix        = string # Subnet address prefix
      naming_prefix_enabled = bool   # Whether to add naming prefix ("snet") to the subnet name
      delegation = optional(set(object({
        name = string
        service_delegation = object({
          name    = string
          actions = optional(list(string))
        })
      })))
    }))
  })
}
