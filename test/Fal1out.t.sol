// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Fal1out.sol";

contract Fal1outTest is Test {
    Fallout fal1out;
    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");


    function setUp() public {
        vm.startPrank(deployer);
        fal1out = new Fallout();
        fal1out.Fal1out();
        vm.stopPrank();
    }

    function test_Owner() public {
        console.log("deployer of the contract: ",fal1out.owner());
        vm.prank(attacker);
        fal1out.Fal1out();

        console.log("attacker address is now owner: ", fal1out.owner());
    }
}