//Intialize Vectors
velocity = new vector(0,0);
acceleration = new vector(0,0);
steering_force = new vector(0,0);
heading = new vector(0,0);
side = new vector(0,0);
heading_smoother = new smoother(smoothing_samples, new vector(0,0));
smoothed_heading = new vector(0,0);

//Random Inits
acting = false;

//Is AI, AIing?
if (arrive_on || evade_on || flee_on || obstacle_avoidance_on || path_following_on || pursuit_on || seek_on || wall_avoidance_on)
{
	acting = true;
}

//Blue Barrel Vehcile is a Green Shell
if (parent_obj == "obj_player")
{
	direction = obj_player.direction;
	
	//Variables
	var desired_magnitude = 15;
	var direction_rad = direction * pi/180;
	
	//X and Y Velocity
	var x_cos = desired_magnitude * cos(direction_rad);
	var y_sin = -desired_magnitude * sin(direction_rad);
	
	//Set Speed
	velocity.set(x_cos, y_sin);
}