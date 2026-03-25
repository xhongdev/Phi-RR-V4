/// @description 事件启用变量
_draw_user_count = (game.settings.enableChartGUI ? 1 : 0); // 绘制GUI
_draw_fps_user_count = (game.settings.enableFPS ? 3 : 0); // 绘制FPS
_step_fps_user_count = (game.settings.enableFPS ? 4 : 0); // 刷新实际FPS

_re_fps = (game.settings[$ "refreshFPSCount"]);