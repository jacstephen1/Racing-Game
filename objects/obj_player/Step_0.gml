//Variables
var forward = keyboard_check(ord("W"));
var backward = keyboard_check(ord("S"));
var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));

var use = keyboard_check(vk_space);

//Image Rotation
if (left && !deactivate)
{
	direction += car_rotation_speed;
}

if (right && !deactivate)
{
	direction -= car_rotation_speed;
}

image_angle = direction;
direction_rad = direction * pi/180;

//Driving Movement
if (forward && speed < max_speed  && !deactivate)
{
	speed += car_acceleration;
}
else if (speed > 0)
{
	speed -= car_deceleration;
}
if (backward && speed > -max_speed  && !deactivate)
{
	speed -= car_deceleration
}
else if (speed < 0)
{
	speed += car_acceleration
}

//Use Item
if (use && inventory_item != "")
{
	show_debug_message("Use: " + string(inventory_item));
	
	var item_type;
	if (inventory_item == "obj_blue_barrel")
	{
		item_type = obj_blue_barrel;
	}
	else if (inventory_item == "obj_orange_barrel")
	{
		item_type = obj_orange_barrel;
	}

	var item = instance_create_layer(x, y, "Misc", item_type, {parent_obj : "obj_player"});

	inventory_item = "";
}

//Game End
if (laps == 3)
{
	show_debug_message("Player finished");
	obj_world_controller.winner = 0;
}