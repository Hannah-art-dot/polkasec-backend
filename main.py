from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from api.routes import router
from api.websocket import websocket_endpoint
from database import init_db
from blockchain.monitor import start_monitoring
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    logger.info("🚀 Starting PolkaSEC Backend...")
    init_db()
    logger.info("✅ Database initialized")
    await start_monitoring()
    logger.info("✅ Blockchain monitoring started")
    yield
    # Shutdown
    logger.info("🛑 Shutting down...")


app = FastAPI(title="PolkaSEC API", version="1.0.0", lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router)
app.add_websocket_route("/ws/alerts", websocket_endpoint)


@app.get("/")
async def root():
    return {
        "name": "PolkaSEC API",
        "version": "1.0.0",
        "status": "running"
    }


@app.get("/health")
async def health_check():
    return {"status": "healthy"}


if __name__ == "__main__":
    import uvicorn
    from config import settings
    uvicorn.run(app, host=settings.HOST, port=settings.PORT)

