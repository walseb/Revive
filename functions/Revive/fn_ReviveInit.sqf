if(isNil("AT_Revive_StaticRespawns")) then {
	AT_Revive_StaticRespawns = [];
};
if(isNil("AT_Revive_enableRespawn")) then {
	AT_Revive_enableRespawn = getMissionConfigValue ["ATR_enableRespawn", false];
};
if(isNil("AT_Revive_clearedDistance")) then {
	AT_Revive_clearedDistance = getMissionConfigValue ["ATR_clearedDistance", 0];
};
if(isNil("AT_Revive_Camera")) then {
	AT_Revive_Camera = getMissionConfigValue ["ATR_cameraType", 1];
};
if(isNil("AT_Revive_RepawnTime")) then {
	AT_Revive_RepawnTime = getMissionConfigValue ["ATR_respawnTime", 5];
};
if(isNil("AT_Revive_MinRepawnTime")) then {
	AT_Revive_MinRepawnTime = getMissionConfigValue ["ATR_minRespawnTime", 10];
};
AT_Revive_Debug = false;
if(isNil("AT_Revive_FrameEH")) then {
	AT_Revive_FrameEH = addMissionEventHandler ["EachFrame", {
		if(count(missionNamespace getvariable ["AT_Revive_setUnconscious",[]])>0) then {
			AT_Revive_setUnconscious params["_unit","_killer","_projectile"];
			missionNamespace setvariable ["AT_Revive_setUnconscious",[]];
			_unit setDamage 0;
			_unit allowDamage false;
			_unit setVariable ["AT_Revive_isUnconscious", true, true];
			[_unit] call ATR_FNC_Unconscious;
			[_unit, _killer, _projectile] spawn ATR_FNC_BroadcastKill;
		};
	}];
};

[] spawn
{
    waitUntil {!isNull player};
	
	[true] spawn ATR_FNC_InitPlayer;
	
	
	player addEventHandler 
	[
		"Respawn", 
		{ 
			_this call ATR_fnc_OnRespawn;
		}
	];
};


if (!AT_Revive_Debug || isMultiplayer) exitWith {};

{
	if (!isPlayer _x) then 
	{
		_x addEventHandler ["HandleDamage", ATR_FNC_HandleDamage];
		_x setVariable ["AT_Revive_isUnconscious", false, true];
		_x setVariable ["AT_Revive_isDragged", objNull, true];
		_x setVariable ["AT_Revive_isDragging", objNull, true];
	};
} forEach switchableUnits;