pragma solidity ^0.4.7;
import "./PatientRecord.sol";


contract Patient{
	address private uid;//patient's ethereum address
	PatientRecord private lastRecord;

	//immutable patient information

	//date (and preferably time) of birth
	//in the UNIX format
	int32 dateTimeOfBirth;

	//sex of the patient, true if female, false if male
	bool sex;
}
