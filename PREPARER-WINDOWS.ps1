$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
if (-not (Test-Path (Join-Path $root 'settings.gradle.kts'))) {throw 'Le script doit se trouver dans le dossier contenant settings.gradle.kts.'}
$version = 'v8.9.0'
$base = "https://raw.githubusercontent.com/gradle/gradle/$version/"
$files = @(
    @{ url = 'gradlew.bat'; path = 'gradlew.bat'; min = 2000 },
    @{ url = 'gradlew'; path = 'gradlew'; min = 2000 },
    @{ url = 'gradle/wrapper/gradle-wrapper.jar'; path = 'gradle/wrapper/gradle-wrapper.jar'; min = 20000 }
)
try {
    foreach ($file in $files) {
        $target = Join-Path $root $file.path
        $parent = Split-Path $target -Parent
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
        Write-Host ('Recuperation officielle : ' + $file.path)
        $temp = "$target.download"
        Invoke-WebRequest -Uri ($base + $file.url) -OutFile $temp -UseBasicParsing -TimeoutSec 60
        if ((Get-Item $temp).Length -lt $file.min) { throw ('Telechargement incomplet : ' + $file.path) }
        Move-Item -Path $temp -Destination $target -Force
    }
    Write-Host 'SUCCES : Wrapper officiel Gradle 8.9 pret.' -ForegroundColor Green
} catch {
    Write-Host ('ERREUR : ' + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
