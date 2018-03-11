
pragma solidity ^0.4.19;

import "./zombiehelper.sol";

contract randomNumber {

uint randNonce = 0;

function generate() returns (uint)
{
  uint random = uint(keccak256(now, msg.sender, randNonce)) % 100;
  randNonce++;
  return random;
}

}
