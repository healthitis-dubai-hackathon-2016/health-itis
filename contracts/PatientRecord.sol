pragma solidity ^0.4.7;
import "./JointlyOwned.sol";
contract PatientRecord is JointlyOwned{
	address private previousRecord;
	function PatientRecord(address patientAddress, address prevRec){
		primaryOwner = patientAddress;
		previousRecord = prevRec;
	}

	//patient's history record data goes here
	//types to be determined


	// type1 field1;
	// type2 field2;
	// type3 field3;
	// ...

	function getPreviousRecord() onlyowner returns (PatientRecord previous){
		previous = PatientRecord(previousRecord);	
	}

	//TODO: write function after types in the record have been determined
	// function getRecordData() returns (type1 f1, type2 f2, type3 f3){
	// 	rec1 = field1;
	// 	rec2 = field2;
	// 	rec3 = field3;
	// }
}
