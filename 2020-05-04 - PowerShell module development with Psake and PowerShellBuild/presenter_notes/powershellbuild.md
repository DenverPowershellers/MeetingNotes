# install powershellbuild

```powershell
install-module powershellbuild -MinimumVersion 0.4.0
```

# make a psake file

```powershell
task default -depends Test

task Test -FromModule PowerShellBuild -Version '0.4.0'
```

# refactor a bit

- create `myNewModule` dev directory
- create `myNewModule\public` and `myNewModule\private` directories
  - move functions to their respective locations and into their respective files
- use `psm1` module file that supports loading functions from public and private directories

```powershell
# Dot source public/private functions
$public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public/*.ps1')  -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private/*.ps1') -Recurse -ErrorAction Stop)
foreach ($import in @($public + $private)) {
    try {
        . $import.FullName
    }
    catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $public.Basename
```

- refactor test to load module from output directory

`Get-Something.Tests.ps1` & `GetSomething.Tests.ps1`

```powershell
Get-Module $env:BHProjectName | Remove-Module -Force
$ModuleManifestPath = Join-Path -Path $env:BHBuildOutput -ChildPath "$($env:BHProjectName).psd1"
Import-Module $ModuleManifestPath -Force
```

`myNewModule.Tests.ps1`

```powershell
$ModuleManifestPath = Join-Path -Path $env:BHBuildOutput -ChildPath "$($env:BHProjectName).psd1"
```

# invoke psake

```powershell
invoke-psake
```

- discuss buildHelpers
- discuss output directory and versied output directory
- discuss automatic functions to export
- discuss markdown docs

```powershell
invoke-psake -tasklist publish
```

# move

```powershell
cd c:\workspace
mv ./mynewmodule ./mynewmodule-powershellbuild
```
