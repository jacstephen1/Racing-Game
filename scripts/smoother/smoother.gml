// _s = samples, _v = vector
function smoother(_s, _v) constructor {
	//Sum is a zero val in the construction
	sum = new vector(0,0);
	sum.copy(_v);
	for (var i = 0; i < _s; i++)
	{
		history[i] = sum;
	}
	update_slot = 0;
	
	static update = function(_heading) {
		//overite oldest val
		history[update_slot++] = _heading;
		
		//Next update_slot wraps
		if (update_slot == array_length(history))
		{
			update_slot = 0;
		}
		
		//Caluclate Average
		sum.set(0,0);
		
		for (var i = 0; i < array_length(history); i++)
		{
			sum.add(history[i]);
		}
		
		sum.divide(array_length(history));
		return sum;
	}	
}