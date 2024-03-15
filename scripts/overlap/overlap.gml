// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function overlap(vehicle){
	//Iterate through list of vehicle
	v_list = obj_world_controller.vehicle_list;
	for (var i = 0; i < array_length(v_list); i++)
	{
		//Due to a weird mechanic with identifying objects, using position to identify rather than id
		if ((vehicle.x != v_list[i].x) && (vehicle.y != v_list[i].y))
		{
			//Calculate distance between positions
			to_entity = new vector(vehicle.x, vehicle.y);
			//show_debug_message("To_entity: " + string(to_entity));
			current_v_pos = new vector(v_list[i].x, v_list[i].y);
			//show_debug_message("Current_v_pos " + string(current_v_pos));
			to_entity.subtract(current_v_pos);
			//show_debug_message("To_entity_post: " + string(to_entity));
		
			var distance_from_other = to_entity.get_length();
		
			//If smaller than number move them away
			var overlap_amount = max(v_list[i].sprite_height/2, v_list[i].sprite_width/2) 
								+ max(vehicle.sprite_width/2, vehicle.sprite_height/2)
								- distance_from_other;
		
			if (overlap_amount >= 0)
			{
					to_entity.divide(distance_from_other);
					to_entity.multiply(overlap_amount);
					
					var potential_x = x + to_entity.x;
					var potential_y = y + to_entity.y;
					
					if (!place_meeting(potential_x, potential_y, obj_wall_collision))
					{
						vehicle.x = x + to_entity.x;
						vehicle.y = y + to_entity.y;
					}
			}
		}
	}
}