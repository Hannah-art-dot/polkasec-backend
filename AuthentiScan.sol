// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title AuthentiScan
 * @dev Main contract for product authentication and manufacturer verification
 */
contract AuthentiScan is Ownable, ReentrancyGuard {
    
    // Manufacturer structure
    struct Manufacturer {
        address walletAddress;
        string name;
        bool isVerified;
        uint256 registrationDate;
        uint256 votes;
    }
    
    // Product structure
    struct Product {
        string productId;
        address manufacturer;
        string name;
        string description;
        bytes32 productHash;
        uint256 registrationDate;
        bool isActive;
    }
    
    // State variables
    mapping(address => Manufacturer) public manufacturers;
    mapping(string => Product) public products;
    mapping(address => bool) public trustedEntities;
    mapping(address => mapping(address => bool)) public hasVoted;
    
    uint256 public constant VERIFICATION_THRESHOLD = 51;
    address[] public trustedEntityList;
    
    // Events
    event ManufacturerRegistered(address indexed manufacturer, string name);
    event ManufacturerVerified(address indexed manufacturer);
    event ProductRegistered(string indexed productId, address indexed manufacturer);
    event ProductVerified(string indexed productId, bool isAuthentic);
    event VoteCasted(address indexed trustedEntity, address indexed manufacturer);
    
    // Modifiers
    modifier onlyVerifiedManufacturer() {
        require(manufacturers[msg.sender].isVerified, "Manufacturer not verified");
        _;
    }
    
    modifier onlyTrustedEntity() {
        require(trustedEntities[msg.sender], "Not a trusted entity");
        _;
    }
    
    // Register a new manufacturer
    function registerManufacturer(string memory _name) external {
        require(manufacturers[msg.sender].walletAddress == address(0), "Already registered");
        require(bytes(_name).length > 0, "Name cannot be empty");
        
        manufacturers[msg.sender] = Manufacturer({
            walletAddress: msg.sender,
            name: _name,
            isVerified: false,
            registrationDate: block.timestamp,
            votes: 0
        });
        
        emit ManufacturerRegistered(msg.sender, _name);
    }
    
    // Vote for manufacturer verification
    function voteForManufacturer(address _manufacturer) external onlyTrustedEntity nonReentrant {
        require(!hasVoted[msg.sender][_manufacturer], "Already voted");
        require(manufacturers[_manufacturer].walletAddress != address(0), "Manufacturer not found");
        require(!manufacturers[_manufacturer].isVerified, "Already verified");
        
        hasVoted[msg.sender][_manufacturer] = true;
        manufacturers[_manufacturer].votes++;
        
        uint256 requiredVotes = (trustedEntityList.length * VERIFICATION_THRESHOLD / 100) + 1;
        if (manufacturers[_manufacturer].votes >= requiredVotes) {
            manufacturers[_manufacturer].isVerified = true;
            emit ManufacturerVerified(_manufacturer);
        }
        
        emit VoteCasted(msg.sender, _manufacturer);
    }
    
    // Register a product
    function registerProduct(
        string memory _productId,
        string memory _name,
        string memory _description,
        bytes32 _productHash
    ) external onlyVerifiedManufacturer nonReentrant {
        require(bytes(_productId).length > 0, "Product ID cannot be empty");
        require(bytes(products[_productId].productId).length == 0, "Product already exists");
        require(_productHash != bytes32(0), "Invalid product hash");
        
        products[_productId] = Product({
            productId: _productId,
            manufacturer: msg.sender,
            name: _name,
            description: _description,
            productHash: _productHash,
            registrationDate: block.timestamp,
            isActive: true
        });
        
        emit ProductRegistered(_productId, msg.sender);
    }
    
    // Verify if product is authentic
    function verifyProduct(string memory _productId) external view returns (bool) {
        Product memory product = products[_productId];
        require(bytes(product.productId).length > 0, "Product not found");
        return product.isActive && manufacturers[product.manufacturer].isVerified;
    }
    
    // Get product details
    function getProductDetails(string memory _productId) 
        external 
        view 
        returns (Product memory) 
    {
        require(bytes(products[_productId].productId).length > 0, "Product not found");
        return products[_productId];
    }
    
    // Add trusted entity (owner only)
    function addTrustedEntity(address _entity) external onlyOwner {
        require(_entity != address(0), "Invalid address");
        require(!trustedEntities[_entity], "Already a trusted entity");
        
        trustedEntities[_entity] = true;
        trustedEntityList.push(_entity);
    }
    
    // Deactivate product
    function deactivateProduct(string memory _productId) external onlyVerifiedManufacturer {
        require(products[_productId].manufacturer == msg.sender, "Not product owner");
        products[_productId].isActive = false;
    }
}
