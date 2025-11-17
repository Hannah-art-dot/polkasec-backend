# 🔧 Fix: Server Not Running

## Problem
You're getting "Unable to connect to the remote server" because the FastAPI server isn't running.

## ✅ Solution: Start the Server

### Step 1: Open a NEW PowerShell Window

Keep your current window for testing, open a **new** one for the server.

### Step 2: Navigate to Project Directory

```powershell
cd "C:\Users\hanah\Polkadot Project\polkasec-backend"
```

### Step 3: Activate Virtual Environment

```powershell
venv\Scripts\activate
```

You should see `(venv)` in your prompt.

### Step 4: Start the Server

**Option A: Use the helper script**
```powershell
.\start-server.ps1
```

**Option B: Start manually**
```powershell
python main.py
```

You should see:
```
INFO:     Started server process
INFO:     Waiting for application startup.
INFO:     🚀 Starting PolkaSEC Backend...
INFO:     ✅ Database initialized
INFO:     ✅ Blockchain monitoring started
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000
```

### Step 5: Test the API (In Your Original Window)

**Option A: Use the test script**
```powershell
.\test-api.ps1
```

**Option B: Test manually**
```powershell
# Use Invoke-RestMethod (PowerShell native)
Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get

# Or use curl.exe (Windows curl)
curl.exe http://localhost:8000/
```

## 🎯 Quick Commands Reference

### Start Server
```powershell
cd "C:\Users\hanah\Polkadot Project\polkasec-backend"
venv\Scripts\activate
python main.py
```

### Test API (in another terminal)
```powershell
cd "C:\Users\hanah\Polkadot Project\polkasec-backend"
.\test-api.ps1
```

## ⚠️ Common Issues

### Issue 1: "Module not found"
**Fix:** Make sure virtual environment is activated
```powershell
venv\Scripts\activate
pip install -r requirements.txt
```

### Issue 2: "Port already in use"
**Fix:** Another process is using port 8000
```powershell
# Find and kill the process
netstat -ano | findstr :8000
taskkill /PID <PID_NUMBER> /F
```

### Issue 3: "Database connection error"
**Fix:** Make sure PostgreSQL is running and `.env` file is correct
```powershell
# Check if PostgreSQL is running
Get-Service -Name postgresql*

# If not running, start it
Start-Service -Name postgresql-x64-15  # Adjust version number
```

## 📝 What You Should See

**When server starts successfully:**
```
🚀 Starting PolkaSEC Backend...
✅ Database initialized
✅ Blockchain monitoring started
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

**When testing API:**
```powershell
PS> Invoke-RestMethod -Uri "http://localhost:8000/" -Method Get

name        version status
----        ------- ------
PolkaSEC API 1.0.0   running
```

## 🚀 Next Steps

1. ✅ Start server in one terminal
2. ✅ Keep it running (don't close that window)
3. ✅ Test API in another terminal
4. ✅ Visit http://localhost:8000/docs for interactive API docs

