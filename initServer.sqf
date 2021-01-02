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

//Get number of players to allow dynamic hostile units number adaptation
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

//Spawn des hostiles
execVM "spawn_IA\spawnCamp_1.sqf";
execVM "spawn_IA\spawnCamp_2.sqf";
execVM "spawn_IA\spawnCamp_3.sqf";
execVM "spawn_IA\spawnCamp_4.sqf";