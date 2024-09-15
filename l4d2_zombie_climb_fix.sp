#include <sourcemod>
#include <sourcescramble>

#pragma semicolon 1
#pragma newdecls required

#define VERSION "1.0.0"

public Plugin myinfo = {
	name = "L4D2 ZombieClimbFix",
	author = "Garamond",
	description = "Fixes zombies not being able to climb over cars",
	version = VERSION,
	url = "https://github.com/garamond13/L4D2-ZombieClimbFix"
};

public void OnPluginStart()
{	
	GameData gamedata = new GameData("l4d2_zombie_climb_fix");
	Address return_val = gamedata.GetAddress("nearby") + view_as<Address>(gamedata.GetOffset("ILocomotion::GetTraversableSlopeLimit_return_val"));

	// Allocate and zero-initializes 4 bytes of memory.
	MemoryBlock block = new MemoryBlock(4);

	// Set new return value for `float ILocomotion::GetTraversableSlopeLimit()`.
	block.StoreToOffset(0, view_as<int>(0.3), NumberType_Int32);
	StoreToAddress(return_val, view_as<int>(block.Address), NumberType_Int32);
	
	CloseHandle(gamedata);
}