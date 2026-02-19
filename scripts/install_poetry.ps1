# scripts/install_poetry.ps1
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'

Write-Host "[Skill: install-poetry] Checking existing installation..." -ForegroundColor Cyan

# Проверяем, доступен ли poetry прямо сейчас
if (Get-Command poetry -ErrorAction SilentlyContinue) {
    Write-Host "✓ Poetry already installed:" -ForegroundColor Green
    poetry --version
    exit 0
}

# Если не найден в PATH, проверим стандартный путь установки (на случай, если PATH не обновлен после предыдущей установки)
$defaultPoetryPath = "$env:APPDATA\Python\Scripts\poetry.exe"
if (Test-Path $defaultPoetryPath) {
    Write-Host "⚠️  Poetry found at default location but not in PATH. Fixing PATH..." -ForegroundColor Yellow
    $env:Path += ";$env:APPDATA\Python\Scripts"
    Write-Host "✓ Poetry is now available:" -ForegroundColor Green
    poetry --version
    exit 0
}

Write-Host "↓ Installing Poetry using official installer..." -ForegroundColor Cyan
try {
    $installer = Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing
    $installer.Content | python -
} catch {
    Write-Error "✗ Installation failed: $_"
    exit 1
}

Write-Host "↻ Updating PATH for current session..." -ForegroundColor Yellow
$env:Path += ";$env:APPDATA\Python\Scripts"

# Финальная проверка
if (Get-Command poetry -ErrorAction SilentlyContinue) {
    Write-Host "✅ Poetry installed and added to PATH successfully!" -ForegroundColor Green
    poetry --version
} else {
    Write-Error "✗ Poetry installed but not found in PATH. Please restart your terminal."
    exit 1
}