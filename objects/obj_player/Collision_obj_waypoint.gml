//Start
if (current_waypoint == -1 && other.id == waypoint_list[0].id)
{
	current_waypoint = 1;
}

//Check which waypoint
for (var i = 0; i < array_length(waypoint_list); i++)
{
	if (current_waypoint != -1)
	{
		if (other.id == waypoint_list[i])
		{
			 current_waypoint = i;
		}
	}
}

//Finish line?
if (current_waypoint == array_length(waypoint_list) - 1)
{
	laps++;
	current_waypoint = -1;
	show_debug_message("Player Lap: " + string(laps));
}