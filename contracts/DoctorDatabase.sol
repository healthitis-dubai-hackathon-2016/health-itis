pragma solidity ^0.4.7;
import "./Doctor.sol";
import "./StringUtils.sol";
//behaves as a singleton
//deploy once, and enter that address to access
contract DoctorDatabase{
	//maps the ethereum address of the user to the passcode that is saved
	mapping (address => string) private doctorPasscodes;

	//maps the ethereum address of the user to their 'Doctor' instance
	mapping (address => Doctor) private doctors;

	function checkDoctorAddressExistence(address addr)
	 returns (bool exists){
		exists = (address(doctors[addr]) != 0);
	}

	//adds a doctor to the database
	function addDoctor(address userAddress, string passcode){
		if(!checkDoctorAddressExistence(userAddress)){
			doctorPasscodes[userAddress] = passcode;
            Doctor doctor = new Doctor(userAddress);
            doctors[userAddress] = doctor;
		}
	}

	//Authenticates a patient based on userId and password
	function authenticateDoctor(address userEthAddress, string passcode)
	 returns (bool isAuthentic){
		isAuthentic = (StringUtils.equal(doctorPasscodes[userEthAddress],passcode))
						&&(address(doctors[userEthAddress])!=0);
	}

	//updates patient's password
	function updatePatientPasscode(address userEthAddress,
	 string oldPasscode, string newPasscode){
		if(authenticateDoctor(userEthAddress, oldPasscode)){
			doctorPasscodes[userEthAddress] = newPasscode;
		}
	}

}
