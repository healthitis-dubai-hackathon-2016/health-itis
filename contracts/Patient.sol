pragma solidity ^0.4.7;
import "./PatientForm.sol";
import "./DoctorForm.sol";
import "./DualList.sol";
import "./StringUtils.sol";


contract Patient{
	using DualList for DualList.list;
	address private uid;//patient's ethereum address
	PatientForm private lastFilledForm;
	DoctorForm private lastDoctorsForm;
	//immutable patient information

	//date (and preferably time) of birth
	//in the UNIX format
	int32 dateTimeOfBirth;

	//sex of the patient, true if female, false if male
	bool sex;

	//List of medical conditions
	DualList.list medicalConditions;
	//List of allergies
	DualList.list allergies;

	function makeConditionInactive(uint index){
		medicalConditions.toggleActive(index);
	}

	// function getMedicalConditions()
	//  returns (string[] conditionNames, bool[] conditionStatuses){
	// 	uint i;
	// 	string[] cn;
	// 	bool[]cs;
	// 	for(i = 0; i<medicalConditions.length; i++){
	// 		cn[i] = medicalConditions.valueAt(i);
	// 		cs[i] = medicalConditions.statusAt(i);
	// 	}
	// 	conditionNames = cn;
	// 	conditionStatuses = cs;
	// }

	// Since we cannot pass array we use string seperated with ';'
	// and then we can process later
	function getAllergies() returns (string allergy){
		uint i;
		for(i = 0; i<allergies.length; i++){
			allergy = StringUtils.strConcat(allergy, ";", allergies.valueAt(i));
		}
		return allergy;
	}

	// Since we cannot pass array we use string seperated with ';'
	// and then we can process later
	function getActiveMedicalConditions() returns (string conditions){
		uint i;
		for(i = medicalConditions.firstActive();
			medicalConditions.hasNextActive(i);
			i = medicalConditions.nextActive(i)){
				conditions = StringUtils.strConcat(conditions, ";", medicalConditions.valueAt(i));
		}
		return conditions;
	}

	function addMedicalCondition(string condition, bool active){
		medicalConditions.insert(condition, active);
	}
	function addAllergy(string allergy){
		allergies.insert(allergy, true);
	}
}
