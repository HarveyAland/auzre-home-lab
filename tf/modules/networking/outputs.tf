output "public_ip_address" {
  description = "The public IP of the VM"
  value       = azurerm_public_ip.pip.ip_address
}

output "nic_id" {
  description = "The network interface ID for the VM"
  value       = azurerm_network_interface.nic.id
}

output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.homelabrg.name
}