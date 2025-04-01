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

variable "lock_enabled" {
  type        = bool
  description = "Enable resource lock"
  default     = false
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Private Endpoint Subnet Id for Storage account"
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "List of Private DNS Zone Id for Storage account"
}

variable "role_assignments" {
  type = list(object({
    principal_id         = string
    role_definition_name = string
  }))
  description = "Role assignments for the Storage account"
  default     = []
}
