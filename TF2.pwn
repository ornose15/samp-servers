#include <a_samp>
#include <cpstream>

#define 	COLOR_GREY 		0xAFAFAFAA
#define 	COLOR_GREEN 	0x33AA33AA
#define 	COLOR_RED 		0xAA3333AA
#define 	COLOR_YELLOW 	0xFFFF00AA
#define		COLOR_PINK 		0xFF66FFAA
#define		COLOR_BLUE 		0x0000BBAA
#define 	COLOR_LIGHTBLUE 0x33CCFFAA
#define 	COLOR_GREY2 	0x999999AA
#define 	COLOR_WHITE 	0xFFFFFFAA
#define 	COLOR_PURPLE 	0xC2A2DAAA
#define 	COLOR_CYAN 		0x00FFFFAA
#define     COLOR_OLIVE 	0x999933AA
#define     COLOR_BROWN     0xC77826AA
#define 	COLOR_RED 		0xAA3333AA
#define 	COLOR_BLACK 	0x000000FF
#define 	COLOR_GOLD 		0xFDCD3BAA
#define 	COLOR_YELLOW 	0xFFFF00AA
#define 	COLOR_GREEN 	0x33AA33AA
#define 	COLOR_AQUA 		0x18DEDCAA
#define 	COLOR_BLUE 		0x0000BBAA
#define 	COLOR_PINK 		0xFF66FFAA
#define 	COLOR_VIOLET 	0x800080AA
#define 	COLOR_CA 		0xEBE472FF
#define 	COLOR_MYBLUE 	0x1A8FCEFF
#define 	COLOR_WHITE 	0xFFFFFFAA
#define 	COLOR_LIGHTBLUE 0x33CCFFAA
#define 	COLOR_DARKRED 	0x660000AA
#define 	COLOR_BEIGE 	0xEDE58FAA
#define 	COLOR_LBLUE 	0x0066FFAA
#define 	LEAVE 			0xc8bebeAA
#define 	BANRED 			0xFF0000AA
#define 	COLOR_TRUEPINK 	0xFF3399AA
#define 	COLOR_GRAY 		0xC6BCBCAA
#define 	COLOR_ORANGE 	0xFF6600AA
#define 	COLOR_GREEN2 	0x40FF40FF

static gTeam[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];

new pname[MAX_PLAYER_NAME];

#define RSCOUT 0
#define RPYRO 1
#define RSOLDIER 2
#define RDEMO 3
#define RENGY 4
#define RHEAVY 5
#define RSNIPER 6
#define RMEDIC 7
#define RSPY 8

#define BSCOUT 9
#define BPYRO 10
#define BSOLDIER 11
#define BDEMO 12
#define BENGY 13
#define BHEAVY 14
#define BSNIPER 15
#define BMEDIC 16
#define BSPY 17

new RandAnims[6][0] = {
{"DAN_LOOP_A"},
{"DNCE_M_A"},
{"DNCE_M_B"},
{"DNCE_M_C"},
{"DNCE_M_D"},
{"DNCE_M_E"}
};

new insetup1[MAX_PLAYERS];
new insetup2[MAX_PLAYERS];
new attack[MAX_PLAYERS];
new spc[MAX_PLAYERS], ncp[MAX_PLAYERS] /*winner[MAX_PLAYERS], loser[MAX_PLAYERS]*/;
new cptimer;
new rtimer;
new cptt;
new rtt;
new clk;
new kt;
new ktt;
new showtd;

new Text:Clock;

forward InSetUp2();
forward Switch();
forward CPTimer();
forward SetUp1();
forward RoundTime();
forward time();
forward KillTime();

main()
{
	print("\n----------------------------------");
	print(" TF2 In San Andreas");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	showtd = 1;
	SetUp1();
	clk = SetTimer("time",1000,1);
	UsePlayerPedAnims();
	rtt = 180;
	rtimer = SetTimer("RoundTime",1000,1);
	SetGameModeText("cp_santos");
	// RED ATTACK
	AddPlayerClass(170, 1958.3783, 1343.1572, 15.3746, 269.1425, 27, 500, 22, 500, 4, 1);// scout
	AddPlayerClass(180, 1958.3783, 1343.1572, 15.3746, 269.1425, 37, 999, 25, 500, 42, 500);// pyro
	AddPlayerClass(58, 1958.3783, 1343.1572, 15.3746, 269.1425, 35, 100, 25, 500, 6, 1);// soldier
	// RED DEFEND
	AddPlayerClass(142, 1958.3783, 1343.1572, 15.3746, 269.1425, 16, 100, 17, 10, 5, 1);//demo
	AddPlayerClass(19, 1958.3783, 1343.1572, 15.3746, 269.1425, 25, 500, 22, 500, 15, 1);//engineer
	AddPlayerClass(264, 1958.3783, 1343.1572, 15.3746, 269.1425, 38, 500, 25, 500, 1, 1);//heavy
	// RED SUPPORT
	AddPlayerClass(203, 1958.3783, 1343.1572, 15.3746, 269.1425, 34, 500, 32, 500, 4, 1);//sniper
	AddPlayerClass(189, 1958.3783, 1343.1572, 15.3746, 269.1425, 28, 500, 4, 1, 0, 0);//medic
	AddPlayerClass(97, 1958.3783, 1343.1572, 15.3746, 269.1425, 24, 500, 4, 1, 0, 0);//spy
	/////////////////////////////////////////////////////////////////////////////////////////
	// BLUE ATTACK
	AddPlayerClass(185, 1958.3783, 1343.1572, 15.3746, 269.1425, 27, 500, 22, 500, 4, 1);// scout
	AddPlayerClass(143, 1958.3783, 1343.1572, 15.3746, 269.1425, 37, 999, 25, 500, 42, 500);// pyro
	AddPlayerClass(24, 1958.3783, 1343.1572, 15.3746, 269.1425, 35, 100, 25, 500, 6, 1);// soldier
	// BLUE DEFEND
	AddPlayerClass(184, 1958.3783, 1343.1572, 15.3746, 269.1425, 16, 100, 17, 10, 5, 1);//demo
	AddPlayerClass(156, 1958.3783, 1343.1572, 15.3746, 269.1425, 25, 500, 22, 500, 15, 1);//engineer
	AddPlayerClass(182, 1958.3783, 1343.1572, 15.3746, 269.1425, 38, 500, 25, 500, 1, 1);//heavy
	// BLUE SUPPORT
	AddPlayerClass(261, 1958.3783, 1343.1572, 15.3746, 269.1425, 34, 500, 32, 500, 4, 1);//sniper
	AddPlayerClass(21, 1958.3783, 1343.1572, 15.3746, 269.1425, 28, 500, 4, 1, 0, 0);//medic
	AddPlayerClass(154, 1958.3783, 1343.1572, 15.3746, 269.1425, 24, 500, 4, 1, 0, 0);//spy
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    new rand = random(sizeof(RandAnims));
    SetPlayerFacingAngle(playerid, 90);
    gPlayerClass[playerid] = classid;
    //SetPlayerClass(playerid, classid);
	SetPlayerPos(playerid, 1351.0912,2136.9329,11.0156);
	SetPlayerCameraPos(playerid, 1346.7181,2136.7241,11.0156);
	SetPlayerCameraLookAt(playerid, 1346.7181,2136.7241,11.0156);
	ApplyAnimation(playerid,"DANCING",RandAnims[rand][0],4.0,1,1,1,1,1);
	switch(classid)
	{
	    case 0:
	    {
	        GameTextForPlayer(playerid, "~r~Attack~n~Scout", 3000, 3);
	        gTeam[playerid] = RSCOUT;
	    }
	    case 1:
	    {
	        GameTextForPlayer(playerid, "~r~Attack~n~Pyro", 3000, 3);
	        gTeam[playerid] = RPYRO;
	    }
	    case 2:
	    {
	        GameTextForPlayer(playerid, "~r~Attack~n~Soldier", 3000, 3);
	        gTeam[playerid] = RSOLDIER;
	    }
	    case 3:
	    {
	        GameTextForPlayer(playerid, "~r~Defend~n~Demoman", 3000, 3);
	        gTeam[playerid] = RDEMO;
	    }
	    case 4:
	    {
	        GameTextForPlayer(playerid, "~r~Defend~n~Engineer", 3000, 3);
	        gTeam[playerid] = RENGY;
	    }
	    case 5:
	    {
	        GameTextForPlayer(playerid, "~r~Defend~n~Heavy", 3000, 3);
	        gTeam[playerid] = RHEAVY;
	    }
	    case 6:
	    {
	        GameTextForPlayer(playerid, "~r~Support~n~Sniper", 3000, 3);
	        gTeam[playerid] = RSNIPER;
	    }
	    case 7:
	    {
	        GameTextForPlayer(playerid, "~r~Support~n~Medic", 3000, 3);
	        gTeam[playerid] = RMEDIC;
	    }
	    case 8:
	    {
	        GameTextForPlayer(playerid, "~r~Support~n~Spy", 3000, 3);
	        gTeam[playerid] = RSPY;
	    }
	    case 9:
	    {
	        GameTextForPlayer(playerid, "~b~Attack~n~Scout", 3000, 3);
	        gTeam[playerid] = BSCOUT;
	    }
	    case 10:
	    {
	        GameTextForPlayer(playerid, "~b~Attack~n~Pyro", 3000, 3);
	        gTeam[playerid] = BPYRO;
	    }
	    case 11:
	    {
	        GameTextForPlayer(playerid, "~b~Attack~n~Soldier", 3000, 3);
	        gTeam[playerid] = BSOLDIER;
	    }
	    case 12:
	    {
	        GameTextForPlayer(playerid, "~b~Defend~n~Demoman", 3000, 3);
	        gTeam[playerid] = BDEMO;
	    }
	    case 13:
	    {
	        GameTextForPlayer(playerid, "~b~Defend~n~Engineer", 3000, 3);
	        gTeam[playerid] = BENGY;
	    }
	    case 14:
	    {
	        GameTextForPlayer(playerid, "~b~Defend~n~Heavy", 3000, 3);
	        gTeam[playerid] = BHEAVY;
	    }
	    case 15:
	    {
	        GameTextForPlayer(playerid, "~b~Support~n~Sniper", 3000, 3);
	        gTeam[playerid] = BSNIPER;
	    }
	    case 16:
	    {
	        GameTextForPlayer(playerid, "~b~Support~n~Medic", 3000, 3);
	        gTeam[playerid] = BMEDIC;
	    }
	    case 17:
	    {
	        GameTextForPlayer(playerid, "~b~Support~n~Spy", 3000, 3);
	        gTeam[playerid] = BSPY;
	    }
	}
	return 1;
}

/*SetPlayerClass(playerid, classid) {
	if(classid == 0) {
		gTeam[playerid] = RSCOUT;
	} else if(classid == 1) {
	gTeam[playerid] = RPYRO;
	} else if(classid == 2) {
		gTeam[playerid] = RSOLDIER;
	} else if(classid == 3) {
		gTeam[playerid] = RDEMO;
	} else if(classid == 4) {
		gTeam[playerid] = RENGY;
	} else if(classid == 5) {
		gTeam[playerid] = RHEAVY;
	} else if(classid == 6) {
 		gTeam[playerid] = RSNIPER;
 	} else if(classid == 7) {
 		gTeam[playerid] = RMEDIC;
	} else if(classid == 8) {
 		gTeam[playerid] = RSPY;
 	/////////////////////////////////////////////////
	} else if(classid == 9) {
		gTeam[playerid] = BSCOUT;
	} else if(classid == 10) {
		gTeam[playerid] = BPYRO;
	} else if(classid == 11) {
		gTeam[playerid] = BSOLDIER;
	} else if(classid == 12) {
		gTeam[playerid] = BDEMO;
	} else if(classid == 13) {
		gTeam[playerid] = BENGY;
	} else if(classid == 14) {
		gTeam[playerid] = BHEAVY;
	} else if(classid == 15) {
 		gTeam[playerid] = BSNIPER;
 	} else if(classid == 16) {
 		gTeam[playerid] = BMEDIC;
	} else if(classid == 17) {
 		gTeam[playerid] = BSPY;
	}
}*/

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(showtd == 1)
	{
		time();
		showtd = 0;
	}
    GetPlayerName(playerid,pname,MAX_PLAYER_NAME);
	SetPlayerColor(playerid,LEAVE);
	new string[256];
	format(string,sizeof(string),"%s has joined the server.",pname);
	SendClientMessageToAll(COLOR_GREY,string);
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

public SetUp1()
{
	cptt = 11;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    insetup1[i] = 1;
	    spc[i] = 1;
	    ncp[i] = 0;
	    if(IsPlayerConnected(i))
	    {
		    insetup1[i] = 1;
		    if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY)
		    {
		       	attack[i] = 0;
				if(attack[i] == 0)
				{
					SetPlayerPos(i,2134.5505,-2276.9448,20.6719);
					SetPlayerFacingAngle(i,307.0222);
				}
			} else if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY) {
  				attack[i] = 1;
				if(attack[i] == 1)
				{
					SetPlayerPos(i,2191.0737,-2264.2754,13.5376);
					SetPlayerFacingAngle(i,63.6913);
				}
			}
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(spc[i] == 1)
			{
			    //cp1 = CPS_AddCheckpoint(2138.6343,-2257.6304,13.3017,7,30);
			    SetPlayerCheckpoint(i,2138.6343,-2257.6304,13.3017,7);
			    spc[i] = 0;
			}
		}
	}
	if(gTeam[playerid] == RSCOUT || gTeam[playerid] == RPYRO || gTeam[playerid] == RSOLDIER || gTeam[playerid] == RDEMO || gTeam[playerid] == RENGY || gTeam[playerid] == RHEAVY || gTeam[playerid] == RSNIPER || gTeam[playerid] == RMEDIC || gTeam[playerid] == RSPY) {
		SetPlayerColor(playerid,COLOR_RED);
	} else if(gTeam[playerid] == BSCOUT || gTeam[playerid] == BPYRO || gTeam[playerid] == BSOLDIER || gTeam[playerid] == BDEMO || gTeam[playerid] == BENGY || gTeam[playerid] == BHEAVY || gTeam[playerid] == BSNIPER || gTeam[playerid] == BMEDIC || gTeam[playerid] == BSPY) {
		SetPlayerColor(playerid,COLOR_BLUE);
	}
	if(insetup1[playerid] == 1)
	{
	    if(gTeam[playerid] == BSCOUT || gTeam[playerid] == BPYRO || gTeam[playerid] == BSOLDIER || gTeam[playerid] == BDEMO || gTeam[playerid] == BENGY || gTeam[playerid] == BHEAVY || gTeam[playerid] == BSNIPER || gTeam[playerid] == BMEDIC || gTeam[playerid] == BSPY)
		{
			attack[playerid] = 0;
			if(attack[playerid] == 0)
			{
				SetPlayerPos(playerid,2134.5505,-2276.9448,20.6719);
				SetPlayerFacingAngle(playerid,307.0222);
				SetPlayerFacingAngle(playerid,63.6913);GameTextForPlayer(playerid,"~b~Defend~n~~w~Defend both of your control points (red checkpoint)",5000,5);
			}
		} else if(gTeam[playerid] == RSCOUT || gTeam[playerid] == RPYRO || gTeam[playerid] == RSOLDIER || gTeam[playerid] == RDEMO || gTeam[playerid] == RENGY || gTeam[playerid] == RHEAVY || gTeam[playerid] == RSNIPER || gTeam[playerid] == RMEDIC || gTeam[playerid] == RSPY) {
  			attack[playerid] = 1;
			if(attack[playerid] == 1)
			{
				SetPlayerPos(playerid,2191.0737,-2264.2754,13.5376);
				GameTextForPlayer(playerid,"~r~Attack~n~~w~Capture both of BLU's control points (red checkpoint)",5000,5);
			}
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
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
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/kill", cmdtext, true) == 0)
	{
		SetPlayerHealth(playerid,0);
		return 1;
	}
	if (strcmp("/team", cmdtext, true) == 0)
	{
		if(gTeam[playerid] == RSCOUT || gTeam[playerid] == RPYRO || gTeam[playerid] == RSOLDIER || gTeam[playerid] == RDEMO || gTeam[playerid] == RENGY || gTeam[playerid] == RHEAVY || gTeam[playerid] == RSNIPER || gTeam[playerid] == RMEDIC || gTeam[playerid] == RSPY)
		{
			SendClientMessage(playerid,COLOR_GREEN,"Hi");
		} else {
		    SendClientMessage(playerid,COLOR_RED,"Bye");
		}
		return 1;
	}
	if (strcmp("/ad", cmdtext, true) == 0)
	{
		if(attack[playerid] == 1)
		{
			SendClientMessage(playerid,COLOR_GREEN,"Attack");
		} else {
		    SendClientMessage(playerid,COLOR_RED,"Defend");
		}
		return 1;
	}
	if (strcmp("/tele", cmdtext, true) == 0)
	{
		SetPlayerPos(playerid,2147.1841,-2261.3213,13.2995);
		return 1;
	}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
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
	if(attack[playerid] == 1) {
		cptimer = SetTimer("CPTimer",1000,1);
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	if(attack[playerid] == 1) {
        KillTimer(cptimer);
	}
	return 1;
}

public CPTimer()
{
	new string[256];
	cptt--;
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(insetup1[i] == 1)
			{
			    if(ncp[i] == 0)
			    {
					if (cptt > 0)
					{
/*			  			if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY)
				    	{
				    	    if(IsPlayerInCheckpoint(i))
				    	    {
						    ///if(attack[i] == 1)
						    //{
								format(string,sizeof(string),"~g~Stay in the checkpoint~n~~p~%d",cptt);
								GameTextForAll(string, 999, 5);
							//}
							}
						} else if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY)
						{
							//if(attack[i] == 0)
							//{*/
		    					format(string,sizeof(string),"~r~Our first control point is being contested!~n~~p~%d",cptt);
							    GameTextForAll(string, 999, 5);
						    //}
						//}
					} else if (cptt == 0) {
				        KillTimer(cptimer);
						Switch();
					    cptt = 11;
					}
				} else if(ncp[i] == 1) {
					if (cptt > 0)
					{
/*			  			if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY)
				    	{
						    //if(attack[i] == 1)
						    //{
								format(string,sizeof(string),"~g~Stay in the checkpoint~n~~p~%d",cptt);
								GameTextForAll(string, 999, 5);
							//}
						} else if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY)
						{
							//if(attack[i] == 0)
							//{*/
								format(string,sizeof(string),"~r~Our last control point is being contested!~n~~p~%d",cptt);
								GameTextForAll(string, 999, 5);
							//}
						//}
					} else if (cptt == 0) {
				        KillTimer(cptimer);
      					Switch();
					    cptt = 11;
					}
				}
			}
		}
	}
	return 1;
}

/*public Switch()
{
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
  			if(CPS_IsPlayerInAnyCheckpoint(i))
	    	{
	    	    SendClientMessage(i,COLOR_RED, "It hits the switch 1");
				GameTextForAll("~r~Our first control point has been captured", 3000, 3);
     			CPS_RemoveCheckpoint(cp1);
   			  	cp2 = CPS_AddCheckpoint(2113.7432,-2308.6853,13.5574,7,30);
	    	}
		}
	}
	return 1;
}*/

public time()
{
	TextDrawDestroy(Clock);
	new string[256];
	format(string,25,"%d",rtt);
	TextDrawHideForAll(Clock);
	Clock=TextDrawCreate(552,28,string);
	TextDrawLetterSize(Clock,0.5,1.8);
	TextDrawFont(Clock,3);
	TextDrawBackgroundColor(Clock,40);
	TextDrawSetOutline(Clock,2);
	TextDrawShowForAll(Clock);
}

public KillTime()
{
	ktt--;
	if(ktt == 0)
	{
		InSetUp2();
		rtt = 601;
		rtimer = SetTimer("RoundTime",1000,1);
		clk = SetTimer("time",1000,1);
		KillTimer(kt);
		ktt = 7;
	}
	return 1;
}

public RoundTime()
{
	rtt--;
	if(rtt > 0)
	{
	
	} else if(rtt == 0) {
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(insetup1[i] == 1)
		    {
		        if(ncp[i] < 2)
		        {
		  			if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY)
			    	{
			  			//if(attack[i] == 1)
				    	//{
				    	    //loser[i] = 1;
				    	    ResetPlayerWeapons(i);
				    	    KillTimer(cptimer);
				    	    GameTextForPlayer(i,"~r~You Lose~n~~w~You didn't capture both control points",5000,5);
				    	    insetup1[i] = 0;
				    	    KillTimer(rtimer);
				    	    insetup2[i] = 1;
				    	    TextDrawDestroy(Clock);
				    	    DisablePlayerCheckpoint(i);
				    	    ktt = 7;
				    	    kt = SetTimer("KillTime",1000,1);
				    	    KillTimer(clk);
						//}
					} else if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY)
					{
			  			//if(attack[i] == 0)
				    	//{
				    	    //winner[i] = 1;
				    	    KillTimer(cptimer);
				    	    GameTextForPlayer(i,"~g~You Won~n~~w~You defended both control points",5000,5);
				    	    insetup1[i] = 0;
				    	    insetup2[i] = 1;
				    	    KillTimer(rtimer);
				    	    TextDrawDestroy(Clock);
				    	    DisablePlayerCheckpoint(i);
				    	    ktt = 7;
				    	    kt = SetTimer("KillTime",1000,1);
				    	    KillTimer(clk);
						//}
					} else if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY)
			    	{
			  			//if(attack[i] == 0)
				    	//{
				    	    //winner[i] = 1;
				    	    KillTimer(cptimer);
				    	    GameTextForPlayer(i,"~g~You Won~n~~w~You defended both control points",5000,5);
 			    	    	insetup1[i] = 0;
				    	    insetup2[i] = 1;
	    				    KillTimer(rtimer);
				    	    TextDrawDestroy(Clock);
				    	    DisablePlayerCheckpoint(i);
				    	    ktt = 7;
				    	    kt = SetTimer("KillTime",1000,1);
				    	    KillTimer(clk);
						//}
					} else if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY)
					{
			  			//if(attack[i] == 1)
				    	//{
				    	    //loser[i] = 1;
				    	    ResetPlayerWeapons(i);
				    	    KillTimer(cptimer);
				    	    GameTextForPlayer(i,"~r~You Lose~n~~p~You didn't capture both control points",5000,5);
    	    				insetup1[i] = 0;
				    	    insetup2[i] = 1;
				    	    KillTimer(rtimer);
				    	    TextDrawDestroy(Clock);
				    	    DisablePlayerCheckpoint(i);
				    	    ktt = 7;
				    	    kt = SetTimer("KillTime",1000,1);
				    	    KillTimer(clk);
						//}
					}
				}
			}
		}
	}
	}
	return 1;
}

public Switch()
{
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(insetup1[i] == 1)
		    {
	  			if(ncp[i] == 0)
		    	{
			  		if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY && attack[i] == 1)
				   	{
						if(attack[i] == 1)
						{
  	    					if(IsPlayerInCheckpoint(i))
				        	{
								GameTextForAll("~r~You captured the first control point", 3000, 3);
								DisablePlayerCheckpoint(i);
								SetPlayerCheckpoint(i,2113.7432,-2308.6853,13.5574,7);
								KillTimer(cptimer);
								ncp[i] = 1;
							}
						}
					} else if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY && attack[i] == 0)
					{
						if(attack[i] == 0) {
							GameTextForAll("~r~Our first control point has been captured", 3000, 3);
							DisablePlayerCheckpoint(i);
							SetPlayerCheckpoint(i,2113.7432,-2308.6853,13.5574,7);
							ncp[i] = 2;
						}
	   			  	}
			    } else if(ncp[i] == 1) {
		  			if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY)
				   	{
						if(attack[i] == 1)
						{
				    	    if(IsPlayerInCheckpoint(i))
					        {
								GameTextForAll("~g~You captured the last control point~n~and won the round", 3000, 3);
								DisablePlayerCheckpoint(i);
								KillTimer(cptimer);
								ncp[i] = 2;
		    	    			insetup1[i] = 0;
					    	    insetup2[i] = 1;
					    	    KillTimer(rtimer);
					    	    TextDrawDestroy(Clock);
					    	    ktt = 7;
						   	    kt = SetTimer("KillTime",1000,1);
						   	    KillTimer(clk);
							}
						}
					} else if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY)
					{
						if(attack[i] == 0)
						{
							GameTextForAll("~r~Our last control point has been captured~n~You lost the round", 3000, 3);
						    ResetPlayerWeapons(i);
						    DisablePlayerCheckpoint(i);
							KillTimer(cptimer);
    	    				insetup1[i] = 0;
					        insetup2[i] = 1;
					   	    KillTimer(rtimer);
					   	    TextDrawDestroy(Clock);
					   	    ktt = 7;
					   	    kt = SetTimer("KillTime",1000,1);
				    	    KillTimer(clk);
						}
			    	}
				}
		    }
    	}
	}
	return 1;
}

public InSetUp2()
{
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    new s = GetPlayerSkin(i);
  			if(gTeam[i] == RSCOUT || gTeam[i] == RPYRO || gTeam[i] == RSOLDIER || gTeam[i] == RDEMO || gTeam[i] == RENGY || gTeam[i] == RHEAVY || gTeam[i] == RSNIPER || gTeam[i] == RMEDIC || gTeam[i] == RSPY)
	    	{
				if(attack[i] == 1)
				{
					if(s == 170) {
						SetPlayerSkin(i, 185);
					} else if(s == 180) {
						SetPlayerSkin(i, 143);
					} else if(s == 58) {
						SetPlayerSkin(i, 24);
					} else if(s == 142) {
						SetPlayerSkin(i, 184);
					} else if(s == 19) {
						SetPlayerSkin(i, 156);
					} else if(s == 264) {
						SetPlayerSkin(i, 128);
					} else if(s == 203) {
						SetPlayerSkin(i, 261);
					} else if(s == 189) {
						SetPlayerSkin(i, 21);
					} else if(s == 97) {
						SetPlayerSkin(i, 154);
					}
				    attack[i] = 0;
				    SetPlayerPos(i,-2653.6443,1388.2767,7.1301);
				}
			} else if(gTeam[i] == BSCOUT || gTeam[i] == BPYRO || gTeam[i] == BSOLDIER || gTeam[i] == BDEMO || gTeam[i] == BENGY || gTeam[i] == BHEAVY || gTeam[i] == BSNIPER || gTeam[i] == BMEDIC || gTeam[i] == BSPY) {
				if(attack[i] == 0)
				{
				    attack[i] = 1;
				    SetPlayerPos(i,-2653.6443,1388.2767,7.1301);
				}
   			}
		}
	}
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
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
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

