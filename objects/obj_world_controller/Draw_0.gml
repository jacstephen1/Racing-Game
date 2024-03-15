//Game Over
if (game_state == -1)
{	
	if (instance_exists(obj_player))
	{
		obj_player.deactivate = true;
	}
	
	instance_activate_object(obj_black);
	view_visible[0] = 0;
	view_visible[1] = 1;
	
	draw_set_font(fnt_end);	
	draw_set_halign(fa_center);

	if (winner == 0)
	{
		draw_text(room_width/2, room_height/2 - 350, "You Win!");
		draw_text(room_width/2, room_height/2 - 200, "1st Place: Player \n2nd Place: AI");
		draw_text(room_width/2, room_height/2 + 300, "Click to Restart");
	}
	else if (winner == 1)
	{
		draw_text(room_width/2, room_height/2 - 350, "AI Wins!");
		draw_text(room_width/2, room_height/2 - 200, "1st Place: AI \n2nd Place: Player");
		draw_text(room_width/2, room_height/2 + 300, "Click to Try Again");
	}
}