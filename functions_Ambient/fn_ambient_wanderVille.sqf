/*
Ambient Villages V2 
Updated: 17 Nov 2023

This FNC creates village ambience, spawning and despawning villagers in a designated zone 

Requires:
- position / standard 2D array 
- radius / how large an area (ellipse)
- num / how many civs 

Notes:
- this should be given a pos, and create marker from that - so we need  system to find ville locations near to patrol and automate this
- for now this is a one-off hardcoded location

*/
params ["_anchor", "_rad", "_num"];

sleep 5;

systemChat "running wanderVille";

_RGG_ambiUnits = []; // temp holding array for ambi units, used for counting and deleting 

_class = [
	"vn_c_men_03",
	"vn_c_men_04",
	"vn_c_men_07",
	"vn_c_men_08",
	"vn_c_men_11",
	"vn_c_men_12",
	"vn_c_men_15",
	"vn_c_men_16",
	"vn_c_men_19",
	"vn_c_men_20",
	"vn_c_men_23",
	"vn_c_men_24",
	"vn_c_men_27",
	"vn_c_men_28",
	"vn_c_men_31",
	"vn_c_men_32"
];

_chk = true; // main bool check state  
while { _chk } do {

	// check if any players are near 
	_cntData = []; 
	{
		_pos = getPos _x;
		_dis = _anchor distance2D _x; 
		if (_dis < 350) then {
			_cntData pushBack _x;
		};
	} forEach allPlayers;

	if ((count _cntData) > 0) then {
		// at least one player is near
		deleteMarker "wanderVille"; 
		_wanderVille = createMarker ["wanderVille", _anchor];
		_wanderVille setMarkerShape "ELLIPSE";
		_wanderVille setMarkerSize [_rad, _rad];
		_wanderVille setMarkerAlpha 0;

		// create ambi-units 
		for "_i" from 1 to _num do {
			_grp = createGroup [civilian, true];
			_from = [["wanderVille"]] call BIS_fnc_randomPos;
			_rndtype = selectRandom _class; 
			_unit = _grp createUnit [_rndtype, _from, [], 2, "none"]; 
			_RGG_ambiUnits pushBack _unit;
			// _unit forceWalk true;
			_unit forceSpeed 0.4;
			sleep 0.1
		};

		_playerNear = true;
		while { _playerNear } do {
			// check if _still_ here 
			_data = [];
			{
				_pos = getPos _x;
				_dis = _anchor distance2D _x;
				if (_dis < 350) then {
					// someone is still near 
					_data pushBack _x;
				};
			} forEach allPlayers;

			if ((count _data) == 0) then {
				// no players here, ok to despawn everything				
				// delete villagers
				{
					deleteVehicle _x;
				} forEach _RGG_ambiUnits;
				sleep 2;
				_playerNear = false;
			} else {
				// player is still near, move them around 
				{
					_randomMovePos = [["wanderVille"]] call BIS_fnc_randomPos;
					_x doMove _randomMovePos;
					_grp = group _x;
					_sMode = selectRandom ["LIMITED"]; 
					_bMode = selectRandom ["CARELESS","SAFE"];
					_grp setSpeedMode _sMode;
					_grp setBehaviour _bMode;
					sleep 0.2
				} forEach _RGG_ambiUnits;
			};
			sleep 20;
		};
	} else {
		systemChat "Debug - ambiVille zone is empty";
	};
	sleep 40;
};







