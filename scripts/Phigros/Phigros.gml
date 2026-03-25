// 辅助宏常量
#macro print LogOutputFile
#macro elif else if
#macro func function
#macro isExists file_exists
#macro InChartPath $"{working_directory}chart/"
#macro VerReal 40301
#macro VerStr "v.4.0.3"
#macro GAME_NAME $"Re: Phi-RR - {VerStr}"

// 测试代码(实验性)
//scheduler_resolution_set(800000000000);
gpu_set_texfilter(true);

//string_format()
// 图层枚举
enum DEPTH {
	DEBUG = -1000,
	LINE = -500,
	NOTE = -600,
	HEF = -700,
	BG = -100
};

// 额外参数
var cmd_count = (parameter_count()),
	cmd = 1;
	
repeat(cmd_count){
	var _cmd = (parameter_string(cmd));
	switch(_cmd){
		case "-debug":
			MsgBox_Info("Enable Debugger." , "Infomation"); //show_message_async("")
		break;
	};
	
	cmd ++;
};

//func G_Configs() constructor{
//	static folder_chart = { 
//		"name" : "Unknown",
//		"level" : "SP Lv.?",
//		"music" : "",
//		"chart" : "",
//		"bg" : ""
//	};
	
//	static settings = {
//		"enableBlur" : false,
//		"enableFPS" : true,
//		"enableQuikyStart" : false,
//		"enableCanvasZoom" : false,
//		"enableSurface" : false,
//		"enableNoteHightLight" : false,
//		"enableChartGUI" : true,
//		"enableLineJudge" : false,
//		"showBG" : true,
//		"enableHitEffect" : true
//	};
	
//	///@desc 字符串转整数
//	static strToReal = (func(str , default_value = undefined){
//		if(string_lower(str) == "false") then return(0);
//		if(string_lower(str) == "true") then return(1);
//		if(string_lower(str) == "undefined") then return(undefined);
//		try{ return(real(str)) }
//		catch(e){ return(default_value) };
//	});
	
//	static realToStrBool = (func(_real){
//		if(!is_real(_real)) then return("undefined");
//		if(bool(_real) == true) then return("true");
//		else return("false");
//	});
//};


///@desc Phigros Official谱面主结构
func Phigros() constructor{
	// 源谱面
	static chart = undefined;
	static version = 0;
	static line_list = [];
	// [谱面开始播放时间(单位: 微秒) , 实时时间(单位: 秒) , 开始暂停时间(单位: 微秒) , 实际暂停时间(单位: 微秒) , 结束暂停时间(单位: 微秒)] 
	static __time = (array_create(6 , 0)); 
	static paused = true;
	static _notes = [];
	// 配置相关
	static notes = ({});
	static font = (font_add($"{working_directory}resource/saira.ttf" , 45 , true , false , -infinity , infinity));
	font_enable_sdf(font , true);
	static res_path = {};
	static effc = undefined;
	static folder_chart = { 
		"name" : "Unknown",
		"level" : "SP Lv.?",
		"music" : "",
		"chart" : "",
		"bg" : ""
	};
	static bg = undefined;
	static settings = {
		"enableBlur" : false,
		"enableFPS" : true,
		"enableQuikyStart" : true,
		"enableCanvasZoom" : false,
		"enableSurface" : false,
		"enableNoteHightLight" : true,
		"enableChartGUI" : false,
		"enableLineJudge" : false,
		"showBG" : false,
		"enableHitEffect" : true,
		"refreshFPSCount" : 60,
		"enableDebug" : true
	};
	
	
	/// 静态函数
	
	///@desc 字符串转浮点数
	static strToReal = (func(str , default_value = undefined){
		if(string_lower(str) == "false") then return(0);
		if(string_lower(str) == "true") then return(1);
		if(string_lower(str) == "undefined") then return(undefined);
		try{ return(real(str)) }
		catch(e){ return(default_value) };
	});
	
	///@desc 浮点数转字符串形式布尔值
	static realToStrBool = (func(_real){
		if(!is_real(_real)) then return("undefined");
		if(bool(_real) == true) then return("true");
		else return("false");
	});
	
	///@desc 读取函数
	///@arg Chart {String} 谱面文件地址
	static Reader = (func(_chart = ""){
		var f = (string_length(_chart) ? _chart : ($"{working_directory}chart/Chart_IN.json"));
		var buff = (buffer_load(f)),
			r = (buffer_read(buff , buffer_string));
		//return(f);
		self.chart = (json_parse(r));
		game.version = (self.chart.formatVersion);
		delete(r);
		buffer_delete(buff);
		for(var i = 0 ; i < array_length(self.chart.judgeLineList) ;  i ++){
			//array_push(self._notes , []);
			if(game.version == 1){
				for(var m = 0 ; m < array_length(self.chart.judgeLineList[i].judgeLineMoveEvents) ; m ++){
					var l_m = (self.chart.judgeLineList[i].judgeLineMoveEvents[m]);
					var r_m = (game.Math.posCovert({
						"start" : l_m.start,
						"end" : l_m[$ "end"]
					}));
					self.chart.judgeLineList[i].judgeLineMoveEvents[m][$ "start"] = r_m.start;
					self.chart.judgeLineList[i].judgeLineMoveEvents[m][$ "end"] = r_m[$ "end"];
					self.chart.judgeLineList[i].judgeLineMoveEvents[m][$ "start2"] = r_m.start2;
					self.chart.judgeLineList[i].judgeLineMoveEvents[m][$ "end2"] = r_m.end2;
				};
			};
			
			var bpm = (self.chart.judgeLineList[i].bpm);
			for(var a = 0 ; a < array_length(self.chart.judgeLineList[i].notesAbove) ; a ++){
				var n = (self.chart.judgeLineList[i].notesAbove[a]);
				array_add(self._notes , { "type" : n.type , "time" : n.time , "holdTime" : (n.type == 3 ? n.holdTime : 0) , "speed" : n[$ "speed"] , "xOffset" : n.positionX , "yOffset" : n.floorPosition , "hl" : false , "isAbove" : true , "id" : i , "bpm" : bpm});
			};
			
			for(var b = 0 ; b < array_length(self.chart.judgeLineList[i].notesBelow) ; b ++){
				var n = (self.chart.judgeLineList[i].notesBelow[b]);
				array_add(self._notes , { "type" : n.type , "time" : n.time , "holdTime" : (n.type == 3 ? n.holdTime : 0) , "speed" : n[$ "speed"] , "xOffset" : n.positionX , "yOffset" : n.floorPosition , "hl" : false , "isAbove" : false , "id" : i , "bpm" : bpm});
			};
			delete(self.chart.judgeLineList[i].notesAbove);
			delete(self.chart.judgeLineList[i].notesBelow);
		};
		array_set(game.__time, 5, self.chart.offset * 1000000);
		print("[R-Chart] Done." , game.settings.enableDebug);
		return(true);
	});
	
	///@desc 整理函数
	static Sort = (func(){
		//print(array_length(game.__time));
		for(var i = 0 ; i < array_length(self.chart.judgeLineList) ; i ++){
			array_sort(self.chart.judgeLineList[i].judgeLineMoveEvents , func(x1 , x2){
				return(x1.startTime - x2.startTime);
			});	
			array_sort(self.chart.judgeLineList[i].judgeLineRotateEvents , func(x1 , x2){
				return(x1.startTime - x2.startTime);
			});
			array_sort(self.chart.judgeLineList[i].judgeLineDisappearEvents , func(x1 , x2){
				return(x1.startTime - x2.startTime);
			});
			array_sort(self.chart.judgeLineList[i].speedEvents , func(x1 , x2){
				return(x1.startTime - x2.startTime);
			});
			
			//array_sort(self.chart.judgeLineList[i].notesBelow , func(x1 , x2){
			//	if(x1.time == x2.time){
			//		struct_set(x1 , "hl" , true);
			//		struct_set(x2 , "hl" , true);
			//	};
			//	return(x1.time - x2.time);
			//});
		};
		if(game.settings.enableNoteHightLight){
			array_sort(self._notes , func(x1 , x2){
				if(x1.time == x2.time){
					struct_set(x1 , "hl" , true);
					struct_set(x2 , "hl" , true);
				};
				return(x1.time - x2.time);
			});
		};
		print("[S-Sort] Done." , game.settings.enableDebug);
	});
	
	///@desc 加载背景图
	///@desc Path {String} 背景图地址
	static Background = (func(custom = ""){
		var p = (string_length(custom) ? custom : ($"{working_directory}chart/illustration.png"));
		game.bg = (sprite_add(p , 1 , false , false , 0 , 0));
		if(sprite_exists(game.bg)) then sprite_set_offset(game.bg , sprite_get_width(game.bg) / 2 , sprite_get_height(game.bg) / 2);
		print($"[R-BG] {sprite_exists(game.bg) ? "Done." : "Failed."}" , game.settings.enableDebug);
	});
	
	///@desc 配置加载器
	static Configs = (func(){
		var f = $"{working_directory}resource/configs.ini";
		//if(isExists(f)){
		ini_open(f);
		if(!isExists(f)){
			print("[F-Configs] No Found 'configs.ini' file" , game.settings.enableDebug);
			
			// Resource
			ini_write_string("Resource" , "note.tap" , $"{working_directory}resource/note_tap.png");
			ini_write_string("Resource" , "note.flick" , $"{working_directory}resource/note_flick.png");
			ini_write_string("Resource" , "note.drag" , $"{working_directory}resource/note_drag.png");
			ini_write_string("Resource" , "note.hold.head" , $"{working_directory}resource/hold_head.png");
			ini_write_string("Resource" , "note.hold.body" , $"{working_directory}resource/hold_body.png");
			ini_write_string("Resource" , "note.hold.end" , $"{working_directory}resource/hold_end.png");
			ini_write_string("Resource" , "font.ui" , $"{working_directory}resource/saira.ttf");
			ini_write_string("Resource" , "effc.hit" , $"{working_directory}resource/effect.png");
			
			// Settings
			var _name = (struct_get_names(self.settings));
			for(var l = 0 ; l < array_length(_name) ; l ++){
				ini_write_string("Settings" , _name[l] , self.settings[$ _name[l]]);
			};
			
			_name = (struct_get_names(self.folder_chart));
			for(var l = 0 ; l < array_length(_name) ; l ++){
				ini_write_string("Chart" , _name[l] , self.folder_chart[$ _name[l]]);
			};
			delete(self.folder_chart);
			//ini_write_string("Settings" , "enableFPS" , "false");
			//ini_write_string("Settings" , "enableBlur" , "false");
		};
		///
		self.res_path[$ "note.tap"] = (ini_read_string("Resource" , "note.tap" , $"{working_directory}resource/note_tap.png"));
		self.res_path[$ "note.flick"] = (ini_read_string("Resource" , "note.flick" , $"{working_directory}resource/note_flick.png"));
		self.res_path[$ "note.drag"] = (ini_read_string("Resource" , "note.drag" , $"{working_directory}resource/note_drag.png"));
		self.res_path[$ "note.hold.head"] = (ini_read_string("Resource" , "note.hold.head" , $"{working_directory}resource/hold_head.png"));
		self.res_path[$ "note.hold.body"] = (ini_read_string("Resource" , "note.hold.body" , $"{working_directory}resource/hold_body.png"));
		self.res_path[$ "note.hold.end"] = (ini_read_string("Resource" , "note.hold.end" , $"{working_directory}resource/hold_end.png"));
		self.res_path[$ "font.ui"] = (ini_read_string("Resource" , "font.ui" , $"{working_directory}resource/saira.ttf"));
		self.res_path[$ "effc.hit"] = (ini_write_string("Resource" , "effc.hit" , $"{working_directory}resource/effect.png"));
		
		///
		var name = (struct_get_names(self.settings));
		for(var i = 0 ; i < array_length(name) ; i ++){
			self.settings[$ name[i]] = (self.strToReal(ini_read_string("Settings" , name[i] , self.settings[$ name[i]])));	
		};
		if(self.settings.enableQuikyStart){
			var _name = (struct_get_names(self.folder_chart));
			for(var i = 0 ; i < array_length(_name) ; i ++){
				self.folder_chart[$ _name[i]] = (ini_read_string("Chart" , _name[i] , self.folder_chart[$ _name[i]]));	
			};
		}else delete(self.folder_chart);
		//self.settings[$ "enable"]
		self.settings[$ "refreshFPSCount"] = (clamp(self.settings[$ "refreshFPSCount"] , 1 , 300));
		ini_close();
		print("[R-Configs] Done." , self.settings.enableDebug);
	});
	
	//static Img = (func(){
	//	var name = [
	//		"note.tap",
	//		"note.drag",
	//		"note.flick",
	//		"note.hold.head",
	//		"note.hold.body",
	//		"note.hold.end",
	//		"font.ui",
	//		"effc.hit"
	//	];
		
	//	// LLLLLLLOAD
	//	for(var i = 0 ; i < array_length(name) ; i ++){
	//		if(isExists(self.res_path[$ name[i]])){
	//			var type = (string_copy(self.res_path[$ name[i]] , 1 , 4)),
	//				_name = (string_copy(self.res_path[$ name[i]] , 4 , string_length(self.res_path[$ name[i]])));
				
	//			switch(type){
	//				case "note":
	//					if(!struct_exists(self.notes , "hold.head")) then self.notes[$ "note.hold"] = (array_create(3 , undefined));
						
	//					if(_name == "hold.head"){
	//						//game.notes[$ "note.hold"][0] = (sprite_add(self.res_path[$ name[i]] , 3 , false , false , 0 , 0));
	//						//sprite_set_offset(self.notes[$ "note.hold"][0] , sprite_get_width(self.notes[$ "note.hold"][0]) / 2 , sprite_get_height(self.notes[$ "note.hold"][0]));
	//					}elif(_name == "hold.body"){
	//						//game.notes[$ "note.hold"][1] = (sprite_add(self.res_path[$ name[i]] , 3 , false , false , 0 , 0));
	//						//sprite_set_offset(self.notes[$ "note.hold"][1] , sprite_get_width(self.notes[$ "note.hold"][1]) / 2 , sprite_get_height(self.notes[$ "note.hold"][1]));
	//					}elif(_name == "hold.end"){
	//						//game.notes[$ "note.hold"][2] = (sprite_add(self.res_path[$ name[i]] , 3 , false , false , 0 , 0));
	//						//sprite_set_offset(self.notes[$ "note.hold"][2] , sprite_get_width(self.notes[$ "note.hold"][2]) / 2 , sprite_get_height(self.notes[$ "note.hold"][2]));
	//					}else{
	//						//game.notes[$ name[i]] = (sprite_add(self.res_path[$ name[i]] , 3 , false , false , 0 , 0));
	//						//sprite_set_offset(self.notes[$ name[i]] , sprite_get_width(self.notes[$ name[i]]) / 2 , sprite_get_height(self.notes[$ name[i]]));
	//					};
	//				break;
					
	//				case "font":
	//					game.font = (font_add(self.res_path[$ name[i]] , 25 , false , false , -infinity , infinity));
	//				break;
					
	//				case "effc":
	//					game[$ type] = (sprite_add(self.res_path[$ name[i]] , 30 , false , false , 0 , 0));
	//					//sprite_set_offset(self[$ type] , sprite_get_width(self[$ type]) / 2 , sprite_get_height(self[$ type]));
	//				break;
	//			};
	//			print($"[L-Image] Loaded {name[i]}");
	//		}else print($"[F-Image] No Found '{self.res_path[$ name[i]]}'");
	//	};
	//	print(self.notes);
	//	// Free
	//	delete(self.res_path);
	//});
	
	///@desc 内置资源执行器
	static Resource = (func(){
		self.Configs();
		//self.Img();
		self.Background(game.settings.enableQuikyStart ? (InChartPath + game.folder_chart.bg) : "");
		
		print("[L-Resource] Done." , game.settings.enableDebug);
	});
	
	///@desc 清理资源
	///@arg full {Bool} 是否完全清理
	static Clean = (func(full = false){
		if(sprite_exists(game.bg)){
			sprite_delete(game.bg);	
		};
		
		while(game.chart != undefined) { delete(game.chart); game.chart = undefined; };
		if(instance_exists(oLine)){
			instance_destroy(oLine);	
		};
		if(instance_exists(oNote)){
			instance_destroy(oNote);	
		};
		
		if(full){
			struct_foreach(game.notes , function(name , values){
				if(!is_array(values)){
					if(sprite_exists(values)) then sprite_delete(values);
				}else{
					for(var i = 0 ; i < array_length(values) ; i ++){
						if(sprite_exists(values[i])) then sprite_delete(values[i]);	
					};
				};
			});	
			delete(game.notes);
			if(font_exists(game.font)){
				font_delete(game.font);
			};
			if(sprite_exists(game.effc)){
				sprite_delete(game.effc);	
			};
			
		};
		print($"[D-Clean] {full ? "Full Clean Done." : "Done."}" , game.settings.enableDebug);
	});
	
	///@desc 谱面数学函数
	static Math = ({
		
		///@desc 计算谱面时间
		timer : (func(bpm , rtime){
			//print($"timer: {array_length(game.__time)}");
			return(rtime / (1.875 / bpm));
		}),
		
		///@desc 计算实时时间
		realTimer : (func(bpm , ctime){
			//print($"rtimer: {array_length(game.__time)}");
			return((ctime * 1.875) / bpm);
		}),
		
		///@desc 获取实时时间并赋值time数组第index个 
		now : (func(index = 1){
			//print($"now : {array_length(game.__time)}");
			var t = (get_timer());
			//game.__time[index] = t;
			array_set(game.__time , index , t);
			return(t);
		}),
		
		///@desc 计算实际谱面时间
		ctime : (func(){
			//print($"ctimer: {array_length(game.__time)}");
			var t = ((get_timer() - game.__time[3] - game.__time[0] + game.__time[5]));
			//game.__time[1] = t;
			array_set(game.__time, 1 , t / 1000000);
			array_set(game.__time , 4 , t);
			return(t);	
		}),
		
		///@desc 计算delta时间
		dtime : (func(_ntime , _stime , _etime){
			var _rdt = ((_ntime- _stime) / (_etime - _stime));
			//print($"dtimer: {array_length(game.__time)}");
			return(_rdt);
		}),
		
		///@desc 实时计算暂停时间
		ptime : (func(){
			var time = (game.__time[4] - game.__time[2]);
			array_set(game.__time , 3 , game.__time[3] + time);	
			return(time);
		}),
		
		///@desc formatVersion = 1 -> 3 坐标计算
		posCovert : (func(pos_struct){
			if((!struct_exists(pos_struct , "start")) || (!struct_exists(pos_struct , "end"))) then return(undefined);
			return({
				"start" : (round(pos_struct.start / 1000) / 880),
				"end" : (round(pos_struct[$ "end"] / 1000) / 880),
				"start2" : ((pos_struct.start % 1000) / 520),
				"end2" : ((pos_struct[$ "end"] % 1000) / 520)
			});
		}),
		
		///@desc formatVersion = 2 -> 3坐标计算
		posCovert2 : (func(pos_struct){
			if(struct_get_names(pos_struct) != 4) then return(undefined);
			return({
				"start" : (0.5 + (pos_struct.start / 10)),
				"end" : (0.5 + (pos_struct[$ "end"] / 10)),
				"start2" : (0.5 + (pos_struct.start2 / 10)),
				"end2" : (0.5 + (pos_struct.end2 / 10))
			});
		})
		//pause1 : (function)
	});
	
	///@desc 判定线&音符
	static CreateLines = (func(){
		for(var i = 0 ; i < array_length(self.chart.judgeLineList) ; i ++){
			var l = (instance_create_depth(room_width / 2 , room_height / 2 , 0 , oLine , { events : self.chart.judgeLineList[i] , line_id : i }));
			array_add(self.line_list , l);
		};
		//print($"cl: {array_length(game.__time)}");
		print("[C-Lines] Done." , game.settings.enableDebug);
		for(var i = 0 ; i < array_length(self._notes) ; i ++){
			var na = (self._notes[i]);
			instance_create_depth( -999 , -999 , 0 , oNote , {
				"type" : na.type,
				"isAbove" : na.isAbove,
				"time" : na.time,
				"holdTime" : (na.holdTime),
				"xOffset" : (na.xOffset),
				"yOffset" : (na.yOffset),
				"line_id" : (na[$ "id"]),
				"bpm" : (na.bpm),
				"speed" : (na[$ "speed"]),
				"_hl" : (na[$ "hl"])
			});
		};
		print("[C-Notes] Done." , game.settings.enableDebug);
	});
	
	
	print($"[Initional] Done." , self.settings.enableDebug);
};


function RPE() constructor{
	static chart = undefined;
	//static BPMList = undefined;
	
	static chart_info = { // 基本说明
		"name" : "Unknown",
		"level" : "SP Lv.?",
		"offset" : 0
	};
	
	static version = 0;
	
	static line_list = []; // 线实例组	
	static attachUI_Group = ["default" , "pause" , "combonumber" , "combo" , "score" , "bar" , "name" , "level"]; // UI绑定组
	static fatherLineList = []  // 父线管理组
	static _notes = []; // 所有音符组
	static chart_time = [0 , 0]; // 谱面实际时间 , 因为RPE的BPM的全局的 , 不需要额外计算时间
	///@desc 读取
	static Reader = (func(_chart){
		var f = (string_length(_chart) ? _chart : ($"{working_directory}chart/Chart_IN.json"));
		var buff = (buffer_load(f)),
			r = (buffer_read(buff , buffer_string));
		//return(f);
		
		game_1.chart = (json_parse(r));
		
		delete(r);
		buffer_delete(buff);
		
		self.version = (game_1.chart.META.RPEVersion)
		print($"RPEVersion: {self.version}" , game.settings.enableDebug);
		
		game_1.chart_info.name = (game_1.chart.META.name);
		game_1.chart_info.level = (game_1.chart.META.level);
		game_1.chart_info.offset = (game_1.chart.META.offset);
		
		delete(game_1.chart.META);
		
		print("[R-Chart] Done." , game.settings.enableDebug);
		return;
	});
	
	///@desc RPE判定线创建
	static CreateLines = (func(){
		// 暴力遍历判定线所有值和事件
		var line_group_size = (array_length(game_1.chart.judgeLineList));
		print($"Lines Count: {line_group_size}");
		for(var i = 0 ; i < line_group_size ; i ++){	
			var //,
				events = [];// = l_s[$ "eventLayers"];
			
			// (line)线部分
			var l_s = (game_1.chart.judgeLineList[i]);//,
			global._id = i;
			if(struct_exists(l_s , "eventLayers")){
				events = l_s[$ "eventLayers"];
				if(!is_array(events) && !array_length(events)) then continue;
				for(var o = 0 ; o < array_length(events) ; o ++){
					var events_index = (events[o]);
					
					if(!is_struct(events_index)) then continue;
					
					global.__id = o;
					
					struct_foreach(events_index , (func(name , val){//干什么 
						if(name == "speedEvents") then return;
						var index = [ 0, 1, 3, 2, 6, 5, 4, 7, 9, 8, 12, 11, 10, 13, 15, 14, pointer_null, 17, 16, pointer_null, 19, 18, 22, 21, 20, 23, 25, 24, pointer_null, 27, 26, 28 ];
						for(var e = 0 ; e < array_length(val) ; e ++){
							struct_set(game_1.chart.judgeLineList[global._id].eventLayers[global.__id][$ name][e] , "easingType" , index[real(val[e].easingType)]);
							var _e_left = (val[e][$ "easingLeft"] ?? 0),
								_e_right = (val[e][$ "easingRight"] ?? 1);
								
							if((_e_left == _e_right) || (_e_left < 0 || _e_left > 1 || _e_right < 0 || _e_right > 1)){
								_e_left = 0;
								_e_right = 1;
							};
							
							struct_set(game_1.chart.judgeLineList[global._id].eventLayers[global.__id][$ name][e] , "easingLeft" , _e_left);
							struct_set(game_1.chart.judgeLineList[global._id].eventLayers[global.__id][$ name][e] , "easingRight" , _e_right);
						};
					}));
				};
                var buff = (buffer_create(1 , buffer_grow , 1));
                buffer_write(buff , buffer_string , json_stringify(l_s.eventLayers , true));
                buffer_save(buff , $"{working_directory}debug/line-{i}-eventLayers.json");
                buffer_delete(buff);
			};
			
			var _isFather = (l_s[$ "father"]); 
			print($"Line[{i}]FatherID->{_isFather + 1 ? _isFather : "undefined"}" , game.settings.enableDebug);
				//enableFatherLine = ()
			var l = (instance_create_depth(room_width / 2 , room_height / 2 , 0 , oLine_1 , {
				"line_id" : i, // 线的id
				"bindUI" : (is_undefined(l_s[$ "attachUI"]) ? 0 : l_s[$ "attachUI"]), // UI绑定(暂不考虑支持)
				"image" : (l_s[$ "Texture"]), // 线的纹理
				"isFather" : (_isFather), // 是否启用父线(-1为无父线)
				"isGif" : (l_s[$ "isGif"] ?? false), // 是否为GIF
				"isCover" : (l_s[$ "isCover"]), // 是否启用遮罩(不考虑支持)
				"sizeControl" : (l_s[$ "sizeControl"]), // notes的大小事件(不考虑支持)
				"alphaControl" : (l_s[$ "alphaControl"]), // notes的不透明度事件(不考虑支持)
				"rotFatherLine" : (l_s[$ "rotateWithFather"]), // 是否继承父线旋转事件
				"events" : (events), // 基本事件
				"extEvents" : (l_s[$ "extended"] ?? {}), // 扩展事件 (暂不考虑支持)
				"bpmfactor" : (l_s[$ "bpmfactor"] ?? 1)
			}));
			
			// (notes)音符部分
			for(var n = 0 ; n < array_length(l_s[$ "notes"]) ; n ++){
				var n_s = (l_s[$ "notes"][n]), // 提前获取
					isFake = ((n_s[$ "isFake"])); // 是否为假音符
				if(!isFake) then maxcombo ++; // 如果不是假音符则 MaxCombo 加一
				instance_create_depth(-999 , -999 , 0 , oNote_1 , {
					"type" : (n_s[$ "type"]), // 音符类型
					"isAbove" : (n_s[$ "above"]), // 是否线朝上 , 当type为2时 , isAbove 为 2
					"alpha" : (n_s[$ "alpha"]), // 初始音符不透明度
					"time" : { // 当 type 不为 2 时 , startTime与endTime一致 , 为打击时刻 ; 若 type 是为 2 , startTime 为 Hold 开始长按时刻 , endTime 为 Hold 结束长按时刻
						"startTime" : (game_1.Math.arrToBeat(n_s[$ "startTime"])),
						"endTime" : (game_1.Math.arrToBeat(n_s[$ "endTime"]))
					},
					"xOffset" : (n_s[$ "positionX"]), // 与线中心X轴偏移量
					"yOffset" : (n_s[$ "yOffset"]), // 与线的Y轴偏移量
					"yscale" : (n_s[$ "size"]), // 音符初始大小
					"speed" : (n_s[$ "speed"]), // 音符速度
					"isFake" : isFake, // 是否为假音符 , 当现在谱面时间超过且等于打击时刻 , 不会增加分数也不会增加打击数
					"line_id" : i
				});
			};
		};
		print("[C-Lines] Done." , game.settings.enableDebug);
		delete(game_1.chart.judgeLineList);
	});
	
	///@desc RPE数学公式
	static Math = ({
		///@desc Array 转 Beat
		arrToBeat : (func(arr){
			return(arr[1] / arr[2] + arr[0]);
		}),
		
		///@desc Second 转 Beat
		secToBeat : (func(_sec , _bpm){
			 return((_sec) * ((_bpm) / 60));	
		}),
		
		///@desc Beat 转 Second
		beatToSec : (func(_beat , _bpm){
			return(_beat * (60 / _bpm));	
		})
	});
};


function PEC() constructor{
	
	// 转换后的谱面
	static chart = {
		"version" : 4,
		"offset" : 0,
		"judgeLineList" : [],
		"notes" : [],
        "bpmList" : []
	};
    
    static line_group = [];
	
	
	///@desc 读取谱面
	static Reader = (func(_chart){
		var f = (string_length(_chart) ? _chart : ($"{working_directory}chart/Chart_IN.json")),
			handle = (file_text_open_read(f));
		var cl = false;
		
        // idk
		var _pe_chart_func = {
			// Notes 音符
            
            // 看完不笑的是个人啊
            
            ///@desc Tap
			"n1" : (func(arr_args0 , arr_arg1 , arr_arg2) { 
                return(
                    { 
                        "type" : 1,
                        "speed" : arr_arg1,
                        "line_id" : (real(arr_args0[0])),
                        "time" : (real(arr_args0[1])),
                        "xOffset" : (real(arr_args0[2])),
                        "isAbove" : (bool(real(arr_args0[3]))),
                        "xscale" : arr_arg2,
                        "isFake" : (real(arr_args0[4]))
                    } 
                ); 
            }),
            
            ///@desc Hold
			"n2" : (func(arr_args0 , arr_arg1 , arr_arg2) { 
                var time = (real(arr_args0[1])),
                    holdTime = ((real(arr_args0[2])) - time);
                return(
                    { 
                        "type" : 2,
                        "speed" : arr_arg1,
                        "line_id" : (real(arr_args0[0])),
                        "time" : time,
                        "holdTime" : holdTime,
                        "xOffset" : (real(arr_args0[3])),
                        "isAbove" : (bool(real(arr_args0[4]))),
                        "xscale" : arr_arg2,
                        "isFake" : (real(arr_args0[5]))
                    } 
                ); 
            }),
            
            ///@desc Flick
			"n3" : (func(arr_args0 , arr_arg1 , arr_arg2) { 
                return(
                    { 
                        "type" : 3,
                        "speed" : arr_arg1,
                        "line_id" : (real(arr_args0[0])),
                        "time" : (real(arr_args0[1])),
                        "xOffset" : (real(arr_args0[2])),
                        "isAbove" : (bool(real(arr_args0[3]))),
                        "xscale" : arr_arg2,
                        "isFake" : (real(arr_args0[4]))
                    } 
                ); 
            }),
            
            ///@desc Drag
			"n4" : (func(arr_args0 , arr_arg1 , arr_arg2) { 
                return(
                    { 
                        "type" : 4,
                        "speed" : arr_arg1,
                        "line_id" : (real(arr_args0[0])),
                        "time" : (real(arr_args0[1])),
                        "xOffset" : (real(arr_args0[2])),
                        "isAbove" : (bool(real(arr_args0[3]))),
                        "xscale" : arr_arg2,
                        "isFake" : (real(arr_args0[4]))
                    } 
                ); 
            }),
			// 瞬时事件
			"cv" : (func(arr_args0) { 
                return([ 
                    { 
                        "time" : [
                            real(arr_args0[1]),
                            real(arr_args0[1])
                        ],
                        "value" : "self",
                        "value2" : (real(arr_args0[2]))
                    } ,
                    real(arr_args0[0]) ,
                    "speedEvents" 
                ]); 
            }),
			"cp" : (func(arr_args0) { 
                return([ 
                    { 
                        "time" : [
                            real(arr_args0[1]),
                            real(arr_args0[1])
                        ],
                        "value" : [
                            "self",
                            "self"
                        ],
                        "value2" : [
                            real(arr_args0[2]),
                            real(arr_args0[3])
                        ],
                        "easingType" : 0
                        
                    } ,
                    (real(arr_args0[0])) ,
                    "moveEvents" 
                ]); 
            }),
			"ca" : (func(arr_args0) { 
                return([ 
                    { 
                        "time" : [
                            real(arr_args0[1]),
                            real(arr_args0[1])
                        ],
                        "value" : "self",
                        "value2" : (real(arr_args0[2])),
                        "easingType" : 0
                        
                    } ,
                    (real(arr_args0[0])) ,
                    "alphaEvents" 
                ]); 
            }),
			"cd" : (func(arr_args0) { 
                return([ 
                    { 
                        "time" : [
                            real(arr_args0[1]),
                            real(arr_args0[1])
                        ],
                        "value" : "self",
                        "value2" : (real(arr_args0[2])),
                        "easingType" : 0
                        
                    } ,
                    (real(arr_args0[0])) ,
                    "rotateEvents" 
                ]); 
            }),
			// 缓动事件
			"cr" : (func(arr_args0) { 
                return([ 
                    { 
                        "time" : [
                            real(arr_args0[1]),
                            real(arr_args0[2])
                        ],
                        "value" : "self",
                        "value2" : (real(arr_args0[3])),
                        "easingType" : (real(arr_args0[4]))
                    } ,
                    (real(arr_args0[0])) ,
                    "rotateEvents" 
                ]); 
            }),
			"cm" : (func(arr_args0) { 
                return([ 
                    { 
                        "time" : [
                            real(arr_args0[1]),
                            real(arr_args0[2])
                        ],
                        "value" : [
                            "self",
                            "self"
                        ],
                        "value2" : [
                            real(arr_args0[3]),
                            real(arr_args0[4])
                        ],
                        "easingType" : (real(arr_args0[5]))
                    } ,
                    (real(arr_args0[0])) ,
                    "moveEvents" 
                ]); 
            }),
			"cf" : (func(arr_args0) { 
                return([ 
                    { 
                        "time" : [
                            real(arr_args0[1]),
                            real(arr_args0[2])
                        ],
                        "value" : "self",
                        "value2" : (real(arr_args0[3])),
                        "easingType" : 0
                    } ,
                    (real(arr_args0[0])) ,
                    "alphaEvents" 
                ]); 
            }),
            "bp" : (func(arr_args0){
                return({
                    "time" : arr_args0[0],
                    "bpm" : arr_args0[1]
                });
            })
		};
		while(!file_text_eof(handle)){
			
			var text = (file_text_readln(handle));
			
			// 获取延迟
			if(!cl){
				self.chart.offset = (number(text , 0));
				cl = true;
				continue;
			};
			
			// 读取类型&参数
			var __t = (string_replace_all(string_copy(text , 1 , 2) , " " , "")),
				args = (string_split_ext(string_copy(text , 3 , string_length(text)) , [" " , "\n" , "\r"] , true));
			
			// 去除空行
			if(!array_length(args)) then continue;
			
			// 线ID
			var lineID = 0;
			
			// 如果不为Notes参数,获取线ID
			if(string_length(__t) == 2) then lineID = (number(args[0] , -1));
			//var lineID = (number(args))
			
			// 如果线ID为非法值则跳过
			if(lineID == -1) then continue;
			
			// 如果判定线组大小＜线ID , 则添加一条线
			if(array_length(self.chart.judgeLineList) - 1 < lineID) then array_add(self.chart.judgeLineList , {			
				"moveEvents" : [],
				"alphaEvents" : [],
				"rotateEvents" : [],
				"speedEvents" : []
			});
			
			//print($"{__t} {args}" , game.settings.enableDebug);
            if(!struct_exists(_pe_chart_func , __t)) then continue;
            
			var event;
			if(__t == "n1" || __t == "n2" || __t == "n3" || __t == "n4"){
                var line1 = (file_text_readln(handle)),
                    line2 = (file_text_readln(handle));
				var next_arg = (number(string_copy(line1 , 2 , string_length(line1)))),//((string_split_ext(string_copy(line1 , 2 , string_length(line1)) , [" " , "\n" , "\r"] , true))),
                    next_arg2 = (number(string_copy(line2 , 2 , string_length(line2))));//((string_split_ext(string_copy(line2 , 2 , string_length(line2)) , [" " , "\n" , "\r"] , true)));
                event = (_pe_chart_func[$ __t](args ,  next_arg , next_arg2));
                
                array_add(self.chart.notes , event);
			}else{
                event = (_pe_chart_func[$ __t](args));
                if(__t == "bp"){
                    array_add(self.chart.bpmList , event);
                }else array_add(self.chart.judgeLineList[event[1]][$ event[2]] , event[0]);
            };
			
			
			//if(event[2] != "notes") then 
			//else {
				//array_add(self.chart.notes , event[0]);
			//};
		};
		self.chartBuffSave();
		print(array_length(self.chart.judgeLineList));
		print(array_length(self.chart.notes));
	});
	
	///@desc PEC数学公式
	static Math = ({
		///@desc Second 转 Beat
		secToBeat : (func(_sec , _bpm){
			 return((_sec) * ((_bpm) / 60));	
		}),
		
		///@desc Beat 转 Second
		beatToSec : (func(_beat , _bpm){
			return(_beat * (60 / _bpm));	
		}),
        
        /// @desc 转换坐标
        /// @param {Real} wx 世界坐标X
        /// @param {Real} wy 世界坐标Y
        /// @returns {Array} [屏幕X, 屏幕Y]
        pos_to_size : (func(xx , yy){
            // 窗口尺寸
            var sw = 1366;
            var sh = 768;
        
            // 世界范围（宽度和高度）
            var world_w = 2048;  // 1024 - (-1024)
            var world_h = 1400;  // 700 - (-700)
        
            // 计算屏幕坐标
            var sx = (xx + 1024) * (sw / world_w);
            var sy = sh - (yy + 700) * (sh / world_h);
        
            return [sx, sy];
        })
	});
	
    ///@desc 创建判定线
    static CreateLines = (func(){
        var _func = (func(x1 , x2){
                if(x1.time[0] < x2.time[1]) then return(-1); 
                elif(x1.time[0] > x2.time[1]) then return(1);
                return(0);    
            });
        array_sort(self.chart.bpmList , _func);
        for(var i = 0 ; i < array_length(self.chart.judgeLineList) ; i ++){
            var _line = (self.chart.judgeLineList[i])
                
            array_sort(_line.moveEvents , _func);
            array_sort(_line.alphaEvents , _func);
            array_sort(_line.rotateEvents , _func);
            array_sort(_line.speedEvents , _func); 
            
            var l = (instance_create_depth(room_width / 2 , room_height / 2 , 0 , oLine_2 , {
                "line_id" : i,
                "events" : _line
            }));
            
            array_add(self.line_group , l);
            
        };
        array_sort(self.chart.notes , (func(x1 , x2){
            
            if(x1.time < x2.time) then return(-1); 
            elif(x1.time > x2.time) then return(1);
            return(0); 
        }));
    });
    
	///@desc 导出谱面
	static chartBuffSave = (function(){
		var buff = (buffer_create(1 , buffer_grow , 1));
		
		buffer_write(buff , buffer_text , json_stringify(self.chart , true));
		var n = 0,
			path = ($"{game_save_id}charts/{current_year}-{current_month}-{current_day}-");
		while(file_exists($"{path}{n}.json")){
			n ++;	
		};
		
		buffer_save(buff , $"{path}{n}.json");
		
		buffer_delete(buff);
	});
};


var EventLayers = [ // Length: Four 
    {
        "moveXEvents" : [
            {
                "startTime" : [0,0,1],
                "endTime" : [1,0,1],
                "easingType" : 1,
                "bezier" : false,
                "bezierPoints" : [0,0,0,0],
                "start" : 1,
                "end" : 10
            },
        ]
    },
    {
        "moveXEvents" : [
            {
                "startTime" : [0,0,1],
                "endTime" : [1,0,1],
                "easingType" : 1,
                "bezier" : false,
                "bezierPoints" : [0,0,0,0],
                "start" : 5,
                "end" : 2
            },
        ]
    },
    {
        "moveXEvents" : [
            {
                "startTime" : [0,0,1],
                "endTime" : [1,0,1],
                "easingType" : 1,
                "bezier" : false,
                "bezierPoints" : [0,0,0,0],
                "start" : 4,
                "end" : -10
            },
        ]
    },
    {
        "moveXEvents" : [
            {
                "startTime" : [0,0,1],
                "endTime" : [1,0,1],
                "easingType" : 1,
                "bezier" : false,
                "bezierPoints" : [0,0,0,0],
                "start" : 3,
                "end" : 14
            },
        ]
    }
]




