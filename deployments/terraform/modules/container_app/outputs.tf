// outputs.tf

output "container_app_environment_id" {
  value = azurerm_container_app_environment.this.id
}

output "container_app_manual_job_ids" {
  value = [for job in azurerm_container_app_job.manual : job.id]
}

output "container_app_event_job_ids" {
  value = [for job in azurerm_container_app_job.event : job.id]
}
