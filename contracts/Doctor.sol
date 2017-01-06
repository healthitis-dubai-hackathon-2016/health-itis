pragma solidity ^0.4.7;
import "./Patient.sol";
import "./DoctorForm.sol";
import "./PatientForm.sol";
import "./Medicine.sol";
import "./PatientDatabase.sol";


contract Doctor{

	address private uid;//doctors's ethereum address
	DoctorForm private lastDoctorForm;

	struct patientData{
		Patient patient;
		PatientForm pForm;
		DoctorForm dForm;
		bool isActive;
	}

	patientData[] private patients;

	function Doctor(address _uid) {
		uid = _uid;
	}

	function takeOwnership(DoctorForm form){
		address previous = form.getPastDoctorForm();
		if(previous!=0){
			form.ownedSecondary();
			takeOwnership(DoctorForm(previous));
		}
	}

	function getPatientData(uint index) returns (address uid, int64 dateTimeOfBirth,
		bool sex, address patientForm, address doctorForm, bool active){

		patientData data = patients[index];
		uid = data.patient.getPatientUID();
		dateTimeOfBirth = data.patient.getPatientDateTimeOfBirth();
		sex = data.patient.getPatientSex();

		patientForm = data.pForm;
		doctorForm = data.dForm;

		active = data.isActive;
	}

	function makePatientInactive(uint index) {
		if(address(patients[index].dForm) != 0){
			patients[index].isActive = false;
		}
	}

	function fillDoctorForm(address patientAddress, string historyOfPresentingIllness,
		string generalExamination, string systemicExamination, string preliminaryDiagnosis,
		string finalDiagnosis, bool conscious, bool cooperative, bool oriented,
		int64 recallDate){

			Patient p = new PatientDatabase().getPatientFromUID(patientAddress);

			patients.length++;
			patients[patients.length-1].patient= p;
			patients[patients.length-1].pForm = p.getLastFilledForm();
			patients[patients.length-1].isActive = true;

			DoctorForm form = new DoctorForm(uid, lastDoctorForm, patientAddress);
			form.setHistoryOfPresentingIllness(historyOfPresentingIllness);
			form.setGeneralExamination(generalExamination);
			form.setSystemicExamination(systemicExamination);
			form.setPreliminaryDiagnosis(preliminaryDiagnosis);
			form.setFinalDiagnosis(finalDiagnosis);
			form.setConsciousCooperativeOriented(conscious, cooperative, oriented);

			lastDoctorForm = form;
			patients[patients.length-1].dForm = form;
			takeOwnership(patients[patients.length].dForm);

	}


}
