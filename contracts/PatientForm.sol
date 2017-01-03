pragma solidity ^0.4.7;
import "./JointlyOwned.sol";
import "./Medicine.sol";
contract PatientForm is JointlyOwned{	
	/*
		The patient's form is as follows:
		ID, i.e. public key (converted to ethereum address)
		Chief complaint
		Additional medical conditions 
		(display a checkbox list of the current medical conditions they have)
		(Provide fields to add any new ones, and allow them to
		remove any existing ones by unchecking the boxes)
		Additional Allergies
	*/
	string private chiefComplaint;
	Medicine[] private selfMedicationList; 
	address private previousForm;

	function PatientForm(address patientAddress, address prevForm){
		primaryOwner = patientAddress;
		previousForm = prevForm;
	}

	function setChiefComplaint(string _chief) onlyowner{
		chiefComplaint = _chief;
	}

	function getChiefComplaint() onlyowner returns (string){
		return chiefComplaint;
	}

	function setSelfMedicationList(Medicine[] _meds) onlyowner{
		selfMedicationList = _meds;
	}

	function getSelfMedicationList() onlyowner returns (Medicine[] _meds){
		_meds = selfMedicationList;
	}

	function getPreviousForm() onlyowner returns (PatientForm previous){
		previous = PatientForm(previousForm);	
	}
}
