// variables.tf

variable "keyvault_id" {
  type        = string
  description = "Key Vault Id"
}

variable "key_policy" {
  type = object({
    key_type = string
    key_size = number

    rotation_policy = object({
      automatic = object({
        time_after_creation = string
        time_before_expiry  = string
      })
      expire_after         = string
      notify_before_expiry = string
    })
  })
  description = "Key Vault key policy"
  default = {
    key_type = "RSA"
    key_size = 4096

    rotation_policy = {
      automatic = {
        time_after_creation = null
        time_before_expiry  = "P30D"
      }
      expire_after         = "P90D"
      notify_before_expiry = "P29D"
    }
  }
}

variable "key_name_suffix" {
  type        = string
  description = "Suffix for the Key Vault key name"
}

variable "role_assignments" {
  type = list(object({
    principal_id         = string
    role_definition_name = string
  }))
  description = "Role assignments required to generate this key"
  default     = []
}
