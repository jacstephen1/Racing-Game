// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pursuit(object, target){
	//Position Vectors
	target_pos = new vector(target.x, target.y);
	object_pos = new vector(object.x, object.y);
	
	//To Evader Vector
	target_pos.subtract(object_pos);
	
	//Calculate Heading
	relative_heading = new vector(object.heading.x, object.heading.y);
	var relative_heading_val = relative_heading.dot(target.heading);
	
	//If evader is ahead and facing target, then seek target
	if ((target_pos.dot(object.heading) > 0) && (relative_heading_val < -0.95))
	{
		return seek(object, target);
	}
	
	//Not ahead to make prediction
	var look_ahead = target_pos.get_length() / (object.max_speed + target.speed);
	look_ahead += turn_time(object, target);
	
	//Temp vector for current target position
	la_target_pos = new vector(target.x, target.y);
	
	//Temp vector for current target velocity
	la_target_velocity = new vector(0,0);
	
	//Find position of target by multiplying velocity by look ahead then adding velocity to current pos
	la_target_velocity.copy(target.velocity);
	la_target_velocity.multiply(look_ahead);
	la_target_pos.add(la_target_velocity);
	
	//Seek to predicted position
	return seek(object, la_target_pos);
}