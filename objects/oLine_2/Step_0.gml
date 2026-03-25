/// @description 事件运行
var name = [
    "moveEvents",
    "alphaEvents",
    "rotateEvents",
    "speedEvents"
],
__x = _x,
__y = _y,
__r = _r,
__a = _a;

for(var i = 0 ; i < array_length(name) ; i ++){
    var __events = (self.events[$ name[i]]);
    
    if(!array_length(__events)) then continue;
        
    var __event = (__events[_counts[i]]);
        
    //var event = ()
    var _start0,_start1;
    switch (name[i]) {
    	case "moveEvents":
            //var val = ()
            _start0 = (__event.value[0] == "self" ? __x : __event.value[0]);
            _start1 = (__event.value[1] == "self" ? __y : __event.value[1]);
            
            __x = (tween_execute(line_time , __event.time[0] , __event.time[1] , _start0 , __event.value2[0] , __event.easingType));
            __y = (tween_execute(line_time , __event.time[0] , __event.time[1] , _start1 , __event.value2[1] , __event.easingType));
            
        break;
    
        case "alphaEvents":
            _start0 = (__event.value == "self" ? __a : __event.value);
            
            __a = (tween_execute(line_time , __event.time[0] , __event.time[1] , _start0 , __event.value2 , __event.easingType));
        break;
    
        case "rotateEvents":
            _start0 = (__event.value == "self" ? __r : __event.value);
            
            __r = (tween_execute(line_time , __event.time[0] , __event.time[1] , _start0 , __event.value2 , __event.easingType));
        break;
    
        case "speedEvents":
            
        break;
    
        default:
            continue;    
    };
};

//if(is_)
var xy = (game_2.Math.pos_to_size(__x , __y));
x = xy[0];
y = xy[1];
image_alpha = (__a / 255);
//image_angle = (__r);