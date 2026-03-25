/// @description 
depth = DEPTH.BG;
if(sprite_exists(game.bg)){
	draw_sprite(game.bg , 0 , room_width / 2 , room_height / 2);	
};
surface = undefined;
size = [ room_width , room_height ];
//event_user(0);
enableBlur = game.settings.enableBlur;

blur = (shd_gaussian_blur);
//_draw_user_count = (game.settings.showBG ? 2 : 1);