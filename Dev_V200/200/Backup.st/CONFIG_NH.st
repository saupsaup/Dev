TYPE
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




(*
	{$IFNDEF TCIB_BTN_DI2}
   TCIB_BTN_DI2  {HIDDEN} : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      CLICK1 : BOOL;
      CLICK2 : BOOL;
      PRESS1 : BOOL;
      PRESS2 : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;
   { $END_IF }

	{$IFNDEF TCIB_C_WS_0000R_TG2_BTN}
	TCIB_C_WS_0000R_TG2_BTN {HIDDEN} :
  STRUCT
    BTN1             : bool;
    BTN2             : bool;
    BTN3             : bool;
    BTN4             : bool;
    BTN5             : bool;
    BTN6             : bool;
    BTN7             : bool;
    BTN8             : bool;
  END_STRUCT;
   { $END_IF }
	
	TCIB_C_WS_0000R_TG2_CLICK {HIDDEN} :
  STRUCT
    CLICKB1          : bool;
    CLICKB2          : bool;
    CLICKB3          : bool;
    CLICKB4          : bool;
    CLICKB5          : bool;
    CLICKB6          : bool;
    CLICKB7          : bool;
    CLICKB8          : bool;
  END_STRUCT;


 TCIB_C_WS_0000R_TG2_PRESS {HIDDEN} :
  STRUCT
    PRESSB1          : bool;
    PRESSB2          : bool;
    PRESSB3          : bool;
    PRESSB4          : bool;
    PRESSB5          : bool;
    PRESSB6          : bool;
    PRESSB7          : bool;
    PRESSB8          : bool;
  END_STRUCT;







	{$IFNDEF TCIB_CWSTG2_AISTAT}
   TCIB_CWSTG2_AISTAT  {HIDDEN} : STRUCT
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      OUFT : BOOL;
      VLDT : BOOL;
      OUFR : BOOL;
      VLDR : BOOL;
   END_STRUCT;
   { $END_IF }

	{$IFNDEF TCIB_C_WS_0000R_TG2_CLICK}
   TCIB_C_WS_0000R_TG2_CLICK  {HIDDEN} : STRUCT
      CLICKB1 : BOOL;
      CLICKB2 : BOOL;
      CLICKB3 : BOOL;
      CLICKB4 : BOOL;
      CLICKB5 : BOOL;
      CLICKB6 : BOOL;
      CLICKB7 : BOOL;
      CLICKB8 : BOOL;
   END_STRUCT;
   { $END_IF }
	{$IFNDEF TCIB_C_WS_0000R_TG2_PRESS}
   TCIB_C_WS_0000R_TG2_PRESS  {HIDDEN} : STRUCT
      PRESSB1 : BOOL;
      PRESSB2 : BOOL;
      PRESSB3 : BOOL;
      PRESSB4 : BOOL;
      PRESSB5 : BOOL;
      PRESSB6 : BOOL;
      PRESSB7 : BOOL;
      PRESSB8 : BOOL;
   END_STRUCT;
   { $END_IF }

   {$IFNDEF TCIB_C_WS_0000R_TG2_BTNs}                            // TG2


   TCIB_C_WS_0000R_TG2_BTNs  {HIDDEN} : STRUCT
      BTN : TCIB_C_WS_0000R_TG2_BTN;
      CLICK : TCIB_C_WS_0000R_TG2_CLICK;
      PRESS : TCIB_C_WS_0000R_TG2_PRESS;
   END_STRUCT;
   TCIB_CWSTG2_STAT  {HIDDEN} : STRUCT
      dummy0 {HIDDEN} : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      PR : BOOL;
      ERR : BOOL;
   END_STRUCT;
   TCIB_C_WS_0000R_TG2_GLASSI  {HIDDEN} : STRUCT
      BTNs : TCIB_C_WS_0000R_TG2_BTNs;
      VALUE : INT;
      STAT : TCIB_CWSTG2_STAT;
      IDENT {HIDDEN} : BYTE;
   END_STRUCT;


	{$IFNDEF TCIB_BTN_DI2}                            // TG2
	TCIB_BTN_DI2 : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      CLICK1 : BOOL;
      CLICK2 : BOOL;
      PRESS1 : BOOL;
      PRESS2 : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;
   { $END_IF }

   TCIB_C_WS_0000R_TG2_IN  {HIDDEN} : STRUCT
      DI : TCIB_BTN_DI2;
      AI_STAT : TCIB_CWSTG2_AISTAT;
      AI1 : REAL;
      AI2 : REAL;
      GLASS : TCIB_C_WS_0000R_TG2_GLASSI;
      THERM : REAL;
      RH : REAL;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_CONT  {HIDDEN} : STRUCT
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
   TCIB_C_WS_0000R_TG2_LED  {HIDDEN}  : STRUCT
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
   TCIB_C_WS_0000R_TG2_GLASSO  {HIDDEN} : STRUCT
      CONT : TCIB_C_WS_0000R_TG2_CONT;
      LED : TCIB_C_WS_0000R_TG2_LED;
      DISPA : INT;
      DISPB : INT;
      ZONE : USINT;
      ICONS : USINT;
      DLIGHT : USINT;
      BLIGHT : USINT;
   END_STRUCT;
   TCIB_C_WS_0000R_TG2_OUT {HIDDEN}  : STRUCT
      GLASS : TCIB_C_WS_0000R_TG2_GLASSO;
   END_STRUCT;
   { $END_IF }
*)
END_TYPE

(*
VAR_GLOBAL
//	xBtnS				  : PTR_TO yBtnS;
 	xBtnS			{HIDDEN}	  : PTR_TO TCIB_C_WS_0000R_PG_BTNs;
 	xGlas			{HIDDEN}	  : PTR_TO TCIB_C_WS_0000R_PG_GLASSO;
 	xBtnS2		{HIDDEN}	  : PTR_TO TCIB_C_WS_0000R_TG2_GLASSI;
 	xGlas2		{HIDDEN}	  : PTR_TO TCIB_C_WS_0000R_TG2_GLASSO;

  	xTvTecoIn   : PTR_TO TCIB_VCHC_STAT;
   xTvTecoOu   : PTR_TO TCIB_VCHC_CONT;
  	pTvIn        : ARRAY[1..10] OF TCIB_VCHC_STAT;
  	pTvOu        : ARRAY[1..10] OF TCIB_VCHC_CONT;


	xWg503In    : PTR_TO TCIB_C_WG_0503S_IN;
   xWg503Ou    : PTR_TO TCIB_C_WG_0503S_OUT;
   xKy001In    : PTR_TO TCIB_C_KY_0001R_IN;
   xKy001Ou    : PTR_TO TCIB_C_KY_0001R_OUT;
END_VAR

VAR_GLOBAL CONSTANT
	_eBtnS	: TCIB_C_WS_0000R_PG_BTNs;
	_eBtnS2	: TCIB_C_WS_0000R_TG2_BTNs;
END_VAR
*)





