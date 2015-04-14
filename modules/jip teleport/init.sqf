#include "settings.sqf"

if (!isDedicated) then {
	
	_target = leader player;
	
	if (player == _target || !(alive _target) || _target getVariable ["frameworkDead", false]) then {
	
		_rank = -1;
	
		{
		
			if (rankId _x > _rank && (alive _target) && !(_x getVariable ["frameworkDead", false])) then {
				_rank = rankId _x;
				_target = _x;
			};
			
		} forEach ((units group player) - [player]);
	};

	if ((_target distance player) >  JIPDISTANCE) then {
	
		_teleportAction = player addAction ["Teleport to Squad", "modules\jip teleport\teleportAction.sqf", _target];
		
		[_teleportAction] spawn { //Spawns code running in parallel
		
			_spawnPos = getPosATL player;
			
			while {true} do {
			
				if (player distance _spawnPos > SPAWNDISTANCE) exitWith { //Exitwith ends the loop
				
					player removeAction (_this select 0);
					
				};
				
				sleep (60); //Runs every min
				
			};
		};
	};
};