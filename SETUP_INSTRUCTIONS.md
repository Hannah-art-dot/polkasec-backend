# PolkaSEC Backend - Setup Instructions

## Manual Setup Steps

### Step 1: Create .env File

Since `.env.example` may be blocked, create a `.env` file manually in the `polkasec-backend` directory with the following content:

```
POSTGRES_URL=postgresql://polkasec:securepass@localhost:5432/polkasec
POLKADOT_RPC=wss://rpc.polkadot.io
ASSETHUB_RPC=wss://polkadot-asset-hub-rpc.polkadot.io
HYDRATION_RPC=wss://rpc.hydradx.cloud
LARGE_TRANSFER_THRESHOLD=10000
HOST=0.0.0.0
PORT=8000
```

**IMPORTANT:** Update the `POSTGRES_URL` with your actual PostgreSQL credentials:
- Replace `polkasec` with your database username
- Replace `securepass` with your database password
- Replace `localhost:5432` with your PostgreSQL host and port if different
- Replace `polkasec` (database name) with your desired database name

### Step 2: Install PostgreSQL (if not already installed)

**Windows:**
1. Download PostgreSQL from https://www.postgresql.org/download/windows/
2. Install PostgreSQL 15 or higher
3. During installation, remember the password you set for the `postgres` user
4. Create a new database:
   ```sql
   CREATE DATABASE polkasec;
   CREATE USER polkasec WITH PASSWORD 'securepass';
   GRANT ALL PRIVILEGES ON DATABASE polkasec TO polkasec;
   ```

**Linux/Mac:**
```bash
sudo apt-get install postgresql postgresql-contrib  # Ubuntu/Debian
# or
brew install postgresql  # Mac

# Create database
sudo -u postgres psql
CREATE DATABASE polkasec;
CREATE USER polkasec WITH PASSWORD 'securepass';
GRANT ALL PRIVILEGES ON DATABASE polkasec TO polkasec;
\q
```

### Step 3: Setup Python Environment

**Windows:**
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

### Step 4: Run the Application

**Windows:**
```powershell
python main.py
```

**Linux/Mac:**
```bash
python main.py
```

The server will start on `http://localhost:8000`

### Step 5: Verify Installation

1. Check health endpoint:
   ```bash
   curl http://localhost:8000/health
   ```

2. Test demo alert:
   ```bash
   curl -X POST http://localhost:8000/api/demo/simulate-attack
   ```

3. Get alerts:
   ```bash
   curl http://localhost:8000/api/alerts
   ```

4. View API documentation:
   Open browser to: `http://localhost:8000/docs`

## Troubleshooting

### PostgreSQL Connection Error
- Verify PostgreSQL is running: `pg_isready` or check Windows Services
- Verify credentials in `.env` file
- Check if PostgreSQL is listening on the correct port (default: 5432)

### Module Import Errors
- Ensure virtual environment is activated
- Reinstall dependencies: `pip install -r requirements.txt --force-reinstall`

### WebSocket Connection Issues
- Ensure RPC endpoints are accessible
- Check firewall settings
- Verify RPC URLs in `.env` file

## Project Structure

```
polkasec-backend/
├── main.py                 # FastAPI application entry point
├── config.py               # Configuration settings
├── requirements.txt        # Python dependencies
├── .env                    # Environment variables (create manually)
├── models/                 # Pydantic models
├── database/               # Database models and CRUD operations
├── blockchain/            # Polkadot blockchain client and monitoring
├── detection/             # Threat detection rules and alerting
└── api/                   # REST API routes and WebSocket handlers
```

