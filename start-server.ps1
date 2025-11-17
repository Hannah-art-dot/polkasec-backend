# PowerShell script to start the PolkaSEC backend server

Write-Host "🚀 Starting PolkaSEC Backend Server" -ForegroundColor Cyan
Write-Host ""

# Check if virtual environment exists
if (-not (Test-Path "venv\Scripts\activate.ps1")) {
    Write-Host "❌ Virtual environment not found!" -ForegroundColor Red
    Write-Host "   Please run: python -m venv venv" -ForegroundColor Yellow
    Write-Host "   Then: venv\Scripts\activate" -ForegroundColor Yellow
    exit 1
}

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-Host "⚠️  .env file not found!" -ForegroundColor Yellow
    Write-Host "   Creating from .env.example..." -ForegroundColor Yellow
    
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
        Write-Host "   ✅ Created .env file" -ForegroundColor Green
        Write-Host "   ⚠️  Please update .env with your PostgreSQL credentials!" -ForegroundColor Yellow
    } else {
        Write-Host "   ❌ .env.example not found!" -ForegroundColor Red
        Write-Host "   Please create .env file manually" -ForegroundColor Yellow
        exit 1
    }
}

# Activate virtual environment
Write-Host "📦 Activating virtual environment..." -ForegroundColor Yellow
& "venv\Scripts\activate.ps1"

# Check if main.py exists
if (-not (Test-Path "main.py")) {
    Write-Host "❌ main.py not found!" -ForegroundColor Red
    Write-Host "   Are you in the correct directory?" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Starting server on http://localhost:8000" -ForegroundColor Green
Write-Host "   Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Start the server
python main.py

