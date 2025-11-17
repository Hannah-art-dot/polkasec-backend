# 🚀 PolkaSEC Backend - Quick Start Guide

## ✅ What's Already Done

All code files have been created and are ready to use! The complete backend structure is in place.

## 📋 Manual Steps You Need to Do

### 1. CREATE .env FILE (REQUIRED)

**You MUST create this file manually** - it was blocked from automatic creation.

**Location:** `polkasec-backend/.env`

**Content to copy:**
```
POSTGRES_URL=postgresql://polkasec:securepass@localhost:5432/polkasec
POLKADOT_RPC=wss://rpc.polkadot.io
ASSETHUB_RPC=wss://polkadot-asset-hub-rpc.polkadot.io
HYDRATION_RPC=wss://rpc.hydradx.cloud
LARGE_TRANSFER_THRESHOLD=10000
HOST=0.0.0.0
PORT=8000
```

**⚠️ IMPORTANT:** 
- Replace `polkasec:securepass` with your actual PostgreSQL username and password
- Replace `localhost:5432` if your PostgreSQL is on a different host/port
- Replace the database name `polkasec` if you want a different name

### 2. SETUP POSTGRESQL DATABASE

**If PostgreSQL is not installed:**

**Windows:**
1. Download from: https://www.postgresql.org/download/windows/
2. Install PostgreSQL 15+
3. Open pgAdmin or psql
4. Run these SQL commands:
```sql
CREATE DATABASE polkasec;
CREATE USER polkasec WITH PASSWORD 'securepass';
GRANT ALL PRIVILEGES ON DATABASE polkasec TO polkasec;
```

**Linux/Mac:**
```bash
sudo apt-get install postgresql  # Ubuntu/Debian
# or
brew install postgresql  # Mac

sudo -u postgres psql
CREATE DATABASE polkasec;
CREATE USER polkasec WITH PASSWORD 'securepass';
GRANT ALL PRIVILEGES ON DATABASE polkasec TO polkasec;
\q
```

### 3. INSTALL PYTHON DEPENDENCIES

**Windows (PowerShell):**
```powershell
cd polkasec-backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

**Linux/Mac:**
```bash
cd polkasec-backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 4. RUN THE APPLICATION

**Windows:**
```powershell
# Make sure venv is activated
venv\Scripts\activate
python main.py
```

**Linux/Mac:**
```bash
# Make sure venv is activated
source venv/bin/activate
python main.py
```

The server will start on: **http://localhost:8000**

## 🧪 Test the API

1. **Health Check:**
   ```bash
   curl http://localhost:8000/health
   ```

2. **Generate Demo Alert:**
   ```bash
   curl -X POST http://localhost:8000/api/demo/simulate-attack
   ```

3. **Get Alerts:**
   ```bash
   curl http://localhost:8000/api/alerts
   ```

4. **View API Docs:**
   Open browser: http://localhost:8000/docs

## 📁 Project Structure

```
polkasec-backend/
├── main.py              # FastAPI app entry point
├── config.py            # Configuration
├── requirements.txt     # Dependencies
├── .env                 # ⚠️ CREATE THIS MANUALLY
├── models/              # Pydantic models
├── database/            # SQLAlchemy models & CRUD
├── blockchain/          # Polkadot client & monitoring
├── detection/           # Threat detection rules
└── api/                 # REST API & WebSocket
```

## 🔧 Troubleshooting

**PostgreSQL Connection Error:**
- Check if PostgreSQL service is running
- Verify credentials in `.env` file
- Test connection: `psql -U polkasec -d polkasec`

**Import Errors:**
- Ensure virtual environment is activated
- Reinstall: `pip install -r requirements.txt --force-reinstall`

**Port Already in Use:**
- Change `PORT` in `.env` file
- Or stop the process using port 8000

## 📚 More Information

See `SETUP_INSTRUCTIONS.md` for detailed setup guide.
See `README.md` for API documentation.

