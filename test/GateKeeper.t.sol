// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Attacks/GateKeeperAttackOne.sol";
import "../src/GateKeeperOne.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract GateKeeperOneTest is Test {
    GatekeeperOne gatekeeperOne;
    GatekeeperOneAttack gatekeeperOneAttack;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");

    function setUp() external {
        vm.prank(deployer);
        gatekeeperOne = new GatekeeperOne();
    }

    function test_exploit() external {

        console.log("Before exploit: ", gatekeeperOne.entrant());

        vm.startPrank(attacker,attacker);
        gatekeeperOneAttack = new GatekeeperOneAttack();
        gatekeeperOneAttack.Attack(address(gatekeeperOne));
        vm.stopPrank();

        console.log("After exploit: ",gatekeeperOne.entrant());
    }
}