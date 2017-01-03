pragma solidity ^0.4.7;
import "./JointlyOwned.sol";
/*
		History of presenting illness (doc)
		
		Self medication taken (patient)

		Additional known conditions (patient)

		Allergies (substances, drug)

		Patient is conscious, cooperative, well-oriented to time, place, person (Doctor)

		doctor's form: 
		General examination
		Systemic examination

		Preliminary Diagnosis

		Required Tests

		Final Diagnosis

		Recall date
*/
contract DoctorForm is JointlyOwned{
	address pastDoctorForm;
	string private historyOfPresentingIllness;
	string private generalExamination;
	string private systemicExamination;
	string private preliminaryDiagnosis;
	string FinalDiagnosis;
	bool private conscious;
	bool private cooperative;
	bool private oriented;
	int64 recallDate;//date of recall in UNIX time

	function DoctorForm(address past){
		pastDoctorForm = past;
	}

	function getPastDoctorForm() returns (address){
		return pastDoctorForm;
	}

	function setHistoryOfPresentingIllness(string _hopi) onlyowner{
		historyOfPresentingIllness = _hopi;
	}

	function getHistoryOfPresentingIllness() onlyowner returns (string hopi){
		hopi = historyOfPresentingIllness;
	}

	function setGeneralExamination(string _ge) onlyowner{
		generalExamination = _ge;
	}

	function getGeneralExamination() onlyowner returns (string ge){
		ge = generalExamination;
	}

	function setSystemicExamination(string _se) onlyowner{
		systemicExamination = _se;
	} 

	function getSystemicExamination() onlyowner returns (string se){
		se = systemicExamination;
	}

	function setPreliminaryDiagnosis(string _pd) onlyowner{
		preliminaryDiagnosis = _pd;
	}

	function getPreliminaryDiagnosis() onlyowner returns (string pd){
		pd = preliminaryDiagnosis;
	}

	function setConsciousCooperativeOriented(bool _c, bool _co, bool _o) onlyowner{
		conscious = _c;
		cooperative = _co;
		oriented = _o;
	}

	function getConsciousCooperativeOriented() onlyowner returns (bool c, bool co, bool o){
		c = conscious;
		co = cooperative;
		o = oriented;
	}
}