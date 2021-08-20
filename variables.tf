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
