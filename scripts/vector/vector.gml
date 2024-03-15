//Main Vector Struct
function vector(_x, _y) constructor {
	x = _x;
	y = _y;
	
	static set = function(_x, _y) {
		x = _x;
		y = _y;
	}	
	
	static set_x = function(_x) {
		x = _x;
	}	
	
	static set_y = function(_y) {
		y = _y;
	}	
	
	static add = function(_vector) {
		x += _vector.x;
		y += _vector.y;
	}
	
	static subtract = function(_vector) {
		x -= _vector.x;
		y -= _vector.y;
	}
		
	static negate = function() {
		x = -x;
		y = -y;
	}
		
	static multiply = function(_scalar) {
		x *= _scalar;
		y *= _scalar;
	}
	
	static divide = function(_scalar) {
		x /= _scalar;
		y /= _scalar;
	}
	
	static perp = function() {
		var old_x = x;
		var old_y = y;
		
		x = -(old_y);
		y = old_x;
	}
	
	static dot = function(_v1) {
		return x*_v1.x + y*_v1.y;
	}
	
	static distance = function(_v1) {
		ySeparation = _v1.y - y;
		xSeparation = _v1.x - x;

		return sqrt(ySeparation*ySeparation + xSeparation*xSeparation);
	}
	
	static distance_sq = function(_v1) {
		ySeparation = _v1.y - y;
		xSeparation = _v1.x - x;

		return ySeparation*ySeparation + xSeparation*xSeparation;
	}
	
	static get_length = function() {
		return sqrt(x * x + y * y);
	}
      
	static get_magnitude = function() {
		return point_distance(0, 0, x, y);
    }
	
	static get_direction = function() {
		return point_direction(0, 0, x, y);
	}

	static normalize = function() {
		if ((x != 0) || (y != 0)) {
			var _factor = 1/sqrt((x * x) + (y * y));
			x = _factor * x;
			y = _factor * y;	
		}
	}
	
	static set_magnitude = function(_scalar) {
		normalize();
		multiply(_scalar);	
	}	
	
	static limit_magnitude = function(_limit) {
		if (get_magnitude() > _limit) {
			set_magnitude(_limit);
		}
	}

	static copy = function(_vector) {
		x = _vector.x;
		y = _vector.y;
	}
}