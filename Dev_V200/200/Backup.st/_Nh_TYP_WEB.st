
TYPE


   NH_TCH_WHT {HIDDEN} : STRUCT      				// HLAVNA RIADIACA PREMENNA
      n           : USINT;
      t           : ARRAY[0..5] OF NH_TCH;
   END_STRUCT;

  	NH_R_XY {HIDDEN} :  STRUCT 												
      xp          : INT := 0;                                // x-posuv celej strany
      yp          : INT := y1;                               // y-posuv celej strany
	END_STRUCT;

   NH_DSH_OBJ	{HIDDEN} :  STRUCT
      rws            : USINT;
      clm            : USINT;
	END_STRUCT;

   NH_DSH	{HIDDEN} :  STRUCT           		
		dsh 				: ARRAY[0..4] OF NH_DSH_OBJ := [
										( rws := 9,	clm := 1 ),				// home page
										( rws := 7,	clm := 1 ),          // browser - riadok
										( rws := 6,	clm := 2 ),          // brows - velky dash
										( rws :=14,	clm := 2 ),          // brows - maly dash
										( rws :=14,	clm := 1 )];         // brows - tenke riadky pre CHECK
	END_STRUCT;

  	NH_SLD_POD {HIDDEN} :  STRUCT     // struktura pre slider z viacerych casovych pointov
//  		edit		: BOOL;									// priznak editacie = blokuje zmenu dna typ.dni

		edit		: NH_DEV_CF;
      btn      : BOOL;                          // bol stlaceny btn na Typ_Day
      zom      : BOOL;                          // je vybraty bod a je vyvyseny
      tch      : BOOL;                          // bol tch nad tymto obewktom
      prs      : BOOL;                          // drzime objekt = pohybujeme sa
      Qf      	: BOOL;                          // pustime objekt - impulz
      idx      : BOOL;                          // preindexovat
      day      : USINT;                         // vybraty typovy den pri editacii
      tpr      : USINT;                         // pocet cyklov  vyhodnotenie press nad navesim
		WhtPoi	: USINT;									// pre HET,HEV 0..1
//      Zon      : USINT;                         // zona, s rodicovskym rozvrhom 0,1 =Home
      poi      : int;                           // cislo vety v aCfg[26]
      p        : SINT := -1;                    // pocet pouzitych pointov :                                 VYPOCITA SA
      x        : SINT := -1;                    // vybraty point pri presuvani                               pomocne pole
      cf       : NH_POD_CFG;
   END_STRUCT;

  	NH_BRW {HIDDEN} :  STRUCT 											 // m-stranka univerzalneho browsu
      r           : ARRAY[0.._RowBrw] OF NH_ROW;             // objekty browsu znamenaju jedno DEV. Ak ma iba jedne stlpec, tak vtedy je r aj riadok
      s           : ARRAY[0.._SldNbr] OF NH_SLD_DAT;
      xy          : NH_R_XY;                                 // treba urobit korekciu xy
      rw          : USINT;                                   // aktualne naplneny pocet riadkov
      ref         : BOOL;                                   // priznak refreshovania pre brw200
      kor         : BOOL;                        // priznak, ci uz boli korigovane zlozky x,y
(*
		// toto je pre kopirovanie	
		cf				: NH_DEV_IO;
      po          : NH_SLD_POD;
      cp          : NH_SLD_CPY;
      px          : NH_SLD_POX;
*)
	END_STRUCT;

  	NH_POD {HIDDEN} :  STRUCT 											 // m-stranka univerzalneho browsu
		// toto je pre kopirovanie	
//		cf				: NH_DEV_IO;
      po          : NH_SLD_POD;
      cp          : NH_SLD_CPY;
      px          : NH_SLD_POX;
	END_STRUCT;


 	NH_LVL  {HIDDEN} : STRUCT 		           	    // hlavicka a FILTER aktualneho browsu
      //pg          : USINT;                       // typ stranky 0=home,2=FAV,ROMS,CAT,ACT,
      obj         : USINT;                       // objekt/typ stranky podla _NhDefObj
      vaz         : USINT;                       // cislo vazieb
      Naz         : STRING[20];                  // nazov v hlavicke lelvel
      Fil         : NH_FIL;                      // fitre DEV
      rw1         : NH_DEV_IO;                  // co je v prvom riadku
      obd         : USINT;                       // cislo objektu, kde je dsh
      dsh         : USINT := 0;                  // typ dsh : 0=home page, 1-riadok,2=3x2,3=6x2,
      fdv         : USINT;                       // filter len na jedno DEV - pomozne pole pre zapamatanie aktualneho vyberu
      srt         : USINT;                       // sposob sortovania
      vis         : BOOL := true;                // visible (to co sa deje na stranke da prenasa do hardware)
      brw         : BOOL;                        // je browser, inak form
      chk         : BOOL;                        // tento browser ma namiesto FAV chck
      fvz         : BOOL;                        // filter na vazby v tomto browsesa vypisuju len priradene vazby (riadchy z chk=true) (ide sa priamo po vazbach)
      psn         : BOOL;                        // zobrazuju sa ikony k zabezpecovacke
//      lst         : BOOL;                        // setup list HET,VEN,SCL,ACL....
      blR         : BOOL;                       	// nefiltruje miestnosti - zablokuje rom aj odstrani ikonu miestosti zo spodneho menu
	END_STRUCT;

  	NH_CAN {HIDDEN} :  STRUCT 											// definicie USRA + FAV a canvas s dotykom
      usr         : USINT;                                  // prihlaseny user = cislo vety v aCfg[22]usr musi byt na zaciatku, lebo od naz sa maze browser
      sbj         : USINT := 1;                                // subjekt = cislo vety ZON  aCfg[3]
      UsrRight    : USINT;
      nIP         : USINT;                                  // cislo IP v ramci usra
      fav         : NH_DEV_IO;
      cat         : NH_WRK_CAT;
      trg         : aTrg;                                   // triger pre dotyk na CANVAS
		CatOk			: BOOL;												// uz bol urobeny zoznam cat
      hom         : BOOL;                                   // vyvolat cisty Homepage
      admin       : BOOL;
      Logout      : BOOL;                                      // priznak zobrazenia Logout
      tch         : NH_TCH;                                 // udalost od dotyky/podrzania....
      yk          : REAL := 1.0;                            // korekcia y//      can 			: TCanvasData4096;
      can 			: TCanvasData6144;

//      can 			: TCanvasData4096;
//      can 			: TCanvasData;
	END_STRUCT;

  	NH_IXB {HIDDEN} :  STRUCT 											 // definicia browsu
      ix1         : USINT;                                   // cislo indexu 1.naplnenej vety v browse bez offset
      ix2         : USINT;                                   // cislo indexu naplenenej poslednej vety ( riadku browsu = rws)
      idx         : USINT;                                   // pocet viet od ix0;
      ofs         : USINT;                                   // ofset 1.vety v poli indexov  [0...8,8][8...10,2] ... 0,8
      n           : USINT;                                   // pocet stranok (bodov navigatora)
      w           : USINT := 50;                             // rozostup medzi bodmi
      pg          : USINT;                                   // cislo aktualnej stranky
      x1          : INT;                                     // x-suradnica 1.bodu
      row         : NH_DSH_OBJ;                              // pocet riadkov a stlpcov pre browser
	END_STRUCT;

  	NH_M {HIDDEN} :  STRUCT 												 // m-stranka univerzalneho browsu
      // odtialto sa maze po prihlaseni
      naz         : STRING[20];                                // editovanie nazvu v hlavicke
      lvl         : USINT;                                     // level vnorenia
      lvp         : USINT;                                     // level + pg
      lng         : USINT;                                     // jazyk
      wht         : SINT;                                      // sposob ziskania dat do browsu
      iter        : SINT;                                      // iteracia
      delay       : UINT;                                      // cakanie medzi vykreslovanim (delay)
      new         : INT := -1;                                 // ND cislo pridaneho/najdeneho/vymazaneho riadka v ramci aCfg[cf]
      set         : BOOL;                                      // povolenie setup modu
      edt         : BOOL;                                      // prebieha editacia nazvu (tit)
      rgb         : BOOL;                                      // farba preRGB sa vybera aj cez slidery
      srt         : BOOL;                                      // moze preusporiadat riadky
      frm         : BOOL;                                      // aktivny vnoreny web iFrame (prekryje / deaktivuje can)
//      ref         : BOOL;                                      // prinak refreshu webu (ze prave bol refresh)
      htx         : USINT ;                                    // ktora webova stranka je zobrazena
      htt         : STRING; // := 'https://nachhouse.atlassian.net/secure/RapidBoard.jspa?rapidView=1&projectKey=NACH&selectedIssue=NACH-13' ;                             // webova adresa 'https:/www.nachhouse.sk'
      mno         : ARRAY[1..2] OF NH_OBJ_MNU;                 // zalohovanie horneho riadka pri editacii
      mnu         : ARRAY[0..3] OF NH_MNU;                    // menu
		lvd			: ARRAY[0..3] OF NH_LVL;						  // data jednotlivych vnoreni (level=lv)
      ixb         : ARRAY[0..1] OF NH_IXB;
      brw         : NH_BRW;                                   // brows
		pod			: NH_POD;
	END_STRUCT;

  	NH_WEB  {HIDDEN}:  STRUCT 			
		M			   : ARRAY[1.._Nh_WEB_M] OF NH_M;
      A           : ARRAY[1.._Nh_WEB_M] OF NH_CAN;
      nbr         : USINT;                         // ktory aWeb[nbr] je prave aktivny
      nrf         : USINT;								// actual count refresh display
      trg         : aTrg;
      Go          : BOOL;
	END_STRUCT;
(*
   NH_OBR_CFG {HIDDEN}:  STRUCT                 //
      obr   : INT   := 23;
      ob1   : INT   := 25;
      cl1   : USINT := 1;
      wht   : USINT := 3;                       // 0=nic sa nevykresli,1=obrazok,2=obrazok vo farebnom kruhu, 3=obrazok vo farebnom kruhu s gradientom
   END_STRUCT
   NH_OBR_STP {HIDDEN}:  STRUCT                 //
      obr   : USINT := 23;
      ob1   : USINT := 25;
    END_STRUCT

   NH_OBR {HIDDEN}:  STRUCT                 //
      dev   : ARRAY[1.._Nh_CFG] OF NH_OBR_CFG;
      cat   : ARRAY[1.._Nh_CAT] OF NH_OBR_CFG;
      stp   : ARRAY[1.._Nh_STP] OF NH_OBR_STP;
   END_STRUCT
*)

  	NH_CAT_DSC {HIDDEN}:  STRUCT 					// categorie
 		Name        : STRING[13];
      typ         : SINT := 125;                   // filter CAT=recno(), alebo ak je > 99 tak zoznam
      dev         : USINT;                          // filter dev alebo ak je > 99 tak zoznam
      obr         : USINT := 12;
      ob0         : USINT;
      ob1         : USINT;
      Dsc         : STRING[25];

	END_STRUCT;

  	NH_STP_DSC {HIDDEN}:  STRUCT 					// categorie
 		Name        : STRING[13];
//      typ         : USINT := 255;                   // filter CAT=recno(), alebo ak je > 99 tak zoznam
      typ         : SINT := 125;                   // filter CAT=recno(), alebo ak je > 99 tak zoznam
      dev         : USINT;                          // filter dev alebo ak je > 99 tak zoznam
      obr         : USINT := 23;
	END_STRUCT;

   NH_PG_HOME_XY {HIDDEN}:  STRUCT                 //
      x     : INT;
      y     : INT;
   END_STRUCT

  	NH_PG_HOME {HIDDEN}:  STRUCT                          // adresy objektov dash
     nD        :  SINT  := 8;                            // posledny riadok Dash (1..._nDash)
     nQ        :  SINT  := 6;                            // pocet objektov Quick menu v riadku rDash + 1
     rQ        :  SINT  := 10;                           // riadok pre Quick menu
     rW        :  SINT  := 11;                           // riadok pre pocasie
     Hom       :  NH_ROW_O;                              // home dash - domcek a vsetko kolo neho
     Dsh       :  NH_ROW_O;                              // definicia objektu 0 v riadku
     Qck       :  NH_ROW_O;                              //
     xy        :  ARRAY[0..8] OF NH_PG_HOME_XY;
//     xyDn      :  ARRAY[0.._RowObr] OF NH_PG_HOME_XY ;   // korekcie dash pri pohybe dolu
//     xyUp      :  ARRAY[0.._RowObr] OF NH_PG_HOME_XY ;   // korekcie dash pri pohybe hore
   END_STRUCT

   NH_TYPE_MNU	  {HIDDEN}    :  STRUCT 		               // definicia spodneho menu
      x        : ARRAY [1..6,3..8] OF INT :=                 // [pocet menu , suradnice ciala menu[3,4,5,6,7,8] ]
                        [           xc,          0,          0,          0,          0,             0,    // 1 x Mnu
                               xc-xz/2,    xc+xz/2,          0,          0,          0,             0,    // 2 x Mnu
                                 xc-xz,         xc,      xc+xz,          0,          0,             0,    // 3x menu
                            xc-xz/2-xz,    xc-xz/2,    xc+xz/2, xc+xz/2+xz,          0,             0,    // 4x menu
                               xc-xz*2,       xc-xz,        xc,      xc+xz,    xc+xz*2,             0,    // 5x menu (HOME)
                          xc-xz*2-xz/2,  xc-xz-xz/2,   xc-xz/2,    xc+xz/2, xc+xz+xz/2,  xc+xz*2+xz/2     // 6x menu (zakladne)
                         ];


      m        : ARRAY [0..31,0..2] OF INT :=              // [[typ menu], [fn,wh,cm]
                        [  0,  0,  0,                        //  0- nic
                          23, 24,  3,                        //  1-setup   DEV
                         120,121,  1,                        //  2-Casove udaje (oneskorene zapnutie/vypnutie, max.cas zapnutia)
                         122,123,  2,                        //  3-LEVEL
                          83, 84,121,                        //  4-tune LED predradnik
                         196,197,  7,                        //  5-Blikanie
                         121,125,  4,                        //  6-RGB-COLOR

                          61, 61, 10,                        //  7-HET/pv-TVE - teploty s obrazkom teploty
                         190,191, 12,                        //  8-HET     - rozdiely teplot pre kurenie
                         345,345, 11,                        //  9-TVE/KOT - uroven otvorenia ventilu
                         220,221, 13,                        // 10-HET/TVE/KOT - rucne
                         222,223, 14,                        // 11-HET - automatika (casove plany)
                          23, 24, 15,                        // 12-TVE - setup = typ ventilu
                          83, 84, 16,                        // 13-TVE - tune = parametre + tools + adaptacia/kalibracia
                         224,225, 20,                        // 14-TVE - tools / adaptacia + kalibracia
                         273,274,199,                        // 15-DaofWeek - nastavenie typu aktualneho dna

                         261,262, 31,                        // 16-ROL-veterna automatika
                         110,111, 32,                        // 17-ROL-kalibracia
                          83, 84, 33,                        // 18-ROL-pozicie/castune
                          23, 24, 34,                        // 19-ROL-setup
                         139,148, 35,                        // 20-ROL-vychod slnka

                          33, 34,  5,                        // 21-WSB play/Led/Setup
                         204,205,120,                        // 22-WSB-Led
                          23, 24,  6,                        // 23-WSB-setup
                          23, 24, 40,                        // 24-BRA-setup

                          83, 84, 23,                         // 25-VEN-tune
                         120,121,198,                         // 26-Systemovy cas, datum ...
                         311,311,122,                         // 27-TGL-Display - svietivost
                         311,311,123,                         // 28-TGL-display - nastavit co sa zobrazuje
                         345,345, 10,                         // 29 HET teploty s obrazkom predvolby
                          83, 84, 21,                        // 30 HET/TVE - regulacne odozvy teploty
                         348,348, 82                         // 31 priradit do ROM


                          ];

      mnu          : ARRAY [0..107,0..1] OF INT :=              // [[riadkovy vyber] [txt=cislo textu,cmd(k textu)]
                        [
                           // WSB - DEFAULT nestmievatelne   0
                           80,  0,                           //  Ziadna akcia
                           81,  2,                           //  prepnut ON/OFF
                           82, 14,                           //  zapnut ON-par
                           83, 10,                           //  vypnut OFF

                           // WSB - vseobecne     4
                           80,  0,                           //  Ziadna akcia
                           81,  2,                           //  prepnut ON/OFF
                           82, 14,                           //  zapnut-par
                           83, 10,                           //  vypnut OFF
                           84,  6,                           //  stmievat

                           // HET-kurenie         9
                           80,  0,                           //  Ziadna akcia
                          154, 31,                           //  Protimraz
                          155, 32,                           //  Utlm
                          156, 33,                           //  Normal
                          157, 34,                           //  Komfort
                          150, 30,                           //  Automatika

                           // BRA-37 brany        15
                           80,  0,                           //  Ziadna akcia
                          181,  2,                           //  Start/Stop
                          183,  3,                           //  Stop
                          178, 14,                           //  Nastavit poziciu
                           72, 51,                           //  Potvrdit zatvorene

                           // ROL-                20
                           80,  0,                           //  Ziadna akcia
                          181,  2,                           //  Start/Stop
                          180, 25,                           //  Natácatlamely
                          179, 10,                           //  vytiahnut hore lam otvorit
                          182, 11,                           //  zatiahnut dolu LAM zaklopit
                          188, 26,                           //  Lamely-otvorit
                          189, 27,                           //  Lamely-zaklopit
                          178, 14,                           //  nastavit poziciu

                           // ACT - stare         28
                           80,  0,                           //  Ziadna akcia
                          118, 14,                           //  Spustit

                           // SCN-aktivna ked     30
                          186,  0,                           //  Len jedno dev
                          185,  1,                           //  ked su vsetky DEV zapnute
                          187,  2,                           //  Manualne

                           // ZAS-typ spotrebica   33
                           91,  2,                           //  Neurceny spotrebic cat:=2
                           92,  1,                           //  Svietidlo cat:=1
                           94,  2,                           //  okruh/stykac
                           93,  5,                           //  Ohrievac
                           96,  4,                           //  Ventilator
                           95,  2,                           //  Nabijacia stanica
                          109,  2,                           //  Rezervovane

                           // WSB - SCENY         40
                           80,  0,                           //  Ziadna akcia
                           81,  2,                           //  prepnut ON/OFF
                           82, 14,                           //  zapnut na par
                           83, 10,                           //  vypnut OFF
                          159, 11,                           //  Zapnut na 100%
                           84,  6,                           //  Stmievat
                          183,  3,                           //  Rezerva -Stop


                           // HET - Vratit  na automatiku      47
                          348,  0,                           //  Nikdy
                          349,  1,                           //  po case
                          350,  2,                           //  Zmenou v automatike
                          351,  3,                           //  Na konci dna
                          352,  4,                           //  Zmenou typ.dna
                          353,  5,                           //  Zmenou fazy dna
                          354,  6,                           //  po datume
                          357,  7,                           //  Podla regulatora

                           // Bezny den - prepnut dalsi den      55
                          348,  0,                           //  Manuálne
                          356,  1,                           //  Podla¾a kalendára
                          210,  2,                           //  Od zajtra Podla¾a kalendára
                          211,  3,                           //  Od datumu Podla¾a kalendára
                          355,  0,                            //  rezerva

                           // Sviatok - vratit na bežný den      60
                          348,  0,                           //  Manuálne
                          356,  1,                           //  Podla¾a kalendára
                          351,  4,                           //  Na konci dna
                          349,  5,                           //  Po èase
                          354,  6,                           //  Po dátume
                          355,  0,                            //  rezerva

                           // Párty - vratit na bežný den      66
                          348,  0,                           //  Manuálne
                          351,  4,                           //  Na konci dna
                          349,  5,                           //  Po èase
                          354,  6,                           //  Po dátume
                          355,  0,                            //  rezerva

                           // Mimo domu - vratit na bežný den      71
                          348,  0,                           //  Manuálne
                          207,  7,                           //  Pri príchode
                          349,  5,                           //  Po èase
                          354,  6,                           //  Po dátume
                          355,  0,                            //  rezerva

                           // Dovolenka - vratit na bežný den      76
                          348,  0,                           //  Manuálne
                          207,  7,                           //  Pri príchode
                          349,  5,                           //  Po èase
                          354,  6,                           //  Po dátume
                          355,  0,                            //  rezerva

                           // Zobrazenie na display TGL      81
                           34,  0,                           //  Teplota miestnosti
                           35,  1,                           //  Vonkajsia teplota
                           36,  2,                           //  Vlhkost
                           46,  3,                           //  REgulovanu teplotu
                           38,  4,                           //  Reguloanu CO2
                           39,  5,                           //  Regulovanu vlhkost
                          355,  0,                           //  rezerva
                          355,  0,                           //  rezerva
                          355,  0,                            //  rezerva

                           // Kalibracia TECO ventilu      90

                          230,  0,                          // Prevádzkový režim             ;                              ;
                          231,  1,                          // Štart kalibrácie s adaptáciou ;                              ;
                          232,  2,                          // Adaptácia ventilu             ;                              ;
                          233,  3,                          // Chladnutie/Štart bez adapt.   ;                              ;
                          234,  4,                          // Zisujem polohu VYPNUTÉ       ;                              ;
                          235,  5,                          // Nastavujem ÚTLM               ;                              ;
                          236,  6,                          // Nastavujem NORMÁL             ;                              ;
                          237,  7,                          // Nastavujem KOMFORT            ;                              ;
                          237,  0,                          // rezerva

                           // ACT - nove         99
                           80,  0,                           //  Ziadna akcia
                           82, 14,                           //  zapnut na par
                           81,  2,                           //  prepnut ON/OFF
                          159, 11,                           //  Zapnut na 100%
                           83, 10,                           //  vypnut OFF
                           84,  6,                           //  Stmievat
                          180, 25,                           //  Natácatlamely
                          183,  3,                           //  Rezerva 1 -Stop
                          183,  3                           //  Rezerva 2 -Stop

                          ];

   END_STRUCT;

   NH_LIST_OBR	  {HIDDEN}   :  STRUCT 		

      ok       : ARRAY[0..1]      OF INT := [35,38];                                                                  // 0/1
      ko       : ARRAY[0..1]      OF INT := [38,35];                                                                  // 1/0
		man		: ARRAY[0..1]      OF INT := [220,221];                                                                // manual = ruka
      day      : ARRAY[0..1,0..4] OF INT := [139,141,143,145, 66, 140,142,144,146, 69 ];                              // Day/Evening/Night/Morning/Lock
      day2  	: ARRAY[0..1,0..3] OF INT := [139,141,143,145,
															140,142,144,146];                              // Day/Evening/Night/Morning
      Lck2  	: ARRAY[0..1,0..3] OF INT := [ 66,389,130,131,
															388,390,391,392];                              // Unlock/Lock/Dark/Light


//      RGB      : ARRAY[0..1,0..4] OF USINT := [208,208,208,208,208, 208,210,209,212,211 ];                              // w-R-G-B-orange
      RGB      : ARRAY[0..4] OF INT := [208,210,209,212,211 ];                              // w-R-G-B-orange
      RGBWA    : ARRAY[0..1,0..5] OF INT := [208,208,208,208,208,208,   208,210,209,212,371,211 ];                              // w-R-G-B-orange
      led      : ARRAY[0..1,0..7] OF INT := [208,208,208,208,208,208,208,208,  209,210,209,210,209,210,209,210];      // Green/Red
      ledR     : ARRAY[0..1,0..1] OF INT := [208,208,  210,209];                                                      // Red/Green - ked je prva RED
      off      : ARRAY[0..1]      OF INT := [127,128];                                                                // Zablokovat 0/1
      Dark     : ARRAY[0..1]      OF INT := [130,131];                                                                // Dark
      pir      : ARRAY[0..1,0..5] OF INT := [139,141,143,145,067,130, 140,142,144,146,069,131 ];                        // Day/Evening/Night/Morning/0/Twilight
		
      clrh     : ARRAY[0..4]      OF INT := [4,8,6,7,2];                                                              // siva/zelena/oranzova,cervena
      OFFon    : ARRAY[0..1]      OF INT   := [54,400];                                                                 // OFF=siva off, ON = zeleny podklad ON
      run      : ARRAY[0..1]      OF INT := [226,227];                                                                // RUN off/ON
//      LedGBR   : ARRAY[0..2,0..4] OF USINT := [139,141,143,145, 66, 140,142,144,146, 69 ];                              // Day/Evening/Night/Morning/Lock

   END_STRUCT;

   NH_RUN_VAL2_D  {HIDDEN} :  STRUCT          // STAVOVY dash S OBRAZKOM/TEXTOM/HODNOTOU
      ok       : BOOL;
      xy       : BOOL;                    // znamena, ze sa text vypisuje len pre to co je v x,y, inak pre xO^.x + x
      noxy     : BOOL;                    // text sa vypise od nastavenej pozicie
      nofmt    : BOOL;                    // text sa neformatuje
      crc      : BOOL;                    // vykresluje sa kruh
      box      : BOOL;                    // vykresluje sa obdlznik
      fil      : BOOL := true;            // vykresluje sa obsah kruhu/obdlznika
      wh       : USINT;                   // predvolba
      obr      : INT;
      txt      : SINT   := -1;            // vypise sa text (-1 := nic sa nevypise)
      grd      : USINT;                   // typ gradientu
      wO       : INT;
      wC       : INT;
      wB       : INT;                     // vyska boxu
      wT       : INT    := 24;            // velkost textu
      FgC      : USINT  := 2;             // GCOLOR_LTGRAY;
      BgC      : USINT  := 1;             // GCOLOR_BLACK;
      FgT      : USINT  := 4;             // GCOLOR_WHILE;
      fmt      : INT    := 2;             // formatovanie textu (stred riadka, stred textu)
      x,y      : INT;                     // korekcie
      ob       : SINT   := -1;            // > 1 aj namapuje nanovo obj
      val      : STRING[10];
	END_STRUCT;

   NH_RUN_VAL2  {HIDDEN} :  STRUCT          // STAVOVY dash S OBRAZKOM/TEXTOM/HODNOTOU
      v        : ARRAY[0.._ShwVal] OF NH_RUN_VAL2_D := [(ok:=1,wh:=18)];
	END_STRUCT;



END_TYPE

