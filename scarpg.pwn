#include <a_samp>
#include <dini>
#include <dudb>
#include <KIHC>
#include <returnuser>
#include <races>
#include <cpstream>

#pragma tabsize 0

main()
{
	print("\n==================================");
	print("Scarface Roleplay");
	print("==================================\n");
}
#define MAX_CARS 298
#define TIME 20000
//================TEAMS=========================================================
//private
#define ADMIN 0
//public (ingame)
#define MECHANIC 1
#define MEDIC 2
#define WHORE 3
#define DRUGS 4
#define IMPORT 5
#define MAIL 6
#define CIV 7
//faction (request)
#define BUS 8
#define TAXI 9
#define COP 10
#define DMV 11
#define PILOT 12
#define BOAT 13
#define MAYOR 14
//gang factions
#define FIDO 15
#define VERCETTI 16
#define JOHNSON 17
//================COLORS========================================================
#define 	COLOR_RED 		0xAA3333AA
#define 	COLOR_BLACK 	0x000000FF
#define 	COLOR_ORANGE 	0xFF9900AA
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
#define 	COLOR_GRAY2 	0xAAAAAAAA
#define 	ORANGE 			0xFF6600AA
#define 	COLOR_GREEN2 	0x40FF40FF
#define 	COLOR_PURPLE 	0x993399AA
#define 	COLOR_BROWN 	0xCC6633AA
#define     COLOR_BLUEGRAY 	0x6688BBFF
//================DMCD==========================================================
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define COLOR_SYSTEM 0xEFEFF7AA
//================OTHER GANGS========================================================
#define MAX_GANGS 			32
#define MAX_GANG_MEMBERS	6
#define MAX_GANG_NAME       16
new gangMembers[MAX_GANGS][MAX_GANG_MEMBERS];
new gangNames[MAX_GANGS][MAX_GANG_NAME];
new gangInfo[MAX_GANGS][3]; //0-created,1-members,2-color
new gangBank[MAX_GANGS];
new playerGang[MAX_PLAYERS];
new gangInvite[MAX_PLAYERS];
//================GANG STUFF====================================================
new johnson;
new vercetti;
new fido;
//================OFFERS========================================================
new RefillOffer[MAX_PLAYERS], RepairOffer[MAX_PLAYERS], HealOffer[MAX_PLAYERS];
new RefillPrice[MAX_PLAYERS], RepairPrice[MAX_PLAYERS], HealPrice[MAX_PLAYERS];
new GTOffer[MAX_PLAYERS], TicketOffer[MAX_PLAYERS];
new GTPrice[MAX_PLAYERS], TicketPrice[MAX_PLAYERS];
//=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
new WeedOffer[MAX_PLAYERS], CocaineOffer[MAX_PLAYERS], MethOffer[MAX_PLAYERS];
new WeedPrice[MAX_PLAYERS], CocainePrice[MAX_PLAYERS], MethPrice[MAX_PLAYERS];
new CrackOffer[MAX_PLAYERS], AcidOffer[MAX_PLAYERS], HazeOffer[MAX_PLAYERS];
new CrackPrice[MAX_PLAYERS], AcidPrice[MAX_PLAYERS], HazePrice[MAX_PLAYERS];
//=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
new playa;
new money;
//================NEW THINGS====================================================
#define MAX_ALLS 5
#define MAX_MONZ 500
new invis[MAX_PLAYERS];
new charitys[MAX_PLAYERS];
new charitysmsg[MAX_PLAYERS];
new ppizza[MAX_PLAYERS] = 0, psushi[MAX_PLAYERS] = 0, pburger[MAX_PLAYERS] = 0, pfish[MAX_PLAYERS] = 0;
new reg[MAX_PLAYERS];
new logged[MAX_PLAYERS];
new psex[MAX_PLAYERS];
//1 male, 2 female
new ploc[MAX_PLAYERS];
//1 Americas, 2 Asia, 3 Europe, 4 Africa, 5 Australia
new preglog[MAX_PLAYERS];
new RegQs[MAX_PLAYERS];
new Petrol[MAX_CARS];
new inguide[MAX_PLAYERS];
new firstspawn[MAX_PLAYERS];
new phone[MAX_PLAYERS];
new isolated[MAX_PLAYERS];
new micons[MAX_PLAYERS];
new spawned[MAX_PLAYERS];
new tickets[MAX_PLAYERS];
new lcar[MAX_PLAYERS];
new vlock[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new gJob[MAX_PLAYERS];
new lesson[MAX_PLAYERS];
new onbreak[MAX_PLAYERS];
new jobbed[MAX_PLAYERS];
new jobhours[MAX_PLAYERS];
new firstime[MAX_PLAYERS];
new PLAYERLIST_authed[MAX_PLAYERS];
new dli[MAX_PLAYERS], pli[MAX_PLAYERS], bli[MAX_PLAYERS], wli[MAX_PLAYERS];
new std[MAX_PLAYERS];
new drink[MAX_PLAYERS];
new taxif[MAX_PLAYERS];
new dfs[MAX_PLAYERS];
new mailed[MAX_PLAYERS];
new givenstd[MAX_PLAYERS];
new inlesson[MAX_PLAYERS];
new fare2[MAX_PLAYERS];
new LastCar[MAX_PLAYERS];
new muted[MAX_PLAYERS];
new inclass[MAX_PLAYERS];
new count6[MAX_PLAYERS] = 0;
new jailed[MAX_PLAYERS];
new jailtime[MAX_PLAYERS];
new phonenbr[MAX_PLAYERS];
new Target[MAX_PLAYERS] = 999;
new caller = 999, calling = 999, incall[MAX_PLAYERS];
new RCPs[MAX_PLAYERS];
new justjoined[MAX_PLAYERS];
new raceid[MAX_PLAYERS];
new racecheck[MAX_PLAYERS];
new inbail[MAX_PLAYERS];
new inbailprice[MAX_PLAYERS];
new phoneprice[MAX_PLAYERS];
new plxlogin[MAX_PLAYERS];
//new owned2;
//new owned;
new healme;
new ooc;
new admin;
new Text:rules1;
new Text:rules2;
new Text:rules3;
new Text:rules4;
new Text:rules5;
new Text:rules6;
new Text:rules7;
new taxipl, buspl, medpl, mechpl;
new Count2;
new count7;
new count7t;
new count8;
new count8t;
new count9;
new count9t;
new count10;
new count10t;
new count11;
new count11t;
new fsecs;
new fsecsd;
new Menu:jobs;
new Menu:wepli;
new drugid;
new jp, dmv, wepl, dmvv2;
new CashScoreOld;
new Float:mx, Float:my, Float:mz;
new giveplayerid, sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
new Vi;
new zcheck;
new skinz;
new zchecko;
new count3 = 120;
new count4;
new count5;
new count5t;
new count3t;
new count4t;
new count6t;
new cashcp;
new cashcpt;
new phonept;
new JailCDt;
new jcdt;
new ttimet;
new fare;
new bankp;
new bankp2;
new time;
new bailq;
new carprice[MAX_CARS];
new bailprice;
new racers = 0;
new finishers;
new racecount = 4;
new racec;
new Float:jx, Float:jy, Float:jz;
new currentpoint = 0;
new nextpoint = 0;
new inrace[MAX_PLAYERS];
new strm[56];
new Menu:race;
new needstaxi = 999, needsbus = 999, needsmech = 999, needsmedic = 999;
new ip[256];
new playerColors[100] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,
0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,
0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,
0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,
0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0x3FE65CFF
};
new payamt[9][0] = {
{"700"},{"750"},{"800"},{"850"},{"900"},{"950"},{"1000"},{"1500"},{"2000"}
};
new peds[51][0] = {
{"1"},{"2"},{"9"},{"10"},{"11"},{"12"},{"13"},{"14"},{"15"},{"18"},{"19"},{"20"},{"21"},{"22"},
{"23"},{"24"},{"25"},{"26"},{"27"},{"28"},{"29"},{"30"},{"31"},{"32"},{"33"},{"34"},{"35"},{"36"},
{"37"},{"38"},{"39"},{"40"},{"41"},{"42"},{"43"},{"44"},{"45"},{"46"},{"47"},{"48"}, {"49"},
{"51"},{"52"},{"53"},{"54"},{"55"},{"56"},{"57"},{"58"},{"60"},{"62"}
};
new whores[16][0] = {
{"152"},{"178"},{"237"},{"238"},{"243"},{"244"},{"207"},{"245"},{"246"},{"85"},{"256"},{"257"},{"64"},
{"63"},{"87"},{"90"}
};
new amount[21][0] = {
{"0"},{"5"},{"10"},{"15"},{"20"},{"25"},{"30"},{"35"},{"40"},{"45"},{"50"},{"55"},{"60"},{"65"},{"70"},
{"75"},{"80"},{"85"},{"90"},{"95"},{"100"}
};
new gRandCarPrices[13][0] = {
{"300"},{"350"},{"400"},{"450"},{"500"},{"550"},{"600"},{"650"},{"700"},{"850"},{"900"},{"950"},
{"1000"}
};
new STI[13][0] = {
{"Aids"},{"Syphilis"},{"Hepititis A"},{"Hepititis B"},{"Pubic Lice (Crabs)"},{"Chlamydia"},{"Gonorrhea"},
{"Syphilis"},{"HIV/AIDS"},{"Herpes"},{"Mononucleosis"},{"Genital Warts"},{"Scabies"}
};
new FishNums = 18;
new RandFish[9][0] = {
{"Salmon"},
{"Stonefish"},
{"Trout"},
{"Perring"},
{"Bass"},
{"Catfish"},
{"Swordfish"},
{"Tuna"},
{"Crappie"}
};
new TeamWins[8][0] = {
{"LV Bandits at LS Saints - Saints Win"},
{"LV Bandits at SF Packers - Bandits Win"},
{"LV Bandits at LS Saints - Bandits Win"},
{"LV Bandits at SF Packers - Packers Win"},
{"SF Packers at LV Bandits - Bandits Win"},
{"SF Packers at LS Saints - Saints Win"},
{"LS Saints at LV Bandits - Bandits Win"},
{"LS Saints at SF Packers - Packers Win"}
};
new RandFishSizes[30][0] = {
{"1"},{"2"},{"3"},{"4"},{"5"},{"6"},{"7"},{"8"},{"9"},{"10"},{"11"},{"12"},{"13"},{"14"},{"15"},
{"16"},{"17"},{"18"},{"19"},{"20"},{"21"},{"22"},{"23"},{"24"},{"25"},{"26"},{"27"},{"28"},
{"29"},{"30"}
};
new Slots[5][0] = {
{"Cherry"},
{"Gold"},
{"Grape"},
{"Lemon"},
{"Bell"}
};
new Slots2[5][0] = {
{"Cherry"},
{"Gold"},
{"Grape"},
{"Lemon"},
{"Bell"}
};
new Slots3[5][0] = {
{"Cherry"},
{"Gold"},
{"Grape"},
{"Lemon"},
{"Bell"}
};
new Float:mailcp[15][3] = {
{1933.3071,2306.9436,10.8203},
{1442.0515,2573.7195,10.8203},
{1731.9856,2825.2136,14.2735},
{2018.7750,2659.5623,10.8203},
{2794.0308,2227.4058,14.6615},
{988.4909,2000.7728,11.4609},
{1366.6735,1897.4744,11.4688},
{2622.2468,2030.4026,14.1161},
{2593.9463,1659.6935,10.8203},
{2420.2942,1409.4213,10.8203},
{2436.4041,1240.9095,14.3426},
{2855.2156,893.7349,9.9500},
{2346.8430,734.6534,11.4683},
{1041.0129,1020.1498,11.0000},
{988.2161,2314.3809,11.4609}
};
new Float:RandIEx[22][3] = {
{4228.9946,1285.6995,189.8703},
{4229.0059,1291.6915,189.8703},
{4228.4834,1302.6077,189.8703},
{4225.2910,1306.1040,189.8703},
{4224.9375,1302.1326,189.8703},
{4224.2764,1296.4083,189.8703},
{4223.3306,1288.2125,189.8703},
{4219.4941,1286.6195,189.8703},
{4219.4941,1286.6195,189.8703},
{4219.2197,1290.1865,189.8703},
{4219.9565,1295.4241,189.8703},
{4220.8843,1302.0164,189.8703},
{4220.8843,1302.0164,189.8703},
{4216.9712,1305.4827,189.8703},
{4216.0200,1299.3915,189.8703},
{4215.3579,1294.3921,189.8703},
{4214.7305,1289.6494,189.8703},
{4209.7808,1285.7867,189.8703},
{4209.7085,1289.8451,189.8703},
{4210.1035,1295.5885,189.8703},
{4210.5293,1301.7800,189.8703},
{4210.7832,1305.4559,189.8703}
};
new CarBuyPrices[6][0] = {
{"25000"},{"30000"},{"35000"},{"40000"},{"45000"},{"50000"}
};
new RandAnims[6][0] = {
{"DAN_LOOP_A"},
{"DNCE_M_A"},
{"DNCE_M_B"},
{"DNCE_M_C"},
{"DNCE_M_D"},
{"DNCE_M_E"}
};
new SexTalk[6][0] = {
{"~r~oooh!!"},
{"~g~oh baby!!"},
{"~y~yeah!!!"},
{"~b~right there!!"},
{"~p~oh yes!"},
{"~w~yeah yeah yeah!!!!! *cum*"}
};
new vehName[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratium", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car",
    "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

//==================IDENTIFIED CARS=============================================
new dmv1, dmv2, dmv3, dmv4, dmv5;
new sboat1, sboat2, sboat3, sboat4;
new sfly1, sfly2, sfly3, sfly4;
new john1, john2, john3, john4, john5, john6;
new ver1, ver2, ver3, ver4, ver5, ver6, ver7;
new fido1, fido2, fido3, fido4, fido5, fido6, fido7, fido8;
new taxi1, taxi2, taxi3, taxi4, taxi5, taxi6, taxi7, taxi8, taxi9, taxi10;
new bus1, bus2, bus3, bus4, bus5, bus6, bus7;
new ambu1, ambu2, ambu3, ambu4, ambu5;
new pol1, pol2, pol3, pol4, pol5, pol6, pol7;
new mayorc;
//==================FORWARDS====================================================
forward PayDay();
forward AdminPayDay();
forward CashUpdate();
forward Update();
//forward IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy);
forward MapIcons();
forward HealDown();
forward CountDown(playerid);
forward JobCountDown(playerid);
forward WepCheck(playerid);
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward CheckFuel(playerid);
forward RapedMe(playerid);
forward MailDrop(playerid);
forward MailDrop2(playerid);
forward MailDrop3(playerid);
forward JCD(playerid);
forward GZs();
forward GZss();
forward TTime(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:xx, Float:yy, Float:zz);
forward clock();
forward Count5();
forward FirstTime();
forward GetVehicleDriverId(vehicleid);
forward LookItCar();
forward LookItPlane();
forward LookItBoat();
forward PingKick();
forward JailCD();
forward AdvertCount();
forward RandIExp();
forward CallT();
forward FiveSecs();
forward AdminCashCP();
forward PhoneCost();
forward Clock();
forward PlayerDistance(Float:radi, playerid, targetid);
forward GameWins();
//==================GAME MODE===================================================
public OnGameModeInit()
{
	ooc = 1;
	race = CreateMenu("~g~Select A Race",1,125,150,300);
	if(IsValidMenu(race))
	{
		SetMenuColumnHeader(race,0,"~r~Red: Bike, ~b~Blue: Car");
		AddMenuItem(race,0,"~r~R~r~ound SF");
	}
	
	rules1 = TextDrawCreate(80.000000,112.000000,"-----Laws-----");
	TextDrawAlignment(rules1,0);
	TextDrawBackgroundColor(rules1,0x000000ff);
	TextDrawFont(rules1,1);
	TextDrawLetterSize(rules1,1.000000,2.000000);
	TextDrawColor(rules1,0xff0000cc);
	TextDrawSetOutline(rules1,1);
	TextDrawSetProportional(rules1,1);
	
	rules2 = TextDrawCreate(80.000000,136.000000,"1. No hacking/modding/glitching");
	TextDrawAlignment(rules2,0);
	TextDrawBackgroundColor(rules2,0x000000ff);
	TextDrawFont(rules2,0);
	TextDrawLetterSize(rules2,1.000000,2.000000);
	TextDrawColor(rules2,0xffffffcc);
	TextDrawSetOutline(rules2,1);
	TextDrawSetProportional(rules2,1);
	
	rules3 = TextDrawCreate(80.000000,156.000000,"2. Respect ALL other players");
	TextDrawAlignment(rules3,0);
	TextDrawBackgroundColor(rules3,0x000000ff);
	TextDrawFont(rules3,0);
	TextDrawLetterSize(rules3,1.000000,2.000000);
	TextDrawColor(rules3,0xffffffcc);
	TextDrawSetOutline(rules3,1);
	TextDrawSetProportional(rules3,1);
	
	rules4 = TextDrawCreate(80.000000,176.000000,"3. Drive on the right side of the road");
	TextDrawAlignment(rules4,0);
	TextDrawBackgroundColor(rules4,0x000000ff);
	TextDrawFont(rules4,0);
	TextDrawLetterSize(rules4,1.000000,2.000000);
	TextDrawColor(rules4,0xffffffcc);
	TextDrawSetOutline(rules4,1);
	TextDrawSetProportional(rules4,1);
	
	rules5 = TextDrawCreate(80.000000,196.000000,"4. Don't flood or spam");
	TextDrawAlignment(rules5,0);
	TextDrawBackgroundColor(rules5,0x000000ff);
	TextDrawFont(rules5,0);
	TextDrawLetterSize(rules5,1.000000,2.000000);
	TextDrawColor(rules5,0xffffffcc);
	TextDrawSetOutline(rules5,1);
	TextDrawSetProportional(rules5,1);
    
	rules6 = TextDrawCreate(80.000000,216.000000,"5. Speak english");
	TextDrawAlignment(rules6,0);
	TextDrawBackgroundColor(rules6,0x000000ff);
	TextDrawFont(rules6,0);
	TextDrawLetterSize(rules6,1.000000,2.000000);
	TextDrawColor(rules6,0xffffffcc);
	TextDrawSetOutline(rules6,1);
	TextDrawSetProportional(rules6,1);
	
	rules7 = TextDrawCreate(80.000000,240.000000,"-----Now type /hide-----");
	TextDrawAlignment(rules7,0);
	TextDrawBackgroundColor(rules7,0x000000ff);
	TextDrawFont(rules7,1);
	TextDrawLetterSize(rules7,1.000000,2.000000);
	TextDrawColor(rules7,0xff0000cc);
	TextDrawSetOutline(rules7,1);
	TextDrawSetProportional(rules7,1);
	
	SetTimer("RapedMe",1000,1);
	SetTimer("Clock",1440000,1);
	SetTimer("GameWins",1440000,1);
	//==============GANGS=======================================================
 	johnson = GangZoneCreate(873.1455, 1949.026, 1099.627, 2053.464);
 	vercetti = GangZoneCreate(1501.826, 2007.047, 1697.068, 2169.506);
 	fido = GangZoneCreate(1872.786, 2625.938, 2079.743, 2792.265);
  	admin = GangZoneCreate(-759.0619, 829.1292, -572.2159, 1039.331);
  	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	for(new c=0;c<MAX_CARS;c++)
	{
	    new rand = random(sizeof(amount));
		Petrol[c] = amount[rand][0];
	}
	for(new c=0;c<MAX_CARS;c++)
	{
	    new rand = random(sizeof(CarBuyPrices));
		carprice[c] = CarBuyPrices[rand][0];
	}
	SetTimer("CheckFuel", TIME, 1);
	//**************************************************************************
	taxipl = 0;
	buspl = 0;
	mechpl = 0;
	medpl = 0;
	//==========================================================================
	jobs = CreateMenu("~g~Job Selection",1,125,150,300);
	if (IsValidMenu(jobs))
	{
		SetMenuColumnHeader(jobs,0,"Select a job");
		AddMenuItem(jobs,0,"Mechanic");
		AddMenuItem(jobs,0,"Medic");
		AddMenuItem(jobs,0,"Whore");
		AddMenuItem(jobs,0,"Drugs");
		AddMenuItem(jobs,0,"Car Import");
		AddMenuItem(jobs,0,"Package Delivery");
	}
	wepli = CreateMenu("~g~License",1,125,150,300);
	if (IsValidMenu(wepli))
	{
		SetMenuColumnHeader(wepli,0,"Apply for weapon license?");
		AddMenuItem(wepli,0,"Yes");
		AddMenuItem(wepli,0,"No");
	}
	//==========================================================================
	//ShowPlayerMarkers(false);
	SetTimer("RandIExp",5000,1);
    SetTimer("HealDown",60000,1);
    EnableZoneNames(1);
	SetGameModeText("LV RPG");
	UsePlayerPedAnims();
	EnableTirePopping(true);
	SetTimer("CashUpdate",1000,1);
	SetTimer("Update",600000,1);
 	SetTimer("PingKick",1000,1);
	jcdt = SetTimer("JCD", 1000, 1);
	//==========================================================================
	jp = CreatePickup(1210, 2, 363.1931,173.7284,1008.3828);
	dmv = CreatePickup(1318, 2, 1165.5331,1348.7206,10.9219);
	dmvv2 = CreatePickup(1318, 2, 1161.8208,1341.8951,10.8125);
	wepl = CreatePickup(1279, 2, 289.2080,-83.8316,1001.5156);
	bankp = CreatePickup(1318, 2, 2558.6372,1788.3259,11.0234);
	bankp2 = CreatePickup(1318, 2, 5.8952,-30.2787,1003.5494);
 	healme = CreatePickup(1240, 2, 1607.4995,1816.5792,10.8203);
	AddStaticPickup(1240, 2, -691.6475,933.8073,13.6328);
	AddStaticPickup(1242, 2, -691.7487,935.3851,13.6328);
	AddStaticPickup(1254, 2, 198.0833,158.2367,1003.0234);
	//==========================================================================
	//admin only
	AddPlayerClass(249, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//mayor only
	AddPlayerClass(187, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//bus
	AddPlayerClass(17, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//taxi
	AddPlayerClass(255, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//cop
	AddPlayerClass(282, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//dmv
	AddPlayerClass(147, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//pilot
	AddPlayerClass(61, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//boat
	AddPlayerClass(217, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//fido
	AddPlayerClass(299, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//vercetti
	AddPlayerClass(59, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//johnson
	AddPlayerClass(271, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//peds
	AddPlayerClass(1, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(2, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(9, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(10, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(11, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(12, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(13, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(14, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(15, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(18, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
 	AddPlayerClass(19, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(20, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(21, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(22, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(23, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(24, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(25, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(26, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(27, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(28, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(29, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(30, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(31, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(32, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(33, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(34, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(35, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(36, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(37, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(38, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(39, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(40, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(41, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(43, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(44, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(45, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(46, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(47, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(48, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(49, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//50
	AddPlayerClass(51, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(52, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(53, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(54, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(55, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(56, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(57, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(58, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(60, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//60
	AddPlayerClass(62, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	//==========================================================================
	CreateVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16,60000);
	CreateVehicle(429,2040.5247,1359.2783,10.3516,177.1306,13,13,60000);
	CreateVehicle(421,2110.4102,1398.3672,10.7552,359.5964,13,13,60000);
	CreateVehicle(411,2074.9624,1479.2120,10.3990,359.6861,64,64,60000);
	CreateVehicle(477,2075.6038,1666.9750,10.4252,359.7507,94,94,60000);
	CreateVehicle(541,2119.5845,1938.5969,10.2967,181.9064,22,22,60000);
	CreateVehicle(541,1843.7881,1216.0122,10.4556,270.8793,60,1,60000);
	CreateVehicle(402,1944.1003,1344.7717,8.9411,0.8168,30,30,60000);
	CreateVehicle(402,1679.2278,1316.6287,10.6520,180.4150,90,90,60000);
	CreateVehicle(415,1685.4872,1751.9667,10.5990,268.1183,25,1,60000);
	CreateVehicle(411,2034.5016,1912.5874,11.9048,0.2909,123,1,60000);
	CreateVehicle(411,2172.1682,1988.8643,10.5474,89.9151,116,1,60000);
	CreateVehicle(429,2245.5759,2042.4166,10.5000,270.7350,14,14,60000);
	CreateVehicle(477,2361.1538,1993.9761,10.4260,178.3929,101,1,60000);
	CreateVehicle(550,2221.9946,1998.7787,9.6815,92.6188,53,53,60000);
	CreateVehicle(558,2243.3833,1952.4221,14.9761,359.4796,116,1,60000);
	CreateVehicle(587,2276.7085,1938.7263,31.5046,359.2321,40,1,60000);
	CreateVehicle(587,2602.7769,1853.0667,10.5468,91.4813,43,1,60000);
	CreateVehicle(603,2610.7600,1694.2588,10.6585,89.3303,69,1,60000);
	CreateVehicle(587,2635.2419,1075.7726,10.5472,89.9571,53,1,60000);
	CreateVehicle(562,2577.2354,1038.8063,10.4777,181.7069,35,1,60000);
	CreateVehicle(562,2394.1021,989.4888,10.4806,89.5080,17,1,60000);
	CreateVehicle(562,1881.0510,957.2120,10.4789,270.4388,11,1,60000);
	CreateVehicle(535,2039.1257,1545.0879,10.3481,359.6690,123,1,60000);
	CreateVehicle(535,2009.8782,2411.7524,10.5828,178.9618,66,1,60000);
	CreateVehicle(429,2010.0841,2489.5510,10.5003,268.7720,1,2,60000);
	CreateVehicle(415,2076.4033,2468.7947,10.5923,359.9186,36,1,60000);
	CreateVehicle(487,2093.2754,2414.9421,74.7556,89.0247,26,57,60000);
	CreateVehicle(506,2352.9026,2577.9768,10.5201,0.4091,7,7,60000);
	CreateVehicle(506,2166.6963,2741.0413,10.5245,89.7816,52,52,60000);
	CreateVehicle(411,1960.9989,2754.9072,10.5473,200.4316,112,1,60000);
	CreateVehicle(429,1919.5863,2760.7595,10.5079,100.0753,2,1,60000);
	CreateVehicle(415,1673.8038,2693.8044,10.5912,359.7903,40,1,60000);
	CreateVehicle(402,1591.0482,2746.3982,10.6519,172.5125,30,30,60000);
	CreateVehicle(603,1580.4537,2838.2886,10.6614,181.4573,75,77,60000);
	CreateVehicle(550,1555.2734,2750.5261,10.6388,91.7773,62,62,60000);
	CreateVehicle(535,1455.9305,2878.5288,10.5837,181.0987,118,1,60000);
	CreateVehicle(477,1537.8425,2578.0525,10.5662,0.0650,121,1,60000);
	CreateVehicle(451,1433.1594,2607.3762,10.3781,88.0013,16,16,60000);
	CreateVehicle(603,2223.5898,1288.1464,10.5104,182.0297,18,1,60000);
	CreateVehicle(558,2451.6707,1207.1179,10.4510,179.8960,24,1,60000);
	CreateVehicle(550,2461.7253,1357.9705,10.6389,180.2927,62,62,60000);
	CreateVehicle(558,2461.8162,1629.2268,10.4496,181.4625,117,1,60000);
	CreateVehicle(477,2395.7554,1658.9591,10.5740,359.7374,0,1,60000);
	CreateVehicle(404,1553.3696,1020.2884,10.5532,270.6825,119,50,60000);
	CreateVehicle(400,1380.8304,1159.1782,10.9128,355.7117,123,1,60000);
	CreateVehicle(418,1383.4630,1035.0420,10.9131,91.2515,117,227,60000);
	CreateVehicle(404,1445.4526,974.2831,10.5534,1.6213,109,100,60000);
	CreateVehicle(400,1704.2365,940.1490,10.9127,91.9048,113,1,60000);
	CreateVehicle(404,1658.5463,1028.5432,10.5533,359.8419,101,101,60000);
	CreateVehicle(581,1677.6628,1040.1930,10.4136,178.7038,58,1,60000);
	CreateVehicle(581,1383.6959,1042.2114,10.4121,85.7269,66,1,60000);
	CreateVehicle(581,1064.2332,1215.4158,10.4157,177.2942,72,1,60000);
	CreateVehicle(581,1111.4536,1788.3893,10.4158,92.4627,72,1,60000);
	CreateVehicle(522,953.2818,1806.1392,8.2188,235.0706,3,8,60000);
	CreateVehicle(522,995.5328,1886.6055,10.5359,90.1048,3,8,60000);
	CreateVehicle(521,993.7083,2267.4133,11.0315,1.5610,75,13,60000);
	CreateVehicle(535,1439.5662,1999.9822,10.5843,0.4194,66,1,60000);
	CreateVehicle(522,1430.2354,1999.0144,10.3896,352.0951,6,25,60000);
	CreateVehicle(522,2156.3540,2188.6572,10.2414,22.6504,6,25,60000);
	CreateVehicle(522,2476.7900,2532.2222,21.4416,0.5081,8,82,60000);
	CreateVehicle(522,2580.5320,2267.9595,10.3917,271.2372,8,82,60000);
	CreateVehicle(522,2814.4331,2364.6641,10.3907,89.6752,36,105,60000);
	CreateVehicle(535,2827.4143,2345.6953,10.5768,270.0668,97,1,60000);
	CreateVehicle(521,1670.1089,1297.8322,10.3864,359.4936,87,118,60000);
	CreateVehicle(487,1614.7153,1548.7513,11.2749,347.1516,58,8,60000);
	CreateVehicle(487,1647.7902,1538.9934,11.2433,51.8071,0,8,60000);
	CreateVehicle(487,1608.3851,1630.7268,11.2840,174.5517,58,8,60000);
	CreateVehicle(476,1283.0006,1324.8849,9.5332,275.0468,7,6,60000); //11.5332
	CreateVehicle(476,1283.5107,1361.3171,9.5382,271.1684,1,6,60000); //11.5382
	CreateVehicle(476,1283.6847,1386.5137,11.5300,272.1003,89,91,60000);
	CreateVehicle(476,1288.0499,1403.6605,11.5295,243.5028,119,117,60000);
	CreateVehicle(415,1319.1038,1279.1791,10.5931,0.9661,62,1,60000);
	CreateVehicle(521,1710.5763,1805.9275,10.3911,176.5028,92,3,60000);
	CreateVehicle(521,2805.1650,2027.0028,10.3920,357.5978,92,3,60000);
	CreateVehicle(535,2822.3628,2240.3594,10.5812,89.7540,123,1,60000);
	CreateVehicle(521,2876.8013,2326.8418,10.3914,267.8946,115,118,60000);
	CreateVehicle(429,2842.0554,2637.0105,10.5000,182.2949,1,3,60000);
	CreateVehicle(549,2494.4214,2813.9348,10.5172,316.9462,72,39,60000);
	CreateVehicle(549,2327.6484,2787.7327,10.5174,179.5639,75,39,60000);
	CreateVehicle(549,2142.6970,2806.6758,10.5176,89.8970,79,39,60000);
	CreateVehicle(521,2139.7012,2799.2114,10.3917,229.6327,25,118,60000);
	CreateVehicle(521,2104.9446,2658.1331,10.3834,82.2700,36,0,60000);
	CreateVehicle(521,1914.2322,2148.2590,10.3906,267.7297,36,0,60000);
	CreateVehicle(549,1904.7527,2157.4312,10.5175,183.7728,83,36,60000);
	CreateVehicle(549,1532.6139,2258.0173,10.5176,359.1516,84,36,60000);
	CreateVehicle(521,1534.3204,2202.8970,10.3644,4.9108,118,118,60000);
	CreateVehicle(549,1613.1553,2200.2664,10.5176,89.6204,89,35,60000);
	CreateVehicle(400,1552.1292,2341.7854,10.9126,274.0815,101,1,60000);
	CreateVehicle(404,1637.6285,2329.8774,10.5538,89.6408,101,101,60000);
	CreateVehicle(400,1357.4165,2259.7158,10.9126,269.5567,62,1,60000);
	CreateVehicle(411,1281.7458,2571.6719,10.5472,270.6128,106,1,60000);
	CreateVehicle(522,1305.5295,2528.3076,10.3955,88.7249,3,8,60000);
	CreateVehicle(521,993.9020,2159.4194,10.3905,88.8805,74,74,60000);
	CreateVehicle(415,1512.7134,787.6931,10.5921,359.5796,75,1,60000);
	CreateVehicle(522,2299.5872,1469.7910,10.3815,258.4984,3,8,60000);
	CreateVehicle(522,2133.6428,1012.8537,10.3789,87.1290,3,8,60000);
	CreateVehicle(415,2266.7336,648.4756,11.0053,177.8517,0,1,60000); //
	CreateVehicle(461,2404.6636,647.9255,10.7919,183.7688,53,1,60000); //
	CreateVehicle(506,2628.1047,746.8704,10.5246,352.7574,3,3,60000); //
	CreateVehicle(549,2817.6445,928.3469,10.4470,359.5235,72,39,60000); //
	CreateVehicle(562,1919.8829,947.1886,10.4715,359.4453,11,1,60000); //
	CreateVehicle(562,1881.6346,1006.7653,10.4783,86.9967,11,1,60000); //
	CreateVehicle(562,2038.1044,1006.4022,10.4040,179.2641,11,1,60000); //
	CreateVehicle(562,2038.1614,1014.8566,10.4057,179.8665,11,1,60000); //
	CreateVehicle(562,2038.0966,1026.7987,10.4040,180.6107,11,1,60000); //
	CreateVehicle(422,9.1065,1165.5066,19.5855,2.1281,101,25,60000); //
	CreateVehicle(463,19.8059,1163.7103,19.1504,346.3326,11,11,60000); //
	CreateVehicle(463,12.5740,1232.2848,18.8822,121.8670,22,22,60000); //
	CreateVehicle(586,69.4633,1217.0189,18.3304,158.9345,10,1,60000); //
	CreateVehicle(586,-199.4185,1223.0405,19.2624,176.7001,25,1,60000); //
	CreateVehicle(476,325.4121,2538.5999,17.5184,181.2964,71,77,60000); //
	CreateVehicle(476,291.0975,2540.0410,17.5276,182.7206,7,6,60000); //
	CreateVehicle(576,384.2365,2602.1763,16.0926,192.4858,72,1,60000); //
	CreateVehicle(586,423.8012,2541.6870,15.9708,338.2426,10,1,60000); //
	CreateVehicle(586,-244.0047,2724.5439,62.2077,51.5825,10,1,60000); //
	CreateVehicle(586,-311.1414,2659.4329,62.4513,310.9601,27,1,60000); //
	CreateVehicle(543,596.8064,866.2578,-43.2617,186.8359,67,8,60000); //
	CreateVehicle(543,835.0838,836.8370,11.8739,14.8920,8,90,60000); //
	CreateVehicle(549,843.1893,838.8093,12.5177,18.2348,79,39,60000); //
	CreateVehicle(400,-235.9767,1045.8623,19.8158,180.0806,75,1,60000); //
	CreateVehicle(599,-211.5940,998.9857,19.8437,265.4935,0,1,60000); //
	CreateVehicle(422,-304.0620,1024.1111,19.5714,94.1812,96,25,60000); //
	CreateVehicle(588,-290.2229,1317.0276,54.1871,81.7529,1,1,60000); //
	CreateVehicle(451,-290.3145,1567.1534,75.0654,133.1694,61,61,60000); //
	CreateVehicle(470,280.4914,1945.6143,17.6317,310.3278,43,0,60000); //
	CreateVehicle(470,272.2862,1949.4713,17.6367,285.9714,43,0,60000); //
	CreateVehicle(470,271.6122,1961.2386,17.6373,251.9081,43,0,60000); //
	CreateVehicle(470,279.8705,1966.2362,17.6436,228.4709,43,0,60000); //
	CreateVehicle(433,277.6437,1985.7559,18.0772,270.4079,43,0,60000); //
	CreateVehicle(433,277.4477,1994.8329,18.0773,267.7378,43,0,60000); //
	CreateVehicle(568,-441.3438,2215.7026,42.2489,191.7953,41,29,60000); //
	CreateVehicle(568,-422.2956,2225.2612,42.2465,0.0616,41,29,60000); //
	CreateVehicle(568,-371.7973,2234.5527,42.3497,285.9481,41,29,60000); //
	CreateVehicle(568,-360.1159,2203.4272,42.3039,113.6446,41,29,60000); //
	CreateVehicle(468,-660.7385,2315.2642,138.3866,358.7643,6,6,60000); //
	CreateVehicle(493,-1029.2648,2237.2217,42.2679,260.5732,1,3,60000); //
	CreateVehicle(419,95.0568,1056.5530,13.4068,192.1461,13,76,60000); //
	CreateVehicle(411,-290.0065,1759.4958,42.4154,89.7571,116,1,60000); //
	CreateVehicle(522,-302.5649,1777.7349,42.2514,238.5039,6,25,60000); //
	CreateVehicle(522,-302.9650,1776.1152,42.2588,239.9874,8,82,60000); //
	CreateVehicle(533,-301.0404,1750.8517,42.3966,268.7585,75,1,60000); //
	CreateVehicle(535,-866.1774,1557.2700,23.8319,269.3263,31,1,60000); //
	CreateVehicle(550,-799.3062,1518.1556,26.7488,88.5295,53,53,60000); //
	CreateVehicle(521,-749.9730,1589.8435,26.5311,125.6508,92,3,60000); //
	CreateVehicle(522,-867.8612,1544.5282,22.5419,296.0923,3,3,60000); //
	CreateVehicle(554,-904.2978,1553.8269,25.9229,266.6985,34,30,60000); //
	CreateVehicle(521,-944.2642,1424.1603,29.6783,148.5582,92,3,60000); //
	CreateVehicle(429,-237.7157,2594.8804,62.3828,178.6802,1,2,60000); //
	CreateVehicle(463,-196.3012,2774.4395,61.4775,303.8402,22,22,60000); //
	CreateVehicle(519,-1341.1079,-254.3787,15.0701,321.6338,1,1,60000); //
	CreateVehicle(519,-1371.1775,-232.3967,15.0676,315.6091,1,1,60000); //
	CreateVehicle(519,1642.9850,-2425.2063,14.4744,159.8745,1,1,60000); //
	CreateVehicle(519,1734.1311,-2426.7563,14.4734,172.2036,1,1,60000); //
	CreateVehicle(415,-680.9882,955.4495,11.9032,84.2754,36,1,60000); //
	CreateVehicle(452,-816.3951,2222.7375,43.0045,268.1861,1,3,60000); //
	CreateVehicle(460,-94.6885,455.4018,1.5719,250.5473,1,3,60000); //
	CreateVehicle(446,1624.5901,565.8568,1.7817,200.5292,1,3,60000); //
	CreateVehicle(454,1639.3567,572.2720,1.5311,206.6160,1,3,60000); //
	CreateVehicle(452,2293.4219,517.5514,1.7537,270.7889,1,3,60000); //
	CreateVehicle(446,2354.4690,518.5284,1.7450,270.2214,1,3,60000); //
	CreateVehicle(484,772.4293,2912.5579,1.0753,69.6706,1,3,60000); //
	CreateVehicle(560,2133.0769,1019.2366,10.5259,90.5265,9,39,60000); //
	CreateVehicle(560,2142.4023,1408.5675,10.5258,0.3660,17,1,60000); //
	CreateVehicle(560,2196.3340,1856.8469,10.5257,179.8070,21,1,60000); //
	CreateVehicle(560,2103.4146,2069.1514,10.5249,270.1451,33,0,60000); //
	CreateVehicle(560,2361.8042,2210.9951,10.3848,178.7366,37,0,60000); //
	CreateVehicle(560,-1993.2465,241.5329,34.8774,310.0117,41,29,60000); //
	CreateVehicle(559,-1989.3235,270.1447,34.8321,88.6822,58,8,60000); //
	CreateVehicle(559,-1946.2416,273.2482,35.1302,126.4200,60,1,60000); //
	CreateVehicle(558,-1956.8257,271.4941,35.0984,71.7499,24,1,60000); //
	CreateVehicle(562,-1952.8894,258.8604,40.7082,51.7172,17,1,60000); //
	CreateVehicle(411,-1949.8689,266.5759,40.7776,216.4882,112,1,60000); //
	CreateVehicle(429,-1988.0347,305.4242,34.8553,87.0725,2,1,60000); //
	CreateVehicle(559,-1657.6660,1213.6195,6.9062,282.6953,13,8,60000); //
	CreateVehicle(560,-1658.3722,1213.2236,13.3806,37.9052,52,39,60000); //
	CreateVehicle(558,-1660.8994,1210.7589,20.7875,317.6098,36,1,60000); //
	CreateVehicle(550,-1645.2401,1303.9883,6.8482,133.6013,7,7,60000); //
	CreateVehicle(460,-1333.1960,903.7660,1.5568,0.5095,46,32,60000); //
	CreateVehicle(411,113.8611,1068.6182,13.3395,177.1330,116,1,60000); //
	CreateVehicle(429,159.5199,1185.1160,14.7324,85.5769,1,2,60000); //
	CreateVehicle(411,612.4678,1694.4126,6.7192,302.5539,75,1,60000); //
	CreateVehicle(522,661.7609,1720.9894,6.5641,19.1231,6,25,60000); //
	CreateVehicle(522,660.0554,1719.1187,6.5642,12.7699,8,82,60000); //
	CreateVehicle(567,711.4207,1947.5208,5.4056,179.3810,90,96,60000); //
	CreateVehicle(567,1031.8435,1920.3726,11.3369,89.4978,97,96,60000); //
	CreateVehicle(567,1112.3754,1747.8737,10.6923,270.9278,102,114,60000); //
	CreateVehicle(567,1641.6802,1299.2113,10.6869,271.4891,97,96,60000); //
	CreateVehicle(567,2135.8757,1408.4512,10.6867,180.4562,90,96,60000); //
	CreateVehicle(567,2262.2639,1469.2202,14.9177,91.1919,99,81,60000); //
	CreateVehicle(567,2461.7380,1345.5385,10.6975,0.9317,114,1,60000); //
	CreateVehicle(567,2804.4365,1332.5348,10.6283,271.7682,88,64,60000); //
	CreateVehicle(560,2805.1685,1361.4004,10.4548,270.2340,17,1,60000); //
	CreateVehicle(506,2853.5378,1361.4677,10.5149,269.6648,7,7,60000); //
	CreateVehicle(567,2633.9832,2205.7061,10.6868,180.0076,93,64,60000); //
	CreateVehicle(567,2119.9751,2049.3127,10.5423,180.1963,93,64,60000); //
	CreateVehicle(567,2785.0261,-1835.0374,9.6874,226.9852,93,64,60000); //
	CreateVehicle(567,2787.8975,-1876.2583,9.6966,0.5804,99,81,60000); //
	CreateVehicle(411,2771.2993,-1841.5620,9.4870,20.7678,116,1,60000); //
	CreateVehicle(466,1713.9319,1467.8354,10.5219,342.8006,6,1,60000); // taxi
	CreateVehicle(411,1711.9751,1459.6394,10.4846,345.1820,116,1,60000); // new1
	CreateVehicle(492,1710.0770,1451.2668,10.5589,346.3498,77,26,60000); // 2
	CreateVehicle(461,1707.3859,1440.5593,10.2093,354.5417,43,1,60000); // 3
	CreateVehicle(461,1708.1227,1444.6547,10.2694,343.4576,53,1,60000); // 4
	CreateVehicle(466,1707.1648,1434.5001,10.3884,354.3010,68,76,60000); // 5
	CreateVehicle(461,1717.8676,1478.0989,10.5246,342.6460,6,1,60000); // 6
	CreateVehicle(538,1447.5947,2632.2500,12.1256,270.0000,80,7,60000); // train
	CreateVehicle(449,-2006.5000,176.8256,27.9973,0.0000,80,80,60000); // tram
	CreateVehicle(565,2078.6663,767.8613,10.7924,178.4803,7,7,60000); // c1
	CreateVehicle(411,2127.6853,687.8859,10.9132,178.3903,80,1,60000); // c2
	CreateVehicle(492,2361.5259,696.6867,11.0805,357.7054,28,56,60000); // c3
	CreateVehicle(415,1625.0688,2603.0742,10.5986,0.0668,20,1,60000); // c4
	CreateVehicle(565,1585.0323,2719.4983,10.4461,358.2070,10,10,60000); // c5
	CreateVehicle(521,1353.5540,2601.6475,10.4218,90.1398,118,118,60000); // c6
	CreateVehicle(412,1372.3196,1968.7961,11.1444,268.3946,10,8,60000); // c7
	CreateVehicle(461,991.8229,1895.8848,10.9306,268.1824,79,1,60000); // c8
	CreateVehicle(466,992.9775,2308.2297,11.0103,276.5634,2,76,60000); // c9
	AddStaticPickup(371, 15, 1710.3359,1614.3585,10.1191); //para
	AddStaticPickup(371, 15, 1964.4523,1917.0341,130.9375); //para
	AddStaticPickup(371, 15, 2055.7258,2395.8589,150.4766); //para
	AddStaticPickup(371, 15, 2265.0120,1672.3837,94.9219); //para
	AddStaticPickup(371, 15, 2265.9739,1623.4060,94.9219); //para
	//DMV=======================================================================
	dmv1 = CreateVehicle(496,1144.0110,1354.6926,10.5372,185.4727,3,3,60000); // dmv1
	dmv2 = CreateVehicle(496,1138.5315,1353.9237,10.5424,183.1926,3,3,60000); // dmv2
	dmv3 = CreateVehicle(496,1133.0156,1354.4966,10.5340,181.5838,3,3,60000); // dmv3
	dmv4 = CreateVehicle(496,1128.1248,1354.7671,10.5339,178.3997,3,3,60000); // dmv4
	dmv5 = CreateVehicle(496,1123.3547,1355.0510,10.5172,181.2228,3,3,60000); // dmv5
	sboat1 = CreateVehicle(493,-2231.3533,2392.4949,-0.0024,47.5505,3,3,60000); // boat1
	sboat2 = CreateVehicle(493,-2224.2778,2399.8406,-0.2562,43.3164,3,3,60000); // boat2
	sboat3 = CreateVehicle(493,-2209.5981,2410.5684,-0.1052,51.6968,3,3,60000); // boat3
	sboat4 = CreateVehicle(493,-2202.2952,2418.5430,-0.2381,46.0866,3,3,60000); // boat4
	sfly1 = CreateVehicle(487,421.3796,2489.7771,16.6586,90.4338,3,3,60000); // mav1
	sfly2 = CreateVehicle(487,421.6896,2497.9045,16.6634,92.5441,3,3,60000); // mav2
	sfly3 = CreateVehicle(487,423.3735,2506.5222,16.6881,86.3415,3,3,60000); // mav3
	sfly4 = CreateVehicle(487,422.4156,2514.9255,16.6612,86.1888,3,3,60000); // mav4
	taxi1 = CreateVehicle(420,1392.9469,713.3551,10.6034,270.5379,6,1,60000); // taxi1
	taxi2 = CreateVehicle(420,1393.0568,717.0647,10.5989,271.2584,6,1,60000); // taxi2
	taxi3 = CreateVehicle(420,1392.7783,720.6296,10.6086,267.1669,6,1,60000); // taxi3
	taxi4 = CreateVehicle(420,1392.7550,724.2181,10.6003,267.3357,6,1,60000); // taxi4
	taxi5 = CreateVehicle(420,1392.6698,727.9030,10.6013,270.0202,6,1,60000); // taxi5
	taxi6 = CreateVehicle(420,1392.6182,731.5430,10.6001,267.8872,6,1,60000); // taxi6
	taxi7 = CreateVehicle(420,1392.4968,735.1641,10.6003,265.6664,6,1,60000); // taxi7
	taxi8 = CreateVehicle(420,1392.5475,738.8901,10.6021,267.6069,6,1,60000); // taxi8
	taxi9 = CreateVehicle(420,1392.7556,742.8641,10.6004,266.7427,6,1,60000); // taxi9
	taxi10 = CreateVehicle(420,1392.9056,747.1757,10.6035,267.7900,6,1,60000); // taxi10
	bus1 = CreateVehicle(437,1389.6528,701.8298,10.9536,267.6879,125,21,60000); // bus1
	bus2 = CreateVehicle(437,1389.7147,693.8329,10.9543,267.8192,123,20,60000); // bus2
	bus3 = CreateVehicle(437,1392.9144,671.7780,10.9619,181.2676,105,20,60000); // bus3
	bus4 = CreateVehicle(437,1385.0782,671.2388,10.9617,179.7833,98,20,60000); // bus4
	bus5 = CreateVehicle(437,1376.9729,671.7563,10.9307,181.0309,95,16,60000); // bus5
	bus6 = CreateVehicle(437,1369.7050,670.9875,10.9607,179.0425,87,7,60000); // bus6
	bus7 = CreateVehicle(437,1362.9231,670.4962,10.9579,178.5772,79,7,60000); // bus7
	ambu1 = CreateVehicle(416,1598.1155,1831.5974,10.9707,0.0062,1,3,60000); // ambu1
	ambu2 = CreateVehicle(416,1602.4189,1831.5559,10.9716,1.3265,1,3,60000); // ambu2
	ambu3 = CreateVehicle(416,1608.2091,1831.2502,10.9745,1.2418,1,3,60000); // ambu3
	ambu4 = CreateVehicle(416,1612.2133,1831.3837,10.9701,0.0907,1,3,60000); // ambu4
	ambu5 = CreateVehicle(416,1617.0848,1831.4664,10.9718,359.2161,1,3,60000); // ambu5
	//==========================================================================
	pol1 = CreateVehicle(598,2277.6846,2477.1096,10.5652,180.1090,0,1,60000);
	pol2 = CreateVehicle(598,2268.9888,2443.1697,10.5662,181.8062,0,1,60000);
	pol3 = CreateVehicle(598,2256.2891,2458.5110,10.5680,358.7335,0,1,60000);
	pol4 = CreateVehicle(598,2251.6921,2477.0205,10.5671,179.5244,0,1,60000);
	pol5 = CreateVehicle(523,2294.7305,2441.2651,10.3860,9.3764,0,0,60000);
	pol6 = CreateVehicle(523,2290.7268,2441.3323,10.3944,16.4594,0,0,60000);
	pol7 = CreateVehicle(523,2295.5503,2455.9656,2.8444,272.6913,0,0,60000);
	john1 = CreateVehicle(567,991.4617,2037.3473,11.1822,91.5865,86,86,60000); // john1
	john2 = CreateVehicle(461,1021.8692,2019.8420,10.7375,93.4587,86,86,60000); // john2
	john3 = CreateVehicle(567,1022.4779,2011.5701,11.1787,85.4257,86,86,60000); // john3
	john4 = CreateVehicle(567,992.0786,1995.0688,11.1542,271.4297,86,86,60000); // john4
	john5 = CreateVehicle(492,993.3489,1985.2188,10.9140,268.2276,86,86,60000); // john5
	john6 = CreateVehicle(522,1022.2686,1969.4838,10.8001,92.0308,86,86,60000); // john6
	ver1 = CreateVehicle(405,1603.7504,2046.6335,11.0761,269.0791,93,93,60000); // ver1
	ver2 = CreateVehicle(405,1632.5520,2038.5936,10.8757,270.2800,93,93,60000); // ver2
	ver3 = CreateVehicle(565,1603.1895,2076.9895,10.7025,90.0719,93,93,60000); // ver3
	ver4 = CreateVehicle(565,1601.2117,2087.7676,10.8810,272.1955,93,93,60000); // ver4
	ver5 = CreateVehicle(565,1622.7280,2135.5325,10.3701,357.7660,93,93,60000); // ver5
	ver6 = CreateVehicle(405,1614.1331,2138.6667,10.6385,180.3130,93,93,60000); // ver6
	ver7 = CreateVehicle(581,1622.9568,2103.1243,10.1214,3.1851,93,93,60000); // ver7
	fido1 = CreateVehicle(402,2012.5066,2755.3877,10.6518,181.1355,0,0,60000); // fido1
	fido2 = CreateVehicle(402,2008.5707,2728.5247,10.6591,358.2430,0,0,60000); // fido2
	fido3 = CreateVehicle(521,1992.0829,2737.7278,10.2358,272.3021,0,0,60000); // fido3
	fido4 = CreateVehicle(411,1997.8760,2756.4795,10.5503,182.3438,0,0,60000); // fido4
	fido5 = CreateVehicle(411,1962.2205,2738.6311,10.3990,268.2974,0,0,60000); // fido5
	fido6 = CreateVehicle(402,1940.6892,2745.6777,10.5037,90.0303,0,0,60000); // fido6
	fido7 = CreateVehicle(402,2049.1226,2745.9341,10.5036,87.7652,0,0,60000); // fido7
	fido8 = CreateVehicle(521,2042.2000,2738.1611,10.2364,275.2568,0,0,60000); // fido8
	CreateVehicle(609,1635.9941,961.2823,10.8651,268.3788,36,36,60000); // mailc1
	CreateVehicle(609,1636.1201,968.5431,10.8919,267.7501,36,36,60000); // mailc2
	CreateVehicle(609,1635.5782,975.2741,10.8944,268.2310,36,36,60000); // mailc3
	CreateVehicle(609,1635.0319,982.7022,10.8914,268.2317,36,36,60000); // mailc4
	CreateVehicle(609,1635.0536,990.1790,10.8914,275.1247,36,36,60000); // mailc5
	CreateVehicle(609,1634.5510,998.3203,10.8914,273.2447,36,36,60000); // mailc6
	CreateVehicle(609,1634.0203,1004.9755,10.8914,271.6781,36,36,60000); // mailc7
	mayorc = CreateVehicle(451,2422.7737,1141.7904,10.4496,180.0910,36,36,60000); // mayor
	CreateVehicle(493,-647.8251,876.8459,-0.1295,231.1747,36,13,60000); //
	CreateVehicle(493,-650.0508,868.4523,-0.0924,229.5508,36,13,60000); //
	CreateVehicle(539,-637.4379,861.8458,0.4382,315.4066,86,70,60000); //
	CreateVehicle(446,-649.8297,885.3865,-0.5033,284.4896,1,57,60000); //
	CreateVehicle(444,-682.0253,966.1611,12.5041,90.6437,32,42,60000); //
	CreateVehicle(425,-702.5239,899.0683,13.0887,291.7734,43,0,60000); //
 	CreateVehicle(541,-680.6547,951.6569,11.7578,85.5807,68,8,60000); //
	CreateVehicle(522,-709.3484,948.1905,12.0208,90.6181,7,79,60000); //
	CreateVehicle(522,-709.0540,951.0348,12.0262,87.8005,6,25,60000); //
	CreateVehicle(522,-709.2424,953.9731,12.0193,88.1136,3,8,60000); //
	return 1;
}

public OnGameModeExit()
{
	Update();
	return 1;
}

public RandIExp()
{
	new rand = random(sizeof(RandIEx));
	CreateExplosion(RandIEx[rand][0],RandIEx[rand][1],RandIEx[rand][2],12,0);
}

public GameWins()
{
	new rand = random(sizeof(TeamWins));
	SendClientMessageToAll(COLOR_ORANGE, TeamWins[rand][0]);
}

public AdvertCount()
{
	count10--;
	if(count10 == 0)
	{
		KillTimer(count10t);
		count10 = 0;
	}
}

public AdminCashCP()
{
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(gTeam[i] == ADMIN)
		    {
			    if(CPS_IsPlayerInCheckpoint(i,cashcp))
			    {
			        GivePlayerMoney(i,50);
			    }
		    }
    	}
    }
}

public CallT()
{
	count11--;
	if(count11 == 0)
	{
	    new string[256],string2[256];
 		GetPlayerName(caller, sendername, sizeof(sendername));
 		GetPlayerName(calling, giveplayer, sizeof(giveplayer));
 		format(string,sizeof(string),"%s never picked up, call ended", sendername);
 		format(string2,sizeof(string2),"You didn't picked up %s's call, call ended", giveplayer);
 		SendClientMessage(caller, COLOR_RED, string);
 		SendClientMessage(calling, COLOR_RED, string2);
		KillTimer(count11t);
		count11 = 0;
		caller = 999;
		calling = 999;
	}
}

public PingKick()
{
 	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(GetPlayerPing(i) >= 800)
			{
			    new string[256];
			    new playername[MAX_PLAYER_NAME];
			    GetPlayerName(i, playername, sizeof(playername));
			    format(string, sizeof(string), "PING CHECK: %s was kicked for having a ping over 800",playername);
			    SendClientMessageToAll(COLOR_RED, string);
			}
		}
	}
}

public Clock()
{
	clock();
}

public TTime(playerid)
{
 	for(new i=0; i<MAX_PLAYERS; i++)
 	if(IsPlayerConnected(i))
	{
		if(taxif[i] == 1)
		{
		    fare++;
		    new string[256];
		    format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~g~Price: ~b~$%d", fare);
		    GameTextForPlayer(i, string, 999, 5);
		}
	}
}

public JailCD()
{
    for(new i=0; i<MAX_PLAYERS; i++)
	if(IsPlayerConnected(i))
	{
	    if(jailed[i] == 1)
	    {
			jailtime[i]--;
			if(jailtime[i] == 0)
			{
				KillTimer(JailCDt);
				jailtime[i] = 0;
				jailed[i] = 0;
				SendClientMessage(i, COLOR_LIGHTBLUE, "Your jail time is over, be more careful this time");
				SetPlayerInterior(i, 0);
				SetPlayerPos(i, 2286.6458,2421.2732,10.8203);
			}
		}
	}
}

public GetVehicleDriverId(vehicleid)
{
	new h,id = -1;
	for(h=0;h<=MAX_PLAYERS;h++)
	{
		if(IsPlayerInVehicle(h,vehicleid)==1)
		{
			id = h;
		}
	}
	return id;
}

GetConnectedPlayers()
{
	new p;
    for(new i=0; i<MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i))
		{
		    i = p;
		}
	}
	return p;
}

public FirstTime()
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i))
		{
	        if(firstime[i] == 1)
	        {
				count6[i]++;
				inguide[i] = 1;
			    if(count6[i] == 1)
			    {
		            SendClientMessage(i, COLOR_GRAY, "==========>First Time Players Guide<==========");
					SendClientMessage(i, COLOR_CA, "I see this is your first time playing here..");
				} else if(count6[i] == 4) {
					SendClientMessage(i, COLOR_GRAY, "==============================================");
				    SendClientMessage(i, COLOR_CA, "You need an account. You'll create one later.");
				    SendClientMessage(i, COLOR_CA, "An account is important because without one, your stats won't be saved");
				    SendClientMessage(i, COLOR_CA, "If your stats aren't saved, when you leave, everything will be lost");
				} else if(count6[i] == 10) {
				    SendClientMessage(i, COLOR_GRAY, "==========>Basic Info<==========");
					SendClientMessage(i, COLOR_CA, "The game mode is LVRP, meaning Las Venturas Role Play");
					SendClientMessage(i, COLOR_CA, "There is no deathmatching, you'll get arrested");
					SendClientMessage(i, COLOR_CA, "No hacking/cheating/glitching/modding in any way, shape or form");
					SendClientMessage(i, COLOR_CA, "That leads to an automatic ban");
				} else if(count6[i] == 16) {
					SendClientMessage(i, COLOR_GRAY, "==============================================");
				    SendClientMessage(i, COLOR_CA, "Remember to follow all rules and most importantly, respect everyone");
				    SendClientMessage(i, COLOR_CA, "Respect is everything here, and try to tone down the cursing");
				    SendClientMessage(i, COLOR_CA, "PLEASE DO NOT TYPE LIKE THIS, 0r 7|-|15, you'll get muted");
				} else if(count6[i] == 22) {
					SendClientMessage(i, COLOR_GRAY, "==============================================");
				    SendClientMessage(i, COLOR_CA, "Always speak english (unless in a private chat), or you'll get muted");
				} else if(count6[i] == 28) {
					SendClientMessage(i, COLOR_GRAY, "==============================================");
				    SendClientMessage(i, COLOR_CA, "Cops, admins, and the Mayor run things");
				    SendClientMessage(i, COLOR_CA, "If you are told to do something, do as your told");
				    SendClientMessage(i, COLOR_CA, "If you feel what they told you to do was wrong, complain at our forum");
				    SendClientMessage(i, COLOR_CA, "scarfacerp.awardspace.com");
				} else if(count6[i] == 34) {
					SendClientMessage(i, COLOR_GRAY, "==========>Licenses and Housing<==========");
					SendClientMessage(i, COLOR_CA, "We are almost done with this guide");
					SendClientMessage(i, COLOR_CA, "Before you can drive, boat, fly, or carry arms, you need a license for each");
					SendClientMessage(i, COLOR_CA, "For more on licenses type /licensing");
				} else if(count6[i] == 40) {
					SendClientMessage(i, COLOR_GRAY, "==============================================");
				    SendClientMessage(i, COLOR_CA, "Houses are available");
				    SendClientMessage(i, COLOR_CA, "If you type /showhouses, houses for sale will show on your mini map");
				    SendClientMessage(i, COLOR_CA, "Houses can have more than one person living there by paying rent");
				} else if(count6[i] == 46) {
				    SendClientMessage(i, COLOR_GRAY, "==========>The End<==========");
				    SendClientMessage(i, COLOR_CA, "If you need more info on this server, type /life");
				    SendClientMessage(i, COLOR_CA, "Other things can be shown by typing /help");
				    SendClientMessage(i, COLOR_CA, "If you ever want to see this guide again type /guide");*/
				} else if(count6[i] == 52) {
					SendClientMessage(i, COLOR_GRAY, "==============================================");
				    SendClientMessage(i, COLOR_CA, "That's it for the guide");
					GameTextForPlayer(i,"~r~You now need to register~n~Use /register <password>",5000,5);
				    inguide[i] = 0;
				    reg[i] = 1;
				    KillTimer(count6t);
//				    firstime[i] = 0;
				    skinz = GetPlayerSkin(i);
				    preglog[i] = 1;
				    plxlogin[i] = 1;
				}
			}
		}
	}
}

PlayerLeaveGang(playerid) {
	new string[256];
	new playername[MAX_PLAYER_NAME];
	new gangnum = playerGang[playerid];

    if(gangnum > 0) {
		for(new i = 0; i < gangInfo[gangnum][1]; i++) {
			if(gangMembers[gangnum][i]==playerid) {

			    //One less gang member
			    gangInfo[gangnum][1]--;

      		    for(new j = i; j < gangInfo[gangnum][1]; j++) {
				    //Shift gang members
				    gangMembers[gangnum][j]=gangMembers[gangnum][j+1];
	    		}

			    //Disband gang if no more members
			    if(gangInfo[gangnum][1]<1) {
			        gangInfo[gangnum][0]=0;
			        gangInfo[gangnum][1]=0;
			        gangBank[gangnum]=0;
       			}

				//Notify other members
				for(new j = 0; j < gangInfo[gangnum][1]; j++) {
				    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
					format(string, sizeof(string),"%s has quit your gang.", playername);
					SendClientMessage(gangMembers[gangnum][j], COLOR_ORANGE, string);
				}

				format(string, sizeof(string),"You have quit the gang '%s' (id: %d)", gangNames[gangnum], gangnum);
				SendClientMessage(playerid, COLOR_ORANGE, string);

				playerGang[playerid]=0;

				SetPlayerColor(playerid,COLOR_GRAY);

				return;
			}
		}
	} else {
		SendClientMessage(playerid, COLOR_RED, "You are not in a gang.");
	}
}

public GZs()
{
    for(new i=0;i<=MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
            new inte = GetPlayerInterior(i);
			if(IsPlayerInArea(i, -759.0619, 829.1292, -572.2159, 1039.331))
		    {
		        if(inte == 0)
		        {
	          		if(gTeam[i] != ADMIN)
			        {
			            KillTimer(zcheck);
			            zchecko = SetTimer("GZss",500,1);
	           			GameTextForPlayer(i, "~n~~n~~n~~n~~n~~n~~r~Admin only zone!~n~You have 5 seconds to leave!", 4000, 5);
	           			fsecs = SetTimer("FiveSecs",1000,1);
	           			fsecsd = 5;
			        } else {
			            KillTimer(zcheck);
			            zchecko = SetTimer("GZss",500,1);
	              		GameTextForPlayer(i, "~n~~n~~n~~n~~n~~n~~g~Welcome to Admin only zone", 4000, 5);
			        }
		        }
			} else {

		    }
		}
	}
 	return 1;
}

public PhoneCost()
{
    for(new i=0;i<=MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
            if(incall[i] == 1)
            {
                if(i == caller)
                {
					phoneprice[i]++;
				}
			}
		}
	}
}

public FiveSecs()
{
    for(new i=0;i<=MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
			if(IsPlayerInArea(i, -759.0619, 829.1292, -572.2159, 1039.331) && GetPlayerInterior(i) == 0)
			{
				fsecsd--;
				if(fsecsd == 0)
				{
				    SetPlayerHealth(i,0);
				}
			}
		}
	}
}

public GZss()
{
    for(new i=0;i<=MAX_PLAYERS;i++)
    {
        if(IsPlayerConnected(i))
        {
			if(!IsPlayerInArea(i, -759.0619, 829.1292, -572.2159, 1039.331) && GetPlayerInterior(i) == 0)
		    {
		        zcheck = SetTimer("GZs",500,1);
		        KillTimer(zchecko);
		        KillTimer(fsecs);
		    }
		}
	}
	return 1;
}

SendClientMessageToTeam(team,color ,string[])
{
	for (new i=0;i<MAX_PLAYERS;i++)
    {
    	if ((IsPlayerConnected(i))&&(gTeam[i]==team))
		{
			SendClientMessage(i,color,string);
		}
    }
}

stock IsNumeric(string[]) { for (new i = 0, j = strlen(string); i < j; i++) if (string[i] > '9' || string[i] < '0') return 0; return 1; }

/*GameTextForTeam(team,string[],time,style)
{
	for (new i=0;i<MAX_PLAYERS;i++)
    {
    	if ((IsPlayerConnected(i))&&(gTeam[i]==team))
		{
			GameTextForPlayer(i,string,time,style);
		}
    }
}*/

public MailDrop(playerid)
{
	for(new h;h<MAX_PLAYERS;h++)
	if(IsPlayerConnected(h))
	{
		if(gJob[h] == MAIL)
		{
		    mailed[h] = 1;
		    count4 = 600;
	 		count3t = SetTimer("MailDrop2", 1000, 1);
	  		new rand = random(sizeof(mailcp));
	    	SendClientMessage(h, COLOR_BROWN, "You have requested and recieved an Insta-Mail package");
	    	SendClientMessage(h, COLOR_BROWN, "Take it to the checkpoint before time runs out (2 mins)");
	    	SendClientMessage(h, COLOR_BROWN, "You will be rewarded $600");
	    	SetPlayerCheckpoint(h, mailcp[rand][0], mailcp[rand][1], mailcp[rand][2], 4);
		}
	}
}

public MailDrop2(playerid)
{
	for(new h;h<MAX_PLAYERS;h++)
	if(IsPlayerConnected(h))
	{
		if(mailed[h] == 1)
		{
			new string[56];
			count3--;
			format(string,sizeof(string),"~n~~n~~n~~n~~n~~n~~w~Time Left: ~r~%d",count3);
			GameTextForPlayer(h, string, 999, 5);
			if(count3 == 0)
			{
				SendClientMessage(h, COLOR_ORANGE, "You failed to get the package delivered on time");
				SendClientMessage(h, COLOR_ORANGE, "Your pay has been deducted $50");
				DisablePlayerCheckpoint(h);
				GivePlayerMoney(h, -50);
				KillTimer(count3t);
				count3 = 120;
				mailed[h] = 0;
		   	}
		}
	}
   	return 1;
}

public MailDrop3(playerid)
{
	count4--;
	if(count4 == 1)
	{
		KillTimer(count4t);
		count4 = 0;
   	}
}

public Count5()
{
	count5--;
	if(count5 == 1)
	{
		KillTimer(count5t);
		count5 = 0;
   	}
}

stock IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy) //By Alex "Y_Less" Cole
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(IsPlayerConnected(playerid))
	{
		if (x > minx && x < maxx && y > miny && y < maxy)
		{
			return 1;
		}
	}
	return 0;
}

public PlayerDistance(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

stock SystemMsg(playerid,msg[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
       SendClientMessage(playerid,COLOR_SYSTEM,msg);
   }
   return 1;
}

stock PlayerName(playerid) {
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}

public WepCheck(playerid)
{
	for(new i=0; i<MAX_PLAYERS; i++)
 	if(IsPlayerConnected(i))
	{
		if(wli[i] == 0)
		{
		    if(PlayerWeapons(i))
			{
				ResetPlayerWeapons(i);
				SendClientMessage(i, COLOR_WHITE, "You need a weapon license to keep this weapon");
				SendClientMessage(i, COLOR_WHITE, "Apply for a weapons license at the Ammunation near The Strip");
			}
		}
	}
}

public LookItCar()
{
    count7 --;
    for(new i=0; i<MAX_PLAYERS; i++)
    {
	   	if(IsPlayerConnected(i))
		{
		    SetPlayerPos(i,1167.2296,1384.3047,10.5609);
			SetPlayerCameraPos(i,1166.5088,1400.2223,20.6972);
	 		SetPlayerCameraLookAt(i,900.5088,650.2223,8.6972);
			if(count7 == 0)
			{
			    SetPlayerPos(i,jx,jy,jz+3);
				SetCameraBehindPlayer(i);
				KillTimer(count7t);
			}
		}
	}
}

public LookItPlane()
{
    count8 --;
    for(new i=0; i<MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i))
		{
		    SetPlayerPos(i,407.5055,2438.5493,29.5588);
			SetPlayerCameraPos(i,380.6236,2499.4443,20.4844);
	 		SetPlayerCameraLookAt(i,399.8089,2505.9265,16.4844);
			if(count8 == 0)
			{
			    SetPlayerPos(i,jx,jy,jz+3);
				SetCameraBehindPlayer(i);
				KillTimer(count8t);
			}
		}
	}
}

public LookItBoat()
{
    count9 --;
    for(new i=0; i<MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i))
		{
		    SetPlayerPos(i,-2191.0967,2411.5249,4.9643);
			SetPlayerCameraPos(i,-2147.6375,2444.2126,3.5560);
	    	SetPlayerCameraLookAt(i,-2155.5349,2439.3960,3.4839);
			if(count9 == 0)
			{
			    SetPlayerPos(i,jx,jy,jz+3);
				SetCameraBehindPlayer(i);
				KillTimer(count9t);
			}
		}
	}
}

public Update()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (PLAYERLIST_authed[i])
			{
				dUserSetINT(PlayerName(i)).("money",GetPlayerMoney(i));
				dUserSetINT(PlayerName(i)).("job",jobbed[i]);
				dUserSetINT(PlayerName(i)).("firstime",firstime[i]);
				dUserSetINT(PlayerName(i)).("drive",dli[i]);
				dUserSetINT(PlayerName(i)).("boat",bli[i]);
				dUserSetINT(PlayerName(i)).("fly",pli[i]);
				dUserSetINT(PlayerName(i)).("weapon",wli[i]);
				dUserSetINT(PlayerName(i)).("count4",count4);
				dUserSetINT(PlayerName(i)).("Count2",Count2);
				dUserSetINT(PlayerName(i)).("count5",count5);
				dUserSetINT(PlayerName(i)).("vlock",vlock[i]);
				dUserSetINT(PlayerName(i)).("tickets",tickets[i]);
				dUserSetINT(PlayerName(i)).("jailed",jailed[i]);
				dUserSetINT(PlayerName(i)).("jailtime",jailtime[i]);
				dUserSetINT(PlayerName(i)).("bail",inbail[i]);
				dUserSetINT(PlayerName(i)).("bailprice",inbailprice[i]);
				dUserSetINT(PlayerName(i)).("sex",psex[i]);
				dUserSetINT(PlayerName(i)).("location",ploc[i]);
				if(gJob[i] == MECHANIC) {
					dUserSetINT(PlayerName(i)).("team",1);
				} else if(gJob[i] == MEDIC) {
					dUserSetINT(PlayerName(i)).("team",2);
				} else if(gJob[i] == WHORE) {
					dUserSetINT(PlayerName(i)).("team",3);
				} else if(gJob[i] == DRUGS) {
					dUserSetINT(PlayerName(i)).("team",4);
				} else if(gJob[i] == IMPORT) {
					dUserSetINT(PlayerName(i)).("team",5);
				} else if(gJob[i] == MAIL) {
					dUserSetINT(PlayerName(i)).("team",6);
				}
				if(gTeam[i] == TAXI)
				{
				    dUserSetINT(PlayerName(i)).("fare",fare2[i]);
				}
				if(gTeam[i] == BUS)
				{
				    dUserSetINT(PlayerName(i)).("fare",fare2[i]);
				}
			}
		}
  	}
  	return 1;
}

stock UpdateT(playerid)
{
	if (PLAYERLIST_authed[playerid])
	{
		dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
		dUserSetINT(PlayerName(playerid)).("job",jobbed[playerid]);
		dUserSetINT(PlayerName(playerid)).("firstime",firstime[playerid]);
		dUserSetINT(PlayerName(playerid)).("drive",dli[playerid]);
		dUserSetINT(PlayerName(playerid)).("boat",bli[playerid]);
		dUserSetINT(PlayerName(playerid)).("fly",pli[playerid]);
		dUserSetINT(PlayerName(playerid)).("weapon",wli[playerid]);
		dUserSetINT(PlayerName(playerid)).("count4",count4);
		dUserSetINT(PlayerName(playerid)).("Count2",Count2);
		dUserSetINT(PlayerName(playerid)).("count5",count5);
		dUserSetINT(PlayerName(playerid)).("vlock",vlock[playerid]);
		dUserSetINT(PlayerName(playerid)).("tickets",tickets[playerid]);
		dUserSetINT(PlayerName(playerid)).("jailed",jailed[playerid]);
		dUserSetINT(PlayerName(playerid)).("jailtime",jailtime[playerid]);
		dUserSetINT(PlayerName(playerid)).("bail",inbail[playerid]);
		dUserSetINT(PlayerName(playerid)).("bailprice",inbailprice[playerid]);
		dUserSetINT(PlayerName(playerid)).("sex",psex[playerid]);
		dUserSetINT(PlayerName(playerid)).("location",ploc[playerid]);
		if(gJob[playerid] == MECHANIC) {
			dUserSetINT(PlayerName(playerid)).("team",1);
		} else if(gJob[playerid] == MEDIC) {
			dUserSetINT(PlayerName(playerid)).("team",2);
		} else if(gJob[playerid] == WHORE) {
			dUserSetINT(PlayerName(playerid)).("team",3);
		} else if(gJob[playerid] == DRUGS) {
			dUserSetINT(PlayerName(playerid)).("team",4);
		} else if(gJob[playerid] == IMPORT) {
			dUserSetINT(PlayerName(playerid)).("team",5);
		} else if(gJob[playerid] == MAIL) {
			dUserSetINT(PlayerName(playerid)).("team",6);
			KillTimer(count3t);
			count3 = 120;
		}
		if(gTeam[playerid] == TAXI)
		{
	 		dUserSetINT(PlayerName(playerid)).("fare",fare2[playerid]);
		}
		if(gTeam[playerid] == BUS)
		{
	 		dUserSetINT(PlayerName(playerid)).("fare",fare2[playerid]);
	  	}
	}
  	return 1;
}

public CashUpdate()
{
	new CashScore;
	new name[MAX_PLAYER_NAME];
	//new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
				//format(string, sizeof(string), "$$$ %s is now in the lead $$$", name);
				//SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
	}
}

public PayDay()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PLAYERLIST_authed[i])
			{
				if(jobbed[i] == 1)
				{
					if(gJob[i] == MECHANIC || gJob[i] == MEDIC || gJob[i] == WHORE || gJob[i] == DRUGS || gJob[i] == IMPORT || gJob[i] == MAIL || gTeam[i] == BUS || gTeam[i] == TAXI)
	 				{
						new string[100];
						new rand = random(sizeof(payamt));
						format(string, sizeof(string), "PayDay: For your hard work you earned %s dollars", payamt[rand][0]);
						SendClientMessage(i,COLOR_AQUA,string);
						GameTextForPlayer(i, "Payday!", 3500, 5);
						GivePlayerMoney(i, payamt[rand][0]);
					}
				}
			}
		}
	}
	return 1;
}

public AdminPayDay()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PLAYERLIST_authed[i])
			{
				if(jobbed[i] == 1)
				{
					if(gTeam[i] == ADMIN || gTeam[i] == MAYOR || gTeam[i] == COP)
	 				{
						new string[100];
						new rand = random(sizeof(payamt));
						format(string, sizeof(string), "PayDay: For your hard work you earned %s dollars", payamt[rand][0]);
						SendClientMessage(i,COLOR_AQUA,string);
						GameTextForPlayer(i, "Payday!", 3500, 5);
						GivePlayerMoney(i, payamt[rand][0]);
					}
				}
			}
		}
	}
	return 1;
}

public MapIcons()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetPlayerMapIcon(i, 0, 2384.9897,1134.7706,34.2529, 56, ORANGE);
			SetPlayerMapIcon(i, 1, 1165.5331,1348.7206,10.9219, 36, ORANGE);
			SetPlayerMapIcon(i, 2, -2186.9885,2415.8528,5.1587, 36, ORANGE);
			SetPlayerMapIcon(i, 3, 414.1424,2533.6438,19.1484, 36, ORANGE);
			SetPlayerMapIcon(i, 24, 2545.9172,1789.1147,30.6641, 52, ORANGE);
		}
	}
}

new Float:health;
public HealDown()
{
   for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
    		GetPlayerHealth(i, health);
    		SetPlayerHealth(i, health - 1);
		}
		if (health== 50)
		{
			SendClientMessage(i, COLOR_BROWN, "Your health is half way, get some food");
		}
		if (health == 10)
		{
			SendClientMessage(i, COLOR_BROWN, "Your health is dangerously low, get some food now!");
        }
	}
}
public OnPlayerRequestClass(playerid, classid)
{
	inclass[playerid] = 1;
	new rand = random(sizeof(RandAnims));
    spawned[playerid] = 0;
	SetPlayerFacingAngle(playerid, 90);
	SetPlayerPos(playerid, 1351.0912,2136.9329,11.0156);
	SetPlayerCameraPos(playerid, 1346.7181,2136.7241,11.0156);
	SetPlayerCameraLookAt(playerid, 1346.7181,2136.7241,11.0156);
	ApplyAnimation(playerid,"DANCING",RandAnims[rand][0],4.0,1,1,1,1,1);
	switch(classid)
	{
	    case 0:
	    {
	    	GameTextForPlayer(playerid, "~r~]Admins Only]", 3500, 3);
	    	SetPlayerTeam(playerid, 0);
	    }
	    case 1:
	    {
	    	GameTextForPlayer(playerid, "~r~Mayor", 3500, 3);
	    	SetPlayerTeam(playerid, 1);
	    }
	    case 2:
	    {
	    	GameTextForPlayer(playerid, "~g~Bus Driver", 3500, 3);
	    	SetPlayerTeam(playerid, 2);
	    }
	    case 3:
	    {
	    	GameTextForPlayer(playerid, "~g~Taxi Driver", 3500, 3);
	    	SetPlayerTeam(playerid, 3);
	    }
	    case 4:
	    {
	    	GameTextForPlayer(playerid, "~g~LVPD", 3500, 3);
	    	SetPlayerTeam(playerid, 4);
	    }
	    case 5:
	    {
	    	GameTextForPlayer(playerid, "~p~Driving Instructor", 3500, 3);
	    	SetPlayerTeam(playerid, 5);
	    }
 	    case 6:
	    {
	    	GameTextForPlayer(playerid, "~p~Pilot Instructor", 3500, 3);
	    	SetPlayerTeam(playerid, 6);
	    }
 	    case 7:
	    {
	    	GameTextForPlayer(playerid, "~p~Boating Instructor", 3500, 3);
	    	SetPlayerTeam(playerid, 7);
	    }
	    case 8:
	    {
	    	GameTextForPlayer(playerid, "~w~Fido Family", 3500, 3);
	    	SetPlayerTeam(playerid, 8);
	    }
	    case 9:
	    {
	    	GameTextForPlayer(playerid, "~w~Vercetti Family", 3500, 3);
	    	SetPlayerTeam(playerid, 9);
	    }
	    case 10:
	    {
	    	GameTextForPlayer(playerid, "~w~Johnson Family", 3500, 3);
	    	SetPlayerTeam(playerid, 10);
	    }
	    case 11:
		{
	    	GameTextForPlayer(playerid, "Pedestrians", 3500, 3);
	    }
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    SetPlayerHealth(playerid, 100);
    SetPlayerPos(playerid, 1680.3296,1447.9521,10.7737);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	cashcp = CPS_AddCheckpoint(-692.0263,928.2659,13.6293,3,30);
    zcheck = SetTimer("GZs",500,1);
    SetTimer("WepCheck",500,1);
	inclass[playerid] = 0;
    SetPlayerHealth(playerid, 100);
	if(firstspawn[playerid] == 0) {
		SetPlayerHealth(playerid, 100);
	} else {
	
	}
 	SetPlayerHealth(playerid, 100);
	if(gTeam[playerid] == BUS) {
		SetPlayerPos(playerid, 1391.1873,685.3361,10.8203);
	} else if(gTeam[playerid] == TAXI) {
		SetPlayerPos(playerid, 1392.8348,753.0795,10.8203);
  	} else if(gTeam[playerid] == COP) {
  		SetPlayerPos(playerid, 2265.2659,2461.8823,10.8203);
  		GivePlayerWeapon(playerid, 24, 50000);
	} else if(gTeam[playerid] == DMV) {
	   	SetPlayerPos(playerid, 1173.4608,1349.6775,10.9219);
	} else if(gTeam[playerid] == PILOT) {
		SetPlayerPos(playerid, 407.1263,2536.3364,16.5465);
	} else if(gTeam[playerid] == FIDO) {
 		SetPlayerPos(playerid, 1996.1805,2731.0322,10.8203);
	} else if(gTeam[playerid] == VERCETTI) {
 		SetPlayerPos(playerid, 1610.3195,2087.1003,10.6719);
	} else if(gTeam[playerid] == JOHNSON) {
 		SetPlayerPos(playerid, 1015.2131,1979.8096,10.8203);
	} else if(gTeam[playerid] == BOAT) {
 		SetPlayerPos(playerid, -2185.7463,2416.3730,5.1802);
	} else if(gTeam[playerid] == MAYOR) {
	    SetPlayerInterior(playerid, 3);
 		SetPlayerPos(playerid, 346.5109,162.0628,1025.7964);
	} else if(gJob[playerid] == MAIL) {
 		SetPlayerPos(playerid, 1631.8187,971.7361,10.8203);
	} else {
		SetPlayerPos(playerid, 1680.3296,1447.9521,10.7737);
	}
	spawned[playerid] = 1;
    GangZoneShowForPlayer(playerid, johnson, 0x00800096);
    GangZoneShowForPlayer(playerid, vercetti, 0x2291FF96);
    GangZoneShowForPlayer(playerid, fido, 0x80808096);
    GangZoneShowForPlayer(playerid, admin, 0xFF5E5E96);
	if(!udb_Exists(PlayerName(playerid)))
	{
	    if(firstime[playerid] == 1) {
	        reg[playerid] = 0;
			logged[playerid] = 0;
	        RegQs[playerid] = 0;
			TogglePlayerControllable(playerid, false);
			SetPlayerHealth(playerid, 100);
			count6t = SetTimer("FirstTime",1000,1);
		} else {
		    RegQs[playerid] = 3;
		}
	} else {
		TogglePlayerControllable(playerid, true);
		SetPlayerHealth(playerid, 100);
	}
	if(firstspawn[playerid] == 0)
	{
	    skinz = GetPlayerSkin(playerid);
		if(gTeam[playerid] != ADMIN)
		{
			if(skinz == 249)
			{
	  			dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
			}
		}
		if(gTeam[playerid] != BUS) {
			if(skinz == 17)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != TAXI) {
			if(skinz == 255)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != COP) {
			if(skinz == 282)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != DMV) {
			if(skinz == 147)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != PILOT) {
			if(skinz == 61)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != BOAT) {
			if(skinz == 217)
			{
			 	dfs[playerid] = 1;
  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != MAYOR) {
			if(skinz == 187)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != JOHNSON) {
			if(skinz == 271)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != FIDO) {
			if(skinz == 299)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] != VERCETTI) {
			if(skinz == 59)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == ADMIN)
		{
			if(skinz != 249)
			{
	  			dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the admin skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
			}
		}
		if(gTeam[playerid] == BUS) {
			if(skinz != 17)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the bus driver skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == TAXI) {
			if(skinz != 255)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the taxi driver skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == COP) {
			if(skinz != 282)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the LVPD skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == DMV) {
			if(skinz != 147)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the driving instructor skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == PILOT) {
			if(skinz != 61)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the flying instructor skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == BOAT) {
			if(skinz != 217)
			{
			 	dfs[playerid] = 1;
  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose boating instructor skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == MAYOR) {
			if(skinz != 187)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the mayor skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == JOHNSON) {
			if(skinz != 271)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Johnson skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == FIDO) {
			if(skinz != 299)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your the Fido skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
		if(gTeam[playerid] == VERCETTI) {
			if(skinz != 59)
			{
			 	dfs[playerid] = 1;
	  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Vercetti skin");
				SetPlayerHealth(playerid, 0);
				ForceClassSelection(playerid);
  			}
		}
	}
	if(jailed[playerid] == 1)
	{
	    SendClientMessage(playerid, COLOR_RED, "Your still in jail");
	    SetPlayerPos(playerid, 198.5881,162.1837,1003.0300);
	    SetPlayerInterior(playerid, 3);
	}
	if(isolated[playerid] == 1)
	{
	    SetPlayerPos(playerid, 4223.0176,1293.5487,189.8703+4);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
	if (killerid == INVALID_PLAYER_ID) {
	    switch (reason) {
			case WEAPON_DROWN:
			{
                format(string, sizeof(string), "*** %s drowned.", name);
			}
			default:
			{
			    if (strlen(deathreason) > 0)
				{
					format(string, sizeof(string), "*** %s died. (%s)", name, deathreason);
				} else {
				    format(string, sizeof(string), "*** %s died.", name);
				}
			}
		}
	} else {
	new killer[MAX_PLAYER_NAME];
	GetPlayerName(killerid, killer, sizeof(killer));
	if (strlen(deathreason) > 0)
	{
		format(string, sizeof(string), "*** %s killed %s. (%s)", killer, name, deathreason);
	} else {
				format(string, sizeof(string), "*** %s killed %s.", killer, name);
		}
	}
	firstspawn[playerid] = 0;
	GetPlayerPos(playerid, mx,my,mz);
    drink[playerid] = 0;
	givenstd[playerid] = 0;
    //skin = GetPlayerSkin(playerid);
    if(killerid == INVALID_PLAYER_ID)
	{
		SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	}
	else
	{
	    SendDeathMessage(killerid,playerid,reason);
	}
	if(dfs[playerid] == 1)
	{
	    dfs[playerid] = 0;
	} else if(dfs[playerid] == 2) {
	} else if(jailed[playerid] == 1) {
		SendClientMessage(playerid, COLOR_BEIGE, "Your jail hospital bill comes down to $600");
		GivePlayerMoney(playerid, -600);
	} else {
		SendClientMessage(playerid, COLOR_BEIGE, "Your hospital bill comes down to $500");
		GivePlayerMoney(playerid, -500);
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
	new idx;
    new tmp[256];
    tmp = strtok(text, idx);
//    if(firstime[playerid] == 1)
//	{
	    if(RegQs[playerid] < 3)
	    {
			if(RegQs[playerid] == 0)
			{
		 		if((strcmp("male", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("male")))
		   		{
		     		psex[playerid] = 1;
		     		SendClientMessage(playerid, COLOR_GRAY, "=======================================");
		       		SendClientMessage(playerid, COLOR_LBLUE, "Your a male.");
					SendClientMessage(playerid, COLOR_LBLUE, "What is your location?");
					SendClientMessage(playerid, COLOR_LBLUE, "Locations: America, South America, Asia, Europe, Africa, Australia");
		   			RegQs[playerid] = 1;
		   			return 0;
				} else if((strcmp("female", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("female"))) {
					psex[playerid] = 2;
					SendClientMessage(playerid, COLOR_GRAY, "=======================================");
					SendClientMessage(playerid, COLOR_LBLUE, "Your a female.");
					SendClientMessage(playerid, COLOR_LBLUE, "What is your location?");
					SendClientMessage(playerid, COLOR_LBLUE, "Locations: North America, South America, Asia, Europe, Africa, Australia");
					RegQs[playerid] = 1;
					return 0;
				}
			} else if(RegQs[playerid] == 1) {
				if((strcmp("america", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("america")))
				{
					ploc[playerid] = 1;
					SendClientMessage(playerid, COLOR_GRAY, "=======================================");
					SendClientMessage(playerid, COLOR_LBLUE, "You live in North America.");
					SendClientMessage(playerid, COLOR_LBLUE, "Thank you for filling in this information");
					firstime[playerid] = 0;
					RegQs[playerid] = 3;
					plxlogin[playerid] = 0;
					if(gTeam[playerid] != ADMIN)
					{
						if(skinz == 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] != BUS) {
						if(skinz == 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != TAXI) {
						if(skinz == 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != COP) {
						if(skinz == 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != DMV) {
						if(skinz == 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != PILOT) {
						if(skinz == 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != BOAT) {
						if(skinz == 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != MAYOR) {
						if(skinz == 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != JOHNSON) {
						if(skinz == 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != FIDO) {
						if(skinz == 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != VERCETTI) {
						if(skinz == 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == ADMIN)
					{
						if(skinz != 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the admin skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] == BUS) {
						if(skinz != 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the bus driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == TAXI) {
						if(skinz != 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the taxi driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == COP) {
						if(skinz != 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the LVPD skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == DMV) {
						if(skinz != 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the driving instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == PILOT) {
						if(skinz != 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the flying instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == BOAT) {
						if(skinz != 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose boating instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == MAYOR) {
						if(skinz != 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the mayor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == JOHNSON) {
						if(skinz != 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Johnson skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == FIDO) {
						if(skinz != 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your the Fido skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == VERCETTI) {
						if(skinz != 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Vercetti skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					return 0;
				} else if((strcmp("asia", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("asia")))
				{
					ploc[playerid] = 2;
					SendClientMessage(playerid, COLOR_GRAY, "=======================================");
					SendClientMessage(playerid, COLOR_LBLUE, "You live in Asia.");
					SendClientMessage(playerid, COLOR_LBLUE, "Thank you for filling in this information");
					RegQs[playerid] = 3;
					if(gTeam[playerid] != ADMIN)
					{
						if(skinz == 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] != BUS) {
						if(skinz == 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != TAXI) {
						if(skinz == 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != COP) {
						if(skinz == 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != DMV) {
						if(skinz == 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != PILOT) {
						if(skinz == 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != BOAT) {
						if(skinz == 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != MAYOR) {
						if(skinz == 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != JOHNSON) {
						if(skinz == 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != FIDO) {
						if(skinz == 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != VERCETTI) {
						if(skinz == 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == ADMIN)
					{
						if(skinz != 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the admin skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] == BUS) {
						if(skinz != 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the bus driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == TAXI) {
						if(skinz != 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the taxi driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == COP) {
						if(skinz != 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the LVPD skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == DMV) {
						if(skinz != 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the driving instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == PILOT) {
						if(skinz != 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the flying instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == BOAT) {
						if(skinz != 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose boating instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == MAYOR) {
						if(skinz != 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the mayor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == JOHNSON) {
						if(skinz != 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Johnson skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == FIDO) {
						if(skinz != 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your the Fido skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == VERCETTI) {
						if(skinz != 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Vercetti skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					return 0;
				} else if((strcmp("europe", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("europe")))
				{
					ploc[playerid] = 3;
					SendClientMessage(playerid, COLOR_GRAY, "=======================================");
					SendClientMessage(playerid, COLOR_LBLUE, "You live in Europe.");
					SendClientMessage(playerid, COLOR_LBLUE, "Thank you for filling in this information");
					RegQs[playerid] = 3;
					if(gTeam[playerid] != ADMIN)
					{
						if(skinz == 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] != BUS) {
						if(skinz == 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != TAXI) {
						if(skinz == 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != COP) {
						if(skinz == 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != DMV) {
						if(skinz == 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != PILOT) {
						if(skinz == 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != BOAT) {
						if(skinz == 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != MAYOR) {
						if(skinz == 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != JOHNSON) {
						if(skinz == 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != FIDO) {
						if(skinz == 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != VERCETTI) {
						if(skinz == 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == ADMIN)
					{
						if(skinz != 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the admin skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] == BUS) {
						if(skinz != 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the bus driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == TAXI) {
						if(skinz != 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the taxi driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == COP) {
						if(skinz != 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the LVPD skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == DMV) {
						if(skinz != 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the driving instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == PILOT) {
						if(skinz != 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the flying instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == BOAT) {
						if(skinz != 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose boating instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == MAYOR) {
						if(skinz != 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the mayor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == JOHNSON) {
						if(skinz != 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Johnson skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == FIDO) {
						if(skinz != 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your the Fido skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == VERCETTI) {
						if(skinz != 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Vercetti skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					return 0;
				} else if((strcmp("africa", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("africa")))
				{
					ploc[playerid] = 4;
					SendClientMessage(playerid, COLOR_GRAY, "=======================================");
					SendClientMessage(playerid, COLOR_LBLUE, "You live in Africa.");
					SendClientMessage(playerid, COLOR_LBLUE, "Thank you for filling in this information");
					RegQs[playerid] = 3;
					if(gTeam[playerid] != ADMIN)
					{
						if(skinz == 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] != BUS) {
						if(skinz == 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != TAXI) {
						if(skinz == 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != COP) {
						if(skinz == 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != DMV) {
						if(skinz == 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != PILOT) {
						if(skinz == 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != BOAT) {
						if(skinz == 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != MAYOR) {
						if(skinz == 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != JOHNSON) {
						if(skinz == 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != FIDO) {
						if(skinz == 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != VERCETTI) {
						if(skinz == 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == ADMIN)
					{
						if(skinz != 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the admin skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] == BUS) {
						if(skinz != 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the bus driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == TAXI) {
						if(skinz != 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the taxi driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == COP) {
						if(skinz != 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the LVPD skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == DMV) {
						if(skinz != 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the driving instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == PILOT) {
						if(skinz != 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the flying instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == BOAT) {
						if(skinz != 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose boating instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == MAYOR) {
						if(skinz != 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the mayor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == JOHNSON) {
						if(skinz != 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Johnson skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == FIDO) {
						if(skinz != 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your the Fido skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == VERCETTI) {
						if(skinz != 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Vercetti skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					return 0;
				} else if((strcmp("australia", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("australia")))
				{
					ploc[playerid] = 5;
					SendClientMessage(playerid, COLOR_GRAY, "=======================================");
					SendClientMessage(playerid, COLOR_LBLUE, "You live in Australia.");
					SendClientMessage(playerid, COLOR_LBLUE, "Thank you for filling in this information");
					SendClientMessage(playerid, COLOR_GRAY, "=======================================");
				    skinz = GetPlayerSkin(playerid);
				    RegQs[playerid] = 3;
					if(gTeam[playerid] != ADMIN)
					{
						if(skinz == 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] != BUS) {
						if(skinz == 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != TAXI) {
						if(skinz == 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != COP) {
						if(skinz == 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != DMV) {
						if(skinz == 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != PILOT) {
						if(skinz == 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != BOAT) {
						if(skinz == 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != MAYOR) {
						if(skinz == 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != JOHNSON) {
						if(skinz == 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != FIDO) {
						if(skinz == 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] != VERCETTI) {
						if(skinz == 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == ADMIN)
					{
						if(skinz != 249)
						{
				  			dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the admin skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
						}
					}
					if(gTeam[playerid] == BUS) {
						if(skinz != 17)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the bus driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == TAXI) {
						if(skinz != 255)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the taxi driver skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == COP) {
						if(skinz != 282)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the LVPD skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == DMV) {
						if(skinz != 147)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the driving instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == PILOT) {
						if(skinz != 61)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the flying instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == BOAT) {
						if(skinz != 217)
						{
						 	dfs[playerid] = 1;
			  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose boating instructor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == MAYOR) {
						if(skinz != 187)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the mayor skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == JOHNSON) {
						if(skinz != 271)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Johnson skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == FIDO) {
						if(skinz != 299)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your the Fido skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
					if(gTeam[playerid] == VERCETTI) {
						if(skinz != 59)
						{
						 	dfs[playerid] = 1;
				  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Vercetti skin");
							SetPlayerHealth(playerid, 0);
							ForceClassSelection(playerid);
			  			}
					}
				    return 0;
				}
	            return 0;
			}
			return 0;
		}
	//}
	if(muted[playerid] == 1)
	{
	    SendClientMessage(playerid, BANRED, "You can't talk because your muted");
	    return 0;
	}
	if(text[0] == '!')
	{
		if(spawned[playerid] == 1)
		{
			new gangChat[256];
			new playername[MAX_PLAYER_NAME];
			new string[256];
			strmid(gangChat,text,1,strlen(text));
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			format(string, sizeof(string),"%s [TeamChat]: %s", playername, gangChat);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(IsPlayerConnected(i))
			    {
		   			if(GetPlayerTeam(i) == GetPlayerTeam(playerid) && spawned[i])
					{
						SendClientMessage(i, COLOR_AQUA, string); // With lightblue color (from valets)
					}
				}
  			}
  		} else {
			SendClientMessage(playerid, BANRED, "You can't team chat if your not spawned");
 			return 0;
  		}
    	return 0;
	}
	if(text[0] == '@') {
		if(playerGang[playerid] > 0) {
		    new gangChat[256];
		    new senderName[MAX_PLAYER_NAME];
		    new string[256];

//		    for(new i = 1; i < strlen(text)+1; i++)
//				gangChat[i]=text[i];

			strmid(gangChat,text,1,strlen(text));

			GetPlayerName(playerid, senderName, sizeof(senderName));
			format(string, sizeof(string),"%s [GangChat]: %s", senderName, gangChat);

			for(new i = 0; i < gangInfo[playerGang[playerid]][1]; i++) {
				SendClientMessage(gangMembers[playerGang[playerid]][i], COLOR_LIGHTBLUE, string);
			}
		}
		return 0;
	}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(RegQs[i] != 0 || RegQs[i] != 1 || RegQs[i] != 2)
	        {
				if(PlayerDistance(45,playerid,i))
				{
					new string[256];
					GetPlayerName(playerid,giveplayer,sizeof(giveplayer));
					format(string,sizeof(string),"%s: %s",giveplayer,text);
					SendClientMessage(i,GetPlayerColor(playerid),string);
				}
			}
		}
		return 0;
	}
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

/*public JobCountDown(playerid){
if (Count2 > 0){
SetTimer("JCD", 1000, 1);
SetTimer("JobCountDown", 18000000, 0);
}
}*/

public JCD(playerid)
{
	Count2--;
	if(Count2 == 0)
	{
		if(jobbed[playerid] == 1)
		{
			KillTimer(jcdt);
			jobhours[playerid] = 0;
			Count2 = 18000;
		}
	}
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	new tmp[256];
    cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/charity", true,8)==0)
	{
	    new tmp2[256];
	    new string[256];
		tmp = strtok(cmdtext, idx);
		tmp2 = strtok(cmdtext, idx);
		new monz = strval(tmp2);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAY, "USAGE: /charity [charity name] [cash]");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: The United Blind People's House (or UBPH)");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: Together We Can Fight HIV/AIDS (or TWC)");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: Let's Fight Cancer!(or LFC)");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: Home For The Lost (or HFTL)");
			return 1;
		}
		if(!strlen(tmp2))
		{
			SendClientMessage(playerid, COLOR_GRAY, "USAGE: /charity [charity name] [cash]");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: The United Blind People's House (or UBPH)");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: Together We Can Fight HIV/AIDS (or TWC)");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: Let's Fight Cancer!(or LFC)");
			SendClientMessage(playerid, COLOR_WHITE, "Charities: Home For The Lost (or HFTL)");
			return 1;
		}
		if(monz < 50)
		{
			SendClientMessage(playerid, COLOR_GRAY, "Please give at least $50");
			return 1;
		}
		if(GetPlayerMoney(playerid) < monz)
		{
			SendClientMessage(playerid, COLOR_GRAY, "You don't have enough cash to give to charity");
			return 1;
		}
		if(strcmp(tmp, "The United Blind People's House", true)==0 || strcmp(tmp, "UBPH", true)==0)
		{
		    format(string,sizeof(string),"You gave a generous donation of %d to The United Blind People's House", monz);
		    SendClientMessage(playerid, COLOR_GREEN2, string);
		    SendClientMessage(playerid, COLOR_GREEN2, "If you continue to give you might be rewarded");
		    charitys[playerid]++;
		    GivePlayerMoney(playerid, -monz);
		} else if(strcmp(tmp, "Together We Can Fight HIV/AIDS", true)==0 || strcmp(tmp, "TWC", true)==0) {
		    format(string,sizeof(string),"You gave a generous donation of %d to Together We Can Fight HIV/AIDS", monz);
		    SendClientMessage(playerid, COLOR_GREEN2, string);
		    SendClientMessage(playerid, COLOR_GREEN2, "If you continue to give you might be rewarded");
		    charitys[playerid]++;
		    GivePlayerMoney(playerid, -monz);
		} else if(strcmp(tmp, "Let's Fight Cancer!", true)==0 || strcmp(tmp, "Let's Fight Cancer", true)==0 || strcmp(tmp, "LFC", true)==0) {
		    format(string,sizeof(string),"You gave a generous donation of %d to Let's Fight Cancer!", monz);
		    SendClientMessage(playerid, COLOR_GREEN2, string);
		    SendClientMessage(playerid, COLOR_GREEN2, "If you continue to give you might be rewarded");
		    charitys[playerid]++;
		    GivePlayerMoney(playerid, -monz);
		} else if(strcmp(tmp, "Home For The Lost", true)==0 || strcmp(tmp, "HTFL", true)==0) {
		    format(string,sizeof(string),"You gave a generous donation of %d to Home For The Lost", monz);
		    SendClientMessage(playerid, COLOR_GREEN2, string);
		    SendClientMessage(playerid, COLOR_GREEN2, "If you continue to give you might be rewarded");
		    charitys[playerid]++;
            GivePlayerMoney(playerid, -monz);
		}
		if(charitysmsg[playerid] != 1)
		{
			if(charitys[playerid] == 5)
			{
			    SendClientMessage(playerid, COLOR_GREEN, "For giving so much money you get back $100");
			    GivePlayerMoney(playerid, 100);
			} else if(charitys[playerid] == 10) {
	            SendClientMessage(playerid, COLOR_GREEN, "For giving so much money you get body armour (rare)");
	            SetPlayerArmour(playerid, 100);
			} else if(charitys[playerid] == 20) {
			    SendClientMessage(playerid, COLOR_GREEN, "For giving so much money you get back $750");
			    GivePlayerMoney(playerid, 750);
			} else if(charitys[playerid] == 35) {
			    SendClientMessage(playerid, COLOR_GREEN, "For giving so much money you get health and $1000");
			    SetPlayerHealth(playerid, 100);
	            GivePlayerMoney(playerid, 1000);
	            charitysmsg[playerid] = 1;
			}
		} else {
		    SendClientMessage(playerid, COLOR_GREEN, "You've given a lot but we don't have that many prizes!");
		}
	    return 1;
	}
/*	if(strcmp(cmd, "/buycar", true)==0)
	{
	    new string[256];
	    new vi = GetPlayerVehicleID(playerid);
	    if(PLAYERLIST_authed[playerid])
	    {
			if(IsPlayerInAnyVehicle(playerid))
			{
			    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			    {
			        if(dUserINT(PlayerName(playerid)).("car") != -1)
			        {
			            if(GetPlayerMoney(playerid) >= carprice[vi])
			            {
					    	dUserSetINT(PlayerName(playerid)).("car",GetPlayerVehicleID(playerid));
					    	owned2 = GetPlayerVehicleID(playerid);
					    	owned = owned2;
							new File:ftw=fopen("ownedcars.txt", io_append);
							format(string, sizeof(string),"%d\r\n", GetPlayerVehicleID(playerid));
							fwrite(ftw, string);
							fclose(ftw);
					    	GetPlayerName(playerid,giveplayer,sizeof(giveplayer));
					    	format(string,sizeof(string),"You have just bought a new %s for $%d!",vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400],carprice[vi]);
					    	SendClientMessage(playerid, COLOR_GREEN2, string);
					    	GivePlayerMoney(playerid, -carprice[vi]);
					    	return 1;
				    	} else {
				    	    format(string,sizeof(string),"This %s costs %d, you don't have enough cash!",vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400],carprice[vi]);
				    	    SendClientMessage(playerid, COLOR_RED, string);
				    	}
					} else {
					    SendClientMessage(playerid, COLOR_RED, "Please sell your car (/sellcar) before buying another");
					}
				} else {
				    SendClientMessage(playerid, COLOR_RED, "You need to be the driver to buy a car");
				}
			} else {
			    SendClientMessage(playerid, COLOR_RED, "Your not in a car!");
			}
		} else {
		    SendClientMessage(playerid, COLOR_RED, "You need to be logged into to buy a car!");
		}
		return 1;
	}*/
	if(strcmp(cmd, "/race", true,5)==0)
	{
		ShowMenuForPlayer(race,playerid);
		return 1;
    }
	if(strcmp(cmd, "/rules", true,6)==0)
	{
		TextDrawShowForPlayer(playerid, rules1);
		TextDrawShowForPlayer(playerid, rules2);
		TextDrawShowForPlayer(playerid, rules3);
		TextDrawShowForPlayer(playerid, rules4);
		TextDrawShowForPlayer(playerid, rules5);
		TextDrawShowForPlayer(playerid, rules6);
		TextDrawShowForPlayer(playerid, rules7);
		return 1;
    }
	if(strcmp(cmd, "/hide", true,5)==0)
	{
		TextDrawHideForPlayer(playerid, rules1);
		TextDrawHideForPlayer(playerid, rules2);
		TextDrawHideForPlayer(playerid, rules3);
		TextDrawHideForPlayer(playerid, rules4);
		TextDrawHideForPlayer(playerid, rules5);
		TextDrawHideForPlayer(playerid, rules6);
		TextDrawHideForPlayer(playerid, rules7);
		return 1;
    }
	if(strcmp(cmd, "/setooc", true,7)==0)
	{
	    if(gTeam[playerid] == ADMIN)
	    {
	        if(ooc == 1)
	        {
	            ooc = 0;
	            SendClientMessageToAll(COLOR_GREEN2, "OOC chat has been disabled!");
	            SendClientMessage(playerid,COLOR_GREEN,"Use /setooc again to enable OOC");
			} else if(ooc == 0) {
			    ooc = 1;
			    SendClientMessageToAll(COLOR_GREEN2, "OOC chat has been enabled!");
			    SendClientMessage(playerid,COLOR_GREEN,"Use /setooc again to disable OOC");
			}
	    }
	    return 1;
	}
	if(strcmp(cmd, "/shout", true, 6)==0 || strcmp(cmd, "/s", true, 2)==0)
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
		if(!strlen((result)))
		{
		    SendClientMessage(playerid,COLOR_GREEN, "USAGE: /(s)hout [message]");
		} else {
			new string[256];
			GetPlayerName(playerid,giveplayer,sizeof(giveplayer));
			format(string,sizeof(string),"%s Shouts: %s!",giveplayer, (result));
			SendClientMessageToAll(GetPlayerColor(playerid),string);
		}
		return 1;
	}
	if(strcmp(cmd, "/adminzone", true,10)==0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			SetPlayerPos(playerid,-687.5140,938.2495,13.6328);
		}
		return 1;
	}
	if(strcmp(cmd, "/advert", true,7)==0 || strcmp(cmd, "/ad", true,3)==0 || strcmp(cmd, "/advertise", true,10)==0)
	{
		new aprice;
		new string[256];
		new newlength;
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
		newlength = length - 8;
		aprice = newlength * 5;
		if(!strlen((result)))
		{
		    SendClientMessage(playerid,COLOR_GREEN, "USAGE: /((ad)vert)ise [message]");
		} else {
			if(GetPlayerMoney(playerid) > aprice)
			{
			    if(count10 <= 0)
			    {
					new name[MAX_PLAYER_NAME];
					GetPlayerName(playerid, name, sizeof(name));
					format(string,sizeof(string), "Advert by %s: %s (Phone: %d)", name, (result), dUserINT(PlayerName(giveplayerid)).("phonenbr"));
					SendClientMessageToAll(COLOR_BLUEGRAY, string);
					format(string,sizeof(string), "~n~~n~~n~~n~~n~~n~~g~Advert Length: ~r~%d~g~, You paid: ~r~$%d",newlength, aprice);
					GameTextForPlayer(playerid, string, 4000, 5);
					GivePlayerMoney(playerid, -aprice);
					count10 = 60;
					count10t = SetTimer("AdvertCount",1000,1);
				} else {
				    format(string,sizeof(string), "Please wait %d seconds before making another advertisment", count10);
				    SendClientMessage(playerid, COLOR_RED, string);
				}
			} else {
				format(string,sizeof(string), "Advert Length: %d, Price: $%d, you don't have enough money!",newlength, aprice);
				SendClientMessage(playerid, COLOR_WHITE, string);
			}
		}
		return 1;
    }
	if(strcmp(cmd, "/gang", true,5) == 0) {
		new string[256];
	    new gangcmd, gangnum;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create/join/invite/quit] [name/number]");
			return 1;
		}
  		giveplayerid = ReturnUser(tmp);

		if(strcmp(tmp, "create", true)==0)
		    gangcmd = 1;
		else if(strcmp(tmp, "invite", true)==0)
		    gangcmd = 2;
		else if(strcmp(tmp, "join", true)==0)
		    gangcmd = 3;
		else if(strcmp(tmp, "quit", true)==0)
		    gangcmd = 4;

		tmp = strtok(cmdtext, idx);
		if(gangcmd < 3 && !strlen(tmp)) {
		    if(gangcmd==0)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create/join/invite/quit] [name/number]");
			else if(gangcmd==1)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [create] [name]");
			else if(gangcmd==2)
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gang [invite] [playerID]");
			return 1;
		}

		//Create Gang//
		if(gangcmd==1) {
		    if(playerGang[playerid]>0) {
				SendClientMessage(playerid, COLOR_RED, "You are already in a gang!");
				return 1;
		    }

			for(new i = 1; i < MAX_GANGS; i++) {
				if(gangInfo[i][0]==0) {
				    //name gang
					format(gangNames[i], MAX_GANG_NAME, "%s", tmp);
					//Gang exists
					gangInfo[i][0]=1;
					//There is one member
					gangInfo[i][1]=1;
					//Gang color is player's color
					gangInfo[i][2]=playerColors[playerid];

					//Player is the first gang member
					gangMembers[i][0] = playerid;
					format(string, sizeof(string),"You have created the gang '%s' (id: %d)", gangNames[i], i);
					SendClientMessage(playerid, COLOR_GREEN, string);

					playerGang[playerid]=i;

					return 1;
				}
			}

			return 1;

		//Join Gang//
		} else if (gangcmd==3) {
	 		gangnum = gangInvite[playerid];

		    if(playerGang[playerid]>0) {
				SendClientMessage(playerid, COLOR_RED, "You are already in a gang!");
				return 1;
		    }
	 		if(gangInvite[playerid]==0) {
				SendClientMessage(playerid, COLOR_RED, "You have not been invited to a gang.");
				return 1;
			}
			if(gangInfo[gangnum][0]==0) {
				SendClientMessage(playerid, COLOR_RED, "That gang does not exist!");
				return 1;
			}

			if(gangInfo[gangnum][1] < MAX_GANG_MEMBERS) {
			    new i = gangInfo[gangnum][1];

				gangInvite[playerid]=0;

				gangMembers[gangnum][i] = playerid;

			    GetPlayerName(playerid, sendername, MAX_PLAYER_NAME);
				for(new j = 0; j < gangInfo[gangnum][1]; j++) {
					format(string, sizeof(string),"%s has joined your gang.", sendername);
					SendClientMessage(gangMembers[gangnum][j], COLOR_ORANGE, string);
				}

				gangInfo[gangnum][1]++;
				playerGang[playerid] = gangnum;

				SetPlayerColor(playerid,COLOR_GRAY2);

				format(string, sizeof(string),"You have joined the gang '%s' (id: %d)", gangNames[gangnum], gangnum);
				SendClientMessage(playerid, COLOR_GREEN, string);

				return 1;
			}

			SendClientMessage(playerid, COLOR_RED, "That gang is full.");
			return 1;

		//Invite to Gang//
		} else if (gangcmd==2) {
	 		giveplayerid = ReturnUser(tmp);

			if(playerGang[playerid]==0) {
				SendClientMessage(playerid, COLOR_RED, "You are not in a gang!");
				return 1;
			}
//			if(gangMembers[playerGang[playerid]][0]!=playerid) {
//				SendClientMessage(playerid, COLOR_RED, "You need to be the gang leader to send an invite.");
//				return 1;
//			}
			if(IsPlayerConnected(giveplayerid)) {
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));

				format(string, sizeof(string),"You have sent a gang invite to %s.", giveplayer);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string),"You have recieved a gang invite from %s to '%s' (id: %d)", sendername, gangNames[playerGang[playerid]],playerGang[playerid]);
				SendClientMessage(giveplayerid, COLOR_GREEN, string);

				gangInvite[giveplayerid]=playerGang[playerid];

			} else
				SendClientMessage(playerid, COLOR_RED, "No such player exists!");

		//Leave Gang//
		} else if (gangcmd==4) {
		    PlayerLeaveGang(playerid);
		}

		return 1;
	}

	//------------------- /ganginfo

	if(strcmp(cmd, "/ganginfo", true,9) == 0) {
	    new gangnum;
	    new string[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp) && playerGang[playerid]==0) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ganginfo [number]");
			return 1;
		} else if (!strlen(tmp))
			gangnum = playerGang[playerid];
		else
			gangnum = strval(tmp);

		if(gangInfo[gangnum][0]==0) {
			SendClientMessage(playerid, COLOR_RED, "No such gang exists!");
			return 1;
		}
		format(string, sizeof(string),"'%s' Gang Members (id: %d)", gangNames[gangnum], gangnum);
		SendClientMessage(playerid, COLOR_GREEN, string);

		for(new i = 0; i < gangInfo[gangnum][1]; i++) {
			GetPlayerName(gangMembers[gangnum][i], giveplayer, sizeof(giveplayer));
			format(string, sizeof(string),"%s (%d)", giveplayer, gangMembers[gangnum][i]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}

	//------------------- /gangs

	if(strcmp(cmd, "/gangs", true,6) == 0)
	{
	    new string[256];
		new x;

		SendClientMessage(playerid, COLOR_GREEN, "Current Gangs:");
	    for(new i=0; i < MAX_GANGS; i++) {
			if(gangInfo[i][0]==1) {
				format(string, sizeof(string), "%s%s(%d) - %d members", string,gangNames[i],i,gangInfo[i][1]);

				x++;
				if(x > 2) {
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    x = 0;
					format(string, sizeof(string), "");
				} else {
					format(string, sizeof(string), "%s, ", string);
				}
			}
		}

		if(x <= 2 && x > 0) {
			string[strlen(string)-2] = '.';
		    SendClientMessage(playerid, COLOR_YELLOW, string);
		}

		return 1;
	}
	if(strcmp(cmd, "/me", true, 3)==0)
	{
		if (!strlen(cmdtext[5]))
		{
		    SendClientMessage(playerid, COLOR_WHITE, "USAGE: /me [action]");
		} else {
			new str[256], pname[256]; GetPlayerName(playerid, pname, 256);
			format(str, 256, "** %s %s", pname, cmdtext[4]);
			SendClientMessageToAll(COLOR_TRUEPINK, str);
		}
		return 1;
	}
	if(strcmp(cmd, "/announce", true, 9)==0)
	{
	    if(gTeam[playerid] == MAYOR || gTeam[playerid] == ADMIN)
	    {
			new str[256];
			format(str, 256, "%s", cmdtext[10]);
			GameTextForAll(str, 4500, 3);
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Mayors and Admins can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd,"/ocmds2", true,7) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "======Other Commands pg. 2=====");
		SendClientMessage(playerid, COLOR_GREEN, "PHONE: /call, /pickup, /t, /hangup");
		SendClientMessage(playerid, COLOR_GREEN, "RACE: /race, /leaverace");
		SendClientMessage(playerid, COLOR_GREEN, "BANK: /withdraw, /deposit, /balance");
		SendClientMessage(playerid, COLOR_GREEN, "FOOD: /eat, /fishhelp");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/ocmds", cmd, true,6) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=========Other Commands========");
		SendClientMessage(playerid, COLOR_GREEN, "GENERAL: /RULES, /me, /licenses, /buy, /credits, /lock, /unlock, /service");
		SendClientMessage(playerid, COLOR_GREEN, "GENERAL: /lotto, /time, /bug, /report (Goes to admins), /callcops (Goes to cops)");
        SendClientMessage(playerid, COLOR_GREEN, "GENERAL: /((ad)vert)ise, /givecash, /admins, /charity");
		SendClientMessage(playerid, COLOR_GREEN, "CARS: /lock, /unlock, /kickout");
		SendClientMessage(playerid, COLOR_GREEN, "HOME: /showhouses, /hidehouses");
		SendClientMessage(playerid, COLOR_GREEN, "CHAT: /shout, /(o)oc");
		SendClientMessage(playerid, COLOR_GRAY, "==========Now /ocmds2=========");
		return 1;
	}
	if(strcmp(cmd, "/o", true, 2)==0 || strcmp(cmd, "/ooc", true, 4)==0)
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
	    new string[256];
        GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
		if(!strlen((result)))
		{
		    return SendClientMessage(playerid,COLOR_GREEN, "USAGE: /(o)oc [message]");
		} else if(ooc == 1)
		{
	        format(string,sizeof(string),"%s [OOC]: %s",giveplayer,(result));
	        SendClientMessageToAll(COLOR_AQUA,string);
        } else {
            SendClientMessageToAll(BANRED,"OOC is disabled");
        }
		return 1;
	}
	if(strcmp(cmd, "/getip", true,6)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /getip [id/name]");
		}
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
			    new string[256];
				GetPlayerIp(giveplayerid, ip, sizeof(ip));
				format(string, sizeof(string), "%s's IP: %s", giveplayer, ip);
				SendClientMessage(playerid, COLOR_WHITE, string);
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/isolate", true,8)==0)
	{
	    new string[256];
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
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
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /isolate [id/name] [reason]");
		}
		if(!strlen(result))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /isolate [id/name] [reason]");
		}
		if(gTeam[giveplayerid] == ADMIN || gTeam[giveplayerid] == MAYOR)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(gTeam[giveplayerid] != ADMIN || gTeam[giveplayerid] != MAYOR)
		        {
			        if(isolated[giveplayerid] == 0)
			        {
					    isolated[giveplayerid] = 1;
						format(string, sizeof(string), "You isolated %s for: %s", giveplayer, result);
						SendClientMessage(playerid,COLOR_RED,"/isolate again to un-isolate");
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string,sizeof(string),"You were isolated by %s for reason: %s",sendername, result);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						SetPlayerPos(giveplayerid, 4223.0176,1293.5487,189.8703+4);
						dfs[giveplayerid] = 2;
					} else if(isolated[giveplayerid] == 1) {
					    isolated[giveplayerid] = 0;
						format(string, sizeof(string), "You un-isolated %s", giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
						format(string,sizeof(string),"You were un-isolated by %s",sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						SetPlayerHealth(giveplayerid, 0);
						dfs[giveplayerid] = 0;
					}
				} else {
			    	SendClientMessage(playerid, BANRED, "You can't isolate admins or the mayor");
				}
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/freeze", true,7)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /freeze [id/name]");
		}
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
			    new string[256];
				TogglePlayerControllable(giveplayerid, false);
				format(string, sizeof(string), "You froze %s", giveplayer);
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string,sizeof(string),"You were frozen by %s",sendername);
				SendClientMessage(giveplayerid, COLOR_WHITE, string);
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/unfreeze", true,9)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /unfreeze [id/name]");
		}
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
			    new string[256];
				TogglePlayerControllable(giveplayerid, true);
				format(string, sizeof(string), "You un-froze %s", giveplayer);
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string,sizeof(string),"You were un-frozen by %s",sendername);
				SendClientMessage(giveplayerid, COLOR_WHITE, string);
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/goto", true,5)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		new Float:x, Float:y, Float:z;
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /goto [id/name]");
		}
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
			    new string[256];
				format(string, sizeof(string), "You teleported to %s", giveplayer);
				SendClientMessage(playerid, COLOR_GREEN2, string);
				if(gTeam[playerid] == ADMIN) {
				    GetPlayerPos(giveplayerid, x,y,z);
				    SetPlayerPos(playerid, x,y,z+3);
					format(string,sizeof(string),"Admin %s teleported to your location",sendername);
					SendClientMessage(giveplayerid, COLOR_GREEN2, string);
				} else if(gTeam[playerid] == MAYOR) {
	   				GetPlayerPos(giveplayerid, x,y,z);
				    SetPlayerPos(playerid, x,y,z+3);
					format(string,sizeof(string),"Mayor %s teleported to your location",sendername);
					SendClientMessage(giveplayerid, COLOR_GREEN2, string);
				}
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/bring", true,6)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		new Float:x, Float:y, Float:z;
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bring [id/name]");
		}
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
			    new string[256];
				format(string, sizeof(string), "You brought %s to your location", PlayerName(giveplayerid));
				SendClientMessage(playerid, COLOR_GREEN2, string);
				if(gTeam[playerid] == ADMIN) {
				    GetPlayerPos(playerid, x,y,z);
				    SetPlayerPos(giveplayerid, x,y,z+3);
					format(string,sizeof(string),"Admin %s teleported you to their location",sendername);
					SendClientMessage(giveplayerid, COLOR_GREEN2, string);
				} else if(gTeam[playerid] == MAYOR) {
	   				GetPlayerPos(playerid, x,y,z);
				    SetPlayerPos(giveplayerid, x,y,z+3);
					format(string,sizeof(string),"Mayor %s teleported you to their location",sendername);
					SendClientMessage(giveplayerid, COLOR_GREEN2, string);
				}
			} else {
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/gmx",true,4)==0)
	{
		if(gTeam[playerid] == ADMIN)
		{
		    GameModeExit();
		} else {
			SendClientMessage(playerid, BANRED, "Only Admins can use this command!");
		}
	    return 1;
	}
	if(strcmp(cmd, "/kickout", true,8)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kickout [id/name]");
		}
		if(IsPlayerConnected(giveplayerid)) {
			if(IsPlayerInAnyVehicle(playerid))
			{
			    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			    {
				    if(IsPlayerInVehicle(giveplayerid,GetPlayerVehicleID(playerid)))
				    {
						new string[256];
				       	GetPlayerName(playerid, sendername, sizeof(sendername));
				       	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				       	format(string, sizeof(string), "** You kicked %s out of your car",giveplayer);
				       	SendClientMessage(playerid, COLOR_GREEN2, string);
				       	format(string, sizeof(string), "** %s kicked you out of his car",sendername);
				       	SendClientMessage(giveplayerid, COLOR_GREEN2, string);
						RemovePlayerFromVehicle(giveplayerid);
					} else {
						SendClientMessage(playerid, COLOR_WHITE, "That player isn't in your vehicle");
					}
				} else {
				    SendClientMessage(playerid, COLOR_YELLOW, "Your are not the driver!");
				}
			} else {
				SendClientMessage(playerid, COLOR_YELLOW, "Your not even in a car!");
			}
		} else {
  			SendClientMessage(playerid, BANRED, "No such player");
		}
		return 1;
	}
	if(strcmp(cmd, "/admins", true,7)==0)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "** Admins Online:");
    	for(new i = 0; i < MAX_PLAYERS; i++)
     	{
     	    if(gTeam[i] == ADMIN)
     	    {
	     		if(IsPlayerConnected(i))
	     		{
	     		    if(invis[i] != 1)
	     		    {
			 		    new string[256];
				     	GetPlayerName(i, sendername, sizeof(sendername));
				     	format(string, sizeof(string), "%s", sendername);
				     	SendClientMessage(playerid, COLOR_GREEN2, string);
			     	}
				}
			}
		}
	    return 1;
	}
	if(strcmp(cmd, "/invisible", true,10)==0)
	{
	    if(gTeam[playerid] == ADMIN)
	    {
			SendClientMessage(playerid, COLOR_GREEN, "You are now invisible for anyone who does /admins");
		}
	    return 1;
	}
	if(strcmp(cmd, "/givecash", true,9)==0)
	{
	    new tmp2[256];
		tmp = strtok(cmdtext, idx);
		tmp2 = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		new mon = strval(tmp2);
		if(!strlen(tmp))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [id/name] [cash]");
		}
		if(!strlen(tmp2))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givecash [id/name] [cash]");
		} else if(IsPlayerConnected(giveplayerid)) {
			if(GetPlayerMoney(playerid) >= mon)
			{
			    if(giveplayerid != playerid)
			    {
					GivePlayerMoney(giveplayerid, mon);
					GivePlayerMoney(playerid, -mon);
					new string[256];
				   	GetPlayerName(playerid, sendername, sizeof(sendername));
				   	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				   	format(string, sizeof(string), "** You sent %s $%d",giveplayer,mon);
				   	SendClientMessage(playerid, COLOR_GREEN2, string);
				   	format(string, sizeof(string), "** %s sent you $%d",sendername, mon);
				   	SendClientMessage(giveplayerid, COLOR_GREEN2, string);
				} else {
				    SendClientMessage(playerid, BANRED, "It doesn't make sense to send yourself your own money!");
				}
			} else {
				SendClientMessage(playerid, BANRED, "You don't have that much money to send!");
			}
		} else {
  			SendClientMessage(playerid, BANRED, "No such player");
		}
		return 1;
	}
	if(strcmp(cmd, "/exit", true,5)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    if(Petrol[GetPlayerVehicleID(playerid)] == 0)
		    {
			    TogglePlayerControllable(playerid,true);
				RemovePlayerFromVehicle(playerid);
			} else {
				SendClientMessage(playerid, BANRED, "Your gas tank still has fuel in it");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "Your not in a car");
		}
	    return 1;
	}
	if(strcmp(cmd, "/explode", true,8)==0)
	{
	    new tmp2[256];
		tmp = strtok(cmdtext, idx);
		tmp2 = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		new type = strval(tmp2);
	    if(IsPlayerAdmin(playerid))
	    {
			if(!strlen(tmp))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /explode [id/name] [type]");
			}
			if(!strlen(tmp2))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /explode [id/name] [type]");
			} else if(IsPlayerConnected(giveplayerid)) {
				new Float:x, Float:y, Float:z;
			    GetPlayerPos(giveplayerid, x,y,z);
				CreateExplosion(x,y,z,type,0);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/service", true,8)==0)
	{
	    new serv[256];
		serv = strtok(cmdtext, idx);
		new string[256];
		if(!strlen(serv))
		{
			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /service [taxi, bus, mechanic, medic]");
		}
		if(strcmp(serv, "taxi", true)==0)
		{
		    if(taxipl > 0)
		    {
			    format(string,sizeof(string), "%s is in need of a taxi (/acceptcall)",PlayerName(playerid));
			    SendClientMessageToTeam(TAXI, COLOR_LIGHTBLUE, string);
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, "You called for a taxi");
			    needstaxi = playerid;
			} else {
			    SendClientMessage(playerid, BANRED, "No taxi drivers online");
			}
		} else if(strcmp(serv, "bus", true)==0)
		{
		    if(buspl > 0)
		    {
			    format(string,sizeof(string), "%s is in need of a bus (/acceptcall)",PlayerName(playerid));
			    SendClientMessageToTeam(BUS, COLOR_LIGHTBLUE, string);
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, "You called for a bus");
			    needsbus = playerid;
			} else {
			    SendClientMessage(playerid, BANRED, "No bus drivers online");
			}
		} else if(strcmp(serv, "mechanic", true)==0)
		{
		    if(mechpl > 0)
		    {
			    format(string,sizeof(string), "%s is in need of a mechanic (/acceptcall)",PlayerName(playerid));
			    SendClientMessageToTeam(MECHANIC, COLOR_LIGHTBLUE, string);
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, "You called for a mechanic");
			    needsmech = playerid;
			} else {
			    SendClientMessage(playerid, BANRED, "No mechanics online");
			}
		} else if(strcmp(serv, "medic", true)==0)
		{
		    if(medpl > 0)
		    {
			    format(string,sizeof(string), "%s is in need of a medic (/acceptcall)",PlayerName(playerid));
			    SendClientMessageToTeam(MEDIC, COLOR_LIGHTBLUE, string);
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, "You called for a medic");
			    needsmedic = playerid;
			} else {
			    SendClientMessage(playerid, BANRED, "No medics online, find somewhere to eat!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/acceptcall", true,11)==0)
	{
	    new Float:x, Float:y, Float:z;
	    if(gTeam[playerid] == TAXI)
	    {
			if(needstaxi < 999)
			{
				if(IsPlayerConnected(needstaxi))
				{
				    new string[256];
    				GetPlayerName(playerid, sendername, sizeof(sendername));
       				GetPlayerName(needstaxi, giveplayer, sizeof(giveplayer));
	               	format(string, sizeof(string), "** You accpted %s's call for a taxi, drive to the checkpoint",giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
     				format(string, sizeof(string), "** Taxi driver %s has accepted your call for a taxi, don't leave this area!",sendername);
					SendClientMessage(needstaxi, COLOR_LIGHTBLUE, string);
					GetPlayerPos(needstaxi, x,y,z);
					SetPlayerCheckpoint(playerid, x,y,z, 4);
					needstaxi = 999;
				}
			}
		} else if(gTeam[playerid] == BUS)
	    {
			if(needsbus < 999)
			{
				if(IsPlayerConnected(needsbus))
				{
				    new string[256];
    				GetPlayerName(playerid, sendername, sizeof(sendername));
       				GetPlayerName(needsbus, giveplayer, sizeof(giveplayer));
	               	format(string, sizeof(string), "** You accpted %s's call for a bus, drive to the checkpoint",giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
     				format(string, sizeof(string), "** Bus driver %s has accepted your call for a bus, don't leave this area!",sendername);
					SendClientMessage(needsbus, COLOR_LIGHTBLUE, string);
					GetPlayerPos(needsbus, x,y,z);
					SetPlayerCheckpoint(playerid, x,y,z, 4);
					needsbus = 999;
				}
			}
		} else if(gTeam[playerid] == MECHANIC)
	    {
			if(needsmech < 999)
			{
				if(IsPlayerConnected(needsmech))
				{
				    new string[256];
    				GetPlayerName(playerid, sendername, sizeof(sendername));
       				GetPlayerName(needsmech, giveplayer, sizeof(giveplayer));
	               	format(string, sizeof(string), "** You accpted %s's call for a mechanic, drive to the checkpoint",giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
     				format(string, sizeof(string), "** Mechanic %s has accepted your call for a bus, don't leave this area!",sendername);
					SendClientMessage(needsmech, COLOR_LIGHTBLUE, string);
					GetPlayerPos(needsmech, x,y,z);
					SetPlayerCheckpoint(playerid, x,y,z, 4);
					needsmech = 999;
				}
			}
		} else if(gTeam[playerid] == MEDIC)
	    {
			if(needsmedic < 999)
			{
				if(IsPlayerConnected(needsmedic))
				{
				    new string[256];
    				GetPlayerName(playerid, sendername, sizeof(sendername));
       				GetPlayerName(needsmedic, giveplayer, sizeof(giveplayer));
	               	format(string, sizeof(string), "** You accpted %s's call for a medic, drive to the checkpoint",giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
     				format(string, sizeof(string), "** Medic %s has accepted your call for a bus, don't leave this area!",sendername);
					SendClientMessage(needsmedic, COLOR_LIGHTBLUE, string);
					GetPlayerPos(needsmedic, x,y,z);
					SetPlayerCheckpoint(playerid, x,y,z, 4);
					needsmedic = 999;
				}
			}
		}
	    return 1;
	}
	if(strcmp(cmd, "/unmute", true,7)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
	    if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
	    {
			if(!strlen(tmp))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /unmute [id/name]");
			} else if(IsPlayerConnected(giveplayerid)) {
				muted[giveplayerid] = 0;
				new string[256];
			   	GetPlayerName(playerid, sendername, sizeof(sendername));
			   	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			   	format(string, sizeof(string), "** You un-muted %s",giveplayer);
			   	SendClientMessage(playerid, COLOR_RED, string);
			   	format(string, sizeof(string), "** %s un-muted you",sendername);
			   	SendClientMessage(giveplayerid, COLOR_RED, string);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/mute", true,5)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
	    if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
	    {
			if(!strlen(tmp))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /mute [id/name]");
			} else if(IsPlayerConnected(giveplayerid)) {
				muted[giveplayerid] = 1;
				new string[256];
			   	GetPlayerName(playerid, sendername, sizeof(sendername));
			   	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			   	format(string, sizeof(string), "** You muted %s",giveplayer);
			   	SendClientMessage(playerid, COLOR_RED, string);
			   	format(string, sizeof(string), "** %s muted you",sendername);
			   	SendClientMessage(giveplayerid, COLOR_RED, string);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
			SendClientMessage(playerid, COLOR_WHITE, "Only Admins and Mayors can use this command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/time", true,5)==0)
	{
		new hour,minute,second;
		new month, day, year;
		gettime(hour,minute,second);
		getdate(year,month,day);
		if (minute <= 9)
		{
			format(strm,sizeof(strm),"~p~World Time: ~w~%d:%d~n~~w~Todays Date: ~p~%d/%d/%d",hour,minute,month,day,year);
			GameTextForPlayer(playerid, strm, 3500, 3);
		} else {
			format(strm,sizeof(strm),"~p~World Time: ~w~%d:%d~n~~w~Todays Date: ~p~%d/%d/%d",hour,minute,month,day,year);
			GameTextForPlayer(playerid, strm, 3500, 3);
		}
		return 1;
	}
	if(strcmp(cmd, "/heal", true,5)==0)
	{
	    new tmp2[256];
		tmp = strtok(cmdtext, idx);
		tmp2 = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		new healamt = strval(tmp2);
		if(IsPlayerAdmin(playerid))
		{
			if(!strlen(tmp))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /heal [id/name] [amount]");
			}
			if(!strlen(tmp2))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /heal [id/name] [amount]");
			} else if(IsPlayerConnected(giveplayerid)) {
				SetPlayerHealth(giveplayerid, healamt);
				new string[256];
				format(string, sizeof(string), "You were healed with %d life", healamt);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/kick", true,5)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
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
			if(!strlen(tmp))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [id/name] [reason]");
			}
			if(!strlen((result)))
			{
                return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [id/name] [reason]");
			} else if(IsPlayerConnected(giveplayerid)) {
			    new name[32], names[32];
			    GetPlayerName(giveplayerid, name, MAX_PLAYER_NAME);
			    GetPlayerName(playerid, names, MAX_PLAYER_NAME);
			    new string[256];
				format(string,sizeof(string), "%s was kicked by %s, Reason: %s", name, names, (result));
				SendClientMessageToAll(COLOR_YELLOW, string);
				new File:ftw=fopen("kicksbans.txt", io_append);
				format(string, sizeof(string), "Player was kicked:\r\nKicker Name: %s\r\nKicked Player: %s\r\nReason: %s\r\n\r\n", names, name, (result));
				fwrite(ftw, string);
				fclose(ftw);
				Kick(giveplayerid);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You are not a mayor or admin");
		}
		return 1;
	}
	if(strcmp(cmd, "/ban", true,4)==0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		if(gTeam[playerid] == ADMIN || gTeam[playerid] == MAYOR)
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
			if(!strlen(tmp))
			{
	  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /ban [id/name]");
			}
			if(!strlen((result)))
			{
                return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kick [id/name] [reason]");
			} else if(IsPlayerConnected(giveplayerid)) {
			    new name[32], names[32];
			    GetPlayerName(giveplayerid, name, MAX_PLAYER_NAME);
			    GetPlayerName(playerid, names, MAX_PLAYER_NAME);
			    new string[256];
				format(string,sizeof(string), "%s was banned by %s, Reason: %s", name, names, (result));
				SendClientMessageToAll(COLOR_YELLOW, string);
				new File:ftw=fopen("kicksbans.txt", io_append);
				format(string, sizeof(string), "Player was banned:\r\nBanner Name: %s\r\nBanned Player: %s\r\nReason: %s\r\n\r\n", names, name, (result));
				fwrite(ftw, string);
				fclose(ftw);
				Ban(giveplayerid);
			} else {
				SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You are not a mayor or admin");
		}
		return 1;
	}
	if(strcmp(cmd, "/fare", true,5)==0)
	{
	    new fp[MAX_PLAYERS];
		tmp = strtok(cmdtext, idx);
		fp[playerid] = strval(tmp);
		if(!strlen(tmp))
		{
  			return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /fare [amount]");
		}
		if(fp[playerid] < 1 || fp[playerid] > 900)
		{
			return SendClientMessage(playerid, BANRED, "Price can not be lower than 1, cannot be higher than 900");
		} else if(onbreak[playerid] == 0) {
			if(gTeam[playerid] == TAXI)
			{
				new string[256];
				format(string, sizeof(string), "Taxi driver %s change his/her fare price to $%d", PlayerName(playerid), fp[playerid]);
				SendClientMessageToAll(COLOR_GREEN2, string);
				fare2[playerid] = fp[playerid];
			} else if(gTeam[playerid] == BUS) {
				new string[256];
				format(string, sizeof(string), "Bus driver %s change his/her fare price to $%d", PlayerName(playerid), fp[playerid]);
				SendClientMessageToAll(COLOR_GREEN2, string);
				fare2[playerid] = fp[playerid];
			}
		} else {
  			SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
		}
		return 1;
	}
	if(strcmp(cmd, "/showhouses", true,11)==0)
	{
	    micons[playerid] = 1;
		SetPlayerMapIcon(playerid, 4, 2071.778076,775.543884,11.460479, 31, ORANGE);
		SetPlayerMapIcon(playerid, 5, 2120.344726,694.703186,11.453125, 31, ORANGE);
		SetPlayerMapIcon(playerid, 6, 2368.572021,691.480468,11.460479, 31, ORANGE);
		SetPlayerMapIcon(playerid, 7, 987.133117,1901.092163,11.460937, 31, ORANGE);
		SetPlayerMapIcon(playerid, 8, 1029.106811,2027.907714,11.468292, 31, ORANGE);
		SetPlayerMapIcon(playerid, 9, 1366.843994,1974.346191,11.460937, 31, ORANGE);
		SetPlayerMapIcon(playerid, 10, 1638.706298,2102.745605,11.312500, 31, ORANGE);
		SetPlayerMapIcon(playerid, 11, 2787.852050,2223.247802,14.661463, 31, ORANGE);
		SetPlayerMapIcon(playerid, 12, 1998.667724,2722.740478,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 13, 2039.785400,2765.142822,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 14, 1580.068359,2709.808593,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 15, 1618.676269,2608.815917,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 16, 1344.788574,2607.788330,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 17, 1314.742797,2524.445068,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 18, 986.971496,2314.180419,11.460937, 31, ORANGE);
		SetPlayerMapIcon(playerid, 19, 2620.253662,719.489807,14.739588, 31, ORANGE);
		SetPlayerMapIcon(playerid, 20, 2236.159912,1285.743652,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 21, 1967.761108,1622.717895,12.865352, 31, ORANGE);
		SetPlayerMapIcon(playerid, 22, 2223.337890,1837.676757,10.820312, 31, ORANGE);
		SetPlayerMapIcon(playerid, 23, 2020.692626,1919.791259,12.340622, 31, ORANGE);
		SendClientMessage(playerid,COLOR_CA, "Use /hidehouses to hide the map icons");
		return 1;
	}
	if(strcmp(cmd, "/hidehouses", true,11)==0)
	{
	    if(micons[playerid] == 1)
	    {
	    	RemovePlayerMapIcon(playerid, 4);
	    	RemovePlayerMapIcon(playerid, 5);
	    	RemovePlayerMapIcon(playerid, 6);
	    	RemovePlayerMapIcon(playerid, 7);
	    	RemovePlayerMapIcon(playerid, 8);
	    	RemovePlayerMapIcon(playerid, 9);
	    	RemovePlayerMapIcon(playerid, 10);
	    	RemovePlayerMapIcon(playerid, 11);
	    	RemovePlayerMapIcon(playerid, 12);
	    	RemovePlayerMapIcon(playerid, 13);
	    	RemovePlayerMapIcon(playerid, 14);
	    	RemovePlayerMapIcon(playerid, 15);
	    	RemovePlayerMapIcon(playerid, 16);
	    	RemovePlayerMapIcon(playerid, 17);
	    	RemovePlayerMapIcon(playerid, 18);
	    	RemovePlayerMapIcon(playerid, 19);
	    	RemovePlayerMapIcon(playerid, 20);
	    	RemovePlayerMapIcon(playerid, 21);
	    	RemovePlayerMapIcon(playerid, 22);
	    	RemovePlayerMapIcon(playerid, 23);
	    } else {
		SendClientMessage(playerid,COLOR_CA, "Use /showhouses to show all houses (including bought houses)");
		}
		return 1;
	}
	if(strcmp(cmd, "/credits", true,8)==0)
	{
		SendClientMessage(playerid,COLOR_GRAY, "===============Credits==============");
		SendClientMessage(playerid,COLOR_CA, "ScaRPG GameMode: Made, v0.1");
		SendClientMessage(playerid,COLOR_CA, "ScaRPG FS: Made, v0.1");
		SendClientMessage(playerid,COLOR_CA, "Lottery FS: Made by Grove, v0.3");
		SendClientMessage(playerid,COLOR_CA, "KIHC: Made by Kapil, vPro");
		SendClientMessage(playerid,COLOR_GRAY, "===================================");
		return 1;
	}
	if(strcmp(cmd, "/leaverace", true,10)==0)
	{
		DisablePlayerRaceCheckpoint(playerid);
		SetPlayerPos(playerid,1680.3296,1447.9521,10.7737);
		return 1;
	}
	if(strcmp(cmd, "/adminzone", true,10)==0)
	{
		if(gTeam[playerid] == ADMIN)
		{
			SetPlayerPos(playerid,-687.5140,938.2495,13.6328);
		}
		return 1;
	}
	if(strcmp(cmd, "/slots", true,6)==0)
	{
		if(PlayerToPoint(500, playerid,1946.2472,1018.7954,992.4688) || PlayerToPoint(500, playerid,2234.9746,1603.9456,1006.1797))
		{
		    if(GetPlayerMoney(playerid) >= 50)
		    {
		        GivePlayerMoney(playerid, - 50);
		    	new rand = random(sizeof(Slots));
		    	new rand2 = random(sizeof(Slots2));
		    	new rand3 = random(sizeof(Slots3));
		    	new rand4 = random(MAX_MONZ);
		    	new won1 = Slots[rand][0];
		    	new won2 = Slots2[rand2][0];
		    	new won3 = Slots3[rand3][0];
		    	new string[256];
		    	if(won1 == won2 && won1 == won2 && won1 == won3)
		    	{
		    		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~r~%s, ~g~%s, ~b~%s",Slots[rand][0],Slots2[rand2][0],Slots3[rand3][0]);
	       			GameTextForPlayer(playerid, string, 4000, 3);
	       			SendClientMessage(playerid, COLOR_RED, "You won 100!!!");
	       			GivePlayerMoney(playerid, rand4);
	    		} else {
		    		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~r~%s, ~g~%s, ~b~%s",Slots[rand][0],Slots2[rand2][0],Slots3[rand3][0]);
	       			GameTextForPlayer(playerid, string, 4000, 3);
	       			SendClientMessage(playerid, COLOR_RED, "You didn't win any money, try again later");
	    		}
			} else {
			    SendClientMessage(playerid, BANRED, "You need $50 to play");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You need to be at the 4 Dragons or Caligulas on The Strip");
		}
	}
	if(strcmp(cmd, "/allin", true,6)==0)
	{
	    new tmp2[256];
		tmp = strtok(cmdtext, idx);
		tmp2 = strtok(cmdtext, idx);
		new amt = strval(tmp);
		new numb = strval(tmp2);
		new rand = random(MAX_ALLS);
		if(!strval(tmp))
		{
			SendClientMessage(playerid,COLOR_GRAY, "USAGE: /allin [cash] [1-5]");
			return 1;
		}
		if(!strval(tmp2))
		{
			SendClientMessage(playerid,COLOR_GRAY, "USAGE: /allin [cash] [1-5]");
			return 1;
		} else
		if(PlayerToPoint(500, playerid,1946.2472,1018.7954,992.4688) || PlayerToPoint(500, playerid,2234.9746,1603.9456,1006.1797))
		{
		    if(GetPlayerMoney(playerid) >= amt)
		    {
			    if(rand == numb)
			    {
			        GivePlayerMoney(playerid, amt*2);
			        SendClientMessage(playerid,COLOR_RED,"Congrats! The number you chose won! Your money was doubled!");
			    } else {
	    			new string[256];
	    			format(string,sizeof(string),"Sorry, the winning number was %d. You lost $%d",rand,amt);
			        SendClientMessage(playerid, COLOR_RED, string);
			        GivePlayerMoney(playerid, - amt);
			    }
			} else {
			    SendClientMessage(playerid, BANRED, "You don't have as much money as you bet!");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You need to be at the 4 Dragons or Caligulas on The Strip");
		}
		return 1;
	}
	if (strcmp(cmd, "/bug", true) == 0)
  	{
		new TextTmp[256];
		new Float:X;
		new Float:Y;
		new Float:Z;
		new Float:PF;
		new InCar;
		new Cid;
		new tmpX[256];
		new tmpY[256];
		new tmpZ[256];
		new tmpPF[256];
		new tmpIC[256];
		new tmpCID[256];
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, PF);
		if(IsPlayerInAnyVehicle(playerid) == 1)
		{
			Cid = GetPlayerVehicleID(playerid);
			InCar = 1;
		} else {
			Cid = 0;
			InCar = 0;
		}
		format(tmpX, sizeof(tmpX), "%f", X);
		format(tmpY, sizeof(tmpY), "%f", Y);
		format(tmpZ, sizeof(tmpZ), "%f", Z);
		format(tmpPF, sizeof(tmpPF), "%f", PF);
		format(TextTmp,sizeof(TextTmp),"%s",cmdtext);
		format(tmpIC, sizeof(tmpIC), "%d", InCar);
		format(tmpCID, sizeof(tmpCID), "%d", Cid);
		new File:f=fopen("Bugs.txt",io_append);
		fwrite(f, "\r\n<< --- The Bug start--- >>\r\n");
		fwrite(f, "The Bug >>");
		fwrite(f,TextTmp);
		fwrite(f,"\r\n X pos >>");
		fwrite(f,tmpX);
		fwrite(f,"\r\n Y pos >>");
		fwrite(f,tmpY);
		fwrite(f,"\r\n Z pos >>");
		fwrite(f,tmpZ);
		fwrite(f,"\r\n Facing angle >>");
		fwrite(f,tmpZ);
		fwrite(f,"\r\n In car >>");
		fwrite(f,tmpIC);
		fwrite(f,"\r\n Car spawn ID >>");
		fwrite(f,tmpCID);
		fwrite(f, "\r\n<< --- End of Bug -- >>\r\n");
		fwrite(f, "\r\n");
		fwrite(f, "========================================================================\r\n");
		fclose(f);
		print("Bug reported and written to text file");
		SendClientMessage(playerid, COLOR_WHITE, "Your bug has been reported! Thank you!");
  		return 1;
  	}
	if(strcmp(cmd, "/lock", true,5)==0)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		    if(vlock[playerid] == 1)
		    {
				for(new i=0;i<MAX_PLAYERS;i++)
				{
					if(IsPlayerConnected(i))
					{
						SetVehicleParamsForPlayer(LastCar[playerid],i, 0, 1);
					}
				}
				lcar[playerid] = 1;
				SendClientMessage(playerid,COLOR_GRAY, "*beep beep* Car locked");

			} else {
		    SendClientMessage(playerid,COLOR_GRAY, "You haven't bought a car lock at the 24/7");
			}
		} else {
			SendClientMessage(playerid,COLOR_GRAY, "Your not in a car");
		}
		return 1;
	}
	if(strcmp(cmd, "/unlock", true,7)==0)
	{
	    if(vlock[playerid] == 1)
	    {
			for(new i=0;i<MAX_PLAYERS;i++)
			{
				if(IsPlayerConnected(i))
				{
					SetVehicleParamsForPlayer(LastCar[playerid],i, 0, 0);
				}
			}
			lcar[playerid] = 0;
			SendClientMessage(playerid,COLOR_GRAY, "*beep beep* Car un-locked");
		} else {
		    SendClientMessage(playerid,COLOR_GRAY, "You haven't bought a car lock at the 24/7");
		}
		return 1;
	}
	if(strcmp(cmd, "/deposit", true,8)==0)
	{
		tmp = strtok(cmdtext, idx);
		new amt = strval(tmp);
		if(!strval(tmp))
		{
			SendClientMessage(playerid,COLOR_GRAY, "USAGE: /deposit [amount]");
			return 1;
		}
		if(PlayerToPoint(100, playerid,-2.0628,-18.4967,1003.5494))
		{
		    if(PLAYERLIST_authed[playerid] == 1)
		    {
		        if(!(strfind(tmp, "-", true) != -1))
		        {
				    if(GetPlayerMoney(playerid) >= amt)
				    {
				        new string[256];
				        new oldmon = dUserINT(PlayerName(playerid)).("bank");
				        dUserSetINT(PlayerName(playerid)).("bank",oldmon + amt);
				        format(string,sizeof(string),"You deposited $%d dollars into your bank account!",amt);
				        SendClientMessage(playerid, COLOR_GREEN2, string);
				        GivePlayerMoney(playerid,-amt);
					} else {
						SendClientMessage(playerid,BANRED, "You don't have that much money!");
					}
				} else {
				    SendClientMessage(playerid,BANRED, "Can't deposit negatives");
				}
			} else {
			    SendClientMessage(playerid,BANRED, "Your not logged in!");
			}
		} else {
			SendClientMessage(playerid,BANRED, "You need to be at the bank!");
		}
		return 1;
	}
	if(strcmp(cmd, "/withdraw", true,9)==0)
	{
		tmp = strtok(cmdtext, idx);
		new amt = strval(tmp);
		if(!strval(tmp))
		{
			SendClientMessage(playerid,COLOR_GRAY, "USAGE: /withdraw [amount]");
			return 1;
		}
		if(PlayerToPoint(100, playerid,-2.0628,-18.4967,1003.5494))
		{
		    if(PLAYERLIST_authed[playerid] == 1)
		    {
		        if(!(strfind(tmp, "-", true) != -1))
		        {
				    if(dUserINT(PlayerName(playerid)).("bank") >= amt)
				    {
				        new oldmon = dUserINT(PlayerName(playerid)).("bank");
				        new string[256];
				        format(string,sizeof(string),"You withdrew $%d dollars from your bank account!",amt);
				        SendClientMessage(playerid, COLOR_GREEN2, string);
				        GivePlayerMoney(playerid,amt);
				        dUserSetINT(PlayerName(playerid)).("bank",oldmon - amt);
					} else {
						SendClientMessage(playerid,BANRED, "You don't have that much money in your account!");
					}
				} else {
				    SendClientMessage(playerid,BANRED, "Can't withdraw negatives");
				}
			} else {
			    SendClientMessage(playerid,BANRED, "Your not logged in!");
			}
		} else {
			SendClientMessage(playerid,BANRED, "You need to be at the bank!");
		}
		return 1;
	}
	if(strcmp(cmd, "/balance", true,8)==0)
	{
		if(PlayerToPoint(100, playerid,-2.0628,-18.4967,1003.5494))
		{
		    if(PLAYERLIST_authed[playerid] == 1)
		    {
				new string[256];
				format(string,sizeof(string),"You have $%d in your bank account",dUserINT(PlayerName(playerid)).("bank"));
				SendClientMessage(playerid, COLOR_GREEN2, string);
			} else {
			    SendClientMessage(playerid,BANRED, "Your not logged in!");
			}
		} else {
			SendClientMessage(playerid,BANRED, "You need to be at the bank!");
		}
		return 1;
	}
	if(strcmp(cmd, "/throwback", true,10)==0)
	{
	    if(PlayerBoats(playerid,GetPlayerVehicleID(playerid)))
	    {
	        if(pfish[playerid] > 0)
	        {
	            new string[256];
		        SendClientMessage(playerid,COLOR_GREEN2, "You threw back your most recent fish into the water");
		        format(string,sizeof(string),"You have %d fish(es) left",pfish[playerid]);
		        SendClientMessage(playerid,COLOR_GREEN2,string);
		        pfish[playerid]--;
			} else {
	        	SendClientMessage(playerid,BANRED, "You have no fish");
	    	}
		} else {
	        SendClientMessage(playerid,BANRED, "You need to be in a boat in the water");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/fishhelp", true,9)==0)
	{
        SendClientMessage(playerid,COLOR_GRAY, "_____Fishing_____");
        SendClientMessage(playerid,COLOR_GRAY, "/fish - Catch fish");
        SendClientMessage(playerid,COLOR_GRAY, "/throwback - Throw back your most recent fish");
        SendClientMessage(playerid,COLOR_GRAY, "You must be in a boat in the water to fish");
	    return 1;
	}
	if(strcmp(cmd, "/fish", true,5)==0)
	{
     	if(PlayerBoats(playerid,GetPlayerVehicleID(playerid)))
	    {
	        new string[256];
	        new rand = random(FishNums);
	        new rand2 = random(sizeof(RandFishSizes));
	        if(FishNums == 0)
			{
				SendClientMessage(playerid,COLOR_RED, "You caught dirty ripped pants and threw it back");
			} else if(rand == 11) {
			    SendClientMessage(playerid,COLOR_RED, "You caught garbage and threw it back");
			} else if(rand == 12) {
				SendClientMessage(playerid,COLOR_RED, "Your line snapped and you fixed it");
			} else if(rand == 13) {
				SendClientMessage(playerid,COLOR_RED, "You caught a dead chicken and threw it back");
			} else if(rand == 14) {
				SendClientMessage(playerid,COLOR_RED, "You caught a dead fish and threw it back");
			} else if(rand == 15) {
				SendClientMessage(playerid,COLOR_RED, "You caught a shoe and threw it back");
			} else if(rand == 16) {
			    new randz = random(sizeof(amount));
			    new stringz[256];
			    format(stringz,sizeof(stringz),"You caught a bag of money with $%d in it!!!",amount[randz][0]);
			    SendClientMessage(playerid,COLOR_GREEN2, stringz);
			    GivePlayerMoney(playerid,amount[randz][0]);
			} else if(rand == 17) {
				SendClientMessage(playerid,COLOR_RED, "You caught a scratched cd and threw it back");
			} else if(rand == 18) {
				SendClientMessage(playerid,COLOR_RED, "You caught a bunch of paper and threw it back");
			} else {
			    if(pfish[playerid] <= 5)
			    {
			        format(string,sizeof(string),"You cought a %s pound %s!",RandFishSizes[rand2][0],RandFish[rand][0]);
			        SendClientMessage(playerid,COLOR_GREEN2, string);
		            SendClientMessage(playerid,COLOR_GREEN2, "You can eat this now or later using /eat or throw it back");
		            pfish[playerid]++;
	            } else {
	                SendClientMessage(playerid,BANRED, "You have too many fish, eat some or throw some away");
	            }
            }
	    } else {
	        SendClientMessage(playerid,BANRED, "You need to be in a boat in the water");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/eat", true,4)==0)
	{
	    new food[256];
	    new string[256];
		food = strtok(cmdtext, idx);
		if(!strlen(food))
		{
			SendClientMessage(playerid,COLOR_GRAY, "USAGE: /eat [food]");
			SendClientMessage(playerid,COLOR_GRAY, "Foods: Pizza, Sushi, Burger, Fish");
			return 1;
		}
		if(strcmp(food, "pizza", true)==0) {
		    if(ppizza[playerid] > 0)
		    {
		        ppizza[playerid]--;
				SendClientMessage(playerid,COLOR_GREEN2, "You have eaten a slice of your Pizza");
				format(string,sizeof(string),"You have %d slices of pizza left", ppizza[playerid]);
				SendClientMessage(playerid, COLOR_GREEN2, string);
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health + 25);
			} else {
			    SendClientMessage(playerid,BANRED, "You don't have any of this food left");
			}
		} else if(strcmp(food, "sushi", true)==0) {
		    if(psushi[playerid] > 0)
		    {
		        psushi[playerid]--;
				SendClientMessage(playerid,COLOR_GREEN2, "You have eaten a roll of your Sushi");
				format(string,sizeof(string),"You have %d rolls of sushi left", psushi[playerid]);
				SendClientMessage(playerid, COLOR_GREEN2, string);
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health + 25);
			} else {
			    SendClientMessage(playerid,BANRED, "You don't have any of this food left");
			}
		} else if(strcmp(food, "burger", true)==0) {
		    if(pburger[playerid] > 0)
		    {
		        pburger[playerid]--;
				SendClientMessage(playerid,COLOR_GREEN2, "You have eaten one of your Cheese Burgers");
				format(string,sizeof(string),"You have %d cheese burgers left", pburger[playerid]);
				SendClientMessage(playerid, COLOR_GREEN2, string);
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health + 25);
			} else {
			    SendClientMessage(playerid,BANRED, "You don't have any of this food left");
			}
		} else if(strcmp(food, "fish", true)==0) {
		    if(pfish[playerid] > 0)
		    {
                pfish[playerid]--;
				SendClientMessage(playerid,COLOR_GREEN2, "You have eaten one of the fishes you caught");
				format(string,sizeof(string),"You have %d fishes left", pfish[playerid]);
				SendClientMessage(playerid, COLOR_GREEN2, string);
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health + 25);
			} else {
			    SendClientMessage(playerid,BANRED, "You don't have any of this food left");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/buy", true,4)==0)
	{
		tmp = strtok(cmdtext, idx);
		new item = strval(tmp);
		if(!strval(tmp))
		{
			SendClientMessage(playerid,COLOR_GRAY, "==========Buy========");
			SendClientMessage(playerid,COLOR_GRAY, "USAGE: /buy <item number>");
			SendClientMessage(playerid,COLOR_GREEN, "1. Carlock ($400), 2. Pizza ($12), 3. Sushi ($10), 4. Burger ($6)");
			SendClientMessage(playerid,COLOR_GREEN, "5. Cellphone ($700), 6. New clothes ($60), 7. Beer ($20),");
			SendClientMessage(playerid,COLOR_GREEN, "8. Vodka ($30), 9. Soda ($4), 10. Orange Juice ($6)");
			SendClientMessage(playerid,COLOR_GREEN, "11. Water ($1)");
			SendClientMessage(playerid,COLOR_GRAY, "=====================");
			return 1;
		}
		if(PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))
		{
		    if(item == 1)
		    {
				if(PLAYERLIST_authed[playerid])
				{
			        if(GetPlayerMoney(playerid) > 400)
			        {
			            if(vlock[playerid] == 0)
			            {
				        	vlock[playerid] = 1;
							SendClientMessage(playerid,COLOR_GREEN, "You bought a car lock for $400!");
							SendClientMessage(playerid,COLOR_GREEN, "You can now use /lock and /unlock");
							GivePlayerMoney(playerid, -400);
						} else {
							SendClientMessage(playerid,COLOR_GRAY, "You already have this item");
						}
					} else {
						SendClientMessage(playerid,COLOR_GRAY, "Need $400");
					}
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need to login");
				}
		    } else if(item == 2)
			{
		        if(GetPlayerMoney(playerid) > 12)
		        {
		            if(ppizza[playerid] <= 8)
		            {
			            SendClientMessage(playerid,COLOR_GREEN, "You bought a hot pizza!");
			            SendClientMessage(playerid,COLOR_GREEN, "You can eat it by using /eat");
			            GivePlayerMoney(playerid, -12);
			            ppizza[playerid]++;
		            } else {
		                SendClientMessage(playerid,BANRED, "You have too many slices of pizza, eat some first!");
		            }
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $12");
				}
		    } else if(item == 3)
			{
		        if(GetPlayerMoney(playerid) > 10)
		        {
		            if(psushi[playerid] <= 10)
		            {
			            SendClientMessage(playerid,COLOR_GREEN, "You bought real Japanese sushi!");
			            SendClientMessage(playerid,COLOR_GREEN, "You can eat it by using /eat");
			            GivePlayerMoney(playerid, -12);
			            psushi[playerid]++;
		            } else {
		                SendClientMessage(playerid,BANRED, "You have too many rolls of sushi, eat some first!");
		            }
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $10");
				}
		    } else if(item == 4)
			{
		        if(GetPlayerMoney(playerid) > 6)
		        {
		            if(pburger[playerid] <= 3)
		            {
			            SendClientMessage(playerid,COLOR_GREEN, "You bought a cheese burger!");
			            SendClientMessage(playerid,COLOR_GREEN, "You can eat it by using /eat");
			            GivePlayerMoney(playerid, -6);
			            pburger[playerid]++;
 		            } else {
		                SendClientMessage(playerid,BANRED, "You have too many burgers, eat some first!");
		            }
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $6");
				}
		    } else if(item == 5)
			{
				if(PLAYERLIST_authed[playerid])
				{
			        if(GetPlayerMoney(playerid) > 700)
			        {
			            if(phone[playerid] == 0)
			            {
		          			new randphone = 1000 + random(8999);
				            new string[256];
				            format(string, sizeof(string), "You bought a phone, your new phone number is %d",randphone);
				            SendClientMessage(playerid,COLOR_GREEN, string);
							phonenbr[playerid] = randphone;
				            phone[playerid] = 1;
				            dUserSetINT(PlayerName(playerid)).("phone",phone[playerid]);
				            dUserSetINT(PlayerName(playerid)).("phonenbr",phonenbr[playerid]);
			            } else {
							SendClientMessage(playerid,COLOR_GRAY, "You already have this item");
						}
					} else {
						SendClientMessage(playerid,COLOR_GRAY, "Need $700");
					}
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need to login");
				}
		    } else if(item == 6)
			{
			    new rand = random(sizeof(peds));
		        if(GetPlayerMoney(playerid) > 60)
		        {
		            SendClientMessage(playerid,COLOR_GREEN, "You bought new clothes");
		            SetPlayerSkin(playerid, peds[rand][0]);
		            GivePlayerMoney(playerid, -60);
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $60");
				}
		    } else if(item == 7)
			{
		        if(GetPlayerMoney(playerid) > 20)
		        {
		            SendClientMessage(playerid,COLOR_GREEN, "You bought beer!");
            		GetPlayerHealth(playerid, health);
    				SetPlayerHealth(playerid, health + 10);
		            GivePlayerMoney(playerid, -20);
          		    drink[playerid]++;
		    		ApplyAnimation(playerid,"PED","WALK_DRUNK",4.0,0,1,0,0,0);
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $20");
				}
		    } else if(item == 8)
			{
		        if(GetPlayerMoney(playerid) > 30)
		        {
		            SendClientMessage(playerid,COLOR_GREEN, "You bought Vodka!");
            		GetPlayerHealth(playerid, health);
    				SetPlayerHealth(playerid, health + 15);
		            GivePlayerMoney(playerid, -30);
          		    drink[playerid]++;
		    		ApplyAnimation(playerid,"PED","WALK_DRUNK",4.0,0,1,0,0,0);
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $30");
				}
		    } else if(item == 9)
			{
		        if(GetPlayerMoney(playerid) > 4)
		        {
		            SendClientMessage(playerid,COLOR_GREEN, "You bought a can of soda!");
            		GetPlayerHealth(playerid, health);
    				SetPlayerHealth(playerid, health + 5);
		            GivePlayerMoney(playerid, -4);
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $4");
				}
		    } else if(item == 10)
			{
		        if(GetPlayerMoney(playerid) > 6)
		        {
		            SendClientMessage(playerid,COLOR_GREEN, "You bought a carton of Orange Juice");
            		GetPlayerHealth(playerid, health);
    				SetPlayerHealth(playerid, health + 20);
		            GivePlayerMoney(playerid, -6);
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $6");
				}
		    } else if(item == 11)
			{
		        if(GetPlayerMoney(playerid) > 1)
		        {
		            SendClientMessage(playerid,COLOR_GREEN, "You bought a bottle of water!");
            		GetPlayerHealth(playerid, health);
    				SetPlayerHealth(playerid, health + 5);
		            GivePlayerMoney(playerid, -1);
				} else {
					SendClientMessage(playerid,COLOR_GRAY, "Need $1");
				}
		    }
		} else {
			SendClientMessage(playerid,COLOR_GRAY, "You need to be at the 24/7 on The Strip!");
		}
		return 1;
	}
	if (strcmp("/break", cmd, true) == 0)
	{
	    if(gTeam[playerid] == BUS || gTeam[playerid] == TAXI || gTeam[playerid] == DMV || gTeam[playerid] == PILOT || gTeam[playerid] == BOAT || gJob[playerid] == MECHANIC || gJob[playerid] == MEDIC || gJob[playerid] == WHORE || gJob[playerid] == DRUGS || gJob[playerid] == IMPORT || gJob[playerid] == MAIL)
	    {
		    	if(onbreak[playerid] == 0) {
				SendClientMessage(playerid, COLOR_GRAY, "** You are now on break");
				onbreak[playerid] = 1;
				new str[256], pname[256]; GetPlayerName(playerid, pname, 256);
				format(str, 256, "** %s is now on break", pname, cmdtext[4]);
				SendClientMessageToAll(COLOR_GREEN2, str);
				if(gJob[playerid] == MAIL)
				{
					KillTimer(count3t);
					KillTimer(count4t);
				}
				if(gJob[playerid] == IMPORT)
				{
					KillTimer(count5t);
				}
				KillTimer(jcdt);
				} else if(onbreak[playerid] == 1) {
				SendClientMessage(playerid, COLOR_GRAY, "** You are now off break");
				onbreak[playerid] = 0;
				new str[256], pname[256]; GetPlayerName(playerid, pname, 256);
				format(str, 256, "** %s is now off break", pname, cmdtext[4]);
				SendClientMessageToAll(COLOR_GREEN2, str);
				if(gJob[playerid] == MAIL)
				{
					count3t = SetTimer("MailDrop2", 1000, 1);
					count4t = SetTimer("MailDrop3", 1000, 1);
				}
				if(gJob[playerid] == IMPORT)
				{
					count5t = SetTimer("Count5", 1000, 1);
				}
				}
		}
		return 1;
	}
	if (strcmp("/players", cmd, true) == 0)
	{
		new string[256];
		format(string,sizeof(string),"%d",GetConnectedPlayers());
		SendClientMessage(playerid, COLOR_RED, string);
	}
	if (strcmp("/jobquit", cmd, true) == 0)
	{
	    if(jobhours[playerid] == 1)
	    {
			if(dUserINT(PlayerName(playerid)).("Count2") <= 18000)
   			{
    			SendClientMessage(playerid, BANRED, "You still have 5 hours to work!");
			} else if(dUserINT(PlayerName(playerid)).("Count2") <= 14400)
			{
				SendClientMessage(playerid, BANRED, "You still have 4 hours to work!");
			} else if(dUserINT(PlayerName(playerid)).("Count2") <= 10800)
			{
				SendClientMessage(playerid, BANRED, "You still have 3 hours to work!");
			} else if(dUserINT(PlayerName(playerid)).("Count2") <= 7200)
			{
				SendClientMessage(playerid, BANRED, "You still have 2 hours to work!");
			} else if(dUserINT(PlayerName(playerid)).("Count2") <= 3600)
			{
				SendClientMessage(playerid, BANRED, "You still have 1 hour to work!");
			}
	    } else if(jobbed[playerid] == 0) {
			SendClientMessage(playerid, BANRED, "You don't even have a job yet!");
		} else {
		    if(gJob[playerid] == MAIL)
		    {
		    	jobbed[playerid] = 0;
			    gTeam[playerid] = CIV;
				SendClientMessage(playerid, BANRED, "You quit your job");
				Count2 = 18000;
				count4 = 0;
				KillTimer(count3t);
				KillTimer(count4t);
		    } else if(gJob[playerid] == IMPORT)
		    {
	    		jobbed[playerid] = 0;
			    gTeam[playerid] = CIV;
				SendClientMessage(playerid, BANRED, "You quit your job");
				Count2 = 18000;
				count5 = 0;
				KillTimer(count5t);
			} else {
			    jobbed[playerid] = 0;
			    gTeam[playerid] = CIV;
				SendClientMessage(playerid, BANRED, "You quit your job");
				Count2 = 18000;
				KillTimer(Count2);
			}
		}
		return 1;
	}
	if (strcmp("/licenses", cmd, true) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "===============Licenses============");
		if(dli[playerid] == 1) {
			SendClientMessage(playerid, COLOR_GRAY, "Drivers License: Passed");
		} else if(dli[playerid] == 0) {
			SendClientMessage(playerid, COLOR_GRAY, "Drivers License: Not Passed");
		}
		if(bli[playerid] == 1) {
			SendClientMessage(playerid, COLOR_GRAY, "Boaters License: Passed");
		} else if(bli[playerid] == 0) {
			SendClientMessage(playerid, COLOR_GRAY, "Boaters License: Not Passed");
		}
		if(pli[playerid] == 1) {
			SendClientMessage(playerid, COLOR_GRAY, "Pilot License: Passed");
		} else if(pli[playerid] == 0) {
			SendClientMessage(playerid, COLOR_GRAY, "Pilot License: Not Passed");
		}
		if(wli[playerid] == 1) {
			SendClientMessage(playerid, COLOR_GRAY, "Weapon License: Passed");
		} else if(wli[playerid] == 0) {
			SendClientMessage(playerid, COLOR_GRAY, "Weapon License: Not Passed");
		}
		SendClientMessage(playerid, COLOR_GRAY, "==================================");
		return 1;
	}
	if(strcmp(cmd, "/call", true,5)==0)
	{
		tmp = strtok(cmdtext, idx);
		new numb;
		numb = strval(tmp);
		if(!strlen(tmp))
		{
  			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /call [phone number]");
  			return 1;
		}
		if(phone[playerid] == 0)
		{
            SendClientMessage(playerid, COLOR_GRAY, "You can't call without a phone");
            return 1;
  		}
		if(incall[playerid] == 1)
		{
            SendClientMessage(playerid, COLOR_GRAY, "Your already in a call");
            return 1;
  		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(dUserINT(PlayerName(i)).("phonenbr") == numb && numb != 0)
				{
				    giveplayerid = i;
			  		if(incall[giveplayerid] == 0)
			  		{
			  			if(IsPlayerConnected(giveplayerid))
					  	{
			  				if(phone[giveplayerid] == 1)
							{
			      				new string[256];
						        GetPlayerName(playerid, sendername, sizeof(sendername));
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						        format(string, sizeof(string), "** You are calling %s",giveplayer);
						        SendClientMessage(playerid, COLOR_GREEN2, string);
						        format(string, sizeof(string), "* ring * %s is calling you on the phone (/pickup to pick up)",sendername);
						        SendClientMessage(giveplayerid, COLOR_GREEN2, string);
						        caller = playerid;
						        calling = giveplayerid;
						        count11 = 60;
						        count11t = SetTimer("CallT",1000,1);
						        return 1;
							} else {
							    SendClientMessage(playerid, COLOR_GRAY, "That player doesn't have a phone");
							}
						} else {
						    SendClientMessage(playerid, COLOR_GRAY, "That player is offline");
						}
					} else {
					    SendClientMessage(playerid, COLOR_GRAY, "That player is in a call");
					}
		        } else {
					SendClientMessage(playerid, BANRED, "No such phone number (/phonebook for help)");
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/pickup", true,7)==0)
	{
	    if(calling == playerid)
	    {
        	new string[256];
	        GetPlayerName(caller, sendername, sizeof(sendername));
	        GetPlayerName(calling, giveplayer, sizeof(giveplayer));
	        format(string, sizeof(string), "** %s picked up (/t to talk)",giveplayer);
	        SendClientMessage(caller, COLOR_GREEN2, string);
	        format(string, sizeof(string), "** You are now talking with %s (/t to talk)",sendername);
	        SendClientMessage(calling, COLOR_GREEN2, string);
	        incall[playerid] = 1;
	        incall[calling] = 1;
	        Target[caller] = calling;
	        Target[calling] = playerid;
			KillTimer(count11t);
			count11 = 0;
			phoneprice[caller] = 0;
			phonept = SetTimer("PhoneCost",1000,1);
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
	    } else {
	        SendClientMessage(playerid, BANRED, "No one is calling you");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/t", true, 2) == 0)
	{
		//GetPlayerName(caller, sendername, sizeof(sendername));
 		//GetPlayerName(calling, giveplayer, sizeof(giveplayer));
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
		new string[256]/*, string2[256]*/;
		if(Target[playerid] -= -1)
		{
		    format(string, sizeof(string), "%s [PhoneCall]: %s", PlayerName(playerid),(result));
			SendClientMessage(calling, COLOR_LIGHTBLUE, string);
			SendClientMessage(caller, COLOR_LIGHTBLUE, string);
		    //format(string2, sizeof(string2), "You said: %s", (result));
			//SendClientMessage(caller, COLOR_LIGHTBLUE, string2);
		/*} else if(calling < 999)
		{
		    format(string, sizeof(string), "%s [PhoneCall]: %s", giveplayer,(result));
			SendClientMessage(caller, COLOR_LIGHTBLUE, string);
		    format(string2, sizeof(string2), "You said: %s", (result));
			SendClientMessage(calling, COLOR_LIGHTBLUE, string2);*/
		} else {
	        SendClientMessage(playerid, BANRED, "Your not in a phone call");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/hangup", true,7) == 0)
	{
	    new string[256], string2[256], string3[256];
		GetPlayerName(caller, sendername, sizeof(sendername));
 		GetPlayerName(calling, giveplayer, sizeof(giveplayer));
		if(caller < 999)
		{
		    format(string, sizeof(string), "%s hung up on you", sendername);
			SendClientMessage(calling, COLOR_LIGHTBLUE, string);
		    format(string2, sizeof(string2), "You hung up on %s", giveplayer);
			SendClientMessage(caller, COLOR_LIGHTBLUE, string2);
			format(string3, sizeof(string3), "~r~Calling Cost: ~r~$%d", phoneprice[caller]);
			GameTextForPlayer(caller,string3,3500,5);
		} else if(calling < 999)
		{
		    format(string, sizeof(string), "%s hung up on you", giveplayer);
			SendClientMessage(caller, COLOR_LIGHTBLUE, string);
		    format(string2, sizeof(string2), "You hung up on %s", sendername);
			SendClientMessage(calling, COLOR_LIGHTBLUE, string2);
			format(string3, sizeof(string3), "~r~Calling Cost: ~r~$%d", phoneprice[caller]);
			GameTextForPlayer(caller,string3,3500,5);
		} else {
	        SendClientMessage(playerid, BANRED, "Your not in a phone call");
	    }
		caller = 999;
		calling = 999;
		incall[caller] = 0;
		incall[calling] = 0;
		Target[caller] = 999;
		Target[calling] = 999;
		KillTimer(phonept);
		phoneprice[playerid] = 0;
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	    return 1;
	}
	if(strcmp(cmd, "/phonebook", true,10) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    giveplayerid = ReturnUser(tmp);
	    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	    new string[256];
	    if(!strlen(tmp))
		{
		    return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /phonebook [id/name]");
		} else if(IsPlayerConnected(giveplayerid)) {
		    format(string,sizeof(string),"%s's phone number: %d",giveplayer,dUserINT(PlayerName(giveplayerid)).("phonenbr"));
		    SendClientMessage(playerid, COLOR_GREEN, string);
		} else {
		    SendClientMessage(playerid, COLOR_GREEN, "No such player");
		}
	    return 1;
	}
	if(strcmp(cmd, "/slesson", true, 8) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /elesson [playerid/name]");
			return 1;
		} else if(gTeam[playerid] == ADMIN || gTeam[playerid] == DMV || gTeam[playerid] == PILOT || gTeam[playerid] == BOAT)
	    {
	        if(onbreak[playerid] == 0)
	        {
				if(!strlen(tmp))
				{
				    return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /slesson [playerid/name]");
				}
				giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if(giveplayerid != playerid)
				        {
						    if(inlesson[giveplayerid] == 0)
						    {
						        if(PlayerDistance(8.0,playerid,giveplayerid))
						        {
			        				new string[256];
							        GetPlayerName(playerid, sendername, sizeof(sendername));
							        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							        format(string, sizeof(string), "** You started a lesson with %s",giveplayer);
							        SendClientMessage(playerid, COLOR_GREEN2, string);
							        format(string, sizeof(string), "** Instructor %s has started your lesson",sendername);
							        SendClientMessage(giveplayerid, COLOR_GREEN2, string);
							        inlesson[giveplayerid] = 1;
							        inlesson[playerid] = 1;
						        } else {
						            return SendClientMessage(playerid, BANRED, "That player isn't near you");
						        }
						    } else {
						    	return SendClientMessage(playerid, BANRED, "That player is already in a lesson");
						    }
					    } else {
					        return SendClientMessage(playerid, BANRED, "You can't start your own lesson");
					    }
					}
				} else {
				    return SendClientMessage(playerid, BANRED, "No such player");
				}
	        } else {
	            return SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
	        }
	    } else {
	    	return SendClientMessage(playerid, BANRED, "You aren't an instructor");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/elesson", true, 8) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /elesson [playerid/name]");
			return 1;
		} else if(gTeam[playerid] == ADMIN || gTeam[playerid] == DMV || gTeam[playerid] == PILOT || gTeam[playerid] == BOAT)
  		{
			if(onbreak[playerid] == 0)
			{
				giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        if(giveplayerid != playerid)
				        {
					        if(inlesson[giveplayerid] == 1)
					        {
					            if(PlayerDistance(8.0,playerid,giveplayerid))
					            {
							        new string[256];
							        GetPlayerName(playerid, sendername, sizeof(sendername));
							        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							        format(string, sizeof(string), "** You ended the lesson with %s",giveplayer);
							        SendClientMessage(playerid, COLOR_GREEN2, string);
							        format(string, sizeof(string), "** Instructor %s has ended your lesson",sendername);
							        SendClientMessage(giveplayerid, COLOR_GREEN2, string);
							        inlesson[giveplayerid] = 0;
							        inlesson[playerid] = 1;
						        } else {
						            return SendClientMessage(playerid, BANRED, "That player isn't near you");
						        }
							} else {
								return SendClientMessage(playerid, BANRED, "That player was never in a lesson");
							}
						} else {
                            return SendClientMessage(playerid, BANRED, "You can't end your own lesson");
						}
				    }
				} else {
				    return SendClientMessage(playerid, BANRED, "No such player");
				    
				}
	        } else {
	            return SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
	            
	        }
	    } else {
	    	return SendClientMessage(playerid, BANRED, "You aren't an instructor");
	    }
	    return 1;
	}
	if(strcmp(cmd, "/givelicense", true,12) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		if(gTeam[playerid] == DMV || gTeam[playerid] == PILOT || gTeam[playerid] == BOAT)
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /givelicense [playerid/name]");
			} else if(onbreak[playerid] == 0) {
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if(giveplayerid != playerid)
					{
						if(gTeam[playerid] == DMV)
						{
							if(IsPlayerConnected(giveplayerid))
							{
								new string[256];
							    GetPlayerName(playerid, sendername, sizeof(sendername));
							    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							    format(string, sizeof(string), "** You gave %s a drivers license",giveplayer);
							    SendClientMessage(playerid, COLOR_GREEN2, string);
							    format(string, sizeof(string), "** Instructor %s has given you a drivers license",sendername);
							    SendClientMessage(giveplayerid, COLOR_GREEN2, string);
								dli[giveplayerid] = 1;
						    	return 1;
							} else {
								return SendClientMessage(playerid, BANRED, "No such player");
							}
					    } else if(gTeam[playerid] == PILOT)
						{
							if(IsPlayerConnected(giveplayerid))
							{
					  			pli[giveplayerid] = 1;
								new string[256];
							    GetPlayerName(playerid, sendername, sizeof(sendername));
							    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							    format(string, sizeof(string), "** You gave %s a flying license",giveplayer);
							    SendClientMessage(playerid, COLOR_GREEN2, string);
							    format(string, sizeof(string), "** Instructor %s has given you a flying license",sendername);
							    SendClientMessage(giveplayerid, COLOR_GREEN2, string);
						    	return 1;
							} else {
								return SendClientMessage(playerid, BANRED, "No such player");
							}
						} else if(gTeam[playerid] == BOAT)
						{
							if(IsPlayerConnected(giveplayerid))
							{
					  			bli[giveplayerid] = 1;
								new string[256];
							    GetPlayerName(playerid, sendername, sizeof(sendername));
							    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							    format(string, sizeof(string), "** You gave %s a boating license",giveplayer);
							    SendClientMessage(playerid, COLOR_GREEN2, string);
							    format(string, sizeof(string), "** Instructor %s has given you a boating license",sendername);
							    SendClientMessage(giveplayerid, COLOR_GREEN2, string);
						    	return 1;
							} else {
								return SendClientMessage(playerid, BANRED, "No such player");
							}
						}
					} else {
					    return SendClientMessage(playerid, BANRED, "You can't give yourself a license");
					}
				}
			} else {
			    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You aren't an instructor!");
		}
	 	return 1;
	}
	if(strcmp(cmd, "/changeskin", true,11) == 0)
	{
		tmp = strtok(cmdtext, idx);
		new skin = strval(tmp);
		if(gTeam[playerid] == COP)
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "=====Change Cop Skin=====");
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /changeskin [280,281,282,283,284,288]");
			} else if(skin == 280) {
				SetPlayerSkin(playerid, 280);
			} else if(skin == 281) {
				SetPlayerSkin(playerid, 281);
			} else if(skin == 282) {
				SetPlayerSkin(playerid, 282);
			} else if(skin == 283) {
				SetPlayerSkin(playerid, 283);
			} else if(skin == 284) {
				SetPlayerSkin(playerid, 284);
			} else if(skin == 288) {
				SetPlayerSkin(playerid, 288);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/takelicense", true,12) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
		if(gTeam[playerid] == COP)
		{
			if(!strlen(tmp))
			{
				return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /takelicense [playerid/name]");
			} else if(IsPlayerConnected(giveplayerid)) {
			    if(PlayerDistance(5.0,playerid,giveplayerid)) {
					if(tickets[giveplayerid] > 4) {
				    	dli[giveplayerid] = 0;
						new string[256];
					    GetPlayerName(playerid, sendername, sizeof(sendername));
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					    format(string, sizeof(string), "** You took %s's driving license",giveplayer);
					    SendClientMessage(playerid, COLOR_GREEN2, string);
					    format(string, sizeof(string), "** Officer %s has taken your driving license",sendername);
					    SendClientMessage(giveplayerid, COLOR_GREEN2, string);
					} else {
			    		SendClientMessage(playerid, BANRED, "This player has less than 4 tickets");
					}
				} else {
    				return SendClientMessage(playerid, BANRED, "That player isn't near you");
        		}
			} else {
		    	SendClientMessage(playerid, BANRED, "No such player");
			}
		} else {
		    SendClientMessage(playerid, BANRED, "You aren't an instructor!");
		}
	 	return 1;
	}
	if(strcmp(cmd, "/fuel", true,5) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gJob[playerid] != MECHANIC)
		    {
		        SendClientMessage(playerid, BANRED, "Your not a mechanic!!");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, BANRED, "USAGE: /fuel [playerid/name] [price]");
				return 1;
			}
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if(money < 1 || money > 900) { SendClientMessage(playerid, BANRED, "Price can not be lower than 1, cannot be higher than 900"); return 1; }
			if(onbreak[playerid] == 0)
			{
				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
				        if(playa != playerid)
				        {
					        if(IsPlayerInAnyVehicle(playa))
							{
							    if(PlayerDistance(8.0,playerid,playa))
							    {
								    new string[256];
								    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
								    format(string, sizeof(string), "** You offered to fill %s's car with gas for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Mechanic %s offers to fill your car with gas for $%d. (/acceptfuel or /denyfuel)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									RefillOffer[playa] = playerid;
									RefillPrice[playa] = money;
								} else {
	    							return SendClientMessage(playerid, BANRED, "That player isn't near you");
	        					}
							}
							else
							{
							    return SendClientMessage(playerid, COLOR_LBLUE, "That player isn't in a car");
							}
						} else {
						    return SendClientMessage(playerid, COLOR_LBLUE, "You can't fill your own car");
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, BANRED, "No such player");
				}
			} else {
			    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/repair", true,7) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gJob[playerid] != MECHANIC)
		    {
		        SendClientMessage(playerid, BANRED, "Your not a mechanic!!");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, BANRED, "USAGE: /repair [playerid/name] [price]");
				return 1;
			}
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if(money < 1 || money > 900) { SendClientMessage(playerid, BANRED, "Price can not be lower than 1, cannot be higher than 900"); return 1; }
			if(onbreak[playerid] == 0)
			{
				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
						if(playa != playerid)
						{
					        if(IsPlayerInAnyVehicle(playa))
							{
							    if(PlayerDistance(8.0,playerid,playa))
							    {
								    new string[256];
								    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
								    format(string, sizeof(string), "** You offered to repair %s's car for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Mechanic %s offers to repair your for $%d. (/acceptrepair or /denyrepair)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									RepairOffer[playa] = playerid;
									RepairPrice[playa] = money;
								} else {
	    							return SendClientMessage(playerid, BANRED, "That player isn't near you");
	        					}
							}
							else
							{
							    SendClientMessage(playerid, COLOR_LBLUE, "That player isn't in a car");
							}
						} else {
						    return SendClientMessage(playerid, COLOR_LBLUE, "You can't repair your own car");
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, BANRED, "No such player");
				}
			} else {
			    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/heal", true,5) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gJob[playerid] != MEDIC)
		    {
		        SendClientMessage(playerid, BANRED, "Your not a medic!!");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, BANRED, "USAGE: /heal [playerid/name] [price]");
				return 1;
			}
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if(money < 1 || money > 900) { SendClientMessage(playerid, BANRED, "Price can not be lower than 1, cannot be higher than 900"); return 1; }
			if(onbreak[playerid] == 0)
			{
				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
				        if(playa != playerid)
				        {
					        if(PlayerDistance(8.0,playerid,playa))
					        {
						    	new string[256];
						    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
			   					format(string, sizeof(string), "** You offered to repair %s's car for $%d",giveplayer,money);
								SendClientMessage(playerid, COLOR_AQUA, string);
								format(string, sizeof(string), "** Mechanic %s offers to repair your for $%d. (/acceptheal or /denyheal)",sendername,money);
								SendClientMessage(playa, COLOR_AQUA, string);
								HealOffer[playa] = playerid;
								HealPrice[playa] = money;
							} else {
	    						return SendClientMessage(playerid, BANRED, "That player isn't near you");
	        				}
        				} else {
        				    return SendClientMessage(playerid, COLOR_LBLUE, "You can't heal yourself");
        				}
					}
				}
				else
				{
				    SendClientMessage(playerid, BANRED, "No such player");
				}
			} else {
			    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/callcops", true,9)==0)
	{
	    if(!strlen(cmdtext[10]))
	    {
	        SendClientMessageToAll(BANRED, "USAGE: /callcops [message]");
	    } else {
			new str[256], pname[256]; GetPlayerName(playerid, pname, 256);
			format(str, 256, "%s Reports: %s", pname, cmdtext[10]);
			SendClientMessageToTeam(COP, COLOR_RED, str);
			SendClientMessage(playerid, COLOR_WHITE, "Your message has been sent to LVPD officers");
			return 1;
		}
	}
	if(strcmp(cmd, "/jail", true,5) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gTeam[playerid] == COP)
		    {
		        new tmp2[256], tmp3[256], tmp4[256];
		        tmp = strtok(cmdtext, idx);
				tmp2 = strtok(cmdtext, idx);
				tmp3 = strtok(cmdtext, idx);
				tmp4 = strtok(cmdtext, idx);
				giveplayerid = ReturnUser(tmp);
				time = strval(tmp2);
				bailq = strval(tmp3);
				bailprice = strval(tmp4);
				if(!strlen(tmp))
				{
					return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /jail [id/name] [time (minutes)] [bail (1=yes or 2=no)] [BailPrice]");
    			}
				if(!strlen(tmp2))
				{
					return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /jail [id/name] [time (minutes)] [bail (1=yes or 2=no)] [BailPrice]");
				}
				if(!strlen(tmp3))
				{
					return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /jail [id/name] [time (minutes)] [bail (1=yes or 2=no)] [BailPrice]");
				}
				if(!strlen(tmp4))
				{
					return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /jail [id/name] [time (minutes)] [bail (1=yes or 2=no)] [BailPrice]");
				}
				if(onbreak[playerid] == 0)
				{
					if(IsPlayerConnected(giveplayerid))
					{
					    if(giveplayerid != INVALID_PLAYER_ID)
					    {
					        if(giveplayerid != playerid)
					        {
						        if(gTeam[giveplayerid] != COP || gTeam[giveplayerid] != ADMIN || gTeam[giveplayerid] != MAYOR)
						        {
							        if(PlayerToPoint(6.1, playerid,197.9359,159.1012,1003.0234) && PlayerToPoint(6.1, giveplayerid,197.9359,159.1012,1003.0234))
							        {
							            if(jailed[giveplayerid] == 0)
							            {
								            if(bailq == 1)
								            {
										    	new string[256];
										    	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
												GetPlayerName(playerid, sendername, sizeof(sendername));
							   					format(string, sizeof(string), "** You jailed %s for %d minutes, Bail: $%d",giveplayer,time,bailprice);
												SendClientMessage(playerid, COLOR_AQUA, string);
												format(string, sizeof(string), "** You were jailed by officer %s for %d minutes, Bail: $%d",sendername,time,bailprice);
												SendClientMessage(giveplayerid, COLOR_AQUA, string);
												jailtime[giveplayerid] = time * 60;
												jailed[giveplayerid] = 1;
												SetPlayerPos(giveplayerid, 198.5881,162.1837,1003.0300);
												JailCDt = SetTimer("JailCD",1000,1);
												ResetPlayerWeapons(giveplayerid);
												inbail[giveplayerid] = 1;
												inbailprice[giveplayerid] = bailprice;
											} else {
										    	new string[256];
										    	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
												GetPlayerName(playerid, sendername, sizeof(sendername));
							   					format(string, sizeof(string), "** You jailed %s for %d minutes, Bail: No Bail",giveplayer,time);
												SendClientMessage(playerid, COLOR_AQUA, string);
												format(string, sizeof(string), "** You were jailed by officer %s for %d minutes, Bail: No Bail",sendername,time);
												SendClientMessage(giveplayerid, COLOR_AQUA, string);
												jailtime[giveplayerid] = time * 60;
												jailed[giveplayerid] = 1;
												SetPlayerPos(giveplayerid, 198.5881,162.1837,1003.0300);
												JailCDt = SetTimer("JailCD",1000,1);
												ResetPlayerWeapons(giveplayerid);
											}
										} else {
										    return SendClientMessage(playerid, BANRED, "This player is already in jail");
										}
							        } else {
						    			return SendClientMessage(playerid, BANRED, "You need to be at the jail cell (skull pickup) at the LVPD HQ");
									}
								} else {
								    return SendClientMessage(playerid, BANRED, "You can't jail other cops, admins, or the mayor");
								}
							} else {
							    return SendClientMessage(playerid, BANRED, "You can't jail yourself");
							}
         				} else {
							return SendClientMessage(playerid, BANRED, "You can't jail yourself");
						}
					} else {
	    				return SendClientMessage(playerid, BANRED, "No such player");
					}
				} else {
					return SendClientMessage(playerid, BANRED, "Your still on break (/break)");
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/paybail", true,8) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = ReturnUser(tmp);
  		if(jailed[playerid] == 1)
    	{
     		if(inbail[playerid] == 1)
       		{
         		if(GetPlayerMoney(playerid) >= inbailprice[playerid])
           		{
					KillTimer(JailCDt);
					jailtime[playerid] = 0;
					jailed[playerid] = 0;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "You paid your bail, I don't want to see you back here again!");
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, 2286.6458,2421.2732,10.8203);
					GivePlayerMoney(playerid,-inbailprice[playerid]);
 				} else {
     				return SendClientMessage(playerid, BANRED, "You don't have enough money to pay your bail");
				}
			} else {
			    return SendClientMessage(playerid, BANRED, "You don't have have bail");
			}
		} else {
		    return SendClientMessage(playerid, BANRED, "You aren't in jail");
		}
		return 1;
	}
	if(strcmp(cmd, "/taze", true,5) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gTeam[playerid] == COP)
		    {
				tmp = strtok(cmdtext, idx);
				playa = ReturnUser(tmp);
				if(!strlen(tmp))
				{
					return SendClientMessage(playerid, BANRED, "USAGE: /taze [id/name]");
				}
				if(onbreak[playerid] == 0)
				{
					if(IsPlayerConnected(playa))
					{
					    if(playa != INVALID_PLAYER_ID)
					    {
							if(playa != playerid)
							{
						        if(PlayerDistance(4.0,playerid,playa))
						        {
						            if(gTeam[giveplayerid] != COP)
						            {
								    	new string[256];
								    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
										GetPlayerName(playerid, sendername, sizeof(sendername));
					   					format(string, sizeof(string), "** You tazed %s",giveplayer,money);
										SendClientMessage(playerid, COLOR_AQUA, string);
										format(string, sizeof(string), "** LVPD officer %s tazed you",sendername,money);
										SendClientMessage(playa, COLOR_AQUA, string);
										new Float:heal;
										GetPlayerHealth(playa, heal);
										SetPlayerHealth(playa, heal - 20);
										ApplyAnimation(playa, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0);
									} else {
									    return SendClientMessage(playerid, BANRED, "You can't taze other cops");
									}
								} else {
	    							return SendClientMessage(playerid, BANRED, "That player isn't near you");
	        					}
        					} else {
        					    return SendClientMessage(playerid, COLOR_LBLUE, "You can't taze yourself");
        					}
						}
					} else {
					    return SendClientMessage(playerid, BANRED, "No such player");
					}
				} else {
				    return SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
				}
			} else {
			    return SendClientMessage(playerid, BANRED, "Your not a cop!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/selldrug", true,9) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new tmp2[256], tmp3[256];
			tmp = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			tmp3 = strtok(cmdtext, idx);
			playa = ReturnUser(tmp);
			drugid = strval(tmp2);
			money = strval(tmp3);
		    if(gJob[playerid] != DRUGS)
		    {
		        return SendClientMessage(playerid, BANRED, "Your not a drug dealer!!");
		    }
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, BANRED, "USAGE: /selldrug [playerid] [drugid] [price]");
				SendClientMessage(playerid, COLOR_GRAY, "1. Weed     2. Cocaine     3. Meth");
				SendClientMessage(playerid, COLOR_GRAY, "4. Crack    5. Acid        6. Purple Haze");
			} else if(!strlen(tmp2))
			{
				SendClientMessage(playerid, BANRED, "USAGE: /selldrug [playerid] [drugid] [price]");
				SendClientMessage(playerid, COLOR_GRAY, "1. Weed     2. Cocaine     3. Meth");
				SendClientMessage(playerid, COLOR_GRAY, "4. Crack    5. Acid        6. Purple Haze");
			} else if(!strlen(tmp3))
			{
				SendClientMessage(playerid, BANRED, "USAGE: /selldrug [playerid] [drugid] [price]");
				SendClientMessage(playerid, COLOR_GRAY, "1. Weed     2. Cocaine     3. Meth");
				SendClientMessage(playerid, COLOR_GRAY, "4. Crack    5. Acid        6. Purple Haze");
			} else
			if(money < 1 || money > 900) { SendClientMessage(playerid, BANRED, "Price can not be lower than 1, cannot be higher than 900"); return 1; }
			if(onbreak[playerid] == 0)
			{
				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
				        if(playa != playerid)
				        {
					        if(PlayerDistance(8.0,playerid,playa))
					        {
						        if(drugid == 1)
						        {
							    	new string[256];
							    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
				   					format(string, sizeof(string), "** You offered %s weed for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Drug dealer %s offers weed for $%d. (/acceptdrug or /denydrug)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									WeedOffer[playa] = playerid;
									WeedPrice[playa] = money;
								} else if(drugid == 2)
						        {
							    	new string[256];
					  				if(playa == playerid) { SendClientMessage(playerid, BANRED, "You can't sell drugs to yourself yourself"); return 1; }
							    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
				   					format(string, sizeof(string), "** You offered %s cocaine for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Drug dealer %s offers cocaine for $%d. (/acceptdrug or /denydrug)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									CocaineOffer[playa] = playerid;
									CocainePrice[playa] = money;
								} else if(drugid == 3)
						        {
							    	new string[256];
					  				if(playa == playerid) { SendClientMessage(playerid, BANRED, "You can't sell drugs to yourself yourself"); return 1; }
							    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
				   					format(string, sizeof(string), "** You offered %s meth for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Drug dealer %s offers meth for $%d. (/acceptdrug or /denydrug)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									MethOffer[playa] = playerid;
									MethPrice[playa] = money;
								} else if(drugid == 4)
						        {
							    	new string[256];
					  				if(playa == playerid) { SendClientMessage(playerid, BANRED, "You can't sell drugs to yourself yourself"); return 1; }
							    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
				   					format(string, sizeof(string), "** You offered %s crack for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Drug dealer %s offers crack for $%d. (/acceptdrug or /denydrug)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									CrackOffer[playa] = playerid;
									CrackPrice[playa] = money;
								} else if(drugid == 5)
						        {
							    	new string[256];
					  				if(playa == playerid) { SendClientMessage(playerid, BANRED, "You can't sell drugs to yourself yourself"); return 1; }
							    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
				   					format(string, sizeof(string), "** You offered %s acid for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Drug dealer %s offers acid for $%d. (/acceptdrug or /denydrug)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									AcidOffer[playa] = playerid;
									AcidPrice[playa] = money;
								} else if(drugid == 6)
						        {
							    	new string[256];
					  				if(playa == playerid) { SendClientMessage(playerid, BANRED, "You can't sell drugs to yourself yourself"); return 1; }
							    	GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									GetPlayerName(playerid, sendername, sizeof(sendername));
				   					format(string, sizeof(string), "** You offered %s purple haze for $%d",giveplayer,money);
									SendClientMessage(playerid, COLOR_AQUA, string);
									format(string, sizeof(string), "** Drug dealer %s offers purple haze for $%d. (/acceptdrug or /denydrug)",sendername,money);
									SendClientMessage(playa, COLOR_AQUA, string);
									HazeOffer[playa] = playerid;
									HazePrice[playa] = money;
								}
							} else {
	    						return SendClientMessage(playerid, BANRED, "That player isn't near you");
	        				}
        				} else {
        				    return SendClientMessage(playerid, COLOR_LBLUE, "You can't sell yourself drugs");
        				}
					}
				} else {
			    	SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
				}
			}
			else
			{
			    SendClientMessage(playerid, BANRED, "No such player");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/goodtime", true,9) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gJob[playerid] != WHORE)
		    {
		        SendClientMessage(playerid, BANRED, "Your not a whore!!");
		        return 1;
		    }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, BANRED, "USAGE: /goodtime [playerid/name] [price]");
				return 1;
			}
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if(money < 1 || money > 900) { SendClientMessage(playerid, BANRED, "Price can not be lower than 1, cannot be higher than 900"); return 1; }
			if(onbreak[playerid] == 0)
			{
				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
				        if(playa != playerid)
				        {
					        if(IsPlayerInAnyVehicle(playerid))
					        {
					            if(IsPlayerInVehicle(giveplayerid,GetPlayerVehicleID(playerid)))
					            {
					                if(PlayerDistance(8.0,playerid,playa))
					                {
								    	new string[256];
									    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
										GetPlayerName(playerid, sendername, sizeof(sendername));
					   					format(string, sizeof(string), "** You offered to have a good time with %s for $%d",giveplayer,money);
										SendClientMessage(playerid, COLOR_AQUA, string);
										format(string, sizeof(string), "** Whore %s offers to have a good time with you for $%d. (/acceptgt or /denygt)",sendername,money);
										SendClientMessage(playa, COLOR_AQUA, string);
										GTOffer[playa] = playerid;
										GTPrice[playa] = money;
									} else {
	    								return SendClientMessage(playerid, BANRED, "That player isn't near you");
	        						}
								} else {
								    SendClientMessage(playerid, BANRED, "That player needs to be in your car");
								}
							} else {
							    SendClientMessage(playerid, BANRED, "You need to be in a car");
							}
						} else {
						    return SendClientMessage(playerid, COLOR_LBLUE, "You can't have sex with yourself");
						}
					}
				} else {
				    SendClientMessage(playerid, BANRED, "No such player");
				}
			} else {
			    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ticket", true,7) == 0)
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
 		new string[256];
	    if(IsPlayerConnected(playerid))
	    {
		    if(gTeam[playerid] == COP)
		    {
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, BANRED, "USAGE: /ticket [playerid/name] [price] [reason]");
					return 1;
				}
				if(!strlen((result)))
				{
					SendClientMessage(playerid, BANRED, "USAGE: /ticket [playerid/name] [price] [reason]");
					return 1;
				}
				playa = ReturnUser(tmp);
				tmp = strtok(cmdtext, idx);
				money = strval(tmp);
				if(money < 1 || money > 900) { SendClientMessage(playerid, BANRED, "Price can not be lower than 1, cannot be higher than 900"); return 1; }
				if(onbreak[playerid] == 0)
				{
					if(IsPlayerConnected(playa))
					{
					    if(playa != INVALID_PLAYER_ID)
					    {
					        if(playa != playerid)
					        {
						        if(PlayerDistance(8.0,playerid,playa))
						        {
  								    if(gTeam[playa] != COP || gTeam[playa] != MAYOR)
									{
									    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
										GetPlayerName(playerid, sendername, sizeof(sendername));
					   					format(string, sizeof(string), "** You are giving %s a ticket, Cost: $%d, Reason: %s",giveplayer,money,(result));
										SendClientMessage(playerid, COLOR_AQUA, string);
										format(string, sizeof(string), "** Officer %s is giving you a ticket, Cost: $%d, Reason: %s (/acceptticket)",sendername,money,(result));
										SendClientMessage(playa, COLOR_AQUA, string);
										TicketOffer[playa] = playerid;
										TicketPrice[playa] = money;
									} else {
									    return SendClientMessage(playerid, BANRED, "You can't give another cop or the mayor a ticket");
									}
								} else {
	    							return SendClientMessage(playerid, BANRED, "That player isn't near you");
	        					}
        					} else {
        					    return SendClientMessage(playerid, COLOR_LBLUE, "You can't give yourself a ticket");
        					}
						}
					}
					else
					{
					    SendClientMessage(playerid, BANRED, "No such player");
					}
				} else {
				    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
				}
			} else {
			    SendClientMessage(playerid, BANRED, "Your not a cop!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/drop", true,5) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gJob[playerid] != MAIL)
		    {
		        return SendClientMessage(playerid, BANRED, "Your not a package deliverer!!");
		    }
		    if(onbreak[playerid] == 0)
		    {
				if(count4 > 0) {
					return SendClientMessage(playerid, COLOR_RED, "Please wait 10 minutes before getting another package");
				} else if(count4 <= 0) {
					MailDrop(playerid);
					count4 = 600;
					count4t = SetTimer("MailDrop3", 1000, 1);
				}
			} else {
			    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/import", true,7) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    if(gJob[playerid] != IMPORT)
		    {
		        return SendClientMessage(playerid, BANRED, "Your not a car importer!!");
		    }
		    if(onbreak[playerid] == 0)
		    {
				if(count5 > 0) {
					return SendClientMessage(playerid, COLOR_RED, "Please wait 10 minutes before importing another car");
				} else if(count5 <= 0) {
					if(IsPlayerInAnyVehicle(playerid))
					{
						SetPlayerCheckpoint(playerid, 1024.4423,2111.4604,10.8203, 10);
						SendClientMessage(playerid, COLOR_YELLOW, "Take this car to the drop off");
						count5 = 600;
						count5t = SetTimer("Count5", 1000, 1);
					} else {
						SendClientMessage(playerid, COLOR_YELLOW, "Your not in a CAR/BIKE");
					}
				}
			} else {
			    SendClientMessage(playerid, COLOR_GRAY, "** You are still on break (/break)");
			}
		}
		return 1;
	}

//=================================ACCEPT=======================================
	
	if(strcmp(cmd,"/acceptfuel",true,11) == 0)
	{
		if(RefillOffer[playerid] < 999)
  		{
			if(IsPlayerConnected(RefillOffer[playerid]))
   			{
      			if(GetPlayerMoney(playerid) > RefillPrice[playerid])
         		{
					if(Petrol[Vi] < 100)
					{
						if(Petrol[Vi] != 100)
						{
							Petrol[Vi] += Petrol[Vi];
		           			GetPlayerName(RefillOffer[playerid], giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
		     				new fuel = 50;
							new string[256];
		     				format(string, sizeof(string), "* You refilled your car with %d%, for $%d by Car Mechanic %s.",fuel,RefillPrice[playerid],giveplayer);
							SendClientMessage(playerid, COLOR_AQUA, string);
							format(string, sizeof(string), "* You refilled %s's car with %d% amount of gas for %d",sendername,fuel,RefillPrice[playerid]);
							SendClientMessage(RefillOffer[playerid], COLOR_AQUA, string);
							GivePlayerMoney(playerid, -RefillPrice[playerid]);
		     				GivePlayerMoney(RefillOffer[playa], RefillPrice[playa]);
		     				RefillOffer[playerid] = 999;
							RefillPrice[playerid] = 0;
						} else {
						    SendClientMessage(playerid, BANRED, "Your tank tank is full");
						    SendClientMessage(RefillOffer[playerid], BANRED, "That player's tank is full");
		     				RefillOffer[playerid] = 999;
							RefillPrice[playerid] = 0;
						}
					}
 				} else {
				    SendClientMessage(playerid, BANRED, "You don't have enough money");
				}
 			}
   		} else {
   			SendClientMessage(playerid, BANRED, "No fuel offers");
		}
    	return 1;
	}
	if(strcmp(cmd,"/acceptrepair",true,13) == 0)
	{
		if(RepairOffer[playerid] < 999)
		{
			if(IsPlayerConnected(RepairOffer[playerid]))
	   		{
   				if(GetPlayerMoney(playerid) > RepairPrice[playerid])
     			{
     				GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
	     			new vehicleid = GetPlayerVehicleID(playerid);
					new string[256];
 					format(string, sizeof(string), "** You repaired your car for $%d by Car Mechanic %s.",RepairPrice[playerid],giveplayer);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** You repaired %s's car for $%d",sendername,RepairPrice[playerid]);
					SendClientMessage(RepairOffer[playerid], COLOR_AQUA, string);
					GivePlayerMoney(playerid, -RepairPrice[playerid]);
     				GivePlayerMoney(RepairOffer[playa], RepairPrice[playa]);
					SetVehicleHealth(vehicleid, 1000);
	     			RepairOffer[playerid] = 999;
					RepairPrice[playerid] = 0;
  				} else {
		    		SendClientMessage(playerid, BANRED, "You don't have enough money");
				}
  			}
    	} else {
      		SendClientMessage(playerid, BANRED, "No repair offers");
		}
 		return 1;
	}
	if(strcmp(cmd,"/acceptheal",true,11) == 0)
	{
		if(HealOffer[playerid] < 999)
		{
			if(IsPlayerConnected(HealOffer[playerid]))
			{
				if(GetPlayerMoney(playerid) > HealPrice[playerid])
  				{
   					GetPlayerName(HealOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new string[256];
					format(string, sizeof(string), "** You were healed by Medic %s for $%d.",giveplayer,HealPrice[playerid]);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** You healed %s for $%d",sendername,HealPrice[playerid]);
					SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
					GivePlayerMoney(playerid, -HealPrice[playerid]);
 					GivePlayerMoney(HealOffer[playa], HealPrice[playa]);
					SetPlayerHealth(playerid, 100);
 					HealOffer[playerid] = 999;
					HealPrice[playerid] = 0;
  				} else {
		    		SendClientMessage(playerid, BANRED, "You don't have enough money");
				}
			}
		} else {
      		SendClientMessage(playerid, BANRED, "No healing offers");
		}
		return 1;
	}
	if(strcmp(cmd,"/acceptdrug",true,11) == 0)
	{
		if(drugid == 1)
		{
			if(WeedOffer[playerid] < 999)
			{
				if(IsPlayerConnected(WeedOffer[playerid]))
				{
					if(GetPlayerMoney(playerid) > WeedPrice[playerid])
	  				{
  						GetPlayerName(WeedOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new string[256];
						format(string, sizeof(string), "** You bought weed from %s for $%d.",giveplayer,WeedPrice[playerid]);
						SendClientMessage(playerid, COLOR_AQUA, string);
						format(string, sizeof(string), "** You sold weed to %s for $%d",sendername,WeedPrice[playerid]);
						SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
						GivePlayerMoney(playerid, -WeedPrice[playerid]);
						GivePlayerMoney(WeedOffer[playa], WeedPrice[playa]);
						WeedOffer[playerid] = 999;
						WeedPrice[playerid] = 0;
						SetPlayerHealth(playerid, 25);
					} else {
   						SendClientMessage(playerid, BANRED, "You don't have enough money");
					}
				}
			} else {
      			SendClientMessage(playerid, BANRED, "No drug offers");
			}
		} else if(drugid == 2)
		{
			if(CocaineOffer[playerid] < 999)
			{
				if(IsPlayerConnected(CocaineOffer[playerid]))
				{
					if(GetPlayerMoney(playerid) > CocainePrice[playerid])
	  				{
  						GetPlayerName(CocaineOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new string[256];
						format(string, sizeof(string), "** You bought cocaine from %s for $%d.",giveplayer,CocainePrice[playerid]);
						SendClientMessage(playerid, COLOR_AQUA, string);
						format(string, sizeof(string), "** You sold cocaine to %s for $%d",sendername,CocainePrice[playerid]);
						SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
						GivePlayerMoney(playerid, -CocainePrice[playerid]);
						GivePlayerMoney(CocaineOffer[playa], CocainePrice[playa]);
						CocaineOffer[playerid] = 999;
						CocainePrice[playerid] = 0;
						SetPlayerHealth(playerid, 25);
					} else {
   						SendClientMessage(playerid, BANRED, "You don't have enough money");
					}
				}
			} else {
      			SendClientMessage(playerid, BANRED, "No drug offers");
			}
		} else if(drugid == 3)
		{
			if(MethOffer[playerid] < 999)
			{
				if(IsPlayerConnected(MethOffer[playerid]))
				{
					if(GetPlayerMoney(playerid) > MethPrice[playerid])
	  				{
  						GetPlayerName(MethOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new string[256];
						format(string, sizeof(string), "** You bought meth from %s for $%d.",giveplayer,MethPrice[playerid]);
						SendClientMessage(playerid, COLOR_AQUA, string);
						format(string, sizeof(string), "** You sold meth to %s for $%d",sendername,MethPrice[playerid]);
						SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
						GivePlayerMoney(playerid, -MethPrice[playerid]);
						GivePlayerMoney(MethOffer[playa], MethPrice[playa]);
						MethOffer[playerid] = 999;
						MethPrice[playerid] = 0;
						SetPlayerHealth(playerid, 25);
					} else {
   						SendClientMessage(playerid, BANRED, "You don't have enough money");
					}
				}
			} else {
      			SendClientMessage(playerid, BANRED, "No drug offers");
			}
		} else if(drugid == 4)
		{
			if(CrackOffer[playerid] < 999)
			{
				if(IsPlayerConnected(CrackOffer[playerid]))
				{
					if(GetPlayerMoney(playerid) > CrackPrice[playerid])
	  				{
  						GetPlayerName(CrackOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new string[256];
						format(string, sizeof(string), "** You bought crack from %s for $%d.",giveplayer,CrackPrice[playerid]);
						SendClientMessage(playerid, COLOR_AQUA, string);
						format(string, sizeof(string), "** You sold crack to %s for $%d",sendername,CrackPrice[playerid]);
						SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
						GivePlayerMoney(playerid, -CrackPrice[playerid]);
						GivePlayerMoney(CrackOffer[playa], CrackPrice[playa]);
						CrackOffer[playerid] = 999;
						CrackPrice[playerid] = 0;
						SetPlayerHealth(playerid, 25);
					} else {
   						SendClientMessage(playerid, BANRED, "You don't have enough money");
					}
				}
			} else {
      			SendClientMessage(playerid, BANRED, "No drug offers");
			}
		} else if(drugid == 5)
		{
			if(AcidOffer[playerid] < 999)
			{
				if(IsPlayerConnected(AcidOffer[playerid]))
				{
					if(GetPlayerMoney(playerid) > AcidPrice[playerid])
	  				{
  						GetPlayerName(AcidOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new string[256];
						format(string, sizeof(string), "** You bought acid from %s for $%d.",giveplayer,AcidPrice[playerid]);
						SendClientMessage(playerid, COLOR_AQUA, string);
						format(string, sizeof(string), "** You sold acid to %s for $%d",sendername,AcidPrice[playerid]);
						SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
						GivePlayerMoney(playerid, -AcidPrice[playerid]);
						GivePlayerMoney(AcidOffer[playa], AcidPrice[playa]);
						AcidOffer[playerid] = 999;
						AcidPrice[playerid] = 0;
						SetPlayerHealth(playerid, 25);
					} else {
   						SendClientMessage(playerid, BANRED, "You don't have enough money");
					}
				}
			} else {
      			SendClientMessage(playerid, BANRED, "No drug offers");
			}
		} else if(drugid == 6)
		{
			if(HazeOffer[playerid] < 999)
			{
				if(IsPlayerConnected(HazeOffer[playerid]))
				{
					if(GetPlayerMoney(playerid) > HazePrice[playerid])
	  				{
  						GetPlayerName(HazeOffer[playerid], giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new string[256];
						format(string, sizeof(string), "** You bought purple haze from %s for $%d.",giveplayer,HazePrice[playerid]);
						SendClientMessage(playerid, COLOR_AQUA, string);
						format(string, sizeof(string), "** You sold pueple haze to %s for $%d",sendername,HazePrice[playerid]);
						SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
						GivePlayerMoney(playerid, -HazePrice[playerid]);
						GivePlayerMoney(HazeOffer[playa], HazePrice[playa]);
						HazeOffer[playerid] = 999;
						HazePrice[playerid] = 0;
						SetPlayerHealth(playerid, 25);
					} else {
   						SendClientMessage(playerid, BANRED, "You don't have enough money");
					}
				}
			}
		} else {
      		SendClientMessage(playerid, BANRED, "No drug offers");
		}
		return 1;
	}
	if(strcmp(cmd,"/acceptgt",true,9) == 0)
	{
		if(GTOffer[playerid] < 999)
		{
			if(IsPlayerConnected(GTOffer[playerid]))
			{
				if(GetPlayerMoney(playerid) > GTPrice[playerid])
				{
				    new rands = random(sizeof(SexTalk));
					GetPlayerName(GTOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new string[256];
					format(string, sizeof(string), "** You are having sex with %s for $%d.",giveplayer, GTPrice[playerid]);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** You are having sex with %s for $%d",sendername,GTPrice[playerid]);
					SendClientMessage(GTOffer[playerid], COLOR_AQUA, string);
					GivePlayerMoney(playerid, -GTPrice[playerid]);
					GivePlayerMoney(GTOffer[playa], GTPrice[playa]);
					GameTextForPlayer(playerid, SexTalk[rands][0], 3500, 3);
					GameTextForPlayer(GTOffer[playerid], SexTalk[rands][0], 3500, 3);
					std[playa]++;
					if(std[playa] == 5)
					{
	    				new rand = random(sizeof(STI));
    					format(string, sizeof(string), "** %s had sex with %s and gained %s!",giveplayer, sendername, STI[rand][0]);
						SendClientMessageToAll(COLOR_RED, string);
						std[playa] = 0;
						givenstd[playerid] = 1;
					}
					GTOffer[playerid] = 999;
					GTPrice[playerid] = 0;
				} else {
 					SendClientMessage(playerid, BANRED, "You don't have enough money");
	  			}
		   	}
		} else {
	   		SendClientMessage(playerid, BANRED, "No good time offers");
		}
     	return 1;
   	}
	if(strcmp(cmd,"/acceptticket",true,13) == 0)
	{
		if(TicketOffer[playerid] < 999)
		{
			if(IsPlayerConnected(TicketOffer[playerid]))
			{
				if(GetPlayerMoney(playerid) > TicketPrice[playerid])
				{
					GetPlayerName(TicketOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new string[256];
					format(string, sizeof(string), "** You accepted the ticket from officer %s costing $%d.",giveplayer, TicketPrice[playerid]);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** You gave the ticket to %s costing $%d",sendername,TicketPrice[playerid]);
					SendClientMessage(TicketOffer[playerid], COLOR_AQUA, string);
					GivePlayerMoney(playerid, -TicketPrice[playerid]);
					GivePlayerMoney(TicketOffer[playa], TicketPrice[playa]);
					tickets[playerid]++;
					TicketOffer[playerid] = 999;
					TicketPrice[playerid] = 0;
				} else {
 					SendClientMessage(playerid, BANRED, "You don't have enough money");
	  			}
		   	}
		} else {
	   		SendClientMessage(playerid, BANRED, "No ticket offers");
		}
     	return 1;
   	}
	
//=========================DENY=================================================
 	
	if(strcmp(cmd,"/denyfuel",true,9) == 0)
	{
		if(RefillOffer[playerid] < 999)
  		{
			if(IsPlayerConnected(RefillOffer[playerid]))
   			{
      			new string [256];
      			GetPlayerName(RefillOffer[playerid], giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "** You denied mechanic %s's re-fuel offer.",giveplayer);
				SendClientMessage(playerid, COLOR_AQUA, string);
				format(string, sizeof(string), "** %s denied your offer for fuel",sendername);
				SendClientMessage(RefillOffer[playerid], COLOR_AQUA, string);
				RefillOffer[playerid] = 999;
				RefillPrice[playerid] = 0;
         	}
		} else {
	    	SendClientMessage(playerid, BANRED, "Nothing to deny");
		}
		return 1;
	}
	if(strcmp(cmd,"/denyrepair",true,11) == 0)
	{
		if(RepairOffer[playerid] < 999)
  		{
			if(IsPlayerConnected(RepairOffer[playerid]))
   			{
				new string [256];
 				GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "** You denied mechanic %s's repair offer.",giveplayer);
				SendClientMessage(playerid, COLOR_AQUA, string);
				format(string, sizeof(string), "** %s denied your offer for a repair",sendername);
				SendClientMessage(RepairOffer[playerid], COLOR_AQUA, string);
				RepairOffer[playerid] = 999;
				RepairPrice[playerid] = 0;
				return 1;
			}
 		} else {
	    	SendClientMessage(playerid, BANRED, "Nothing to deny");
		    return 1;
		}
	}
	if(strcmp(cmd,"/denyheal",true,9) == 0)
	{
		if(HealOffer[playerid] < 999)
  		{
			if(IsPlayerConnected(HealOffer[playerid]))
   			{
				new string [256];
 				GetPlayerName(HealOffer[playerid], giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "** You denied medic %s's heath offer.",giveplayer);
				SendClientMessage(playerid, COLOR_AQUA, string);
				format(string, sizeof(string), "** %s denied your offer for health",sendername);
				SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
				HealOffer[playerid] = 999;
				HealPrice[playerid] = 0;
				return 1;
			}
 		} else {
	    	SendClientMessage(playerid, BANRED, "Nothing to deny");
		    return 1;
		}
	}
	if(strcmp(cmd,"/denygt",true,7) == 0)
	{
		if(HealOffer[playerid] < 999)
  		{
			if(IsPlayerConnected(HealOffer[playerid]))
   			{
				new string [256];
 				GetPlayerName(GTOffer[playerid], giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "** You denied whore %s's offer of a good time",giveplayer);
				SendClientMessage(playerid, COLOR_AQUA, string);
				format(string, sizeof(string), "** %s denied your offer of a good time",sendername);
				SendClientMessage(GTOffer[playerid], COLOR_AQUA, string);
				RepairOffer[playerid] = 999;
				RepairPrice[playerid] = 0;
				return 1;
			}
 		} else {
	    	SendClientMessage(playerid, BANRED, "Nothing to deny");
		    return 1;
		}
	}
	if(strcmp(cmd,"/denydrug",true,9) == 0)
	{
	    if(drugid == 1)
	    {
			if(WeedOffer[playerid] < 999)
	  		{
				if(IsPlayerConnected(WeedOffer[playerid]))
	   			{
					new string [256];
	 				GetPlayerName(WeedOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "** You denied drug dealer %s's offer for weed",giveplayer);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** %s denied your offer for weed",sendername);
					SendClientMessage(WeedOffer[playerid], COLOR_AQUA, string);
					WeedOffer[playerid] = 999;
					WeedPrice[playerid] = 0;
					return 1;
				}
	 		} else {
		    	SendClientMessage(playerid, BANRED, "Nothing to deny");
			    return 1;
			}
		} else if(drugid == 2)
	    {
			if(CocaineOffer[playerid] < 999)
	  		{
				if(IsPlayerConnected(CocaineOffer[playerid]))
	   			{
					new string [256];
	 				GetPlayerName(CocaineOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "** You denied drug dealer %s's offer for cocaine",giveplayer);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** %s denied your offer for cocaine",sendername);
					SendClientMessage(CocaineOffer[playerid], COLOR_AQUA, string);
					CocaineOffer[playerid] = 999;
					CocainePrice[playerid] = 0;
					return 1;
				}
	 		} else {
		    	SendClientMessage(playerid, BANRED, "Nothing to deny");
			    return 1;
			}
		} else if(drugid == 3)
	    {
			if(MethOffer[playerid] < 999)
	  		{
				if(IsPlayerConnected(MethOffer[playerid]))
	   			{
					new string [256];
	 				GetPlayerName(MethOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "** You denied drug dealer %s's offer for meth",giveplayer);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** %s denied your offer for meth",sendername);
					SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
					MethOffer[playerid] = 999;
					MethPrice[playerid] = 0;
					return 1;
				}
	 		} else {
		    	SendClientMessage(playerid, BANRED, "Nothing to deny");
			    return 1;
			}
		} else if(drugid == 4)
	    {
			if(CrackOffer[playerid] < 999)
	  		{
				if(IsPlayerConnected(CrackOffer[playerid]))
	   			{
					new string [256];
	 				GetPlayerName(CrackOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "** You denied drug dealer %s's offer for crack",giveplayer);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** %s denied your offer for crack",sendername);
					SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
					CrackOffer[playerid] = 999;
					CrackPrice[playerid] = 0;
					return 1;
				}
	 		} else {
		    	SendClientMessage(playerid, BANRED, "Nothing to deny");
			    return 1;
			}
		} else if(drugid == 5)
	    {
			if(AcidOffer[playerid] < 999)
	  		{
				if(IsPlayerConnected(AcidOffer[playerid]))
	   			{
					new string [256];
	 				GetPlayerName(AcidOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "** You denied drug dealer %s's offer for acid",giveplayer);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** %s denied your offer for acid",sendername);
					SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
					AcidOffer[playerid] = 999;
					AcidPrice[playerid] = 0;
					return 1;
				}
	 		} else {
		    	SendClientMessage(playerid, BANRED, "Nothing to deny");
			    return 1;
			}
		} else if(drugid == 6)
	    {
			if(HazeOffer[playerid] < 999)
	  		{
				if(IsPlayerConnected(HazeOffer[playerid]))
	   			{
					new string [256];
	 				GetPlayerName(HazeOffer[playerid], giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "** You denied drug dealer %s's offer for purple haze",giveplayer);
					SendClientMessage(playerid, COLOR_AQUA, string);
					format(string, sizeof(string), "** %s denied your offer for purple haze",sendername);
					SendClientMessage(HealOffer[playerid], COLOR_AQUA, string);
					HazeOffer[playerid] = 999;
					HazePrice[playerid] = 0;
					return 1;
				}
	 		} else {
		    	SendClientMessage(playerid, BANRED, "Nothing to deny");
			    return 1;
			}
		}
	}
	if(strcmp(cmd,"/kill",true,5) == 0)
	{
		SetPlayerHealth(playerid, 0);
		return 1;
	}
	if(strcmp(cmd, "/help", true,5) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "===============Help============");
		SendClientMessage(playerid, COLOR_GREEN, "/RULES, /cmds, /jobs, /life, /families, /licenses, /licensing");
        SendClientMessage(playerid, COLOR_GREEN, "/ganghelp, /casinohelp");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/jobs", cmd, true,5) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "============Jobs pg. 1=========");
		SendClientMessage(playerid, COLOR_GREEN, "There are different jobs you can get to make some extra cash");
		SendClientMessage(playerid, COLOR_GREEN, "Faction jobs (jobs that have to be requested) can't be obtained ingame");
		SendClientMessage(playerid, COLOR_GREEN, "To get a faction job you must visit the forum and apply there");
		SendClientMessage(playerid, COLOR_GREEN, "If accepted, your user file will be updated");
		SendClientMessage(playerid, COLOR_GREEN, "The next time you login, you will be in that faction group");
		SendClientMessage(playerid, COLOR_GRAY, "Now please do /jobs2");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/jobs2", cmd, true,6) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "============Jobs pg. 2=========");
		SendClientMessage(playerid, COLOR_GREEN, "In-game jobs such as mechanic can be aquired by visiting the Job Market");
 		SendClientMessage(playerid, COLOR_GREEN, "The Job Market is a building where you can apply for a non-faction job");
		SendClientMessage(playerid, COLOR_GREEN, "Once there, enter the checkpoint, and a list of jobs in a menu will appear");
		SendClientMessage(playerid, COLOR_GREEN, "The Job Market is the yellow icon on your map behind The Camel's Toe Casino");
		SendClientMessage(playerid, COLOR_GRAY, "Now please do /joblist");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/joblist", cmd, true,8) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=============Jobs List=========");
		SendClientMessage(playerid, COLOR_GREEN, "In-Game: Mechanic, Medic, Whore, Drug Dealer, Car Imports, Package Delivery");
		SendClientMessage(playerid, COLOR_GREEN, "Faction: Bus, Taxi, Cop, Driving Instructor, Pilot Instructor");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/life", cmd, true,5) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=============Life pg. 1========");
		SendClientMessage(playerid, COLOR_GREEN, "Welcome to Las Venturas, a glitzy city of fame and gambling");
		SendClientMessage(playerid, COLOR_GREEN, "Here, you can join a family faction (see /families), get a job, or relax");
		SendClientMessage(playerid, COLOR_GREEN, "It is vital you eat and get a job (see /jobs) because if you don't eat, you will die");
		SendClientMessage(playerid, COLOR_GREEN, "If you don't get a job you will be broke and lose everything!");
		SendClientMessage(playerid, COLOR_GRAY, "Now please do /life2");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/life2", cmd, true,6) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=============Life pg. 2========");
		SendClientMessage(playerid, COLOR_GREEN, "Here you can buy houses and own cars (/showhouses to see all houses for sale)");
		SendClientMessage(playerid, COLOR_GREEN, "To drive, fly, boat, or carry weapons you must get a licence. For a driving licence, visit the DMV near the Stadium");
		SendClientMessage(playerid, COLOR_GREEN, "To get a flying license, visit the Abandoned Airfield");
		SendClientMessage(playerid, COLOR_GREEN, "To get a weapon license visit the Ammunation at the Strip");
		SendClientMessage(playerid, COLOR_GREEN, "To get a boating licence visit the boating school near the Gant Bridge");
		SendClientMessage(playerid, COLOR_GRAY, "Now please do /life3");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/life3", cmd, true,6) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=============Life pg. 3========");
		SendClientMessage(playerid, COLOR_GREEN, "Being a bad person will get you arrested");
		SendClientMessage(playerid, COLOR_GREEN, "Always stay on your game and do the right thing or the LVPD will get involved");
		SendClientMessage(playerid, COLOR_GREEN, "Offences like driving on the wrong side of the road will get you a ticket and a fine");
		SendClientMessage(playerid, COLOR_GREEN, "Too many tickets could result in you losing your license so always be safe");
		SendClientMessage(playerid, COLOR_GRAY, "Now please do /life4");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/life4", cmd, true,6) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=============Life pg. 4========");
		SendClientMessage(playerid, COLOR_GREEN, "Cops are always on alert, if you do anything bad, they will know");
		SendClientMessage(playerid, COLOR_GREEN, "More serious offences include killing and rape which will get you arrested");
		SendClientMessage(playerid, COLOR_RED, "You have just finished reading the basics of this server. Enjoy your time here");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/families", cmd, true,9) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=============Families==========");
		SendClientMessage(playerid, COLOR_GREEN, "On this server there are only 3 families");
		SendClientMessage(playerid, COLOR_GREEN, "A family is a fancy way of saying gang");
		SendClientMessage(playerid, COLOR_GREEN, "To be in a family you must apply at the forums");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/cmds", cmd, true,5) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=============Commands==========");
		SendClientMessage(playerid, COLOR_GREEN, "/jobcmds - Job Commands");
		SendClientMessage(playerid, COLOR_GREEN, "/ocmds - Other Commands");
		SendClientMessage(playerid, COLOR_GREEN, "/fcmds - Faction Commands");
		SendClientMessage(playerid, COLOR_GREEN, "@[message] - Gang Chat (/ganghelp)");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/jobcmds", cmd, true,8) == 0)
	{
		if(gJob[playerid] == MECHANIC) {
			SendClientMessage(playerid, COLOR_GRAY, "=========Job Commands========");
			SendClientMessage(playerid, COLOR_GREEN, "Mechanic: /repair, /fuel, /break, /jobquit");
			SendClientMessage(playerid, COLOR_GRAY, "============================");
		} else if(gJob[playerid] == MEDIC) {
			SendClientMessage(playerid, COLOR_GRAY, "=========Job Commands========");
			SendClientMessage(playerid, COLOR_GREEN, "Medic: /heal, /break, /jobquit");
			SendClientMessage(playerid, COLOR_GRAY, "============================");
		} else if(gJob[playerid] == WHORE) {
			SendClientMessage(playerid, COLOR_GRAY, "=========Job Commands========");
			SendClientMessage(playerid, COLOR_GREEN, "Whore: /goodtime, /break, /jobquit");
			SendClientMessage(playerid, COLOR_GRAY, "============================");
		} else if(gJob[playerid] == DRUGS) {
			SendClientMessage(playerid, COLOR_GRAY, "=========Job Commands========");
			SendClientMessage(playerid, COLOR_GREEN, "Drug Dealer: /selldrug, /break, /jobquit");
			SendClientMessage(playerid, COLOR_GRAY, "============================");
		} else if(gJob[playerid] == IMPORT) {
			SendClientMessage(playerid, COLOR_GRAY, "=========Job Commands========");
			SendClientMessage(playerid, COLOR_GREEN, "Car Imports: /import, /break, /jobquit");
			SendClientMessage(playerid, COLOR_GRAY, "============================");
		} else if(gJob[playerid] == MAIL) {
			SendClientMessage(playerid, COLOR_GRAY, "=========Job Commands========");
			SendClientMessage(playerid, COLOR_GREEN, "Mail Man: /drop, /break, /jobquit");
			SendClientMessage(playerid, COLOR_GRAY, "============================");
		} else {
			SendClientMessage(playerid, COLOR_GRAY, "You don't have a job");
		}
		return 1;
	}
	if(strcmp("/fcmds", cmd, true,6) == 0)
	{
		if(gTeam[playerid] == ADMIN) {
			SendClientMessage(playerid, COLOR_GREEN, "Admin: /announce, /kick, /ban, /mute, /slesson, /elesson, /givelicense");
			SendClientMessage(playerid, COLOR_GREEN, "Admin: /getip, /freeze, /unfreeze, /goto, /bring, /gmx, /isolate, /adminzone");
			SendClientMessage(playerid, COLOR_GREEN, "Admin: /setooc, /invisible, /setlife, /spawncar");
			SendClientMessage(playerid, COLOR_GREEN, "Admin: ![message] - Admin and Mayor Chat");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else if(gTeam[playerid] == MAYOR) {
			SendClientMessage(playerid, COLOR_GRAY, "========Faction Commands=======");
			SendClientMessage(playerid, COLOR_GREEN, "Mayor: /announce, /kick, /ban, /mute, /goto, /bring, /freeze, /unfreeze");
            SendClientMessage(playerid, COLOR_GREEN, "Mayor: /isloate");
            SendClientMessage(playerid, COLOR_GREEN, "Mayor: ![message] - Admin and Mayor Chat");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else if(gTeam[playerid] == BUS) {
			SendClientMessage(playerid, COLOR_GRAY, "========Faction Commands=======");
			SendClientMessage(playerid, COLOR_GREEN, "Bus: /acceptcall, /break");
			SendClientMessage(playerid, COLOR_GREEN, "Bus: ![message] - Bus Driver Chat");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else if(gTeam[playerid] == TAXI) {
			SendClientMessage(playerid, COLOR_GRAY, "========Faction Commands=======");
			SendClientMessage(playerid, COLOR_GREEN, "Taxi: /acceptcall, /break");
			SendClientMessage(playerid, COLOR_GREEN, "Taxi: ![message] - Taxi Driver Chat");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else if(gTeam[playerid] == COP) {
			SendClientMessage(playerid, COLOR_GRAY, "========Faction Commands=======");
			SendClientMessage(playerid, COLOR_GREEN, "Cop: /ticket, /jail, /pullover, /takelicense, /megaphone, /break");
			SendClientMessage(playerid, COLOR_GREEN, "Cop: /changeskin, /taze, /pullover");
			SendClientMessage(playerid, COLOR_GREEN, "Cop: ![message] - Cop Radio");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else if(gTeam[playerid] == DMV) {
			SendClientMessage(playerid, COLOR_GRAY, "========Faction Commands=======");
			SendClientMessage(playerid, COLOR_GREEN, "Driving Instructor: /slesson, /elesson, /givelicence, /break");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else if(gTeam[playerid] == PILOT) {
			SendClientMessage(playerid, COLOR_GRAY, "========Faction Commands=======");
			SendClientMessage(playerid, COLOR_GREEN, "Flying Instructor: /slesson, /elesson, /givelicence, /break");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else if(gTeam[playerid] == BOAT) {
			SendClientMessage(playerid, COLOR_GRAY, "========Faction Commands=======");
			SendClientMessage(playerid, COLOR_GREEN, "Boating Instructor: /slesson, /elesson, /givelicence, /break");
			SendClientMessage(playerid, COLOR_GRAY, "==============================");
		} else {
			SendClientMessage(playerid, COLOR_GRAY, "You aren't in a faction");
		}
		return 1;
	}
	if(strcmp("/licensing", cmd, true,10) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=========Licenses==============");
		SendClientMessage(playerid, COLOR_GREEN, "Driving: DMV near stadium");
		SendClientMessage(playerid, COLOR_GREEN, "Flying: Abandoned air strip at the desert");
		SendClientMessage(playerid, COLOR_GREEN, "Boating: Boating school near gant bridge");
		SendClientMessage(playerid, COLOR_GREEN, "Weapon: Ammunation on the strip");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/ganghelp", cmd, true,9) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "=========Street Gangs==========");
		SendClientMessage(playerid, COLOR_GREEN,"/gang create [name]");
		SendClientMessage(playerid, COLOR_GREEN,"/gang join");
		SendClientMessage(playerid, COLOR_GREEN,"/gang invite [id]");
		SendClientMessage(playerid, COLOR_GREEN,"/gang quit");
		SendClientMessage(playerid, COLOR_GREEN,"/gang info [id]");
		SendClientMessage(playerid, COLOR_GREEN,"Gang Chat: @[text]");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/casinohelp", cmd, true,11) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "============Casinos============");
		SendClientMessage(playerid, COLOR_GREEN,"You can play casino games at the 4 Dragons or Caligulas.");
		SendClientMessage(playerid, COLOR_GREEN,"Casino games are one of the best ways to earn a quick buck");
		SendClientMessage(playerid, COLOR_GREEN,"When you play one game, you have to wait 5 minutes before playing again");
		SendClientMessage(playerid, COLOR_GRAY,"Now please do /casinogames");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	if(strcmp("/casinogames", cmd, true,12) == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "============Casinos============");
		SendClientMessage(playerid, COLOR_GREEN,"/Slots - Random chance of getting up to $500, need $50 to play");
		SendClientMessage(playerid, BANRED,"Slots - Difficulty Level: 5/5");
		SendClientMessage(playerid, COLOR_GREEN,"/All In - Put in money and a number, if your number wins, the money you put in doubles");
		SendClientMessage(playerid, BANRED,"All In - Difficulty Level: 4/5");
		SendClientMessage(playerid, COLOR_GRAY, "==============================");
		return 1;
	}
	dcmd(login,5,cmdtext);
  	dcmd(register,8,cmdtext);
  	dcmd(logout,6,cmdtext);
	return 0;
}
dcmd_logout(playerid, params[])
{
	#pragma unused params
	if (PLAYERLIST_authed[playerid])
	{
	    PLAYERLIST_authed[playerid] = false;
	    SendClientMessage(playerid,COLOR_GRAY,"Logged out");
	}
	return 1;
}
public OnPlayerConnect(playerid)
{
/*	new stringg[256];
	GetPlayerName(playerid,stringg,MAX_PLAYER_NAME);
	if(!(strfind(stringg, "_", true) != -1) || (strfind(stringg, "[", true) != -1) || (strfind(stringg, "]", true) != -1))
	{
		SendClientMessage(playerid, COLOR_AQUA, "You were kicked: Either you had a clan tag on or your name isn't correct");
		SendClientMessage(playerid, COLOR_AQUA, "If you were wearing a clan tag: Remove it");
		SendClientMessage(playerid, COLOR_AQUA, "In order to play, your nickname should look like: Ex_Ample");
		Kick(playerid);
	}*/
	firstspawn[playerid] = 1;
	gTeam[playerid] = CIV;
	lesson[playerid] = 0;
    SetPlayerColor(playerid, COLOR_GRAY);
	new pName[30], strr[200];
	GetPlayerName(playerid, pName, 30);
	format(strr, sizeof(strr), "** %s has joined the server.", pName);
	SendClientMessageToAll(COLOR_GRAY,strr);
    if (!udb_Exists(PlayerName(playerid)))
    {
        firstime[playerid] = 1;
        dli[playerid] = 0;
        pli[playerid] = 0;
        bli[playerid] = 0;
        wli[playerid] = 0;
	} else {
	new string [256];
	format(string,sizeof(string),"~g~Welcome back ~p~%s!~n~~g~Please ~r~/login",PlayerName(playerid));
	GameTextForPlayer(playerid,string,3500, 5);
	}
    PLAYERLIST_authed[playerid]=false;
    MapIcons();
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	if(inguide[playerid] == 1) { inguide[playerid] = 0; }
    if(playerGang[playerid]>0) { PlayerLeaveGang(playerid); }
	muted[playerid] = 0;
	if(lcar[playerid] == 1)
	{
 		for(new i=0;i<MAX_PLAYERS;i++)
		{
	 		for(new k=0;k<LastCar[playerid];k++)
			{
			    if(IsPlayerConnected(i))
			    {
					SetVehicleParamsForPlayer(k,i, 0, 0);
				}
			}
		}
	}
	drink[playerid] = 0;
	switch(reason)
	{
		case 0:
		{
			new pName[30], string[200];
			GetPlayerName(playerid, pName, 30);
			format(string, 256, "** %s has left the server. (Timeout)", pName);
			SendClientMessageToAll(COLOR_GRAY, string);
		}
		case 1:
		{
			new pName[30], string[200];
			GetPlayerName(playerid, pName, 30);
			format(string, 256, "** %s has left the server. (Leaving)", pName);
			SendClientMessageToAll(COLOR_GRAY, string);
		}
		case 2:
		{
			new pName[30], string[200];
			GetPlayerName(playerid, pName, 30);
			format(string, 256, "** %s has left the server. (Kick/Ban)", pName);
			SendClientMessageToAll(COLOR_GRAY, string);
		}
 	}
	if (PLAYERLIST_authed[playerid]) {
		dUserSetINT(PlayerName(playerid)).("money",GetPlayerMoney(playerid));
		dUserSetINT(PlayerName(playerid)).("job",jobbed[playerid]);
		dUserSetINT(PlayerName(playerid)).("firstime",firstime[playerid]);
		dUserSetINT(PlayerName(playerid)).("drive",dli[playerid]);
		dUserSetINT(PlayerName(playerid)).("boat",bli[playerid]);
		dUserSetINT(PlayerName(playerid)).("fly",pli[playerid]);
		dUserSetINT(PlayerName(playerid)).("weapon",wli[playerid]);
		dUserSetINT(PlayerName(playerid)).("count4",count4);
		dUserSetINT(PlayerName(playerid)).("Count2",Count2);
		dUserSetINT(PlayerName(playerid)).("count5",count5);
		dUserSetINT(PlayerName(playerid)).("vlock",vlock[playerid]);
		dUserSetINT(PlayerName(playerid)).("tickets",tickets[playerid]);
		dUserSetINT(PlayerName(playerid)).("jailed",jailed[playerid]);
		dUserSetINT(PlayerName(playerid)).("jailtime",jailtime[playerid]);
		dUserSetINT(PlayerName(playerid)).("bail",inbail[playerid]);
		dUserSetINT(PlayerName(playerid)).("bailprice",inbailprice[playerid]);
		dUserSetINT(PlayerName(playerid)).("sex",psex[playerid]);
		dUserSetINT(PlayerName(playerid)).("location",ploc[playerid]);
		if(gJob[playerid] == MECHANIC) {
			dUserSetINT(PlayerName(playerid)).("team",1);
		} else if(gJob[playerid] == MEDIC) {
			dUserSetINT(PlayerName(playerid)).("team",2);
		} else if(gJob[playerid] == WHORE) {
			dUserSetINT(PlayerName(playerid)).("team",3);
		} else if(gJob[playerid] == DRUGS) {
			dUserSetINT(PlayerName(playerid)).("team",4);
		} else if(gJob[playerid] == IMPORT) {
			dUserSetINT(PlayerName(playerid)).("team",5);
		} else if(gJob[playerid] == MAIL) {
			dUserSetINT(PlayerName(playerid)).("team",6);
			KillTimer(count3t);
			count3 = 120;
		}
		if(gTeam[playerid] == TAXI)
		{
	 		dUserSetINT(PlayerName(playerid)).("fare",fare2[playerid]);
		}
		if(gTeam[playerid] == BUS)
		{
	 		dUserSetINT(PlayerName(playerid)).("fare",fare2[playerid]);
	  	}
		if(gTeam[playerid] == TAXI) {
		taxipl--;
		if(taxipl == 0) { SendClientMessageToAll(COLOR_AQUA, "All taxi drivers have left"); }
		} else if(gTeam[playerid] == BUS) {
		buspl--;
		if(buspl == 0) { SendClientMessageToAll(COLOR_AQUA, "All bus drivers have left"); }
		} else if(gTeam[playerid] == MECHANIC) {
		mechpl--;
		if(mechpl == 0) { SendClientMessageToAll(COLOR_AQUA, "All mechanics have left"); }
		} else if(gTeam[playerid] == MEDIC) {
		medpl--;
		if(medpl == 0) { SendClientMessageToAll(COLOR_AQUA, "All medics have left"); }
		}
	}
  	PLAYERLIST_authed[playerid]=false;
}

/*==============================================================================
							DCMD COMMANDS
================================================================================*/
dcmd_register(playerid,params[]) {

    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"Already logged in.");
    if (udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"Account already exists, please use '/login password'.");
    if (strlen(params)==0) return SystemMsg(playerid,"SYNTAX: '/register password'");
    if (udb_Create(PlayerName(playerid),params) && dUserSetINT(PlayerName(playerid)).("team",0) && dUserSetINT(PlayerName(playerid)).("teamr",0) && dUserSetINT(PlayerName(playerid)).("money",1000)) return SystemMsg(playerid,"Account successfully created.");
	if(plxlogin[playerid] == 1)
	{
        GameTextForPlayer(playerid,"~r~You now need to log in~n~Do so now by using /login <password>",5000,5);
        plxlogin[playerid] = 2;
	}
	return true;
}
dcmd_login(playerid,params[]) {
    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"Already logged in.");
    if (!udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"Account doesn't exist, please use '/register password'.");
    if (strlen(params)==0) return SystemMsg(playerid,"SYNTAX: '/login password'");
	if (udb_CheckLogin(PlayerName(playerid),params)) {
		    if(plxlogin[playerid] == 2)
		    {
				SendClientMessage(playerid, COLOR_LBLUE, "_____Please Answer Some Questions_____");
				SendClientMessage(playerid, COLOR_LBLUE, "Are you a male or female?");
				SendClientMessage(playerid, COLOR_LBLUE, "Type male or female");
				//preglog[playerid] = 0;
				logged[playerid] = 1;
				KillTimer(count6t);
				RegQs[playerid] = 0;
		    }
	if(preglog[playerid] == 1 || preglog[playerid] == 2)
    {
		SendClientMessage(playerid, COLOR_LBLUE, "_____Please Answer Some Questions_____");
		SendClientMessage(playerid, COLOR_LBLUE, "Are you a male or female?");
		SendClientMessage(playerid, COLOR_LBLUE, "Type male or female");
		preglog[playerid] = 0;
    }
	    if(inclass[playerid] == 0) {
			GivePlayerMoney(playerid,dUserINT(PlayerName(playerid)).("money")-GetPlayerMoney(playerid));
	       	jobbed[playerid] = dUserINT(PlayerName(playerid)).("job");
			firstime[playerid] = dUserINT(PlayerName(playerid)).("firstime");
			dli[playerid] = dUserINT(PlayerName(playerid)).("drive");
			bli[playerid] = dUserINT(PlayerName(playerid)).("boat");
			pli[playerid] = dUserINT(PlayerName(playerid)).("fly");
			wli[playerid] = dUserINT(PlayerName(playerid)).("weapon");
			count4 = dUserINT(PlayerName(playerid)).("count4");
			Count2 = dUserINT(PlayerName(playerid)).("Count2");
			count5 = dUserINT(PlayerName(playerid)).("count5");
			vlock[playerid] = dUserINT(PlayerName(playerid)).("vlock");
			tickets[playerid] = dUserINT(PlayerName(playerid)).("tickets");
			jailed[playerid] = dUserINT(PlayerName(playerid)).("jailed");
			jailtime[playerid] = dUserINT(PlayerName(playerid)).("jailtime");
			phonenbr[playerid] = dUserINT(PlayerName(playerid)).("phonenbr");
			phone[playerid] = dUserINT(PlayerName(playerid)).("phone");
			inbail[playerid] = dUserINT(PlayerName(playerid)).("bail");
			inbailprice[playerid] = dUserINT(PlayerName(playerid)).("bailprice");
			psex[playerid] = dUserINT(PlayerName(playerid)).("sex");
			ploc[playerid] = dUserINT(PlayerName(playerid)).("location");
			if(dUserINT(PlayerName(playerid)).("teamr") == 0)
			{
				gTeam[playerid] = CIV;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Civilian", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 1) {
				gTeam[playerid] = ADMIN;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as Admin", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				new string2[256];
				format(string2,sizeof(string2), "Admin %s logged in", PlayerName(playerid));
				SendClientMessageToAll(COLOR_GREEN, string2);
				SetPlayerTeam(playerid,0);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 2) {
				gTeam[playerid] = BUS;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Bus Driver", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 1391.1873,685.3361,10.8203);
				new string2[256];
				format(string2,sizeof(string2), "Bus Driver %s logged in", PlayerName(playerid));
				SendClientMessageToAll(COLOR_GREEN, string2);
				buspl++;
				SetPlayerTeam(playerid,1);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 3) {
				gTeam[playerid] = TAXI;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Taxi Driver", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 1392.8348,753.0795,10.8203);
				new string2[256];
				format(string2,sizeof(string2), "Taxi driver %s logged in", PlayerName(playerid));
				SendClientMessageToAll(COLOR_GREEN, string2);
				taxipl++;
				SetPlayerTeam(playerid,2);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 4) {
				gTeam[playerid] = COP;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Cop", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 2265.2659,2461.8823,10.8203);
				GivePlayerWeapon(playerid, 24, 50000);
				GivePlayerWeapon(playerid, 41, 50000);
				GivePlayerWeapon(playerid, 3, 1);
				SetPlayerTeam(playerid,3);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 5) {
				gTeam[playerid] = DMV;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Driving Instructor", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 1173.4608,1349.6775,10.9219);
				new string2[256];
				format(string2,sizeof(string2), "Driving instructor %s logged in", PlayerName(playerid));
				SendClientMessageToAll(COLOR_GREEN, string2);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 6) {
				gTeam[playerid] = PILOT;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Flying Instructor", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 407.1263,2536.3364,16.5465);
				new string2[256];
				format(string2,sizeof(string2), "Flying instructor %s logged in", PlayerName(playerid));
				SendClientMessageToAll(COLOR_GREEN, string2);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 7) {
				gTeam[playerid] = FIDO;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Fido Family Member", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 1996.1805,2731.0322,10.8203);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 8) {
				gTeam[playerid] = VERCETTI;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Vercetti Family Member", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 1610.3195,2087.1003,10.6719);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 9) {
				gTeam[playerid] = JOHNSON;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Johnson Family Member", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, 1015.2131,1979.8096,10.8203);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 10) {
				gTeam[playerid] = BOAT;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as a Boating Instructor", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerPos(playerid, -2185.7463,2416.3730,5.1802);
				new string2[256];
				format(string2,sizeof(string2), "Boating instructor %s logged in", PlayerName(playerid));
				SendClientMessageToAll(COLOR_GREEN, string2);
			} else if(dUserINT(PlayerName(playerid)).("teamr") == 11) {
				gTeam[playerid] = MAYOR;
				new string[256];
				format(string,sizeof(string), "Welcome back %s, you are recognized as Las Venturas Mayor", PlayerName(playerid));
				SendClientMessage(playerid, COLOR_YELLOW, string);
				SetPlayerInterior(playerid, 3);
				SetPlayerPos(playerid, 346.5109,162.0628,1025.7964);
				new string2[256];
				format(string2,sizeof(string2), "Mayor %s logged in", PlayerName(playerid));
				SendClientMessageToAll(COLOR_GREEN, string2);
				SendClientMessageToAll(COLOR_GRAY, "*** MAYOR: Your black turismo is outside waiting for you! ***");
				SetPlayerTeam(playerid,0);
			}
			if(dUserINT(PlayerName(playerid)).("team") == 1) {
				gJob[playerid] = MECHANIC;
				SendClientMessage(playerid, ORANGE, "Your job is: Mechanic");
				mechpl++;
			} else if(dUserINT(PlayerName(playerid)).("team") == 2) {
				gJob[playerid] = MEDIC;
				SendClientMessage(playerid, ORANGE, "Your job is: Medic");
				SetPlayerPos(playerid, 1607.4800,1818.1030,10.8203);
				medpl++;
			} else if(dUserINT(PlayerName(playerid)).("team") == 3) {
				SendClientMessage(playerid, ORANGE, "Your job is: Whore");
				gJob[playerid] = WHORE;
				new rand = random(sizeof(whores));
				SetPlayerSkin(playerid, whores[rand][0]);
			} else if(dUserINT(PlayerName(playerid)).("team") == 4) {
				gJob[playerid] = DRUGS;
				SendClientMessage(playerid, ORANGE, "Your job is: Drug Trade");
			} else if(dUserINT(PlayerName(playerid)).("team") == 5) {
				gJob[playerid] = IMPORT;
				SendClientMessage(playerid, ORANGE, "Your job is: Car Imports");
			} else if(dUserINT(PlayerName(playerid)).("team") == 6) {
				gJob[playerid] = MAIL;
				SetPlayerPos(playerid, 1631.8187,971.7361,10.8203);
	   			SendClientMessage(playerid, ORANGE, "Your job is: Package Delivery");
			}
			if(count4 > 0)
			{
			    if(gJob[playerid] == MAIL)
			    {
					SetTimer("MailDrop3", 1000, 1);
				}
			}
			if(count5 > 0)
			{
			    if(gJob[playerid] == IMPORT)
			    {
					SetTimer("Count5", 1000, 1);
				}
			}
			if(gTeam[playerid] == TAXI)
			{
	  			fare2[playerid] = dUserINT(PlayerName(playerid)).("fare");
			}
			SetTimer("PayDay",1440000,1);
			SetTimer("AdminPayDay",1440000,1);
	       	PLAYERLIST_authed[playerid]=true;
	       	if(inguide[playerid] != 1)
	       	{
	       		TogglePlayerControllable(playerid, true);
			}
/*		    if(inguide[playerid] == 1)
		    {
		        count6t = SetTimer("FirstTime",1000,1);
		    }*/
			if(inguide[playerid] == 0)
			{
	      		skinz = GetPlayerSkin(playerid);
				if(gTeam[playerid] != ADMIN)
				{
					if(skinz == 249)
					{
			  			dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
					}
				}
				if(gTeam[playerid] != BUS) {
					if(skinz == 17)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != TAXI) {
					if(skinz == 255)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != COP) {
					if(skinz == 282)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != DMV) {
					if(skinz == 147)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != PILOT) {
					if(skinz == 61)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != BOAT) {
					if(skinz == 217)
					{
					 	dfs[playerid] = 1;
		  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != MAYOR) {
					if(skinz == 187)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != JOHNSON) {
					if(skinz == 271)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != FIDO) {
					if(skinz == 299)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] != VERCETTI) {
					if(skinz == 59)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your correct skin");
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "If you are a civilian choose a pedestrian skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == ADMIN)
				{
					if(skinz != 249)
					{
			  			dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the admin skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
					}
				}
				if(gTeam[playerid] == BUS) {
					if(skinz != 17)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the bus driver skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == TAXI) {
					if(skinz != 255)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the taxi driver skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == COP) {
					if(skinz != 282)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the LVPD skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == DMV) {
					if(skinz != 147)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the driving instructor skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == PILOT) {
					if(skinz != 61)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the flying instructor skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == BOAT) {
					if(skinz != 217)
					{
					 	dfs[playerid] = 1;
		  				SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose boating instructor skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == MAYOR) {
					if(skinz != 187)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the mayor skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == JOHNSON) {
					if(skinz != 271)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Johnson skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == FIDO) {
					if(skinz != 299)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose your the Fido skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
				if(gTeam[playerid] == VERCETTI) {
					if(skinz != 59)
					{
					 	dfs[playerid] = 1;
			  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "You don't belong in this skin, choose the Vercetti skin");
						SetPlayerHealth(playerid, 0);
						ForceClassSelection(playerid);
		  			}
				}
			}
			if(jailed[playerid] == 1)
			{
			    SendClientMessage(playerid, COLOR_RED, "Your still in jail");
			    SetPlayerPos(playerid, 198.5881,162.1837,1003.0300);
			    SetPlayerInterior(playerid, 3);
			    JailCDt = SetTimer("JailCD",1000,1);
			}
			return SystemMsg(playerid,"Successfully logged in!");
		} else {
  			return SendClientMessage(playerid, BANRED, "Please spawn before logging in");
		}
    }
    return SystemMsg(playerid,"Login failed!");
}
/*==============================================================================
							DCMD COMMANDS END
================================================================================*/

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
	if(taxif[playerid] == 1)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i))
		    {
			    if(gTeam[i] == TAXI)
			    {
			        i = giveplayerid;
			        if(IsPlayerInVehicle(playerid, vehicleid == taxi1 || vehicleid == taxi2 || vehicleid == taxi3 || vehicleid == taxi4 || vehicleid == taxi5 || vehicleid == taxi6 || vehicleid == taxi7 || vehicleid == taxi8 || vehicleid == taxi9 || vehicleid == taxi10))
			        {
					    KillTimer(ttimet);
					    taxif[playerid] = 0;
					    GivePlayerMoney(playerid, -fare);
					    GivePlayerMoney(i, fare);
			            new string[256],string2[256];
						GetPlayerName(playerid,sendername,sizeof(sendername));
						GetPlayerName(giveplayerid,giveplayer,sizeof(giveplayer));
						format(string,sizeof(string),"You payed $%d to %s for the ride",fare,giveplayer);
						format(string2,sizeof(string2),"You earned $%d for driving %s to his/her destination",fare,sendername);
						SendClientMessage(playerid,COLOR_YELLOW,string);
						SendClientMessage(giveplayerid,COLOR_YELLOW,string2);
					}
				}
			}
		}
	}
	return 1;
}

stock bool:printfile(filename[])
{
	new	File: file = fopen(filename, io_read),
		line[255];

	print("\n");

	if (!file)
	{
		printf("ERROR: The file \"%s\" doesn't exist!\n", filename);
		return false;
	}

	while (fread(file, line))
		print(line);

	fclose(file);
	print("\n");

	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid = GetPlayerVehicleID(playerid);
/*	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    new carsz = printfile("ownedcars.txt");
		if(GetPlayerVehicleID(playerid) == carsz)
		{
		    if(GetPlayerVehicleID(playerid) == owned && GetPlayerVehicleID(playerid) != dUserINT(PlayerName(playerid)).("car"))
		    {
		        new string[256];
	    		RemovePlayerFromVehicle(playerid);
	    		format(string,sizeof(string),"This car belongs to someone else",vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
	    		SendClientMessage(playerid, COLOR_GREEN, string);
		    } else {

		    }
	    }
	}*/
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    if(vehicleid == dmv1 || vehicleid == dmv2 || vehicleid == dmv3 || vehicleid == dmv4 || vehicleid == dmv5)
	    {
	        if(inlesson[playerid] == 1)
	        {
	        	PutPlayerInVehicle(playerid, vehicleid, 0);
	        } else if(inlesson[playerid] == 0)
	        {
	        	RemovePlayerFromVehicle(playerid);
	        	SendClientMessage(playerid, COLOR_WHITE, "There's no lesson in progress");
	        }
	    }
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		if(vehicleid == sboat1 || vehicleid == sboat2 || vehicleid == sboat3 || vehicleid == sboat4)
	    {
     		if(inlesson[playerid] == 1)
	        {
                PutPlayerInVehicle(playerid, vehicleid, 0);
	        } else if(inlesson[playerid] == 0)
	        {
	        	RemovePlayerFromVehicle(playerid);
	        	SendClientMessage(playerid, COLOR_WHITE, "There's no lesson in progress");
	        }
	    }
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		if(vehicleid == sfly1 || vehicleid == sfly2 || vehicleid == sfly3 || vehicleid == sfly4)
	    {
     		if(inlesson[playerid] == 1)
	        {
				PutPlayerInVehicle(playerid, vehicleid, 0);
	        } else if(inlesson[playerid] == 0)
	        {
	        	RemovePlayerFromVehicle(playerid);
	        	SendClientMessage(playerid, COLOR_WHITE, "There's no lesson in progress");
	        }
	    }
	}
	if(vehicleid == john1 || vehicleid == john2 || vehicleid == john3 || vehicleid == john4 || vehicleid == john5 || vehicleid == john6)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
	    	if(gTeam[playerid] != JOHNSON)
	    	{
	    		RemovePlayerFromVehicle(playerid);
	    		SendClientMessage(playerid, COLOR_GRAY, "Only Johnson Family members can drive this car");
			}
		}
	}
	if(vehicleid == ver1 || vehicleid == ver2 || vehicleid == ver3 || vehicleid == ver4 || vehicleid == ver5 || vehicleid == ver6 || vehicleid == ver7)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
		    if(gTeam[playerid] != VERCETTI)
		    {
		    	RemovePlayerFromVehicle(playerid);
		    	SendClientMessage(playerid, COLOR_GRAY, "Only Vercetti Family members can drive this car");
			}
		}
	}
	if(vehicleid == fido1 || vehicleid == fido2 || vehicleid == fido3 || vehicleid == fido4 || vehicleid == fido5 || vehicleid == fido6 || vehicleid == fido7 || vehicleid == fido8)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
		    if(gTeam[playerid] != FIDO)
		    {
		    	RemovePlayerFromVehicle(playerid);
		    	SendClientMessage(playerid, COLOR_GRAY, "Only Fido Family members can drive this car");
			}
		}
	}
	if(vehicleid == mayorc)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
		    if(gTeam[playerid] != MAYOR)
		    {
		    	RemovePlayerFromVehicle(playerid);
		    	SendClientMessage(playerid, COLOR_GRAY, "Only the mayor can drive this car");
			}
		}
	}
	if(vehicleid == taxi1 || vehicleid == taxi2 || vehicleid == taxi3 || vehicleid == taxi4 || vehicleid == taxi5 || vehicleid == taxi6 || vehicleid == taxi7 || vehicleid == taxi8 || vehicleid == taxi9 || vehicleid == taxi10)
	{
		if(newstate == PLAYER_STATE_DRIVER)//
		{
		    if(gTeam[playerid] != TAXI)
		    {
		        new string[256];
		    	RemovePlayerFromVehicle(playerid);
		    	SendClientMessage(playerid, COLOR_RED, "Trying to steal a taxi");
		    	SendClientMessage(playerid, COLOR_RED, "The police have been informed");
				format(string, sizeof(string), "** %s tried to steal a taxi", PlayerName(playerid));
		    	SendClientMessageToTeam(COP, COLOR_GRAY2, string);
			}
		}
	}
	if(vehicleid == bus1 || vehicleid == bus2 || vehicleid == bus3 || vehicleid == bus4 || vehicleid == bus5 || vehicleid == bus6 || vehicleid == bus7)
	{
		if(newstate == PLAYER_STATE_DRIVER)//
		{
		    if(gTeam[playerid] != BUS)
		    {
		        new string[256];
		    	RemovePlayerFromVehicle(playerid);
		    	SendClientMessage(playerid, COLOR_RED, "Trying to steal a bus");
		    	SendClientMessage(playerid, COLOR_RED, "The police have been informed");
				format(string, sizeof(string), "** %s tried to steal a bus", PlayerName(playerid));
		    	SendClientMessageToTeam(COP, COLOR_GRAY2, string);
			}
		}
	}
	if(vehicleid == ambu1 || vehicleid == ambu2 || vehicleid == ambu3 || vehicleid == ambu4 || vehicleid == ambu5)
	{
		if(newstate == PLAYER_STATE_DRIVER)//
		{
		    if(gTeam[playerid] != TAXI)
		    {
		        new string[256];
		    	RemovePlayerFromVehicle(playerid);
		    	SendClientMessage(playerid, COLOR_RED, "Trying to steal an ambulance");
		    	SendClientMessage(playerid, COLOR_RED, "The police have been informed");
				format(string, sizeof(string), "** %s tried to steal an ambulance", PlayerName(playerid));
		    	SendClientMessageToTeam(COP, COLOR_GRAY2, string);
			}
		}
	}
	if(vehicleid == pol1 || vehicleid == pol2 || vehicleid == pol3 || vehicleid == pol4 || vehicleid == pol5 || vehicleid == pol6 || vehicleid == pol7)
	{
		if(newstate == PLAYER_STATE_DRIVER)//
		{
		    if(gTeam[playerid] != COP)
		    {
		        new string[256];
		    	RemovePlayerFromVehicle(playerid);
		    	SendClientMessage(playerid, COLOR_RED, "Trying to steal a police car");
		    	SendClientMessage(playerid, COLOR_RED, "The police have been informed");
				format(string, sizeof(string), "** %s tried to steal a police car", PlayerName(playerid));
		    	SendClientMessageToTeam(COP, COLOR_GRAY2, string);
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(!PlayerBoats(playerid,GetPlayerVehicleID(playerid)) && !PlayerPlanes(playerid,GetPlayerVehicleID(playerid)))
		{
  			if(inlesson[playerid] == 1)
	        {
                PutPlayerInVehicle(playerid, vehicleid, 0);
	        } else if(dli[playerid] == 0)
			{
			    GetPlayerPos(playerid,jx,jy,jz);
			    count7 = 4;
			    count7t = SetTimer("LookItCar",1000,1);
				RemovePlayerFromVehicle(playerid);
				SendClientMessage(playerid, COLOR_WHITE, "You need a drivers license to drive this car/bike");
				SendClientMessage(playerid, COLOR_WHITE, "Visit the DMV near the stadium");
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(PlayerBoats(playerid,GetPlayerVehicleID(playerid)))
		{
  			if(inlesson[playerid] == 1)
	        {
                PutPlayerInVehicle(playerid, vehicleid, 0);
	        } else if(bli[playerid] == 0)
			{
			    GetPlayerPos(playerid,jx,jy,jz);
		    	count9 = 4;
		    	count9t = SetTimer("LookItBoat",1000,1);
				RemovePlayerFromVehicle(playerid);
				SendClientMessage(playerid, COLOR_WHITE, "You need a boaters license to drive this boat");
				SendClientMessage(playerid, COLOR_WHITE, "Visit the boating school near the Gant Bridge");
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(PlayerPlanes(playerid,GetPlayerVehicleID(playerid)))
		{
  			if(inlesson[playerid] == 1)
	        {
                PutPlayerInVehicle(playerid, vehicleid, 0);
	        } else if(pli[playerid] == 0) {
	            GetPlayerPos(playerid,jx,jy,jz);
		    	count8 = 4;
		    	count8t = SetTimer("LookItPlane",1000,1);
				RemovePlayerFromVehicle(playerid);
				SendClientMessage(playerid, COLOR_WHITE, "You need a pilots license to fly this plane/helicopter");
				SendClientMessage(playerid, COLOR_WHITE, "Visit the flying school in the desert");
			}
		}
	}
	if(vehicleid == taxi1 || vehicleid == taxi2 || vehicleid == taxi3 || vehicleid == taxi4 || vehicleid == taxi5 || vehicleid == taxi6 || vehicleid == taxi7 || vehicleid == taxi8 || vehicleid == taxi9 || vehicleid == taxi10)
	{
	    new string[256];
	    new string2[256];
		if(newstate == PLAYER_STATE_PASSENGER)
		{
    		for(new i = 0; i < MAX_PLAYERS; i++)
    		{
    		    if(IsPlayerConnected(i))
    		    {
	    		    if(gTeam[i] == TAXI)
	    		    {
		    		    if(i != playerid)
		    		    {
			      			if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && GetPlayerState(i) == 2)
				        	{
				        	    i = giveplayerid;
								if(onbreak[giveplayerid] == 0)
								{
									if(GetPlayerMoney(playerid) >= fare2[giveplayerid])
									{
			 							GivePlayerMoney(giveplayerid, fare2[giveplayerid]);
			   							GivePlayerMoney(playerid, -fare2[giveplayerid]);
			   							GetPlayerName(playerid,sendername,sizeof(sendername));
			   							GetPlayerName(giveplayerid,giveplayer,sizeof(giveplayer));
			   							format(string,sizeof(string),"You payed $%d to %s to enter his/her taxi",fare2[giveplayerid],giveplayer);
			   							format(string2,sizeof(string2),"%s has entered your taxi for $%d",sendername,fare2[giveplayerid]);
			   							SendClientMessage(playerid,COLOR_YELLOW,string);
			   							SendClientMessage(giveplayerid,COLOR_YELLOW,string2);
			   							fare = 0;
					  					ttimet = SetTimer("TTime",1000,1);
					  					taxif[playerid] = 1;
									} else {
									    format(string,sizeof(string),"You need $%d to enter this taxi",fare2[giveplayerid]);
									    SendClientMessage(playerid, COLOR_YELLOW, string);
									    RemovePlayerFromVehicle(playerid);
									}
								} else {
									RemovePlayerFromVehicle(playerid);
									SendClientMessage(playerid, BANRED, "That driver is on break!");
								}
							} else {
									RemovePlayerFromVehicle(playerid);
									SendClientMessage(playerid, BANRED, "There's no driver in here");
							}
						}
					}
				}
			}
		}
	}
	if(vehicleid == bus1 || vehicleid == bus2 || vehicleid == bus3 || vehicleid == bus4 || vehicleid == bus5 || vehicleid == bus6 || vehicleid == bus7)
	{
	    new string[256];
	    new string2[256];
		if(newstate == PLAYER_STATE_PASSENGER)
		{
    		for(new i = 0; i < MAX_PLAYERS; i++)
    		{
    		    if(IsPlayerConnected(i))
    		    {
	    		    if(gTeam[i] == BUS)
	    		    {
		    		    if(i != playerid)
		    		    {
			      			if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && GetPlayerState(i) == 2)
				        	{
				        	    i = giveplayerid;
								if(onbreak[giveplayerid] == 0)
								{
									if(GetPlayerMoney(playerid) >= fare2[giveplayerid])
									{
			 							GivePlayerMoney(giveplayerid, fare2[giveplayerid]);
			   							GivePlayerMoney(playerid, -fare2[giveplayerid]);
			   							GetPlayerName(playerid,sendername,sizeof(sendername));
			   							GetPlayerName(giveplayerid,giveplayer,sizeof(giveplayer));
			   							format(string,sizeof(string),"You payed $%d to %s to enter his/her bus",fare2[giveplayerid],giveplayer);
			   							format(string2,sizeof(string2),"%s has entered your bus for $%d",sendername,fare2[giveplayerid]);
			   							SendClientMessage(playerid,COLOR_YELLOW,string);
			   							SendClientMessage(giveplayerid,COLOR_YELLOW,string2);
									} else {
									    format(string,sizeof(string),"You need $%d to enter this bus",fare2[giveplayerid]);
									    SendClientMessage(playerid, COLOR_YELLOW, string);
									    RemovePlayerFromVehicle(playerid);
									}
								} else {
									RemovePlayerFromVehicle(playerid);
									SendClientMessage(playerid, BANRED, "That driver is on break!");
								}
							} else {
									RemovePlayerFromVehicle(playerid);
									SendClientMessage(playerid, BANRED, "There's no driver in here");
							}
						}
					}
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(drink[playerid] >= 5)
	    {
	        if(dli[playerid] == 1 || bli[playerid] == 1 || pli[playerid] == 1)
	        {
				new string[256];
				format(string, sizeof(string), "%s had too many drinks and is riding drunk!", PlayerName(playerid));
				SendClientMessageToAll(COLOR_RED, string);
				SendClientMessageToTeam(COP, BANRED, string);
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    LastCar[playerid] = GetPlayerVehicleID(playerid);
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if(CPS_GetPlayerCheckpoint(playerid) == cashcp)
    {
    	GameTextForPlayer(playerid,"~g~Money ~r~Spot!",3500,5);
    	SendClientMessage(playerid, COLOR_GREEN2, "$50 every second");
        cashcpt = SetTimer("AdminCashCP",1000,1);
    }
	if(gTeam[playerid] == TAXI)
	{
	    DisablePlayerCheckpoint(playerid);
	} else if(gTeam[playerid] == BUS) {
	    DisablePlayerCheckpoint(playerid);
	} else if(gTeam[playerid] == MECHANIC) {
	    DisablePlayerCheckpoint(playerid);
	} else if(gTeam[playerid] == MEDIC) {
	    DisablePlayerCheckpoint(playerid);
	}
	if(gJob[playerid] == MAIL)
	{
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid, COLOR_BROWN, "You have successfully dropped the package!");
		SendClientMessage(playerid, COLOR_BROWN, "Here is $600 for your hard work");
		GivePlayerMoney(playerid, 600);
		KillTimer(count3t);
		count3 = 120;
		mailed[playerid] = 0;
	}
	if(gJob[playerid] == IMPORT)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		    new string[256];
		    new string2[256];
		    new rand = random(sizeof(gRandCarPrices));
			DisablePlayerCheckpoint(playerid);
			format(string,sizeof(string), "You have successfully imported the %s!", vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
			SendClientMessage(playerid, COLOR_BROWN, string);
			format(string2,sizeof(string2),"Here is $%s for the car",gRandCarPrices[rand][0]);
			SendClientMessage(playerid, COLOR_BROWN, string2);
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			GivePlayerMoney(playerid, gRandCarPrices[rand][0]);
		} else {
		    SendClientMessage(playerid, COLOR_WHITE, "Where's the car?");
		}
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
    if(CPS_GetPlayerCheckpoint(playerid) == cashcp)
    {
        KillTimer(cashcpt);
    }
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(racecheck[playerid] == 1)
    {
        currentpoint++;
    	nextpoint = currentpoint + 1;
	} else {
	
	}
	RCPs[playerid]++;
	new strings[256];
	format(strings,sizeof(strings),"Checkpoint %d",RCPs[playerid]);
	SendClientMessage(playerid, COLOR_WHITE, strings);
	new string[256];
	for(new h=0; h<MAX_PLAYERS; h++)
	if(IsPlayerConnected(h))
	for(new i=0; i<inrace[h]; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(raceid[i] == 0)
			{
			    //if(justjoined[i] == 1)
			    //{
				SetPlayerRaceCheckpoint(i,0,RaceCP0[currentpoint][0],RaceCP0[currentpoint][1],RaceCP0[currentpoint][2],RaceCP0[nextpoint][0],RaceCP0[nextpoint][1],RaceCP0[nextpoint][2],8);
			    //}
				if(RCPs[playerid] == 21)
			    {
					GameTextForPlayer(playerid, "~r~SLOW DOWN!!",4000,5);
			    }
				if(RCPs[playerid] == 34)
			    {
			        racecheck[playerid] = 0;
			        SendClientMessage(playerid, COLOR_RED, "1");
			        SetPlayerRaceCheckpoint(playerid,1,-1655.8673,445.3485,6.7431,-1680.0668,422.7057,6.7451,8);
			    }
			    if(RCPs[playerid] == 35)
			    {
			        finishers++;
					DestroyVehicle(GetPlayerVehicleID(playerid));
					DisablePlayerRaceCheckpoint(playerid);
			        format(string,sizeof(string),"~r~%s ~g~finished in ~r~%i ~g~place",PlayerName(playerid),finishers);
			        GameTextForPlayer(i,string,3500,5);
			        SendClientMessage(playerid, COLOR_RED, "0");
			        SetPlayerPos(playerid,1680.3296,1447.9521,10.7737);
			    }
			}
		}
	}
	return 1;
}

forward RaceCD();
public RaceCD()
{
	racecount--;
	for(new i=0; i<inrace[i]; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	     	if(racecount == 3)
		    {
		    	GameTextForPlayer(i,"~w~3",1000,5);
		    } else if(racecount == 2) {
		        GameTextForPlayer(i,"~y~2",1000,5);
		    } else if(racecount == 1) {
		        GameTextForPlayer(i,"~r~1",1000,5);
		    } else if(racecount == 0) {
		        TogglePlayerControllable(i, true);
		        SetPlayerRaceCheckpoint(i,0,-2449.814941,1376.956176,6.611145,RaceCP0[nextpoint][0],RaceCP0[nextpoint][1],RaceCP0[nextpoint][2],8);
	            racecheck[i] = 1;
				currentpoint = 0;
		        nextpoint = 0;
				GameTextForPlayer(i,"~g~GO",1000,5);
				KillTimer(racec);
				racecount = 3;
		    }
	    }
	}
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
	if(pickupid == jp)
	{
		GameTextForPlayer(playerid,"~g~There's a ~r~5 hour contract ~g~involved",4500,5);
/*		SendClientMessage(playerid, BANRED, "Please be aware that before you can quit your job");
		SendClientMessage(playerid, BANRED, "You must have worked for 5 hours!");*/
		ShowMenuForPlayer(jobs, playerid);
		TogglePlayerControllable(playerid, false);
	}
	if(pickupid == dmv)
	{
		SetPlayerPos(playerid, 1165.5193,1342.4506,10.8125);
	}
	if(pickupid == dmvv2)
	{
		SetPlayerPos(playerid, 1166.2162,1351.4481,10.9219);
	}
	if(pickupid == wepl)
	{
		TogglePlayerControllable(playerid, false);
		ShowMenuForPlayer(wepli, playerid);
	}
	if(HP1[pickupid] != 0)
	{
		OnPlayerEnterHousee(playerid,HP1[pickupid]);
	}
	if(pickupid == bankp)
	{
		SetPlayerPos(playerid, 6.0856,-28.8966,1003.5494);
		SetPlayerInterior(playerid, 10);
		SendClientMessage(playerid, COLOR_GREEN, "Bank: /balance, /withdraw, /deposit");
	}
	if(pickupid == bankp2)
	{
		SetPlayerPos(playerid, 2561.6465,1788.1611,10.8203);
		SetPlayerInterior(playerid, 0);
	}
	if(pickupid == healme)
	{
		if(GetPlayerMoney(playerid) >= 20)
		{
			SetPlayerHealth(playerid,100);
			SendClientMessage(playerid, COLOR_GREEN2, "You bought health for $20");
		} else {
		    GetPlayerHealth(playerid, health);
			SetPlayerHealth(playerid,health);
			SendClientMessage(playerid, COLOR_GREEN2, "Oops, you don't have enough cash for this health");
		}
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    new tr = dUserINT(PlayerName(playerid)).("teamr");
	if(Current == race)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            SetPlayerPos(playerid,-2420.8152,1376.8159,6.6038);
	            raceid[playerid] = 0;
/*			 	new Float:x,Float:y,Float:z,Float:ang;
				new vid[10];
				new vids;
			  	vids++;*/
			  	raceid[playerid] = 0;
			  	racers++;
			  	inrace[playerid] = 1;
				TogglePlayerControllable(playerid, false);
				new string[256];
				format(string,sizeof(string),"%s Has entered the 'Round SF' race!",PlayerName(playerid));
				SendClientMessageToAll(COLOR_GOLD,string);
				SendClientMessageToAll(COLOR_GOLD,"Type /race and select Round SF to join (needs min 5 racers)");
		  		/*GetPlayerPos(playerid,x,y,z);
				vid[vids] = CreateVehicle(522,x,y,z,GetPlayerFacingAngle(playerid,ang),60,20,60000);
				PutPlayerInVehicle(playerid,vid[vids],0);*/
				if(racers == 1)
				{
					racec = SetTimer("RaceCD",1000,1);
				}
	        }
		}
	}
    if(Current == jobs)
    {
        switch(row)
        {
            case 0:
            {
                if(tr == 1 || tr == 2 || tr == 3 || tr == 4 || tr == 5 || tr == 6 || tr == 10 || tr == 11)
				{
					TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Your teams can't get these jobs!");
				} else if(jobbed[playerid] == 0)
                {
            		TogglePlayerControllable(playerid, true);
            		jobbed[playerid] = 1;
            		SendClientMessage(playerid, COLOR_GOLD, "You are now a mechanic");
            		SendClientMessage(playerid, COLOR_GOLD, "See /jobcmds for your commands");
            		jobhours[playerid] = 1;
            		gJob[playerid] = MECHANIC;
            		Count2 = 18000;
				} else if(jobbed[playerid] == 1) {
				    TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Do /jobquit before getting another job");
				}
            }
            case 1:
            {
            	if(tr == 1 || tr == 2 || tr == 3 || tr == 4 || tr == 5 || tr == 6 || tr == 10 || tr == 11)
				{
					TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Your teams can't get these jobs!");
				} else if(jobbed[playerid] == 0)
                {
            		TogglePlayerControllable(playerid, true);
            		jobbed[playerid] = 1;
            		SendClientMessage(playerid, COLOR_GOLD, "You are now a medic");
            		SendClientMessage(playerid, COLOR_GOLD, "See /jobcmds for your commands");
            		jobhours[playerid] = 1;
            		gJob[playerid] = MEDIC;
            		Count2 = 18000;
				} else if(jobbed[playerid] == 1) {
				    TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Do /jobquit before getting another job");
				}
            }
            case 2:
            {
                if(tr == 1 || tr == 2 || tr == 3 || tr == 4 || tr == 5 || tr == 6 || tr == 10 || tr == 11)
				{
					TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Your teams can't get these jobs!");
				} else if(jobbed[playerid] == 0)
                {
                    new rand = random(sizeof(whores));
            		TogglePlayerControllable(playerid, true);
            		jobbed[playerid] = 1;
            		SendClientMessage(playerid, COLOR_GOLD, "You are now a whore");
            		SendClientMessage(playerid, COLOR_GOLD, "See /jobcmds for your commands");
            		jobhours[playerid] = 1;
            		gJob[playerid] = WHORE;
            		SetPlayerSkin(playerid, whores[rand][0]);
            		Count2 = 18000;
				} else if(jobbed[playerid] == 1) {
				    TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Do /jobquit before getting another job");
				}
            }
            case 3:
            {
                if(tr == 1 || tr == 2 || tr == 3 || tr == 4 || tr == 5 || tr == 6 || tr == 10 || tr == 11)
				{
					TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Your teams can't get these jobs!");
				} else if(jobbed[playerid] == 0)
                {
            		TogglePlayerControllable(playerid, true);
            		jobbed[playerid] = 1;
            		SendClientMessage(playerid, COLOR_GOLD, "You are now a drug dealer");
            		SendClientMessage(playerid, COLOR_GOLD, "See /jobcmds for your commands");
            		jobhours[playerid] = 1;
            		gJob[playerid] = DRUGS;
            		Count2 = 18000;
				} else if(jobbed[playerid] == 1) {
				    TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Do /jobquit before getting another job");
				}
            }
            case 4:
            {
                if(tr == 1 || tr == 2 || tr == 3 || tr == 4 || tr == 5 || tr == 6 || tr == 10 || tr == 11)
				{
					TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Your teams can't get these jobs!");
				} else if(jobbed[playerid] == 0)
                {
            		TogglePlayerControllable(playerid, true);
            		jobbed[playerid] = 1;
            		SendClientMessage(playerid, COLOR_GOLD, "You are now a car importer");
            		SendClientMessage(playerid, COLOR_GOLD, "See /jobcmds for your commands");
            		jobhours[playerid] = 1;
            		Count2 = 18000;
            		gJob[playerid] = IMPORT;
				} else if(jobbed[playerid] == 1) {
				    TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Do /jobquit before getting another job");
				}
            }
            case 5:
            {
            	if(tr == 1 || tr == 2 || tr == 3 || tr == 4 || tr == 5 || tr == 6 || tr == 10 || tr == 11)
				{
					TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Your teams can't get these jobs!");
				} else if(jobbed[playerid] == 0)
                {
            		TogglePlayerControllable(playerid, true);
            		jobbed[playerid] = 1;
            		SendClientMessage(playerid, COLOR_GOLD, "You are now a package deliverer");
            		SendClientMessage(playerid, COLOR_GOLD, "See /jobcmds for your commands");
            		jobhours[playerid] = 1;
            		gJob[playerid] = MAIL;
            		Count2 = 18000;
				} else if(jobbed[playerid] == 1) {
				    TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "Do /jobquit before getting another job");
				}
            }
		}
	}
    if(Current == wepli)
    {
        switch(row)
        {
            case 0:
            {
                if(wli[playerid] == 0)
                {
            		TogglePlayerControllable(playerid, true);
            		SendClientMessage(playerid, COLOR_GOLD, "You have applied for a weapon licence");
            		SendClientMessage(playerid, COLOR_GOLD, "Check /licneces later to see if you were approved");
					new string[256], File:w=fopen("weaponapps.txt", io_append);
					format(string, sizeof(string), "Application for Weapon Licnence\r\nName: %s\r\n\r\n", PlayerName(playerid));
					fwrite(w, string);
					fclose(w);
				} else if(wli[playerid] == 1) {
				    TogglePlayerControllable(playerid, true);
					SendClientMessage(playerid, BANRED, "You already have a weapon licence");
				}
            }
            case 1:
            {
          		TogglePlayerControllable(playerid, true);
            }
		}
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
	return 1;
}

PlayerBoats(playerid, vehicleid)
{
	vehicleid = GetPlayerVehicleID(playerid);
	#define BOATS 10
	new IsPlayerBoats[BOATS] =
	{
	472, 473, 493, 595, 484, 430, 453, 452, 446, 454
	};
   	if(IsPlayerInVehicle(playerid,vehicleid))
   	{
		for(new i = 0; i < BOATS; i++)
		{
			if(GetVehicleModel(vehicleid) == IsPlayerBoats[i])
 			{
	        	return true;
  			}
		}
	}
	return false;
}
PlayerPlanes(playerid, vehicleid)
{
	vehicleid = GetPlayerVehicleID(playerid);
	#define PLANES 20
	new IsPlayerPlanes[PLANES] =
	{
	592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469
	};
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
		for(new i = 0; i < PLANES; i++)
		{
	    	if(GetVehicleModel(vehicleid) == IsPlayerPlanes[i])
	    	{
	        	return true;
	    	}
		}
	}
	return false;
}
PlayerWeapons(playerid)
{
	#define WEPS 42
	new IsPlayerWeapons[WEPS] =
	{
	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,
	36,37,38,39,40,41,42
	};
	for(new i = 0; i < WEPS; i++)
	{
		if(GetPlayerWeapon(playerid) == IsPlayerWeapons[i])
 		{
  			return true;
  		}
	}
	return false;
}
public Float:GetDistanceBetweenPlayers(p1,p2){
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)){
return -1.00;
}
GetPlayerPos(p1,x1,y1,z1);
GetPlayerPos(p2,x2,y2,z2);
return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
public CheckFuel(playerid)
{
	new Ptmess[32];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) == 1 && IsPlayerInAnyVehicle(i) == 1)
		{
   			if(GetPlayerState(i) == 2)
    		{
     			Vi = GetPlayerVehicleID(i);
     			Petrol[Vi]--;
				if(Petrol[Vi] >= 1)
				{
      				format(Ptmess, sizeof(Ptmess), "~n~~n~~n~~n~~n~~n~~w~Gas: ~r~%d", Petrol[Vi]);
      				GameTextForPlayer(i, Ptmess, 3500, 3);
      			} else {
					TogglePlayerControllable(i,false);
      				RemovePlayerFromVehicle(i);
      				SendClientMessage(i, COLOR_RED, "Your vehicle ran out of gas");
      				GameTextForPlayer(playerid,"~w~Use ~r~/exit ~w~to leave the car~n~Or use ~r~/service ~w~to call for a mechanic",4000,5);
 					if(Petrol[Vi] < 0)
	   				{
	   					Petrol[Vi] = 0;
	   				}
      			}
				if(Petrol[i] >= 51)
				{
					format(Ptmess, sizeof(Ptmess), "~n~~n~~n~~n~~n~~n~~w~Gas: ~r~%d", Petrol[Vi]);
       				GameTextForPlayer(i, Ptmess, 3500, 3);
 				}
			}
		}
	}
}
public RapedMe(playerid)
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && givenstd[i]==1)
        {
    		GetPlayerHealth(i, health);
    		SetPlayerHealth(i, health - 1);
        }
	}
}
public PlayerToPoint(Float:radi, playerid, Float:xx, Float:yy, Float:zz)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -xx);
		tempposy = (oldposy -yy);
		tempposz = (oldposz -zz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
public clock()
{
	new hour,minute,second,string[256];
	new year,month,day;
	gettime(hour,minute,second);
	getdate(year,month,day);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(hour == 0){SetWorldTime(0);SetPlayerWeather(i,0);format(string,sizeof(string),"~w~Time is - ~r~%d~w~:~g~0%d~n~~g~Todays Date - %s/%d/%d",hour,minute,month,day,year); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 1){SetWorldTime(1);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 2){SetWorldTime(2);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 3){SetWorldTime(3);SetPlayerWeather(i,3);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 4){SetWorldTime(4);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 5){SetWorldTime(5);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 6){SetWorldTime(6);SetPlayerWeather(i,6);format(string,sizeof(string),"~w~Time is - ~g~~g~%d~w~:~g~~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 7){SetWorldTime(7);format(string,sizeof(string),"~w~Time is - ~g~~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 8){SetWorldTime(8);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 9){SetWorldTime(9);SetPlayerWeather(i,9);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~0%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 10){SetWorldTime(10);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 11){SetWorldTime(11);SetPlayerWeather(i,11);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 12){SetWorldTime(12);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 13){SetWorldTime(13);SetPlayerWeather(i,13);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 14){SetWorldTime(14);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 15){SetWorldTime(15);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 16){SetWorldTime(16);SetPlayerWeather(i,16);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 17){SetWorldTime(17);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 18){SetWorldTime(18);SetPlayerWeather(i,18);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 19){SetWorldTime(19);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 20){SetWorldTime(20);SetPlayerWeather(i,20);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 21){SetWorldTime(21);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 22){SetWorldTime(22);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 23){SetWorldTime(23);SetPlayerWeather(i,23);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
			if (hour == 24){SetWorldTime(24);format(string,sizeof(string),"~w~Time is - ~g~%d~w~:~g~%d",hour,minute); GameTextForPlayer(i, string, 3500, 3);}
		}
	}
	return 1;
}

/*stock SetUpPlayerRace()
{
    new Float:nny, Float:x, Float:y;
	for(new i=0; i<inrace[i]; i++)
	{
		if(raceid == 0)
		{
		    if(justjoined[i] == 1)
		    {

		    }
		}
	}
}*/

