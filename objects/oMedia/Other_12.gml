/// @description 播放
if(soundIndex){
	channel = (fmod_system_play_sound(soundIndex , false));
	fmod_channel_control_set_volume(channel , 1);
};