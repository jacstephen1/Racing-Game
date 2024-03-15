// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function seek(object, target)
{
	//Calulcate Desired Velocity
	target_pos = new vector(target.x, target.y);
	object_pos = new vector(object.x, object.y);
	
	target_pos.subtract(object_pos);
	target_pos.normalize();
	target_pos.multiply(object.max_speed);
	
	desired_velocity = new vector(target_pos.x, target_pos.y);
	
	//Return steering force
	desired_velocity.subtract(object.velocity);
	return desired_velocity;
}