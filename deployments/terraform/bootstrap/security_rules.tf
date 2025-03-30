//

# security_rule {
#   name                       = "AllowSshRdpInbound"
#   protocol                   = "Tcp"
#   source_port_range          = "*"
#   source_address_prefix      = var.network.bastion_subnet_prefix
#   destination_port_ranges    = ["22", "3389"]
#   destination_address_prefix = var.network.bootstrap_vm_subnet_prefix
#   access                     = "Allow"
#   priority                   = 110
#   direction                  = "Inbound"
# }

# security_rule {
#   name                       = "AllowInternetOutbound"
#   protocol                   = "*"
#   source_port_range          = "*"
#   destination_port_range     = "*"
#   source_address_prefix      = var.network.bootstrap_vm_subnet_prefix
#   destination_address_prefix = "Internet"
#   access                     = "Allow"
#   priority                   = 110
#   direction                  = "Outbound"
# }

# security_rule {
#   name                       = "DenyAllOutBound"
#   protocol                   = "*"
#   source_port_range          = "*"
#   destination_port_range     = "*"
#   source_address_prefix      = var.network.bootstrap_vm_subnet_prefix
#   destination_address_prefix = "*"
#   access                     = "Deny"
#   priority                   = 1000
#   direction                  = "Outbound"
# }
