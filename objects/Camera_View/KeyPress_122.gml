/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 
window_set_fullscreen(!(window_get_fullscreen()));
if(window_get_fullscreen()){
	surface_resize(application_surface , display_get_width() , display_get_height())	
}else{
	surface_resize(application_surface , window_get_width() , window_get_height());
};