// variables.tf

variable "naming_suffix" {
  type        = list(string)
  description = "Naming suffix for this module"
}

variable "location" {
  type        = string
  description = "Resource location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "ssh_private_key_filepath" {
  type        = string
  description = "Path to the SSH private key file"
}

variable "vm_configs" {
  description = "Virtual machine configurations"
  type = object({
    admin_username = string
    nic_subnet_id  = string
    os_type        = string # Valid values: "linux" or "windows"
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
      password_enabled    = bool # Valid only for Linux VMs
      ssh_key_enabled     = bool # Valid only for Linux VMs
    })
  })
}

variable "vm_secret_keyvault_id" {
  type        = string
  description = "Key Vault Id for storing VM secrets"
  default     = null
}
