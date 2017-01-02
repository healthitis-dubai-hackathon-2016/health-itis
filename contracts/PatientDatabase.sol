pragma solidity ^0.4.7;
import "./Patient.sol";
import "./StringUtils.sol";
//behaves as a singleton
//deploy once, and enter that address to access
contract PatientDatabase{
	//maps the ethereum address of the user to the passcode that is saved
	mapping (address => string) private patientPasscodes;

	//maps the ethereum address of the user to their 'Patient' instance address
	mapping (address => address) private patients;

	function checkPatientAddressExistence(address addr) 
	 returns (bool exists){
		exists = (patients[addr] != 0);
	}

	//adds a patient to the database
	function addPatient(address userAddress, string passcode){
		if(!checkPatientAddressExistence(userAddress)){
			patientPasscodes[userAddress] = passcode;
			//add code to create a new patient instance
			//add the patient instance's address to the mapping
		}
	}

	//Authenticates a patient based on userId and password
	function authenticatePatient(address userEthAddress, string passcode)
	 returns (bool isAuthentic){
		isAuthentic = (StringUtils.equal(patientPasscodes[userEthAddress],passcode))
						&&(patients[userEthAddress]!=0);
	}

	//updates patient's password
	function updatePatientPasscode(address userEthAddress,
	 string oldPasscode, string newPasscode){
		if(authenticatePatient(userEthAddress, oldPasscode)){
			patientPasscodes[userEthAddress] = newPasscode;
		}
	}
	
}
