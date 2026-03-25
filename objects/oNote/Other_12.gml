/// @description 长条(type == 3)位置计算
var l_f = (game.line_list[self.line_id].__value[0]);

var	_y = ((self.isAbove ? (l_f - self.yOffset) : (self.yOffset - l_f)));//,


// 超过可视范围不进行计算
if(abs(_y) > 5 && !isHold) { canDraw = false; exit;}//{ canDraw = false; exit; };

// 超过最小值或长度为0的不绘制
var	_c_y = ((!self.isAbove ? (_y < -0.001) : (_y > 0.001)) && !isHold);

if(_c_y || yscale == 0) then canDraw = false;
else canDraw = true;

var scale = [ window_get_width() * 0.05625, window_get_height() * 0.6],
	l_xy = [
		game.line_list[self.line_id].x,
		game.line_list[self.line_id].y
	],
	xy0 = [
		(self.xOffset * scale[0] + l_xy[0]),
		((_y * scale[1]) + l_xy[1])
	];
var rot = (game.line_list[self.line_id].image_angle),
	height = (sprite_get_height(note_hold_body));
	
var _sign = (self.isAbove ? -1 : 1);
if(isHold){
	
	yscale = ((( isClickRealTime + hold_time_length - game.__time[1] ) * scale[1]) / (height) * self[$ "speed"]);
	_hxy = [
		GetRotate(xy0[0] , l_xy[1] , l_xy[0] , l_xy[1] , rot),
		GetRotate(xy0[0], l_xy[1] + ((height * yscale) * (_sign)) , l_xy[0] , l_xy[1] , rot)
	];
}else{
	var b_y = (xy0[1] + (((sprite_yoffset / 4) * (_sign)) + (_sign)));
	_hxy = [
		GetRotate(xy0[0] , xy0[1] , l_xy[0] , l_xy[1] , rot),
		GetRotate(xy0[0], b_y , l_xy[0] , l_xy[1] , rot),
		GetRotate(xy0[0], b_y + ((height * yscale) * (_sign)) , l_xy[0] , l_xy[1] , rot)
	];
};
image_angle = ((-180 * (!self.isAbove)) + rot);
