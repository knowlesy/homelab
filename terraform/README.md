# Homelab Terraform - Proxmox VMs (ISO-based)

This Terraform configuration creates 3 VMs on Proxmox using ISO installation instead of templates.

## Prerequisites

1. **Proxmox VE** server with API access enabled
2. **Ubuntu ISO file** uploaded to Proxmox local storage (iso directory)
3. **Terraform** installed (>= 1.0)
4. **Strong passwords** for VM access (stored securely)

## Setup Instructions

### 1. Configure Proxmox User

Create a dedicated Terraform user in Proxmox:

```bash
# On Proxmox server
pveum user add terraform@pve
pveum passwd terraform@pve
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.PowerMgmt"
pveum aclmod / -user terraform@pve -role TerraformProv
```

### 2. Upload Ubuntu ISO

Upload Ubuntu ISO to Proxmox local storage:

1. **Download Ubuntu Server ISO:**
   ```bash
   wget https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso
   ```

2. **Upload to Proxmox:**
   - Via Web UI: Go to your node → local (storage) → ISO Images → Upload
   - Via CLI: Copy the ISO to `/var/lib/vz/template/iso/` on your Proxmox server
   - Via SCP: `scp ubuntu-22.04.3-live-server-amd64.iso root@proxmox-server:/var/lib/vz/template/iso/`

3. **Verify ISO is available:**
   ```bash
   # On Proxmox server
   ls -la /var/lib/vz/template/iso/
   ```

### 3. Configure Variables

1. Copy the example variables files:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   cp passwords.tfvars.example passwords.tfvars
   ```

2. Edit `terraform.tfvars` with your Proxmox details:
   - Update `proxmox_api_url` with your Proxmox server URL
   - Set `proxmox_user` and `proxmox_password`
   - Update `proxmox_node` with your node name
   - Set `vm_iso` to your ISO filename (e.g., `local:iso/ubuntu-22.04.3-live-server-amd64.iso`)
   - Configure network settings (bridge, gateway, IPs)

3. Edit `passwords.tfvars` with your VM passwords:
   - Set `default_vm_password` for a common password across all VMs
   - Or set individual passwords in the `vm_passwords` map
   - Use strong, unique passwords for each VM

### 4. Deploy VMs

```bash
# Initialize Terraform
terraform init

# Review the plan (including passwords file)
terraform plan -var-file="passwords.tfvars"

# Apply the configuration (including passwords file)
terraform apply -var-file="passwords.tfvars"
```

## VM Configuration

The default configuration creates 3 VMs:

| VM Name | VMID | vCPUs | RAM | Disk | IP Address | Purpose |
|---------|------|-------|-----|------|------------|---------|
| homelab-web-01 | 101 | 2 | 2GB | 20GB | 192.168.1.101 | Web Server |
| homelab-db-01 | 102 | 4 | 4GB | 40GB | 192.168.1.102 | Database Server |
| homelab-app-01 | 103 | 2 | 2GB | 30GB | 192.168.1.103 | Application Server |

All VMs are connected to the same network bridge (`vmbr0` by default).

## Customization

You can customize the VM configuration by modifying the `vm_config` variable in `terraform.tfvars`:

```hcl
vm_config = {
  vm1 = {
    name        = "custom-vm-name"
    vmid        = 201
    cores       = 4
    memory      = 8192
    disk_size   = "50G"
    ip_address  = "192.168.1.201"
    description = "Custom VM Description"
  }
  # Add more VMs as needed
}
```

## Accessing VMs

After deployment, you can SSH to the VMs using password authentication:

```bash
ssh ubuntu@192.168.1.101  # Enter password when prompted
ssh ubuntu@192.168.1.102  # Enter password when prompted
ssh ubuntu@192.168.1.103  # Enter password when prompted
```

The passwords are the ones you set in `passwords.tfvars`.

## Network Configuration

All VMs are configured with:
- Static IP addresses
- Same network bridge
- Default gateway: 192.168.1.1
- DNS servers: 8.8.8.8, 8.8.4.4

## Troubleshooting

### Common Issues

1. **Template not found**: Ensure the template name in `vm_template` matches your Proxmox template
2. **Permission denied**: Verify the Proxmox user has correct permissions
3. **Network issues**: Check that the bridge name and IP range are correct
4. **SSH connection failed**: Ensure your SSH public key is correctly set and the private key is accessible

### Debugging

Enable debug logging by setting `proxmox_debug = true` in your `terraform.tfvars`.

## Cleanup

To destroy all VMs:

```bash
terraform destroy -var-file="passwords.tfvars"
```

## Security Notes

- Never commit `terraform.tfvars` or `passwords.tfvars` to version control (they're already in `.gitignore`)
- Use strong, unique passwords for each VM
- Consider enabling SSH key authentication as an additional security layer
- Use strong passwords for Proxmox users
- Consider using Proxmox API tokens instead of passwords
- Regularly update your VM templates with security patches
- Store password files securely and restrict access to them
