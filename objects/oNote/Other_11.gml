/// @description 非长条(type != 3)位置处理
if(self.type == 3 || game.paused) then exit;
var l_f = (game.line_list[self.line_id].__value[0]);


var	_y = (self.isAbove ? (l_f - self.yOffset) : (self.yOffset - l_f));

var	_c_y = ((!self.isAbove ? (_y < -0.001) : (_y > 0.001)));

if(_c_y) then canDraw = false;
else canDraw = true;
	
//if(abs(_y) > 5) {canDraw = false; exit; }

var scale = [ window_get_width() * 0.05625, window_get_height() * 0.6],
	l_xy = [
		game.line_list[self.line_id].x,
		game.line_list[self.line_id].y
	];
xy = [
	(self.xOffset * scale[0] + l_xy[0]),
	((_y * self[$ "speed"] * scale[1]) + l_xy[1])
];

//if((xy[0] < -(room_width)) || (xy[0] > (room_width * (5/4))) || (xy[1] < (-room_height)) || (xy[1] > (room_height * (5/4)))) { canDraw = false; exit; };
var rot = (game.line_list[self.line_id].image_angle);
var _xy = GetRotate(xy[0] , xy[1] , l_xy[0] , l_xy[1] , rot);

x = _xy[0];
y = _xy[1];
image_angle = rot;