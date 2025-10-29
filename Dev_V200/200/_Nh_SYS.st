// { $DEFINE __NH_METEO_IQWS_4000 }
// { $DEFINE __NH_FRM }
{ $DEFINE __NH_WEB }
//{ $DEFINE __NH_DALI } // pritomnost DALI
{ $DEFINE __NH_WRK } // ak je // budu sa generovat ladiace premenn

// { $DEFINE __NH_PSN }
// { $DEFINE __NH_EXP }


// NUTNTY ZAKLAD
VAR_GLOBAL CONSTANT
	_NH2_VER: STRING[3] := '200';
	_NH_ZONES {HIDDEN}: USINT			:= 5; // pocet default Zon
   { $ IF CPU_CODE > 1999 }
		_NH_CLUSTER		{HIDDEN}: UDINT			:= 4096;
      _NH_RAM			{HIDDEN}: UDINT			:= 150000;		 // pre 1000 je mensia pamat
      _Nh_WEB_M		{HIDDEN}: USINT			:= 3;					// pocet nezavislych webovych stranok pre M-klientov
      _Nh_USR		 {HIDDEN}: USINT			:= 5;					// pocet usrov, malo by odpovedat _Nh_WEB_M
// { $DEFINE __NH_FRM } // aktualizuju sa vsetky formulare
   { $ ELSIF CPU_CODE = 1001 OR CPU_CODE = 1047 }
		_NH_CLUSTER		{HIDDEN}: UDINT			:= 512;
// _NH_RAM		{HIDDEN}: UINT			:= 28000;
      _NH_RAM			{HIDDEN}: UDINT			:= 65535;
      _Nh_WEB_M		{HIDDEN}: USINT			:= 1;
      _Nh_USR		 {HIDDEN}: USINT			:= 5;					// pocet usrov, malo by odpovedat _Nh_WEB_M
   { $ ELSE }
		_NH_CLUSTER		{HIDDEN}: UDINT			:= 512;
      _NH_RAM			{HIDDEN}: UDINT			:= 28000;
      _Nh_WEB_M		{HIDDEN}: USINT			:= 1;
      _Nh_USR		 {HIDDEN}: USINT			:= 1;					// pocet usrov, malo by odpovedat _Nh_WEB_M
   { $ END_IF }
// _Nh_ADR_ROT {HIDDEN}: STRING[5] := 'NH2/'; // hlavny adresar konfiguracie
   _Nh_EXP {HIDDEN}: STRING[7] := 'NH2.exp';
	_Nh_CFG			{HIDDEN}: USINT			:= 70;				// pocet viet DEV (kazde DEV ma HED)
	_Nh_PAR			{HIDDEN}: USINT			:= 16;			 	// pocet viet parametrov
	_Nh_VAZ 			{HIDDEN}: USINT			:= 9;			 	// pocet samostatnych sad vazieb aVaz[_Nh_VIO]
//	_Nh_VCF			{HIDDEN}: USINT			:= 2;			 	// pocet viet CFG presortovanycg vazieb na pointroch
//	_Nh_WRK			{HIDDEN}: USINT			:= 3;			 	// pocet viet CFG work pamate, ktora sa vymazava pri kazdom cykle
	_Nh_CAT			{HIDDEN}: USINT			:= 70;				// celkovy pocet kategorii
	_Nh_CAT_STA		{HIDDEN}: USINT			:= 5;				// max pocet stavov kategorii [0..5]
   _Nh_TYP {HIDDEN}: SINT := 5; // MAX pocet zakladnych typov
END_VAR

FUNCTION_BLOCK aTrgQx	{HIDDEN} 				// TRIGER VSTUPU vyhodi zmenu vstupu In, impulz pri zacati a skonceni
	VAR_INPUT
      In: BOOL; // vstup (pre vyhodnotenie zmeny)
   END_VAR
   VAR_OUTPUT
      Qr: BOOL; // impulz pri nastaveni vstupu IN - zaroven nastavi aj Q
      Qf: BOOL; // impulz pri skonceni vstupu IN - Q uz nie je nastavene
      Qx: BOOL;
      Q: BOOL; // trvanie signalu na vstupe In
   END_VAR
   Qf := Q AND In = FALSE ;
   Qr := Q = FALSE AND In ;
   Qx := Qf OR Qr;
   Q := In;
END_FUNCTION_BLOCK


TYPE
   NH_DEV_IO		{HIDDEN}: STRUCT
		c: USINT; 				// dev cfg
		n: INT; // cislo DEV
		p: INT; // cislo parametra
   END_STRUCT;

   NH_CFG_ALL {HIDDEN}: STRUCT // rozsirena CFG = vacsina DEV
		Idx: INT;								// index / cislo dev (aCfg[idx])
		typ: SINT; // typ
	 	Rom: USINT; 							// cislo miestnosti
      cat: USINT; // kategoria
		Par: INT; 							// cislo default parametra, 255 znamena, ze sice je parameter, ale pouziva sa az vo vazbach. napr. pri WSB
		Name: STRING[20]; // := 'Všetky miestnosti'; // nazov
      blk: BOOL; // blokovanie DEV
      inv: BOOL; // inverzne DEV (zapnutim sa vypne ON = OFF)
		psn: BOOL; // aktivne dev dava signal pre PSN
// LogEvn: BOOL; // Logovat event = udalost do Log suboru
      LogAct: BOOL; // Logovat akciu od Eventu
      NoShow: BOOL; // nezobrazit v miestnosti v RUN rezime
      DevExt: BOOL; // odkaz na ine DEV (DALI,MQTT..) potom ma .hw strukturu NH_DEV_SW4
//		RestoreLVL: BOOL;	 				 // od 13.3.24 tento par urcuje ci po restarte sa obnovi stav { predtym xDev^.cx.all.LvlOnRst}
//		Dummy1: BOOL;	 				 // od 13.3.24 tento par urcuje ci po restarte sa obnovi stav { predtym xDev^.cx.all.LvlOnRst}
		LvlOnRst: BOOL := TRUE;
		Dummy2: BOOL;
//		ID: STRING[6]; 			 // jednoznacne ID (108_01)
       // ***10.11.22
   	ID: STRING[5]; 			 // jednoznacne ID (108_01)
       // ***30.1.23 do LIP islo aj s tymto, k ROSOCH bez tohto

	END_STRUCT;

	NH_CFG_CFG: STRUCT 					// zakladny konfiguracny subor vsetkych DEV a ich rozlozenie v RAM
		Siz: UDINT;								// 4	velkost jedneho zaznamu
		Ram: UDINT;							 	// 8 	adresa 1.vety vo virtualnej pamati mRam[ vRam ], kde je ulozena xCfg (nulta veta )
      Rec: INT; 	// 10		pocet zaznamov
      ver: USINT := 0; // 11
  		cfg: STRING[3] ;						// 15	 nazov suboru na SDC dev := xxx.***
		New: INT;						 	// 17 pocet novych zaznamov, ktore sa ziadaju
	 NOk: BOOL; 	// 18
		ini: BOOL;
		ImpExactVer: BOOL := 0;					// obnovuju sa len rovnake verzie
      ImpFullRec: BOOL := FALSE; 			// z DBX sa obnovuje cela veta velkosti SIZ. inak po cf+al+cx...
		ImpFullCfg: BOOL := FALSE;					// z DBX naimportuje vsetky zaznamy k CFG
		DelAfterImp: BOOL := FALSE;					// po importe vsetky zaznamy oznaci ako neplatne - dalsou kontrolou sa odznacia
      ofs: UDINT; // 22	offset Empty premennej od eRom

      par: USINT; // 23 cislo parametra (odkaz do aPar)
      cat: USINT; // 25	cislo cat do ktorej patri toto dev
      ref: USINT := 251; // 26	druh refreshu 251-len to co je na obrazovke,252=to co je na obrazevke a predefinovat,254=novy vypis od 1.zanamu
      tGrp: USINT; // typovy predstavitel/skupina vazieb

      al: USINT;								// 27
      cx: UDINT; // velkost specialnej cfg pre dev
      cf: USINT := SIZEOF(NH_CFG_ALL); // velkost hlavnej cfg
      me: UDINT; // velkost uzivatelskej prevadzkovej pamate
      hw: USINT; // velkost HW pamate
      io: UDINT;

		// potialto sa nesmie prehadzovat

      dummy5: USINT;




		Imp_AL: BOOL;								// vynimka: ma sa obnovovat aj .al napr pre HET}
//		Imp_IO: BOOL;								// .IO sa z DBX neobnovuje

      // dotialto sa obnovuje DBXver > 001
		NbrPoi: USINT;								// priaznak ze ma poi je zaroven aj pocet POI vo vete (ROM=1,HET=2,HEV=2)
      mWsb: USINT; // cislo menu pre akcie od WSB/TLA/TGL
      mnu: USINT; // cislo menu pre ikonu vlastnosti - user _042.MN0
      rExp: USINT; // pocet viet v z exportu
      fBr: USINT; // cislo formatoveho suboru pre pre BRW-ROW, ulozene _Nh_ADR_ROT,'/CFG/FRM/_000.
      fSc: USINT := 200; // cislo menu cez ktore sa dostane so _Nh_Frm_SCR = parametrov DEV
      ar2: BOOL; // '>>' dvojita sipka dalej je v obr[4] prioritou c.1
      lst: BOOL; // ma ikonu DEV-listu {SCN,ACT..}
      stp: BOOL := TRUE; // moze mat odskok na vazby = ikona setup (len v rezime setup)
      fav: BOOL := TRUE; // ma ikonu fav
      chk: BOOL := TRUE; // ma ikonu check (ak je vo vazbach)
      edn: BOOL := TRUE; // moze sa editovat nazov
      sld: BOOL; // DEv ma slider v riadkovom zobrazeni
      ou: BOOL; // tot je vystup - kde sa nieco nastavuje
// dbx: BOOL; // data boli obnovene z DBX
// sdc: BOOL; // data boli obnovene z SDC
// NoDelDBX: BOOL; // pri obnoveni z DBX sa NE-oznaci ako DEL. Potom ju odznaci proces aktualizacie adries z NH2.ADR
      NoRecCat: BOOL; // pri zfiltrovani kategorie sa zobrazia aj ked nemaju ziadny zaznam
// scn: BOOL; // priznak, ze ide o dev, ktore riadi viac vystupnych DEV (SCN,ACT,TIM...) ma nejeky dev-list
      body: BOOL; // tento DEV zapisuje pritomnost

      del: BOOL;			 // je mozne mazat DEV (ON/OFF)
      bck: BOOL := TRUE; // toto cfg sa zalohuje z RAM -> SDC
      imp: BOOL := TRUE; // do cf sa importuju adresy z CIB .... , ROM nebude mat adresy
      NewExp: BOOL; // toto CFG ma z exportu nove data/adresy a musi sa aktualizovat
      QckStat: BOOL; // v HOME-QuickMnu sa vypisuju obrazku zo stat, nie z dev
      lvl254: BOOL; // dev nema max LVL 100% ale 254 = DALI (len pre web)
      analog: BOOL; // dev je 0-100% alebo 0-254 (len pre web)
      dali: BOOL; // patri do dali
      ShwSta: BOOL; 		 // robrazi sa ikona cfg v ROM/ZON ak je niektore z DEV v [cf] aktivne
      zone: BOOL; // moze vstupovat {davat signal} aj do zony (TER,LUX)
		RomIsZone: BOOL;								// xDev^.cf.rom je cislo zony, inak cislo miestnosti {default}
		Visible: BOOL;									// v meu vazieb sa bude zobrazovat visible
		led: BOOL;
		dis: BOOL;
	END_STRUCT;

  	NH_PAR_CFG: STRUCT 					// zakladny konfiguracny subor vsetkych parametrov
		Siz: UDINT;								// 4	velkost jedneho zaznamu
		Ram: UDINT;							 	// 8 	adresa 1.vety vo virtualnej pamati mRam[ vRam ], kde je ulozena xCfg (nulta veta )
      Rec: INT; 	// 10		pocet zaznamov
      ver: USINT := 1; // 11
  		cfg: STRING[3] ;						// 15	 nazov suboru na SDC dev := xxx.***
		New: INT;						 	// 17 pocet novych zaznamov, ktore sa ziadaju
	 NOk: BOOL; 	// 18
		ini: BOOL;
		ImpExactVer: BOOL := FALSE;					// obnovuju sa len rovnake verzie
      ImpFullRec: BOOL := TRUE; 			// z DBX sa obnovuje cela veta velkosti SIZ. inak po cf+al+cx...
		ImpFullCfg: BOOL := FALSE;					// z DBX naimportuje vsetky zaznamy k CFG
		DelAfterImp: BOOL := TRUE;					// po importe vsetky zaznamy oznaci ako neplatne - dalsou kontrolou sa odznacia
      ofs: UDINT; // offset Empty premennej od epSvd
      grp: BOOL; // novy parameter sa vytvori, len ak vstupuje na pozici OUT skupinovych prikazov do SCN,ACT,TIM. Inak sa zoberie default cislo paramtra z DEV
	END_STRUCT;

   NH_REC_VAZ		{HIDDEN}: STRUCT 	// uvodny zaznam pre DEV
 		ok: BOOL;						 // platna veta
   END_STRUCT;
   NH_VAZ		{HIDDEN}: STRUCT 		 // veta vazieb
		ok: NH_REC_VAZ;
		in: NH_DEV_IO; 		// dev in
		ou: NH_DEV_IO; // dev out
	END_STRUCT;

  	NH_VAZ_CFG: STRUCT 			 // zakladny konfiguracny subor vazieb
		Siz: UDINT := SIZEOF(NH_VAZ);		// 4	velkost jedneho zaznamu
		Ram: UDINT;							 	// 8 	adresa 1.vety vo virtualnej pamati mRam[ vRam ], kde je ulozena xCfg (nulta veta )
      Rec: INT; 	// 10		pocet zaznamov
      ver: USINT := 1; // 11
  		cfg: STRING[3] ;						// 15	 nazov suboru na SDC dev := xxx.***
		New: INT;						 	// 17 pocet novych zaznamov, ktore sa ziadaju
	 NOk: BOOL; 	// 18
		ini: BOOL;
		ImpExactVer: BOOL := FALSE;					// obnovuju sa len rovnake verzie
      ImpFullRec: BOOL := TRUE; 			// z DBX sa obnovuje cela veta velkosti SIZ. inak po cf+al+cx...
		ImpFullCfg: BOOL := TRUE;					// z DBX naimportuje vsetky zaznamy k CFG
		DelAfterImp: BOOL := FALSE;					// po importe vsetky zaznamy oznaci ako neplatne - dalsou kontrolou sa odznacia
   END_STRUCT;

  	NH_DBX_VER {HIDDEN}: STRUCT 			// riadiaca hlavicka DBX
      CRC: STRING[12] 	:= '#d13.4!M65y*';
      VER: STRING[3] 	:= _NH2_VER; // .cx a.IO su uz UDINT, pribudl NoRestAl
      Dbx0: UDINT 			:= 0; // pociatocna adresa v DBX ka msa zacina zapisovat aCfg,aPar,aVaz...
	END_STRUCT;
  	NH_DBX: STRUCT 			// riadiaca hlavicka DBX
      ver: NH_DBX_VER ;
		sCfx: ARRAY[0..2] OF USINT := [SIZEOF(NH_CFG_CFG), SIZEOF(NH_PAR_CFG), SIZEOF(NH_VAZ_CFG)];
		nCfx: ARRAY[0..2] OF USINT := [_Nh_CFG, _Nh_PAR, _Nh_VAZ];
		aCfx: ARRAY[0..2] OF UDINT;
      vRam: UDINT; // aktualna velkost dat v aRam[] = posladny zaznam aVaz
		FromDBx128: BOOL := FALSE;				// tento DBX bol obnoveny z databoxu, kde ja max. velkost 128*1024 B
		dummy: STRING[141];
	END_STRUCT;

   NH_DiskInfo: STRUCT 				// HLAVNA RIADIACA PREMENNA
		path		   : STRING[20];
		Exist		   : BOOL;
		ErrCrDir		: BOOL;
		freeSpace	: USINT;                
		Info		   : TDiskInfo;
	END_STRUCT;
							

   NH_DISK_HED: STRUCT
//		i: USINT;

//		exec: BOOL;
		disk: ARRAY[1..4] OF NH_DiskInfo :=
					[	(	path := 'NH2/'), 			// root
						( 	path := 'USB/'), // usb
						( 	path := 'SDC/'), // sdc
						( 	path := 'RAM/') // ram
					];
		USB_Ready:   aTrgQx; // := (Qx := FALSE, Q := FALSE, In := TRUE);
		err:         BOOL;							// running operation create all directories
		timeExec:      UINT; 						   // time create / check all directories

	END_STRUCT;

	NH_LOG_HED_DBX_Write: STRUCT		// datagram
//		FirstDtgrAdr:		UDINT;		// address of the current header	
//		LastDtgrAdr:		UDINT;		// address of the last header written		
		HeadAdr:				UDINT;		// address of the current header
		Rows: 				USINT; 		// current rows in header
 		Bytes: 				INT;  		// current bytes of the entire datagram (header + rows)
		RowAdr:				UDINT;   	// newline address
		buffer:				bool;			// buffer number where writing 1/2
	END_STRUCT;
	NH_LOG_HED_DBX_Read: STRUCT
		buffer:				bool;			// buffer number from reading 1/2. 0=not reading
		DtgrAdr:				UDINT;   	// address of the datagram header to be read
		LastDtgrAdr:		UDINT;		// the address of the datagram header that was written and not read
		LastDtgrLen:		INT:=1200; 	// the length of the datagram with which it was written	
	END_STRUCT;
	NH_LOG_HED_DBX: STRUCT
		write:				NH_LOG_HED_DBX_Write;
		read:					NH_LOG_HED_DBX_Read;				
		HeadLen:				USINT:=12;	// Datagram header length
		DatagramLen:		INT := 1200;	
		DbxBeginAdr: 		UDINT := 0; // zaciatok dat logu
		DbxEndAdr: 			UDINT;
		
		dummy:				STRING[11];
	END_STRUCT;

	NH_LOG_HED: STRUCT
		Quite10Sec: 	USINT;									// kolko sec nebol zapis do evn, podla toho zavrie
		Writes: 			UINT;
     	logDate: 		STRING[8] := '25-04-13';	// log dat
	  	logTime: 		STRING[11] := '13:04:01.12';
		fhEvn: 			HANDLE; // subor textov a prekladov
	END_STRUCT;

(*
	NH_LOG_DBX_HED: STRUCT
		AdrHed: 			UDINT := 0; // adresa hlavicky logu
	END_STRUCT;
*)


   	NH_SYS: STRUCT 				// HLAVNA RIADIACA PREMENNA
		ini						: USINT := 250; 		// Cislo procesu, ktory prebieha. Restart zcina 0... , 255 je vykonavanie finalneho programu
		LogDBx					: NH_LOG_HED_DBX;
		LogHed					: NH_LOG_HED;
		DiskHed					: NH_DISK_HED;
		ADR_DBX					: STRING[25] := 'NH2/200/DBX/25032423/'; // hlavny adresar konfiguracie
//		IS_USB_DISK: aTrgQx;

		// these variables are one cycle behind the system,
		YEAR			         : USINT;				   // actual YEAR (next cycle after change in  system)
		MONTH			         : USINT;				   // actual MONTH
		DAY			         : USINT;				   // actual DAY
		F_EDGE_1MON				: BOOL;					// new month
		F_EDGE_1DAY				: BOOL;					// new day
		F_EDGE_1MIN				: BOOL;					// new minute

		NewDbx					: BOOL;					// natvrdo sa po restarte vytvaraju vsetky nove dat1
		UpdDbx					: USINT;				// sumarny pocet zatial neulozenych modifikacii vo vsetkych suboroch
		UpdFile					: USINT;				// sumarny pocet zatial neulozenych modifikacii vo vsetkych suboroch
		nMemToDbx				: UINT;
		nMemToRBx				: UINT;
		nDbxToMem				: UINT;
		nDbxToFile				: UINT;
		mSec						: UINT;					// pocet miliSec posledneho cyklu - UINT
		mSecMax					: UINT;					// max pocet miliSec za poslednu minutu
		mSecLimit				: UINT := 300;			// obmedzenie dlzky cyklu u suborovych transakcii
		RWtoFileCycle			: UDINT;				// kolko byte bolo zapisane v tomto cykle
		NhDT						: DT;					// na zaciatku cyklu sa nacita DT
		NhDate					: DATE;					// na zaciatku cyklu sa nacita Date
		NhTime					: TIME; 				// na zaciatku cyklu sa nacita

      aRoW1: UDINT; // 1.veta wrk rom
      sRoW: UDINT; // velkost wrk-rom vsetkych viet
      aZoW1: UDINT; // 1.veta prevej zony = domcek
      sZoW: UDINT; // velkost vsetkych wrk-viet ZON
      vIx1: UDINT; // adresa 1.indexu browsu (hned za poslednou vazbou)
      vIx2: UDINT; // adresa posledneho indexu. Je UDINT, lebo moze presiahnut 65 535, potom sa zapisuje do bRam
      Err_vIx2: UDINT; // o kolko prekrocili data browsu limit UINT (65535)
      Err_vDbx: UDINT; // ZAVAZNA CHYBA - o kolko prekrocili hlavne data virtualnu pamat mRam - limit UINT (65535)
      Err_vSrt: UDINT; // ZAVAZNA CHYBA - o kolko prekrocili data vazieb pri sortovani za koniec mRam

		UseRBx: BOOL; 							// namiesto DBx pouzivat RBx
		IS_RBx: BOOL;							// RamBox Exist CPU > 2000
		IS_DBx: BOOL;					 // DataBox Exist

		CloseAllFiles: BOOL;

//		rst: aTrgQx;
		Size_RBx: UDINT;
		Size_DBx: UDINT;


		OpenFilesCount: UINT;
      LangfH: HANDLE; // subor textov a prekladov

		LuxOut: USINT;
		LuxIn: USINT;
		rSec: REAL;							// pocet miliSec posledneho cyklu - REAL
      rTime: REAL; // aktualny cas v REAL forme



      ErrPt: UINT; // pocet chybnych mapovani xPtr
      ErrPar: UINT; // pocet chybnych mapovani xPtr

//      LastRstDT: DT; // cas posledneho restartu
//      LastRstTyp: USINT; // typ posl.restartu: 1=Cold/hot/restart/none


      ActExp: INT; // aktualne sortovana veta
      SrtExp: INT; // kolkokrat preslo vsetky vety exportu
      RecExp: INT; // pocet viet exportu

      Restart: BOOL; // prebieha restart, v aSys.Ini je to len jeden cyklus
      RestCyc: UINT; 			// pocet sec od restartu, ked bude nastavena RestIni;
		RestartBck: BOOL;							// po uspesnom restarte vytvori po 1.minute ram subor


      Exp: USINT; // stav vytvarania exportu a ADR suboru
// TypExp: USINT; // po restarte 0=nebol export do .ADR, ver.1='RGB_102_01_Q', ver.2='RGB_9A7_Q',
// EndExp: UINT; // adresa poslednej vety docasneho exportu
// IniAdr: USINT; // postupne kroky extrahovania z exportu
// tDbxRam: UINT; // posledny cas cyklu ked boli z DBX obnovene data DO RAM
// tRamDbx: UINT; // posledny cas cyklu ked boli z RAM data zalohovane do RAM

      nDbxRam: UINT; // pocet obnoveni dat z DBX do RAM
      nRamDBX: UINT; // pocet zapisov dat z RAM DO DBX

      dMin: INT; // pocet minut v ramci dna
      n1Sec: USINT; // naplni sa cislom, ked bode sekundovy impulz
      u1Sec: UINT; // to iste co n1Sec len
      u1Min: UINT; // to iste co n1Sec len
      u100mS: UINT; // to iste co n1Sec len
      u50mS: UINT; // to iste co n1Sec len
      i1Sec: INT; // to iste co n1Sec len
      n1Min: USINT; // naplni sa cislom, ked bode MIN impulz
      i1Min: INT; // naplni sa cislom, ked bode MIN impulz
//		NhLcT: UINT; // SYSTEM_S.LAST_CYCLE_TIME_100US; (1s=10 000)
		et50: UINT; 							//
		et100: UINT; 							// napocitava do 1 000	 (100ms )
		et200: UINT; 							// napocitava do 2 000	 (200ms )
		PULSE_50MS: BOOL; // pulz kazdych 50ms
		PULSE_100MS: BOOL; // pulz kazdych 100ms
		PULSE_200MS: BOOL; // pulz kazdych 200ms

		PULSE_BEEP: BOOL; // 0.5s dlhy impulz kazde 2 min
		et_PULSE_BEEP: UINT;
//	 frw: NH_FRW;
      aDbxSdc: UDINT; // pocitocna adresa DBX odkial sa zapisuje
      sDbxSdc: UDINT; // velkost dat DBX pre zapis na SDC_Nh_RAM;
      n100ms: USINT;
      n50ms: USINT;

		Debug: BOOL := TRUE;					// vypisuje debug spravy

		RefCyc: USINT;							// cislo cyklu v sekvencii (0->1->2->3->4) od prechodu na novu minutu ->, alebo iny refresh
		EXP_ROM: BOOL := TRUE; // preberat z exportu aj miestnosti ak sa najdu
		RefCycNew: BOOL;							// poziadavka na rucne nastartovanie sekvencie
      chg: BOOL; // priznak modifikacie parametrov od posledneho ulozenia
      Qf230: BOOL; // impulz pri vypadku napatia
      Qr230: BOOL; // impulz pri obnoveni napatia
      QfHDO: BOOL; // impulz pri vypnuti HDO
      QrHDO: BOOL; // impulz pri zapnuti HDO
      prgChange: BOOL;
      CfgRamOk: BOOL; // v RAM sa nachadzaju platne data (z DBX, SDC alebo novovytvorene). Mozu byt aktualnejsie ako v DBX
      CfgDbxOk: BOOL; // true = v dbx je CFG ok ,
		CfgBckOk: BOOL; // posledne zistovanie, ci existuje subor na SDC podla dbx.mem
      ExtPSN: BOOL; // stav komunikacie s Ext PSN
      Locked: BOOL; //
      Open: BOOL; //
      pass: BOOL;
// CPU_DO0: BOOL; // rele 0 na CPU, ktore sa pouziva na HW-reboot procesora
      DO0_REBOOT: BOOL; // rele 0 na CPU, ktore sa pouziva na HW-reboot procesora
      Sim: BOOL; // simulator PLC
		cyc: BOOL;
	END_STRUCT;





   NH_BTN8 {HIDDEN}: ARRAY[1.. 8] OF BOOL;
	NH_BTN3 {HIDDEN}: ARRAY[1.. 3] OF BOOL;
   NH_BTN4 {HIDDEN}: ARRAY[0.. 3] OF BOOL;
   NH_BTN05 {HIDDEN}: ARRAY[0.. 5] OF BOOL;
   NH_BTN15 {HIDDEN}: ARRAY[0..15] OF BOOL;
   NH_LVL15 {HIDDEN}: ARRAY[0..15] OF USINT;
   NH_PV03 {HIDDEN}: ARRAY[0.. 3] OF USINT;
   NH_PV18 {HIDDEN}: ARRAY[1..8] OF USINT; // click 1-5, P,H [switch,0,0,0,0,Push,Hold,0]

   NH_PV01 {HIDDEN}: ARRAY[0.. 1] OF USINT;
   NH_PI14 {HIDDEN}: ARRAY[1..14] OF INT;

END_TYPE



VAR_GLOBAL CONSTANT
   _Cfg0 {HIDDEN}: UDINT := SIZEOF(NH_DBX); 	// zaciatok CFG
   _Par0 {HIDDEN}: UDINT := _Cfg0 + SIZEOF(NH_CFG_CFG) * _Nh_CFG; // zaciatok PAR
   _Vaz0 {HIDDEN}: UDINT := _Par0 + SIZEOF(NH_PAR_CFG) * _Nh_PAR; // zaciatok VAZ
   _Ram0 {HIDDEN}: UDINT := _Vaz0 + SIZEOF(NH_VAZ_CFG) * _Nh_VAZ; // prva veta aCfg[1] rom = 1.miestnost
END_VAR

VAR_GLOBAL // grobalne pouzivane premenne
	mRam					 	{HIDDEN}: ARRAY[0.._NH_RAM] OF BYTE; // mapovanie virtualnej ram (VR)
   mObr 	{HIDDEN}: ARRAY[0..4096] OF BYTE;
	Base0 AT mObr[3068] {HIDDEN}: UDINT ;						// before yTx6
	yTxa 	AT mObr[3072] {HIDDEN}: STRING[255] ;						// before yTx6
	yTxb 	AT mObr[3328] {HIDDEN}: STRING[255] ;						// before yTx6
	yTxc 	AT mObr[3584] {HIDDEN}: STRING[255] ;						// before yTx6
	yTx0 	AT mObr[3840] {HIDDEN}: STRING[255] ;						// before yTx6

	yTx1 	{HIDDEN}: STRING[255] ;
	yTx2 	{HIDDEN}: STRING[255] ;
	yTx3 	{HIDDEN}: STRING[255] ;
   yTx4 	{HIDDEN}: STRING[255] ;

	xTx1 	{HIDDEN}: PTR_TO STRING[255] ;
	xTx2 	{HIDDEN}: PTR_TO STRING[255] ;

   aSys: NH_SYS;
   aDbx AT mRam: NH_DBX;

(*
   { $ IF CPU_CODE > 1999 }
      CPU_DI {HIDDEN} AT r16_p6_IO_IN.DIS;
      CPU_DO {HIDDEN} AT r16_p6_IO_OUT.DOS;
   { $ ELSIF CPU_CODE = 1004 } 	 // 1000,1001,1047
      CPU_DI {HIDDEN} AT r0_p3_DI;
      CPU_DO {HIDDEN} AT r0_p3_DO;
   { $ ELSE } 	 // 1000,1001,1047
      CPU_DI {HIDDEN} AT r0_p5_DI;
      CPU_DO {HIDDEN} AT r0_p5_DO;
   { $ END_IF }
 *)
END_VAR


VAR_GLOBAL CONSTANT
   DayNamesSVK: ARRAY [1..7] OF STRING [2] := [ 'Po', 'Ut', 'St', 'Št', 'Pi', 'So', 'Ne'];
   _NhDLtask 	{HIDDEN}: USINT := 64; // max. pocet uloh pre jeden DALI-master
	_NH_CRLF				{HIDDEN}: STRING[2]		:= '$r$n';
   _eBtn3 	{HIDDEN}: NH_Btn3;
   _1Btn3 	{HIDDEN}: NH_Btn3 := [1, 1, 1];
   _eBtn8 	{HIDDEN}: NH_Btn8;
   _1Btn8 	{HIDDEN}: NH_Btn8 := [1, 1, 1, 1, 1, 1, 1, 1];
   _eBtn05 	{HIDDEN}: NH_Btn05;
   _1Btn05 	{HIDDEN}: NH_BTN05 := [1, 1, 1, 1, 1, 1];
   _eBtn15 	{HIDDEN}: NH_Btn15;
   _1Btn15 	{HIDDEN}: NH_Btn15 := [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
	_eLvl15				{HIDDEN}: NH_LVL15;
END_VAR



TYPE
	NH_ARR_OUT {HIDDEN}: ARRAY[0..3] OF USINT := [ 0 , 25 , 50 , 100 ];
  	NH_ARR_VAL {HIDDEN}: ARRAY[0..3] OF REAL := [ 5.0, 20.0, 23.0, 25.0];
   NH_RGB_LVL {HIDDEN}: STRUCT
      lvl: ARRAY[1..5] OF USINT := [255, 255, 255, 0, 0]; // parametre pre 3.kanaly R/G/B/WC/WA
   END_STRUCT;

	NH_RFID {HIDDEN}: ARRAY[0..7] OF BYTE; // kompletny RFID kod aj 13Mhz

   NH_CFG_CLICK	{HIDDEN}: STRUCT
		Click: USINT := 6;					 // max cas medzi clickmi [x 100ms]. Ak je = 0, vyhodnoti sa len prvy click
		Press: USINT := 7; 				 // cas po ktorom je uz stlacenie [x 100ms]
		Hold: USINT := 0; 			 // cas po ktorom je dlhe podrzanie [x 100ms]
      LockTime: USINT := 10; // ak je stlaceny btn viac ako 10s vypne sa posielanie CMD, je to zaseknuty BTN
		nBTNs: USINT := 2;	 // celkovy pocet btn
      BtnHold: ARRAY[1..8] OF BOOL; // ktore BTN pouzivaju hold {vylucuje sa s press} rezervovane aj pre klavesnicu
      OneClck: ARRAY[1..8] OF BOOL; // ktore BTN maju len JEDEN-rychly click
	END_STRUCT;

  	NH_BTN_CLICK	 {HIDDEN}: STRUCT
		cmd: USINT;
      Nbr: USINT; // cislo aktualne stlaceneh BTN v HW
      Click: USINT; // cislo clicku
      wht: USINT; // stavy
		Lck: USINT;								// zaseknute TLACIDLO/TGL
		shw: USINT;								// oneskorenie zobrazenia
		et: UINT;
		Busy: BOOL;
      Lock: BOOL; // zaseknuty BTN, treba reset TGL
	END_STRUCT;

   NH_VAL_3 {HIDDEN}: STRUCT
      val: ARRAY[0..3] OF REAL := [5.0, 18.5, 21.5, 23.5]; // hodnoty predvolieb
	END_STRUCT;
   NH_DEV_HW0	{HIDDEN}: STRUCT
		typ: USINT;
		cfg: USINT;
		d: ARRAY[0..0] OF UDINT; // adresy Dev
	END_STRUCT;
   NH_DEV_HW1	{HIDDEN}: STRUCT
		typ: USINT;
		cfg: USINT;
		d: ARRAY[0..1] OF UDINT; // adresy Dev
	END_STRUCT;
   NH_DEV_HW2 {HIDDEN}: STRUCT
		typ: USINT;
		cfg: USINT;
		d: ARRAY[0..2] OF UDINT; // adresy Dev
	END_STRUCT;
   NH_DEV_HW3	{HIDDEN}: STRUCT
		typ: USINT;
		cfg: USINT;
		d: ARRAY[0..3] OF UDINT; // adresy Dev
	END_STRUCT;
   NH_DEV_HW4	{HIDDEN}: STRUCT
		typ: USINT;
		cfg: USINT;
		d: ARRAY[0..4] OF UDINT; // adresy Dev
	END_STRUCT;
   NH_DEV_HW5	{HIDDEN}: STRUCT
		typ: USINT;
		cfg: USINT;
		d: ARRAY[0..5] OF UDINT; // adresy Dev
	END_STRUCT;
   NH_DEV_EXT	{HIDDEN}: STRUCT
		typ: USINT;
		cfg: USINT := 1; // 0=CIB,1=DALI,2=MQTT
		d: ARRAY[0..5] OF UDINT; // adresy Dev
	END_STRUCT;
  	NH_TRIG {HIDDEN}: STRUCT 			 // DEL oD oQ fav >> o5 o6 o7 o8 o9 o10 DEL
      In: BOOL ;				// vstupny signal
  		Q: BOOL ;				// preneseny vstup (minuly stav)
      Qf: BOOL ; // zostupna hrana
      Qr: BOOL ; // nabezna hrana
	END_STRUCT;
   NH_CLK_CMD {HIDDEN}: STRUCT 			// Co sa vykona pri konkretnom clicku / push / hold , click+push
// cmd: ARRAY[1..8] OF USINT := [2,0,0,0,0,6,6,0]; // click 1-5, P,H [switch,0,0,0,0,Push,Hold,0]
		cmd: NH_PV18;	// := [0,0,0,0,0,6,6,0]; // click 1-5, P,H [switch,0,0,0,0,Push,Hold,0]
	END_STRUCT;

(*
  	NH_FRW {HIDDEN}: STRUCT 					 // prenosovy subor citania/zapisu
      fH: HANDLE; // otvoreny subor
      fP: UDINT; // aktualna poziacia v fH
      fN: STRING[50]; // subor pre _Nhfrw
      fR: UDINT; // kolko bolo posledne nacitane/zapisane
      fA: UDINT; // kolko bolo doteraz celkovo nacitane x
// mode: TF_MODE; // 0=read,1=write,2=append
	END_STRUCT;
 *)

   NH_DT_M {HIDDEN}: STRUCT // struktura NH datumu+casu
    	year: USINT; (* rok (poslední dvì èíslice letopoètu) *)
    	month: USINT; (* mìsíc (1 .. 12) *)
    	day: USINT; (* den (1 .. 28/29/30/31) *)
    	hour: USINT; (* hodina (0 .. 23) *)
    	min: USINT; (* minuta (0 .. 59) *)
//		sec: usint; (* sekunda (0 .. 59) *)
  	END_STRUCT;

   NH_REC_OK	 {HIDDEN}: STRUCT 	// uvodny zaznam pre DEV
 		ok: BOOL;						 // platna veta
      ref: BOOL; // treba prepocitat/aktualizovat data DEV
      stp: BOOL; // zobrazi sa len v SETUP mode
      adm: BOOL; // ma pristup len ADMIN (CAT)
		cpy: BOOL;								// oznacenie pree kopirovanie
      CmdInBlk: BOOL; // vstup je blokovany = neprijima data, dokial ich FB nespracuje
      CmdOuRpt: BOOL; // treba opakovat zaslaty CMD, vystupne DEV bolo zaneprazdnene
		DevRef: BOOL;								// zmena nejakeho parametra - refresh samotneho dev
   END_STRUCT;


  	NH_CMD_ALL {HIDDEN}: STRUCT 		//
		cmd: USINT; 							// command
		val: REAL; 	 // hodnota, ktora prislucha k CMD (napr.teplota,sumrak...)
		par: INT; 	// parameter, pod ktorym sa ma vykonat CMD (0=pouzije sa default par)
	END_STRUCT;

   NH_DEV_CF		{HIDDEN}: STRUCT
		c: USINT; 			 // dev cfg
		n: INT; // cislo DEV
   END_STRUCT;

   NH_DEV_SW		{HIDDEN}: STRUCT
		c: USINT; 			 // dev cfg
		n: INT; // cislo DEV
		o: USINT;								// vystupny/vstupny port (pri DALI R/G/B/WW/CW )
   END_STRUCT;

  	NH_VAL_IO {HIDDEN}: STRUCT 				// prenos vstupnej veliciny
      own: BOOL;								// ma vlastny snimac (u TER/LUX je to v default ROM)
   	Zon: BOOL;								// pre LUX v rom/zon: hodnota bola prebrata z nadradenej zony
		Out: BOOL; // pre LUX v rom/zone: z vonkajsej zony
	 chg: BOOL; 								// zmena - po prenesni n CMD sa vynuluje
		cmd: BOOL;								// chg sa preniesla na cmd a ten by sa mal vyslat
//		FromOwn: BOOL := 1;						// prebrat hodnotu z vlastnej miestnosti ak existuje
		FromZon: BOOL := 1;						// povolenie prebrat hodnotu z vyssej zony, ak sa nenasla FromOwn - v 1.poradi
		FromOut: BOOL := 1;						// povolenie prebrat hodnotu z vonkajsej zony - v 2.poradi
      val: REAL; // posledna hodnota
		dev: NH_DEV_SW;
   END_STRUCT;



  	NH_DEV_ALL {HIDDEN}: STRUCT 	// default pre vsetky DEV - MAXIMALNA konfiguracia
		in: NH_CMD_ALL; 					// vstupny prikaz
		ou: NH_CMD_ALL; 					// vystupy prikaz
      sta: USINT; // stav, podla ktoreho za vykresli obrazok s podkladom
		cm: USINT;
   	et: UINT;
      Qf: BOOL; // impulz, ked skoncil cas: et
	 trg: NH_TRIG;
      wsb: BOOL; // priznak, ze cmd prisiel z ovladaca WSB alebo WEB
      vaz: BOOL; // ma nejake in-vazby WSB,PIR,TGL...
      lst: BOOL; // bit8 je nejakom DEV-liste SCN,ACT,....
      up: BOOL := TRUE; // bit1 smer stmievania up=hore (po restarte zacina nadol)

      Qx: BOOL; // univerzalne pouzitie - impulz, ked sa dosiahne ukoncenie casu do 0
      dummyEvn: BOOL; // logovat udalost
      Off: BOOL; // priroritne je priznak dlheho vypnutia, inak univerzalne,

      RUN: USINT; // co sa vykona po dobehnuti casu
      ct: USINT; //
      ex: INT; // bezi pomocny cas - vacsinou kontroluje maximalnu dobu zopnutia
      rmp: USINT; // rampa
      el: USINT; // dalsi pomocny cas - zisti sa dlhe vypnutie
// lvl: USINT; // zapamatana uroven
// par: INT; // zapamatany parameter
	END_STRUCT;

  	NH_DEV_ALL_M {HIDDEN}: STRUCT 	// default pre vsetky DEV - MAXIMALNA konfiguracia
		in: NH_CMD_ALL; 					// vstupny prikaz
		ou: NH_CMD_ALL; 					// vystupy prikaz
      sta: USINT; // stav, podla ktoreho za vykresli obrazok s podkladom
		cm: USINT;
   	et: UINT;
      Qf: BOOL; // impulz, ked skoncil cas: et
	 trg: NH_TRIG;
      wsb: BOOL; // priznak, ze cmd prisiel z ovladaca WSB alebo WEB
      vaz: BOOL; // ma nejake in-vazby WSB,PIR,TGL...
      lst: BOOL; // je nejakom DEV-liste SCN,ACT,....
      up: BOOL := TRUE; // smer stmievania up=hore (po restarte zacina nadol)
	END_STRUCT;

  	NH_POI_DAT {HIDDEN}: STRUCT // struktura pre slider z viacerych casovych pointov - uchovava sa
      t: INT := - 1; // casova znacka (pocet minut dna)
      o: SINT; // co je v tejto casovej znacke (hodnota/odkaz )
	END_STRUCT;
   NH_POI_OBR {HIDDEN}: STRUCT
      o: INT; // obrazky k hodnotam
      c: USINT; // color
	END_STRUCT;
  	NH_ARR_POI {HIDDEN}: STRUCT // struktura pre slider z viacerych casovych pointov - uchovava sa
      p: ARRAY[0..7] OF NH_POI_DAT;
	END_STRUCT;
   NH_POI_FIX	{HIDDEN}: STRUCT // kedy vratit na bezny kalendarny den 6 byte
		dummy: BOOL;
      wht: USINT; // sposob kedy 1 = okamzite
      tme: NH_DT_M; // datum/cas
	END_STRUCT;
   NH_POI_DAY	{HIDDEN}: STRUCT // casovy program kurenia jedneho dna
		fff: BOOL;
      Day: USINT; // vybraty den 0=Week, 1-7=(PO-NE),8=,Free,9=Full,10=Out,11=Holi/vynimka)
      Poi: ARRAY[1..11] OF INT;
// Fix: NH_POI_FIX := (wht:=1); // zablokuje, aby sa Day kazdu min aktualizoval z Home
	END_STRUCT;

   NH_POI {HIDDEN}: STRUCT // casovy program kurenia jedneho dna
 		ok: NH_REC_OK := (ok := 1);
      cx: NH_ARR_POI :=
                  ( p := [ ( t := 0, o := 2), // night 0:00
                           ( t := 330, o := 3), // morning 5:30
                           ( t := 390, o := 0), // day 6:30
                           ( t := 1050, o := 1), // evening 17:30
                           ( t := 1440, o := 1) // 24:0;
                   ]);
	END_STRUCT;
  	NH_ARR_OBR {HIDDEN}: STRUCT 		// obrazky pre interval v NH_ARR_POI
      o: ARRAY[0..4] OF NH_POI_OBR
                                          := [ ( o := 140, c := 5), // day
                                                ( o := 142, c := 3), // evening
                                                ( o := 144, c := 9), // night
                                                ( o := 146, c := 8) // morning
                                                ];
	END_STRUCT;
  	NH_POD_CFG {HIDDEN}: STRUCT // riadiaca struktura pre TIM-slider z viacerych casovych pointov - uchovava sa
      tim: BOOL := TRUE; // vypisanie casu, aj vynasacej ciary
      typ: USINT; // 0=Daymode,1=Heat,2=Ven
      n: SINT := 7; // maximalny pocet pointov = bodov ZADAVA sa
      o: SINT := 3; // pocet hodnot/obrazkov vyberanych do jednotlivych pointov ZADAVA sa
      vo: NH_ARR_OBR;
      va: NH_ARR_VAL;
      fm: STRING[8] := ''; // format hodnoty (ak jeprazdne, nevypisuje sa)
	END_STRUCT;


   NH_ROM_LCK {HIDDEN}: STRUCT
      KeyCode: BOOL; // prisiel dobry kod z Klavesnice
      WebCode: BOOL; // prislo z webu
		LockRom: BOOL := 1;			 		 // tato miestnost/zona bude zamykana
		AllLocked: BOOL ;			 		 		 // vsetky miestnosti su zalokovane
		FromZone: BOOL := 0;			 		 // ZON prepise udaje v ROM, ROM=povoli prepisat
		ChangeStat: BOOL;							 // impulz pri zmene stavu PSN
		AllLockedOld: BOOL ;			 		 		 // minuly stav zalokovania vsetkych miestnosti
     	Stat: USINT := 0; // 0=unlock, 1=locking, 2=locked, 3=unlocking, 4=dog, 5=Narusenie, 6=Alarm
      et: UINT ; // prebieha nejaky cas podla Lock
      tdOu: UINT := 10;	// 60; // odchodove oneskorenie [SEC]
      tdIn: UINT := 13;	// 30; // prichodove oneskorenie [SEC]
      tDog: UINT := 16;	// 60; // ostrazitost [sec]
      tNar: UINT := 30;	// 300; // Cas narusenie
      tRst: UINT := 0;	// 300; // Cas autoresetu bez pohybu v LVL - ALARM
		StatOld: USINT;
		dummy: STRING[9];
   END_STRUCT;

  	NH_CFX_ROM_LUX {HIDDEN}: STRUCT
		LuxMin: USINT := 70;						// minimalna hodnota osvetlenia
		RolMin: USINT := 80;						// minimalna hodnota zatienenia zaluziami
		KoefBli: REAL := 0.0; // cim viac poklasne osvetleni pod 100%, pouzije sa este neviem ako ake koef
		LuxYes: BOOL := 1;							// ovplyvneny snimacom
		RolYes: BOOL := 1;							// ovplyvneny snimacom
   END_STRUCT;

  	NH_CFX_ROM {HIDDEN}: STRUCT 			// CFX MIESTNOSTI
		LuxMin_OLD: USINT;								// len pre kompatibilitu - minimalna hodnota osvetlenia
      NoBody: UINT := 1800; // pocet SEC, bez pritomnosti (Auto-nepritomnost) = vyhlasi sa klud
      BlPirOFF: USINT := 1; // cas [min] blokovania PIR po vypnuti vypinacom/z webu 255=do konca dna
      pRzv_OLD: USINT; // odkial zobrat rodicovsky rozvrh: 0-Nema Rodica, 1(255)-Domcek, > 1=konkretna zona
      pDay: NH_POI_DAY; // DayMode
      lck: NH_ROM_LCK;						// uz aj lock je + string[10]
      FixDay: NH_POI_FIX := (wht := 1); // zablokuje, aby sa Day kazdu min aktualizoval z Home

		// nove
		LuxPar: NH_CFX_ROM_LUX;
      Dark: BOOL; // tma - musi tu byt, lebo porestarte ak je nastavene rucne by sa stratilo
		IniDefault: BOOL;								// priznak inicializacie
      dummy: STRING[19];


// Fix: NH_POI_FIX := (wht:=1); // zablokuje, aby sa Day kazdu min aktualizoval z Home

   END_STRUCT;

(* posledne
  	NH_CFX_ROM {HIDDEN}: STRUCT 			// CFX MIESTNOSTI
		LuxMin: USINT;								// minimalna hodnota osvetlenia
      NoBody: UINT := 1800; // pocet SEC, bez pritomnosti (Auto-nepritomnost) = vyhlasi sa klud
      BlPirOFF: USINT := 1; // cas [min] blokovania PIR po vypnuti vypinacom/z webu 255=do konca dna

      pRzv: USINT; // odkial zobrat rodicovsky rozvrh: 0-Nema Rodica, 1(255)-Domcek, > 1=konkretna zona
      pDay: NH_POI_DAY; // DayMode
      lck: NH_ROM_LCK;

      dummy: STRING[19];
   END_STRUCT;
 *)

   NH_ROM_MEM {HIDDEN}: STRUCT
		Locked: BOOL;								// jednoznacne povie ze je zamknute
      BodyQr: BOOL; // nova pritomnost - impulz
      BodyQ: BOOL; // pritomnost trva
      PsnQr: BOOL; // nova pritomnost - impulz
      PsnQ: BOOL; // pritomnost trva
		Light: NH_TRIG;							// zapnutie/vypnutie/trvanie osvetlenia
      DayObr: SINT; // obrazok denneho modo 0,1,2,3 day,evening,night/morning
      BlPirOn: USINT := 253; 	// po restarte blokuje pir 254 cyklov
      BlPirOff: USINT; // bezi cas blokovanie PIR-ov v miestnosti po vypnuti WSB/WEB
		DarkRolLvl: USINT; 	 // uroven zatienenia roletami
//		refStat: USINT;								// LOCK status z minuleho cyklu


// tNoBody: UINT; // pocet minut zostavajucich do vyhlasenia nepritomnosti
// tLock: UINT; // cas pre odchod,prichod,strazenie,koniec alarmu vbez pohybu
// tAlarm: UINT; // pocet minut do prepnutia na vyssi level ALARMU
//		cm: USINT;								// pomocna prem. pre alarm
//		sta: USINT;

	END_STRUCT;

   NH_ROM		{HIDDEN}: STRUCT
 		ok: NH_REC_OK := (ok := TRUE);
      cf: NH_CFG_ALL := (typ := 1);
	 al: NH_DEV_ALL;
//	 al: NH_ROM_ALL;
      cx: NH_CFX_ROM;
		io: ARRAY[100..104] OF NH_VAL_IO; // TER,LUX,CO2,RH
      me: NH_ROM_MEM;
	END_STRUCT;

  	NH_ZON_PAR 	{HIDDEN}: STRUCT 			// PARAMETRE MIESTNOSTI
 		ok: NH_REC_OK;
		cmd: USINT := 60;
	END_STRUCT;





  	NH_DEV_OKA {HIDDEN}: STRUCT 	// default pre vsetky DEV - MAXIMALNA konfiguracia
		ok: NH_REC_OK;
		cf: NH_CFG_ALL;
		al: NH_DEV_ALL;
	END_STRUCT


END_TYPE


VAR_GLOBAL

	rb {HIDDEN}: BOOL;
   err {HIDDEN}: BOOL;
   exec {HIDDEN}: BOOL;
   ok {HIDDEN}: BOOL;
   ok1 {HIDDEN}: BOOL;						 // casto pouzivana premenna
   ok2 {HIDDEN}: BOOL;
   ok3 {HIDDEN}: BOOL;
   ok4 {HIDDEN}: BOOL;
   rst {HIDDEN}: BOOL;						 // casto pouzivana premenna
   rom {HIDDEN}: BOOL;
   sbj {HIDDEN}: BOOL;
   yes {HIDDEN}: BOOL;

	// zdielane pre pracu s SDC
	fH {HIDDEN}: HANDLE;			// handle
   fP {HIDDEN}: UDINT; // file Position
   fS {HIDDEN}: UDINT;	 		// file Size
   fRW 	{HIDDEN}: UDINT;				// file Rear/write	- pocet byte na zapis/citanioe

   sp	 {HIDDEN}: UDINT;
   sz {HIDDEN}: UDINT;
   sPtr {HIDDEN}: UDINT;
   sRun {HIDDEN}: UDINT;
	offSrc			{HIDDEN}: UDINT;		// posun pri kopirovani
	offDst			{HIDDEN}: UDINT;

   xBtn15 	{HIDDEN}: PTR_TO NH_Btn15;		// koli memCpyPtr
   yBtn15 	{HIDDEN}: NH_Btn15;		// koli memCpyPtr


   i {HIDDEN}: USINT;
   k {HIDDEN}: USINT;
   ii {HIDDEN}: USINT;
   cf {HIDDEN}: USINT;
   vo {HIDDEN}: USINT;
   vi {HIDDEN}: USINT;
   rmp {HIDDEN}: USINT; // rapa pre SVA,RGB
   cmd {HIDDEN}: USINT; // rapa pre SVA,RGB
// GoNext {HIDDEN}: USINT;

   j {HIDDEN}: SINT; // rapa pre SVA,RGB
   jj {HIDDEN}: SINT;

   x {HIDDEN}: INT;
   y {HIDDEN}: INT;
   z {HIDDEN}: INT;
   ix {HIDDEN}: INT;
   qx {HIDDEN}: INT;
   qy {HIDDEN}: INT;
// v1,v2,v3 {HIDDEN}: INT;
   nd {HIDDEN}: INT; // vseobecne cislo zanzmau
   nDel {HIDDEN}: INT; // cislo vymazaneho zaznamu
   nNew {HIDDEN}: INT; // cislo vymazaneho zaznamu
   new {HIDDEN}: INT;
   grp {HIDDEN}: INT;
   del {HIDDEN}: INT; // univerzalne

	rj				 {HIDDEN}: UDINT;
	rji			 {HIDDEN}: UINT;
   va {HIDDEN}: UDINT; // virtualna adresa
   vai {HIDDEN}: UINT; // virtualna adresa
   delay {HIDDEN}: UINT;
	_NhSeed			{HIDDEN}: DINT;
	_NhDT				{HIDDEN}: DT;
	_NhTime			{HIDDEN}: TIME;

   kr {HIDDEN}: REAL;
   vr {HIDDEN}: REAL; // REAL pre pouzitie do slidera
   ur {HIDDEN}: REAL;

   xx {HIDDEN}: REAL;
   yy {HIDDEN}: REAL;
   zz {HIDDEN}: REAL;
   aa {HIDDEN}: REAL;
   bb {HIDDEN}: REAL;
   cc {HIDDEN}: REAL;
   ee {HIDDEN}: UDINT;
	ff				 {HIDDEN}: UDINT;

   xPtB {HIDDEN}: PTR_TO BOOL;
	xPtS			{HIDDEN}: PTR_TO SINT;
	xPtU			{HIDDEN}: PTR_TO USINT;
   xPtU2			{HIDDEN}: PTR_TO USINT;
	xPtR			{HIDDEN}: PTR_TO REAL;
	xMin			{HIDDEN}: PTR_TO REAL;
	xMax			{HIDDEN}: PTR_TO REAL;
	xPtI			{HIDDEN}: PTR_TO INT;
	xPtUi			{HIDDEN}: PTR_TO UINT;
	xPtT			{HIDDEN}: PTR_TO TIME;
	xPtY			{HIDDEN}: PTR_TO BYTE;
	xPtD			{HIDDEN}: PTR_TO UDINT;
	xPtC			{HIDDEN}: PTR_TO STRING;
	xPtIO			{HIDDEN}: PTR_TO NH_VAL_IO;
	xPtIOa		{HIDDEN}: PTR_TO NH_VAL_IO;
//	yPtIO			{HIDDEN}: NH_VAL_IO;

   xLedR {HIDDEN}: PTR_TO BOOL;
	xLedG {HIDDEN}: PTR_TO BOOL;
	xLedB {HIDDEN}: PTR_TO BOOL;
   xLedO {HIDDEN}: PTR_TO BOOL;
   xBeep {HIDDEN}: PTR_TO BOOL;

  	xCPa {HIDDEN}: PTR_TO NH_PAR_CFG;
   xCIo {HIDDEN}: PTR_TO NH_VAZ_CFG;
	xDbx	 {HIDDEN}: PTR_TO NH_DBX; // hlavny riadiaci subor vratane organizacie DBX
	yDbx	 {HIDDEN}: NH_DBX; // hlavny riadiaci subor vratane organizacie DBX
   yCfg {HIDDEN}: NH_CFG_CFG; // konfiguracia vsetkych DEV

	fbDbxFromFile: ReadDbxFromFile;
   fbDbxToFile: WriteDbxToFile;
	_LangTXT 	{HIDDEN}: STRING[30];
	xDevOkA		{HIDDEN}: PTR_TO NH_DEV_OKA;
END_VAR

FUNCTION _NheRam {HIDDEN}: BOOL // VYNULUJE PREVADZKOVU RAM (za DBX,CFG,PAR,VAZ)
   memsetEx(val := 0, length := _NH_RAM - aDbx.vRam, dest := VOID( mRam[aDbx.vRam ] ) );
END_FUNCTION

FUNCTION _NhMemSetPTR {HIDDEN}: BOOL 	// vymaze mRam od Adresy pointra v dlke size
   VAR_INPUT
      size: UDINT; 	// velkost vymazanej pamate
      dest: PTR_TO USINT; 	// pointer na zaciatok pamate
      mAdr: UDINT;
   END_VAR
	_NhMemSetPTR := TRUE;
   IF mAdr = 0 THEN
      mAdr := PTR_TO_UDINT(dest) - PTR_TO_UDINT(ADR(mRam)) ;
   END_IF;
	memsetEx(val := 0, length := size, dest := VOID( mRam[ mAdr ])) ; // vycisti celu ram !! DOLEZITE
END_FUNCTION

FUNCTION _NhMemClrPTR {HIDDEN}: BOOL // vymaze pamat od Adresy pointra v dlke size
   VAR_INPUT
      size: UDINT; // velkost vymazanej pamate
      dest: PTR_TO USINT; // pointer na zaciatok pamate
   END_VAR
	_NhMemClrPTR	:= TRUE;
   memset(val := 0, length := 1020, dest := VOID(yTx1)); // pouzije yTx1-yTx4 na cistu oblast, v ktorej vymaze 999b
   WHILE size > 0 DO
      MemcpyPtr(source := ADR(yTx1), dest := dest, length := MIN(size, 1020)); // prekopiruje cistu pamat na adresu
      dest := dest + MIN(size, 1020);
      size := size - MIN(size, 1020);
   END_WHILE;
END_FUNCTION

FUNCTION _NhClrRam {HIDDEN}: BOOL // vymazanie v adresovanej pamati mRam podla pointru
   VAR_INPUT
      a: PTR_TO USINT; // adresa pointru
      s: UINT; // velkost dat, ktore sa prepisu 0
   END_VAR
   VAR_TEMP
      d: UDINT;
   END_VAR
   d := PTR_TO_UDINT(a) - PTR_TO_UDINT( ADR(mRam) );
   memset(val := 0, length := s , dest := VOID( mRam[ d ] ) );
   _NhClrRam := TRUE;
END_FUNCTION

FUNCTION {HIDDEN} aBlank: BOOL								// doplni string medzerami na dlzku n
	VAR_INPUT
   	lft: BOOL; // zlava medzery
      txt: PTR_TO STRING[255];
		n: INT;
   END_VAR
   VAR_TEMP
		p: INT;
   END_VAR
  	p := LEN(txt^);
   IF lft THEN
      WHILE n > 0 DO // doplnit medzerami
         txt^ := INSERT(txt^, ' ', 1);
         n := n - 1;
   	END_WHILE;
   ELSIF p >= n THEN // string > ako sa pozaduje
	 	txt^ := LEFT(txt^, p);
   ELSE
   	WHILE p < n DO // doplnit medzerami
         txt^ := CONCAT(txt^, ' ');
         p := p + 1;
   	END_WHILE;
   END_IF;
   aBlank := TRUE;
END_FUNCTION

FUNCTION_BLOCK aTrg	{HIDDEN} 				// TRIGER VSTUPU vyhodi zmenu vstupu In, impulz pri zacati a skonceni
	VAR_INPUT
      In: BOOL; // vstup (pre vyhodnotenie zmeny)
      rst: BOOL; //
   END_VAR
   VAR_OUTPUT
      Qr: BOOL; // impulz pri nastaveni vstupu IN - zaroven nastavi aj Q
      Qf: BOOL; // impulz pri skonceni vstupu IN - Q uz nie je nastavene
      Q: BOOL; // trvanie signalu na vstupe In
      Qe: BOOL; // impulz, ked sa et dopocita k 0
      et: UINT; // po

   END_VAR
   Qe := FALSE;
   IF rst THEN
      rst := FALSE;
// In := true; // pri resete sa zavola aj in
      Q := FALSE;
      et := 0;
      Qr := FALSE;
      Qf := FALSE;
      RETURN;
   END_IF;
   Qr := In AND Q = FALSE;
   Qf := In = FALSE AND Q;
   Q := In;
   IF et = 0 THEN
      ;
   ELSIF et > aSys.mSec THEN
      et := et - aSys.mSec;
   ELSE
      et := 0;
      Qe := TRUE;
   END_IF;
END_FUNCTION_BLOCK

FUNCTION aTrim {HIDDEN}: BOOL								// vyhodi pociatocne a kocove medzery
	VAR_INPUT
      wht: USINT; // 0=zLava, 1=zlava aj zprava, 2=zlava, vsetky medzery
      txt: PTR_TO STRING; // pointer premennej
   END_VAR
   VAR_TEMP
      n: INT;
      zn: STRING[1];
   END_VAR
   aTrim := TRUE;
   n := LEN(txt^);
   WHILE n > 0 DO
      CASE wht OF
         0: // zprava
            zn := MID(txt^, 1, n);
            IF zn = ' ' THEN
               n := n - 1;
               txt^ := LEFT(txt^, n);
            ELSE
               EXIT;
            END_IF;
         1: // zpava aj zlava
            zn := MID(txt^, 1, n);
            IF zn = ' ' THEN
               n := n - 1;
               txt^ := LEFT(txt^, n);
            ELSE
               zn := MID(txt^, 1, 1);
               IF zn = ' ' THEN
                  n := n - 1;
                  txt^ := MID(txt^, n, 2);
               ELSE
                  EXIT;
               END_IF;
            END_IF;
         2: // zlava
            zn := MID(txt^, 1, 1);
            IF zn = ' ' THEN
               n := n - 1;
               txt^ := MID(txt^, n, 2);
            ELSE
               EXIT;
            END_IF;
       ELSE // vsetky medzery v stringu
            n := FIND(in1 := txt^, in2 := ' ');
            IF n > 0 THEN
               txt^ := DELETE(txt^, 1, n);
            ELSE
               EXIT;
            END_IF;
      END_CASE;
   END_WHILE;
END_FUNCTION


FUNCTION _NhSysLogMsg: BOOL // nacita 1.riadok zo suboru yTx1 do yTx2, alebo zapise to co je v yTx2 do suboru yTx1
   VAR_INPUT
		write: 		BOOL; 			// overwrite file
		ini:			BOOL:=TRUE; 	// CASE position for aSys.ini
		debug:		BOOL;				// only if aSys.debug = TRUE
		eRowBefore:	BOOL;				// prida prazdny riadok pred a za
		eRowAfter:	BOOL;				// prida prazdny riadok pred a za
		NoTime:		BOOL; 			// nezapisovat cas
		msg:	 		STRING[255]; 	// message to log without datetime
	END_VAR
 	VAR_TEMP
		fH: 			HANDLE;
		logFile: 	STRING;
 	END_VAR
	IF debug AND aSys.Debug = FALSE THEN					// log only in debug mode
		_NhSysLogMsg	:= TRUE;
	ELSE
		_NhSysLogMsg	:= FALSE;
		logFile	:= CONCAT(aSys.DiskHed.disk[2].path, 'nh_', DT_TO_STRINGF(aSys.NhDT, '%TYYMM.log') );
	   IF write THEN
   	   fH := FileOpen(fileName := logFile, mode := F_WRITE);
	   ELSE
   	   fH := FileOpen(fileName := logFile, mode := F_APPEND);
	   END_IF;
   	IF fH <> INVALID_HANDLE_VALUE THEN 	// nenajdeny subor alebo zla cesta
			IF FileSize(hFile := fH) < 500000 THEN						// obmedzenie logu na 0.5mb
				IF NoTime = false THEN
					IF ini THEN
		         	msg := CONCAT(DT_TO_STRINGF(GetRtc(), '%TYY.MM.DD-hh:mm:ss.zzz '), USINT_TO_STRINGF(aSys.ini, '[%3u:] '), msg, _NH_CRLF );
					ELSE
      		   	msg := CONCAT(DT_TO_STRINGF(GetRtc(), '%TYY.MM.DD-hh:mm:ss.zzz '), msg, _NH_CRLF );
					END_IF;				
				END_IF;
		      IF eRowBefore THEN
   		      msg := CONCAT(_NH_CRLF, msg);
      		END_IF;
		      IF eRowAfter THEN
   		      msg := CONCAT(msg,_NH_CRLF);
      		END_IF;
				fRW	:= FileWrite(hFile := fH, adrBuf := PTR_TO_UDINT(ADR(msg)), size := INT_TO_UDINT(LEN(msg)));
				_NhSysLogMsg:= TRUE;
			END_IF;
			rb	:= FileClose(hFile := fH);
		END_IF;	
	END_IF;
END_FUNCTION


FUNCTION _Nh1RowTxt: BOOL // nacita 1.riadok zo suboru yTx1 do yTx2, alebo zapise to co je v yTx2 do suboru yTx1
   VAR_INPUT
      write: BOOL; // zapisat
      append: BOOL := TRUE; // pridat, prioritne je write
      close: BOOL := TRUE; // close file on end
      logRst: BOOL;
// sysIni: BOOL := true; 	 // prida aSys.ini ak je LogRst
      EmpRow: BOOL; // pred riadok prida '$r$n' = prazdny riadok
		adHed1: BOOL;							// pridat prvy riadok to je v yTx3
      adTime: SINT; // za datum pridat aj cas
   END_VAR
// VAR_TEMP
// fH: HANDLE;
//		begin: UDINT;
// END_VAR
   IF logRst THEN
// yTx1 := CONCAT( _Nh_ADR_ROT,'NH2.LOG');
// yTx1 := CONCAT( aSys.ADR_RAM,'NH2.LOG');
// yTx1 := 'RAM/NH2.LOG';
		yTx1	:= CONCAT(aSys.DiskHed.disk[2].path, 'nh_', DT_TO_STRINGF(aSys.NhDT, '%TYYMM.log') );
//		yTx1	:= CONCAT( 'WWW/LOGS/NH2_', DT_TO_STRINGF(aSys.NhDT, '%TYYMM.LOG') );

// yTx1 := 'WWW/LOGS/NH2.LOG';
// 	yTx1 := '/SDC/NH2.LOG';
// yTx1 := CONCAT( aSys.ADR_DBX,'NH2.LOG');
   END_IF;
   fRW := 0;
   IF write THEN
      fH := FileOpen(fileName := yTx1, mode := F_WRITE);
   ELSIF append THEN
      fH := FileOpen(fileName := yTx1, mode := F_APPEND);
   ELSE
		_Nh1RowTxt	:= FALSE;
  		RETURN;
   END_IF;
   IF fH <> INVALID_HANDLE_VALUE THEN 	// nenajdeny subor alebo zla cesta
		IF logRst THEN
			IF FileSize(hFile := fH) > 500000 THEN						// obmedzenie logu na 0.5mb
   			rb				:= FileClose(hFile := fH);
				_Nh1RowTxt := FALSE;
 				RETURN;
			END_IF;
		END_IF;
		offSrc	:= 1;										// start position first character in original yTx2
		CASE adTime OF
		 - 1: ;
			0: IF logRst THEN
         	yTx2 := CONCAT(DT_TO_STRINGF(GetRtc(), '%TYY.MM.DD-hh:mm:ss.zzz '), USINT_TO_STRINGF(aSys.ini, '[%3u:] '), yTx2 ); offSrc := 22;
(*
       			yTx2 := CONCAT(
//			 			UDINT_TO_STRINGF( TIME_TO_UDINT( SUB_DT_DT(aSys.NhDT,aSys.LastRstDT))/100 ,'%6.3d'),' '
			 			TIME_TO_STRINGF( SUB_DT_DT(aSys.NhDT, aSys.LastRstDT) , '%Tss.zzz'), ' '
						, UINT_TO_STRINGF(aSys.RestCyc, '%3u ')
						, USINT_TO_STRINGF(aSys.ini, '[%3u:] ')
						, yTx2
								);
					offSrc := 17;		//	move first character of yTx2 fo this position
*)
				END_IF;
    		1: yTx2 := CONCAT(DT_TO_STRINGF(aSys.NhDT, '%Thh:mm '), yTx2);						offSrc := 7;
         2: yTx2 := CONCAT(DT_TO_STRINGF(aSys.NhDT, '%Thh:mm:ss '), yTx2); offSrc := 10;
         3: yTx2 := CONCAT(DT_TO_STRINGF(GetRtc(), '%TYY.MM.DD-hh:mm:ss.zzz '), yTx2); offSrc := 22;
//         3: yTx2 := CONCAT(DT_TO_STRINGF(aSys.NhDT, '%TYY.MM.DD-hh:mm:ss.zzz '), yTx2); offSrc := 22;
         4: yTx2 := CONCAT(DT_TO_STRINGF(aSys.NhDT, '%TYY.MM.DD-hh:mm:ss.zz '), _NH_CRLF, yTx2, _NH_CRLF); offSrc := 24;
         ELSE yTx2 := CONCAT(DT_TO_STRINGF(getRTC(), '%Thh:mm:ss.zz '), yTx2); 		offSrc := 13;
      END_CASE;
      fRW := FIND(yTx2, _NH_CRLF);
      IF fRW = 0 THEN
         yTx2 := CONCAT(yTx2, _NH_CRLF);
      END_IF;
		IF adHed1 THEN													// ak je subor prazdny, prida hlavicku
			IF FileSize(hFile := fH) = 0 THEN
		 		fRW := FIND(yTx3, _NH_CRLF);
   		 	IF fRW = 0 THEN
      			 yTx3 := CONCAT(yTx3, _NH_CRLF);
	 			END_IF;
         	yTx2 := CONCAT(yTx3, yTx2);
				offSrc := offSrc + LEN(yTx3) + 2;
			END_IF;
		END_IF;
      IF EmpRow THEN
         yTx2 := CONCAT(_NH_CRLF, yTx2);
      END_IF;
      fRW := FileWrite(hFile := fH, adrBuf := PTR_TO_UDINT(ADR(yTx2)), size := INT_TO_UDINT(LEN(yTx2)));

// yTx2 := LEFT(yTx2,fRW-2); 		// odstrani CRLF z konca
      yTx2 := MID(yTx2, fRW - 2, OffSrc); // odstrani CRLF z konca a nacita od povodneho zaciatku

		aSys.RWtoFileCycle := aSys.RWtoFileCycle + fRW;
		IF close THEN
		 	rb		:= FileClose(hFile := fH);
		END_IF;
   END_IF;
   _Nh1RowTxt := fRW > 0;
END_FUNCTION



FUNCTION _NhCloseAllFiles {HIDDEN}: BOOL;
	aSys.OpenFilesCount		:= OpenFilesCount();
	rb 						:= CloseAllFiles();
	_LangTXT 				:= CONCAT(aSys.DiskHed.Disk[4].path, 'FRM/_NhLang.TXT');
  	aSys.LangfH 			:= FileOpen(fileName := _LangTXT, mode := F_READ);
	aSys.LogHed.fhEvn 		:= INVALID_HANDLE_VALUE;
	aSys.CloseAllFiles		:= TRUE;
END_FUNCTION

FUNCTION _Nh_LangTxt {HIDDEN}: BOOL
   VAR_INPUT
		id: INT;
   END_VAR
   rb 			:= FileSetPos(hFile := aSys.LangfH, offset := INT_TO_UDINT(id - 1) * 64);
   _Nh_LangTxt := FileRead (hFile := aSys.LangfH, adrBuf := PTR_TO_UDINT(ADR(_LangTXT)), size := 30) = 30;
END_FUNCTION

FUNCTION _Nh_Lang {HIDDEN}: BOOL // nazov suboru obrazka
   VAR_INPUT
      id: INT;
      txt: PTR_TO STRING; // pointer premennej
      zn: USINT := 30; // pocet znakov premennej
   END_VAR
	rb	:= FileSetPos(hFile := aSys.LangfH, offset := INT_TO_UDINT(id - 1) * 64);
   IF FileRead (hFile := aSys.LangfH, adrBuf := PTR_TO_UDINT(txt), size := USINT_TO_UDINT(zn)) > 0 THEN
		_Nh_Lang := aTrim(wht := 0, txt := txt);
	ELSE
		_Nh_Lang := FALSE;
      	txt^ 	:= '_NhLang ?';
	END_IF;
(*
	IF _NhLang THEN
		txt^	:= _LangTxt;
  		rb := aTrim(txt := txt); // medzery zprava
	ELSE
      txt^ 	:= '_NhLang ?';
	END_IF;
 *)
END_FUNCTION

FUNCTION _NhGetTimeCyc {HIDDEN}: TIME			// returns actual time cycle
	_NhGetTimeCyc := SUB_DT_DT(GetRtc(), aSys.NhDT);
END_FUNCTION
FUNCTION _NhMaxTimeCyc {HIDDEN}: BOOL			// returns if the cycle time up to this moment is greater than the specified value
	VAR_INPUT
		tc: UDINT := 300; // := CPU_MAX_CYCLE_TIME-CPU_MAX_CYCLE_TIME/8;
	END_VAR
	_NhMaxTimeCyc := TIME_TO_UDINT(_NhGetTimeCyc()) >= tc;	// T#0.3s THEN
END_FUNCTION
FUNCTION _NhMaxRWLimit {HIDDEN}: BOOL			// returns if the cycle time up to this moment is greater than the specified value
	VAR_INPUT
		rw: UDINT := _NH_CLUSTER * 5;
	END_VAR
	_NhMaxRWLimit	:= aSys.RWtoFileCycle > rw;
END_FUNCTION


FUNCTION _NhFclose {HIDDEN}: BOOL // otvori/zavrie subor
	VAR_INPUT
		dir: BOOL;
	END_VAR
   VAR_IN_OUT
      fh: HANDLE;
   END_VAR
   IF fh <> INVALID_HANDLE_VALUE THEN // otvorit
      fS := FileSize(hFile := fH); // do GLB sa vlozi velkost suboru
		IF dir THEN
	 rb := DirClose (hDir := fH);
		ELSE
	 rb := FileClose(hFile := fH);
		END_IF;
   END_IF;
   fh := INVALID_HANDLE_VALUE;
   _NhFclose := TRUE;
END_FUNCTION


FUNCTION _NhDirExists {HIDDEN}: BOOL   // test if directory exists
   VAR_INPUT
      fN: STRING[30];
   END_VAR
   VAR_TEMP
      fh: HANDLE;
   END_VAR   
   fN := CONCAT(fN,'_T_._T_');
   fH := FileOpen(fileName := fN, mode := F_WRITE);
   _NhDirExists := fH <> INVALID_HANDLE_VALUE;
   IF _NhDirExists THEN
      rb := FileClose(hFile := fH);
      rb := FileDelete(fileName := fN); // vymaze testovaci subor
   END_IF;   

END_FUNCTION

FUNCTION _NhTF_MODE_S : STRING[1] 	// retun string enum TF_MODE
   VAR_INPUT
      mode: 	TF_MODE; // 0:=F_READ {default} 1:=F_WRITE, 2:=F_APPEND, 3:= F_READ_PLUS
	END_VAR
	IF mode = 0 	THEN _NhTF_MODE_S := '0';		// F_READ otevrít soubor pro ctení
	ELSIF mode = 1 THEN _NhTF_MODE_S := '1';		// F_WRITE otevrít soubor pro zápis, zápis dat bude od zacátku souboru
	ELSIF mode = 2 THEN _NhTF_MODE_S := '2';   	// F_APPEND otevrít soubor pro zápis,data budou pripojena na konec souboru
	ELSIF mode = 3 THEN _NhTF_MODE_S := '3';    // F_READ_PLUS otevrít soubor pro ctení i pro zápis
	ELSE	              _NhTF_MODE_S := '?';
	END_IF;
END_FUNCTION


FUNCTION _NhFopen {HIDDEN}: BOOL // otvori subor, do fS zapise velkost a do fP nastaveny offset
   VAR_INPUT
      close: 	BOOL := TRUE; // ak je na zaciatku otvorene, najskor zavrie
      EndCl: 	BOOL; // na konci zavrie (..pre vytvorenie suboru, alebo test... )
//		errLog: 	BOOL;
      seek: 	UDINT; // data offset in file
      mode: 	TF_MODE; // 0:=F_READ {default} 1:=F_WRITE, 2:=F_APPEND, 3:= F_READ_PLUS
	END_VAR
   VAR_IN_OUT
      fH: 		HANDLE;
      fN: 		STRING;
   END_VAR
   _NhFopen := FALSE;
   IF close AND fh <> INVALID_HANDLE_VALUE THEN
      rb := _NhFclose(fH := fH);
   END_IF;
   fH := FileOpen(fileName := fN, mode := mode);
   IF fh <> INVALID_HANDLE_VALUE THEN
      fS := FileSize(hFile := fH); // do GLB sa vlozi velkost suboru
      fP := 0; // poziacia v subore
      IF fS=UNKNOWN_SIZE THEN
         EndCl := TRUE; // ak je neznama velkost, uzavrie subor a vrati false
			rb:=_NhSysLogMsg(msg:='! _NhFopen fS=UNKNOWN_SIZE; fN: {'+fN+'};mode:'+_NhTF_MODE_S(mode)+';fS='+UDINT_TO_STRING(fS),debug:=true); // mode:'+mode);
      ELSE
         _NhFopen := TRUE;
      END_IF;
      IF EndCl THEN // na konci zavrie
         _NhFopen := FALSE;
      ELSIF mode = 1 THEN // ked je F_WRITE, offset {seek} sa ignoruje, zapisuje sa od zaciatku
         ;
      ELSIF _NhFopen AND seek > 0 THEN // je otvoreny a ma sa presunut na poziciu {offset}
         // ako funguje offset {seek}:
         // F_WRITE vynuluje subor a nastavi fS:=0
         // F_APPEND otvori a zapise velkost do fS
         // potom obidva mody: ak seek>fS doplnia pre poziciu 'seek' znaky 'NULL' a od pozicie 'seek' zapisu data
         // preto treba seek obmedzit na velkost fS, aby sa neazpisovali 'NULL';
         IF seek <= fS THEN // ziadana pozicia <= ako velkost suboru
            IF FileSetPos( hFile := fh, offset := seek) THEN	//
               fP := seek;
            ELSE
               _NhFopen := FALSE;
               fP := 0;
            END_IF;
         ELSIF mode = 2 THEN // pri append je pozicia nastavena na koniec suboru
            fP := fS;
         ELSE
            _NhFopen := FALSE; // F_READ, F_READ_PLUS nenaslo poziciu, vrati false
		 		rb:=_NhSysLogMsg(msg:='! _NhFopen seek <= fS: fN:{'+fN+'};mode:'+_NhTF_MODE_S(mode)+';fS='+UDINT_TO_STRING(fS),debug:=true); // mode:'+mode);
         END_IF;
      END_IF;
      IF _NhFopen = FALSE THEN // na konci zavrie
         _NhFopen := _NhFclose(fH := fH);
      END_IF;
	ELSE	
		rb:=GetLastErrTxt(errCode := GetLastErr(), errMessage := yTx0);
		rb:=_NhSysLogMsg(msg:='! _NhFopen Err: "'+yTx0+'";fN:{'+fN+'};mode:'+_NhTF_MODE_S(mode),debug:=true); // mode:'+mode);
   END_IF;
END_FUNCTION

FUNCTION _Nh_File_Mem {HIDDEN}: BOOL
   VAR_INPUT
      write: BOOL;
      what: USINT;
      aVar: UDINT;
      size: UDINT;
      fH: HANDLE;
   END_VAR
	fRW	:= 0;
   IF write THEN
      CASE what OF
        0: fRW := FileWrite (hFile := fH, adrBuf := aVar, size := size);
        1: fRW := FileWriteRBx (hFile := fH, adrRBx := aVar, size := size);
      END_CASE;
   	aVar	:= fRW;
   ELSE
      CASE what OF
        0: fRW := FileRead (hFile := fH, adrBuf := aVar, size := size);
        1: fRW := FileReadRBx (hFile := fH, adrRBx := aVar, size := size);
      END_CASE;
   	aVar	:= fRW / 4;
   END_IF;
  	aSys.RWtoFileCycle 	:= aSys.RWtoFileCycle + aVar;
   _Nh_File_Mem 			:= fRW = size;
END_FUNCTION

FUNCTION_BLOCK _Nh_File_Line // zapisuje/cita/modifikuje riadok
	//	yTx0:='a.txt'; fbLine(open:=true,seek:=0,nLine:=1,sLine:=,aLine:=);		otvorit,vymazat,inicializovat
	// fbLine(close:=true,seek:=0);															len zatvorit
	// fbLine(write:=true,seek:=fbFileLine.LineS);
   (* close and delete file before open
      open a file from yTx5 (always F_READ_PLUS)
      seek: set
   *)

   VAR_INPUT
      what: 	USINT; // 0=Mem,1=RBx
      aLine: 	UDINT; 	//
		sLine: 	UDINT := 1; // dlzka riadka vratane CRLF
      nLine: 	UDINT := 1; // pocet riadkov pre zapis/nacitanie
      seek: 	UDINT; // set the beginning of this line
      open: 	BOOL; // najskor zatvori a nanovo otvori
      del: 		BOOL; // pred otvorenim vymaze
      close: 	BOOL; // na konci zatvori
      write: 	BOOL; // read=true:from File, read:=false: write To file
      append: 	BOOL;
   END_VAR
   VAR_OUTPUT
      ready: 	BOOL; // action is done
      done: 	BOOL;
      err: 		BOOL; // error flag
      rec: 		UDINT; // number of record
      LineS: 	UDINT; // the line number that was last loaded
      LineN: 	UDINT; // last number of lines, that were R/W
   END_VAR
   VAR
      fH: 		HANDLE;
      fS: 		UDINT; 		// fileSize
   END_VAR
   fRW := 0; err := FALSE; done := FALSE;
   IF open THEN open := FALSE;
      err 	:= FALSE; LineS := 0; LineN := 0; ready := FALSE;
      rb 	:= _NhFclose(fH := fH);
      IF del THEN del := FALSE;
         rb := fileDelete(fileName := yTx0);
      END_IF;
      IF _NhFopen(fN := yTx0, fH := fH, mode := 3) THEN
         ready := TRUE;
         fS 	:= FileSize(hFile := fH);
         rec 	:= fS / sLine;
      ELSE
         RETURN;
      END_IF;
   ELSIF ready = FALSE THEN
      RETURN;
   END_IF;
   IF seek > 0 THEN
      IF seek > rec THEN
         IF write THEN
            append := TRUE;
         ELSIF append THEN ;
         ELSE
            err := TRUE;
// done := true;
            LineS := 0;
            LineN := 0;
         END_IF;
      ELSE
         rb := FileSetPos( hFile := fH, offset := (seek - 1) * sLine);
   		err := _Nh_File_Mem(write := write, what := what, aVar := aLine, size := sLine * nLine, fH := fH) = FALSE;
         IF fRW >= sLine THEN
            LineS := seek;
            LineN := fRW / sLine;
         	done := TRUE;
         ELSE
            LineS := 0;
            LineN := 0;
         END_IF;
         append := FALSE;
      END_IF;
   END_IF;
   IF append THEN append := FALSE;
      rb := FileSetPos( hFile := fh, offset := fS);
      err := _Nh_File_Mem(write := TRUE, what := what, aVar := aLine, size := sLine * nLine, fH := fH) = FALSE;
      IF fRW >= sLine THEN
         LineS := fS / sLine;
         LineN := fRW / sLine;
      ELSE
         LineS := 0;
         LineN := 0;
      END_IF;
      fS := fS + fRW;
   END_IF;
   IF fRW > 0 THEN
      rec := fS / sLine;
   END_IF;
   IF close THEN
      rb := _NhFclose(fH := fH);
      ready := FALSE;
      close := FALSE;
   END_IF;
END_FUNCTION_BLOCK

FUNCTION_BLOCK _Nh_File_RW // zapisuje/cita zo suboru do premennej. Premenna moze byt v MEM,RAM,DBX
	// moze nacitat aj riadok ukonceny CRLF, pricom nie je pevna dlzka riadka
	// Copy data from/to variable/RamBox to/from file.
   // If file does not exist new file is created.
   // If file exists file content is overwitten.
   // these global variables that must exist are overwritten: fS,fP,fRW
   VAR_INPUT
      adrVar: 	UDINT; // adresa: variable/Ram/Dbx address {it is entered at the beginning and cannot be changed after that !!!}
		size: 	UDINT;
      seek: 	UDINT; // data offset in file {it is only taken over at the beginning, after that it has no effect}
      whatVar: USINT; // what is in adrVar 0=MEM, 1=RamBox, 2=DataBox
      mode: 	TF_MODE; // 0=F_READ,1=F_WRITE,2=F_APPEND {ak je seek=0 => append na koniec, seek>0..zapise na pozociu seek}
      exec: 	BOOL; // leading edge start new write/read. if a process is running, interrupt it and close the file
		init: 	BOOL;
      cancel: 	BOOL; // immediate termination
      Line: 	BOOL; // reads 255b and looks for CRLF and sets position to the next line
      FullFile:BOOL; 	 // Load the full size of the file detected after opening. Only read from file. {mode:=0}
      LimitOn: BOOL := TRUE; //
   END_VAR
   VAR_OUTPUT
      done: 	BOOL; // action is done
      busy: 	BOOL; // action in progress
      row: 		BOOL; // found row ended CRLF. The string is at the address adrVar (including CRLF) maps into xTx2^
      err: 		BOOL; // error flag
		cyc: 		UINT;
      errID: 	UDINT; // error number
      actSize: UDINT; // really written
		cycSize: UDINT; 		 // actualy Size per cycle
      hnd: 		HANDLE;
   END_VAR
   VAR_IN_OUT
      fileName: STRING; // file name
   END_VAR
   VAR
//      hnd: HANDLE;
   END_VAR
	VAR_TEMP

	END_VAR
   done := FALSE; row := FALSE;
    // open file and seek position
	IF exec THEN
      IF line THEN
         mode := F_READ;
      END_IF;
		cyc	:= 0; // errTxt := '';
      exec 	:= FALSE; busy := TRUE; err := FALSE; errID := 0; actSize := 0;
		IF whatVar = 2 THEN
			IF mode = F_READ THEN fbDbxFromFile.exec := TRUE;
			ELSE fbDbxToFile.exec 	 := TRUE;
			END_IF;

		ELSIF _NhFopen(fN := fileName, fH := hnd , mode := mode, seek := seek, ) = FALSE THEN	 // (DBX W/R), close file
			yTx2	:= fileName;														// vrati meno suboru aj s chybovou hlaskou
			busy 	:= FALSE; done := TRUE; err := TRUE; // errID := 900001;
			errID := fS;	// GetLastErr();
			fS		:= 0;
// rb := GetLastErrTxt(errCode := errId, errMessage := yTx2);
      ELSIF Line OR FullFile THEN
         size := fS; // the file size is in the variable fS after opening. The full size is loaded
      END_IF;
      fP := seek;
		IF init THEN
			init := FALSE;
			IF busy THEN
				RETURN;
			END_IF;
		END_IF;
   END_IF;
   // write data to file to variable (one sector per one PLC cycle)
   IF busy THEN
		cyc := cyc + 1;
      IF cancel THEN // force/user break
         done := TRUE; err := TRUE; errID := 1003 ; 		// _NhFileRW-user break
      ELSIF size > actSize THEN
         IF LimitON AND aSys.mSecMax > aSys.mSecLimit THEN
         	cycSize := 512;
			ELSE
				cycSize	:= _NH_CLUSTER;
			END_IF;
         cycSize := MIN(size - actSize, cycSize ); // at most for one cycle
         CASE whatVar OF
           0: // MEM
               IF Line THEN
                  xTx2 := UDINT_TO_PTR(adrVar);
                  fRW 	:= FileRead(hFile := hnd, adrBuf := adrVar , size := 255); // start at position actSize
						aSys.RWtoFileCycle := aSys.RWtoFileCycle + fRW / 2;
                  IF fRW > 0 THEN // 1 4 6
                     cycSize := FIND(xTx2^, _NH_CRLF); // 'abcCRxyz'
                     IF cycSize > 0 THEN // cycSize:=4
                        xTx2^ := LEFT(xTx2^, cycSize - 1); // 'abc' (4-1=3)
                        Row := TRUE; // Out impulz
                        cycSize := cycSize + 1;
                        fRW := cycSize; // '...CRxzy'
                        rb := FileSetPos(hFile := hnd, offset := actSize + fRW ); // next line position 'xyz' ( 4+2{CRLF}=6)
                     ELSE
                         cycSize := fRW; // actual position = next line
                     END_IF;
                  END_IF;

               ELSIF mode = F_READ THEN fRW 	:= FileRead(hFile := hnd, adrBuf := adrVar + actSize, size := cycSize);
               ELSE fRW 	:= FileWrite(hFile := hnd, adrBuf := adrVar + actSize, size := cycSize);
											aSys.RWtoFileCycle := aSys.RWtoFileCycle + fRW;
               END_IF;
         		actSize := actSize + fRW; // actual read/write size
           1: // RamBox
               IF mode = F_READ THEN 	fRW := FileReadRbx( hFile := hnd, adrRbx := adrVar + actSize, size := cycSize);
               ELSE 							fRW := FileWriteRbx(hFile := hnd, adrRbx := adrVar + actSize, size := cycSize);
											aSys.RWtoFileCycle := aSys.RWtoFileCycle + fRW;
               END_IF;
         		actSize := actSize + fRW; // actual read/write size
           2: // DataBox
               IF mode = F_READ THEN
//						fRW := fbDbxFromFile.actSize;
						fbDbxFromFile(fileName := fileName, dstAdr := adrVar, size := size, seek := seek);	// SDC->DBX
                  fRW := fbDbxFromFile.actSize; // - fRW;
						IF fbDbxFromFile.exec = FALSE THEN
			 done 		:= TRUE;
         				actSize 	:= fbDbxFromFile.actSize;
						ELSIF fbDbxFromFile.Done OR fbDbxFromFile.Err THEN
							err := fbDbxFromFile.Err; errID := fbDbxFromFile.ErrID; // exec:=TRUE resets .ERR, but errID remains
							fbDbxFromFile.exec := FALSE; // next
						END_IF;
               ELSE
//						fRW := fbDbxToFile.actSize;
						fbDbxToFile(fileName := fileName, srcAdr := adrVar, size := size, seek := seek); 	// DBX->SDC
                  fRW := fbDbxToFile.actSize; // - fRW;
						aSys.RWtoFileCycle := aSys.RWtoFileCycle + fRW;
						IF fbDbxToFile.exec = FALSE THEN
			 done 		:= TRUE;
         				actSize 	:= fbDbxToFile.actSize;
						ELSIF fbDbxToFile.Done OR fbDbxToFile.Err THEN
							err := fbDbxToFile.Err; errID := fbDbxToFile.ErrID;
							fbDbxToFile.exec := FALSE;
						END_IF;
               END_IF;
					fRW := cycSize;
         ELSE // function not defined
               fRW 	:= 0;
               cancel := TRUE; err := TRUE; errID := 1004; 					// _NhFileRW-undefined WhatVar
         END_CASE;
      	IF done AND actSize = size THEN
           	done := TRUE;
         ELSIF fRW <> cycSize THEN 			// the request did not proceed correctly
  	 done := TRUE; err := TRUE; errID := 1005;
			END_IF;
      ELSE
         done := TRUE;
      END_IF;
   END_IF;
   // correct end process or any error or forced interruption
   IF done THEN
      rb := _NhFclose(fH := hnd);
      cancel := FALSE; busy := FALSE;
   END_IF;
END_FUNCTION_BLOCK

FUNCTION _Nh_Line_RW: BOOL // write a fixed length line+CRLF or read a specific line
	// yTx1 .. log file name {full path}
	// yTx2 .. content to write into log file
	// !!! GLOBAL VAR fP will be owerwriten and return the position of the next line !!!
   VAR_INPUT
      mode:       TF_MODE;       // 0=F_READ,1=F_WRITE,2=F_APPEND
		LineNbr:    UDINT := 1;	   // number of Line for read/write
      LineLen:    UDINT := 40;   // length line (included CRLF := 2)
		read255:    BOOL;          // cumulative function: reopens the file, reads the first 255 where it looks for a LineNbr terminated by CRLF, close file
		readFP:     UDINT;			// read from File Position
		close:      BOOL := TRUE;  // close at the end
      new:        BOOL;          // delete file and create new
		fExist:     BOOL;			   // test if the loaded file actually exists
   END_VAR
   VAR_IN_OUT
      fH:         HANDLE; // file handle
   END_VAR
   _Nh_Line_RW := FALSE;
	IF read255	THEN
		rb := _NhFclose(fH := fH);
		fH := INVALID_HANDLE_VALUE; LineLen := 0; close := TRUE; // readFP := 0;
	ELSIF new THEN
      rb := _NhFclose(fH := fH); // close file for delete
		rb 	:= FileDelete(fileName := yTx1);
   END_IF;
   IF fH <> INVALID_HANDLE_VALUE THEN ;
   ELSIF _NhFopen(fN := yTx1, fH := fH , mode := mode) THEN ;
	ELSIF fExist THEN
//		rb := _NhSysLogMsg(msg:='File NOT Exists: {' + yTx1 + '}',ini:=FALSE);
		RETURN;
	ELSE
		RETURN;
   END_IF;
   IF mode = F_READ THEN
		IF LineLen = 0 THEN														// look for CRLF
			rb 	:= FileSetPos( hFile := fH, offset := readFP);
		 	fRW 	:= FileRead (hFile := fH, adrBuf := PTR_TO_UDINT(ADR(yTx2)), size := 255); // try to read the whole line
			aSys.RWtoFileCycle := aSys.RWtoFileCycle + fRW / 4;
			new	:= TRUE;
			fP		:= readFP + fRW;
         WHILE fRW > 0 DO // AND LineNbr > 0 DO 		// 1	 4 6
// 	 	 LineLen := INT_TO_UDINT(FIND(yTx2,_NH_CRLF)); 		// 'aaaCRbbbbbCRddddd'
    	 	LineLen := FIND(yTx2, _NH_CRLF); 		// 'aaaCRbbbbbCRddddd'
	 		IF LineLen > 0 THEN 	// 4 6
					IF new THEN
						new 	:= FALSE;
						fP		:= readFP + LineLEn + 2;						// save start position of the next Line
    				END_IF;
					LineNbr := LineNbr - 1;
					IF LineNbr > 0 THEN										 	//	 4 6
    					yTx2 	:= DELETE(in := yTx2, L := LineLen + 1, P := 1); // 'aaaCRbbbbbCRddddd' -> 'bbbbbCRddddd'
			 ELSE
//						LineLen	:= LineLen - 1;
     					yTx2 		:= LEFT(yTx2, LineLen - 1); // We found the requested line.
						fRW		:= 0;
					END_IF;
    			ELSE																	// 'dddd'
					EXIT;																// force another to read data from file
            END_IF;
      	END_WHILE;
			LineLen := 0; 						// _NhLineRW := LineNbr = LineLen;
			IF LineNbr > 0 THEN
				rb := _Nh_LangTxt(1002); yTx2 := CONCAT(_LangTxt, UDINT_TO_STRING(LineNbr)); //	In file NOT found Line nbr:
			ELSIF fExist THEN
				IF FileExists( fileName := yTx2) = FALSE THEN		 	// test file
					yTx2	:= CONCAT('File NOT Exists: ', '{', yTx2 , '}');
//					_Nh_LangTxt(1001); yTx2:=CONCAT(_LangTxt,UDINT_TO_STRING(LineNbr)); // File from Line NOT Exist
					LineLen := 999; 		// not found
				END_IF;
			END_IF;
		ELSE
			yTx2		:= '';
			IF readFP = 0	THEN
				readFP 	:= ( (LineNbr - 1) * LineLen );
			END_IF;
			rb 		:= FileSetPos( hFile := fh, offset := readFP); // vzdy je true, ak je otvoreny subor
   		LineNbr 	:= FileRead (hFile := fH, adrBuf := PTR_TO_UDINT(ADR(yTx2)), size := LineLen );
			fP			:= readFP + LineNbr;
		END_IF;
   ELSE
      // 123456789 12
      // 12345*....CF
      IF LineLen = 0 THEN
         LineLen := LEN(yTx2) + 2; // neriadi sa fixnou dlzkou, ale prida len dlzku strigu + NUL + CRLF {'12345NULCRLF'}
      END_IF;
		memsetEx(val := 16#20202020, length := LineLen - LEN(yTx2) - 1, dest := VOID(yTx2), offDest := LEN(yTx2) + 1); // vymaze string medzerami
      memsetEx(val := 16#0a0d, length := 2, dest := VOID(yTx2), OffDest := LineLen - 2); // + CRLF
      IF mode = F_WRITE THEN
			LineNbr 	:= ( (LineNbr - 1) * LineLen );
    	ELSIF mode = F_APPEND THEN
			;
    	ELSE
         { $ IF CPU_CODE > 1999 }
// lineNbr := 16#FFFF_FFFF;
            lineNbr := END_POS;
         { $ ELSE }

            lineNbr := 16#FFFF;
         { $ END_IF }
			readFP	:= LineNbr;
   	 rb 		:= FileSetPos( hFile := fh, offset := readFP);
	 END_IF;

		LineNbr 	:= FileWrite(hFile := fH, adrBuf := PTR_TO_UDINT(ADR(yTx2)), size := LineLen);
		fP			:= readFP + LineNbr;
		aSys.RWtoFileCycle := aSys.RWtoFileCycle + LineNbr;
   END_IF;
   _Nh_Line_RW := LineNbr = LineLen; // to co sa chcelo sa zapisalo
   IF close THEN
      rb := _NhFclose(fH := fH);
   END_IF;
END_FUNCTION

(*
FUNCTION _NhLogErrTxt: BOOL 	// insert error string into yTx2 and save log
	VAR_INPUT
		save: BOOL:=TRUE;		// save to log
		clr: BOOL:=TRUE; 		// only err string {or yTx2+errorString}
		errID: INT; // ID
	END_VAR
RETURN;

//	_Nh_LangTxt(id:=errID); // get Err text into string _LangTxt
	IF clr THEN
		yTx2	:= _LangTxt;
	ELSE
		yTx2	:= CONCAT(yTx2,_LangTxt);
	END_IF;
	IF save THEN
		_Nh1RowTxt(logRst:=1); 	// write log
	END_IF;
END_FUNCTION
 *)

FUNCTION {HIDDEN} _Nh_N12: UINT // podla podmienky vrati o1, alebo o2
   VAR_INPUT
      in: BOOL;
      o1: UINT;
      o2: UINT;
   END_VAR
   IF in THEN _Nh_N12 := o1;
   ELSE _Nh_N12 := o2;
   END_IF;
END_FUNCTION

FUNCTION {HIDDEN} _Nh_O12: INT // podla podmienky vrati o1, alebo o2
   VAR_INPUT
      in: BOOL;
      o1: INT;
      o2: INT;
   END_VAR
   IF in THEN _Nh_O12 := o1;
   ELSE _Nh_O12 := o2;
   END_IF;
END_FUNCTION

FUNCTION {HIDDEN} _Nh_U12: USINT // podla podmienky vrati o1, alebo o2
   VAR_INPUT
      in: BOOL;
      o1: USINT;
      o2: USINT;
   END_VAR
   IF in THEN _Nh_U12 := o1;
   ELSE _Nh_U12 := o2;
   END_IF;
END_FUNCTION

FUNCTION {HIDDEN} _Nh_S12: SINT // podla podmienky vrati o1, alebo o2
   VAR_INPUT
      in: BOOL;
      o1: SINT;
      o2: SINT;
   END_VAR
   IF in THEN _Nh_S12 := o1;
   ELSE _Nh_S12 := o2;
   END_IF;
END_FUNCTION

FUNCTION_BLOCK _Nh_TONF {HIDDEN} 	// opozdenie v [sec/Min/Hour] In->Out po zapnuti aj vypnuti s autoresetom
  	VAR_INPUT
		PT: UINT; 		// delay po zapnuti [sec]
      wht: USINT;
  		In: BOOL; 	// vstup
		rst: BOOL;
  	END_VAR
	VAR
		InOld: BOOL;
	END_VAR
	VAR_OUTPUT
		Q: BOOL;							// vystup
		Qr: BOOL; 	// impulz pri ON
		Qf: BOOL; 	// impulz pri Off
		ET: UINT;
	END_VAR
	Qr 	:= FALSE;
	Qf 	:= FALSE;
	IF rst OR InOld <> In THEN 									// reset
		ET 	:= PT;										// prida sa 1sec aby sa vyhodnotilo ET
		Q		:= 0; // NOT in;
		rst 	:= FALSE;
		InOld := In;
	ELSIF et > 0 THEN // bezi opozdenie
      CASE wht OF
        0: et := et - BOOL_TO_UINT(SYSTEM_S.F_EDGE_1SEC);
        1: et := et - BOOL_TO_UINT(SYSTEM_S.F_EDGE_1MIN);
        2: et := et - BOOL_TO_UINT(SYSTEM_S.F_EDGE_1HOUR);
      END_CASE;
		IF et = 0 THEN											// minimum je 1, co sa chape ako OK
			et	:= 0;
         Q := In;
			Qr := Q;
			Qf := Q = FALSE;
		END_IF;
   ELSE
      Q := In;
   END_IF;
END_FUNCTION_BLOCK

FUNCTION_BLOCK _Nh_TONOF {HIDDEN} 	// opozdenie v [sec] In->Out po zapnuti aj vypnuti s autoresetom
  	VAR_INPUT
		tOn: UINT; 		// delay po zapnuti [sec]
		tOf: UINT;							// delay po vypnuti [sec]
		In: BOOL; 	// vstup
		rst: BOOL;
  	END_VAR
	VAR
		InOld: BOOL;
	END_VAR
	VAR_OUTPUT
		Q: BOOL;							// vystup
		Qr: BOOL; 	// impulz pri ON
		Qf: BOOL; 	// impulz pri Off
		et: UINT;
	END_VAR
	Qr 	:= FALSE;
	Qf 	:= FALSE;
	IF rst OR InOld <> In THEN 									// reset
		IF In THEN
			et 	:= tOn + 1;										// prida sa 1sec aby sa vyhodnotilo ET
		ELSE
			et 	:= tOf + 1;
     	END_IF;
		IF RST THEN
			Q		:= 0;	// In; // resetne vystup
//			Q		:= NOT In; 	// pri in:=1 .. oneskorenie zapnutia Q:=0->1
																		// pri in:=0 .. oneskorenie vypnutia Q:=1->0
	 END_IF;
		rst 	:= FALSE;
		InOld := In;
	ELSIF et > 0 THEN // bezi opozdenie
		et := et - aSys.u1Sec;
		IF et <= 1 THEN											// minimum je 1, co sa chape ako OK
			et	:= 0;
			Q 	:= In;
			Qr := Q;
			Qf := Q = FALSE;
		END_IF;
	END_IF;
END_FUNCTION_BLOCK

FUNCTION_BLOCK _Nh_U_Delay {HIDDEN} // opozdenie In->Out po ustaleni v case Delay
  	VAR_INPUT
		Delay: USINT; // opozdenie novej hod kazdenho noveho PV rozdielneho od aktualneho
		IN: BOOL; 	 	// nova hodnota
  	END_VAR
	VAR_OUTPUT
		Done: BOOL;
		Busy: BOOL;
		et: USINT; // cas delay v [s]
	END_VAR
	Done	:= FALSE;
	IF In THEN
		et	 	:= Delay;
		Busy	:= TRUE;
	ELSIF Busy THEN
		IF et > 0 AND SYSTEM_S.F_EDGE_1SEC THEN
			et := et - 1;
		END_IF;
		IF et = 0 THEN
			Done	:= TRUE;
			Busy	:= FALSE;
		END_IF;
	END_IF;
END_FUNCTION_BLOCK

FUNCTION_BLOCK _Nh_R_Delay {HIDDEN} // opozdenie In->Out po ustaleni v case Delay
	VAR_OUTPUT
		dif: REAL;
		Out: REAL;							// aktualna hodnota / vystup
		et: USINT; // cas delay v [s]
		chg: BOOL; 	// zmenil sa vystup
	END_VAR
  	VAR_INPUT
		rst: BOOL; 						// restart {vstup revedie na vystup okamzite = bez Delay
		In: REAL; // nova hodnota
		Delay: USINT; 		// opozdenie novej hod kazdenho noveho PV rozdielneho od aktualneho
		Sens: REAL := 0.1;					// hysterezia = povolena odchylka
  	END_VAR
	VAR
		Old: REAL;							// posledna hodnota In
	END_VAR
	chg	:= FALSE;
//	in 	:= ROUND(in * 10.0) / 10.0;
	dif := Out - In;
	IF ABS(Out - In) <= sens	THEN
		et	:= 0;
	ELSIF rst OR Delay = 0 THEN
		Out := In;
		chg := TRUE;
	ELSIF Old <> In OR et = 0 THEN
		et	 	:= Delay;
		Old 	:= In;
	ELSE
		et := et - aSys.n1Sec;
		IF et = 0 THEN
			Out := In;
			chg := TRUE;
		END_IF;
	END_IF;
	chg	:= chg OR rst;
END_FUNCTION_BLOCK

FUNCTION_BLOCK _Nh_FILTER_1R {HIDDEN} // filer 1.radu
   VAR_INPUT
      In: REAL ; // nova hodnota zo snimaca (stara hodnota je v xDev^.al.in.val)
      fil: REAL := 10.0; // filtrovanie 1.radu
		hys: REAL := 0.1 ;		 // povolena odchylka
      sample: UINT := 30; // vzorkovacia frekvencia vydavania vystupu[s]
		rst: BOOL;		 // okamzite prenesenie vstupnej hodnoty na vustup
		rstBig: BOOL := TRUE	; 	 // resetne, ked je velka zmena - po restarte sa nastavi
   END_VAR
	VAR_OUTPUT
//		Run: BOOL; 				 // po restarte sa vyvola reset
		Qr: BOOL;					 // impulz pri zmene vystupu
		New: REAL; // nova vypocitavana hodnota podla filtra
		Out: REAL; // vystupna filtrovana hodnota zakomponovana aj s hystereziou vydana po vzorkovacej frekvencii
    	Qn: UINT; // zostatok [s] do vyslania noveho vystupu
		nBig: USINT;					 // pocet velkych zmien
	END_VAR
	Qr	:= FALSE;
   IF rst THEN // OR run = false THEN // okamzity prenos hodnoty (vyluci sa filter) reset vstupov
		rst	:= FALSE;
//		run	:= true;
		New 	:= In;
//		Out	:= New;
//		Qr		:= true;
      Qn 	:= 0;
   ELSIF SYSTEM_S.R_EDGE_100MS THEN
		New 	:= (New * fil + In ) / (fil + 1.0) ;
		IF rstBig THEN
			// ak sa caka na velku zmenu a ta je 100x vacsia ako vysledok, tak sa
			IF ABS(Out - In) > 100. * hys THEN
				nBig		:= nBig + 1;
				rstBig 	:= FALSE;
				New 		:= In;
		 Qn 		:= 0;
			END_IF;
		END_IF;

	END_IF
   IF Qn = 0 THEN
		IF ABS(New - Out) > hys THEN
			Qr := TRUE;
			Out := ROUND(new * 10.) * 0.1;
		END_IF;
		Qn :=	sample;
   ELSIF SYSTEM_S.R_EDGE_1SEC THEN
      Qn := Qn - 1;
   END_IF
END_FUNCTION_BLOCK





(*
FUNCTION_BLOCK _Nh_Brw_Dir // copy file or directory
	VAR_INPUT
		go: USINT;
		IniEnd: USINT;
		IniErr: USINT;
		IniRun: USINT:=255;
		copy: BOOL:=true;	// copy:=false => delete after copy (move)
		file: BOOL:=true ;	// dir or file
      exec: BOOL; // leading edge start new write/read. if a process is running, interrupt it and close the file
// break: BOOL; 	// immediate termination
		init: BOOL;			// only open files an prepare for run on the next call
	END_VAR
   VAR_OUTPUT
      done: BOOL; // action is done
      busy: BOOL; // action in progress
      err: BOOL; // error flag
      errID: UDINT; // error number
      size: UDINT; // data length {it is entered at the beginning and cannot be changed after that !!!}
      actSize: UDINT; // really written
		cycSize: UDINT; 		 // actualy Size per cycle
		cyc: UINT;
		files: UINT;
		allSize: UDINT;
		_NhFileInfo: TFileInfo;
   END_VAR
   VAR
		fbLD: ListDirectories;
		hDir: HANDLE;
      hSrc: HANDLE;
      hDst: HANDLE;
      hLog: HANDLE;
      adrVar: UDINT; // adresa: variable/Ram/Dbx address {it is entered at the beginning and cannot be changed after that !!!}
		GoNext: USINT;
   END_VAR
	VAR_TEMP
//		fRW: UDINT;
		fS: UDINT;
	END_VAR
	done	:= false;
	CASE Go OF
     0: RETURN;
     1: // copy file
			// ytx3,yTx4 contain both source and destination files, including the path
			aSys.Ini	:= IniRun;
			files		:= 0;
			allSize	:= 0;
			file		:= true;
			IF CPU_CODE >= 2000 THEN
				IF ForceDirs(fileName:=yTx4) = false THEN
					yTx2	:= yTx4;
					Go		:= 80;
					RETURN;
				END_IF;
			END_IF;
			exec		:= true;
			cyc		:= 0;
			GoNext :=	99;
	END_CASE;
END_FUNCTION_BLOCK
 *)


FUNCTION _Nh_Log_Path: BOOL // nacita/zapise do suboru
	VAR_INPUT
		month:	BOOL;
		read: 	BOOL;
		write: 	BOOL;
		fDhh: 	BOOL; // create day+time file	: DD_hhmm to yTx1
		fDhhTx2:	BOOL; // create day+time file	: DD_hhmm to yTx2
		suffix:	BOOL; // add suffix to file		".fN"
		restart: BOOL;
   	wh	: 		USINT;
		wh2: 		USINT; // additional parameter
		fN	: 		STRING[3]; 	// file name or suffix
      frm: 		UINT;
	END_VAR
	VAR_TEMP
		txt: 		STRING[10];
	END_VAR
	_Nh_Log_Path	:= TRUE;
	yTx1			:= fN; STRING_TO_LOWER(yTx1);
	CASE wh OF
		0:
			RETURN;
	 	5:	// copy 
 			CASE frm OF                                                                         // template of copy src* -> dst*
				0:	// copy V200/FRM -> RAM/FRM
					yTx3 	:= CONCAT(aSys.DiskHed.Disk[1].path, _NH2_VER, '/FRM/');			   // source
					yTx4 	:= CONCAT(aSys.DiskHed.Disk[4].path, 'FRM/'); 		// dest
			END_CASE;
			RETURN;
	 	6:	// log DIR + copy dir/file
 			CASE frm OF                                                                         // template log  of copy 
				0:	// copy V200/FRM -> RAM/FRM
      			yTx1 	:= CONCAT(aSys.DiskHed.Disk[4].path, '_CopyDir.log');							// log file for copy dir/file
			END_CASE;
			RETURN;




	 	7:	// read template from RAM/FRM/_231.FRM
         	yTx1 	:= CONCAT('_', UINT_TO_STRINGF(frm, '%03u'));
			yTx2	:= CONCAT(aSys.DiskHed.Disk[4].path, 'FRM/', yTx1, '.FRM');
			RETURN;


	 	1:	// create path in version after restart {FRM}

			yTx2 	:= CONCAT(aSys.DiskHed.Disk[1].path, _NH2_VER, '/', fN, '/');
			yTx1	:= CONCAT(aSys.DiskHed.Disk[1].path, yTx1, '.DIR'); // actual dir for save file rrmmddhh.mem

      2:	// LOG
			yTx2	:= CONCAT(aSys.DiskHed.Disk[2].path, 'LOG/');
			yTx1	:= CONCAT(yTx2, yTx1, '.DIR'); //

	 	4:	// create path in RAM, if exist - for faster run
//			month := false;
			yTx2 	:= CONCAT(aSys.DiskHed.Disk[4].path, fN, '/');
			yTx1	:= CONCAT(aSys.DiskHed.Disk[1].path, yTx1, '.DIR'); // actual dir for save file rrmmddhh.mem

	 	10:	// create path in version after restart {FRM}
			yTx2 	:= CONCAT(aSys.DiskHed.Disk[1].path, _NH2_VER, '/DBX/', DT_TO_STRINGF(aSys.NhDT, '%TYY_MM_DD/'));
			yTx1	:= CONCAT(aSys.DiskHed.Disk[1].path, yTx1, '.DIR'); // actual dir for save file rrmmddhh.mem
			aSys.ADR_DBX := yTx2;
	 100:	// LOG evn 'RAM/'
			yTx1	:= CONCAT(aSys.DiskHed.disk[4].path, 'evn_', DT_TO_STRINGF(aSys.NhDT, '%TYYMM'), '.csv' );
//			yTx1	:= CONCAT('WWW/LOGS/EVN_',DT_TO_STRINGF(aSys.NhDT,'%TYYMM.LOG') );
			IF aSys.restart THEN
//				rb := FileDelete(fileName := yTx1);
			END_IF;
			RETURN;
//		ELSE
//			_Nh_Log_Path	:= FALSE;
//			RETURN;
   END_CASE;

	CASE wh OF
	 	21:	//NH2
			yTx1 	:= aSys.DiskHed.Disk[1].path;					
			yTx2	:= '';
			CASE frm OF
				1:	// source FRM, 
					yTx1 	:= CONCAT(yTx1, _NH2_VER, '/FRM/');											
					RETURN;
				2:	// read path from dbx.mem to yTx2
					yTx1 	:= CONCAT(yTx1, 'dbx.mem');													// file with actual path to backup file
					read	:= TRUE;
				3:	// rename .wrk -> .mem file after writing successfully
					yTx2	:= CONCAT(yTx1, 'dbx.wrk');													// dest file for rename		
					yTx1	:= CONCAT(yTx1, 'dbx.mem');													// source file for rename	
					rb		:= FileRename(oldName := yTx2, newName := yTx1);						// rename .wrk -> .mem
					read	:= TRUE;
			END_CASE;
	 	22:	// USB
			yTx1 	   := aSys.DiskHed.Disk[2].path;					
			month 	:= TRUE;
			CASE frm OF
				0: RETURN;
				1:	yTx1 	:= CONCAT(yTx1, _NH2_VER, '/DBX/');						                  // CPU=2000log file
					CASE wh2 OF
						1:	// create export cib file 
							fDhh:=TRUE; suffix:=TRUE; fN:='cib'; 						
						2:	// create wrk file at the beginning of the recording backup RBx->file 'NH2/002/2025_01/25_1030.DBX';	// new backup file
							yTx2 	:= yTx1;																			// dest path for dbx.wrk
							yTx1	:= CONCAT(aSys.DiskHed.Disk[1].path, 'dbx.wrk');					// NH2/dbx.wrk
							fDhhTx2:=TRUE; suffix:=TRUE; fN:='DBX'; write:=TRUE; 						// insert path to yTx2 + suffix and write to dbx.wrk
					END_CASE;
				2:	yTx1 	:= CONCAT(yTx1, 'LOG/MSG/');						
				3:	yTx1 	:= CONCAT(yTx1, 'LOG/ALA/');						
				4:	yTx1 	:= CONCAT(yTx1, 'LOG/EVN/');						
				5:	yTx1 	:= CONCAT(yTx1, 'LOG/HET/');						
			 100: // log NAME
				


			END_CASE;
	 	23: // SDC
				yTx1 	:= CONCAT(aSys.DiskHed.Disk[3].path, 'TST/');					               // test copy for faster run  
				RETURN;
	 	24:	// RAM
			yTx1 	:= CONCAT(aSys.DiskHed.Disk[4].path, 'FRM/');					                  // FRM copy for faster run
			RETURN;
	END_CASE;
(*
	IF restart THEN
//		write := true;
		yTx2 	 := CONCAT(yTx2,DT_TO_STRINGF(aSys.NhDT,'%TYY_MM_DD/')); 		// data kazdeho CFG);
      aSys.ADR_DBX := yTx2;
	END_IF;
 *)
	IF month THEN						// add month dir
		txt	:= CONCAT(USINT_TO_STRINGF(aSys.YEAR, '20%02d'),'_',USINT_TO_STRINGF(aSys.MONTH, '%02d'),'/');
		IF fDhhTx2 THEN						// add day+time file	
			yTx2 	:= CONCAT(yTx2, txt); // data kazdeho CFG);									// formulare			
		ELSE		//ELSIF fDhh THEN
			yTx1 	:= CONCAT(yTx1, txt); // data kazdeho CFG);									// formulare			
		END_IF;
	END_IF
	IF fDhh OR fDhhTx2 THEN						// add day+time file	
		txt := CONCAT(USINT_TO_STRINGF(aSys.DAY, '%02d'),'_',DT_TO_STRINGF(aSys.NhDT, '%Thhmm'));
		IF fDhhTx2 THEN						// add day+time file	
			yTx2 	:= CONCAT(yTx2,txt ); 	
		ELSE
			yTx1 	:= CONCAT(yTx1, txt ); // add 'day_hhmm'		
		END_IF;
	END_IF	
	IF suffix THEN						// add suffix
		IF fDhhTx2 THEN						// add day+time file	
			yTx2 	:= CONCAT(yTx2, '.',fN); 	
		ELSE
			yTx1 	:= CONCAT(yTx1, '.',fN); 	
		END_IF;
	END_IF;
	IF write THEN
		_Nh1RowTxt(write := TRUE); 				// write yTx2 to file xTx1 + add 'CFLF'
	ELSIF read THEN
		_Nh_Log_Path := _Nh_Line_RW(fH := fH, mode := 0, Read255 := 1, fExist := 1);
	END_IF;
END_FUNCTION


FUNCTION _Nh_Create_DIR_PATH: BOOL // check OR create DIR in the entire path
	VAR_INPUT
      disk:    USINT;   // 1=NH2,2=USB,3=SDC,4=RAM
		wh:      USINT; 	// 21=NH2,22=USB,23=SDC,24=RAM
		frm:     UINT; 	
	END_VAR
	VAR_TEMP
      create :   BOOL; 
		i: USINT;
	END_VAR
	rb		:= _Nh_Log_Path(wh := wh, frm := frm);											// path to yTx1
	yTxA	:= yTx1;																		// _Nh1RowTxt replace yTx1, yTxA maps  to free mem

	IF FileExists( fileName := yTxA) THEN
      _Nh_Create_DIR_PATH  := TRUE;
//	ELSIF CPU_CODE >= 2000 THEN																// CP-2000 create DIR in one step
	ELSIF FALSE THEN																		
		_Nh_Create_DIR_PATH  := ForceDirs(fileName := yTxA);
		create               := true;																		// exist
	ELSE																					// CP-1000 must create DIR step by step
		create               := true;																		// exist
 		_Nh_Create_DIR_PATH  := TRUE;		
		yTxc	:= '';																		// postupne sa bude skladat cesta
		FOR i := 1 TO LEN( yTxA ) DO
		 	yTxB	:= MID( yTxA, 1, i );													// extract	next char
			yTxC	:= CONCAT( yTxC, yTxB );												// ads next char
		 	IF yTxB = '/' THEN 																// ebd of dir
				IF FileExists( fileName := yTxC) THEN										// test if exist
					;
				ELSIF DirCreate( dirName := yTxC ) = FALSE THEN								// create dir universal method CP1000 and CP2000
					_Nh_Create_DIR_PATH := FALSE;
					EXIT;
				END_IF
			END_IF;
		END_FOR;
		yTxA := yTxC;
	END_IF;
	IF _Nh_Create_DIR_PATH = FALSE THEN
		aSys.DiskHed.Disk[disk].errCrDir	:= GetLastErrTxt(errCode := GetLastErr(), errMessage := yTx2);
		yTx2	:= CONCAT(USINT_TO_STRING(disk), ' Err Create DIR: ',yTxC, ' of ',yTxA, ' Err: ', yTx2);
		rb:=_NhSysLogMsg(msg:=yTx2);
//	 	rb		:= _Nh1RowTxt(logRst := 1, adTime := 3);
   ELSIF create THEN
		yTx2	:= CONCAT(USINT_TO_STRING(disk), ' Create DIR  Ok: ',yTxA );
   ELSE
		yTx2	:= CONCAT(USINT_TO_STRING(disk), ' Test DIR    Ok: ',yTxA );
	END_IF;
	rb:=_NhSysLogMsg(msg:=yTx2);
//	rb		:= _Nh1RowTxt(logRst := 1, adTime := 3);
END_FUNCTION


FUNCTION_BLOCK _Nh_Create_DIR_FB  // create all DIRs in the entire path and writes info in aSys.DiskHed
	VAR_INPUT
		exec:       BOOL; // leading edge start new write/read. if a process is running, interrupt it and close the file
	END_VAR
	IF SYSTEM_S.USB_DISK_READY <> SYSTEM_S.IS_USB_DISK THEN
cc:=cc+1;	
	END_IF;


	aSys.DiskHed.USB_Ready(In:=SYSTEM_S.USB_DISK_READY);
	IF aSys.DiskHed.USB_Ready.Qx  THEN
 		IF aSys.DiskHed.USB_Ready.Qr THEN
   			yTx2 	:= 'USB Inserted';													// START Create Dir
        ELSE
   			yTx2 	:= 'USB REmoved';													// START Create Dir
	 	END_IF;
   	yTx2 	:= CONCAT(yTx2, ' !!! Re-Create Dir..');
		rb:=_NhSysLogMsg(msg:=yTx2);
//		IF fb_Nh_Copy_Dir.busy = FALSE THEN
//			exec	:= true;
//		END_IF;
	END_IF;
	IF exec THEN												// start
      err		:= FALSE;
      exec     := FALSE;
   	_NhDT    := GetRTC();      
		aSys.DiskHed.Disk[1].path	:= '';
		aSys.DiskHed.Disk[2].path	:= 'USB/';
		aSys.DiskHed.Disk[3].path	:= 'SDC/';
		aSys.DiskHed.Disk[4].path	:= 'RAM/';
      FOR i := 1 TO 4 DO
         rb	:= DiskInfo(diskName          := aSys.DiskHed.Disk[i].path, diskDesc := aSys.DiskHed.Disk[i].info); // bytes
         aSys.DiskHed.Disk[i].errCrDir    := FALSE;      
			aSys.DiskHed.Disk[i].Exist       := aSys.DiskHed.disk[i].Info.TotalNumberOfKBytes > 0;
         aSys.DiskHed.Disk[i].freeSpace   := 0;    
         IF aSys.DiskHed.Disk[i].Exist THEN
   			aSys.DiskHed.Disk[i].freeSpace   := REAL_TO_USINT( 100.0 * 
                                                               UDINT_TO_REAL(aSys.DiskHed.disk[i].Info.TotalNumberOfFreeKBytes) / 
                                                               UDINT_TO_REAL(aSys.DiskHed.disk[i].Info.TotalNumberOfKBytes) ); 
         END_IF
      END_FOR;

      // base dir NH2/ od native journaled disk
		aSys.DiskHed.Disk[1].path	:= 'NH2/';
		err := _Nh_Create_DIR_PATH( disk:=1, wh := 21, frm := 1) = FALSE; 	// create


	aSys.DiskHed.Disk[3].Exist :=false;

		// test if exist real USB/ next substitute USB/ to SDC/ or NH2/
      IF aSys.DiskHed.Disk[2].Exist THEN												// disk USB NOT inserted
         ;
      ELSIF aSys.DiskHed.Disk[3].Exist THEN
         aSys.DiskHed.disk[2]       := aSys.DiskHed.disk[3];      
         aSys.DiskHed.Disk[2].Exist := FALSE;
      ELSE 
         aSys.DiskHed.disk[2]       := aSys.DiskHed.disk[1];      
         aSys.DiskHed.Disk[2].Exist := FALSE;
      END_IF
      // create DBX and all LOG dirs
		FOR delay := 1 TO 5 DO															
			err := err OR _Nh_Create_DIR_PATH( disk := 2, wh := 22, frm := delay) = FALSE; 								
		END_FOR;

      // test if exist real SDC/
      IF aSys.DiskHed.Disk[3].Exist = false THEN
         aSys.DiskHed.disk[3]       := aSys.DiskHed.disk[1];
			aSys.DiskHed.Disk[3].Exist	:= false;
		END_IF;	
		err := err OR _Nh_Create_DIR_PATH( disk := 3, wh := 23, frm := 1) = FALSE;
      IF aSys.DiskHed.Disk[4].Exist = false THEN
         aSys.DiskHed.disk[4]       := aSys.DiskHed.disk[1];
			aSys.DiskHed.Disk[4].path 	:= CONCAT(aSys.DiskHed.disk[4].path, _NH2_VER, '/');	// if not exist, then substitute to NH2/200/.  only for FRM/	
			aSys.DiskHed.Disk[4].Exist	:= false;
		END_IF;	
		err := err OR _Nh_Create_DIR_PATH( disk := 4,wh := 24, frm := 1) = FALSE;

   	aSys.DiskHed.timeExec   := TIME_TO_UINT ( SUB_DT_DT( GetRTC() , _NhDT ) );
	END_IF;
END_FUNCTION_BLOCK



(*
FUNCTION _Nh_Create_DIR: BOOL // check OR create DIR in the entire path
	VAR_INPUT
      Go: USINT;
	END_VAR
	_Nh_Create_DIR		:= TRUE;
   	err 			:= FALSE;
	aSys.DiskHed.run	:=	FALSE;
// yTx1 := _Nh_ADR_ROT;
   IF FileExists( fileName := aSys.DiskHed.Disk[1].path) = FALSE THEN
      rb := DirCreate(dirName := aSys.DiskHed.Disk[1].path);
   END_IF;
   aSys.DiskHed.Disk[1].Ready := TRUE;




// rb := DiskInfo(diskName := yTx1, diskDesc := aSys.Size_ROT_DISK); // bytes
	_Nh_DiskInfo(disk := 1);
   yTx1		:= 'RAM/';			 											 // bude skusat pre CP-2000
   IF FileExists( fileName := yTx1) THEN
      aSys.DiskHed.Disk[4].path 	:= yTx1;	 // RAM/
      aSys.DiskHed.Disk[4].ready := TRUE;
   ELSE
      aSys.DiskHed.Disk[4].ready := TRUE;
      aSys.DiskHed.Disk[4].path 	:= CONCAT(aSys.DiskHed.Disk[1].path, _NH2_VER, '/');	 // NH2/200/
      yTx1		 := '';
   END_IF;
// rb := DiskInfo(diskName := aSys.ADR_RAM, diskDesc := aSys.Size_RAM_DISK); // bytes
	_Nh_DiskInfo(disk := 4);
   yTx1		:= 'SDC/';			 											 // bude skusat pre CP-2000
   IF FileExists( fileName := yTx1) THEN
      aSys.DiskHed.Disk[3].ready := TRUE;
      aSys.DiskHed.Disk[3].path	:= yTx1;	 // SDC/
   END_IF;
   yTx1		:= 'USB/';
   aSys.DiskHed.Disk[2].ready	:= FALSE;	 // USB/
   IF FileExists( fileName := yTx1) THEN
      aSys.IS_USB_DISK.Q 	:= TRUE;
      aSys.IS_USB_DISK.In 	:= TRUE;
      aSys.DiskHed.Disk[2].path	:= yTx1;	 // USB/
      aSys.DiskHed.Disk[2].ready	:= TRUE;	 // USB/
   ELSIF aSys.DiskHed.Disk[3].ready THEN
      aSys.DiskHed.Disk[2].path	:= aSys.DiskHed.Disk[3].path;	 // SDC/
   ELSE
      aSys.DiskHed.Disk[2].path	:= CONCAT(aSys.DiskHed.Disk[1].path, yTx1); // NH2/USB/
   END_IF;
// rb := DiskInfo(diskName := aSys.ADR_USB, diskDesc := aSys.Size_USB_DISK); // kiloBytes
	_Nh_DiskInfo(disk := 2);
   IF aSys.DiskHed.Disk[3].ready = FALSE THEN // when no SDC
      aSys.DiskHed.Disk[3].path := aSys.DiskHed.Disk[2].path;	 // SDC/
   END_IF;

// rb := DiskInfo(diskName := aSys.ADR_SDC, diskDesc := aSys.Size_SDC_DISK); // bytes
	_Nh_DiskInfo(disk := 3);


   WHILE Go > 0 DO
	 exec := FALSE;
      CASE Go OF
         1: // only 'NH2/004/FRM'
            exec := _Nh_Log_Path(wh := 1, fN := 'FRM');
				IF aSys.DiskHed.Disk[4].ready THEN
			 	Go	:= 2;
				ELSE
			 	Go	:= 10;
				END_IF;
         2: // run faster directories 		RAM/FRM/
  	 	exec := _Nh_Log_Path(wh := 4, fN := 'FRM', write := TRUE);
			 IF aSys.DiskHed.Disk[3].ready THEN // when no SDC
			 	Go	:= 3;
         	ELSE
			 	Go	:= 10;
         	END_IF;

         3: // SDC/
				Go	:= 10;

        10: // ads 'USB/004/25011318/' or 'NH2/USB/25011318/'		YYMMDDhh
			 exec	 := _Nh_Log_Path(wh := 10, fn := 'DBX', write := TRUE);
            Go	:= 11;
        11: // 'WWW/LOGS/'
            yTx2 := 'WWW/LOGS/';
			 exec	 := TRUE;
  			 Go	:= 20;

        20: // /NH2/USB/
            yTx2 := aSys.DiskHed.Disk[2].path;
			 exec	 := TRUE;
  			 Go	:= 21;
        21: // start all MONTHLy directories
		 exec	 := _Nh_Log_Path(wh := 2, fN := 'HET', write := TRUE, month := TRUE);	// LOG/HET/RRRR.MM
			 Go	:= 22;
        22: // LOG/HET/RRRR.MM Created,
			 exec		:= _Nh_Log_Path(wh := 2, fN := 'HEV', write := TRUE, month := TRUE);	// LOG/HEV/RRRR.MM
			 Go	:= 23;
        23: // LOG/HEV/RRRR.MM Created, next HEV
			 exec		:= _Nh_Log_Path(wh := 2, fN := 'ALA', write := TRUE, month := TRUE);	// LOG/ALA/RRRR.MM
			 Go	:= 50;
   	 50: // special directories
	 		Exec		:= _Nh_Log_Path(wh := 2, fN := 'EVN', write := TRUE, month := TRUE);			// LOG/EVN/RRRR.MM	komplet vsetky udalosti
		 	Go	:= 51;
   	 51: // special directories
	 		Exec		:= _Nh_Log_Path(wh := 2, fN := 'MSG', write := TRUE, month := TRUE);			// LOG/MSG/RRRR.MM	vyslane/prijate spravy
		 	Go	:= 255;
   	 53: // special directories

      ELSE
				go := 0;
				;
      END_CASE;
      IF exec THEN
     		IF CPU_CODE >= 2000 THEN
	 		IF ForceDirs(fileName := yTx2) THEN
               exec := FALSE;
   			END_IF;
         END_IF;
      END_IF;
      IF exec THEN
			exec	:= FALSE;
         ix := FIND(yTx2, _Nh_CRLF);
         IF ix > 0 THEN
      		yTx3	:= LEFT(yTx2, ix - 1);
         ELSE
      		yTx3	:= yTx2;
         END_IF;
         yTx4 := '';
   		WHILE TRUE DO
				ix := FIND(yTx3, '/');
				IF ix > 0 THEN
               yTx2 := LEFT(yTx3, ix);
					yTx4 	:= CONCAT(yTx4, yTx2);
					yTx3	:= DELETE(yTx3, ix, 1);
					IF FileExists(fileName := yTx4) THEN
						;
					ELSIF DirCreate(dirName := yTx4) THEN
						;
	 		ELSE
						err := TRUE;
						EXIT;
					END_IF;
				ELSE
					EXIT;
				END_IF;
   		END_WHILE;
      END_IF;
		IF err THEN
			rb := GetLastErrTxt(errCode := GetLastErr(), errMessage := yTx2);
      	rb := _Nh1RowTxt(logRst := 1, adTime := 3);
			go		:= 255;
		ELSE
//			go		:= goNext;
		END_IF;
   END_WHILE;
	IF aSys.restart THEN
 		yTx2 := CONCAT(' *** RESTART: ', USINT_TO_STRING(aSys.LastRstTyp), ' *** ');
      rb := _Nh1RowTxt(logRst := 1, adTime := 3, EmpRow := 1); // , write:=TRUE);
// rb := _Nh1RowTxt(logRst:=1, adTime:=3, EmpRow:=1, write:=TRUE);
		yTx2 		:= 'OK Create ALL Dir';													// START Create Dir
  		rb 	:= _Nh1RowTxt(logRst := 1);
	END_IF;
END_FUNCTION
 *)



FUNCTION_BLOCK _Nh_Copy_DIR // copy file or directory
	VAR_INPUT
		go: 		   USINT;			// 1=copy file, 2=copy dir and next case run 
		IniEnd: 	   USINT;			// when ends set the case of main 
		IniErr: 	   USINT;			// when error set the case of main
		IniRun: 	   USINT := 255;	// when start set the case of main
		copy: 		BOOL := TRUE;	// copy:=false => delete after copy (move)
		file: 		BOOL := TRUE ;	// dir or file
    	exec: 		BOOL; 			// leading edge start new write/read. if a process is running, interrupt it and close the file
		init: 		BOOL;			   // only open files an prepare for run on the next call
	END_VAR
   VAR_OUTPUT
     	done: 		BOOL; 			// action is done
     	busy: 		BOOL; 			// action in progress
     	err: 		   BOOL; 			// error flag
     	errID: 		UDINT; 			// error number
     	size: 		UDINT; 			// data length {it is entered at the beginning and cannot be changed after that !!!}
     	actSize: 	UDINT; 			// really written
		cycSize: 	UDINT; 		 	// actualy Size per cycle
		cyc: 		   UINT;			// number of cycles 
		files: 		UINT;
		allSize: 	UDINT;
		_NhFileInfo: TFileInfo;
   END_VAR
   VAR
		hDir: 		HANDLE;
      hSrc: 		HANDLE;
      hDst: 		HANDLE;
      hLog: 		HANDLE;
	 	adrVar: 	   UDINT; // adresa: variable/Ram/Dbx address {it is entered at the beginning and cannot be changed after that !!!}
		GoNext: 	   USINT;
   END_VAR
	done	:= FALSE;
	CASE Go OF

     	0: RETURN;
     	1: // copy file
			// ytx3,yTx4 contain both source and destination files, including the path
			aSys.Ini	:= IniRun;
			files		:= 0;
			allSize	:= 0;
			file		:= TRUE;
			IF CPU_CODE >= 2000 THEN
				IF ForceDirs(fileName := yTx4) = FALSE THEN
					yTx2	:= yTx4;
					Go		:= 80;
					RETURN;
				END_IF;
			END_IF;
			Cyc      := 0;
         exec		:= TRUE;
			GoNext 	:=	99;                                                         // next cyccle                                  

     	2: // Start copy DIR + first file
			// ytx3,yTx4 contain only the source and destination directories without the file
			aSys.Ini	:= IniRun;
			files		:= 0;
			allSize	:= 0;
			file		:= FALSE;                                                      // it  is DIR
			hDir		:= DirOpen(dirName := yTx3, dirInfo := _NhFileInfo);           // open DIR for read
			IF hDir = INVALID_HANDLE_VALUE THEN                                     // open error
				yTx2	:= yTx3;
				Go		:= 80;
				RETURN;
			ELSIF FileExists(fileName := yTx4) THEN	;                             // test if exist
			ELSIF CPU_CODE >= 2000 THEN
				IF ForceDirs(fileName := yTx4) = FALSE THEN
					yTx2	:= yTx4;
					Go		:= 80;
					RETURN;
				END_IF;
			ELSIF DirCreate(dirName := yTx4) 	THEN	;
			ELSE
				yTx2	:= yTx4;                                                       // create text error
				Go		:= 80;
				RETURN;
			END_IF;
			Cyc      := 0;
         exec		:= TRUE;                                                       // go directly for first file
 			GoNext	:= 12;                                                         // next cyccle

    	12: // Next file in copy DIR

			IF DirRead(hDir := hDir, dirInfo := _NhFileInfo) = FALSE THEN
				rb		:= _Nh_Log_Path(wh := 6);																	// only log DIR {to yTx3}
				yTx2	:= CONCAT('End of dir. f:', UINT_TO_STRING(files), ' s: ', UDINT_TO_STRING(allSize) ) ;
	 		   _Nh_Line_RW(mode := 2, fH := hLog, LineLen := 0);
				Go		:= 99;
				RETURN;
			END_IF;
			exec	:= TRUE;

	 	80:	// Error
			err := TRUE;
			IF errID = 0 THEN
	 			errID := GetLastErr();
			 	GetLastErrTxt(errCode := errID, errMessage := yTx1);
				yTx2	:= CONCAT('err: ', UDINT_TO_STRING(errID), ' msg: ', yTx1, ' f: ', yTx2);
			ELSE
				yTx2	:= CONCAT('err: ', UDINT_TO_STRING(errID), ' 3: ', yTx3, ' 4: ', yTx4);
			END_IF;
			rb		:= _Nh_Log_Path(wh := 6);															// yTx1 	:= CONCAT(aSys.ADR_RAM,'_CopyDir.log');
			_Nh_Line_RW(mode := 2, fH := hLog, LineLen := 0);
         Go    := 99;
			RETURN;

	   99:	// End
			rb		:= _NhFClose(fH := hDir, dir := TRUE);
     		IF copy = FALSE AND err = FALSE THEN								               // delete source file/dir
	 			IF file THEN                                                            // delete file       
					_Nh_Line_RW(mode := 0, fH := hLog, LineNbr := 1);
   	  			IF file THEN
						yTx2	:= CONCAT('Delete file: ', yTx2) ;
					ELSE
		 				rb 	:= DirDelete(dirName := yTx2);
						yTx2	:= CONCAT('Delete dir: ', yTx2) ;
					END_IF;
					_Nh_Line_RW(mode := 2, fH := hLog, LineLen := 0);
				END_IF;
			END_IF;
     		rb 	 		:= _NhFclose(fH := hSrc);
     		rb 			:= _NhFclose(fH := hDst);
     		rb 			:= _NhFclose(fH := hLog);
			Go 			:= 0;
			GoNext 		:=	0;
			Done 		:= TRUE;
			Busy		:= FALSE;
			IF err THEN
				aSys.Ini	:= IniErr;
			ELSE
				aSys.Ini	:= IniEnd;
			END_IF;
			RETURN;

	   254: ; // TST
			   RETURN;

	   255: ; // running;


	   ELSE // non-defined
		   	aSys.Ini	:= IniRun;
			   Go 		:= 99;
			   RETURN;
   END_CASE;
   IF exec THEN
      aSys.Ini	:= IniRun;
		exec 	:= FALSE; done := TRUE; busy := FALSE; err := TRUE; errID := 0; actSize := 0;
	   IF Go < 10 THEN																	            // start copy file/Dir
			rb		:= _Nh_Log_Path(wh := 6);															// LOG copy
   		yTx2  := yTx3;	_Nh_Line_RW(mode := 1, fH := hLog, new := TRUE, close := TRUE);
   		yTx2  := yTx4;	_Nh_Line_RW(mode := 2, fH := hLog);
		END_IF;
		IF goNext = 12 THEN
   		_Nh_Line_RW(mode := 0, fH := hLog, LineNbr := 1);	yTx3	:= CONCAT(yTx2, _NhFileInfo.fileName);
   		_Nh_Line_RW(mode := 0, fH := hLog, LineNbr := 2);	yTx4	:= CONCAT(yTx2, _NhFileInfo.fileName);
			yTx2	:= CONCAT(_NhFileInfo.fileName, ' ', UDINT_TO_STRING(_NhFileInfo.fileSize));
   		_Nh_Line_RW(mode := 2, fH := hLog, LineLen := 0);
		END_IF;
      IF _NhFopen(fN := yTx3, fH := hSrc , mode := 0) THEN 	// open source file
			size	:= FileSize(hFile := hSrc);
			IF _NhFopen(fN := yTx4, fH := hDst , mode := 1) THEN 	// open dest file
				done 		:= FALSE; busy := TRUE; err := FALSE;
				adrVar 	:= PTR_TO_UDINT( ADR(mObr) ) ;							// wrk mem used for copy
			ELSE
				errID	:= 900002;
			END_IF;
		ELSE
			errID	:= 900001;
		END_IF;
		Go 		:= 255;
		IF init THEN																		// only prepare open files/dirs
			init	:= FALSE;
			IF busy THEN
				RETURN;																		// if not Err
			END_IF;
		END_IF;
   END_IF;

   IF busy THEN
      cyc := cyc + 1;
		IF aSys.mSecMax > aSys.mSecLimit THEN
			cycSize := 512;
		ELSE
			cycSize := _NH_CLUSTER;
		END_IF;
		cycSize 	:= MIN(size - actSize, cycSize);
		fRW 		:= FileRead( hFile := hSrc, adrBuf := adrVar, size := cycSize);
		fRW 		:= FileWrite(hFile := hDst, adrBuf := adrVar, size := fRW);
     	actSize 	:= actSize + fRW; // actual read/write size
		IF actSize = size THEN
        	done := TRUE;
      ELSIF fRW <> cycSize THEN // the request did not proceed correctly
         done 	:= TRUE; err := TRUE; errID	:= 900003;
		END_IF;
	END_IF;
   IF done THEN
      rb 	   := _NhFclose(fH := hSrc);
      rb 	   := _NhFclose(fH := hDst);
		allSize	:= allSize + actSize;
		files		:= files + 1;
      IF err THEN
			GoNext	:= 80;
			files		:= 0;
		ELSIF copy = FALSE THEN
			_Nh_Line_RW(mode := 0, fH := hLog, LineNbr := 1);
			IF file = FALSE THEN
				yTx2	:= CONCAT(yTx2, _NhFileInfo.fileName);
			END_IF;
			rb 	:= FileDelete(fileName := yTx2);
      END_IF
		Go 	:= goNext;
		done	:= FALSE;
   END_IF;
END_FUNCTION_BLOCK

VAR_GLOBAL
	fb_Nh_Copy_DIR			: _Nh_Copy_DIR;
END_VAR


FUNCTION _Nh_LVL_100 {HIDDEN}: REAL // vypocita LVL 0..100 a koriguje o Minimum a Maximu
   VAR_INPUT
 		lvlIn: REAL; 	// hodnota 0..100
   	lvlMin: USINT := 10; 	// minimum 0..100
   	lvlMax: USINT := 100; // maximum 0..100
   END_VAR
   _Nh_LVL_100 := ( USINT_TO_REAL(lvlMin) + lvlIn * ( USINT_TO_REAL(lvlMax - lvlMin) / 100.0 )) * BOOL_TO_REAL(lvlIn > 0.0) ; // minimum + skorigovany LVL

// _Nh_LVL_100 := USINT_TO_REAL(lMin) + LVL*( USINT_TO_REAL(lMax-lMin)/254.0 ); // minimum + skorigovany LVL
// _Nh_LVL_100 := _Nh_LVL_100/2.54 * BOOL_TO_REAL(LVL > 0.0); // prevod na 0..100 len ked je VAL > 0
//	_Nh_LVL_100	:= ( vr + xDev^.al.ou.val * (kr - vr) / 100.0) * BOOL_TO_REAL(xDev^.al.ou.val > 0.0) ;
END_FUNCTION

FUNCTION _Nh_255_100 {HIDDEN}: REAL
   VAR_INPUT
      lvl: USINT;
   END_VAR
// _Nh_255_100 := FLOOR( USINT_TO_REAL(LVL)/2.54 );
   _Nh_255_100 := USINT_TO_REAL(LVL);
END_FUNCTION

FUNCTION_BLOCK _Nh_PWM {HIDDEN} // Blikac / Pulsne sirkova modulace
   VAR_INPUT
      Per: UINT; // perioda modulace [ms] (50-56000)
      Pls: USINT; // sirka pulsu [%] (0-100% z periody)
      Run: BOOL; // povolovaci vstup
   END_VAR
   VAR_OUTPUT
      Q: BOOL; // priznak zmeny vystupu
      Out: BOOL; // vystup
      et: UINT; // zostavajuci cas do konca periody [ms]
   END_VAR
   VAR
   END_VAR
   Q := FALSE;
   IF Run = FALSE THEN // je spusteny blikac
      et := 0;
      IF Out THEN // ak prisiel stop (run=0) v priebehu trvania impulzu, vystup mohol byt zapnuty
         Out := FALSE; // finalne vypne vystup
         Q := TRUE;
      END_IF;
   ELSIF et = 0 THEN // start
      et := MAX(50, Per);
      IF pls > 0 THEN // zapne sa len ked ma nejake trvanie
         Out := TRUE;
         Q := TRUE;
      END_IF;
   ELSE
      et := et - MIN(et, aSys.mSec);
      IF et > 0 AND Out AND pls < 100 THEN
         IF et <= REAL_TO_UINT( UINT_TO_REAL(per) * 0.01 * USINT_TO_REAL(100 - pls)) THEN // zostavanic cas je meni ako doba vypnutia (100-pls)
            Out := FALSE;
            Q := TRUE;
         END_IF;
      END_IF;
   END_IF;
END_FUNCTION_BLOCK


FUNCTION_BLOCK _Nh_Blik_FB {HIDDEN}
	VAR_INPUT
		wht: USINT;				// perioda
      nbr: USINT; // pocet zablikani
		RunOn: BOOL; // zapnut
		// future
//		RunOff: BOOL;
//		EndOn: BOOL;
//		EndOFF: BOOL;
   END_VAR
   VAR_OUTPUT
      Q: BOOL; // vystup
      Qi: BOOL; // zmena ON-OFF-ON
		Qn: BOOL; 		// imp. pri dosiahnuti poctu zaplikani
   END_VAR
   VAR
// Qr: BOOL;
      Qo: BOOL;
   END_VAR
	CASE wht OF
   	 0: Q	:= 0;
				RETURN;
		 1: Q := SYSTEM_S.PERIOD_PULSE_1SEC;					// kazdu sec
		 2: Q := SYSTEM_S.PERIOD_PULSE_10SEC;					// kazdych 10S pravidelne
		 3: IF Q THEN													// 10s je zapmute a 1s vypnute
					IF SYSTEM_S.R_EDGE_10SEC THEN
					 Q := FALSE;
					END_IF;
	 			ELSIF SYSTEM_S.R_EDGE_1SEC THEN
					Q := TRUE;
		 		END_IF;
		 5: Q := SYSTEM_S.PERIOD_PULSE_500MS;					// kazdych 500ms
		 6: Q := SYSTEM_S.PERIOD_PULSE_1MIN;					// kazdu 1.Min
				// vlastne pulzy
		100: Q := aSys.PULSE_50MS;
		101: Q := aSys.PULSE_100MS;
		102: Q := aSys.PULSE_200MS;
	END_CASE;
   Qi := Q <> Qo;
   Qo := Q;
	Qn	:= FALSE;

	IF nbr = 0 THEN
		;
	ELSIF RunON THEN
		IF	Q THEN
			RunOn 	:= FALSE;
			Qi		 	:= TRUE;
		END_IF;
	ELSIF	Qi AND Q = FALSE THEN
		nbr 	:= nbr - 1;
		IF nbr = 0 THEN
			Qn		:= TRUE;
			wht 	:= 0 ;
		END_IF;
	END_IF;
END_FUNCTION_BLOCK



FUNCTION_BLOCK _Nh_Click_FB {HIDDEN}
   VAR_OUTPUT
		Q: BOOL; // vyhodnotenie {impulz alebo ak je press alebo hold, je signal az do ukoncenia)
		Qb: BOOL;										// ak bol pri vyhodnocovani jedenehi BTN stlaceny INY BTN
		Lock: BOOL;										// WSB je zalokovane = drzi sa viac ako 10s
		Click: USINT; 	// cislo clicku na OutBTN
		OutBtn: USINT; 	// vyhodnoteny btn = InBtn pri prvom stlaceni
	END_VAR
	VAR_INPUT
		InBtn: USINT; 				// stalceny nejaky btn v sekcii CLICK ... trva asi 8 cyklov, potom 0->1
      cfc: PTR_TO NH_CFG_CLICK; 				// zaciatok CFX je rovnaky pre vsetky
		BTNs: USINT := 6;
	END_VAR
 	VAR
		trg: aTrgQx;											// vyhodnoti Qr,Q,Qf
		tClk: DT;													// strojovy cas clicku
   	Go: USINT;
		et: USINT;
	END_VAR
	Q			:= FALSE;
	Qb			:= FALSE;
	Lock		:= FALSE;
	IF trg.Qr	THEN
		IF InBtn > 0 THEN
			i			:= InBtn;
		ELSE
			FOR i := 1 TO BTNs DO
				IF xPtB^ THEN
					EXIT;
				END_IF;
				xPtB := xPtB + 1;
   		END_FOR;
		END_IF;
		IF Go = 8 THEN
			IF i <> OutBtn THEN
				xDevOkA^.al.ou.cmd	:= OutBtn;
				xDevOkA^.al.ou.par	:= USINT_TO_INT(Click);
				Qb						:= TRUE;
				Click 				:= 0;
			END_IF;
		ELSE
			Click 				:= 0;
		END_IF;
		Go 					:= 9; 										// startuje sa vzdy 1
		OutBtn				:= i;
		tClk					:= GetRTC();									// zaciatok Clicku

//		_Nh_Log_Evn_ADD( tsk := aCfg[cf].tgrp, wht := 'BEG', tRtc := tClk);

		xDevOkA^.al.ou.Val := USINT_TO_REAL(i);
		xDevOkA^.ok.ref	:= TRUE;
		xDevOkA^.al.sta	:= 1;
	ELSIF trg.Q	THEN
		_NhTime := SUB_DT_DT( GetRTC() , tClk);
		IF _NhTime > T#11s THEN
			Lock 	:= TRUE;
			Go		:= 0;
		ELSE
			CASE Go OF
   	 0: // uz sa vyhodnotil Hold, alebo aj press pred Hold, caka sa len na pustenie BTN
      	 1: // prebieha press - posielaju sa udaje pre stmievanie ....
					Q	:= TRUE;
			 2:	// bezi cakacka na Hold - kedy sa dosiahne cas;
					IF SUB_DT_DT( GetRTC() , tClk) > USINT_TO_TIME(cfc^.Hold) * 100 THEN								// HW vyhodnotil Click, mal by byt na to BTN, ktory je prve spracovavany
						Click := 7;
						Q			:= TRUE;
						Go 		:= 0;
					END_IF;
	 	ELSE
				IF _NhTime >= USINT_TO_TIME(cfc^.Press) * 100 THEN // prvykrat sa dosiahol press
					IF cfc^.Press > 0 THEN // prvykrat sa dosiahol press
						Click := 6;
						Q			:= TRUE;
					END_IF;
					IF cfc^.Hold > 0 THEN // AND cfC^.BtnHold[Btn] // kontrola, ci nie je nadefinovany Hold
      	 	Go 	:= 2;
					ELSE
						Go		:= 1;
					END_IF;
   	 END_IF;
			END_CASE;
		END_IF;
	ELSIF trg.Qf	THEN
		IF Go = 9 THEN													// prve pustenie btn
			Click := Click + 1;
			IF Click > 4 THEN										// dosakol sa MAX pocet 5-Clickov
				Q 				:= TRUE;
				Go 			:= 0;
			ELSIF cfc^.Click = 0 OR cfc^.OneClck[OutBtn] THEN	// btn NE-bude vyhodnocovat dalsi click, potvrdi sa prvy
				Q 				:= TRUE;
				Go 			:= 0;
			ELSE
				tClk	:= GetRTC();									// zaciatok Clicku
				Go 	:= 8;
         END_IF;
			et := 20;
		ELSE 													// prebieha press alebo Hold
			et := 5;
			Go 	:= 0;
		END_IF;
	ELSIF Go = 8	THEN // cakacka na dalsi click
		IF SUB_DT_DT( GetRTC() , tClk) > USINT_TO_TIME(cfc^.Click) * 100 THEN								// HW vyhodnotil Click, mal by byt na to BTN, ktory je prve spracovavany
			Q				:= TRUE;
			Go 			:= 0;
		END_IF;
	ELSIF et > 0 THEN
		IF SYSTEM_S.R_EDGE_100MS THEN
			et := et - 1;
			IF et = 0 THEN
				xDevOkA^.al.ou.val 	:= 0.0;
				xDevOkA^.ok.ref		:= TRUE;
				xDevOkA^.al.sta		:= 0;
			END_IF;
		END_IF;
	END_IF;
	IF Q THEN
		xDevOkA^.al.ou.cmd	:= OutBtn;
		xDevOkA^.al.ou.par	:= USINT_TO_INT(Click);
	ELSIF Qb = FALSE THEN
		xDevOkA^.al.ou.cmd	:= 0;
	END_IF;
END_FUNCTION_BLOCK


VAR_GLOBAL
//	fb_Nh_Copy_Dir: _Nh_Copy_Dir;

	fbFileRWa: _Nh_File_RW;
//	fbFileRWb: _Nh_File_RW;
	fbLine: _Nh_File_Line;
//	fbBrwDir: _Nh_Brw_Dir;
END_VAR


