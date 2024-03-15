if (acting && !hit)
{
	//Calculate action forces
	steering_force = calculate_forces_weighted_sum(self);
	overlap(self);

	//Calculate forces based on steering_force
	if (steering_force.x != 0 && steering_force.y != 0) 
	{
		steering_force.divide(mass);
		acceleration.set(steering_force.x, steering_force.y);
	}

	//Determine Velocity
	velocity.add(acceleration);
	velocity.limit_magnitude(max_speed);

	//Previous x,y
	var previous_x = x;
	var previous_y = y;

	//Move vehicle
	x += velocity.x;
	y += velocity.y;


	//Find Heading Vector
	heading.copy(velocity);
	heading.normalize();

	//Find Side Vector
	side.copy(heading);
	side.perp();

	//Smooth Heading
	if (smoothing_on)
	{
		//Smooth
		smoothed_heading = heading_smoother.update(heading);
	
		//Set image angle
		image_angle = point_direction(0, 0, 360 * smoothed_heading.x, 360 * smoothed_heading.y);
	}
	else
	{
		//Set image angle
		image_angle = point_direction(0, 0, 360 * heading.x, 360 * heading.y);
	}
}