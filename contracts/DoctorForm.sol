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
	address patient;

	string private historyOfPresentingIllness;
	string private generalExamination;
	string private systemicExamination;
	string private preliminaryDiagnosis;
	string private FinalDiagnosis;
	bool private conscious;
	bool private cooperative;
	bool private oriented;
	int64 recallDate;//date of recall in UNIX time

	//IPFS Files Hash
	int256[] ipfsHashes;

	function DoctorForm(address doctorAddress, address past, address patientAddress){
		primaryOwner = doctorAddress;
		pastDoctorForm = past;
		patient = patientAddress;
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

	function setFinalDiagnosis(string _fd) onlyowner{
		FinalDiagnosis = _fd;
	}

	function getFinalDiagnosis() onlyowner returns (string fd){
		fd = FinalDiagnosis;
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

	function addIPFSHash(int256 hash){
		ipfsHashes.push(hash);
	}

	function getIPFSHashes(int256[] hashes){
		hashes = ipfsHashes;
	}
}
