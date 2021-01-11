//Récupère la liste de tous les marqueurs LUCY pour les masquer et les blacklister pour GDC_fnc_chooseSpawnPos
private _tbMrk = allMapMarkers select {["mrk", _x, true] call BIS_fnc_inString};

//Masque les marqueurs
{_x setMarkerAlpha 0.0} forEach _tbMrk;

//LUCY (-> lancé dans l'init.sqf)
[0.5,"mkr_spawn_static_unit",true,600.0,false,3600.0,true,true,"COLONEL"] call GDC_fnc_lucyInit;
//["loadout\loadout.sqf"] call GDC_fnc_lucyConfigLoadoutIA;

//Spawn au choix des joueurs
["mk_spawn",[],"LIEUTENANT",["marker_zone_nospawn"]] call GDC_fnc_chooseSpawnPos;

//Lance le briefing
execVM "briefing.sqf";

/* Initalization of the computer to hack */

// set position of computer to hack with random
_pos_1 = [2576.98,5084.06,6.96];
_pos_2 = [2474.29,5138.44,6.51];
_pos_3 = [2474.15,5138.69,2.38];
computerToHack setPos selectRandom [_pos_1,_pos_2,_pos_3];
computerToHack setVectorUp [0,0,1];

// Add ACE actions to the computer to hack 
_action_hack_bf = [
	"HackSystem",
	"Hacker le système : attaque par force brute",
	"",
	{
		[
			15,
			[],
			{
				[computerToHack, 600] spawn int_fnc_probaChallenge; 
			}, 
			{hint "Challenge system connection aborted"},
			"Connexion et initialisation du système de piratage. Merci de patienter..."
		] call ace_common_fnc_progressBar;	
	},
	{!(computerToHack getVariable "challengeSuccessfull") && (player getUnitTrait "UAVHacker")}
] call ace_interact_menu_fnc_createAction;
[computerToHack, 0, ["ACE_MainActions"], _action_hack_bf] call ace_interact_menu_fnc_addActionToObject;

_action_hack_dico = [
	"HackSystem",
	"Hacker le système : attaque par dictionnaire",
	"",
	{
		[15, [], {[computerToHack, 300, [0.0001,0.001,0.002,0.023]] spawn int_fnc_probaChallenge;}, {hint "Challenge system connection aborted"}, "Connexion et initialisation du système de piratage. Merci de patienter..."] call ace_common_fnc_progressBar;
	},
	{!(computerToHack getVariable "challengeSuccessfull") && (player getUnitTrait "UAVHacker")}
] call ace_interact_menu_fnc_createAction;
[computerToHack, 0, ["ACE_MainActions"], _action_hack_dico] call ace_interact_menu_fnc_addActionToObject;

_action_acces = [
	"AccessSystem",
	"Accéder au système",
	"",
	{
		[
			5,
			[],
			{
				if !(isNil {reinf1}) then {
					if !(isNil {reinf2}) then {
						hintSilent parseText format [ 
							"<br /> 
							<t size='1.5' color='#a4aac1'>From NATO HQ :</t><br /><br />
							<t size='1.2'>Reinforcements are on their way.</t><br /><br />
							<t size='1.2'>Alpha grid position is </t><br />
							<t size='1.3' color='#acf1ec'> %1</t><br /><br />
							<t size='1.2'>Bravo grid position is </t><br />
							<t size='1.3' color='#acf1ec'> %2</t><br /><br />",
							mapGridPosition leader reinf1,
							mapGridPosition leader reinf2
						];
					} else {
						hintSilent parseText format [ 
							"<br /> 
							<t size='1.5' color='#a4aac1'>From NATO HQ :</t><br /><br />
							<t size='1.2'>Reinforcements are on their way.</t><br /><br />
							<t size='1.2'>Alpha grid position is </t><br />
							<t size='1.3' color='#acf1ec'> %1</t><br /><br />
							<t size='1.2'>Bravo is being prepared</t><br /><br />",
							mapGridPosition leader reinf1
						];
					};
				} else {
					hintSilent parseText format [ 
						"<br /> 
						<t size='1.5' color='#a4aac1'>From NATO HQ :</t><br /><br />
						<t size='1.2'>Reinforcements are being prepared.</t><br /><br />
						<t size='1.2'>Hold on tight !</t><br /><br />"
					];
				}
			},
			{hint "Abandon"},
			"Accès au système. Merci de patienter..."
		] call ace_common_fnc_progressBar;
	},
	{(computerToHack getVariable "challengeSuccessfull")}
] call ace_interact_menu_fnc_createAction;
[computerToHack, 0, ["ACE_MainActions"], _action_acces] call ace_interact_menu_fnc_addActionToObject;