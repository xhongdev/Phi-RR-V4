/// @description 完全销毁
event_user(7);
if(track > 0){
	fmod_system_close(track);
	fmod_system_release(track);
};

print("[C-Sound] Full Clean.")
instance_destroy();