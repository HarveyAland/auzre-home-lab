variable "location" {
  description = "Azure region"
  default     = "UK South"
}

variable "rg" {
  description = "The resource group name"
  default     = "labrg"
}

variable "hmip" {
  description = "Your home IP in CIDR format"
  default     = "84.18.227.54/32"
}

variable "admin_username" {
  description = "VM admin username"
  type        = string
}

variable "admin_password" {
  description = "VM admin password"
  type        = string
  sensitive   = true
}
