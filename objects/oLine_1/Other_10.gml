///@desc 线初始化
scaleX = 1;
scaleY = 1;
_scales = 1;


//var init_struct = {
    //"moveXEvents": 0,
    //"moveYEvents": 0,
    //"alphaEvents": 0,
    //"rotateEvents": 0,
    //"speedEvents": 0,
    //"colorEvents": c_white,
    //"scaleXEvents": 1,
    //"scaleYEvents": 1,
    //"textEvents": "",
    //"paintEvents": 0,
    //"inclineEvents": 0,
    //"gifEvents": 0
//};
//events_count = array_create(array_length(self.events), init_struct);
//events_values = array_create(array_length(self.events), init_struct);
//events_error_revalues = array_create(array_length(self.events), init_struct);
//events_count = (array_create(array_length(self.events) , {
    //"moveXEvents" : 0,
    //"moveYEvents" : 0,
    //"alphaEvents" : 0,
    //"rotateEvents" : 0,
    //"speedEvents" : 0,
    //"colorEvents" : 0,
    //"scaleXEvents" : 0,
    //"scaleYEvents" : 0,
    //"textEvents" : 0,
    //"paintEvents" : 0,
    //"inclineEvents" : 0,
    //"gifEvents" : 0
//}));
//
//events_values = (array_create(array_length(self.events) , {
    //"moveXEvents" : 0,
    //"moveYEvents" : 0,
    //"alphaEvents" : 0,
    //"rotateEvents" : 0,
    //"speedEvents" : 0,
    //"colorEvents" : c_white,
    //"scaleXEvents" : 1,
    //"scaleYEvents" : 1,
    //"textEvents" : "",
    //"paintEvents" : 0,
    //"inclineEvents" : 0,
    //"gifEvents" : 0
//}));
//
//events_error_revalues = (array_create(array_length(self.events) , {
    //"moveXEvents" : 0,
    //"moveYEvents" : 0,
    //"alphaEvents" : 0,
    //"rotateEvents" : 0,
    //"speedEvents" : 0,
    //"colorEvents" : c_white,
    //"scaleXEvents" : 1,
    //"scaleYEvents" : 1,
    //"textEvents" : "",
    //"paintEvents" : 0,
    //"inclineEvents" : 0,
    //"gifEvents" : 0
//})); 
//
//ext_events_values = {
    //"colorEvents" : c_white,
    //"scaleXEvents" : 1,
    //"scaleYEvents" : 1
//};

// HYWA
//array_set(events_values , 0 , {
    //"moveXEvents" : 0,
    //"moveYEvents" : 0,
    //"alphaEvents" : 0,
    //"rotateEvents" : 0,
    //"speedEvents" : 0,
    //"colorEvents" : c_white,
    //"scaleXEvents" : 1,
    //"scaleYEvents" : 1,
    //"textEvents" : "",
    //"paintEvents" : 0,
    //"inclineEvents" : 0,
    //"gifEvents" : 0
//});
//
//array_set(events_count , 0 , {
    //"moveXEvents" : 0,
    //"moveYEvents" : 0,
    //"alphaEvents" : 0,
    //"rotateEvents" : 0,
    //"speedEvents" : 0,
    //"colorEvents" : 0,
    //"scaleXEvents" : 0,
    //"scaleYEvents" : 0,
    //"textEvents" : 0,
    //"paintEvents" : 0,
    //"inclineEvents" : 0,
    //"gifEvents" : 0
//})

events_count = (array_create(array_length(self.events) , {
    "moveXEvents" : 0,
    "moveYEvents" : 0,
    "alphaEvents" : 0,
    "rotateEvents" : 0,
    "speedEvents" : 0
}));

events_values = (array_create(array_length(self.events) , {
    "moveXEvents" : 0,
    "moveYEvents" : 0,
    "alphaEvents" : 0,
    "rotateEvents" : 0,
    "speedEvents" : 0
}));

events_recall_values = (array_create(array_length(self.events) , {
    "moveXEvents" : 0,
    "moveYEvents" : 0,
    "alphaEvents" : 0,
    "rotateEvents" : 0,
    "speedEvents" : 0
}));

events_end_values = ({
    "moveXEvents" : 0,
    "moveYEvents" : 0,
    "alphaEvents" : 0,
    "rotateEvents" : 0,
    "speedEvents" : 0
});

ext_events_count = {
    "colorEvents" : 0,
    "scaleXEvents" : 0,
    "scaleYEvents" : 0,
    "textEvents" : 0,
    "paintEvents" : 0,
    "inclineEvents" : 0,
    "gifEvents" : 0
};

ext_events_values = {
    "colorEvents" : c_white,
    "scaleXEvents" : 1,
    "scaleYEvents" : 1,
    "textEvents" : "",
    "paintEvents" : 0,
    "inclineEvents" : 0,
    "gifEvents" : 0
};

var _sort = (func(x1 , x2){
    if(x1.startTime < x2.startTime) then return(-1); 
        
    elif(x1.startTime > x2.startTime) then return(1); 
        
	else
    return(0);        
	//return(x1.startTime - x2.startTime);
});

// 码了个B , 谁发明的数组beat
for(var i = 0 ; i < array_length(self.events) ; i ++){
    if(is_undefined(self.events[@ i])) { 
        //print($"events: {self.events}\nindex: {i}\nLength: {array_length(self.events)}"); 
        continue; 
    };
        
    var names = (struct_get_names(self.events[@ i]));
    for(var ii = 0 ; ii < array_length(names) ; ii ++){
        var _events = (self.events[i][$ names[ii]]);
        array_foreach(_events , func(val , index){
            if(struct_exists(val , "startTime") && is_array(val[$ "startTime"])) then val.startTime = (game_1.Math.arrToBeat(val.startTime));
                
            if(struct_exists(val , "endTime") && is_array(val[$ "endTime"])) then val.endTime = (game_1.Math.arrToBeat(val.endTime));
        });
        array_sort(self.events[i][$ names[ii]] , _sort);
    };
};

struct_foreach(self.extEvents , func(name , val){
    array_foreach(val , func(val , index){
        if(struct_exists(val , "startTime") && is_array(val[$ "startTime"])) then val.startTime = (game_1.Math.arrToBeat(val.startTime));
                
        if(struct_exists(val , "endTime") && is_array(val[$ "endTime"])) then val.endTime = (game_1.Math.arrToBeat(val.endTime));
    });
    array_sort(val , (func(x1 , x2){
        if(x1.startTime < x2.startTime) then return(-1); 
             
        if(x1.startTime > x2.startTime) then return(1); 
                     
        return(0);        
    }));
});


//struct_set(self.events[0] , "extEvents" , (self.extEvents ?? {}) );

//var ext = (self.extEvents);
if(struct_exists(self.extEvents , "textEvents")){
    _draw_user_count = 7;
    text = "";
    sprite_index = spr_gunmu;
    
}elif(self.image != "line.png"){
    if(file_exists($"{InChartPath}{self.image}")){
        sprite = (sprite_add($"{InChartPath}{self.image}" , 1 , false , false , 0 , 0 ));
        if(sprite_exists(sprite)){
            sprite_index = sprite;
            print($"Line[{self.line_id}] Texture: Successed to Load \"{self.image}\" Image. " , game.settings.enableDebug);
        }else{
            sprite_index = spr_gunmu;
            print($"Line[{self.line_id}] Texture: Failed to Load \"{self.image}\" Image. " , game.settings.enableDebug);
        }
    }else{
        sprite_index = spr_gunmu;
        print($"Line[{self.line_id}] Texture: Non-Image called \"{self.image}\" " , game.settings.enableDebug);
    };
};

//delete(self.extEvents);

//print($"Line[{self.line_id}]: {self.events[0].extEvents}");

line_debug = false;

/*
var ext_names = (struct_get_names(self.extEvents));
for(var l = 0 ; l < array_length(ext_names) ; l ++){
    
}

//print(events_count);
if(self.line_id == 0 || self.line_id == 1 || self.line_id == 2 || self.line_id == 3 || self.line_id == 4) then print(self.events);