// variables.vm_secret.tf

variable "vm_secret_keyvault_enabled" {
  type        = bool
  description = "Enable Key Vault for storing VM secrets"
  default     = false
}

variable "vm_secret_keyvault_id" {
  type        = string
  description = "Key Vault Id for storing VM secrets"
  default     = null
}

variable "vm_secret_role_assignment" {
  type = object({
    principal_id                           = string
    name                                   = optional(string)
    role_definition_id                     = optional(string)
    role_definition_name                   = optional(string)
    skip_service_principal_aad_check       = optional(bool)
    delegated_managed_identity_resource_id = optional(string)
    description                            = optional(string)
    condition                              = optional(string)
    condition_version                      = optional(string)
  })
  description = "Role assignment for the current user to access Key Vault"
}
