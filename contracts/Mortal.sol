pragma solidity ^0.4.7;

import "./JointlyOwned.sol";

contract Mortal is JointlyOwned {
    function kill() onlyowner{
    	selfdestruct(primaryOwner);
    }
}
