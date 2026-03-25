/// @description BG绘制
if(sprite_exists(game.bg) && game.settings.showBG){
	event_user(0);
	var _1 = (window_get_fullscreen());
	var ___ = [ (_1 ? display_get_width() : window_get_width()) , (_1 ? display_get_height() : window_get_height()) ];
	var _ = [___[0] / sprite_get_width(game.bg) , ___[1] / sprite_get_height(game.bg)],
		__ = (_[0] - _[1] ? _[1] : _[0]);
		
	surface_set_target(surface);
	
	draw_clear_alpha(c_black, 0);
	draw_sprite_ext(game.bg , 0 , room_width / 2 , room_height / 2 , __ , __ , 0 , c_white , 1);
	
	surface_reset_target();
	
	
	if(enableBlur){
		shader_set(blur);
	
		// 设置着色器参数
	    var blur_uniform = shader_get_uniform(blur, "u_blur_amount");
	    var size_uniform = shader_get_uniform(blur, "u_texture_size");
		var kel_uniform = (shader_get_uniform(blur , "u_kernel_radius"));
		if(kel_uniform != -1){
			shader_set_uniform_f(kel_uniform , 1);	
		};
	
	    if (blur_uniform != -1) {
	        shader_set_uniform_f(blur_uniform, 3.0);
	    };
    
	    if (size_uniform != -1) {
	        var tex_width = surface_get_width(surface);
	        var tex_height = surface_get_height(surface);
	        shader_set_uniform_f(size_uniform, tex_width, tex_height);
	    };
		draw_surface(surface , 0 , 0);
	
	    shader_reset();
	}else draw_surface(surface , 0 , 0);
	draw_sprite_ext(spr_black , 0 , window_get_width() / 2 , window_get_height() / 2 , (window_get_width() / room_width) , (window_get_height() / room_height) , 0 , c_black , 0.6);	
};