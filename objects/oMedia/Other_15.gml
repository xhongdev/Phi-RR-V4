/// @description 清理并再次初始化(循环利用一下)
event_user(7);
fmod_system_close(track);
fmod_system_release(track);
print("[C-Sound] Clean.")

event_user(0);