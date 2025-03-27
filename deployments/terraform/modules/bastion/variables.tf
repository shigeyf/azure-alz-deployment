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

variable "bastion_configs" {
  description = "Bastion Host configurations"
  type = object({
    sku         = string
    scale_units = number
    subnet_id   = string
  })
}
