# install psake

```powershell
Install-Module psake
```

# make a psake file

`psakeFile.ps1`

```powershell
task default -depends test

task test -depends analyze, manifest, pester

task analyze {
    Invoke-ScriptAnalyzer -Recurse -Path ./
}

task manifest {
    Update-ModuleManifest -Path .\myNewModule.psd1 -FunctionsToExport 'Get-Something'
}

task pester -depends analyze, manifest {
    Invoke-Pester
}

task publish -depends test {
    Publish-Module -Path ./ -NuGetApiKey $env:PSGALLERY_API_KEY -Repository PSGallery
}
```

# invoke psake

```powershell
invoke-psake
```

```powershell
invoke-psake -tasklist publish
```
