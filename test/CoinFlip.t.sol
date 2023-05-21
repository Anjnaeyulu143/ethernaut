// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/CoinFlip.sol";
import "../src/Attacks/CoinflipAttack.sol";


contract CoinFlipTest is Test {
    CoinFlip coinflip;
    AttackCoinflip attackCoinFlip;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");

    address coinFlipAddr;

    function setUp() public {
        vm.prank(deployer);
        coinflip = new CoinFlip();

        coinFlipAddr = address(coinflip);
    }

    function test_flip() public {

        vm.prank(attacker);
        attackCoinFlip = new AttackCoinflip(coinFlipAddr);

        for(uint8 i=1; i <= 10;) {
            vm.prank(attacker);
            attackCoinFlip.attackCoinflip();
            vm.roll(block.number+1);
            unchecked {
                ++i;
            }

            console.log("consecutive wins: ",coinflip.consecutiveWins());
        }
    }
}