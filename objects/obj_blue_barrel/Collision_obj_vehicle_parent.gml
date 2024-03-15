//Vehicle Collision
if ((other == obj_blue_barrel) || (other == obj_orange_barrel))
{
	instance_destroy(other);
	instance_destroy(self);
}
else
{
	other.hit = true;
	other.hit_dir = other.direction;
	instance_destroy(self);
}
