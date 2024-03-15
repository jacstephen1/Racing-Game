//Path Struct
function vehicle_path(_vehicle, _type, _loops) constructor {
	type = _type; //1 is infinite looped
	loops = _loops; //Number of times to loop
	wp_list = _vehicle.waypoint_list_1;
	current_wp_index = 0;
	looped = 0;
	
	static set_type = function(_type) {
		type = _type;
	}
	
	static get_current_wp = function() {
		return wp_list[current_wp_index];
	}
	
	static get_last_wp = function() {
		if (current_wp_index >= 0 && current_wp_index < array_length(wp_list))
		{
			return wp_list[current_wp_index];
		}
		
		return pointer_null;
	}
	
	static set_next_wp = function() {
		current_wp_index++;
	}
	
	//return false if next is end
	static get_ending = function(_vehicle) {
		if (array_length(wp_list) > 0)
		{	
			if (current_wp_index == array_length(wp_list) - 1)
			{
				looped++;
				
				if (loops == 3)
				{
					switch (looped)
					{
						case 1: 
							wp_list = _vehicle.waypoint_list_1;
						break;
						case 2:
							wp_list = _vehicle.waypoint_list_2;
						break;
						case 3:
							wp_list = _vehicle.waypoint_list_3;
						break;
					}
				}
				
				//Update Vehicle Laps
				_vehicle.laps = looped;
				
				if (type == 1 || looped < loops)
				{
					current_wp_index = 0;
					return false;
				}
				
				return true;
			}
			
			//If current wp != array_length
			return false;
		}
	}
}