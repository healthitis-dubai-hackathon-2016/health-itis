pragma solidity ^0.4.7;
/*
	Modification of the owned contract to enable joint
	ownership by a primary (patient) and a secondary (doctor)
	owner
*/
contract JointlyOwned{
	address primaryOwner;
	address secondaryOwner;
	address memory addr;

	modifier onlyowner(){
		addr = msg.sender;
		if(addr == primaryOwner || addr == secondaryOwner){
			_;
		}
	}

	function ownedSecondary(){
		secondaryOwner = msg.sender;
	}
}