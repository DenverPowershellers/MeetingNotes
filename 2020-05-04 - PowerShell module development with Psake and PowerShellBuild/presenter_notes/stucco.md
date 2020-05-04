# install stucco

```powershell
cd c:\workspace
Install-Module Stucco
```

# stucco template

```powershell
cd c:\workspace
New-Item -ItemType Directory -Name myNewModule
$template = Get-PlasterTemplate -IncludeInstalledModules | Where-Object TemplatePath -Match 'Stucco'
Invoke-Plaster -TemplatePath $template.TemplatePath
```

# push to git

```plaintext
git init
git add .
git commit -m "init"
git remote add origin https://github.com/joeypiccola/myNewModule.git
git push -u origin master
```

# copy over our tests and functions

```powershell
cd c:\workspace
Copy-Item -Recurse -Path .\mynewmodule-powershellbuild\myNewModule\public\get-something.ps1 .\myNewModule\myNewModule\Public\
Copy-Item -Recurse -Path .\mynewmodule-powershellbuild\myNewModule\private\getsomething.ps1 .\myNewModule\myNewModule\Private\
Copy-Item -Recurse -Path .\mynewmodule-powershellbuild\tests\GetSomething.Tests.ps1 .\myNewModule\tests\
Copy-Item -Recurse -Path .\mynewmodule-powershellbuild\tests\Get-Something.Tests.ps1 .\myNewModule\tests\
Remove-Item .\myNewModule\myNewModule\Public\Get-HelloWorld.ps1
Remove-Item .\myNewModule\myNewModule\Private\GetHelloWorld.ps1
```

# invoke psake

expose first issue with `Help.tests.ps1` and `pwsh7`

```powershell
invoke-psake
```

# start to fix things

## myNewModule\tests\Help.tests.ps1

Ensure imported module is from `outputdir`. remove `workflow` on line 13

replace `4-12` with...

```powershell
Get-Module $env:BHProjectName | Remove-Module -Force
$ModuleManifestPath = Join-Path -Path $env:BHBuildOutput -ChildPath "$($env:BHProjectName).psd1"
Import-Module $ModuleManifestPath -Force
```

## myNewModule\tests\Manifest.tests.ps1

Ensure imported manifest is from `outputdir`. replace 1-7 with...

```powershell
$moduleName         = $env:BHProjectName
$outputManifestPath = Join-Path -Path $env:BHBuildOutput -ChildPath "$($env:BHProjectName).psd1"
$manifest           = Import-PowerShellDataFile -Path $outputManifestPath
```

# build.ps1

- comment entry point to kick off build process and ensure build env has what it needs
- discuss `psdepends` and `requirements.psd1`

# update requirements

- pester `4.10.1`
- psake `4.9.0`

```powershell
    'PSScriptAnalyzer' = @{
        Version = '1.18.3'
    }
    'platyPS' = @{
        Version = '0.14.0'
    }
```

# segway into AppVeyor / CI

update build image to `APPVEYOR_BUILD_WORKER_IMAGE: Visual Studio 2017`

add `-Bootstrap` to `ps` and `pwsh` test scripts


# lets make it even better!

lets upload our pester test result

add psake task `UploadTestResults`

```powershell
task UploadTestResults {
    $wc = New-Object 'System.Net.WebClient'
    $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", $testResultsPath)
} -description 'Uploading tests'
```

add the following to our psake properties block

```powershell
    $testResultsPath = Join-Path -Path $PSScriptRoot -ChildPath "output/$env:BHProjectName/testResults.xml"
    $PSBPreference.Test.OutputFile = $testResultsPath
```

update appveylor.yml to also run our `UploadTestResults` task

```powershell
. .\build.ps1 -Bootstrap -Task Test, UploadTestResults
```

# badges

```plaintext
| Appveyor | Appveyor Tests  | PS Gallery Downloads | PS Gallery Version|
|--------|--------|--------|--------|
[![AppVeyor][appveyor-badge]][appveyor] | [![AppVeyor][appveyor-badge-tests]][appveyor] | [![PowerShell Gallery][powershellgallery-downloads]][powershellgallery] | [![PowerShell Gallery][powershellgallery-version]][powershellgallery]
```

```plaintext
[appveyor]: https://ci.appveyor.com/project/joeypiccola/mynewmodule
[appveyor-badge]: https://ci.appveyor.com/api/projects/status/<--key-->/branch/master?svg=true&passingText=master%20-%20PASSING&pendingText=master%20-%20PENDING&failingText=master%20-%20FAILING
[appveyor-badge-tests]: https://img.shields.io/appveyor/tests/joeypiccola/mynewmodule/master
[powershellgallery]: https://www.powershellgallery.com/packages/mynewmodule
[powershellgallery-downloads]: https://img.shields.io/powershellgallery/dt/mynewmodule
[powershellgallery-version]: https://img.shields.io/powershellgallery/v/mynewmodule
```
