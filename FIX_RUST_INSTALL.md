# 🔧 Quick Fix: Rust Installation Issue

## Problem
You're getting this error:
```
Cargo, the Rust package manager, is not installed or is not on PATH.
```

## Solution

### Step 1: Install Rust

**Download and install Rust:**
1. Visit: **https://rustup.rs/** 
2. Click "Download rustup-init.exe" (Windows 64-bit)
3. Run the installer
4. Choose option **1** (default installation)
5. Wait for installation to complete

### Step 2: Restart PowerShell

**IMPORTANT:** Close and reopen your PowerShell terminal completely. This ensures PATH is updated.

### Step 3: Verify Rust Installation

In your **NEW** PowerShell window:
```powershell
cargo --version
rustc --version
```

You should see version numbers. If you get "command not found", see Troubleshooting below.

### Step 4: Install Dependencies

```powershell
cd "C:\Users\hanah\Polkadot Project\polkasec-backend"
venv\Scripts\activate
pip install -r requirements.txt
```

## Troubleshooting

### If `cargo --version` still doesn't work:

**Option A: Add Cargo to PATH manually (Current Session)**
```powershell
$env:PATH = "$env:USERPROFILE\.cargo\bin;$env:PATH"
cargo --version
```

**Option B: Add Cargo to PATH permanently**
1. Press `Win + R`, type `sysdm.cpl`, press Enter
2. Click "Environment Variables"
3. Under "User variables", select "Path" and click "Edit"
4. Click "New" and add: `C:\Users\hanah\.cargo\bin`
5. Click OK on all dialogs
6. **Restart PowerShell**

**Option C: Use the helper script**
```powershell
cd "C:\Users\hanah\Polkadot Project\polkasec-backend"
.\install-rust.ps1
```

### If you see "Visual Studio Build Tools" errors:

Install Microsoft C++ Build Tools:
1. Download: https://visualstudio.microsoft.com/downloads/
2. Install "Build Tools for Visual Studio"
3. Select "Desktop development with C++" workload
4. Install and restart PowerShell

## Quick Test

After Rust is installed, test with:
```powershell
cargo --version
rustc --version
pip install substrate-interface
```

If all three commands work, you're ready to go! 🎉

