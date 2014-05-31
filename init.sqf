/*
=TFB= Trench Script
Initialization file
Created by =TFB= Kiefer and =TFB= Joseph
version 0.02 
Visit us at: 
http://tf-blackjack.com/
05/29/2014

TODO:
    - [x] Scrollwheel option to dig/fill
    - [x] Dig based off of classname(s)
    - [o] Modulize script functions [Joe]
    - [o] Make sure this works in multiplayer [Kiefer]
    - [o] Add to GetHub [Joe}
    - [o] Add timers to dig/fill 
    - [o] Add cancel system (move to cancel)
    - [o] Create Commands for multiple defense types
    - [o] Add basic position param, code
    
*/

//Editable Variables

TFB_who_can_dig     = ["B_engineer_F"];         //Who can dig, Array can be more than one type
//_anim               = "AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon"; 
_TFB_dig_time       = 10;                       //Time it takes to dig trench
//_TFB_fill_time    = 5;                //Time it takes to fill trench

// Don't edit below //

// Dig a trench
TFB_fnc_digTrench = {
    _trench = createVehicle ["CraterLong",(_this select 1) modelToWorld [0,2,-.4], [], 0, "CAN_COLLIDE"];
    _trench setDir (getDir (_this select 1) - 90);
    (_this select 1) removeAction (_this select 2);
    _id = _trench addAction ["Fill Trench", {call TFB_fnc_removeTrench}]; 
};

// Remove trench
TFB_fnc_removeTrench = 
{
    deleteVehicle (_this select 0);
    _id = (_this select 1) addAction ["Dig Trench", {call TFB_fnc_digTrench}];
};
// Determine who is allowed to dig
TFB_is_class_can_dig =
{
    _unit = _this select 0;
    _cond = false;
    {
        if (_unit isKindOf _x) then {_cond = true};
    } forEach TFB_who_can_dig;      //Check against entire array of types
    _cond;
};

//Init
[player] spawn
{
    if ([_this select 0] call TFB_is_class_can_dig) then {
        (_this select 0) addAction ["Dig Trench", {call TFB_fnc_digTrench}]
    };
    hint "TRENCH Started";
}