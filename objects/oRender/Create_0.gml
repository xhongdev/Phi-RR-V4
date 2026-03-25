/// @description
window_set_caption($"{GAME_NAME}");
gml_release_mode(true);
globalvar game , _eff_c , combo , maxcombo , fpsReal;
fpsReal = fps_real;
combo = 0;
maxcombo = 0;
game = (new Phigros());
game.Resource();
print(game.folder_chart , game.settings.enableDebug);
game.Reader(game.settings.enableQuikyStart ? (InChartPath + game.folder_chart.chart) : "");
//game.background()
depth = DEPTH.DEBUG;
if(game.settings.showBG) then instance_create_depth(0,0,0,oBG);
instance_create_depth(0,0,0,oMedia , { "name" : game.settings.enableQuikyStart ? (InChartPath + game.folder_chart.music) : (InChartPath + "") });
game.Sort();
game.CreateLines();
instance_create_depth(0 , 0 , 0 , oEffect);
draw_set_font(game.font);
font_scales = clamp(0.6 * ((room_width / 2) / (string_width(game.folder_chart.name) * 0.6 + 40)) , 0.2 , 0.6);
_eff_c = (method(self , function(_x,_y){
	if(!game.settings.enableHitEffect) then return;
	var color = #ffeca0;
	with(oEffect){
		_x = (floor(_x));
		_y = (floor(_y));
		part_particles_create_color(p1,_x,_y,_hitFX,color,1);
		part_particles_create_color(p1,_x,_y,part,color,4);
	};
}));
//print(array_length(game.__time));
//print($"Time: {game.math.dtime(game.time[1] , 0 , 0)}")
//print(struct_get_names(game.settings))
maxcombo = (instance_number(oNote));
print(game.notes , game.settings.enableDebug);
event_user(2);
//game_set_speed(60 , gamespeed_fps);
fps_more = 0;
refresh_count = 0;
alarm[0] = 300;

//var arr = [0 , 1 , 2];
//array_add(arr , [ 1 , 2 , 3 , 4 , 5 , 8] , true);
//print(arr);