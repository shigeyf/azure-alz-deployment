// nsg.tf

// https://learn.microsoft.com/en-us/azure/bastion/bastion-nsg#nsg
resource "azurerm_network_security_group" "bastion_nsg" {
  count               = var.deploy_network ? 1 : 0
  name                = local.bastion_subnet_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "AllowHttpsInBound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 110
    direction                  = "Inbound"
  }

  security_rule {
    name                       = "AllowGatewayManager"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 120
    direction                  = "Inbound"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 130
    direction                  = "Inbound"
  }

  security_rule {
    name                       = "AllowBastionHostCommunicationInbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["8080", "5701"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    access                     = "Allow"
    priority                   = 140
    direction                  = "Inbound"
  }

  security_rule {
    name                       = "AllowSshRdpOutbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
    access                     = "Allow"
    priority                   = 110
    direction                  = "Outbound"
  }

  security_rule {
    name                       = "AllowAzureCloudOutbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
    access                     = "Allow"
    priority                   = 120
    direction                  = "Outbound"
  }

  security_rule {
    name                       = "AllowBastionCommunicationOutbound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["8080", "5701"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    access                     = "Allow"
    priority                   = 130
    direction                  = "Outbound"
  }

  security_rule {
    name                       = "AllowHttpOutbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
    access                     = "Allow"
    priority                   = 140
    direction                  = "Outbound"
  }
}

resource "azurerm_network_security_group" "jumpbox_nsg" {
  count               = var.deploy_network ? 1 : 0
  name                = local.jumpbox_subnet_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "Jumpbox.In.Allow.SshRdp"
    description                = "Allow inbound RDP and SSH from the Bastion Host subnet"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = var.network.bastion_subnet_prefix
    destination_port_ranges    = ["22", "3389"]
    destination_address_prefix = var.network.jumpbox_subnet_prefix
    access                     = "Allow"
    priority                   = 110
    direction                  = "Inbound"
  }

  security_rule {
    name                       = "Jumpbox.Out.Allow.PrivateEndpoints"
    description                = "Allow outbound traffic from the jumpbox subnet to the Private Endpoints subnet"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.network.jumpbox_subnet_prefix
    destination_address_prefix = var.network.private_endpoints_subnet_prefix
    access                     = "Allow"
    priority                   = 120
    direction                  = "Outbound"
  }

  security_rule {
    name                       = "Jumpbox.Out.Allow.Internet"
    description                = "Allow outbound traffic from all VMs to Internet"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.network.jumpbox_subnet_prefix
    destination_address_prefix = "Internet"
    access                     = "Allow"
    priority                   = 130
    direction                  = "Outbound"
  }

  security_rule {
    name                       = "DenyAllOutBound"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.network.jumpbox_subnet_prefix
    destination_address_prefix = "*"
    access                     = "Deny"
    priority                   = 1000
    direction                  = "Outbound"
  }
}

resource "azurerm_network_security_group" "private_endpoints_nsg" {
  count               = var.deploy_network ? 1 : 0
  name                = local.public_endpoints_subnet_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
