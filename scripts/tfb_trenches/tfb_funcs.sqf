// Dig a trench
tfb_fnDigTrench = {

	_args = _this;
	
	_trench = createVehicle [
		"CraterLong",
		_args select 0 modelToWorld [0,2,-.4], 
		[], 
		0, 
		"CAN_COLLIDE"
	];
	
    _trench setDir (getDir (_args select 0) - 90);
	(_args select 0) removeAction ActionID;
    ActionID = _trench addAction ["Fill Trench", "scripts\tfb_trenches\tfb_addAction.sqf", [[_trench,_this select 2], tfb_fnRemoveTrench], 1.5, true, true, "", "call tfb_fnSetId"]; 
};

// Remove trench
tfb_fnRemoveTrench = {
	_args = _this;
	
    deleteVehicle (_args select 1);
    ActionID = player addAction ["Dig Trench", "scripts\tfb_trenches\tfb_addAction.sqf", [[player,_this select 2], tfb_fnDigTrench], 1.5, true, true, "", "call tfb_fnSetId"]; 
};

// Determine who is allowed to dig
tfb_fnPlayerCanDig = {
    _unit = _this select 0;
    _cond = false;
    {
        if (_unit isKindOf _x) then {_cond = true};
    } forEach tfb_whoCanDig;      // Check against entire array of types
    _cond
};