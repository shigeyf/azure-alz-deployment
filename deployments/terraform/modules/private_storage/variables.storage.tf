// variables.storage.tf

variable "containers" {
  type = list(object({
    name                  = string
    container_access_type = string
  }))
  description = "List of containers to be created"
  default     = []
}

variable "lock_enabled" {
  type        = bool
  description = "Enable resource lock"
  default     = false
}
