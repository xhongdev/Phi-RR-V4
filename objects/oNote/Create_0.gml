/// @description 
depth = DEPTH.NOTE;
event_user(0);

// 提前计算好
_step_user_count = (self.type == 3 ? 2 : 1);
_draw_user_count = (self.type == 3 ? 4 : 3);
_judge_user_count = (self.type == 3 ? 6 : 5);

canDraw = false;
hl = self._hl;
delete(self._hl);
//hl = (game.settings.enbaleNoteHightLight ? (other.time == self.time) : 0);