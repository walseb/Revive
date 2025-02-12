!isNull cursorTarget
	&& {call ATR_FNC_Check_Revive}
	&& {((Items player) findIf {_x in (missionNamespace getvariable ["a3e_arr_faks",["FirstAidKit"]])} > -1) || {(Items cursorTarget) findIf {_x in (missionNamespace getvariable ["a3e_arr_faks",["FirstAidKit"]])} > -1} }
;