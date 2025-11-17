# PowerShell script to help install Rust and set up PATH

Write-Host "🔧 Rust Installation Helper for PolkaSEC Backend" -ForegroundColor Cyan
Write-Host ""

# Check if Rust is already installed
$cargoExists = Get-Command cargo -ErrorAction SilentlyContinue

if ($cargoExists) {
    Write-Host "✅ Rust/Cargo is already installed!" -ForegroundColor Green
    cargo --version
    rustc --version
    Write-Host ""
    Write-Host "You can now install substrate-interface:" -ForegroundColor Yellow
    Write-Host "  pip install substrate-interface" -ForegroundColor White
    exit 0
}

Write-Host "❌ Rust/Cargo not found in PATH" -ForegroundColor Red
Write-Host ""

# Check if Cargo exists but not in PATH
$cargoPath = "$env:USERPROFILE\.cargo\bin\cargo.exe"
if (Test-Path $cargoPath) {
    Write-Host "⚠️  Cargo found at: $cargoPath" -ForegroundColor Yellow
    Write-Host "   But it's not in your PATH" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Adding to PATH for current session..." -ForegroundColor Cyan
    $env:PATH = "$env:USERPROFILE\.cargo\bin;$env:PATH"
    
    $cargoExists = Get-Command cargo -ErrorAction SilentlyContinue
    if ($cargoExists) {
        Write-Host "✅ Cargo is now available!" -ForegroundColor Green
        cargo --version
        Write-Host ""
        Write-Host "⚠️  This is only for the current PowerShell session." -ForegroundColor Yellow
        Write-Host "   To make it permanent, add this to your PATH:" -ForegroundColor Yellow
        Write-Host "   $env:USERPROFILE\.cargo\bin" -ForegroundColor White
        Write-Host ""
        Write-Host "   Or restart PowerShell after installing Rust." -ForegroundColor Yellow
        exit 0
    }
}

Write-Host "📥 Rust is not installed. Please install it:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Option 1: Download and run rustup-init.exe" -ForegroundColor Cyan
Write-Host "   Visit: https://rustup.rs/" -ForegroundColor White
Write-Host "   Or: https://win.rustup.rs/x86_64" -ForegroundColor White
Write-Host ""
Write-Host "Option 2: Open installer in browser" -ForegroundColor Cyan
$install = Read-Host "   Open rustup installer in browser? (Y/N)"
if ($install -eq "Y" -or $install -eq "y") {
    Start-Process "https://win.rustup.rs/x86_64"
}

Write-Host ""
Write-Host "After installing Rust:" -ForegroundColor Yellow
Write-Host "1. Close and reopen PowerShell" -ForegroundColor White
Write-Host "2. Run: pip install -r requirements.txt" -ForegroundColor White
Write-Host ""

