/// @description 
depth = DEPTH.LINE;
sprite_index = line;
image_blend = (game.settings.enableLineJudge ? #ffeca0 : c_white);
_events = self.events;
_counts = [0 , 0 , 0 , 0];
__x = 0;
__y = 0;
__a = 0;
__r = 0;

delete(self.events);
__value = [0 , 0];
event_user(0);
event_user(1);

