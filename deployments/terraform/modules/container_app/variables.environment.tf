// variables.environment.tf

variable "container_app_subnet_id" {
  type        = string
  description = "Container App Subnet Id"
}

variable "workload_profile_name" {
  type        = string
  description = "The name of the workload profile for the Container App Environment"
}

//

variable "container_app_infra_resource_group_name" {
  type        = string
  description = "The name of the resource group where the infrastructure resources are created"
  default     = null
}

variable "log_destination" {
  type        = string
  description = "Log destination for the Container App Environment, can be 'azure-monitor' or 'log-analytics'"
  default     = "azure-monitor"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace Id for the case when log_destination is defined with 'log-analytics'"
  default     = null
}

variable "internal_load_balancer_enabled" {
  type        = bool
  description = "Enable Internal Load Balancer for the Container App Environment"
  default     = true
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "Enable Zone Redundancy for the Container App Environment"
  default     = true
}
