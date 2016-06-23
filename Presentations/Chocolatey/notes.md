#Fun with Chocolatey
## Introduction

### Important Links
* [Chocolatey.org](chocolatey.org)
* [Nuget.org](nuget.org)
* [Chocolatey.Server](https://chocolatey.org/packages?q=chocolatey.server)

### What is Chocolatey?
* Windows package manager
  * Similar to yum or apt-get

### What is Nuget?
* .NET package manager
  * Accessible from Powershell
  * Core web service behind chocolatey

### Getting Started
* Native to Powershell V5
  * Needs to be set up on vanilla installs
  * `Find-Package -ProviderName Bootstrap | Install-Package -Force`
  * `Find-Package -ProviderName Chocolatey`
  * Requires Nuget.exe which is installed during the bootstrap
  * Defaults to being an untrusted provider
* Same basic mechanism as PowershellGallery
  * `Find-Module`
  * `Install-Module`
* Install the chocolately client
  * Provides `choco.exe`
  * More feature rich than the default PS Provider
    * Also more robust
  * Compiled client is less native 

## Feeds
Chocolatey, and Nuget, both allow you to host your own feeds internally to your environment.  Obviously a key feature for enterprise users.

* Simple [Nuget Feed](nuget.org)
  * Great for testing
  * Great for hosting PowerShell Modules
* [Chocolatey.Server](https://chocolatey.org/packages?q=chocolatey.server) Feed
  * Great for testing and small deployments
* [Chocolatey for business](https://chocolatey.org/pricing)
  * Full enterprise ready features
  * Enhanced package creation and validation features

## Packages
[Chocolatey Documents](https://chocolatey.org/docs)

* Anatomy of a package
  * .nupkg
    * Simple archive, you can open it with anything that opens zip files
      * rename to .zip and extract
  * [.nuspec](https://docs.nuget.org/create/nuspec-reference)
    * instruction file for the package
    * xml document
  * [chocolately internal module](https://chocolatey.org/docs/helpers-reference)
  * [Package Scripts](https://chocolatey.org/docs/create-packages):
    * chocolateyInstall.ps1
    * chocolateyUninstall.ps1
    * chocolateyBeforeModify.ps1
* Creating a simple package
  * Important note, chocolatey.org is not allowed to host third party binaries
    * All packages published on the gallery must download required binaries on their own
  * Your own packages can bundle binaries

