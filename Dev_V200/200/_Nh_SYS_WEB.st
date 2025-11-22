VAR_GLOBAL CONSTANT     // konstanty pre WEBMAKER
   _Nh_ixc         : ARRAY[0.._Nh_CFG+1] OF USINT := [0,4,44,5,48,10,11,12,43,31,30,23,21,15,13,14,40,50,20,22,32,33,34,35,24,8,9,7,27,28,29,37,38,39,41,42,16,17,18,51,19,6,47,46,49,1,3,0]; // SCN,SVD,SVA....
	_Nh_CUST	    {HIDDEN} : USINT 	:= 1;				            // definicia CUST (uvodnej obrazovky): 0-vsetky, 1-len NacHouse, 2=FS, 3-HS, 4-hotel
   _RgbBck	    {HIDDEN} :  UDINT := 4278190080;					// backGround color=farba splyvajuca s pozadim;  alebo 4278190080=nic/priehladne
   _RowBrw      {HIDDEN} : USINT := 14;                        // pocet objektov (riadkov+stlpcov)
   _SldNbr      {HIDDEN} :  SINT := 14;                        // pocet sliderov
	_RowObr      	{HIDDEN} :  SINT := 10;                   // pocet objektov v riadku
   _ShwVal      {HIDDEN} : USINT :=  4;                        // pocet naraz sa vypisujucich objektov v jednom cykle
   _Nh_Sty      {HIDDEN} : ARRAY[0..5] OF UINT := [
                  GTEXT_STYLE_ITALIC + GTEXT_STYLE_ALIGN_LEFT   + GTEXT_STYLE_HRIGHT  + GTEXT_STYLE_VCENTER,    // 0 stred riadka zlava do prava
                  GTEXT_STYLE_ITALIC + GTEXT_STYLE_ALIGN_RIGHT  + GTEXT_STYLE_HLEFT   + GTEXT_STYLE_VCENTER,    // 1 stred riadka, zprava do lava
                  GTEXT_STYLE_ITALIC + GTEXT_STYLE_ALIGN_CENTER + GTEXT_STYLE_HCENTER + GTEXT_STYLE_VCENTER,    // 2 stred riadka, stred textu
                  GTEXT_STYLE_NORMAL + GTEXT_STYLE_ALIGN_LEFT   + GTEXT_STYLE_HRIGHT  + GTEXT_STYLE_VDOWN,      // 3 zhora-dolu, zlava do prava
                  GTEXT_STYLE_NORMAL + GTEXT_STYLE_ALIGN_RIGHT  + GTEXT_STYLE_HRIGHT  + GTEXT_STYLE_VDOWN,      // 4 zhora-dolu, zlava do prava
                  GTEXT_STYLE_NORMAL + GTEXT_STYLE_ALIGN_CENTER + GTEXT_STYLE_HCENTER + GTEXT_STYLE_VCENTER     // 5 stred, stred, NORMAL pismo
                  ];

   _NhColor        :  ARRAY[0..34] OF UDINT :=
                  [  3548178,                               // 0
//                  [  GCOLOR_BLACK,                        //
                     GCOLOR_BLACK,                          // 1
                     GCOLOR_GRAY,                           // 2
                     GCOLOR_AZURE,                          // 3
                     GCOLOR_WHITE,                          // 4
                     GCOLOR_YELLOW,                         // 5
                     GCOLOR_ORANGE,                         // 6
                     GCOLOR_RED,                            // 7
                     GCOLOR_GREEN,                          // 8
                     GCOLOR_BLUE,                           // 9
                     GCOLOR_LTGRAY,                         // 10
                     GCOLOR_YELLOW_A700,                    // 11
                     GCOLOR_YELLOW_900,                     // 12
                     GCOLOR_GREEN_A700,                     // 13
                     GCOLOR_GREEN_200,                      // 14
                     GCOLOR_ORANGE_A700,                    // 15
                     GCOLOR_ORANGE_400,                     // 16
                     GCOLOR_RED_A700,                       // 17
                     GCOLOR_RED_500,                        // 18
                     GCOLOR_CYAN,                           // 19
                     GCOLOR_CYAN_A700,                      // 20
                     GCOLOR_BLUE_A400,  		               // 21
                     GCOLOR_BLUE_300,                       // 22
                     GCOLOR_LIGHT_BLUE_A700,                // 23
                     GCOLOR_LIGHT_BLUE_50,                  // 24
                     GCOLOR_DKGRAY+ GCOLOR_TRANSPARENT3_4,  // 25
                     GCOLOR_WHITE + GCOLOR_TRANSPARENT1_4,  // 26
                     GCOLOR_AZURE + GCOLOR_TRANSPARENT1_2,  // 27
                     GCOLOR_PURPLE_A700,                    // 28
                     GCOLOR_DEEP_PURPLE_50,            		// 29
                     GCOLOR_AMBER_700 								// 30	

//                     GCOLOR_ORANGE+ GCOLOR_TRANSPARENT1_2,  // 29

                  ];


   x0          {HIDDEN} : INT := 0;                      // zaciatok
   x2          {HIDDEN} : INT := 590;                    // pravy koniec
   xz          {HIDDEN} : INT := 90;                     // vzdialenost medzi spodnymi menu
   xc          {HIDDEN} : INT := 290;                    // stred x

   y1          {HIDDEN} : INT := 103;                    // koniec horneho menu = zaciatok browsu
   yy2          {HIDDEN} : INT := 930;                    // koniec browsu = zaciatok spodneho menu
   yyc          {HIDDEN} : INT := 510;                    // stred Y
   yyr          {HIDDEN} : INT := 132;                    // vyska riadku

END_VAR


TYPE
  	NH_sta_OBR  {HIDDEN}  :  STRUCT 					
 		obr         : ARRAY[0.._Nh_CAT_STA] OF INT;                  // kategoria moze mat max 5 stavov
 		wht         : ARRAY[0.._Nh_CAT_STA] OF USINT;
	END_STRUCT;


  	FILT_LIST {HIDDEN} :  STRUCT 					
		n	  					: ARRAY[0.._Nh_CFG] OF BOOL;	
	END_STRUCT;
  	FILT_LIST_TYP {HIDDEN} :  STRUCT 					
		n	  					: ARRAY[0.._Nh_TYP] OF BOOL;	
	END_STRUCT;


  	NH_OBJ_4O1  {HIDDEN}    :  STRUCT		// obrazky nad ROM DayMode/Sviecka
      wh          : USINT := 107;                           // 1
      obj         : USINT := 1;                             // 2        cislo obj ku ktoremu sa vykresluju info obj
      ok          : ARRAY [1..4] OF BOOL := [1,1,0,0];      // aktivny
      fil         : ARRAY [1..4] OF BOOL := [1,1,1,1];      // vypln BgC
      txt         : ARRAY [1..4] OF BOOL;                   // text
      crc         : ARRAY [1..4] OF BOOL  := [1,1,1,1];      // podklad-kruh
      obr         : ARRAY [1..4] OF INT   := [142,131,142,144]; // cislo obrazka Day/sviecka/evening/night/
      wxy         : ARRAY [1..4] OF USINT := [40,40,40,40]; // polomer kruhu/kruznice
      BgC         : ARRAY [1..4] OF USINT := [1,1,1,1]; 		// 4,22     ak fil:=true: vypln kruhu,  ak fil:=false farba kruznice
      FgT         : ARRAY [1..4] OF USINT := [4,4,4,4];     // 4,26     farba textu
      cmd         : ARRAY [1..4] OF USINT;                  // co sa ma vykonat
   END_STRUCT;

  	NH_OBJ_4O2  {HIDDEN}  :  STRUCT 		// obrazky nad STAT	 Time/Pir			
      wh          : USINT := 107;                           // 1
      obj         : USINT := 2;                             // 2        cislo obj ku ktoremu sa vykresluju info obj
      ok          : ARRAY [1..4] OF BOOL ;      				//          aktivny
      fil         : ARRAY [1..4] OF BOOL ;      				// vypln BgC
      txt         : ARRAY [1..4] OF BOOL;                   // text
      crc         : ARRAY [1..4] OF BOOL;                   // 0        kruh
      obr         : ARRAY [1..4] OF INT := [232,226];             // cislo obrazka time/pir
      wxy         : ARRAY [1..4] OF USINT := [34,34,34,34]; // polomer kruhu/kruznice
      BgC         : ARRAY [1..4] OF USINT := [10,10,10,10]; // 4,22     ak fil:=true: vypln kruhu,  ak fil:=false farba kruznice
      FgT         : ARRAY [1..4] OF USINT := [4,4,4,4];     // 4,26     farba textu
      cmd         : ARRAY [1..4] OF USINT :=[44,45];                  // co sa ma vykonat
   END_STRUCT;


  	NH_OBJ_DAT {HIDDEN} :  STRUCT       // velkost: 30  vseobecny objekt  			
      wh       : USINT;                         // 0 0=nic,1=obrazok...2=...
		x			: INT ;                     		// 1 x-ova suradnica stredu objektu
		y			: INT ;         				      // 3 y-ova suradnica stredu objektu (default pre spodne menu)
		w			: INT := 80;            		   // 5 sirka  (pri obrazku je to aj vyska)
      cm       : USINT := 251;                  // 7 command, ktory vrati pri stlaceni
		h			: INT ;            		         // 8 vyska objektu
		fn			: INT;                           // 10 cislo obrazka pri nevybratom menu
      FgC      : USINT;                         // 12 GCOLOR_AZURE;
      BgC      : USINT;                         // 13 _RgbBck;
      fmt      : STRING[8];                     // 14
      cf       : NH_DEV_IO;                     // 23
      // bit 29
		Set0		: BOOL;                          // 29
		Set1		: BOOL;
		Set2		: BOOL;
		Set3		: BOOL;
		Set4		: BOOL;
		Set5		: BOOL;
		set6		: BOOL;
      Q        : BOOL;									  // xA^.trg.Q - musi si nulovat objekt	
		// bit 30
      Qr       : BOOL;                            // xA^.trg.Qr
		Qf       : BOOL;                            // xA^.trg.Qf
      Qs       : BOOL;                            // toto pouziva objekt, nenastavuje sa nikde - koniec dotyku slidera, ....
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL;                            // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte
	END_STRUCT;                      					// 30 byte

  	NH_SLD_DAT  {HIDDEN} :  STRUCT  // umiestnenie slidera 			
      t        : USINT;                               // typ premennej 0=real. 1=USINT
      xv       : INT;                                 // suradnica vb gulicky
      xa       : INT;                                 // suradnica va gulicky
      v1       : REAL;                                // hodnota minima
      v2       : REAL := 100.0;                       // hodnota maxima
      va       : UDINT;                               // pointer premennej pre bod xa
      vb       : UDINT;                               // pointer premennej pre bod xb
		ref		: UDINT;											// pointer BOOL premennej, kde sa zapisuje zmena hodnoty v slideri
      ink      : REAL := 1.0;                         // minimalny prirastok pri slideri tuning
      fmt      : STRING[14];                          // format premennej
//      txt      : USINT;                               // cislo textu
      txt      : INT;                                 // cislo textu
      sld      : BOOL := 1;                           // klasicky slider
      tun      : BOOL;                                // tuning (zoom) - ...*...+
      zom      : BOOL := 1;                           // moze sa zmenit na typ
      bor      : BOOL;                                // hranice od-do
      zva      : BOOL;                                // zoomuje sa VA, inak vb
      bal      : BOOL;                                // je viditelna gulicka
      tep      : BOOL;                                // po skonceni dotyku sa bude zobrazovat teplomer s hodnotou va
   END_STRUCT;

  	NH_ROW_O {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT;
   END_STRUCT

  	NH_OBJ_MNU  {HIDDEN}  :  STRUCT       // vseobecny objekt  			
		x			: INT ;                     				// x-ova suradnica stredu objektu
		y			: INT ;         				            // y-ova suradnica stredu objektu (default pre spodne menu)
		w			: INT := 80;            		         // sirka/vyska obrazka
      wh       : INT;                                 // 0=obrazok,pri vybratom menu
      cm       : USINT;                                // command, ktory vrati pri stlaceni
		fn			: INT;
      kxy      : BOOL;                              // priznak, ze uz bolavykonana korekcia xy suradnice
      frm      : USINT;
	END_STRUCT;

   NH_MNU {HIDDEN} :  STRUCT 			
      n         : USINT;                              // cislo vybrateho menu, ktore ma byt podfarbene
      o    	    : ARRAY[1..8] OF NH_OBJ_MNU := [
                                       (x:=x0+50 ,       y:= y1-50, w:= 54), //  <
                                       (x:=x2-45 ,       y:= y1-50, w:= 60), //  setup
                                       (x:=xc-xz*2-xz/2, y:= yy2+55),         // home
                                       (x:=xc-xz  -xz/2, y:= yy2+55),         // FAV
                                       (x:=xc-xz/2,      y:= yy2+55),         // rom
                                       (x:=xc+xz/2,      y:= yy2+55),         // cat
                                       (x:=xc+xz+xz/2,   y:= yy2+55),         // act
                                       (x:=xc+xz*2+xz/2, y:= yy2+55)];        // ON/OFF

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

  	NH_obr_WHT  {HIDDEN}  :  STRUCT 					
 		obr         : INT;                  // kategoria moze mat max 5 stavov
 		wht         : USINT;
	END_STRUCT;

  	NH_dev_CFG   {HIDDEN}  : ARRAY[0.._Nh_CFG] OF BOOL;

 	NH_dev_OBR_F {HIDDEN}  :  STRUCT 					        // obrazok DEV   [1]
		obr	: NH_obr_WHT;
		fil	: NH_dev_CFG :=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
	END_STRUCT

   NH_FRM_SAVE_MAP {HIDDEN}  : STRUCT      				// HLAVNA RIADIACA PREMENNA
      size     : UDINT;
      hed      : NH_FRM_HED;
	END_STRUCT;

	NH_CAT {HIDDEN}  : STRUCT  				// DEFINICIA 1 RIADKA MENU cat
		obr0		: INT;                   // hlavny obrazok
		wh0		: USINT;                // podklad ked lvl = 0;
		obr1		: INT;                  // obr ked
		wh1		: USINT;		   			//  pre lvl > 0
		txt		: INT;
		rght		: USINT;						// prava: 0=vsetci 1-supervisor 2-admin
		cmd1		: USINT := 251;			// CMD - hlavna ikona
		cmd2		: USINT := 51	;	   	// CMD - hlavna ikona
		cmd4		: USINT := 51;				// CMD pri odskoku dalej . ak=0 nema stavovy obrazok, ani sipky odskoku 		
		frm		: USINT;						// cislo FRM screenu 				
	END_STRUCT;
	
	NH_FRM_232 {HIDDEN}  : STRUCT  			// CAT,DASH   								
//      typ	: USINT := 232;
      hed : NH_FRM_HED := (Name:='_232',desc:='CAT:Obr,Sta,CatToCat',wht:=0);
 	       CatToCat : ARRAY[-2.._Nh_CAT] OF FILT_LIST := [ 	// CAT (v riadku) sa nachadza vo vyssej CAT (stlpec)
//           	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]), //-2 browser SETUP
			(n := [0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  //-1 browser CAT
//	(n := [0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  //-1 browser CAT

//0
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
// 1          	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 1 SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 2 ZAS
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 6 PSN
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
//11          	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
//21          	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// ..... MSG
			(n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SIR
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
//31          	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
//41          	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	//
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 45 DOR
			(n := [0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 46 WIN
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),

			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// ALA

			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
//51          	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	

			(n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// NH sceny
			(n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // dali sceny

			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 55 ALA

			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 56 MSG all
			(n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 57 MSG alarm
			
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),

			()	
         ];

		cat	: ARRAY[0.._Nh_CAT] OF NH_CAT :=
				[
              	(obr0:=24, 	wh0:=18,	obr1:=24, 	wh1:=18,	txt:=0	),		//  0- nic
				  	(obr0:=62, 	wh0:=18,	obr1:=201, 	wh1:=17, txt:=256	),    //  1-SVE
				  	(obr0:=73, 	wh0:=18, obr1:=202, 	wh1:=13, txt:=258	),				    //  2-ZAS
				  	(obr0:=116, wh0:=18,	obr1:=114, 	wh1:=30, txt:=268	),    //  3-ROL
//				  	(obr0:=116, wh0:=18,	obr1:=114, 	wh1:=34, txt:=268	),    //  3-ROL
				  	(obr0:=70, 	wh0:=18,	obr1:=215, 	wh1:=16, txt:=260	),    //  4-VET
				  	(obr0:=61, 	wh0:=18,	obr1:= 61, 	wh1:=33, txt:=262	),    //  5-HET
				  	(obr0:=66, 	wh0:=18,	obr1:=-1,  	wh1:= 0, txt:=264	),    //  6-SEC
				  	(obr0:=216, wh0:=18,	obr1:=217, 	wh1:=15, txt:=266	),    //  7-BRA
				  	(obr0:=71, 	wh0:=18,	obr1:= 72, 	wh1:=13, txt:=270	),    //  8-ZAVLAHA
				 	(obr0:=155, wh0:=18,	obr1:=155, 	wh1:=13, txt:=272	),    //  9-WELLNESS
				  	(obr0:=75, 	wh0:=18,	obr1:= 76, 	wh1:=13, txt:=274	),    // 10-MULTIMEDIA
				 	(obr0:=132, wh0:=18,	obr1:=313, 	wh1:=13, txt:=276	),    // 11-FOTOVOLTAIKA
				 	(obr0:=218, wh0:=18,	obr1:=218, 	wh1:=13, txt:=278 ),    // 12-KANALIZACIA
				  	(obr0:=98,  wh0:=0,	obr1:= 98,  wh1:=0, 	txt:=282 ),    // 	13-SENZORY  KATEGORIA
				  	(obr0:=61, 	wh0:=18,	obr1:= 61, 	wh1:=13, txt:=284 ),    // 14-TEPLOTA
				  	(obr0:=87, 	wh0:=18,	obr1:= 89, 	wh1:=16, txt:=286 ),    // 15-PIR
				  	(obr0:=86, 	wh0:=18,	obr1:= 87, 	wh1:=16, txt:=288 ),    // 16-SUMRAK
				 	(obr0:=258, wh0:=18,	obr1:= 13,  wh1:=36, txt:=258	),    // 17-VLHKOST
				 	(obr0:=314, wh0:=18,	obr1:=314, 	wh1:=20, txt:=378 ),    // 18-CO2
				  	(obr0:=91, 	wh0:=18,	obr1:= 91, 	wh1:=23, txt:=292 ),    // 19-Dvere
				  	(obr0:=92, 	wh0:=18,	obr1:= 92, 	wh1:=23, txt:=290 ),    // 20-Okna
				  	(obr0:=88, 	wh0:=18,	obr1:= 88, 	wh1:=23, txt:=298 ),    // 21-Srdce = zivot
				 	(obr0:=313, wh0:=18,	obr1:=313, 	wh1:=18, txt:=300 ),    // 22-COx - rozne plyny
				 	(obr0:=105, wh0:= 0,	obr1:=105,  wh1:=0, 	txt:=304 ),    // 	23-ovladace - skupina
				 	(obr0:=103, wh0:=18,	obr1:=103, 	wh1:=37, txt:=308 ),    // 24-TLACITKA
				  	(obr0:=97, 	wh0:=18,	obr1:= 97, 	wh1:=16, txt:=310 ),    // 25-KLAVESNICE
				 	(obr0:=109, wh0:=18,	obr1:=109, 	wh1:=16, txt:=312 ),    // 26-REGULATORY
				 	(obr0:=151, wh0:=18,	obr1:=151, 	wh1:=13, txt:=302 ),    // 27-RFID
				 	(obr0:=138, wh0:=18,	obr1:=  0,  wh1:=0,  txt:=56 	),    // 28-                                       MSG/SMS/MAIL
				 	(obr0:=168, wh0:=18,	obr1:=168, 	wh1:=23, txt:=414 ),    // 29-SIRENY
				  	(obr0:=77,  wh0:=0,	obr1:= 77,  wh1:=0, 	txt:=280 ),    // 	30-STATISTIKY
				  	(obr0:=79,  wh0:=0,	obr1:= 79, 	wh1:=13, txt:=321,	rght:=1),    // 		31-UZIVATELIA
				  	(obr0:=11,  wh0:=0,	obr1:= 11,  wh1:=0, 	txt:=323,	rght:=1),    // 		32-CISELNIKY
				 	(obr0:=298, wh0:= 0,	obr1:=298,  wh1:=0, 	txt:=337,	rght:=1),    // 		33-AUTOMATIAZCNE PRVKY

				  	(obr0:=81,  wh0:=0,	obr1:= 81,  wh1:=0,  txt:= 0 ),    // 		34-GLOBALNE NASTAVENIA		- disable

				 	(obr0:=290, wh0:= 0,	obr1:=290,  wh1:=0, 	txt:=334,rght:=3),    // 		35-DALI
				  	(obr0:=99,  wh0:=0,	obr1:=  0,  wh1:=0, 	txt:=329 ),    // 		36-EXTERNE SYSTEMY
				 	(obr0:=260, wh0:= 0,	obr1:=260,  wh1:=0, 	txt:=325 ),    // 37-RFID KARTY
				  	(obr0:=74,  wh0:=0,	obr1:= 74,  wh1:=0, 	txt:=327 ),    // 38-HOSTIA
				  	(obr0:=368,  wh0:=0,	obr1:=  0,  wh1:=0, 	txt:=317,rght:=3),    // 	39-SETUP KURENIA
				 	(obr0:=196, wh0:= 0,	obr1:=197,  wh1:=0, 	txt:=376 ),    // 40-BLIKAC
				 	(obr0:=295, wh0:= 0,	obr1:=295,  wh1:=0, 	txt:=333 ),    // 41-CASOVAC
				 	(obr0:=298, wh0:= 0,	obr1:=298,  wh1:=0, 	txt:=339 ),    // 42-smart way
				 	(obr0:=353, wh0:=18,	obr1:=352, 	wh1:=15, txt:=331 ),    // 43-EXTERNEY ALARM
				  	(obr0:=92, 	wh0:=18,	obr1:= 92, 	wh1:=23, txt:=290 ),    // 44-OKNA
				  	(obr0:=91, 	wh0:=18,	obr1:=91, 	wh1:=23, txt:=292 ),    // 45-DVERE
				  	(obr0:=95, 	wh0:=18,	obr1:= 96, 	wh1:=23, txt:=294 ),    // 46-POZIAR
				 	(obr0:=108, wh0:=18,	obr1:=108, 	wh1:=23, txt:=306 ),    // 47-H2O
				  	(obr0:=88, 	wh0:=18,	obr1:= 88, 	wh1:=23, txt:=298 ),    // 48-ZIVOT
				 	(obr0:=313, wh0:=18,	obr1:=313, 	wh1:=23, txt:=300 ),    // 49-CO
				  	(obr0:=90, 	wh0:=18,	obr1:= 90, 	wh1:=23, txt:=254 ),    // 50-HORLAVY PLYN
				  	(obr0:=368, wh0:=0,	obr1:=  0,  wh1:=0,  txt:=41,	rght:=3),    // 51-SETUP REKUPERACIE
				  	(obr0:=24,  wh0:=0,	obr1:=  0,  wh1:=0,  txt:=43 	),    // 52-SERVIS FAV
				  	(obr0:=30, 	wh0:=18,	obr1:=  0,  wh1:=0,  txt:=11  ),    // 	53-SCENY NachHouse
				 	(obr0:=333, wh0:=18,	obr1:=  0,  wh1:=0, 	txt:=300 ),    // 	54-DALI SCENY
				 	(obr0:=356, wh0:= 0,	obr1:=  0,  wh1:=0, 	txt:=408,	rght:=1),    // 	55-Akcie ALARMU
				 	(obr0:=235, wh0:= 0,	obr1:=  0,  wh1:=0,  txt:=56  ),    // 56-Spravy {all}
				 	(obr0:=236, wh0:= 0,	obr1:=  0,  wh1:=0, 	txt:=388,	rght:=1),    // 57-Spravy alarmu
				 	(obr0:=385, wh0:= 0,	obr1:=  0,  wh1:=0, 	txt:=354,	rght:=2,	cmd1:=204, cmd2:=0, cmd4:=204, frm:=80 )     // 58-meteostanica

				];


		sta   : ARRAY[ 0..50,0..1] OF INT :=
		 		[
					 66, 18,				//	[0,0] [0,1] 		// 60 stat= 0 odkodovane
					287, 13,				// [1,0] [1,1]      	// 61 stat:=1 odchod   	orange/outgoing
					 68, 15,          // 2       				// 62 stat:=2 locked   	zamok/sveto-cerveny gradient 15
					289, 14,				//	3      				// 63 stat:=3 prichod  	cierny prichod/orange gradient
					351, 22,				//	4				  		// 64 stat:=4 dog 		cierny pes/orange gradient
					354,160,				//	5						// 65 stat:=5 Narusenie cierny majak/svetlo-fialovy gradient
					355, 38,				//	6						// 66 stat:=6 Alarm 		biely majak+sirena/tmavo-fialovy bez gradientu
					 66, 18,				//	7						// free
					 68, 18,				//	8						// free
					 66, 18,				//	9						// volne
					 68, 14,          // 10       			// stat:=2 locked   zamok-polozamknuty/sveto-cerveny gradient 15

				];
				
		psn4 : NH_OBJ_4O1 := (wh:=107, obj:=1, txt:=[0,0,0,1], BgC:=[3,3,7,5], FgT:=[0,0,0,0], Obr:=[89,89,169,0], wxy:=[58,58,58,58], ok:=[0,0,0,0] );                // 8 = time/blkPIR na dstavom//

	END_STRUCT;

//  	NH_FRM_STA  {HIDDEN} :  STRUCT 					                // OBR - status: DEV
//      typ         : USINT := 231;
  	NH_FRM_233  {HIDDEN} :  STRUCT 					                // OBR - status: DEV
      hed : NH_FRM_HED := (Name:='_233',wht:=0);
 		dev         : ARRAY[0..100] OF NH_STA_OBR :=
                     [
                        //          0   1   2   3   4   5
                        ( obr := [ 24, 24, 24, 24, 24, 24],    // 0
                          wht := [ 18, 18, 18, 18, 18, 18]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 1 ROM     (obr=formtovanie textu 0..2:=na stred)
                          wht := [100,100,100,  0,100,100]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 2 CAT
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 1 ROM     (obr=formtovanie textu 0..2:=na stred)
                          wht := [100,100,100,  0,100,100]),

//                        ( obr := [ 66,  0, 68,   0, 69, 69],          // 3 ZON
//                          wht := [ 18,112, 15, 114, 32, 33]),

                        ( obr := [  0,207,  0,  0, 30,207],          // 4-SCN
                          wht := [ 10, 14,  0,  0, 18, 14]),

                        ( obr := [ 34, 34,  0,  0, 34, 34],          // 5-ACT
                          wht := [ 18, 20,  0,  0, 18, 20]),

                        ( obr := [183,184,185,186,  0,  0],          // 6 HET
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 7 KOT
                          wht := [ 10,115,115,115, 18,115]),

                        ( obr := [  0,  0,  0,  0,100,  0],          // 8 TVE
                          wht := [ 10,115,115,115, 18,115]),

                        ( obr := [  0,  0,  0,  0,100,  0],          // 9 CER
                          wht := [ 10,115,115,115, 18,115]),

                        ( obr := [  0,  0,  0,  0, 62,201],          // 10 SVD
                          wht := [ 10, 11,118,  0, 18, 17]),

                        ( obr := [  0,  0,  0,  0, 63,316],          // 11 SVA
                          wht := [ 10,110,117,  0, 18, 17]),

                        ( obr := [  0,  0,  0,  0, 64,317],          // 12 RGB
                          wht := [ 10,110,117,  0, 18, 17]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 13 WSB      - obr sa upravi podla typu
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 14 TLA      - obr sa upravi podla typu
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [ 87, 89,  0,  0,  0,  0],          // 15 PIR
                          wht := [ 18, 16,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 16 TER
                          wht := [100,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 17 TEH
                          wht := [100,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 18 TEK
                          wht := [100,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 19 LUX
                          wht := [101,  0,  0,  0,  0,  0]),

                        ( obr := [199,198, 60, 60,  0,  0],          // 20 FAV  dash/Quick/fav/fav
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [  0,405,  0,  0,  0,  0],          // 21 ZAS  zas/sve/het-cold// nabijacka
                          wht := [ 10,  0,118,  0,  0,  0]),

                        ( obr := [ 78, 78,  0,  0,  0,  0],          // 22 USR
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  2,  2],          // 23 VEN
                          wht := [ 10,115,115,115, 18,115]),

                        ( obr := [ 97,  0,  0,  0,  0,  0],          // 24 KEY
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 25 smar-w
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 26 POI
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 27 H20
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 28 FIRE
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 29 GAS
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 30 MArkiza
                          wht := [  0,  0,  0,  0,  0,  0]),

                        ( obr := [114,115,  0,  0,  0,  0],          // 31 ROL
                          wht := [ 50,  0,  0,  0,  0,  0]),

                        ( obr := [  0,168,  0,  0,  0,  0],          // 32 SIR
                          wht := [ 10, 23,  0,  0,  0,  0]),

                        ( obr := [ 91, 91,  0,  0,  0,  0],          // 33 DOR
                          wht := [  0, 23,  0,  0,  0,  0]),

                        ( obr := [ 92, 92,  0,  0,  0,  0],          // 34 WIN
                          wht := [  0, 23,  0,  0,  0,  0]),

                        ( obr := [ 34, 34,  0,  0,  0,  0],          // 35 blikac
                          wht := [ 18, 20,  0,  0,  0,  0]),

                        ( obr := [  0,  0,  0,  0,  0,  0],          // 36 XX
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [508,216,166,169,505,508],          // 37 garaz/Brana,branicka/zavora
                          wht := [ 23, 23, 23, 23, 23, 23]),
                        ( obr := [151,151,  0,  0,  0,  0],          // 38 RFID snimace
                          wht := [ 18, 13,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 39 karty
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [310,310,  0,  0,  0,  0],          // 40 TGL
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 41 CO...
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 42 DALI-M  0=OFF,
                          wht := [ 10,110,111,112,114,115]),            // 1=ON-LVL z al.ou.val 1..254,
                                                                        // 2=Scan = zeleny
                                                                        // 3:=LVL,PAR....Oranzovy
                                                                        // 4 RANDOME ID
                                                                        // 5 Err
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 43 DALI-slave  : 0=OFF,1=LVL,2=ERR
                          wht := [ 10,110,117,  0,  0,  0]),

                        ( obr := [  0 , 0,336,  0,  0,  0],          // 44 DALI-group
                          wht := [ 10,110, 14,  0,  0,150]),

                        ( obr := [340,341,342,343,  0,  0],          // 45 Regulator RVE
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [138, 93, 76,138,  0,  0],          // 46 MSG/SMS/MAIL
                          wht := [  0,  0,  0,  0,  0,  0])
                        ];

	END_STRUCT;

 	NH_OPV_REG   {HIDDEN}   :  STRUCT 					        // predvolby HET/VEN/TVE
		zn			  : ARRAY[0..1,0..1] OF STRING[10];
      mode       : ARRAY[ 0..1,														// Mode  (Kurenie/Chladenie )
								  0..1,                                         // WHT	(Vykon/Teplota)
								  0..4] OF INT;
      obr1       : ARRAY[ 0..1,														// Mode  (Kurenie/Chladenie )
								  0..1,                                         // WHT	(Vykon/Teplota)
								  0..3] OF INT;	END_STRUCT;

// 	NH_OBR_OPV   {HIDDEN}   :  STRUCT 					        // predvolby HET/VEN/TVE

   NH_FRM_229   {HIDDEN}   :  STRUCT 					        // predvolby HET/VEN/TVE
      hed : NH_FRM_HED := (Name:='_229',Wht:=0);
//      typ         : USINT := 229;
		//							    0   1
      //            reg     [ HET,HEV     ,TVE,VEN]
		reg			: ARRAY[0..3] OF NH_OPV_REG :=
			[	
				(	// HET      	
					zn	:=	[ '%3u','%4.1f°', 								   	// Het 	[vykon/teplota]
                       '%3u','%4.1f°'],                          	// Cold 	[vykon/teplota]
      			mode  := [222, 54,172,174,176,  223,193,173,175,177, 		// mode:=0 KURENIE 	[ vykon,teplota]
								 222, 54,172,174,176,  223,193,173,175,177],		// mode:=1 CHLADENIE [ vykon,teplota]
      			obr1	:= [183,184,185,186,      183,184,185,186,			// mode:=0 KURENIE 	[ vykon,teplota]
                         410,411,412,413,      410,411,412,413 ],      	// mode:=1 CHLADENIE [ vykon,teplota]
				),
				(	// HEV
					zn :=	[	'%3u','%3.0f%%CO2', 								// mode:=0 VETRANIE 		[vykon/CO2]
    							'%3u','%3.0f%%RH'],                     	// mode:=1 ODVLHCENIE 	[vykon/RH]
					 mode := [222, 54,172,174,176,  223,193,173,175,177, 	
								 222, 54,172,174,176,  223,193,173,175,177],
					 obr1 := [340,341,342,343,       340,341,342,343,		
                         415,416,417,418,       415,416,417,418]
				 ),
				(	// TVE      	
					zn	:=	[ '%3u','%4.1f°', 								   	// Het 	[vykon/teplota]
                       '%3u','%4.1f°'],                          	// Cold 	[vykon/teplota]
      			mode  := [221, 54,172,174,176,  220,193,173,175,177, 		// mode:=0 KURENIE 	[ vykon,teplota]
								 221, 54,172,174,176,  220,193,173,175,177],		// mode:=1 CHLADENIE [ vykon,teplota]
      			obr1	:= [183,184,185,186,      183,184,185,186,			// mode:=0 KURENIE 	[ vykon,teplota]
                         410,411,412,413,      410,411,412,413 ],      	// mode:=1 CHLADENIE [ vykon,teplota]
				)
			];
	END_STRUCT;

  	NH_OBJ_123_CF      :  STRUCT    // prepinac medzi riadkami + vyber volby z 10 textov {2 riadky}
		x			: INT 	:= 95;                     				// x-ova suradnica stredu objektu
		y			: INT 	:= 400;         				            // y-ova suradnica stredu objektu (default pre spodne menu)
      w        : INT 	:= 490;                          // sirka
      h        : INT 	:= 53;                           // vzdialenost medzi riadkami
      hTxt     : INT 	:= 30;                           // vyska textu
		rw1		: USINT 	:= 1;                          // ktorym riadkom sa zacina
      rw2      : USINT 	:= 7;                          // ktorym riadkom konci
      typ      : USINT 	:= 1;                         // typ premennej 1=usint,3=sint
	END_STRUCT;

  	NH_OBJ_123      :  STRUCT    // prepinac medzi riadkami + vyber volby z 10 textov {2 riadky}
      // prvy riadok
      wh       : USINT  := 123;                        //
		cf			: NH_OBJ_123_CF;
      row      : USINT;                              // vybraty riadok
		CMD		: USINT;											// aky CMD je vo vybratom riadku, alebo aky CMD sa hlada v texte
      FgC      : USINT 	:= 2;                         // farba neaktivneho riadku {siva}
      BgC      : USINT 	:= 8;                         // farba aktuvneho riadku {zelena}
      aVar     : UDINT;                               // adresa premennej
      dummy1   : ARRAY[1..6] OF USINT;                // doplnenie do 30
      // bit 29
		Set0		: BOOL;                          // 29
		Set1		: BOOL;
		Set2		: BOOL;
		Set3		: BOOL;
		Set4		: BOOL;
		Set5		: BOOL;
		set6		: BOOL;
      Q        : BOOL;									  // xA^.trg.Q - musi si nulovat objekt	
		// bit 30
      Qr       : BOOL;                            // 29 zaciatok dotyku (tch = true )
      Qf       : BOOL;                            // koniec dotyku (tch = true )
      Qs       : BOOL;                            // koniec dotyku slidera alebo dotyk nad vybratym objektom
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL;                            // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte

      // druhy riadok
//		txt      : ARRAY[1..15] OF INT;                  // texty riadkov  vyberu msx 15
		wh2		: USINT;
		dummy		: USINT;
		txt		: NH_PI14;
	END_STRUCT;



   NH_FRM_246   {HIDDEN}  : STRUCT					// rozne varianty objektu riadka  xR^.o.obj[]
      hed : NH_FRM_HED := (Name:='_246',desc:='Varianty riadka');
//	   typ : USINT := 246;
		OBJ_EMPTY_1		: NH_OBJ_DAT :=	
			(wh:=0);
		OBJ_EMPTY_2		: ARRAY[1..2] OF  NH_OBJ_DAT :=	
			[(wh:=0), (wh:=0)];

		PV_OBJ_TX0_21		: NH_OBJ_DAT :=	// r0
			(wh:=21,  x:= x2- 70 , 	y:= y1 + 60,  w:= 45, Fn :=585, FgC := 4, BgC := 50, 	h:=33);			 	// manualne rezim
//        	(wh:=21,  x:= x2- 70 , 	y:= y1 + 140,  w:= 45, Fn :=561, FgC := 8, BgC := 50, h:=24, cm:=89),					 // 1 ovplyvneny snimacom osvetlenia
		PV_OBJ_TX0_6		: NH_OBJ_DAT :=	// r0
 			(wh:=6,  x:= x2/2   , 	y:= y1 + 60, w:= 400,FgC := 4, BgC := 0, fn := 2, 	h:=33,cf:=(c:=0,n:=584));   	// rezim - len text

//		PV_OBJ_TX1_6		: NH_OBJ_DAT :=	// r0
// 			(wh:=6,  x:= x2/2   , 	y:= y1 +250, w:= 400,FgC := 4, BgC := 0, fn := 2, 	h:=33,cf:=(n:=592));   		// predvolby reguluju
		PV1_IsOn			: NH_OBJ_DAT :=
				(wh:=21,  x:= x2- 70 , 	y:= y1 + 900,  w:= 45, Fn :=597, FgC := 4, BgC := 50, 	h:=28);			 	// PV-1 je ON/OFF

		PV_OBJ_REG_HET : NH_OBJ_123 :=
 			(wh:=123,cf:=(x:=170, y:= y1 + 130, rw2:=2, h:= 50, hTxt:= 28, typ:=1),
    			txt:=[586,587]);             												                                 	// KURENIE/CHLADENIE
		PV_OBJ_REG_REK : NH_OBJ_123 :=            // r3
 			(wh:=123,cf:=(x:= 170,     y:= y1 + 130, typ:=1, rw2:=2, h:= 50, hTxt:= 28),
    			txt:=[589,590]);             												                                 	// VETRANIE/ODVLHCENIE

		PV_OBJ_WHT_VYKON : NH_OBJ_123 :=            // r3
 			(wh:=123,cf:=(x:= 90,     y:= y1 + 320, typ:=1, rw2:=1, h:= 50, hTxt:= 28),
    			txt:=[593]);             												                                 		// len Vykon
		PV_OBJ_WHT_TER : NH_OBJ_123 :=            // r3
 			(wh:=123,cf:=(x:= 70,     y:= y1 + 320, typ:=1, rw2:=2, h:= 50, hTxt:= 28),
    			txt:=[593,594]);             												                                 	// Vykon/teplota
		PV_OBJ_WHT_CO2 : NH_OBJ_123 :=            // r3
 			(wh:=123,cf:=(x:= 70,     y:= y1 + 320, typ:=1, rw2:=2, h:= 50, hTxt:= 28),
    			txt:=[593,595]);             												                                 	// Vykon/koncentracia CO2
		PV_OBJ_WHT_RH : NH_OBJ_123 :=            // r3
 			(wh:=123,cf:=(x:= 70,     y:= y1 + 320, typ:=1, rw2:=2, h:= 50, hTxt:= 28),
    			txt:=[593,596]);             												                                 	// Vykon/vhlkost


		PV_OBJ_SLD_VYKON		: ARRAY[6..10] OF NH_OBJ_DAT :=	// r0   (celkovo 6 riadkov)
          [ (wh:=13, x:= 50     , y:= y1 + 500,   w:= x2-110 , FgC := 4, BgC := 2, fn := 0, fmt := '193'),              // 0 off  		FMT:=cislo obrazka
            (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 8, fn := 1, fmt := '173'),              // 1 Minimum
            (wh:=13, x:= 50     , y:= y1 + 700,   w:= x2-110 , FgC := 4, BgC := 6, fn := 2, fmt := '178'),              // 2 Normal
            (wh:=13, x:= 50     , y:= y1 + 800,   w:= x2-110 , FgC := 4, BgC := 7, fn := 3, fmt := '177')               // 3 Maximum
			 ];
		PV_OBJ_SLD_PV			: ARRAY[6..10] OF NH_OBJ_DAT :=
         [  (wh:=13, x:= 50     , y:= y1 + 500,   w:= x2-110 , FgC := 4, BgC := 2, fn := 0, fmt := '193'),              // 0 PV-0 protimraz
            (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 8, fn := 1, fmt := '173'),              // 1 PV 1
            (wh:=13, x:= 50     , y:= y1 + 700,   w:= x2-110 , FgC := 4, BgC := 6, fn := 2, fmt := '178'),              // 2 PV 2
            (wh:=13, x:= 50     , y:= y1 + 800,   w:= x2-110 , FgC := 4, BgC := 7, fn := 3, fmt := '177')             	// 3 PV 3
			];

		PV_OBJ_SLD_DELAY		: NH_OBJ_DAT :=	// r0   (celkovo 6 riadkov)
          (wh:=13, x:= 50     , y:= y1 + 900,   w:= x2-110 , FgC := 4, BgC := 2, fn := 4, fmt := '121');              // 10 opozdenie technologie

   	// %vykon
		PV_SLD_VYKON		: ARRAY[0..3] OF NH_SLD_DAT :=  // HET,COLD
         [  (t:=1,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'       			   ,txt:= 176),     	// 0 off       	txt:=cislo textu
            (t:=1,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'      			   ,txt:= 154),     	// 1 Minimum
            (t:=1,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'      			   ,txt:= 156),     	// 2 Normal	
            (t:=1,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'						,txt:= 165)      	// 3 Maximum
			];
		// %CO2/vlhkost
		PV_SLD_CO2			: ARRAY[0..3] OF NH_SLD_DAT :=     //
        [   (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'   					,txt:= 176),     	// 0 OFF
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'    					,txt:= 155),      // 1 PV-2
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'   			  		,txt:= 156),      // 2 PV-3
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'   			 		,txt:= 157)      	// 3 PV-4
		  ];

		// °C teplota
		PV_SLD_TMP_HET		: ARRAY[0..3] OF NH_SLD_DAT :=     // teplotz pre Kurenie + sauna
        [   (t:=0,	xv := x2-53, v1 := 0.0, v2 :=120.0 , fmt := '%5.1f°',  ink := 0.1			,txt:= 176),     	// 0 OFF
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=120.0 , fmt := '%5.1f°',  ink := 0.1   		,txt:= 155),      // 1 PV-2
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=120.0 , fmt := '%5.1f°',  ink := 0.1   		,txt:= 156),      // 2 PV-3
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=120.0 , fmt := '%5.1f°',  ink := 0.1   		,txt:= 157)      	// 3 PV-4
		  ];
(*
		PV_SLD_TMP_COLD		: ARRAY[0..3] OF NH_SLD_DAT :=  // teploty pre chladenie
        [   (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0, fmt := '%5.0f %%',ink := 1.0			,txt:= 176),        	// 0 off
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=35.0 , fmt := '%5.1f°',  ink := 0.1   		,txt:= 155),        	// 1 Minimum
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=35.0 , fmt := '%5.1f°',  ink := 0.1   		,txt:= 156),        	// 2 Normal
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=35.0 , fmt := '%5.1f°',  ink := 0.1   		,txt:= 157)        	// 3 Maximum
		  ];
*)
		e4O1 				: NH_OBJ_4O1 := (wh:=  0,obj:=1,ok:=[0,0,0,0]); 							// disable objekt 401
		tim_1    		: NH_OBJ_4O1 := (wh:=107,obj:=1,ok:=[0,1,0,0],obr:=[0,295,0,0]); 		// timer obrazok nad hlavnou ikonou
		tim_1_typ_obr  : ARRAY[0..6] OF INT := [232,197,148,147,131,130,387];  // 0=Nacasovat,1=cyklus,2=Sunrise,3=Sunshine,4=Dark,5=Light,6=Random


   END_STRUCT;


//   NH_TYP_DAY	{HIDDEN} :  STRUCT  // typove dni : WEEK (PO-NE) ,Sviatok,Party,OutHome,Holiday
   NH_FRM_248	{HIDDEN} :  STRUCT  // typove dni : WEEK (PO-NE) ,Sviatok,Party,OutHome,Holiday
      hed : NH_FRM_HED :=(Name:='_248',wht:=0);
//      typ         : USINT := 248;
//      oDay        : ARRAY[0..11] OF INT := [270,  0,  0,  0,  0,  0,  0,  0,  273,276,279,282];           // cislo zakladnych obrazkov = nektivnych. (+1 = biele, +2 azure)
//      xTyp     : ARRAY[7..11] OF INT :=[ 25,170,266,364,462];            // +25=[0], +145=[1], dalej +98
      // xDay len pre dotyk na webe
      xDay     : ARRAY[0..11] OF INT :=[ 25,  20, 94,168,242,316,390,464,  170,266,364,462];            // +25=[0], +145=[1], dalej +98
      oTyp     : ARRAY[0..4,7..11] OF INT := [
                  270,273,276,279,282,       // sivy     = nema POI / nevybraty
                  272,275,278,281,284,       // zeleny   = ma   POI / nevybraty
                  271,274,277,280,283,       // biely    = biely vzdy pre vybraty
                   25,170,266,364,462,       // x-ova korekcia obrazka
                  201,202,203,204,205];      // texty k typ.dnom

      wDay     : ARRAY[0..1,1..7] OF INT := [      // week Day
                   20, 94,168,242,316,390,464,       // x-ova korekcia
                   21, 22, 23, 24, 25, 26, 27];      // texty k dnu v tyzdni
	END_STRUCT;

 	NH_FRM_230     :  STRUCT 					        // hlavny obrazok DEV   [1]
      hed : NH_FRM_HED :=(Name := '_230',wht:=0) ;
//		typ	: USINT := 230;

		T05	: ARRAY[1..7,0.. 5] OF NH_DEV_OBR_F :=
											         	
		[	(obr:=( obr := 200,  wht :=  0)),	// 1. volne - povodne bola ROOM			
		 	(obr:=( obr :=  16				)),
			(obr:=( obr :=  19				)),
			(obr:=( obr :=  15				)),
			(obr:=( obr :=  20				)),
			(obr:=( obr :=   0				)),

			(obr:=( obr :=   4,	wht :=  0)),  	// 2. 3 zon		domcek	
			(obr:=( obr := 315				)),      		//	Privatna jednotka (byt)
			(obr:=( obr := 285				)),     			// vonkajsia zona
			(obr:=( obr :=  21,  			)),            // zona {vnutorna}
			(obr:=( obr := 277,  			)),				// spolocne priestory														
			(obr:=( obr :=   0,  			)),

			(obr:=( obr :=  70,	wht :=  0)),  	// 3. 23 VEN / ven    // ventilator
			(obr:=( obr := 194				)),                      // rekuperacia
			(obr:=( obr :=  70				)),
			(obr:=( obr :=  70,  			)),
			(obr:=( obr :=  70,  			)),																		
			(obr:=( obr :=   0,  			)),

			(obr:=( obr := 360,	wht :=  0)),  	// 4. 32    sir
			(obr:=( obr := 361				)),         // strobo
			(obr:=( obr := 362				)),         // zvoncekkop
			(obr:=( obr := 352,  			)),         // majak
			(obr:=( obr :=   0,  			)),			//        					
			(obr:=( obr :=   0,  			)),

			(obr:=( obr := 508,	wht :=  0)),  	// 5. 37 	gar
			(obr:=( obr := 216				)),        	// bra
			(obr:=( obr := 166				)),         // branicka
			(obr:=( obr :=  53,  			)),         // dvere - elektromagnet
			(obr:=( obr := 506,  			)),			// zavora						
			(obr:=( obr :=   0,  			)),

			(obr:=( obr := 235,	wht :=  0)),  	// 6. 46 MSG	spravy
			(obr:=( obr :=  93				)),        	// 	SMS
			(obr:=( obr :=  76				)),			// 	mail
			(obr:=( obr :=   0,  			)),
			(obr:=( obr :=   0,  			)),																		
			(obr:=( obr :=   0,  			)),

			(obr:=( obr := 161,	wht :=  0)),  	// 7.  6 TER
			(obr:=( obr := 162				)),        	// 	Room
			(obr:=( obr :=   0,				)),			// 	Out
			(obr:=( obr :=   0,  			)),
			(obr:=( obr :=   0,  			)),																		
			(obr:=( obr :=   0,  			))

		];	

		T10	: ARRAY[1.. 6,0..10] OF NH_DEV_OBR_F :=
		[	(obr:=( obr := 100, wht :=  0	)),	// 8 tve	       // TVE
			(obr:=( obr := 100           	)),		             // TVE-Teco
			(obr:=( obr := 191           	)),		             // Rohoz
			(obr:=( obr := 346           	)),		             // radiator
			(obr:=( obr := 347           	)),						 // bojler		
			(obr:=( obr := 100           	)),						 // servopohon/klapka		
			(obr:=( obr := 100           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),								

			(obr:=( obr := 102, wht :=  0	)),	// 13 wsb	
			(obr:=( obr := 102           	)),		
			(obr:=( obr := 103           	)),		
			(obr:=( obr := 103           	)),		
			(obr:=( obr := 104           	)),								
			(obr:=( obr := 104           	)),								
			(obr:=( obr := 104           	)),								
			(obr:=( obr := 104           	)),								
			(obr:=( obr := 109           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),											

			(obr:=( obr := 106, wht :=  0	)),	// 14 tla	
			(obr:=( obr := 106           	)),		
			(obr:=( obr := 107           	)),		
			(obr:=( obr := 105           	)),		
			(obr:=( obr := 105           	)),								
			(obr:=( obr := 105           	)),								
			(obr:=( obr := 105           	)),								
			(obr:=( obr := 105           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),								
			
			(obr:=( obr :=  73, wht :=  0	)),	// 21 zasuvka ON	
			(obr:=( obr :=  62           	)),			// 1 svetlo		
			(obr:=( obr :=  49          	)),		   // 2 stykac ON
			(obr:=( obr :=  54           	)),		   // 3 stykac OFF
			(obr:=( obr := 183           	)),			// 4 Ohrievac					
			(obr:=( obr := 340           	)),			// 6 ventilator					
			(obr:=( obr := 159           	)),			// 6 nabijacia stanica					
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr := 225				)),			// 9 HW-reset					
			(obr:=( obr :=   0				)),								
			
			(obr:=( obr := 314, wht :=  0	)),	// 41 cox
			(obr:=( obr := 313           	)),		 // co2
			(obr:=( obr := 314           	)),		// CO
			(obr:=( obr := 314           	)),		// propan
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)), 								

			(obr:=( obr :=  66, wht := 18	)),	// 6:  48 akcie alarmu
			(obr:=( obr := 287, wht := 13	)),		
			(obr:=( obr :=  68, wht := 15 )),		
			(obr:=( obr := 289, wht := 14	)),		
			(obr:=( obr := 351, wht := 22	)),								
			(obr:=( obr := 354, wht :=160	)),								
			(obr:=( obr := 355, wht := 38	)),								
			(obr:=( obr := 277, wht := 18	)),								
			(obr:=( obr :=  66           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)) 								


(*
		cf28  : ARRAY[0..10]	OF 	INT :=[ 66,287, 68,289,351,354,355, 66, 66, 66, 67];	// -191 , -170 , 48-ALA-obr
		wh28  : ARRAY[0..10] OF    INT :=[ 18, 13, 15, 14, 22,160, 38, 18, 18, 18, 16];	// -213 , 48-ALA-wh
*)


				];	
		T15	: ARRAY[1.. 2,0..15] OF NH_DEV_OBR_F :=
															  // 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70),	// 1 rom	
		[	(obr:=( obr := 291, wht :=  0	), fil := [0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),	// 43 DLS	// nedefinovane
			(obr:=( obr := 318           	), fil := [0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),		         // svetlo biele
			(obr:=( obr := 323           	), fil := [0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),		         // rgb
			(obr:=( obr := 326           	), fil := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),					// zas
			(obr:=( obr := 372           	), fil := [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),					// TVE	
			(obr:=( obr :=  70           	), fil := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),					// VENtilator
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),

			(obr:=( obr := 200,  wht :=  0)),	// ROOM		0 setup			
		 	(obr:=( obr :=  16				)),           	// 1 vnutorna miestnost
			(obr:=( obr :=  19				)),            // 2 vonkajsia miestnost
			(obr:=( obr :=  15				)),            // 3 podzemna miestnost
			(obr:=( obr := 155				)),            // 4 wellness
			(obr:=( obr := 374 				)),            // 5 sauna
			(obr:=( obr := 375           	)),				//	6 Relax			
			(obr:=( obr := 376           	)),				// 7 bazen				
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0           	)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				)),								
			(obr:=( obr :=   0				))

		];	
		
		obr	: ARRAY[0.._Nh_CFG]  OF NH_obr_WHT :=
  				[
				  	( obr :=  24   	 		),	//	 0
				  	( obr := -15,  wht := 2	),	//  1 rom
				  	( obr :=  10				),	//  2 cat
				  	( obr :=  -5,  wht := 2	),	//  3 zon
				  	( obr :=  29			  	),	//  4 scn
				  	( obr :=  27				),	//  5 act
				  	( obr := 183				),	//  6 het
				  	( obr :=  82				),	//  7 kot
				  	( obr := -10,  wht := 1 ),	//  8 tve
				  	( obr := 101				),	//  9 cer
				  	( obr :=  62				),	// 10 svd
				  	( obr :=  63				),	//	11	sva					  					  					  				  	
				  	( obr :=  64				),	// 12 rgb
				  	( obr := -10,  wht := 2	), // 13 wsb
				  	( obr := -10,  wht := 3	),	// 14 tla
				  	( obr :=  87				),	// 15 pir
//				  	( obr := 161				),	// 16 ter
				  	( obr := -5,	wht := 7	),	// 16 ter
				  	( obr := 163				),	// 17 teh
				  	( obr := 164				),	//	18 tek					  					  					  				  	
				  	( obr :=  86				),	// 19 lux
				  	( obr :=  59				),	// 20 fav
				  	( obr := -10,  wht := 4	),	// 21 zas
				  	( obr :=  78				),	// 22 usr
				  	( obr :=  -5,  wht := 3	),	// 23 VEN {rekuperacia}
				  	( obr :=  97				),	// 24 kla
				  	( obr := 297				),	//	25 smart way 					  					  				  	
				  	( obr :=   0				),	// 26 poi
				  	( obr := 108				),	// 27 h2o
				  	( obr :=  95				),	// 28 fir
				  	( obr :=  90				),	// 29 gas
				  	( obr := 114				),	// 30 mar
				  	( obr := 114				),	// 31 rol
				  	( obr :=  -5,  wht := 4	),	//	32 sir					  					  					  				  	
				  	( obr :=  91				),	// 33 dor
				  	( obr :=  92				),	// 34 win
				  	( obr := 197				),	// 35 bli
				  	( obr := 197				),	// 36 bli
				  	( obr :=  -5,  wht := 5	),	// 37 bra/gar
				  	( obr :=  53				),	// 38 rfi snimac
				  	( obr := 137				),	// 39 rfk
				  	( obr := 310				),	// 40 tgl
				  	( obr := -10,  wht := 5	),	//	41 cox   		  					  					  				  	
				  	( obr := 290				),	// 42 DLm
				  	( obr := -15,  wht := 1	),	// 43 DLs
				  	( obr := 333				),	// 44 DLg
				  	( obr := 297				),	// 45 SMV - smart way        a
				  	( obr :=  -5,  wht := 6	),	// 46 MSG
				  	( obr := 340				),	// 47 HEV
				  	( obr := -10,	wht := 6,),	// 48 ACT-ALARM
				  	( obr := 386				),	// 49 VVO - ventil vody/kurenia
				  	( obr := 295				),	// 50 TIM
				  	( obr := 258				),	// 51 RHX - vlhkost
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//					  					  					  					  				  	
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//					  					  					  					  				  	
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//
				  	( obr :=   0				),	//					  					  					  					  				  	
				  	( obr :=   0				),	//
				  	( obr :=   0				)	//
  				];		
	END_STRUCT

	NH_FRM_231  {HIDDEN} : STRUCT   // STAT DEV 					
//      typ	: USINT := 231;
      hed : NH_FRM_HED := (Name:='_231',wht:=0);
 		dev   : ARRAY[0..51,0..3] 	OF INT :=
		 		[
              24,	18, 	 24, 18,		//  0- nic
				  66, 18,	 -1,  1,    //  1-rom      // unlock /odchod
					0,  0,     0,  0,		//  2-cat
				  66, 18,    -1,  1,    //  3-ZON		// unlock /odchod
				   0, 10,  	207, 14,    //  4-SCN
				  34, 18,  	 34, 20,    //  5-ACT				
				   0, 10,  	  1,  0,    //  6-HET
				   0, 10,  	  0,115,    //  7-KOT
				   0, 10,  	  0,115,    //  8-TVE				
				   0, 10,  	  0,115,    //  9-CER				
				   0, 10,  	  0, 11,    // 10-SVD
				   0, 10,  	  0,110,    // 11-SVA
				   0, 10,  	  0,110,    // 12-RGB				
				   0,  0,  	  0,  0,    // 13-WSB
				   0,  0,  	  0,  0,    // 14-TLA
				  87, 18,  	 89, 16,    // 15-PIR
				   0,100,  	  0,100,    // 16-TER
				   0,100,  	  0,100,    // 17-TEH
				   0,100,  	  0,100,    // 18-TEK
				   0,101,  	  0,101,    // 19-LUX														
				 199,  0,  	198,  0,    // 20-FAV
				   0, 10,  	213, 13,    // 21-ZAS
				  78,  0,  	 78,  0,    // 22-USR
				   0, 10,  	  0,113,    // 23-VEN/REK				  									
				  97,  0,  	  0,  0,    // 24-KEY
				   0,  0,  	  0,  0,    // 25-SMART.W
				   0,  0,  	  0,  0,    // 26-POI
				   0,  0,  	  0,  0,    // 27-H2O
				   0,  0,  	  0,  0,    // 28-FIRE
				   0,  0,  	  0,  0,    // 29-GAS
				   0,  0,  	  0,  0,    // 30-MARkiza
//				 114,  0,  	115,  0,    // 31-ROL
				 116, 18,	-29,  0,    // 31-ROL    	// stat:=0 zatiahnuta roleta
				   0, 10,  	360, 23,    // 32-SIR
				  91, 18,  	363, 15,    // 33-DOR																	 																																												
				  92,  0,  	364, 15,    // 34-WIN
				  34, 18,  	 34, 20,    // 35-BLIkac
				   0,  0,  	  0,  0,    // 36
				 216, 18,  	-21,  0,    // 37-GATE : GAR/BRAna/BRAnicka/ZAVORA																																								
				 151,183,  	151, 13,    // 38-RFID snimace
				   0,  0,  	  0,  0,    // 39-RFID karty
				 310,  0,  	310,  0,    // 40-TGL
				   0,101,  	  0,101,    // 41-COx
				   0, 10,  	-11,  0,    // 42-DLM
				   0, 10,  	  0,110,    // 43-DLs
				   0, 10,  	207, 14,    // 44-DLg				
				 340,  0,  	341,  0,    // 45-SmartWay
				 34,  18,  	 34, 20,    // 46-MSG/SMS/MAIL
				  34, 18,  	 34, 20,    // 47-
				  34, 18,  	 34, 20,    // 48-ACT				
				   0, 10,  	  0,103,    // 49-VVO
				   0, 10,  	 34, 20,    // 50-TIM
				   0,101,  	  0,101     // 51-RH
				];
				

		sta   : ARRAY[ 0..50,0..1] OF INT :=
		 		[
					 66, 18,				//	[0,0] [0,1] 		// 60 stat= 0 odkodovane
					287, 13,				// [1,0] [1,1]      	// 61 stat:=1 odchod   	orange/outgoing
					 68, 15,          // 2       				// 62 stat:=2 locked   	zamok/sveto-cerveny gradient 15
					289, 14,				//	3      				// 63 stat:=3 prichod  	cierny prichod/orange gradient
					351, 22,				//	4				  		// 64 stat:=4 dog 		cierny pes/orange gradient
					354,160,				//	5						// 65 stat:=5 Narusenie cierny majak/svetlo-fialovy gradient
					355, 38,				//	6						// 66 stat:=6 Alarm 		biely majak+sirena/tmavo-fialovy bez gradientu
					 66, 18,				//	7						// free
					 68, 18,				//	8						// free
					 66, 18,				//	9						// volne
					 68, 14,          // 10       			// stat:=2 locked   zamok-polozamknuty/sveto-cerveny gradient 15
					  // DLm
				     0,113,    		// 11						// stat:=1,   LVL>0.0	
				     0,112,          // 12       			// stat:=2,  QUERY  - vsetky  //refprit.ballastov -102 = text 102 z ob^.fmt , 20=wht
				     0,114,          // 13       			// stat:=3,  RND    - nove adresy

				  -102, 22,          // 14       			// stat:=4,  QUERY  sta:= 4; do ktorych scen patri ballast
				  -102, 22,          // 15       			// stat:=5,  QUERY  sta:= 5; LVL dev vo vsetkych scenach
				  -102, 37,          // 16       			// stat:=6,  QUERY  sta := 6; vyhladat nove ballasty
				  -102, 37,          // 17       			// stat:=7,  QUERY  sta := 7; volne - asi
				  -102, 38,          // 18       			// stat:=8,  QUERY  sta = 8 vymaat 1.adres
				  -102, 38,          // 19       			// stat:=9,  QUERY  sta:= 9; vymazat vsetky adresy
				  -102, 38,          // 20       			// stat:=9,  QUERY  sta:= 9; vymazat vsetky adresy


					  // GATE

				   510, 15,    		// 21						// stat:=1,    garaz
				   217, 15,    		// 22						// stat:=2,    brana
				   365, 15,    		// 23						// stat:=3,    branicka
				   363, 15,    		// 24						// stat:=4,    dvere
				   505, 15,    		// 25						// stat:=5,    zavora
				   217, 15,    		// 26						// stat:=6,    nic
				   117, 23,    		// 27						// stat:=7,		sipka hore = otvara sa
				   118, 23,    		// 28						// stat:=8,		sipka dolu = zatvara sa		  				
					// ROL

				   114, 37,    		// 29						// stat:=1,    roleta povytiahnuta > 0%, lamely otvorene >0%
				   498, 28,    		// 30						// stat:=2,    roleta zatiahnuta na 0% ale lamely ootvorene >0%
				   117, 23,    		// 31						// stat:=3,		lamely sa otvaraju pohybom hore  {otvorena lamela}
				   117, 23,    		// 32						// stat:=4,		roleta sa otvara smerom hore 		{sipka hore}
				   118, 23,    		// 33						// stat:=5,		lamely sa zaklapaju nadol        {zatvorena lamela}
				   118, 23,   			// 34						// stat:=6,		roleta sa zatvara nadol				{sipka dolu}
				    84, 23,   			// 35						// stat:=7,		bezi predlzeny dojazd = kalibracia

(*
				   116, 30,    		// 29						// stat:=1,    povytiahnuta roleta (otvorene lamely)
				   500, 30,    		// 30						// stat:=2,		lamely sa otvaraju pohybom hore  {otvorena lamela}
				   117, 30,    		// 30						// stat:=3,		roleta sa otvata smerom hore 		{sipka hore}
				   500, 30,    		// 30						// stat:=2,		lamely sa otvaraju pohybom hore  {otvorena lamela}
				   118, 30     		// 31						// stat:=4,		sipka dolu = zatvara sa		  				
*)

				];

(*
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 42 DALI-M  0=OFF,
                          wht := [ 10,110,111,112,114,115]),            // 1=ON-LVL z al.ou.val 1..254,
                                                                        // 2=Scan = zeleny
                                                                        // 3:=LVL,PAR....Oranzovy
                                                                        // 4 RANDOME ID
                                                                        // 5 Err
                        ( obr := [  0,  0,  0,  0,  0,  0],          // 43 DALI-slave  : 0=OFF,1=LVL,2=ERR
                          wht := [ 10,110,117,  0,  0,  0]),

                        ( obr := [  0 , 0,336,  0,  0,  0],          // 44 DALI-group
                          wht := [ 10,110, 14,  0,  0,150]),

                        ( obr := [340,341,342,343,  0,  0],          // 45 Regulator RVE
                          wht := [  0,  0,  0,  0,  0,  0]),
                        ( obr := [  0,  0,  0,  0,  0,  0],          //45 H2O
                          wht := [  0,  0,  0,  0,  0,  0])
                        ];

*)

	END_STRUCT;
	



   NH_FRM_234 : STRUCT
      hed : NH_FRM_HED := (Name:='_234',desc:='Fil.Dev[],iov,io',wht:=0) ;
      rom : ARRAY[199..204] OF FILT_LIST := [
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1,1,1,1,1,0,0,0,1,0,1,0,1,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]), // 199 DEV bez miestnosti
            (n := [0,0,0,0,1,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]), // 200 1 miestnost / RUN
            (n := [0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,0,0,1,0,1,0,0,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]), // 201 1 miestnost / SETUP
            (n := [0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,0,1,1,0,0,1,0,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]), // 202 1 miestnost / SECURITY DEV

            (n := [0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,0,1,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]), // 203 #setup miestnost typ=0

            (n := [0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])  // 204 1 admin
         ];

      zon : ARRAY[200..201] OF FILT_LIST := [
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	      60       65
            (n := [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]), //  zona - RUN
            (n := [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])  //  zona - Admin SETUP
         ];

      set : ARRAY[70..80] OF FILT_LIST := [
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,1,0,0]),    //  70 pridelit DEV do ROM
            (n := [0,1,0,1]),    //  71 volne
            (n := [0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),    //  72 SEtUP-LIST HET v hlavicke
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),    //  73 SEtUP-LIST HET-VEN v hlavicke
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),    //  74 SETUP-LIST TVE v hlavicke
            (n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),    //  75 SETUP-LIST KOT v hlavicke
            (n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),    //  76 SETUP-LIST CER v hlavicke
            (n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),    //  77 SETUP-LIST VEN v hlavicke
            (n := [0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     //  78 SETUP-LIST TER
            (n := [0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),    //  79 SETUP-LIST LUX
            (n := [0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])     //  80 SETUP-KEY
         ];

      iov : ARRAY[0.._Nh_CFG] OF FILT_LIST := [    // v hlavicke je RIADOK a v STLPCOCH su DEV, ktore ho mozu spustat (budu v prowse pre vyber)
            (),     	//  0 Empty
            (),    	//  1 Rmpty Rom
            (),    	//  2 Empty Cat
            (),    	//  3 Empty Zon
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  4 scn  sceny
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  5 act  akcie
            (n := [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  6 het  modul kurenia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  7 kot  kotol
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  8 TVE  termoventil,spirala
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  9 CER  obehove cerpadlo
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 10 SVD  svetlo digital
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 11 SVA  svetlo stivatelne
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 12 RGB  svetlo farebne
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 13 WSB  ovladac WSB
            (n := [0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 14 TLA  tlacitka
            (n := [0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,1,1,0,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 15 pir
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 16 teR  teplota-miestnost
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 17 teH  teplota-teleso
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 18 teK  teplota-kotol
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 19 lux  intenzita osvetlenia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 20 FAV
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 21 ZAS  spotrebice
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 22 USR  uzivatelia
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 23 VEN/REK-uperacia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 24 KEY
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 25 RZV - casovy rozvrh PO-NE
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 26 POI - slider
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 27 H2O
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 28 FIRe - len ON/OFF : poziar,dym,CO,CO2,butan...
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 29 GAS // intenzita (real) CO,CO2,metan,butan,RH
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 30 MAR garaz,brana,branicka
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 31 ROL rolety
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 32 SIR sirena,stroboskop,zvoncek
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 33 DOR
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 34 WIN
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 35 BLK
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 36    XXX*BLx
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 37 BRA,GAR....
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 38 RFI
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 39 RFK

            (n := [0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 40 TGL
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 41 COX
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 42 DALI*M
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 43 DALI - S
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 44 DALI - GRP
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 45 SMW - smart way
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 46 MSG
            (n := [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 47 HEV {HET=rekuperacia}
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 48 ALA {akcia alarmu}
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 49 VVO
            (n := [0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])      // 50 TIM
         ];

      in : ARRAY[0.._Nh_CFG] OF FILT_LIST := [ // riadok sa spyta, ci je IN oproti DEV v hlavicke=STLPEC
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0]) ,    //  0  ken pre zachytenie chyby, ked sa odkazuje cf=0
            (n := [0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0]) ,    //  1 rom  miestnosti
            (n := [0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0]) ,    //  2 cat  kategorie
            (n := [0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  3 zon  zony
            (n := [1,1,1,1,1,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  4 scn  sceny
            (n := [0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  5 act  akcie
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  6 het  modul kurenia
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  7 kot  kotol
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  8 tve  termoventil,spirala
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  9 cer  obehove cerpadlo
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 10 svd  svetlo digital
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 11 sva  svetlo stievatelne
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 12 rgb  svetlo farebne
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]) ,    // 13 wsb  ovladac WSB
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]) ,    // 14 tla  tlacitka
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]) ,    // 15 pir
            (n := [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]) ,    // 16 teR  teplota miestnost
            (n := [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]) ,    // 17 teH  teplot radiator
            (n := [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]) ,    // 18 teK  teplota kotol
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0]) ,    // 19 lux  intenzita osvetlenia
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 20 FAV
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 21 ZAS  spotrebice
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 22 Usr  uzivatelia

            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 23 VEN
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),     // 24 KEY
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0]),     // 25 PRG - casovy program
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 26 Stykace - okruhy
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),     // 27 H2O
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),     // 28 FIRe - len ON/OFF : poziar,dym,CO,CO2,butan...
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),     // 29 GAS // intenzita (real) CO,CO2,metan,butan,RH
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 30 MAR
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 31 ROL rolety
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 32 SIR sirena,stroboskop,zvoncek
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),     // 32 DOR
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),     // 34 WIN
            (n := [0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 35 BLK
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 36 XXX
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 37 BRA
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 38 RFI
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 39 RFK
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]),     // 40 TGL
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 41 BTN
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 42 DL-ma
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 43 DL-slave
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 44 DL-group
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 45 SMW
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 46 MSG
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 47 HEV
            (n := [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 48 ALA
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 49 VVO
            (n := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])      // 50 TIM
				
				];
   END_STRUCT

   NH_FRM_235   {HIDDEN}     : STRUCT
//      typ : USINT := 235;
      hed : NH_FRM_HED := (Name:='_235',wht:=0) ;
      DevToCat : ARRAY[0.._Nh_CFG] OF FILT_LIST := [   // DEV (v riadku) vstupuje do CAT (stlpec)
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
// 1          	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// ROM
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // ZON
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SCN
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// ACT
			(n := [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 6  HET
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 7 KOT
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 8 TVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 9 CER
			(n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	//10 SVE
// 11         	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// sva
			(n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 16 ter
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 17 teh
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 18 tek
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 18 lux
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 20 fav
// 21         	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 21 zas
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 22 usr
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 23 rek = TVE pre vetranie
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 24 key
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
// 31         	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SIR
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // DOR
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// WIN
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
// 41         	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	//
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // 46 MSG
			(n := [0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 47 HEV - regulator vetrania
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// 48 ALA
			(n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),  // VVO
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
// 51         	 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65        70
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	

			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),
			(n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),	// SVE

			()
			];

   END_STRUCT


   NH_FRM_236     {HIDDEN}    : STRUCT
//      typ : USINT := 236;
      hed : NH_FRM_HED :=(Name:='_236',desc:='Dev-list:ACT,SCN,',wht:=0) ;
		rgbwa	: FILT_LIST := // zoznam DEV (v riadku) ktore maju DLs {vhlavicke) vo svojom HW vratane RGBWA
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
				(n := [0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);     //  HW vazby DLs k DEV vratane RGBWA
      lst : ARRAY[0.._Nh_CFG] OF FILT_LIST := [ // v riadku je DEV z hlavicky a stlpce su DEV ktore mozu byt v LISTE (ACT,SCN,BLK..)
            (),     //  0 prazdne               napr (ACT->GAT,SVx,SCN...)
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     //  1 rom  miestnosti (vsetko)
            (n := [0,0,1]),    //  2 cat ... len cat
            (n := [0,1,0]),    //  3 zone/subj - len miestnosti
            // 4                                                                                                                                              //  toto je v HLAVICKE
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  4 scn  sceny
            (n := [0,0,0,0,1,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  5 act  akcie
            (n := [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  6 het  modul kurenia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  7 kot  kotol

            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  8 TVE  termoventil,spirala
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  9 CER  obehove cerpadlo
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 10 SVD  svetlo digital
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 11 SVA  svetlo stivatelne
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 12 RGB  svetlo farebne
            (n := [0,0,0,0,0,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 13 WSB  ovladac WSB
            (n := [0,0,0,0,0,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 14 TLA  tlacitka
            (n := [0,0,0,0,0,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 15 pir
            (n := [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 16 teR  teplota-miestnost
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 17 teH  teplota-teleso
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 18 teK  teplota-kotol
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 19 lux  intenzita osvetlenia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 20 FAV
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 21 ZAS  spotrebice
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 22 USR  uzivatelia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 23 VENT+REK-uperacia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 24 KEY
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 25 RZV - casovy rozvrh PO-NE
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 26 POI - slider
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 27 H2O
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 28 FIRe - len ON/OFF : poziar,dym,CO,CO2,butan...
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 29 GAS // intenzita (real) CO,CO2,metan,butan,RH
            (n := [0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 30 MAR garaz,brana,branicka
            (n := [0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 31 ROL rolety
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 32 SIR sirena,stroboskop,zvoncek
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 33 DOR
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 34 WIN
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 35 BLK
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 36    XXX*BLx
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 37 BRA,GAR....
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 38 RFI
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 39 RFK
            (n := [0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 40 TGL
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 41 COX
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 42 DALI*M
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 43 DALI - S
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 44 DALI - GRP
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 45 SMW - smart way
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 46 MSG
            (n := [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 47 HEV {HET pre vetranie}
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 48 ALA akce ALArmu
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])      // 49 VVO
         ];
				  // vazby dev , externe vazby, HET,HEV ....
      iodev : ARRAY[0.._Nh_CFG] OF FILT_LIST := [ // v riadku je DEV z hlavicky a stlpce su DEV ktore mozu byt v LISTE (ACT,SCN,BLK..)
            (),     //  0 prazdne               napr (ACT->GAT,SVx,SCN...)
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),        //  1 rom  miestnosti (vsetko)
            (n := [0,0,1]),    //  2 cat ... len cat
            (n := [0,1,0]),    //  3 zone/subj - len miestnosti
            // 4                                                                                                                                              //  toto je v HLAVICKE
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  4 scn  sceny
            (n := [0,0,0,0,1,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  5 act  akcie
            (n := [0,1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  6 het  modul kurenia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  7 kot  kotol

            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  8 TVE  termoventil,spirala
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    //  9 CER  obehove cerpadlo
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 10 SVD  svetlo digital
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 11 SVA  svetlo stivatelne
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 12 RGB  svetlo farebne
            (n := [0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 13 WSB  ovladac WSB
            (n := [0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]) ,    // 14 TLA  tlacitka
            (n := [0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 15 pir
            (n := [0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 16 teR  teplota-miestnost
            (n := [0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 17 teH  teplota-teleso
            (n := [0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 18 teK  teplota-kotol
            (n := [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 19 lux  intenzita osvetlenia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 20 FAV
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 21 ZAS  spotrebice
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 22 USR  uzivatelia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) ,    // 23 VEN+REK-uperacia
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 24 KEY
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 25 RZV - casovy rozvrh PO-NE
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 26 POI - slider
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 27 H2O
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 28 FIRe - len ON/OFF : poziar,dym,CO,CO2,butan...
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 29 GAS // intenzita (real) CO,CO2,metan,butan,RH
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 30 MAR garaz,brana,branicka
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 31 ROL rolety
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 32 SIR sirena,stroboskop,zvoncek
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 33 DOR
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 34 WIN
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 35 BLK
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 36    XXX*BLx
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 37 BRA,GAR....
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 38 RFI
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 39 RFK
            (n := [0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]),     // 40 TGL
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 41 COX
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 42 DALI*M
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 43 DALI - S
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 44 DALI - GRP
            (n := [0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 45 SMW - smart way
//                 0         5         10        15        20        25        30        35	      40        45	     50        55	       60        65
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),     // 46 MSG
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]),      // 47 HEV {HET pre vetranie}
            (n := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])      // 48 HEV akce ALArmu
         ];
   END_STRUCT


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

  	NH_ROW_H  {HIDDEN}  :  STRUCT       // hlavicka RIADKA
      cf       : NH_DEV_IO;                           // cf,nd,par
      nd       : INT;                                 // fyzicke poradove cislo vety v CFG
      sld      : BOOL;                                // ma slider (cislo slider je to iste ako cislo riadka)
      in       : BOOL;                                // tato veta je vo vazbe v xVaz^.in
      btn      : BOOL;                                // priznak, ze nad WSB treba zobrazit BTN, ktory jestlaceny, alebo nakonfigurovany
      chk      : BOOL;                                // zaskrtnuty CHK v riadku - pre Vaz[2]
      dlg      : BOOL;                                // v riadku je vazba DALI sceny -> dalia slave > DLg->DLs
//      del      : BOOL;                                // tento riadok ma objekt del/copy
		pir		: BOOL;											// v riadku je pir
		new      : BOOL;											// uz bola natiahnuta definica, riadi sa teraz druhom refreshu					
   END_STRUCT




	NH_POI_DAYWRK {HIDDEN}: NH_POI := ( cx := ( p:= [         // DayMode  Jeden pracovny den
                           ( t :=   0,  o := 2),   // night    0:00
                           ( t := 330,  o := 3),   // morning  5:30 //330
                           ( t := 390,  o := 0),   // day      6:30
                           ( t :=1080,  o := 1),   // evening 18:00
                           ( t :=1380,  o := 2),   // 23:0;
                           ( t :=1440,  o := 2)    // 24:0;
                   ]));
   NH_POI_DAYFRE  {HIDDEN} : NH_POI := ( cx := ( p:= [        // sobota/nedela/sviatok
                           ( t :=   0,  o := 2),   // night    0:00
                           ( t := 450,  o := 3),   // morning  7:30  //450
                           ( t := 480,  o := 0),   // day      8:00
                           ( t :=1080,  o := 1),   // evening 18:00
                           ( t :=1440,  o := 1)    // 24:0;
                   ]));

  	NH_POI_WDAY {HIDDEN}:  STRUCT 	
      PON       : NH_POI_DAYWRK ;                  // pondelok
      UTO       : NH_POI_DAYWRK ;                  // utorok
      STR       : NH_POI_DAYWRK ;                  // streda
      STV       : NH_POI_DAYWRK ;                  // stvrtok
      PIA       : NH_POI_DAYWRK ;                  // piatok
      SOB       : NH_POI_DAYFRE ;                  // sobota
      NED       : NH_POI_DAYFRE ;                  // nedela
      FRE       : NH_POI_DAYFRE ;                  // volny den /sviatok
      ALL       : NH_POI := ( cx := ( p:= [        // plny dom (party)
                           ( t :=   0,  o := 1),   // night    0:00
                           ( t :=  60,  o := 2),    // 24:0;
                           ( t := 480,  o := 3),   // morning  8:00
                           ( t := 540,  o := 0),   // day      9:00
                           ( t :=1020,  o := 1),   // evening 21:00
                           ( t :=1440,  o := 1)    // 24:0;
                   ]));
      OUT       : NH_POI_DAYWRK ;                  // Out
      HOL       : NH_POI_DAYWRK ;                  // Holiday
   END_STRUCT;

   NH_POI_HETWRK {HIDDEN} : NH_POI := ( cx := ( p:= [       // HET  Jeden pracovny den
                           ( t :=   0,  o := 1),   // utlm     0:00
                           ( t := 360,  o := 3),   // komfort  6:00
                           ( t := 450,  o := 1),   // utlm     7:30
                           ( t := 960,  o := 3),   // komfort 16:00
                           ( t :=1380,  o := 1),   // utlm    22:30;
                           ( t :=1440,  o := 1)    // utlm    24:00;
                   ]));
   NH_POI_HETFRE {HIDDEN} : NH_POI := ( cx := ( p:= [       // HET  volny den
                           ( t :=   0,  o := 1),   // utlm     0:00
                           ( t := 420,  o := 3),   // komfort  7:00
                           ( t :=1380,  o := 1),   // utlm    23:00
                           ( t :=1440,  o := 1)    // utlm    24:00;
                   ]));
  	NH_POI_WHET  {HIDDEN} :  STRUCT 	
      PON       : NH_POI_HETWRK ;                  // pondelok
      UTO       : NH_POI_HETWRK ;
      STR       : NH_POI_HETWRK ;
      STV       : NH_POI_HETWRK ;
      PIA       : NH_POI_HETWRK ;
      SOB       : NH_POI_HETFRE ;
      NED       : NH_POI_HETFRE ;
      FRE       : NH_POI_HETFRE ;
      ALL       : NH_POI_HETFRE ;
      OUT       : NH_POI   := ( cx := ( p:= [
                           ( t :=   0,  o := 1),   // utlm     0:00
                           ( t :=1440,  o := 1)    // utlm    24:00;
                   ]));
      HOL       : NH_POI   := ( cx := ( p:= [
                           ( t :=   0,  o := 0),   // protimraz    0:00
                           ( t :=1440,  o := 0)    // protimraz    24:00;
                   ]));
   END_STRUCT;

   NH_POI_VENWRK {HIDDEN} : NH_POI := ( cx := ( p:= [       // HEV  Jeden pracovny den
                           ( t :=   0,  o := 0),   //
                           ( t := 300,  o := 3),   // 5:00
                           ( t := 315,  o := 0),   // 5:15
                           ( t := 720,  o := 3),   // 12:00
                           ( t := 735,  o := 0),   // 12:15
                           ( t :=1080,  o := 3),   // 18:00
                           ( t :=1095,  o := 0),   // 18:15
                           ( t :=1440,  o := 0)    //    24:00;
                   ]));

  	NH_POI_WVEN {HIDDEN} :  STRUCT 	
      PON       : NH_POI_VENWRK ;                  // pondelok
      UTO       : NH_POI_VENWRK ;
      STR       : NH_POI_VENWRK ;
      STV       : NH_POI_VENWRK ;
      PIA       : NH_POI_VENWRK ;
      SOB       : NH_POI_VENWRK ;
      NED       : NH_POI_VENWRK ;
      FRE       : NH_POI_VENWRK ;
      ALL       : NH_POI_VENWRK ;
      OUT       : NH_POI_VENWRK ;
      HOL       : NH_POI_VENWRK ;

   END_STRUCT;


  	NH_FRM_249  {HIDDEN} :  STRUCT          // sablona typovych dni
      hed   : NH_FRM_HED := (Name:='_249',row:=1,desc:='Typove dni');
      DAY   : NH_POI_WDAY;             // DAY   : PO-NE
      HET   : NH_POI_WHET;             // HET   : PO-NE
      VEN   : NH_POI_WVEN;             // VEN   : PO-NE
   END_STRUCT;


   NH_FRM_247	{HIDDEN}   : STRUCT
      hed      : NH_FRM_HED := (Name:='_247',wht:=0,row:=2,desc:='Typ.Day+Time slider');
      txt   : ARRAY[0..2] OF INT := [555,223,223]; 										// texty v hlavicke - riadok 1		
      poi   : ARRAY[0..3] OF NH_POD_CFG :=
                              [  (),                                            // DayMode sa preberie ako default
                                 (  tim := false,  typ := 1,  n := 7,  o := 3,  // HetMode sa zadefinuje
                                     vo := ( o := [
                                                      ( o := 171,  c := 4),      // 0 - vlocka
                                                      ( o := 173,  c := 8),      // 1
                                                      ( o := 175,  c := 6),      // 2
                                                      ( o := 177,  c := 7)]),    // 3
                                   ),
                                 (  tim := false,  typ := 2,  n := 7,  o := 3,  // VEN sa zadefinuje
                                     vo := ( o := [
                                                      ( o :=  54,  c := 4),      // 0 - off
                                                      ( o := 173,  c := 8),      // 1
                                                      ( o := 175,  c := 6),      // 2
                                                      ( o := 177,  c := 7)]),    // 3
                                    ),

                                 (  tim := false,  typ := 3,  n := 4,  o := 3,  // hyst REG
                                     vo := ( o := [
                                                      ( o :=  54,  c := 4),      // 0 - off
                                                      ( o := 173,  c := 8),      // 1
                                                      ( o := 175,  c := 6),      // 2
                                                      ( o := 177,  c := 7)]),    // 3
                                    )

                               ];

   	ini 	: NH_FRM_249;
   END_STRUCT


   NH_FRM_260_DATA	{HIDDEN} : STRUCT
		mWsb		: USINT;
		typ		: SINT := -1;
		cf			: NH_OBJ_123_CF;
		txt		: NH_PI14;
		pvCmd    : NH_PV18;				//click 1-5, P,H  [switch,0,0,0,0,Push,Hold,0]
	END_STRUCT

   NH_FRM_260	 : STRUCT
      hed : NH_FRM_HED := (Name:='_260',desc:='Prepincie menu');
		grp		: USINT;				// skupina do ktorej DEV patri
		typ		: SINT := 0;      // pripadny konkretny typ DEV
		i			: USINT;
		m			: USINT;
		nWsb		: USINT := 20;   	// max pocet predvolieb
		mWsb		: ARRAY[0..20] OF NH_FRM_260_DATA := [
						( mWsb := 0,  	cf := (rw2 := 4,x:=180,y:=500),
												txt := [80,81,616,83], 									// 0 default SVD,ZAS : Nic/prepnut/zapnut/vypnut
//												cmd := [ 0, 2, 11,10]),									// cisla prikazov
												//Click  1  2  3  4  5 Pr Hl xx
											 pvCmd := [ 2, 0, 0, 0, 0, 0, 0, 0]),									// predvolba do pWsb.cmd[click1,2,3,4,5,Push,Hold,rezerva]


						( mWsb := 4, typ:=1,  	cf:= (rw2:= 8), 	
												txt := [80,626,625,179,182,188,189,178],     	// ROL				Nic/Start*Stop/Natacat Lamly/Vytiahnut Hore/Zatihmut dolu/Lamely otvorit/Lam.Zatvorit/Predvolba
//												cmd := [ 0,23,  24, 10, 11, 26, 27, 14]),	
												//Click  1  2  3  4  5 Pr Hl xx
											 pvCmd := [23,10,11,26,27,24, 0, 0]),						
						( mWsb := 4, typ:=2,  cf:=(rw2 := 7),
												txt := [80,181,618,619,183,178,72],  				// GAT{0=garaz,1=brana}		Nic/Start-stop/OtvoritZatvorit/Stop/Predvolba/Potvrdit zatvorene
//												cmd := [ 0,  2, 11, 10,  3, 14,51])						
											 pvCmd := [ 2, 0, 0, 0, 0,51, 0, 0]),									// predvolba do pWsb.cmd[click1,2,3,4,5,Push,Hold,rezerva]
						( mWsb := 4,  	cf:= (rw2:= 6), 			
												txt := [80,81,82,159,83,84],			  				// SCN     Nic/prepnut/PV/Zapnut(100)/vypnut/stmievat
//												cmd := [ 0, 2,14, 11,10, 6]),	
											 pvCmd := [ 2,11,10,14, 0, 6, 0, 0]),				

						( mWsb := 5, typ:=1,  	cf:= (rw2:= 7), 	
												txt := [80,178,179,182,188,189,183],     	// ROL				Nic/Predvolba/Vytiahnut Hore/Zatiahmut dolu/Lamely otvorit/Lam.Zatvorit/Stop
//												cmd := [ 0,14, 10, 11, 26, 27, 3]),	
												//Click  1  2  3  4  5 Pr Hl xx
											 pvCmd := [14,10,11,26,27, 3, 0]),						
						( mWsb := 5, typ:=2,  cf:=(rw2 := 7),
												txt := [80,181,618,619,183,178,72],  				// GAT{0=garaz,1=brana}		Nic/Start-stop/OtvoritZatvorit/Stop/Predvolba/Potvrdit zatvorene
//												cmd := [ 0,  2, 11, 10,  3, 14,51])						
											 pvCmd := [ 2, 0, 0, 0, 0,51, 0, 0]),									// predvolba do pWsb.cmd[click1,2,3,4,5,Push,Hold,rezerva]
						( mWsb := 5,  	cf:= (rw2:= 4,x:=110), 	
												txt := [80,118,159,83],				  					// ACT        	  	Nic/vykonat akciu/Zapnut(100)/vypnut
//												cmd := [ 0, 14, 11,10]),	
											 pvCmd := [14, 0, 0, 0, 0, 0, 0, 0]),				
						( mWsb := 6,  	cf:= (rw2:= 6,x:=140),
												txt := [80,154,155,156,157,223],						// HET        	  	Nic/off/1/2/3/Auto
//											  Cmd := [ 0, 31, 32, 33, 34, 30]),	
											 pvCmd := [32,33,34,31, 0,30, 0, 0]),						
						( mWsb :=11,  	cf:= (rw2:= 6), 	
												txt := [80,81,82,159,83,84],							// SVA,RGB        Nic/Prepnut/zapnut(PV)/Zapnut(100)/vypnut/stmievat
//												cmd := [ 0, 2,14, 11,10, 6]),	
												//Click  1  2  3  4  5 Pr Hl xx
											 pvCmd := [ 2, 0, 0, 0, 0, 6, 0, 0]),									// predvolba do pWsb.cmd[click1,2,3,4,5,Push,Hold,rezerva]
						( mWsb :=31,  	cf:= (rw2:= 9), 	
												txt := [80,181,180,179,182,188,189,178,183],     	// ROL				Nic/Start*Stop/Natacat Lamly/Vytiahnut Hore/Zatihmut dolu/Lamely otvorit/Lam.Zatvorit/Predvolba
//												cmd := [ 0, 2, 25, 10, 11, 26, 27, 14, 3]),	
												//Click  1  2  3  4  5 Pr Hl xx
											 pvCmd := [ 2,10,11,26,27,25, 3, 0]),						

						// ak ma skupina viac typov, prve musia byt najs konkretne typy, a za za nimi na koniec -1
						( mWsb :=37, typ:=2,cf:=(rw2:=3), 		
												txt := [80,617,72],      								// GAT{dvere}		Nic/Otvorit/Potvrdit zatvorene
//												cmd := [ 0, 2, 51]),	
											 pvCmd := [ 2, 0, 0, 0, 0,51, 0, 0]),									// predvolba do pWsb.cmd[click1,2,3,4,5,Push,Hold,rezerva]
						( mWsb :=37, typ:=3,  cf := (rw2 := 3),
												txt := [80,617,72],      								// GAT{branicka}	Nic/Otvorit/Potvrdit zatvorene
//												cmd := [ 0, 2, 51]),	
											 pvCmd := [ 2, 0, 0, 0, 0,51, 0, 0]),									// predvolba do pWsb.cmd[click1,2,3,4,5,Push,Hold,rezerva]
						( mWsb :=37,  cf:=(rw2 := 7),
												txt := [80,181,618,619,183,178,72],  				// GAT{0=garaz,1=brana}		Nic/Start-stop/OtvoritZatvorit/Stop/Predvolba/Potvrdit zatvorene
//												cmd := [ 0,  2, 11, 10,  3, 14,51])						
											 pvCmd := [ 2, 0, 0, 0, 0,51, 0, 0])									// predvolba do pWsb.cmd[click1,2,3,4,5,Push,Hold,rezerva]
					];	
	END_STRUCT


   NH_LOG_IMP       : STRUCT   // struktura EVN-log
		ok				: STRING[1]:=' ';  		sok	: BYTE := 16#3b;
		cf				: STRING[3];   			s1 	: BYTE := 16#3b;
      cfg         : STRING[3];     			s2 	: BYTE := 16#3b;
      ID          : STRING[5];   			s6 	: BYTE := 16#3b;         // nacitane z exportu
  		inv			: string[1]:='0';      	s3i 	: BYTE := 16#3b;			 // on/off	
  		typ			: string[1]:='0';      	s3 	: BYTE := 16#3b;
  		typYes		: string[1]:='N';      	sy 	: BYTE := 16#3b;				// prepisuje sa typ
		d				: STRING[1]:='0';			d2 	: BYTE := 16#3b; 				//	hw.d[d]
      HWs         : STRING[8];      		sa 	: BYTE := 16#3b;
		HWtyp			: STRING[1]:= '0';		d22 	: BYTE := 16#3b;
      IO          : STRING[1];      sb 	: BYTE := 16#3b;         // I=vstup, Q=vystup, M=pamat
      MEM         : STRING[1];      sc 	: BYTE := 16#3b;         // 0=BOOL,1=REAL,
      RomID       : STRING[3]:='   ';     s7 	: BYTE := 16#3b;         // RomID, ktore sa bude hladat v xRom^.cf.ID
      Rom         : STRING[3]:='   ';     s5 	: BYTE := 16#3b;         // cislo vety rom {nd}
      typRom      : STRING[1]:=' ';    	s4 	: BYTE := 16#3b;			 // 0=admin,1=vnutorna,2=vonkajsia,3=podzemna,4=wellmess,5=sauna
      Name        : STRING[20];     s8 	: BYTE := 16#3b;
      NameCf      : STRING[20];     s81 	: BYTE := 16#3b;          		// aktualny nazov v CFG
      Cr       	: BYTE   := 16#0D;
      Lf       	: BYTE   := 16#0A;
	END_STRUCT;


   NH_FRM_500	{HIDDEN}   : STRUCT
      hed      : NH_FRM_HED := (Name:='_500',desc:='Import from CIB');
		rImp		: NH_LOG_IMP;
		eImp 		: NH_LOG_IMP;
   END_STRUCT




	NH_brw_D1_BLK    {HIDDEN}  :  NH_OBJ_DAT  :=          // PIR
      (wh:=0, x:=125,  y:=109,  w:=48, h:= 68, FgC:=4,  BgC:=2,  fn:=0, cf:=(c:=0) ); // 5 Blk
	NH_brw_D1_PIR    :  NH_OBJ_DAT  :=          // PIR
      (wh:=0, x:=125,  y:=109,  w:=50, h:=68 , FgC:=7,  BgC:=2,  fn:=0, cf:=(c:=5)); // 6 PIR day mode

	NH_OBJ_LIST   :  NH_OBJ_DAT  :=          // obrazok dev list
      (wh:=1, x:=x2-110,y:=109,w:=48, fn:=39, cm:=80); // 6 list DEV

	NH_brw_OBJ  {HIDDEN}   :  STRUCT
		list		: NH_OBJ_LIST;
		dlgl		: NH_OBJ_LIST := (fn:=333);
		rgbwa		: NH_OBJ_DAT  := (wh:=20, x:=125,  y:=109,  w:=50, h:=60 , FgC:=11,  BgC:=2,  fn:=0, cf:=(c:=4,n:=0,p:=0)); // 5 RGBWA na sebe
		srgbwa	: NH_OBJ_DAT  := (wh:=20, x:=x2-110,  y:=109,  w:=50, h:=0 ,  FgC:=11,  BgC:=2,  fn:=0, cf:=(c:=5,n:=0,p:=0)); // 6 RGBWA na sebe
//		srgbwa	: NH_OBJ_DAT  := (wh:=20, x:=125,  y:=109,  w:=50, h:=0 ,  FgC:=10,  BgC:=2,  fn:=0, cf:=(c:=4,n:=0,p:=0)); // 6 RGBWA na sebe
		blk		: NH_BRW_D1_BLK := (wh:=20);	
//		tim_1    : NH_OBJ_4O1 := (wh:=107,obj:=2,ok:=[0,1,0,0],obr:=[0,295,0,0]); 		// timer nad hlavnym obrazkom, def
//		tim_2    : NH_OBJ_4O2;
	END_STRUCT





END_TYPE


TYPE

   NH_LIST_OBR	     :  STRUCT 		

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

   NH_TYPE_MNU	      :  STRUCT 		               // definicia spodneho menu
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

 	END_STRUCT;


END_TYPE


VAR_GLOBAL
	xObrWht						{HIDDEN}	: PTR_TO NH_OBR_WHT;
   yFrmName AT mObr  		{HIDDEN} : NH_FRM_HED;              // head of template
	yFrmData	AT mObr[34]		{HIDDEN} : USINT;	//NH_LOG_HEAD;		// data of template
	yFrm_229	AT	mObr			{HIDDEN}	: NH_FRM_229;	// obrazky predvolieb regulatorov
	yFrm_230	AT	mObr			{HIDDEN}	: NH_FRM_230;	// obrazky DEV
	yFrm_231	AT	mObr			{HIDDEN}	: NH_FRM_231;	// obrazky pre stav DEV,CAT,...
	yFrm_232	AT	mObr			{HIDDEN}	: NH_FRM_232;	// obrazky HOM,CAT
	yFrm_233	AT	mObr			{HIDDEN}	: NH_FRM_233;	// xObs
	yFrm_234	AT	mObr			{HIDDEN}	: NH_FRM_234;	// xFiD
	yFrm_235	AT	mObr			{HIDDEN}	: NH_FRM_235;	
	yFrm_236	AT	mObr			{HIDDEN}	: NH_FRM_236;	
	yFrm_246	AT	mObr			{HIDDEN}	: NH_FRM_246;
	yFrm_247	AT	mObr			{HIDDEN}	: NH_FRM_247;
	yFrm_260	AT mObr			{HIDDEN} : NH_FRM_260;				
	yFrm_248	AT	mObr			{HIDDEN}	: NH_FRM_248;

(*
	yFrm_011		AT	mObr	{HIDDEN}		: NH_HOM_011;	// HOM
		yFrm_030		AT	mObr	{HIDDEN}		: NH_FRM_030;	// AUT-MAN
	yFrm_039		AT	mObr	{HIDDEN}		: NH_FRM_039;	// FRM-TGL-LED
		yFrm_076		AT	mObr	{HIDDEN}		: NH_FRM_076;	// AUT-MAN

//	yFrm_230		AT	mObr	{HIDDEN}		: NH_FRM_230;	// obrazky DEV







	yFrm_247		AT	mObr	{HIDDEN}		: NH_FRM_247;

*)

	// na ladenie
(*
	yFrm_061		AT mObr	{HIDDEN} 	: NH_FRM_061;				
	yFrm_260		AT mObr	{HIDDEN} 	: NH_FRM_260;				
	yFrm_005		AT mObr	{HIDDEN} 	: NH_FRM_005;				
	yFrm_001		AT mObr	{HIDDEN} 	: NH_FRM_001;					// HW par DLI
	yFrm_091		AT mObr	{HIDDEN} 	: NH_FRM_091;					// HW par DLI
*)
END_VAR



TYPE



   NH_WEB_SS	{HIDDEN}  : STRUCT
      newLogin : BOOL;
   END_STRUCT
   NH_WEB_PD	{HIDDEN}  : STRUCT
      usr      : USINT;          // prihlaseny user na stranke
      new      : BOOL;
      usage    : USINT;
   END_STRUCT
   NH_WEB_IP	{HIDDEN}  : STRUCT
      pg      : USINT;          // prihlaseny user na stranke
      ip      : TIPadr;
      new     : BOOL;
   END_STRUCT
   NH_WEB_PG	{HIDDEN}  : STRUCT
      pg      : ARRAY [1.._Nh_WEB_M] OF NH_WEB_PD;       // stav usrov
      ip      : ARRAY [1..8] OF NH_WEB_IP;             // novo prihlasena IP
      ses     : USINT;                                // pocet aktivnych session
   END_STRUCT

   NH_WEB_ACC 	{HIDDEN} : STRUCT
      wO 	   : TWebServerAccessTable;   	          // Old web acces table
      wA 	   : TWebServerAccessTable;   	          // NEW web acces table
      pgN      : NH_WEB_PG;
      pgO      : NH_WEB_PG;
      WebChg   : UINT;
   END_STRUCT

  	NH_SLD_POX {HIDDEN} :  STRUCT     // struktura pre slider z viacerych casovych pointov
      mx       : REAL;
      my       : REAL;
      xy       : ARRAY[0..1,0..7] OF INT;             // suradnica zobrazeneho casu nad vynasacou ciarou pointu 0=x,1=y
  	END_STRUCT;

  	NH_SLD_CPY  {HIDDEN}  :  STRUCT     // struktura pre slider z viacerych casovych pointov
      all      : BOOL;                                // je vybraty zdrojovy den pre kopirovanie, nemenia sa dni, len sa oznacuju do kopirovania
		chk		: BOOL;											// aspon jeden DEV je oznaceny na cpy
      cpy      : BOOL;                                // je vybraty zdrojovy den pre kopirovanie, nemenia sa dni, len sa oznacuju do kopirovania
		src		: USINT;											// zdrojovy den	
		dst		: NH_BTN15;                            // ciele kam sa bude kopirovat
  	END_STRUCT;





  	NH_OBJ_DSH {HIDDEN} :  STRUCT       // velkost: 30  vseobecny objekt  			
      wh       : USINT := 102;                  // 0=nic,1=obrazok...2=...
		x			: INT ;                     		// 1 x-ova suradnica stredu objektu
		y			: INT ;         				      // 3 y-ova suradnica stredu objektu (default pre spodne menu)
		w			: INT := 80;            		   // 5 sirka  (pri obrazku je to aj vyska)
      cm       : USINT := 251;                  // 11 command, ktory vrati pri stlaceni
		dash		: INT			:= 381;      			// 7	cislo obrazkaDSH
		vMin		: REAL		:= 0.0;					// 9  minimalna hodnota
		vMax		: REAL		:= 18.0;					//	13 max.hodnota pre zobrazenie
		tx1		: STRING[3] := 'Min';				// 17 text laveho intervalu : Min,Avg, pravy je vzdy Max
		title		: INT;									// 21 cislo textu dash
		idx		: USINT;                         // 23 index na aMeteo.idx[]
//		tx2		: STRING[3] := 'Max';            // 21
		mj			: STRING[3]; 							// 25	popis jednotky °C, %, hPa

      Qr       : BOOL;                            // 29 zaciatok dotyku (tch = true )
      Qf       : BOOL;                            // koniec dotyku (tch = true )
      Qs       : BOOL;                            // koniec dotyku slidera
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL;                            // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte
												
	END_STRUCT;                      					// 30 byte


  	NH_OBJ_124   {HIDDEN}   :  STRUCT    // prepinac medzi obrazkami, alebo chck 15 obrazkov v 2 riadkoch
      // prvy riadok
      wh       : USINT 	:= 124;
		x			: INT 	:= 60;                  	// x-ova suradnica stredu objektu 1.obrazka
		y			: INT 	:= y1+130;         			// y-ova suradnica stredu objektu 1.obrazka
      w        : INT 	:= 490;                    // velkost obrazka
      cm       : USINT 	:= 251;                  	// ... len pre kompatilititu
      h        : INT 	:= 50;                     // vzdialenost medzi obrazkami
		nObr		: USINT	:= 7;								// pocet obrazkov
		Obr1 		: USINT	:= 1;                      // cislo prveho obrazka
      aVar  	: UDINT;                           	// adresa cielovej premennej, kde sa uklada posledny vyber
      typ      : USINT 	:= 1;                     	// typ cielovej premennej 1=usint,3=sint
      aArray	: UDINT;                           	// adresa cieloveho pola
		WrkVar	: USINT;										// pomocna premenna - ak sa cislo vyberu neuklada do nejakej premennej je va adrese aVar tato premmenne,
		WrkArray	: NH_BTN15;									// pomocne pole [0..15]
      FgC      : USINT 	:= 4;                     	// oramovanie vybrateho riadka = kruznica
      BgC      : USINT 	:= 4;                     	// vypln kruznice
		// 27
		xxxx     : INT 	:= 28;                           // vyska textu
      // bit 29
		Visible	: BOOL := true;							// len zobrazit
		Enable	: BOOL := true;							// povolenie vyberat
		Chceck	: BOOL := true;                    	// vybera vsetky volby (ink len jednu a ostatne nuluje)
		Circle	: BOOL := true;							// oramovanie vyberu je kruznica
		Set4		: BOOL;                             //
		Set5		: BOOL;
		set6		: BOOL;
      Q        : BOOL;									  // xA^.trg.Q - musi si nulovat objekt	
		// bit 30
      Qr       : BOOL;                            // xA^.trg.Qr
		Qf       : BOOL;                            // xA^.trg.Qf
      Qs       : BOOL;                            // toto pouziva objekt, nenastavuje sa nikde - koniec dotyku slidera, ....
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL;                            // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte


      // druhy riadok
		xTxt		: INT 	:= 60;                  	// x-ova suradnica stredu objektu 1.obrazka
		yTxt		: INT 	:= y1+130;         			// y-ova suradnica stredu objektu 1.obrazka
      wTxt     : INT 	:= 490;                    // velkost obrazka
      hTxt     : INT 	:= 25;                     // vzdialenost medzi obrazkami
      FgTxt    : USINT 	:= 2;                     	//
	
	
		ObrOff      : ARRAY[1..8] OF INT :=        	// nevybraty obrazok obrazka
							[120,148,147,130,131,378, 33];   	// nacasovat/SunRise/SunSet/DarkOff/DarkOn/random/odpocita cas od spustenia
      ObrSet      : ARRAY[1..8] OF INT :=          // vybraty obrazok
							[121,148,147,130,131,378, 34];
      TxtSet      : ARRAY[1..8] OF INT :=          // cislo textu k vybratemu obj
							[543,544,545,546,547,548,549];
		CmdSet      : ARRAY[1..8] OF USINT;          // doplnujuci CMD co sa ma urobit po vybere, normalne nic
		Dummy9		: ARRAY[1..25] OF USINT;
		// koniec 4.riadka
	END_STRUCT;



  	NH_OBJ_ROL  {HIDDEN} :  STRUCT       // velkost: 30  ROLETY zobrazenie
      wh       : USINT 	:= 109;         			// 0         	
		x			: INT		:= 50;                  // 	lavy horny roh ROL -
		y			: INT 	:= 200;                 //
		w			: INT 	:= 430;			         // 	sirka ROL
		cm			: USINT  := 251;                 // 7	len pre kompatibilitu
		h			: INT 	:= 658;			         // 	vyska ROL
		// 11
		yCirRol	: INT;                 				// 	suradnica gulicky ROL
		yCirLam	: INT; 			         			// 	suradnivc gulicky LAM

		bRol     : INT		:= 50;	                  // 10	vyska boxu nad roletou
		xLam		: INT		:= 530;                 // 	lavy horny roh LAM slidera
		yLam		: INT 	:= 220;			
		xObrR		: INT		:= 80;                  // 	x-suradnica obrazka rolety
		wObr		: USINT	:= 60;						//	 	sirka/vyska obrazku
			cf			: NH_DEV_IO;							//23	 byte 23 	
      // byte 29
		dummy0	: BOOL;                          // byte 29
		dummy1	: BOOL;
		dummy2	: BOOL;
		dummy3	: BOOL;
		dummy4	: BOOL;
wwwWindGuardOn	: BOOL;                            // bezi ochrana pred vetrom
wwwHandBlkWind	: BOOL;							  	  // priznak rucneho blokovania WindG	
      Q        : BOOL;									  // xA^.trg.Q - musi si nulovat objekt	
		// byte 30
      Qr       : BOOL;                            // xA^.trg.Qr
		Qf       : BOOL;                            // xA^.trg.Qf
      Qs       : BOOL;                            // toto pouziva objekt, nenastavuje sa nikde - koniec dotyku slidera, ....
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL := true;                    // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte

		// obj 2 = 30 byte (0 byte )
      wh2      : USINT 	:= 0;  							//0	wh v 2 objekte                	
		rCirSld	: INT		:= 30;							// 	r gulicky slidera
		rCirUpDn	: INT		:= 35;							// 	r gulicky slidera	pri zobrazeni pohyby
		wObrInfo	: INT		:= 90;							// 	velkost info obrazka
		corner	: INT 	:= 3;	

wwwCMD		: USINT;										// 	co sa ma urobit
			wwwCMDf		: USINT;										// 	
		wSldLam	: INT 	:= 14;							//	 	hrubka aktivnej casi slidera

		hLam		: INT 	:= 615;		            // 	vyska * dlzka slidera odhora nadol
		xObrL		: INT		:= 335;	                  // 	x-suradnica obrazka LAM
		yObr		: INT		:= 900; 						// 	y-suradnica obrazkov a textu % pod  Rol



		hTxt		: USINT	:= 34;							// 	vyska textu
wwwpRol		: USINT;										// 	poziadavka na ROL v %
wwwpLam		: USINT;										// 	poziadavka na LAM v %
		// 19
		nLam		: USINT 	:= 16;							// 	pocet lamiel
		wLMax   	: INT 	:= 40;                     // 	sirka {vyska} lamely pri uplnom zaklopeni
		wLold		: INT 	:= 40;							// 	minimalna vyska lamely pri uplnom otvoreni
		mLam		: INT 	:= 10;							// 	bocny okraj medzi lamelou a lavym/pravym oranovanim
      chk    	: BOOL;                             // 28 .. odpoveda Qr
		SldRol	: BOOL := true;							// 	zobrazit slider ROL   .. odpoveda Qf
		SldLam	: BOOL := true;							// 	zobrazit slider LAM
		tchLam	: BOOL := true;							// 	povolit nastavovanie slidera LAM
		tchUpDn	: BOOL := 0;								// 	pri dotyku len spustit zmenu smeru  CMD=1 .. ma prednost pre sliderom ROL
		StatRow	: BOOL := true;							// 	vykresluju sa aj statusove obrazky a hodnoty pod obrazkom														
		ShwLamUp	: BOOL := true;							// 	vykresluju sa aj statusove obrazky a hodnoty pod obrazkom															
	END_STRUCT;                      					// 60 byte


  	NH_ROW {HIDDEN} :  STRUCT              // jedne riadok			
      h        : NH_ROW_H;
      o        : NH_ROW_O;
	END_STRUCT;



 	NH_FIL {HIDDEN} :  STRUCT 		          	   // hlavicka a FILTER aktualneho browsu
      cf          : NH_DEV_IO;                  // identifikacia DEV
		dev			: FILT_LIST; 		            // hlavny filter pre DEV
		cat			: FILT_LIST; 		            // hlavny filter pre CAT
      rom         : USINT;                      // filter na rom
      typ         : SINT;                       // filter na TYP
	END_STRUCT;


  	NH_TCH {HIDDEN} :  STRUCT 			
		aObj			: UDINT;
      evn         : USINT;                            // vyhodnotene cislo udalosti
      cmd         : USINT;                            // vysledny prikaz podla udalosti 20=home screen
      cm          : USINT;                            // command z objektu
      wh          : USINT;                            // wh z objektu riadka nad ktorym bol posledny dotyk   xR^.o.ob[0].wh
      wht         : SINT;


      cmdNext       : USINT;
      xMwht        : SINT;
      col         : SINT :=  1;                       // stlpec v riadku
      row         : SINT := -1;                       // riadok, v ktorom bolo stlacenie
      obj         : SINT := -1;                       // objekt v riadku na ktorom bol stlacenie
      tme         : UINT;                             // cas podrzania
		x1,x2,y1,y2 : INT;                              // suradnice pri prvom/poslednom stlaceni alebo od zaciatku pres
      ok          : BOOL;                             // priznak vyhodnotenia az do najblizsieho noveho dotyku
//      mnu         : BOOL;                             // nove menu
//      tob         : BOOL;                             // na nejakom objekte bol dotyk
//      prs         : BOOL;                             // je press
//      Qpr         : BOOL;                             // impulz pri prvom vyhodnoteni (aj na nevybratom objekte)
//      Qpf         : BOOL;                             // impulz pri ukonceni press     (aj na nevybratom objekte)
      Q           : BOOL;                             // priznak stlacenia nad vybratym objektom
      Qr          : BOOL;                             // impulz pri 1.stlaceni nad vybratym objektom
      Qf          : BOOL;                             // impulz pri uvolneni stlacenia nad vybratym objektom
//      Qs          : BOOL;                             // impulz LEN pre slider - aktivuje sa pri Qf a sposobi este jednu otocku, aby sa odcitali posledne zapisane data - najma pri dotyky nad sliderom
      del         : BOOL;                             // priznak vymazania riadka (row)
      cpy         : BOOL;                             // priznak kopirovania riadka (row)
//      Bl          : BOOL;
      End         : BOOL;                             // uplne ukoncenie udalosti
      mnu         : BOOL;                             // dotyk bol na menu
      sld         : BOOL;                             // pohybujeme sliderom
      p1          : BOOL;                             // priznak s ktorym pracuje  program
      p2          : BOOL;                             // priznak s ktorym pracuje  program
   END_STRUCT;

   NH_TCH_WHT {HIDDEN} : STRUCT      				// HLAVNA RIADIACA PREMENNA
      n           : USINT;
      t           : ARRAY[0..5] OF NH_TCH;
   END_STRUCT;

  	NH_R_XY {HIDDEN} :  STRUCT 												
      xp          : INT := 0;                                // x-posuv celej strany
      yp          : INT := y1;                               // y-posuv celej strany
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

  	NH_FRM_CAT {HIDDEN} :  STRUCT 			// enimane veliciny pre ROM,ZON
      cat         : ARRAY[0.._Nh_CAT]    OF BOOL;          // status kategorie - nieco je zapnute
   END_STRUCT;

  	NH_CAN {HIDDEN} :  STRUCT 											// definicie USRA + FAV a canvas s dotykom
      usr         : USINT;                                  // prihlaseny user = cislo vety v aCfg[22]usr musi byt na zaciatku, lebo od naz sa maze browser
      sbj         : USINT := 1;                                // subjekt = cislo vety ZON  aCfg[3]
      UsrRight    : USINT;
      nIP         : USINT;                                  // cislo IP v ramci usra
      fav         : NH_DEV_IO;
      cat         : NH_FRM_CAT;
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

END_TYPE



VAR_GLOBAL CONSTANT
   _e_NH_IDX_ROW        {HIDDEN}	   : NH_IDX_ROW;
	  eFilt_List			:  FILT_LIST;                                                                                      // prazdny filter
	  eFilt_List_typ		:  FILT_LIST_Typ;                                                                                      // prazdny filter
	
	  eRn     {HIDDEN} 	: NH_RUN_VAL2;

     eMnH     {HIDDEN} 	: NH_MNU := (     o := [(
                                        fn :=  1, wh :=  1, cm := 25  ), //       // logo
                                       (fn := 23, wh := 25, cm := 250  ),         // setup
                                       (fn :=  3, wh :=  0, cm := 20   ),         // home
                                       (fn := 41, wh := 42, cm := 21   ),         // FAV
                                       (fn := 16, wh := 17, cm := 22   ),         // rom
                                       (fn := 10, wh := 11, cm := 23   ),         // cat
                                       (fn := 27, wh := 28, cm := 24   ),         // act
                                       (fn := 49, wh :=  0, cm := 26   )]         // ON/OFF
                           );





      eMn0     {HIDDEN} : NH_MNU := (     o := [
                                       (fn :=  1, cm := 25),         // globalne nastaveia
                                       (fn := 23, cm := 250),        // setup ON/OFF
                                       (fn := 0),                    // home
                                       (fn := 41, cm :=  21),        // FAV
                                       (fn := 16, cm :=  22),        // rom
                                       (fn := 10, cm :=  23),        // cat
                                       (fn := 27, cm :=  24),        // act
                                       (fn := 0,)]);                 // ON/OFF


      eMn1     {HIDDEN} : NH_MNU := (     o := [(fn :=  0 ),  //  <
                                       (fn :=  0 ),  //  setup
                                       (fn :=  3,          cm :=  20),         // home
                                       (fn := 41,wh := 42, cm :=  21),         // FAV
                                       (fn := 16,wh := 17, cm :=  22),         // rom
                                       (fn := 10,wh := 11, cm :=  23),         // cat
                                       (fn := 27,wh := 28, cm :=  24),         // act
                                       (fn := 49,wh := 51, cm :=  26)]);       // ON/OFF

      eMvz      {HIDDEN} : NH_MNU := (     o := [(fn :=  6,wh :=   0,cm :=  31),       // <
                                       (fn :=   0,wh :=   6,cm :=   0, w:=72),  // obrazok vyssej casti
                                       (fn :=  35,wh :=  38,cm :=  33),          // 3 check
                                       (fn :=  10,wh :=  11,cm :=  34),          // 4 cat
                                       (fn :=  16,wh :=  18,cm :=  35),          // 5 all.rom / 1rom
                                       (fn := 348,wh := 348,cm :=  82),          // 6 priradit rom
//											      (fn :=  23,wh :=  24,cm :=  82),       	// 7-tune - parametre kurenia
//                                       (fn := 112,wh := 113,cm :=  36),          // visible
                                       (fn :=  39,wh :=  40,cm :=  37),          // 7-list     NESMIE SA OPRAVOVAT cm!!
                                       (fn :=  33,wh :=  34,cm :=  38)]);        // 8-play     NESMIE SA OPRAVOVAT cm!!


      eMn101     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (),
                                       (),
                                       (),
                                       (fn :=  23,wh :=  24,cm :=   3, x := xc)]);      // setup = Nastavenie parametrov

      eMn102     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (),
                                       (),
                                       (fn := 120,wh := 121,cm :=   1),          // Time
                                       (fn :=  23,wh :=  24,cm :=   3)]);        // setup = Nastavenie parametrov

      eMn103     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn := 122,wh := 123,cm :=   2,x:=xc-90),          // Level
                                       (fn :=  23,wh :=  24,cm :=   3,x:=xc   ),        // setup
                                       (fn :=  83,wh :=  84,cm := 121,x:=xc+90)]);           // tune predradnik / RGB


      eMn104     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (),
                                       (fn := 120,wh := 121,cm :=   1),             // Time
                                       (fn := 122,wh := 123,cm :=   2),             // Level
                                       (fn :=  23,wh :=  24,cm :=   3),             // setup
                                       (fn :=  83,wh :=  84,cm := 121)]);           // tune predradnik / RGB


      eMn105     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn := 120,wh := 121,cm :=   1,x:=xc-180),          // Time
                                       (fn := 122,wh := 123,cm :=   2,x := xc-90),          // Level + Ramp ON/OFF
                                       (fn := 124,wh := 125,cm :=   4,x := xc),          // COLOR
                                       (fn :=  23,wh :=  24,cm :=   3,x := xc+90),          // setup = Nastavenie parametrov
                                       (fn :=  83,wh :=  84,cm := 121,x := xc+180)]);        // tune predradnik / RGB


      eMnTLA   {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn :=  33,wh :=  34,cm :=   5,x := 205),          // PLAY = priradenie
                                       (fn :=  23,wh :=  24,cm :=   6,x := 385)]);        // setup

      eMnWSB   {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn :=  33,wh :=  34,cm :=   5,x := 205),          // PLAY = priradenie
                                       (fn := 204,wh := 205,cm := 120,x := 295),          // LED WSB
                                       (fn :=  23,wh :=  24,cm :=   6,x := 385)]);        // setup

      eMnPIR     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn := 215,wh := 216,cm :=  10,x := 115),          // Day
                                       (fn := 217,wh := 218,cm :=  10,x := 205),          // Evening
                                       (fn := 219,wh := 220,cm :=  10,x := 295),          // Night
                                       (fn := 221,wh := 222,cm :=  10,x := 385),          // Morning
                                       (fn :=  23,wh :=  24,cm :=   9,x := 475)]);        // setup = Nastavenie parametrov


      eMnUsr     {HIDDEN} : NH_MNU := (   o :=
                                      [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (fn :=  32,wh :=  25,cm := 101),          //  +
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=  79,wh :=  79,cm :=  55),          // Users
                                       (fn := 285,wh := 286,cm :=  56),          // Web
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=   0,wh :=   0,cm :=   0)]);



(*
   _NhObrXYZ {HIDDEN} :  ARRAY [-10..-1,0..3] OF INT :=                 // obrazky podla nejakej podmieny (typ,stav...)
            [
//                21, 79,315, 21,             // -11 ZONE
               258, 82,  0,  0,             // -10 RH,CO2,CO
               508,216,166,507,             // -9 BRA  garaz,brana,branicka,zavora
               168,169,169,168,             // -8 SIR/STROB/
               183,184,185,186,             // -7 HET
                60, 60, 60, 60,             // -6  FAV dash/quick/FAV all/FAV user
                17, 19, 15,17,              // -5  ROM   In/OUT/pivnica
               106,107,  0,  0,             // -4  TLA   1/2
               102,103,104,105,             // -3  WSB   2/4/8/5
               100, 99,100,100,             // -2  termoventil : TVE, spirala
               161,162,  0,  0              // -1  teploty  :    miestnost,vonku //,podlaha,kotol

            ];

   // wht   :  index _NhStavDev[wht] odkial sa zoberi parametre do prikazu pre zobrazenie
   //          _NhVal2(wh := _NhStaDev[s].wht, obr := _NhStaDev[s].val);
   //             wh    - je bud podklad, alebo jednorazova prikaz, ktory nadefinuje vykreslenie
   //             obr   - ak si ho funkcia (wh) inak nespracuje, tak je to obrazok
   // val   :  ak je > 0 = cislo obrazka
   //          ak je < 0 je to odkaz na _NhObrXYZ[val], kde su obrazky podla nejakeho kriteria k DEV (vacsinou xCfg^.typ). rozduje funkcia _NhObrNbr()

   _NhObrDev  :  ARRAY [0.._Nh_CFG] OF NH_DEF_OBR :=     // definicia zakladnych obrazkov a obrazkov stavu (stav=odkaz) pre  DEV
            [
            (wht :=   0, val :=  23),      //  wht = index _NhStavDev[wht], val = cislo obrazka   ak je val < 0 potom je odkaz na _NhObrXYZ[val]
            (wht :=   1, val :=  -5),      //  1 ROM INR/EXT
            (wht :=   0, val :=  11),      //  2 CAT
            (wht :=   0, val :=  21),      //  3 ZON  stavovy obrazok sa definuje v _NhBrw6 CASE:9, hlavny obrazok:=21
            (wht :=  27, val :=  30),      //  4 SCN
            (wht :=  25, val :=  28),      //  5 ACT  0/34

//            (wht :=  29, val :=  -7),      //  6 HET
            (wht :=   0, val := 183),      //  6 HET
            (wht :=  42, val :=  95),      //  7 KOT
            (wht :=  42, val := 100),      //  8 TVE
            (wht :=   0, val := 101),      //  9 CER

            (wht :=   5, val :=  62),      // 10 SVD
            (wht :=   7, val :=  63),      // 11 SVA
            (wht :=   9, val :=  64),      // 12 RGB

            (wht :=   0, val :=  -3),      // 13 WSB     stavovy obrazok sa definuje v _NhBrw6
            (wht :=   0, val :=  -4),      // 14 TLA     stavovy obrazok sa definuje v _NhBrw6
            (wht :=  23, val :=  87),      // 15 PIR
            (wht :=   3, val :=  -1),      // 16 TER
            (wht :=   3, val := 163),      // 17 TEH
            (wht :=   3, val := 164),      // 18 TEK
            (wht :=   4, val :=  86),      // 19 LUX
            (wht :=   0, val :=  -6),      // 20 FAV
            (wht :=  11, val :=  73),      // 21 ZAS
            (wht :=   0, val :=  78),      // 22 USR
            (wht :=  30, val :=  70),      // 23 VENT
            (wht :=   0, val :=  97),      // 24 KEY
            (wht :=   0, val := 298),      // 25 SMART-WAY
            (wht :=   0, val :=   1),      // 26   POI
            (wht :=   0, val :=   1),      // 27 H2O
            (wht :=   0, val :=   1),      // 28 FIR
            (wht :=   0, val :=   1),      // 29 GAS
            (wht :=   0, val := 110),      // 30 MAR
            (wht :=  44, val := 114),      // 31 ROL
            (wht :=  30, val :=  -8),      // 32 SIR
            (wht :=  35, val :=  91),      // 33 DOR
            (wht :=  33, val :=  92),      // 34 WIN
            (wht :=   0, val := 197),      // 35 BLI
            (wht :=   0, val :=   1),      // 36   XXX
            (wht :=  50, val :=  -9),      // 37 BRA
            (wht :=   0, val :=   1),      // 38 RFI-snimace
            (wht :=   0, val :=   1),      // 39 RFK-karty
            (wht :=   0, val := 310),      // 40 TGL
            (wht :=   0, val := -10),      // 41 COX  (RH,CO2,CO)
            (wht :=   0, val := 290),      // 42 DALI-M
            (wht :=   0, val := 063),      // 43 DALI-S
            (wht :=   0, val := 029)       // 44 DALI-G
            ];

   // _NhStaDev: vykreslenie obraka podlastavu DEV vo funkcii : _NhVal2(wh := _NhStaDev[].wht, obr := _NhStaDev[].val);
   // jedno dev v _NhStaDev ma viac viet, podla stavu
   //    _NhStaDev[wht+0]  := 1.veta ked xDev^.ou.val = 0.0;
   //    _NhStaDev[wht+1]  := 2.veta ked xDev^.ou.val > 0.0;
   //    _NhStaDev[wht+2]  := 3.veta ked moze existovat ine kriterium unikatne k DEV

   // vsetko sa vyrobi v _NhShwObj() ked xO^.wh := 3


   _NhStaDev {HIDDEN} :  ARRAY [0.._Nh_CFG] OF NH_DEF_OBR :=               // zobrazenie stavy DEV (obrazky, hodnoty, ikony ,,,)
            [
            (wht :=   0, val :=  23),      //  0 nic (obrazok setup)
            (wht :=   1, val :=   0),        //  1 ROM - zobrazenie teploty
            (),                              // 2 - volne
//            (wht :=  18, val :=  66),        //  2 ZON - zobrazenie teploty
            (wht :=   1, val :=   0),        //  3 teplota miestnosti,vonku,podlahy,kotla... podla typ
            (wht :=   2, val :=   0),        //  4 LUX - zobrazenie osvetlenia
            (wht :=  10, val :=  -1),        //  5 SVD - OFF   (-1 znamena ze sa nevykresli ziadny obrazok !!!)
//            (wht :=  11, val :=   0),        //  6 SVD - ON - v zltom kruhu s gradientom
            (wht :=  17, val := 201),        //  6 SVD - ON - v zltom kruhu s gradientom
            (wht :=  10, val :=  -1),        //  7 SVA - OFF
//            (wht :=  12, val :=   0),        //  8 SVA - lvl v zltom kruhu s gradientom
            (wht :=  17, val := 201),        //  8 SVA - ON - v zltom kruhu s gradientom
            (wht :=  10, val :=  -1),        //  9 RGB - OFF
//            (wht :=  12, val :=   0),        // 10 RGB - lvl v zltom kruhu s gradientom
            (wht :=  17, val := 201),        // 10 RGB - ON - v zltom kruhu s gradientom

            (wht :=  18, val :=  73),       // 11 ZAS - NEURCENY-OFF            sivy + obrazok
            (wht :=  18, val :=  62),       // 12 ZAS - SVE-OFF                 sivy + obrazok
            (wht :=  18, val :=  50),       // 13 ZAS - STYKAC-OFF               sivy + obrazok
            (wht :=  18, val :=  61),       // 14 ZAS - HET-OFF                 sivy + obrazok
            (wht :=  18, val := 159),       // 15 ZAS - NABIJ.STANICA-OFF        sivy + obrazok
            (wht :=  18, val :=  73),       // 16 ZAS - rezerva-OFF              sivy + obrazok

            (wht :=  13, val := 202),       // 17 ZAS - NEURCENY-ON             zeleny + obrazok
            (wht :=  17, val := 201),       // 18 ZAS - SVD-ON                  zlty   + obrazok
            (wht :=  13, val := 213),       // 19 ZAS - SYKAC ON                 zeleny + obrazok
            (wht :=  13, val := 203),       // 20 ZAS - HET-ON                  zeleny + obrazok
            (wht :=  13, val := 214),       // 21 ZAS - NABIJACIA STANICA-ON    zeleny + obrazok
            (wht :=  13, val := 202),       // 22 ZAS - rezerva -ON             zeleny + obrazok

            (wht :=  10, val :=  -1),       // 23 PIR - pir je v klude, neodpocitava sa nic
            (wht :=  16, val :=  89),       // 24 PIR - prihadza signal          cierna postava v modrom

            (wht :=  18, val :=  28),       // 25 ACT - OFF sipka v sivom kruhu
            (wht :=  20, val :=  28),       // 26 ACT - ON sipka v Azurovom kruhu bez gradientu

            (wht :=  18, val :=  30),       // 27 SCN - OFF scn v sivom kruhu
            (wht :=  14, val := 207),       // 28 SCN - ON  scn v oranzovom kruhu

            (wht :=   1, val :=   0),       // 29 HET - zobrazenie teploty

            (wht :=  10, val :=  -1),       // 30 VEN - OFF
            (wht :=  13, val := 215),       // 31 VEN - ON - v modrom kruhu s gradientom

            (wht :=   4, val :=   0),       // 32 TVE - vystredene cislo v azurovom kruhu

            (wht :=  18, val :=  -1),       // 33 WIN - OFF
            (wht :=  14, val :=  92),       // 34 WIN - ON - v modrom kruhu s gradientom

            (wht :=  18, val :=  -1),       // 35 DOR - OFF
            (wht :=  14, val :=  91),       // 36 DOR - ON - v modrom kruhu s gradientom

            (wht :=  18, val :=  66),       // 37 ZON - Unlocked 0
            (wht :=  14, val :=  67),       // 38 ZON - Lock   1/2
            (wht :=  15, val :=  67),       // 39 ZON - Lock full
            (wht :=  18, val :=  66),       // 40 ZON - Locking
            (wht :=  18, val :=  66),       // 41 ZON - Unlocking

            (wht :=  10, val :=  -1),       // 42 TVE - OFF
            (wht :=  40, val :=   0),       // 43 TVE - cerveny kruh s cislo v strede

            (wht :=  18, val := 114),       // 44 ROL - OFF  0%      dn - zatiahnute     sivy
            (wht :=  14, val := 115),       // 45 ROL - viac 1-99%   up/dn - povytiahnute      oranzovy
            (wht :=  23, val := 117),       // 46 ROL - pohyb hore               cerveny
            (wht :=  23, val := 118),       // 47 ROL - pohyb dolu               cerveny
            (wht :=  90, val := 501),       // 48 ŽAL - zatienene    siva
            (wht :=  90, val := 500),       // 49 ŽAL - zodtienene   biela

            (wht :=  18, val := 509),       // 50 GAR - OFF  0%         sivy
            (wht :=  23, val := 510),       // 52 GAR - otvorene  100%  cerveny
            (wht :=  18, val := 216),       // 53 BRANA - OFF  0%         sivy
            (wht :=  15, val := 217),       // 54 BRANA - otvorene  100%  cerveny gradient
            (wht :=  18, val := 166),       // 55 BRANICKA - OFF  0%         sivy
            (wht :=  23, val := 167),       // 56 BRANICKA - otvorene  100%  cerveny
            (wht :=  21, val := 506),       // 55 BRANICKA - OFF  0%         sivy
            (wht :=  23, val := 507)        // 56 BRANICKA - otvorene  100%  cerveny

         ];


   // tito parametre sa posielaju do _NhVal2(wh := _NhStaCat[s].wht, obr := _NhStaCat[s].val);
   // wht : funkcia
   // val : obrazok
   // vsetko sa vyrobi v _NhShwObj() ked xO^.wh := 2
*)

END_VAR



VAR_GLOBAL CONSTANT

	{ $ IF _nh_Cust = 0 OR _Nh_CUST = 1} 	 // vsetko

      _ePg0   : NH_PG_HOME :=
      (
      Hom := ( ob := [
               ( wh:= 1, x := xc,     y := yyc- 30,  w := 180,  fn := 255 ),                                  // domcek
               ( wh:= 1, x := xc,     y := yyc- 55,  w :=  32,  fn := 0 ),                                   // day/night vnutri
               ( wh:= 0, x := xc+ 40, y := yyc-120,  w :=  32,  fn := 140 ),                                  // day/night vonku
               ( wh:= 1, x := xc,     y := yyc-  5,  w :=  80,  fn :=  92,   cm := 50,    cf := (c:=2, n:=17)),   // okno
               (),
//               ( x := xc+ 30, y := yc+ 90,  w :=  50,  wh := 0,  fn :=  92, h := -70, FgC := 1, BgC := 8,   cf := (c:=2, n:=18)),   // otvorene dvere ( h > 0 : vymaze aj kruh pod obrazkom)
               ( x := xc- 30, y := yyc+ 90,  w :=  50,  wh := 0,  fn := 111, h := -70, FgC := 8, BgC := 1,   cf := (c:=2, n:=23)),   // otvoreny garaz
               ( x := xc+100, y := yyc+ 20,  w :=  50,  wh := 0,  fn :=  77, h :=   0,                       cf := (c:=2, n:=24)),  // otvorena brana/branicka
               ( x := xc- 45, y := yyc-130,  w :=  75,  wh := 1,  fn := 132, h :=   0,                       cf := (c:=2, n:=11)),  // fotovoltaika

               ( wh:=4, x := xc-60, y := yyc+45, w:=58, h:=48, fn := 0, FgC := 0, BgC := 0,   cf := (c:=1, n:=1)),   // otvorene dvere ( h > 0 : vymaze aj kruh pod obrazkom)
               ( wh:=4, x := xc-60, y := yyc+45, w:=58, h:=48, fn := 91, cm := 50,   cf := (c:=2, n:=18)),   // otvorene dvere ( h > 0 : vymaze aj kruh pod obrazkom)
               (BgC := 13)
                     ]),

      dsh :=  ( ob := [

               (x := 0,      y:= 0, wh := 0),
               (x := xc,     y:= yyc-253, w := 130, wh := 2, cm:=50),   // 1.kruznica pod obr.1 prvy hore
               (x := xc+158, y:= yyc-183, w := 130, wh := 2, cm:=50),   // 2.kruznica pod obr.2
               (x := xc+210, y:= yyc- 25, w := 130, wh := 2, cm:=50),   // kruznica pod obr.3 - vprav v strede
               (x := xc+158, y:= yyc+133, w := 130, wh := 2, cm:=50),   // kruznica pod obr.4
               (x := xc,     y:= yyc+203, w := 130, wh := 2, cm:=50),   // kruznica pod obr.5 - dolu
               (x := xc-158, y:= yyc+133, w := 130, wh := 2, cm:=50),   // kruznica pod obr.6
               (x := xc-210, y:= yyc- 25, w := 130, wh := 2, cm:=50),   // kruznica pod obr.7 - vlavo v strede
               (x := xc-158, y:= yyc-183, w := 130, wh := 2, cm:=50)    // kruznica pod obr.8
                     ]),

      Qck :=  ( ob := [

               (x := xc-220, y := yy2-70, w := 64, wh := 0),                      // 1 - preve zprava
               (x := xc-220, y := yy2-65, w := 64, wh := 2, cm:=50),                      // 1 - preve zprava
               (x := xc-130, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc- 40, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc+ 50, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc+140, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc+230, y := yy2-65, w := 64, wh := 2, cm:=50),                      // 6 - posledne zlava
               (x := xc+320, y := yy2-65, w := 64, wh := 2, cm:=50),                      // 7 - dalej
               ()
                     ]),
      xy := [
               (),
               (x := 380, y := 275),
               (x := 490, y := 400),
               (x := 490, y := 562),
               (x := 380, y := 693),
               (x := 205, y := 693),
               (x :=  87, y := 569),
               (x :=  87, y := 400),
               (x := 200, y := 275)
               ],

      );


	{ $ END_IF } 	


	{ $ IF _Nh_CUST = 2} 	                // Futbal.stadion HE
      _ePg0 : NH_PG_HOME :=
      (
      Home := ( ob := [
               ( x := xc,    y:= yc- 20, w:= 600, wh:=1,          fn := 300 ),                    // futb.stadion
//               ( x := xc+15, y:= yc- 20, w:= 160, wh:=1,          fn := 301 ),                    // futb.stadion
               ()
                     ]),
      Dash :=  ( ob := [
               (x := xc-200, y:= yc+220, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.1 prvy hore
               (x := xc-200, y:= yc+ 65, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.2
               (x := xc-200, y:= yc-105, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.3 - vprav v strede
               (x := xc-200, y:= yc-260, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.4
               (x := xc+195, y:= yc-260, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.5 - dolu
               (x := xc+195, y:= yc-105, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.6
               (x := xc+195, y:= yc+ 65, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.7 - vlavo v strede
               (x := xc+195, y:= yc+220, w := 110, wh := 2 , cf := (c := 2))    // kruznica pod obr.8
                     ]),

      Quick :=  ( ob := [

               (x := xc+320, y := y2-60, w := 64, wh := 2),
               (x := xc+230, y := y2-60, w := 64, wh := 2),
               (x := xc+140, y := y2-60, w := 64, wh := 2),
               (x := xc+ 50, y := y2-60, w := 64, wh := 2),
               (x := xc- 40, y := y2-60, w := 64, wh := 2),
               (x := xc-130, y := y2-60, w := 64, wh := 2),
               (x := xc-220, y := y2-60, w := 64, wh := 2),
               (x := xc-310, y := y2-60, w := 64, wh := 2),
               (),
               (w := 48, wh := 100)                    // weather
                     ]),

      );
	

      eMnHfs     : NH_MNU := (  n := 3,                                               // len obrazok HOME
                              o := [(fn :=  1),(fn := 0),
                                       (wh := 4, fn := 4, cm :=20, x:=xc, y:= y2+55),         // home
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 )
                                       ]);

   { $ END_IF } 	


	{ $ IF _Nh_CUST = 3} 	                // zimny stadion HE
      _ePgHome : NH_PG_HOME;
	{ $ END_IF } 	
END_VAR

//      pHet     : ARRAY[0..1,1..4] OF USINT := [170,172,174,176, 171,173,175,177];                                       // HeatMode */1/2/3/ manual/program
//      pTve     : ARRAY[0..1,0..3] OF USINT := [ 49,172,174,176,  52,173,175,177];                                       // Tve    Off/1/2/3/ manual/program











VAR_GLOBAL CONSTANT

(*
   // [OFF/ON, HET/TVE, A/1/2/3]      HET, TVE  OFF..ON    A,0,1,2,3              [0,OFF,            n] [0,ON,             n]
   _ObrHetPVP     {HIDDEN}   : ARRAY[ 0  ..  2, 0..   1,   0 ..    4] OF USINT := [222,170,172,174,176,  223,171,173,175,177, // HET: [0,OFF/ON, PRG/0/1/2/3/4 ]
                                                                                   222, 54,172,174,176,  223,193,173,175,177, // VEN: [1,OFF/ON, PRG/0/1/2/3/4 ]
                                                                                   220, 54,172,174,176,  221,193,173,175,177  // TVE: [2,OFF/ON, MAN/0/1/2/3/4 ]
*)

   _NhListObr     {HIDDEN}   : NH_LIST_OBR;
   _NhTypeMnu     {HIDDEN}   : NH_TYPE_MNU;
	_NhDsh			{HIDDEN}   : NH_DSH;
   _eRowHed       {HIDDEN}	  : NH_ROW_H;                   // cisla hlavicka riadka
   _eSld          {HIDDEN}	  : NH_SLD_DAT;
   _eFil          {HIDDEN}	  : NH_FIL;
   _eWht          {HIDDEN}   : NH_TCH_WHT;
   _eTch          {HIDDEN}	  : NH_TCH;                     // prazdny touch
   _eRowH         {HIDDEN}	  : NH_ROW_H;                    // prazdna hlavicka riadka
//   _ObjDay        {HIDDEN}   : NH_POI_DAY_XY;
   _NhObrLeds     {HIDDEN}   : ARRAY[1..4] OF USINT := [210,209,212,208];    // R,G,B,SH


//	_NhObjCfgBlk    :  NH_OBJ_DAT  :=          // PIR
//      (wh:= 0, x:=125,  y:=109,  w:=48, h:= 68, FgC:=4,  BgC:=2,  fn:=0            ); // 5 Blk
	_NhObjD1pir    :  NH_OBJ_DAT  :=          // PIR
      (wh:= 0, x:=125,  y:=109,  w:=50, h:=68 , FgC:=7,  BgC:=2,  fn:=0, cf:=(c:=5)); // 6 PIR day mde


END_VAR





VAR_GLOBAL
	aWeb			      : NH_WEB;

   yRn         {HIDDEN}     : NH_RUN_VAL2;

   xM          {HIDDEN}     : PTR_TO NH_M;
   xA          {HIDDEN}     : PTR_TO NH_CAN;
   xB          {HIDDEN}     : PTR_TO NH_BRW;
   xL		      {HIDDEN}     : PTR_TO NH_LVL;
   xF		      {HIDDEN}     : PTR_TO NH_FIL;
   xU          {HIDDEN}     : PTR_TO NH_MNU;
   xR          {HIDDEN}     : PTR_TO NH_ROW;
   xR2         {HIDDEN}     : PTR_TO NH_ROW;
   xRowO			{HIDDEN}     : PTR_TO NH_ROW_O;
	xS          {HIDDEN}     : PTR_TO NH_SLD_DAT;
   xO          {HIDDEN}     : PTR_TO NH_OBJ_DAT;
   xO2         {HIDDEN}     : PTR_TO NH_OBJ_DAT;
   xOh         {HIDDEN}     : PTR_TO NH_OBJ_123;
   xOh2        {HIDDEN}     : PTR_TO NH_OBJ_123;

   x4o         {HIDDEN}     : PTR_TO NH_OBJ_4O1;
	xRo 			{HIDDEN}		 : PTR_TO NH_OBJ_ROL;
//	yRo 			{HIDDEN}	AT aWeb.M[1].brw.r[14]	: NH_OBJ_ROL;
	yRo 			{HIDDEN}		:  NH_OBJ_ROL;
	x124			{HIDDEN}		:  PTR_TO NH_OBJ_124;	
	y124			{HIDDEN}		:  NH_OBJ_124;	

   xoDsh       {HIDDEN}     : PTR_TO NH_OBJ_DSH;


   xOm         {HIDDEN}     : PTR_TO NH_OBJ_MNU;
   xIxB        {HIDDEN}	    : PTR_TO NH_IXB;
   xIdx        {HIDDEN}	    : PTR_TO NH_IDX;
 	yIdxR			{HIDDEN}	    : NH_IDX_ROW;

   ky2          {HIDDEN} : INT := 915;                    // koniec browsu = zaciatok spodneho menu
   kyr          {HIDDEN} : INT := 132;                    // vyska riadku
   kyc          {HIDDEN} : INT := 510;                    // stred Y
   kyb          {HIDDEN} : INT := 800;                    // celkova vyska browsu
   yk           {HIDDEN}       : REAL;
   yLVL                   : NH_LVL;
   aAcc                             : NH_WEB_ACC;                      // riadiaca premenne
   CustomizedLoginPage AT %S355.1    {HIDDEN}   : BOOL := true;                     // povolenie Cust pristupu (prekopirovat XML do web/import)
   targetPage                        {HIDDEN} : STRING[20] := '001_NHM.XML';           // nazov stranky na ktoru presmeruje REDIR.XML
   aHtt                              {HIDDEN} : STRING[80] ; //:= '_NH_USR_.XML';
//   pageLogout                       : ARRAY [1..3] OF STRING[20];       //



END_VAR

VAR_GLOBAL		// docasne pomocne premenne
   yS          				{HIDDEN}     : NH_SLD_DAT;
   y4o         				{HIDDEN}     : NH_OBJ_4O1;
   yOh         				{HIDDEN}     : NH_OBJ_123;
	yoDsh       				{HIDDEN}     : NH_OBJ_DSH;
	_NhObjO4rom 				{HIDDEN}     :  NH_OBJ_4O1;
	_NhObjO4sta 				{HIDDEN}     :  NH_OBJ_4O2;
   xCan        				{HIDDEN}     : PTR_TO TCanvasData;
END_VAR



FUNCTION _NhVal2  : BOOL           // nadefinovanie stavoveho obrazka/textu pre kategoriu
   VAR_INPUT
      xy       : BOOL;                    // znamena, ze sa text vypisuje len pre to co je v x,y, inak pre xO^.x + x
      noxy     : BOOL;                    // text sa vypise od nastavenej pozicie
      nofmt    : BOOL;                    // text sa neformatuje
      crc      : BOOL;                    // vykresluje sa kruh
      box      : BOOL;                    // vykresluje sa obdlznik
      fil      : BOOL := true;            // vykresluje sa obsah kruhu/obdlznika
   	wrk		: BOOL;
	   wh       : USINT;                   // predvolba
      grd      : USINT;                   // typ gradientu
      obr      : INT;                     // vykresli sa obrazok
      txt      : SINT   := -1;            // vypise sa text (-1 := nic sa nevypise)
		nTxt		: INT;							// cislo textu
      FgC      : USINT  := 2;             // GCOLOR_LTGRAY;
      BgC      : USINT  := 1;             // GCOLOR_BLACK;
      FgT      : USINT  := 4;             // GCOLOR_WHILE;
      fmt      : INT    := 2;             // formatovanie textu (stred riadka, stred textu)
      wC       : INT    ;                 // priemer kruhu/sirka boxu
      hB       : INT    ;                 // vyska boxu
      wO       : INT    ;                 // velkost obrazka
      wT       : INT := 22   ;            // velkost textu
      wL       : USINT  := 2;             // hrubka kruznice / oramovanie kruhu
      x,y      : INT;                     // korekcie
      r        : INT    := 2;             // polomer Rounbow
      ob       : SINT := -1;               // namapuje xO
      val      : STRING[10];              // nieco naforpatovane pre zobrazenie ako text
   END_VAR
   VAR_TEMP
      n        : INT;
   END_VAR
   _NhVal2 := true;
   IF ob > -1 THEN
      xO := ADR(xR^.o.ob[ ob ]);
   END_IF;

   IF wC = 0 THEN
      wC := xO^.w;
   END_IF;
   IF wO = 0 THEN
//      wO := wC-7;
      wO := wC/5*4;
   END_IF;
   IF hB = 0 THEN
      hB := wC;
   END_IF;
   IF wT = 0 THEN
      wT := xO^.h;
   END_IF;
   CASE wh OF                                                          // jednoucelovo nadefinovane predvolby

      0: //bez predvolby = vypisuje sa podla toho co prislo v parametroch ( crc,obr,txt....)
         ;

    100: // normalna teplota z al.ou.val, formatovanie textu podla xO^.fn    , vyska xO^.h, farba podla FgC
         FgT := xO^.FgC; txt := 10; wT := xO^.h; fmt := xO^.fn; fil := false;
    101: // % (luxy,CO) z al.ou.val, formatovanie textu podla xO^.fn, vyska xO^.h
         FgT := xO^.FgC; txt := 11; wT := xO^.h; fmt := xO^.fn; fil := false;
    102: // oranzovy gradient-kruh s ciernym 'ON'
         fil :=1; crc := 1; grd := 11;  FgC :=15; BgC :=  4; FgT := 1; txt := 2; wT := 18;
    103: // azurovy gradient-kruh s ciernym 'ON'
         fil :=1; crc := 1; grd := 11;  FgC :=3; BgC :=  4; FgT := 1; txt := 2; wT := 18;

    109: // modry gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC := 3; BgC :=  3; FgT := 4; txt :=15; wT := 22; fmt := 2;
    110: // zlty gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC := 5; BgC :=  4; FgT := 1; txt :=15; wT := 22; fmt := 2;
    111: // Zeleny gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC := 8; BgC :=  4; FgT := 1; txt :=15; wT := 22; fmt := 2;
    112: // Oranzovy gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC :=15; BgC :=  4; FgT := 1; txt :=15; wT := 22; fmt := 2;
    113: // Azurovy  gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC := 3; BgC :=  4; FgT := 1; txt :=15; wT := 22; fmt := 2;
    114: // Purpurovy gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC := 28; BgC := 2; FgT := 4; txt :=15; wT := 22; fmt := 2;
    115: // Cerveny gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC := 7; BgC :=  4; FgT := 1; txt :=15; wT := 22; fmt := 2;
    116: // Biely gradient-kruh s cislom v strede z al.ou.val
         fil :=1; crc := 1; grd := 11;  FgC := 4; BgC :=  2; FgT := 1; txt :=15; wT := 22; fmt := 2;
    117: // Zeleny kruh bez grd s cislom z VR cierny text - pre CHECK/analog
	      fil :=1; crc := 1; grd := 1;  FgC := 8; BgC :=  8; FgT := 1; txt := 3; wT := 22; fmt := 2;
    118: // Zeleny kruh bez grd s cislom z VR cierny text - pre CHECK/DIGITAL
	      fil :=1; crc := 1; grd := 1;  FgC := 8; BgC :=  8; FgT := 1; txt := 2; wT := 22; fmt := 2;
    120: // silne sve tlo-cerveny  kruh + gradient
         fil :=1; crc := 1; grd := 11;  FgC := 18; BgC :=  4;   //BgC :=  4;



    150: // Cerveny gradient-kruh s cislom v strede z al.ou.sta
         fil :=1; crc := 1; grd := 11;  FgC := 7; BgC :=  4; FgT := 1; txt :=16; wT := 22; fmt := 2;
    151: // Cerveny gradient-kruh s cislom v strede z al.ou.ex
         fil :=1; crc := 1; grd := 11;  FgC := 7; BgC :=  4; FgT := 1; txt :=17; wT := 22; fmt := 2;

    160: // tmavo-cerveny kruh + svetly gradient
         fil :=1; crc := 1; grd := 11;  FgC :=28; BgC :=  4;
    161: // purpurovy kruh + tmavy gradient
         fil :=1; crc := 1; grd := 13;  FgC :=28; BgC :=  1;   //BgC :=  4;

    170: // tmavo-modry obdlznik bez gradientu
         fil :=1; box := 1; grd := 1;   FgC :=4; BgC :=  9;
    171: // svetlo-modry obdlznik bez gradientu
         fil :=1; box := 1; grd := 11;  FgC :=4; BgC := 22;   //BgC :=  4;

      1: // teplota v browse
         FgT := xO^.FgC; txt := 10; wT := 32; fmt := 1; x := 30; y := -5;    // skoriguje suradnice vypisu teploty - posunie do prava a odtial sa vykresluje do lava
//         FgT := xO^.FgC; txt := 10; wT := xO^.h; fmt := 1; x := 30; y := -5;    // skoriguje suradnice vypisu teploty - posunie do prava a odtial sa vykresluje do lava
      2: // % osvetlenia v browse
         FgT := xO^.FgC; txt := 11; wT := 28; fmt := 1; x := 30; y := -5;
      3: // lx v browse
         FgT := xO^.FgC; txt := 12; wT := 28; fmt := 1; x := 30; y := -5;
      4: // vystredene cislo v sivom kruhu s gradientom
         FgT := 4; txt := 3; wT := 20; fmt := 2;               // cislo bielou
         crc := 1; grd := 11;  FgC := 2; BgC :=  1; wC := 60;


      9: // kruh bez gradientu vypln farbou Bgc, bez oramovanie pripadny text farbou FgC, text podla poslanych parametrov
         fil :=1; crc := 1; grd := 2; Fgc:= BgC; FgT := 1; wL := 0;

//         fil :=1; crc := 1; grd := 2;  FgC := 8; BgC :=  8; FgT := 1;


     10: // sivy gradient-kruh s bielym 'OFF'
         fil :=1; crc := 1; grd := 11;  FgC := 2; BgC :=  1; FgT := 4; txt := 1; wT := 19;

     11: // zlty gradient-kruh s ciernym 'ON'
         fil :=1; crc := 1; grd := 11;  FgC := 5; BgC :=  4; FgT := 1; txt := 2; wT := 18;

     12: // zlty gradient-kruh s cislom v strede
         fil :=1; crc := 1; grd := 11;  FgC := 5; BgC :=  4; FgT := 1; txt := 3; wT := 22;

     13: // zeleny   kruh + gradient
         fil :=1; crc := 1; grd := 11;  FgC := 8; BgC :=  4;
     14: // oranzovy kruh + gradient
         fil :=1; crc := 1; grd := 11; FgC := 15; BgC :=  4; //FgC := 6; BgC :=  4;
         IF obr > 0 THEN
            wO := wC/4*3;
         END_IF;
     15: // sve tlo-cerveny  kruh + gradient
         fil :=1; crc := 1; grd := 11;  FgC := 7; BgC :=  4;   //BgC :=  4;
     16: // azurovy  kruh + gradient
         fil :=1; crc := 1; grd := 11;  FgC := 3; BgC :=  4;
     17: // zlty gradient-kruh
         fil :=1; crc := 1; grd := 11;  FgC := 5; BgC :=  4;
     18: // sivy gradient-kruh
         fil :=1; crc := 1; grd := 11;  FgC := 2; BgC :=  1;
     19: // oranzovy kruh + gradient v strede oranzova, dooloko biela
         fil :=1; crc := 1; grd := 12;  FgC := 6; BgC := 26;
//         crc := 1; grd := 11;  FgC := 6; BgC := 4;

     20: // azurovy kruh bez gradientu
         fil :=1; crc := 1; grd := 2;  FgC := 3; BgC := 3; FgT := 4;
     21: // zelena  bez gradienu
         fil :=1; crc := 1; grd := 2;  FgC := 8; BgC :=  8; FgT := 1;
     22: // oranzova  bez gradientu
         fil :=1; crc := 1; grd := 2;  FgC := 6; BgC :=  6; FgT := 1;
     23: // cervena  bez gradientu
         fil :=1; crc := 1; grd := 2;  FgC := 7; BgC :=  7; FgT := 4;
     24: // biela  bez gradientu
         fil :=1; crc := 1; grd := 2;  FgC := 4; BgC :=  4; FgT := 1;

     25: // azurovy  bez gradient  + ON
         fil :=1; crc := 1; grd := 11;  FgC := 3; BgC :=  4; FgT := 1; txt := 2; wT := 24;
     26: // azurovy  kruh + \\gradient  + ON
         fil :=1; crc := 1; grd := 11;  FgC := 3; BgC :=  4; FgT := 1; txt := 2; wT := 24;

     27: // cierny kruh bez gradientu
         fil :=1; crc := 1; grd := 2;  FgC := 1; BgC := 1;

     28: // svetlo-purpurovy bez gradientu
//         fil :=1; crc := 1; grd := 2;  FgC := 28; BgC := 28;
         fil :=1; crc := 1; grd := 10;  FgC := 21; BgC :=21; FgT := 1; //txt := 0; wT := 44; fmt := 2;

     29: // zlty gradient-kruh s cislom v strede, vypisuje to co je xO^.fmt
         fil :=1; crc := 1; grd := 11;  FgC := 5; BgC :=  4; FgT := 1; wT := 22;

//     30: // sivy gradient-kruh s cislom v strede z yTx1
//         fil :=1; crc := 1; grd := 11;  FgC := 2; BgC :=  1; FgT := 4; txt := 0; wT := 44; fmt := 2;

     30: // tmavy modry gradient-kruh
//         fil :=1; crc := 1; grd := 11;  FgC := 9; BgC :=21; FgT := 1; //txt := 0; wT := 44; fmt := 2;
//         fil :=1; crc := 1; grd := 11;  FgC := 9; BgC :=1; FgT := 1; //txt := 0; wT := 44; fmt := 2;
//         fil :=1; crc := 1; grd := 11;  FgC :=20; BgC :=0; FgT := 4; //txt := 0; wT := 44; fmt := 2;
         fil :=1; crc := 1; grd := 11;  FgC :=3; BgC :=0; FgT := 4; //txt := 0; wT := 44; fmt := 2;

     31: // tmavy zeleny gradient-kruh
         fil :=1; crc := 1; grd := 11;  FgC := 8; BgC :=  1; //FgT := 4; txt := 0; wT := 44; fmt := 2;
     32: // tmavy oranzovy  gradient-kruh
         fil :=1; crc := 1; grd := 11;  FgC := 6; BgC :=  1; //FgT := 4; txt := 0; wT := 44; fmt := 2;
     33: // tmavy cerveny gradient-kruh
         fil :=1; crc := 1; grd := 10;  FgC := 1;  BgC :=  7; //FgT := 4; // txt :=9; wT := 38; fmt := 2;
     34: // tmavy azurovy gradient
         fil :=1; crc := 1; grd := 11;  FgC := 3;  BgC :=  1;// FgT := 4; txt := 0; wT := 44; fmt := 2;
     35: // biely gradient
         fil :=1; crc := 1; grd := 11;  FgC := 4; BgC :=  2; FgT := 1;
     36: // sivy  bez gradienu
         fil :=1; crc := 1; grd := 2;  FgC := 2; BgC :=  2; FgT := 1;
     37: // modry  bez gradienu
         fil :=1; crc := 1; grd := 2;  FgC := 9; BgC :=  9; FgT := 1;
     38: // tmavo-purpurovy bez gradientu
         fil :=1; crc := 1; grd :=12;  FgC := 1; BgC :=28;


     40: // cerveny bez gradient u kruh s cislom v strede
         fil :=1; crc := 1; grd := 2;  FgC := 7; BgC :=  7; FgT := 4; txt := 3; wT := 25;


     50: // sivy obdlznik
         fil :=1; crc := 0; box := 1; grd := 11;  FgC := 2; BgC :=  1;   wC := xO^.w; hB := xO^.h; wO := wC;

     52: // oranzovy obdlznik
         fil:=1; crc := 0; box := 1; grd := 11;  FgC := 6; BgC :=  4;   wC := xO^.w; hB := xO^.h; wO := wC;

     80: // podfarbenie menu
         fil :=1; crc := 0; box := 1; grd := 10;  FgC := 3; BgC := 27;   wC := xO^.w+10; hB := xO^.h+25;    //wO := wC;


     90: // bez podkladu, farba
         crc := 0; box := 0;
    ELSE // neurceny obr - svetlo-sivy grdirnt-kruh s obrazko setup
         crc := 1; grd := 11; FgC := 2; BgC :=  26; obr := 24;
   END_CASE;
   // vyberie gradient/frame


   IF grd > 0 THEN                                                         // ak je grd=0 akceptuju sa existujuce nastavenia
      CASE grd OF                                                          // kruznica, kruh, kruh s oramovanim, kruh s gradientom
          1 :  rmp := GFILL_STYLE_BGCOLOR;                                    // kruh bez oramovania bez gradientu
          2 :  rmp := GFILL_STYLE_FRAME;                                      // kruh s oramovanim bez gradientu
         10 :  rmp := GGRADIENT_STYLE_LINEAR;                                 // kruh s gradientom linear
         11 :  rmp := GGRADIENT_STYLE_LINEAR+GGRADIENT_STYLE_HORIZONTAL;      // kruh s gradientom linear+horizontal
         12 :  rmp := GGRADIENT_STYLE_RADIAL;                                 // kruh s gradientom RADIAL
         13 :  rmp := GGRADIENT_STYLE_RADIAL1_3;                            // kruh s gradientom RADIAL
         14 :  rmp := GGRADIENT_STYLE_BAR1_3;                            // kruh s gradientom RADIAL
      END_CASE;
      // nastavi gradient
      IF grd > 9 THEN                                                      // bude gradient
         GC_SetFillStyle      (style := GFILL_STYLE_GRADIENT, GrData := xCan);					
         GC_SetGradientStyle  (style := rmp, color1 := _NhColor[FgC], color2 := _NhColor[BgC],  GrData := xCan);					
      ELSE
         GC_SetFillStyle      (style := rmp, GrData := xCan);					
         GC_SetLineWidth      (Width := wL,  GrData := xCan);
         IF FgC = 255 THEN
            GC_SetFgColor (Color 	:= _NhColor[0] ,GrData := xCan);		     // farba pozadia
            GC_SetBgColor (Color 	:= RGBA_TO_COLOR(r := rgb.R, g := rgb.G, b := rgb.B) ,GrData := xCan);		     // farba pozadia
         ELSE
            GC_SetFgColor (Color := _NhColor[FgC]    , GrData := xCan);
            GC_SetBgColor (Color := _NhColor[BgC]    , GrData := xCan);
         END_IF;
      END_IF;
   END_IF;
      IF noxy THEN
         ;
      ELSIF xy THEN
         GC_MoveTo   (x := x, y := y , GrData := xCan);
      ELSE
         GC_MoveTo   (x := xO^.x + x, y := xO^.y + y , GrData := xCan);
      END_IF;


   IF crc THEN
      GC_CCircle   (fill  := fil, r:= wC / 2,   GrData := xCan);  // kruznica                       2000:
   END_IF;
   IF box THEN
      GC_CRoundBox(fill  := fil, width := wC, height := hB,  r := r , GrData := xCan);
   END_IF;
   IF obr > 0 THEN
      GC_CImage   (filename := _NhFnObr(fn := obr), width := wO, height := wO,	GrData := xCan);
   END_IF;
	wrk	:= true;
   IF txt > -1 THEN
      CASE txt OF
        0 : ; // vypise sa to co je v yTx1
        1 : yTx1 := 'OFF';
        2 : yTx1 := 'ON';
        3 : yTx1 := USINT_TO_STRINGF(REAL_TO_USINT(vr),'%u');                      // vystredene cislo
        7 : yTx1 := REAL_TO_STRINGF(vr,'%7.1f°');                                  // vystredena teplota
            aTrim(txt := ADR(yTx1), wht := 3);
        8 : yTx1 := REAL_TO_STRINGF(vr,yTx2);                                      // hodnota naformatovana podla yTx2
//        10: yTx1 := REAL_TO_STRINGF(vr,'%7.1f°');                                  // teplota v browse
//        11: yTx1 := REAL_TO_STRINGF(vr,'%5.0f%%');                                 // % osvetlenia v browse
         9: yTx1 := REAL_TO_STRINGF(xDev^.al.ou.val,'%3.0f°');    						// teplota home
        10: yTx1 := REAL_TO_STRINGF(xDev^.al.ou.val,'%6.1f°');                                  // teplota v browse
            aTrim(txt := ADR(yTx1), wht := 3);
        11: yTx1 := REAL_TO_STRINGF(xDev^.al.ou.val,'%5.0f%%');                                 // % osvetlenia v browse
            aTrim(txt := ADR(yTx1), wht := 3);
        12: yTx1 := UINT_TO_STRINGF(xDev2^.al.et,'%d lx');                         // luxy ????
        13: yTx1 := 'GO';
        14: yTx1 := 'STOP';
//        15: yTx1 := REAL_TO_STRINGF(xDev^.al.ou.val,'%3.0f%');                                 // % osvetlenia v browse
        15: yTx1 := USINT_TO_STRINGF(REAL_TO_USINT(xDev^.al.ou.val),'%u');                  // cislo 0..255
        16: yTx1 := USINT_TO_STRINGF(xDev^.al.sta,'%u');
        17: yTx1 := INT_TO_STRINGF(xDev^.al.ex,'%u');
       100: yTx1 := yTx2;
       101: IF xO^.cf.c > 0 THEN
               _NhxPt(c := xO^.cf.c, n := xO^.cf.n, x:=7);                               // nazov DEV
               yTx1 := xPt^.cf.Name;
               yTx1 := LEFT(yTx1,xO^.w/8);
            ELSE
               yTx1 := '_NhVal2(txt=101)';
            END_IF;
            aTrim(txt := ADR(yTx1), wht := 3);
       102: yTx1  := xO^.fmt;
      END_CASE;
	ELSIF txt = -2 THEN
		IF nTxt > 0 THEN
		  _Nh_Lang(id := nTxt ,txt := ADR( yTx1 ));
		ELSE
			wrk := false;
		END_IF;
	ELSE
		wrk	:= false;	
	END_IF;   	
	IF wrk THEN
	   IF nofmt THEN
         ;
      ELSIF fmt > 9 THEN                                                             // pod textom bude vymazany box farbou pozadnia
         vai := _Nh_Sty[fmt-10];  // + GTEXT_STYLE_FILLBG;
         GC_SetFillStyle   (style := GFILL_STYLE_BGCOLOR , GrData := xCan);					
         GC_SetFgColor     (Color := _NhColor[0]    , GrData := xCan);          // farba ramceka
         GC_SetBgColor     (Color := _NhColor[0]    , GrData := xCan);          // farba podkladu
         GC_CBox           (fill  := fil, width := xO^.w+2 , height := wt + 4 ,   GrData := xCan);  // podklad pod textom
         GC_SetTextstyle(style   := vai               , GrData := xCan);           // formatovanie textu zlava do prava
      ELSIF fmt = -1 THEN                                                             // pod textom bude vymazany box farbou pozadnia
         GC_SetFillStyle(style   := GFILL_STYLE_BGCOLOR, GrData := xCan);					
      ELSIF fmt = -2 THEN                                                             // pod textom bude vymazany box farbou pozadnia
         GC_SetTextstyle(style   := INT_TO_UINT(fmt)  , GrData := xCan);           // formatovanie zlava do prava
      ELSE
         vai := _Nh_Sty[fmt];                                                       // format textu bez podkladu
         GC_SetTextstyle(style   := vai               , GrData := xCan);           // formatovanie textu
      END_IF;
      GC_SetTextSize (size 	:= INT_TO_USINT(wt) , GrData := xCan);           // vyska textu
      GC_SetFgColor  (Color 	:= _NhColor[FgT]    , GrData := xCan);           // farba textu
      GC_WriteText   (text    := yTx1             , GrData := xCan);           //
   END_IF;
END_FUNCTION

FUNCTION _webState {HIDDEN} : USINT
   VAR_INPUT
      s     : T_SESSION_STATE;
   END_VAR
   CASE s OF
      SESSION_EMPTY     : _webState:=0; yTx3 := 'EMPTY  ';    // Spojení je volné
      SESSION_LOGIN     : _webState:=1; yTx3 := 'LOGIN.B';    // Zahájení prihlášení uživatele k web serveru
      SESSION_LOGIN_RUN : _webState:=2; yTx3 := 'LOGIN.R';    //Probíhá prihlašování uživatele k web serveru
      SESSION_ACTIVE    : _webState:=3; yTx3 := 'ACTIVE ';    //Probíhá komunikace s úspešne prihlášeným uživatelem
      SESSION_LOGOUT    : _webState:=4; yTx3 := 'LOGOUT ';    // Probíhá odlašování uživatele (ukoncuje se spojení)
      ELSE                _webState:=5; yTx3 := '???    ';
   END_CASE;
END_FUNCTION



FUNCTION _NhTchXY {HIDDEN} : BOOL    // dotyk nad bodom s rozptylom medzi hranicami  v1...v...v2
   VAR_INPUT
      v      : INT;
      v1     : INT;
      v2     : INT;
      xy     : INT := 20;
   END_VAR
   _NhTchXY := true;
   IF v >= v1 - xy  AND                                       // nie na hranica
      v <= v2 + xy THEN
      RETURN;
   END_IF;
   _NhTchXY := false;
END_FUNCTION













FUNCTION _NhShwMnu {HIDDEN}  : BOOL              // preberie ciastocne MENU z predchadzajucej urovne
   VAR_TEMP
      fn    : INT;
   END_VAR
      GC_SetFillStyle      (style := GFILL_STYLE_GRADIENT, GrData := xCan);					
//      IF xL^.obj = 34 OR xL^.obj = 36 THEN     // IOV,FVL
      IF xL^.chk  THEN        // IOV,FVL
//         GC_SetGradientStyle  (style := GGRADIENT_STYLE_LINEAR, color1:= GCOLOR_BLACK, color2:=GCOLOR_GREEN+GCOLOR_TRANSPARENT1_4, GrData := xCan);			
         GC_SetGradientStyle  (style := GGRADIENT_STYLE_LINEAR, color1:= GCOLOR_BLACK, color2:=GCOLOR_GREEN, GrData := xCan);			
         GC_RoundBox          (fill:=1, r:=10, x:= 5, y:= 5, width := x2 ,height := y1-5, GrData := xCan);                    // horny modry podklad
      	GC_SetFgColor        (Color 	:= GCOLOR_WHITE, GrData := xCan);                                                         // nadpis cierna /zaelena
      ELSE
         GC_SetGradientStyle  (style := GGRADIENT_STYLE_LINEAR, color1:= GCOLOR_BLACK, color2:=GCOLOR_AZURE, GrData := xCan);			
         GC_RoundBox          (fill:=1, r:=5, x:= 0, y:= 0, width := x2 ,height := 105, GrData := xCan);
      	GC_SetFgColor        (Color 	:= GCOLOR_WHITE, GrData := xCan);
      END_IF;
      // vymazat priestor spodneho menu
      GC_SetFillStyle      (style := GFILL_STYLE_BGCOLOR, GrData := xCan);					
      GC_SetBgColor        (Color 	:= _NhColor[0] ,GrData := xCan);		                                                    // farba pozadia
      GC_Box               (fill:=1, x:= x0, y:= ky2, width := x2 ,height := 130, GrData := xCan);
      // obrazky
      FOR i := 1  TO 8 DO
         x := xU^.o[i].w;
         IF xU^.o[i].kxy = false THEN
            xU^.o[i].y  := REAL_TO_INT(INT_TO_REAL(xU^.o[i].y) * yk);
            xU^.o[i].kxy := true;
         END_IF;

         GC_MoveTo   (x :=xU^.o[i].x, y := xU^.o[i].y, GrData := xCan);
         IF i = xU^.n THEN       // podfarbenie vybrateho menu
            GC_SetFillStyle      (style := GFILL_STYLE_GRADIENT, GrData := xCan);					
            IF xL^.chk THEN     // IOV,FVL
//               GC_SetGradientStyle  (style := GGRADIENT_STYLE_LINEAR, color2:= GCOLOR_BLACK, color1:=GCOLOR_GREEN+GCOLOR_TRANSPARENT1_4, GrData := xCan);			
               GC_SetGradientStyle  (style := GGRADIENT_STYLE_LINEAR, color2:= GCOLOR_BLACK, color1:=GCOLOR_GREEN, GrData := xCan);			
            ELSE
               GC_SetGradientStyle  (style := GGRADIENT_STYLE_LINEAR, color2:= GCOLOR_AZURE + GCOLOR_TRANSPARENT3_4 , color1:=GCOLOR_AZURE, GrData := xCan);			
            END_IF;
            GC_CRoundBox          (fill:=1, r:=15, width := x ,height := x, GrData := xCan);
            fn := xU^.o[i].wh;                                                                                  // obrazok, ked je mnu vybrate
            x  := x - 5;
         ELSE
//            GC_MoveTo   (x :=xU^.o[i].x, y := xU^.o[i].y, GrData := xCan);
            fn := xU^.o[i].fn;                                                                                                // len zobrazit, nie vybrat
         END_IF;
         IF fn <> 0 THEN
            GC_CImage   (filename := _NhFnObr(fn := fn ), width := x, height := x,	GrData := xCan);
         END_IF;
      END_FOR;
      GC_SetFillStyle      (style := GFILL_STYLE_BGCOLOR, GrData := xCan);					                                        // farba neaktivnej ciary
     	GC_SetBgColor        (Color 	:= _RgbBck ,GrData := xCan);		                                                          // farba pozadia
      // text
      GC_MoveTo            (x := xc , y := xU^.o[1].y , GrData := xCan);
      GC_SetTextSize       (size 	:= 32, GrData := xCan);                            // vyska textu je aj pre hodnotu aj pripadny text
      GC_SetTextstyle      (style := _Nh_Sty[2], GrData := xCan);
		GC_CWriteText        (text := xL^.naz, GrData := xCan);
      // ciara
     	GC_SetFgColor        (Color 	:= GCOLOR_GRAY,GrData := xCan);		// farba aktivnej ciary
      GC_SetLineWidth      (Width := 2, GrData := xCan);
      GC_SetLineStyle      (style := GLINE_CAP_ROUND + GLINE_STYLE_SOLID, GrData := xCan);
      GC_Line              (y1 := ky2, y2 := ky2, x1:= 20, x2 := x2-20,GrData := xCan);
END_FUNCTION

FUNCTION _NhVazPar {HIDDEN} : BOOL  //
         IF xR^.h.in THEN
            xR^.h.cf       := xVaz^.in;                                    // preberie sa aj s parametrami
            xR^.o.ob[1].cf := xVaz^.in;
            xR^.o.ob[2].cf := xVaz^.in;
            xR^.o.ob[4].cf := xVaz^.ou;
         ELSE
            xR^.h.cf       := xVaz^.ou;
            xR^.o.ob[1].cf := xVaz^.ou;
            xR^.o.ob[2].cf := xVaz^.ou;
            xR^.o.ob[4].cf := xVaz^.in;
         END_IF;
END_FUNCTION

FUNCTION _NhUsrPar  {HIDDEN} : BOOL  // nastavi aktualne zobrazenie pre usra do menu[2], xL^.dsh
   VAR_INPUT
      sav      : BOOL;                 // true = ulozi k usrovi , false =  precita z usra
      fav      : BOOL;                 // favorite
      dsh      : BOOL;                 // dash
//      qck      : BOOL;
      ds1      : BOOL;
      qc1      : BOOL;
      usr      : USINT;                // ak je > 0 pouzije sa, inak aktualny user
   END_VAR
   _NhUsrPar   := true;
   IF usr = 0 THEN
      usr := xA^.usr;
   END_IF;
   _NhxPtU(c := 22, n :=usr ,x:=-1); xUsr := xPt;                                                // namapuje usra
   IF fav   THEN
      IF sav THEN
         xUsr^.cx.fav := xA^.fav;
      ELSE
         xA^.fav := xUsr^.cx.fav;
      END_IF;
   END_IF;
   IF ds1   THEN
      IF sav THEN
         xUsr^.cx.ds1 := xL^.rw1;
      ELSE
         xL^.rw1 := xUsr^.cx.ds1;
      END_IF;
   END_IF;
   IF qc1   THEN
      IF sav THEN
         xUsr^.cx.qc1 := xL^.rw1;
      ELSE
         xL^.rw1 := xUsr^.cx.qc1;
      END_IF;
   END_IF;
   IF dsh   THEN
      IF sav THEN
         xUsr^.cx.Brw[xL^.obj] := xL^.dsh;                  // ulozi cislo DSH k browsu
      ELSE
         xL^.dsh := xUsr^.cx.Brw[xL^.obj];
      END_IF;
   END_IF;
END_FUNCTION

FUNCTION  _Nh_Brw_Dsh_Chg   {HIDDEN}    : BOOL  // nastavi aktualne zobrazenie pre usra do menu[2], xL^.dsh
   VAR_INPUT
      chg      : BOOL;
      mnu      : USINT := 1;                                         // default je horne lave menu
   END_VAR
   _Nh_Brw_Dsh_Chg := true;
   xL^.dsh := LIMIT(1,xL^.dsh,4);										// opravi ak treba				
   IF xA^.usr = 0 THEN														// ziadny user nastavi default
      _Nh_Brw_Dsh_Chg 		:= 0;
      xL^.dsh   				:= 1;                                                  // nacita aktualny dsh
      RETURN;
   END_IF;

	IF xUsr^.cx.DshSet THEN													// user moze menit
	   IF xL^.obj <= 30 THEN
   	   xL^.dsh := LIMIT(1,xUsr^.cx.brw[ xL^.obj ],3);  // nacita a nastavi ulozeny dsh
	   END_IF;
	   IF chg THEN                                              // pri zmene
   	   xL^.dsh := xL^.dsh + 1;
	   END_IF;
   	CASE xL^.dsh OF
	      2 :   ix 		:= 157;
   	   3 :   ix 		:= 158;
	   ELSE     ix 		:= 156;
   	         xL^.dsh 	:= 1;
	   END_CASE;
	   IF xL^.obj <= 30 THEN

//   	   _NhSysUpd(chg := xUsr^.cx.brw[ xL^.obj ] <> xL^.dsh);

      	xUsr^.cx.brw[ xL^.obj ] := xL^.dsh;                            // ulozi k usrovi
	   END_IF;
   	IF mnu > 0 THEN                               // rezim meny dsh
      	xU^.o[mnu].fn    := ix;                                        // prepnutie zobrazenie dash / riadok
	      xU^.o[mnu].cm    := 43;                                        // funkcia z menu
		ELSE
      	xU^.o[mnu].fn    := 0;                                        // prepnutie zobrazenie dash / riadok
	      xU^.o[mnu].cm    := 0;                                        // funkcia z menu
   	END_IF;
	   xL^.obd          := mnu;                                        	// funkcia z menu
	END_IF;
END_FUNCTION

FUNCTION _NhTchObjXYW {HIDDEN}: BOOL   // dotyk nad objektom X,Y,W
   VAR_INPUT
      x  :  INT;  // Lavy zaciatok objektu
      y  :  INT;  // nad objektom
      w  :  INT;  // sirka objeku
		h	:  INT := -1;	// vyska
   END_VAR
	IF h = -1 THEN
		h	:= w;
	END_IF;
   IF xA^.tch.x1 >= x 		AND                 // zaciatok X
      xA^.tch.x1 <= x + w 	AND                 // koniec X
      xA^.tch.y1 >= y  		AND                 // y-navrchu
      xA^.tch.y1 <= y + h  THEN                // y-spodok
      _NhTchObjXYW := true;
   ELSE
      _NhTchObjXYW := false;
   END_IF;
END_FUNCTION

VAR_GLOBAL
	yR 	: NH_ROW;
END_VAR


FUNCTION _Nh_Web_SHW_107 {HIDDEN} : BOOL      // vykreslit doplnujuce objektynad hlavnym objektom, dotyk a cykonanie pripadneho CMD
   VAR_INPUT
      tch      : BOOL;
 		row		: bool;
		obj		: SINT;
   END_VAR
   VAR
      x,y,o      : INT;
      r			: USINT;
   END_VAR
	yR		:= xR^;
   x4o   := xO;
   _Nh_Web_SHW_107 := false;
   FOR i := 1 TO 4 DO
      IF x4O^.ok[i] THEN
//y4O := x4O^;
			r := x4O^.obj;				
			IF row THEN
				xO2 := ADR(xB^.r[ r ].o.ob[obj]);
			ELSE
				xO2 := ADR(xR^.o.ob[ r ]);
			END_IF;
   		grp   := xO2^.w * 10 / 28;                  // suradnica posunu vypocitana podla velkosti objektu
   	   x     := xO2^.x;
      	y     := xO2^.y;
         CASE i OF
            1: x  := x  - grp;
               y  := y  - grp;
            2: x  := x  + grp;
               y  := y  - grp;
            3: x  := x  - grp;
               y  := y  + grp;
            4: x  := x  + grp;
               y  := y  + grp;
         END_CASE;
         grp   := USINT_TO_INT(x4o^.wxy[i]);
         IF tch THEN
            IF _NhTchObjXYW(x:=x-grp/2, y:=y-grp/2, w:=grp) AND x4o^.cmd[i] > 0 THEN
               xA^.tch.cmd := x4o^.cmd[i];
               xA^.tch.cm  := x4o^.cmd[i];
//               xR^.o.ob[ x4O^.obj ].tch := false;
               _Nh_Web_SHW_107 := true;
               EXIT;
            END_IF;
//            xO^.tch     := 0;                ///***
         ELSE
				nDel	:= 2;												// formatovanie na stred
            IF x4o^.fil[i] THEN
                ii := 0;                       				// FgC - farba popredia kruznice bude cierna
             ELSE
               ii := x4o^.BgC[i];                    		// farba
            END_IF;
            IF x4o^.txt[i] THEN
               del   := 0;
               jj    := 0;                              	
					IF x4o^.obr[i] >= 10000 THEN					// predsadi pred/za obrazok					
						nNew := x4o^.obr[i] - 10000;
						IF i = 1 OR i = 3 THEN						// vlavo pred objekt
							nDel	:= 1;									// <--
							x		:= xO2^.x - xO2^.w*10/3 ;
						ELSE
							x		:= xO2^.x + xO2^.w/2 + xO2^.w/10 ;
							nDel	:= 0;									// -->
						END_IF;
					ELSE
						nNew := x4o^.obr[i];
					END_IF;											
               yTx1  := INT_TO_STRING(nNew);      // cislo z obrazka sa prevedie na text
            ELSE
               del   := x4o^.obr[i];               		// bude cislo obrazka
               jj    := -1;
            END_IF;
				o	:= USINT_TO_INT(x4o^.wxy[i]);
				IF x4o^.crc[i] THEN
               IF x4o^.txt[i]  THEN
                  grp := grp * 20 / 39;
						IF x4o^.obr[i] > 99 THEN
							o := o*10/7;
						END_IF;					
//               ELSIF x4o^.fil[i] = false THEN
					ELSE
                  grp := grp * 10 / 11;
					
               END_IF;
            END_IF;
                     _NhVal2(
                                 crc   := x4o^.crc[i],
                                 wC    := o,
                                 grd   := 2,                                  // kruh s oramovanim bez gradientu
                                 wL    := 1,                                  // hrubka kruznice
                                 fil   := x4o^.fil[i],
                                 xy    := true,                               // move to x,y
                                 x     := x,
                                 y     := y,
                                 obr   := del,                        // >0 obrazok, <=0 ignoruje, je to text
                                 wO    := grp,
                                 wT    := grp,
                                 fmt   := nDel,
                                 txt   := jj,
                                 FgT   := x4o^.FgT[i],
                                 FgC   := ii,
                                 BgC   := x4o^.BgC[i]
                              );

         END_IF;
      END_IF;
   END_FOR;
END_FUNCTION



FUNCTION _NhDayObr {HIDDEN}: INT      // vykreslit doplnujuce objektynad hlavnym objektom, dotyk a cykonanie pripadneho CMD
   VAR_INPUT
      off   : BOOL;
      day   : SINT;
   END_VAR
   CASE day OF
     0 : _NhDayObr := 140;
     1 : _NhDayObr := 142;
     2 : _NhDayObr := 144;
     3 : _NhDayObr := 146;
    10 : _NhDayObr := 148;      // vychod slnka
    11 : _NhDayObr := 147;      // zapad slnka
   END_CASE;
   IF off THEN
      _NhDayObr := _NhDayObr - 1;
   END_IF;
END_FUNCTION


FUNCTION _Nh_FRM_Read_SLIDER {HIDDEN}: BOOL
	IF yFrmName.sld > 0 THEN                                                     		// mame slider
		OffSrc := USINT_TO_UDINT(yFrmName.row) * SIZEOF(NH_ROW_O);          				// slider zacina za riadkami browsu
		OffDst := (yFrmName.siz - SIZEOF(NH_FRM_HED) - OffSrc) / SIZEOF(NH_SLD_DAT) ;	// kolko riadkov realne obsahuju zvysne data
//		OffDst := USINT_TO_UDINT(yFrmName.sld);
		memCpyPTR(	source	:= ADR(yFrmData) + offSrc ,											// adresa zaciatku slidera
						dest		:= PTR_TO_UDINT(ADR( xB^.s[0] )) ,	                     // kopiruje sa do slidera 0
						length	:= OffDst * SIZEOF(NH_SLD_DAT) );                        // pocet sliderov * velkost slidera {ak bude 0 tak sa nic nekopiruje}
	END_IF;
END_FUNCTION

FUNCTION  _NhIsObrOk {HIDDEN}: BOOL (* yTx1:=CONCAT('_',UINT_TO_STRINGF(frm,'%03u')); yTx2:=CONCAT(aSys.ADR_RAM,'FRM/',yTx1,'.FRM'); *)
	VAR_INPUT
		frm	: UINT;
	END_VAR
//	yTx0 := CONCAT('_',UINT_TO_STRINGF(frm,'%03u'));
	rb := _Nh_Log_PATH(wh:=24, frm:=7, obr:=frm); 		//yTx2:='_999", yTx1:='RAM/FRM/_999.FRM'
// 	If yFrmName.Name = yTx0 THEN
 	If yFrmName.Name = yTx2 THEN
		_NhIsObrOk := TRUE;
		RETURN;
	ELSE
		_NhIsObrOk := false;	
	END_IF;
//	fH 	:= INVALID_HANDLE_VALUE;
//	yTx0 	:= CONCAT(aSys.DiskHed.Disk[4].path,'FRM/',yTx0,'.FRM');							// RAM/
//  	IF _NhFOpen(fN:=yTx0, fH:=fH) THEN
  	IF _NhFOpen(fN:=yTx1, fH:=fH) THEN
     	yFrmName.siz 	:= fS;	
  		yFrmName.siz 	:= FileRead  (hFile := fH, adrBuf := PTR_TO_UDINT(ADR(mObr)), size := fS );
		_NhIsObrOk		:= yFrmName.siz = fS;
		rb					:= _NhFClose(fH:=fH);
	END_IF;
END_FUNCTION


FUNCTION _Nh_FRM_Read {HIDDEN}: BOOL
   VAR_INPUT
		ref		: BOOL;
      frm      : UINT;          // pripona suboru
      row      : USINT;
   END_VAR
   VAR_TEMP
      i        : USINT;
   END_VAR
  	If _NhIsObrOk(frm := frm) THEN
		_Nh_FRM_Read := TRUE;
		If ref THEN
			RETURN;
		END_IF;
	ELSE
		_Nh_FRM_Read := false;	
		RETURN;
	END_IF;
	CASE yFrmName.wht OF
     0 :	// all file for next specific use
			;
     1 :	// browser
			offSrc := SIZEOF(NH_ROW_O) * USINT_TO_UDINT( MIN(yFrmName.row,xL^.dsh-1) ); 		// posun na konkretny riadok podla DSH
			memCpyPTR(	source	:= ADR(yFrmData) + offSrc ,                              		// z konkretneho riadka
							dest		:= PTR_TO_UDINT(ADR( xB^.r[row].o )) ,								// do aktualneho riadka
							length	:= SIZEOF(NH_ROW_O) );                                   	// velkost 10 objektov
			IF yFrmName.sld > 0 THEN                                                     		// mame slider
				OffSrc := USINT_TO_UDINT(yFrmName.row) * SIZEOF(NH_ROW_O) + USINT_TO_UDINT(xL^.dsh-1) * SIZEOF(NH_SLD_DAT);          				// slider zacina za riadkami browsu
				memCpyPTR(	source	:= ADR(yFrmData) +	OffSrc, 													// zaciatok DASH-1

								dest		:= PTR_TO_UDINT(ADR( xB^.s[row] )) ,	                     // kopiruje sa do slidera 0
								length	:= SIZEOF(NH_SLD_DAT) );                        // pocet sliderov * velkost slidera {ak bude 0 tak sa nic nekopiruje}
			END_IF;


//			_Nh_FRM_Read_SLIDER();

     2 :	// FRM
     		xRowO := ADR(yFrmData);
			FOR i := 1 TO yFrmName.row DO
				IF xB^.r[i].h.nd = 0 THEN
					xB^.r[i].h.nd 	:= USINT_TO_INT(i) ;
				END_IF;
				xB^.r[i].o		:= xRowO^;	
				xRowO				:= xRowO + SIZEOF(NH_ROW_O);
         END_FOR;
			_Nh_FRM_Read_SLIDER();
     3 :	// menu
			i		:= xM^.lvl;
			memCpyPTR(	source	:= PTR_TO_UDINT(ADR(yFrmData)) ,
							dest		:= PTR_TO_UDINT(ADR(xM^.mnu[i])) ,	
							length	:= SIZEOF(NH_MNU) );
     4 :	// HOME-PG - ALL
     		xRowO := ADR(yFrmData);
			FOR i := 0 TO yFrmName.row  DO
				xB^.r[i].h.nd 	:= USINT_TO_INT(i) ;
				xB^.r[i].o		:= xRowO^;	
				xRowO				:= xRowO + SIZEOF(NH_ROW_O);
			END_FOR;
   END_CASE;

END_FUNCTION




FUNCTION _Nh_Get_Frm260  {HIDDEN} : BOOL					//
	VAR_INPUT
		cmd	: BOOL;
		cf		: USINT;
		nd		: INT;
		grp	: USINT;
	END_VAR
	_Nh_Get_Frm260 := _NhIsObrOk(frm:=260);
	_NhxPt (c := cf, n := nd,x:=35);
	yFrm_260.typ := xPt^.cf.typ;											   // typ vyssej casti	
	yFrm_260.grp := grp;

		yFrm_260.m := 0;
		FOR i := 0 TO yFrm_260.nWsb DO
			IF yFrm_260.mWsb[i].mWsb = grp AND			// presna skupina
				( 	yFrm_260.mWsb[i].typ = yFrm_260.typ OR       // konkretny typ
					yFrm_260.mWsb[i].typ = -1)             		// plati pre vsetky typy
				THEN
				yFrm_260.m := i;	
				EXIT;
			END_IF;
	  	END_FOR;
		IF cmd THEN
			pWsb^.cm.cmd	:= yFrm_260.mWsb[yFrm_260.m].pvCmd;	
		ELSE
			xOh^.cf			:= yFrm_260.mWsb[yFrm_260.m].cf;
			xOh^.txt			:= yFrm_260.mWsb[yFrm_260.m].txt;
		END_IF
END_FUNCTION


VAR_GLOBAL
	_NhBrwObj 						: NH_BRW_OBJ;
//   _eRowBrw6      {HIDDEN} : NH_ROW_O ;         // pre kompatibilitu sa niekde pouziva
END_VAR


FUNCTION _NhTypObr  {HIDDEN} : BOOL
	VAR_INPUT
   	cf 		: USINT;
   	typ		: SINT;
		dev		: USINT;
		txx		: USINT;
	END_VAR
	cf 	:= LIMIT(cf ,0,_Nh_CFG);
	dev	:= LIMIT(dev,0,_Nh_CFG);
	_NhTypObr 	:= true;
//	xTypObr 		:= ADR(mObr);
  	If _NhIsObrOk(frm := 230) THEN
		_NhTypObr := TRUE;
	ELSE
		_NhTypObr := false;	
		RETURN;
	END_IF;
	CASE cf OF
 		13: 	// WSB
      		typ := MAX(1,typ/2);
	END_CASE;

	txx	:= yFrm_230.obr[cf ].wht;	
//	typ   := LIMIT(ABS(typ),0, 5);
  	CASE  yFrm_230.obr[cf ].obr OF
   	-5 : 	xObrWht 		:= ADR(yFrm_230.T05[ txx ,  typ ].obr );	
				_NhTypObr   := yFrm_230.T05[ txx ,  typ ].fil[dev] OR yFrm_230.T05[ txx , typ ].fil[0] ;
     -10 : 	xObrWht 		:= ADR(yFrm_230.T10[ txx ,  typ ].obr );	
				_NhTypObr   := yFrm_230.T10[ txx ,  typ ].fil[dev] OR yFrm_230.T10[ txx , typ ].fil[0] ;
     -15 : 	xObrWht 		:= ADR(yFrm_230.T15[ txx ,  typ ].obr );	
				_NhTypObr   := yFrm_230.T15[ txx ,  typ ].fil[dev] OR yFrm_230.T15[ txx , typ ].fil[0] ;
	//			_NhTypObr   := true;	//yFrm_230.T15[ txx ,  typ ].fil[dev] OR yFrm_230.T15[ txx ,  0 ].fil[dev] ;
	ELSE	xObrWht := ADR(yFrm_230.obr[cf ]);	
   END_CASE;
END_FUNCTION

FUNCTION _Nh_POI_INI_REC {HIDDEN}   : INT	    // urobi testy POI, prida nove, vymaze stare
	_Nh_POI_INI_REC := 0;
	FOR i := 1 TO _Nh_CFG DO
		IF aCfg[i].NbrPoi > 0 THEN
		   _Nh_POI_INI_REC := _Nh_POI_INI_REC + ( 11 * ( aCfg[i].rec * USINT_TO_INT(aCfg[i].NbrPoi)) );
		END_IF;
   END_FOR;
END_FUNCTION

// HET _Nh_POI_INI_NEW(cf:=xR^.h.cf.c, nd1:=xR^.h.cf.n, nd2:=xR^.h.cf.n, del:=true);

FUNCTION _Nh_POI_INI_NEW {HIDDEN} : BOOL	// skontroluje vetu POI alebo ju vytvori zo sablony pre zadane CFG a POI
											// NESMIE SA SPUSTAT NARAZ DEL A NEW !!!!
   VAR_INPUT
//		new	: BOOL;					// vsetky POI vynulovat a nanovo pridelit
		del	: BOOL;					// len vymaze POI, nic ine
      cf   	: USINT 	:= 1;
      nd1   : INT		:= 1;       // 1.rec z ROM/HET/VEN...
      nd2   : INT;               // posledne rec
		po1	: USINT 	:= 1;       // ktory den z poi[]
		po2	: USINT 	:= 11;
   END_VAR
	VAR_TEMP
		ok2			: BOOL;
		day			: USINT;
		WhtPoi		: USINT;	
		RecPoiReQ	: INT;
	END_VAR
   _Nh_POI_INI_NEW := true;
	RecPoiReQ :=_Nh_POI_INI_REC();				// na zaciatku sa spocita, kolko viet je potrebne

   _Nh_FRM_Read(frm:=247);
	IF nd2 = 0 THEN
		nd2 := aCfg[cf].rec;
	END_IF;
  	day	:= po1;
   WHILE nd1 <= nd2  DO                                		// pre CF
		ok2 := true;
		IF _Nh_xPod_Map(cf:=cf, nd:=nd1, WhtPoi:=WhtPoi) THEN                // veta ROM/HET/VEN, musi sa vzdy premapovat po pridani novych viet do POI
			IF xPod^.Day = 0 OR xPod^.Day > 11 THEN
         	xPod^.Day := SYSTEM_S.COUNTER_DAYS_OF_WEEK;										// kontrola na 0-day
			END_IF;
			WHILE day <= po2 DO
				IF del OR xPod^.poi[day] < 0 OR xPod^.poi[day] > aCfg[26].rec THEN									// vymaze stare alebo neplatne (-1) POI ak existuje a prida vzdy odkaz na novu vetu POI
					IF xPod^.poi[day] > 0 AND xPod^.poi[day] <= aCfg[26].rec THEN  // veta existuje
						IF _NhxPt(ok:=1, c:=26, n:=xPod^.poi[day], x:=-124) THEN  	// najde vetu aby ju vymazal
							xPt^.ok.ok := false;                 							// len zneplatni, neprepisuje udaje
						END_IF;
					END_IF;
					xPod^.poi[day] := 0;                                  			// vynuluje cislo vety pre day		
				END_IF;
				IF del  THEN                     						// len vymnazava, alebo opravuje, a nepridava
					;
				ELSIF xPod^.poi[day] = 0 THEN                      					// ak nename POI vetu, hlada sa DEL veta
					; //vyriesi sa dalej						
				ELSIF _NhxPt(ok:=1, c:=26, n:=xPod^.poi[day], x:=-124) = false THEN    // nenasla sa ani DEL veta
					xPod^.poi[day] := 0;
				END_IF;
				IF del THEN              									// len vymnazava, alebo opravuje
					day 	:= day + 1;
				ELSIF xPod^.poi[day] = 0 THEN													// nebola najdena DEL veta		
					ok1	:= false;
					IF aCfg[26].rec >= RecPoiReQ THEN	//_Nh_POI_INI_REC() THEN
						xPod^.poi[day] := _NhFindDel(wh:=0, cx:=26, new:=false, ok:=true); 	// ak najde vetu,oznaci ju ako OK
						IF xPod^.poi[day] > 0 THEN
							// xDel je uz namapovane a veta je OK
							xPox := xDel;
(*
						   yTx2  := CONCAT('  cf;nd;day;poi[day]: ',USINT_TO_STRINGF(cf,'%2u'),';',INT_TO_STRINGF(nd1,'%4u'),';',USINT_TO_STRINGF(day,'%2u'),';',INT_TO_STRINGF(xPod^.poi[day],'%4u')    )  ;
							yTx2  := CONCAT(yTx2,';',USINT_TO_STRINGF(WhtPoi,'%2u'),';',BOOL_TO_STRINGF(xPox^.ok.ok,'%b{on^off}'));
							_Nh1RowTxt(logRst:=1);
*)
							CASE cf OF
   	                 6 : xPox2 := ADR(yFrm_247.ini.HET);
      	             47 : xPox2 := ADR(yFrm_247.ini.VEN);
         	         ELSE  xPox2 := ADR(yFrm_247.ini.DAY);
            	      END_CASE;
							xPox2 		:= xPox2 + (SIZEOF(NH_POI) * USINT_TO_UDINT(day-1));	// zdroj=sablona
							xPox^			:= xPox2^;													// nakopiruje zo sablony
//							xPox^.ok.ok	:= true;
							day 			:= day + 1;
						ELSE
							ok1	:= true;							
						END_IF;
					ELSE
						ok1	:= true;
					END_IF;
					IF ok1 THEN
						aCfg[26].new := aCfg[26].new + (11 * USINT_TO_INT( aCfg[cf].NbrPoi ));		// prida rovno 11 viet, resp kolko zostava do 11					
						aCfg[26].nOk := false;                                         // neoznaci ako OK
						_Nh_Go_DbxToMem(ram := true);
						ok2 			:= false;
						RecPoiReQ 	:=_Nh_POI_INI_REC();				// len v pripade, ze by sa nenasla DEF-veta
						EXIT;
					END_IF;	
				ELSE
					day := day + 1;
				END_IF;
			END_WHILE;		// day
		ELSE
			WhtPoi   := 200;												// len  aby sa posunul
		END_IF;
		IF ok2 THEN  																				// vykonali sa vsetky poi[1..11] v jednej vete CF, ide sa na dalsiu
			IF WhtPoi + 1 < aCfg[cf].NbrPoi THEN
				WhtPoi 	:= WhtPoi + 1;	
			ELSE
				WhtPoi 	:= 0;	
				nd1 		:= nd1 + 1;
			END_IF;
			day	:= po1;			
		END_IF;
	END_WHILE;
END_FUNCTION

FUNCTION _NhFilDev  {HIDDEN} : BOOL
   VAR_INPUT
		lst	: BOOL;
		clear	: BOOL;	
      wht   : USINT;
      row   : USINT;
      n     : USINT;
   END_VAR
	_NhFilDev := TRUE;
	{ $ IFDEF __NH_WEB }
	IF lst THEN
	  	IF _NhIsObrOk(frm := 236) THEN
		   CASE wht OF
   		  0 : ; // vsetky filtre vo filt
	   	  1 : xF^.dev  := yFrm_236.rgbwa;       						// ktore DEV maju HW nahradene DLs + RGBWA
   		  2 : xF^.dev  := yFrm_236.iodev[row];
	   	  3 : xF^.dev  := yFrm_236.lst[row];
	   	END_CASE;
		END_IF;
	ELSIF _NhIsObrOk(frm := 234) THEN					// vlozi do xF^.dev zoznam DEV, vyhovoujucich browsu
		IF clear OR wht = 0 THEN
			xF^.dev := yFrm_234.iov[0];					// clear dev-list
			xF^.cat := yFrm_234.iov[0];					// clear dev-list
		END_IF;
	   CASE wht OF
   	  0 : ; // vsetky filtre vo filt
	     1 : xF^.dev		:= yFrm_234.rom[row];
   	  2 : xF^.dev  	:= yFrm_234.zon[row];
   	  4 : xF^.dev  	:= yFrm_234.iov[row];
//	     5 : _NhFilDev 	:= xF^.dev.n[n];	// len frati, ci DEV je v dev-liste
	     5 : _NhFilDev 	:= yFrm_234.in[row].n[n];	// len vati, ci DEV je v dev-liste
     	  7 : xF^.dev  	:= yFrm_234.set[row];
	   END_CASE;
		RETURN;	
	ELSE
		RETURN;
	END_IF;
	{ $ END_IF }
END_FUNCTION





