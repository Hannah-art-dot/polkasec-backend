@echo off
REM Setup script for PolkaSEC Backend (Windows)

echo Setting up PolkaSEC Backend...

REM Create virtual environment
python -m venv venv

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Install dependencies
pip install -r requirements.txt

REM Create .env file from example
if not exist .env (
    copy .env.example .env
    echo Created .env file from .env.example
)

echo.
echo Setup complete!
echo.
echo Next steps:
echo 1. Update .env with your PostgreSQL credentials
echo 2. Run: python main.py
echo.

pause

