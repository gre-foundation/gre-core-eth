pragma solidity ^0.4.17;

/// @title HazardCategory contract - Provide All Hazard Category available in GRE
/// @author William - <william@gre-foundation.org>
contract HazardIdentification {

    enum HIStatus { Init, Pending, Open, Close }

    /*
     *  Storage
     */
    address public creator;
    HIStatus public status;
    string public name;
    string public description;
    uint8 public category;
    uint8 public subCategory;
    
    //TODO:Add more state variables
    
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
    function HazardIdentification(string _name,string _description,uint8 _category,uint8 _subCategory) public {
        creator = msg.sender;
        name = _name;
        description = _description;
        category = _category;
        subCategory = _subCategory;
        status = HIStatus.Init;
    }
}