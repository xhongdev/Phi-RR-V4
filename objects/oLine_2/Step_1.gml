/// @description 事件偏移矫正
line_time = (game_2.Math.secToBeat(game.__time[1] , pec_bpm));
var name = [
    "moveEvents",
    "alphaEvents",
    "rotateEvents",
    "speedEvents"
];//(struct_get_names(self.events))
for(var i = 0 ; i < array_length(name) ; i ++){
    var _events = (self.events[$ name[i]]);
    
    //for(var l = 0 ; l < array_length(_events) ; l ++){
    var count = (_counts[i]),
        len = (array_length(_events));
    //var _event = (_events[count]);
        //if(_events.startT)
    while(line_time < _events[count].time[0] && count > 0){
        if(line_time > _events[count - 1].time[1]) then break;
        count --;
    };
    
    while(line_time > _events[count].time[1] && len - 1 > count){
        //if(line_time < _events[count + 1].time[0]) then break;
        switch (name[i]) {
            case "moveEvents":
                _x = (number(_events[count].value2[0] , 0));
                _y = (number(_events[count].value2[1] , 0));
            break;
            
            case "alphaEvents":
                _a = (number(_events[count].value2 , 0));
            break;
            
            case "rotateEvents": 
                _r = (number(_events[count].value2 , 0));
            break;    
        };
        count ++;
    };
    
    array_set(_counts , i , count);
    //};
};