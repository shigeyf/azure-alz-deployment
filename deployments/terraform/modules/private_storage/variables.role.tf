// variables.role.tf

variable "keyvault_id" {
  type        = string
  description = "Key Vault Id"
}

variable "role_assignments" {
  type = list(object({
    principal_id         = string
    role_definition_name = string
  }))
  description = "Role assignments for the Storage account"
  default     = []
}
