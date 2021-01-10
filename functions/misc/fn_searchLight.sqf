/*
Example :
[this, ["mrk_watch2_1","mrk_watch2_2","mrk_watch2_3","mrk_watch2_4","mrk_watch2_5","mrk_watch2_6","mrk_watch2_7"]] spawn int_fnc_searchLight;
*/

params ["_watcher","_tbWatchMrk"];

if !(isServer) exitWith {};
_watcher action ["SearchlightOn", vehicle _watcher];
private _isNearbyENI = objNull;  
while {alive _watcher && (isNull _isNearbyENI)} do {  
	_isNearbyENI = _watcher findNearestEnemy position _watcher;  
	private _watchMrk = selectRandom _tbWatchMrk;
	_watcher doWatch getMarkerPos _watchMrk;  
	sleep 10 + (random 20);  
};