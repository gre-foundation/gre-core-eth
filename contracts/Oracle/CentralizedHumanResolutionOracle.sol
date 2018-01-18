pragma solidity ^0.4.17;
import "./Oracle.sol";

/// @title Centralized human resolution oracle contract
/// @author William - <william@gre-foundation.org>
contract CentralizedHumanResolutionOracle is Oracle {
    
    /*
     *  Events
     */
    event ResultSetComplete(int result);

    /*
     *  Storage
     */
    address public owner;
    bool public isResultSet;
    int public result;

    /*
     *  Modifiers
     */
    modifier isOwner() {
        // Only owner is allowed to proceed
        require(msg.sender == owner);
        _;
    }

    modifier resultNotSet() {
        // Only owner is allowed to proceed
        require(!isResultSet);
        _;
    }
    /*
     *  Public functions
     */
    /// @dev Constructor sets owner address
    function CentralizedHumanResolutionOracle(address _owner) public {
        owner = _owner;
    }

    /// @dev Changes owner
    /// @param newOwner New owner
    function changeOwner(address newOwner) public isOwner resultNotSet {
        owner = newOwner;
    }

    /// @dev Sets result
    /// @param _result The Result
    function setResult(int _result) public isOwner resultNotSet returns (bool) {
        isResultSet = true;
        result = _result;
        ResultSetComplete(result);
        return true;
    }

    function isResultSet() public constant returns (bool) {
        return isResultSet;
    }

    function getResult() public constant returns (int) {
        return result;
    }
}