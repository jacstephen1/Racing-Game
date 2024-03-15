// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function turn_time(object, target){
	//Position Vectors
	target_pos = new vector(target.x, target.y);
	object_pos = new vector(object.x, object.y);
	
	//Normalized vector to target
	target_pos.subtract(object_pos);
	target_pos.normalize();
	
	var dot = object.heading.dot(target_pos);
	
	return ((dot - 1.0) * (-object.max_rotation_speed));
}