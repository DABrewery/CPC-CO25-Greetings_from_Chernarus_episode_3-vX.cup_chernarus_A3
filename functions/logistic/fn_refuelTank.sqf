/*
 * Author: tanin69
 * Refuel the tank of a fuel vehicle from a nearby fuel station
 *
 * Arguments:
 * 0: Vehicle that the tank is to be refueled <OBJECT>
 * 1: Refuel station <OBJECT>
 * 2: Refueling area : area in which the vehicle must be to be refueled. If the vehicle leaves the area during refuling, the operation is cancelled <OBJECT - Trigger>
 * 3: (optional, default : 10000) Tank capacity of the vehicle <NUMBER>
 *
 * Return value:
 * Nothing
 *
 * Example : [veh, fuelStation, trgRefuel, 5000] call fn_refuelTank.sqf
 *
 */

params[
	"_vehicle", //Véhicule dont la citerne est à ravitailler
	"_station", //Station de refuel
	"_area",    //Zone dans laquelle doit se trouver le véhicule. Si le véhicule quitte la zone en cours de ravitaillement; celui-ci est interrompu
	["_tankCapacity", 10000]
];

private _tankLoad = 0;                 //Quantité actuelle dans la citerne du véhicule
private _stationQuantity = 0;          //Quantité dans la station
private _refuelNeededQuantity = 0;     //Quantité pour remplir la citerne au max
private _refuelDeliveredQuantity = 0;  //Quantité délivrée par la station

//Vérifie la quantité de carburant dans la citerne du véhicule
_tankLoad = [_vehicle] call ace_refuel_fnc_getFuel;

//Calcule la quantité requise pour faire le plein (à enlever de la station)
_refuelNeededQuantity = _tankCapacity - _tankLoad;

//Vérifie la quantité de fuel de la station
_stationQuantity = [_station] call ace_refuel_fnc_getFuel;

//Si la cuve est vide, on sort en renvoyant les bonnes valeurs
if (_stationQuantity == 0) exitWith {hint "La station ne contient plus de fuel, aucun ravitaillement n'a été effectué.";};

//S'il y assez de fuel, on délivre la quantité requise pour le plein
if (_stationQuantity >= _refuelNeededQuantity) then {
	
	_refuelDeliveredQuantity = _refuelNeededQuantity;
	[
		_refuelDeliveredQuantity * 0.01,
		[_vehicle, _station, _area, _tankCapacity, _stationQuantity, _refuelNeededQuantity],
		{
			params ["_args"];
			_args params ["_vehicle", "_station", "_area", "_tankCapacity", "_stationQuantity","_refuelNeededQuantity"];
			//On met à jour la quantité de fuel de la station
			_stationQuantity = _stationQuantity - _refuelNeededQuantity;
			//On met à jour la quantité de fuel de la citerne
			[_vehicle, _tankCapacity] call ace_refuel_fnc_setFuel;
			_refuelDeliveredQuantity = _refuelNeededQuantity;
			[_station, _stationQuantity] call ace_refuel_fnc_setFuel;
			[["%1 litres de carburant ajoutés à la citerne. %2 litres restant dans la station.", _refuelDeliveredQuantity, _stationQuantity],2.5] call ace_common_fnc_displayTextStructured;
		},
		{
			["Ravitaillement de la citerne interrompu. Aucun carburant n'a été transféré.",2.5] call ace_common_fnc_displayTextStructured;
		},
		"Ravitaillement en cours",		
		{
			params ["_args"];
			_args params ["_vehicle", "_station", "_area"];
			_vehicle inArea _area;
		}
		
	] call ace_common_fnc_progressBar
	
} else { //Sinon on délivre le reste

	_refuelDeliveredQuantity = _stationQuantity;

	[
		_refuelDeliveredQuantity * 0.01,
		[_vehicle, _station, _area, _tankCapacity, _stationQuantity, _refuelDeliveredQuantity, _tankLoad],
		{
			params ["_args"];
			_args params ["_vehicle","_station", "_area", "_tankCapacity", "_stationQuantity", "_refuelDeliveredQuantity", "_tankLoad"];
			[_vehicle, _refuelDeliveredQuantity + _tankLoad] call ace_refuel_fnc_setFuel;
			_stationQuantity = 0;
			[_station, _stationQuantity] call ace_refuel_fnc_setFuel;
			[["%1 litres de carburant ajoutés à la citerne. %2 litres restant dans la station.", _refuelDeliveredQuantity, _stationQuantity],2.5] call ace_common_fnc_displayTextStructured;
		},
		{["Ravitaillement de la citerne interrompu.Aucun carburant n'a été transféré.",2.5] call ace_common_fnc_displayTextStructured;},
		"Ravitaillement en cours",
		{
			params ["_args"];
			_args params ["_vehicle", "_station", "_area"];
			_vehicle inArea _area;
		}
	] call ace_common_fnc_progressBar

};
