pragma solidity ^0.4.7;
import "./JointlyOwned.sol";
/*
	Display the medicine data in the following way:
	_______________________________________________________________________________
	|Medicine Name | 1/0-1/0-1/0  |  Frequency (days)  | Dosage (mg) |Notes        |
	|______________|_(b-l-d)______|________________________________________________|
	|med1		   | 1-0-1		  | 1 (every day)	   |50			 |Take by mouth|
	|______________|_______________________________________________________________|
	|med2		   | 0-1-0		  | 2 (alternate days) |100 		 |Dissolve in water
	|______________|______________|____________________|___________________________|
	|med3          | 0-0-0		  |	1 				   |0 (N/A)		 |Apply topically
	|____________(no_specific_time)________________________________________________|
	| 			and so on..........                    |  			 |             |
	|______________________________________________________________________________|

	
	Table is just for demonstration purpose, don't take it literally
	Each medicine is one record in the above table
*/
contract Medicine is JointlyOwned{
	string private name;
	bool private breakfast;
	bool private lunch;
	bool private dinner;
	uint8 private frequency;
	string private notes;
	uint8 private dosage;//dosage in mg

	function Medicine(address _patient, string _name, bool _b, bool _l, bool _d, uint8 _freq, string _notes, uint8 _dosage){
		primaryOwner = _patient;
		name = _name;
		breakfast = _b;
		lunch = _l;
		dinner = _d;
		frequency = _freq;
		notes = _notes;
		dosage = _dosage;
	}

	function getData() onlyowner returns (string _name, bool _b, bool _l, bool _d, uint8 _f, string _notes, uint8 _dosage){
		_name = name;
		_b = breakfast;
		_l = lunch;
		_d = dinner;
		_f = frequency;
		_notes = notes;
		_dosage = dosage;
	}
}