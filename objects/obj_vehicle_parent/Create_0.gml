//Intialize Vectors
velocity = new vector(0,0);
acceleration = new vector(0,0);
steering_force = new vector(0,0);
heading = new vector(0,0);
side = new vector(0,0);
heading_smoother = new smoother(smoothing_samples, new vector(0,0));
smoothed_heading = new vector(0,0);

//Random Inits
hit = false;
hit_dir = -1;
acting = false;

//Waypoint Vectors List (Making Three Lists for All Laps)
if (instance_exists(obj_waypoint))
{
	for (var i = 0; i < instance_number(obj_waypoint); ++i;)
	{
		var wp_x = instance_find(obj_waypoint,i).x;
		var wp_y = instance_find(obj_waypoint,i).y;
		var wp_h = instance_find(obj_waypoint,i).sprite_height - 170;
		
		//Randomize
		var wp_x_1 = random_range(wp_x-(wp_h/2), wp_x+(wp_h/2));
		var wp_y_1 = random_range(wp_y-(wp_h/2), wp_y+(wp_h/2));
		
		var wp_x_2 = random_range(wp_x-(wp_h/2), wp_x+(wp_h/2));
		var wp_y_2 = random_range(wp_y-(wp_h/2), wp_y+(wp_h/2));
		
		var wp_x_3 = random_range(wp_x-(wp_h/2), wp_x+(wp_h/2));
		var wp_y_3 = random_range(wp_y-(wp_h/2), wp_y+(wp_h/2));
		
	    waypoint_list_1[i] =  new vector(wp_x, wp_y);
		waypoint_list_2[i] =  new vector(wp_x, wp_y);
		waypoint_list_3[i] =  new vector(wp_x, wp_y);
	}
}

//Initialize Path
v_path = new vehicle_path(self, 0, 3);

//Is AI, AIing?
if (arrive_on || evade_on || flee_on || obstacle_avoidance_on || path_following_on || pursuit_on || seek_on || wall_avoidance_on)
{
	acting = true;
}
