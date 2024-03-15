// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function arrive(object, target)
{
	//Position Vectors
	
	target_pos = new vector(target.x, target.y);
	object_pos = new vector(object.x, object.y);
	
	//ToTarget Distance
	target_pos.subtract(object_pos);
	var distance = target_pos.get_length();
	
	//Check Distance -- Note: Margin is 30pixels to ensure the vehicle doesn't attempt to keep overcorrecting
	if (distance > 30)
	{
		//Deceleration to arrive at target
		var object_decel = distance / (object.deceleration * .3);
		
		//Check that the deceleration speed is less than the max speed
		object_decel = min(object_decel, object.max_speed);
	
		//Return steering force
		target_pos.multiply(object_decel);
		target_pos.divide(distance);
		target_pos.subtract(object.velocity);
		
		return target_pos;
	}
	
	//If at destination
	object.arrive_on = false;
	
	if (pf_arrive)
	{
		object.path_following_on = false;
		object.race_finished = true;
	}
	
	return new vector(0,0);
}