// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Attacks/ForceAttack.sol";
import "../src/Force/Force.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";


contract ForceTest is Test {
    Force force;
    ForceAttack forceAttack;
    
    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");

    function setUp() public {
        vm.deal(attacker,1 ether);
        vm.startPrank(deployer);
        force = new Force();
        vm.stopPrank(); 
    }

    function testExpliot() public {
        assertEq(address(force).balance,0);
        console.log("before balance of the force: ",address(force).balance);
        vm.startPrank(attacker);
        forceAttack = new ForceAttack{value:1 ether}();

        forceAttack.Attack(address(force));
        vm.stopPrank();
        console.log("after balance of the force contract: ", address(force).balance);
        assertGt(address(force).balance,0);

        
    }


}