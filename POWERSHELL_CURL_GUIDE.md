# PowerShell curl Commands Guide

## ⚠️ Important: PowerShell curl is NOT the same as Linux curl!

In PowerShell, `curl` is an **alias** for `Invoke-WebRequest`, which has different syntax.

## ✅ Correct PowerShell Commands

### Option 1: Use Invoke-RestMethod (Recommended)

```powershell
# GET request
Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get

# POST request
Invoke-RestMethod -Uri "http://localhost:8000/api/demo/simulate-attack" -Method Post
```

### Option 2: Use curl.exe (Windows curl)

```powershell
# Use curl.exe explicitly (not the alias)
curl.exe http://localhost:8000/
curl.exe -X POST http://localhost:8000/api/demo/simulate-attack
```

### Option 3: Use the Test Script

```powershell
.\test-api.ps1
```

## 📋 Common API Commands

### Start the Server First!

```powershell
# Start server in one terminal
.\start-server.ps1

# Or manually:
python main.py
```

### Then Test Endpoints:

```powershell
# Root endpoint
Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get

# Health check
Invoke-RestMethod -Uri "http://localhost:8000/health" -Method Get

# Get chains
Invoke-RestMethod -Uri "http://localhost:8000/api/chains" -Method Get

# Get alerts
Invoke-RestMethod -Uri "http://localhost:8000/api/alerts" -Method Get

# Get alert stats
Invoke-RestMethod -Uri "http://localhost:8000/api/alerts/stats" -Method Get

# Simulate attack (POST)
Invoke-RestMethod -Uri "http://localhost:8000/api/demo/simulate-attack" -Method Post
```

## 🔧 Quick Fix for Your Current Issue

**Problem:** Server not running

**Solution:**
1. Open a **NEW** PowerShell window
2. Navigate to project:
   ```powershell
   cd "C:\Users\hanah\Polkadot Project\polkasec-backend"
   ```
3. Activate virtual environment:
   ```powershell
   venv\Scripts\activate
   ```
4. Start server:
   ```powershell
   python main.py
   ```
5. Keep that window open, then in **ANOTHER** PowerShell window, run:
   ```powershell
   cd "C:\Users\hanah\Polkadot Project\polkasec-backend"
   .\test-api.ps1
   ```

## 📝 Example Output

```powershell
PS> Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get

name     version status
----     ------- ------
PolkaSEC API 1.0.0   running
```

## 🎯 Pro Tips

1. **Use the test script** - It's easier: `.\test-api.ps1`
2. **Use Invoke-RestMethod** - It automatically parses JSON
3. **Use curl.exe** - If you prefer curl syntax, use `curl.exe` explicitly
4. **Check server is running** - Make sure `python main.py` is running first!

