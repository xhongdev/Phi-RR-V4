/// @description 长条绘制
if(isHold){
	//draw_sprite_ext(sprite_index , 0 , _hxy[0][0] , _hxy[0][1] , image_xscale , image_yscale, image_angle , image_blend , image_alpha);
	draw_sprite_ext(note_hold_body , hl , _hxy[0][0] , _hxy[0][1] , image_xscale , yscale, image_angle , image_blend , image_alpha);
	draw_sprite_ext(note_hold_end , hl , _hxy[1][0] , _hxy[1][1] , image_xscale , image_yscale, image_angle , image_blend , image_alpha);
}else{
	draw_sprite_ext(sprite_index , hl , _hxy[0][0] , _hxy[0][1] , image_xscale , image_yscale, image_angle , image_blend , image_alpha);
	draw_sprite_ext(note_hold_body , hl , _hxy[1][0] , _hxy[1][1] , image_xscale , yscale, image_angle , image_blend , image_alpha);
	draw_sprite_ext(note_hold_end , hl , _hxy[2][0] , _hxy[2][1] , image_xscale , image_yscale, image_angle , image_blend , image_alpha);
};