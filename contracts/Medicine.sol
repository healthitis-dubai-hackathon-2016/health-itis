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

}