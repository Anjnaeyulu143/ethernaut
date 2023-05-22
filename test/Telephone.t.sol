// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Attacks/TelephoneAttack.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract TelephoneTest is Test {
    Telephone telephone;    
    AttackTelephone attackTelephone;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");

    function setUp() public {
        vm.prank(deployer);
        telephone = new Telephone();
    }

    function testFail_ChangeOwner() public {
        vm.startPrank(attacker,attacker);
        telephone.changeOwner(attacker);
        vm.stopPrank();

        assertEq(telephone.owner(),attacker);
    }

    function test_ChangeOwner() public {
        vm.startPrank(attacker,attacker);
        attackTelephone = new AttackTelephone(address(telephone));
        attackTelephone.Attacktelephone();
        vm.stopPrank();

        assertEq(telephone.owner(),attacker);

    }
}