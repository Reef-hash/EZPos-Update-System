param(
    [Parameter(Mandatory = $true)]
    [string]$Version,

    [Parameter(Mandatory = $true)]
    [string]$InstallerPath,

    [Parameter(Mandatory = $true)]
    [string]$DownloadUrl,

    [Parameter(Mandatory = $true)]
    [string]$ReleaseNotes,

    [string]$MinimumVersion = "1.0.0",
    [bool]$Mandatory = $false,
    [bool]$SchemaChanged = $false
)

if (-not (Test-Path $InstallerPath)) {
    throw "Installer not found: $InstallerPath"
}

$hash = Get-FileHash -Path $InstallerPath -Algorithm SHA256
$published = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$manifest = [ordered]@{
    version = $Version
    name = "EZPos v$Version"
    publishedDate = $published
    releaseNotes = $ReleaseNotes
    downloadUrl = $DownloadUrl
    checksum = [ordered]@{
        algorithm = "sha256"
        value = $hash.Hash.ToLower()
    }
    mandatory = $Mandatory
    minimumVersion = $MinimumVersion
    targetFramework = "net6.0-windows7.0"
    updatedComponents = [ordered]@{
        binaries = $true
        schema = $SchemaChanged
    }
}

$manifest | ConvertTo-Json -Depth 5 | Set-Content -Path "latest.json" -Encoding UTF8
Write-Host "latest.json updated for version $Version"
Write-Host "SHA256: $($hash.Hash.ToLower())"
