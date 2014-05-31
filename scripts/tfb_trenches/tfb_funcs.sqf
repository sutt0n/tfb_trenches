


// Dig a trench
tfb_fnDigTrench = {
    _trench = createVehicle ["CraterLong",(_this select 1) modelToWorld [0,2,-.4], [], 0, "CAN_COLLIDE"];
    _trench setDir (getDir (_this select 1) - 90);
    (_this select 1) removeAction (_this select 2);
    _id = _trench addAction ["Dig Trench", "scripts\tfb_trenches\tfb_addAction.sqf", [[_trench],tfb_fnRemoveTrench]]; 
};

// Remove trench
tfb_fnRemoveTrench = 
{
    deleteVehicle (_this select 0);
    _id = (_this select 1) addAction ["Dig Trench", "scripts\tfb_trenches\tfb_addAction.sqf", [[_this select 1],tfb_fnDigTrench]];
};

// Determine who is allowed to dig
tfb_fnPlayerCanDig =
{
    _unit = _this select 0;
    _cond = false;
    {
        if (_unit isKindOf _x) then {_cond = true};
    } forEach tfb_whoCanDig;      // Check against entire array of types
    _cond
};