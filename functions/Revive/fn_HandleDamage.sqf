//params["_unit","_bodyPart","_amountOfDamage","_killer","_projectile","_context"];
params ["_unit", "_bodyPart", "_amountOfDamage", "_killer", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];


if (alive _unit
	&& {_amountOfDamage >= 1}
	&& {!(_unit getVariable ["AT_Revive_isUnconscious",false])}
	&& {_bodyPart in ["","head","face_hub","head_hit","neck","spine1","spine2","spine3","pelvis","body"]}
) then {
	_amountOfDamage = 0;
	if(count (_unit getVariable ["AT_Revive_setUnconscious", []]) == 0) then {
		missionNamespace setvariable ["AT_Revive_setUnconscious",[_unit, _killer,_projectile]];
	};
};
_amountOfDamage;
