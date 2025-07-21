resource "azurerm_windows_virtual_machine" "hmlabvm" {
  name                = "homelab-vm"
  computer_name       = "homelab-vm"
  resource_group_name = var.rg
  location            = var.location
  size                = "Standard_B2ms"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    var.nicid,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-smalldisk"
    version   = "20348.3695.250523"
  }

  tags = {
    environment = "lab"
  }
}