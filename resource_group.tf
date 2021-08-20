#Create Resource Group
resource "azurerm_resource_group" "vm_group" {
  name     = var.resource_group
  location = var.resource_location
}
