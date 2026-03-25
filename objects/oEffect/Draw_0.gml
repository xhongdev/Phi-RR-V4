/// @description 
if(!(game.paused)){
	//depth = DEPTH.HIT_FX;
	part_type_sprite(_hitFX,effect,true,0,0);
	repeat(clamp(floor( delta_time / 16666.67 ) , 1 , infinity))
		part_system_update(p1);

}else{
	part_type_sprite(_hitFX,effect,false,0,0);
};
part_system_drawit(p1);