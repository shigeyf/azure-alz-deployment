// container_app_environment.tf

resource "azurerm_container_app_environment" "this" {
  name                               = local.container_app_environment_name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  tags                               = var.tags
  logs_destination                   = var.log_destination
  log_analytics_workspace_id         = var.log_analytics_workspace_id
  infrastructure_resource_group_name = var.container_app_infra_resource_group_name != null ? var.container_app_infra_resource_group_name : local.container_app_environment_rg_name
  infrastructure_subnet_id           = var.container_app_subnet_id
  internal_load_balancer_enabled     = var.internal_load_balancer_enabled
  zone_redundancy_enabled            = var.zone_redundancy_enabled

  workload_profile {
    name                  = var.workload_profile_name
    workload_profile_type = "Consumption"
    maximum_count         = 0
    minimum_count         = 0
  }
}
