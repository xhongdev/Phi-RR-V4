/// @description 
window_set_caption($"{GAME_NAME}");
depth = DEPTH.DEBUG;
gml_release_mode(false);
globalvar game , game_1 , _eff_c , combo , maxcombo , rpe_bpm , fpsReal;
bpm_count = 0;
sec = 0;
rpe_bpm = 140;
combo = 0;
maxcombo = 0;

game = (new Phigros());
game.Resource();
fpsReal = 0;
game_1 = (new RPE());
instance_create_depth(0,0,0,oBG);
instance_create_depth(0,0,0,oMedia , { "name" : game.settings.enableQuikyStart ? (InChartPath + game.folder_chart.music) : (InChartPath + "30629530.mp3") });
game_1.Reader(game.settings.enableQuikyStart ? (InChartPath + game.folder_chart.chart) : "")
game_1.CreateLines();
cameraZoom = false;

bindUI = { // [x , y , color , alpha , rot , scaleX , scaleY]
    "name" : (array_create(7 , 0)),
    "level" : (array_create(7 , 0)),
    "bar" : (array_create(7 , 0)),
    "score" : (array_create(7 , 0)),
    "combo" : (array_create(7 , 0)),
    "combonumber" : (array_create(7 , 0))
};

fps_more = 0;
refresh_count = 0;
_re_fps = (game.settings[$ "refreshFPSCount"]);

alarm[0] = 200;