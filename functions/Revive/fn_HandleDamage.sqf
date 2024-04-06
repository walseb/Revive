params["_unit","_bodyPart","_amountOfDamage","_killer","_projectile","_context"];


if (alive _unit
	&& {_amountOfDamage >= 1}
	&& (_context <= 2)
	&& {!(_unit getVariable ["AT_Revive_isUnconscious",false])}
	&& {_bodyPart in ["","head","face_hub","head_hit","neck","spine1","spine2","spine3","pelvis","body"]}
) then {
	_unit setDamage 0;
	_unit allowDamage false;
	_amountOfDamage = 0;
	[_unit, _killer, _projectile] spawn ATR_FNC_Unconscious;
};

if (_context > 2) then {_amountOfDamage = 0;};
_amountOfDamage;
