(* 3. INICIALIZACIA GLOBALNYCH PREMENNYCH *)

VAR_GLOBAL CONSTANT        // grobalne pouzivane premenne

//   _e_ROM_STA           {HIDDEN}	   : NH_ROM_STA;
//   _eCode               {HIDDEN}	   : NH_RFID;
//   _eHW_2               {HIDDEN}    : NH_DEV_HW2;
   _etTDT               {HIDDEN}    : TTecoDateTime;

//	_eScnGrp     		{HIDDEN}    : NH_DALI_GRP;
END_VAR

VAR_GLOBAL
//   aSys	      {HIDDEN}     : NH_SYS;

	dlma           {HIDDEN} : USINT;
   dlsl           {HIDDEN} : USINT;
	dlgr           {HIDDEN} : USINT;
	xDlm				{HIDDEN}	  : PTR_TO NH_DLM;
   xDLg        	{HIDDEN}	  : PTR_TO NH_DLG;
	xDLfb	     		{HIDDEN}	  : PTR_TO NH_DALI;
//   xDLp        {HIDDEN}	  : PTR_TO NH_DLS_PAR;
   xDLMc       	{HIDDEN}	  : PTR_TO NH_DL_CMD;
//   xDLsta      {HIDDEN}	  : PTR_TO NH_CFX_DALI;
   xDLpar      	{HIDDEN}	  : PTR_TO NH_DL_BAL_PAR;
	xDls			{HIDDEN}	  : PTR_TO NH_DLS;	

//   xCan        {HIDDEN}     : PTR_TO TCanvasData;
	xGlb			{HIDDEN}     : PTR_TO NH_GLB;
//   xLed        {HIDDEN}   : PTR_TO NH_LED_WSB;
//   yLed        {HIDDEN}   : NH_LED_TGL;
   xCfL        {HIDDEN}   : PTR_TO NH_LEDS_CFG;
   xCfd        {HIDDEN}   : PTR_TO NH_DISP_CFG;
   

	xUsr			{HIDDEN}	    : PTR_TO NH_USR;
	xUsr2			{HIDDEN}	    : PTR_TO NH_USR;
   yUsr        {HIDDEN}	    : NH_USR;
   yPar        {HIDDEN}     : NH_PAR_CFG;
   yVio        {HIDDEN}     : NH_VAZ_CFG;

   xPt         {HIDDEN}	    : PTR_TO NH_RGB;
   xDel			{HIDDEN}	    : PTR_TO NH_RGB;          		          // univerzalne DEL

//	yDev			{HIDDEN}	    : NH_SVA;          		          // univerzalne DEV
//	xCfg			{HIDDEN}	    : PTR_TO NH_CFG_ALL;				             // univerzalny CFG  aj s HW (typ+d[...])
//	xCfg2			{HIDDEN}	    : PTR_TO NH_CFG_ALL;				             // univerzalny CFG  aj s HW (typ+d[...])
//	xDlD			{HIDDEN}	    : PTR_TO NH_HW_DALI;       		          // cfg pre DALI
//	xCfx			{HIDDEN}	    : PTR_TO NH_CFG_OUT;       		          // cfg pre OUT
//	xCfx2		   {HIDDEN}	    : PTR_TO NH_CFG_OUT;       		          // cfg pre OUT



	xDev			{HIDDEN}		 : PTR_TO NH_SVA;          		          // univerzalne DEV
	xDev2			{HIDDEN}	  	 : PTR_TO NH_SVA;          		          // univerzalne DEV
	xCfx			{HIDDEN}	    : PTR_TO NH_SVA_CX;       		          // cfg pre OUT
	xCfx2		   {HIDDEN}	    : PTR_TO NH_SVA_CX;       		          // cfg pre OUT



//   xLvl        {HIDDEN}	    : PTR_TO NH_PAR_LVL;       		          //
//	xCxb			{HIDDEN}	    : PTR_TO NH_BLX_CXB;       		
//	xCfK			{HIDDEN}	    : PTR_TO NH_CFG_KLA;       		          // cfg pre klavesnicu
//	xCfP			{HIDDEN}	    : PTR_TO NH_PIR_CFX;       		          // cfg pre PIR,WIN,DOR ...
//   xClc			{HIDDEN}	    : PTR_TO NH_CLK_CMD;       		          // CMD pre jedne button
	xRgb			{HIDDEN}	    : PTR_TO NH_RGB;          		          // univerzalne DEV
	xClr			{HIDDEN}	    : PTR_TO NH_RGB_COLOR;                    // mapovanie zloziek
	xPar			{HIDDEN}	    : PTR_TO NH_RGB_PAR;				          // univerzalny PAR
	xPar2			{HIDDEN}	    : PTR_TO NH_RGB_PAR;				          // univerzalny PAR
	yRgbWA 	   {HIDDEN}	    :        NH_RGB_LVL;		

//	xPaX			{HIDDEN}	    : PTR_TO NH_DLS_PAR;				          // univerzalny PAR bude nahradeny xPar
//	xSvX			{HIDDEN}	    : PTR_TO NH_SVD;				                // univerzalny PAR tot bude xDev


   xArR        {HIDDEN}	    : PTR_TO NH_ARR_REA;				          // pole REAL
   xArI        {HIDDEN}	    : PTR_TO NH_ARR_INT;				          // pole INT
   xPoi        {HIDDEN}	    : PTR_TO NH_POI_DAT;				          //
   xPox        {HIDDEN}	    : PTR_TO NH_POI;     				          //
   xPox2       {HIDDEN}	    : PTR_TO NH_POI;     				          //
   yPox        {HIDDEN}	    : NH_POI;     				          //
   xPod        {HIDDEN}	    : PTR_TO NH_POI_DAY;				          //
   xPod2       {HIDDEN}	    : PTR_TO NH_POI_DAY;				          //
   xFix        {HIDDEN}	    : PTR_TO NH_POI_FIX;				          //


	yPod        {HIDDEN}	    : NH_POI_DAY;				          //
//   xRzv        {HIDDEN}	    : PTR_TO NH_RZV;				                //

   xArP        {HIDDEN}	    : PTR_TO NH_ARR_POI;				          // pole pointov
	xNh			{HIDDEN}	    : PTR_TO NH_CFG_CFG;				                // xCfg,xPar,xVaz
	xNh2			{HIDDEN}	    : PTR_TO NH_CFG_CFG;				                // xCfg,xPar,xVaz
	xCfg			{HIDDEN}	    : PTR_TO NH_CFG_CFG;				                // xCfg,xPar,xVaz
   xCfb        {HIDDEN}     : PTR_TO NH_CLK_BTN;

   xIO        {HIDDEN}	  : PTR_TO NH_DEV_IO;
   yIO        {HIDDEN}	  : NH_DEV_IO;
//	cCat			{HIDDEN}	  : PTR_TO NH_RGB;          		// adresa konfiguracie DEV

	xLck		   {HIDDEN}   : PTR_TO NH_ROM_LCK;
	xRom		   {HIDDEN}   : PTR_TO NH_ROM;               // miestnost CFG
	xZon    		{HIDDEN}	  : PTR_TO NH_ROM;               // zona CFG
	xZOu    		{HIDDEN}	  : PTR_TO NH_ROM;               // vonkajsia zona
	pZon    		{HIDDEN}	  : PTR_TO NH_ZON_PAR;              // zona CFG
   xHom    		{HIDDEN}	  : PTR_TO NH_ROM;               	// zona 1 = cely domcek , na zaciatko sa namapuje a nemeni sa
//   xHo2        {HIDDEN}   : PTR_TO NH_ROM ;                 // vonkajsia zona
   xFav        {HIDDEN}	  : PTR_TO NH_FAV;
   xScn    		{HIDDEN}	  : PTR_TO NH_SCN;
	xAct    		{HIDDEN}	  : PTR_TO NH_ACT;
	xAla    		{HIDDEN}	  : PTR_TO NH_ALA;
   xHet        {HIDDEN}   : PTR_TO NH_HET ;
   xHet2       {HIDDEN}   : PTR_TO NH_HET ;

	xPva			{HIDDEN}	  : PTR_TO NH_HET_PV;       		
	xPva2			{HIDDEN}	  : PTR_TO NH_HET_PV;       		
//	xMan			{HIDDEN}	  : PTR_TO NH_HET_MAN;       		          // cfg pre predvolby

   xTve        {HIDDEN}   : PTR_TO NH_TVE ;
	xDTm			{HIDDEN}	  : PTR_TO NH_DT_M;
//	xPDT			{HIDDEN}	  : PTR_TO NH_DT;

   xPir        {HIDDEN}   : PTR_TO NH_PIR ;

   xTer        {HIDDEN}   : PTR_TO NH_TER ;
   xLux        {HIDDEN}   : PTR_TO NH_LUX ;
   xDor        {HIDDEN}   : PTR_TO NH_DOR ;
   xZas        {HIDDEN}   : PTR_TO NH_SVD ;
//   xVen        {HIDDEN}   : PTR_TO NH_VEN ;
   xKey        {HIDDEN}   : PTR_TO NH_KEY ;

	xVaz			{HIDDEN}	  : PTR_TO NH_VAZ;					// adresa vazby
	yVaz			{HIDDEN}	  : NH_VAZ;					         //
//   xVcf        {HIDDEN}	  : PTR_TO NH_VAZ_VCF;
//   xDin        {HIDDEN}	  : PTR_TO NH_DEV_ALL;
//   xDou        {HIDDEN}	  : PTR_TO NH_DEV_ALL;

	xSvd			{HIDDEN}	  : PTR_TO NH_SVD;
	xVvo			{HIDDEN}	  : PTR_TO NH_VVO;
	xTim			{HIDDEN}	  : PTR_TO NH_TIM;

	xWsb			{HIDDEN}	  : PTR_TO NH_WSB;
	xTla			{HIDDEN}	  : PTR_TO NH_TLA;
 	xTgl			{HIDDEN}	  : PTR_TO NH_TGL;
   xCfc  		{HIDDEN}	  : PTR_TO NH_CFG_CLICK;

	xRFI			{HIDDEN}	  : PTR_TO NH_RFI;
	xRFK			{HIDDEN}	  : PTR_TO NH_RFK;

   xRol        {HIDDEN}	  : PTR_TO NH_ROL;
	xRol2       {HIDDEN}	  : PTR_TO NH_ROL;
	xRSld      {HIDDEN}	  : PTR_TO NH_ROL_SLD;	
//   xBra        {HIDDEN}	  : PTR_TO NH_BRA;
//   pBra        {HIDDEN}   : PTR_TO NH_BRA_PAR ;

   xGat        {HIDDEN}	  : PTR_TO NH_GAT;
   pGat        {HIDDEN}   : PTR_TO NH_GAT_PAR ;

   xBlk        {HIDDEN}   : PTR_TO NH_BLK ;
//   xBlx        {HIDDEN}   : PTR_TO NH_BLX ;

   rgb                    : NH_RGB_COLOR;

   pWSB        {HIDDEN}   	: PTR_TO NH_WSB_PAR ;
   pPir        {HIDDEN}   	: PTR_TO NH_PIR_PAR ;          //
   pHet        {HIDDEN}   	: PTR_TO NH_HET_PAR ;
   pHet2       {HIDDEN}   	: PTR_TO NH_HET_PAR ;
   pRol        {HIDDEN}   	: PTR_TO NH_ROL_PAR ;
   pRol2       {HIDDEN}   	: PTR_TO NH_ROL_PAR ;
   xRolT   		{HIDDEN} 	: PTR_TO NH_ROL_UPDN;
   xFmt23     	{HIDDEN} 	: PTR_TO NH_OBJ_FMT_23;
   yFmt23     	{HIDDEN} 	: NH_OBJ_FMT_23;


   xBtn8                   {HIDDEN} : PTR_TO NH_BTN8;
   yBtn8                   {HIDDEN} : NH_BTN8;

   xHoW        {HIDDEN}    : PTR_TO NH_WRK_ROM;          // domcek vo wrk
//   xZoW1       {HIDDEN}    : PTR_TO NH_WRK_ROM;          // domovska zona (pre subjekt je ina ako xHow)
   xRoW1       {HIDDEN}    : PTR_TO NH_WRK_ROM;          // 1.rom  vo wrk
   xRoW        {HIDDEN}    : PTR_TO NH_WRK_ROM;          // univerzalne pre rom aj zon
   xZoW        {HIDDEN}    : PTR_TO NH_WRK_ROM;          // univerzalne pre rom aj zon ako druha xRoW
//   xCaW        {HIDDEN}    : PTR_TO NH_WRK_CAT;          // pritomnost CAT v zone > 3

   xTTdt       {HIDDEN}    : PTR_TO TTecoDateTime;
   _NhDefRom 	{HIDDEN}    : USINT := 1;               	// default room (setup) pre priradenie do SCN....
   _NhDefHom 	{HIDDEN}    : USINT := 1;               	// default Home - domcek pre priradenie do ACT....


//	xReg			{HIDDEN}	  : PTR_TO NH_REG_REG;
//	xVal3			{HIDDEN}	  : PTR_TO NH_VAL_3;





END_VAR

FUNCTION _Nh_Poi_Home_Day {HIDDEN} : USINT                           (* ZISTI AKTUALNY DEN *)
   VAR_INPUT
//      fix   : BOOL;
      day   : USINT;
   END_VAR
   _Nh_Poi_Home_Day := xHom^.cx.pDay.Day;                         // vrati den domceka

	RETURN;
(*
   IF xHom^.cx.pDay.Day = 0 OR xHom^.cx.pDay.fix = false  THEN                             // vybraty kaledar = vyberie sa aktualny den v tyzdni (1-7)
      xHom^.cx.pDay.Day := SYSTEM_S.COUNTER_DAYS_OF_WEEK;    // opravi sa 0
   END_IF;
   IF fix AND day > 0 THEN                                     // vrati to co prislo
      _Nh_Poi_Home_Day := day;
   ELSE
      _Nh_Poi_Home_Day := xHom^.cx.pDay.Day;                         // vrati den domceka
   END_IF;
*)
END_FUNCTION

(*
FUNCTION _Nhfrw {HIDDEN} : BOOL    // nacita/zapise
   VAR_INPUT
      row      : BOOL := true;               // prida znak CRLF
      cBeg     : BOOL := true;               // zatvorit na zaciatku
      cEnd     : BOOL := true;               // zatvorit na konci
		NofA		: BOOL;								// pri zapisovani viac suborov za sebou neresetuje kolko sa zapisalo
//      wht      : USINT;                      // 0=read, 1=write 2=append
		mode		: TF_MODE;
      sz       : UDINT;                      // pocet bytov na citanie/zapis
      fW      	: PTR_TO STRING[255];         // adresa premennej do ktorej/z ktorej sa zapisuje
   END_VAR
   VAR_IN_OUT

   END_VAR
   _NhFrw   := false;
   IF _NhFopen( fh := aSys.frw.fH, fN := aSys.frw.FN, mode := mode) THEN
//      aSys.frw.wht   := mode;
      CASE mode OF
        F_READ 		: rb := FileSetPos(hFile := aSys.frw.fH, offset := aSys.frw.fP);            		                    // nastavi sa na poziciu
        F_WRITE		: aSys.frw.fP := BEGIN_POS;
				IF NofA = false THEN
	            aSys.frw.fA := 0;
   			END_IF;	
	     F_APPEND 		: ;
        F_READ_PLUS	: rb := FileSetPos(hFile := aSys.frw.fH, offset := aSys.frw.fP);            		                    // nastavi sa na poziciu
      END_CASE;
      IF mode <> F_READ THEN
         If row THEN
            fW^ := CONCAT(fW^,'$r$n');
         END_IF;
         IF sz = 0 THEN
            sz := INT_TO_UDINT(LEN( fW^ ));
         END_IF;
         aSys.frw.fR := FileWrite (hFile := aSys.frw.fH, adrBuf := PTR_TO_UDINT(fW), size := sz );   // nacita maximum
      ELSE
         aSys.frw.fR := FileRead (hFile := aSys.frw.fH, adrBuf := PTR_TO_UDINT(fW), size := sz);   // nacita maximum
      END_IF;
      aSys.frw.fA := aSys.frw.fA + aSys.frw.fR;
      aSys.frw.fP := aSys.frw.fP + aSys.frw.fR;
      _NhFrw      := aSys.frw.fR = sz;
      If cEnd THEN
         rb := _NhFclose(fH := aSys.frw.fH);
      END_IF;
   END_IF;
END_FUNCTION
*)

FUNCTION _NhFnObr {HIDDEN} : STRING[8]                              // nazov suboru obrazka
   VAR_INPUT
      fn       : INT;                   // file name 0..255
   END_VAR
   _NhFnObr   := CONCAT(INT_TO_STRINGF(fn,'%03u'),'.PNG');
END_FUNCTION

FUNCTION _NhxPt {HIDDEN} : BOOL	    // namapuje xRom,xZon a ich docasne pamate
   VAR_INPUT
		err	: BOOL := true;				// zpise ERROR
		ok		: BOOL;					// vrati TRUE aj ked je veta DEL
      c    	: USINT;
      n    	: INT;
      x     : INT;
   END_VAR
   _NhxPt      := false;

//err:=1;

   IF c=0 OR c > _NH_CFG OR n<=0 THEN
      aSys.ErrPt  := aSys.ErrPt + 1;

		IF err THEN
   	   yTx2 := CONCAT('Err-0: _NhxPt: c:',USINT_TO_STRINGF(c,'%2d'),';n:',INT_TO_STRINGF(n,'%4d'),';x:',INT_TO_STRINGF(x,'%5d'));	
      	_Nh1RowTxt(logRst := 1, adTime := 3);
		END_IF	
   ELSIF n <= aCfg[c].rec THEN
      xPt     := ADR( mRam[ aCfg[c].Ram + aCfg[c].siz * INT_TO_UDINT( n - 1 ) ]);
      _NhxPt  := ok OR xPt^.ok.OK;
	ELSE
      aSys.ErrPt  := aSys.ErrPt + 1;	
		IF err THEN
   	   yTx2 := CONCAT('Err-X: _NhxPt: ',USINT_TO_STRINGF(c,'%2d'),';',INT_TO_STRINGF(n,'%4d'),';',INT_TO_STRINGF(x,'%5u'));	
//			If vaz > -1 THEN
//				yTx2 := CONCAT(yTx2,'  ;cfv',USINT_TO_STRINGF(CFv,'%3u'),';iov:',SINT_TO_STRINGF(vaz,'%2u'),';NDv',INT_TO_STRINGF(ndv,'%4u'));
//			END_IF;
      	_Nh1RowTxt(logRst := 1, adTime := 3);
		END_IF	
   END_IF;
END_FUNCTION

(*
FUNCTION _NhVarSdc {HIDDEN} : BOOL  // zapise na SDC
   VAR_INPUT
      src   : UDINT;       // adresa premennej
      siz   : UDINT;       // kolko bytov od zaciatko premennej sa ma zapisat
   END_VAR
   fH    := FileOpen(fileName := yTx3, mode := F_WRITE);
   IF fH <> INVALID_HANDLE_VALUE THEN
      FileWrite (hFile := fH, adrBuf := src, size := siz);
   END_IF;
   FileClose(hFile := fH);
END_FUNCTION
*)
(*
FUNCTION {HIDDEN} _NhRowTxtNext : BOOL    // nacita riadok do yTx1 ukonceny CRLF od aktualne nastavenej pozice a presunie na zaciatok dalsieho riadka
   VAR_INPUT
      row      : USINT := 250;
   END_VAR
   VAR_TEMP
      x     : INT;
   END_VAR
   _NhRowTxtNext  := false;
   rb    := FileSetPos(hFile := fH, offset := fP);            		                    // nastavi sa na poziciu
   fRW   := FileRead (hFile := fH, adrBuf := PTR_TO_UDINT(ADR(yTx1)), size := USINT_TO_UDINT(row));   // nacita maximum
   x 	   := FIND(yTx1,'$r$n');                                                        // najde koniec riadka
   IF x > 0 AND fRW > 0 THEN                                                           // nejaky riadok (aj prazdny) nacitany
      yTx1 := MID(yTx1,x - 1,1);
      fP := fP + INT_TO_UDINT(x) + 1;                                                  // prestavi buducu poziciu na dalsi riadok (za crlf (2byte))
      _NhRowTxtNext  := true;
   END_IF;
END_FUNCTION
*)

FUNCTION aRGBL {HIDDEN} : BOOL		// upravi zaslane zlozky podla levelu, ktory je ulozeny v zlozke priehladnosti A
	VAR_INPUT
   	rgb			: PTR_TO NH_RGB_COLOR;
		lvl			: REAL;
   END_VAR
   lvl := lvl * 0.01;
	rgb^.R := REAL_TO_USINT( USINT_TO_REAL(rgb^.R) * lvl );
	rgb^.G := REAL_TO_USINT( USINT_TO_REAL(rgb^.G) * lvl );
	rgb^.B := REAL_TO_USINT( USINT_TO_REAL(rgb^.B) * lvl );
END_FUNCTION

// knihovna pre zakladne funkcie PTR,OBR


FUNCTION _NhaDev {HIDDEN} : UDINT	 // vrati adresu DEV/CFG/VAZ v mRam a tiez naplni: va=SIZEOF(cf,nd) POZOR NA va PREPISUJE SA
   VAR_INPUT
      wh       : USINT;                   // 0/1/2  : CFG/PAR/VAZ
      cf       : USINT;                   // cislo cfg podla wh
      nd       : INT;                     // cislo vetry
   END_VAR
   CASE wh OF
     1 : _NhaDev := aPar[cf].Ram; va := aPar[cf].siz;
     2 : _NhaDev := aVaz[cf].Ram; va := SIZEOF(NH_VAZ);
   ELSE  _NhaDev := aCfg[cf].Ram; va := aCfg[cf].siz;
   END_CASE;
   _NhaDev  := _NhaDev + va * INT_TO_UDINT( nd - 1 );
END_FUNCTION






FUNCTION _NhxPtIOa {HIDDEN} : BOOL	    // namapuje xPtIOa := xD^.io[io]
   VAR_INPUT
		xIO	: PTR_TO NH_VAL_IO;
      c     : USINT;
		io		: UDINT;
   END_VAR
	xPtIOa		:= xIO + aCfg[c].siz - aCfg[c].me - aCfg[c].io;		// xDev^.io    (xDev + size - me - io)
	xPtIOa		:= xPtIOa + SIZEOF(NH_VAL_IO) * io;											// xDev^.io[io]
	_NhxPtIOa  := aCfg[c].io > 0;
END_FUNCTION


FUNCTION _NhxPtIO {HIDDEN} : BOOL	
   VAR_INPUT
      c    : USINT;
      n    : INT := 1 ;
      x     : INT := -1234;
   END_VAR
	xPtIO 		:= ADR(yTx3);
	_NhxPtIO 	:= false;
   IF c=0 OR n=0 OR c > _NH_CFG THEN
		;
   ELSIF n < 0 OR n > aCfg[c].rec THEN
		;
   ELSIF aCfg[c].io = 0 THEN
		;		
	ELSIF _NhxPt(c := c, n := n, x:= x) THEN
		xPtIO := xPt + 1 +
					USINT_TO_UDINT(aCfg[c].cf) +
					USINT_TO_UDINT(aCfg[c].al) +					
					aCfg[c].cx +					
					USINT_TO_UDINT(aCfg[c].hw)					
										;
		IF xPtIO^.dev.c > 0 AND xPtIO^.dev.n > 0 THEN
			_NhxPtIO := true;
		ELSE

		END_IF;
	END_IF;
END_FUNCTION

FUNCTION _NhxDev {HIDDEN} : BOOL	
   VAR_INPUT
      c    : USINT;
      n    : INT := 1 ;
      x     : INT;
//      r     : INT;
   END_VAR
   _NhxDev  := _NhxPt(c := c, n := n, x:= x);
   xDev     := xPt;
END_FUNCTION

FUNCTION _NhxDev2 {HIDDEN} : BOOL	    // namapuje xDev,xCfg
   VAR_INPUT
      c    : USINT;
      n    : INT := 1 ;
      x     : INT;
//      r     : INT;
   END_VAR
   _NhxDev2 := _NhxPt(c := c, n := n, x:= x);
   xDev2     := xPt;
END_FUNCTION

FUNCTION _NhxRom {HIDDEN} : BOOL	    // namapuje xDev,xCfg
   VAR_INPUT
      c    : USINT := 1;
      nr    : USINT;
      x     : INT;
   END_VAR
   _NhxRom  := _NhxPt(c := c, n := USINT_TO_INT(nr), x:= x);
	IF nr = 0 THEN
		IF c = 1 THEN
			nr := _NhDefRom;
		ELSE
			nr := 1;
		END_IF;
	   _NhxRom  := _NhxPt(c := c, n := USINT_TO_INT(nr), x:= x);
	END_IF;
   xRom     := xPt;
END_FUNCTION




FUNCTION _NhxRoW  {HIDDEN}  :BOOL   // xRoW namapuje na Rom[nbr] alebo zon[nbr]
   VAR_INPUT
      zon   : BOOL;              // zona/rom
      nbr   : USINT;             // cislo zony/rom
   END_VAR
	VAR
		sPtr	: UDINT;
	END_VAR
   sPtr  := USINT_TO_UDINT( nbr-1 ) * SIZEOF(NH_WRK_ROM);
   IF zon THEN
      xRoW  :=  xHoW + sPtr;
   ELSE
      xRoW  :=  xRoW1 + sPtr;
   END_IF;
	_NhxRoW := true;
END_FUNCTION

FUNCTION _NhxZon {HIDDEN} : BOOL	    // namapuje xZon aj xZoW
   VAR_INPUT
      c   	: USINT := 3;
      nz    : USINT;
      x     : INT;
   END_VAR
   _NhxZon  := _NhxPt(c := c, n := USINT_TO_INT(nz), x:= x);
   xZon     := xPt;
   xZoW  	:= xHoW + ( USINT_TO_UDINT( nz-1 ) * SIZEOF(NH_WRK_ROM) ) ;
END_FUNCTION


FUNCTION _NhxPir {HIDDEN} : BOOL	    // namapuje xRom, odkial je PIR
   VAR_INPUT
      n    	: INT;     // veta PIR
      x     : INT;
   END_VAR
   _NhxPir  := false;
   IF _NhxPt(c := 15, n := n, x:=x) THEN
      IF xPt^.cf.rom > 0 THEN
         IF _NhxRom(c := 1, nr := xPt^.cf.rom, x:=x) THEN
            _NhxPir  := true;
         END_IF;
      END_IF;
   END_IF;
END_FUNCTION

FUNCTION _NhxPtU {HIDDEN} : BOOL	    // namapuje xRom,xZon a ich docasne pamate
   VAR_INPUT
      c    : USINT;
      n    : USINT;
      x    : INT;
   END_VAR
   _NhxPtU := _NhxPt(c := c, n := USINT_TO_INT(n), x:=x );
END_FUNCTION

FUNCTION _NhxPar  {HIDDEN}    : BOOL	    // namapuje xPar
   VAR_INPUT
		err	: BOOL := true;
      cp    : USINT;
      np    : INT := 1;
		cf		: USINT;
      nd    : INT := -1;
      x     : INT;
   END_VAR
   IF cp=0 OR np=0  THEN
      _NhxPar      := false;
      aSys.ErrPar  := aSys.ErrPar + 1;
      aSys.ErrPt   := aSys.ErrPt + 1;
		IF err THEN
	      yTx2        := CONCAT('Err: _NhxPar: cp:',USINT_TO_STRINGF(cp,'%3d'),'; np:',INT_TO_STRINGF(np,'%4d'),'; cf:',USINT_TO_STRINGF(cf,'%3d'),'; nd:',INT_TO_STRINGF(nd,'%5d'),'; x:',INT_TO_STRINGF(x,'%5d') );
   	   rb          := _Nh1RowTxt(logRst := 1, adTime := 3);
		END_IF;
   ELSE
      xPar     := ADR( mRam[ aPar[cp].Ram + aPar[cp].siz * INT_TO_UDINT( np - 1 )]);   // + USINT_TO_UDINT(aPar[cp].siz) * INT_TO_UDINT( np - 1 );
      _NhxPar  := xPar^.ok.OK = true AND aPar[cp].rec >= np;
   END_IF;
END_FUNCTION

FUNCTION _NhxPar2 {HIDDEN} : BOOL	    // namapuje xPar2
   VAR_INPUT
      cp    : USINT;
      np    : INT := 1;
		cf		: USINT;
      nd    : INT := -1;
      x     : INT;
   END_VAR
   IF cp=0 OR np=0 THEN
      _NhxPar2      := false;
      aSys.ErrPar  := aSys.ErrPar + 1;
      aSys.ErrPt   := aSys.ErrPt + 1;
      yTx2        := CONCAT('Err: _NhxPar2: cp:',USINT_TO_STRINGF(cp,'%3d'),'; np:',INT_TO_STRINGF(np,'%4d'),'; cf:',USINT_TO_STRINGF(cf,'%3d'),'; nd:',INT_TO_STRINGF(nd,'%5d'),'; x:',INT_TO_STRINGF(x,'%4d') );
      rb          := _Nh1RowTxt(logRst := 1, adTime := 3);
   ELSE
      xPar2     := ADR( mRam[ aPar[cp].Ram + aPar[cp].siz * INT_TO_UDINT( np - 1 )]);   // + USINT_TO_UDINT(aPar[cp].siz) * INT_TO_UDINT( np - 1 );
      _NhxPar2  := xPar2^.ok.OK = true AND aPar[cp].rec >= np;
   END_IF;
(*
   xPar2     := ADR( mRam[ aPar[cp].Ram + aPar[cp].siz * INT_TO_UINT( np - 1 )]);   // + USINT_TO_UDINT(aPar[cp].siz) * INT_TO_UDINT( np - 1 );
   _NhxPar2  := xPar2^.ok.OK = true AND aPar[cp].rec >= np;
*)
END_FUNCTION

FUNCTION _NhxCfg {HIDDEN}   : BOOL	                                 // namapuje xDev,xCfg a pripadne aj par
   VAR_INPUT
      par   : BOOL;                                               // namapuje aj parameter ak existuje
      c    	: USINT;
      n    	: INT := 1 ;
      p    	: INT := 1;
      x     : INT;
   END_VAR
	IF c = 2 THEN
		_NhxCfg := false;
		RETURN;
	END_IF;
   IF _NhxDev(c := c, n := n, x:=x) THEN                                   // xDev
      xCfx           := xDev + 1 + SIZEOF(NH_CFG_ALL) + USINT_TO_UDINT(aCfg[c].al);
//      xCfx     := xCfg     + USINT_TO_UDINT(aCfg[cf].cf);                // user CFG
      IF par AND aCfg[c].par > 0 THEN                               // parameter existuje
         IF p = 0 THEN
            p := xDev^.cf.par;                                         // podhodi sa default par
         END_IF;
			IF x=0 THEN
				x:= 110;
			END_IF
         rb := _NhxPar(cp := aCfg[c].par, np := p,x:=-321  );                     // xPar

      END_IF;
      _NhxCfg  := true ;
   ELSE
      _NhxCfg  := false ;
   END_IF;
END_FUNCTION

FUNCTION _NhxCfg2 {HIDDEN} : BOOL	                                 // namapuje xDev,xCfg a pripadne aj par
   VAR_INPUT
      par   : BOOL;                                               // namapuje aj parameter ak existuje
      c    : USINT;
      n    : INT := 1 ;
      p    : INT := 1;
      x     : INT;
   END_VAR
   x:=1;
	IF c = 2 THEN
		_NhxCfg2 := false;
		RETURN;
	END_IF;
   IF _NhxDev2(c := c, n := n, x:=-22) THEN                                   // xDev
      xCfx2     := xDev2 + 1 + SIZEOF(NH_CFG_ALL) + USINT_TO_UDINT(aCfg[c].al); //SIZEOF(NH_DEV_ALL);
//      xCfx2     := xCfg2     + USINT_TO_UDINT(aCfg[cf].cf);                // user CFG
      IF par AND aCfg[c].par > 0 THEN
         IF p = 0 THEN
            p := xDev2^.cf.par;                                         // podhodi sa default par
         END_IF;
//         _NhxPar2(cp := aCfg[c].par, np := p ,x:=x);                     // xPar
         _NhxPar2(cp := aCfg[c].par, np := p ,x:=-543);                     // xPar
      END_IF;
      _NhxCfg2  := true ;
   ELSE
      _NhxCfg2  := false ;
   END_IF;
END_FUNCTION

FUNCTION _NhxVaz {HIDDEN} : BOOL	    // namapuje xVaz
   VAR_INPUT
		ok		: BOOL;      				// vrati true aj vtedy, ked je najdena veta  DEL
      cv    : USINT;                // aVaz[cv]
      nd    : INT := 1 ;
   END_VAR
   IF nd <= aVaz[cv].rec THEN
      xVaz     := ADR( mRam[ aVaz[cv].Ram ]) + ( SIZEOF(NH_VAZ) * INT_TO_UDINT( nd - 1 ) );
      _NhxVaz  := xVaz^.ok.ok OR ok;
   ELSE
      _NhxVaz  := false;
   END_IF;
END_FUNCTION

FUNCTION _NhxUsr {HIDDEN} : BOOL	    // namapuje xDev,xCfg
   VAR_INPUT
      u    : USINT := 1 ;
   END_VAR
   _NhxUsr := _NhxPt(c := 22, n := USINT_TO_INT(u),x:=1) AND aCfg[22].rec > 0;
   xUsr     := xPt;
END_FUNCTION



FUNCTION _NhName {HIDDEN} : BOOL	    // nacita alebo zapise Name, Name2 d DEV
   VAR_INPUT
      write       : BOOL;
      Name2       : BOOL;
      cf          : USINT;
      nd          : INT;
      xName       : PTR_TO STRING;
   END_VAR
   VAR_TEMP
      xDev        : PTR_TO NH_RGB;
//      xCfg        : PTR_TO NH_CFG_ALL;
   END_VAR
   _NhName  := true;

   IF cf = 0 OR nd = 0 THEN
      xName^ := '_NhName: error';
      RETURN;
//	ELSIF cf = 2 THEN
//      xName^ := '_NhName: cf:=2 err';
//      RETURN;
   END_IF;

   xDev     := ADR( mRam[ aCfg[cf].Ram + aCfg[cf].siz * INT_TO_UDINT( nd - 1 )]); // + ( USINT_TO_UDINT(aCfg[cf].siz) * INT_TO_UDINT( nd - 1 ) );
   IF write THEN
      IF Name2 THEN
         ;
      ELSE
         xDev^.cf.Name := xName^;
      END_IF;
      xDev^.ok.ok := true;                      // pre istotu oznaci vetu ako platnu

   ELSIF Name2 THEN
   ELSE  xName^ := xDev^.cf.Name;
   END_IF;
END_FUNCTION

FUNCTION _Nh_254_TO_100 {HIDDEN}  : USINT       // skoriguje lvl z 254 -> 100%
   VAR_INPUT
      lvl      : USINT;                         // max.uroven
      L100     : USINT := 254;                   // max.uroven
   END_VAR
   IF L100 > 0 THEN
      _Nh_254_TO_100 := REAL_TO_USINT(USINT_TO_REAL(lvl)/(USINT_TO_REAL(L100)*0.01));
   ELSE
      _Nh_254_TO_100 := 0;
   END_IF;
END_FUNCTION


FUNCTION _Nh_RGB_LVL {HIDDEN}  : BOOL               // koriguje RGB zlozky z xSrc o lvl a ulozi ich do xDst
   VAR_INPUT
      lvl     : USINT;                          // uroven
      xSrc    : PTR_TO USINT;                   // zdroje (nekorigovane zlozky RGB)
      xDst    : PTR_TO USINT;                   // kam sa maju ulozit lvl RGB korigovane o jas
   END_VAR
   _Nh_RGB_LVL := true;
   FOR ii := 0 TO 2 DO
      vr    := (USINT_TO_REAL(xSrc^)/100.0 * USINT_TO_REAL(lvl) ); // / 2.55 ;
      xDst^ := REAL_TO_USINT(MAX(0.,MIN(vr,255.)));
      xDst  := xDst + 1;
      xSrc  := xSrc + 1;
   END_FOR;
END_FUNCTION

FUNCTION _NhSrtVaz {HIDDEN} : BOOL  // nastavi aktualne zobrazenie pre usra do menu[2], xL^.dsh
   VAR_INPUT
      vaz   : USINT;          // cislo vazieb
      poz   : INT;            // veta kam chceme umiestniet
      new   : INT;            // kde je momentalne pridana
   END_VAR
   VAR_TEMP
     	nw     	: UDINT;
//		rj			: UDINT;
//		va			: UDINT;
   END_VAR
   _NhSrtVaz := true;
   IF poz = new THEN                                                                         // veta s trafila za kopirovanu vetu
      RETURN;
   END_IF;

//	{ $ IF CPU_CODE = 2000} 	                                                               // pre odkladanie kopirovaneho bloku sa pouzije rychla RAM

//	{ $ ELSE } 	

      IF new > poz THEN                                                                      // nova veta je za pozadovanou poziciou
         rj    :=  INT_TO_UDINT(new-poz)*SIZEOF(NH_VAZ);                                      // vekost kopirovnych viet
         va    :=  aVaz[vaz].ram + INT_TO_UDINT(poz-1)*SIZEOF(NH_VAZ);                        // zaciatok bloku viet, ktore sa maju presuvat
         nw    :=  va + SIZEOF(NH_VAZ);                                                      // kam sa maju nakopirovat presuvane vety
      ELSE
         poz   :=  poz - 1;                                                                  // kopiruje sa na vetu, ktora je kopirovna
         rj    :=  INT_TO_UDINT(poz-new)*SIZEOF(NH_VAZ);                                      // vekost kopirovnych viet
         va    :=  aVaz[vaz].ram + INT_TO_UDINT(new)*SIZEOF(NH_VAZ);                          // zaciatok bloku viet, ktore sa maju presuvat - za pridanu vetu
         nw    :=  va - SIZEOF(NH_VAZ);                                                      // kam sa maju nakopirovat presuvane vety
      END_IF;
      IF _NH_RAM - aDbx.vRam >= rj THEN                                                      // ochrana prednedostatkom pamate
         // do volnej pamati sa odlozia zaznamy, ktore sa maju presuvat
         MemCpyEx(length := rj, source := VOID(mRam[va]), dest := VOID( mRam[ aDbx.vRam ] ) );
         // odlozene zaznamy sa presunu spat, ale na novu adresu
         MemCpyEX(length := rj, source := VOID( mRam[ aDbx.vRam ] ), dest := VOID(mRam[nw]));
         // na ziadanu poziciu sa nakopiruju data odlozenej vety
         MemCpyEX(length := SIZEOF(NH_VAZ), source := VOID( yVaz ), dest := VOID( mRam[ aVaz[vaz].ram + INT_TO_UDINT(poz-1)*SIZEOF(NH_VAZ) ]) );
      ELSE
         // error sprava
         aSys.Err_vSrt := rj - (_NH_RAM - aDbx.vRam);
      END_IF;

//	{ $ END_IF } 	

END_FUNCTION





FUNCTION _NhTecoDT {HIDDEN}: BOOL      // do DT1 vlozi akt.cas a pripadne prida cas z DT2. Vynuluje sec.
   VAR_INPUT
      xtDT1   : PTR_TO TTECOdatetime;
      xtDT2   : PTR_TO TTECOdatetime;
      what    : USINT;                 // 0=len vlozi aktualny cas,1=+pripocita Dt2
   END_VAR
   VAR_TEMP
      xPt1    : PTR_TO USINT;
      xPt2    : PTR_TO USINT;
      i       : USINT;
   END_VAR;
   _NhTecoDT   := true;
   xtDT1^      := _etTDT;                 // vycisti
   CASE what OF
     0 : ;                                                     // len vymaze
     1 : xtDT1^   := DT_TO_TecoDT(GetDateTime());              // zapise datum/hod:min, zbytok vymaze

     2 : // prida cas                                          // + prida z DT2
         xtDT1^   := DT_TO_TecoDT(GetDateTime());
         xPt1     := xtDT1;
         xPt2     := xtDT2;
         FOR i := 1 TO 5  DO
            xPt1^ := xPt1^ + xPt2^;
            xPt1 := xPt1 + 1;
            xPt2 := xPt2 + 1;
         END_FOR;

     3 : xtDT1^   := DT_TO_TecoDT(GetDateTime());              // koniec dnesneho dna zapise datum/hod:min, zbytok vymaze
         xtDT1^.hour :=  23;
         xtDT1^.min  :=  59;
         xtDT1^.sec  :=  59;
         RETURN;

   END_CASE;
   xtDT1^.sec := 0;
   xtDT1^.milisec := 0;

//   _NhTecoDT := SUB_DT_DT(TecoDT_TO_DT(xtDT2^),GetDateTime());
//   xtDT2^.milisec := TIME_TO_UINT(_NhTecoDT);
END_FUNCTION


FUNCTION _NhWrkRam  {HIDDEN}  : BOOL	
   // vytvori 1 adresu WRK pamate pre browsery

   // tu treba kontrolu na prekrocenie aDbx.vRam limitu UINT 65536
   // zaciatok wrk pamate - 1.veta zony[1] - CAT co do nej patria
   aSys.aRoW1     := aDbx.vRam + 1;                      // adresa  1.vety wrk-rom
   xRoW1          := ADR(mRam[aSys.aRoW1]);              // pointer 1.vety wrk rom
   aSys.sRoW      := INT_TO_UDINT(aCfg[1].rec) * SIZEOF(NH_WRK_ROM);

   aSys.aZoW1     := aSys.aRoW1 + aSys.sRoW;
   xHoW          	:= ADR(mRam[aSys.aZoW1]);     			// domcek
//	xZoW1          := xHoW;											// na zaciatku je domovska zona pre subjekt rovnaka
   aSys.sZoW      := INT_TO_UDINT(aCfg[3].rec) * SIZEOF(NH_WRK_ROM);

   // pre data browsu
   aSys.vIx1      := aSys.aZoW1 + aSys.sZoW;;                             // za poslednou vetou poslednej sady vazieb zacina WRK zona, kde sa budu vytvarat indexy browsu
   aSys.vIx2      := aSys.vIx1 + 10 * SIZEOF(NH_IDX);    // velmi predbezne rezervuje 10 viet na vsetky browsy. pri kazdom agregovani udajov sa zadava maximum

	memsetEx(val := 0, length := _NH_RAM - aSys.aRoW1-1, dest := VOID( mRam[aSys.aRoW1] ));

   // tieto adresy sa nemenia
	xTx1     := ADR(yTx1);
   _NhxPt(c:= 3, n := 1, x:=2);      						// treba namapovat home pre subjekt !!!!
	xHoM  	:= xPt;                              		// cely dom
	xZOu		:= xHoM + SIZEOF(NH_ROM);			         // Vonkajsia zona

   _NhxPt(c:=25, n := 1,ok:=true, x:=-222);      						// treba namapovat globalnu CFG
	xGlb  	:= xPt;                              		// cely dom

   aSys.RefCycNew := true;
END_FUNCTION



FUNCTION _NhGetCFG {HIDDEN} : USINT    		// vrati cislo riadka v CFG
	VAR_INPUT
		cfg		: STRING[3];
	END_VAR
   _NhGetCFG := 1;
   WHILE _NhGetCFG <= _Nh_CFG DO
		IF aCfg[_NhGetCFG].cfg = cfg THEN
         RETURN;
      END_IF;
      _NhGetCFG := _NhGetCFG + 1;
   END_WHILE;
   _NhGetCFG := 0;
END_FUNCTION


FUNCTION _NhCpyRec {HIDDEN} : BOOL	 // prekopiruje data CFG/PAR,.... zo zdrojovej vety do cielovej
   VAR_INPUT
      wh       : USINT;                   // 0/1/2  : CFG/PAR/VAZ
      cf       : USINT;                   // cislo cfg podla wh
      ns       : INT;                     // cislo vety - source
      nd       : INT;                     // cislo vety - destination
   END_VAR
   VAR_TEMP
      vs       : UDINT;                    // adresa mRam Source
      vd       : UDINT;
   END_VAR
   vs := _NhaDev(wh := wh, cf := cf, nd := ns);    // !!! POZOR NA va (teraz je v nej velkost zaznamu) PREPISUJE SA
   vd := _NhaDev(wh := wh, cf := cf, nd := nd);
   IF vs <> vd THEN                       // kontrola ci to nie je ta ista veta
      MemCpyEx(length := va, source := VOID(mRam[ vs ]),  dest := VOID( mRam[ vd ] ) );
   END_IF;
   _NhCpyRec := TRUE;
END_FUNCTION


FUNCTION _Nh_Go_MemToDBX    : BOOL    		// ulozi do dbx celu RAM alebo len DBX
	VAR_INPUT
		DBX	: BOOL;
	END_VAR
	IF DBX OR aSys.UseRBx = false THEN
	   _Nh_Go_MemToDBX	:= WriteToDBx( dataBoxAddress := aDbx.ver.Dbx0, length := MIN(aSys.Size_DBx,aDbx.vRam), varAddress := PTR_TO_UDINT(ADR(mRam)) ) ;		
	   aSys.nMemToDbx    := aSys.nMemToDbx + 1;
	ELSE //aSys.UseRBxTHEN
   	_Nh_Go_MemToDBX	:= WriteToRBx ( ramBoxAddress := aDbx.ver.Dbx0, length := aDbx.vRam, varAddress := PTR_TO_UDINT(ADR(mRam)) ) ;
	   aSys.nMemToRBx    := aSys.nMemToRBx + 1;
	END_IF;
   aSys.CfgDbxOk  	:= true;
   aSys.UpdDbx      	:= 0;
END_FUNCTION


FUNCTION_BLOCK _Nh_Cfg_Backup		// backup MEM/RAM/DBX -> File or Restore File -> MEM/RAM/DBX
	VAR_INPUT
//      WhatDo      : USINT;			// cim sa nastartovalo = co sa ma robit
		Go				: USINT;				
		IniEnd		: USINT;
		IniErr		: USINT;
		IniRun		: USINT;	//:=255;
//		Init			: BOOL;
		SaveMem		: BOOL;
		logRst		: BOOL := true;	// loguje akciu do _NhRest,LOG
	END_VAR                        	
	VAR_OUTPUT
		Err			: BOOL;	
		Exec			: BOOL;
		Done			: BOOL;
		busy			: BOOL;
		toFile		: BOOL;
	END_VAR
	VAR
		fbCfgRW		: _Nh_File_RW;
//		yDbx1	      : NH_DBX;                                // hlavny riadiaci subor vratane organizacie DBX
//		yDbx2	      : NH_DBX;                                // hlavny riadiaci subor vratane organizacie DBX
	END_VAR
	done	:= false;		
	CASE Go OF
		0:	RETURN ;
		1:	// MEM->file
			toFile				:= true;
			xDbx					:= ADR(aDbx);
			fbCfgRW.adrVar		:= PTR_TO_UDINT(ADR(mRam));
			fbCfgRW.whatVar	:= 0;	
			fbCfgRW.size		:= xDbx^.vRam;
		2:	// RBx->file
			toFile				:= true;
//yDbx1 := aDbx;
        	IF SaveMem  THEN
           	_Nh_Go_MemToDBX();
				SaveMem	:= 0;
			END_IF;				
			ReadFromRBx(ramBoxAddress:=0, length:=SIZEOF(aDbx), varAddress:=PTR_TO_UDINT(ADR(mObr)));
			xDbx					:= ADR(mObr);
//yDbx2 := xDbx^;
			fbCfgRW.adrVar		:= 0;
			fbCfgRW.whatVar	:= 1;	
			fbCfgRW.size		:= xDbx^.vRam;
		3:	// DBX->file
			toFile				:= true;
			xDbx					:= ADR(mObr);

	     	IF SaveMem  THEN
           	_Nh_Go_MemToDBX(DBX:=true);
				SaveMem	:= 0;
			END_IF;				
			ReadFromDBx(dataBoxAddress:=0, length:=SIZEOF(aDbx), varAddress:=PTR_TO_UDINT(ADR(mObr)));
			fbCfgRW.adrVar		:= 0;
			fbCfgRW.whatVar	:= 2;	
			fbCfgRW.size		:= MIN(aSys.Size_DBx, xDbx^.vRam);	// DBX max 128*1024=131072							

	  11:	// file->MEM
			toFile				:= false;
			fbCfgRW.adrVar		:= PTR_TO_UDINT(ADR(mRam));
			fbCfgRW.whatVar	:= 0;	
	  12:	// file->RAM
			toFile				:= false;
			fbCfgRW.adrVar		:= 0;
			fbCfgRW.whatVar	:= 1;	
	  13:	// file->DBX
			toFile				:= false;
			fbCfgRW.adrVar		:= 0;
			fbCfgRW.whatVar	:= 2;	
	 255:	;
   ELSE	RETURN;
	END_CASE;
//	Go					:= 255;
	IF Go = 255 THEN  																
		;
	ELSIF toFile THEN  																// write xxx -> to file
		IF _Nh_Log_Path(wh:=3,wrk:=true,write:=true) THEN
			// yTx1	:= CONCAT(aSys.DiskHed.Disk[1].path,'dbx.wrk');    // read from dbx.mem to yTx2
			// yTx2 	:= CONCAT(aSys.ADR_DBX,DT_TO_STRINGF(aSys.NhDT,'%Thh_mm.dbx') ); // new backup file 'NH2/002/25_01_03/10_30.dbx'
			aSys.UpdFile		:= 0;
			fbCfgRW.exec:=1; fbCfgRW.mode:=1; fbCfgRW.FullFile:=0; fbCfgRW.Line:=0;;
		ELSE
			done	:= true; err	:= true;
 			yTx2 	:= CONCAT('Err write backup file {','IF _Nh_Log_Path(wh:=3,wrk:=true,write:=true) THEN}' );
		END_IF;				
	ELSIF	_Nh_Log_Path(wh:=3, mem:=true, read:=TRUE) THEN		// load last backup file from dbx.mem into yTx2
		fbCfgRW.exec:=1; fbCfgRW.mode:=0; fbCfgRW.FullFile := 1;
	ELSE
		done	:= true;  err	:= true;
		yTx2 	:= CONCAT('Err read backup file {','ELSIF	_Nh_Log_Path(wh:=3, mem:=true, read:=TRUE) THEN}');
	END_IF;	
	IF fbCfgRW.exec THEN
		err		:= false;
		Go			:= 255;
		aSys.Ini	:= IniRun;
		yTx1		:= yTx2;
	END_IF;

	fbCfgRW(fileName:=yTx1, busy=>busy, done=>done);		

	IF fbCfgRW.err THEN
		done		:= true;
		err		:= true;
	   GetLastErrTxt(errCode:=fbCfgRW.errID, errMessage := _LangTxt);
(*
		IF fbCfgRW.errID < 1000 THEN
		   GetLastErrTxt(errCode:=fbCfgRW.errID, errMessage := _LangTxt);
		ELSE
//				_Nh_LangTxt(id:=UDINT_TO_INT(fbCfgRW.errID));

		END_IF;
*)
		yTx2	:= CONCAT(
						'err: {',UDINT_TO_STRING(fbCfgRW.errID),'} msg:{',_LangTxt,'} ',
						'{',yTx1,'};{',yTx2,'}'); //{',USINT_TO_STRING(WhatDo),'}');
	END_IF;
   IF done THEN
		aSys.Ini			:= IniEnd;
  		CASE fbCfgRW.whatVar OF							// start Function
			0:	yTx3 := 'MEM';
			1:	yTx3 := 'RBx';
			2:	yTx3 := 'DBX';
  		ELSE	yTx3 := '???';
  		END_CASE;
		IF err THEN
			aSys.Ini			:= IniErr;
		ELSIF toFile THEN
			rb := _Nh_Log_Path(wh:=3,read:=TRUE);							// rename dbx.wrk -> dbx.mem, and load actual backup into yTx2 from .mem
 			yTx2 	:= CONCAT('New Bakup {',yTx3,'}->{',yTx2,'}' );
		ELSE
			rb 	:= _Nh_Log_Path(wh:=3, mem:=true,read:=TRUE);					     		
 			yTx2 	:= CONCAT('Restore {',yTx2,'}->{',yTx3,'}' );
		END_IF;
		IF logRst THEN
 			yTx2 	:= CONCAT(yTx2,'{',UDINT_TO_STRING(fbCfgRW.adrVar),'}{',UDINT_TO_STRING(fbCfgRW.actSize),'}');		
   		rb  	:= _Nh1RowTxt(logRst:=1,adTime:=3);
		END_IF;	
		Go 				:= 0;
		IniEnd			:= 0;
		IniErr			:= 0;
		IniRun			:= 0;
		logRst			:= true;	
		err				:= 0;
		SaveMem			:= 0;
		fbCfgRW(fileName:=yTx1, busy=>busy, done=>done);				// len abu sa resertli busy,done
	END_IF;
END_FUNCTION_BLOCK



(*
FUNCTION_BLOCK _Nh_Cfg_Backup		// backup MEM/RAM/DBX -> File or Restore File -> MEM/RAM/DBX
	VAR_INPUT
      WhatDo      : USINT;			// cim sa nastartovalo = co sa ma robit
		IniEnd		: USINT;
		IniErr		: USINT;
		IniRun		: USINT;	//:=255;
//		Init			: BOOL;
		SaveMem		: BOOL;
		logRst		: BOOL := true;	// loguje akciu do _NhRest,LOG
	END_VAR                        	
	VAR_OUTPUT
		Done			: BOOL;
		busy			: BOOL;
	END_VAR
	VAR
		fbCfgRW		: _Nh_File_RW;
		Go				: USINT;				// 0:Nic, 1:MEM->SCD, 2:SCD->MEM, 3:RAM->SCD; 4: SDC->RAM, 5:DBX->SCD, 6: SDC->DBX
	END_VAR
	done	:= false;		
	CASE Go OF
      0:	CASE WhatDo OF																			// start Function
				0:	
            	RETURN ;
				1:	// MEM->file
					xDbx	:= ADR(aDbx);
//					fbCfgRW.adrVar		:= PTR_TO_UDINT(ADR(mRam));
//					fbCfgRW.whatVar	:= 0;	
				2:	// RBx->file
					xDbx	:= ADR(mObr);
	           	IF SaveMem  THEN
   	           	_Nh_Go_MemToDBX();
					END_IF;				
					ReadFromRBx(ramBoxAddress:=0, length:=SIZEOF(aDbx), varAddress:=PTR_TO_UDINT(ADR(mObr)));
//					fbCfgRW.adrVar		:= 0;
//					fbCfgRW.whatVar	:= 1;	
				3:	// DBX->file
					xDbx	:= ADR(mObr);
	           	IF SaveMem  THEN
   	           	_Nh_Go_MemToDBX();
					END_IF;				
					ReadFromDBx(dataBoxAddress:=0, length:=SIZEOF(aDbx), varAddress:=PTR_TO_UDINT(ADR(mObr)));
//					fbCfgRW.adrVar		:= 0;
//					fbCfgRW.whatVar	:= 2;	

	  		  11:	// file->MEM
//					fbCfgRW.adrVar		:= PTR_TO_UDINT(ADR(mRam));
//					fbCfgRW.whatVar	:= 0;	
	  		  12:	// file->RAM
//					fbCfgRW.adrVar		:= 0;
//					fbCfgRW.whatVar	:= 1;	
	  		  13:	// file->DBX
//					fbCfgRW.adrVar		:= 0;
//					fbCfgRW.whatVar	:= 2;	
   		ELSE	RETURN;
   		END_CASE;
			SaveMem			:= false;
			Go					:= 255;
			IF WhatDo < 11 THEN  																// write xxx -> to file
				IF _Nh_Log_Path(wh:=1,fn:='DBX',read:=true) THEN
					aSys.UpdFile	:= 0;
					// yTx1 := file with actual backup path {NH2/200/dbx.DIR}.
					// yTx2 .. path from file {NH2/200/DBX/25_02_13/}
					_Nh_Log_Path(wh:=3,wrk:=true,write:=true);
					yTx1 := yTx2;
					fbCfgRW.size			:= xDbx^.vRam;
					IF WhatDo = 3 THEN
						fbCfgRW.size			:= MIN(aSys.Size_DBx, xDbx^.vRam);	// DBX max 128*1024=131072							
					END_IF;
					fbCfgRW(init:=1, exec:=1, mode:=1, whatVar:=WhatDo-1, fileName:=yTx1);
				ELSE
					Go	:= 199;
				END_IF;				
			ELSE
				IF _Nh_Log_Path(wh:=3, mem:=true, read:=TRUE) THEN		// load last backup file from dbx.mem into yTx2
					yTx1						:= yTx2;
					fbCfgRW.mode			:= 0;			
					fbCfgRW.FullFile		:= true;           	// full file from SDC
					fbCfgRW.whatVar		:= WhatDo -11;	
				ELSE
					Go	:= 99;
				END_IF;
			END_IF;	
			IF Go = 99 THEN
				RETURN;
			ELSIF WhatDo = 1 OR WhatDo = 11 THEN
				fbCfgRW.adrVar	:= PTR_TO_UDINT(ADR(mRam));
			ELSE
				fbCfgRW.adrVar	:= 0;
			END_IF;			
			fbCfgRW.exec	:= true;
			aSys.Ini			:= IniRun;											// this section just blocks other function

     99:	// End
//			fbCfgRW.exec	:= false;
			IF fbCfgRW.Err THEN
				aSys.Ini			:= IniErr;
			ELSE
				aSys.Ini			:= IniEnd;
			END_IF;
			Go					:= 0;
			WhatDo 			:= 0;
			IniEnd			:= 0;
			IniErr			:= 0;
			IniRun			:= 0;
			logRst			:= true;	

    199:	// Err
			aSys.Ini			:= IniErr;
			Go					:= 0;
			WhatDo 			:= 0;

    255:	// running
			;
	END_CASE;

	fbCfgRW(fileName:=yTx1, busy=>busy, done=>done);		

   IF done THEN
		IF fbCfgRW.err THEN
			IF fbCfgRW.errID < 1000 THEN
			   GetLastErrTxt(errCode:=fbCfgRW.errID, errMessage := _LangTxt);
			ELSE
//				_Nh_LangTxt(id:=UDINT_TO_INT(fbCfgRW.errID));
			END_IF;
			yTx2	:= CONCAT(
						'err: {',UDINT_TO_STRING(fbCfgRW.errID),'} msg:{',_LangTxt,'} ',
						'{',yTx1,'};{',yTx2,'}{',USINT_TO_STRING(WhatDo),'}');
		ELSIF WhatDo < 10 THEN
			rb := _Nh_Log_Path(wh:=3,read:=TRUE);							// rename dbx.wrk -> dbx.mem, and load actual backup into yTx2 from .mem
     		CASE WhatDo OF							// start Function
				1:	yTx1 := 'MEM';
				2:	yTx1 := 'RBx';
				3:	yTx1 := 'DBX';
   		ELSE	yTx1 := '???';
   		END_CASE;
 			yTx2 	:= CONCAT('New Bakup {',yTx1,'}->{',yTx2,'}' );
		ELSE
			rb 	:= _Nh_Log_Path(wh:=3, mem:=true,read:=TRUE);					     		
		  CASE WhatDo OF							// start Function
	  		  11:	yTx1 := 'MEM';
	  		  12:	yTx1 := 'RBx';
	  		  13:	yTx1 := 'DBX';
   		ELSE	yTx1 := '???';
   		END_CASE;
 			yTx2 	:= CONCAT('Restore {',yTx2,'}->{',yTx1,'}' );
		END_IF;
		IF logRst THEN
 			yTx2 	:= CONCAT(yTx2,'{',UDINT_TO_STRING(fbCfgRW.adrVar),'}{',UDINT_TO_STRING(fbCfgRW.actSize),'}');		
   		rb  	:= _Nh1RowTxt(logRst:=1,adTime:=3);
		END_IF;	
		Go			:= 99;
	END_IF;
END_FUNCTION_BLOCK
*)

VAR_GLOBAL
	fbCfgBck		      : _Nh_Cfg_Backup;
	fb_RBx_To_File		: _Nh_Cfg_Backup;
END_VAR		

FUNCTION _NhSysUpd  : BOOL	
   VAR_INPUT
		fDbx	: BOOL;   			// MEM->RAM
		fFile	: BOOL;           // RAM->File
		dbx   : USINT;          // + mem
      file  : USINT;          // + file
   END_VAR
	IF aSys.UpdDbx < 255 THEN
		aSys.UpdDbx 	:= aSys.UpdDbx 	+ dbx;
	END_IF;
	IF aSys.UpdFile < 255 THEN
		aSys.UpdFile 	:= aSys.UpdFile	+ file;
	END_IF;
	IF aSys.UpdDbx > 0 OR fDbx THEN
		IF fbCfgBck.busy = false THEN		
			_Nh_Go_MemToDBX();             													// vykona MEM->RAM
		ELSE
			aSys.UpdDbx := 100;
		END_IF;
	END_IF;	
	IF aSys.UpdFile > 10 OR fFile THEN
		IF fbCfgBck.busy = false THEN
			IF aSys.IS_RBx THEN
				fbCfgBck.Go := 2;
			ELSIF aSys.IS_DBx THEN
				fbCfgBck.Go := 3;
			ELSE
				fbCfgBck.Go := 1;		
			END_IF;
			// nastartuje RAM - > File
			fbCfgBck.SaveMem:=true; fbCfgBck.IniEnd:=aSys.ini; fbCfgBck.IniErr:=0; fbCfgBck.IniRun:=0;
		END_IF;
	END_IF;	
(*
	IF (aSys.UpdFile > 10 OR fFile) AND fbCfgBck.busy = false THEN
		aSys.UpdFile	:= 0;
		i	:= 1;                                                             // MEM -> File
		IF aSys.IS_RBx THEN
			i := 2;                                         						// RAM -> File
		ELSIF aSys.IS_DBx THEN
			i := 3;                                                           // DBX -> File
		END_IF;
		fbCfgBck(init:=1 ,WhatDo:=i, IniEnd:=0, IniErr:=0, IniRun:=0);	      // nastartuje RAM - > File
	END_IF;	
*)
   _NhSysUpd 		:= true;
END_FUNCTION


FUNCTION _NhMap {HIDDEN} : BOOL	    // nmapuje xNh na vetu aCfg/aPar/aVaz, do sz vlozi velkost vety, do va virtualnu adresu a do xDev pinter 1.vety
   VAR_INPUT
		wh    : USINT;       // 0=aCfg,1=aPar,2=aVaz
      cx    : USINT;       // cislo vety cfg/par/vaz
   END_VAR
   CASE wh OF
     1 : xNh := ADR(aPar[cx]);
     2 : xNh := ADR(aVaz[cx]);
   ELSE  xNh := ADR(aCfg[cx]);
   END_CASE;
   sz     := xNh^.siz;
   va     := xNh^.ram;                                             // virtualna adresa 1.vety
   _NhMap := xNh^.Rec > 0 OR xNh^.New > 0;
END_FUNCTION

FUNCTION _NhEmpRec   {HIDDEN}  : BOOL	 // nakopiruje default (DEL) vetu NA poziciu (va) virtualnej adresy v RAM, alebo za poslednu vety aktualnej sady (volnu adresu ram)
   VAR_INPUT
      wh       : USINT;    // 0/1/2  : CFG/PAR/VAZ
      va       : UDINT;     // adresa virtualnej ram kam sa ma nakopirovat veta (va=0 : pridava sa nova veta)
   END_VAR
   VAR_TEMP
      ok    : BOOL;
   END_VAR
   IF va = 0 THEN
      ok := true;
      va := aDbx.vRam;                                         // pridava sa nova veta na volnu virtualnu pamat
   END_IF;
   xDel        := ADR(mRam[ va ]);                             // pripravi sa ptr na adresu DEL-vety
   CASE wh OF
     1 : MemCpyEx(length := sz, source := VOID(epSVD), offSource := xNh^.ofs,   dest := VOID( mRam[ va ] ) );
     2 : MemCpyEx(length := sz, source := VOID(eVAZ),                           dest := VOID( mRam[ va ] ) );
   ELSE  MemCpyEx(length := sz, source := VOID(eRom),  offSource := xNh^.ofs,   dest := VOID( mRam[ va ] ) );
   END_CASE;
   IF ok THEN
      IF xNh^.Ram = 0 THEN
         xNh^.Ram := va;                                       // ak sa pridava 1.veta, zaznaci sa adresa pre cely blok
      END_IF;
      aDbx.vRam   := aDbx.vRam + sz;           // posunie sa volna pozicia v vRam za pridanu vetu
   END_IF;
//   aSys.Upd  := aSys.Upd + 1;
   _NhEmpRec := true;
END_FUNCTION


FUNCTION _NhFindDel {HIDDEN} : int	// najde volnu DEL a vrati jej cislo, alebo prida poziadavku na novu DEL-vetu
   VAR_INPUT
      new   : BOOL := true;                           // ak nenajde, zaradi poziadavku na jednu novu vety
      ok    : BOOL := true;                           // oznaci vetu za platnu
      nOk   : BOOL;                                   // oznaci priznak v buducnosti pridanej vety ako platnu
      wh    : USINT;                                  // 0/1/2/3/4 := CFG/PAR/VAZ/POI-ROM/POI-HET
      cx    : USINT;                                  // cislo vety podla WH
      nx    : INT;                                    // ak > 0 tak tuto vetu vymaze - vlozi do nej default data
   END_VAR
   _NhMap(wh  := wh , cx := cx);
   _NhFindDel := nx;
   IF nx > xNh^.rec THEN                              // nema zaznamy, alebo sa chce vymazat veta vacsia ako aktualny pocet zaznamov
      _NhFindDel := 0;
      new        := false;                            //**-** 13.3.2021 pridane ko kontrola pri chybnom vymazani
   ELSIF nx = 0 THEN                                  // hlada sa DEL-veta
      xDel  := ADR( mRam[ va ]);                      // 1.veta v ram (va je z _NhMap)
      nx    := 1;
      WHILE nx  <= xNh^.Rec DO
         IF xDel^.ok.ok = false THEN
            _NhFindDel  := nx;
            EXIT;
         END_IF;
         xDel  := xDel  + sz;
         nx    := nx    + 1;
      END_WHILE;
   END_IF;
   IF _NhFindDel > 0 THEN
      _NhEmpRec(wh := wh, va := va + sz * INT_TO_UDINT(_NhFindDel-1) );  // vypocita virtualnu adresu vety, do ktorej vlozi DEFAULT udaj cim ju zneplatni
      xDel^.ok.ok := ok;
   ELSIF new THEN
      xNh^.new := xNh^.new + 1;
      xNh^.nOk := xNh^.nOk OR nOk;
   END_IF;
END_FUNCTION


FUNCTION _NhNewRec {HIDDEN} : BOOL	    // nakopiruje vsetky vety jedneho cfg/par/vaz z DBX do RAM a pripadne oznaci ako del, alebo vymaze RAM, aj priada nove vety
   VAR_INPUT
      wh    : USINT;             // 0-cfg,1-par,2-vaz
   END_VAR
   _NhNewRec   := true;
   WHILE xNh^.new > 0 DO                                          // prida nove vety podla .NEW
      _NhEmpRec(wh := wh);                                        // prida novu DEL-vetu na koniec aktualnej virtualnej pamate
      xDel^.ok.ok := xNh^.nOk;		/////25.8.24
(*
      IF xNh^.nOk THEN                                            // novopridana veta bude oznazena ako platna
         xDel^.ok.ok := true;
      ELSE
         ///!!! 30.1.23 pridana veta default ma byt false
         xDel^.ok.ok := false;
      END_IF;
*)
      xNh^.Rec := xNh^.Rec + 1;                                   // zvysi pocet
      xNh^.new := xNh^.new - 1;
   END_WHILE;
   xNh^.nOk := false;                                             // resetovat priznak oznacenia platnosti vety
END_FUNCTION


FUNCTION _Nh_Go_DbxToMem_CFG {HIDDEN} : BOOL	    // nakopiruje vsetky vety jedneho cfg/par/vaz z DBX do RAM a pripadne oznaci ako del, alebo vymaze RAM, aj priada nove vety
   VAR_INPUT
      del   : BOOL;              // oznaci vsetky vety ako DEL
      wh    : USINT;             // 0-cfg,1-par,2-vaz
      cx    : USINT;             // cislo vety cfg/par,vaz
   END_VAR
   VAR_TEMP
      nx    : INT;
   END_VAR
   _Nh_Go_DbxToMem_CFG  := false;
   IF _NhMap(wh  := wh , cx := cx) = false THEN
      RETURN;
   END_IF;

   // v premennych po mapovani bude :
   // va : aktualna (stara) adresa sady dat v RAM = aktualna adresa dat v DBX
   // sz : velkost jednej vety sady dat
   xNh^.Ram := aDbx.vRam;                                   // sada dat dostane novu adresu (zmena bude en ak sa predtym pridavali vety)

   IF xNh^.Rec > 0 THEN
      // z adresy DBX (aNh.Ram) nakopiruje na volnu adresu RAM (aDbx.vRam) vsetky zaznamy k CFG
      IF aSys.CfgDbxOk THEN
         _Nh_Go_DbxToMem_CFG  := true;
         // nacita sa z povodnej adresy DBX do novej adresy RAM
			IF aSys.UseRBx THEN												// CP2 pouziva sa RamBox
				ReadFromRBx( ramBoxAddress  := aDbx.ver.Dbx0 + va ,length := sz * INT_TO_UDINT( xNh^.Rec) , varAddress := PTR_TO_UDINT(ADR(mRam [ aDbx.vRam ])) );
			ELSE
				ReadFromDBx( dataBoxAddress := aDbx.ver.Dbx0 + va ,length := sz * INT_TO_UDINT( xNh^.Rec) , varAddress := PTR_TO_UDINT(ADR(mRam [ aDbx.vRam ])) );
			END_IF;
         // pripravi sa nova adresa pre dalsie sadu dat alebo pre pridanie novych viet aktualnej sady
         aDbx.vRam   := aDbx.vRam + sz * INT_TO_UDINT( xNh^.Rec) ;               // nastavi volnu adresu za blok nakopirovanych zaznamov
      END_IF;
      IF del  THEN
         va := xNh^.ram;                                          // nova virtualna adresa 1.vety
         FOR nx := 1 TO xNh^.Rec  DO
            IF del THEN
               xDel        := ADR(mRam[ va ]);                    // ptr na adresu vety (va pride z _NhMap)
               xDel^.ok.ok := false;                              // oznaci DEL
            END_IF;
            va := va + xNh^.Siz;
         END_FOR;
      END_IF;
   END_IF;
   // skontroluje poziadavky na nove vety
	_NhNewRec(wh := wh);
END_FUNCTION

FUNCTION _Nh_Go_DbxToMem   {HIDDEN}    : BOOL	    // z DBX (u CP2 z disku RAM) postupne kopiruje bloky zaznamov a prida nove vety ak treba
   // _NhDbxRam -> _NhDbxCFG -> _NhNewRec -> _NhEmpRec
   //  vyber CFG     1.cfg       + vety        def.data
   // 1. ulozi aktualnu RAM do DBX     _NhRamDBX()         ... ram=true
   // 2. naspat prikopiruje postupne  CFG/PAR/VAZ
   // 3. u kazdeho CFG/PAR/VAZ skontroluje poziadavku na novy vety, a prida ju ako DEL
   VAR_INPUT
      Ram            : BOOL;                                                 // najskor ulozi aktualnu RAM do DBX
      dbx            : BOOL ;                                                // po natiahnuti aj ulozi nove data do DBX - s pripadnymi novymi vetami
      ForceRamOk     : BOOL;                                                 // ked sa postupne naplna ram aj je priebezne ok, urcite nie pre program
   END_VAR
   VAR_TEMP
      cx    : USINT;
   END_VAR
   IF (aSys.CfgRamOk AND ram) OR ForceRamOk THEN                             // ak su v Ram platne data
      _Nh_Go_MemToDBX();                                                   	 // najskor ulozi RAM do DBX
   END_IF;
//	aSys.nDbxRam 		:= aSys.nDbxRam + 1;
   _Nh_Go_DbxToMem	:= true;
   aDbx.vRam   		:= _Ram0;                                             // zacina sa nanovo
	_NheRAM();
//   memsetEx(val := 0, length := _NH_RAM - _Ram0 - 1, dest := VOID( mRam[_Ram0] ) );// vycisti celu ram    !! DOLEZITE
	IF true THEN
      FOR  cx := 1  TO _Nh_Cfg DO
         _Nh_Go_DbxToMem_CFG(wh := 0, cx := cx);                                  // nakopiruje data 1cfg a prida prida DEL/vety
      END_FOR;
      FOR  cx := 1  TO _Nh_Par DO
         _Nh_Go_DbxToMem_CFG(wh := 1, cx := cx);                                  // nakopiruje data 1cfg a prida prida DEL/vety
      END_FOR;
      FOR  cx := 1  TO _Nh_Vaz DO                                       //// 29.5.24 - opravene - nepridavalo vazby
         _Nh_Go_DbxToMem_CFG(wh := 2, cx := cx);                                  // nakopiruje data 1cfg a prida prida DEL/vety
      END_FOR;
   END_IF;
	_NhWrkRam();																				// nastavi nove adesy WRK premennych
   IF dbx THEN
      _Nh_Go_MemToDBX() ;                                                  // na konci este raz ulozi uz novu RAM do DBX
   END_IF;
END_FUNCTION


FUNCTION _NhGetZon  {HIDDEN} : USINT //  vrati cislo zony podla zadaneho ROM
   VAR_INPUT
      Rom      : USINT;
   END_VAR
   _NhGetZon := 0;
   IF rom = 0 THEN
      ;
   ELSIF _NhxPt(c:=1, n:=USINT_TO_INT(Rom), x:=86) THEN
      _NhGetZon := xPt^.cf.Rom;
   END_IF;
END_FUNCTION

FUNCTION _NhGetDelRec  {HIDDEN} : BOOL //  do vstupnehho poitra vlozi cislo najdenej vety, vrati TRUE. Ak nenajde, prida novy zaznam, ale vrati FALSE
   VAR_INPUT
      wh       : USINT;                // 0=cfg,1=par,2=vac, 3-POI-ROM, 4:=POI-HET
      cf       : USINT;
      ptrVar   : PTR_TO INT;           // adrsa, kde ma zapisat cislo najdenej/pridanej vety
   END_VAR
   _NhGetDelRec := true;
   ptrVar^ := _NhFindDel(wh := wh, cx := cf, nx := 0, new := 1, nOk := true);
   IF ptrVar^ = 0 THEN
      ptrVar^ := xNh^.rec + 1;
      _Nh_Go_DbxToMem(ram := true, dbx := false );          // v 1.iteracii sa neuklada do dbx, lebo este sa budu zapisovat data
      _NhGetDelRec := false;
   END_IF;
(*
   WHILE true DO
      nd  :=
      IF nd > 0 THEN
         ptrVar^ := nd;
         EXIT;
      ELSE
         _NhGetDelRec := false;
         ptrVar^ := nd;
         _NhDbxRam(ram := true, dbx := false );          // v 1.iteracii sa neuklada do dbx, lebo este sa budu zapisovat data
      END_IF;
   END_WHILE;
*)
END_FUNCTION


FUNCTION _Nh_xPod_Map  {HIDDEN}  : BOOL 	// namapuje cele POI aj s FIX
   // ak nie je zadane nd, musi byt namapovane xPt
	VAR_INPUT
		cf			: usint;
		nd			: INT;
		WhtPoi	: USINT;	
	END_VAR
	IF nd > 0 THEN
   	IF _NhxPt(c := cf, n := nd, x:=-30) = false THEN      			// najde vetu
     	   yTx2 := CONCAT('Err _Nh_xPod_Map: ',USINT_TO_STRINGF(cf,'%2d'),';',INT_TO_STRINGF(nd,'%4d'),';',INT_TO_STRINGF(x,'%4d') );
      	_Nh1RowTxt(logRst:=1, adTime:=3);
			_NhxPt(c := 1, n := USINT_TO_INT(_NhDefRom),x:=-31);
   		// len aby nebola chyba
			xRom 	:= xPt;
			xPod	:= ADR(xRom^.cx.pDay);
			xFix	:= ADR(xRom^.cx.FixDay);
        _Nh_xPod_Map := false;
			RETURN;
		END_IF;
	END_IF;
	CASE cf OF
	 6 :  xHet 	:= xPt;	
			xPod 	:= ADR(xHet^.cx.pDay[ WhtPoi ]);
			_Nh_xPod_Map := xHet^.ok.ok;
   47 :  xHet 	:= xPt;	
			xPod 	:= ADR(xHet^.cx.pDay[ WhtPoi ]);
			_Nh_xPod_Map := xHet^.ok.ok;
	ELSE	xRom 	:= xPt;
   		xPod	:= ADR(xRom^.cx.pDay);
	     	xFix	:= ADR(xRom^.cx.FixDay);
   	  	_Nh_xPod_Map := xRom^.ok.ok;
	END_CASE;
END_FUNCTION


FUNCTION _Nh_Poi_Obr {HIDDEN} : INT // z POI vycita obrazok/interval/cas do najblizsej zmeny
   VAR_INPUT
      wh       : SINT;         // co vrati: 0=cislo obrazka, 1=cislo indexu (intervalu),kde sa momentalne nachadzame,2=cas do najblizsej zmeny  (MIN)
      nd       : INT;          // cislo vety POI aCfg[26]
   END_VAR
   IF _NhxDev2(c := 26, n := nd ,x:=-3) THEN
		xArP  := xDev2+1;                                        // preskocit na POI_DAT
      nd    := 0;
      WHILE _Nh_Poi_Obr < 8 AND xArp^.p[_Nh_Poi_Obr].t > -1  DO
         IF aSys.dMin = xArp^.p[_Nh_Poi_Obr].t THEN                      // sme presne na bode
            nd := 1;
            EXIT;
         ELSIF xArp^.p[ _Nh_Poi_Obr ].t > aSys.dMin  THEN           // bod je za aktualnym casom
            EXIT;
         END_IF;
         _Nh_Poi_Obr := _Nh_Poi_Obr + 1;
      END_WHILE;
      CASE wh OF
        0 : IF nd = 0 THEN
               _Nh_Poi_Obr := SINT_TO_INT(xArp^.p[_Nh_Poi_Obr-1].o);                                    // vrati cislo obrazka
            ELSE
               _Nh_Poi_Obr := SINT_TO_INT(xArp^.p[_Nh_Poi_Obr].o);                                    // vrati cislo obrazka
            END_IF;
        2 : IF _Nh_Poi_Obr = 0 OR _Nh_Poi_Obr = 8 THEN                                  // nahodou je na hraniciiach 0/24h
               ;
            ELSIF xArp^.p[_Nh_Poi_Obr].t > -1 THEN                                    // vyssi bod ma cas
               IF xArp^.p[_Nh_Poi_Obr].o <> xArp^.p[_Nh_Poi_Obr-1].o THEN               // vyssi bod ma zmenu obrazka
                  _Nh_Poi_Obr := xArp^.p[_Nh_Poi_Obr].t - aSys.dMin;                     // cas do najblizsej zmenu
               ELSIF xArp^.p[2].t = -1 THEN                                         // je len jeden interval,[0..1], v bode 2=-1 => nikdy nebude zmena
                  _Nh_Poi_Obr := 0;
               ELSE                                                                 // prechod na dalsi den = pokus
                  // prechod na dalsi den
                  wh := xArp^.p[_Nh_Poi_Obr].o;                                       // zapamata si obrazok
                  _Nh_Poi_Obr := 0;
                  WHILE _Nh_Poi_Obr < 8 AND xArp^.p[_Nh_Poi_Obr].t > -1  DO
                     IF xArp^.p[_Nh_Poi_Obr].o <> wh THEN                      // sme presne na bode
                        _Nh_Poi_Obr := 1440 - aSys.dMin + xArp^.p[_Nh_Poi_Obr].t;
                        RETURN;
                     END_IF;
                     _Nh_Poi_Obr := _Nh_Poi_Obr + 1;
                  END_WHILE;
                  _Nh_Poi_Obr := 0;
               END_IF;
            END_IF;
      END_CASE;
   END_IF;
END_FUNCTION


(*
FUNCTION _Nh_EndDT   : DT      //
   VAR_INPUT
      wht         : USINT;                   // 0= 1=na konci dna
      xTdt        : PTR_TO TTecoDateTime;
      tMin        : UINT;                     // pocet minut na pripocitanie
         x        : USINT;
   END_VAR
   CASE wht OF
      0 :   // pripocitat HH:MM z TTecoDateTime
(*
            _Nh_EndDT := ADD_DT_TIME(in1 := aSys.NhDT, in2 := LREAL_TO_TIME(
                   (  USINT_TO_LREAL(xTdt^.hour) * 60.0 +
                     USINT_TO_LREAL(xTdt^.min)) * 60000.0 ));

            _Nh_EndDT := ADD_DT_TIME(in1 := aSys.NhDT, in2 := T#1h * xTdt^.hour + T#1m * xTdt^.min);
      1 :   // pripocitat DD:HH:MM z TTecoDateTime
            _Nh_EndDT := ADD_DT_TIME(in1 := aSys.NhDT, in2 := T#1d * xTdt^.Day + T#1h * xTdt^.hour + T#1m * xTdt^.min);
      2 :   // na konci dna
            _Nh_EndDT := ADD_DT_TIME(in1 := DATE_TO_DT(aSys.NhDate), in2 := T#24h );      // DATE_TO_DT vytvpri dnesny datum, kde mudu HH:MM:SS = 0
      3 :   // den v tyzdni
            IF SYSTEM_S.COUNTER_DAYS_OF_WEEK < xTdt^.Day THEN
               x := xTdt^.Day - SYSTEM_S.COUNTER_DAYS_OF_WEEK;
               _Nh_EndDT := ADD_DT_TIME(in1 := DATE_TO_DT(aSys.NhDate), in2 := T#1d * x + T#1h * xTdt^.hour + T#1m * xTdt^.min);
            ELSIF SYSTEM_S.COUNTER_DAYS_OF_WEEK = xTdt^.Day
                  AND aSys.NhTime < T#1h * xTdt^.hour + T#1m * xTdt^.min
                  THEN
               _Nh_EndDT := ADD_DT_TIME(in1 := DATE_TO_DT(aSys.NhDate), in2 := T#1h * xTdt^.hour + T#1m * xTdt^.min);
            ELSE
               x := 7-SYSTEM_S.COUNTER_DAYS_OF_WEEK + xTdt^.Day ;   // (Ned-Stv) + Str := 7-4 + 3  =
               _Nh_EndDT := ADD_DT_TIME(in1 := DATE_TO_DT(aSys.NhDate), in2 := T#1d * x + T#1h * xTdt^.hour + T#1m * xTdt^.min);
//               _Nh_EndDT := ADD_DT_TIME(in1 := aSys.NhDT, in2 := SUB_TIME(T#24h,aSys.NhTime));
            END_IF;
     100:   // pripocitat tMin k aktualnemu casu
            _Nh_EndDT := ADD_DT_TIME(in1 := aSys.NhDT, in2 := LREAL_TO_TIME( UINT_TO_LREAL(tMin) * 60000.0 ) );
   END_CASE;
END_FUNCTION
*)

FUNCTION _Nh_Fix_TME_TO_DT {HIDDEN}  : DT      //
   VAR_INPUT
		wht		:  USINT;
      fix      :  PTR_TO NH_POI_FIX;
   END_VAR
	VAR_TEMP
		TEcoDT	: TTecoDateTime;

//    year             : usint;  (*rok     (poslední dvì èíslice letopoètu)*)
//    month            : usint;  (*mìsíc   (1 .. 12)*)
//    day              : usint;  (*den     (1 .. 28/29/30/31)*)
//    hour             : usint;  (*hodina  (0 .. 23)*)
//    min              : usint;  (*minuta  (0 .. 59)*)
//    sec              : usint;  (*sekunda (0 .. 59)*)
//    dayOfWeek        : usint;  (*den v týdnu (1 = pondìlí, 7 = nedìle)*)
//		milisec          : uint;  (*milisekunda*)

	END_VAR
	// default pripocita den+cas

	CASE wht OF
		2:	// + time
			_NhTime	:=		T#1d * fix^.tme.Day
							+ 	T#1h * fix^.tme.hour
							+ 	T#1m * fix^.tme.min;
			_Nh_Fix_TME_TO_DT 	:= ADD_DT_TIME(aSys.NhDT,_NhTime);					

		4:	// od zajtra
			_Nh_Fix_TME_TO_DT 	:= ADD_DT_TIME(DATE_TO_DT(aSys.NhDate),T#24:00:00);					
		5:	// od buduceso tyzdna
			i := 8-SYSTEM_S.COUNTER_DAYS_OF_WEEK;	
			_Nh_Fix_TME_TO_DT 	:= ADD_DT_TIME(DATE_TO_DT(aSys.NhDate), T#1d * i);					
	ELSE
			TEcoDT.year		:= fix^.tme.year;
			TEcoDT.month	:= fix^.tme.month;
			TEcoDT.day		:= fix^.tme.day;
			TEcoDT.hour		:= fix^.tme.Hour;
			TEcoDT.min		:= fix^.tme.min;
			_Nh_Fix_TME_TO_DT := TecoDT_TO_DT( TEcoDT );
	END_CASE;

(*

	_NhTime	:=		T#1d * fix^.tme.Day
					+ 	T#1h * fix^.tme.hour
					+ 	T#1m * fix^.tme.min;
	CASE wht OF
     	0:	//pripocitat den+time+min
			;
		1:	// datum

			RETURN;
		2:	// of zajtra
   ELSE

   END_CASE;
	_Nh_Fix_TME_TO_DT 	:= ADD_DT_TIME(aSys.NhDT,_NhTime);
*)
END_FUNCTION



FUNCTION _Nh_Fix_HET_MAN  {HIDDEN}     :BOOL        // nastavit datum zmeny MAN -> PRG
   VAR_INPUT
		ref		: 	BOOL;						// len vypocita toChg
		off		: 	BOOL;              	// nastavi 0 do datumu
      fix      :  PTR_TO NH_POI_FIX;
      chg      :  PTR_TO NH_HET_CHG;
   END_VAR
	_Nh_Fix_HET_MAN := true;
	IF ref = false THEN
	   CASE  fix^.wht OF                                                 // NASTAVIT cas vratenia na automatiku
   	   0: // nikdy
				off := true;
			1:	// zmenou v dennom programe 	
				;// toto sa vykona v _NH_Het_CMD_PVA
      	2: // po uplynuti casu
				chg^.dtChg := ADD_DT_TIME(aSys.NhDT, T#1d * fix^.tme.Day +	T#1h * fix^.tme.hour +	T#1m * fix^.tme.min );					
   	   3: // od datumu
				chg^.dtChg := _Nh_Fix_TME_TO_DT(fix:=fix, wht:=fix^.wht);
   	   4: // od zajtra
//				chg^.dtChg := _Nh_Fix_TME_TO_DT(fix:=fix, wht:=fix^.wht);
				chg^.dtChg :=  ADD_DT_TIME(DATE_TO_DT(aSys.NhDate),T#24:00:00);					
   	   5: // na zaciatku tyzdna
				i := 8-SYSTEM_S.COUNTER_DAYS_OF_WEEK;	
				chg^.dtChg := ADD_DT_TIME(DATE_TO_DT(aSys.NhDate), T#1d * i);					
   	   6: // ked bude den v tyzdni
				off := true;
   	   7: // po zmene sumraku
				off := true;
   	   8: // Zmenou fazy dna
				off := true;
		END_CASE;
(*
	   CASE  man^.manTyp OF                                                 // NASTAVIT cas vratenia na automatiku
   	   0:  off := true;                                  // nebude nikdy zmena  00:00:00 xHet^.me.end := T#1s;                                                      // manualne
      	1:  chg^.dtChg := _Nh_EndDT(xTdt := ADR(man^.manMem), wht:=1);    // po case
	      2:  chg^.dtChg := _Nh_EndDT(xTdt := ADR(man^.manMem), wht:=2);    // na konci dna
   	   3:  chg^.dtChg := _Nh_EndDT(xTdt := ADR(man^.manMem), wht:=3);    // den v tyzdni
      	4:  chg^.dtChg := TecoDT_TO_DT(man^.manMem);                      // k datumu
	//      5:  chg^.dtChg := UINT_TO_DT(0);    // * prvou zmenou v automatike - vyrobi sa len pre HET
   	   // toto Treba dorobit - !! ZATIAL SA VYPOCITA ZACIATOK DRUHEHO DNA - ako vo volbe 2
      	6:  chg^.dtChg := _Nh_EndDT(xTdt := ADR(man^.manMem), wht:=2);    // * zmena typu dna sa predpoklada na konci dna
	      7:  chg^.dtChg := _Nh_EndDT(xTdt := ADR(man^.manMem), wht:=2);    // * faza dna
   	END_CASE;
*)
	END_IF;
	IF off THEN
		chg^.dtChg := UINT_TO_DT(0);
	END_IF;
	IF chg^.dtChg > aSys.NhDT THEN
		chg^.toChg := SUB_DT_DT(IN1 := chg^.dtChg, IN2 := aSys.NhDT );       // vypocita sa casu do najblizsej zmeny
	ELSE
		chg^.toChg := T#0h;
	END_IF;	
END_FUNCTION



FUNCTION _Nh_Poi_Obr_Chg  {HIDDEN}  : BOOL       // vrati, ci je aktualne zmena a zapise cas najblizsej zmeny
   // xPod uz musi byt namapovane
   VAR_INPUT
      wEnd     : BOOL := true;         // zapis End
      wPv      : BOOL := true;         // zapis aktualne pv
      pv       : PTR_TO USINT;         // aktualne cislo predvolby
      chg      : PTR_TO NH_HET_CHG;
   END_VAR
   VAR_TEMP
      d        : USINT;                   // obmedzenie hladania na 2 dni (dnesny a zajtrajsi) 0..1
      i        : SINT := 0;               // pomocne hladanie casoveho pointu
      p        : SINT := -1;              // casovy point
      day      : USINT;                   // vybraty den
      dMin     : INT;                     // aktualny case
   END_VAR
   _Nh_Poi_Obr_Chg := false;
   Day         := xPod^.Day;
   dMin        := aSys.dMin;
   chg^.dtChg  := DATE_TO_DT( aSys.NhDate );                         // zaciatok dnesneho dna(ten je este vzdy mensi ako aktualny cas - zostane ak sa nenajde)
   FOR d := 0 TO 1 DO
      ok := false;
      IF Day = 0 THEN
         EXIT;
      ELSIF xPod^.poi[ Day ] = 0 THEN
         EXIT;
      ELSIF _NhxPt(c := 26, n := xPod^.poi[ Day ], x:=-4) = false THEN                           // namapovat vetu
         EXIT;
      END_IF;
      xArP  := xPt + 1;                                              // postavi sa za ok, rovno na xPAr^.cx.p[0]
      i     := 0;
      WHILE i < 8 AND xArp^.p[i].t > -1  DO                          // [0..7] a nesmie byt -1=neobsadene
         IF dMin = xArp^.p[i].t THEN                                 // sme presne na bode => prave sa zacal tento interval
            p     := i;
            EXIT;
         ELSIF dMin < xArp^.p[i].t THEN                              // bod je za aktualnym casom
            p := i-1;                                                // plati to co je v predchadzajucom bode (intervale)
            EXIT;
         END_IF;
         i := i + 1;                                                 // presun na dali point
      END_WHILE;

      IF p > -1 THEN                                                 // nasiel sa prvy bod za aktualnym casom
         _Nh_Poi_Obr_Chg := pv^ <> SINT_TO_USINT(xArp^.p[p].o);      // obrazky su rozdielne = je zmena
         chg^.pvChg  := SINT_TO_USINT(xArp^.p[p].o);                 // zapise obrazok
         IF wPv AND d = 0 THEN
            pv^   := chg^.pvChg ;                                    // zapise PV z aktualneho intervalu. To moze len pri aktualnom dni (d=0)
         END_IF;
         IF wEnd THEN                                                   // zapisat cas najblizsej zmeny
            FOR i := p+1 TO 7 DO                                        // hlada sa od nasledujuceho bodu
               IF xArp^.p[i].t > -1 AND xArp^.p[i].o <> xArp^.p[p].o THEN     // je rozdiel obrazkov  [p]=aktualny obrazkok, [i] nasledujuci
                  EXIT;
               END_IF;
            END_FOR;
            IF i <= 7 THEN                                              // nasiel sa bod, kde je zmena
               chg^.dtChg := ADD_DT_TIME(IN1 := chg^.dtChg, IN2 := LREAL_TO_TIME( INT_TO_LREAL(xArp^.p[i].t) * 60000.0) );   // pripocitat cas z pointu
               chg^.pvChg := SINT_TO_USINT(xArp^.p[i].o);
               RETURN;
            END_IF;
         ELSE
            RETURN;
         END_IF;
      END_IF;

      IF Day > 7 THEN                                             // Sviatok...dovolenka  sa otoci
      ELSIF Day = 7 THEN
         Day   := 1;
         dMin  := 0;
      ELSE
         Day   := Day + 1;
         dMin  := 0;
      END_IF;
      chg^.dtChg  := ADD_DT_TIME(chg^.dtChg,TIME#24:00:00);           // presun na dalsi den
      dMin        := 0;
      p           := -1;
   END_FOR;
   chg^.dtChg := UDINT_TO_DT( 0 );
   
END_FUNCTION




(*
FUNCTION _Nh_Poi_Obr_Chg  : BOOL       // vrati, ci je aktualne zmena a zapise cas najblizsej zmeny
   VAR_INPUT
      wEnd     : BOOL := true;         // zapis End
      wPv      : BOOL := true;         // zapis pv
      nd       : INT;                  // cislo vety POI aCfg[26]
      pv       : PTR_TO USINT;         // aktualne cislo predvolby
      chg      : PTR_TO NH_HET_CHG;
   END_VAR
   VAR_TEMP
      i        : SINT := 0;
      j        : SINT := -1;
   END_VAR
   _Nh_Poi_Obr_Chg := false;
   IF _NhxDev2(c := 26, n := nd, x:=-4) THEN                           // namapovat vetu
      xArP  := xDev2+1;                                                 // postavi sa za ok, rovno na xPAr^.cx.p[0]
      WHILE i < 8 AND xArp^.p[i].t > -1  DO                             // [0..7] a nesmie byt -1=neobsadene
         IF aSys.dMin = xArp^.p[i].t THEN                               // sme presne na bode => prave sa zacal tento interval
            j     := i;
            EXIT;
         ELSIF aSys.dMin < xArp^.p[i].t THEN                            // bod je za aktualnym casom
            j := i-1;                                                   // plati to co je v predchadzajucom bode (intervale)
            EXIT;
         END_IF;
         i := i + 1;
      END_WHILE;
      IF j > -1 THEN                                                    // nasiel sa bod za aktualnym casom
         _Nh_Poi_Obr_Chg := pv^ <> SINT_TO_USINT(xArp^.p[j].o);                           // obrazky su rozdielne
         IF wPv THEN
            pv^         := SINT_TO_USINT(xArp^.p[j].o);                                        // zapise PV
            chg^.pvChg  := pv^;                                         // default zapise rovnaky obrazok
         END_IF;
         IF wEnd THEN                                                   // zapisat cas najblizsej zmeny
            FOR i := j+1 TO 7 DO                                        // hlada sa od nasledujuceho bodu
               IF xArp^.p[i].t > -1 AND xArp^.p[i].o <> xArp^.p[j].o THEN     // je rozdiel obrazkov  [j]=aktualny obrazkok, [i] nasledujuci
                  EXIT;
               END_IF;
            END_FOR;
            chg^.dtChg := DATE_TO_DT( getdate() );                            // zaciatok dnesneho dna(ten je este vzdy mensi ako aktualny cas - zostane ak sa nenajde)
            IF i <= 7 THEN                                              // nasiel sa bod, kde je zmena
               chg^.dtChg := ADD_DT_TIME(IN1 := chg^.dtChg, IN2 := LREAL_TO_TIME( INT_TO_LREAL(xArp^.p[i].t) * 60000.0) );   // pripocitat cas z pointu
               chg^.pvChg := SINT_TO_USINT(xArp^.p[i].o);
            ELSE
               j := -1;
               i := 0;
               WHILE i < 8 AND xArp^.p[i].t < aSys.dMin  DO             // prechadza sa zajtrajsi den od zaciatku az do aktuealneho casu ale zajtra
                  IF pv^ <> SINT_TO_USINT(xArp^.p[i].o) THEN                                                                           // este pred casom je zmena
                     chg^.dtChg := ADD_DT_TIME(IN1 := chg^.dtChg, IN2 := T#24:00:00 );                                              // zaciatok druheho dna
                     chg^.dtChg := ADD_DT_TIME(IN1 := chg^.dtChg, IN2 := LREAL_TO_TIME( INT_TO_LREAL(xArp^.p[i].t) * 60000.0) );    // pripocitat cas z pointu
                     chg^.pvChg := SINT_TO_USINT(xArp^.p[i].o);
                     EXIT;
                  END_IF;
                  i := i + 1;
               END_WHILE;
               IF i > 7 THEN
                  chg^.dtChg := UDINT_TO_DT( 0 );
               END_IF;
            END_IF;
         END_IF;
      END_IF;
   END_IF;
END_FUNCTION
*)



FUNCTION _Nh_CHG_VAL   {HIDDEN}    :BOOL                               // zmena hodnoty a zapis do ROM
   VAR_INPUT
		zon	: BOOL := true;											// je zobraty ces io^.dev.c => z vyssej zony alebo ineho def
		io		: PTR_TO NH_VAL_IO;
      val   : REAL;
//		rom	: USINT;
   END_VAR
   io^.own  		:= true;                  						// urcite vlastny snimac
   io^.zon  		:= zon;                  						// priznak ci z ineho DEV / zony
   io^.chg  		:= io^.val <> val;	// OR aSys.restart;                  // zmena
	xHoW^.chg	   := xHoW^.chg OR io^.chg;							// centralna zmena niektorej hodnoty do domceka
	IF io^.chg THEN
		io^.cmd := true;
	END_IF;
   io^.val			:= val;                             				// 100-teplota, 101=% osvetlenia
   _Nh_CHG_VAL 	:= io^.chg;
END_FUNCTION

FUNCTION _Nh_Sta_Rom   {HIDDEN} :BOOL                                  // zapise stav pre konkretnu kategoriu do: ROM,ZON,HOM
   VAR_INPUT
		Body		: BOOL 	:= true;
		psn		: BOOL 	:= true;
		sta		: USINT 	:= 1;
		cat		: USINT;
   END_VAR
	_Nh_Sta_Rom		:= true;
	xDev^.al.sta 	:= sta;
	
	IF sta > 0 THEN
		IF cat = 0 THEN
			cat := xDev^.cf.cat;
		END_IF;
		psn 	:= psn 	AND xDev^.cf.psn;
		body  := body  AND aCfg[cf].body;
		// domcek
	   xHoW^.cat[cat] 	:= true;                    						// domcek vzdy, aj ked su subjekty
   	xHoW^.body     	:= xHoW^.body 	OR body;                		// pohyb do domceka
   	xHoW^.psn 			:= xHoW^.psn 	OR psn;       			
		// miesnost
	   IF xDev^.cf.rom > 0 THEN														
		   _NhxPt(c:=1, n := USINT_TO_INT(xDev^.cf.rom), x:=-120); 		// namapuje xPt = Rom
   	   _NhxRoW(nbr := xDev^.cf.rom);                                  // xRow  pre zonu,
 	     	xRoW^.cat[cat] 	:= true;
	   	xRoW^.body    		:= xRoW^.body 		OR body;                // pohyb do ROM
	   	xRoW^.psn 			:= xRoW^.psn 		OR psn;
     		// nadradena zona.  Pre subjekt iny ako domcek (1) je to aj domovska zona
      	IF xPt^.cf.rom > 1 THEN
         	_NhxRoW(nbr := xPt^.cf.rom, zon := true);							// namapuje zonu do xRow
	 	     	xRoW^.cat[cat] 	:= true;
		   	xRoW^.body    		:= xRoW^.body 		OR body;
		   	xRoW^.psn 			:= xRoW^.psn 		OR psn;
      	END_IF;
//	   	xCaW^.cat[ aCfg[cf].cat ] := true;										// status do CAT
   	END_IF;
	END_IF;

END_FUNCTION


(*
FUNCTION _Nh_Sta_Rom   :BOOL                                  // zapise stav pre konkretnu kategoriu do: ROM,ZON,HOM
   VAR_INPUT
		ok			: BOOL;
		Body		: BOOL := true;
		BodyPSN	: BOOL := true;
		sta		: USINT := 1;
		cat		: USINT;

   END_VAR
	_Nh_Sta_Rom	:= true;
	IF ok THEN
		xDev^.al.sta := sta;
		IF cat = 0 THEN
			cat := xDev^.cf.cat;
		END_IF;
		// domcek
	   xHoW^.cat[cat] 	:= true;                    							// domcek vzdy, aj ked su subjekty
   	xHoW^.body     	:= xHoW^.body 		OR (Body AND aCfg[cf].body);                // pohyb do domceka
   	xHoW^.bodyPSN 		:= xHoW^.bodyPSN 	OR (BodyPSN AND xHoW^.LckStat > 1 AND Body AND aCfg[cf].body);                // pohyb do domceka
		// miesnost
	   IF xDev^.cf.rom > 0 THEN														
		   _NhxPt(cf:=1, nd := USINT_TO_INT(xDev^.cf.rom), x:=-120); 		// namapuje xPt = Rom
   	   _NhxRoW(nbr := xDev^.cf.rom);                                  // xRow  pre zonu,
 	     	xRoW^.cat[cat] 	:=true;
	   	xRoW^.body    		:= xRoW^.body 		OR aCfg[cf].body;                // pohyb do ROM
	   	xRoW^.bodyPSN 		:= xRoW^.bodyPSN 	OR (BodyPSN AND xRoW^.lckStat > 1 AND aCfg[cf].body);                // pohyb do domceka

     		// nadradena zona.  Pre subjekt iny ako domcek (1) je to aj domovska zona
      	IF xPt^.cf.rom > 1 THEN
         	_NhxRoW(nbr := xPt^.cf.rom, zon := true);							// namapuje zonu do xRow
	 	     	xRoW^.cat[cat] 	:=true;
		   	xRoW^.body    		:= xRoW^.body 		OR aCfg[cf].body;
		   	xRoW^.bodyPSN 		:= xRoW^.bodyPSN 	OR (BodyPSN AND xRoW^.LckStat > 1 AND aCfg[cf].body);                // pohyb do domceka
      	END_IF;
//	   	xCaW^.cat[ aCfg[cf].cat ] := true;										// status do CAT
   	END_IF;
	ELSE
		xDev^.al.sta := 0;	
	END_IF;
END_FUNCTION
*)
(*
FUNCTION _Nh_Dev_EX  {HIDDEN}   : BOOL	 // odpocitava cas. Ak sa skoncil tak impulz na al.Qx a vystup trvale TRUE
   VAR_INPUT
      t  : USINT := 2;
   END_VAR
   _Nh_Dev_EX := false;
   IF xDev^.al.ex > 0 THEN
      CASE t OF
        1 : xDev^.al.ex  := xDev^.al.ex - aSys.i1Sec;    //[SEC]
        2 : xDev^.al.ex  := xDev^.al.ex - aSys.i1Min;    //[MIN]
      END_CASE;
      _Nh_Dev_EX := xDev^.al.ex = 0;
   END_IF;
END_FUNCTION
*)

FUNCTION _Nh_Dev_ET_INT  {HIDDEN}   : BOOL	 // odpocitava cas. Ak sa skoncil tak impulz
   VAR_INPUT
      t  	: USINT;          // aky cas
		et		: PTR_TO INT;		
   END_VAR
	IF et^ = 0 THEN
	   _Nh_Dev_ET_INT := false;
	ELSE
	   CASE t OF
   	  0 : et^ := et^ - MIN(et^,UINT_TO_INT(aSys.mSec));    // mSec
	     1 : et^ := et^ - USINT_TO_INT(aSys.n1Sec);                     		// SEC
   	  2 : et^ := et^ - USINT_TO_INT(aSys.n1Min);   								// MIN
	     3 : et^ := et^ - USINT_TO_INT(aSys.n100ms);  									// 100ms
   	  4 : et^ := et^ - USINT_TO_INT(aSys.n50ms);  									// 100ms
	   END_CASE;
   	_Nh_Dev_ET_INT := et^ = 0;           // impulz ked sa dosiahlo et:=0
	END_IF;
END_FUNCTION

FUNCTION _Nh_Dev_ET_USINT  {HIDDEN}   : BOOL	 // odpocitava cas. Ak sa skoncil tak impulz
   VAR_INPUT
      t  	: USINT;          // aky cas
		et		: PTR_TO USINT;		
   END_VAR
	IF et^ = 0 THEN
	   _Nh_Dev_ET_USINT := false;
	ELSE
	   CASE t OF
   	  0 : et^ := et^ - MIN(et^,UINT_TO_USINT(aSys.mSec));    // mSec
	     1 : et^ := et^ - aSys.n1Sec;                     		// SEC
   	  2 : et^ := et^ - aSys.n1Min;   								// MIN
	     3 : et^ := et^ - aSys.n100ms;  								// 100ms
   	  4 : et^ := et^ - aSys.n50ms;  									// 50ms
	   END_CASE;
   	_Nh_Dev_ET_USINT := et^ = 0;           // impulz ked sa dosiahlo et:=0
	END_IF;
END_FUNCTION

FUNCTION _Nh_Dev_ET_UINT  {HIDDEN}   : BOOL	 // odpocitava cas. Ak sa skoncil tak impulz
   VAR_INPUT
      t  	: USINT;          // aky cas
		et		: PTR_TO UINT;		
   END_VAR
	IF et^ = 0 THEN
	   _Nh_Dev_ET_UINT := false;
	ELSE
	   CASE t OF
   	  0 : et^ := et^ - MIN(et^,aSys.mSec);    					// mSec
	     1 : et^ := et^ - aSys.u1Sec;                     		// SEC
   	  2 : et^ := et^ - aSys.u1Min; 									// MIN
	     3 : et^ := et^ - aSys.u100ms;  								// 100ms
   	  4 : et^ := et^ - aSys.u50ms;  								// 500ms
	   END_CASE;
   	_Nh_Dev_ET_UINT := et^ = 0;           // impulz ked sa dosiahlo et:=0
	END_IF;
END_FUNCTION

FUNCTION _Nh_Dev_AT_UINT  {HIDDEN}   : BOOL	 // odpocitava cas. Ak sa skoncil tak impulz
   VAR_INPUT
      t  	: USINT;          // aky cas
		et		: PTR_TO UINT;		
		etMax	: UINT;
   END_VAR
	   CASE t OF
   	  0 : et^ := et^ + aSys.mSec; 			   					// mSec
	     1 : et^ := et^ + aSys.u1Sec;                     		// SEC
   	  2 : et^ := et^ + aSys.u1Min; 									// MIN
	     3 : et^ := et^ + aSys.u100ms;  								// 100ms
   	  4 : et^ := et^ + aSys.u50ms;  									// 500ms
	   END_CASE;
   	_Nh_Dev_AT_UINT := et^ >= etMax;
END_FUNCTION



FUNCTION _Nh_Dev_ET  {HIDDEN}   : BOOL	 // odpocitava cas. Ak sa skoncil tak impulz
   VAR_INPUT
		Qf		: BOOL;    			// nasilne nanuti impulz
      t  	: USINT;          // aky cas
   END_VAR
	IF xDev^.al.et > 0 THEN
	   CASE t OF
   	  0 : xDev^.al.et := xDev^.al.et - MIN(xDev^.al.et,aSys.mSec); 			// mSec
	     1 : xDev^.al.et := xDev^.al.et - aSys.u1Sec;                     		// SEC
   	  2 : xDev^.al.et := xDev^.al.et - aSys.u1Min; 									// MIN
	     3 : xDev^.al.et := xDev^.al.et - aSys.u100ms;  								// 100ms
   	  4 : xDev^.al.et := xDev^.al.et - aSys.u50ms;  								// 500ms
	   END_CASE;
		_Nh_Dev_ET  := xDev^.al.et = 0;                          					// trvale,ked et:=0
	   xDev^.al.Qf := _Nh_Dev_ET;                                              // impulz
	ELSE
   	_Nh_Dev_ET 	:= true;
	   xDev^.al.Qf := Qf;
	END_IF;
END_FUNCTION

(*
FUNCTION _Nh_Dev_ET  {HIDDEN}   : BOOL	 // odpocitava cas. Ak sa skoncil tak impulz na al.Qx a vystup trvale TRUE
   VAR_INPUT
      t    : USINT;          // aky cas
   END_VAR
   _Nh_Dev_ET := xDev^.al.et > 0;
   CASE t OF
     0 : xDev^.al.et := xDev^.al.et - MIN(xDev^.al.et,aSys.mSec);                            // mSec
     1 : xDev^.al.et := xDev^.al.et - MIN(xDev^.al.et,aSys.u1Sec);                           // SEC
     2 : xDev^.al.et := xDev^.al.et - MIN(xDev^.al.et,BOOL_TO_UINT(SYSTEM_S.F_EDGE_1MIN));   // MIN
     3 : xDev^.al.et := xDev^.al.et - MIN(xDev^.al.et,BOOL_TO_UINT(SYSTEM_S.F_EDGE_100ms));  // 100ms
     4 : xDev^.al.et := xDev^.al.et - MIN(xDev^.al.et,BOOL_TO_UINT(SYSTEM_S.F_EDGE_100ms));  // 100ms
   END_CASE;
   xDev^.al.Qf := xDev^.al.et = 0 AND _Nh_Dev_ET;           // impulz ked et:=0
   _Nh_Dev_ET  := xDev^.al.et = 0;                          // trvale,ked et:=0
END_FUNCTION
*)

FUNCTION _Nh_ET_MS  {HIDDEN}   : BOOL	 				// rychlejsia verzia _Nh_DEV_ET
   VAR_INPUT
		et		: PTR_TO UINT;		
   END_VAR
   _Nh_ET_MS  := false;                          	
	IF et^ = 0 THEN
		;
	ELSIF et^ > aSys.mSec THEN
		et^ := et^ - aSys.mSec;                            // mSec
	ELSE
		et^ 	:= 0;
	   _Nh_ET_MS  := true;
	END_IF;
END_FUNCTION


FUNCTION _Nh_Dev_RMP {HIDDEN} : BOOL    // nastavi rampu, podla toho ci sa bude zapinat, alebo vypinat
	xDev^.al.up	:= xDev^.al.in.val >= xDev^.al.OU.val;
	IF 	aCfg[cf].analog = false THEN	xDev^.al.RMP	:= 0;
	ELSIF aCfg[cf].par = 0			THEN  xDev^.al.RMP	:= 1;
	ELSIF xDev^.al.up 				THEN  xDev^.al.RMP	:= xPar^.sva.rUp;
	ELSE	                              xDev^.al.RMP	:= xPAr^.sva.rDn;
	END_IF;
END_FUNCTION

FUNCTION _Nh_Dev_Qx   {HIDDEN}  :BOOL     // TRIGER vyhodnotenia zaciatku a konca vstupu (CMD...)
   VAR_INPUT
      In    : BOOL;
   END_VAR
   xDev^.ok.CmdInBlk := In;             ///***30.11.22 potvrdi prijatier dat - odblokuje vstup
   xDev^.al.trg.In := In;
   xDev^.al.trg.Qf := xDev^.al.trg.Q and xDev^.al.trg.In = false ;
   xDev^.al.trg.Qr := xDev^.al.trg.Q = false AND xDev^.al.trg.In ;
   xDev^.al.trg.Q  := xDev^.al.trg.In;
   _Nh_Dev_Qx      := xDev^.al.trg.Qr;
END_FUNCTION

FUNCTION _Nh_Qx {HIDDEN}  :BOOL     // TRIGER In)
   VAR_INPUT
      In    : BOOL;
		trg	: PTR_TO NH_TRIG;
   END_VAR
   trg^.In := In;
   trg^.Qf := trg^.Q and trg^.In = false ;
   trg^.Qr := trg^.Q = false AND trg^.In ;
   trg^.Q  := trg^.In;
   _Nh_Qx  := trg^.Qr OR trg^.Qf;
END_FUNCTION

(*
FUNCTION _Nh_Qx2 {HIDDEN}  :BOOL     // TRIGER vyhodnotenia zaciatku a konca vstupu (CMD...)
   VAR_INPUT
		trg	: PTR_TO NH_TRIG;
   END_VAR
//   trg^.In := In;
   trg^.Qf := trg^.Q and trg^.In = false ;
   trg^.Qr := trg^.Q = false AND trg^.In ;
   trg^.Q  := trg^.In;
   _Nh_Qx2  := trg^.Qr OR trg^.Qf;
END_FUNCTION
*)


(*
FUNCTION _Dev_PAR {HIDDEN}  :BOOL                              // zistiti Qr=zaciatok CMD a ked Qr=true, tak aj namapuje parameter
	_Dev_PAR := true;
	IF xDev^.al.in.par = 0 THEN                                 // prislo z webu
 		xDev^.al.ou.par := xDev^.cf.par;                            // do def parametra sa uklada fyzicky stav DEV
   ELSE
   	xDev^.al.OU.par   := xDev^.al.IN.par;
   END_IF;
END_FUNCTION
*)

FUNCTION _Dev_Qx_PAR {HIDDEN}  :BOOL  // zistiti Qr=zaciatok CMD vlozi do ou,par prichadzajucia, alebo default parameter a namapuje prameter
   VAR_INPUT
		clr		: BOOL := true;   // vynuluje prichadzajuci PAR a tak pripravi v dalsom CMD default
		dpa   	: INT;         	// DEFAULT parameter
   END_VAR
   _Dev_Qx_PAR := false;
	IF _Nh_Dev_Qx(In := xDev^.al.in.CMD > 0) THEN
      _Dev_Qx_PAR := true;
      IF xDev^.al.in.par = 0 OR xDev^.al.in.par > aPar[aCfg[cf].par].rec    THEN                                 // prislo z webu
         xDev^.al.ou.par := dpa;                      	// do def parametra sa uklada fyzicky stav DEV
      ELSE
         xDev^.al.OU.par   := xDev^.al.IN.par;
      END_IF;
   ELSIF xDev^.al.OU.par = 0 THEN
   	xDev^.al.ou.par := dpa;                            // do def parametra sa uklada fyzicky stav DEV
   END_IF;
   IF _NhxPar(cp := aCfg[cf].par , np := xDev^.al.OU.par,x:=-1000) = false THEN       // parameter z vazby
//	      yTx2        := CONCAT('cf:',USINT_TO_STRINGF(cf,'%3d'), '; nd:',INT_TO_STRINGF(nd,'%5d'), '; dpa:',INT_TO_STRINGF(dpa,'%5d'), ';al.in.par:',INT_TO_STRINGF(xDev^.al.in.par,'%5d') );
//   	   rb          := _Nh1RowTxt(logRst := 1);
		;
	END_IF;
	IF clr THEN
		xDev^.al.in.par 	:= 0;												//***19.1123
	END_IF;
END_FUNCTION


FUNCTION _Nh_TST_ROM  {HIDDEN} : BOOL;
	IF  xDev^.cf.typ = 0 THEN
 		_NhDefRom := INT_TO_USINT(nd);
	END_IF;							
	IF xDev^.cf.rom = 0 OR xDev^.cf.rom > INT_TO_USINT(aCfg[3].rec) THEN      // kontrola na zone
 		xDev^.cf.rom := 1;
	END_IF;
	IF _NhxPt(c:=3, n := USINT_TO_INT(xDev^.cf.rom),x:=-123) = false  THEN							
 		xDev^.cf.rom := 1;
   END_IF;
END_FUNCTION

FUNCTION _Nh_TST_ZON  {HIDDEN} : BOOL;
	IF xDev^.cf.typ = 1 THEN                                 							// BYT vstupuje do domcek
		xDev^.cf.rom := 1; 														// domcek						
	END_IF;
	IF _NhxPt(c := 3, n := USINT_TO_INT(xDev^.cf.rom),x:=53) = false THEN			// nenajdena zona
		xDev^.cf.rom := 1; 														
	ELSIF xDev^.cf.rom > INT_TO_USINT(aCfg[3].rec)                             	// zona je > ako max
			OR xPt^.cf.typ > 1 THEN                                              		// vyssia zona nie je HOME ani Byt
		xDev^.cf.rom := 1; 														
	END_IF;
END_FUNCTION

FUNCTION _NH_Het_Map_Reg  {HIDDEN} : BOOL
	VAR_TEMP
		mode	:	USINT;
	END_VAR;		
	xReg		:= ADR(xHet^.cx.reg);						
	mode		:= xReg^.Mode;
	xRegMod	:= ADR(xReg^.reg[ mode ] );
END_FUNCTION

FUNCTION _NhIsDBxCfgOk     : BOOL	 // Find CRC in RBx o DBX
	VAR_INPUT
		RBx		: BOOL;	// read from RamBox	
		mess  	: BOOL := true;
	END_VAR
	_NhIsDBxCfgOk	:= false;
	xDbx 	:= ADR(mObr);
	IF RBx THEN
		rb 		:= ReadFromRBx( ramBoxAddress  := 0, length := MIN(SIZEOF(mObr),SIZEOF(aDbx)), varAddress := PTR_TO_UDINT(xDbx) );
		_LangTXT	:= 'RBx. ';
	ELSIF aSys.IS_DBx THEN
 		rb 		:= ReadFromDBx( dataBoxAddress := 0, length := SIZEOF(aDbx), varAddress := PTR_TO_UDINT(xDBx) );
		_LangTXT	:= 'DBX. ';
	END_IF;
	IF rb AND aDbx.ver.CRC = xDbx^.ver.CRC THEN
		_NhIsDBxCfgOk	:= TRUE;
		_LangTXT			:= CONCAT(_LangTXT,'Ok. ');	
		IF RBx = false THEN
			xDbx^.FromDBx128 := SizeOfDataBox() = 128;		// pri prechode z DBX na RBx zaznaci do DBX ze DBX mal je 128k a moze byt
 			rb 		:= WriteToDBx( dataBoxAddress := 0, length := SIZEOF(aDbx), varAddress := PTR_TO_UDINT(xDbx) );  // zapise spat do DBX oznacit
		END_IF;
	ELSIF rb = false THEN
		_LangTXT			:= CONCAT(_LangTXT,'Error ReadFrom. ');	
	ELSE
		_LangTXT			:= CONCAT(_LangTXT,'Different versions. ');	
	END_IF;
	IF mess THEN
		yTx2	:= CONCAT('.Search ',_LangTXT,'{',aDbx.ver.CRC,'}{',xDbx^.ver.CRC,'}');
  		_Nh1RowTxt(logRst:=1);
	END_IF;
	IF _NhIsDBxCfgOk = false THEN
		aSys.CfgBckOk := _Nh_Log_Path(wh:=3, mem:=true, read:=TRUE);			// yTx1:=dbx.mem, yTx2 read from dbx.mem and check if backup file exists
		IF mess THEN
			yTx2 	:= CONCAT('..No: ',BOOL_TO_STRINGF(RBx,'%b{Rbx^DBX}'),'... Read dbx.mem: {',yTx1,'} CFG: {',yTx2,'}');
			_Nh1RowTxt(logRst:=1);
		END_IF;
	END_IF;
END_FUNCTION

FUNCTION _Nh_RBx_Mem {HIDDEN} : BOOL			// read/write from RBx,DBx to/from Mem
	VAR_INPUT	
		RBx		: BOOL;							// Read form Rbx
		write		: BOOL;
		logErr	: BOOL:=TRUE;
//		logOk		: BOOL;
		aDbx		: UDINT;
		sDbx		: UDINT;
		aMem		: UDINT;		
	END_VAR
	IF RBx THEN
		IF write THEN
			_Nh_RBx_Mem := WriteToRBx(ramBoxAddress  := aDbx, length := sDbx, varAddress :=  aMem );
		ELSE
			_Nh_RBx_Mem := ReadFromRBx(ramBoxAddress  := aDbx, length := sDbx, varAddress :=  aMem );
		END_IF;
	ELSIF write THEN
		_Nh_RBx_Mem := WriteToDBx(dataBoxAddress := aDbx, length := sDbx, varAddress :=  aMem  );
	ELSE
		_Nh_RBx_Mem := ReadFromDBx(dataBoxAddress := aDbx, length := sDbx, varAddress :=  aMem  );
	END_IF;
	IF logErr AND _Nh_RBx_Mem = FALSE THEN
		yTx2	:= CONCAT('.. Err_Nh_Dbx_RW:',BOOL_TO_STRINGF(RBx,'%b{RBx^DBx}'),BOOL_TO_STRINGF(write,'%b{ W^ R}'),
							UDINT_TO_STRINGF(aDbx,'%14d'),UDINT_TO_STRINGF(sdbx,'%4d'),UDINT_TO_STRINGF(aMem,'%9d') );
		_Nh1RowTxt(logRst:=1);
	END_IF;
(*
	IF logOk AND _Nh_RBx_Mem  THEN
		yTx2	:= CONCAT('.. Ok__Nh_Dbx_RW:',BOOL_TO_STRINGF(RBx,'%b{RBx^DBx}'),BOOL_TO_STRINGF(write,'%b{ W^ R}'),
							UDINT_TO_STRINGF(aDbx,'%14d'),UDINT_TO_STRINGF(sdbx,'%4d'),UDINT_TO_STRINGF(aMem,'%9d') );
		_Nh1RowTxt(logRst:=1);
	END_IF;
*)
END_FUNCTION

VAR_GLOBAL

//	fbDskMan			: _Nh_Disk_Man;			
	
	aMeteo			: NH_METEO;
	{ $IFDEF __NH_METEO_IQWS_4000 }
 		fbMeteo 		: fbMeteoIQWS4000;

//	   TER_MTS_1   {PUBLIC} AT aMeteo.station.temperature : REAL;   //Vonk.teplota-Meteo.;000
	   TER_MTS_1   {PUBLIC} AT aMeteo.idx[2].val 			: REAL;   //Vonk.teplota-Meteo.;000
//		LUX_MTS_1   {PUBLIC} AT aMeteo.OutLux 					: REAL;   //Súmrak-Meteo.;000
		LUX_MTS_1   {PUBLIC} 										: REAL;   //Súmrak-Meteo.;000
	{ $END_IF}
END_VAR



