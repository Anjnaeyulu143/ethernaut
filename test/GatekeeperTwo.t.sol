// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Attacks/GateKeeperAttackTwo.sol";
import "../src/GateKeeperTwo.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo gatekeeperTwo;
    GatekeeperTwoAttack gatekeeperTwoAttack;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");

    function setUp() public {
        vm.prank(deployer);
        gatekeeperTwo = new GatekeeperTwo();
    }

    function test_exploit() public {

        console.log("Before exploit: ",gatekeeperTwo.entrant());

        vm.prank(attacker,attacker);
        gatekeeperTwoAttack = new GatekeeperTwoAttack(address(gatekeeperTwo));

        console.log("Address of the Attacker: ",attacker);
        console.log("After exploit: ",gatekeeperTwo.entrant());
    }
}