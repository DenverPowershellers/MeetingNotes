# Ansible Powershell Demo

## Intro
 #todo

[Slide Deck](https://gitpitch.com/mdeangelo272/demo-ansible-powershell/meetup_denver#/)


## Usage
Create a Resource Group in Azure called `demos`.

Login into the [Azure Shell](https://shell.azure.com)
* Select `PowerShell`

### Get the source code and Setup the Local Environment: 
Go to you home directory: `cd $HOME`

create and use a `repos` directory:
```
mkdir repos 
cd repos
```

Clone the git repo
```
git clone -b meetup_denver https://github.com/mdeangelo272/demo-ansible-powershell.git`
cd demo-ansible-powershell
```

### Create a VM in Azure
Execute The Playbook
```
ansible-playbook main.yml --tags 'windows'
```

To create a windows VM use the 'windows' tag. To create a Linux VM use the 'linux' tag. 


### Configure the VM
 #todo: discuss this


## Local Setup 
**Ansible CLI requires a POSIX Compliant Shell.** Because of this the Ansible commands should be run from Linux or from a Windows machine with [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10).
 #todo: mkd - add some details here
* install python 
* install pip
* instal ansible 2.4+ (2.6 preferred)
* must install ansible azure dependencies
`pip install ansible[azure]`

## raw notes
* to bootstrap windows server run the `bootstrap_winrm.ps1` script on the Windows Server (Assumes you have the latest version of Windows Server 2016)
    * (should probably be done with machine images)
