// variables.managed_id.tf

variable "container_compute_managed_identity_id" {
  type        = string
  description = "The principal id of the managed identity used by the container compute to pull images from the container registry"
}
