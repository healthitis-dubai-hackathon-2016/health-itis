pragma solidity ^0.4.7;
import "./Mortal.sol";
/*
	Display the medicine data in the following way:
	__________________________________________________________________
	|Medicine Name | 1/0-1/0-1/0  |  Frequency (days)  | Notes        |
	|______________|_(b-l-d)______|___________________________________|
	|med1		   | 1-0-1		  | 1 (every day)	   | Take by mouth|
	|______________|__________________________________________________|
	|med2		   | 0-1-0		  | 2 (alternate days) | Dissolve in water
	|______________|______________|____________________|______________|
	|med3          | 0-0-0		  |	1 				   | Apply topically
	|____________(no_specific_time)___________________________________|
	| 			and so on..........                                   |
	|_________________________________________________________________|

	
	Table is just for demonstration purpose, don't take it literally
	Each medicine is one record in the above table
*/
contract Medicine is Mortal{
	string private name;
	bool private breakfast;
	bool private lunch;
	bool private dinner;
	uint8 private frequency;
	string private notes;

	function Medicine(address _patient, string _name, bool _b, bool _l, bool _d, uint8 _freq, string _notes){
		primaryOwner = _patient;
		name = _name;
		breakfast = _b;
		lunch = _l;
		dinner = _d;
		frequency = _freq;
		notes = _notes;
	}
	function getName() onlyowner returns (string){
		return name;
	}

	/*
		returns an unsigned 8-bit integer in the following format
		xxxxx(0/1)(0/1)(0/1)
			   ^	^	 ^
			   a 	b 	 c

		a-> dinner
		b-> lunch
		c-> breakfast
	*/
	function getMedicineTimes() onlyowner returns (uint8){
		uint8 times = 0;
		if(breakfast){times = times | 1;}
		if(lunch){times = times | 2;}
		if(dinner){times = times | 4;}
		return times;
	}

	function getFrequency() onlyowner returns (uint8 freq){
		freq = frequency;
	}

	function getNotes() onlyowner returns (string _notes){
		_notes = notes;
	}
}