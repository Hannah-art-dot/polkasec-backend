import { expect } from "chai";
import { ethers } from "hardhat";
import { AuthentiScan } from "../typechain-types";

describe("AuthentiScan", function () {
  let authentiscan: AuthentiScan;
  let owner: any;
  let manufacturer: any;
  let trusted: any;

  beforeEach(async function () {
    [owner, manufacturer, trusted] = await ethers.getSigners();
    const AuthentiScan = await ethers.getContractFactory("AuthentiScan");
    authentiscan = await AuthentiScan.deploy();
    await authentiscan.waitForDeployment();
  });

  it("Should register a manufacturer", async function () {
    await authentiscan.connect(manufacturer).registerManufacturer("TestMfg");
    const mfg = await authentiscan.manufacturers(manufacturer.address);
    expect(mfg.name).to.equal("TestMfg");
  });

  it("Should register a product", async function () {
    // First verify manufacturer
    await authentiscan.addTrustedEntity(trusted.address);
    await authentiscan.connect(manufacturer).registerManufacturer("TestMfg");
    await authentiscan.connect(trusted).voteForManufacturer(manufacturer.address);
    
    // Register product
    const productHash = ethers.id("test-product");
    await authentiscan.connect(manufacturer).registerProduct(
      "prod123",
      "Test Product",
      "A test product",
      productHash
    );
    
    const product = await authentiscan.products("prod123");
    expect(product.name).to.equal("Test Product");
  });

  it("Should verify authentic product", async function () {
    await authentiscan.addTrustedEntity(trusted.address);
    await authentiscan.connect(manufacturer).registerManufacturer("TestMfg");
    await authentiscan.connect(trusted).voteForManufacturer(manufacturer.address);
    
    const productHash = ethers.id("test-product");
    await authentiscan.connect(manufacturer).registerProduct(
      "prod456",
      "Authentic Product",
      "A genuine product",
      productHash
    );
    
    const isAuthentic = await authentiscan.verifyProduct("prod456");
    expect(isAuthentic).to.be.true;
  });
});
