/// @description 文字事件绘制
//draw_set_colour(c_white);
//depth = DEPTH.LINE - 3;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(game.font);
draw_text_transformed_colour(x , y , text , scaleX * 0.6, scaleY * 0.6  , image_angle , image_blend , image_blend , image_blend , image_blend , image_alpha);
//print($"text: {text} | xy: {[x , y]} | rot: {image_angle} | alpha: {image_alpha} | color: {color_get_red(image_blend)} {color_get_green(image_blend)} {colour_get_blue(image_blend)}");