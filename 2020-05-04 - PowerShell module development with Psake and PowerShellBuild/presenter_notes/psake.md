# make a psake file

`psakeFile.ps1`

```powershell
task default -depends test, analyze, manifest

task test -depends analyze, manifest {
    Invoke-Pester
}

task analyze {
    Invoke-ScriptAnalyzer -Recurse -Path ./
}

task manifest {
    Update-ModuleManifest -Path .\myNewModule.psd1 -FunctionsToExport 'Get-Something'
}

task publish -depends test {
    Publish-Module -Path ./ -NuGetApiKey $env:PSGALLERY_API_KEY -Repository PSGallery
}
```