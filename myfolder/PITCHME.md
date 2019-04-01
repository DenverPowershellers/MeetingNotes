## What is Ansible
* Ansible is a Configuration Management (CM) Tool Similar to Chef and Puppet
* Like other CM tools, Ansible can also be used for Infrastructure as Code (IaC)
* Ansible is implemented in Python
* You defined your configurations and infrastructure in YAML

---

## Why Ansible
* Ansible is easy to learn
* Unlike other Configuration Management tools, Ansible is Agent less
* Ansible uses SSH or WinRM to communicate with nodes
* Ansible uses PowerShell for Windows Specific modules
* Ansible Modules can be written in any language

---

## Primary Concepts
* Controller Node - The Instance that you actually run the Ansible commands from
* Inventories - Defines and classifies your nodes and workloads
* Playbooks - Defines logic to be applied to your inventories

---

## Ansible in Windows
* Uses Native WinRM
* Windows servers must have WinRM activated, Ansible provides PowerShell scripts for this
* Supports many configuration options, such as: 
    * Windows Roles and Features
    * Directories, Files, and templates
    * Registry manipulation
    * Desired State Config Execution
    * IIS configurations

---

## Ansible in Azure
* Ansible can configure cloud infrastructure in Azure
* the Azure Shell natively supports Ansible using Windows Subsystem for Linux
* Can manage: VMs, storage, containers, load balancers, network interfaces, databases, and more
* supports elastic workloads using dynamic inventories

---

## Contact Me
* email: iam@mdeangelo272.me
* Website: https://mdeangelo272.me/
* GitHub: https://github.com/mdeangelo272
* LinkedIn: https://www.linkedin.com/in/mdeangelo272/
