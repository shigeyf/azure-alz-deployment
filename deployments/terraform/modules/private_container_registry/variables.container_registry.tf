// variables.container_registry.tf

variable "images" {
  type = map(object({
    task_name            = string
    dockerfile_path      = string
    context_path         = string
    context_access_token = optional(string, "a") # This `a` is a dummy value because the context_access_token should not be required in the provider
    image_names          = list(string)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of objects that define the images to build in the container registry. The key of the map is the name of the image and the value is an object with the following attributes:

- `task_name` - The name of the task to create for building the image (e.g. `image-build-task`)
- `dockerfile_path` - The path to the Dockerfile to use for building the image (e.g. `dockerfile`)
- `context_path` - The path to the context of the Dockerfile in three sections `<repository-url>#<repository-commit>:<repository-folder-path>` (e.g. https://github.com/Azure/terraform-azurerm-avm-ptn-cicd-agents-and-runners#8ff4b85:container-images/azure-devops-agent)
- `context_access_token` - The access token to use for accessing the context. Supply a PAT if targetting a private repository.
- `image_names` - A list of the names of the images to build (e.g. `["image-name:tag"]`)
DESCRIPTION
}

variable "container_compute_managed_identity_principal_id" {
  type        = string
  description = "The principal id of the managed identity used by the container compute to pull images from the container registry"
}
