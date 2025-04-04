// variables.role.tf

variable "role_assignments" {
  type = list(object({
    principal_id         = string
    role_definition_name = string
  }))
  description = "Role assignments for the Storage account"
  default     = []
}
