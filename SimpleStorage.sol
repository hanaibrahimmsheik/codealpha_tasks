// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20; //compiler version to use

//A simple contract that stores one number
contract SimpleStorage {

//Stores the number. "public" lets evryone read it from outside.
    int256 public value;

//Increase the stored number by 1
    function increment() public {
        value += 1;
    }

//Decreases the stored number by 1
    function decrement() public {
        value -= 1;
    }
}
