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

Invoke a specific psake task that has dependencies.
```powershell
Invoke-psake -buildFile ./psakeFile.ps1 -taskList test
```

Use `Get-PSakeScriptTasks` to get a list of tasks in a `psakeFile.ps1`.
```powershell
Get-PSakeScriptTasks -buildFile ./psakeFile.ps1
```

Common task pattern / dependency tree to follow (i.e. we'll see this with PowerShellBuild's psake tasks).
```
Init       - output build variables
Clean      - remove the contents of our dedicated build output directory
StageFiles - copy of readme markdown file
BuildHelp  - call PlatyPS and build markdown  help
Build      - copy public and private functions to dedicated build output directory
Pester     - run pester tests against build output files
Analyze    - run powershell script analyzer against build output files
```

## PowerShellBuild
[PowerShellBuild](https://github.com/psake/PowerShellBuild) is a module that contains a default set of psake tasks. These tasks are generic enough for anyone to use as part fo the module development process. These tasks can be "inherited" or loaded into a `psakeFile.ps1` via the `-FromModule` param. The obvious benefit of this is that it removes the need for you to copy and paste identical psake tasks across your modules.

Example showing the `clean` task being loaded form the PowerShellBuild module.
```powershell
task clean -FromModule PowerShellBuild -Version '0.3.0'
```

Invoke psake's clean task as loaded from the PowerShellBuild module.
```powershell
cd powershellbuild
Invoke-psake -buildFile ./psakeFile.ps1 -taskList clean
```

### limitations
This is new and currently under development. There are bugs, things don't always work :(.
- `$PSBPreference.Build.Dependencies` does not work if you want to add additional dependencies to psakes's `build` task.
- the workaround for the above issue is to explicitly define `-depends` for the PowerShellBuild task you wish to modify the dependencies on. See below.
```
task Build -FromModule PowerShellBuild -depends @('StageFiles','BuildHelp','myCustomBuildTask')
```
However, the issue with this is that you can only do it once / it only works at overriding the default dependencies on one task loaded from a module.
```
task Build -FromModule PowerShellBuild -depends @('StageFiles','BuildHelp','myCustomBuildTask')
task Test -FromModule PowerShellBuild -depends @('Analyze','Pester','UploadTestResults')
task UploadTestResults -depends pester {"    upload me some test results"}
```

## build.ps1
The file `build.ps1` is a common name used as an entry point or initiator script to kick things off that require building. `build.ps1` can be used to load prerequisites and kick off things like `Invoke-psake`. The `build.ps1` discussed here was provided as part of the stucco plaster template.

The stucco generated `build.ps1` we'll use today features a `-bootstrap` param that automatically reviews all build dependencies (e.g. other PowerShell modules) listed in `requirements.psd1` and installs them. This functionality under the hood is leveraging [psdepend](https://github.com/RamblingCookieMonster/PSDepend). The `-bootstrap` param must only be run once during the initial build.

## stucco generated module leveraging psake and PowerShellBuild

Run a build by calling `./build.ps1`.
```powershell
cd stucco/myModule
./build.ps1 -Bootstrap
```