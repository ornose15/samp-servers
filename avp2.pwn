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
	SetGameModeText("AvP PyroIsland");
	eg = SetTimer("EndGame", 600000, 1);
	stime = SetTimer("UpdateScore", 1000, 1);
	rheal = SetTimer("RefHeal", 50, 1);
	SetTimer("Tips", 180000, 1);
	SetTimer("UpdateScoreMoney", 1000, 1);
	UsePlayerPedAnims();
	AddPlayerClass(249, -2107.9973,1999.6034,7.1142,310.7840, 38, 5000, 16, 5000, 32, 5000); //admin
	AddPlayerClass(287, -1938.0540,1842.7443,26.3585,359.1054, 28, 5000, 26, 5000, 30, 5000); //army
	AddPlayerClass(137, -1842.8695,2135.8142,7.0114,113.6264, 32, 5000, 27, 5000, 31, 5000); //pirate
	AddPlayerClass(260, -2062.5410,2050.8665,20.0404,299.2174, 0, 0, 0, 0, 0, 0); //spec

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
	CreatePickup(346,2,-1969.2083,2035.6317,7.0966);
	CreatePickup(348,2,-1966.5192,2036.8596,7.0966);
	CreatePickup(349,2,-1963.7264,2038.1349,7.0966);
	CreatePickup(351,2,-1960.7057,2039.5145,7.0966);
	CreatePickup(353,2,-1958.2472,2040.6376,7.0966);
	CreatePickup(356,2,-1950.9229,2043.9823,7.0466);
	CreatePickup(372,2,-1947.7323,2045.4397,7.0466);
	CreatePickup(346,2,-1944.0449,2047.1239,7.0466);
	CreatePickup(348,2,-1941.9049,2047.7377,7.0466);
	//JETPACKS
	AddStaticPickup(370,2,-1954.4640,2042.3652,7.0466);
	//karts ------------ p = pirates, s = spectators, a = army
	AddStaticVehicle(487,-1851.9633,2109.6445,7.0970,114.6322,74,35); // p
	AddStaticVehicle(571,-1857.1541,2120.7732,6.4722,114.3106,2,35); // p
	AddStaticVehicle(571,-1853.5062,2122.5718,6.4812,117.1404,40,35); // p
	AddStaticVehicle(571,-1849.9153,2124.2273,6.4712,121.1893,11,22); // p
	AddStaticVehicle(571,-1846.7469,2126.5798,6.4668,115.3137,91,2); // p
	AddStaticVehicle(571,-1843.1981,2128.0427,6.4671,113.9433,51,53); // p
	AddStaticVehicle(571,-1851.1484,2140.4031,6.4667,118.9802,2,35); // p
	AddStaticVehicle(571,-1853.9700,2139.1978,6.4669,118.6074,40,35); // p
	AddStaticVehicle(571,-1856.7799,2137.9587,6.4676,124.1178,11,22); // p
	AddStaticVehicle(571,-1859.3916,2136.2078,6.4670,111.6716,91,2); // p
	AddStaticVehicle(571,-1862.3660,2135.1323,6.4666,117.2197,36,2); // p
	AddStaticVehicle(571,-2049.5266,2043.0771,19.1704,301.2917,51,53); // s
	AddStaticVehicle(571,-2050.7017,2045.0343,19.1390,300.7363,36,2); // s
	AddStaticVehicle(571,-2051.9617,2047.2765,19.1554,301.3140,91,2); // s
	AddStaticVehicle(571,-2053.2649,2049.7795,19.1650,301.2825,11,22); // s
	AddStaticVehicle(571,-2059.0576,2060.8689,19.1570,301.0595,2,35); // s
	AddStaticVehicle(571,-2060.7485,2063.6648,19.1673,301.0403,40,35); // s
	AddStaticVehicle(571,-2061.7441,2066.0576,19.1433,293.2931,36,2); // s
	AddStaticVehicle(487,-2058.1511,2027.9784,20.0056,300.3306,26,57); // s
	AddStaticVehicle(571,-1931.1083,1883.9650,25.6957,24.1461,40,35); // a
	AddStaticVehicle(571,-1929.8059,1880.7181,25.6962,31.3201,11,22); // a
	AddStaticVehicle(571,-1927.7062,1877.3561,25.6902,26.8769,91,2); // a
	AddStaticVehicle(571,-1926.1772,1873.6383,25.6908,26.5311,51,53); // a
	AddStaticVehicle(571,-1924.9099,1870.1775,25.7094,24.6671,36,2); // a
	AddStaticVehicle(571,-1902.5598,1880.7296,25.6965,23.5828,36,2); // a
	AddStaticVehicle(571,-1903.9518,1883.9725,25.6826,25.3774,51,53); // a
	AddStaticVehicle(571,-1905.2863,1887.6625,25.6914,25.3687,91,2); // a
	AddStaticVehicle(571,-1906.3021,1890.7197,25.7086,25.3773,11,22); // a
	AddStaticVehicle(571,-1907.4609,1893.5605,25.7138,25.3450,40,35); // a
	AddStaticVehicle(497,-1994.2114,1841.3436,26.5188,293.9427,0,1); // a
	AddStaticVehicle(571,-2096.1934,2003.0588,6.4474,325.0143,91,2); // na
	AddStaticVehicle(571,-2099.1746,1999.1942,6.4840,328.0071,11,22); // na
	AddStaticVehicle(571,-2110.2854,2007.2493,6.4799,326.3999,40,35); // na
	AddStaticVehicle(571,-2107.8157,2010.9775,6.4860,320.9890,51,53); // na
	//PYROISLAND
	CreateObject(17639, -1875.132690, 2120.568115, 6.105145, 0.0000, 0.0000, 25.7831);
	CreateObject(17639, -1964.504883, 2077.365967, 6.118762, 0.0000, 0.0000, 25.7831);
	CreateObject(17680, -1954.950806, 1964.946289, 15.777016, 0.0000, 0.0000, 205.3013);
	CreateObject(17662, -2025.531616, 2067.413086, 12.665338, 0.0000, 0.0000, 27.5020);
	CreateObject(17639, -2048.931641, 2035.749146, 6.171646, 0.0000, 0.0000, 26.6425);
	CreateObject(8661, -1856.722412, 2128.894775, 5.933397, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1874.463623, 2120.683594, 5.884511, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1890.963135, 2112.775879, 5.881386, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1908.617310, 2104.324463, 5.879503, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1926.478882, 2095.755371, 5.877621, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1943.663330, 2087.472168, 6.020003, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1840.926880, 2094.441650, 5.907627, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1858.843994, 2086.122070, 5.830744, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1876.570557, 2077.954834, 5.828862, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1894.305176, 2069.758789, 5.826977, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1911.754639, 2061.697754, 5.825095, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1873.125122, 2164.405518, 5.944501, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1890.706421, 2156.254883, 5.839562, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1908.266846, 2148.176270, 5.837679, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1925.949341, 2139.989258, 5.885797, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1907.193115, 1863.390625, 25.394554, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1915.312256, 1881.230103, 25.412634, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1923.519409, 1899.216309, 25.421381, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1899.096558, 1845.640259, 25.442671, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1862.971802, 1862.094604, 25.440788, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1871.111938, 1879.937134, 25.413906, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1879.238525, 1897.702515, 25.407450, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1931.439819, 1916.631592, 25.419497, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1887.278809, 1915.365601, 25.355572, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1895.448242, 1933.054688, 25.353689, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1934.836914, 1829.380615, 25.360378, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1943.036133, 1847.347046, 25.358496, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1951.133911, 1865.139526, 25.424940, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1959.238892, 1882.953125, 25.448057, 0.0000, 0.0000, 204.4417);
	CreateObject(8661, -1967.138672, 1900.429810, 25.446186, 0.0000, 0.0000, 204.4417);
	CreateObject(13132, -1875.002930, 2171.206787, 9.119010, 0.0000, 0.0000, 115.0605);
	CreateObject(16021, -1926.657471, 2137.512451, 5.533579, 0.0000, 0.0000, 23.8573);
	CreateObject(16146, -1909.163818, 2164.092773, 8.899092, 0.0000, 0.0000, 115.1645);
	CreateObject(17523, -1838.874390, 2088.943604, 8.304813, 0.0000, 0.0000, 294.6828);
	CreateObject(4857, -1859.637207, 2147.252197, 8.310457, 0.0000, 0.0000, 294.6828);
	CreateObject(5189, -1919.921509, 2049.788574, 11.330061, 0.0000, 0.0000, 294.6828);
	CreateObject(6283, -1879.638672, 2075.103027, 10.932297, 0.0000, 0.0000, 26.6425);
	CreateObject(8661, -1927.995850, 2054.188232, 5.984540, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1943.149658, 2131.890869, 5.918120, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1960.828247, 2123.356201, 5.941238, 0.0000, 0.0000, 295.5422);
	CreateObject(14537, -1870.458374, 2070.528564, 7.787662, 0.0000, 0.0000, 26.6425);
	CreateObject(5418, -2066.161377, 2037.752563, 25.821688, 0.0000, 0.0000, 208.6357);
	CreateObject(1675, -1978.287476, 1896.822266, 28.605650, 0.0000, 0.0000, 295.6461);
	CreateObject(1675, -1971.052734, 1880.887085, 28.607521, 0.0000, 359.2443, 293.9272);
	CreateObject(1675, -1963.775024, 1864.515625, 28.584404, 0.0000, 0.0000, 294.6828);
	CreateObject(1677, -1940.794678, 1833.763672, 29.137327, 0.0000, 0.0000, 23.2048);
	CreateObject(3309, -1913.859375, 1846.869995, 26.843792, 0.0000, 0.0000, 114.3051);
	CreateObject(3310, -1888.414551, 1854.249634, 27.532679, 0.0000, 0.0000, 293.8234);
	CreateObject(3311, -1861.877808, 1866.862305, 28.352350, 0.0000, 0.0000, 206.2649);
	CreateObject(3312, -1887.924561, 1932.359131, 28.320415, 0.0000, 0.0000, 24.9237);
	CreateObject(3313, -1876.725708, 1907.816162, 28.259958, 0.0000, 0.0000, 294.6828);
	CreateObject(3873, -1950.536011, 2125.327637, 23.266121, 0.0000, 0.0000, 0.0000);
	CreateObject(6296, -1902.006836, 2138.016602, 8.001759, 0.0000, 0.0000, 0.0000);
	CreateObject(6962, -1880.527588, 2146.423828, 12.595716, 0.0000, 0.0000, 198.6338);
	CreateObject(16781, -2055.061279, 2018.125000, 18.851923, 0.0000, 0.0000, 207.0202);
	CreateObject(3167, -1952.249634, 1913.398315, 25.454971, 0.0000, 0.0000, 296.5056);
	CreateObject(3168, -1965.162964, 1905.989502, 25.800844, 0.0000, 0.0000, 116.7794);
	CreateObject(3169, -1961.121338, 1898.817505, 25.463018, 0.0000, 0.0000, 296.4017);
	CreateObject(3170, -1947.226318, 1905.907837, 25.446308, 0.0000, 0.0000, 298.9800);
	CreateObject(3173, -1918.076660, 1926.876221, 25.673634, 0.0000, 0.0000, 295.5422);
	CreateObject(3174, -1907.564575, 1931.770508, 25.382471, 0.0000, 0.0000, 115.0605);
	CreateObject(3178, -1862.164673, 1889.553345, 28.154999, 0.0000, 0.0000, 115.0604);
	CreateObject(8420, -1992.082642, 1836.370728, 25.367142, 0.0000, 0.0000, 294.6828);
	CreateObject(3187, -1961.082275, 1818.360107, 29.221205, 0.0000, 0.0000, 24.9237);
	CreateObject(4199, -1989.657715, 1800.880615, 27.456181, 0.0000, 0.0000, 115.0605);
	CreateObject(7073, -1844.314941, 2144.967041, 24.195337, 0.0000, 0.0000, 0.0000);
	CreateObject(3506, -1876.882568, 2127.802979, 6.181406, 0.0000, 0.0000, 0.0000);
	CreateObject(3506, -1870.216919, 2114.569092, 6.181406, 0.0000, 0.0000, 0.0000);
	CreateObject(623, -1880.039795, 2109.687012, 6.456564, 0.0000, 0.0000, 28.3614);
	CreateObject(623, -1893.471802, 2119.935059, 6.456564, 0.0000, 0.0000, 189.0761);
	CreateObject(8661, -1948.614990, 2052.455566, 6.025362, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1966.349609, 2044.239746, 6.048477, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1983.766724, 2036.400391, 5.871593, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1945.735962, 2046.041992, 6.046594, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1963.731079, 2037.729492, 6.096594, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1976.997681, 2031.591187, 5.794711, 0.0000, 0.0000, 294.6828);
	CreateObject(8661, -1973.579346, 2105.937988, 6.146468, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1991.020020, 2096.983398, 6.144585, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -2006.526611, 2087.099609, 6.167699, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1976.947754, 2115.598389, 5.919584, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -1994.356567, 2107.232666, 5.917704, 0.0000, 0.0000, 295.5422);
	CreateObject(8661, -2012.299561, 2098.623291, 5.937166, 0.0000, 0.0000, 295.5422);
	CreateObject(3436, -1996.295288, 2110.107666, 11.697956, 0.0000, 0.0000, 25.7831);
	CreateObject(3469, -1950.871094, 2030.672363, 9.211882, 0.0000, 0.0000, 114.2010);
	CreateObject(3469, -1962.366943, 2055.918701, 9.163765, 0.0000, 0.0000, 115.0605);
	CreateObject(1306, -1974.445557, 2035.272583, 13.592382, 0.0000, 0.0000, 297.2611);
	CreateObject(1340, -1941.313721, 2073.901367, 7.147589, 0.0000, 0.0000, 116.0240);
	CreateObject(1341, -1946.112183, 2101.123291, 7.022588, 0.0000, 0.0000, 297.2612);
	CreateObject(1342, -1924.002075, 2081.583496, 6.911315, 0.0000, 0.0000, 118.6023);
	CreateObject(1342, -1937.166260, 2105.107422, 6.911315, 0.0000, 0.0000, 295.4387);
	CreateObject(6299, -1986.373291, 2088.093018, 8.414972, 0.0000, 0.0000, 296.4017);
	CreateObject(1372, -2019.408936, 2093.711426, 6.297601, 0.0000, 0.0000, 297.2611);
	CreateObject(971, -1840.592285, 2126.454590, 9.676146, 0.0000, 0.0000, 26.5388);
	CreateObject(971, -1842.057495, 2120.348145, 9.478331, 0.0000, 0.0000, 114.0975);
	CreateObject(971, -1838.480469, 2112.286377, 9.444330, 0.0000, 0.0000, 114.0975);
	CreateObject(976, -1836.655029, 2108.231934, 6.019537, 0.0000, 0.0000, 294.6828);
	CreateObject(976, -1833.118042, 2100.295654, 5.998159, 0.0000, 0.0000, 203.5825);
	CreateObject(971, -1849.397339, 2143.585938, 9.707210, 0.0000, 0.0000, 190.7949);
	CreateObject(971, -1854.470947, 2146.862549, 9.478323, 0.0000, 0.0000, 294.6828);
	CreateObject(971, -1858.084717, 2154.909668, 9.505219, 0.0000, 0.0000, 114.2012);
	CreateObject(971, -1861.776123, 2162.961670, 9.489434, 0.0000, 0.0000, 115.1645);
	CreateObject(971, -1865.437134, 2170.994385, 9.485867, 0.0000, 0.0000, 113.4456);
	CreateObject(9483, -2132.159180, 2005.620972, 5.156968, 0.0000, 0.0000, 59.3011);
	CreateObject(4193, -2111.451660, 1982.180298, 20.403214, 0.0000, 0.0000, 148.6825);
	CreateObject(971, -1838.176392, 2132.634277, 9.714275, 0.0000, 0.0000, 294.6828);
	CreateObject(971, -1841.763306, 2141.015869, 9.632155, 0.0000, 0.0000, 113.4456);
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
	SendRconCommand("changemode avp3");
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
	SetPlayerMapIcon(playerid,0,-1956.6105,2041.4351,7.0966,18,COLOR_RED); //weapon icon
	SetPlayerMapIcon(playerid,1,-1846.0914,2134.3215,7.0114,9,COLOR_RED); //pirate icon
	SetPlayerMapIcon(playerid,2,-1914.3405,1879.8103,26.4591,30,COLOR_RED); //army icon
	SetPlayerMapIcon(playerid,3,-2073.2849,2044.0428,28.7045,60,COLOR_RED); //spectator icon
	SetPlayerMapIcon(playerid,4,-2112.3235,1981.1239,34.4328,32,COLOR_RED); //admin icon
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
		if(gTeam[playerid] == ADMIN)
		{
			SetPlayerPos(playerid, -2107.9973,1999.6034,7.1142);
			SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == REF) {
			SetPlayerPos(playerid, -2062.5410,2050.8665,20.0404);
			SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == ARMY) {
		    SetPlayerPos(playerid, -1938.0540,1842.7443,26.3585);
            SendClientMessage(playerid,COLOR_YELLOW, "Welcome home");
		} else if(gTeam[playerid] == PIRATE) {
		    SetPlayerPos(playerid, -1842.8695,2135.8142,7.0114);
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

