// outputs.tf

locals {
  from = tolist([for p in var.peering_pairs : "${p.from.name}-to-${p.to.name}"])
  to   = tolist([for p in var.peering_pairs : "${p.to.name}-to-${p.from.name}"])
}

output "vnet_peerings" {
  value = {
    for i in range(length(local.from)) : i => {
      local.from[i] : azurerm_virtual_network_peering.from_to_peering[local.from[i]].id,
      local.to[i] : azurerm_virtual_network_peering.to_from_peering[local.to[i]].id,
    }
  }
  description = "List of VNet peering pairs"
}
