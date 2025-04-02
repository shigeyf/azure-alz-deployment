// peering.tf

resource "azurerm_virtual_network_peering" "from_to_peering" {
  for_each                  = { for index, p in var.peering_pairs : "${p.from.name}-to-${p.to.name}" => p }
  name                      = each.key
  resource_group_name       = each.value.from.vnet_resource_group_name
  virtual_network_name      = each.value.from.vnet_name
  remote_virtual_network_id = each.value.to.vnet_id

  allow_virtual_network_access = each.value.from.options.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.from.options.allow_forwarded_traffic
  allow_gateway_transit        = each.value.from.options.allow_gateway_transit
  use_remote_gateways          = each.value.from.options.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "to_from_peering" {
  for_each                  = { for index, p in var.peering_pairs : "${p.to.name}-to-${p.from.name}" => p }
  name                      = each.key
  resource_group_name       = each.value.to.vnet_resource_group_name
  virtual_network_name      = each.value.to.vnet_name
  remote_virtual_network_id = each.value.from.vnet_id

  allow_virtual_network_access = each.value.to.options.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.to.options.allow_forwarded_traffic
  allow_gateway_transit        = each.value.to.options.allow_gateway_transit
  use_remote_gateways          = each.value.to.options.use_remote_gateways
}
