# UG Meeting Schedule
- Introductions

- Introduce Packer

- Workstation setup
  - VSCode/Sublime/Notepad++/etc..
    - [VSCode](https://code.visualstudio.com/)
    - [Sublime](https://www.sublimetext.com/)
    - [Notepad++](https://notepad-plus-plus.org/)
    - [Atom](https://atom.io/)
  - [Chocolatey](https://chocolatey.org) (opt)
  - [Packer](https://www.packer.io/)
  - [git](https://chocolatey.org/packages/git) (opt)
  - [Vagrant](https://www.vagrantup.com/)
  - VirtualBox/VMWare Workstation
    - [VirtualBox](https://chocolatey.org/packages/virtualbox)
    - [VMWare Workstation](https://chocolatey.org/packages/vmwareworkstation)
  - git clone / download [Packer-Windows](https://github.com/joefitzgerald/packer-windows)
    - if download
      - Unblock-File
      - Expand-Archive

- cd to repo
- Overview of what and why
- Comment out updates
- packer build -only [virtualbox|vmware]-iso ./windows_2012_r2.json 
- How to build on top of image
- freetime for hacking on images
- Wrap up
- Next meetup Thursday june 16th


##Set up your workstation to use packer (Assumes windows 10)
1. Install Chocolatey
  - `iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))`
2. Install Vagrant
  - `choco install vagrant`
3. Install Packer
  - `choco install packer`
4. Install git
  - `choco install git`
5. Install VirtualBox
  -  `choco install virtualbox`
6. Clone packer-windows
  - `cd ~`
  - `git clone https://github.com/joefitzgerald/packer-windows.git`

##Build your first packer windows server (Windows Server 2012 r2)
***Quick Note:*** The packer run takes a long time, ~ 4 hours depending on your workstation

1. Navigate to the packer-windows repo
  - `cd ~\packer-windows`
2. do your initial packer run
  - `packer build -only virtualbox-iso .\windows_2012_r2.json`


## Links we discussed
- [Packer Builders](https://www.packer.io/docs/templates/builders.html)
- [Packer Post Processors](https://www.packer.io/docs/templates/post-processors.html)
- Another great packer for windows repository [packer-templates](https://github.com/mwrock/packer-templates)
  - Great blog post by Matt Wrock on this particular repo: [HurryUpAndWait](http://www.hurryupandwait.io/blog/creating-windows-base-images-for-virtualbox-and-hyper-v-using-packer-boxstarter-and-vagrant)

