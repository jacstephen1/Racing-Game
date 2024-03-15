// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function obstacle_avoidance(vehicle){
	if (vehicle.velocity.x > 0 || vehicle.velocity.y > 0)
	{
		//Position Vectors
		vehicle_pos = new vector(vehicle.x, vehicle.y);

		//Min length + (object speed / object max_speed) * min length
		var detection_box_length = vehicle.min_detection_box + ((vehicle.speed/vehicle.max_speed) * vehicle.min_detection_box);
	
		ob_list = obj_world_controller.ob_list;
	
		//Variables
		var closest_obstacle = pointer_null;
		var distance_to_closest_ip = 2147483647;
		local_pos_co = new vector(0,0);
	
		for (var i = 0; i < array_length(ob_list); i++;)
		{
			//Calculate object position in local space
			local_pos = new vector(0,0);
			ob_pos = new vector(ob_list[i].x, ob_list[i].y);
			local_pos = point_to_ls(ob_pos, vehicle.heading, vehicle.side, vehicle_pos);
			show_debug_message("Ob_pos: " + string(ob_pos) + " Vehicle_pos: " + string(vehicle_pos));
			show_debug_message("Velocity: " + string(vehicle.velocity) + " Heading: " + string(vehicle.heading) + " Side: " + string(vehicle.side));
		
			//If not behind agent
			if (local_pos.x >= 0)
			{
				show_debug_message(local_pos);
				//Check for potential intersection
				//Find radius 
				var object_bRadius = max(ob_list[i].sprite_width/2, ob_list[i].sprite_height/2);
				var vehicle_bRadius = max(vehicle.sprite_width/2, vehicle.sprite_height/2);
			
				//Create expanded radius
				var expanded_radius = object_bRadius + vehicle_bRadius;
				
				show_debug_message("Expanded Radius: " + string(expanded_radius));
			
				if (abs(local_pos.y) < expanded_radius)
				{
					var c_x = local_pos.x;
					var c_y = local_pos.y;
				
					var sqrt_part = sqrt(expanded_radius*expanded_radius - c_y*c_y);
				
					var ip = c_x - sqrt_part;
				
					if (ip <= 0)
					{
						ip = c_x + sqrt_part;
					}
				
					if (ip < distance_to_closest_ip)
					{
						distance_to_closest_ip = ip;
						closest_obstacle = ob_list[i];
						local_pos_co = local_pos;
					}
				}
			}
		}
	
		steering_force = new vector(0,0);
	
		if (closest_obstacle != pointer_null)
		{
			//Closer to agent = stronger force
			var multiplier = 1.0 + ((vehicle.min_detection_box - local_pos_co.x) / vehicle.min_detection_box);
		
			//Lateral Force
			var co_bRadius = max(closest_obstacle.sprite_width/2, closest_obstacle.sprite_height/2)
			steering_force.y = (co_bRadius - local_pos_co.y) * multiplier;
		
			//Braking Force
			var braking_weight = .2;
			steering_force.x = (co_bRadius - local_pos_co.x) * braking_weight;
			
			//Lessen Forces
			steering_force.normalize();
		}
	
		return vector_to_ws(steering_force, vehicle.heading, vehicle.side);
	}
	return (new vector(0,0));
}