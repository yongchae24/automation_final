
output "vm_hostnames" {
  description = "The hostnames of the VMs"
  value       = { for k, v in var.vm_names : "${var.humber_id}-${k}" => v }
}

output "vm_domain_names" {
  description = "The domain names of the VMs"
  value       = { for k, v in azurerm_public_ip.public_ip : k => v.domain_name_label }
}

output "vm_fqdns" {
  description = "The FQDNs of the Linux VMs"
  value       = { for k, v in azurerm_public_ip.public_ip : k => "${v.domain_name_label}.${v.location}.cloudapp.azure.com" }
}

output "vm_private_ips" {
  description = "The private IP addresses of the VMs"
  value       = { for k, v in azurerm_network_interface.nic : k => v.private_ip_address }
}

output "vm_public_ips" {
  description = "The public IP addresses of the VMs"
  value       = { for k, v in azurerm_public_ip.public_ip : k => v.ip_address }
}

output "vm_ids" {
  description = "The IDs of the Linux VMs"
  value       = { for k, v in azurerm_virtual_machine.vm : k => v.id }
}

output "vm_names" {
  description = "The names of the Linux VMs"
  value       = { for k, v in var.vm_names : k => v }
}

output "vm_nic_ids" {
  description = "The NIC IDs of the Linux VMs"
  value       = [for nic in azurerm_network_interface.nic : nic.id]
}

