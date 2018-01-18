pragma solidity ^0.4.17;

/// @title Abstract oracle contract
/// @author William - <william@gre-foundation.org>
contract Oracle {
    function isResultSet() public constant returns (bool);
    function getResult() public constant returns (int);
}