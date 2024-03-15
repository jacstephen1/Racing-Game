// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function path_following(vehicle){
	//Position Vectors
	vehicle_pos = new vector(vehicle.x, vehicle.y);
	v_path = vehicle.v_path;
	
	//Variables
	current_wp = new vector(0,0)
	current_wp.copy(v_path.get_current_wp());
	var ending = v_path.get_ending(vehicle);
	
	//Check if close enough
	if (current_wp.distance_sq(vehicle_pos) < 100)
	{
		v_path.set_next_wp();
	}
	
	if (ending)
	{
		vehicle.pf_arrive = true;
		return arrive(vehicle, v_path.get_last_wp());
	}
	else
	{
		return seek(vehicle, v_path.get_last_wp());
	}
}