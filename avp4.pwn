#include <a_samp>
#include <dutils>

#pragma unused ret_memcpy

#define 	COLOR_GREY 		0xAFAFAFAA
#define 	COLOR_GREEN 	0x33AA33AA
#define 	COLOR_RED 		0xAA3333AA
#define 	COLOR_YELLOW 	0xFFFF00AA
#define		COLOR_PINK 		0xFF66FFAA
#define		COLOR_BLUE 		0x0000BBAA
#define 	COLOR_LIGHTBLUE 0x33CCFFAA
#define 	BANRED 			0xD91616AA
#define 	COLOR_ORANGE 	0xFF9900AA
#define 	COLOR_GREY2 	0x999999AA
#define 	COLOR_WHITE 	0xFFFFFFAA
#define 	COLOR_PURPLE 	0xC2A2DAAA
#define 	COLOR_LIGHTGREEN 0x40FF40FF
#define 	COLOR_CYAN 		0x00FFFFAA
#define     COLOR_OLIVE 	0x999933AA
#define     COLOR_BROWN     0xC77826AA
#define     COLOR_GOLD      0xDAA520AA

#define ADMIN 0
#define ARMY 1
#define PIRATE 2
#define REF 3

static gTeam[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];
new adminp[MAX_PLAYERS];
new pname[MAX_PLAYER_NAME];
new mute[MAX_PLAYERS];
new tscore[MAX_PLAYERS];
new pspawned[MAX_PLAYERS];
new injail[MAX_PLAYERS];
new tk[MAX_PLAYERS];

new as;
new ps;
new stime;
new Float:x,Float:y,Float:z;
new nc;
new countt;
new rheal;
new firstspawn[MAX_PLAYERS];

new Menu:shop;
new Menu:shopweps;
new Menu:shoplife;
new eg;

forward EndGame();
forward UpdateScore();
forward RefHeal();
forward Tips();
forward UpdateScoreMoney();
forward CountDown();

new Tipss[5][0] = {
{"AvP Bot: Need heavy duty weapons? Use /shop to buy them"},
{"AvP Bot: Why do I have money? To buy weapons, armour, and health (/shop)"},
{"AvP Bot: Army vs. Pirates 0.1 by [Fackin']Pyrokid"},
{"Avp Bot: See a cheater? Use /report to let the admins know"},
{"Avp Bot: Use /highpoint to teleport you to a high location with a parachute"}
};

new Float:spawns[][0] =
{
{2729.6812,2686.5115,59.0234},
{2693.9653,2784.3000,59.0234},
{2685.8921,2842.7505,62.2206},
{2630.6870,2830.0696,122.9219},
{2509.3203,2692.5923,74.8281},
{2593.9431,2641.9954,109.1719}
};

new RandAnims[6][0] = {
{"DAN_LOOP_A"},
{"DNCE_M_A"},
{"DNCE_M_B"},
{"DNCE_M_C"},
{"DNCE_M_D"},
{"DNCE_M_E"}
};

main()
{
	print("\n----------------------------------");
	print(" AvP ");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
    stime = SetTimer("UpdateScore", 1000, 1);
	countt = 601;
	SetGameModeText("AvP Oil Refinery");
	eg = SetTimer("EndGame", 600000, 1);
	stime = SetTimer("UpdateScore", 1000, 1);
	rheal = SetTimer("RefHeal", 50, 1);
	SetTimer("Tips", 180000, 1);
	SetTimer("UpdateScoreMoney", 1000, 1);
	UsePlayerPedAnims();
	AddPlayerClass(249, 2618.5500,2722.9124,36.5386,118.0436, 38, 5000, 16, 5000, 32, 5000); //admin
	AddPlayerClass(287, 2594.7610,2641.2024,109.1719,327.7838, 28, 5000, 26, 5000, 30, 5000); //army
	AddPlayerClass(137, 2714.8743,2773.6882,74.8281,129.2347, 32, 5000, 27, 5000, 31, 5000); //pirate
	AddPlayerClass(260, 2618.5500,2722.9124,36.5386,118.0436, 0, 0, 0, 0, 0, 0); //spec
	
	//MENUS
	shop = CreateMenu("~b~AvP Shop", 2, 400.0, 290.0, 140.0, 150.0);
	AddMenuItem(shop, 0, "Heavy Duty Weapons");
	AddMenuItem(shop, 0, "Life");
	shopweps = CreateMenu("~r~AvP Shop", 2, 400.0, 270.0, 120.0, 150.0);
	AddMenuItem(shopweps, 0, "Grenade");
	AddMenuItem(shopweps, 0, "Molotov Cocktail");
	AddMenuItem(shopweps, 0, "Sniper");
	AddMenuItem(shopweps, 0, "RPG");
	AddMenuItem(shopweps, 0, "Flamethrower");
	AddMenuItem(shopweps, 0, "Back");
	AddMenuItem(shopweps, 1, "$2,000");
	AddMenuItem(shopweps, 1, "$2,000");
	AddMenuItem(shopweps, 1, "$2,500");
	AddMenuItem(shopweps, 1, "$3,500");
	AddMenuItem(shopweps, 1, "$3,000");
	shoplife = CreateMenu("~g~AvP Shop", 2, 400.0, 290.0, 120.0, 150.0);
	AddMenuItem(shoplife, 0, "Health");
	AddMenuItem(shoplife, 0, "Armour");
	AddMenuItem(shoplife, 1, "$200");
	AddMenuItem(shoplife, 1, "$300");
	AddMenuItem(shoplife, 0, "Back");

	//ISLAND PICKUPS
	CreatePickup(346,2,2581.3364,2813.8103,10.8203);
	CreatePickup(348,2,2581.2334,2817.0493,10.8203);
	CreatePickup(349,2,2581.1523,2819.6067,10.8203);
	CreatePickup(351,2,2581.0547,2822.6936,10.8203);
	CreatePickup(353,2,2580.9587,2825.7129,10.8203);
	CreatePickup(356,2,2580.8474,2829.2126,10.8203);
	CreatePickup(372,2,2580.7534,2832.1780,10.8203);
	CreatePickup(346,2,2580.6360,2835.8745,10.8203);
	CreatePickup(348,2,2578.6843,2832.1138,10.8203);
	CreatePickup(349,2,2578.7566,2829.9871,10.8203);
	CreatePickup(351,2,2578.8518,2827.1909,10.8203);
	CreatePickup(353,2,2578.9695,2823.7456,10.8203);
	CreatePickup(356,2,2579.0667,2820.9111,10.8203);
	//JETPACKS
	//AddStaticPickup(370,2,-1954.4640,2042.3652,7.0466);
	//GATES
	CreateObject(12911, 2624.304199, 2777.570801, 22.818634, 0.0000, 0.0000, 280.9318);
	CreateObject(16138, 2714.807129, 2745.409668, 9.788294, 0.0000, 0.0000, 178.7629);
	CreateObject(5706, 2740.482666, 2813.645996, 15.337120, 0.0000, 0.0000, 0.0000);
	CreateObject(5863, 2754.497314, 2843.154541, 14.591740, 0.0000, 0.0000, 0.0000);
	CreateObject(5864, 2527.913330, 2830.871826, 13.274233, 0.0000, 0.0000, 0.0000);
	CreateObject(5865, 2734.427002, 2768.849609, 13.614298, 0.0000, 0.0000, 0.0000);
	CreateObject(5886, 2800.522949, 2844.841553, 15.902975, 0.0000, 1.7189, 179.5181);
	CreateObject(6871, 2520.019775, 2924.115234, 31.004774, 0.0000, 0.0000, 0.0000);
	CreateObject(17538, 2636.750000, 2896.156494, 24.341269, 0.0000, 0.0000, 269.8631);
	CreateObject(5135, 2732.710938, 2861.657959, 13.972801, 0.8594, 0.0000, 0.0000);
	CreateObject(18255, 2648.100342, 2867.931641, 15.269855, 179.6224, 0.0000, 88.5220);
	CreateObject(12906, 2772.511719, 2782.455322, 9.905951, 0.0000, 0.0000, 181.2372);
	CreateObject(10438, 2640.420898, 2839.930908, 15.308683, 0.0000, 0.0000, 268.8997);
	CreateObject(3399, 2542.586670, 2852.289551, 12.438592, 0.0000, 0.0000, 0.0000);
	CreateObject(3867, 2573.688477, 2852.985840, 17.532570, 0.0000, 0.0000, 180.3776);
	CreateObject(3867, 2557.948730, 2852.478027, 17.506834, 0.0000, 0.0000, 180.3776);
	CreateObject(10831, 2460.000000, 2851.179932, 18.793959, 0.0000, 0.0000, 181.3410);
	CreateObject(10828, 2569.088379, 2872.255615, 21.873718, 0.0000, 0.0000, 269.7591);
	CreateObject(3722, 2757.749756, 2769.172363, 14.238596, 0.0000, 0.0000, 0.0000);
	CreateObject(12930, 2577.859863, 2808.810303, 10.675555, 0.0000, 0.0000, 0.0000);
	CreateObject(13489, 2667.530518, 2846.142822, 11.987952, 0.0000, 0.0000, 86.8031);
	CreateObject(14612, 2622.281006, 2807.110596, 12.533028, 0.0000, 0.0000, 0.0000);
	CreateObject(16601, 2759.492676, 2859.015381, 14.572998, 0.0000, 0.0000, 0.0000);
	CreateObject(925, 2722.030518, 2739.677979, 10.882217, 0.0000, 0.0000, 0.0000);
	CreateObject(3566, 2513.250244, 2832.800537, 12.208168, 0.0000, 0.0000, 0.0000);
	CreateObject(1690, 2717.716064, 2752.137939, 14.387698, 0.0000, 0.0000, 0.0000);
	CreateObject(3257, 2730.561035, 2813.915527, 19.158087, 0.0000, 0.0000, 0.0000);
	CreateObject(3637, 2720.108398, 2842.701660, 17.906429, 0.0000, 0.0000, 0.0000);
	CreateObject(3638, 2637.531494, 2732.577148, 26.102703, 0.0000, 0.0000, 179.8301);
	CreateObject(3675, 2718.120361, 2770.548096, 16.651508, 0.0000, 0.0000, 0.0000);
	CreateObject(16087, 2627.389893, 2862.214600, 8.083687, 0.0000, 0.0000, 0.0000);
	CreateObject(1378, 2418.580078, 2845.650635, 34.124657, 0.0000, 0.0000, 0.0000);
	CreateObject(5773, 2818.685059, 2789.219482, 7.453407, 0.0000, 0.0000, 0.0000);
	CreateObject(7503, 2729.525391, 2693.601563, 9.846851, 0.0000, 0.0000, 90.2409);
	CreateObject(7503, 2737.712646, 2693.680664, 9.866869, 0.0000, 0.0000, 90.2409);
	CreateObject(5126, 2730.426514, 2793.289795, 25.042324, 0.0000, 0.0000, 0.0000);
	CreateObject(1376, 2733.402100, 2793.439453, 16.479105, 0.0000, 0.0000, 270.6186);
	CreateObject(17942, 2650.098633, 2860.272705, 11.195608, 0.0000, 0.0000, 0.0000);
	CreateObject(652, 2503.463135, 2877.785889, 17.552111, 0.0000, 0.0000, 0.0000);
	CreateObject(705, 2758.369873, 2728.917969, 10.095154, 0.0000, 0.0000, 0.0000);
	CreateObject(7040, 2739.092285, 2727.016357, 13.221209, 0.0000, 0.0000, 0.0000);
	CreateObject(7317, 2725.161621, 2710.850586, 15.873083, 0.0000, 0.0000, 0.0000);
	CreateObject(3255, 2653.630615, 2887.244141, 14.100300, 0.0000, 0.0000, 0.0000);
	return 1;
}

public OnGameModeExit()
{
	if(as > ps) { GameTextForAll("~g~The Army team has won this round!",4000,5); print("The Army team has won this round!"); }
	else if(ps > as) { GameTextForAll("~b~The Pirate team has won this round!",4000,5); print("The Pirate team has won this round!"); }
	else if(ps == as) { GameTextForAll("~y~The teams tied!",4000,5); print("The teams tied!"); }
	return 1;
}

public EndGame()
{
	SendRconCommand("changemode avp");
	return 1;
}

public UpdateScore()
{
	countt--;
	if(countt == 600)
	{
	    nc = 10;
	} else if(countt == 540) {
		nc = 9;
	} else if(countt == 480) {
		nc = 8;
	} else if(countt == 420) {
		nc = 7;
	} else if(countt == 360) {
		nc = 6;
	} else if(countt == 300) {
		nc = 5;
	} else if(countt == 240) {
		nc = 4;
	} else if(countt == 180) {
		nc = 3;
	} else if(countt == 120) {
		nc = 2;
	} else if(countt == 60) {
		nc = 1;
	} else if(countt == 1) {
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if (IsPlayerConnected(i))
			{
			    GetPlayerPos(i,x,y,z);
			    SetPlayerHealth(i,1);
			    SetPlayerArmour(i,1);
			    CreateExplosion(x,y,z,1,10.0);
			}
		}
	} else if(countt == 0) {
		EndGame();
	}
	new string[256];
	format(string,sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~r~Kills: ~g~Army: %d - ~b~Pirates: %d~n~~r~Time Left: ~g~%d Minutes",as,ps,nc);
	GameTextForAll(string,1000,5);
	return 1;
}

SetPlayerClass(playerid, classid) {
	if(classid == 0) {
	gTeam[playerid] = 6;
	} else if(classid == 1) {
	gTeam[playerid] = ARMY;
	} else if(classid == 2) {
	gTeam[playerid] = PIRATE;
	} else if(classid == 3) {
	gTeam[playerid] = REF;
	}
}

public RefHeal()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if(gTeam[i] == REF) { SetPlayerHealth(i,100); ResetPlayerMoney(i); ResetPlayerWeapons(i); }
		}
	}
	return 1;
}

public Tips()
{
	new rand = random(sizeof(Tipss));
	SendClientMessageToAll(COLOR_LIGHTBLUE, Tipss[rand][0]);
	return 1;
}

public UpdateScoreMoney()
{
	for(new i;i<200;i++)
	{
 		SetPlayerScore(i,GetPlayerMoney(i));
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    new rand = random(sizeof(RandAnims));
    pspawned[playerid] = 0;
    KillTimer(stime);
    SetPlayerClass(playerid, classid);
    gPlayerClass[playerid] = classid;
    ApplyAnimation(playerid,"DANCING",RandAnims[rand][0],4.0,1,1,1,1,1);
	switch(classid)
	{
	    case 0:
	    {
	    	GameTextForPlayer(playerid,"~r~Admin Only",3500,5);
    	}
	    case 1:
	    {
	    	GameTextForPlayer(playerid,"~g~Army",3500,5);
    	}
    	case 2:
    	{
    		GameTextForPlayer(playerid,"~b~Pirates",3500,5);
    	}
	   	case 3:
    	{
    		GameTextForPlayer(playerid,"~y~Spectator",3500,5);
    	}
	}
	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 90.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1003.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(GetPlayerSkin(playerid) == 249)
	{
	    if(adminp[playerid] == 0)
	    {
	    	SendClientMessage(playerid, COLOR_RED, "You are not logged in as admin");
	    	SetPlayerHealth(playerid, 0);
	    	ForceClassSelection(playerid);
		}
	 }
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerWorldBounds(playerid,2750.3552,2537.2151,2858.0945,2593.7041);
	AllowPlayerTeleport(playerid,false);
	AllowAdminTeleport(true);
	firstspawn[playerid] = 1;
	pspawned[playerid] = 0;
    KillTimer(stime);
	adminp[playerid] = 0;
	tscore[playerid] = 0;
	SetPlayerColor(playerid, COLOR_GREY2);
	GetPlayerName(playerid,pname,MAX_PLAYER_NAME);
	new string[256];
	format(string,sizeof(string),"%s has joined the server.",pname);
	SendClientMessageToAll(COLOR_GREY,string);
	SendClientMessage(playerid,COLOR_GOLD, "Welcome to Pyrokid's Army vs. Pirates Team Deathmatch");
	SendClientMessage(playerid,COLOR_BROWN, "Objective: You are on teams. Kill people on the other team to get points for your team");
	SendClientMessage(playerid,COLOR_BROWN, "Each round is 10 minutes. Whichever team has the most points at the end of the round wins");
	SendClientMessage(playerid,COLOR_BROWN, "WARNING: Don't team kill, you'll cost your team points");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	GetPlayerName(playerid,pname,MAX_PLAYER_NAME);
	new string[256];
    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s has left the server (Timeout).", pname);
        case 1: format(string, sizeof(string), "%s has left the server (Leaving).", pname);
        case 2: format(string, sizeof(string), "%s has left the server (Kicked).", pname);
    }
	SendClientMessageToAll(COLOR_GREY,string);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(gTeam[playerid] != REF) { GivePlayerMoney(playerid, 200); }
	pspawned[playerid] = 1;
	if(injail[playerid] == 1) { SetPlayerPos(playerid,1569.3589,-1352.4086,328.5556); }
	if(gTeam[playerid] == ADMIN) { SetPlayerColor(playerid, COLOR_ORANGE); }
	else if(gTeam[playerid] == ARMY) { SetPlayerColor(playerid, COLOR_GREEN); SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kill those Pirates!"); }
	else if(gTeam[playerid] == PIRATE) { SetPlayerColor(playerid, COLOR_BLUE); SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kill those Army men!"); }
	else if(gTeam[playerid] == REF) { if(firstspawn[playerid] == 1) { SetPlayerColor(playerid, COLOR_YELLOW); SendClientMessage(playerid, COLOR_YELLOW, "You are a spectator. You have unlimited life, but no weapons and no cash."); SendClientMessage(playerid, COLOR_YELLOW, "You spawn with no weapons and have no money to buy weapons."); SendClientMessage(playerid, COLOR_YELLOW, "If somehow you obtain a weapon or cash, they will be automatically taken away."); firstspawn[playerid] = 0; } else { } }
	SetPlayerInterior(playerid,0);
	SetPlayerMapIcon(playerid,0,2580.7534,2832.1780,10.8203,18,COLOR_RED); //weapon icon
	SetPlayerMapIcon(playerid,1,2714.8743,2773.6882,74.8281,9,COLOR_RED); //pirate icon
	SetPlayerMapIcon(playerid,2,2573.1362,2661.5884,37.9099,30,COLOR_RED); //army icon
	SetPlayerMapIcon(playerid,3,2618.5500,2722.9124,36.5386,60,COLOR_RED); //spectator icon
	GivePlayerWeapon(playerid,46,1);
	GivePlayerWeapon(playerid,34,50);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    new playercash;
	if(killerid == INVALID_PLAYER_ID) {
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        ResetPlayerMoney(playerid);
	} else {
		SendDeathMessage(killerid,playerid,reason);
		playercash = GetPlayerMoney(playerid);
		if (playercash > 0)  {
			GivePlayerMoney(killerid, playercash);
			ResetPlayerMoney(playerid);
		} else {
		}
 	}
	new skin[MAX_PLAYERS];
	new skin2[MAX_PLAYERS];
	skin2[killerid] = GetPlayerSkin(killerid);
	skin[playerid] = GetPlayerSkin(playerid);
	if(gTeam[killerid] == PIRATE && gTeam[playerid] == ARMY) { ps++; }
	if(gTeam[killerid] == ARMY && gTeam[playerid] == PIRATE) { as++; }
	if(gTeam[killerid] == ADMIN && gTeam[playerid] == ARMY) { ps++; } //admin is in army skin but kills a pirate
	if(gTeam[killerid] == ADMIN && gTeam[playerid] == PIRATE) { as++; } //admin is in pirate skin but kills a army
	if(gTeam[killerid] == ARMY && gTeam[playerid] == ADMIN) { as++; } //army kills admin in a pirate skin
	if(gTeam[killerid] == PIRATE && gTeam[playerid] == ADMIN) { ps++; } //pirate kills admin in a army skin
	if(gTeam[killerid] == PIRATE && gTeam[playerid] == PIRATE)
	{
	    tk[killerid]++;
		GetPlayerName(killerid,pname,MAX_PLAYER_NAME);
		new string[256];
		new string2[256];
		format(string,sizeof(string),"%s team-killed and his/her team (Pirates) have lost a point!",pname);
		ps--;
		SendClientMessageToAll(COLOR_RED,string);
		ResetPlayerWeapons(killerid);
		ResetPlayerMoney(killerid);
		if(tk[killerid] < 3)
		{
			format(string2,sizeof(string2),"You have comitted %d team kills, 3 is a kick",tk[killerid]);
			SendClientMessage(killerid,BANRED,string2);
		} else if(tk[killerid] == 3) {
			format(string2,sizeof(string2),"You have comitted 3 team kills and have been kicked",tk[killerid]);
			SendClientMessage(killerid,BANRED,string2);
			Kick(killerid);
		}
	}
	if(gTeam[killerid] == ARMY && gTeam[playerid] == ARMY)
	{
	    tk[killerid]++;
		GetPlayerName(killerid,pname,MAX_PLAYER_NAME);
		new string[256];
		new string2[256];
		format(string,sizeof(string),"%s team-killed and his/her team (Army) have lost a point!",pname);
		as--;
		SendClientMessageToAll(COLOR_RED,string);
		if(tk[killerid] < 3)
		{
			format(string2,sizeof(string2),"You have comitted %d team kills, 3 is a kick",tk[killerid]);
			SendClientMessage(killerid,BANRED,string2);
		} else if(tk[killerid] == 3) {
			format(string2,sizeof(string2),"You have comitted 3 team kills and have been kicked",tk[killerid]);
			SendClientMessage(killerid,BANRED,string2);
			Kick(killerid);
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(text[0] == '!' && pspawned[playerid] == 1)
	{
	    new string[256];
	    new gchat[256];
	    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	    strmid(gchat,text,1,strlen(text));
		format(string, sizeof(string),"%s [TeamChat]: %s", pname, gchat);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
			    if(gTeam[playerid] == ADMIN && gTeam[i] == ADMIN)
			    {
                    SendClientMessage(i, COLOR_CYAN, string);
				} else if(gTeam[playerid] == ARMY && gTeam[i] == ARMY) {
				    SendClientMessage(i, COLOR_CYAN, string);
				} else if(gTeam[playerid] == PIRATE && gTeam[i] == PIRATE) {
				    SendClientMessage(i, COLOR_CYAN, string);
				} else if(gTeam[playerid] == REF && gTeam[i] == REF) {
				    SendClientMessage(i, COLOR_CYAN, string);
				}
			}
		}
		return 0;
	}
	if(mute[playerid] == 1)
	{
		SendClientMessage(playerid, BANRED, "You are muted and can't talk");
	    return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(injail[playerid] == 1) { SendClientMessage(playerid,BANRED,"You are in jail and connot do commands"); return 0; }
	new cmd[256], tmp[256], idx, gplayer, sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
	cmd = strtok(cmdtext, idx);
	tmp = strtok(cmdtext, idx);
	gplayer = strval(tmp);
	//ADMIN LOGIN---------------------------------------------------------------
	if(strcmp("/admingen", cmd, true) == 0)
	{
	    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	    new string[256];
	    format(string,sizeof(string),"%s logged in as admin",pname);
		SendClientMessageToAll(COLOR_GREEN, string);
		adminp[playerid] = 1;
		SetPlayerColor(playerid, COLOR_ORANGE);
		gTeam[playerid] = ADMIN;
		return 1;
	}
	//REGULAR COMMANDS----------------------------------------------------------
	if(strcmp("/help", cmd, true) == 0)
	{
	    SendClientMessage(playerid,COLOR_GREY,"======Help Menu=====");
        SendClientMessage(playerid,COLOR_PURPLE,"/cmds - Regular Commands");
        SendClientMessage(playerid,COLOR_PURPLE,"/acmds - Admin Commands");
        SendClientMessage(playerid,COLOR_PURPLE,"![text] - Team Chat");
        SendClientMessage(playerid,COLOR_GREY,"=====================");
		return 1;
	}
	if(strcmp("/cmds", cmd, true) == 0)
	{
	    SendClientMessage(playerid,COLOR_GREY,"======Commands Menu=====");
        SendClientMessage(playerid,COLOR_PURPLE,"/objective, /avpmodes, /home, /admins, /votekick, /shop, /sendcash, /report");
        SendClientMessage(playerid,COLOR_PURPLE,"/suggestion, /highpoint");
        SendClientMessage(playerid,COLOR_GREY,"===========================");
		return 1;
	}
	if(strcmp("/acmds", cmd, true) == 0)
	{

	    SendClientMessage(playerid,COLOR_GREY,"======Admin Menu=====");
        SendClientMessage(playerid,COLOR_PURPLE,"/gmx, /kick, /ban, /(un)mute, /sethealth, /setarmour, /givemoney");
        SendClientMessage(playerid,COLOR_PURPLE,"/(un)jail, /explode, /announce, /timeleft, /stoptime, /changemode");
        SendClientMessage(playerid,COLOR_GREY,"=======================");
		return 1;
	}
	if(strcmp("/objective", cmd, true) == 0)
	{
		SendClientMessage(playerid,COLOR_BROWN, "Objective: You are on teams. Kill people on the other team to get points for your team");
		SendClientMessage(playerid,COLOR_BROWN, "Each round is 10 minutes. Whichever team has the most points at the end of the round wins");
		SendClientMessage(playerid,COLOR_BROWN, "WARNING: Don't team kill, you'll cost your team points");
		return 1;
	}
	if(strcmp("/avpmodes", cmd, true) == 0)
	{
	    SendClientMessage(playerid,COLOR_GREY,"======AvP Game Modes=====");
		SendClientMessage(playerid,COLOR_PURPLE,"1. Ship Attack, 2. PyroIsland, 3. Area 51, 4. Oil Refinery");
        SendClientMessage(playerid,COLOR_GREY,"===========================");
		return 1;
	}
	if(strcmp("/highpoint", cmd, true) == 0)
	{
	    new rand = random(sizeof(spawns));
		SetPlayerPos(playerid,spawns[rand][0],spawns[rand][1],spawns[rand][2]);
		SendClientMessage(playerid,COLOR_LIGHTGREEN,"Teleported to a High Point with a parachute");
		GivePlayerWeapon(playerid,46,1);
		
		return 1;
	}
    if(!strcmp(cmdtext, "/me", true, 3)) // 3 is the length of /me
    {
        if(cmdtext[3] == 0) {
            SendClientMessage(playerid, COLOR_WHITE, "USAGE: /me [action]");
            return 1;
        }
        new str[128];
        GetPlayerName(playerid, str, sizeof(str));
        format(str, sizeof(str), "** %s %s", str, cmdtext[4]);
        SendClientMessageToAll(COLOR_PINK, str);
        return 1;
    }
	if (strcmp(cmd, "/admins", true) == 0)
	{
        if(IsPlayerConnected(playerid))
	    {
			SendClientMessage(playerid, COLOR_LIGHTGREEN, "Admins Online:");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
				    if(gTeam[i] == ADMIN)
				    {
				        new string[256];
						GetPlayerName(i, sendername, sizeof(sendername));
						format(string, sizeof(string), "Admin: %s", sendername);
						SendClientMessage(playerid, COLOR_GREEN, string);
					}
				}
			}
		}
		return 1;
	}
	if(strcmp("/kill", cmd, true) == 0)
	{
	    if(gTeam[playerid] == REF) { KillTimer(rheal); SetPlayerHealth(playerid,0); rheal = SetTimer("RefHeal", 50, 1); } else {
			SetPlayerHealth(playerid,0);
		}
		return 1;
	}
	if(strcmp("/shop", cmd, true) == 0)
	{
		ShowMenuForPlayer(shop,playerid);
		TogglePlayerControllable(playerid,0);
		return 1;
	}
	if(strcmp("/suggestion", cmd, true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /suggestion [suggest]");
			return 1;
		}
		new string[256];
		new year,month,day;
		getdate(year,month,day);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new File:reps=fopen("suggestions.txt", io_append);
		format(string,sizeof(string),"SUGGESTION: %s suggests: %s\r\nOn %d %d, %d\r\n\r\n",sendername,result,month,day,year);
		fwrite(reps,string);
		fclose(reps);
		SendClientMessage(playerid,COLOR_LIGHTGREEN,"Your suggestion has been saved and will be reviewed!");
		return 1;
	}
	if(strcmp("/report", cmd, true) == 0)
	{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /report [playerid] [reason]");
				return 1;
			}
			if(!strlen(result)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /report [playerid] [reason]");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256], string2[256];
				new ip[16];
				GetPlayerIp(gplayer,ip,sizeof(ip));
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new File:reps=fopen("reports.txt", io_append);
				format(string2,sizeof(string2),"REPORT: %s reported %s for reason: %s \r\nIP: %s\r\n\r\n",sendername,giveplayer,result,ip);
				fwrite(reps,string2);
				fclose(reps);
				SendClientMessage(playerid,COLOR_LIGHTGREEN,"Your report has been sent to all admins and saved!");
 				for(new i=0; i<MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
					    if(gTeam[i] == ADMIN)
					    {
							format(string,sizeof(string),"REPORT: %s reports %s for reason: %s",sendername,giveplayer,result);
							SendClientMessage(i,COLOR_RED,string);
						}
					}
				}
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
			return 1;
	}
	if(strcmp("/home", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			SetPlayerPos(playerid, 2618.5500,2722.9124,36.5386);
			SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == REF) {
			SetPlayerPos(playerid, 2618.5500,2722.9124,36.5386);
			SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == ARMY) {
		    SetPlayerPos(playerid, 2594.7610,2641.2024,109.1719);
            SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == PIRATE) {
		    SetPlayerPos(playerid, 2714.8743,2773.6882,74.8281);
		    SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		}
		return 1;
	}
	if(strcmp("/sendcash", cmd, true) == 0)
	{
	 		new tmp2[256];
			tmp2 = strtok(cmdtext, idx);
	 		new monz = strval(tmp2);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sendcash [playerid] [cash]");
				return 1;
			}
			if(!strlen(tmp2)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sendcash [playerid] [cash]");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
			    if(GetPlayerMoney(playerid) >= monz)
			    {
					new string[256];
					GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string,sizeof(string),"%s has sent you $%d",sendername,monz);
					SendClientMessageToAll(COLOR_YELLOW,string);
					GivePlayerMoney(gplayer,monz);
					GivePlayerMoney(playerid,-monz);
				} else {
				    SendClientMessage(playerid, BANRED, "You don't have that much money");
				}
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
			return 1;
	}
	//ADMIN COMMANDS------------------------------------------------------------
	if(strcmp("/changemode", cmd, true) == 0)
	{
		new string[256];
	 	new m = strval(tmp);
		if(!strlen(tmp)) {
		    SendClientMessage(playerid, COLOR_RED, "See /avpmodes for all AvP game modes");
			SendClientMessage(playerid, COLOR_RED, "USAGE: /changemode [mode number]");
			return 1;
		}
		if(gTeam[playerid] == ADMIN)
		{
			if(m == 1)
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s changed mode to AvP Ship Attack",sendername);
				SendClientMessageToAll(COLOR_YELLOW,string);
				SendRconCommand("changemode avp1");
			} else  if(m == 2) {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s changed mode to AvP PyroIsland",sendername);
				SendClientMessageToAll(COLOR_YELLOW,string);
				SendRconCommand("changemode avp2");
			} else  if(m == 3) {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s changed mode to AvP Area 51",sendername);
				SendClientMessageToAll(COLOR_YELLOW,string);
				SendRconCommand("changemode avp3");
            } else  if(m == 4) {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s changed mode to AvP Oil Refinery",sendername);
				SendClientMessageToAll(COLOR_YELLOW,string);
				SendRconCommand("changemode avp4");
			} else {
			    SendClientMessage(playerid, BANRED, "No such mode");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "Only Admins can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/stoptime", true, 9)==0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(gTeam[playerid] == ADMIN)
		{
  			new string[256];
			format(string, sizeof(string), "Admin %s stopped the timer.", sendername);
		    KillTimer(eg);
		    KillTimer(stime);
		    SendClientMessage(gplayer, COLOR_YELLOW, string);
		} else {
			SendClientMessage(playerid, BANRED, "Only Admins can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/goto", true, 5)==0)
	{
		GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /goto [playerid]");
		}
		if(gTeam[playerid] == ADMIN)
		{
		    if(IsPlayerConnected(gplayer))
		    {
			    new string[256];
				format(string, sizeof(string), "You teleported to %s", giveplayer);
				SendClientMessage(playerid, COLOR_GREEN, string);
				if(gTeam[playerid] == ADMIN) {
				    GetPlayerPos(gplayer, x,y,z);
				    SetPlayerPos(playerid, x,y,z+3);
					format(string,sizeof(string),"Admin %s teleported to your location",sendername);
					SendClientMessage(gplayer, COLOR_GREEN, string);
				}
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, BANRED, "Only Admins can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/bring", true, 6)==0)
	{
		GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bring [playerid]");
		}
		if(gTeam[playerid] == ADMIN)
		{
		    if(IsPlayerConnected(gplayer))
		    {
			    new string[256];
				format(string, sizeof(string), "You teleported to %s to you", giveplayer);
				SendClientMessage(playerid, COLOR_GREEN, string);
				if(gTeam[playerid] == ADMIN) {
				    GetPlayerPos(playerid, x,y,z);
				    SetPlayerPos(gplayer, x,y,z+3);
					format(string,sizeof(string),"Admin %s teleported you to their location",sendername);
					SendClientMessage(gplayer, COLOR_GREEN, string);
				}
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, BANRED, "Only Admins can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/announce", true, 9)==0)
	{
	    if(gTeam[playerid] == ADMIN)
	    {
			new str[256];
			format(str, 256, "%s", cmdtext[10]);
			GameTextForAll(str, 4500, 3);
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Admins can use this command!");
		}
		return 1;
	}
	if(strcmp("/timeleft", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
		    new secs = strval(tmp);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /timeleft [time (seconds)]");
				return 1;
			}
			/*if(strval(tmp) > 601) {
				SendClientMessage(playerid, COLOR_WHITE, "Round can't be longer than 10 minutes");
				return 1;
			}
			if(strval(tmp) < 60) {
				SendClientMessage(playerid, COLOR_WHITE, "Round can't be shorter than 1 minute");
				return 1;
			}*/
			new string[256];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string,sizeof(string),"Admin %s changed the round time! %d seconds left!",sendername,secs);
			SendClientMessageToAll(COLOR_YELLOW,string);
			KillTimer(stime);
			countt = secs;
			stime = SetTimer("UpdateScore", 1000, 1);
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	if(strcmp("/explode", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /explode [playerid]");
				return 1;
			}
			if(IsPlayerConnected(gplayer)) {
				GetPlayerPos(gplayer,x,y,z);
				CreateExplosion(x,y,z,6,10);
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
	    return 1;
	}
	if(strcmp("/jail", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /jail [playerid] [reason]");
				return 1;
			}
			if(!strlen(result)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /jail [playerid] [reason]");
				return 1;
			}
			if(IsPlayerConnected(gplayer)) {
				if(injail[gplayer] == 0) {
					new string[256];
					GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string,sizeof(string),"Admin %s has sentenced %s to jail for reason: %s",sendername,giveplayer,result);
					SendClientMessageToAll(COLOR_YELLOW,string);
					SetPlayerPos(gplayer,1569.3589,-1352.4086,328.5556);
					ResetPlayerWeapons(gplayer);
					injail[gplayer] = 1;
				} else {
				    SendClientMessage(playerid, BANRED, "That player is already in jail!");
				}
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
	    return 1;
	}
	if(strcmp("/unjail", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /unjail [playerid]");
				return 1;
			}
			if(IsPlayerConnected(gplayer)) {
				if(injail[gplayer] == 1)
				{
				    GetPlayerPos(gplayer,x,y,z);
				    KillTimer(rheal);
				    injail[gplayer] = 0;
				    CreateExplosion(x,y,z,6,10);
				    CreateExplosion(x,y,z,6,10);
				    rheal = SetTimer("RefHeal", 50, 1);
					GetPlayerName(gplayer,pname,MAX_PLAYER_NAME);
					new string[256];
					format(string,sizeof(string),"You set %s free",pname);
					SendClientMessage(gplayer,COLOR_YELLOW,"You have been set free");
					SendClientMessage(playerid,COLOR_YELLOW,string);
				} else {
				    SendClientMessage(playerid, BANRED, "That player isn't in jail");
				}
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
	    return 1;
	}
	if(strcmp("/gmx", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
	    	GameModeExit();
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
	    return 1;
	}
	if(strcmp("/givemoney", cmd, true) == 0)
	{
 		new tmp2[256];
		tmp2 = strtok(cmdtext, idx);
 		new monz = strval(tmp2);
		if(gTeam[playerid] == ADMIN)
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givemoney [playerid] [cash]");
				return 1;
			}
			if(!strlen(tmp2)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givemoney [playerid] [cash]");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256];
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s sent you $%d",sendername,monz);
				SendClientMessageToAll(COLOR_YELLOW,string);
				GivePlayerMoney(gplayer,monz);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	if(strcmp("/kick", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [playerid] [reason]");
				return 1;
			}
			if(!strlen(result)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [playerid] [reason]");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256];
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s has kicked %s for reason: %s",sendername,giveplayer,result);
				SendClientMessageToAll(COLOR_YELLOW,string);
				Kick(gplayer);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	if(strcmp("/ban", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ban [playerid] [reason]");
				return 1;
			}
			if(!strlen(result)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ban [playerid] [reason]");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256];
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s has banneded %s for reason: %s",sendername,giveplayer,result);
				SendClientMessageToAll(COLOR_YELLOW,string);
				Ban(gplayer);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	if(strcmp("/mute", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /mute [playerid] [reason]");
				return 1;
			}
			if(!strlen(result)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /mute [playerid] [reason]");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256];
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"Admin %s has muted %s for reason: %s",sendername,giveplayer,result);
				SendClientMessageToAll(COLOR_YELLOW,string);
				mute[gplayer] = 1;
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	if(strcmp("/unmute", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /unmute [playerid]");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256];
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				format(string,sizeof(string),"You have un-muted %s",giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
				SendClientMessage(gplayer,COLOR_LIGHTGREEN,"You have been un-muted");
				mute[gplayer] = 0;
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	if(strcmp("/sethealth", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
		    new tmp2[256];
		    tmp2 = strtok(cmdtext, idx);
		    new health = strval(tmp2);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sethealth [playerid] [health]");
				return 1;
			}
			if(!strlen(tmp2)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sethealth [playerid] [health]");
				return 1;
			}
			if(health > 100) {
				SendClientMessage(playerid, COLOR_WHITE, "User's health cannot be more than 100");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256];
				new string2[256];
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"You set %s's health to %d",giveplayer,health);
				SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
				format(string2,sizeof(string2),"You're health has been set to %d",health);
				SendClientMessage(gplayer,COLOR_LIGHTGREEN,string2);
				SetPlayerHealth(gplayer,health);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	if(strcmp("/setarmour", cmd, true) == 0)
	{
		if(gTeam[playerid] == ADMIN)
		{
		    new tmp2[256];
		    tmp2 = strtok(cmdtext, idx);
		    new health = strval(tmp2);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /setarmour [playerid] [health]");
				return 1;
			}
			if(!strlen(tmp2)) {
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /setarmour [playerid] [health]");
				return 1;
			}
			if(health > 100) {
				SendClientMessage(playerid, COLOR_WHITE, "User's armour cannot be more than 100");
				return 1;
			}
			if(IsPlayerConnected(gplayer))
			{
				new string[256];
				new string2[256];
				GetPlayerName(gplayer, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string,sizeof(string),"You set %s's armour to %d",giveplayer,health);
				SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
				format(string2,sizeof(string2),"You're armour has been set to %d",health);
				SendClientMessage(gplayer,COLOR_LIGHTGREEN,string2);
				SetPlayerArmour(gplayer,health);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You're not an admin!");
		}
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:current = GetPlayerMenu(playerid);
	if(current == shop)
	{
	    switch(row)
	    {
	        case 0:
	        {
	        	HideMenuForPlayer(shop,playerid);
	        	ShowMenuForPlayer(shopweps,playerid);
	        	TogglePlayerControllable(playerid,0);
	        }
	        case 1:
	        {
	        	HideMenuForPlayer(shop,playerid);
	        	ShowMenuForPlayer(shoplife,playerid);
	        	TogglePlayerControllable(playerid,0);
	        }
		}
	}
	if(current == shopweps)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            if(gTeam[playerid] != ADMIN)
	            {
	                if(GetPlayerMoney(playerid) > 2000)
	                {
			            TogglePlayerControllable(playerid,1);
						GivePlayerWeapon(playerid, 16, 5);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "You bought 5 grenades for $2,000");
						GivePlayerMoney(playerid,-2000);
					} else {
						SendClientMessage(playerid,BANRED,"You don't have enough money");
						TogglePlayerControllable(playerid,1);
					}
				} else {
    				TogglePlayerControllable(playerid,1);
					GivePlayerWeapon(playerid, 16, 20);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "You got 20 grenades for free (admin discount)");
				}
	        }
	        case 1:
	        {
	            if(gTeam[playerid] != ADMIN)
	            {
	                if(GetPlayerMoney(playerid) > 2000)
	                {
			            TogglePlayerControllable(playerid,1);
						GivePlayerWeapon(playerid, 18, 5);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "You bought 5 molotovs for $2,000");
						GivePlayerMoney(playerid,-2000);
					} else {
						SendClientMessage(playerid,BANRED,"You don't have enough money");
						TogglePlayerControllable(playerid,1);
					}
				} else {
     				TogglePlayerControllable(playerid,1);
					GivePlayerWeapon(playerid, 18, 20);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "You got 20 molotovs for free (admin discount)");
				}
	        }
	        case 2:
	        {
	            if(gTeam[playerid] != ADMIN)
	            {
	                if(GetPlayerMoney(playerid) > 2500)
	                {
			            TogglePlayerControllable(playerid,1);
						GivePlayerWeapon(playerid, 34, 15);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "You bought a sniper with 15 bullets for $2,500");
						GivePlayerMoney(playerid,-2500);
					} else {
						SendClientMessage(playerid,BANRED,"You don't have enough money");
						TogglePlayerControllable(playerid,1);
					}
				} else {
    				TogglePlayerControllable(playerid,1);
					GivePlayerWeapon(playerid, 34, 100);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "You got a sniper with 100 bullets for free (admin discount)");
				}
	        }
	        case 3:
	        {
	            if(gTeam[playerid] != ADMIN)
	            {
	                if(GetPlayerMoney(playerid) > 3500)
	                {
			            TogglePlayerControllable(playerid,1);
						GivePlayerWeapon(playerid, 35, 5);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "You bought an RPG with 5 bullets for $3,500");
						GivePlayerMoney(playerid,-3500);
					} else  {
						SendClientMessage(playerid,BANRED,"You don't have enough money");
						TogglePlayerControllable(playerid,1);
					}
				} else {
    				TogglePlayerControllable(playerid,1);
					GivePlayerWeapon(playerid, 35, 100);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "You got an RPG with 100 bullets for free (admin discount)");
				}
	        }
	        case 4:
	        {
	            if(gTeam[playerid] != ADMIN)
	            {
	                if(GetPlayerMoney(playerid) > 3000)
	                {
			            TogglePlayerControllable(playerid,1);
						GivePlayerWeapon(playerid, 37, 15);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "You bought a flamethrower for $3,000");
						GivePlayerMoney(playerid,-3000);
					} else {
						SendClientMessage(playerid,BANRED,"You don't have enough money");
						TogglePlayerControllable(playerid,1);
					}
				} else {
    				TogglePlayerControllable(playerid,1);
					GivePlayerWeapon(playerid, 37, 1000);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "You got a flamethrower for free (admin discount)");
				}
	        }
	        case 5:
	        {
	            TogglePlayerControllable(playerid,0);
				HideMenuForPlayer(shopweps,playerid);
				ShowMenuForPlayer(shop,playerid);
	        }
		}
	}
	if(current == shoplife)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            if(gTeam[playerid] != ADMIN)
	            {
	                if(GetPlayerMoney(playerid) > 200)
	                {
			            TogglePlayerControllable(playerid,1);
						SetPlayerHealth(playerid,100);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "You bought health for $200");
						GivePlayerMoney(playerid,-200);
					} else {
						SendClientMessage(playerid,BANRED,"You don't have enough money");
						TogglePlayerControllable(playerid,1);
					}
				} else {
    				TogglePlayerControllable(playerid,1);
					SetPlayerHealth(playerid,100);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "You got health for free (admin discount)");
				}
	        }
	        case 1:
	        {
	            if(gTeam[playerid] != ADMIN)
	            {
	                if(GetPlayerMoney(playerid) > 300)
	                {
			            TogglePlayerControllable(playerid,1);
						SetPlayerArmour(playerid,100);
						SendClientMessage(playerid, COLOR_LIGHTGREEN, "You bought armour for $300");
						GivePlayerMoney(playerid,-300);
					} else {
						SendClientMessage(playerid,BANRED,"You don't have enough money");
						TogglePlayerControllable(playerid,1);
					}
				} else {
    				TogglePlayerControllable(playerid,1);
					SetPlayerArmour(playerid,100);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "You got armour for free (admin discount)");
				}
	        }
	        case 2:
	        {
	            TogglePlayerControllable(playerid,0);
				HideMenuForPlayer(shoplife,playerid);
				ShowMenuForPlayer(shop,playerid);
	        }
		}
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid,1);
	return 1;
}

