pragma solidity ^0.6.0;

contract Variables{

    uint256 public myUint;
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    bool public myBool;
    function setMyBool(bool mBool) public{
        myBool = mBool;
    }

    string public myString;
    function setMyString(string memory mString) public{
        myString = mString;
    }

    uint8 public myUint8; // Wrapping Around : 0 - 255
    function incrementUint() public{
        myUint8++;
    }
    function decrementUint() public{
        myUint8--;
    }

    address public mAddress;
    function setAddress(address addr) public{
        mAddress = addr;
    }

    function getBalance() public view returns(uint){
        return mAddress.balance;
    }
}