/// @description 创建音符
exit;
//var notes = (game._notes[self.line_id]);
for(var i = 0 ; i < array_length(notes) ; i ++){
	var na = (notes[i]);
	instance_create_depth( -999 , -999 , 0 , oNote , {
		"type" : na.type,
		"isAbove" : na.isAbove,
		"time" : na.time,
		"holdTime" : (na.holdTime),
		"xOffset" : (na.xOffset),
		"yOffset" : (na.yOffset),
		"line_id" : self.line_id,
		"bpm" : _events.bpm,
		"speed" : na[$ "speed"],
		"_hl" : (na[$ "hl"])
	});
};


/*
for(var a = 0 ; a < array_length(_events[$ "notesAbove"] ?? 0) ; a ++){
	var na = (_events.notesAbove[a]);
	instance_create_depth( -999 , -999 , 0 , oNote , {
		"type" : na.type,
		"isAbove" : true,
		"time" : na.time,
		"holdTime" : (na.type == 3 ? na.holdTime : 0),
		"xOffset" : (na.positionX),
		"yOffset" : (na.floorPosition),
		"line_id" : self.line_id,
		"bpm" : _events.bpm,
		"speed" : na[$ "speed"],
		"_hl" : (is_undefined(na[$ "hl"]) ? false : na[$ "hl"])
	});
};

for(var b = 0 ; b < array_length(_events[$ "notesBelow"] ?? 0) ; b ++){
	var na = (_events.notesBelow[b]);
	instance_create_depth( -999 , -999 , 0 , oNote , {
		"type" : na.type,
		"isAbove" : false,
		"time" : na.time,
		"holdTime" : (na.type == 3 ? na.holdTime : 0),
		"xOffset" : (na.positionX),
		"yOffset" : (na.floorPosition),
		"line_id" : self.line_id,
		"bpm" : _events.bpm,
		"speed" : na[$ "speed"],
		"_hl" : (is_undefined(na[$ "hl"]) ? false : na[$ "hl"])
	});
};

delete(_events[$ "notesBelow"]);
delete(_events[$ "notesAbove"]);