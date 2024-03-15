//Calculate Vectors Upon Creation
//Added Padding to From and To
var padding = 0;
from = new vector(bbox_left - padding, //A
				  bbox_top - padding);
to = new vector(bbox_right + padding,  //B
				bbox_bottom + padding);
				
//Normal Vector
temp = new vector(x, y);
temp.normalize();
normal = new vector(-temp.y, temp.x);