/// @description 
window_set_caption($"{GAME_NAME}");

depth = DEPTH.DEBUG;

gml_release_mode(true);

globalvar game , game_2 , _eff_c , combo , maxcombo , pec_bpm;

var time = get_timer();
bpm_count = 0;
offset_time = 0;


pec_bpm = 120;
combo = 0;
maxcombo = 0;


game = (new Phigros());
game.Resource();
game_2 = (new PEC());

instance_create_depth(0,0,0,oBG);
instance_create_depth(0,0,0,oMedia , { "name" : (game.settings.enableQuikyStart ? (InChartPath + game.folder_chart.music) : (InChartPath + "30629530.mp3")) });

game_2.Reader(game.settings.enableQuikyStart ? (InChartPath + game.folder_chart.chart) : "");
game_2.CreateLines();
//game_2.CreateLines();

cameraZoom = false;

print($"Usage Times: {(get_timer() - time) / 1000}ms");

alarm[0] = 300;