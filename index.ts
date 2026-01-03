import http from "http";
import { ethers } from "ethers";

const PORT = process.env.PORT || 4000;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS || "";

// RPC Provider
const provider = new ethers.JsonRpcProvider(
  process.env.SEPOLIA_RPC_URL || "https://sepolia.infura.io/v3/"
);

const server = http.createServer(async (req, res) => {
  res.writeHead(200, { "Content-Type": "application/json" });
  
  const response = {
    status: "ok",
    message: "PolkaSec Backend - Blockchain Anti-Counterfeiting System",
    blockchain: {
      network: "Sepolia",
      contractAddress: CONTRACT_ADDRESS,
    },
    endpoints: {
      verify: "/api/verify/:productId",
      register: "/api/register",
      check: "/api/health",
    },
    timestamp: new Date().toISOString(),
  };
  
  res.end(JSON.stringify(response, null, 2));
});

server.listen(PORT, () => {
  console.log(`✅ PolkaSec Backend running on http://localhost:${PORT}`);
  console.log(`🔗 Connected to Sepolia: ${process.env.SEPOLIA_RPC_URL}`);
  console.log(`📝 Smart Contract: ${CONTRACT_ADDRESS}`);
});
