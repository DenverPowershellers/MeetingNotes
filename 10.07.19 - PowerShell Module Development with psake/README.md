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
[psake](https://github.com/psake/psake) is a build automation tool written in PowerShell. Runs defined tasks in a `psakeFile.ps1`. There's a lot of flexibility with how tasks are executed, see [examples](https://github.com/psake/psake/tree/master/examples) for more info. What's in scope for this talk is executing synchronous tasks with and without dependencies.

Invoke psake's default task.
```powershell
cd psake
Invoke-psake -buildFile ./psakeFile.ps1
```

Invoke a specific psake task.
```powershell
Invoke-psake -buildFile ./psakeFile.ps1 -taskList hi
```

Invoke a specific psake task with dependencies.
```powershell
Invoke-psake -buildFile ./psakeFile.ps1 -taskList test
```

## PowerShellBuild
[PowerShellBuild](https://github.com/psake/PowerShellBuild) is a module that contains a default set of psake tasks. These tasks are generic enough for anyone to use as part fo the module development process. These tasks can be "inherited" or loaded into a `psakeFile.ps1` via the `-FromModule` param. The obvious benefit of this is that it removes the need for you to copy and paste identical psake tasks across your modules.

Example showing the `clean` task being loaded form the PowerShellBuild module.
```powershell
task clean -FromModule PowerShellBuild -Version '0.3.0'
```

Invoke psake's clean task loaded from the PowerShellBuild module.
```powershell
cd powershellbuild
Invoke-psake -buildFile ./psakeFile.ps1 -taskList clean
```

### limitations
This is new and currently under development. There are bugs, things don't always work :(.
- issues with adding dependencies to PowerShellBuild psake tasks from custom tasks
- "overrides" do not work as expected


## build.ps1
The file `build.ps1` is a common name used as an entry point or initiator script to kicking things off that require building. `build.ps1` can be used to load prerequisites and kick off things like `Invoke-psake`. The `build.ps1` discussed here was provided as part of the stucco plaster template.

## stucco generated module leveraging psake and PowerShellBuild

run a build
```powershell
cd stucco/myModule
./build.ps1 -Bootstrap
```