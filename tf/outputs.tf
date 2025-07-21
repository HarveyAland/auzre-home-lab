output "vm_public_ip" {
  description = "The public IP address of the VM"
  value       = module.networking.public_ip_address
}