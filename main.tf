terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.29.0"
    }
  }

  required_version = "1.0.4"
}

provider "azurerm" {
  features {}
}

#Create Resource Group
resource "azurerm_resource_group" "vm_group" {
  name     = var.resource_group
  location = var.resource_location
}

#Create Virtual Network
resource "azurerm_virtual_network" "vm_network" {
  name                = var.network_name
  address_space       = [var.network_address]
  resource_group_name = azurerm_resource_group.vm_group.name
  location            = azurerm_resource_group.vm_group.location
}

#Create network subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vm_group.name
  virtual_network_name = azurerm_virtual_network.vm_network.name
  address_prefixes     = [var.subnet_address]
}

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

variable "resource_group" {
  description = "Name of the resource group"
  type        = string
  default     = "VirtualMachineGroup"
}

variable "resource_location" {
  description = "Location of resources"
  type        = string
  default     = "UK South"
}

variable "network_name" {
  description = "Name of Network"
  type        = string
  default     = "VirtualMachineNetwork"
}

variable "subnet_name" {
  description = "Name of Subnet"
  type        = string
  default     = "VirtualMachineSubnet"
}

variable "vm_name" {
  description = "Name of VM"
  type        = string
  default     = "VM"
}

variable "vm_size" {
  description = "Size of VM"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_disk_size" {
  description = "Size of VM Disk"
  type        = string
  default     = "32"
}

variable "vm_disk_type" {
  description = "Type of disk"
  type        = string
  default     = "Standard_LRS"
}

variable "vm_sku" {
  description = "VM SKU"
  type        = string
  default     = "2019-Datacenter-smalldisk"
}

variable "admin_username" {
  description = "Desired Admin Username"
  type        = string
  default     = "James"
}

variable "admin_password" {
  description = "Desired admin password"
  type        = string
  default     = "sdfhq48SDFdf224sf"
  sensitive   = true
}

variable "vm_environment" {
  description = "VM Environment"
  type        = string
  default     = "Production"
}

variable "network_address" {
  description = "Network Address space"
  type        = string
  default     = "10.0.0.0/22"
}

variable "subnet_address" {
  description = "Subnet Prefix"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vm_network_interface" {
  description = "name of VM  network interface"
  type        = string
  default     = "Production"
}
