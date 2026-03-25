/// @description 
if(game.settings.enableFPS) then window_set_caption($"{GAME_NAME} - FPS: {fps} / {fps_real}");
if(!game.paused){
	//print(array_length(game.__time));
	event_user(0);
	game.Math.ctime();
	//print(game.__time);
}elif(game.paused && game.__time[0] > 0){
		
};

fps_more += fps_real;
refresh_count ++;
if(refresh_count >= _re_fps) {
	fpsReal	= (fps_more / _re_fps);
	fps_more = 0;
	refresh_count = 0;
};