/// @description BPMList-计算谱面时间
var be = (game_1.chart.BPMList),
	len = (array_length(be));
if(!len) then exit;

//var ctime = () 
var ctime = (game_1.Math.secToBeat(game.__time[1] , rpe_bpm));//,
	//_bpm_count = bpm_count;
//try{
	if(len - 1 > bpm_count){
		var etime0 = (game_1.Math.arrToBeat(be[bpm_count].startTime)),
			etime1 = (game_1.Math.arrToBeat(be[bpm_count + 1].startTime));
		while(ctime > etime1 && len - 1 > bpm_count){	
			print($"{be[bpm_count]}\n{be[bpm_count + 1]}");
			var _ctime0 = (game_1.Math.beatToSec(game_1.Math.arrToBeat( be[bpm_count + 1].startTime)  , be[bpm_count].bpm)),
				_ctime1 = (game_1.Math.beatToSec(game_1.Math.arrToBeat( be[bpm_count + 1].startTime) , be[bpm_count + 1].bpm)),
				offset_time = (_ctime1 - _ctime0);

			sec += (-offset_time);
            bpm_count ++;
			//var _ctime = (game_1.Math.secToBeat(game.__time[1] , be[bpm_count].bpm)),
				//offset_time = (_ctime - ctime);
			//etime0 = (game_1.Math.arrToBeat(be[bpm_count].startTime));
			//etime1 = (game_1.Math.arrToBeat(be[bpm_count + 1].startTime));
			//sec += (-offset_time);//(game_1.Math.beatToSec(-offset_time , be[bpm_count]));
			//array_set(game_1.chart_time , 0 , etime1);
		};
	
		while(ctime < etime0 && bpm_count > 0){
			bpm_count --;
			var _ctime0 = (game_1.Math.secToBeat(be[bpm_count].startTime , be[bpm_count + 1].bpm)),
				_ctime1 = ((game_1.Math.secToBeat(be[bpm_count].startTime , be[bpm_count].bpm))),
				offset_time = (_ctime1 - _ctime0);

			sec = (-offset_time);
			//etime0 = (game_1.Math.arrToBeat(be[bpm_count].startTime));
			//sec += (-offset_time);
			//array_set(game_1.chart_time , 0 , etime0);
			//etime1 = (game_1.Math.arrToBeat(be[bpm_count + 1].startTime));
		};
		
		//if(bpm_count != _bpm_count){
			//array_set(game_1.chart_time , 0 , array_get(game_1.chart_time , 1));
			//array_set(game_1.chart_time , 1 , 0);
		//};
	};
//}catch(e) { delete(e); };


rpe_bpm = (be[bpm_count].bpm);

//array_set(game_1.chart_time , 1 , game_1.chart_time[0] + (game_1.Math.secToBeat(game.__time[1] - sec, rpe_bpm)));
//print($"ChartTime: {game_1.chart_time}  BPM: {rpe_bpm}");
