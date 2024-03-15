// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function line_intersect(A, B, C, D, dist, point){
	var r_top = (A.y - C.y) * (D.x - C.x) - (A.x - C.x) * (D.y - C.y);
	var r_bot = (B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x);
	
	var s_top = (A.y - C.y) * (B.x - A.x) - (A.x - C.x) * (B.y - A.y);
	var s_bot = (B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x);
	
	//Parallel Lines?
	if ((r_bot == 0) || (s_bot == 0))
	{
		return false;
	}
	
	var r = r_top/r_bot;
	var s = s_top/s_bot;
	
	if ((r > 0) && (r < 1) && (s > 0) && (s < 1))
	{
		dist = A.distance(B) * r;
		
		//Temp Vectors
		_B = new vector(0,0);
		_B.copy(B);
		_B.subtract(A);
		_B.multiply(r);
		
		_A = new vector(0,0);
		_A.copy(A);
		_A.add(_B);
		
		point = _A;
		
		return true;
	}
	else
	{
		dist = 0;
		return false;
	}
}