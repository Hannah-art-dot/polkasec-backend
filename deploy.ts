import { ethers } from "hardhat";

async function main() {
  console.log("🚀 Deploying AuthentiScan and ProductRegistry...");

  // Deploy AuthentiScan
  const AuthentiScan = await ethers.getContractFactory("AuthentiScan");
  const authentiscan = await AuthentiScan.deploy();
  await authentiscan.waitForDeployment();
  const authentiscanAddress = await authentiscan.getAddress();
  console.log("✅ AuthentiScan deployed to:", authentiscanAddress);

  // Deploy ProductRegistry
  const ProductRegistry = await ethers.getContractFactory("ProductRegistry");
  const productRegistry = await ProductRegistry.deploy();
  await productRegistry.waitForDeployment();
  const productRegistryAddress = await productRegistry.getAddress();
  console.log("✅ ProductRegistry deployed to:", productRegistryAddress);

  console.log("\n📝 Save these addresses for frontend configuration:");
  console.log("AuthentiScan:", authentiscanAddress);
  console.log("ProductRegistry:", productRegistryAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
