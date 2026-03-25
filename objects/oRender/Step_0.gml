/// @description 
//if(game.settings.enableFPS) then window_set_caption($"{GAME_NAME} - FPS: {fps} / {fps_real}");
if(!game.paused){
	//print(array_length(game.__time));	
	game.Math.ctime();
	//print(game.__time);
}elif(game.paused && game.__time[0] > 0){
		
};

event_user(_step_fps_user_count);