# 🏠 Homelab Infrastructure Repository

Welcome to my homelab infrastructure setup! 🚀 This repository contains everything needed to deploy and manage a complete virtualized homelab environment using **Terraform** for infrastructure provisioning and **Ansible** for configuration management. The setup creates 3 Proxmox VMs that can be configured as a Kubernetes cluster, web servers, or any other services you need for learning and experimentation. 

## 🛠️ What's Inside

### 🏗️ **Terraform Infrastructure** (`/terraform`)
- **Proxmox VM Provisioning** - Automated creation of 3 VMs using the BPG Proxmox provider
- **ISO Boot Configuration** - VMs boot from Ubuntu Server ISO for clean installations  
- **Network Configuration** - Properly configured networking with static IPs
- **Resource Management** - Configurable CPU, memory, and disk allocation per VM

### 🎭 **Ansible Automation** (`/ansible`)
- **Secure Password Management** - Ansible Vault integration for SSH credentials
- **Comprehensive Testing Suite** - Multiple playbooks for connectivity, system info, and health checks
- **System Maintenance** - Automated updates, security patching, and system cleanup
- **Service Installation** - Docker and Kubernetes prerequisites setup
- **Organized Structure** - Separate directories for playbooks and inventory files

## 🚀 Quick Start

### 1️⃣ Deploy Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 2️⃣ Test Connectivity
```bash
cd ansible
ansible-playbook -i inventory/inventory.yml playbooks/ping-test.yml --ask-vault-pass
```

### 3️⃣ Update Systems
```bash
ansible-playbook -i inventory/inventory.yml playbooks/system-update.yml --ask-vault-pass
```

## 🎯 Default Configuration

| VM | Role | IP Address | Resources |
|---|---|---|---|
| 🖥️ homelab-vm-01 | K8s Master / Web Server | 192.168.1.101 | 2 CPU, 2GB RAM, 20GB Disk |
| 🖥️ homelab-vm-02 | K8s Worker / Database | 192.168.1.102 | 2 CPU, 2GB RAM, 20GB Disk |
| 🖥️ homelab-vm-03 | K8s Worker / App Server | 192.168.1.103 | 2 CPU, 2GB RAM, 20GB Disk |

## 📚 Documentation

- 📖 **[Terraform Documentation](terraform/README.md)** - Infrastructure setup and configuration
- 🎭 **[Ansible Documentation](ansible/README.md)** - Automation and configuration management  
- 📋 **[Playbook Index](ansible/PLAYBOOK-INDEX.md)** - Complete guide to all available playbooks
- 🔐 **[Vault Reference](ansible/VAULT-REFERENCE.md)** - Security and password management

## 🔧 Prerequisites

- **Proxmox VE** server with API access
- **Terraform** >= 1.0
- **Ansible** >= 2.9
- **Ubuntu 22.04 Server ISO** uploaded to Proxmox

## 🌟 Features

- ✅ **Infrastructure as Code** - Fully automated VM provisioning
- 🔒 **Secure by Default** - Encrypted password storage with Ansible Vault
- 🧪 **Comprehensive Testing** - Multiple test playbooks for validation
- 🔄 **System Maintenance** - Automated updates and cleanup procedures
- 📊 **Monitoring Ready** - System information gathering and health checks
- 🐳 **Container Ready** - Docker installation and Kubernetes preparation
- 📁 **Well Organized** - Clean directory structure and documentation

## 🤝 Usage Patterns

**🏠 Home Lab Learning**: Perfect for learning DevOps tools, container orchestration, and infrastructure automation

**🧪 Testing Environment**: Isolated environment for testing applications and configurations

**☸️ Kubernetes Cluster**: Ready-to-configure 3-node Kubernetes setup

**🌐 Web Services**: Host websites, databases, and applications

## 🚨 Security Notes

- 🔐 All sensitive data is stored in encrypted Ansible vaults
- 🛡️ Security update playbooks included for maintaining system security
- 📝 Comprehensive `.gitignore` prevents accidental credential commits

---

💡 **Happy Homelabbing!** This setup provides a solid foundation for learning, experimenting, and building awesome things in your homelab environment. Feel free to customize the configurations to match your specific needs and use cases! 🎉
