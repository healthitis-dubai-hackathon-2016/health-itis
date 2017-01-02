pragma solidity ^0.4.7;
/*
	Modification of the owned contract to enable joint
	ownership by a primary (patient) and a secondary (doctor)
	owner
*/
contract JointlyOwned{
	address primaryOwner;
	address secondaryOwner;

	modifier onlyowner(){
		if(msg.sender == primaryOwner || msg.sender == secondaryOwner){
			_;
		}else{
			throw;
		}
	}

	function ownedSecondary(){
		secondaryOwner = msg.sender;
	}
}