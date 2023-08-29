params["_unit", "_killer", "_projectile"];
_unit setVariable ["AT_Revive_isUnconscious", true, true];

if((side _unit == side _killer) && (_unit != _killer)) then {
	private _inGameMsg = format["%1 was shot by %2.",name _unit, name _killer];
	_inGameMsg remoteExec ["systemchat", 0, false];

	private _currentWeapon = currentWeapon _killer;
	private _distance = _killer distance _unit;
	diag_log format["Teamkill Report: %1 was shot by %2 with %3 (projectile %4) from %5 meters", name _unit, name _killer, _currentWeapon, _projectile, _distance];
} else {
	private _msg = format["%1 is unconscious.",name _unit];
	_msg remoteExec ["systemchat", 0, false];
};
private _inVehicle = false;
if(vehicle _unit == _unit) then {
	_ragdoll = [_unit] spawn ATR_FNC_ragdoll;
	waituntil{scriptDone _ragdoll};
} else {
	private["_vehicle"];
	_vehicle = vehicle _unit;
	if(getdammage _vehicle < 1) then {
		_inVehicle = true;
		[_unit] call ATR_FNC_SwitchVehicleDeadAnimation;
	} else {
		moveOut _unit;
		_ragdoll = [_unit] spawn ATR_FNC_ragdoll;
	};
};

_unit setDamage 0.9;
_unit setVelocity [0,0,0];
_unit allowDammage false;
_unit setCaptive true;
if(surfaceIsWater getpos _unit && ((getPosASL _unit) select 2)<1 && (vehicle _unit == _unit)) then {
	[_unit] call ATR_FNC_WashAshore;
};

if(AT_Revive_Camera==1) then {
	[] spawn ATHSC_fnc_createCam;
};
sleep 0.5;

if(vehicle _unit == _unit) then {
	[_unit,"AinjPpneMstpSnonWnonDnon"] remoteExec ["switchmove", 0, false];
};
_unit enableSimulation false;  //THIS IS WHAT'S ALLOWING THE ANIMATION TO WORK IN WHEN IT SHOULDN'T "AinjPpneMstpSnonWnonDnon" NORMALLY HAS AN ISSUE WHERE THE _unit IMMEDIATELY ROLLS BACK WHEN A PRIMARY IS EQUIPPED BUT THE DISABLE SIMULATION PREVENTS THAT

switch (true) do
		{
		case ((currentweapon _unit == (secondaryweapon _unit)) and (primaryweapon _unit != "")): {_unit selectweapon primaryweapon _unit;};
		case (((currentweapon _unit == (secondaryweapon _unit)) and (primaryweapon _unit == "")) and (handgunweapon _unit != "")): {_unit selectweapon handgunweapon _unit;};
		case (((currentweapon _unit == (secondaryweapon _unit)) and (primaryweapon _unit == "")) and (handgunweapon _unit == "")): {_unit action ["SwitchWeapon", _unit, _unit, 100];};
		};

// Call this code only on players
if (isPlayer _unit) then
{

	while { !isNull _unit && alive _unit && (_unit getVariable "AT_Revive_isUnconscious")} do
	{
		if(vehicle _unit == _unit && _inVehicle) then {
			_inVehicle = false;
			_unit enableSimulation true;
			_ragdoll = [_unit] spawn ATR_FNC_ragdoll;
			waituntil{scriptDone _ragdoll};
			sleep 0.25;
			_unit enableSimulation false;
		};
		if(vehicle _unit != _unit && !_inVehicle) then {
			_inVehicle = true;
			_unit enableSimulation true;
			[_unit] call ATR_FNC_SwitchVehicleDeadAnimation;
			sleep 0.25;
			_unit enableSimulation false;
		};
		sleep 0.5;
	};
	private _pos = getposATL _unit;

	// _unit got revived
	//sleep 6;
	//Track some statistics
	private _reviveStats = missionNamespace getvariable ["A3E_Revive_Count",0];
	missionNamespace setvariable ["A3E_Revive_Count",_reviveStats+1,true];

	_unit enableSimulation true;
	_unit allowDamage true;
	_unit setCaptive false;

	sleep 0.5;
	_unit setPosATL _pos; //Fix the stuck in the ground bug

};