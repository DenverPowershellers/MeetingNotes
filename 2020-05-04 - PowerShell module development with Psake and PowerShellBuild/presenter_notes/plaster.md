# install plaster

```powershell
cd C:\workspace
Install-Module Plaster
```

# plaster template

```powershell
New-Item -ItemType Directory -Name myNewModule
$template = Get-PlasterTemplate -IncludeInstalledModules | Where-Object TemplatePath -Match 'NewPowerShellScriptModule'
Invoke-Plaster -TemplatePath $template.TemplatePath
```

# copy over functions and tests

```powershell
cd c:\workspace
Move-Item .\myNewModule\test\ .\myNewModule\tests
Copy-Item .\mynewmodule-byhand\Tests\ .\myNewModule\ -Force -Recurse
```

# update manifest missing bits

`myNewModule.psd1`

```powershell
Description = 'myNewModule'
```

# make some functions

`myNewModule.psm1`

```powershell
function Get-Something {
    GetSomething
}
function GetSomething {
    Write-Output 'you got something'
}
```

# update manifest FunctionsToExport

```powershell
Update-ModuleManifest -Path .\myNewModule.psd1 -FunctionsToExport 'get-something'
```

# test

```powershell
Invoke-Pester
```

# analyze

```powershell
Invoke-ScriptAnalyzer -Recurse -Path ./
```

# publish

```powershell
Publish-Module -Path ./ -NuGetApiKey $env:PSGALLERY_API_KEY -Repository PSGallery
```
