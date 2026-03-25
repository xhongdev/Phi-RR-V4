/// @description 启用绘制UI事件
draw_set_halign(fa_middle);
draw_set_valign(fa_center);

draw_set_font(game.font);
draw_text_transformed_colour(room_width / 2 , 40 , "AUTOPLAY" , 0.3 , 0.3 , 0 , c_white , c_white , c_white , c_white , combo >= 3);
draw_text_transformed_colour(room_width / 2 , 90 , string(combo) , 1 , 1 , 0 , c_white , c_white , c_white , c_white , combo >= 3);

// 曲名
draw_set_halign(fa_left);
draw_set_valign(fa_center);
draw_text_transformed_colour(40 , room_height - 35 , game.folder_chart.name , font_scales , font_scales , 0 , c_white , c_white , c_white , c_white , 1);

// 难度
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text_transformed_colour(room_width - 40 , room_height - 10 , game.folder_chart.level , 0.6 , 0.6 , 0 , c_white , c_white , c_white , c_white , 1);
// 绘制分数
draw_set_valign(fa_center);
draw_text_transformed_colour(room_width - 40 , 70 , Getchartscore() , 0.85 , 0.85 , 0 , c_white , c_white , c_white , c_white , 1);

var val = (game.__time[4] / oMedia.length);
draw_sprite_ext(spr_pixel_2 , 0 , 0 , 0 , val * (room_width / 2) , 4 , 0 , c_gray , 1);
draw_sprite_ext(spr_pixel_2 , 0 , val * room_width - 2 , 0 , 1 , 4 , 0 , c_white , 1);
// ((game.__time[4] / oMedia.length) * (room_width / 2))
//print($"{game.__time[4]} | {oMedia.length} -> {game.__time[4] / oMedia.length}");
//print();