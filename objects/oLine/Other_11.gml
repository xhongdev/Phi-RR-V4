/// @description 处理速度事件

var value = 0;
speedValueList = [value];
for(var i = 0 ; i < array_length(_events[$ "speedEvents"]) ; i ++){
	var s_e = (_events[$ "speedEvents"][i])
	var dtime = (game.Math.realTimer(_events.bpm , s_e.endTime) - game.Math.realTimer(_events.bpm , s_e.startTime));
	var _v = (value + (dtime * s_e.value));
	array_add(speedValueList , value + (dtime * s_e.value));
	value = _v;
};
//print(speedValueList);