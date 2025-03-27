// bastion_nsg_security_rules.tf

locals {
  bastion_subnet_fixed_name = "AzureBastionSubnet"

  // NSG Security Rules for AzureBastionSubnet
  // https://learn.microsoft.com/en-us/azure/bastion/bastion-nsg#nsg
  bastion_nsg_security_rules = [
    {
      name                                       = "AllowHttpsInBound"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = "443"
      destination_port_ranges                    = null
      source_address_prefix                      = "Internet"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "*"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 110
      direction                                  = "Inbound"
    },
    {
      name                                       = "AllowGatewayManager"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = "443"
      destination_port_ranges                    = null
      source_address_prefix                      = "GatewayManager"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "*"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 120
      direction                                  = "Inbound"
    },
    {
      name                                       = "AllowAzureLoadBalancerInbound"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = "443"
      destination_port_ranges                    = null
      source_address_prefix                      = "AzureLoadBalancer"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "*"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 130
      direction                                  = "Inbound"
    },
    {
      name                                       = "AllowBastionHostCommunicationInbound"
      protocol                                   = "*"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = null
      destination_port_ranges                    = ["8080", "5701"]
      source_address_prefix                      = "VirtualNetwork"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 140
      direction                                  = "Inbound"
    },
    {
      name                                       = "AllowSshRdpOutbound"
      protocol                                   = "*"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = null
      destination_port_ranges                    = ["22", "3389"]
      source_address_prefix                      = "*"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 110
      direction                                  = "Outbound"
    },
    {
      name                                       = "AllowAzureCloudOutbound"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = "443"
      destination_port_ranges                    = null
      source_address_prefix                      = "*"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "AzureCloud"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 120
      direction                                  = "Outbound"
    },
    {
      name                                       = "AllowBastionCommunicationOutbound"
      protocol                                   = "*"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = null
      destination_port_ranges                    = ["8080", "5701"]
      source_address_prefix                      = "VirtualNetwork"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 130
      direction                                  = "Outbound"
    },
    {
      name                                       = "AllowHttpOutbound"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      source_port_ranges                         = null
      destination_port_range                     = "80"
      destination_port_ranges                    = null
      source_address_prefix                      = "*"
      source_address_prefixes                    = null
      source_application_security_group_ids      = null
      destination_address_prefix                 = "Internet"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      access                                     = "Allow"
      priority                                   = 140
      direction                                  = "Outbound"
    }
  ]
}
