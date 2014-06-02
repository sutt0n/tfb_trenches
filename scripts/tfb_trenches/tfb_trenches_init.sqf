// ********************************************************
// * [=TFB=] Taskforce Blackjack Trench Script
// * Initialization File
// *
// * @filename init.sqf
// * @authors: Kiefer [=TFB=], Joseph/Smutton [=TFB=]
// * @version 0.2
// * @website http://tf-blackjack.com
// * @created 5/29/2014
// * 
// * TODO:
// *  - [x] Scrollwheel option to dig/fill
// *  - [x] Dig based off of classname(s)
// *  - [x] Add to GetHub [Joe]
// *  - [x] Modulize script functions [Joe]
// *  - [o] Make sure this works in multiplayer [Kiefer]
// *  - [o] Add timers to dig/fill 
// *  - [o] Add cancel system (move to cancel)
// *  - [o] Create Commands for multiple defense types
// *  - [o] Add basic position param, code
// *  
// ********************************************************

// Configuration
tfb_whoCanDig	= ["B_engineer_F"];         //Who can dig, Array can be more than one type
//_anim         = "AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon"; 
//_TFB_dig_time = 10;                       //Time it takes to dig trench
//_TFB_fill_time    = 5;                //Time it takes to fill trench

// *********************************
// * Don't edit below this line.   *
// *********************************
//if( !isDedicated ) then {};

call compile preprocessFile "scripts\tfb_trenches\tfb_funcs.sqf";

//if( isServer ) then {};

// Only client-side shall surpass this line! =o
if( isDedicated ) exitWith {};

// Initialization
[] spawn
{

	// Anti JIP
	waitUntil {!isNull player};
	waitUntil {player == player};

    if ([player] call tfb_fnPlayerCanDig) then {
        player addAction ["Dig Trench", "scripts\tfb_trenches\tfb_AddAction.sqf", [[player],tfb_fnDigTrench]];
    };
    hint "TRENCH Started";
}