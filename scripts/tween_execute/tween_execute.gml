// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// 函数::Ease执行
/// @desc                       缓动执行函数
/// @arg    {Real}              nowTime   当前时间
/// @arg    {Real}              startTime 开始时间
/// @arg    {Real}              endTime   结束时间
/// @arg    {Real}              start     开始值
/// @arg    {Real}              end       结束值
/// @arg    {Constant.EaseType} easeType  缓动类型
/// @arg    {Real}              easeHead  缓动头偏移
/// @arg    {Real}              easeTail  缓动尾偏移
/// @return {Real}
function tween_execute(_now_time, _start_time, _end_time, _start, _end, _ease_type = EASE.LINEAR, _ease_head = 0, _ease_tail = 1) {
	//if(_start == NaN || _start == infinity || _end == NaN || _end == infinity) then return(NaN);
	// detla计算
	var _rdt = ((_now_time - _start_time) / (_end_time - _start_time));
	// Linear
	if (_ease_type == EASE.LINEAR) then return(lerp(_start, _end, _rdt));
	// 检测Easings
	static _efn = (Easings.Address);
	var _easing;
	if (!is_method(_ease_type)) then _easing = (_efn(_ease_type)); 
	else _easing = _ease_type;
	// 无头尾
	if ((_ease_head == 0) && (_ease_tail == 1)) then return(lerp(_start, _end, (_easing(_rdt))));
	// 带头尾
	var _e_head = (_easing(_ease_head, _ease_type)),
		_e_delta = ((_end - _start) / ((_easing(_ease_tail, _ease_type)) - _e_head))
	;
	return(_start + ((_easing((_rdt * (_ease_tail - _ease_head) + _ease_head), _ease_type)) - _e_head) * _e_delta);
};
