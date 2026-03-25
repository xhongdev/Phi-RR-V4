/// @description BPMList事件处理
var bpm_e = (game_2.chart.bpmList);
var len = (array_length(bpm_e));

if(len - 1 > bpm_count){
    var ctime = (game_2.Math.secToBeat(game.__time[1] , pec_bpm)),
        b_count = bpm_count;
    
    while(ctime >= bpm_e[b_count + 1].time && b_count < len - 1){
        b_count ++;
    };
    
    while(ctime < bpm_e[b_count].time && b_count > 0){
        b_count --;
    };
    
    bpm_count = b_count;
};

pec_bpm = (bpm_e[bpm_count].bpm);