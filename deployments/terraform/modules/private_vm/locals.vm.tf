// locals.vm.tf

locals {
  // Fixed values
  vm_os_type_linux   = "linux"
  vm_os_type_windows = "windows"
  vm_password_length = 20

  // Resource names
  vm_name          = module.naming.virtual_machine.short_name_unique
  vm_nic_name      = join("-", [module.naming.network_interface.name_with_pad, local.vm_name])
  vm_password_name = join("-", ["password", local.vm_name])
  vm_ssh_key_name  = join("-", ["ssh-key", local.vm_name])
}
