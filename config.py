from pydantic_settings import BaseSettings
from pydantic import ConfigDict

class Settings(BaseSettings):
    # Database - CHANGED TO SQLITE
    POSTGRES_URL: str = "sqlite:///./polkasec.db"
    
    # Blockchain RPC
    POLKADOT_RPC: str = "wss://rpc.polkadot.io"
    ASSETHUB_RPC: str = "wss://polkadot-asset-hub-rpc.polkadot.io"
    HYDRATION_RPC: str = "wss://rpc.hydradx.cloud"
    
    # Thresholds
    LARGE_TRANSFER_THRESHOLD: int = 10000
    FAILED_TX_THRESHOLD: int = 50
    
    # Server
    HOST: str = "0.0.0.0"
    PORT: int = 8000
    
    model_config = ConfigDict(
        env_file=".env",
        extra="ignore"
    )

settings = Settings()
