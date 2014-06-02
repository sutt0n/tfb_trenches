// Dig a trench
tfb_fnDigTrench = {
	// Basics
	_args	= _this;
	_player	= _args select 0;
	_id		= _args select 1;
	
	// Create trench
	_trench = createVehicle [
		"CraterLong",
		_player modelToWorld [0,2,-.37], 
		[], 
		0, 
		"CAN_COLLIDE"
	];
	
	// Set direction of trench
    _trench setDir (getDir _player - 90);
	
	// Remove "Dig Trench" option
	_player removeAction _id;
	
	// Add "Fill Trench" option
    _trench addAction ["Fill Trench", "scripts\tfb_trenches\tfb_addAction.sqf", [[_trench,_player], tfb_fnRemoveTrench]]; 
};

// Remove trench
tfb_fnRemoveTrench = {
	// Basics
	_args	= _this;
	_trench	= _this select 0;
	_player = _this select 1;
	
	// Remove the trench
    deleteVehicle _trench;
	
	// Add "Dig Trench" option
    _player addAction ["Dig Trench", "scripts\tfb_trenches\tfb_addAction.sqf", [[_player], tfb_fnDigTrench]]; 
};

// Determine who is allowed to dig (_unit == player)
tfb_fnPlayerCanDig = {
    _unit = _this select 0;
    _cond = false;
    {
        if (_unit isKindOf _x) then {_cond = true};
    } forEach tfb_whoCanDig;      // Check against entire array of types
    _cond
};