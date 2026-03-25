/// @description UI绑定
var str = [
    "pause",
    "combonumber",
    "combo",
    "score",
    "bar",
    "name",
    "level"
]
if(is_real(self.bindUI)) then self.bindUI = (str[self.bindUI]);

var xx = x,
    yy = y,
    angle = image_angle,
    alpha = image_alpha,
    color = image_blend,
    scaleX = image_xscale,
    scaleY = image_yscale,
    name = self.bindUI;
with(oRender_2){
    bindUI[$ name] = [ xx , yy , color , angle , alpha , scaleX , scaleY];
};
//struct_set(oRender_1.bindUI)

//switch (self.bindUI) {
	//case "pause" : case 1:
        //
    //break;
//
    //case "combonumber" : case 2:
        //
    //break;
//
    //case "combo" : case 3:
        //
    //break;
//
    //case "score" : case 4:
        //
    //break;   
//
    //case "bar" : case 5:
        //
    //break;
//
    //case "name" : case 6:
        //
    //break;
//
    //case "level" : case 7:
        //
    //break;        
//}