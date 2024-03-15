// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wall_avoidance(vehicle){
	//Position Vectors
	vehicle_pos = new vector(vehicle.x, vehicle.y);
	
	//Create Feelers
		var wall_detection_distance = 250;
	
		//feeler pointing straight in front
		feeler0 = new vector(0,0);
		feeler0.copy(vehicle.heading);
		feeler0.multiply(wall_detection_distance);
		feeler0.add(vehicle_pos);
		feelers[0] = feeler0;

		//feeler to left
		//Temp rotation vector
		feeler1 = new vector(0,0);
		feeler1.copy(vehicle.heading);
		rotate_around_origin(feeler1, (pi * (3/4)));
		feeler1.multiply(wall_detection_distance/2);
		feeler1.add(vehicle_pos);
		feelers[1] = feeler1;

		//feeler to right
		feeler2 = new vector(0,0);
		feeler2.copy(vehicle.heading);
		rotate_around_origin(feeler2, (pi * (1/4)));
		feeler2.multiply(wall_detection_distance/2);
		feeler2.add(vehicle_pos);
		feelers[2] = feeler2;
		
	//Wall Avoidance
	var distance_to_ip = 0.0;
	var distance_to_closest_ip = 999999999999999;
	var closest_wall_i = -1;
	wall_list = obj_world_controller.wall_list;
	
	steering_force = new vector(0,0);
	point = new vector(0,0);
	closest_point = new vector(0,0);
	
	//Examine Feelers
	for (var flr = 0; flr < array_length(feelers); flr++)
	{
		//Check wall intersections
		for (var w = 0; w < array_length(wall_list); w++)
		{
			//from is top corner, to is bottom corner
			if (line_intersect(vehicle_pos, feelers[flr], wall_list[w].from, wall_list[w].to, distance_to_ip, point))
			{
				//Is this the closest?
				if (distance_to_ip < distance_to_closest_ip)
				{
					distance_to_closest_ip = distance_to_ip;
					
					closest_wall_i = w;
					
					closest_point.copy(point);
				}
			}
		}
		
		//If intersection
		if (closest_wall_i >= 0)
		{	
			//Calculate overshoot
			over_shoot = new vector(0,0);
			over_shoot.copy(feelers[flr]);
			over_shoot.subtract(closest_point);

			//Force of overshoot
			steering_force.copy(wall_list[closest_wall_i].normal);
			steering_force.multiply(over_shoot.get_length());
			
			//Lessen Forces
			steering_force.normalize();
		}
	}
	
	return steering_force;
}