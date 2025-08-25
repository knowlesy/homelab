# Proxmox API Configuration
variable "proxmox_api_url" {
  description = "The Proxmox API URL (e.g., https://proxmox.example.com:8006/api2/json)"
  type        = string
}

variable "proxmox_user" {
  description = "The Proxmox user (e.g., root@pam or terraform@pve)"
  type        = string
}

variable "proxmox_password" {
  description = "The Proxmox user password"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Skip TLS verification (useful for self-signed certificates)"
  type        = bool
  default     = true
}

# Proxmox Node Configuration
variable "proxmox_node" {
  description = "The Proxmox node to deploy VMs on"
  type        = string
  default     = "pve"
}

# VM ISO Configuration
variable "vm_iso" {
  description = "The ISO file to use for VM installation (format: storage:iso/filename.iso)"
  type        = string
  default     = "local:iso/ubuntu-22.04.3-live-server-amd64.iso"
}

variable "vm_iso_storage" {
  description = "Storage location for ISO files"
  type        = string
  default     = "local"
}

# VM Disk Storage Configuration
variable "vm_disk_storage" {
  description = "Storage location for VM disks (global setting for all VMs)"
  type        = string
  default     = "local-lvm"
}

# Network Configuration
variable "network_bridge" {
  description = "The network bridge to connect VMs to"
  type        = string
  default     = "vmbr0"
}

variable "network_model" {
  description = "The network model for VM NICs"
  type        = string
  default     = "virtio"
}

variable "network_tag" {
  description = "VLAN tag for the network (optional)"
  type        = number
  default     = null
}

# VM Configuration
variable "vm_config" {
  description = "Configuration for the VMs"
  type = map(object({
    name        = string
    vmid        = number
    cores       = number
    memory      = number
    disk_size   = string
    ip_address  = string
    description = string
  }))
  default = {
    vm1 = {
      name        = "homelab-vm-01"
      vmid        = 101
      cores       = 2
      memory      = 2048
      disk_size   = "20G"
      ip_address  = "192.168.1.101"
      description = "Homelab VM 1 - Web Server"
    }
    vm2 = {
      name        = "homelab-vm-02"
      vmid        = 102
      cores       = 2
      memory      = 2048
      disk_size   = "20G"
      ip_address  = "192.168.1.102"
      description = "Homelab VM 2 - Database Server"
    }
    vm3 = {
      name        = "homelab-vm-03"
      vmid        = 103
      cores       = 2
      memory      = 2048
      disk_size   = "20G"
      ip_address  = "192.168.1.103"
      description = "Homelab VM 3 - Application Server"
    }
  }
}

# SSH Configuration
variable "ssh_user" {
  description = "SSH user for the VMs"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  description = "SSH public key to add to VMs (optional when using passwords)"
  type        = string
  default     = ""
}

# VM Password Configuration
variable "vm_passwords" {
  description = "Passwords for each VM"
  type = map(string)
  sensitive = true
  default = {}
}

variable "default_vm_password" {
  description = "Default password for VMs if not specified individually"
  type        = string
  sensitive   = true
  default     = ""
}

# Network Gateway and DNS
variable "network_gateway" {
  description = "Default gateway for the VMs"
  type        = string
  default     = "192.168.1.1"
}

variable "dns_servers" {
  description = "DNS servers for the VMs"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}
