// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Delegation/Delegation.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract DelegationTest is Test {
    Delegate delegate;
    Delegation delegation;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");


    function setUp() public {
        vm.startPrank(deployer);
        delegate = new Delegate(deployer);
        delegation = new Delegation(address(delegate));
        vm.stopPrank();
    }

    function testExpliot() public {
        assertEq(delegation.owner(),deployer);
    }
}