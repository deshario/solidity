pragma solidity ^0.6.0;

contract SomeContract{

    uint public myUint = 10;
    function setUint(uint mInt) public {
        myUint = mInt;
    }
}