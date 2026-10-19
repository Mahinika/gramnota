# Packages the Flutter Windows Release folder into an Inno Setup installer
# and a portable zip. Copies the MSVC app-local CRT next to gramnota.exe
# so a clean Windows 10/11 PC can start the app.
$ErrorActionPreference = "Stop"
# Native tools write progress to stderr. That is not a failure.
$PSNativeCommandUseErrorActionPreference = $false

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$release = Join-Path $repoRoot "build\windows\x64\runner\Release"
$installerDir = Join-Path $repoRoot "build\windows\installer"
$iss = Join-Path $PSScriptRoot "gramnota.iss"
$iscc = if ($env:INNO_ISCC) { $env:INNO_ISCC } else { "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe" }

if (-not (Test-Path (Join-Path $release "gramnota.exe"))) {
  throw "Missing $release\gramnota.exe. Run flutter build windows --release first."
}
if (-not (Test-Path $iscc)) {
  throw "Inno Setup compiler not found at $iscc"
}

$versionLine = Select-String -Path (Join-Path $repoRoot "pubspec.yaml") -Pattern "^version:\s*(\d+\.\d+\.\d+)\+(\d+)\s*$"
if (-not $versionLine) {
  throw "pubspec.yaml version must look like 1.0.0+1"
}
$appVersion = $versionLine.Matches[0].Groups[1].Value
$appBuild = $versionLine.Matches[0].Groups[2].Value
Write-Host "Packaging Gramnota $appVersion+$appBuild"

$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
if (-not (Test-Path $vswhere)) {
  throw "vswhere not found"
}
$vsPath = (& $vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath | Select-Object -First 1)
if (-not $vsPath) {
  throw "Visual Studio C++ tools not found"
}
$vsPath = $vsPath.Trim()
$msvcRoot = Join-Path $vsPath "VC\Redist\MSVC"
$latest = Get-ChildItem $msvcRoot -Directory |
  Where-Object { $_.Name -match '^\d+\.\d+\.\d+' } |
  Sort-Object { [version]$_.Name } -Descending |
  Select-Object -First 1
if (-not $latest) {
  throw "No MSVC redistributable under $msvcRoot"
}
$crtDir = Join-Path $latest.FullName "x64\Microsoft.VC143.CRT"
if (-not (Test-Path $crtDir)) {
  $found = Get-ChildItem (Join-Path $latest.FullName "x64") -Directory -Filter "Microsoft.VC*.CRT" | Select-Object -First 1
  if (-not $found) {
    throw "CRT folder missing under $($latest.FullName)"
  }
  $crtDir = $found.FullName
}
Write-Host "Copying VC++ runtime from $crtDir"
Copy-Item (Join-Path $crtDir "*.dll") -Destination $release -Force
Get-ChildItem (Join-Path $crtDir "*.dll") | ForEach-Object { Write-Host "  $($_.Name)" }

Get-ChildItem -Path $release -Recurse -File |
  Where-Object { $_.Extension -in '.pdb', '.ilk', '.exp', '.lib' } |
  Remove-Item -Force

$required = @(
  "gramnota.exe",
  "flutter_windows.dll",
  "msvcp140.dll",
  "vcruntime140.dll",
  "vcruntime140_1.dll",
  "data\icudtl.dat"
)
foreach ($relative in $required) {
  $path = Join-Path $release $relative
  if (-not (Test-Path $path)) {
    throw "Release folder is missing $relative"
  }
}

$dumpbin = Get-ChildItem -Path (Join-Path $vsPath "VC\Tools\MSVC") -Recurse -Filter "dumpbin.exe" -ErrorAction SilentlyContinue |
  Where-Object { $_.FullName -match '\\Hostx64\\x64\\dumpbin\.exe$' } |
  Select-Object -First 1
if (-not $dumpbin) {
  throw "dumpbin.exe not found under $vsPath"
}

function Get-DependentDlls([string]$binary) {
  $output = & $dumpbin.FullName /dependents $binary
  $dlls = @()
  $inList = $false
  foreach ($line in $output) {
    if ($line -match "Image has the following dependencies") {
      $inList = $true
      continue
    }
    if (-not $inList) { continue }
    if ($line -match "Summary") { break }
    if ($line -match "^\s+([A-Za-z0-9_.-]+\.dll)\s*$") {
      $dlls += $Matches[1]
    }
  }
  return $dlls
}

# Check binaries that load at startup. Skip the CRT DLLs themselves: they
# import api-ms-win-* API sets, which Windows 10+ resolves and which are not
# files in System32. Skip dartjni.dll too; nothing in Gramnota loads it, and
# it imports jvm.dll.
$targets = @(
  (Join-Path $release "gramnota.exe"),
  (Join-Path $release "flutter_windows.dll")
)
$targets += @(Get-ChildItem $release -Filter "*_plugin.dll" -File | ForEach-Object { $_.FullName })
$missing = @()
foreach ($binary in $targets) {
  foreach ($dll in (Get-DependentDlls $binary)) {
    if ($dll -match "^(?i)(api-ms-win-|ext-ms-)") { continue }
    $local = Join-Path $release $dll
    if (Test-Path $local) { continue }
    $mustShip = $dll -match "^(?i)(msvcp|vcruntime|concrt|vccorlib)"
    $system = Join-Path $env:SystemRoot "System32\$dll"
    if (-not $mustShip -and (Test-Path $system)) { continue }
    $missing += "$(Split-Path $binary -Leaf) -> $dll"
  }
}
if ($missing.Count -gt 0) {
  throw "Missing app-local DLLs:`n$($missing -join "`n")"
}
Write-Host "Runtime dependencies are next to gramnota.exe"

New-Item -ItemType Directory -Force -Path $installerDir | Out-Null
$compile = & $iscc "/DAppVersion=$appVersion" "/DAppBuild=$appBuild" $iss 2>&1 | Out-String
Write-Host $compile
if ($compile -notmatch "Compiler engine version: Inno Setup 6\.") {
  throw "Inno Setup 6 did not compile the installer.`n$compile"
}
if ($LASTEXITCODE -ne 0) {
  throw "ISCC failed with exit code $LASTEXITCODE"
}

$setup = Join-Path $installerDir "Gramnota-Setup-$appVersion.exe"
if (-not (Test-Path $setup)) {
  throw "Installer was not created at $setup"
}

$zip = Join-Path $installerDir "Gramnota-$appVersion-windows-x64.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
tar.exe -a -c -f $zip -C $release .
if ($LASTEXITCODE -ne 0) {
  throw "tar failed with exit code $LASTEXITCODE"
}
$listed = @(tar.exe -tf $zip | ForEach-Object { ($_ -replace '\\', '/').Trim().TrimStart('./') })
foreach ($requiredName in @("gramnota.exe", "vcruntime140.dll", "msvcp140.dll", "data/icudtl.dat")) {
  if ($listed -notcontains $requiredName) {
    throw "Portable zip is missing $requiredName"
  }
}

Write-Host "Installer: $setup ($([math]::Round((Get-Item $setup).Length / 1MB, 1)) MB)"
Write-Host "Zip: $zip ($([math]::Round((Get-Item $zip).Length / 1MB, 1)) MB)"

if ($env:GITHUB_ENV) {
  Add-Content -Path $env:GITHUB_ENV -Value "APP_VERSION=$appVersion" -Encoding utf8NoBOM
  Add-Content -Path $env:GITHUB_ENV -Value "APP_BUILD=$appBuild" -Encoding utf8NoBOM
}
