
# create files

```powershell
New-Item -ItemType Directory -Path 'C:\workspace\myNewModule'
New-Item -ItemType Directory -Path 'C:\workspace\myNewModule\Public'
New-Item -ItemType Directory -Path 'C:\workspace\myNewModule\Private'
New-Item -ItemType Directory -Path 'C:\workspace\myNewModule\Tests'
New-ModuleManifest -Path 'C:\workspace\myNewModule\myNewModule.psd1' -ModuleVersion "2.0.0" -Author "YourNameHere"
cd C:\workspace
```

# update manifest missing bits

`myNewModule.psd1`

```powershell
RootModule = 'myNewModule.psm1'
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

# make some tests

`Tests\GetSomething.Tests.ps1`

```powershell
$moduleName = 'myNewModule'
$moduleFile = "$moduleName.psm1"
$moduleFilePath = "$PSScriptRoot\..\$ModuleFile"
Remove-Module $moduleName -Force -ErrorAction SilentlyContinue
Import-Module $ModuleFilePath

Describe 'Get-Something' {
    function GetSomething {}
    context 'returns something as expected' {
        it "should return you got something" {
            Get-Something | should -be 'you got something'
        }
    }
}
```

`Tests\GetSomething.Tests.ps1`

```powershell
$moduleName = 'myNewModule'
$moduleFile = "$moduleName.psm1"
$moduleFilePath = "$PSScriptRoot\..\$ModuleFile"
Remove-Module $moduleName -Force -ErrorAction SilentlyContinue
Import-Module $ModuleFilePath

InModuleScope myNewModule {
    Describe 'GetSomething' {
        context 'returns something as expected' {
            it "should return you got something" {
                GetSomething | should -be 'you got something'
            }
        }
    }
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

# move

```powershell
cd c:\workspace
mv ./mynewmodule ./mynewmodule-byhand
```
