// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function flee(object, target){
	//Position Vectors
	target_pos = new vector(target.x, target.y);
	object_pos = new vector(object.x, object.y);
	
	//Is the attacker within the safety square
	if (object_pos.distance_sq(target_pos) > object.panic_distance_sq)
	{
		return new vector(0,0);
	}
	
	//Calulcate Desired Velocity
	object_pos.subtract(target_pos);
	object_pos.normalize();
	object_pos.multiply(object.max_speed);
	
	desired_velocity = new vector(object_pos.x, object_pos.y);
	
	//Return steering force
	desired_velocity.subtract(object.velocity);
	return desired_velocity;
}