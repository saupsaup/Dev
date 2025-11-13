FUNCTION _Nh_CUST_RESTART  {HIDDEN} : BOOL

END_FUNCTION

VAR_GLOBAL
//	_rom_		{HIDDEN}				AT mObr	: USINT;		// pouzita len pre mapovanie rom koli exportu
	_rom_		{HIDDEN}				:BOOL;
   ROM_101	{HIDDEN}{PUBLIC} 	AT _rom_;            //Pepo;1
   ROM_102	{HIDDEN}{PUBLIC} 	AT _rom_;            //Spalna;1
   ROM_000	{HIDDEN}{PUBLIC} 	AT _rom_;            //System;0
   ROM_X02  {HIDDEN}{PUBLIC} 	AT _rom_; 				//Balkon;2
   ROM_X01  {HIDDEN}{PUBLIC} 	AT _rom_;            //Vonku;2

	GAT_X01			{PUBLIC} : BOOL;                 //Garáž-L;X01
	GAT_X02			{PUBLIC} : BOOL;                 //Garáž-P;X01
	GAT_X04_1		{PUBLIC} : BOOL;                 //Brána;X01
	GAT_X04_Y		{PUBLIC} : BOOL;                 //brana-zatvorit;X01
	GAT_X05_2		{PUBLIC} : BOOL;                 //Bránièka;X01
	GAT_X03_3		{PUBLIC} : BOOL;                 //Vstup.dvere;X01

	ZAS_000			{PUBLIC} : BOOL;                 //Zásuvka ON/OFF;102
	ZAS_001_1		{PUBLIC} : BOOL;                 //Zásuvka-Lampa;102
	ZAS_002_2		{PUBLIC} : BOOL;                 //Stykaè-ON;102
	ZAS_003_3		{PUBLIC} : BOOL;                 //Stykaè-OFF;102
	ZAS_004_4		{PUBLIC} : BOOL;                 //Zásuvka-ohrievaè;102
	ZAS_005_5		{PUBLIC} : BOOL;                 //Zásuvka-ventilátor;102
	ZAS_006_6      {PUBLIC} : BOOL;                 //Nabijacia stanica;102
	ZAS_009_9      {PUBLIC} : BOOL;                 //HW-Reset;102

END_VAR



(*
VAR_GLOBAL CONSTANT

   _NewDbx  : BOOL := 0;      // natvrdo sa po restarte vytvaraju vsetky nove dat1
//   _GoExp   : BOOL := 1;      // ide sa do exportu = exportuju sa vety CFG a postupuje sa podla ActHWA

	_NhIpWebPush	: string [16]		:='192.168.9.175';
	{$IFDEF __NH_DALI}
		_Nh_DALI_MA	{HIDDEN} : USINT	:=  2;			 									// pocet samostatnych sad vazieb aVaz[_Nh_VIO]
   {$END_IF}
	{ $IFDEF __NH_METEO_IQWS_4000 }
		_NhipIQWS       	 : string [16]		:='192.168.43.100'; 	//IP adresa anemometru IQWS 4000
	{ $END_IF}

 	_Nh_MSG	{HIDDEN} : USINT			:= 1;				// celkovy pocet formularov


	_Nh_MSG_RCV	: ARRAY[1..1] OF STRING[80] := [
	'f7ab034164f9378b1f2b65fd0554f912c0e2272f43a9d2e6fa25d377c65031cf'   	// moje
//	'.af2f65949afbc152c0d77eebb9aaf5d5cca5930cdc3057f52635c8301106c8b6',    	// Marek
//	'db9e76ae6a095bb2450409752c48b065f3cea3a5caf2f47401a3ece10ee6ea8e',	   // mamka
//	'87e08ab8c8c05dd0732292b70bf14649ed2e69ba4d363177a7d19c26196cfc21'      // Zuzka M.
	];


(*
	_Nh_MSG_NBR	{HIDDEN} : USINT			:= 1;											// celkovy pocet formularov
	_Nh_MSG_TOKEN	: ARRAY[1..3] OF STRING[80] := [
	'f7ab034164f9378b1f2b65fd0554f912c0e2272f43a9d2e6fa25d377c65031cf',  	// moje
	'db9e76ae6a095bb2450409752c48b065f3cea3a5caf2f47401a3ece10ee6ea8e',	   // mamka
	'A'
//	'db9e76ae6a095bb2450409752c48b065f3cea3a5caf2f47401a3ece10ee6ea8e',	   // mamka
//	'87e08ab8c8c05dd0732292b70bf14649ed2e69ba4d363177a7d19c26196cfc21'      // Zuzka M.
	];

END_VAR
*)
(*
VAR_GLOBAL
	rr					: BOOl;
   ROM_101        {PUBLIC} AT rr;                 //Pepo;1
   ROM_102        {PUBLIC} AT rr;                 //Spalna;1
   ROM_000         {PUBLIC} AT rr;                //System;0
   ROM_X02       {PUBLIC} AT rr;                 //Balkon;2
   ROM_X01       {PUBLIC} AT rr;                 //Vonku;2

	GAT_X01			{PUBLIC} : BOOL;                 //Garáž-L;X01
	GAT_X02			{PUBLIC} : BOOL;                 //Garáž-P;X01
	GAT_X04_1		{PUBLIC} : BOOL;                 //Brána;X01
	GAT_X04_Y		{PUBLIC} : BOOL;                 //brana-zatvorit;X01
	GAT_X05_2		{PUBLIC} : BOOL;                 //Bránièka;X01
	GAT_X03_3		{PUBLIC} : BOOL;                 //Vstup.dvere;X01

	ZAS_000			{PUBLIC} : BOOL;                 //Zásuvka ON/OFF;102
	ZAS_001_1		{PUBLIC} : BOOL;                 //Zásuvka-Lampa;102
	ZAS_002_2		{PUBLIC} : BOOL;                 //Stykaè-ON;102
	ZAS_003_3		{PUBLIC} : BOOL;                 //Stykaè-OFF;102
	ZAS_004_4		{PUBLIC} : BOOL;                 //Zásuvka-ohrievaè;102
	ZAS_005_5		{PUBLIC} : BOOL;                 //Zásuvka-ventilátor;102
	ZAS_006_6      {PUBLIC} : BOOL;                 //Nabijacia stanica;102
	ZAS_009_9      {PUBLIC} : BOOL;                 //HW-Reset;102
END_VAR
*)



