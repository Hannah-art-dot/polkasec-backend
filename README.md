# PolkaSEC Backend

Security Operations Center for Polkadot blockchain monitoring.

## Quick Start

### Prerequisites
- Python 3.11+
- PostgreSQL 15+

### Installation

1. Clone and setup:
```bash
chmod +x setup.sh
./setup.sh
```

2. Configure database:
```bash
Edit .env with your PostgreSQL URL
nano .env
```

3. Run:
```bash
source venv/bin/activate
python main.py
```

Server runs on http://localhost:8000

## API Endpoints

- `GET /api/alerts` - List alerts
- `GET /api/alerts/{id}` - Get alert details
- `GET /api/alerts/stats` - Alert statistics
- `GET /api/chains` - Chain status
- `POST /api/demo/simulate-attack` - Demo mode
- `WS /ws/alerts` - Real-time alerts

## Testing

Simulate attack:
```bash
curl -X POST http://localhost:8000/api/demo/simulate-attack
```

Get alerts:
```bash
curl http://localhost:8000/api/alerts
```

