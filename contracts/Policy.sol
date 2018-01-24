pragma solidity ^0.4.17;
import "./Oracle/Oracle.sol";

/// @title Policy contract
/// @author William - <william@gre-foundation.org>
contract Policy {
    /*
     *  Events
     */
    event BuyPolicyComplete(address buyer,uint amount);
    event ProvideCapacityComplete(address insuer,uint amount);

    /*
     *  Storage
     */
    address public owner;
    Oracle public oracle;

    bool private isResultSet;
    int private result;
    int private exceptResult;

    uint public capacity;
    uint public currentCapacity;
    uint public premium;
    uint public coverage;

    mapping (address => uint) policyHolders;
    mapping (address => uint) insuer;

    mapping (address => uint) claimResult;


    /*
     *  Modifiers
     */
    modifier resultNotSet() {
        // result is not yet set
        require(!isResultSet);
        _;
    }

    modifier resultSet() {
        // result has already set
        require(isResultSet);
        _;
    }

    modifier isParticipant() {
        // message sender is a insuer or a policy holder
        require(insuer[msg.sender] > 0 || policyHolders[msg.sender] > 0);
        _;
    }

    
    /*
     *  Public functions
     */
    /// @dev Contract constructor 
    /// @param _oracle Oracle contract used to resolve the policy
    /// @param _premium Premium of the policy
    /// @param _coverage Coverage of the policy
    function Policy(Oracle _oracle, uint _premium, uint _coverage,int _exceptResult) public {
        // require(address(_oracle) != 0);
        // require(msg.value == _premium * _capacity);
        require(_coverage >= _premium);

        owner = msg.sender;
        oracle = _oracle;
        premium = _premium;
        coverage = _coverage;
        exceptResult = _exceptResult;
    }

    function buyPolicy(uint amount) public resultNotSet returns (bool) {
        require(amount > 0);
        require(currentCapacity >= amount);
        // require(msg.value == premium * amount);

        currentCapacity = currentCapacity - amount;
        if(policyHolders[msg.sender] > 0)
            policyHolders[msg.sender] = policyHolders[msg.sender] + amount;
        else
            policyHolders[msg.sender] = amount;
        BuyPolicyComplete(msg.sender,amount);
        return true;
    }

    function provideCapacity(uint amount) public resultNotSet returns (bool) {
        require(amount > 0);
        // require(msg.value == premium * amount);

        capacity = capacity + amount;
        currentCapacity = currentCapacity + amount;
        if(insuer[msg.sender] > 0)
            insuer[msg.sender] = insuer[msg.sender] + amount;
        else
            insuer[msg.sender] = amount;
        BuyPolicyComplete(msg.sender,amount);
        return true;
    }

    function claim() public resultNotSet isParticipant returns (bool) {
        require(oracle.isResultSet());

        isResultSet = true;
        result = oracle.getResult();

        return true;
    }

    function withdraw() public resultSet isParticipant returns (uint) {
        require(
            result == exceptResult && policyHolders[msg.sender] >0  
         || result != exceptResult && insuer[msg.sender] >0         
        );
        uint premiumAmount = 0;
        uint settlementAmount = 0;
        uint deposit = 0;
        //insuer can always get premium
        premiumAmount = insuer[msg.sender] * premium;

        //result equals to exceptResult,policy holder can get settlement
        if(result == exceptResult) { 
            settlementAmount = policyHolders[msg.sender] * coverage;
        } else {
            //insuer get their deposit back
            deposit = insuer[msg.sender] * coverage;
        }
        return premiumAmount + settlementAmount + deposit;
    }

}