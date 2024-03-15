//Race Finished
if (race_finished)
{
	show_debug_message("AI finished");
	obj_world_controller.winner = 1;
}

//Hit by Item
if (hit)
{
	direction += 2;
	image_angle = direction;
	
	if (image_angle == hit_dir)
	{
		hit = false;
	}
}