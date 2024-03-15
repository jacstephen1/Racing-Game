// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function calculate_forces_weighted_sum(vehicle){
	//Initialize
	steering_force = new vector(0,0);
	force = new vector(0,0);
	
	//Debug
	var debug = false;
	
	//Wall Avoidance
	if (vehicle.wall_avoidance_on)
	{
		force = wall_avoidance(vehicle);
		
		if (debug) show_debug_message("Wall Avoidance Force: " + string(force));
		
		//Attempt to Divide Force to Reduce
		if (force.x != 0 && force.y != 0)
		{
			force.divide(2);
		}
		
		if (!accumulate_force(vehicle, steering_force, force)) return steering_force;
	}
	
	//Obstacle Avoidance
	if (vehicle.obstacle_avoidance_on)
	{
		force = obstacle_avoidance(vehicle);
		
		if (debug) show_debug_message("Obstacle Avoidance Force: " + string(force));
		
		if (!accumulate_force(vehicle, steering_force, force)) return steering_force;
	}
	
	//Path Following
	if (vehicle.path_following_on)
	{
		force = path_following(vehicle);
		
		if (debug) show_debug_message("Path Following Force: " + string(force));
		
		if (!accumulate_force(vehicle, steering_force, force)) return steering_force;
	}
	
	//Evasion
	if (vehicle.evade_on)
	{
		force = evade(vehicle, vehicle.target);
		
		if (debug) show_debug_message("Evade Force: " + string(force));
		
		if (!accumulate_force(vehicle, steering_force, force)) return steering_force;
	}
	
	//Pursuit
	if (vehicle.pursuit_on)
	{
		force = pursuit(vehicle, vehicle.target);
		
		if (debug) show_debug_message("Pursuit Force: " + string(force));
		
		if (!accumulate_force(vehicle, steering_force, force)) return steering_force;
	}
	
	//Fleeing
	if (vehicle.flee_on)
	{
		force = flee(vehicle, vehicle.target);
		
		if (debug) show_debug_message("Flee Force: " + string(force));
		
		if (!accumulate_force(vehicle, steering_force, force)) return steering_force;
	}
	
	//Arriving
	if (vehicle.arrive_on)
	{
		force = arrive(vehicle, vehicle.target);
		
		if (debug) show_debug_message("Arrive Force: " + string(force));
		
		if (!accumulate_force(vehicle, steering_force, force)) return steering_force;
	}
	
	//Return
	return steering_force;
}

function accumulate_force(vehicle, running_to_t, force_to_add){
	//Current steering forces
	var magnitude_so_far = running_to_t.get_length();
	
	//How much remains to be used
	var magnitude_remaining = vehicle.max_force - magnitude_so_far;
	
	//No more force?
	if (magnitude_remaining <= 0.0)
	{
		show_debug_message("No Magnitude Remaining \nForce_to_add: " + string(force_to_add));
		return false;
	}
	
	//Calculate the magnitude of the force added
	var magnitude_to_add = force_to_add.get_length();
	
	//If not above total
	if (magnitude_to_add < magnitude_remaining)
	{
		running_to_t.add(force_to_add);
	}
	else
	{
		force_to_add.normalize();
		force_to_add.multiply(magnitude_remaining);
		running_to_t.add(force_to_add);
	}
	
	return true;
}