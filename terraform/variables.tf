variable "resource_group" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "dev-resource-group"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
  default     = "dev-vm"
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B1s"
}


