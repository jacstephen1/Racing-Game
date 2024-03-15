//Vector Variable
velocity = new vector(0,0);
heading = new vector(0,0);

//Variables
direction_rad = direction * pi/180;

//Create WP List
if (instance_exists(obj_waypoint))
{
	for (var i = 0; i < instance_number(obj_waypoint); ++i;)
	{
	    waypoint_list[i] = instance_find(obj_waypoint,i);
	}
}