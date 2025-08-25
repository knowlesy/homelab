# Ansible Homelab Testing

This directory contains Ansible playbooks to test and manage the VMs created with Terraform.

## Files


- **`inventory.yml`** - YAML format inventory (preferred)
- **`ping-test.yml`** - Quick SSH connectivity test
- **`ansible.cfg`** - Ansible configuration

## Security Configuration

- **`secrets.yml`** 

### Ansible Vault Setup

SSH passwords are stored securely using Ansible Vault:

1. **Encrypt the vault file:**
   ```bash
   ansible-vault encrypt secrets.yml
   ```
   You'll be prompted to create a vault password.
   

   ```bash
# This file is encrypted.
vault_ssh_password: 'YourSuperSecretPassword123!'
   ```


4. **Edit encrypted vault:**
   ```bash
   ansible-vault edit group_vars/vault.yml
   ```

### Manual Ansible Commands

Test individual VMs:

```bash
# Test single host
ansible node-01 -m ping

# Test all hosts
ansible all -m ping

# Run command on all hosts
ansible all -m shell -a "hostname && uptime"

# Check if VMs need sudo password
ansible all -m shell -a "sudo whoami" --ask-become-pass
```

## VM Configuration

The inventory assumes:
- **Username:** `ubnadmin`
- **IP Addresses:**
  - node-01: 192.168.1.101 (K8s Master)
  - node-02: 192.168.1.102 (K8s Worker)  
  - node-03: 192.168.1.103 (K8s Worker)




