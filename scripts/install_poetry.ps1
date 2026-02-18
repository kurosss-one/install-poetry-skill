$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'

if (Get-Command poetry -ErrorAction SilentlyContinue) {
    Write-Host "Poetry already installed:" -ForegroundColor Green
    poetry --version
    exit 0
}

Write-Host "Installing Poetry..." -ForegroundColor Cyan
$installer = Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing
$installer.Content | python -

$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")

if (Get-Command poetry -ErrorAction SilentlyContinue) {
    Write-Host "Poetry installed successfully!" -ForegroundColor Green
    poetry --version
}