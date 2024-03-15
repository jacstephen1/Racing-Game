//Camera Movement
camera_set_view_pos(view_camera[0], x - (camera_get_view_width(view_camera[0])/2), y - (camera_get_view_height(view_camera[0])/2));

//Vectors
velocity.set(hspeed, vspeed);
heading.copy(velocity);
heading.normalize();