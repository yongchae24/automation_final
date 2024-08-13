
output "_01_resource_group_name" {
  description = "The name of the resource group created by the child module"
  value       = module.rgroup-n01649144.resource_group_name
}

output "_02_virtual_network_name" {
  description = "The name of the virtual network created by the child module"
  value       = module.network-n01649144.virtual_network_name
}

output "_03_subnet_name" {
  description = "The name of the subnet created by the child module"
  value       = module.network-n01649144.subnet_name
}

output "_07_linux_vm_hostnames" {
  description = "The hostnames of the VMs created by the vmlinux module"
  value       = module.vmlinux-n01649144.vm_hostnames
}

output "_08_linux_vm_domain_names" {
  description = "The domain names of the VMs created by the vmlinux module"
  value       = module.vmlinux-n01649144.vm_domain_names
}

output "_09_linux_vm_fqdns" {
  description = "The FQDNs of the Linux VMs"
  value       = module.vmlinux-n01649144.vm_fqdns
}

output "_10_linux_vm_private_ips" {
  description = "The private IP addresses of the VMs created by the vmlinux module"
  value       = module.vmlinux-n01649144.vm_private_ips
}

output "_11_linux_vm_public_ips" {
  description = "The public IP addresses of the VMs created by the vmlinux module"
  value       = module.vmlinux-n01649144.vm_public_ips
}

