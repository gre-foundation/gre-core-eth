pragma solidity ^0.4.17;

/// @title HazardCategory contract - Provide All Hazard Category available in GRE
/// @author William - <william@gre-foundation.org>
contract HazardCategory {
    
    /*
     *  Storage
     */
    address public creator;
    uint[256] public categories;
    mapping (uint => uint[256]) subCategories;
    
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
    /// @param code Category Code
    /// @return position If success,returns the position that been set,else returns -1
    function setCategory(uint8 position,uint code) public returns (uint8){
        require(position >= 0 && position <= 255);

        categories[position] = code;

        return position;
    }

    /// @dev Get all categories at one time
    /// @param categories All categories available in GRE
    function getCategories() public view returns (uint[256]) {
        return categories;
    }
}