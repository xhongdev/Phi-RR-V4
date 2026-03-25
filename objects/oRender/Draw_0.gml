/// @description 
draw_set_font(game.font);
event_user(_draw_user_count);
draw_set_valign(fa_center);
event_user(_draw_fps_user_count);
draw_set_colour(c_gray);
draw_set_halign(fa_left);
draw_text_transformed(5 , room_height - 10 , $"@{VerStr} - Code By XTHX(PGRVersion->{game.version})" , 0.3 , 0.3 , 0);
