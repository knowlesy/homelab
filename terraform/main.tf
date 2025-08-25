resource "proxmox_virtual_environment_vm" "homelab_vms" {
  for_each = var.vm_config

  # VM Basic Configuration
  name        = each.value.name
  vm_id       = each.value.vmid
  node_name   = var.proxmox_node
  description = each.value.description

  # VM Resources
  cpu {
    cores = each.value.cores
    type  = "host"
  }

  memory {
    dedicated = each.value.memory
  }

  # VM Settings
  started = true
  agent {
    enabled = true
  }

  # Main disk configuration
  disk {
    datastore_id = var.vm_disk_storage
    file_id      = null  # Create empty disk
    interface    = "virtio0"
    size         = tonumber(replace(each.value.disk_size, "G", ""))
    iothread     = true
    ssd          = true
  }

  # CD-ROM for ISO
  cdrom {
    enabled   = false
    file_id   = var.vm_iso
    interface = "ide2"
  }

  # Network Configuration
  network_device {
    bridge = var.network_bridge
    model  = var.network_model
    vlan_id = var.network_tag
  }

  # Boot order - CD-ROM first for ISO installation
  boot_order = ["ide2", "virtio0"]

  # VM BIOS
  bios = "ovmf"

  # Machine type
  machine = "q35"

  # Lifecycle management
  lifecycle {
    ignore_changes = [
      network_device,
      disk,
      cdrom,
    ]
  }
}
