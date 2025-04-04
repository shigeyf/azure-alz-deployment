// vm_linux_extention.tf

resource "azurerm_virtual_machine_extension" "this" {
  name               = azurerm_linux_virtual_machine.this[0].computer_name
  virtual_machine_id = azurerm_linux_virtual_machine.this[0].id
  tags               = var.tags

  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
{
  "script": "${local.install_script}"
}
SETTINGS

  depends_on = [
    azurerm_linux_virtual_machine.this,
  ]
}
