//PLUTO Opfor
[
	opfor,		        //0 camp
	[1000,2000,6000],	//1 revealRange [man,land,air]
	[1500,2000,3000],	//2 sensorRange [man,land,air]
	120,			    //3 QRFtimeout
	[1000,2000,6000],	//4 QRFrange [man,land,air]
	[20,30,60],		    //5 QRFdelay [min,mid,max]
	240,			    //6 ARTYtimeout
	[20,30,60],		    //7 ARTYdelay [min,mid,max]
	[1,2,4],		    //8 ARTYrounds [min,mid,max]
	[0,40,100]		    //9 ARTYerror [min,mid,max]
] call GDC_fnc_pluto;

gdc_plutoDebug = false;

//On adapte le nombre d'hostiles par rapport au nombre de joueurs
nbJoueurs = playersNumber east;

/* Groups definition */
	private _fsl    = "rhsgref_cdf_b_para_rifleman";
	private _lat    = "rhsgref_cdf_b_para_grenadier_rpg";
	private _aa     = "rhsgref_cdf_b_para_specialist_aa";
	private _at     = "rhsgref_cdf_b_para_grenadier_rpg" ;
	private _ass_at = "rhsgref_cdf_b_para_rifleman";
	private _lmg    = "rhsgref_cdf_b_para_autorifleman";
	private _mg     = "rhsgref_cdf_b_para_machinegunner";
	private _ass_mg = "rhsgref_cdf_b_para_rifleman";
	private _gl     = "rhsgref_cdf_b_para_grenadier";
	private _tl     = "rhsgref_cdf_b_para_squadleader";
	private _sl     = "rhsgref_cdf_b_para_officer";
	private _medic  = "rhsgref_cdf_b_para_medic";

// Groupes de max 4
GROUPE_BLUFOR_PETIT = [
	[_fsl, _fsl],
	[_gl, _fsl],
	[_lmg, _fsl],
	[_tl, _fsl, _fsl],
	[_tl, _lat, _fsl],
	[_tl, _lmg, _fsl],
	[_tl, _lat, _fsl, _fsl],
	[_tl, _lmg, _fsl, _fsl],
	[_tl, _gl, _lmg , _fsl],
	[_tl, _mg, _ass_mg, _fsl]
];
// Groupes de 7
GROUPE_BLUFOR_MOYEN = [
	[_tl, _lat, _lmg, _fsl, _fsl, _fsl, _fsl],
	[_tl, _mg, _ass_mg, _fsl, _fsl, _fsl, _fsl],
	[_tl, _gl, _lmg, _fsl, _fsl, _fsl, _fsl]
];
// Groupes de 14
GROUPE_BLUFOR_GRAND = [
	[_sl, _medic, _tl, _at, _ass_at, _fsl, _fsl, _tl, _mg, _ass_mg, _fsl, _fsl, _tl, _gl]
];
// Groupes de 6
GROUPE_BLUFOR_PETIT_US = 
	["rhsusf_army_ucp_officer","rhsusf_army_ucp_maaws", "rhsusf_army_ucp_rifleman","rhsusf_army_ucp_machinegunner","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_rifleman"];

/*******************************************/
/*                CARGO                    */
/*******************************************/

loadCargo = {
	params ["_veh","_cargo"];
	clearMagazineCargoGlobal _veh;
	clearWeaponCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	switch (_cargo) do {
		case "cargo_1": {
			_veh addItemCargoGlobal ["rhs_mag_rgd5",200];
			_veh addItemCargoGlobal ["rhs_mag_rgo",200];
			_veh addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR_green",100];
			_veh addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR_7N26",300];
			_veh addMagazineCargoGlobal ["rhs_30Rnd_545x39_7N6M_AK",500];
			_veh addMagazineCargoGlobal ["rhs_mag_9x19_17",200];
			_veh addWeaponCargoGlobal ["rhs_weap_rpg7",10];
			_veh addMagazineCargoGlobal ["rhs_rpg7_PG7VL_mag",40];		
			_veh addMagazineCargoGlobal ["rhs_mag_9x19_17",200];
			_veh addItemCargoGlobal ["ACE_EntrenchingTool",20];
			_veh addMagazineCargoGlobal ["rhs_mag_nspn_green",50];
			_veh addMagazineCargoGlobal ["rhs_mag_nspn_red",50];
		};
		case "cargo_2": {
			_veh addItemCargoGlobal ["rhs_mag_rdg2_white",50];
			_veh addItemCargoGlobal ["rhs_mag_rdg2_black",50];
		};
		case "cargo_3": {
			_veh addMagazineCargoGlobal ["rhs_20rnd_9x39mm_SP6",50];
			_veh addMagazineCargoGlobal ["rhs_20rnd_9x39mm_SP5",50];
			_veh addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR_green",20];
		};
		case "cargo_4": {
			_veh addMagazineCargoGlobal ["rhs_rpg7_PG7VL_mag",40];
			_veh addMagazineCargoGlobal ["rhs_rpg7_OG7V_mag",20];
			_veh addMagazineCargoGlobal ["rhs_rpg7_TBG7V_mag",20];
			_veh addBackpackCargoGlobal ["rhs_rpg_empty",15];
		};
		case "cargo_5": {
			_veh addItemCargoGlobal ["ACE_packingBandage",300];
			_veh addItemCargoGlobal ["ACE_quikclot",300];
			_veh addItemCargoGlobal ["ACE_elasticBandage",300];
			_veh addItemCargoGlobal ["ACE_fieldDressing",400];
			_veh addItemCargoGlobal ["ACE_salineIV_250",80];
			_veh addItemCargoGlobal ["ACE_salineIV_500",60];
			_veh addItemCargoGlobal ["ACE_salineIV",50];
			_veh addItemCargoGlobal ["ACE_morphine",50];
			_veh addItemCargoGlobal ["ACE_atropine",50];
			_veh addItemCargoGlobal ["ACE_tourniquet",40];
			_veh addItemCargoGlobal ["ACE_surgicalKit",5];
			_veh addItemCargoGlobal ["ACE_splint",100];
			_veh addItemCargoGlobal ["Toolkit",5];
			_veh addItemCargoGlobal ["ACE_Wirecutter",10];
			_veh addItemCargoGlobal ["ACE_Cabletie",50];
			_veh addItemCargoGlobal ["ACE_Banana",200];
			_veh addItemCargoGlobal ["ACE_Bodybag",50];
			_veh addBackpackCargoGlobal ["rhsgref_ttsko_alicepack",10];
			_veh addBackpackCargoGlobal ["CUP_B_ACRPara_dpm",10];
		};
		case "cargo_6": {
			_veh addItemCargoGlobal ["ACRE_PRC148",6];
		};
	};
};

//Ajoute le cargo des véhicules, caisses, etc.
[vehicCrate_1,"cargo_1"] call loadCargo;
[vehicCrate_2,"cargo_1"] call loadCargo;
[smokeCrate_1,"cargo_2"] call loadCargo;
[smokeCrate_2,"cargo_2"] call loadCargo;
[smokeCrate_3,"cargo_2"] call loadCargo;
[magCrate_1,"cargo_3"] call loadCargo;
[launcherCrate_1,"cargo_4"] call loadCargo;
[medicCrate_1,"cargo_5"] call loadCargo;

//Spawn des hostiles
execVM "spawn_IA\spawnCamp_1.sqf";
execVM "spawn_IA\spawnCamp_2.sqf";
execVM "spawn_IA\spawnCamp_3.sqf";
execVM "spawn_IA\spawnCamp_4.sqf";

// Set the computer as not hacked 
computerToHack setVariable ["challengeSuccessfull", false, true];