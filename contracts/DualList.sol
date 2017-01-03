pragma solidity ^0.4.7;
library DualList{
	
	struct data{
		bool active;
		string value;
	}

	struct list{
		mapping(uint=>data) item;
		uint length;
	}

	function dataAt(list storage self, uint index) returns (string val, bool ac){
		if(index < self.length){
			val = self.item[index].value;
			ac = self.item[index].active;
		}else{
			throw;
		}
	}

	function valueAt(list storage self, uint index) returns (string){
		if(index < self.length){
			return self.item[index].value;
		}else{
			throw;
		}
	}

	function statusAt(list storage self, uint index) returns (bool){
		if(index < self.length){
			return self.item[index].active;
		}else{
			throw;
		}
	}


	function insert(list storage self, string value, bool active){
		self.item[self.length++].value = value;
		self.item[self.length-1].active = active;
	}

	function toggleActive(list storage self, uint index){
		self.item[index].active = !self.item[index].active;
	}

	function firstActive(list storage self) returns (uint){
		uint index;
		for(index=0; !self.item[index].active; index++){
			if(index>=self.length)
				return self.length;
		}
		return index;
	}

	function hasNextActive(list storage self, uint index) returns (bool){
		uint i;
		for(i = index; !self.item[i].active; i++){
			if(i>=self.length){
				return false;
			}
		}
		return true;
	}

	function nextActive(list storage self, uint index) returns (uint){
		uint i;
		for(i=index; !self.item[i].active; i++){
			if(i >= self.length){
				return self.length;
			}
		}
		return i;
	}

	function firstInactive(list storage self) returns (uint index){
		for(index=0; self.item[index].active; index++){
			if(index>=self.length)
				return self.length;
		}
	}

	function hasNextInactive(list storage self, uint index) returns (bool){
		uint i;
		for(i = index; self.item[i].active; i++){
			if(i>=self.length){
				return false;
			}
		}
		return true;
	}

	function nextInactive(list storage self, uint index) returns (uint){
		uint i;
		for(i=index; self.item[i].active; i++){
			if(i >= self.length){
				return self.length;
			}
		}
		return i;
	}

	modifier forAllActive(list storage self){
		uint i;
		for(i = firstActive(self); hasNextActive(self, i); i = nextActive(self, i)){
			_;
		}
	}

	modifier forAllInactive(list storage self){
		uint i;
		for(i = firstInactive(self); hasNextInactive(self, i); i = nextInactive(self, i)){
			_;
		}
	}
}