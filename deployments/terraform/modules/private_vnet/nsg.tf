// nsg.tf

resource "azurerm_network_security_group" "nsg" {
  for_each = var.vnet_configs.subnets

  name                = each.value.naming_prefix_enabled ? "${module.naming.network_security_group.name_unique_with_pad}-${local.subnet_naming_prefix}-${each.value.name}" : "${module.naming.network_security_group.name_unique_with_pad}-${each.value.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  // NSG Security Rules for AzureBastionSubnet
  dynamic "security_rule" {
    for_each = { for i in local.bastion_nsg_security_rules : i.name => i if each.value.name == local.bastion_subnet_fixed_name }
    content {
      name                                       = security_rule.value.name
      protocol                                   = security_rule.value.protocol
      source_port_range                          = security_rule.value.source_port_range
      source_port_ranges                         = security_rule.value.source_port_ranges
      destination_port_range                     = security_rule.value.destination_port_range
      destination_port_ranges                    = security_rule.value.destination_port_ranges
      source_address_prefix                      = security_rule.value.source_address_prefix
      source_address_prefixes                    = security_rule.value.source_address_prefixes
      source_application_security_group_ids      = security_rule.value.source_application_security_group_ids
      destination_address_prefix                 = security_rule.value.destination_address_prefix
      destination_address_prefixes               = security_rule.value.destination_address_prefixes
      destination_application_security_group_ids = security_rule.value.destination_application_security_group_ids
      access                                     = security_rule.value.access
      priority                                   = security_rule.value.priority
      direction                                  = security_rule.value.direction
    }
  }
}
