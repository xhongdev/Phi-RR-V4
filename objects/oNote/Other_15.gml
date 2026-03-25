/// @description 非长条判定
if(game.Math.timer(self.bpm , game.__time[1]) >= self.time){
	var obj = (game.line_list[self.line_id]),
		_xy = (GetRotate(xy[0] , obj.y , obj.x , obj.y , obj.image_angle));
	_eff_c(_xy[0] , _xy[1]);
	combo ++;
	//print(_xy , game.settings.enableDebug);
	audio_play_sound(sound , 0 , 0);
	instance_deactivate_object(self);
};