(* Upozornení *)
(* Soubor je automaticky regenerován a všechny rucní modifikace budou ztracené. *)

VAR_GLOBAL CONSTANT
   CPU_TYPE : USINT := 73; (* Typ CPU *)
   CPU_CODE : UINT := 2000; (* Kód CPU *)
   CPU_SYSTEM_ID : USINT := 18; (* System ID *)
   CPU_CPM_ID : USINT := 11; (* Cpm ID *)
   CPU_PROG_MEM_SIZE : UDINT := 1048572; (* Velikost pameti pro program *)
   CPU_RETAIN_SIZE : UDINT := 49152; (* Velikost retain zóny *)
   CPU_NOTE_R_SIZE : UDINT := 327680; (* Velikost R zóny *)
   CPU_MAX_CYCLE_TIME : UDINT := 1200; (* Maximální doba cyklu *)
END_VAR

TYPE

   DT_ITCL_DEVICES_ARRAY : ARRAY[0..7] OF BYTE;

   DT_ITCL_MODULES_ARRAY : ARRAY[0..7] OF DT_ITCL_DEVICES_ARRAY;

   DT_ITCL_DIAG : STRUCT
      STAT : DT_ITCL_MODULES_ARRAY;
      ERR : DT_ITCL_MODULES_ARRAY;
   END_STRUCT;

   DT_TCL2_ARRAY : ARRAY[0..63] OF BYTE;

   DT_TCL2_DIAG : STRUCT
      STAT : DT_TCL2_ARRAY;
      ERR : DT_TCL2_ARRAY;
   END_STRUCT;

   DT_CIB_ARRAY : ARRAY[0..31] OF BYTE;

   DT_CIB_LINE_STAT : STRUCT
      IPWR : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      FUSE : BOOL;
      ECIB : BOOL;
      WCIB : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
      SCANE : BOOL;
      dummy9 {HIDDEN} : BOOL;
      dummy10 {HIDDEN} : BOOL;
      dummy11 {HIDDEN} : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   DT_CIB_LINE : STRUCT
      STPW : DT_CIB_LINE_STAT;
      UCIB : REAL;
   END_STRUCT;

   DT_CIB_DIAG : STRUCT
      STAT : DT_CIB_ARRAY;
      ERR : DT_CIB_ARRAY;
      LINE : DT_CIB_LINE;
   END_STRUCT;

   TBIN_7DI : STRUCT
      DI0 : BOOL;
      DI1 : BOOL;
      DI2 : BOOL;
      DI3 : BOOL;
      IN230 : BOOL;
      HDO0 : BOOL;
      HDO1 : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TBIN_4DIP : STRUCT
      DIP0 : BOOL;
      DIP1 : BOOL;
      DIP2 : BOOL;
      DIP3 : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TAIStat : STRUCT
      UNF : BOOL;
      UNR : BOOL;
      OVR : BOOL;
      OVF : BOOL;
      FLS : BOOL;
      CJC : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
      CHC : BOOL;
      dummy9 {HIDDEN} : BOOL;
      dummy10 {HIDDEN} : BOOL;
      dummy11 {HIDDEN} : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   TAI : STRUCT
      STAT : TAIStat;
      FS : INT;
      ENG : REAL;
      PCT : REAL;
   END_STRUCT;

   TSTPW2 : STRUCT
      ACUC : BOOL;
      PWRA : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      WSRC : BOOL;
      ESRC : BOOL;
      WACU : BOOL;
      EACU : BOOL;
      dummy8 {HIDDEN} : BOOL;
      dummy9 {HIDDEN} : BOOL;
      dummy10 {HIDDEN} : BOOL;
      dummy11 {HIDDEN} : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   DT_IR2553_IN : STRUCT
      DIS : TBIN_7DI;
      DIP : TBIN_4DIP;
      AI0 : TAI;
      AI1 : TAI;
      AI2 : TAI;
      AI3 : TAI;
      STPW : TSTPW2;
      USRC : REAL;
      SACU : REAL;
      IACU : REAL;
   END_STRUCT;

   DT_OI2872_IN : STRUCT
      Keyb : USINT;
   END_STRUCT;

   TBIN_2DO : STRUCT
      DO0 : BOOL;
      DO1 : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   DT_IR2553_OUT : STRUCT
      DOS : TBIN_2DO;
   END_STRUCT;

   TVideoRamArray : ARRAY[0..79] OF USINT;

   DT_OI2872_OUT : STRUCT
      VideoRam : TVideoRamArray;
      CodePage : UINT;
   END_STRUCT;

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

   TCIB_CWSPG_STAT : STRUCT
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      OUFT : BOOL;
      VLDT : BOOL;
      OUFR : BOOL;
      VLDR : BOOL;
   END_STRUCT;

   TCIB_C_WS_0000R_PG_BTN : STRUCT
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

   TCIB_C_WS_0000R_PG_CLICK : STRUCT
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

   TCIB_C_WS_0000R_PG_PRESS : STRUCT
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

   TCIB_C_WS_0000R_PG_BTNs : STRUCT
      BTN : TCIB_C_WS_0000R_PG_BTN;
      CLICK : TCIB_C_WS_0000R_PG_CLICK;
      PRESS : TCIB_C_WS_0000R_PG_PRESS;
   END_STRUCT;

   TCIB_C_WS_0000R_PG_GLASSI : STRUCT
      BTNs : TCIB_C_WS_0000R_PG_BTNs;
      IDENT : BYTE;
   END_STRUCT;

   TCIB_C_WS_0000R_PG_IN : STRUCT
      DI : TCIB_BTN_DI2;
      STAT : TCIB_CWSPG_STAT;
      AI1 : REAL;
      AI2 : REAL;
      GLASS : TCIB_C_WS_0000R_PG_GLASSI;
      THERM : REAL;
      RH : REAL;
   END_STRUCT;

   TCIB_C_WS_0000R_PG_CONT : STRUCT
      DOT1A : BOOL;
      DOT2A : BOOL;
      DOT1B : BOOL;
      DOT2B : BOOL;
      DBA : BOOL;
      DBB : BOOL;
      BZ : BOOL;
      PX : BOOL;
   END_STRUCT;

   TCIB_C_WS_0000R_PG_LED : STRUCT
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

   TCIB_C_WS_0000R_PG_GLASSO : STRUCT
      CONT : TCIB_C_WS_0000R_PG_CONT;
      LED : TCIB_C_WS_0000R_PG_LED;
      BLIGHT : USINT;
      DISPA : INT;
      DISPB : INT;
      SETA : USINT;
      SETB : USINT;
   END_STRUCT;

   TCIB_C_WS_0000R_PG_OUT : STRUCT
      GLASS : TCIB_C_WS_0000R_PG_GLASSO;
   END_STRUCT;

   TCIB_CWS4LO_BTN : STRUCT
      UP1 : BOOL;
      DOWN1 : BOOL;
      UP2 : BOOL;
      DOWN2 : BOOL;
      DI1 : BOOL;
      DI2 : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
      CLICK_UP1 : BOOL;
      CLICK_DOWN1 : BOOL;
      CLICK_UP2 : BOOL;
      CLICK_DOWN2 : BOOL;
      CLICK_DI1 : BOOL;
      CLICK_DI2 : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
      PRESS_UP1 : BOOL;
      PRESS_DOWN1 : BOOL;
      PRESS_UP2 : BOOL;
      PRESS_DOWN2 : BOOL;
      PRESS_DI1 : BOOL;
      PRESS_DI2 : BOOL;
      dummy22 {HIDDEN} : BOOL;
      dummy23 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_CWSLo_STAT : STRUCT
      iOUF : BOOL;
      iVLD : BOOL;
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_C_WS_0400R_Logus_IN : STRUCT
      DI : TCIB_CWS4LO_BTN;
      STAT : TCIB_CWSLo_STAT;
      THERM : REAL;
      AI1 : REAL;
      AI2 : REAL;
   END_STRUCT;

   TCIB_WSB_LED4 : STRUCT
      GREEN1 : BOOL;
      RED1 : BOOL;
      GREEN2 : BOOL;
      RED2 : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_C_WS_0400R_Logus_OUT : STRUCT
      LED : TCIB_WSB_LED4;
   END_STRUCT;

{$IFNDEF TCIB_RFID}
   TCIB_RFID : ARRAY[0..7] OF BYTE;
{$END_IF}

{$IFNDEF TCIB_CKY0001R_DI}
   TCIB_CKY0001R_DI : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      CLICK_DI1 : BOOL;
      CLICK_DI2 : BOOL;
      PRESS_DI1 : BOOL;
      PRESS_DI2 : BOOL;
      TAMPER1 : BOOL;
      TAMPER2 : BOOL;
   END_STRUCT;
{$END_IF}

{$IFNDEF TCIB_CKY0001R_STAT}
   TCIB_CKY0001R_STAT : STRUCT
      OUFT : BOOL;
      VLDT : BOOL;
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;
{$END_IF}

{$IFNDEF TCIB_C_KY_0001R_IN}
   TCIB_C_KY_0001R_IN : STRUCT
      BUTTONS : BYTE;
      RF_CODE : TCIB_RFID;
      DI : TCIB_CKY0001R_DI;
      STAT : TCIB_CKY0001R_STAT;
      THERM : REAL;
      AI1 : REAL;
      AI2 : REAL;
   END_STRUCT;
{$END_IF}

{$IFNDEF TCIB_C_KY_0001R_OUT}
   TCIB_C_KY_0001R_OUT : STRUCT
      SETT : BYTE;
      ICONS : BYTE;
      TIM : INT;
      TEXT1 : STRING[16];
      TEXT2 : STRING[16];
   END_STRUCT;
{$END_IF}

   TCIB_DI5T : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      DI3 : BOOL;
      DI4 : BOOL;
      DI5 : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
      TAMPER1 : BOOL;
      TAMPER2 : BOOL;
      TAMPER3 : BOOL;
      TAMPER4 : BOOL;
      TAMPER5 : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_AI5_STAT : STRUCT
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      OUF3 : BOOL;
      VLD3 : BOOL;
      OUF4 : BOOL;
      VLD4 : BOOL;
      OUF5 : BOOL;
      VLD5 : BOOL;
      dummy10 {HIDDEN} : BOOL;
      dummy11 {HIDDEN} : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_AI4 : STRUCT
      AI1 : REAL;
      AI2 : REAL;
      AI3 : REAL;
      AI4 : REAL;
   END_STRUCT;

   TCIB_C_IT_0504S_IN : STRUCT
      DI : TCIB_DI5T;
      STAT : TCIB_AI5_STAT;
      AI : TCIB_AI4;
      AI5 : REAL;
   END_STRUCT;

   TCIB_AO4 : STRUCT
      AO1 : REAL;
      AO2 : REAL;
      AO3 : REAL;
      AO4 : REAL;
   END_STRUCT;

   TCIB_C_IT_0504S_OUT : STRUCT
      AO : TCIB_AO4;
   END_STRUCT;

   TCIB_CWSTG2_AISTAT : STRUCT
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      OUFT : BOOL;
      VLDT : BOOL;
      OUFR : BOOL;
      VLDR : BOOL;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_BTN : STRUCT
      BTN1 : BOOL;
      BTN2 : BOOL;
      BTN3 : BOOL;
      BTN4 : BOOL;
      BTN5 : BOOL;
      BTN6 : BOOL;
      BTN7 : BOOL;
      BTN8 : BOOL;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_CLICK : STRUCT
      CLICKB1 : BOOL;
      CLICKB2 : BOOL;
      CLICKB3 : BOOL;
      CLICKB4 : BOOL;
      CLICKB5 : BOOL;
      CLICKB6 : BOOL;
      CLICKB7 : BOOL;
      CLICKB8 : BOOL;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_PRESS : STRUCT
      PRESSB1 : BOOL;
      PRESSB2 : BOOL;
      PRESSB3 : BOOL;
      PRESSB4 : BOOL;
      PRESSB5 : BOOL;
      PRESSB6 : BOOL;
      PRESSB7 : BOOL;
      PRESSB8 : BOOL;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_BTNs : STRUCT
      BTN : TCIB_C_WS_0000R_TG2_BTN;
      CLICK : TCIB_C_WS_0000R_TG2_CLICK;
      PRESS : TCIB_C_WS_0000R_TG2_PRESS;
   END_STRUCT;

   TCIB_CWSTG2_STAT : STRUCT
      dummy0 {HIDDEN} : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      PR : BOOL;
      ERR : BOOL;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_GLASSI : STRUCT
      BTNs : TCIB_C_WS_0000R_TG2_BTNs;
      VALUE : INT;
      STAT : TCIB_CWSTG2_STAT;
      IDENT {HIDDEN} : BYTE;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_IN : STRUCT
      DI : TCIB_BTN_DI2;
      AI_STAT : TCIB_CWSTG2_AISTAT;
      AI1 : REAL;
      AI2 : REAL;
      GLASS : TCIB_C_WS_0000R_TG2_GLASSI;
      THERM : REAL;
      RH : REAL;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_CONT : STRUCT
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

   TCIB_C_WS_0000R_TG2_LED : STRUCT
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

   TCIB_C_WS_0000R_TG2_GLASSO : STRUCT
      CONT : TCIB_C_WS_0000R_TG2_CONT;
      LED : TCIB_C_WS_0000R_TG2_LED;
      DISPA : INT;
      DISPB : INT;
      ZONE : USINT;
      ICONS : USINT;
      DLIGHT : USINT;
      BLIGHT : USINT;
   END_STRUCT;

   TCIB_C_WS_0000R_TG2_OUT : STRUCT
      GLASS : TCIB_C_WS_0000R_TG2_GLASSO;
   END_STRUCT;

{$IFNDEF TStatC_DL_0012S}
   TStatC_DL_0012S : STRUCT
      dummy0 {HIDDEN} : BOOL;
      dummy1 {HIDDEN} : BOOL;
      RNDOK : BOOL;
      SHS : BOOL;
      RRE : BOOL;
      RRF : BOOL;
      DONE : BOOL;
      ARC : BOOL;
   END_STRUCT;
{$END_IF}

{$IFNDEF tC_DL_0012Sin}
   tC_DL_0012Sin : STRUCT
      STAT : TStatC_DL_0012S;
      DATA : USINT;
   END_STRUCT;
{$END_IF}

{$IFNDEF TContC_DL_0012S}
   TContC_DL_0012S : STRUCT
      LENM : BOOL;
      DBL : BOOL;
      RNDS : BOOL;
      CHS : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      TRG : BOOL;
      ACN : BOOL;
   END_STRUCT;
{$END_IF}

{$IFNDEF tC_DL_0012Sout}
   tC_DL_0012Sout : STRUCT
      CONT : TContC_DL_0012S;
      ADDRESS : USINT;
      COMMAND : USINT;
      DATA : USINT;
   END_STRUCT;
{$END_IF}

   TCIB_CJC_STAT : STRUCT
      WD1 : BOOL;
      WD2 : BOOL;
      WD3 : BOOL;
      WD4 : BOOL;
      WD5 : BOOL;
      WD6 : BOOL;
      ManMode : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_C_JC_0006M_IN : STRUCT
      STAT : TCIB_CJC_STAT;
   END_STRUCT;

   TCIB_CJC : STRUCT
      DO1u : BOOL;
      DO1d : BOOL;
      DO2u : BOOL;
      DO2d : BOOL;
      DO3u : BOOL;
      DO3d : BOOL;
      DO4u : BOOL;
      DO4d : BOOL;
      DO5u : BOOL;
      DO5d : BOOL;
      DO6u : BOOL;
      DO6d : BOOL;
      dummy12 {HIDDEN} : BOOL;
      dummy13 {HIDDEN} : BOOL;
      dummy14 {HIDDEN} : BOOL;
      dummy15 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_C_JC_0006M_OUT : STRUCT
      DOs : TCIB_CJC;
      PD1 : USINT;
      PD2 : USINT;
      PD3 : USINT;
      PD4 : USINT;
      PD5 : USINT;
      PD6 : USINT;
   END_STRUCT;

   TCIB_CDM_STAT : STRUCT
      OverLoad1 : BOOL;
      OverLoad2 : BOOL;
      OverLoad3 : BOOL;
      OverLoad4 : BOOL;
      OverLoad5 : BOOL;
      OverLoad6 : BOOL;
      ManMode : BOOL;
      OverHeat : BOOL;
   END_STRUCT;

   TCIB_C_DM_0006M_ULED_IN : STRUCT
      STAT : TCIB_CDM_STAT;
      iTHERM : REAL;
   END_STRUCT;

   TCIB_CDM_LEDa : STRUCT
      LED1 : REAL;
      ramp1 : USINT;
      LED2 : REAL;
      ramp2 : USINT;
      LED3 : REAL;
      ramp3 : USINT;
   END_STRUCT;

   TCIB_CDM_LEDb : STRUCT
      LED4 : REAL;
      ramp4 : USINT;
      LED5 : REAL;
      ramp5 : USINT;
      LED6 : REAL;
      ramp6 : USINT;
   END_STRUCT;

   TCIB_C_DM_0006M_ULED_OUT : STRUCT
      LEDa : TCIB_CDM_LEDa;
      LEDb : TCIB_CDM_LEDb;
   END_STRUCT;

   TCIB_CHC_STAT : STRUCT
      OUF1 : BOOL;
      VLD1 : BOOL;
      OUF2 : BOOL;
      VLD2 : BOOL;
      OUFI : BOOL;
      VLDI : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_AI2 : STRUCT
      AI1 : REAL;
      AI2 : REAL;
   END_STRUCT;

   TCIB_DI2 : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_VCHC_STAT : STRUCT
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

   TCIB_C_HC_0201F_E_IN : STRUCT
      STAT : TCIB_CHC_STAT;
      AI : TCIB_AI2;
      iTHERM : REAL;
      DI : TCIB_DI2;
      VSTAT : TCIB_VCHC_STAT;
   END_STRUCT;

   TCIB_VCHC_CONT : STRUCT
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

   TCIB_C_HC_0201F_E_OUT : STRUCT
      VCONT : TCIB_VCHC_CONT;
   END_STRUCT;

   TCIB_CWG0503S_VAL : ARRAY[0..4] OF USINT;

   TCIB_CWG0503S_CODE : STRUCT
      STAT : USINT;
      VAL : TCIB_CWG0503S_VAL;
   END_STRUCT;

   TCIB_CWG0503S_STAT : STRUCT
      OUF4 : BOOL;
      VLD4 : BOOL;
      OUF5 : BOOL;
      VLD5 : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_CWG0503S_DI : STRUCT
      DI1 : BOOL;
      DI2 : BOOL;
      DI3 : BOOL;
      DI4 : BOOL;
      DI5 : BOOL;
      TAMPER4 : BOOL;
      TAMPER5 : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_C_WG_0503S_IN : STRUCT
      CODE : TCIB_CWG0503S_CODE;
      STAT : TCIB_CWG0503S_STAT;
      AI4 : REAL;
      AI5 : REAL;
      DI : TCIB_CWG0503S_DI;
   END_STRUCT;

   TCIB_DO3 : STRUCT
      DO1 : BOOL;
      DO2 : BOOL;
      DO3 : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TCIB_C_WG_0503S_OUT : STRUCT
      DOs : TCIB_DO3;
   END_STRUCT;

   TCIB_C1W4000M_STAT : STRUCT
      ERR : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      ARC : BOOL;
   END_STRUCT;

   TCIB_C_1W_4000M_IN : STRUCT
      STAT : TCIB_C1W4000M_STAT;
      ROMCODE1 : WORD;
      ROMCODE2 : WORD;
      ROMCODE3 : WORD;
      ROMCODE4 : WORD;
      VAL1 : INT;
      VAL2 : INT;
      VAL3 : INT;
      VAL4 : INT;
      VAL5 : INT;
      ERRCODE : UINT;
   END_STRUCT;

   TCIB_C1W4000M_CONT : STRUCT
      dummy0 {HIDDEN} : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      ACN : BOOL;
   END_STRUCT;

   TCIB_C_1W_4000M_OUT : STRUCT
      CONT : TCIB_C1W4000M_CONT;
      CMD : USINT;
      CHAN : USINT;
   END_STRUCT;

   TCHStatistic : STRUCT
      STAT : USINT;
      ERR : USINT;
      trueMes : UDINT;
      falseMes : UDINT;
   END_STRUCT;

   TUniStat : STRUCT
      DSR : BOOL;
      CTS : BOOL;
      dummy2 {HIDDEN} : BOOL;
      TRO : BOOL;
      RCF : BOOL;
      ROV : BOOL;
      TRF : BOOL;
      ARC : BOOL;
   END_STRUCT;

   TZONE_ARRAY_ETH1_UNI0_RX : ARRAY[0..511] OF USINT;

   TUNI_ETH1_UNI0_IN : STRUCT
      STAT : TUniStat;
      ERR : USINT;
      NUMR : UINT;
      DATA : TZONE_ARRAY_ETH1_UNI0_RX;
   END_STRUCT;

   TCHControl2 : STRUCT
      CONTROL : BYTE;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      LOG_TEXT_ONLY : BOOL;
      LOG_HEX_ONLY : BOOL;
      LOG_CYCLIC : BOOL;
      LOG_ON : BOOL;
   END_STRUCT;

   TUniCont : STRUCT
      dummy0 {HIDDEN} : BOOL;
      dummy1 {HIDDEN} : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      TRG : BOOL;
      CLR : BOOL;
      ACN : BOOL;
   END_STRUCT;

   TUniSign : STRUCT
      DTR : BOOL;
      RTS : BOOL;
      dummy2 {HIDDEN} : BOOL;
      dummy3 {HIDDEN} : BOOL;
      dummy4 {HIDDEN} : BOOL;
      dummy5 {HIDDEN} : BOOL;
      dummy6 {HIDDEN} : BOOL;
      dummy7 {HIDDEN} : BOOL;
   END_STRUCT;

   TZONE_ARRAY_ETH1_UNI0_TX : ARRAY[0..511] OF USINT;

   TUNI_ETH1_UNI0_OUT : STRUCT
      CONT : TUniCont;
      SIGN : TUniSign;
      NUMT : UINT;
      DATA : TZONE_ARRAY_ETH1_UNI0_TX;
   END_STRUCT;

END_TYPE

VAR_GLOBAL_INPUT
(* CP-2000 *)
   r0_p0_ITCL_DIAG : DT_ITCL_DIAG;
   r16_p1_TCL2_DIAG : DT_TCL2_DIAG;
   r16_p1_CIB_DIAG : DT_CIB_DIAG;
   r16_p2_CIB_DIAG : DT_CIB_DIAG;
   r16_p6_IO_IN : DT_IR2553_IN;
   r16_p7_DISP_IN : DT_OI2872_IN;
   (* Aliases *)
   IOP_OI_STAT AT r0_p0_ITCL_DIAG.STAT[7];
   IOP_OI_SysUsb_STAT AT r0_p0_ITCL_DIAG.STAT[7,3];
   IOP_OI_UsrDisp_STAT AT r0_p0_ITCL_DIAG.STAT[7,2];
   IOP_OI_SysDisp_STAT AT r0_p0_ITCL_DIAG.STAT[7,1];
   IOP_IR_STAT AT r0_p0_ITCL_DIAG.STAT[6];
   IOP_IR_IO_STAT AT r0_p0_ITCL_DIAG.STAT[6,1];
   IOP_PGB2_STAT AT r0_p0_ITCL_DIAG.STAT[5];
   IOP_PGB2_PORT2_STAT AT r0_p0_ITCL_DIAG.STAT[5,2];
   IOP_PGB2_PORT1_STAT AT r0_p0_ITCL_DIAG.STAT[5,1];
   IOP_PGB1_STAT AT r0_p0_ITCL_DIAG.STAT[4];
   IOP_PGB1_PORT2_STAT AT r0_p0_ITCL_DIAG.STAT[4,2];
   IOP_PGB1_PORT1_STAT AT r0_p0_ITCL_DIAG.STAT[4,1];
   IOP_SX2_STAT AT r0_p0_ITCL_DIAG.STAT[2];
   IOP_SX2_CIB_STAT AT r0_p0_ITCL_DIAG.STAT[2,2];
   IOP_SX2_TCL2_STAT AT r0_p0_ITCL_DIAG.STAT[2,1];
   IOP_SX1_STAT AT r0_p0_ITCL_DIAG.STAT[1];
   IOP_SX1_CIB_STAT AT r0_p0_ITCL_DIAG.STAT[1,2];
   IOP_SX1_TCL2_STAT AT r0_p0_ITCL_DIAG.STAT[1,1];
   IOP_OI_ERR AT r0_p0_ITCL_DIAG.ERR[7];
   IOP_OI_SysUsb_ERR AT r0_p0_ITCL_DIAG.ERR[7,3];
   IOP_OI_UsrDisp_ERR AT r0_p0_ITCL_DIAG.ERR[7,2];
   IOP_OI_SysDisp_ERR AT r0_p0_ITCL_DIAG.ERR[7,1];
   IOP_IR_ERR AT r0_p0_ITCL_DIAG.ERR[6];
   IOP_IR_IO_ERR AT r0_p0_ITCL_DIAG.ERR[6,1];
   IOP_PGB2_ERR AT r0_p0_ITCL_DIAG.ERR[5];
   IOP_PGB2_PORT2_ERR AT r0_p0_ITCL_DIAG.ERR[5,2];
   IOP_PGB2_PORT1_ERR AT r0_p0_ITCL_DIAG.ERR[5,1];
   IOP_PGB1_ERR AT r0_p0_ITCL_DIAG.ERR[4];
   IOP_PGB1_PORT2_ERR AT r0_p0_ITCL_DIAG.ERR[4,2];
   IOP_PGB1_PORT1_ERR AT r0_p0_ITCL_DIAG.ERR[4,1];
   IOP_SX2_ERR AT r0_p0_ITCL_DIAG.ERR[2];
   IOP_SX2_CIB_ERR AT r0_p0_ITCL_DIAG.ERR[2,2];
   IOP_SX2_TCL2_ERR AT r0_p0_ITCL_DIAG.ERR[2,1];
   IOP_SX1_ERR AT r0_p0_ITCL_DIAG.ERR[1];
   IOP_SX1_CIB_ERR AT r0_p0_ITCL_DIAG.ERR[1,2];
   IOP_SX1_TCL2_ERR AT r0_p0_ITCL_DIAG.ERR[1,1];
(* C-WS-0000R-PG *)
   r4144_p0_IN : TCIB_C_WS_0000R_PG_IN;
   (* Aliases *)
   RHX_101 {PUBLIC} AT r4144_p0_IN.RH; (* Vlhkost;101 *)
   TER_101 {PUBLIC} AT r4144_p0_IN.THERM; (* Pepo;101 *)
   PIR_102_2 {PUBLIC} AT r4144_p0_IN.GLASS.BTNs.BTN.BTN6; (* PIR-2;102 *)
   PIR_101_2 {PUBLIC} AT r4144_p0_IN.GLASS.BTNs.BTN.BTN5; (* PIR-1;101 *)
   TTT {PUBLIC} AT r4144_p0_IN.GLASS.BTNs.BTN;
   TGL_101_6 {PUBLIC} AT r4144_p0_IN.GLASS.BTNs; (* TGL-01;101 *)
   EEE {PUBLIC} AT r4144_p0_IN.GLASS;
   LUX_001 {PUBLIC} AT r4144_p0_IN.AI2; (* LUX;101 *)
   PIR_TS2_2 {PUBLIC} AT r4144_p0_IN.DI.DI1; (* PIR-typ.2-DI-1;101 *)
(* C-WS-0400R-Logus *)
   r4144_p1_IN : TCIB_C_WS_0400R_Logus_IN;
   (* Aliases *)
   DOR_101 {PUBLIC} AT r4144_p1_IN.DI.DI2; (* Koncak;102 *)
   WSB_101_4 {PUBLIC} AT r4144_p1_IN.DI.UP1; (* Wsb-tst;101 *)
(* C-KY-0001R *)
   r4144_p2_IN : TCIB_C_KY_0001R_IN;
(* C-WS-0400R-Logus *)
   r4144_p3_IN : TCIB_C_WS_0400R_Logus_IN;
   (* Aliases *)
   TLA_001_2 {PUBLIC} AT r4144_p3_IN.DI.DI2;
   TLA_001_1 {PUBLIC} AT r4144_p3_IN.DI.DI1; (* Tla-1;101 *)
   WSB_102_4 {PUBLIC} AT r4144_p3_IN.DI.UP1; (* WSB-102;102 *)
(* C-WS-0000R-PG *)
   r4144_p4_IN : TCIB_C_WS_0000R_PG_IN;
   (* Aliases *)
   TGL_1A1_6 AT r4144_p4_IN.GLASS.BTNs; (* TGL-A;101 *)
(* C-WS-0000R-PG *)
   r4144_p5_IN : TCIB_C_WS_0000R_PG_IN;
   (* Aliases *)
   TER_1A1 {PUBLIC} AT r4144_p5_IN.THERM; (* Ter-TGL.B;101 *)
   TGL_1B1_6 {PUBLIC} AT r4144_p5_IN.GLASS; (* TGL-B;102 *)
(* C-IT-0504S *)
   r4144_p6_IN : TCIB_C_IT_0504S_IN;
(* C-WS-0000R-TG2 *)
   r4144_p7_IN : TCIB_C_WS_0000R_TG2_IN;
(* C-DL-0064M *)
   r4146_p0_IN : tC_DL_0012Sin; (* DALI-1;000 *)
   (* Aliases *)
   DLM_001 {PUBLIC} AT r4146_p0_IN; (* DALI-1;000 *)
(* C-DL-0064M *)
   r4146_p1_IN : tC_DL_0012Sin; (* DLm-2;000 *)
   (* Aliases *)
   DLM_002 {PUBLIC} AT r4146_p1_IN; (* DLm-2;000 *)
(* C-JC-0006M *)
   r4146_p2_IN : TCIB_C_JC_0006M_IN; (* ADALI-2;000 *)
(* C-DM-0006M-ULED *)
   r4146_p3_IN : TCIB_C_DM_0006M_ULED_IN;
(* C-HC-0201F-E *)
   r4146_p4_IN : TCIB_C_HC_0201F_E_IN;
   (* Aliases *)
   TVE_001_1 {PUBLIC_API} AT r4146_p4_IN.VSTAT; (* TVE-Teco typ-1;101 *)
(* C-WG-0503S *)
   r4146_p5_IN : TCIB_C_WG_0503S_IN;
(* C-1W-4000M *)
   r4146_p6_IN : TCIB_C_1W_4000M_IN;
(* ETH1_UNI0 *)
   r0_p0_Statistic_ETH1_UNI0 : TCHStatistic;
   UNI_ETH1_UNI0_IN : TUNI_ETH1_UNI0_IN;
END_VAR

VAR_GLOBAL_OUTPUT
(* CP-2000 *)
   r0_p0_ITCL_CONTROL : UINT;
   r16_p1_TCL2_CONTROL : UINT;
   r16_p1_CIB_CONTROL : UINT;
   r16_p2_CIB_CONTROL : UINT;
   r16_p6_IO_OUT : DT_IR2553_OUT;
   r16_p7_DISP_OUT : DT_OI2872_OUT;
   (* Aliases *)
   SIR_001 {PUBLIC} AT r16_p6_IO_OUT.DOS.DO1; (* SIR-1;101 *)
   TVE_001 {PUBLIC} AT r16_p6_IO_OUT.DOS.DO0; (* TVE-RE-1 CPU;X02 *)
(* C-WS-0000R-PG *)
   r4144_p0_OUT : TCIB_C_WS_0000R_PG_OUT := (GLASS := (BLIGHT := 100));
   (* Aliases *)
   SVD_001 {PUBLIC} AT r4144_p0_OUT.GLASS.CONT.BZ; (* Svd;101 *)
   TGL_101_Q {PUBLIC} AT r4144_p0_OUT.GLASS;
(* C-WS-0400R-Logus *)
   r4144_p1_OUT : TCIB_C_WS_0400R_Logus_OUT;
   (* Aliases *)
   WSB_101_Q {PUBLIC} AT r4144_p1_OUT.LED.GREEN1;
(* C-KY-0001R *)
   r4144_p2_OUT : TCIB_C_KY_0001R_OUT;
(* C-WS-0400R-Logus *)
   r4144_p3_OUT : TCIB_C_WS_0400R_Logus_OUT;
   (* Aliases *)
   WSB_102_Q {PUBLIC} AT r4144_p3_OUT.LED.GREEN1;
(* C-WS-0000R-PG *)
   r4144_p4_OUT : TCIB_C_WS_0000R_PG_OUT := (GLASS := (BLIGHT := 100));
   (* Aliases *)
   TGL_1A1_Q {PUBLIC} AT r4144_p4_OUT.GLASS;
(* C-WS-0000R-PG *)
   r4144_p5_OUT : TCIB_C_WS_0000R_PG_OUT := (GLASS := (BLIGHT := 100));
   (* Aliases *)
   TGL_1B1_Q {PUBLIC} AT r4144_p5_OUT.GLASS;
(* C-IT-0504S *)
   r4144_p6_OUT : TCIB_C_IT_0504S_OUT;
   (* Aliases *)
   SVA_5A4 {PUBLIC} AT r4144_p6_OUT.AO.AO1; (* AO1-0-10V;101 *)
(* C-WS-0000R-TG2 *)
   r4144_p7_OUT : TCIB_C_WS_0000R_TG2_OUT := (GLASS := (DLIGHT := 100, BLIGHT := 100));
(* C-DL-0064M *)
   r4146_p0_OUT : tC_DL_0012Sout;
   (* Aliases *)
   DLM_001_Q {PUBLIC} AT r4146_p0_OUT;
(* C-DL-0064M *)
   r4146_p1_OUT : tC_DL_0012Sout;
   (* Aliases *)
   DLM_002_Q {PUBLIC} AT r4146_p1_OUT;
(* C-JC-0006M *)
   r4146_p2_OUT : TCIB_C_JC_0006M_OUT;
   (* Aliases *)
   VEN_002_Q {PUBLIC} AT r4146_p2_OUT.DOs.DO5d;
   VEN_002_1 {PUBLIC} AT r4146_p2_OUT.DOs.DO5u; (* Rekup-2st;101 *)
   ROL_102_D {PUBLIC} AT r4146_p2_OUT.DOs.DO4d;
   ROL_102_U {PUBLIC} AT r4146_p2_OUT.DOs.DO4u; (* Spalna-Dvere;102 *)
   ROL_1C1_D {PUBLIC} AT r4146_p2_OUT.DOs.DO3d;
   ROL_1C1_0U {PUBLIC} AT r4146_p2_OUT.DOs.DO3u; (* Pepo-Vikier;101 *)
   ROL_101_D {PUBLIC} AT r4146_p2_OUT.DOs.DO2d;
   ROL_101_U {PUBLIC} AT r4146_p2_OUT.DOs.DO2u; (* Pepo-OKNO;101 *)
   ROL_1B1_D {PUBLIC} AT r4146_p2_OUT.DOs.DO1d;
   ROL_1B1_U {PUBLIC} AT r4146_p2_OUT.DOs.DO1u; (* Pepo-DVERE pokaz.rele;101 *)
(* C-DM-0006M-ULED *)
   r4146_p3_OUT : TCIB_C_DM_0006M_ULED_OUT;
   (* Aliases *)
   SVA_002_Q {PUBLIC} AT r4146_p3_OUT.LEDb.ramp5;
   SVA_002 {PUBLIC} AT r4146_p3_OUT.LEDb.LED5; (* SVA-02-WW;102 *)
   SVA_001_Q {PUBLIC} AT r4146_p3_OUT.LEDb.ramp4;
   SVA_001 {PUBLIC} AT r4146_p3_OUT.LEDb.LED4; (* SVA-01-CW;101 *)
   RGB_102_B {PUBLIC} AT r4146_p3_OUT.LEDa.LED3;
   RGB_102_G {PUBLIC} AT r4146_p3_OUT.LEDa.LED2;
   RGB_102_R {PUBLIC} AT r4146_p3_OUT.LEDa.LED1; (* RGB _2;102 *)
(* C-HC-0201F-E *)
   r4146_p4_OUT : TCIB_C_HC_0201F_E_OUT;
   (* Aliases *)
   TVE_001_Q {PUBLIC_API} AT r4146_p4_OUT.VCONT;
(* C-WG-0503S *)
   r4146_p5_OUT : TCIB_C_WG_0503S_OUT;
(* C-1W-4000M *)
   r4146_p6_OUT : TCIB_C_1W_4000M_OUT;
(* ETH1_UNI0 *)
   r0_p0_Control_ETH1_UNI0 : TCHControl2;
   UNI_ETH1_UNI0_OUT : TUNI_ETH1_UNI0_OUT;
END_VAR

VAR_GLOBAL
END_VAR

VAR_EXTERNAL
END_VAR



(* ******************************************************************************* *)
(* Generováno programem Mosaic *)
(* © 2001-2025 Teco a.s. *)
