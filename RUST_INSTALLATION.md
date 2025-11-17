# Rust Installation Guide for Windows

The `substrate-interface` package requires Rust and Cargo to compile. Here's how to install it on Windows.

## Quick Installation

### Option 1: Using rustup (Recommended)

1. **Download rustup-init.exe:**
   - Visit: https://rustup.rs/
   - Or direct download: https://win.rustup.rs/x86_64
   - Run the installer

2. **During installation:**
   - Choose "1) Proceed with installation (default)"
   - The installer will add Rust to your PATH automatically

3. **Restart PowerShell:**
   - Close and reopen your PowerShell terminal
   - This ensures PATH changes take effect

4. **Verify installation:**
   ```powershell
   rustc --version
   cargo --version
   ```

5. **Install substrate-interface:**
   ```powershell
   cd polkasec-backend
   venv\Scripts\activate
   pip install substrate-interface
   ```

### Option 2: Manual PATH Setup (If rustup didn't add it)

If Cargo is installed but not found, add it to PATH:

**PowerShell (Current Session):**
```powershell
$env:PATH += ";C:\Users\$env:USERNAME\.cargo\bin"
```

**Permanent (System-wide):**
1. Open System Properties → Environment Variables
2. Edit "Path" under User variables
3. Add: `C:\Users\YourUsername\.cargo\bin`
4. Restart PowerShell

**Verify:**
```powershell
cargo --version
```

## Alternative: Use Pre-compiled Wheels (If Available)

If you're having trouble with Rust compilation, you can try installing a pre-compiled wheel:

```powershell
pip install --only-binary :all: substrate-interface
```

Note: This may not always be available for your Python version/platform.

## Troubleshooting

### "Cargo not found" after installation

1. **Check if Cargo exists:**
   ```powershell
   Test-Path "$env:USERPROFILE\.cargo\bin\cargo.exe"
   ```

2. **If it exists, add to PATH manually:**
   ```powershell
   $env:PATH = "$env:USERPROFILE\.cargo\bin;$env:PATH"
   ```

3. **Verify:**
   ```powershell
   cargo --version
   ```

### Still having issues?

1. **Reinstall Rust:**
   ```powershell
   # Uninstall
   rustup self uninstall
   
   # Reinstall from https://rustup.rs/
   ```

2. **Check Visual Studio Build Tools:**
   - Rust on Windows requires Microsoft C++ Build Tools
   - Download: https://visualstudio.microsoft.com/downloads/
   - Install "Desktop development with C++" workload

3. **Try installing in a new terminal:**
   - Close all PowerShell windows
   - Open a fresh PowerShell as Administrator
   - Navigate to project and try again

## After Rust Installation

Once Rust is installed, install all dependencies:

```powershell
cd polkasec-backend
venv\Scripts\activate
pip install -r requirements.txt
```

This should now work without errors!

