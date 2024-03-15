if (winner == -1)
{
	game_state = 0;
}
else
{
	game_state = -1;
	
	if (instance_exists(obj_ai_1))
	{
		obj_ai_1.acting = false;
	}
}

if ((mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_escape)) && game_state = -1)
{
	game_state = 0;
	obj_player.deactivate = false;
	view_visible[0] = 1;
	view_visible[1] = 0;
	game_restart();
}