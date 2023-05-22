// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/King.sol";
import "../src/Attacks/KingAttack.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract kingTest is Test {
    King king;
    AttackKing attackKing;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");
    address user = makeAddr("user");

    uint256 constant DEPLOYER_ETHER = 1 ether;
    uint256 constant ATTACKER_ETHER = 2 ether;
    uint256 constant USER_ETHER = 3 ether;

    function setUp() public {
        vm.deal(deployer, 5 ether);
        vm.deal(attacker, 5 ether);
        vm.deal(user, 5 ether);

        vm.startPrank(deployer);
        king = new King{value:DEPLOYER_ETHER}();
        vm.stopPrank();
    }

    function testExpliot() public {
        assertEq(address(king).balance,DEPLOYER_ETHER);

        vm.startPrank(attacker);
        attackKing = new AttackKing{value:ATTACKER_ETHER}(address(king));
        vm.stopPrank();

        vm.prank(user);
        vm.expectRevert();
        (bool success,) = address(king).call{value:USER_ETHER}("");
        require(success,"transaction failed");
    }

}