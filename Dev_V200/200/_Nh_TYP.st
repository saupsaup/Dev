 (* 2. DEFINICIA VSETKYCH ZAKLADNYCH TYPOV KTORE SU POUZITE V aCfg,aPar,aVaz *)

TYPE			//	TECO clone
	NH_TCIB_RFID {HIDDEN} : ARRAY[0..7] OF BYTE;                     // kompletny RFID kod aj 13Mhz
   NH_TCIB_CWG0503S_VAL {HIDDEN} : ARRAY[0..4] OF USINT;
	NH_TCIB_CHC_STAT {HIDDEN} : STRUCT
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      OUFI : BOOL;
      VLDI : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   NH_TCIB_AI2 {HIDDEN} : STRUCT
      AI1 : REAL;
      AI2 : REAL;
   END_STRUCT;

   NH_TCIB_DI2 {HIDDEN} : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;
(*
   NH_TCIB_VCHC_STAT {HIDDEN} : STRUCT
      READY : BOOL;
      RUN : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      WD : BOOL;
      FS : BOOL;
      SERVICE : BOOL;
      POSITION : REAL;
   END_STRUCT;
*)
   NH_TCIB_VCHC_STAT : STRUCT
      READY : BOOL;
      RUN : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      WD : BOOL;
      FS : BOOL;
      SERVICE : BOOL;
      POSITION : REAL;
   END_STRUCT;



   NH_TCIB_C_HC_0201F_E_IN {HIDDEN} : STRUCT                // TVE IN
      STAT : NH_TCIB_CHC_STAT;
      AI : NH_TCIB_AI2;
      iTHERM : REAL;
      DI : NH_TCIB_DI2;
      VSTAT : NH_TCIB_VCHC_STAT;
   END_STRUCT;



   NH_TCIB_VCHC_CONT {HIDDEN} : STRUCT
      INIT : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
      POSITION : REAL;
   END_STRUCT;


   NH_TCIB_C_HC_0201F_E_OUT {HIDDEN} : STRUCT
      VCONT : NH_TCIB_VCHC_CONT;
   END_STRUCT;


// *** KLAVESNICA s RFID - zakladna ***


   NH_TCIB_CWG0503S_STAT {HIDDEN} : STRUCT
      OUF4 : BOOL;
      VLD4 : BOOL;
      OUF5 : BOOL;
      VLD5 : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;



   NH_TCIB_CWG0503S_DI {HIDDEN} : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      DI3 : BOOL;
      DI4 : BOOL;
      DI5 : BOOL;
      TAMPER4 : BOOL;
      TAMPER5 : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;




   NH_TCIB_CWG0503S_CODE {HIDDEN} : STRUCT
      STAT : USINT;
      VAL : NH_TCIB_CWG0503S_VAL;
   END_STRUCT;





   NH_TCIB_C_WG_0503S_IN {HIDDEN} : STRUCT
      CODE : NH_TCIB_CWG0503S_CODE;
      STAT : NH_TCIB_CWG0503S_STAT;
      AI4 : REAL;
      AI5 : REAL;
      DI : NH_TCIB_CWG0503S_DI;
   END_STRUCT;



   NH_TCIB_DO3 {HIDDEN} : STRUCT
      DO1 : BOOL;
      DO2 : BOOL;
      DO3 : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;



   NH_TCIB_C_WG_0503S_OUT {HIDDEN} : STRUCT
      DOs : NH_TCIB_DO3;
   END_STRUCT;

   NH_TCIB_CKY0001R_DI {HIDDEN} : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      CLICK_DI1 : BOOL;
      CLICK_DI2 : BOOL;
      PRESS_DI1 : BOOL;
      PRESS_DI2 : BOOL;
      TAMPER1 : BOOL;
      TAMPER2 : BOOL;
   END_STRUCT;





   NH_TCIB_CKY0001R_STAT {HIDDEN} : STRUCT
      OUFT : BOOL;
      VLDT : BOOL;
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;



   NH_TCIB_C_KY_0001R_IN {HIDDEN} : STRUCT
      BUTTONS : BYTE;
      RF_CODE : NH_TCIB_RFID;
      DI : NH_TCIB_CKY0001R_DI;
      STAT : NH_TCIB_CKY0001R_STAT;
      THERM : REAL;
      AI1 : REAL;
      AI2 : REAL;
   END_STRUCT;

(*
   {$IFNDEF TCIB_C_KY_0001R_OUT}                            // KLAV WGA
   TCIB_C_KY_0001R_OUT : STRUCT
      SETT : BYTE;
      ICONS : BYTE;
      TIM : INT;
      TEXT1 : STRING[16];
      TEXT2 : STRING[16];
   END_STRUCT;
   { $END_IF }
*)
(*
   NH_TCIB_CWG0503S_CODE {HIDDEN} : STRUCT
         STAT : USINT;
         VAL : NH_TCIB_CWG0503S_VAL;
      END_STRUCT;
*)



   NH_TCIB_C_KY_0001R_OUT {HIDDEN} : STRUCT
      SETT : BYTE;
      ICONS : BYTE;
      TIM : INT;
      TEXT1 : STRING[16];
      TEXT2 : STRING[16];
   END_STRUCT;




   NH_TCIB_C_WS_0000R_PG_CONT  {HIDDEN} : STRUCT
      DOT1A : BOOL;
      DOT2A : BOOL;
      DOT1B : BOOL;
      DOT2B : BOOL;
      DBA : BOOL;
      DBB : BOOL;
      BZ : BOOL;
      PX : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_PG_LED  {HIDDEN} : STRUCT
      LED1 : BOOL;
      LED2 : BOOL;
      LED3 : BOOL;
      LED4 : BOOL;
      LED5 : BOOL;
      LED6 : BOOL;
      LED7 : BOOL;
      LED8 : BOOL;
      LED9 : BOOL;
      LED10 : BOOL;
      LED11 : BOOL;
      LED12 : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
      RED1 : BOOL;
      RED2 : BOOL;
      RED3 : BOOL;
      RED4 : BOOL;
      RED5 : BOOL;
      RED6 : BOOL;
      dummy22 {HIDDEN} : BOOL;
      dummy23 {HIDDEN} : BOOL;
      GREEN1 : BOOL;
      GREEN2 : BOOL;
      GREEN3 : BOOL;
      GREEN4 : BOOL;
      GREEN5 : BOOL;
      GREEN6 : BOOL;
      dummy30 {HIDDEN} : BOOL;
      dummy31 {HIDDEN} : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_PG_GLASSO  {HIDDEN} : STRUCT
      CONT : NH_TCIB_C_WS_0000R_PG_CONT;
      LED : NH_TCIB_C_WS_0000R_PG_LED;
      BLIGHT : USINT;
      DISPA : INT;
      DISPB : INT;
      SETA : USINT;
      SETB : USINT;
   END_STRUCT;


   NH_TCIB_C_WS_0000R_PG_BTN  {HIDDEN} : STRUCT
      BTN1 : BOOL;
      BTN2 : BOOL;
      BTN3 : BOOL;
      BTN4 : BOOL;
      BTN5 : BOOL;
      BTN6 : BOOL;
      BTN7 : BOOL;
      BTN8 : BOOL;
      BTN9 : BOOL;
      BTN10 : BOOL;
      BTN11 : BOOL;
      BTN12 : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      PR : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_PG_CLICK  {HIDDEN} : STRUCT
      CLICKB1 : BOOL;
      CLICKB2 : BOOL;
      CLICKB3 : BOOL;
      CLICKB4 : BOOL;
      CLICKB5 : BOOL;
      CLICKB6 : BOOL;
      CLICKB7 : BOOL;
      CLICKB8 : BOOL;
      CLICKB9 : BOOL;
      CLICKB10 : BOOL;
      CLICKB11 : BOOL;
      CLICKB12 : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_PG_PRESS  {HIDDEN} : STRUCT
      PRESSB1 : BOOL;
      PRESSB2 : BOOL;
      PRESSB3 : BOOL;
      PRESSB4 : BOOL;
      PRESSB5 : BOOL;
      PRESSB6 : BOOL;
      PRESSB7 : BOOL;
      PRESSB8 : BOOL;
      PRESSB9 : BOOL;
      PRESSB10 : BOOL;
      PRESSB11 : BOOL;
      PRESSB12 : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_PG_BTNs  {HIDDEN} : STRUCT
      BTN : NH_TCIB_C_WS_0000R_PG_BTN;
      CLICK : NH_TCIB_C_WS_0000R_PG_CLICK;
      PRESS : NH_TCIB_C_WS_0000R_PG_PRESS;
   END_STRUCT;



   NH_TCIB_CWSTG2_AISTAT : STRUCT
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      OUFT : BOOL;
      VLDT : BOOL;
      OUFR : BOOL;
      VLDR : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_BTN : STRUCT
      BTN1 : BOOL;
      BTN2 : BOOL;
      BTN3 : BOOL;
      BTN4 : BOOL;
      BTN5 : BOOL;
      BTN6 : BOOL;
      BTN7 : BOOL;
      BTN8 : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_CLICK : STRUCT
      CLICKB1 : BOOL;
      CLICKB2 : BOOL;
      CLICKB3 : BOOL;
      CLICKB4 : BOOL;
      CLICKB5 : BOOL;
      CLICKB6 : BOOL;
      CLICKB7 : BOOL;
      CLICKB8 : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_PRESS : STRUCT
      PRESSB1 : BOOL;
      PRESSB2 : BOOL;
      PRESSB3 : BOOL;
      PRESSB4 : BOOL;
      PRESSB5 : BOOL;
      PRESSB6 : BOOL;
      PRESSB7 : BOOL;
      PRESSB8 : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_BTNs : STRUCT
      BTN : NH_TCIB_C_WS_0000R_TG2_BTN;
      CLICK : NH_TCIB_C_WS_0000R_TG2_CLICK;
      PRESS : NH_TCIB_C_WS_0000R_TG2_PRESS;
   END_STRUCT;

   NH_TCIB_CWSTG2_STAT : STRUCT
      dummy0 {HIDDEN} : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      PR : BOOL;
      ERR : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_GLASSI : STRUCT
      BTNs : NH_TCIB_C_WS_0000R_TG2_BTNs;
      VALUE : INT;
      STAT : NH_TCIB_CWSTG2_STAT;
      IDENT {HIDDEN} : BYTE;
   END_STRUCT;

   NH_TCIB_BTN_DI2  {HIDDEN} : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      CLICK1 : BOOL;
      CLICK2 : BOOL;
      PRESS1 : BOOL;
      PRESS2 : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;


   NH_TCIB_C_WS_0000R_TG2_IN : STRUCT
      DI : NH_TCIB_BTN_DI2;
      AI_STAT : NH_TCIB_CWSTG2_AISTAT;
      AI1 : REAL;
      AI2 : REAL;
      GLASS : NH_TCIB_C_WS_0000R_TG2_GLASSI;
      THERM : REAL;
      RH : REAL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_CONT : STRUCT
      DBA : BOOL;
      DOT1A : BOOL;
      DOT2A : BOOL;
      DOTHA : BOOL;
      DBB : BOOL;
      DOT1B : BOOL;
      DOT2B : BOOL;
      DOTHB : BOOL;
      DO1 : BOOL;
      AKTOR : BOOL;
      AKTOREN : BOOL;
      CAL : BOOL;
      ID1 : BOOL;
      ID2 : BOOL;
      CLEAR : BOOL;
      WR : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_LED : STRUCT
      BLUE1 : BOOL;
      BLUE2 : BOOL;
      BLUE3 : BOOL;
      BLUE4 : BOOL;
      BLUE5 : BOOL;
      BLUE6 : BOOL;
      BLUE7 : BOOL;
      BLUE8 : BOOL;
      RED1 : BOOL;
      RED2 : BOOL;
      RED3 : BOOL;
      RED4 : BOOL;
      RED5 : BOOL;
      RED6 : BOOL;
      RED7 : BOOL;
      RED8 : BOOL;
      GREEN1 : BOOL;
      GREEN2 : BOOL;
      GREEN3 : BOOL;
      GREEN4 : BOOL;
      GREEN5 : BOOL;
      GREEN6 : BOOL;
      GREEN7 : BOOL;
      GREEN8 : BOOL;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_GLASSO : STRUCT
      CONT : NH_TCIB_C_WS_0000R_TG2_CONT;
      LED : NH_TCIB_C_WS_0000R_TG2_LED;
      DISPA : INT;
      DISPB : INT;
      ZONE : USINT;
      ICONS : USINT;
      DLIGHT : USINT;
      BLIGHT : USINT;
   END_STRUCT;

   NH_TCIB_C_WS_0000R_TG2_OUT : STRUCT
      GLASS : NH_TCIB_C_WS_0000R_TG2_GLASSO;
   END_STRUCT;
END_TYPE


VAR_GLOBAL
 	xBtnS			{HIDDEN}	  : PTR_TO NH_TCIB_C_WS_0000R_PG_BTNs;
 	xGlas			{HIDDEN}	  : PTR_TO NH_TCIB_C_WS_0000R_PG_GLASSO;
 	xBtnS2		{HIDDEN}	  : PTR_TO NH_TCIB_C_WS_0000R_TG2_GLASSI;
 	xGlas2		{HIDDEN}	  : PTR_TO NH_TCIB_C_WS_0000R_TG2_GLASSO;

  	xTvTecoIn   {HIDDEN}		: PTR_TO NH_TCIB_VCHC_STAT;
   xTvTecoOu 	{HIDDEN}  	: PTR_TO NH_TCIB_VCHC_CONT;
  	pTvIn       {HIDDEN} 	: ARRAY[1..10] OF NH_TCIB_VCHC_STAT;
  	pTvOu       {HIDDEN} 	: ARRAY[1..10] OF NH_TCIB_VCHC_CONT;


	xWg503In    {HIDDEN}		: PTR_TO NH_TCIB_C_WG_0503S_IN;
   xWg503Ou    {HIDDEN}		: PTR_TO NH_TCIB_C_WG_0503S_OUT;
   xKy001In    {HIDDEN}		: PTR_TO NH_TCIB_C_KY_0001R_IN;
   xKy001Ou    {HIDDEN}		: PTR_TO NH_TCIB_C_KY_0001R_OUT;
END_VAR

VAR_GLOBAL CONSTANT
	_eBtnS		{HIDDEN}		: NH_TCIB_C_WS_0000R_PG_BTNs;
	_eBtnS2		{HIDDEN}		: NH_TCIB_C_WS_0000R_TG2_BTNs;
   _eLedTGL    {HIDDEN}    : NH_TCIB_C_WS_0000R_PG_LED;
END_VAR


TYPE
	NH_CFX_ALL {HIDDEN} 	 :  STRUCT 		            // spolocna CFG pre analogove DEV
      tMaxON      : UINT   := 360;                 // maximalny cas zapnutia [min]. (NE-moze resetovat PIR) defalt 360min = 6h
      Pwr         : REAL   := 14.0;                // prikon
		LastLvl		: USINT;									// posledny LVL ( nie pre obnovenie LVL po restarte koli obnoveniu LVL po blikani, atd)
		LastCMD		: USINT;									// posledne CMD, ktore prislo/odislo - podla dalsieho parametra
//		LvlOnRst		: BOOL := true ;	 					// po restarte obnovit poslednu LVL
		Dummy1		: BOOL;	 								// po restarte obnovit poslednu LVL
		Dummy2		: BOOL;	 								// po restarte obnovit poslednu LVL
//		LastCMDin	: BOOL;									// posledne ulozene CMD je In
		LastWsb		: BOOL;									// posledne ulozeny prikaz prisiel z WSB
		Dummy4		: BOOL;	 								// po restarte obnovit poslednu LVL
		LastScnOn 	: BOOL;									// scena bola zapnuta
	END_STRUCT;

   NH_CFX_SVA	 {HIDDEN}	 :  STRUCT 		       	// spolocna CFG pre analogove DEV
		Lv0			: USINT	:= 1;
		Lv1			: USINT	:= 100;
	END_STRUCT;
   NH_CFX_DIM {HIDDEN}	 :  STRUCT 		       		// spolocna CFG pre analogove DEV
      tOnL        : USINT  := 0; //25;             // cas nabehu do minima [100mS]
      DimHW       : BOOL   := 1;                   // ma sa hardwarovo stmievanat (ak ma adrresu)
		dummy1		: BOOL;
		dummy2		: BOOL;
		dummy3		: BOOL;
	END_STRUCT;
   NH_CFX_DALI  {HIDDEN} : STRUCT
      Present     : BOOL;                          // priznak,ze bol RANDOM/check....
      Err         : BOOL;                          // celkovy pocet err
      ErrID       : USINT;                         // posledny Err
   END_STRUCT;
   NH_CFX_DLM  {HIDDEN} : STRUCT
//      Present     : BOOL;                          // priznak,ze bol RANDOM/check....
//      Clear       : BOOL;                          // RND vymazal vsetky adresy
//      Random      : BOOL;                          // vykonane hladanie novych adries
      nSha        : USINT;                         // pocet pritomnych Short-addres (balastov)
      nScn        : USINT;                         // pocet priradenych skupin
   END_STRUCT;






   NH_DLM_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL ;
      sta         : NH_CFX_DALI;
      dlm         : NH_CFX_DLM;
	END_STRUCT;
   NH_DLS_GRP  {HIDDEN} : STRUCT
//    grp         : ARRAY[0..15] OF BOOL;
//		lvl         : ARRAY[0..15] OF USINT;
		grp			: NH_Btn15;
		lvl			: NH_LVL15;
   END_STRUCT;
   NH_DLM_GRP  {HIDDEN} : STRUCT
		set			: NH_Btn15;								// scena sa sama nastavila
		dev			: NH_Btn15;								// aspon 1.DEV v scene je zapnute, inak treba SCN vypnut
		lvl			: NH_LVL15;                      // na aku LVL {254 = vsetky ballasty podla sceny}
		rmp			: NH_LVL15;              			// aka Rampa sa poslala do kazdeho ballasty
   END_STRUCT;


   NH_DLS_CFG {HIDDEN}  : STRUCT
		out5inOne	: BOOL;									// toto je 1 SHA adresa a 5 vystupov {RGBWA}
		dummy			: BOOL;
		dummy2		: BOOL;
		dummy3		: BOOL;
		dummy4		: BOOL;
		dummy5		: BOOL;
		dummy6		: BOOL;
		dummy7		: BOOL;
		dummyA		: UDINT;
   END_STRUCT;
   NH_DLS_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL;
      sta         : NH_CFX_DALI;
      scn         : NH_DLS_GRP;
		cfg			: NH_DLS_CFG;
	END_STRUCT;
   NH_DLG_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL;
      sta         : NH_CFX_DALI;
	END_STRUCT;

   NH_DLM_RND  {HIDDEN} : STRUCT
      Present     : BOOL;                          // priznak,ze bol RANDOM/check....
      Clear       : BOOL;                          // RND vymazal vsetky adresy
      Random      : BOOL;                          // vykonane hladanie novych adries
   END_STRUCT;
   NH_DLM_ERR  {HIDDEN} : STRUCT
      nErrS       : ARRAY[1..4] OF USINT;
      nErrG       : ARRAY[1..4] OF USINT;
   END_STRUCT;
   NH_DLM_ME  {HIDDEN} : STRUCT
      rnd         : NH_DLM_RND;
      err         : NH_DLM_ERR;
		scn         : NH_DLM_GRP;
//      ScnNbr      : USINT;                         // HW nastavil, cislo sceny 0..15, ktora sa prave zmenila
//		ScnLvl		: USINT;                         // LVL pre cislo sceny v ScnGrp
//		ScnSet		: BOOL;                          // priznak, ze niektora scena bola v tomto kole nastavena
		Rmp255		: USINT;
      Lvl255      : BOOL;                          // globalna zmena LVL pre vsetky SLAVE, nastavuje DALI-HW

//		ScnOn			: BOOl;
   END_STRUCT;

   NH_DLS_ME  {HIDDEN} : STRUCT
		SendDLM		: BOOL;									// priznak, ze uz to bolo aspon raz poslane do DALI mastra
      rmp         : USINT;
   END_STRUCT;

   NH_DLM  {HIDDEN} : STRUCT
      ok          : NH_REC_OK;
      cf          : NH_CFG_ALL := (LvlOnRst:=false) ;
      al          : NH_DEV_ALL;
      cx          : NH_DLM_CX ;
      hw          : NH_DEV_HW1;
		me				: NH_DLM_ME;
   END_STRUCT;
   NH_DLS  {HIDDEN} : STRUCT
      ok          : NH_REC_OK;
      cf          : NH_CFG_ALL;
      al          : NH_DEV_ALL;
      cx          : NH_DLS_CX;  // := (all:=(LvlOnRst:=false)) ;
      me          : NH_DLS_ME;
   END_STRUCT;
   NH_DLG  {HIDDEN} : STRUCT
      ok          : NH_REC_OK;
      cf          : NH_CFG_ALL  := (LvlOnRst:=false) ;
      al          : NH_DEV_ALL;
      cx          : NH_DLG_CX;
      me          : NH_DLS_ME;
   END_STRUCT;



   NH_IDX_ROW {HIDDEN} :  STRUCT 					// index pre vsetky weby
      in          : BOOL;                 // kde ktore DEV sa zoberie z vazby
      vaz         : BOOl;                 // priznak , ze dev.c je druh vazby aVaz[dev.c] a dev.n je cislo zanzmamu vo vazb
      chk         : BOOL;                 // ci je zaskrtnuta vazba
      fav         : BOOL;                 // je FAV v aktualne vybratej kategorri FAV
      nd          : INT;                  // cislo vety - vacsinou v xVaz[2]
      dev         : NH_DEV_IO;
   END_STRUCT;

   NH_IDX {HIDDEN} :  STRUCT 					// index pre vsetky weby
      ix          : ARRAY[1.._Nh_WEB_M] OF NH_IDX_ROW;
   END_STRUCT;




//	{ $IFNDEF __NH_METEO_IQWS_4000 }
   {$IFNDEF T_METEO_IQWS_4000}                            // TVE TECO

	  	T_METEO_IQWS_4000 		{HIDDEN} 		:  STRUCT 		
	    windspeed        : real;  (*Okamžitá rychlost vìtru               [m/s]*)
   	 winddir          : real;  (*Smìr proudìní vìtru                   [0-15]*)
	    wdird            : real;  (*Smìr proudìní vìtru ve stupních       [deg]*)
   	 windgust         : real;  (*Maximální rychlost vìtru              [m/s]*)
	    pressure         : real;  (*Absolutní tlak                        [hPa]*)
   	 systemp          : real;  (*Vnitøní teplota meteostanice - systém [°C]*)
	    temperature      : real;  (*Teplota                               [°C]*)
   	 baraltitude      : real;  (*Barometická nadmoøská výška           [m]*)
	    windchill        : real;  (*Pocitová teplota                      [°C]*)
   	 relhumidity      : real;  (*Relativní vlhkost                     [%]*)
	    abshumidity      : real;  (*Absolutní vlhkost                     [g/m3]*)
   	 dewpoint         : real;  (*Rosný bod                             [°C]*)
	    spower           : real;  (*Intenzita sluneèního záøení           [W/m2]*)
   	 uf               : real;  (*UV faktor*)
	    stime            : dt;  	(*èas bouøky                            [UTC]*)
   	 sdist            : real;  (*Vzdálenost bouøky                     [km]*)
	    senr             : real;  (*Bouøková energie*)
   	 lpd              : udint; (*Poèet bleskù za den*)
		END_STRUCT
	{ $END_IF}

  NH_METEO_IDX	{HIDDEN} 		:  STRUCT 		
		v1			: REAL;				// Min /Avg	
		v2			: REAL;           // Max
		val		: REAL;         	// hodnota
		fmt		: STRING[5] := '%4.1f';			// naformatovana hodnota
	END_STRUCT;



  NH_METEO	 {HIDDEN}  		:  STRUCT 		
 		ok          			: NH_REC_OK := (ok:=1);										// aby mal kde zapisovat slider
		station					: T_METEO_IQWS_4000; 															// data from weather station
		idx						:  ARRAY[0..7] 	OF NH_METEO_IDX := [
											( fmt := '%4.1f'),					// vietor
											( fmt := '%4.0f', v1:=1000),     // tlak
											( fmt := '%5.1f', v1:=40),       // teplota
											( fmt := '%5.1f', v1:=40),       // pocit.t
											( fmt := '%4.1f', v1:=100),      // rel.vlhkost
											( fmt := '%4.1f', v1:=100),  		// abs.vhk winchild
											( fmt := '%4.1f', v1:=100),      // sl.ziarenie
											( fmt := '%4.0f')	];             // burka = km
                                               	
		rr							: REAL;		

		WindSpeedMan			: REAL;		         // manualne zadana rychlost
		WindDirMan360			: UINT;		         // orientacia, prebrata z station
		spowerMan				: REAL;		         // manualne zadana spower
   	SunriseTime          : TIME;              // cas vychodu slunce
	   SunsetTime           : TIME;              // cas zapadu slunce
		windSpeed_F				: _Nh_FILTER_1R;
		sPower_F					: _Nh_FILTER_1R;
//		WindDelayRol			: _Nh_TONOF;         // oneskorenie narazov vetra pre WindSpeedBli
		WindSpeedRol			: USINT;					// upravena hodnota vetra pre zaluzie											// vystup pre zaluzie - v urcenej dobe sa napocitava



		ownData					: 	BOOL;						// mame vlastu meteostanicu	
		err						:	BOOL;						// nekomunikuje s
		NewData  				:  BOOL;
//		Manual					: 	BOOL;						// manualne ovladanie
		
	END_STRUCT;

   NH_METEO_CFG	{HIDDEN} 		:  STRUCT 		
		typ						: USINT;
		temp						: ARRAY[0..2]		OF REAL	:= [1.0,10.0,35.0]; 		// [min,normal,max]
		wind						: ARRAY[0..2]		OF REAL	:= [4.0,9.0,15.0];			// [ok,high,critikal]
		FilWindSpeed			: UINT	:= 254;												// filter 1.radu pre Wind opozdenie	
		FilsPower				: UINT	:= 100;												// filter 1.radu pre sl.ziarenie
		sPower100				: UINT 	:= 1000;												// kolko je hranica 100% osvetlenia	
		KoefTo100				: REAL 	:= 10.0;	//1.267;	//126.7;
		SendToBlind				: BOOL 	:= 1;													// posielat pre rolety
		Manual				: BOOL;
		xx							: string[10];		
	END_STRUCT;


	NH_RGB_COLOR {HIDDEN} :  STRUCT 															// struktura RGB svetla
		R				: USINT 	:= 255;
		G				: USINT	:= 255;
		B				: USINT	:= 255;
//		A				: USINT	:= ;          // pouziva sa na ukladanie levelu, nie na opacity
	END_STRUCT;

  	NH_RGB_MEM {HIDDEN} :  STRUCT 			// riadiaca hlavicka DBX
		pvc			: ARRAY[1..9] OF NH_RGB_COLOR  := [
										( R := 255,	 G := 255,  B := 255),
										( R := 255,  G := 0,    B := 255),
										( R := 255,  G := 255,  B := 0  ),
										( R := 255,  G := 128,  B := 0  ),
										( R := 0,    G := 191,  B := 255),
										( R := 0,  	 G := 255,  B := 255),
										( R := 245,  G := 145,  B := 245),
										( R := 255,  G := 128,  B := 0  ),
										( R := 255,  G := 255,  B := 255)];

		lvl			: ARRAY[1..9] OF USINT  := [255,255,255,255,255,255,255,255,255];

	END_STRUCT;


  	NH_EXT_ALARM {HIDDEN} :  STRUCT 			// riadiaca hlavicka DBX
      ExtAlarm    : USINT := 1;                    // 0=defaul, 1=paradox
      ExtPass     : STRING[6] := '1234';
		xx				: STRING[10];
	END_STRUCT;


    NH_GLB_CX {HIDDEN}	 :  STRUCT
		Subj			: BOOL;
		latitude 	: LREAL := 48.92935;    // sirka
		longitude   : LREAL := 21.91247;		// dlzka		
		TimeZone		: SINT  := 1;
		DefLanguage	: USINT := 0;				// default jazyk
		dummy			: STRING[10];
 		meteo       : NH_METEO_CFG;
		extAlarm		: NH_EXT_ALARM;
//      rgb         : NH_RGB_MEM;
	END_STRUCT;


   NH_GLB {HIDDEN} 	 :  STRUCT           // casovy program kurenia jedneho dna 		
 		ok          : NH_REC_OK := (ok:=1);
      cx          : NH_GLB_CX;
	END_STRUCT;
END_TYPE


// *** TECO SERVO-VENTIL ANALOGOVY CIB ***






TYPE
  	NH_DEV_ALL_CLI  {HIDDEN}  :  STRUCT            			// TG / TLA,WSB
		in				: NH_CMD_ALL;  					// vstupny prikaz
		ou				: NH_CMD_ALL;  					// vystupy prikaz
      sta         : USINT;                      // stav, podla ktoreho za vykresli obrazok s podkladom
		cm				: USINT;
   	et				: UINT;
      Qf          : BOOL;                       // impulz, ked skoncil cas : et
	   trg         : NH_TRIG;
      wsb         : BOOL;                       // priznak, ze cmd prisiel z ovladaca WSB alebo WEB
      vaz         : BOOL;                       // ma nejake in-vazby WSB,PIR,TGL...
      lst         : BOOL;                       // je nejakom DEV-liste SCN,ACT,....
      up          : BOOL := true;               // smer stmievania up=hore (po restarte zacina nadol)
		cli			: _Nh_Click_FB;
		DEV			: NH_BTN8;							// ktore BTN su pouzite vo vazbe	na nejake DEV
  		HET			: NH_BTN8;							// ktore BTN maju vazbu k HET/VEN... regulatorom
  		PRG			: NH_BTN8;							// na ktorych btn bezi program a maju blikat
	END_STRUCT;
END_TYPE


TYPE
   NH_DAY_LVL	{HIDDEN} :  STRUCT 		
      lvl   :  ARRAY[0..5] OF USINT   := [0,0,0,0,0];    // 0=DAY / 1=EVNING / 2=NIGHT / 3=MORNING / 4=LOCK .....
	END_STRUCT;

   NH_DAY_CFG	{HIDDEN} :  STRUCT 		
      n     :  ARRAY[0..7] OF BOOL   := [0,1,1,1,0];    // 0=DAY / 1=EVNING / 2=NIGHT / 3=MORNING / 4=LOCK .....
	END_STRUCT;

  	NH_ARR_REA {HIDDEN} :  STRUCT 					        // status celej kategorie
 		v         : ARRAY[0..7] OF REAL;
	END_STRUCT;
  	NH_ARR_INT {HIDDEN} :  STRUCT 					        // status celej kategorie
 		v         : ARRAY[0..7] OF INT;
	END_STRUCT;
  	NH_OBJ_FMT_23   :  STRUCT 					// mapovanie xO^.fmt pre univerzalne pouzitie
      wht          : USINT;
      txt          : INT;
      obj          : USINT;
	END_STRUCT;

   NH_DEF_OBR  {HIDDEN} :  STRUCT          // STAVOVY dash S OBRAZKOM/TEXTOM/HODNOTOU
      wht         : USINT;                      // predvolba pre kreslenie stavu
//      wht         : INT;                      // predvolba pre kreslenie stavu
      val         : INT;                        // cislo obrazka, parameter hodnoty .... atd
	END_STRUCT;
  	
END_TYPE

TYPE

  	NH_OUT_ALL  {HIDDEN} :  STRUCT 			// par SVD,SVA,ZAS,SIRnajuniverzalnejsie parametre svetla
      rPir      	: BOOL  := true;        // pritomnost resetuje cas zapnutia
      BlPirOff    : BOOL  := true;        // blokovat PIR v ROM PO VYPNUTI - vacsina dev mimo napr ZAS,SIR...
      BlPirON     : BOOL  := true;        // blokovat PIR v ROM po zapnuti - u niektorych napr ZAS,SIR,... to nebude
      dummy       : BOOL  := true;        // blokovanie od tejto akcie je pre celu miestnost/len pre toto DEV
      tOff        : UINT  := 0;           // po case [s] vypnut pri PIR, pri WSB/WEB max. cas zapnutia
      tDelay      : UINT  := 0;           // Opozdene vykonanie
      lvl         : USINT := 100;         // nastavena LVL
   END_STRUCT;









  	NH_SMW {HIDDEN} :  STRUCT 					// smart WAY
 		ok          : NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL;
	END_STRUCT;
  	NH_ACT {HIDDEN} :  STRUCT 					// Scn,Act
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL;
//      cx          : NH_CFX_SCN;
	END_STRUCT;


  	NH_TIM_MEM {HIDDEN} :  STRUCT 					// Scn,Act
		typOld	: SINT;
		rnd	: USINT; 	
		hour	: USINT;
		min	: USINT;	
		sec	: USINT;
		tim	: TIME;	
	END_STRUCT;

  	NH_TIM_CFX_RND {HIDDEN} :  STRUCT 					
		// pre RND - simulacie
		etRND					: USINT;
		IntGenRND			: USINT:=60;			// interval generovania nahodneho cisla [S]
		TimeOnMin			: UINT :=5;				// min.cas zapnutia - po nom sa spusti generovanie OFF			
		TimeOnMax			: UINT :=30;         // max.cas zapnutia - ak sa dosiahne a je zapnute, vypne sa a nastavi sa min.cas OFF
		TimeOffMin			: UINT :=60;	  	   // min.cas vypnutia - po nom sa spusti generovanie ON
		TimeOffMax			: UINT :=150;			// max.cas vypnutia - ak sa dosiahne posle sa ON a nastvai sa min.cas ON
		// RND + ostatne
		LockDark				: NH_BTN4	:= [1,1,1,1];           // Unlock/Lock/Light/Dark
		PartOfDay			: NH_BTN4  	:=	[1,1,1,1];           // ktore casti dna day/evening/night/morning
		DayOfWeek			: NH_BTN15 	:= [0,1,1,1,1,1,1,1,1,1,0]; 	// ktore dni v tyzdni + sviatok. 0=volne, 1..7 PO-NE, 8 sviatok, 9=party
	END_STRUCT;

  	NH_TIM_CFX {HIDDEN} :  STRUCT 					
		RND					: NH_TIM_CFX_RND;
		WhatOut				: USINT;					// 0=ON,1=OFF,3=ON+OFF
		TimeFrom				: NH_DT_M;				// platnost Od: RR.MM.DD  a zadovn cas zaciatku HH:MM
		TimeTo				: NH_DT_M;      		// platnost Do: RR.MM.DD  a zadovn cas konca HH:MM
		TimeEnd				: NH_DT_M;           // casova znacka

	END_STRUCT;

  	NH_TIM {HIDDEN} :  STRUCT 					// Scn,Act
 		ok				: NH_REC_OK := (ok:=1);
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_M;
      cx          : NH_TIM_CFX;
      me          : NH_TIM_MEM;
	END_STRUCT;

   NH_PIR_CFX	{HIDDEN} :  STRUCT 		
      funLock     : USINT := 0;              // pre Odmknute filtrovanie poctom cyklov / 100msec
      fLock     	: USINT := 5;              // pre Zamknute filtrovanie poctom cyklov / 100msec
      tOffRst    	: UINT  := 3;              // po tomto case neposielat signal a skusit autoreset
      tam1        : BOOL;                    // tamper - vyvazenie
      tam2        : BOOL;                    // dvojite vyvazenie
		dummy			: BOOL;							
	END_STRUCT;
(*
   NH_PIR_MEM	{HIDDEN} :  STRUCT 		
		Dark			: bool;                    // pomocne premenne, naplnaju sa z xRom^.me.Dark - aby sa vo vazbach nemusela mapovat Rom
		Day         : SINT;
	END_STRUCT;
*)
   NH_PIR		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL := (inv := 1, psn:=1);
		al				: NH_DEV_ALL;                     // spolocne pre vsetky DEV  cf+io
      cx          : NH_PIR_CFX;
		hw				: NH_DEV_HW1;
//      me          : NH_PIR_MEM;                     // pomozna pamat
	END_STRUCT;
   NH_PIR_PAR	{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK ;
      Day         : NH_DAY_CFG := (n:=[1,1,1,1,0,1]); // v ktorm mode ma zapinat PIR Day/Evening/Night/Morning / Twilight;
	END_STRUCT;


   NH_CFX_TER	{HIDDEN} :  STRUCT 		
      fil         : USINT := 10;                   // konstatnta filtrovania vstupu 1. radu
      hys       	: REAL := 0.1;                   // povolena odchylka +- od poslednej hodnoty
      kor        	: REAL ;                         // korekcia vstupnej hodnoty
		BlkDefRom	: BOOL; 									// neposielat do default rom
//		BlkLuxRom	: BOOL; 									// Blokovat posielanie hodnoty ak v default miestnosti je zapalene svetlo
		sample		: UINT := 30;
   END_STRUCT;

   NH_TER_MEM	{HIDDEN} :  STRUCT 		
		man			: BOOL;									// priznak manualu - po restarte sa resetne
		f1r			: _Nh_FILTER_1R;
		nQr			: UINT;
		nBl			: UINT;
		nRom			: UINT;
//      delay      : _Nh_R_Delay;
   END_STRUCT;

   NH_TER		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL;                     // spolocne pre vsetky DEV  cf+io
      cx          : NH_CFX_TER := (fil := 250, hys := 0.1);
		hw				: NH_DEV_HW0;                     // zakladna adresa HW
		me				: NH_TER_MEM;
	END_STRUCT;

   NH_DOR		{HIDDEN} :  STRUCT       // dor,win,co2 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL := (psn:=1);
		al				: NH_DEV_ALL_M;
		cx				: NH_PIR_CFX;
		hw				: NH_DEV_HW0;                     // zakladna adresa HW
	END_STRUCT;

   NH_CFX_LUX	{HIDDEN} :  STRUCT 		
      fil         : USINT := 10;                    // konstatnta filtrovania vstupu 1. radu
      hys        	: REAL := 1.0;                   // povolena odchylna +- (ak je zmena vacsia, aktualizuje sa vystup)
      Dark        : REAL := -41.0;                 // spodna hranica = tma
      Sun         : REAL := 125.0;                 // vrchna hranica = svetlo
      koef        : REAL := 1.0;                   // koeficient prevodu na LUX (pri snimani REAL veliciny)
		BlkDefRom	: BOOL; 									// neposielat do default rom
		BlkLuxRom	: BOOL; 									// Blokovat posielanie hodnoty ak v default miestnosti je zapalene svetlo
		sample		: UINT := 1;
   END_STRUCT;
   NH_LUX_MEM	{HIDDEN} :  STRUCT 		
		man			: BOOL;									// priznak manualu - po restarte sa resetne
		f1r			: _Nh_FILTER_1R;
      lux         : REAL;                          // hodnota v luxoch
		nQr			: UINT;
		nRomQr		: USINT;
		nRomQf		: USINT;		
		nf1RQr		: USINT;
		nRefCyc		: USINT;
	END_STRUCT;
   NH_LUX		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL;                  // spolocne pre vsetky DEV  cf+io
      cx          : NH_CFX_LUX := (fil := 100); //, dark := 0.0, Sun := 50000.0);
		hw				: NH_DEV_HW0;                     // zakladna adresa HW
      me          : NH_LUX_MEM;
	END_STRUCT;

   NH_KEY_CFX	{HIDDEN} :  STRUCT 		
      tWait       : USINT := 2;                // zakaznie na dalsiu klavesu
      tBeepE      : USINT := 1;                // cas ms pre ERR
      tBeepOk     : USINT := 1;                // cas ms pre ERR
      tMax        : USINT := 60;               // max cas pipania min
      Beep        : BOOL  := true;
	END_STRUCT;
   NH_KEY_MEM	{HIDDEN} :  STRUCT 		
		keyPas      : STRING[6];
		beep			: _Nh_Blik_FB;
		code			: NH_TCIB_CWG0503S_CODE;
		ChgTx1		: BOOL;
		ChgTx2		: BOOL;
		Q				: BOOL;							// podrzanie
		Qf				: BOOL;							// potvrdenie zadaneho znaku, alebo podrzanie
//		Qpir			: BOOL;							// bol vytvoreny zoznam miestnosti, kde bol pohyb
//		Change		: BOOL;							// hociaka zmena

	END_STRUCT;

  	NH_KEY  {HIDDEN} :  STRUCT 					// klavesnica + RFID
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_M;
      cx          : NH_KEY_CFX;
		hw				: NH_DEV_HW2;
      me          : NH_KEY_MEM;
	END_STRUCT;



   NH_RFI_CX		{HIDDEN} :  STRUCT 		
      blk            : BOOL;                    // zablokovany snimac
      bpYes          : BOOL;                    // pipat pri OK
      bpNo           : BOOL;                    // pipat pri chybe
      LedG           : BOOL;                    //
      LedR           : BOOL;                    //
      Beep           : BOOL;                    //
      et0            : UINT := 2000;            // cas medzi bliknutiami pri STAN-BY
	END_STRUCT;

   NH_RFI		{HIDDEN} :  STRUCT 		
 		ok				 : NH_REC_OK;
      cf           : NH_CFG_ALL;
      al           : NH_DEV_ALL := ( et := 1);
      cx           : NH_RFI_CX;
      hw           : NH_DEV_HW1;
	END_STRUCT;

   NH_RFK_CX		{HIDDEN} :  STRUCT 		
      blk            : BOOL;                    // zablokovana karta
      admin          : BOOL;                    // administrato = ovlada vsetko
      lost           : BOOL;                    // stratena karta
      code           : NH_RFID;                 // kod karty
	END_STRUCT;

   NH_RFK		{HIDDEN} :  STRUCT 		
 		ok				 : NH_REC_OK;
      cf           : NH_CFG_ALL;
      cx           : NH_RFK_CX;
	END_STRUCT;


   NH_BLK_CFX	 {HIDDEN}		  :  STRUCT       // blikac
      // 1.obrazovka
      nBlk		   : USINT := 3;                    // 0 pocet blikov
      LUp         : USINT := 100;                  // 4 uroven pri zopnuti
      LDn         : USINT := 0;                    // 5 uroven pri vypnuti
      rmp         : USINT;                         // 6 rampa

      tUp         : UINT := 10;                  	// 1 cas zopnutia
      tDn         : UINT := 10;                  	// 2 cas vypnutia
      Delay       : UINT := 0;                     // 7 odlozenie startu
      lOwn        : BOOL;                          // 3 Vlastna Uroven impulzu
      OffS        : BOOL;                          // 9 prvy je OFF (najskor vypne bez pocitania)
      OffE        : BOOL := true;                  // 9 Po ukonceni vypnut

      // 2.obrazovka
 		nSer		   : USINT := 1;                    // 0 pocet serii
      lSer        : USINT;                         // 1 LVL v ktorej bude DEV pocas cakania do dalsej serie
      tSer        : UINT := 60;                    // 2 cas do dalsej serie
      tMax        : UINT := 0;                     // 3 max cas fungovania
      
   END_STRUCT;

   NH_BLK_MEM		{HIDDEN} :  STRUCT       // blikac len priamo pre DEV-OUT
      cmd         : USINT;
      nBlk        : USINT;
      nSer        : USINT;
      sta         : USINT;
		tMax			: UINT;

//      run         : USINT;
	END_STRUCT;

   NH_BLK		{HIDDEN} :  STRUCT       // blikac len priamo pre DEV-OUT
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
//		al				: NH_DEV_ALL;                     // spolocne pre vsetky DEV  cf+io
		al				: NH_DEV_ALL_M;
      cx          : NH_BLK_CFX;
      me          : NH_BLK_MEM;
	END_STRUCT;


//****



(*
  	NH_OK {HIDDEN} :  STRUCT 					// categorie
 		ok          : NH_REC_OK ;
//      cf          : NH_CFG_CAT;                          // minimalna verzia cfg
	END_STRUCT;
*)

  	NH_WRK_ROM {HIDDEN} :  STRUCT 			// enimane veliciny pre ROM,ZON
      cat         : ARRAY[0.._Nh_CAT]	OF BOOL;          // status kategorie - nieco je zapnute
		chg			: BOOL;                      // centralny priznak niektorej veliciny, ktora vstupuje do ROM/HET
//		chgio			: ARRAY[100..105] OF BOOL;   // priznak zmeny konkretnej veliciny TER/LUX/..
		Body     	: BOOL;                      // pritomnost vonku+vnuti
		BodyIn		: BOOL;                      // pritomnost LEN vnutri
		BodyOu		: BOOL;                      // pritomnost LEN vonku
		psn			: BOOL;                      // pritomnost pre Alarm pri LOCK state
//      KeyCode     : BOOL;                      // prisiel dobry kod z Klavesnice
//      WebCode     : BOOL;                      // prislo z webu
		LckStat     : USINT;
		LckEt     	: UINT;
   END_STRUCT;






   NH_GAT_CX   {HIDDEN}	:  STRUCT       // BRA/GAR/ROL
      yGat      	: REAL;                             // % skutocna 		pozicia  0%=zatvorene     , 100%=vytiahnute
      pGat      	: REAL;                             // % pozadovana 	pozicia  0%=zatvorene     , 100%=vytiahnute
      cmd         : USINT;                            // 0=motor off,1=pohyb Up, 2=Pohyb Dn
      run         : USINT;                            // command, ktory sa prave vykonava
		what			: USINT;										// ktore dev je prave zapnute .hw.d[what]
      tImp        : USINT :=  8;                     	// cas impulzu pre  elektroniku [100ms] 5x100ms=0.8s
      tRev    		: USINT := 10;                     	// rfeverzny cas
   	tOpenClose	: ARRAY[1..2] OF UINT := [450,450]; // cas zatvorenia/otvrenia
      btn       	: BOOL := 1;                        // web/btn = pre brany = zatvorene, pre rolety prepnutie medzi BLI{0}/LAM{1}
		LastClose	: BOOL := 1;			               // posledny smer pohybu
      HwEndUse   	: BOOL := true;                     // pouzivat koncovy spinac
      HwEndOpen   : BOOL;                            	// Spinac zopnuty pri otvoreni = typ DVERE, ked su otvorene je signal
		RelayClose 	: BOOL;										// Open/close je samostatne rele
		MotIsReal	: ARRAY[0..2] OF BOOL; // :=[1];			// v adrese .hw[ x] je hodnota typu real, nasobi * 100 a tak sa posle do HW					
	END_STRUCT;

   NH_GAT_ME {HIDDEN}  	:  STRUCT       // BRA/GAR/ROL
		inkr				: REAL;										// o kolko % sa posunie za 1ms
		HwEnd				: NH_TRIG;									// Qf,Qr pre koncovy spinac
		RelayCloseOk 	: BOOL;	
		cOld			: USINT;
		rOld			: USINT;
		cNew			: USINT;
		rNew			: USINT;

//      eImp        : USINT ;                      		// bezi cas impulzu
	END_STRUCT;

   NH_GAT	 {HIDDEN}  :  STRUCT       // BRA/GAR/ROL
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_M;   //NH_DEV_ALL;                     // spolocne pre vsetky DEV  cf+io
      cx          : NH_GAT_CX;
		hw				: NH_DEV_HW2;
		io				: ARRAY[0..0] 	OF NH_VAL_IO;     	// DOR
		me				: NH_GAT_ME;
//		io				: ARRAY[100..100] OF NH_VAL_IO;
	END_STRUCT;


  	NH_OUT_GAT  {HIDDEN}  :  STRUCT 			// PARAMETRE MIESTNOSTI
 		ok				: NH_REC_OK;
//      stat        : BOOL;                           // univerzalne pouzitie
//		rPir			: BOOL := true;						// pritomnost resetuje 	
//      lvl        	: USINT :=100;                    // pozadovana pozicia  0=zatiahnute/zatvorene, 100=vytiahnute/otvorene
//		tDelay      : USINT ;                          // opozdenie ON/OFF
		tCloseUnl 	: USINT;									 // zatvorit po Odkodovani
		tCloseLck	: USINT;                          // zatvorit po zakodovani
	END_STRUCT;


  	NH_GAT_PAR  {HIDDEN}  :  STRUCT 			// PARAMETRE MIESTNOSTI
 		ok				: NH_REC_OK;
		all			: NH_OUT_ALL;
		gat			: NH_OUT_GAT;		
(*
      stat        : BOOL;                           // univerzalne pouzitie
		rPir			: BOOL := true;						// pritomnost resetuje 	
      lvl        	: USINT :=100;                    // pozadovana pozicia  0=zatiahnute/zatvorene, 100=vytiahnute/otvorene
		tDelay      : USINT ;                          // opozdenie ON/OFF
		tClose 		: USINT;									 // zatvorit po
		tCloseLck	: USINT;
*)
	END_STRUCT;



   NH_ROL_UPDN		{HIDDEN} 	 :  STRUCT       // ROLETY/MARKIZY
      Rol        : UINT := 6500; //9000;             // cas rolety [10ms]
      Lam	     : UINT := 1300; //1100 ;            // cas lamely [1ms]
      Mot        : USINT;                            // opozdenie motora po On/Off [10ms]
		chg		  : USINT;	                          // opozdenie motora po pri zmene smeru [10ms]
   END_STRUCT;

   NH_ROL_QUE	 {HIDDEN} 		 :  STRUCT       // co sa ma urobit po dokonceni aktualne CMD
		Yes		  : BOOL;	
      pRol       : USINT;
      pLam	     : USINT;
   END_STRUCT;

   NH_ROL_ANAL_DATA		{HIDDEN} 	 :  STRUCT

		mot			: USINT;	
		whL			: USINT;
		whB			: USINT;
		tRunL			: REAL;
		yLam			: REAL;
		uLam			: USINT;
		pLam			: USINT;


		tRunB			: REAL;
		yRol			: REAL;
		uRol			: USINT;
		pRol			: USINT;


		vrL			: REAL;
		vrB			: REAL;

		cmd			: USINT;

	END_STRUCT;
   NH_ROL_ANAL		{HIDDEN} 	 :  STRUCT
		i				: USINT;
		d				: ARRAY[0..30] OF NH_ROL_ANAL_DATA;
	END_STRUCT;

	NH_ROL_SLD {HIDDEN} 		 :  STRUCT       // struktura pre namapovanie slidera
		xRol			: USINT;
		xLam			: USINT;
	END_STRUCT;



  	NH_ROL_PVP {HIDDEN} :  STRUCT 			
		prg			: BOOL;															// aktivna denna automatika/program
   	sunRise		: BOOL := 1;													// vychod slnka
   	sunSet		: BOOL;															// zapad slnka
	   hwLam      	: ARRAY[0..3] OF USINT:= [ 40, 60, 76,  0];     	// fixne HW predvolby lamiel pri ovladani z WSB
      pvBli      	: ARRAY[0..3] OF USINT:= [  0,  0,  0,  0];     	// predvolby Rol pre rano-noc
      pvLam      	: ARRAY[0..3] OF USINT:= [  0, 30, 60,100];     	// predvolby Lam
	END_STRUCT;


   NH_ROL_CF	 {HIDDEN} 		 :  STRUCT       // ROLETY/MARKIZY
      tUp  		  			: NH_ROL_UPDN := (lam:=1200);         	// casy pre pohyb hore
      tDn      			: NH_ROL_UPDN := (lam:=1300);          // casy pre pohyb dolu
		PV						: NH_ROL_PVP;									// predvolby
		tPvHwLam       	: USINT 	:= 9;                         // cas prestavok medzi HW predvolbami Lamiel  9*100 = mS
		tDelayRev			: USINT 	:= 10;                        // reverzny cas ochrany motora
		tDelayEnd      	: USINT 	:= 2; 								// predlzit dojazd motora po dosiahnuti matematickej polohy
		LamAngle				: USINT 	:= 90;						  		// max uhol otvorenych lamiel
		DarkLam				: USINT 	:= 45;     							// Lvl lamiel, kedy sa nastavi sumrak
		DarkRol				: USINT 	:= 50 ;                      	// LVL rolety kedy sa nastavi Sumrak v miestnosti
		DarkRolLvl			: USINT 	:=100;     							// Podiel na zatieni v miestnosti
		WindWaitOn			: USINT 	:= 60;		   					// po akom case [min] pokial presiahne vietor hodnotu [s]
		WindWaitOFF			: USINT 	:= 60;                      	// ak prestane vietor, po kolkych minutach sa zatiahne tak ako bolo [min]
		WindSpeedOn			: USINT 	:= 9;									//	rychlost, pri ktorej sa aktivuje ochrana 	
		WindSpeedOFF		: USINT 	:= 4;									//	rychlost, pri ktorej sa aktivuje koniec ochrany
		WindGuardBlkTime	: UINT 	:= 120;								// Rucny zasah zablokuje automatiku na [min]
		WindDay        	: NH_DAY_CFG :=( n := [0,0,1,0,0]);    // ktore denne obdobiesa nevracia roleta spat
		WindGuardRol		: USINT 	:= 0;									// ochranna pozicia pri silnom vetre
		WindGuardLam		: USINT 	:= 0;                			// ochranna pozicia pri silnom vetre
		WindDirFrom			: UINT 	:= 0;									// reaguje len ked fuka vietor v urcitom uhle
		WindDirTo			: UINT 	:= 360;
		HighRolOnWall 		: REAL 	:= 1.0;                    	// vyska spodneho okraja rolety
		HeatRol				: USINT 	:= 0;									// uroven zaluzii pri kureni
		HeatLam				: USINT 	:= 0;
		CoolRol				: USINT 	:= 100;								// uroven zaluzii pri Chladeni
		CoolLam				: USINT 	:= 100;
		SunShadeDeepth		: REAL   := 1.5;                    	// vzdialenost slnecneho luca od steny do miestnosti
		SunShadeSetTime	: USINT  := 15;                     	// vykonat upravu lamiel podla slnka kazdych [min]
		SunShadeMinDark	: UINT   := 90;                     	// minimalna intenzita slnecneho jasu, ked funguje slnecna automatika
		IgnoreReqRol		: USINT  := 2;                      	// ignorovat zmenu ROL < ako
		IgnoreReqLam		: USINT  := 5;                      	// ignorovat zmenu LAMLamiel < ako
		WindGuardOn  		: BOOL := 1;                        	// je zapnuta ochana proti vetru
		WindDirOnly			: BOOL;                             	// len pri smere vetra
		SetDark				: BOOL := 1;                        	// ovplyvnuje sumrak v miestnosti
		AutoHeatOn			: BOOL;											// sucastou kurenia
		AutoCoolOn			: BOOL;                             	// sucastou chladenia
		AutoSunShade		: BOOL;                             	// automaticke udrziavanie luca slnka
		LamHWpulse			: BOOL := 0;                        	// pouziva sa sa teco JC-006, ktore ma hw[2] premennu PDx na generovanie pulzu x10 mS
      ForceUpDn         : BOOL;                                // pred pohybom sa nastavi nasilne krajna pozicia z opacneho smeru, aby sa presla cela cesta {u roliet s dialkovym-bez definovaneho stavu}
		dummy					: STRING[10];
   END_STRUCT;

	NH_ROL_CFX	  {HIDDEN}		 :  STRUCT       // ROLETY/MARKIZY
		cf						: NH_ROL_CF;		
      cmd         		: USINT;                            // command, ktory sa prave vykonava
      NextCmd       		: USINT;                            // command, ktory sa vykona po ukoncenie CMD
		NextPar				: INT;   									// ak sa ma nastavit podla parametra
	   MotStat     		: USINT;                           	// 0=vypnuty, 1=na zaciatku tohto cyklu sa zapol, >1 je zapnuty kontinualne
		tStart				: DT;                               // casova znacka, kedy zacal niektory z pohybov
		Up						: BOOL;                             // posledny/aktualny smer pohybu
      SetLam      		: BOOL;                             // slider zobrazuje natocenie Lamely, inak Up/Dn
		IniDefaul			: BOOL;                             // uz prebehla 1.iniciaizacia
		xGoDelayMot			: BOOL;                             // priznak na predlzenie dojazdu motora po dosiahnuti koncovej polohy
      pRol        		: USINT;                            // pozadovana hodnota prebrata z parametra, alebo 0 pri vypnuti
      pLam        		: USINT;                            // pozadovana hodnota prebrata z parametra, alebo 0 pri vypnuti
      uRol        		: USINT;                            // aktualna pozicia rolety 0%=zatiahnute,100%=vytiahnute
	   uLam        		: USINT;                            // aktualna pozicia Lamely 0%=zaklopene, 100%=otvorene
      yRol        		: REAL;                             // pozadovana hodnota prebrata z parametra, alebo 0 pri vypnuti
	   yLam        		: REAL;                             // aktualna pozicia Lamely 0%=zaklopene, 100%=otvorene
		DelayStart			: BOOl;										// bezi odlozeny start	
		etHandBlkWind		: UINT;										// cas do konca blokovania WindGuard uzivatelom
		cmdWind				: USINT;										// status WindGuard
		dWindG				: _Nh_TONOF;                        // opozdenie silneho vetra
	END_STRUCT;

	NH_ROL_MEM	 {HIDDEN} 		 :  STRUCT       // ROLETY/MARKIZY
		// ******  ladenie
		in							: NH_DEV_ALL_M;
		ou							: NH_DEV_ALL_M;                   	// spolocne pre vsetky DEV  cf+io
      cx       			   : NH_ROL_CFX;
		// ********
//		inNextPar				: INT;
//		ouNextPar				: INT;		
//		cmNextPar				: INT;		
//		cmd						: USINT;		

//		defPar					: INT;

		QrCmd						: USINT;										// posledny CMD, ktory prisiel z in
		QrCmdEnd					: USINT;                              // posledny par, ktory prisiel z in
		CMDs						: USINT;										// CMD pre slider											
		RtcStamp					: DT;
		que						: NH_ROL_QUE;
		dWindUp					: _Nh_TONF ;								// opozdenie pri silnom vetre
		dWindDn					: _Nh_TONF ;	                    	// opozdenie pri slabom vetree
		yLamOld					: REAL;
		yRolOld					: REAL;
		iLam						: REAL;										// o kolko % sa posunie za 1ms
		iRol						: REAL;										// o kolko % sa posunie za 1ms
		tRun						: REAL;
		tFromBegin				: REAL;
		tToBegin					: REAL;
		tCycle					: REAL;
		tRestLam					: REAL;
		tRestBli					: REAL;
		dDark						: _Nh_TONOF := (tOn:=15,tOf:=15);	// opozdenie sumraku
		cpy						: BOOL;
		UpChg						: BOOL;										// ci bola zmena smeru
   END_STRUCT;


   NH_ROL		{HIDDEN} 	 :  STRUCT
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
//		al				: NH_DEV_ALL;                   	// spolocne pre vsetky DEV  cf+io
		al				: NH_DEV_ALL_M;                   	// spolocne pre vsetky DEV  cf+io
      cx          : NH_ROL_CFX;
		hw				: NH_DEV_HW2;                    // Up/Dn/Lamely-pulse
		io				: ARRAY[0..0] 	OF NH_VAL_IO;     	// Externe DEV {DALI/MQTT..}
		me				: NH_ROL_MEM;
	END_STRUCT;
	
	NH_OUT_ROL 	{HIDDEN}  :  STRUCT 			// PARAMETRE MIESTNOSTI
//	   SetPozi   	: BOOL := 1;                    // aj z webu/wsb nastavit poziciu/opozdenie podla tohto parametra
//      Delay       : UINT ;                        // opozdenie ON/OFF
      pRol        : USINT :=100;                    // pozadovana pozicia  100=zatiahnute, 0=vytiahnute
      pLam        : USINT :=100;                    // pozadovane natocenie lamiel 100 = zaklopene
	END_STRUCT;

	NH_ROL_PAR 	{HIDDEN}  :  STRUCT 			// PARAMETRE MIESTNOSTI
 		ok				: NH_REC_OK;
   	all			: NH_OUT_ALL;
		rol			: NH_OUT_ROL;
	END_STRUCT;


   NH_DL_idx  {HIDDEN} : STRUCT
      sha         : USINT;
      wht         : USINT;                      // cislo parametra, ....
      lvl         : USINT;                      // hodnota parametra/vykonu...
   END_STRUCT
   NH_DL_CMD  {HIDDEN} : STRUCT
      cmd         : USINT;                      // aktualny prikaz
      sh1         : USINT;
      sh2         : USINT;
      par         : USINT;
      lvl         : USINT;
      io          : UDINT;
//		out			: USINT;
//		Yes			: BOOL;	
      Break       : BOOL;                       // poziadavka na korektne ukoncenie procesu
		web			: BOOL;                       // zapisuje do webovej struktury
		AllSha		: BOOL;								// vsetky adresy	- priznak pre vymazanie mastra	
		Read			: BOOL;								// citanie prikazom 		
      Block       : BOOL;                       // blokuje DLs, DLg, - ON/OFF
		LogAct		: BOOL;
		
//      Break       : BOOL;                       // je mozne breaknut
//      RunLVL      : BOOL;                       // bezi funkcia, ktora scanuje LVL
//      GoIdle      : BOOL;                       // Tento proces bol spusteny z Idel, ak sa preusi, bude sa opakovat cca po 10s
//      GoLog       : BOOL;                       // zapisat do Logu na SDC

      pwr         : NH_RGB_LVL := ( lvl := [0,0,0,0,0]);
   END_STRUCT

   NH_DL_BAL_HWA {HIDDEN} :    STRUCT
      hwAdrH            : usint; // 37
      hwAdrM            : usint; // 38
      hwAdrL            : usint; // 39
      DeviceType        : usint; // 31
      Version           : usint; // 29 ROM
   END_STRUCT;
   NH_DL_BAL_HWE {HIDDEN} :  STRUCT
      BallastState      : bool; // 23? 0‘=OK,  Ballast State
      LampFailure       : bool; // 24 0‘=OK,  Lamp Failure          - selhani lampy
      PowerFailure      : bool; // 33 0‘=No, Power Failure          - bol vypadok napajania
      LimitError        : bool; // 26 0‘=Off, Limit Error           - prekrocenie limitov
      ResetState        : bool; // 27 0‘=No, Reset State            - stav po resetu
      MissingShortAddr  : bool; // 28 0‘=No, Missing Short Address  - chyba kratka adresa
      LampPowerOn       : bool; // 25 0‘=Off, Lamp Power On         - Lampa zapnuta
      TerminateFading   : bool; // 0‘=Terminate Fading              - stmievanie ukoncene
   END_STRUCT;


   NH_DL_BAL_PAR  {HIDDEN} :  STRUCT 	// docasna struktura, pre nacitanie a zobrazenie HW parametrov - pri vstupr do DLS , DLg
      wh    : USINT := 0;
      par   : ARRAY[1..8] OF USINT;  	// 1.LVL 2.FADE.TIME 3.FADE_RATE 4.min LVL 3.HW min LVL 6.MAx LVL 7.LVL po rest. 8.LVL on Error				
   END_STRUCT;

   NH_DALI  {HIDDEN} :  STRUCT
		tmeCmd		: TIME;												// cas zaciatku aktualneho/posledneho CMD	
		cycCMD		: UINT;												// pocet cyklov az do cakania na Done
		et				: UINT;												// aktualny / posledny cas vykonavania cmd[1]	
		etMax			: UINT;			                           // max cas cakania na odpoved {Done}
		cmdEnd		: USINT;												// tento fb sa po Done este raz vykona, pre korektne ukoncenie, pripadne reset
		cmdQue		: USINT;												// aktualna fronta prikazov
//		cmdFree		: USINT;												// atualne volne CMD

      cmd   	   : ARRAY[1.._NhDLtask] OF NH_DL_CMD ;      // fronta prikazov	
		ct				: USINT;												// jednotka pre et {0=mSec, 1=sec}
      txt         : STRING[25];
		cmdFull		: BOOL;                                   // fronta prikazov je plna
		break			: BOOl;												// prikaz sa ukoncil breakom = prekroceny cas
//		etFull		: USINT;												// pocet cyklov pre reset CMD
//      Cmd         : ARRAY[1.._NhDLtask] OF NH_DL_CMD ;      // fronta prikazov

//      Run         : NH_DL_RUN;                              // pomocne Data z prave prebiehajucej alebo poslednej akcie
      Que         : fb_DL_Query;
//      trc         : fb_DL_Transceiver;                      // LVL
      lvl         : fb_Dl_Direct;
      Scn         : fb_DL_Scene;
      Par         : fb_DL_SetPar;
      gra         : fb_DL_Address;
      RND         : fb_DL_RNDAddr;
		RGBWA 		: fb_DL2_SetRBGWA;
		NewSha		: USINT;													// pocet novych adries / nova adresa
//		CmdNext		: USINT;
		BalNoSha		: BOOL;													// priznak, ze bol najdeny ballast bez SHA, a ide sa mu [priradovat
		FreeSha		: BOOL;													// hlada sa volne SHA pre presunutie pri precislovani
//      Go          : NH_DLM_GO;
//      Par255      : USINT;                         // globalna zmena parametra - cislo
//      wrk         : ARRAY[0..64] OF NH_DL_WRK;
   END_STRUCT;


(*
1      ActLevel          : usint;   // 34            // fyzicka aktualna LVL lampy
2      FadeTime          : usint    // 20
3      FadeRate          : usint    // 21
4      MinLevel          : usint    // 17
5      PhyMinLevel       : usint    // 32 ROM               // needituje sa
6      MaxLevel          : usint    // 16
7      PowONLevel        : usint;   // 19
8      FailLevel         : usint;   // 18
*)


(*
   NH_DL_BAL_CHG  {HIDDEN} :  STRUCT
      par               : ARRAY[2..8]  OF USINT;   // par[2]..
      scn               : NH_BTN15;
   END_STRUCT;

   NH_DL_BAL_SET  {HIDDEN} :  STRUCT
      lvl               : NH_DL_BAL_CHG;
      chg               : NH_DL_BAL_CHG;           // po restarte sa nastavi uroven aka bol naposledy
   END_STRUCT;

   NH_DL_DEV   {HIDDEN}  : STRUCT
      c        : USINT;
      n        : INT;
   END_STRUCT;
   NH_DL_RGB   {HIDDEN}  : STRUCT
      cf       : ARRAY[1..3] OF NH_DL_DEV;
   END_STRUCT;
*)
{ $IFDEF __NH_DALI }

{ $END_IF }




   NH_SVD_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL;
	END_STRUCT;
   NH_SVA_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL;
		sva			: NH_CFX_SVA;
		dim			: NH_CFX_DIM;
	END_STRUCT;
   NH_RGB_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL;
		sva			: NH_CFX_SVA;
	END_STRUCT;



















  	NH_OUT_SVA  {HIDDEN} :  STRUCT 			// par SVD,SVA,ZAS,SIRnajuniverzalnejsie parametre svetla
      rDn         : USINT := 1;
      rUp         : USINT := 1;
   END_STRUCT;
  	NH_SVD_PAR {HIDDEN} :  STRUCT 			// PARAMETRE MIESTNOSTI
 		ok				 : NH_REC_OK;
      all          : NH_OUT_ALL;
	END_STRUCT;
  	NH_SVA_PAR {HIDDEN} :  STRUCT 			
 		ok				 : NH_REC_OK;
      all          : NH_OUT_ALL;
      sva          : NH_OUT_SVA;
	END_STRUCT;
  	NH_RGB_PAR {HIDDEN} :  STRUCT 			// PARAMETRE RGB SVETLA
 		ok				 : NH_REC_OK;
      all          : NH_OUT_ALL;
      sva          : NH_OUT_SVA;
      rgb          : NH_RGB_LVL;
	END_STRUCT;

(*
   NH_DS_WRK  {HIDDEN} : STRUCT
      NoY         : ARRAY[16..39] OF BOOL;                                 // docasne - Query bolo Done, ale No-Yes
      out         : ARRAY[16..39] OF USINT;                                // docasne - fyzicky vystup z Query
   END_STRUCT
*)

   NH_SVD		{HIDDEN} :  STRUCT 		
 		ok				 : NH_REC_OK;
      cf           : NH_CFG_ALL;	// := (RestoreLVL:=1);
      al           : NH_DEV_ALL;
      cx           : NH_SVD_CX;
      hw           : NH_DEV_HW0;
	END_STRUCT;

   NH_VVO_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL;
//		typ			: USINT;
		impulz		: USINT := 15;
		dummy			: STRING[5];
	END_STRUCT;

   NH_VVO		{HIDDEN} :  STRUCT 		
 		ok				 : NH_REC_OK;
      cf           : NH_CFG_ALL;	// := (RestoreLVL:=1);
      al           : NH_DEV_ALL;
      cx           : NH_VVO_CX;
      hw           : NH_DEV_HW1;
	END_STRUCT;


   NH_CFX_SCN	 {HIDDEN}	 :  STRUCT 		
      wht         : USINT;	 	// kedy je scena ON
		dummy1		: BOOL;
		dummy2		: BOOL;
		dummy3		: BOOL;
	END_STRUCT;
   NH_SCN_CX {HIDDEN}  : STRUCT
      all         : NH_CFX_ALL;
		sva			: NH_CFX_SVA;
		scn			: NH_CFX_SCN;
	END_STRUCT;
   NH_SCN_ME {HIDDEN}  : STRUCT
		delayOff		: UINT;							// pocet sec po zapnuti scn, kedy sa zacne kontrolovat, ci treba SCN vypnut DevScnOn = false
      in          : NH_DEV_ALL;
		qr				: NH_DEV_ALL;	
		ou				: NH_DEV_ALL;
	END_STRUCT;		
		
  	NH_SCN  {HIDDEN} :  STRUCT 					// Scn,Act
 		ok				 : NH_REC_OK;
      cf           : NH_CFG_ALL;
      al           : NH_DEV_ALL;
      cx           : NH_SCN_CX ;
		me				 : NH_SCN_ME;	
	END_STRUCT;
   NH_SVA		{HIDDEN} :  STRUCT 		
 		ok				 : NH_REC_OK ;
      cf           : NH_CFG_ALL  := (LvlOnRst:=true) ;
      al           : NH_DEV_ALL;
      cx           : NH_SVA_CX;
      hw           : NH_DEV_HW2;			// 0=lvl,1=ramp,2=HW min
	END_STRUCT;

   NH_RGB_HW	{HIDDEN} :  STRUCT 		
		d 				: ARRAY[0..2] OF UDINT;        // adresy Dev
		r 				: ARRAY[0..2] OF UDINT;        // adresy RAMP
	END_STRUCT;
   NH_MEM_RGB	{HIDDEN} :  STRUCT 		
      rgb         : NH_RGB_COLOR;
	END_STRUCT;
   NH_RGB	{HIDDEN} 		:  STRUCT 		
 		ok				 : NH_REC_OK ;
      cf           : NH_CFG_ALL;
      al           : NH_DEV_ALL;
      cx           : NH_SVA_CX	; // := (dim :=1, Lv0 := 5,Lv1:=100,tMaxON:=360);
      hw           : NH_DEV_HW4;					// R/G/B/WW/CW

//      cx           : NH_CFG_OUT := (dim :=1, Lv0 := 5,Lv1:=100,tMaxON:=360);
//      hw           : NH_RGB_HW;
	END_STRUCT;


   NH_BTN_N	{HIDDEN} :  STRUCT 		
      new         : USINT;                     // cislo aktualne stlaceneh BTN v HW
      old         : USINT;                     // cislo stareho BTN
      Click       : USINT;                      // cislo clicku
      et          : UINT;                       // beziaci cas
      Busy        : BOOL;                       // priznak, ze bol aspon raz vyhodnoteny click
      End         : BOOL;                       // vyslat CMD
      Done        : BOOL;
	END_STRUCT;

   NH_CLK_BTN	{HIDDEN} :  STRUCT 		
      Nx           : ARRAY[1..8]  OF  BOOL := [1,0,0,0,0,1];     // povolenia pre 1.BTN : 1..5 Click, 6=Push, 7= Hold, 8 Cl1+P
	END_STRUCT;

   NH_LED_WSB	{HIDDEN} :  STRUCT 		
      btn   :  ARRAY[1..8] OF NH_Btn3;
	END_STRUCT;

   NH_LED_BTN1	{HIDDEN} :  STRUCT 		
      rgb   :  NH_Btn3;
	END_STRUCT;
   NH_LED_BTN8 {HIDDEN} :  STRUCT 		
      btn   :  ARRAY[1..8] OF NH_LED_BTN1;
	END_STRUCT;

   NH_LEDS_CFG	 {HIDDEN} :  STRUCT 		
		LEDs			: NH_LED_BTN8;                   // manualne nastavene LED na BTN maju svietit
      DayLvl      : ARRAY[0..3]  OF USINT := [100,80,40,90];   // Lvl Den/Vecer/Noc/rano 0-100%
      DaySlp      : ARRAY[0..3]  OF USINT := [  0, 0, 0, 0];   // Cas zhasnutia Den/Vecer/Noc/rano [0.1]s
		BtnBli		: USINT; 		                  // ktory BTN bol prave stlaceny a blika - zmena btn
		BtnHet		: USINT; 		                  // cislo BTN, ktory je posledne vybraty pre zobrazenie hodnoty na display
		BtnRgb		: USINT:= 3;							// akou farbou budu svietit BTN, ktore maju vazbu
		etSlp			: INT;								 	// riadnie sleep- time		
		cmd			: USINT;									// stav blikania
      Sleep       : BOOL;                        	// Centralny priznak, ze niektore LED-ky na BTN su uspate
      PirRst      : BOOL := true;                	// pritomnost v miestnosti resetuje StleepTime
      PirWake     : BOOL := true;                	// pohyb v miestnosti zobudi LED
		refresh		: BOOL;                        	// refresh zo slidera
		BlkOuCMD		: BOOL;  								// zablokuje vystupny CMD z TGL - ked sa prebudilo, alebo iny HET-BTN
		dummy5		: BOOL;
		dummy6		: BOOL;
		dummy7		: BOOL;
		// nedolezite
		LED1bck		: NH_LED_BTN1;                   // zaloha LED jedneho BTN, s ktorym sa prave blika
		LEDbOff		: NH_BTN8;                       // zaloha=vsetky blokovane okrem jedneho, ktory ma byt rozsvieteny ked je ON
		LEDbRun     : NH_BTN8;                       // zoznam podla ktoreh sa fyzicky blika. nuluje sa alebo sa preberaz z LEDbOff
		blik			: _Nh_Blik_FB ;

		dummy			: UDINT;
	END_STRUCT;

   NH_DISP_CFG	 {HIDDEN} :  STRUCT 		
      DayLvl      : ARRAY[0..3]  OF USINT := [100,80,40,90];   // Lvl Den/Vecer/Noc/rano 0-100%
      DaySlp      : ARRAY[0..3]  OF USINT := [  0, 0, 0, 0];     // Cas zhasnutia Den/Vecer/Noc/rano [0.1]s
		etSlp			: INT;								 	// riadnie sleep- time		
		nDisp			: USINT;
//		etBli			: UINT;	                        // cas pre blikanie
//		cmd			: USINT;									// stav blikania
//		tBlON			: USINT := 50;                   // cas On 100ms
//		tBlOff		: USINT := 10;                   // cas On 100ms
//		tBlset		: USINT := 1;                    // cas On 100ms
//		nBli			: USINT;                         // pocet zostavajucich bliknuti
//		up				: BOOL;									// On/off
      Sleep       : BOOL;                        // Centralny priznak, ze niektore LED-ky na BTN su uspate
      PirRst      : BOOL := true;                // pritomnost v miestnosti resetuje StleepTime
      PirWake     : BOOL := true;                // pohyb v miestnosti zobudi LED
		refresh		: BOOL;                        // refresh zo slidera
		off			: BOOL;
		TG2			: BOOL;                        // typ TGL-2
		dummy6		: BOOL;
		dummy7		: BOOL;
		
      WhtDisp     : USINT ;                      // co sa pozaduje zobrazovat na display
		WhtBtn		: USINT := 2;                  // z ktoreho btn berieme Val, pokial je WhtDisp
		WhtFmt		: USINT := 0;                  // aky format ma byt zobrazeny
   	
		dummy       : STRING[5];
   END_STRUCT;

   NH_CFX_TLA	{HIDDEN} :  STRUCT 		
      cfc         : NH_CFG_CLICK;
	END_STRUCT;

   NH_CFG_KLA	{HIDDEN} :  STRUCT 		
      cfc         : NH_CFG_CLICK;
		btn		   : ARRAY[1..12] OF NH_CLK_BTN;	 // konfiguracia 12 tlacitok klavesnice
	END_STRUCT;

   NH_CFX_WSB	{HIDDEN} :  STRUCT 		
      cfC         : NH_CFG_CLICK;
      cfL         : NH_LEDS_CFG;                 // config LED
	END_STRUCT;
   NH_CFX_TGL	{HIDDEN} :  STRUCT 		
      cfC         : NH_CFG_CLICK;
      cfL         : NH_LEDS_CFG;                 // config LED
      cfD         : NH_DISP_CFG;                 // config Display
	END_STRUCT;
   NH_TLA_MEM	 {HIDDEN}  :  STRUCT 		
      btn     		: USINT;                       // prave stlaceny BTN
	END_STRUCT;

   NH_TGL_MEM	 {HIDDEN}  :  STRUCT 		
		xxx			: USINT;
//      btn     		: USINT;                       // prave stlaceny BTN
//		tgl			: _Nh_TGL_Btns;
	END_STRUCT;


   NH_WSB	{HIDDEN}	:  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_CLI;
      cx          : NH_CFX_WSB;
		hw				: NH_DEV_HW1;                     // zakladna adresa HW
      me          : NH_TLA_MEM;
//      me          : NH_WSB_MEM;
	END_STRUCT;
  	NH_WSB_PAR {HIDDEN} :  STRUCT 			// PARAMETRE TLACITKA VO VAZBE
 		ok				: NH_REC_OK;
		bt	         : USINT := 1;						// cislo btn na tlacitku, priradene do vazby
      cm          : NH_CLK_CMD;
	END_STRUCT;

   NH_TLA	{HIDDEN}	 :  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_CLI;
      cx          : NH_CFX_TLA;
		hw				: NH_DEV_HW4;                     // zakladna adresa HW
      me          : NH_TLA_MEM;
	END_STRUCT;

   NH_TGL	{HIDDEN}	   :  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_CLI;
      cx          : NH_CFX_TGL ;
		hw				: NH_DEV_HW1;                     // zakladna adresa HW
      me          : NH_TGL_MEM;
	END_STRUCT;

   NH_MSG		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK := ( ok := true);
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL;                  // spolocne pre vsetky DEV  cf+io
//      cx          : NH_CFX_MSG;
	END_STRUCT;


  	NH_ALA_CX {HIDDEN} :  STRUCT 					// Scn,Act
		Qr				: BOOL := true;            // prvy vstyp do LVL
		Pir			: BOOL := true;            // Qr pohybu
		dogOff		: BOOL;            			// pes zalezie do budy
		alaRst      : BOOL;							// obnovenie strazenia
		dummy1		: BOOL;
		dummy2      : BOOL;	
		dummy3      : BOOL;	
		dummy4      : BOOL;	
		PirFilt		: UINT := 30;         		// pocet SEC, kolko sa caka za dalsim vykonanim
	END_STRUCT;


  	NH_ALA {HIDDEN} :  STRUCT 					// Scn,Act
 		ok				: NH_REC_OK := (ok:=1);
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_M;
      cx          : NH_ALA_CX;
	END_STRUCT;

  // treba dotiahnut
  	NH_ALA_PAR {HIDDEN} :  STRUCT 					// Scn,Act
		OnlyFrom			: NH_BTN8;						// len ked pride z urovne 1..7
		OnlyPir			: BOOL;							// len ak bol pohyb
		OnlyAllLock		: BOOL;							// len ked su zamknute vsetky miestnosti
		RunPirFilter	: UINT;							// spustat kazdych [s] - ak je novy pohyb
		RunMaxCount		: UINT;							// Max.pocet spusteni za donu RunMaxTime
		RunMaxTime		: UINT;	                  // doba od 1.akcie pocas ktorej sa pripocitava RunMaxCount - resetne sa 1.akciou
		tPirFilter		: UINT;							// spustat kazdych [s] - ak je novy pohyb
		tMaxCount		: UINT;							// Max.pocet spusteni za donu RunMaxTime
		tMaxTime			: UINT;	                  // doba od 1.akcie pocas ktorej sa pripocitava RunMaxCount - resetne sa 1.akciou
	END_STRUCT;

   NH_HET_CHG	{HIDDEN} :  STRUCT 		
      dtChg     : DT;                              // datum/cas do najblizsej zmeny (koniec manualu, alebo zmena v programe automatiky)
      toChg     : TIME;                            // aktualny pocet min do prvej zmeny (do ukoncenia aktualneho cas.programu)
      pvChg     : USINT;                           // aka predvolba bude po uplynuti casu {vypocitana z PRG}
	END_STRUCT;

  	NH_REG_HYS  {HIDDEN}: ARRAY[0..1,1..3] OF REAL :=
  							[ 0.2, -0.6, -1.1, 			// Dn
							 -0.5, -1.0, -2.0];        // Up

  	NH_HET_MODE {HIDDEN} :  STRUCT 			// PARAMETRE a PREDVOLBY DIF regulatora
		Wht			: USINT;                 	// []		
   	out			: NH_ARR_OUT;
   	req			: NH_ARR_VAL;
		hys    		: NH_REG_HYS;
	END_STRUCT;

  	NH_HET_REG {HIDDEN}   :  STRUCT 			// PARAMETRE PREDVOLBY PID regulatora
      btn         : NH_BTN05 ;                  // ktore btn su viditelne
		IniDefault	: BOOL;
		ModeFromSrc	: BOOL := true;
		Guard			: BOOL;							// len pre TVE
		pwm			: BOOL;                    // len pre TVE
		Mode			: USINT;                 	// mode
		Delay			: USINT := 5;              // opozdenie technologie
		reg			: ARRAY[0..1] OF NH_HET_MODE :=
         		   [	// kurenie
							( out := [0,25,50,100],  req := [5.0, 20.0, 23.0, 25.0], hys := [  0.2, -1.0, -2.0, 			// Dn
							 																						-0.5, -1.0, -2.0]),        // Up),
							// chladenie
                     ( out := [0,25,50,100],  req := [0.0, 30.0, 25.0, 20.0], hys := [  0.5,  1.0,  2.0, 			// Dn
							 																						-0.5,  1.0,  2.0])        // Up),
						];
	END_STRUCT;

   NH_HET_pLED	{HIDDEN} :  STRUCT 		  // parametre LED
      prgOff      : USINT := 1;                      // cas vypnutia LED pri PRG [s]
      prgHet      : USINT := 3;                       // cas blikania LED pri PRG ak sa kuri PRG [s]
      prgDot      : USINT := 3;                       // cas blikania bodky pri PRG [s]
      dummy       : UDINT;
   END_STRUCT;

   NH_HET_MAN	{HIDDEN} :  STRUCT 		
      manTyp      : USINT := 1;                       // kedy sa manual vrati do auto
      manMem      : TTecoDateTime :=(hour:=2);        // udaj pre man (podla man za odtialto vyberie cas vratenia na manual)
   END_STRUCT;
   NH_HET_PV_P	{HIDDEN} :  STRUCT 		
      prg         : BOOL;                             // prg
      pv          : USINT;                            // predvolba
	END_STRUCT;

   NH_HET_PV	{HIDDEN} :  STRUCT 		
      chg        	: BOOL;                             // priznak, ze bolo nieco stlacene - hoci aj to iste
		p				: NH_HET_PV_P;
	END_STRUCT;


   NH_HET_PVA 	 {HIDDEN} :  STRUCT 		
      pva         : NH_HET_PV;           // co sa ma nastavit: prg/man a na aky stupen.  ... porovnava sa s me.pva
		fix			: NH_POI_FIX;
	END_STRUCT;

   NH_HET_LED	{HIDDEN} :  STRUCT 		    // prenos medzi HET a TGL,WSB....
		chg			: BOOL;
		rgb			: NH_BTN3;
   END_STRUCT;

  	NH_HET_pLOG    :  STRUCT 			// PARAMETRE PREDVOLBY PID regulatora
		Enable		: BOOL := true;		// zapnuta
		chgOut		: BOOL := true;  		// zmena vystupu
		Sample		: UINT  := 60;	      // odoberanie vzoriek	[s]
		chgReq		: USINT  := 10;			// [0.1st] zmena pozadovanej teploty ktora vyvola zapis  10 = 1.0 st
		chgRom		: USINT  := 2;			// [0.1st] zmena teploty Rom,ktora vyvola zapis  2 = 0.2
		chgHet		: USINT  := 20;			// [0.1st] zmena teploty Het,ktora vyvola zapis 20 = 2.0st
		chgKot		: USINT  := 50;			// [0.1st] zmena teploty Kot,ktora vyvola zapis 50 = 5.0st
	END_STRUCT;

  	NH_HET_pPID {HIDDEN}   :  STRUCT 			// PARAMETRE PREDVOLBY PID regulatora
		sample		: UINT := 30;			
	END_STRUCT;


   NH_HET_CFX	 {HIDDEN} :  STRUCT 		   // regulator kurenia
      chg         : NH_HET_CHG;                       // udaje k najblizsej zmene
		reg			: NH_HET_REG := (btn := [1,1,1,1,1]);
      pDay        : ARRAY[0..1] OF NH_POI_DAY;			// kurenie/CHLADENIE
      pLed        : NH_HET_pLED;                       // casy blikania LED
		pLog    		: NH_HET_pLOG;
		pPid			: NH_HET_pPID;
	END_STRUCT;

END_TYPE


VAR_GLOBAL
	xReg			{HIDDEN}	  	: PTR_TO NH_HET_REG;       		          // cfg pre predvolby
	xRegMod		{HIDDEN}	  	: PTR_TO NH_HET_MODE;
END_VAR


FUNCTION_BLOCK _Nh_DIF_REG  {HIDDEN}

	// xRegMod									sadu pre regulaciu (hysterezie pre kurenie/chladenie, pozadovana velicina prestupen regulacie
	// xPtIO^.val	   						regulovana velicina
	// xHet^.me.pv
	VAR_INPUT
//		Go				: USINT;                // refresh: 1:=Stat, 2=Out
		pvNew			: USINT;						// nova predvolba
		sample		: UINT	:= 30;		   // cas vyhodnocovania vzorky [s]
		heat			: BOOL 	:= true;			// kurenie / chladenie,vetranie,Co2
		refSta		: BOOL;						// refresh Sta - s nasilnym prepocitanim
		refOut		: BOOL;		            // refresh Out - s prepocitanim iba ak je Grad <> 0
  	END_VAR
	VAR_OUTPUT
		Up				: BOOL;						// teplota naposledy stupala
		Qout			: BOOL;						// impulz pri novej hodnota vystupu Out	
		Qchg			: BOOL;						// impulz pri ukonceni opozdenie
		grad			: SINT;                 // gradient = rychlost zmeny teploty od poslednej vzorky [-127 .. +127]
		EtChg			: USINT := 0;				// opozdenie zmeny predvolby z ovladaca, alebo webu, po restarte bude 30s
		EtOut			: UINT  ;         		// cas odoberania vzorky a vyhodnotenie Out povelu pre technologiu (po restarte je 30s, dokial zareaguju ventily  )
		Sta			: USINT;						// vypocitany stupen kurenie, este len pre web
		Out			: USINT;						// stupen kurenia pre technologiu {preneseny sta}
	END_VAR
	VAR
		pv				: USINT := 255;			// aktualna predvolba, po opozdeni, s ktoru sa pracuje, po restarte je 255
		Old			: REAL;						// minula hodnota regulovanej veliciny - z posledneho vyhodnotenia... pre zistenie gradientu
//      x				: UINT;
//      y				: UINT;
//      z				: UINT;
	END_VAR
	Qout := false	;
	Qchg := false	;
	// opozdenie zmeny predvolby z regulatora / ovladaca
	IF pv <> pvNew THEN									// prvy rozdiel predvolieb
		EtChg 	:= MAX(1,EtChg,xReg^.Delay);	   // nastavi s cas opozdenia, po restarte bude min 30s
		pv 		:= pvNew;                        // preberie sa predvolba
		RETURN;
	ELSIF EtChg	> 0 THEN
		EtChg := EtChg - aSys.n1Sec;
		IF EtChg = 0 THEN                        	// uplynul cas opozdenia
			RefSta	:= 1;                      	// prepocita sa aj ked nebola zmena tepoty
			EtOut		:= 0;									// aby preslo priamo do vypoctu
			Qchg		:= true;
		ELSE
			RETURN;
		END_IF;
	END_IF;
	IF xRegMod^.wht = 0 THEN													// kuri sa na pevny stupen
		Qout	:= Sta <> pv;
		Sta 	:= pv;         							
		out	:= sta;                             // tu ziadny odbez vzorky nie je, okamzite sa presuva PV na stat aj Out
	ELSIF EtOut > 0 THEN									// cas do odobratia dalsej vzorky
		ETout 	:= ETout - aSys.u1Sec;
		IF ETout = 0 THEN
			RefOut	:= true;
		END_IF;
	ELSE
		EtOut		:= sample;	
		Grad		:= REAL_TO_SINT( LIMIT(-127.,(xPtIO^.val - Old)*10.,127.) );
		Old 		:= xPtIO^.val;
		IF Grad <> 0 OR RefSta THEN		// vypocet len ak je zmena teploty, alebo pri refresi
			Up	:= Grad > 0;
			Sta	:= 3;
			WHILE sta >= 1 DO
				IF heat THEN								// pri kureni sa je najvyssi vykon najnizzsie pod ziadanou hodnotou
					IF Old <= xRegMod^.reQ[ pv ] + xRegMod^.hys[ BOOL_TO_USINT( up ) ,Sta] THEN
						EXIT;
					END_IF;
				ELSIF Old >= xRegMod^.reQ[ pv ] + xRegMod^.hys[ BOOL_TO_USINT( up ) ,Sta] THEN
					EXIT;										// pri chladeni/odvlhceni/CO2 sa je najvyssi vykon najvyssie nad ziadanou hodnotou
				END_IF;	
				Sta := Sta-1;
			END_WHILE;
		END_IF;
		IF RefOut THEN
			Qout	:= out <> sta;
			out	:= sta;
		END_IF;
		RefSta	:= false;
		RefOut	:= false;		
	END_IF;
END_FUNCTION_BLOCK

TYPE


   NH_HET_MEM  {HIDDEN}		:  STRUCT 		
      pvm         : NH_HET_PV;                        // aktualna predvolba
		dif			: _Nh_DIF_REG;
		out			: USINT;
//		poi			: INT;
		led			: NH_HET_LED;
		CmdVal		: BOOL;       							// prichadzajuci CMD od napr.svetla zapamata stav ON/OFF

		LogSec		: UINT;									// sample pre log [s]
		LogRec		: UINT;									// pocet viet v logu od restartu
		// posledne hodnoty, ktore isli do logu
   	LogReQ		: INT;                         	
   	LogRom		: INT;
   	LogHet		: INT;
   	LogKot		: INT;
   	LogOut		: USINT;   	

	END_STRUCT;


   NH_HET		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
 		al				: NH_DEV_ALL_M;                  // spolocne pre vsetky DEV  cf+io
//		al				: NH_ROM_ALL;                    // spolocne pre vsetky DEV  cf+io
      cx          : NH_HET_CFX;
		io				: ARRAY[0..3] OF NH_VAL_IO;  		// teplota,TVE,KOT,CET
      me          : NH_HET_MEM;
	END_STRUCT;

  	NH_HET_PAR {HIDDEN} :  STRUCT 			// PARAMETRE KURENIA - nastavia sa ako keby boli .CX
 		ok				: NH_REC_OK;
      par         : NH_HET_PVA;
		What        : USINT;						// po zapnuti / po vypnuti
      Delay			: UINT;						// oneskorene
      Wait			: UINT;                 // sledowanie pohyby
	END_STRUCT;

  	NH_TVE_GUARD  {HIDDEN}  :  STRUCT 			// PARAMETRE PREDVOLBY PID regulatora
		val         : ARRAY[0..1,0..1] OF USINT := [5,30,20,27]; // het.min/max, cold.min/max
  		tDis			: USINT := 17;								// pohotovostna/dispozicna teplota teplota
  		tRun			: UINT   := 0;	                    // cas chodu 0..100%
      eMax        : UINT   := 0;                     // max cas zopnutia [min]
		PV1_IsOn		: BOOL;
	END_STRUCT;


   NH_TVE_CFX {HIDDEN} 	:  STRUCT 		
      chg         : NH_HET_CHG;                       // udaje k najblizsej zmene
		reg			: NH_HET_REG := (btn := [1,1,1,1,1]);
      par         : NH_HET_PVA;                       // struktura parametra
		guard			: NH_TVE_GUARD;
	END_STRUCT;

   NH_TVE_MEM	 {HIDDEN}   :  STRUCT 		
      pvm         : NH_HET_PV;                        // aktualna predvolba
		dif			: _Nh_DIF_REG;
		cmd			: USINT;
//      pvm         : NH_HET_PV;                        // aktualna predvolba
		pwm			: _Nh_PWM;									// SW PWM regulator	
		stat			: NH_TCIB_VCHC_STAT;                   // vystupna LVL j POSITION prre vsetky TV. vychadza sa z TECO struktury
		pvMax			: USINT;										// max.pocet predvolieb
//		cntOn			: UINT;										// celkovy pocet zapnuti - len pre testovanie, lebo cvakali relatka
//		cntOff		: UINT;										// celkovy pocet vypnuti - len pre testovanie, lebo cvakali relatka
//		cntNoChg		: UINT;										// pocet nepotrebnych zmien - HW bolo take ako poziadavka
//		ChangeHW		: BOOL;										// HW zmenila ext.app alebo rucne v Mosaicu	
(*
		SetHw			: BOOL;
//      reG         : ARRAY[0..0] OF REAL;              // [0]-pozadovana teplota (TER,TEH,TEK..), [1]-teplota vykur.telesa (TVE)
      reQ         : REAL;                             // aktualna pozadovana teplota prebrata z cx.pv.pvT[ stupen kurenia ]
      grad        : REAL;                             // gradient od poslednej zmeny teploty zony + zvysuje sa, - znizuje sa
      typ         : USINT;                            // typ vystupu BOOL, BOOL 0*1*2*3, REAL, TVE
		cat			: USINT := 5;								// CAT, ktora sa ma aktivovat  cf.cat je len ze bude v tejto CAT
      run         : USINT;                            // 0=ready,1=otvara,2=zatvara,3=adaptacia,9=false;
      adaptStart  : TIME;
      adaptEnd    : TIME;
      kalibStart  : TIME;
      kalibEnd    : TIME;
      ready       : BOOL;                            //
      adapt       : BOOL;                            // start aleb priebeh adaptacie
      kalib       : BOOL;                            // start alebo priebeh klibracie
*)
	END_STRUCT;

   NH_TVE		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;     					// NC - bez napatia otvoreny
		al				: NH_DEV_ALL_M;                    // spolocne pre vsetky DEV  cf+io
//		al				: NH_ROM_ALL;                    // spolocne pre vsetky DEV  cf+io
      cx          : NH_TVE_CFX;
		hw				: NH_DEV_HW3;
		io				: ARRAY[0..1] OF NH_VAL_IO;
		me				: NH_TVE_MEM;
	END_STRUCT;


END_TYPE

FUNCTION  _NhDevRef   {HIDDEN} : BOOL      // podla podmienky vrati o1, alebo o2
   VAR_INPUT
      ref   : BOOL := true;
      xR    : PTR_TO NH_RGB;    // vacsinou xDev, xPt insk potom konkretne xTgl...
   END_VAR
   xR^.ok.ref     := xR^.ok.ref OR ref OR SYSTEM_S.R_EDGE_1SEC;       // dev sa nastavi priznak, ktory sa nuluje po zobrazeni v poslednom WEB-session
   _NhDevRef      := true;
END_FUNCTION




(*
// toto musi byt tu a definicia aCfg... v inom subore, hned za tymto. inak si s tym nepie poradit kompilator
VAR_GLOBAL CONSTANT
   _Cfg0    {HIDDEN} : UDINT   := SIZEOF(NH_DBX);                           	// zaciatok CFG
   _Par0    {HIDDEN} : UDINT   := _Cfg0 + SIZEOF(NH_CFG_CFG)     * _Nh_CFG;   // zaciatok PAR
   _Vaz0    {HIDDEN} : UDINT   := _Par0 + SIZEOF(NH_PAR_CFG)     * _Nh_PAR;   // zaciatok VAZ
   _Ram0    {HIDDEN} : UDINT   := _Vaz0 + SIZEOF(NH_VAZ_CFG)     * _Nh_VAZ;   // prva veta aCfg[1]  rom = 1.miestnost
END_VAR
*)


TYPE
   NH_FAV {HIDDEN} :  STRUCT 					// zoznam oblubenych
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
      cx          : NH_DEV_IO;                     // FAV c=user,n: -1 dash,-2quick,0=FAV vsetkych, 1.... fav usra
	END_STRUCT;
   NH_USR_IP  {HIDDEN} :  STRUCT          // rozsirena CFG = vacsina DEV
      IP          : STRING[16];                 // IP adresa
      x           : REAL := 1.0;
      y           : REAL := 1.13;
	END_STRUCT;
  	NH_USR_CX  {HIDDEN} :  STRUCT 					
      Set         : BOOL := 1;                        // moze ist do rezimu setup
      LastSet     : BOOL;
      LoginHome   : BOOL := 1;                        // pri prihlaseni ist vzdy na HomePage
      DshSet      : BOOL := 0;                        // je v rezime prestavovania DSH v browsoch
      OwnDSH      : BOOL := 1;                        // ma vlastny DSH
      OwnQCK      : BOOL := 1;                        // ma vlastny QuickMenu
      UsrRight    : USINT := 1 ;                      // right = uroven pristupu 0=ziadny 1=user, 2-spravca, 3-admin
      ZonList     : ARRAY[1..16] OF BOOL := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];  // zony, ktore moze user vidiet
      sbj         : USINT := 1;
      lng         : USINT;                            // language 0=SVK,1=ENG
      fav         : NH_DEV_IO:=  (c:= 1, n :=  0);     // default FAV
      dsh         : NH_DEV_IO := (c:= 1, n := -1);    // default DASH
      qck         : NH_DEV_IO := (c:= 1, n := -2);    // default QUICK
      ds1         : NH_DEV_IO := (c:= 1, n := -1);    // 1.DASH
      qc1         : NH_DEV_IO := (c:= 1, n := -2);    // 1.QUICK
      keyPas      : STRING[6];                        // kod z klavesnice
      IPnbr       : USINT := 1;
      IP          : ARRAY[1..3] OF NH_USR_IP ;
      rfid        : NH_RFID;
      mail        : STRING[50];                       // mail
      gsm         : STRING[15];                       // telefonne cislo
      skin        : USINT;                            // 0=svetle farby, 1= tmave farby
      msg         : ARRAY[0..7] OF BOOL;              // spravy, ktore ma dostavat
      Brw         : ARRAY[0..30] OF USINT := [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];  // typ vypisu DASH v browsi :// 0=home page, 1=riadok, 2=velky dash 3x2, 3=maly dsh 6x2

     	rgb			: ARRAY[1..6] OF NH_RGB_LVL :=     		// predvolby RGB
						[	( lvl := [255,255,255,  0,  0]),       // biela
							( lvl := [255,  0,255,  0,  0]),			// fialova
							( lvl := [  0,255,255,  0,  0]),       // azurova
							( lvl := [255,165,  0,  0,  0]),       // oranzova
							( lvl := [ 30, 40,255,  0,  0]),       // dodger blue
							( lvl := [138, 43,226,  0,  0])        // modra fialova
						 ];


//      xxx         : STRING[20];



      // [home,fav,roms,zone,act];

	END_STRUCT;
  	NH_USR {HIDDEN} :  STRUCT 					// categorie
 		ok				: NH_REC_OK  := (ok := true);
      cf          : NH_CFG_ALL := (Name := 'User');                 // cf.rom = uzivatel, cf.typ : -1,-2 Dash,quick, 0=FAV all, 1... cislo FAV usra
		cx				: NH_USR_CX;
	END_STRUCT;


   NH_FRM_250	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_250',desc:='HOME-Dsh/user->vz1',wht:=0,row:=8);
		vz1 : ARRAY[1..8] OF NH_VAZ :=     // FVL: ( Vaz[1] )_ - zoznam DEV k jednej hlavicke FAV
            [  (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=1)),   // SVE
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=2)),   // ZAS
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=3)),   // ROL
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=4)),   // VEN
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=5)),   // HET
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=6)),   // SEC
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=7)),   // BRA
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=8))    // ZAVLAZ
            ];
   END_STRUCT

   NH_FRM_251	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_251',desc:='TMP-FVL/user->vz1',wht:=0,row:=4);
		fav: ARRAY[1..4] OF NH_FAV :=     // FAV - hlavicka pre usra + 1 zdielany
            [  (  ok:= (ok:=1, stp:=1), cf := (Name:= 'Home Dash Menu',       typ :=  1), cx:=(c:=1,n:=-1)),
               (  ok:= (ok:=1, stp:=1), cf := (Name:= 'Home Quick Menu',      typ :=  2), cx:=(c:=1,n:=-2)),
               (  ok:= (ok:=1, adm:=1), cf := (Name:= 'Quick Setup Guide',    typ :=  3), cx:=(c:=1,n:= 3)),
               (  ok:= (ok:=1        ), cf := (Name:= 'Ob¾úbené všetkých',    typ :=  0), cx:=(c:=1,n:= 0))
            ];
   END_STRUCT

   NH_FRM_252	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_252',desc:='TMP-Def.Zone',wht:=0,row:=5);
		zon : ARRAY[1..5] OF NH_ROM :=     // ZON 1=domcek,2=vonkajsie zony
            [  (  cf := (Name:= 'Môj domov',       typ := 0, rom:=1)),
               (  cf := (Name:= 'Vonku',           typ := 2, rom:=1)),
               (  cf := (Name:= '1.Np',            typ := 3, rom:=1)),
               (  cf := (Name:= '2.Np',            typ := 3, rom:=1)),
               (  cf := (Name:= 'Podzemie',        typ := 3, rom:=1))
            ];
   END_STRUCT

   NH_FRM_253	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_253',desc:='TMP-Def.users',wht:=0,row:=5);
		usr : ARRAY[1..5] OF NH_USR :=     // 1admin + 6 usrov
            [ (  cf := (Name:= 'Admin'),     cx := (UsrRight := 3 ) ),
              (  cf := (Name:= 'User-2'),    cx := (UsrRight := 1 ) ),
              (  cf := (Name:= 'User-3'),    cx := (UsrRight := 1 ) ),
              (  cf := (Name:= 'User-4'),    cx := (UsrRight := 1 ) ),
              (  cf := (Name:= 'Spravca'),   cx := (UsrRight := 2 ) )
               ];
   END_STRUCT

   NH_FRM_254	{HIDDEN} 	  : STRUCT
      hed : NH_FRM_HED := (Name:='_254',desc:='TMP-Def.Msg-type',wht:=0,row:=3);
		msg  {HIDDEN} : ARRAY[1..3] OF NH_MSG :=     // MSG : SPRAVY
            [  (  cf := (Name:= 'Notifikácia',     typ := 0, rom:=1)),
               (  cf := (Name:= 'SMS',    			typ := 1, rom:=1)),
               (  cf := (Name:= 'Mail',            typ := 2, rom:=1))
            ];
   END_STRUCT

   NH_FRM_255	{HIDDEN} : STRUCT
      hed : NH_FRM_HED := (Name:='_255',desc:='TMP-Def.Alarm LVL',wht:=0,row:=7);
		ala : ARRAY[1..7] OF NH_ALA :=     // ALA : SPRAVY
            [  (  cf := (Name:= 'Odomknuté',     	typ := 0, rom:=1)),
               (  cf := (Name:= 'Zamykám...',    	typ := 1, rom:=1)),
               (  cf := (Name:= 'ZAMKNUTÉ',        typ := 2, rom:=1)),
               (  cf := (Name:= 'Niekto prišiel',	typ := 3, rom:=1)),
               (  cf := (Name:= 'Dunèo stráž',		typ := 4, rom:=1)),
               (  cf := (Name:= 'Dunèo trhaj',  	typ := 5, rom:=1)),
               (  cf := (Name:= 'A L A R M',   		typ := 6, rom:=1))
            ];
   END_STRUCT
END_TYPE



