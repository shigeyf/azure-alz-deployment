// variables.tf

// Basic parameters: naming suffix, location, and tags

variable "naming_suffix" {
  type        = list(string)
  description = "Naming suffix for bootstrap resources"
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

// Subnet index names
variable "vnet_vm_subnet_index" {
  type        = string
  description = "Subnet index name for VM"
}

variable "vnet_bastion_subnet_index" {
  type        = string
  description = "Subnet index name for Bastion"
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

// Virtual Machine configurations
variable "vm_configs" {
  description = "Virtual machine configurations"
  type = object({
    admin_username = string
    os_type        = string
    os_disk_size   = number
    os_disk_type   = string
    size           = string

    os_source_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    options = object({
      hibernation_enabled = bool
      password_enabled    = bool
      ssh_key_enabled     = bool
    })
  })
}

// Virtual Machine Login SSH Key
variable "ssh_private_key_filepath" {
  type        = string
  description = "Path to the SSH private key file"
}

// Bastion Host configurations
variable "bastion_configs" {
  description = "Bastion Host configurations"
  type = object({
    sku         = string
    scale_units = number
  })
}
