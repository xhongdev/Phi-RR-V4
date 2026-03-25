/// @description 非文字事件绘制
var __scales = [
    scaleX * _scales * 0.8,
    scaleY * _scales * 0.8
]
if(sprite_index == line){
    __scales[0] = (__scales[0] * 1.18);
    __scales[1] = (__scales[1] * 0.65);
}
draw_sprite_ext(sprite_index , 0 , x , y , __scales[0], __scales[1], image_angle , image_blend , image_alpha);
