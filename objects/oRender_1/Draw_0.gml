/// @description 
draw_set_font(game.font);
draw_set_colour(c_gray);
draw_set_valign(fa_center);
draw_set_halign(fa_left);
draw_text_transformed(5 , room_height - 10 , $"@{VerStr} - Code By XTHX(RPEVersion->{game_1.version})" , 0.3 , 0.3 , 0);
draw_text_transformed(5 , 30 , $"{game_1.Math.secToBeat(game.__time[1] - sec , rpe_bpm)}" , 0.3 , 0.3 , 0);

if(game.settings.enableFPS){
	draw_set_halign(fa_right);
	draw_set_colour(c_white);
	draw_text_transformed(room_width , 30 , $"{ceil(fpsReal)}({fps})" , 0.35 , 0.35 , 0);
};