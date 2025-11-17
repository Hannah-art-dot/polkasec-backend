# PowerShell script to test PolkaSEC API endpoints

Write-Host "🧪 Testing PolkaSEC API Endpoints" -ForegroundColor Cyan
Write-Host ""

$baseUrl = "http://localhost:8000"

# Test 1: Root endpoint
Write-Host "1. Testing root endpoint..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/" -Method Get
    Write-Host "   ✅ Root endpoint: " -ForegroundColor Green -NoNewline
    Write-Host ($response | ConvertTo-Json -Compress)
} catch {
    Write-Host "   ❌ Error: $_" -ForegroundColor Red
}

Write-Host ""

# Test 2: Health check
Write-Host "2. Testing health endpoint..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/health" -Method Get
    Write-Host "   ✅ Health check: " -ForegroundColor Green -NoNewline
    Write-Host ($response | ConvertTo-Json -Compress)
} catch {
    Write-Host "   ❌ Error: $_" -ForegroundColor Red
}

Write-Host ""

# Test 3: Get chains
Write-Host "3. Testing chains endpoint..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/chains" -Method Get
    Write-Host "   ✅ Chains status: " -ForegroundColor Green
    $response.chains | ForEach-Object {
        $status = if ($_.connected) { "🟢 Connected" } else { "🔴 Disconnected" }
        Write-Host "      - $($_.name): $status" -ForegroundColor $(if ($_.connected) { "Green" } else { "Red" })
    }
} catch {
    Write-Host "   ❌ Error: $_" -ForegroundColor Red
}

Write-Host ""

# Test 4: Get alerts
Write-Host "4. Testing alerts endpoint..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/alerts" -Method Get
    Write-Host "   ✅ Alerts found: $($response.Count)" -ForegroundColor Green
    if ($response.Count -gt 0) {
        $response | Select-Object -First 3 | ForEach-Object {
            Write-Host "      - [$($_.severity)] $($_.title)" -ForegroundColor White
        }
    }
} catch {
    Write-Host "   ❌ Error: $_" -ForegroundColor Red
}

Write-Host ""

# Test 5: Get alert stats
Write-Host "5. Testing alert statistics..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/alerts/stats" -Method Get
    Write-Host "   ✅ Alert stats: " -ForegroundColor Green
    Write-Host "      Total: $($response.total)" -ForegroundColor White
    Write-Host "      By Severity: " -ForegroundColor White -NoNewline
    Write-Host ($response.by_severity | ConvertTo-Json -Compress) -ForegroundColor Cyan
} catch {
    Write-Host "   ❌ Error: $_" -ForegroundColor Red
}

Write-Host ""

# Test 6: Simulate attack
Write-Host "6. Testing demo attack simulation..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/demo/simulate-attack" -Method Post
    Write-Host "   ✅ Demo alert generated!" -ForegroundColor Green
    Write-Host "      Alert ID: $($response.alert_id)" -ForegroundColor White
    Write-Host "      Status: $($response.status)" -ForegroundColor White
} catch {
    Write-Host "   ❌ Error: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "✨ Testing complete!" -ForegroundColor Cyan

