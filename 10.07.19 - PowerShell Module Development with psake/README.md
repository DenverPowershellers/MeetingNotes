# PowerShell Module Development

## plaster
[plaster](https://github.com/PowerShell/Plaster) is a template-based file and project generator.
```powershell
$plasterDest = '.\plaster'
$defaultTemplate = Get-PlasterTemplate -IncludeInstalledModules | Where-Object Title -eq 'New PowerShell Manifest Module'
Invoke-Plaster -TemplatePath $defaultTemplate.TemplatePath -DestinationPath $plasterDest/myModule  -Verbose
```

## stucco
[stucco](https://github.com/devblackops/Stucco) is an opinionated Plaster template for building high-quality modules. Stucco is written and managed by [devblackops](https://twitter.com/devblackops). Note, stucco leverages [PowerShellBuild](https://github.com/psake/PowerShellBuild) psake tasks (discussed later).

```powershell
$plasterDest = '.\stucco'
$stuccoTemplate = Get-PlasterTemplate -IncludeInstalledModules | Where-Object TemplatePath -Match 'Stucco'
Invoke-Plaster -TemplatePath $stuccoTemplate.TemplatePath -DestinationPath $plasterDest/myModule
```

## psake
[psake](https://github.com/psake/psake) is a build automation tool written in PowerShell. Runs defined tasks in a `psakeFile.ps1`.

Invoke psake's default task.
```powershell
cd psake
Invoke-psake -buildFile ./psakeFile.ps1
```

Invoke a specific psake task.
```powershell
Invoke-psake -buildFile ./psakeFile.ps1 -taskList hi
```

## PowerShellBuild
[PowerShellBuild](https://github.com/psake/PowerShellBuild) is a module that contains a default set of psake tasks. These tasks are generic enough for anyone to use as part fo the module development process. These tasks can be "inherited" or laoded into a `psakeFile.ps1`. The obvious benefit of this is that it removes the need for you to copy and paste identical psake tasks across your modules.

Example showing the `clean` task being loaded form the PowerShellBuild module.
```powershell
task clean -FromModule PowerShellBuild -Version '0.3.0'
```

Invoke psake's default task.
```powershell
cd powershellbuild
Invoke-psake -buildFile ./psakeFile.ps1
```

## stucco generated module with psake and PowerShellBuild


```powershell
cd stucco/myModule
./build.ps1 -Bootstrap