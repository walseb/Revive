//params["_unit","_bodyPart","_amountOfDamage","_killer","_projectile","_context"];
params ["_unit", "_bodyPart", "_amountOfDamage", "_killer", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];


if (alive _unit
	&& {_amountOfDamage >= 1}
	&& {!(_unit getVariable ["AT_Revive_isUnconscious",false])}
	&& {_bodyPart in ["","head","face_hub","head_hit","neck","spine1","spine2","spine3","pelvis","body"]}
) then {
	_amountOfDamage = 0;
	if(!(_unit getVariable ["AT_Revive_isUnconscious", false])) then {
		_unit setDamage 0;
		_unit allowDamage false;
		_unit setVariable ["AT_Revive_isUnconscious", true, true];
		[_unit] call ATR_FNC_Unconscious;
		[_unit, _killer, _projectile] spawn ATR_FNC_BroadcastKill;
	};
};
_amountOfDamage;
