/// @description 绘制FPS

draw_set_halign(fa_right);
draw_set_colour(c_white);
draw_text_transformed(room_width , 30 , $"{ceil(fpsReal)}({fps})" , 0.35 , 0.35 , 0);