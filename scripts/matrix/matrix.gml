// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function build_identity()
{
	mat_temp[1][1] = 1; mat_temp[1][2] = 0; mat_temp[1][3] = 0;
	mat_temp[2][1] = 0; mat_temp[2][2] = 1; mat_temp[2][3] = 0;
	mat_temp[3][1] = 0; mat_temp[3][2] = 0; mat_temp[3][3] = 1;
	
	return mat_temp;
}

function transform_vector(_matrix, _point) {
	var temp_x = (_matrix[1][1]*_point.x) + (_matrix[2][1]*_point.y) + (_matrix[3][1]);
	var temp_y = (_matrix[1][2]*_point.x) + (_matrix[2][2]*_point.y) + (_matrix[3][2]);
	
	_point.set(temp_x, temp_y);
}

function m_multiply(_matrix, _temp) {
	mat_temp = build_identity();
	
	mat_temp[1][1] = (_temp[1][1]*_matrix[1][1]) + (_temp[1][2]*_matrix[2][1]) + (_temp[1][3]*_matrix[3][1])
	mat_temp[1][2] = (_temp[1][1]*_matrix[1][2]) + (_temp[1][2]*_matrix[2][2]) + (_temp[1][3]*_matrix[3][2])
	mat_temp[1][3] = (_temp[1][1]*_matrix[1][3]) + (_temp[1][2]*_matrix[2][3]) + (_temp[1][3]*_matrix[3][3])
	
	mat_temp[2][1] = (_temp[2][1]*_matrix[1][1]) + (_temp[2][2]*_matrix[2][1]) + (_temp[2][3]*_matrix[3][1])
	mat_temp[2][2] = (_temp[2][1]*_matrix[1][2]) + (_temp[2][2]*_matrix[2][2]) + (_temp[2][3]*_matrix[3][2])
	mat_temp[2][3] = (_temp[2][1]*_matrix[1][3]) + (_temp[2][2]*_matrix[2][3]) + (_temp[2][3]*_matrix[3][3])
	
	mat_temp[3][1] = (_temp[3][1]*_matrix[1][1]) + (_temp[3][2]*_matrix[2][1]) + (_temp[3][3]*_matrix[3][1])
	mat_temp[3][2] = (_temp[3][1]*_matrix[1][2]) + (_temp[3][2]*_matrix[2][2]) + (_temp[3][3]*_matrix[3][2])
	mat_temp[3][3] = (_temp[3][1]*_matrix[1][3]) + (_temp[3][2]*_matrix[2][3]) + (_temp[3][3]*_matrix[3][3])
	
	_matrix = mat_temp;
}

function rotate(_matrix, _fwd, _side) {
	mat_temp = build_identity();
	
	mat_temp[1][1] = _fwd.x; mat_temp[1][2] = _fwd.y; mat_temp[1][3] = 0;
	mat_temp[2][1] = _side.x; mat_temp[2][2] = _side.y; mat_temp[2][3] = 0;
	mat_temp[3][1] = 0; mat_temp[3][2] = 0; mat_temp[3][3] = 1;
	
	m_multiply(_matrix, mat_temp)
}

function rotate_ang(_matrix, _ang) {
	mat_temp = build_identity();
	
	var sin_val = sin(_ang);
	var cos_val = cos(_ang);
	
	mat_temp[1][1] = cos_val; mat_temp[1][2] = sin_val; mat_temp[1][3] = 0;
	mat_temp[2][1] = -sin_val; mat_temp[2][2] = cos_val; mat_temp[2][3] = 0;
	mat_temp[3][1] = 0; mat_temp[3][2] = 0; mat_temp[3][3] = 1;
	
	m_multiply(_matrix, mat_temp)
}
	
function point_to_ls(_point, _heading, _side, _position) {
	//Copy Point
	trans_point = new vector(0,0);
	trans_point.copy(_point);
		
	//Intiialize Matrix
	mat_transform = build_identity();
		
	var t_x = -(_position.dot(_heading));
	var t_y = -(_position.dot(_side));
	
	//Create Matrix
	mat_transform[1][1] = _heading.x; mat_transform[1][2] = _side.x;
	mat_transform[2][1] = _heading.y; mat_transform[2][2] = _side.y;
	mat_transform[3][1] = t_x; mat_transform[3][2] = t_y;
	
	//Transform Vertices
	transform_vector(mat_transform, trans_point);
		
	return trans_point;
}
	
function vector_to_ws(_vec, _heading, _side) {
	//Copy vector
	trans_vec = new vector(0,0);
	trans_vec.copy(_vec);
		
	//Intiialize Matrix
	mat_transform = build_identity();
		
	//Rotate
	rotate(mat_transform, _heading, _side);
	
	//Transform
	transform_vector(mat_transform, trans_vec);
	
	return trans_vec;
}

function rotate_around_origin(_v, _ang) {
	//New matrix
	mat = build_identity();
		
	//Rotate
	rotate_ang(mat, _ang);
		
	//Tranform
	transform_vector(mat, _v);
}