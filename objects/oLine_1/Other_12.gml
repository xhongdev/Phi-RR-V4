///@desc 主线事件运行&index递进

//exit;

if(is_undefined(self.events) && is_undefined(self.extEvents)) then exit;

// 每个事件值
var _r_x = 0,
    _r_y = 0,
    _r_r = 0,
    _r_a = 0;

// 总和 
var _t_x = 0,
    _t_y = 0,
    _t_a = 0,
    _t_r = 0,
    _t_c = c_white,
    _t_sx = 1,
    _t_sy = 1;

/*
var _t_x = 0,
    _t_y = 0,
    _t_a = 0,
    _t_r = 0,
    _t_c = c_white,
    _t_sx = 1,
    _t_sy = 1;
*/

var eventLayers = (self.events),
	spEvents = (self.extEvents);

if(!is_undefined(eventLayers)){
	for(var i = 0 ; i < array_length(eventLayers) ; i ++){
		if(is_undefined(eventLayers[i])) then continue;
		
		// 获取值
		//_r_x = (events_values[@ i].moveXEvents);
		//_r_y = (events_values[@ i].moveYEvents);
		//_r_r = (events_values[@ i].rotateEvents);
		//_r_a = (events_values[@ i].alphaEvents);
		
		// 检测事件是否存在
		var _ex = false,
			_ey = false,
			_er = false,
			_ea = false;
		
		var names = (variable_struct_get_names(eventLayers[i]));
		for(var l = 0 ; l < array_length(names) ; l ++){
			
			// 获取事件信息
			var event_name = (names[@ l]);
			if(event_name == "speedEvents"){ continue; };
			
			var _index = (events_count[@ i][$ event_name]),
				events = (eventLayers[@ i][$ event_name]),
				aaa = false,
				bbb = 0;
				
			var events_len = (array_length(events));
			_index = (clamp( _index , 0 , events_len - 1 ));
			/// 事件index
			if((events_len - 1) > (_index + 1)){
				if((events[_index][$ "endTime"] > events[_index + 1][$ "startTime"]) && (events[_index + 1][$ "startTime"] <= line_time)){
					aaa = true;
					_index ++;
				};
			};
			
			
			while((_index > 0) && (line_time < events[_index][$ "startTime"])){
				if((events[_index - 1][$ "endTime"] < line_time) && (!aaa)) { bbb = 1; break; };
				
				_index --;
				
			};
			
			while(((events_len - 1) > _index) && (line_time > events[_index][$ "endTime"])){
				//if(self.line_id == 0){ print($"{event_name}: Ins..."); aaa = true; bbb = _index};
				if(bbb) { break; };
				_index ++;	
				
			};
			
			_index = (clamp( _index , 0 , events_len - 1 ));
			
			events_count[@ i][$ event_name] = _index;
			if(_index - 1 >= 0){
				//if(_index == (events_len - 1)){
				//	events_values[@ i][$ event_name] = (events[@ (events_len - 2)][$ "end"]);	
				//}else{
				if(aaa) then events_values[@ i][$ event_name] = (events[@ (_index)][$ "end"]);
				else events_values[@ i][$ event_name] = (events[@ (_index - 1)][$ "end"]);	
				//};
			};
			
			var index = (events_count[@ i][$ event_name]);
			if(aaa){
				print($"{event_name}: Old[{bbb}] - Now[{index}] - Len[{events_len}]");	
			};
			
			//print(1111);
			
			/// 事件运行部分
			
			
			if(!is_array(events)){
				print($"Line[{self.line_id}] -> EventLayer[{i}]: {event_name} is no array");
				continue;
			};
			
			
			
			if((events_len - 1) < index){
				print($"Line[{self.line_id}] -> EventLayer[{i}]: {event_name} -> Index[{index}] out of length[{events_len}]");
				continue;
			}elif(index < 0){
				print($"Line[{self.line_id}] -> EventLayer[{i}]: {event_name} -> Index[{index}] out of -1]");
				continue;
			};
			var event = (events[@ index]);
			
			var stime = (event[$ "startTime"]),
				etime = (event[$ "endTime"]),
				_eval = (events_values[@ i][$ event_name]);
			
			
			
			if(line_time < stime || bbb) {
				switch(event_name){
					case "moveXEvents":
						_r_x = (_eval);
						_ex = true;
					break;
					
					case "moveYEvents":
						_r_y = (_eval);
						_ey = true;
					break;
					
					case "alphaEvents":
						_r_a = (_eval);
						_ea = true;
					break;
					
					case "rotateEvents":
						_r_r = (_eval);
						_er = true;
					break;
				};
				
				continue;
			};
			
			
			var sval = (event[$ "start"]),				
				type = (event[$ "easingType"]),
				eval = (event[$ "end"]),
				eLeft = (event[$ "easingLeft"]),
				eRight = (event[$ "easingRight"]),
				tval = (tween_execute(line_time , stime , etime , sval , eval , type , eLeft , eRight)),
				_re_value = (events_recall_values[@ i][$ event_name]);
				
			//if((line_time >= stime && line_time <= etime)){
			switch(event_name){
				case "moveXEvents":
					_r_x = tval;
					if(!is_finite(_r_x)){
						_r_x = (_re_value);
					}else events_recall_values[@ i][$ event_name] = (tval);//_r_x = 0//_eval;
					_ex = true;
				break;
				
				case "moveYEvents":
					_r_y = tval;
					if(!is_finite(_r_y)){
						_r_y = (_re_value);
					}else events_recall_values[@ i][$ event_name] = (tval);//then _r_y = 0//_eval;
					_ey = true;
				break;
					
				case "alphaEvents":
					_r_a = tval;
					if(!is_finite(_r_a)){
						_r_a = (_re_value);
					}else events_recall_values[@ i][$ event_name] = (tval);//then _r_a = 0//_eval;
					_ea = true;
				break;
					
				case "rotateEvents":
					_r_r = tval;
					if(!is_finite(_r_r)){
						_r_r = (_re_value);
					}else events_recall_values[@ i][$ event_name] = (tval);//then _r_r = 0//_eval;
					_er = true;
				break;
			//};
			};
		};
		
		// IDK NU
		if(!_ex) then _r_x = (events_values[@ i][$ "moveXEvents"]);
		if(!_ey) then _r_y = (events_values[@ i][$ "moveYEvents"]);
		if(!_ea) then _r_a = (events_values[@ i][$ "alphaEvents"]);
		if(!_er) then _r_r = (events_values[@ i][$ "rotateEvents"]);
		
		// 累加
		_t_x += _r_x;
		_t_y += _r_y;
		_t_a += _r_a;
		_t_r += _r_r;
	
	
		// 归零
		_r_x = 0;
		_r_y = 0;
		_r_a = 0;
		_r_r = 0;
	
		// 特殊层
		if(i == 0 && (!is_undefined(spEvents))){
			var _names = (variable_struct_get_names(spEvents));
			//if(array_length(_names) == 0) then 
			var len = (array_length(_names));
			if(len){
				//for(var e = 0 ; e < len ; e ++){
				//	var event_name = (_names[e]);	
				//};
			};
		};
	
	};
};

//if(_t_x == 0) then _t_x = (events_end_values.moveXEvents);
//if(_t_y == 0) then _t_y = (events_end_values.moveYEvents);
//if(_t_a == 0) then _t_a = (events_end_values.alphaEvents);
//if(_t_r == 0) then _t_r = (events_end_values.rotateEvents);

//events_end_values.moveXEvents = (_t_x);
//events_end_values.moveYEvents = (_t_y);
//events_end_values.alphaEvents = (_t_a);
//events_end_values.rotateEvents = (_t_r);

var pos = (get_window_pos_scale(_t_x , _t_y));
x = pos[0];
y = pos[1];
image_angle = (-_t_r);
image_alpha = (_t_a / 255);
image_xscale = _t_sx;
image_yscale = _t_sy;
image_blend = _t_c;


