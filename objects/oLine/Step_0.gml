/// @description 

if(game.paused) then exit;
//try{

var _ev = {
	
};
var _x = 0,
	_y = 0,
	_a = image_alpha,
	_r = image_angle;

var l_xy = (array_length(_events.judgeLineMoveEvents)),
	l_a = (array_length(_events.judgeLineRotateEvents)),
	l_r = (array_length(_events.judgeLineDisappearEvents)),
	l_s = (array_length(_events.speedEvents)),
	nowTime = (game.Math.timer(_events.bpm , game.__time[1]));

if(l_xy != 0){
	_ev[$ "_xy"] = (_events.judgeLineMoveEvents[_counts[0]]);
	__x = _x;
	__y = _y;
	_x = (lerp(_ev._xy.start , _ev._xy[$ "end"] , game.Math.dtime(nowTime , _ev._xy.startTime , _ev._xy.endTime)));
	_y = (lerp(_ev._xy.start2 , _ev._xy[$ "end2"] , game.Math.dtime(nowTime , _ev._xy.startTime , _ev._xy.endTime)));
};

if(l_a != 0){
	_ev[$ "_alpha"] = (_events.judgeLineDisappearEvents[_counts[2]]);
	__a = _a;
	_a = (lerp(_ev._alpha.start , _ev._alpha[$ "end"] , game.Math.dtime(nowTime , _ev._alpha.startTime , _ev._alpha.endTime)));
};

if(l_r != 0){
	_ev[$ "_rot"] = (_events.judgeLineRotateEvents[_counts[1]]);
	__r = _r;
	_r = (lerp(_ev._rot.start , _ev._rot[$ "end"] , game.Math.dtime(nowTime , _ev._rot.startTime , _ev._rot.endTime)));
};

if(l_s != 0){
	_ev[$ "_speed"] = (_events.speedEvents[_counts[3]]);
	__value[0] = (((game.__time[1] - game.Math.realTimer(_events.bpm , _ev._speed.startTime)) * _ev._speed.value) + __value[1]);
};
var scale = [ window_get_width() / 880, window_get_height() / 520];
_a = (is_nan(_a) ? __a : _a);
_x = (is_nan(_x) ? __x : _x);
_y = (is_nan(_y) ? __y : _y);
_r = (is_nan(_r) ? __r : _r);
x = ((window_get_width() * _x / scale[0]) * scale[0]);
y = ((window_get_height() * (1 - _y) / scale[1]) * scale[1]);
image_alpha = _a;
image_angle = _r;
//}catch(e){ delete(e) };

// 