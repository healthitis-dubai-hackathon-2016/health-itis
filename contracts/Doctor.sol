pragma solidity ^0.4.7;
import "./Patient.sol";
import "./DoctorForm.sol";
import "./PatientForm.sol";
import "./Medicine.sol";


contract Doctor{

	struct patientData{
		Patient patient;
		PatientForm pForm;
		DoctorForm dForm;
	}

	patientData[] private patients;

	function takeOwnership(DoctorForm form){
		address previous = form.getPastDoctorForm();
		if(previous!=0){
			form.ownedSecondary();
			takeOwnership(DoctorForm(previous));
		}
	}

	function addPatient(Patient p, PatientForm pf, address lastDoctorForm){
		patients.length++;
		patients[patients.length-1].patient= p;
		patients[patients.length-1].pForm = pf;
		patients[patients.length-1].dForm = new DoctorForm(lastDoctorForm);
		takeOwnership(patients[patients.length].dForm);
	}


}
