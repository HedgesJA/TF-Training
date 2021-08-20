#Create Network adapter
resource "azurerm_network_interface" "vm_network_interface" {
  name                = var.vm_network_interface
  location            = azurerm_resource_group.vm_group.location
  resource_group_name = azurerm_resource_group.vm_group.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Create Virtual Machine
resource "azurerm_windows_virtual_machine" "virtual_machine" {
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.vm_group.name
  location              = azurerm_resource_group.vm_group.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  license_type          = "Windows_Server"
  network_interface_ids = [azurerm_network_interface.vm_network_interface.id]

  os_disk {
    caching              = "ReadOnly"
    storage_account_type = var.vm_disk_type
    disk_size_gb         = var.vm_disk_size
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.vm_sku
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  tags = {
    environment = var.vm_environment
  }

}
