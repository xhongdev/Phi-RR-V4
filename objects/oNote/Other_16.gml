/// @description 长条判定
var nowTime = (game.Math.timer(self.bpm , game.__time[1]));
if(nowTime >= self.time){
	//
	
	if(!isHold) { 
		audio_play_sound(sound , 0 , 0);	
		isHold = true; 
		//_start = (game.Math.realTimer(self.bpm , self.time));
		//_end = (_start + (game.Math.realTimer(self.bpm , self.holdTime)));
		_eff_c(_hxy[0][0] , _hxy[0][1]);
		//_bak_time = 
	}else{
		//isOutTime = false;
		var offset = (game.__time[1] - _bak_time);
		if(offset >= (60 / self.bpm) / 2){
			_eff_c(_hxy[0][0] , _hxy[0][1]);
			_bak_time = game.__time[1];
		};
		//else 
		//print(offset);
		
	};
	if(nowTime >= self.time + self.holdTime){
		combo ++;
		instance_deactivate_object(self);
	};
};