//Set Camera
view_visible[0] = 1;
view_visible[1] = 0;

//Obstacle List
if (instance_exists(obj_obstacle_parent))
{
	for (var i = 0; i < instance_number(obj_obstacle_parent); ++i;)
	{
	    ob_list[i] = instance_find(obj_obstacle_parent,i);
	}
}

//Wall List
if (instance_exists(obj_wall_parent))
{
	for (var i = 0; i < instance_number(obj_wall_parent); ++i;)
	{
	    wall_list[i] = instance_find(obj_wall_parent,i);
	}
}

//Vehicle List
if (instance_exists(obj_vehicle_parent))
{
	for (var i = 0; i < instance_number(obj_vehicle_parent); ++i;)
	{
	    vehicle_list[i] = instance_find(obj_vehicle_parent,i);
	}
	//Player Vehicle
	if (instance_exists(obj_player) && instance_exists(obj_vehicle_parent))
	{
		array_push(vehicle_list, instance_find(obj_player,0));
	}
}

instance_deactivate_object(obj_black);