// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;


  // we need to call this function from the smart contract not from the direct EOA.
  // To bypass this modifer

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  // At execution of this modifier the gasleft is mulitiple of the 8191
  // total gas = (8192 * gas) + i(the amout of gas is used to reach till this instruction)
  // we need to use brute force approach here to bypass this modifier

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  // requirement #1 => It takes the bytes 8 _gateKey (0x A1 A2 A3 A4 A5 A6 A7 A8); 
  // First it converts bytes8 into uint64(8bytes) = bytes8 (0x A1 A2 A3 A4 A5 A6 A7 A8);
  // Then it converts uint64 into uint32(4bytes) = bytes4 (0x A5 A6 A7 A8);
  // Then it converts uint32 into uint16(2bytes) = bytes2(0x A7 A8);
  // Here A5 & A6 must be zeros;

  // requirement #2 
  // Then it converts uint64 into uint32(4bytes) = bytes4 (0x A5 A6 A7 A8); 
  // Then it converts bytes8 into uint64(8bytes) = bytes8 (0x A1 A2 A3 A4 A5 A6 A7 A8);
  // Here A1 A2 & A3 A4 must be not equal to zero

  // requirement #3
  // Then it converts uint64 into uint32(4bytes) = bytes4 (0x A5 A6 A7 A8);
  // tx.origin is EOA which is 20 bytes == uint160 and it converts into uint16 bytes2 => (0x A7 A8); 


  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}