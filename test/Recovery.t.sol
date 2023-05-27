// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Recovery/SimpleToken.sol";
import "../src/Recovery/Recovery.sol";
import "../src/Recovery/RecoveryHack.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";


contract RecoveryTest is Test {
    SimpleToken simpleToken;
    Recovery recovery;
    Dev dev;

    address deployer = makeAddr("deployer");
    address user = makeAddr("user");
    address auditor = makeAddr("auditor");


    function setUp() external {
        vm.deal(user,0.002 ether);

        vm.startPrank(deployer);
        recovery = new Recovery();
        vm.stopPrank();
    }

    function test_recovery() external {
        vm.startPrank(user);
        recovery.generateToken("Anjan",100000);
        vm.stopPrank();

        vm.startPrank(auditor);
        dev = new Dev();
        (address addr) = dev.recovery(address(recovery));
        console.log("address of lost contract: ",addr);
        vm.stopPrank();

    }
}

// SimpleToken: [0x0d5C87e3905Da4B351d605a0d89953aF60eF667a
// SimpleToken@0x0d5C87e3905Da4B351d605a0d89953aF60eF667a