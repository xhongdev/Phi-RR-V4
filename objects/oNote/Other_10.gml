/// @description 按键贴图&初始化&音效
switch(self.type){
	case 1: sprite_index = note_tap;  sound = snd_note_tap;			break;
	case 2: sprite_index = note_drag; sound = snd_note_drag;		break;
	case 3:
		sound = snd_note_tap;
		depth = ++depth;
		sprite_index = note_hold_head;		
		var scale = [ window_get_width() * 0.05625, window_get_height() * 0.6];		
		_hxy = [[0 , 0 ] , [0 , 0] , [0 , 0]];
		hold_time_length = (game.Math.realTimer(self.bpm , self.holdTime));
		yscale = ((hold_time_length * scale[1]) / (sprite_get_height(note_hold_body)) * self[$ "speed"]);
		isClickRealTime = (game.Math.realTimer(self.bpm , self.time))
		isHold = false;
		holdTimeCount = 0;
		//_start = 0;
		_bak_time = (game.Math.realTimer(self.bpm , self.time));
		//isOutTime = false;
	break;
	case 4:	sprite_index = note_flick; sound = snd_note_flick;		break;
	
	default:									break;
};
xy = [0,0];
if(game.Math.realTimer(self.bpm , self.time) + game.Math.realTimer(self.bpm , self.holdTime) > oMedia.length) then maxcombo --; 
image_xscale = (image_xscale / 5);
image_yscale = (image_yscale / 5)