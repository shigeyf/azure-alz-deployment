// variables.tf

variable "naming_suffix" {
  description = "Suffix to be used for resource naming"
  type        = list(string)
  default     = []
}

variable "location" {
  type        = string
  description = "Resource location for this module"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags for this module"
  default     = {}
}

variable "use_existing_rg" {
  description = "Flag to determine if an existing resource group should be used"
  type        = bool
  default     = false
}

variable "existing_rg_name" {
  description = "Name of the existing resource group to use."
  type        = string
  default     = ""
}

variable "deploy_network" {
  description = "Flag to deploy the network resources"
  type        = bool
  default     = true
}

variable "network" {
  description = "Network configurations"
  type = object({
    vnet_address_prefix             = string
    private_endpoints_subnet_prefix = string
    bastion_subnet_prefix           = string
    jumpbox_subnet_prefix           = string
  })
  default = {
    vnet_address_prefix             = "10.0.0.0/16"
    private_endpoints_subnet_prefix = "10.0.2.0/28"
    bastion_subnet_prefix           = "10.0.2.64/26" // Bastion subnet must have /26 range
    jumpbox_subnet_prefix           = "10.0.2.128/28"
  }
}

variable "deploy_private_endpoints" {
  description = "Flag to deploy the private endpoints"
  type        = bool
  default     = true
}

variable "virtual_machine" {
  description = "Virtual machine configurations"
  type = object({
    vm_admin_user          = string
    vm_admin_ssh_key_file  = string
    vm_bastion_sku         = string
    vm_hibernation_enabled = bool
    vm_os_windows          = bool
    vm_os_disk_size        = number
    vm_os_disk_type        = string
    vm_size                = string
  })
}
