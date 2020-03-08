pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract LibrariesExample{

    using SafeMath for uint;

    mapping(address => uint) public tokenBalance;

    constructor() public{
        tokenBalance[msg.sender] = 1;
    }

    function sendToken(address to, uint amount) public returns(bool){
        tokenBalance[msg.sender] = tokenBalance[msg.sender].sub(amount);
        tokenBalance[to] = tokenBalance[to].add(amount);
        return true;
    }
}