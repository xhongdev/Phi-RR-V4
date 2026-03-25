/// @description 

if(!game.paused){
	var _ev = [
		_events.judgeLineMoveEvents,
		_events.judgeLineRotateEvents,
		_events.judgeLineDisappearEvents,
		_events.speedEvents
	],
	nowTime = (game.Math.timer(_events.bpm , game.__time[1]));
	for(var i = 0 ; i < 4 ; i ++){
		//if() then continue;
		var _ev_l = (array_length(_ev[i]));
		if(_ev_l == 0) then continue;
		var count = _counts[i];
		//var	startTime = (_ev[i][_counts[i]].startTime),
		//	endTime = (_ev[i][_counts[i]].endTime);
		
		if((_ev[i][count].startTime <= nowTime && _ev[i][count].endTime >= nowTime) || (count >= _ev_l - 1)) then continue;
		
		while(_ev[i][count].endTime < nowTime && count >= 0 && count < _ev_l){
			//_counts[i] ++;
			count ++;
			//array_set(_counts , i , _counts[i] + 1);
		};
		
		while(_ev[i][count].startTime > nowTime && count > 0 && count < _ev_l){
			//array_set(_counts , i , _counts[i] - 1);
			count --;
		};
		
		if(i == 3 && count > 0) { __value[1] = (speedValueList[count]) };
		array_set(_counts , i , count);
	};
};