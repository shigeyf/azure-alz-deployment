// variables.tf

variable "naming_conventions" {
  type = object({
    suffix = list(string)
  })
  description = "Naming conventions for this deployment"
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

variable "virtual_machine" {
  description = "Virtual machine configurations"
  type = object({
    vm_admin_user          = string
    vm_admin_ssh_key       = string
    vm_bastion_sku         = string
    vm_hibernation_enabled = bool
    vm_os_windows          = bool
    vm_os_disk_size        = number
    vm_os_disk_type        = string
    vm_password_kv_id      = string
    vm_size                = string
    vm_subnet_id           = string
    bastion_subnet_id      = string
  })
}
