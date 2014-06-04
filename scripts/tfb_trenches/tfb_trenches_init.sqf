// ********************************************************
// * [=TFB=] Taskforce Blackjack Trench Script
// * Initialization File
// *
// * @filename init.sqf
// * @authors: Kiefer [=TFB=], Joseph/Smutton [=TFB=]
// * @version 0.3
// * @website http://tf-blackjack.com
// * @created 5/29/2014
// * @updated 6/1/2014
// * 
// * TODO:
// *  - [x] Scrollwheel option to dig/fill
// *  - [x] Dig based off of classname(s)
// *  - [x] Add to GetHub
// *  - [x] Modulize script functions
// *  - [o] Make sure this works in multiplayer
// *  - [o] Add timers to dig/fill 
// *  - [o] Add cancel system (move to cancel)
// *  - [o] Create Commands for multiple defence types
// *  - [o] Add basic position param, code
// *  
// ********************************************************

// Configuration
tfb_whoCanDigBasic			= ["Man"];         		//Who can dig basic trench (Recognizes Array)
tfb_maxBasicTrench			= 1;							//Max trenches per unit
//tfb_whoCanDigAdv			= ["B_engineer_F"];    //Who can dig advanced trench
//tfb_maxAdvTrench			= 3;							//Max advanced trenches per unit
//_anim         = "AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon"; 
//_tfb_dig_time = 10;                       //Time it takes to dig trench
//_tfb_fill_time    = 5;                //Time it takes to fill trench

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

	// Allow JIP functionality
	waitUntil {!isNull player};
	waitUntil {player == player};
	
	// Counter for Basic Trenches
	tfb_counter_basic = 0;
	
	//Add Action
    if ([player] call tfb_fnPlayerCanDig) then {
		TrenchDigAction = player addAction ["Dig Trench", "scripts\tfb_trenches\tfb_AddAction.sqf", [[player],tfb_fnDigTrench]];
    };
	
	//Remove action from dead player, add action to respawned player
	player addEventHandler ["killed", {
	 [] spawn {
		player removeAction TrenchDigAction;
		WaitUntil{alive player};
		if (tfb_counter_basic < tfb_maxBasicTrench) then {
			TrenchDigAction = player addAction ["Dig Trench", "scripts\tfb_trenches\tfb_AddAction.sqf", [[player],tfb_fnDigTrench]];  }
		};
	} ];
	
	// Testing if Trench has started properly
    hint "TRENCH Started";
}