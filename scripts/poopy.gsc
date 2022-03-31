#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	thread onPlayerConnect();
}

onPlayerConnect() {
	level endon("disconnect");
	
	for(;;) {
		level waittill("connected", player);
	
		player thread onPlayerSpawned();

		if (!player isBot()) {
			player thread monitorGrenades();
			
			player.editClassNum = "none";
			player.editClassType = "none";
			player.editClassWeapon = "none";
		}
	}
}

onPlayerSpawned() {
	self endon("disconnect");
	
	for(;;) {
		self waittill("spawned_player");

		if (!self isBot()) {

			if (level.gameType == "sd") {
				self maps\mp\perks\_perks::givePerk( "specialty_falldamage" );
			}

			self maps\mp\perks\_perks::givePerk( "specialty_fastmantle" );
			self maps\mp\perks\_perks::givePerk( "specialty_marathon" );
			self maps\mp\perks\_perks::givePerk( "specialty_lightweight" );
			self.hasRadar = true;
		}

		if(isDefined(self.pers["spawnPosition"])){
			self setOrigin( self.pers["spawnPosition"] );
		}
		
		if(isDefined(self.pers["spawnAngle"])){
			self setPlayerAngles( self.pers["spawnAngle"] );
		}
	}
}


monitorGrenades() {
	self endon("disconnect");
	
	for(;;) {
		self waittill( "grenade_fire", grenade, weaponName );
		wait 2.50;
		self maps\mp\perks\_perks::givePerk( weaponName );
	}
}
