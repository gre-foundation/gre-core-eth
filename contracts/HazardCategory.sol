pragma solidity ^0.4.17;

/// @title HazardCategory contract - Provide All Hazard Category available in GRE
/// @author William - <william@gre-foundation.org>
contract HazardCategory {
    
    /*
     *  Storage
     */
    address public creator;
    uint[256] public categories;
    mapping (uint8 => uint[256]) public subCategories;

    /*
     *  Modifiers
     */
    modifier isCreator() {
        // Only creator is allowed to proceed
        require(msg.sender == creator);
        _;
    }

    /*
     *  Public functions
     */
    /// @dev Contract constructor
    function HazardCategory() public {
        creator = msg.sender;
    }

    /// @dev Sets Category at the specified position
    /// @param categoryId The specified position
    /// @param code Category Code
    /// @return position If success,returns the position that been set,else returns -1
    function setCategory(uint8 categoryId,uint code) public returns (uint8){
        require(categoryId >= 0 && categoryId <= 255);

        categories[categoryId] = code;

        return categoryId;
    }

    /// @dev Get all categories at one time
    /// @return categories All categories available in GRE
    function getCategories() public view returns (uint[256]) {
        return categories;
    }

    function setSubCategory(uint8 categoryId, uint8 subCategoryId, uint code) public returns (uint8 cid, uint8 scid) {
        require(categoryId >= 0 && categoryId <= 255);
        require(subCategoryId >= 0 && subCategoryId <= 255);

        subCategories[categoryId][subCategoryId] = code;

        cid = categoryId;
        scid = subCategoryId;
    }

    function setSubCategory(uint8 categoryId, uint[256] codeList) public returns (uint) {
        require(categoryId >= 0 && categoryId <= 255);
        
        subCategories[categoryId] = codeList;

        return 1; 
    }

    function getSubCategories(uint8 categoryId) public view returns (uint[256]) {
        return subCategories[categoryId];
    }
}