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
    /// @param position The specified position
    /// @param code Category code
    /// @return result If success,returns true,else returns false
    function setCategory(uint8 position,uint code) public returns (bool){
        require(position >= 0 && position <= 255);

        categories[position] = code;

        return true;
    }

    /// @dev Get all categories at one time
    /// @return categories All categories available in GRE
    function getCategories() public view returns (uint[256]) {
        return categories;
    }

    /// @dev Sets one SubCategory at the specified position
    /// @param categoryPosition The specified category position
    /// @param subCategoryPosition The specified sub category position
    /// @param code Sub category code
    /// @return result If success,returns true,else returns false
    function setSubCategory(uint8 categoryPosition, uint8 subCategoryPosition, uint code) public returns (bool) {
        require(categoryPosition >= 0 && categoryPosition <= 255);
        require(subCategoryPosition >= 0 && subCategoryPosition <= 255);

        subCategories[categoryPosition][subCategoryPosition] = code;
        
        return true;
    }

    /// @dev Sets the whole SubCategory at the specified position
    /// @param categoryId The specified category ID
    /// @param codeList Sub category code whole list
    /// @return result If success,returns true,else returns false
    function setSubCategory(uint8 categoryId, uint[256] codeList) public returns (bool result) {
        require(categoryId >= 0 && categoryId <= 255);
        
        subCategories[categoryId] = codeList;

        return true; 
    }

    /// @dev Get sub category list of the specified category
    /// @return sub categories All sub categories of the  available in GRE
    function getSubCategories(uint8 categoryId) public view returns (uint[256]) {
        return subCategories[categoryId];
    }
}