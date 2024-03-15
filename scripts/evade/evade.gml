// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function evade(object, target){
	//Position Vectors
	target_pos = new vector(target.x, target.y);
	object_pos = new vector(object.x, object.y);
	
	//ToPursuer
	target_pos.subtract(object_pos);
	
	//Look ahead
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
	return flee(object, la_target_pos);
}