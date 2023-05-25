// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Attacks/ElevatorAttack.sol";
import "../src/Elevator.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ElevatorTest is Test{
    Elevator elevator;
    ElevatorAttack elevatorAttack;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");

    function setUp() public {
        vm.prank(deployer);
        elevator = new Elevator();
    }

    function test_exploit() public {
        vm.startPrank(attacker);
        elevatorAttack = new ElevatorAttack(address(elevator));
        elevatorAttack.Attack(1);
        vm.stopPrank();

        assertEq(elevator.top(),true);

    }
}

