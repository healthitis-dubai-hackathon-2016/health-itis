pragma solidity ^0.4.7;
import "./Patient.sol";
import "./StringUtils.sol";
//behaves as a singleton
//deploy once, and enter that address to access
contract PatientDatabase{
	//maps the ethereum address of the user to the passcode that is saved
	mapping (address => string) private patientPasscodes;

	//maps the ethereum address of the user to their 'Patient' instance
	mapping (address => Patient) private patients;

	function checkPatientAddressExistence(address addr)
	 returns (bool exists){
		exists = (address(patients[addr]) != 0);
	}

	function getPatientFromUID(address uid) returns (Patient) {
		return patients[uid];
	}

	//adds a patient to the database
	function addPatient(address userAddress, string passcode, int64 dateTimeOfBirth, bool sex){
		if(!checkPatientAddressExistence(userAddress)){
			patientPasscodes[userAddress] = passcode;
			Patient patient = new Patient(userAddress, dateTimeOfBirth, sex);
			patients[userAddress] = patient;
		}
	}

	//Authenticates a patient based on userId and password
	function authenticatePatient(address userEthAddress, string passcode)
	 returns (bool isAuthentic){
		isAuthentic = (StringUtils.equal(patientPasscodes[userEthAddress],passcode))
						&&(address(patients[userEthAddress])!=0);
	}

	//updates patient's password
	function updatePatientPasscode(address userEthAddress,
	 string oldPasscode, string newPasscode){
		if(authenticatePatient(userEthAddress, oldPasscode)){
			patientPasscodes[userEthAddress] = newPasscode;
		}
	}

}
