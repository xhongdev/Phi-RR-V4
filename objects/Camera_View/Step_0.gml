///@desc Camera
// 矫正摄像头
//scale_x = ((room_width / window_get_width()) - (__settings[$ "EnableCameraZoom_0_5"] ? 0.5 : 0));
//scale_y = ((window_get_width() / room_width) - (__settings[$ "EnableCameraZoom_0_5"] ? 0.5 : 0));
//scale_y = scale_x;


if(!(room_width == window_get_width()) || !(room_height == window_get_height())){
	if(!window_get_fullscreen()){
		room_width = (window_get_width());
		room_height = (window_get_height());
	}else{
		var _d_w = (display_get_width()),
		_d_h = (display_get_height());
		room_width = (_d_w);
		room_height = (_d_h);
		
		//window_set_size(_d_w,_d_h);
	};
	rm_x = room_width;
	rm_y = room_height;
};
width = (room_width);
height = (room_height);
try{
	surface_resize(application_surface ,room_width, room_height);
}catch(_e){delete(_e)};
camera_set_view_pos(_camera, (-(x + ((width / scale_x) - width)/2)), (-(y + (((height / scale_y) - height) / 2))));
camera_set_view_angle(_camera, angle);
camera_set_view_size(_camera, (width / scale_x), (height / scale_y));


//if(shake_x>0){
//	if(_shake_time_x>0){
//		_shake_time_x-=1;
//	}else{
//		if(!shake_random_x){
//			if(_shake_positive_x){
//				_shake_pos_x=shake_x;
//			}else{
//				shake_x-=shake_decrease_x;
//				_shake_pos_x=-shake_x;
//			}
//			_shake_positive_x=!_shake_positive_x;
//		}else{
//			_shake_pos_x=random_range(-shake_x,shake_x);
//			shake_x-=shake_decrease_x;
//		}
//		_shake_time_x=shake_speed_x;
//	}
//}else{
//	shake_speed_x=0;
//	shake_decrease_x=1;
//	shake_random_x=FN;
//	_shake_time_x=0;
//	_shake_pos_x=0;
//	_shake_positive_x=TY;
//}
//if(shake_y>0){
//	if(_shake_time_y>0){
//		_shake_time_y-=1;
//	}else{
//		if(!shake_random_y){
//			if(_shake_positive_y){
//				_shake_pos_y=shake_y;
//			}else{
//				shake_y-=shake_decrease_y;
//				_shake_pos_y=-shake_y;
//			}
//			_shake_positive_y=!_shake_positive_y;
//		}else{
//			_shake_pos_y=random_range(-shake_y,shake_y);
//			shake_y-=shake_decrease_y;
//		}
//		_shake_time_y=shake_speed_y;
//	}
//}else{
//	shake_speed_y=0;
//	shake_decrease_y=1;
//	shake_random_y=FN;
//	_shake_time_y=0;
//	_shake_pos_y=0;
//	_shake_positive_y=TY;
//}


//if(!instance_exists(target)){
//	camera_set_view_target(_camera,noone);
//	camera_set_view_pos(_camera,x+_shake_pos_x,y+_shake_pos_y);
//}else{

//	camera_set_view_target(_camera,target);
//	camera_set_view_border(_camera,width/scale_x/2,height/scale_y/2);
//	x=camera_get_view_x(_camera);
//	y=camera_get_view_y(_camera);
//}
//camera_set_view_size(_camera,width/scale_x,height/scale_y);
//camera_set_view_angle(_camera,angle);