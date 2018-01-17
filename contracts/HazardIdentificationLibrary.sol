pragma solidity ^0.4.17;
import "./HazardIdentification.sol";

/// @title HazardIdentificationLibrary contract - Provide All Hazard Category available in GRE
/// @author William - <william@gre-foundation.org>
contract HazardIdentificationLibrary {

    /*
     *  Storage
     */
    address public creator;
    mapping (bytes32 => HazardIdentification) public hazardIdentifications;

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
    function HazardIdentificationLibrary() public {
        creator = msg.sender;
    }
}