// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ProductRegistry
 * @dev Registry for storing and managing product metadata
 */
contract ProductRegistry {
    
    struct ProductMetadata {
        string productId;
        string batchNumber;
        uint256 manufacturingDate;
        string location;
        bool isValidated;
    }
    
    mapping(string => ProductMetadata) public productMetadata;
    address public admin;
    
    event ProductMetadataStored(string indexed productId, string batchNumber);
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }
    
    constructor() {
        admin = msg.sender;
    }
    
    function storeProductMetadata(
        string memory _productId,
        string memory _batchNumber,
        uint256 _manufacturingDate,
        string memory _location
    ) external onlyAdmin {
        productMetadata[_productId] = ProductMetadata({
            productId: _productId,
            batchNumber: _batchNumber,
            manufacturingDate: _manufacturingDate,
            location: _location,
            isValidated: true
        });
        
        emit ProductMetadataStored(_productId, _batchNumber);
    }
    
    function getProductMetadata(string memory _productId) 
        external 
        view 
        returns (ProductMetadata memory) 
    {
        return productMetadata[_productId];
    }
}
