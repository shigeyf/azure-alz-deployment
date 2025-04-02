// variables.tf

variable "peering_pairs" {
  type = list(object({
    from = object({
      name                     = string
      vnet_resource_group_name = string
      vnet_id                  = string
      vnet_name                = string
      options = object({
        allow_virtual_network_access = bool
        allow_forwarded_traffic      = bool
        allow_gateway_transit        = bool
        use_remote_gateways          = bool
      })
    }),
    to = object({
      name                     = string
      vnet_resource_group_name = string
      vnet_id                  = string
      vnet_name                = string
      options = object({
        allow_virtual_network_access = bool
        allow_forwarded_traffic      = bool
        allow_gateway_transit        = bool
        use_remote_gateways          = bool
      })
    })
  }))
  description = "List of VNet peering pairs"
  default     = []
}
