///@desc
///@param str {String} 需要输入的调试信息
///@param isOutputFile {Bool} 是否输出到文件,默认为false
function LogOutputFile(str , isOutputFile = false){
	if(!variable_global_exists("logBuff")) { globalvar logBuff , sb; logBuff = (buffer_create(1 , buffer_grow , 1)); sb = true};
	if(isOutputFile){
		var __str = ($"{sb ? "" : "\n"}[{current_year}.{current_month}.{current_day} - {current_hour}:{current_minute}:{current_second}] Output: {str}");
		buffer_write(logBuff , buffer_text , __str);
		sb = false;
	};
	
	show_debug_message(str);
};

function LogUninit(){
	if(!variable_global_exists("logBuff")) then return;
	//if(!string_length(logStr)) then return;
	var n = 0,
		path = ($"{working_directory}Logs/{current_year}-{current_month}-{current_day}-");
	while(file_exists($"{path}{n}.log")){
		n ++;	
	};
	buffer_save(logBuff , $"{path}{n}.log");
	buffer_delete(logBuff);
	//delete(logStr)
};