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

new Tipss[4][0] = {
{"AvP Bot: Need heavy duty weapons? Use /shop to buy them"},
{"AvP Bot: Why do I have money? To buy weapons, armour, and health (/shop)"},
{"AvP Bot: Army vs. Pirates 0.1 by [Fackin']Pyrokid"},
{"Avp Bot: See a cheater? Use /report to let the admins know"}
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
	SetGameModeText("AvP Ship Attack");
	eg = SetTimer("EndGame", 600000, 1);
	stime = SetTimer("UpdateScore", 1000, 1);
	rheal = SetTimer("RefHeal", 50, 1);
	SetTimer("Tips", 180000, 1);
	SetTimer("UpdateScoreMoney", 1000, 1);
	UsePlayerPedAnims();
	AddPlayerClass(249, -14747.3145,233.3413,8.3430,61.9960, 38, 5000, 16, 5000, 32, 5000);
	AddPlayerClass(287, -14405.7676,239.1276,2.0863,256.7417, 28, 5000, 26, 5000, 30, 5000);
	AddPlayerClass(137, -14962.2588,243.2204,5.0109,283.6920, 32, 5000, 27, 5000, 31, 5000);
	AddPlayerClass(260, -14747.3145,233.3413,8.3430,61.9960, 0, 0, 0, 0, 0, 0);

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
	CreatePickup(346,2,-14739.5029,229.4057,8.0536);
/*	CreatePickup(348,2,-14744.5889,227.0123,8.4410);
	CreatePickup(349,2,-14745.5996,236.0062,8.1378);
	CreatePickup(351,2,-14752.9365,239.8743,8.3945);
	CreatePickup(353,2,-14758.5361,234.9211,8.9224);
	CreatePickup(355,2,-14765.1533,230.8804,8.7519);
	CreatePickup(356,2,-14769.0674,235.7265,9.3642);
	CreatePickup(372,2,-14767.2334,242.4991,9.0481);
	CreatePickup(346,2,-14765.6934,255.1935,8.1732);
	CreatePickup(348,2,-14761.7422,262.3689,6.3096);
	CreatePickup(349,2,-14765.9951,225.5463,7.5895);
	CreatePickup(351,2,-14752.0234,214.0969,5.2346);*/

	//JETPACKS
	AddStaticPickup(370,2,-14496.3984,231.6567,20.2953);
	AddStaticPickup(370,2,-14983.1172,246.1477,8.3875);

	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

	//OBJECTS
	//CARRIER AND ISLAND
	CreateObject(10771, -14474.109, 228.528, 4.495, 0.000, 0.000, 540.000);
	CreateObject(11374, -14468.026, 233.732, 10.984, 0.000, 0.000, 180.000);
	CreateObject(10770, -14477.329, 236.072, 37.725, 0.000, 0.000, 180.000);
	CreateObject(11237, -14477.336, 236.071, 37.726, 0.000, 0.000, 180.000);
	CreateObject(11145, -14411.218, 228.522, 3.305, 0.000, 0.000, 180.000);
	CreateObject(11146, -14465.121, 227.966, 11.339, 0.000, 0.000, 180.000);
	CreateObject(13120, -14701.006, 221.490, -38.216, 0.000, 0.000, 0.000);
	CreateObject(11149, -14468.019, 233.727, 11.024, 0.000, 0.000, 180.000);
	CreateObject(11150, -14539.311, 238.997, 10.971, 0.000, 0.000, 180.000);
	CreateObject(10772, -14475.458, 228.716, 16.286, 0.000, 0.000, 180.000);
	CreateObject(3114, -14417.353, 213.355, 15.739, 0.000, 0.000, 180.000);
	CreateObject(3115, -14375.085, 228.479, 15.994, 0.000, 0.000, 180.000);
	CreateObject(3885, -14507.394, 236.013, 19.795, 360.000, 0.000, 180.000);
	CreateObject(3884, -14507.426, 236.027, 19.795, 0.000, 0.000, 180.000);
	CreateObject(3885, -14438.394, 236.013, 17.055, 360.000, 0.000, 180.000);
	CreateObject(3884, -14438.426, 236.027, 17.115, 0.000, 0.000, 180.000);
	//PIRATE SHIP AND FENCE
	CreateObject(8493, -14949.2, 242.5, 16.2, 0.0, 0.0, -93.0);
	CreateObject(974, -14958.7, 250.3, 2.3, 50.0, 0.0, -5.0);
	CreateObject(974, -14958.3, 254.5, -0.8, 56.0, -1.0, -4.0);
	CreateObject(974, -14958.7, 250.3, 2.2, 50.0, 0.0, -5.0);
	CreateObject(974, -14958.2, 254.5, -0.8, 56.0, -1.0, -4.0);
	CreateObject(974, -14958.7, 250.3, 2.2, 50.0, 0.0, -5.0);
	//JAIL
	CreateObject(988, 1566.138550, -1352.779175, 327.500122, 89.3814, 0.8594, 271.4780);
	CreateObject(988, 1571.005737, -1352.580688, 327.478516, 89.3814, 0.8594, 271.4780);
	CreateObject(988, 1570.819336, -1347.196533, 327.488739, 89.3814, 0.8594, 271.4780);
	CreateObject(988, 1571.100464, -1357.946045, 327.482300, 89.3814, 0.8594, 271.4780);
	CreateObject(988, 1575.906128, -1352.403076, 327.443665, 89.3814, 0.8594, 271.4780);
	CreateObject(988, 1569.706543, -1360.694824, 328.346527, 0.0000, 0.0000, 3.4377);
	CreateObject(988, 1571.984985, -1357.767822, 328.225067, 0.0000, 0.0000, 92.8192);
	CreateObject(988, 1566.965454, -1358.114746, 328.363922, 0.0000, 0.0000, 272.3375);
	CreateObject(988, 1574.649048, -1355.146851, 328.286346, 0.0000, 0.0000, 3.4377);
	CreateObject(988, 1576.724976, -1352.216187, 328.250610, 0.0000, 0.0000, 92.8192);
	CreateObject(988, 1574.395142, -1349.734985, 328.267303, 0.0000, 0.0000, 183.0601);
	CreateObject(988, 1571.680420, -1347.086792, 328.283539, 0.0000, 0.0000, 91.9597);
	CreateObject(988, 1568.864380, -1344.521606, 328.351837, 0.0000, 0.0000, 182.2006);
	CreateObject(988, 1566.682373, -1347.377930, 328.352905, 0.0000, 0.0000, 272.4414);
	CreateObject(988, 1564.163940, -1350.057495, 328.367981, 0.0000, 0.0000, 182.2006);
	CreateObject(988, 1562.035400, -1352.932861, 328.381012, 0.0000, 0.0000, 272.4414);
	CreateObject(988, 1564.390503, -1355.594849, 328.346313, 0.0000, 0.0000, 3.5415);
	//island boats
	AddStaticVehicle(452,-14755.7744,280.9551,-0.7775,59.5297,1,35); //
	AddStaticVehicle(493,-14739.2754,273.1883,0.1714,66.0656,36,13); //
	AddStaticVehicle(493,-14720.4756,261.1646,0.1990,55.5919,36,13); //
	AddStaticVehicle(446,-14711.2217,241.0842,-0.5771,37.4232,3,3); //
	AddStaticVehicle(452,-14711.2559,210.7247,0.1649,295.8626,1,22); //
	AddStaticVehicle(446,-14729.9424,205.3708,-1.1325,293.8999,1,5); //
	AddStaticVehicle(452,-14750.1445,203.8838,0.0722,274.8517,1,16); //
	AddStaticVehicle(493,-14767.2422,205.6103,-0.6306,262.0386,36,13); //
	//pirate boats
	AddStaticVehicle(452,-14973.7773,234.5089,-0.0077,273.3222,1,44); //
	AddStaticVehicle(493,-14958.6084,233.8570,0.0201,265.2943,36,13); //
	AddStaticVehicle(446,-14937.2490,236.4646,-1.1072,294.1776,1,22); //
	AddStaticVehicle(493,-14949.1660,250.6229,0.3327,266.8764,36,13); //
	AddStaticVehicle(446,-14975.3936,254.2151,-1.0463,266.9971,1,35); //
	AddStaticVehicle(452,-14959.5547,263.7829,-1.0217,270.7839,1,53); //
	//carrier boats
	AddStaticVehicle(493,-14391.0205,221.0711,-0.5733,271.6030,36,13); //
	AddStaticVehicle(493,-14375.5576,221.0248,-0.0623,272.0364,36,13); //
	AddStaticVehicle(446,-14374.7852,235.2408,-0.0190,274.1997,1,44); //
	AddStaticVehicle(452,-14388.1299,235.4303,-0.4419,270.5692,1,57); //
	//other cars
	AddStaticVehicle(447,-14417.6475,213.3669,17.3126,92.0517,75,2); //
	AddStaticVehicle(447,-14982.4473,243.8694,8.4029,175.8065,75,2); //
	AddStaticVehicle(487,-14522.8516,232.5079,17.4352,89.0392,29,42); //
	AddStaticVehicle(539,-14532.0439,220.8960,16.6442,92.3287,86,70); //
	AddStaticVehicle(539,-14537.7832,225.2703,16.6442,93.7210,79,74); //
	AddStaticVehicle(539,-14546.4619,229.1637,16.6442,90.2739,70,86); //
	AddStaticVehicle(539,-14965.6914,243.9086,4.2711,175.4658,86,70); // new vortex
	AddStaticVehicle(539,-14954.1494,243.2937,4.2880,357.9334,79,74); // new vortex
	AddStaticVehicle(539,-14946.8486,241.0689,5.2543,358.9181,70,86); // new new vortex
	AddStaticVehicle(487,-14940.9639,241.6495,6.8686,0.2257,12,39); // new mav
	AddStaticVehicle(460,-14960.5654,219.8744,1.3837,263.6209,46,32); // skimmer
	AddStaticVehicle(460,-14444.8262,266.0008,1.7860,91.0754,1,18); // skimmer2
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
	SendRconCommand("changemode avp2");
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
	SetPlayerMapIcon(playerid,0,-14751.5684,224.7775,8.8018,18,COLOR_RED); //island
	SetPlayerMapIcon(playerid,1,-14960.7090,243.5771,5.0109,9,COLOR_RED); //pirate
	SetPlayerMapIcon(playerid,2,-14484.9258,227.3842,17.2841,30,COLOR_RED); //carrier
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
        SendClientMessage(playerid,COLOR_PURPLE,"/suggestion");
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
				    if(gTeam[playerid] == ADMIN)
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
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == REF)
		{
			SetPlayerPos(playerid, -14747.3145,233.3413,8.3430);
			SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == ARMY) {
		    SetPlayerPos(playerid, -14405.7676,239.1276,2.0863);
            SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == PIRATE) {
		    SetPlayerPos(playerid, -14962.2588,243.2204,5.0109);
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

