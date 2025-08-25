output "vm_details" {
  description = "Details of all created VMs"
  value = {
    for vm_key, vm in proxmox_virtual_environment_vm.homelab_vms : vm_key => {
      name       = vm.name
      vmid       = vm.vm_id
      ip_address = var.vm_config[vm_key].ip_address
      node       = vm.node_name
      status     = "created_from_iso"
      iso        = var.vm_iso
    }
  }
}

output "vm_ip_addresses" {
  description = "Planned IP addresses for VMs (manual configuration required)"
  value = {
    for vm_key, vm_config in var.vm_config : vm_config.name => vm_config.ip_address
  }
}


output "storage_configuration" {
  description = "Storage configuration summary"
  value = {
    vm_disk_storage = var.vm_disk_storage
    iso_storage     = var.vm_iso_storage
    iso_file        = var.vm_iso
  }
}

output "network_configuration" {
  description = "Network configuration summary"
  value = {
    bridge      = var.network_bridge
    gateway     = var.network_gateway
    dns_servers = var.dns_servers
    vlan_tag    = var.network_tag
  }
}
