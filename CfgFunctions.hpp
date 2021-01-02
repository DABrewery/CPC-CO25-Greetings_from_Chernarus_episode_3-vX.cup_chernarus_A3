class CfgFunctions
{
	
	class int
	{
		class spawn_zone
		{
			file="functions\spawn_zone";
			class spawnFixedWeapons {};
			class spawnGarnisons {};
			class spawnRdmPatrols {};
			class spawnMechInfantry {};
		};

		class fleeing
		{
			file="functions\fleeing";
			class doFleeing {};
			class fleeing {};
		};

		class logistic
		{
			class cargoVehicle {};
			class refuelTank {};
		};
		
		class misc
		{
			file="functions\misc";
			class probaChallenge {};
			class findClearZoneInArea {};
		};

	}

};