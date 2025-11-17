#!/bin/bash
# Setup script for PolkaSEC Backend

echo "Setting up PolkaSEC Backend..."

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Copy env file
cp .env.example .env

echo "✅ Setup complete!"
echo "Next steps:"
echo "1. Update .env with your PostgreSQL credentials"
echo "2. Run: python main.py"

