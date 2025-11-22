
FUNCTION _Nh_IO_DEV  {HIDDEN} : BOOL  	// namapovanie DEV podla IO
	VAR_INPUT
		val		: BOOL := true;   						// zapise standardne do io^.val := xPt^.al.OU.val
		io			: PTR_TO NH_VAL_IO;
	END_VAR
	_Nh_IO_DEV	:= false;
	IF io^.dev.c > 0 THEN												// hociajaky DEV ma prednost predefult TEMP
		IF _NhxPt(c := io^.dev.c, n := io^.dev.n, x:=-56) THEN
			_Nh_IO_DEV	:= true;
			IF val THEN      	
				_Nh_CHG_VAL(io := io, val := xPt^.al.OU.val);
			END_IF;
			io^.own 		:= true;			
		ELSE
//			_NhMemClrPTR(size:=SIZEOF( NH_VAL_IO ), dest := io );
			io^.chg		:= false;
			io^.own 		:= false;			
			io^.dev.c 	:= 0;			
		END_IF;
	END_IF;		
END_FUNCTION

FUNCTION _Nh_ROM_IO_VAL {HIDDEN} : BOOL  // ukladanie hodnot do ROM,ZON
	VAR_INPUT
		clr		: BOOL;
		i1			: USINT := 100;
		i2			: USINT := 100;
		io			: PTR_TO NH_VAL_IO;
	END_VAR
	_Nh_ROM_IO_VAL	:= true;
	WHILE i1 <= i2 DO
		ok	:= false;
		IF clr  THEN																// reset
			io^.own 		:= false;			                           // ma snima
			io^.zon 		:= false;			
			io^.out 		:= false;			
			io^.chg 		:= false;			
//			io^.val 		:= -0.0;			
			xPt^.al.lst := 0;
		ELSIF io^.dev.c > 0 THEN												// hociajaky DEV ma prednost predefult TEMP
			IF _NhxPt(c := io^.dev.c, n := io^.dev.n, x:=-56) THEN
				_Nh_CHG_VAL(io := io, val := xPt^.al.OU.val);		
				xPt^.al.vaz := true;
			ELSE
				io^.own 		:= false;			
				io^.zon 		:= false;			
				io^.chg 		:= false;			
				io^.val 		:= -0.0;			
//				_NhMemSetPTR(size := SIZEOF(NH_VAL_IO), dest:= io );
			END_IF;
		ELSIF io^.own THEN														// ROM/ZON ma default snimac
				;
		ELSIF xRom^.io[i1].FromZon AND	xZon^.io[i1].own THEN		// najskor z nadradenej zony
				io^.zon := true;
				io^.out := false;			
	   		io^.chg := xZon^.io[i1].val <> io^.val;
				io^.val := xZon^.io[i1].val;

		ELSIF xRom^.io[i1].FromOut AND	xZOu^.io[i1].own THEN		// najskor z vonkajsej zony
				io^.zon := false;
				io^.out := true;			
	   		io^.chg := xZOu^.io[i1].val <> io^.val;
				io^.val := xZOu^.io[i1].val;
		ELSE
				io^.zon := false;
				io^.out := false;			
	   		io^.chg := false;
				io^.val := -0.0;
//				_Nh_ROM_IO_VAL	:= false;
		END_IF;
		io 				:= io + SIZEOF(NH_VAL_IO);
		i1 				:= i1+1;
	END_WHILE;
END_FUNCTION

FUNCTION _Dev_INI {HIDDEN}   :BOOL     // INICIALIZACIA KAZDEHO nulteho DEV (adresa 1.dev - sz)
   VAR_INPUT
      c     : USINT;
   END_VAR
   _Dev_INI       := true;
   nd             := 0;                                           // este pred prvym DEV, ktore si pripocita + 1
   cf             := c;
   sRun           := aCfg[cf].siz;                 // velkost celeho DEV
   xDev           := ADR( mRam[ aCfg[cf].Ram ]) - sRun;             // pointer prvej vety (musi byt ponizeny o jeden zaznam, lebo pri prvom zazname sa pripocita sz)
   xCfx           := xDev + 1 + SIZEOF(NH_CFG_ALL) + USINT_TO_UDINT(aCfg[cf].al);          // len cfx k Dev
END_FUNCTION

// toto treba pouzivat
FUNCTION _Nh_DEV_INI   {HIDDEN}:BOOL                     // INICIALIZACIA KAZDEHO nulteho DEV (adresa 1.dev - sz)
   VAR_INPUT
      c     : USINT;
   END_VAR                                                  // len pre kopatibilitu s  _Dev_INI
	nd					:= 0;										
	cf             := c;
   sRun           := aCfg[cf].siz;        						// velkost celeho DEV
   xDev           := ADR( mRam[ aCfg[cf].Ram ]) - sRun;  	// pointer prvej vety (musi byt ponizeny o jeden zaznam, lebo pri prvom zazname sa pripocita sz)
   _Nh_DEV_INI    := aCfg[cf].Rec > 0;
END_FUNCTION

FUNCTION _Dev_DEV  {HIDDEN}   :BOOL       // zaciatok cyklu adresy dalsieho DEV
   nd          := nd + 1;
   xDev        := xDev + sRun;                                      // namapuje dalsie DEV (prve dev ma o sz menej)
   _Dev_DEV    := nd <= aCfg[cf].rec;
END_FUNCTION

FUNCTION _Dev_CFX {HIDDEN} :BOOL       // adresy dalsieho DEV
   nd          := nd + 1;
   xCfx        := xCfx + sRun;
   xDev        := xDev + sRun;;
   _Dev_CFX    := nd <= aCfg[cf].rec;
END_FUNCTION

FUNCTION _Dev_TER  {HIDDEN} :BOOL       // adresy dalsieho DEV
//   _Dev_TER := _NhxDev(cf := cf, nd := nd, x:=5);                 // v je uz aj xCfg
   _Dev_TER := _NhxPt(c := cf, n := nd, x:=5);                 // v je uz aj xCfg
   xDev  := xPt;
   IF xDev^.ok.cmdOuRpt = false THEN                              // nema sa opakovat CMD
      xDev^.al.ou.cmd   := 0;                                     // reset vystupneho cmd, posledne stlaceny btn zostava do najblizsieho stlacenia
   END_IF;
END_FUNCTION

FUNCTION _Dev_BLK_2   {HIDDEN} :BOOL                              // adresy dalsieho DEV
   _Dev_BLK_2 := xDev^.cf.blk = FALSE  AND xDev^.ok.ok ;
   IF xDev^.ok.cmdOuRpt = false THEN                                   // nema sa opakovat CMD
      xDev^.al.ou.cmd   := 0;                                     // reset vystupneho cmd, posledne stlaceny btn zostava do najblizsieho stlacenia
   END_IF;
END_FUNCTION

FUNCTION _Dev_BLK   {HIDDEN} :BOOL       // adresy dalsieho DEV
   _Dev_BLK := _NhxCfg(c := cf, n := nd, x:=6 )                       // v  je uz aj xCfg
               AND xDev^.cf.blk = FALSE;                             // nie je blokovane
   IF xDev^.ok.cmdOuRpt = false THEN                                   // nema sa opakovat CMD
      xDev^.al.ou.cmd   := 0;                                     // reset vystupneho cmd, posledne stlaceny btn zostava do najblizsieho stlacenia
   END_IF;
END_FUNCTION

FUNCTION _Dev_TRG  {HIDDEN}  :BOOL     (* TRIGER vyhodnotenia zaciatku a konca vstupu nadstrukturou NH_TRIG. Vracia nabeznu hranu *)
   VAR_INPUT
      In     : BOOL;                   (*stav vsupnej premennej*)
      trg    : PTR_TO NH_TRIG;         (*pamatova struktura, kde su Qr,Qf,Q*)
   END_VAR
   trg^.In := In;
   trg^.Qf := trg^.Q and trg^.In = false ;
   trg^.Qr := trg^.Q = false AND trg^.In ;
   trg^.Q  := trg^.In;
   _Dev_TRG:= trg^.Qr;
END_FUNCTION



FUNCTION _Nh_Dev_Ok_Bl_Cmd {HIDDEN}   : BOOL;      // Vyhodnotenie n-Click,press,Hold z HW WSB,

   _Nh_Dev_Ok_Bl_Cmd := xDev^.ok.ok AND xDev^.cf.blk = false;
   xDev^.al.ou.cmd   := 0;
END_FUNCTION

FUNCTION _Nh_Dev_REC   :BOOL                    // dalsie Dev, vrati platny, netestuje BLK
	VAR_INPUT
   	blk	: BOOL;
	END_VAR
   xDev           	:= xDev  + sRun;                       // namapuje dalsie DEV
   _Nh_Dev_REC    	:= xDev^.ok.OK AND (xDev^.cf.blk = false OR blk = false);
    xDev^.al.ou.cmd  := 0;                                           // resetuje vystupny prikaz
END_FUNCTION

FUNCTION _Dev_PTR_PAR {HIDDEN}  : BOOL	                            // posun na dalsie DEV s pouzitim pointera a velkosti vety SZ, vratane zachytenia Qr,Q,Qf
   nd    := nd + 1;
   xDev := xDev + sz;
   IF nd <= aCfg[cf].Rec THEN
      _Dev_PTR_PAR   := true;
      IF xDev^.ok.OK AND xDev^.cf.blk = false THEN
         IF _Nh_Dev_Qx(In := xDev^.al.in.CMD > 0 ) THEN //  );                                  // zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0
            xDev^.al.ou.par := xDev^.al.in.par;
         END_IF;
         IF xDev^.al.ou.par = 0 THEN
            xDev^.al.ou.par := xDev^.cf.par;
         END_IF;
         _NhxPar(cp := aCfg[cf].par , np := xDev^.al.ou.par,x:=255);
         ok := true;
      END_IF;
   ELSE
      _Dev_PTR_PAR       := false;
   END_IF;
END_FUNCTION


FUNCTION _NhInkrValTst {HIDDEN}   :BOOL             // skontroluje REAL cislo, prida inkrement pohybu v rozmedzi 0..100, ak sa dosiahne spodna/vrchna hranica je FALSE, ked je rozdiel = TRUE *)
   VAR_INPUT
      wh       : USINT;                   // 0=kazdy cyklys, 1=kazdu sec
      cj       : USINT;                   // 0 = 1.ms, 1=10ms, 2=1SEC
      tRun     : UINT;                    // cas presunu z 0 na 100%
      in       : PTR_TO REAL;             // pointer na vstup
      ou       : PTR_TO REAL;             // pointer na vystup
   END_VAR
   _NhInkrValTst  := true;
   in^   :=  MIN(100.0,MAX(in^,0.0));                      // oprava
   kr    := 0.0;
   IF IS_INVALID_REAL(in^) THEN                                   // test na chybne cislo IN
      in^   := 100.0;
   END_IF;
   IF IS_INVALID_REAL(ou^) THEN
      ou^   := in^;
   END_IF;
   IF tRun = 0 THEN
      ou^   := in^;
   ELSIF wh = 0   THEN                         // kazdy cyklus
      CASE cj OF
        1 : kr :=  10.0 / UINT_TO_REAL(tRun);                           // 10ms : kolko % sa posunie za 1ms
      ELSE  kr := 100.0 / UINT_TO_REAL(tRun);                           //  1ms : kolko % sa posunie za 1ms
      END_CASE;
      kr := UINT_TO_REAL(aSys.mSec )* kr;                               // kolko % sa posunulo za cas predchadzajucejo cyklu v [ms]
   ELSIF SYSTEM_S.F_EDGE_1SEC THEN        // kazdu SEC
      kr := (100.0 / UINT_TO_REAL(tRun));
   END_IF;
   IF in^ > ou^   THEN
      ou^ := MIN(ou^ + kr,in^);
   ELSIF in^ < ou^   THEN
      ou^ := MAX(ou^ - kr,in^);
   ELSE
      _NhInkrValTst  := false;
   END_IF;
   ou^ :=  MIN(100.0,MAX(ou^,0.0));                      // oprava
END_FUNCTION

(*
     xWg503In    : PTR_TO TCIB_C_WG_0503S_IN;
      xWg503Ou    : PTR_TO TCIB_C_WG_0503S_OUT;
      xKy001In    : TCIB_C_KY_0001R_IN;
      xKy001Ou    : TCIB_C_KY_0001R_OUT;
*)



FUNCTION _Nh_WEB_WSB_SHW {HIDDEN}  : BOOL                // Vyhodnotenie n-Click,press,Hold z HW WSB,GLAS
   _Nh_WEB_WSB_SHW := false;
(*
   _Nh_WEB_WSB_SHW := false;
   CASE xWsb^.al.clk.Shw OF
     0 : ;
     1 : xWsb^.al.clk.Shw  := 0;
         xWsb^.al.sta      := 0;
         xWsb^.al.ou.val   := 0.0;                                               // vypne zobrazenie
         _NhDevRef(xR  := xWsb);
         _Nh_WEB_WSB_SHW := true;
   ELSE  xWsb^.al.clk.Shw := xWsb^.al.clk.Shw - aSys.n1Sec;
   END_CASE;
*)
END_FUNCTION

(*
FUNCTION	_Nh_NEW_BTN {HIDDEN} : BOOL
   xWsb^.al.et       := 0;                                  // dolezite pre ukoncenie, resetuje xWsb^.al.Qf
	xWsb^.al.sta		:= 1;	
 	xWsb^.al.ou.val	:= SINT_TO_REAL(j);
  	xWsb^.al.ou.par   := 0;                                  // resetne minuly Click
	xWsb^.al.clk.Lck  := 0;                                  // tu sa pocita celkovy cas stlacenia
  	xWsb^.al.clk.shw  := 0;                                  // zotrvacnost zobrazenia po pusteni BTN [sec]
   _NhDevRef(xR  := xWsb);
END_FUNCTION
*)

(*
FUNCTION _Nh_TLA_BTN_SW  {HIDDEN}  : BOOL             // z HW WSB,TGL vyhodnoti n-Click,Press a apise do al.ou.Val=:btn, par:=n-Click/Press, CMD:=9 je impulz pri vyhodnoteni
   VAR_INPUT
		wsb	: BOOL;									// stary tyo WSB, ktory nema HW-press ale BTN su zaradne za sebou
		Nbr	: SINT;									// max pocet Btn (u TLA hw-adries za sebou)
		hw		: PTR_TO UDINT;
//      me    : PTR_TO NH_BTN_CLICK;          // cela MEM, kde je stary a novy stav pre vyhodnotenie
      cx    : PTR_TO NH_CFG_CLICK;          // zaciatok CFX je rovnaky pre vsetky
   END_VAR
	VAR
      bt		: PTR_TO BOOL;                // HW adresa prveho btn		
		nxt	: UDINT;		
		j		: SINT;
	END_VAR

   _Nh_TLA_BTN_SW := false;
   IF xWsb^.al.clk.Busy THEN                               // uz je stlaceny HW btn (vyhodnoteny v minulom cykle)
		IF wsb THEN
	      nxt 			:= USINT_TO_UDINT(xWsb^.al.clk.Nbr-1) ;            // posuv HW adresy vyhodnotenia CLICK alebo PRESS
			bt 			:= UDINT_TO_PTR(hw^);
			bt				:= bt + nxt;
		ELSE
	      nxt 			:= USINT_TO_UDINT(xWsb^.al.clk.Nbr-1) * 4;            // posuv HW adresy vyhodnotenia CLICK alebo PRESS
			hw				:= hw + nxt;
			bt 			:= UDINT_TO_PTR(hw^);
		END_IF;

		xWsb^.al.clk.et 		:= xWsb^.al.clk.et + aSys.mSec;
      CASE xWsb^.al.clk.wht OF
		  0 : // vsetko sa vyhodnotilo, caka sa pustenim BTN
				IF bt^ = false THEN
					_NhMemClrPTR(size := SIZEOF(NH_BTN_CLICK) ,dest := ADR(xWsb^.al.clk));					
  					xDev^.al.RMP      := 4;                                  // zotrvacnost zobrazenia po pusteni BTN [sec]
				END_IF;		
        1 : // caka sa na pustenie BTN - vyhodnoti sa Click, alebo zaciatok press
				IF bt^ = false THEN
					xWsb^.al.clk.Click := xWsb^.al.clk.Click + 1;
               IF xWsb^.al.clk.Click >= 5  OR cx^.Click = 0  THEN     // max 5 Clickov a cas cakania je nastaveny
						_Nh_TLA_BTN_SW := true;					
						xWsb^.al.clk.wht			:= 0;
					ELSE
						xWsb^.al.clk.et			:= 0;		
						xWsb^.al.clk.wht			:= 2;
					END_IF;
				ELSIF cx^.Press = 0 THEN  	
					;
				ELSIF xWsb^.al.clk.et >= USINT_TO_UINT(cx^.Press) * 100 THEN  	// dosiahol sa press
					xWsb^.al.clk.wht		:= 6;
				END_IF;

        2 : // caka sa na dalsi Click - nove stlacenie
				IF bt^ THEN
					xWsb^.al.clk.wht		:= 1;
				ELSIF xWsb^.al.clk.et >= USINT_TO_UINT(cx^.Click) * 100 THEN	// cakanie za dalsim clickom sa skoncilo				
					_Nh_TLA_BTN_SW := true;					
					xWsb^.al.clk.wht			:= 0;
				END_IF

        6 : // prebieha PRS,HOL, zaseknuty BTN
				IF bt^ = false THEN
					_Nh_TLA_BTN_SW := true;					
					xWsb^.al.clk.wht			:= 0;
				ELSE
					xWsb^.al.clk.Click 		:=	6;
					_Nh_TLA_BTN_SW := true;					
				END_IF;		
      END_CASE;
   ELSE   // (0) caka sa na stlacenie
//		xWsb^.al.clk.Nbr 	:= 0;
		xWsb^.al.clk.Busy 	:= false;
		FOR j := 0 TO Nbr-1 DO
			IF hw^ > 0 THEN											// hw.d[0..5]. na zaciatku je namapovane vzdy hw := ADR(na hw.d[0])
				IF wsb THEN
					IF j = 0 THEN
						bt 	:= UDINT_TO_PTR(hw^);				// v prvom vstupe sa bt namapuje na prvy BTN WSB = Up
					ELSE
						bt		:= bt + 1;                       // presunie pointer na dalsi BTN
					END_IF;
				ELSE
					bt 	:= UDINT_TO_PTR(hw^);              	// pri TLA sa zoberie dalsia HW adresa z hw.d[0..5]
				END_IF;
				IF bt^ THEN
					_Nh_NEW_BTN();
					xWsb^.al.clk.Click   := 0;
					xWsb^.al.clk.et	   := 0;
					xWsb^.al.clk.wht 		:= 1;
					xWsb^.al.clk.Busy 	:= true;
					xWsb^.al.clk.Nbr		:= SINT_TO_USINT(j)+1;
					xDev^.al.ou.val	:= USINT_TO_REAL(xWsb^.al.clk.Nbr);
					EXIT;	
				END_IF;
				IF wsb = false	THEN
					hw	:= hw + 4;							         // pri TLA sa presunie na dalsiu addresu hw.d[0..5]
				END_IF;
   		END_IF;
		END_FOR;
  END_IF;
END_FUNCTION
*)

FUNCTION _Nh_LED_REFRESH_TGL  {HIDDEN} : BOOL;
	_Nh_LED_REFRESH_TGL := true;
	FOR i := 1 TO xTgl^.cx.cfC.nBTNs DO
		IF xCfL^.LEDbRun[i] OR xCfL^.Sleep THEN					// niektory  btn je off alebo centralny sleep
			xLedR^	:= 0;
			xLedG^	:= 0;
			xLedO^	:= 0;
		ELSE
			xLedR^	:= xCfL^.LEDs.btn[i].rgb[1];
			xLedG^	:= xCfL^.LEDs.btn[i].rgb[2];
			xLedO^	:= xCfL^.LEDs.btn[i].rgb[3];
      END_IF;
		xLedR		:= xLedR + 1;				
		xLedG		:= xLedG + 1;				
		xLedO		:= xLedO + 1;				
	END_FOR;
END_FUNCTION


FUNCTION _Nh_LED_SET_RGB_BTN {HIDDEN} : BOOL;
	_Nh_LED_SET_RGB_BTN := true;
	FOR i := 1 TO xTgl^.cx.cfC.nBTNs DO
		xTgl^.cx.cfL.LEDs.btn[i].rgb := _eBtn3;
		IF xTgl^.cx.cfL.BtnRgb > 0 AND						// nejaka farba, nie WHITE
		   xTgl^.al.DEV[i]			THEN                 // a ma vazbu k DEV
	      xCfL^.LEDs.btn[i].rgb[ xTgl^.cx.cfL.BtnRgb ] := true;
		END_IF;			
	END_FOR;
END_FUNCTION

(*
FUNCTION _Nh_BTN_LED_NBR : USINT
	VAR_INPUT
		cf		: USINT;
		btn   : USINT;
	END_VAR
	CASE cf OF
     40 : _Nh_BTN_LED_NBR := btn;
   ELSE   _Nh_BTN_LED_NBR := (btn + MOD(btn,2)) / 2;
   END_CASE;			
END_FUNCTION
*)

FUNCTION _Nh_LED_REFRESH_WSB {HIDDEN} : BOOL;
	FOR i := 1 TO xTgl^.cx.cfC.nBTNs DO
(*
		IF xTgl^.al.HET[i] = false THEN
			xCfL^.LEDs.btn[i].rgb := _eBtn3;
		ELSIF xCfL^.LEDs.btn[i].rgb[3] THEN
			xLedR^	:= true;
			xLedG^	:= true;
		ELSE	
			xLedR^	:= xCfL^.LEDs.btn[i].rgb[1];
			xLedG^	:= xCfL^.LEDs.btn[i].rgb[2];
      END_IF;
*)		

	IF MOD(i,2) = 0 THEN				
		IF xCfL^.LEDbRun[i] OR xCfL^.Sleep THEN					// niektory  btn je off alebo centralny sleep
			xLedR^	:= 0;
			xLedG^	:= 0;
		ELSIF xCfL^.LEDs.btn[i].rgb[3] THEN
			xLedR^	:= true;
			xLedG^	:= true;
		ELSE	
			xLedR^	:= xCfL^.LEDs.btn[i].rgb[1];
			xLedG^	:= xCfL^.LEDs.btn[i].rgb[2];
      END_IF;
		
//		IF MOD(i,2) = 0 THEN		
			xLedR		:= xLedR + 2;				
			xLedG		:= xLedG + 2;				
		END_IF;
	END_FOR;
END_FUNCTION

FUNCTION _Nh_TGL_LED_SET_SLEEP {HIDDEN} : BOOL;
	xCfL^.etSlp := USINT_TO_INT(xCfL^.DaySlp[xRom^.me.DayObr]) * 15;
	IF xCfL^.sleep THEN                                         // je zaspate, tento click len zobudi, ale neposle CMD
		IF xTgl^.al.HET[ xCfL^.BtnBli ]  THEN					      // len ak je stlaceny HET-btn, pri svetle funguje okamzite
			xCfL^.BlkOuCMD := true;											// pri zobudeni zablokuje poslanie CMD /clicku z TGL
		END_IF;
	END_IF;
	IF xCfL^.etSlp = 0 THEN													// nebude sleep
		xCfL^.etSlp 		:= -1;
	END_IF;
	xCfL^.sleep 		:= false;
	xCfL^.refresh 		:= true;			
	_Nh_TGL_LED_SET_SLEEP := xCfL^.etSlp > 0;
END_FUNCTION

FUNCTION _Nh_TGL_LED_RUN {HIDDEN}  : BOOL;
	_Nh_TGL_LED_RUN 	:= true;
	xTgl^.al.Qf			:= false;											// priznak pre preberatie hodnoty z HET/HEV...

	IF cf = 13 THEN
		IF xTgl^.al.cli.trg.Qr THEN	//OR xCfL^.ChgHet THEN                            				// zaciatok noveho clicku na BTN
			xCfL^.BtnBli := xTgl^.al.cli.OutBtn;		
			_Nh_TGL_LED_SET_SLEEP();	
		END_IF;	
	ELSIF xTgl^.al.cli.trg.Qr THEN	//OR xCfL^.ChgHet THEN                            				// zaciatok noveho clicku na BTN
		IF xCfL^.cmd = 2 THEN                                    		// ak prave nieco blika na beznom BTN, nie HET, zrusi to
			xCfL^.LEDS.btn[ xCfL^.BtnBli ].rgb := xCfL^.LED1bck.rgb;		// obnovi zapnute LED pred stlacenim
		END_IF;
		xCfL^.BtnBli := xTgl^.al.cli.OutBtn;		
		i := 0;
		IF xCfL^.sleep THEN
			xCfL^.etSlp	:= -2;
		ELSIF xTgl^.al.HET[ xCfL^.BtnBli ] THEN						// stlaceny BTN Ma HET vazbu
			xTgl^.al.Qf			:= true;
			IF xCfL^.BtnHet = xCfL^.BtnBli THEN
//				i 	:= 3;                                  						// DEFAULT zapne GREEN
				i 	:= 4;                                  						// DEFAULT zapne GREEN
			ELSE
				xCfL^.BlkOuCMD := true;										// zablokuje poslanie CMD /clicku z TGL
			END_IF;
			xCfL^.BtnHet := xCfL^.BtnBli;

		ELSIF xTgl^.al.DEV[ xCfL^.BtnBli ] THEN						// tento BTN ma vazbu na nejake ine DEV
			i 	:= 2;                                  						// DEFAULT zapne GREEN
		ELSE
			i	:= 1;
		END_IF;
		IF i > 0 THEN
			xCfL^.LED1bck.rgb		:= xCfL^.LEDS.btn[ xCfL^.BtnBli ].rgb; 	// zalohuje LED na stlacenom btn
			IF i < 3 THEN                                               // nie je HET btb
				xCfL^.LEDS.btn[ xCfL^.BtnBli ].rgb 	:= _eBtn3;	// najskor vsetky led resetne
				xCfL^.LEDS.btn[ xCfL^.BtnBli ].rgb[i] := true;		// nastavi vybratu LED {R alebo G}
				xCfL^.blik.wht 	:= 102;                             // 3 x preblikne 200ms
				xCfL^.blik.nbr 	:= 3;			

      	ELSE
				xCfL^.blik.wht 	:= 1;                               // HET btn - blika po 1s
				xCfL^.blik.nbr 	:= 5;			                        // blika 5x ziadana hodnota
			END_IF;
			// zoznam BTN
	 		xCfL^.LEDbOff  								:= _1Btn8;	         			// pri blikani budu vsetky LED na vsetkych btn OFF
			xCfL^.LEDbOff[ xCfL^.BtnBli ]  	:= false;	         			// okrem stlaceneho btn
			xCfL^.LEDbRun									:= xCfL^.LEDbOff;    			// defaultne sa zapne
			xCfL^.cmd				:= 2;
			xCfL^.blik.RunOn 	:= true;			
		END_IF;					
	ELSIF xTgl^.al.in.cmd = 7 THEN
		_Nh_TGL_LED_SET_SLEEP();
		xTgl^.al.Qf	:= true;   								
	ELSIF xTgl^.al.in.cmd = 36 THEN										// nastavit LED nad funkcnym tlacidlom
		_Nh_LED_SET_RGB_BTN();
		_Nh_TGL_LED_SET_SLEEP();     										
		xTgl^.al.Qf	:= true;
	END_IF;
	xTgl^.cx.cfL.blik();
	CASE xCfL^.etSlp OF
	  -1: // kontrolovat prebudenie podla pir
			IF (xCfL^.PirWake AND xRom^.me.BodyQ) THEN				// zobudit pohybom v miestnosti
				_Nh_TGL_LED_SET_SLEEP();     								// zobudit
			END_IF;	
	  -2: // len prebudit a neposlat CMD
			_Nh_TGL_LED_SET_SLEEP();

	   0: // nastavit sleep;
			xCfL^.Sleep 			:= true;
			xCfL^.refresh 			:= true;			
			xCfL^.etSlp				:= -1;
//			xCfL^.LEDbRun  		:= _1Btn8;

   ELSE	// bezi sleep time		
			IF xCfL^.PirRst AND xRom^.me.BodyQ THEN
				_Nh_TGL_LED_SET_SLEEP();
			ELSE
				xCfL^.etSlp := xCfL^.etSlp - aSys.i1Sec;
			END_IF;
   END_CASE;

	CASE xCfL^.cmd OF
     0: ;
	  2: // blika jednym BTN
			IF xCfL^.blik.Qn THEN			
				xCfL^.LEDS.btn[ xCfL^.BtnBli ].rgb := xCfL^.LED1bck.rgb;	// obnovi zapnute LED pred stlacenoim
		 		xCfL^.LEDbRun  		:= _eBtn8;	               			// odblokuje vsetky BTN
				xCfL^.cmd				:= 3;
				xCfL^.blik.wht 		:= 3;                               // bude bilat 10s/ON - 1s/OFF
				xCfL^.blik.nbr 		:= 0;			
				xTgl^.al.Qf				:= true;                       		// preberie hodnoty z HET
				_Nh_TGL_LED_SET_SLEEP();
			ELSIF xCfL^.blik.Qi = false THEN
				xCfL^.refresh	:= false;
			ELSIF xCfL^.blik.Q THEN
				xCfL^.LEDbRun		:= xCfL^.LEDbOff;
				xCfL^.refresh	:= true;
			ELSE
	         xCfL^.LEDbRun  	:= _1Btn8;										// vsetky LED, vratane toho,ktorym sa blika su vypnute
				xCfL^.refresh	:= true;
			END_IF;
     3:
			IF xCfL^.blik.Qi = false THEN
				;
			ELSIF xCfL^.Sleep THEN
				;
//				xCfL^.refresh 		:= true;			
			ELSIF xCfL^.blik.Q THEN
				xCfL^.LEDbRun		:= _eBtn8;                             // vsetky BTN ak maju nejake LED svietia
				xCfL^.refresh		:= true;
			ELSE
	         xCfL^.LEDbRun  	:= xTgl^.al.PRG;                      	// su vypnute le PRG led
				xCfL^.refresh		:= true;
			END_IF;
   END_CASE;
	IF xTgl^.al.cli.Q THEN									// prenasa sa vystupny prikaz z TGL
		IF xCfL^.BlkOuCMD THEN
			xTgl^.al.ou.CMD := 0;                   	// zablokuje ho bud prebudenie zo sleep alebo prepnutie medzi inymi het
		END_IF;
	ELSIF xTgl^.al.cli.trg.Qf THEN
		xCfL^.BlkOuCMD	:= false;
	END_IF;


   xTgl^.al.cm   		:= xCfL^.cmd;						// koli kompatibilite


	xTgl^.al.DEV		:= _eBtn8;							// k tomuto BTN je priradena funkcia
	xTgl^.al.HET 		:= _eBtn8;                    // tento BTN ovlada HET,VEN...
	xTgl^.al.PRG 		:= _eBtn8;                    // vynuluje tiem btn, kde bezi program

END_FUNCTION





(*

	ok := _Nh_Dev_ET_UINT(et:=ADR(xCfL^.etBli), t:=0 );

//               xCfL^.LEDbOff  := xWsb^.al.het;									// nic nie jeblokovane

	CASE xCfL^.cmd OF
     	0:	// ziadna z LED nie je blokovana
			xCfL^.LEDbRun  := _eBtn8;	
      	IF xTgl^.al.prg THEN
				xCfL^.cmd := 11;
	      END_IF;

		1: // uz blika pravidelne - program
			IF ok THEN			
             xCfL^.LEDbRun  := _eBtn8;										// nic nie jeblokovane
	         IF xWsb^.al.prg = false THEN									// netreba blikat, ziadny BTN neriadie regulator
					xCfL^.cmd 	:= 0;
	         ELSIF xWsb^.al.het = _eBtn8 THEN									// netreba blikat, ziadny BTN neriadie regulator
					;
//					xCfL^.cmd 	:= 0;
				ELSIF xCfL^.up THEN												// je ON, nasleduje OFF technologickyc BTN
					xCfL^.up			:= false;	
					xCfL^.etBli 	:= 1000;	//USINT_TO_UINT(xCfL^.tBlOff) * 100;				// 0.1S -> 0.001 S
               xCfL^.LEDbRun  := xWsb^.al.het;									// nic nie jeblokovane
				ELSE
					xCfL^.up			:= true;	
					xCfL^.etBli		:= 5000;	//USINT_TO_UINT(xCfL^.tBlOn) * 100;				// 0.1S -> 0.001 S
	         END_IF;
				xCfL^.refresh	:= true;
			END_IF;

		2: // blika rychlo - zmena
			IF ok THEN			
				xCfL^.etBli 		:= 300;												// 0.1S -> 0.001 S
				xCfL^.nBli	:= xCfL^.nBli - 1;
	         IF xCfL^.nBli = 0 THEN													// koniec zablikania
					xCfL^.LEDS.btn[xCfL^.BtnBli].rgb := xCfL^.LED1bck.rgb;	// obnovi zapnute LED pred stlacenoim
					xCfL^.cmd 			:= 0;
	            xCfL^.LEDbRun  	:= _eBtn8;										// nic nie jeblokovane
				ELSIF xCfL^.up	THEN														// je ON, nasleduje OFF
					xCfL^.up			:= false;	
               xCfL^.LEDbRun  := xCfL^.LEDbOFF;									// vsetko vypne, okrem jedneho btn coma svietit
				ELSE
					xCfL^.up			:= true;	
               xCfL^.LEDbRun  := _1Btn8;											// vsetko !! vypne
	         END_IF;
				xCfL^.refresh	:= true;
			END_IF;

		3: // svieti len stlaceny BTN, osatne NIE
			IF ok THEN			
				xCfL^.LEDS.btn[xCfL^.BtnBli].rgb := xCfL^.LED1bck.rgb;	// obnovi zapnute LED pred stlacenoim
            xCfL^.LEDbRun  	:= _eBtn8;										// nic nie jeblokovane
				xCfL^.cmd 		:= 0;
				xCfL^.refresh	:= true;
			END_IF;

	  11:	// start pravidelneho blikania - program
			xCfL^.LEDbOff  	:= xWsb^.al.het;										// vypnute budu len technologicke BTN
			xCfL^.LEDbRun  	:= _eBtn8;
			xCfL^.up				:= true;
			xCfL^.etBli 		:= 1000;			
			xCfL^.cmd			:= 1;
			xCfL^.refresh		:= true;

	  12:	// start rychleho zablikania - stlacenie BTN na ovladaci, alebo webe

			xCfL^.BtnQr			:= true;											// impulz pri stlaceni Btn

			IF xCfL^.BtnBli > 0 AND xCfL^.BtnBli <=8 THEN											// prebudi a zablika xCfL^.btn.Nbr > 0 AND xCfL^.btn.Nbr <= 8 THEN
				xCfL^.LED1bck.rgb					:= xCfL^.LEDS.btn[xCfL^.BtnBli].rgb;       // zalohuje rozsvietene LED pred stalcenim
				IF xWsb^.al.btn[xCfL^.BtnBli] THEN									// tento BTN ma vazbu
//					IF xCfL^.LEDS.btn[xCfL^.BtnBli] = _eBtn3 THEN    			// nema ziadnu LED rozsvietenu
						xCfL^.LEDS.btn[xCfL^.BtnBli].rgb 	:= _eBtn3;
						xCfL^.LEDS.btn[xCfL^.BtnBli].rgb[2] := true;				// zapne green
//					END_IF;
				ELSIF xWsb^.al.het[xCfL^.BtnBli] = false THEN					// nie je technologicky
//					IF xCfL^.LEDS.btn[xCfL^.BtnBli] = _eBtn3 THEN    			// nema ziadnu LED rozsvietenu
						xCfL^.LEDS.btn[xCfL^.BtnBli].rgb 	:= _eBtn3;
						xCfL^.LEDS.btn[xCfL^.BtnBli].rgb[1] := true;				// zapne RED
//					END_IF;
				END_IF;
           	xCfL^.LEDbOff  					:= _1Btn8;	                   				// OFF vsetky vypnute
           	xCfL^.LEDbOff[xCfL^.BtnBli]  	:= false;	                   				// okrem stlaceneho
				xCfL^.LEDbRun		:= xCfL^.LEDbOff;
				xCfL^.up				:= true;									// 5 x zablika
				xCfL^.nBli			:= 6;									// 5 x zablika
				xCfL^.etBli 		:= 300;								// 0.5 min na zaciatku svieti a ostatne zhasnu
				xCfL^.cmd			:= 2;
			ELSE
				xCfL^.cmd			:= 0;			
			END_IF;
			xCfL^.refresh		:= true;

	  13:	// refresh
			xCfL^.cmd			:= 0;
			xCfL^.refresh		:= true;

   ELSE	// upratat
		   xCfL^.sleep 	:= false;
		   xCfL^.refresh 	:= true;
   		xCfL^.cmd 		:= 0;
   END_CASE;


	xTgl^.al.in.cmd 	:= 0;
	xTgl^.al.btn		:= _eBtn8;							// k tomuto BTN je priradena funkcia
	xTgl^.al.het 		:= _eBtn8;                    // tento BTN ovlada HET,VEN...
	xTgl^.al.prg		:= false;


END_FUNCTION
*)




FUNCTION _Nh_DIS_REFRESH {HIDDEN} : BOOL
	VAR_INPUT
		tg2	: USINT;
	END_VAR
	_Nh_DIS_REFRESH := true;
(*
	// preverit !!!!
	IF xTgl^.al.HET = _eBtn8 THEN
		IF xCfd^.WhtDisp > 1 THEN
			xCfd^.WhtDisp := 0;
		END_IF;
	ELSIF xCfd^.WhtDisp = 0 THEN
		xCfd^.WhtDisp := 3;
	END_IF;
*)	
	
	CASE xCfd^.WhtDisp OF
     0 : xTgl^.al.in.val := xRom^.al.ou.val;							// teplota miestnosti
     1 : _NhxZon(c:=3, nz:=2, x:=-32 );								// vonkajsia teplota
	  		xTgl^.al.in.val := xZon^.al.ou.val;
	  2 : ;
   END_CASE;
	IF tg2 = 1 THEN
		CASE xCfd^.WhtFmt OF
		  0 :	// teplota teplota vo formate 99.9, -9.9, -10, 999
	         xGlas2^.cont.DOT1A := 0;
         	IF xTgl^.al.in.val > 99.9 OR xTgl^.al.in.val < -9.9 THEN
      	      xGlas2^.cont.DOT2A := 0;
   	         xGlas2^.DISPA      := REAL_TO_INT(xTgl^.al.in.val);
	         ELSE
         	   xGlas2^.cont.DOT2A := 1;
      	      xGlas2^.DISPA      := REAL_TO_INT(xTgl^.al.in.val * 10.0) ;
   	      END_IF;
		ELSE	// bez korekcie
         	xGlas2^.cont.DOT1A := 0;
      	   xGlas2^.cont.DOT2A := 0;
   	      xGlas2^.DISPA      := REAL_TO_INT(xTgl^.al.in.val);
		END_CASE;
	ELSE
		CASE xCfd^.WhtFmt OF
		  0 :	// teplota teplota vo formate 99.9, -9.9, -10, 999
	         xGlas^.cont.DOT1A := 0;
         	IF xTgl^.al.in.val > 99.9 OR xTgl^.al.in.val < -9.9 THEN
      	      xGlas^.cont.DOT2A := 0;
   	         xGlas^.DISPA      := REAL_TO_INT(xTgl^.al.in.val);
	         ELSE
         	   xGlas^.cont.DOT2A := 1;
      	      xGlas^.DISPA      := REAL_TO_INT(xTgl^.al.in.val * 10.0) ;
   	      END_IF;
		ELSE	// bez korekcie
         	xGlas^.cont.DOT1A := 0;
      	   xGlas^.cont.DOT2A := 0;
   	      xGlas^.DISPA      := REAL_TO_INT(xTgl^.al.in.val);
		END_CASE;
	END_IF;
END_FUNCTION



FUNCTION _Nh_TGL_DIS_SET_SLEEP {HIDDEN} : BOOL;
	xCfd^.etSlp := USINT_TO_INT(xCfd^.DaySlp[xRom^.me.DayObr]) * 15;
	IF xCfd^.etSlp = 0 THEN													// nebude sleep
		xCfd^.etSlp 		:= -1;
	END_IF;
	xCfd^.sleep 		:= false;
	xCfd^.refresh 		:= true;			
	_Nh_TGL_DIS_SET_SLEEP := xCfd^.etSlp > 0;
END_FUNCTION


FUNCTION _Nh_TGL_DIS_RUN  {HIDDEN}  : BOOL;
	_Nh_TGL_DIS_RUN := true;
	IF xTgl^.al.in.cmd = 7 THEN
		_Nh_TGL_LED_SET_SLEEP();
	END_IF;
	CASE xCfd^.etSlp OF
	  -1: // kontrolovat prebudenie podla pir
			IF xCfd^.PirWake AND xRom^.me.BodyQ THEN
				_Nh_TGL_DIS_SET_SLEEP();
			END_IF;	
	  -2: // prebudit
			_Nh_TGL_DIS_SET_SLEEP();
			xCfd^.Off 			:= false;
			
	   0: // nastavit sleep;
			xCfd^.Sleep 			:= true;
			xCfd^.refresh 			:= true;			
			xCfd^.etSlp				:= -1;
   ELSE	// bezi sleep time		
			IF xCfd^.PirRst AND xRom^.me.BodyQ THEN
				_Nh_TGL_DIS_SET_SLEEP();
			ELSE
				xCfd^.etSlp := xCfd^.etSlp - aSys.i1Sec;
			END_IF;
   END_CASE;
	CASE xCfL^.cmd OF
     0: ;
	  2: // blika jednym BTN
			xCfD^.refresh	:= xCfL^.blik.Qi;
			IF xCfL^.BtnHet <> xCfL^.BtnBli THEN			
				xCfd^.off		:= true;
				xCfD^.refresh	:= true;
			ELSIF xCfL^.blik.Qn THEN			
				xCfd^.off		:= false;
				xCfD^.refresh	:= true;
				_Nh_TGL_DIS_SET_SLEEP();				
			ELSIF xCfL^.blik.Q THEN
				xCfd^.off		:= false;
			ELSE
				xCfd^.off		:= true;
			END_IF;
     3:
			IF xCfD^.sleep THEN
				;
			ELSIF xCfL^.blik.Qi THEN
//				_Nh_TGL_DIS_SET_SLEEP();
				xCfd^.off		:= false;
				xCfD^.refresh	:= true;
			END_IF;

   END_CASE;

END_FUNCTION

FUNCTION _Nh_Click_BTN {HIDDEN} : BOOL
	VAR_INPUT
		n	: USINT;
	END_VAR
	FOR i := 1 TO n DO
		IF xPtB^ THEN                                  					// prvy btn
			_Nh_Click_BTN	:= true;                                  // zisti sa ktory BTN to je
			_NhDevRef(xR  := xDev);												// urobi sa aj refresh pre WEB
			RETURN;
		END_IF;
		xPtB := xPtB + 1;															// nastavime na dali click
	END_FOR;
	_Nh_Click_BTN	:= false;                                  		// zisti sa ktory BTN to je
END_FUNCTION

FUNCTION _Nh_CR_HET_dev {HIDDEN} : BOOL
  	VAR_INPUT
  		dev	: PTR_TO NH_DEV_SW;
	END_VAR
	IF dev^.c > 0 AND dev^.n > 0 THEN
		_Nh_CR_HET_dev := _NhxPt(c:=dev^.c, n:=dev^.n);
	ELSE
		_Nh_CR_HET_dev := false;
	END_IF;		 	
END_FUNCTION

FUNCTION_BLOCK _Nh_Create_HET
	VAR
		go		: USINT;
		kot	: NH_DEV_SW;
		cer	: NH_DEV_SW;
		dev	: PTR_TO NH_DEV_SW;
		tv		: INT;		
	END_VAR
	CASE go OF
     0 : // nastavit KOT,CER
			cf := 7;
			FOR nd := 1 TO aCfg[cf].rec DO
				IF _NhxPt(c:=cf, n:=nd) THEN
					kot.c := cf;
					kot.n := nd;
					exit;
				END_IF;
         END_FOR;
			cf := 9;
			FOR nd := 1 TO aCfg[cf].rec DO
				IF _NhxPt(c:=cf, n:=nd) THEN
					cer.c := cf;
					cer.n := nd;
					exit;
				END_IF;
         END_FOR;
			go 	:= 1;
			tv   	:= 1;
     1 : //
			WHILE tv <= aCfg[8].rec DO
				IF _NhxPt(c:=8, n:=tv) THEN
					xTve	:= xPt;
					_NhxRom(nr:=xTve^.cf.rom);
					cf := 17;															// TEH = teplota podlahy
					FOR nd := 1 TO aCfg[cf].rec DO
						IF _NhxPt(c:=cf, n:=nd) THEN
							IF xPt^.cf.rom = xTve^.cf.rom THEN              // TEH je v tej istej miestnosti ako TVE
								dev := ADR(xTve^.io[1].dev);
								IF _Nh_CR_HET_dev(dev := dev) = false THEN
									dev^.c := cf;                    	// priradi TVE TEH
									dev^.n := nd;
								END_IF;
								exit;
							END_IF;
						END_IF;
      		   END_FOR;
					cf := 6;																// HET regulator
					ok	:= true;


					FOR nd := 1 TO aCfg[cf].rec DO									
						IF _NhxPt(c:=cf, n:=nd) THEN
							IF xPt^.cf.rom = xTve^.cf.rom THEN              // hlada sa TEH v rom, kde je TVE
								xHet := xPt;
								dev := ADR(xHet^.io[0].dev);
								IF _Nh_CR_HET_dev(dev := dev) = false THEN
									dev^.c	 := 1;							// teplota miestnosti
									dev^.n	 := USINT_TO_INT(xTve^.cf.rom);	// cislo miestnosti													 	
								END_IF;
								dev := ADR(xHet^.io[1].dev);
								IF _Nh_CR_HET_dev(dev := dev) = false THEN
									dev^.c	 := 8;          				// TVE
									dev^.n	 := tv;														 	
								END_IF;
								dev := ADR(xHet^.io[2].dev);
								IF _Nh_CR_HET_dev(dev := dev) = false THEN
									dev^	 := kot;                   // kotol je vacsinou pre vsetkych rovnaky
								END_IF;
								dev := ADR(xHet^.io[3].dev);
								IF _Nh_CR_HET_dev(dev := dev) = false THEN
									dev^	 := cer;                   // kotol je vacsinou pre vsetkych rovnaky
								END_IF;
								ok		:= false;
								exit;
							END_IF;
						END_IF;
      		   END_FOR;
					IF ok THEN															// nenasla sa veta HET
						yIO.n := _NhFindDel(wh := 0, cx := cf, new := true); // hlada sa vymazana, hned sa ozznaci za platnu
						IF  yIO.n > 0 THEN	
				 			xHet           := xDel;
        					xHet^.cf.idx   := yIO.n;
             			xHet^.cf.Name  := xRom^.cf.Name;
                     xHet^.cf.rom   := xTve^.cf.rom;
                     xHet^.cf.cat   := 5;
							xHet^.cf.typ 	:= 0;
							yIO.p := _NhFindDel(wh := 1, cx := aCfg[cf].par, new := true, nOk:=true);
							IF yIO.p > 0 THEN
                     	xHet^.cf.par   := yIO.p;										// potom sa musi restartovat, a oprava parametrov prideli
							ELSE
                     	xHet^.cf.par   := aPar[ aCfg[cf].par ].rec + aPar[ aCfg[cf].par ].new;								
								ok	:= false;
							END_IF;
						ELSE
							ok	:= false;
						END_IF;
						If ok = false THEN
							_Nh_Go_DbxToMem(ram := true, dbx := true );
							EXIT;
						END_IF;
					END_IF;
				END_IF;
				tv := tv + 1;
         END_WHILE;
			IF tv > aCfg[8].rec THEN
				aSys.ini 		:= 0;
				go 				:= 0;
			END_IF;
   END_CASE;
END_FUNCTION_BLOCK

FUNCTION _Nh_Typ_Day_Fix {HIDDEN} : BOOL 			// podla priznaku fix prideluje typove dni do Hom,Zon,Rom
	// xRom=aktualna miestnost, xZon=vyssia zona  su uz namapovane
	VAR_INPUT
		Go			: BOOL := true;
		home		: BOOL;
		xDay		: PTR_TO NH_POI_DAY;
		xFix		: PTR_TO NH_POI_FIX;
	END_VAR;
	_Nh_Typ_Day_Fix	:= true;
	If go THEN
		CASE xFix^.wht OF
	     0 : // nikdy
   	  1 : // prave teraz / z vyssej zony
				IF home THEN
					xDay^.Day := SYSTEM_S.COUNTER_DAYS_OF_WEEK ;
				ELSE
					xDay^.Day	:= xZon^.cx.pDay.Day;
				END_IF;
   	ELSE
	   ;
   	END_CASE;
	END_IF;	
	IF xDay^.Day < 1 or xDay^.Day > 11 THEN
		xDay^.Day := SYSTEM_S.COUNTER_DAYS_OF_WEEK ;
	END_IF;
END_FUNCTION


FUNCTION _Nh_Dev_CMD   : BOOL    // spracuje nove CMD (prvy impulz)
	IF aCfg[cf].analog = false THEN                                //SVD,ZAS
		cmd := 10;
	ELSE
		cmd := cf;
	END_IF;		
	_NhDevRef(xR  := xDev);
END_FUNCTION

FUNCTION _Nh_Dev_OFF_SCN  : BOOL    // co s ma spracovat po vypnuti casom
	VAR_INPUT
		all		: BOOL := true;	
		cmd		: USINT;
	END_VAR
	_Nh_Dev_OFF_SCN := true;
	xDev^.al.ex    	:= 0;
 	xDev^.al.et    	:= 0;
 	xDev^.al.cm    	:= 0;   					// hlavny CASE
	xDev^.al.el			:=	0;
	IF all	THEN
		xDev^.al.In.val   := 0.0;
		xDev^.al.Ou.val   := 0.0;
		xDev^.al.in.CMD   := 0;
		xDev^.al.Ou.CMD   := cmd;
	END_IF;
	_NhDevRef(xR  := xDev);
END_FUNCTION

FUNCTION _Nh_Dev_OFF  : BOOL    // co s ma spracovat po vypnuti casom
	VAR_INPUT
		cmd		: USINT := 10;	
	END_VAR
	_Nh_Dev_OFF := true;
	xDev^.al.ex    	:= 0;
 	xDev^.al.et    	:= 0;
 	xDev^.al.cm    	:= 0;
 	xDev^.al.Up    	:= false;
	xDev^.al.In.val   := 0.0;
	IF cmd = 0 THEN
		xDev^.al.Ou.val   := 0.0;
	ELSE
		xDev^.al.in.CMD   := cmd;
	END_IF;	
END_FUNCTION

FUNCTION _Nh_Dim_SW {HIDDEN} : BOOL;
	_Nh_Dim_SW := false;
	IF xDev^.al.el >= 3  THEN                               // pustene tlacitko/slider
(*
		IF aCfg[cf].Lvl254 THEN										// DALI
			IF xDev^.al.up THEN
				xDev^.al.IN.val	:= MIN(254.0, xDev^.al.IN.val + 10.0 );
			ELSE
				xDev^.al.IN.val	:= MAX(1.0, xDev^.al.IN.val - 10.0 );
			END_IF;
		ELSIF xDev^.al.up THEN                          	// 0-100   	
*)
		IF xDev^.al.up THEN                          	// 0-100   	
			xDev^.al.IN.val	:= MIN(100.0, xDev^.al.IN.val + 3.0 );				
		ELSE
			xDev^.al.IN.val	:= MAX(1.0, xDev^.al.IN.val - 3.0 );
		END_IF;
		_Nh_Dim_SW := true;	
	ELSe
		_Nh_Dim_SW := false;	
	END_IF;
END_FUNCTION

(*
FUNCTION _Nh_SVX_Bl_PIR   : BOOL    // rovnake CMD z Qr vyhodnoti a nastavi defaut CM, val...
   IF xDev^.cx.all.LastCMD > 0 THEN         										// povolene prikazy testuju blokovanie PIR a oneskorenie
//	   _NhxRom(nr := xDev^.cf.rom, x:=-10);
//      _NhxPar(cp := aCfg[cf].par , np := xDev^.al.ou.par, cf:=cf, nd:=nd, x:=110); // xPar = NH_RGB_PAR ma aj svd,sva,rgb
//	   IF xDev^.al.wsb = false THEN                                   // nic sa nedeje neprislo z WSB {mozno z ACT..SCN}
		IF xDev^.cx.all.LastWsb = false THEN
   	   ;
	   ELSIF  xDev^.al.in.val > 0.0 AND xPar^.all.BlPirON THEN       	// je ON
   	   xRom^.me.BlPirOn    := 50;  	                             	// zapnutie od WSB/WEB vzdy blokuje PIR
   	   xRom^.me.BlPirOff   := 0;                               		// resetne sa cas blokovania po vypnuti
	   ELSIF xPar^.all.BlPirOff AND xRom^.cx.BlPirOFF > 0 THEN 			// kontrola na blokovanie PIR po vypnuti WSB/WEB
   		xRom^.me.BlPirOff := MAX(xRom^.me.BlPirOff,xRom^.cx.BlPirOFF); // max cas blokovania po vypnuti
	   END_IF   ;
	END_IF;
END_FUNCTION
*)

FUNCTION _Nh_SVX_Bl_PIR  {HIDDEN}   : BOOL    // rovnake CMD z Qr vyhodnoti a nastavi defaut CM, val...
   IF xDev^.al.in.CMD  > 0 THEN         										// povolene prikazy testuju blokovanie PIR a oneskorenie
	   IF xDev^.al.wsb = false THEN                                   // nic sa nedeje neprislo z WSB {mozno z ACT..SCN}
   	   ;
	   ELSIF  xDev^.al.in.val > 0.0 AND xPar^.all.BlPirON THEN       	// je ON
   	   xRom^.me.BlPirOn    := 50;  	                             	// zapnutie od WSB/WEB vzdy blokuje PIR
   	   xRom^.me.BlPirOff   := 0;                               		// resetne sa cas blokovania po vypnuti
	   ELSIF xPar^.all.BlPirOff AND xRom^.cx.BlPirOFF > 0 THEN 			// kontrola na blokovanie PIR po vypnuti WSB/WEB
   		xRom^.me.BlPirOff := MAX(xRom^.me.BlPirOff,xRom^.cx.BlPirOFF); // max cas blokovania po vypnuti
	   END_IF   ;
	END_IF;
END_FUNCTION


FUNCTION _NH_NEXT_ET {HIDDEN} : UINT
	VAR_INPUT
		xNhDT	: PTR_TO NH_DT_M;			// +4 294  295967
	END_VAR
	VAR_TEMP
		etReq : UINT;
		etAct	: UINT;
	END_VAR
	etAct	:= USINT_TO_UINT(SYSTEM_S.COUNTER_HOURS) * 60 + USINT_TO_UINT(SYSTEM_S.COUNTER_MINUTES) ;
	IF xNhDT^.hour = 0 THEN
		etReQ	:= 24 * 60 + USINT_TO_UINT(xNhDT^.min) ;	
	ELSE
		etReQ	:= USINT_TO_UINT(xNhDT^.hour) * 60 + USINT_TO_UINT(xNhDT^.min) ;	
	END_IF;
	IF etReQ >= etAct THEN         // 18:30-17:20 1110-1040=70,	 18:30-17:50 1110-1070=40, 18:30-18:30  // 00:00-19:30 1440-1170=270,
		_NH_NEXT_ET := etReQ - etAct;
	ELSE                           // 18:30-19:30 1110-1170=-60+24*60=1380   1110+270=1380
		_NH_NEXT_ET := 24*60 - (etAct - etReQ);
	END_IF;              						
END_FUNCTION


FUNCTION _NH_ADD_TIME_TIME {HIDDEN} : BOOL
	VAR_INPUT
		xDTa		: PTR_TO NH_DT_M;				// sem sa ma pricitat
		xDTb		: PTR_TO NH_DT_M;			   // z tohto sa ma pricitat
	END_VAR
	_NH_ADD_TIME_TIME := true;
	xDTa^.min := xDTa^.min + xDTb^.min;
	IF xDTa^.min > 59 THEN							// 2:60 -> 3:00  , 2:61 => 3:01
		xDTa^.hour 	:= xDTa^.hour + 1;
		xDTa^.min	:= xDTa^.min - 60;		
	END_IF;	
	xDTa^.hour := xDTa^.hour + xDTb^.hour;		
	IF xDTa^.hour > 23 THEN                  // 24 -> 00:  25 -> 01:00
		xDTa^.hour 	:= xDTa^.hour - 24;
	END_IF;	
END_FUNCTION

FUNCTION _Nh_ALARM_ROM {HIDDEN} : BOOL
	j 		:= 0;
	ok		:= false;
	FOR i := 1 TO INT_TO_USINT(aCfg[1].rec) DO
		IF _NhxRom(nr := i) THEN
			IF xRom^.me.BodyQ THEN
				ok	:= true;
				IF j > 0 THEN
					_Nh_MSG_TXT := CONCAT(_Nh_MSG_TXT,',');
				END_IF;
				_Nh_MSG_TXT := CONCAT(_Nh_MSG_TXT,xRom^.cf.Name);
				j := j + 1;
			END_IF;			
		END_IF;	
   END_FOR;


	IF ok THEN

	ELSe
	END_IF;

END_FUNCTION

FUNCTION _Nh_MSG_ALARM_ROM  {HIDDEN}  : BOOL	// do _Nh_MSG_TXT vlozi "Alarm " + zoznam miestnosti
	VAR_INPUT
		rom	: BOOL;	// pridat miestnosti kde je pohyb
	END_VAR	
	_Nh_MSG_ALARM_ROM := false;
	IF _Nh_MSG_TXT = '' THEN
//   	RETURN;
	END_IF;
	IF rom THEN	
	   _Nh_ALARM_ROM();								// do yTx1 pozbiera nazvy miestnosti, kde je prave pohyb
	END_IF;
	IF fbWebPush.webPush.busy = false AND _Nh_MSG_TXT <> '' THEN
		fbWebPush.send := true;									// uvolni odosilanie
	END_IF;	
	IF fbNotify.busy = false  THEN
		yTx0 			:= CONCAT('{',xHom^.cf.Name,'} ',_Nh_MSG_TXT);
		_Nh_MSG_TXT := '';
		sz := CP1250_TO_UTF8(cp1250:=yTx0,utf8:=_Nh_MSG_TXT,maxLen := 255);  // yTx1->_Nh_MSG_TXT skonvertuje diakritiku
		fbNotify.go := 1;									// uvolni odosilanie
	END_IF;	
END_FUNCTION


FUNCTION _Nh_ROM_LOCK_RUN  {HIDDEN} : BOOL
	ok		:= _Nh_Dev_ET_UINT(t:=1,et := ADR(xLck^.et));
	IF xLck^.et > 0 THEN
   	_NhDevRef(xR := xDev);               	//ROM
    	_NhDevRef(xR := xZon);
     	_NhDevRef(xR := xHom);
   END_IF;

// xLck^.tRst := 15;

   CASE xLck^.Stat OF
      0: // Unlocked
			xRom^.cx.lck.et		:= 0;		
      1: // odchod - Locking

         IF ok THEN
            xLck^.Stat 			:= 2;
         END_IF;

      2: // Locked

         IF xRom^.me.PsnQr THEN  									// 1.vsup do zamknutej zony
            xLck^.et   			:= MAX(xLck^.tdIn,1);         // nastavit prichodove oneskorenie
            xLck^.Stat    		:= 3;
				xRom^.al.ou.cmd	:= 63;								// 	
         END_IF;

      3: // prichodove oneskorenie
         IF xHom^.cx.lck.Stat > 4 THEN           				// koniec casu prichodu
         	xLck^.et   		:= xHom^.cx.lck.et;					// nastavit autorestart alarmu
   	      xLck^.Stat     := xHom^.cx.lck.stat;
         ELSIF ok THEN           										// koniec casu prichodu
				IF xLck^.tDog > 0  THEN
	            xLck^.et  			:= xLck^.tDog;             // presun na ostrazitost
   	         xLck^.Stat  		:= 4;
				ELSIF xLck^.tNar > 0 THEN                                           // ak nie je DOG a ide rovno do alarmu, ale caka na pohyb
	            xLck^.et   		:= xLck^.tNar;						// nastavit autorestart alarmu
   	         xLck^.Stat     := 5;
				ELSE
	            xLck^.et   		:= xLck^.tRst;						// nastavit autorestart alarmu
   	         xLck^.Stat     := 6;
				END_IF;
         END_IF;

      4: // Dog - ostrazitost
         IF xRom^.me.PsnQr OR xHom^.cx.lck.Stat > 4 THEN  									// pohyb v ostrazitosti vyvola okamzite alarm
				IF xLck^.tNar > 0 AND xHom^.cx.lck.stat <= 5 THEN
	            xLck^.et   			:= MAX(1,xLck^.tNar);      // presun na NARUSENIE
   	         xLck^.Stat    		:= 5;
				ELSE
					xLck^.et   			:= xLck^.tRst;               	// + nastavit autorestart alarmu
   	         xLck^.Stat     	:= 6;
//					_Nh_MSG_TXT := CONCAT('{',xHom^.cf.Name,'}: Narušenie: ');
					_Nh_MSG_TXT := 'Narušenie: ';
					_Nh_MSG_ALARM_ROM(rom:=1);
				END_IF;
         ELSIF ok THEN													// v priebehu ostrazitosi nebol pohyb
				xRom^.al.ou.cmd	:= 67;								// obnovenie strazenia po Ostrazitosti
            xLck^.Stat    		:= 2;                         // ipulz po ukoncenie
				xRom^.cx.lck.et	:= 0;		
         END_IF;

      5: // NARUSENIE = tichy poplach
         IF ok THEN														// nebol pohyb, presunie sa do urovne ALARM
				xLck^.et   			:= xLck^.tRst;               	// + nastavit autorestart alarmu
            xLck^.Stat     	:= 6;
         END_IF;

      6: // ALARM
         IF ok THEN														// nebol pohyb, presunie sa do urovne ALARM
				xLck^.et   			:= 0;               	
            xLck^.Stat     	:= 2;
				xRom^.al.ou.cmd	:= 68;								// obnovenie strazenia po Ostrazitosti

         ELSIF xRom^.me.PsnQr THEN  								// pohyb
            xLck^.et   			:= xLck^.tRst;						// nastavit autorestart alarmu
				xRom^.al.ou.cmd	:= 66;								// ALARM
         END_IF;
	END_CASE;

	xRom^.al.sta	:= xLck^.Stat;


	IF xZon^.cx.lck.LockRom AND xLck^.LockRom AND xLck^.stat < 2 THEN	// ROM aj zona sa zamykaju a ROM nie je zmknuta
		xZon^.cx.lck.AllLocked	:= false;                           	// priznak do vyssej ZON,HOM, ze nie vsetky ROM su zamknute
		xHom^.cx.lck.AllLocked	:= false;                           	// priznak do vyssej ZON,HOM, ze nie vsetky ROM su zamknute
	END_IF;
	xZon^.cx.lck.stat	:= MAX(xZon^.cx.lck.stat, 	xRom^.cx.lck.stat) ;  // ak by bol
	xZon^.cx.lck.et	:= MAX(xZon^.cx.lck.et, 	xRom^.cx.lck.et) ;
	xZon^.al.sta		:= xZon^.cx.lck.stat;

	xHom^.cx.lck.stat	:= MAX(xHom^.cx.lck.stat, 	xRom^.cx.lck.stat) ;  // ak by bol
	xHom^.cx.lck.et	:= MAX(xHom^.cx.lck.et, 	xRom^.cx.lck.et) ;
	xHom^.al.sta		:= xHom^.cx.lck.stat;


END_FUNCTION


FUNCTION _Nh_ROM_LOCK_START {HIDDEN}  : BOOL		// aktualnu ROM/ZONE zamkne/odomkne a preberie udaje							
	VAR_INPUT
//		zon	: BOOL := true;							// aktualizuje status vyssej zony
	END_VAR
	_Nh_ROM_LOCK_START := true;
	CASE xRom^.al.OU.CMD OF
     56:	// lock
			IF xRom^.cx.lck.FromZone            		               // miestost dovoli prepisat parametre z vyssej zony
				AND xZon^.cx.lck.FromZone THEN								// zona dovoli pouzit svoje udaje
					xRom^.cx.lck.tdOu	:= xZon^.cx.lck.tdOu;
					xRom^.cx.lck.tdIn	:= xZon^.cx.lck.tdIn;
					xRom^.cx.lck.tDog	:= xZon^.cx.lck.tDog;
					xRom^.cx.lck.tNar	:= xZon^.cx.lck.tNar;
					xRom^.cx.lck.tRst	:= xZon^.cx.lck.tRst;
			END_IF;
			IF xRom^.cx.lck.LockRom THEN
				xRom^.cx.lck.stat 	:= 1;
    			xRom^.cx.lck.et  		:= MAX(xRom^.cx.lck.tdOu,1);     // nastavit ODCHODOVE oneskorenie
				xRom^.al.trg.Qr 		:= true;									// priznak pre miestnost, ze v zone bol LOCK/UNLOCK
			END_IF;                                           			
     57:	// unlock
			xRom^.cx.lck.stat 	:= 0;
			xRom^.cx.lck.et 		:= 0;
			xRom^.al.trg.Qr 		:= true;											// priznak pre miestnost, ze v zone bol LOCK/UNLOCK
	ELSE	
//			RETURN;
  	END_CASE;
	xRom^.al.sta		:= xRom^.cx.lck.stat;	
(*
	IF zon THEN
		xZon^.cx.lck.stat	:= MAX(xZon^.cx.lck.stat, 	xRom^.cx.lck.stat) ;  // ak by bol
		xZon^.cx.lck.et	:= MAX(xZon^.cx.lck.et, 	xRom^.cx.lck.et) ;
		xZon^.al.sta		:= xZon^.cx.lck.stat;
	END_IF;
*)
END_FUNCTION

FUNCTION _Nh_ROM_CMD_IN {HIDDEN}   : BOOL  // ukladanie hodnot do ROM a nasledne do ZON
	VAR_INPUT
//		zon	: BOOL;			// dotyk bol na zone, nie na HOM
	END_VAR
	xRom^.al.ou.CMD 	:= 0;
	xRom^.al.trg.Qr 	:= false;
	_Nh_ROM_CMD_IN		:= false;
	IF xRoM^.al.in.CMD > 0 THEN                                       // na in.CMD moze prist len 55,56,57
		_Nh_ROM_CMD_IN	 := true;													// priznak 55 LOCK/UNLOCK,
		xRoM^.al.trg.Qr := true;
		xRoM^.al.ou.CMD := xRoM^.al.in.CMD;										// pre vsetky ZON prenesie vstup na vystup, ak je 0 tak vynuluje
		IF xRoM^.al.in.CMD = 55 THEN												// prepni LOCK-UNLOCK
      	IF xRoM^.cx.lck.stat > 0 THEN
				xRoM^.al.ou.CMD := 57;												// unlock
			ELSE
				xRoM^.al.ou.CMD := 56;												// LOCK
			END_IF;
		END_IF;

		_Nh_ROM_LOCK_START();														// podla ou.CMD vykona LOCK/UNLOCK + preberie udaje zo zony
(*
		IF zon THEN
			xHom^.al.sta 		:= 0;
			xHom^.cx.lck.et 	:= 0;
			xHom^.cx.lck.stat := 0;
		END_IF;
*)
	END_IF;
	xRom^.al.in.CMD 	:= 0;																// vsetky ZON
END_FUNCTION


VAR_GLOBAL
	xRa	: PTR_TO NH_ROL_ANAL_DATA;
END_VAR

FUNCTION _Nh_INVALID_REAL {HIDDEN}  :BOOL		// otestuje ci vReal je v medziach (vMin,vMax) a tiez ci je vysledok platne real cislo, inak ho nahradi vMin
	VAR_INPUT
		vReal		: PTR_TO REAL;			// premenna
		vInit		: REAL;            	// ak je chybne REL cislo, inicializuje sa tymto
		vMin		: REAL;					// minimum
		vMax		: REAL := 100.0;    // maximum
	END_VAR
	_Nh_INVALID_REAL := true;
	IF IS_INVALID_REAL(vReal^) THEN
		vReal^ := vInit;
	ELSIF vReal^ > vMax THEN
		vReal^ := vMax;	
	ELSIF vReal^ < vMin THEN
		vReal^ := vMin;	
	END_IF;
END_FUNCTION

FUNCTION _Nh_ROL_Tst_Real {HIDDEN}  :BOOL									// prvy vstup do Up/Dn, ked sa na zaciatku cyklu zapol motor
	_Nh_ROL_Tst_Real := true;
	_Nh_INVALID_REAL(vReal:=ADR(xRol^.cx.yLam));
	_Nh_INVALID_REAL(vReal:=ADR(xRol^.cx.yRol));
	_Nh_INVALID_REAL(vReal:=ADR(xRol^.me.tRun));
	_Nh_INVALID_REAL(vReal:=ADR(xRol^.me.iRol));
	_Nh_INVALID_REAL(vReal:=ADR(xRol^.me.iLam));
	_Nh_INVALID_REAL(vReal:=ADR(xRol^.me.yLamOld));
	_Nh_INVALID_REAL(vReal:=ADR(xRol^.me.yRolOld));
END_FUNCTION

FUNCTION _Nh_ROL_HW  :BOOL															// zapnut/vypnut motor v HW
	VAR_INPUT
//		Break 		: BOOL;			// Ak sa ziada u,Dn, nestopne motor ak ide v spravnom smere
		Up				: BOOL;		   // spusti motor Up
		Dn				: BOOL;        // spusti motor Dn
	END_VAR	
	_Nh_ROL_HW				:= xLedR^ OR xLedG^;	// OR xRol^.cx.cmd > 200;
	xRol^.cx.DelayStart  := false;					                        // vzdy sa zrusi odlozeny start
	IF _Nh_ROL_HW THEN																	// je zapnuty nejaky motor
		xRol^.cx.MotStat 	:= 7;														   // len nastavi poziadavku na zastavenie motorov
		xLedR^ 				:= 0;															
		xLedG^				:= 0;
		up						:= false;                                       // resetnu sa pripadne prikazy Up,Dn
		dn						:= false;
	END_IF;
	IF up THEN
		xRol^.al.sta		:= 3;																	// hore sa zacina lamelami
		xRol^.cx.cmd 		:= 201;									
		xRol^.me.UpChg 	:= xRol^.cx.Up = false;
		xRol^.cx.Up 		:= true;	
		xLedR^ 				:= 1;
		xLedG^				:= 0;
		IF xRol^.cx.cf.tUp.Rol > 0 THEN
			xRol^.me.iRol	:= 100 / (UINT_TO_REAL(xRol^.cx.cf.tUp.Rol) * 10.0) ;   	// Rol su [10 mS]
		ELSE
			xRol^.me.iRol	:= 1000.0; 	
		END_IF;
		IF xRol^.cx.cf.tUp.Lam	> 0 THEN
			xRol^.me.iLam	:= 100.0 /  UINT_TO_REAL(xRol^.cx.cf.tUp.Lam);		// Lam su [mS]
		ELSE
			xRol^.al.sta	:= 4;																// preskocia sa lamely, ide sa na rol
			xRol^.me.iLam	:= 0.0;	
			xRol^.cx.yLam	:= 100.0;														// ak nema naklapanie lamely, vzdy su zatiahnute
			xRol^.cx.uLam	:= 100;			
			xRol^.cx.pLam	:= 100;			
		END_IF;
	ELSIF dn	THEN
		xRol^.al.sta		:= 5;                               						// dolu sa zacina lamelami
		xRol^.cx.cmd 		:= 202;									
		xRol^.me.UpChg 	:= xRol^.cx.Up;
		xRol^.cx.Up 		:= false;	
		xLedR^ 				:= 0;
		xLedG^				:= 1;
		IF xRol^.cx.cf.tDn.Rol > 0 THEN
			xRol^.me.iRol	:= 100 / (UINT_TO_REAL(xRol^.cx.cf.tDn.Rol) * 10.0) ;   	// Rol su [10 mS]
		ELSE
			xRol^.me.iRol	:= 1000.0; 	
		END_IF;
		IF xRol^.cx.cf.tDn.Lam	> 0 THEN
			xRol^.me.iLam	:= 100.0 /  UINT_TO_REAL(xRol^.cx.cf.tDn.Lam);		// Lam su [mS]
		ELSE
			xRol^.al.sta	:= 6;				
			xRol^.me.iLam	:= 0.0;	
			xRol^.cx.yLam	:= 100.0;														// ak nema naklapanie lamely, vzdy su zatiahnute
			xRol^.cx.uLam	:= 100;			
			xRol^.cx.pLam	:= 100;			
		END_IF;
	END_IF;
	IF up OR dn THEN
		xRol^.cx.MotStat 	:= 1;														// v tomo cykle sa nastavili premenne ale rele sa zopne az na zaciatku noverho cyklu
		xRol^.me.yLamOld	:= xRol^.cx.yLam;                            // zapamataju sa pozicie pred startom
		xRol^.me.yRolOld	:= xRol^.cx.yRol;
	END_IF;
    _NhDevRef(xR  := xRol);
END_FUNCTION

FUNCTION _Nh_ROL_200_Begin {HIDDEN}   :BOOL									// prvy vstup do Up/Dn, ked sa na zaciatku cyklu zapol motor
	// 0: lamely/roleta sa prestavuju
	// 1:	motor vypnuty - poziadavka na START v tomto cykle (len nastavi premenne, ale vypne sa az na zaciatku dalsieho cyklu)
	// 2: na zaciatku tohto cykly sa fyzicky zapol motor
	// 3: motor zapnuty
	
	// 7: motor zapnuty - poziadavka na STOP v tomto cykle (len nastavi premenne, ale vypne sa az na zaciatku dalsieho cyklu)
	// 8: na zaciatku tohto cyklu sa vypol motor


	_Nh_ROL_200_Begin := true;
	IF xRol^.cx.cmd = 201 THEN
		xRolT := ADR(xRol^.cx.cf.tUp);											// nampuje konkretnu sadu pre pohyb Up
	ELSE
		xRolT := ADR(xRol^.cx.cf.tDn);		
	END_IF;

	_NhDT		:= GetRTC();																// aktualny strojovy cas pre tuto roletu

	xRol^.me.tCycle			:= TIME_TO_REAL( SUB_DT_DT( _NhDT ,xRol^.me.RtcStamp) );
	xRol^.me.tFromBegin		:= TIME_TO_REAL( SUB_DT_DT( _NhDT ,aSys.NhDT) );


	xRol^.me.tToBegin			:= TIME_TO_REAL( SUB_DT_DT( aSys.NhDT ,xRol^.me.RtcStamp) );

	cmd		:= 0;
	ok			:= true;
	CASE xRol^.cx.MotStat OF
	  	0: // roleta/lamela sa presuva
			;
  		1: // poziadavka na zapnutie motora nastavila zopnutie rele, ktore sa zopne na zaciatku nasledujuceho cyklu
//			_NhMemSetPTR(size := SIZEOF(NH_ROL_ANAL), dest:= ADR(xRol^.me.a) );
			_Nh_ROL_200_Begin := false;
	  		xRol^.cx.MotStat	:= 2;	
	   	ok						:= false;
			IF xRol^.cx.CmdWind	> 9 AND xRol^.al.wsb THEN														// rucny zasah pri v ochannej pozici
				IF xRol^.cx.cf.WindGuardBlkTime > 0 THEN
					xRol^.cx.etHandBlkWind 	:= xRol^.cx.cf.WindGuardBlkTime;	// restartne sa cas blokovania
					xRol^.cx.etHandBlkWind 	:= 30;
					xRol^.cx.CmdWind			:= 20;     										// nastavi blokovanie ochrany rucnym zasahom
				ELSE
					xRol^.cx.etHandBlkWind 	:= 0;				
				END_IF;
			END_IF;
		2: // na zaciatku tohto cyklu sa zapol motor, moze mat nejake opozdenie
			IF xRol^.me.UpChg	THEN                                            	// zmena smeru
				_NhTime 				:= UINT_TO_TIME(USINT_TO_UINT(xRolT^.chg)*10);  // opozdenie motora  len pri zmene smeru a starte
				xRol^.me.UpChg		:= false;
			ELSE
				_NhTime 				:= UINT_TO_TIME(USINT_TO_UINT(xRolT^.Mot)*10);  // opozdenie motora pri rovnakom pohybe
			END_IF;		
			xRol^.cx.tStart	:= ADD_DT_TIME(aSys.NhDT, _NhTime );      		// cas  skutocneho startu = zaciatok cyklu + opozdenie motora
			xRol^.cx.MotStat	:= 3;
			IF _NhDT  < xRol^.cx.tStart THEN
				ok 				:= false;
            xRol^.me.tRun  := 0.0;
	  		END_IF;  	
	   3: // motor zapnuty - roleta sa pohybuje
			;
	  	7: // prvy vstup Break / STOP - v tomto cykle vypnu premenne motora, na zaciatku dalsieho vypne fyzicky motor
			cmd	:= 99;
	  	8: // na zaciatku tohto cyklu sa vypol motor - tu zisti uz realny cas, kolko bol motor zapnuty od startu, ;
			IF xRol^.al.cm = 30 THEN
				xRol^.al.et 	:= USINT_TO_UINT( xRol^.cx.cf.tPvHwLam ) * 100;	 				// cas prestavok medzi HW predvolbami lamiel
			ELSE
				xRol^.al.et 	:= USINT_TO_UINT(xRol^.cx.cf.tDelayRev) * 100;					// ochranna doba ( [0.1s]  * 100  = [mS]
			END_IF;
			xRol^.me.tRun		:= TIME_TO_REAL(SUB_DT_DT( aSys.NhDT ,xRol^.cx.tStart));   	// od uplneho zaciatku az po zaciatok tohto cyklu
			// ked je STOP, oneskorenie motora sa nepripocita lebo sa nezmeni smer, len sa vypne rele, co by nemalo mat az taku zotrvacnost
			ok 					:= false;
			xRol^.me.tToBegin	:= 0.0;			// podhodi sa 0 pre vypocet vr = predpoklad do konca cyklu
	END_CASE;
	IF ok THEN	// cas od zaciatku pozubu povysenny o odhad casu az do konca tohto cyklu (aby sa este v tomto cykle aplikoval stop)
		// predpokladany cas, od zaciatku pohybu doteraz + odhad kolko by este uplynulo do konca tohto cyklu aby sa dal urobit STOP
(*
		xRol^.me.tRun		:= 	TIME_TO_REAL( SUB_DT_DT( _NhDT ,xRol^.cx.tStart) )				// od zaciatku pohybu po teraz
									+	TIME_TO_REAL( SUB_DT_DT( aSys.NhDT ,xRol^.me.RtcStamp) );	// + predpoklad casu do konca tohto cyklu (aby sa mohlo vypnut uz v tomto cykle)

*)

		xRol^.me.tRun		:= 	TIME_TO_REAL( SUB_DT_DT( _NhDT ,xRol^.cx.tStart) );				// od zaciatku pohybu po teraz
	END_IF;
END_FUNCTION

FUNCTION _Nh_ROL_200_End   {HIDDEN}    :BOOL													// pri kontrole polohy Rolety
	_Nh_ROL_200_End	:= true;
	CASE cmd OF
		0:	;	
    203: // predlzit dojazd - kalibrovat
			IF (xRol^.cx.uRol <=  2 AND xRol^.cx.uLam <= 5) OR
			 	(xRol^.cx.uRol >= 98 AND xRol^.cx.uLam >= 95) THEN
				IF xRol^.cx.up	 THEN
					xRol^.cx.yRol 	:= 0.0;
					xRol^.cx.uRol 	:= 0;							
					xRol^.cx.yLam	:= 0.0;
					xRol^.cx.uLam 	:= 0;							
				ELSE
					xRol^.cx.yRol 	:= 100.0;
					xRol^.cx.uRol 	:= 100;							
					xRol^.cx.yLam	:= 100.0;
					xRol^.cx.uLam 	:= 100;							
				END_IF;			
				xRol^.al.et 		:= MAX(1,USINT_TO_UINT(xRol^.cx.cf.tDelayEnd) * 1000);	// ochanna doba ( [0.1s]  * 100  = [mS]
				xRol^.cx.cmd		:= 203;	
			ELSE

				IF _Nh_ROL_HW() = false THEN
					xRol^.cx.CMD 	:= 3;	

				END_IF;
			END_IF;
   END_CASE;
	CASE xRol^.cx.MotStat OF
     7 : // v romto cykle za zaradila poziadavka na vypnutie motora
	  		xRol^.cx.MotStat := 8;
     8 : // na zaciatku tohto cyklu sa vypol motor
			xRol^.cx.pRol		:= xRol^.cx.uRol;
			xRol^.cx.pLam		:= xRol^.cx.uLam;

			xRol^.cx.MotStat 	:= 0;							/////14.9/2024

   END_CASE;
	_NhDevRef(xR  := xRol);
END_FUNCTION


FUNCTION _Nh_ROL_Go_Pozi  {HIDDEN}     :BOOL			// korigovat poziadavku a spustit motor spravnym smerom
	_Nh_ROL_Go_Pozi  		:= true;
	IF xRol^.cx.pRol 	< xRol^.cx.uRol THEN                            // ROL ma sa vytiahnut ->0%
		IF xRol^.cx.pLam > 4 AND xRol^.al.CM <> 7 THEN						// lamela sa pozaduje po vytiahnuti este ZAKLOPIT > 0%
			// - Pri vytiahnuti sa lamela automaticky OTVORI na 0% preto:
			// 1. najskor sa roleta vytiahne, a Lamely zostanu na 0%
			// 2. v dalsom sa lamely sklopia do pozadovanej > 0%
      	xRol^.me.Que.Yes 	:= true;
      	xRol^.me.Que.pLam := xRol^.cx.pLam;
      	xRol^.me.Que.pRol := xRol^.cx.pRol;
			// toto je test			
//			xRol^.cx.pRol := MIN(100,xRol^.cx.pRol + 3);						// v prvom cykle sa povytiahne vyssie, lebo sa bude vracat
		END_IF;
		xRol^.cx.pLam 	:= 0;           	
		_Nh_ROL_HW(up:=1);
	ELSIF xRol^.cx.pRol 	> xRol^.cx.uRol THEN	                        // ma sa zatiahnut ->100%
		IF xRol^.cx.pLam < 96 AND xRol^.al.CM <> 7 THEN					// lamela maby POOTVORENA
			// - Pri ZATIAHNUTI sa lamela automaticky ZAKLOPI na 100% preto:
			// 1. najskor sa roleta ZATIAHNE, Lamely zostanu na 100%
			// 2. v dalsom sa lamely otvoria do pozadovanej < 100%
      	xRol^.me.Que.Yes 	:= true;
      	xRol^.me.Que.pLam := xRol^.cx.pLam;
      	xRol^.me.Que.pRol := xRol^.cx.pRol;
		END_IF;
		xRol^.cx.pLam 	:= 100;														// pri zatahovani sa najsor zaklopia LAM		->0%
		_Nh_ROL_HW(Dn:=1);
	ELSIF xRol^.cx.pLam	< xRol^.cx.uLam THEN                         // otvaraju sa len lamely	
		_Nh_ROL_HW(up:=1);
	ELSIF xRol^.cx.pLam 	> xRol^.cx.uLam THEN	                        // zatvaraju sa len lamely
		_Nh_ROL_HW(Dn:=1);
	ELSE
		_Nh_ROL_Go_Pozi  := false;
	END_IF;
END_FUNCTION


FUNCTION _Nh_ROL_Lam_UpDn    {HIDDEN}     :BOOL		// nastavit nsledujuci stupen lamely
	VAR_INPUT
		Up		: BOOL;
	END_VAR
	xRol^.cx.pRol	:= xRol^.cx.uRol;										// ROL sa nema pohybovat
	IF xRol^.al.CM <> 30 THEN												// nema pauzu medzi prevolbami
		_Nh_ROL_Lam_UpDn	:= false;
		RETURN ;
//		xRol^.al.CM 	:= 30;                                    // priznak posuvania po stupnoch
	END_IF;
	IF Up  THEN																	// smer Hore 100->0, lamela sa OTVARA
		xRol^.cx.pLam 	:= 0;                              			
		IF xRol^.cx.cf.tPvHwLam > 0 THEN
			FOR j := 3 TO 0 BY -1 DO                      			// ide sa od najvyssieho stupna
				IF xRol^.cx.cf.pv.hwLam[j] > 0 THEN
					IF xRol^.cx.cf.pv.hwLam[j] < xRol^.cx.uLam THEN
						xRol^.cx.pLam 	:= xRol^.cx.cf.pv.hwLam[j];
						EXIT;
					END_IF;
				END_IF;
  			END_FOR;
		END_IF;
		_Nh_ROL_Lam_UpDn := xRol^.cx.uLam > 0;              		// este nie je celkom otvorene
	ELSE                                                			// smer DOLU 0->100, lamela sa zatara
		xRol^.cx.pLam 	:= 100; 												// maximum je uplne otvorene
		IF xRol^.cx.cf.tPvHwLam > 0 THEN
			FOR i := 0 TO 3 DO                                 	// ide sa od najnizsieho stupna po najvyssi
				IF xRol^.cx.cf.pv.hwLam[i] > 0 THEN
					IF xRol^.cx.cf.pv.hwLam[i] > xRol^.cx.uLam THEN
						xRol^.cx.pLam 	:= xRol^.cx.cf.pv.hwLam[i];
						EXIT;
					END_IF;
				END_IF;
  			END_FOR;
		END_IF;
		_Nh_ROL_Lam_UpDn := xRol^.cx.uLam < 100;				// Este sa nedosiahla krajna pozicia = uplne otvorene
	END_IF;
//	_Nh_ROL_Lam_UpDn := xRol^.cx.pLam <> xRol^.cx.uLam;			// nastavila sa nova poziadavka
END_FUNCTION

FUNCTION _Nh_ROM_Dark  {HIDDEN}  : BOOL  // ukladanie hodnot do ROM a nasledne do ZON
						// LUX - sumrak	
						ok 	:= false;
						ok2   := xRom^.io[101].own = false AND													// nema ziadny LUX snimac
									xRom^.io[101].zon = false AND
									xRom^.io[101].out = false;
									
		            IF xRom^.cx.LuxPar.LuxYes THEN  	
							IF ok2 THEN
								;
							ELSIF xRom^.cx.LuxPar.LuxMin = 0 THEN												// je 0, nic sa nedeje
								;
	         		   ELSIF REAL_TO_USINT(xRom^.io[101].val) < xRom^.cx.LuxPar.LuxMin THEN		// osvetlenie je < ako nastavene minimum = je sumrak
               	   	xRom^.cx.Dark 	:= true;
								ok					:= true;
		            	ELSIF REAL_TO_USINT(xRom^.io[101].val) >= xRom^.cx.LuxPar.LuxMin THEN	// je svetlo
      	            	xRom^.cx.Dark := false;
	   	      	   END_IF;
						END_IF;	
      				// zaluzie sumrak
		            IF ok THEN																						// vybavene snimacom LUX				
							;
						ELSIF xRom^.cx.LuxPar.RolYes THEN                   								// uz je sumrak, alebo nie su rolety
							IF ok2 = false AND xRom^.io[101].val < 100.0 THEN                         // uz sa stmieva, pouzijersa koeficient
								ii	:= 	REAL_TO_USINT(
											MIN(101.0,USINT_TO_REAL(xRom^.me.DarkRolLvl) * xRom^.cx.LuxPar.KoefBli) // vynasobi real , vysledok je real
														 									) ;
							ELSE
								ii	:= xRom^.me.DarkRolLvl;	
							END_IF;
							IF ii  > xRom^.cx.LuxPar.RolMin THEN						// je zatienenie
		            	   xRom^.cx.Dark  := true;                                           	// urcite je zatienenie
							ELSE
		            	   xRom^.cx.Dark  := false;                                           	// urcite je zatienenie							
   						END_IF;

						END_IF;
END_FUNCTION

FUNCTION _Nh_ROL_Stat  {HIDDEN}  :BOOL  // nastavi status pre zobrazenie onrazka {al.sta}
	_Nh_ROL_Stat := true;
	xRol^.al.ou.val := 0.0;
	IF xRol^.cx.uRol < 100  THEN											// povytiahnute, lamely pootvotrene alebo zati
		// moze byt aj povytiahnute , ale lamely zatvorene
		xRol^.al.sta := 1;
	ELSIF xRol^.cx.uLam < 100 THEN										// zatiahnute dolu, ale pootvorene lamely
		xRol^.al.sta := 2;
	ELSE
		xRol^.al.sta := 0;												
//		xRol^.al.ou.val := 200.0;
	END_IF;

//	xRol^.al.ou.val := LIMIT(0.0, 100.0-xRol^.cx.yRol + 100.0-xRol^.cx.yLam ,200.0);

	xRol^.al.ou.val := LIMIT(0.0, xRol^.cx.yRol + xRol^.cx.yLam, 200.0);

	IF xRol^.cx.cf.SetDark THEN
		IF xRol^.cx.uRol > xRol^.cx.cf.DarkRol AND
			xRol^.cx.uLam > xRol^.cx.cf.DarkLam	THEN
			xRol^.me.dDark.In 	:= true;
		ELSE  	
			xRol^.me.dDark.In 	:= false;
		END_IF;
	END_IF;
	_NhDevRef(xR  := xRol);
END_FUNCTION

FUNCTION _Nh_ROL_Go_Rol  {HIDDEN}   : BOOL			// po spracovani pozicie lamiel presunie na ROL
  	VAR_INPUT
		sta	: USINT;
  	END_VAR
	_Nh_ROL_Go_Rol := true;
	IF sta = 4 THEN
		xRol^.me.yRolOld	:= xRol^.me.yRolOld + xRol^.cx.yLam;  			// v case zaciatku rolety treba ponizit pociatocny +ak nedosla LAM do konca, - ak presvihla koniec
		i						:= 0;
	ELSE
//		xRol^.me.yRolOld	:= xRol^.me.yRolOld + MAX(0.0, xRol^.cx.yLam - 100.0);  // v case zaciatku rolety treba povysit pociatocny stav rolety
		xRol^.me.yRolOld	:= xRol^.me.yRolOld + (xRol^.cx.yLam - 100.0);  // v case zaciatku rolety treba povysit pociatocny stav rolety
		i						:= 100;
	END_IF;
	xRol^.cx.yLam		:= USINT_TO_REAL(i);
	xRol^.cx.uLam		:= i;
	xRol^.cx.pLam 		:= i;							
	xRol^.me.tRun		:= 0.0;
	xRol^.cx.tStart	:= _NhDT;															// cas zaciatku pre Roletu := akt.cas
	xRol^.al.sta		:= sta;		                                          // presunie na ROL
END_FUNCTION

FUNCTION _Nh_Tve_Obr_OnOff {HIDDEN} : BOOL // podla HW oznaci obrazky predvolieb. Moze ich vsetky vypnut a nasledne zapnut na pozadovany stupen
   VAR_INPUT
      obr   : BOOL;           // oznacit obrazky a podla OFF aj povypinat HW
      off   : BOOL;           // vypnut vsetko
		inv	: BOOL;				// inverzne ON=OFF	
      lvl   : USINT;          // >0 = zapnut na lvl
		reg 	: PTR_TO NH_HET_REG;
		hw		: PTR_TO NH_DEV_HW3;
   END_VAR
   _Nh_Tve_Obr_OnOff := true;	
	   IF obr THEN       	
			reg^.btn 		:= _1Btn05;			
			xTve^.me.pvMax := 4;
			IF hw^.typ = 0 THEN					// ON/OFF vymaze stupne
				FOR j:= 5 TO 2 BY -1 DO				// max 3 stupne: hw: 0..2
  		   		IF hw^.d[j-2] = 0 THEN        //      d[0   1 2 3]		//
					  										//  0   1   2 3 4 		j:=4,hw.d[2]  j:=2,hw.d[0]
						reg^.BTN[j] := false;			// PRG-OFF/ON-2-3-4		len zobrazenie obrazkov
						xTve^.me.pvMax	:= xTve^.me.pvMax - 1;
					END_IF;
	   	   END_FOR;
			END_IF;
	   END_IF;
		IF OFF THEN             		
			IF lvl > 0 THEN
				lvl := MIN(4,lvl + 1);                        // pv:=1,	lvl:=1+1=2
			END_IF;
			FOR i := 2 TO 4 DO
				IF reg^.btn[i] THEN
					xPtB  := UDINT_TO_PTR(hw^.d[i-2]);
					IF lvl = i THEN
						xPtB^	:= true;		//NOT inv;    	// zapnut
					ELSE
						xPtB^	:= false;	//inv;  		   // vypnut
					END_IF;
					IF inv THEN
               	xPtB^ := NOT xPtB^;
					END_IF;
				END_IF;
			END_FOR;
		END_IF;
END_FUNCTION


FUNCTION _Nh_Poi_Het {HIDDEN} : BOOL
	// pre pv zapise do cas zmeny podla aktualneho poi grafu
	xPt := xHet;																// potrebne	pre _Nh_xPod_Map
	_Nh_xPod_Map(cf:=cf, WhtPoi:=xHet^.cx.reg.mode);
	_Nh_Poi_Obr_Chg(  pv := ADR(xPvA^.p.pv), chg:=adr(xHet^.cx.chg)); //, nd := xHet^.me.poi);
	// len zaktualizuje cas do ukoncenia  manualu
	_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xHet^.cx.chg), ref:=true);
END_FUNCTION

FUNCTION _NH_TVE_VAL_TO_PV  {HIDDEN}  : USINT     // podla HW oznaci PV. Moze ich vsetky vypnut a nasledne zapnut na pozadovany stupen
	i	:= REAL_TO_USINT(xTve^.al.in.val);
(*
	IF i <= xTve^.cx.pvp.pvLvl[0] THEN
		_NH_TVE_VAL_TO_PV := 0;
	ELSIF i <= xTve^.cx.pvp.pvLvl[1] THEN
		_NH_TVE_VAL_TO_PV := 1;
	ELSIF i <= xTve^.cx.pvp.pvLvl[2] THEN
		_NH_TVE_VAL_TO_PV := 2;
	ELSE
		_NH_TVE_VAL_TO_PV := 3;
	END_IF;
*)
END_FUNCTION

(*
	HE
	Spalna		21-30-100
	Pepo			21-30-100
	Obyvacka		18-30-100
	Erik			22-25-60
	Kuchyna		25-
*)

FUNCTION _NH_Tve_CMD   {HIDDEN}   : BOOL
	IF _Nh_Dev_REC(blk:=true) THEN
		_NH_Tve_CMD 	:= true;
		xHet		:= xDev;															// tot koli mapovaniu reg
		xTve		:= xDev;
		_NH_Het_Map_Reg();	
		xPvA  	:= ADR(xTve^.cx.par.pva);                      		// parameter
		xPva2 	:= ADR(xTve^.me.pvm);                              // vykonna pamat
   	xFix  	:= ADR(xTve^.cx.par.Fix);
		IF _Nh_Dev_Qx(in:=xDev^.al.in.CMD) THEN                  	// zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0, namapuje parameter
			CASE xTve^.al.in.CMD OF
				1: // z webu - stlaceny stavovy obr ON/OFF
					IF xPva2^.p.PV = 0 THEN
						xPvA^.p.pv := xTve^.me.pvMax ;
					ELSE
						xPvA^.p.pv := 0 ;
					END_IF;
					xPvA^.p.prg	:= false;
			END_CASE;
		ELSIF aSys.Restart THEN
			_Nh_Tve_Obr_OnOff(obr:=true, hw:=ADR(xTve^.hw), reg:=ADR(xTve^.cx.reg));
			xPva2^		:= xPvA^;                 					// po restarte vyrovna PV, aby sa neresetoval cas do konca 	
		ELSIF aSys.RefCyc = 3 THEN
			xPvA^.chg 		:= true;	//xPvA^.chg OR xPvA^.p.prg;							// aby neprestavovalo dtChg pri manuali !!!					
		END_IF;
		IF xPvA^.p.prg THEN																// ma byt program
			xPvA^.p.PV   		:= MIN(xTve^.me.pvMax,INT_TO_USINT(xTve^.al.in.par));					// kazdy cyklus sa prebera PV		
			xTve^.al.in.par	:= 0;                                  		// pripravi na dalsi otocku primania pri PRG
		END_IF;
		IF xPvA^ <> xPva2^ THEN
			_NhDevRef(xR := xTve);			
			IF xPvA^.p.prg THEN															// ma byt program
				xTve^.cx.chg.dtChg := UINT_TO_DT(0);								// nema casove obmedzenie
			ELSIF aSys.RefCyc > 0 THEN
//			ELSIF xPvA^.p.pv = xPva2^.p.pv THEN    						// ziadna zmena v man
				;
			ELSIF xFix^.wht = 1 THEN                                 		// prva zmena v automatike
            xFix^.wht := 0;                                       // TVE nema automatiku
  			ELSE
				_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xTve^.cx.chg) );   	// pri prepnuti na MAN zisti koniec z parametra
			END_IF;	
			_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xTve^.cx.chg), ref:=true); // aktualizuje cas do konca
	      xPvA^.chg	 		:= false;												// urcita zrusi zmenu
   	   xPva2^ 		:= xPvA^;                                    // vyrovna prevadzkovu pamat
		ELSIF	xTve^.cx.chg.dtChg = UINT_TO_DT(0) THEN                  // MAN sa nikdy neskonci - nepojde sa do porovnania
			;
		ELSIF xTve^.cx.chg.dtChg <= aSys.NhDT THEN                     // prave sa skoncil MAN
			xPvA^.p.prg   		:= true;	
			xPva2^ 		:= xPvA^;											// prevazdzkova pamat sa vyrovna z parametrom
			xPvA^.chg			:= true;												// po otocke aktualizuje cas aj predvolbu z POI
		END_IF;

		xPtIO 	:= ADR(xTve^.io[1]);												// teplota vyhrievacie teleso {podlahy}
		IF aSys.RefCyc > 0 THEN
			;
		ELSIF _Nh_IO_DEV(io := xPtIO) THEN
			IF xTve^.cx.reg.Guard THEN				// zapnut tepelne ochrany = zatial len TVE
				IF	xPtIO^.val = 0.0   OR                               		// nula je ako ze nedava teplotu
					xPtIO^.val <= -40.0 OR                              		// snimac ukazuje chujovinu
      	 		xPtIO^.val >= 124.0 THEN                            		// snimac ukazuje chujovinu
					xPtIO^.val := -0.0;													// toto sa zobrazi
		      ELSIF xTve^.cx.reg.Mode = 1 THEN       							// chladenie
					// CHLADENIE
		      	IF xTve^.cx.guard.val[1,1] > 0 AND REAL_TO_USINT(xPtIO^.val) > xTve^.cx.guard.val[1,1] THEN       // vysoka teplota
	      		   	xTve^.al.CM    	:= 110;
   	      		   xPvA^.p.prg      	:= false;
	   	         	xPva^.p.pv       	:= 1;
  	   		   ELSIF xTve^.cx.guard.val[1,0] > 0 AND REAL_TO_USINT(xPtIO^.val) < xTve^.cx.guard.val[1,0] THEN       // nizka teplota
	         			xTve^.al.CM    	:= 120;
	   	      	 	xPvA^.p.prg      	:= false;
   	   	     		xPva^.p.pv       	:= 0;
					ELSIF xTve^.al.CM > 100 THEN														// prave sa skoncilo obmedzenie
						xTve^.al.CM			:= 0;
			      	xPvA^.chg     		:= true;
      				xPvA^.p.prg      	:= true;
	      			xPva^.p.pv       	:= 0;
					END_IF;
		      	//KURENIE
				ELSIF xTve^.cx.guard.val[0,1] > 0 AND REAL_TO_USINT(xPtIO^.val) > xTve^.cx.guard.val[0,1] THEN       // vysoka teplota
      		   	xTve^.al.CM    	:= 110;
         		   xPvA^.p.prg      	:= false;
	            	xPva^.p.pv       	:= 0;
  	   	   ELSIF xTve^.cx.guard.val[0,0] > 0 AND REAL_TO_USINT(xPtIO^.val) < xTve^.cx.guard.val[0,0] THEN       // nizka teplota
	         		xTve^.al.CM    	:= 120;
	   	       	xPvA^.p.prg      	:= false;
   	   	     	xPva^.p.pv       	:= 1;
				ELSIF xTve^.al.CM > 100 THEN														// prave sa skoncilo obmedzenie
					xTve^.al.CM			:= 0;
		      	xPvA^.chg      	:= true;
      			xPvA^.p.prg      	:= true;
	      		xPva^.p.pv       	:= 0;
				END_IF
				IF xPtIO^.chg THEN
					xPvA^.chg := true;
				END_IF;				
			END_IF;
		ELSE
			xRegMod^.wht 			:= 0;												// pouzije sa hodnota vystupu			
		END_IF;
		xTve^.me.DIF(	pvNew		:= xPva2^.p.PV ); 					// zatial len oneskorenie stupna
		IF xTve^.me.DIF.Qchg THEN
			// zapise sa poziadavka, potom sa vyhodnoti realne do out
			xTve^.al.in.val	:= USINT_TO_REAL(xRegMod^.Out[ xPva2^.p.PV ]);  //xVal3^.val[ xPva2^.PV ];			
			xTve^.me.CMD		:= 10;		
			_NhDevRef(xR := xTve);					
		END_IF;

(*

		IF xRegMod^.wht = 1 THEN
			xHet^.al.ou.val		:= xPtIO^.val;									// reguluje sa teplota / CO2/ vlhkost
		ELSE
			xHet^.al.ou.val		:= USINT_TO_REAL(xRegMod^.Out[ xHet^.me.pvm.p.PV ]);
		END_IF;	
		xHet^.me.DIF(	pvNew		:= xHet^.me.pvm.p.PV, 	
							sample   := xHet^.cx.pPid.sample,
							out		=> xHet^.me.Out ) ;

		IF xHet^.al.sta <> xHet^.me.DIF.Sta THEN
			xHet^.al.sta := xHet^.me.DIF.Sta;
			_NhDevRef(xR := xHet);						
		END_IF;

		xTve^.me.pvDelay(	In	:= xPvA^.Qr, Delay := xTve^.cx.reg.Delay );	
		IF xTve^.me.pvDelay.Done THEN										// skoncilo opozdenie technologie
			xPvA^.Qr 			:= false;								// DOLEZITE !!!!
			xPva2^		:= xPvA^;
			xDev^.al.in.val	:= USINT_TO_REAL(xRegMod^.out[xPva2^.PV]);  //xVal3^.val[ xPva2^.PV ];			
			IF xPvA^.prg THEN														// ma byt program
				_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xTve^.cx.chg), ref := true, off:=true);	// vynuluje datum/cas konca
			END_IF;

			xTve^.me.CMD		:= 10;		
			_NhDevRef(xR := xDev);					
		END_IF;
		xPvA^.Qr 			:= false;								// DOLEZITE !!!!
*)

	



		xDev^.al.in.CMD	:= 0;







(*

		IF xPvA^.Qr THEN

			_NhDevRef(xR := xTve);			
			IF xPvA^.prg THEN														// ma byt program
				;
			ELSIF xPva2^.pv <> xPvA^.pv OR xPva2^.Qr THEN	// zmena v manuali, alebo stlacena ta ista predvolba
				IF xFix^.wht = 1 THEN                                 // prva zmena v automatike
					_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xTve^.cx.chg), ref := true, off:=true);	// vynuluje datum/cas konca
			  	ELSE
  					_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xTve^.cx.chg));   	// pri prepnuti na MAN zisti koniec z parametra
				END_IF;
			END_IF;	
			_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xTve^.cx.chg), ref:=true);	// urobi refresh zostavajuceho casu toChg
			xPva2^.Qr := false;
		ELSIF xPvA^.prg THEN                             							
			xPva2^.PV   := MIN(xTve^.me.pvMax,INT_TO_USINT(xTve^.al.in.par));					// kazdy cyklus sa prebera PV		
	  		xTve^.al.in.par	:= 0;                                  		// pripravi na dalsi otocku primania pri PRG
			xPvA^.Qr				:= xPvA^.pv <> xPva2^.PV;              // prisla zmena
			xPvA^.pv  			:= xPva2^.PV;									// vyrovna sa zmena
		ELSIF	xTve^.cx.chg.dtChg = UINT_TO_DT(0) THEN                  	// MAN sa nikdy neskonci - nepojde sa do porovnania
			;
		ELSIF xTve^.cx.chg.dtChg <= aSys.NhDT THEN                     	// prave sa skoncil MAN
			xPvA^.prg   	:= true;	
			xPvA^.Qr			:= true;
		END_IF;
		xPtIO 	:= ADR(xTve^.io[1]);												// teplota vyhrievacie teleso {podlahy}
		IF _Nh_IO_DEV(io := xPtIO) AND xTve^.cx.reg.Guard THEN				// zapnut tepelne ochrany = zatial len TVE
				IF	xPtIO^.val = 0.0   OR                               		// nula je ako ze nedava teplotu
					xPtIO^.val <= -40.0 OR                              		// snimac ukazuje chujovinu
      	 		xPtIO^.val >= 124.0 THEN                            		// snimac ukazuje chujovinu
					xPtIO^.val := -0.0;													// toto sa zobrazi
		      ELSIF xTve^.cx.reg.Mode = 1 THEN       							// chladenie
					// CHLADENIE
		      	IF xTve^.cx.guard.val[1,1] > 0 AND REAL_TO_USINT(xPtIO^.val) > xTve^.cx.guard.val[1,1] THEN       // vysoka teplota
	      		   	xTve^.al.CM    	:= 110;
   	      		   xPvA^.prg      	:= false;
	   	         	xPva^.pv       	:= 1;
  	   		   ELSIF xTve^.cx.guard.val[1,0] > 0 AND REAL_TO_USINT(xPtIO^.val) < xTve^.cx.guard.val[1,0] THEN       // nizka teplota
	         			xTve^.al.CM    	:= 120;
	   	      	 	xPvA^.prg      	:= false;
   	   	     		xPva^.pv       	:= 0;
					ELSIF xTve^.al.CM > 100 THEN														// prave sa skoncilo obmedzenie
						xTve^.al.CM			:= 0;
			      	xPvA^.Qr      		:= true;
      				xPvA^.prg      	:= true;
	      			xPva^.pv       	:= 0;
					END_IF;
		      	//KURENIE
				ELSIF xTve^.cx.guard.val[0,1] > 0 AND REAL_TO_USINT(xPtIO^.val) > xTve^.cx.guard.val[0,1] THEN       // vysoka teplota
      		   	xTve^.al.CM    	:= 110;
         		   xPvA^.prg      	:= false;
	            	xPva^.pv       	:= 0;
  	   	   ELSIF xTve^.cx.guard.val[0,0] > 0 AND REAL_TO_USINT(xPtIO^.val) < xTve^.cx.guard.val[0,0] THEN       // nizka teplota
	         		xTve^.al.CM    	:= 120;
	   	       	xPvA^.prg      	:= false;
   	   	     	xPva^.pv       	:= 1;
				ELSIF xTve^.al.CM > 100 THEN														// prave sa skoncilo obmedzenie
					xTve^.al.CM			:= 0;
		      	xPvA^.Qr      		:= true;
      			xPvA^.prg      	:= true;
	      		xPva^.pv       	:= 0;
				END_IF
				IF xPtIO^.chg THEN
					xPvA^.Qr := true;
				END_IF;				

		END_IF;
		xTve^.me.pvDelay(	In	:= xPvA^.Qr, Delay := xTve^.cx.reg.Delay );	
		IF xTve^.me.pvDelay.Done THEN										// skoncilo opozdenie technologie
			xPvA^.Qr 			:= false;								// DOLEZITE !!!!
			xPva2^		:= xPvA^;
			xDev^.al.in.val	:= USINT_TO_REAL(xRegMod^.out[xPva2^.PV]);  //xVal3^.val[ xPva2^.PV ];			
			IF xPvA^.prg THEN														// ma byt program
				_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xTve^.cx.chg), ref := true, off:=true);	// vynuluje datum/cas konca
			END_IF;

			xTve^.me.CMD		:= 10;		
			_NhDevRef(xR := xDev);					
		END_IF;
		xPvA^.Qr 			:= false;								// DOLEZITE !!!!
	
*)	
	
	ELSE
		_NH_Tve_CMD := false;
	END_IF;
	xDev^.ok.DevRef	:= false;
END_FUNCTION
(*
		IF xTve^.cx.reg.Guard AND cf = 8 THEN											// zapnut tepelne ochrany = zatial len TVE
			xPtIO 	:= ADR(xTve^.io[1]);												// teplota vyhrievacie teleso {podlahy}
			IF _Nh_IO_DEV(io := xPtIO) THEN											// ochrana pred prehriatim/prechladenim
				IF	xPtIO^.val = 0.0   OR                               		// nula je ako ze nedava teplotu
					xPtIO^.val <= -40.0 OR                              		// snimac ukazuje chujovinu
      	 		xPtIO^.val >= 124.0 THEN                            		// snimac ukazuje chujovinu
					xPtIO^.val := -0.0;													// toto sa zobrazi
		      ELSIF xTve^.cx.reg.Mode = 1 THEN       							// chladenie
					// CHLADENIE
		      	IF xTve^.cx.guard.val[1,1] > 0 AND REAL_TO_USINT(xPtIO^.val) > xTve^.cx.guard.val[1,1] THEN       // vysoka teplota
	      		   	xTve^.al.CM    	:= 110;
   	      		   xPvA^.prg      	:= false;
	   	         	xPva^.pv       	:= 1;
  	   		   ELSIF xTve^.cx.guard.val[1,0] > 0 AND REAL_TO_USINT(xPtIO^.val) < xTve^.cx.guard.val[1,0] THEN       // nizka teplota
	         			xTve^.al.CM    	:= 120;
	   	      	 	xPvA^.prg      	:= false;
   	   	     		xPva^.pv       	:= 0;
					ELSIF xTve^.al.CM > 100 THEN														// prave sa skoncilo obmedzenie
						xTve^.al.CM			:= 0;
			      	xPvA^.Qr      		:= true;
      				xPvA^.prg      	:= true;
	      			xPva^.pv       	:= 0;
					END_IF;
		      	//KURENIE
				ELSIF xTve^.cx.guard.val[0,1] > 0 AND REAL_TO_USINT(xPtIO^.val) > xTve^.cx.guard.val[0,1] THEN       // vysoka teplota
      		   	xTve^.al.CM    	:= 110;
         		   xPvA^.prg      	:= false;
	            	xPva^.pv       	:= 0;
  	   	   ELSIF xTve^.cx.guard.val[0,0] > 0 AND REAL_TO_USINT(xPtIO^.val) < xTve^.cx.guard.val[0,0] THEN       // nizka teplota
	         		xTve^.al.CM    	:= 120;
	   	       	xPvA^.prg      	:= false;
   	   	     	xPva^.pv       	:= 1;
				ELSIF xTve^.al.CM > 100 THEN														// prave sa skoncilo obmedzenie
					xTve^.al.CM			:= 0;
		      	xPvA^.Qr      		:= true;
      			xPvA^.prg      	:= true;
	      		xPva^.pv       	:= 0;
				END_IF
				IF xPtIO^.chg THEN
					xPvA^.Qr := true;
				END_IF;				
			END_IF;
		END_IF;

		IF _Nh_IO_DEV(io := xPtIO) THEN												// ochrana pred prehriatim/prechladenim



				IF	xPtIO^.val = 0.0   OR                               			// nula je ako ze nedava teplotu
					xPtIO^.val <= -40.0 OR                              			// snimac ukazuje chujovinu
      	 		xPtIO^.val >= 124.0 THEN                            			// snimac ukazuje chujovinu
						xPtIO^.val := -0.0;														// toto sa zobrazi
				ELSIF

		      ELSIF xTve^.cx.tMax > 0 AND REAL_TO_USINT(xPtIO^.val) >= xTve^.cx.tMax THEN       // vysoka teplota
      		   	xTve^.al.CM    	:= 110;
         		   xPvA^.prg      	:= false;
	            	xPva^.pv       	:= 0;
  	   	   ELSIF xTve^.cx.tMin > 0 AND REAL_TO_USINT(xPtIO^.val) <= xTve^.cx.tMin THEN       // nizka teplota
	         		xTve^.al.CM    	:= 120;
	   	       	xPvA^.prg      	:= false;
   	   	     	xPva^.pv       	:= 1;
		   	ELSIF xTve^.al.CM > 100 THEN												// prave sa skoncilo obmedzenie
	         		xTve^.al.CM    	:= 0;
						xPvA^.Qr      		:= true;
      	   		xPvA^.prg      	:= true;
	            	xPva^.pv       	:= 0;
				END_IF
				IF xPtIO^.chg THEN
					xPvA^.Qr := true;
				END_IF;

		ELSIF xTve^.al.CM > 100 THEN														// prave sa skoncilo obmedzenie
//			xTve^.al.reg.Mode	:= 0;			
			xTve^.al.CM			:= 0;
      	xPvA^.Qr      		:= true;
      	xPvA^.prg      	:= true;
	      xPva^.pv       	:= 0;
		END_IF;
*)


FUNCTION _NH_Het_LOG_DATA   : BOOL
   yTx2 := CONCAT(
				REAL_TO_STRINGF(INT_TO_REAL(xHet^.me.LogReQ)*0.1,'%6.1f;'),   	// ziadane
				REAL_TO_STRINGF(INT_TO_REAL(xHet^.me.LogRom)*0.1,'%6.1f;'));   // miestnost
	IF xHet^.io[1].zon THEN
   	yTx2 := CONCAT(yTx2,REAL_TO_STRINGF(INT_TO_REAL(xHet^.me.LogHet)*0.1,'%6.1f;'));   // podlaha
	ELSE
   	yTx2 := CONCAT(yTx2,'      ;');
	END_IF;
	IF xHet^.io[2].zon THEN
   	yTx2 := CONCAT(yTx2,REAL_TO_STRINGF(INT_TO_REAL(xHet^.me.LogKot)*0.1,'%6.1f;'));  	// kotol
	ELSE
   	yTx2 := CONCAT(yTx2,'      ;');
	END_IF;
 	REPLACE_CHAR(C1 := 16#2E, C2 := 16#2C, input := yTx2);						// nahradi '.' -> ','

   yTx2 := CONCAT(	USINT_TO_STRINGF(SYSTEM_S.COUNTER_DAYS_OF_MONTH,'%1d;'), 								// cas	
							TIME_TO_STRINGF(aSys.NhTime,'%Thh:mm;'), 								// cas	
							yTx2,
                     USINT_TO_STRINGF(xHet^.me.Out,'%1d'));   				// PV-tv);
	yTx3	:= ' D;Time ;ReQ   ;Rom   ;Het   ;Kot   ;O';
			//  1  4     10     17     24     31     38  />40
			//	'13;22:30;1234,6;1234,6;1234,6;1234,6;3CRLF
	yTx1 := INT_TO_STRING(nd);															// cislo miestnosti
END_FUNCTION

FUNCTION _NH_Het_LOG   : BOOL

RETURN;

	IF xHet^.cx.pLog.Enable = false THEN
		RETURN;
	END_IF;
	// 10 sec month Log
	IF SYSTEM_S.R_EDGE_10MIN  THEN
		_NH_Het_LOG_DATA();
//		_NhPathLOG(cfg:=cf,yTxt:=yTx1, file:=1);
//  		_Nh1RowTxt(adHed1:=true);
	END_IF;
	xHet^.me.LogSec := xHet^.me.LogSec + aSys.u1Sec;			// pridava SEC od posledneho zapisu
	IF xHet^.me.DIF.Etchg > 0 THEN
		Return;
	ELSIF xHet^.me.LogSec >= xHet^.cx.pLog.Sample THEN

		xHet^.me.LogSec := 0;	
		IF xRegMod^.wht = 0 THEN                              		
			nDel 	:= USINT_TO_INT( xRegMod^.out[ xHet^.me.pvm.p.PV ] ) *10 ;			// reguluje sa vystupny vykon
			nNew 	:= nDel;
		ELSE
			nDel 	:= REAL_TO_INT(FLOOR( xRegMod^.reQ[ xHet^.me.pvm.p.PV ]*10.));// ReQ	odstrihne co je za prvou des.ciarkou
	   	nNew 	:= REAL_TO_INT(FLOOR(xHet^.io[0].val * 10.) );		         	// Rom
		END_IF;
		grp	:= ABS(xHet^.me.LogReQ - nDel);
		ok 	:= grp >= USINT_TO_INT(xHet^.cx.pLog.chgReQ);
		grp	:= ABS(xHet^.me.LogRom - nNew);
		ok		:= ok OR grp >= USINT_TO_INT(xHet^.cx.pLog.chgRom);
		IF xHet^.io[1].zon THEN
			del	:= REAL_TO_INT(FLOOR(xHet^.io[1].val * 10.) );		           	// Het		
			grp	:= ABS(xHet^.me.LogHet - del);
			ok := ok OR grp >= USINT_TO_INT(xHet^.cx.pLog.chgHet);
		END_IF;
		IF xHet^.io[2].zon THEN
			new	:= REAL_TO_INT(FLOOR(xHet^.io[2].val * 10.) );		           	// Kot
			grp	:= ABS(xHet^.me.LogKot - new);
			ok		:= ok OR grp >= USINT_TO_INT(xHet^.cx.pLog.chgKot);
		END_IF;
		ok		:= ok OR xHet^.me.LogOut <> xHet^.me.Out;
		IF ok = false THEN
			RETURN;
		END_IF;
	ELSE
		RETURN;
	END_IF;

	xHet^.me.LogRec := xHet^.me.LogRec + 1;	
	xHet^.me.LogReQ := nDel;
	xHet^.me.LogRom := nNew;
	xHet^.me.LogHet := del;
	xHet^.me.LogKot := new;
  	xHet^.me.LogOut := xHet^.me.Out;

	IF aSys.Restart THEN
		RETURN;	
	END_IF;

	_NH_Het_LOG_DATA();

//	_NhPathLOG(cfg:=cf,yTxt:=yTx1, file:=2);
//  	_Nh1RowTxt(adHed1:=true);


END_FUNCTION


FUNCTION _NH_Het_PAR_MAP {HIDDEN}  : BOOL
	VAR_INPUT
		map	: BOOL := true;				
	END_VAR
	_NH_Het_PAR_MAP := false;
	IF map THEN
		_NhxPar(cp := aCfg[cf].par , np := xDev^.al.OU.par ,x:=-1016);
	END_IF;
	pHet					:= xPar;
   xFix  				:= ADR(pHet^.par.Fix);
   xPva  				:= ADR(pHet^.par.pva);
END_FUNCTION

VAR_GLOBAL
   err1  : UINT;
END_VAR


FUNCTION _NH_Het_CMD   {HIDDEN}  : BOOL
	IF _Nh_Dev_REC(blk:=true) THEN
		_NH_Het_CMD 	:= true;				
		xHet		:= xDev;															// tot koli mapovaniu reg
		_NH_Het_Map_Reg();
		ok						:= _Dev_Qx_PAR(dpa := xHet^.cf.par, clr:=false);	// zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0, namapuje parameter			
		_NH_Het_PAR_MAP(map:=false);
		xPva2 				:= ADR(xHet^.me.pvm);                              // vykonna pamat
		xHet^.me.led.chg	:= false;						            // reset zmeny pre TLG,WSB...

		IF aSys.RefCyc = 3 OR aSys.Restart THEN							// uz je zapiasany DAy aj v ZON aj ROM
			IF NOT(xM^.pod.po.edit.c = cf AND xM^.pod.po.edit.n = nd) THEN	// ak sa prave toto het edituje, neaktualizuje sa
				xPt := xHet;																// potrebne	pre _Nh_xPod_Map
				_Nh_xPod_Map(cf:=cf, WhtPoi:=xHet^.cx.reg.mode);
				_NhxRom(nr:=xHet^.cf.rom);
				xPod^.Day		:= xRom^.cx.pDay.Day;								// preberie sa den z miestnosti pre ktoru sa kuri
			END_IF;
         IF aSys.Restart THEN
			   xPvA^.chg		:= false;												// nerobi sa nic, len dobehnu casy MANualu. Pri PRG sa bude aktualizovat dalej
   			xPva2^         := xPvA^;												      // prevazdzkova pamat sa vyrovna z parametrom
         ELSE
   			xPvA^.chg	:= true;															// refresne aj casy do konca
         END_IF;
      END_IF;
		IF ok THEN
			//xHet^.al.cm := xHet^.al.in.CMD;
			xPvA^.chg			:= true;
   		CASE xHet^.al.in.CMD OF  								
				 1 : ; // z webu - nic sa len refresh
    			10 :   // Off {SCN/ACT....}
   	           	xPvA^.p.prg   	:= false;
   					xPvA^.chg		:= xPvA^.p.pv = 0;
		      		xPvA^.p.pv    	:= 0;
        		14 :	// pokyn zo SCN/ACT pre het ..

						      ;  // vsetky udaje su v parametri pHet2

				21 :   // PIR
						CASE xDev^.al.cm OF
                    	2: // delay = opozdenie pri prvom vstupe
                    	3: // Wait 	= cakanie na pohyb			
								xDev^.al.cm	:= 9;            			// ukonci cas a v nasl.cykle vykona	
						ELSE
						  		xDev^.al.cm := 2;							// nastartuje sa Delay
       						xDev^.al.et := pHet^.Delay;
                  END_CASE;
						xDev^.al.ou.par 	:= xHet^.cf.par;			// pokracuje sa s default parametrom
						_NH_Het_PAR_MAP();	
						xPvA^.chg := false;
(*
      	        180:   // SVx,ZAS,
								ok1   		:= false;
								xHet^.me.CmdVal:= REAL_TO_BOOL(xDev^.al.in.val);  // z prichadzajuceho CMD zapamata ON/OFF
                       	IF pHet^.what = 0 THEN     					// pozaduje sa pri ON
									IF xDev^.al.cm	= 5 THEN						// je nastarovany delay od ON
										xPvA^.Qr		:= false;							// default nic sa nestane							
			                 	ELSIF xHet^.me.CmdVal THEN       		// ->ON, vzdy nanovo nastavi cas
										xPva2^.Qr   := true;				// zabezpeci refresh zostavajuceho casu
										xDev^.al.cm			:= 5;             // nastavi Delay
   	  								xDev^.al.et 		:= pHet^.Delay;
									ELSE
										xPvA^.Qr		:= false;							// default nic sa nestane																
									END_IF;
								ELSIF	xDev^.al.cm	= 6 THEN           		// nastartovany delay od OFF
									xPvA^.Qr		:= false;							// default nic sa nestane							
                       	ELSIF xHet^.me.CmdVal = false THEN
									xPva2^.Qr   := true;				
									xDev^.al.cm			:= 6;             	// nastartuje Delay od OFF
  	  								xDev^.al.et 		:= pHet^.Delay;   		
								ELSE
									xPvA^.Qr		:= false;							// default nic sa nestane															
								END_IF;
						  		xDev^.al.ou.par 	:= xHet^.cf.par;			// pokracuje sa s default parametrom
*)

				// tieto CMD len s ovladaca
   	  		30 :   // HOLD  z WSB = Automatika
               	xPvA^.p.prg   	:= true;
						xPvA^.chg		:= true;			
      		31 :  // PRESS z WSB = protimraz
   	           	xPvA^.p.prg   	:= false;
   					xPvA^.chg		:= xPvA^.p.pv = 0;
		      		xPvA^.p.pv    	:= 0;
    	     	32 :  // Click-1
            	  	xPvA^.p.prg   	:= false;
   					xPvA^.chg		:= xPvA^.p.pv = 1;
               	xPvA^.p.pv    	:= 1;
        		33 :	// Click-2
						xPvA^.p.prg   	:= false;
   					xPvA^.chg		:= xPvA^.p.pv = 2;
						xPvA^.p.pv    	:= 2;
	     		34 :	// Click-3
						xPvA^.p.prg   	:= false;
   					xPvA^.chg		:= xPvA^.p.pv = 3;
               	xPvA^.p.pv    	:= 3;
				ELSE   // refresh/restart
						xPvA^.chg		:= false;
      	END_CASE;
      END_IF;


		IF xDev^.al.CM > 0 THEN    											     // caka sa - filter od PIR/SVx...		
			IF xPvA^.p <> xPva2^.p  THEN
				xDev^.al.CM := 0;
	      ELSIF _Nh_Dev_ET(t:=1) THEN									
				CASE xDev^.al.cm OF
               2:	// ukonceny Delay  {opozdenie po prvom signale} ...bude sa cakat za PIR
				  		xDev^.al.cm := 3;											// wait
						_NhxPar(cp := aCfg[cf].par , np := xDev^.al.IN.par,x:=-1016);
						pHet2 := xPar;
           			xDev^.al.et := pHet2^.Wait;

               5:	// svetlo ma byt ON
						IF xHet^.me.CmdVal THEN
					  		xDev^.al.cm := 9;											
						ELSE
							xDev^.al.cm := 0;
						END_IF;
               6:	// svetlo ma byt OFF
						IF xHet^.me.CmdVal = false THEN
					  		xDev^.al.cm := 9;											
						ELSE
							xDev^.al.cm := 0;
						END_IF;
               9:	// signal z PIR v case wait = koniec
						;
            ELSE
						xDev^.al.cm := 0;          							// ukoncil sa aj Wait, a nenastal pohyb
            END_CASE;
			END_IF;
			IF xDev^.al.cm = 9 THEN												// zaznamenany pohyb v case sledovania
				xDev^.al.OU.par	:= xDev^.al.IN.par;                 // v dalsom cykle sa pouziju udaje s pripraveneho parametra
				_NH_Het_PAR_MAP();	
				xDev^.al.cm 		:= 0;
			END_IF;
		END_IF;


		IF xPvA^ <> xPva2^ THEN
			_NhDevRef(xR := xHet);			
			IF xPvA^.p.prg THEN															// ma byt program
(*
					IF aSys.RefCyc = 3 OR aSys.Restart THEN
						;
					ELSIF err1 <  1500 THEN //AND SYSTEM_S.F_EDGE_1SEC THEN  //xHet^.me.poi = 0 THEN
					   aSys.ErrPt := aSys.ErrPt +1;
	               yTx2     := CONCAT('cf:',USINT_TO_STRINGF(cf,'%3u'),' nd:',INT_TO_STRINGF(nd,'%3u'),
                           ', pvA: ',BOOL_TO_STRINGF(xPvA^.chg,'%b{Y^n}'),' ',BOOL_TO_STRINGF(xPvA^.p.prg,'%b{A^M}'),' ',USINT_TO_STRINGF(xPvA^.p.PV,'%1u'),
                           ', pvM: ',BOOL_TO_STRINGF(xPvA2^.chg,'%b{Y^n}'),' ',BOOL_TO_STRINGF(xPvA2^.p.prg,'%b{A^M}'),' ',USINT_TO_STRINGF(xPvA2^.p.PV,'%1u')
                           );
   	            yTx2     := CONCAT(yTx2,' cmd:',USINT_TO_STRINGF(xHet^.al.in.CMD,'%3u'),' cm:',USINT_TO_STRINGF(xHet^.al.CM,'%3u')
                                 ,' refc:',USINT_TO_STRINGF(aSys.RefCyc,'%3u')
	                        );
      	         	rb    := _Nh1RowTxt(logRst:=1, adDate:=1, adTime:=1);
   	   			 err1 	:= err1 +1;
	            END_IF;
  *)
            _Nh_Poi_Het();
//			ELSIF xPvA^.p.pv = xPva2^.p.pv THEN    						// netreba, lebo sem pojde len ked xPvA^.chg:=true, ked sa stalci ta ista predvolba
			ELSIF aSys.RefCyc > 0 THEN
				;
			ELSIF xFix^.wht = 1 THEN                                 		// prva zmena v automatike
				xPva2^.p.pv	:= xPvA^.p.pv;     								// lem si zapamta PV
   			_Nh_Poi_Het();                                              // toto prepise  xPvA^.p.pv
				xPvA^.p.pv     	:= xPva2^.p.pv;                     // vrati zapamatany
  			ELSE
				_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xHet^.cx.chg) );   	// pri prepnuti na MAN zisti koniec z parametra
			END_IF;	
			_Nh_Fix_HET_MAN(fix := xFix, chg := ADR(xHet^.cx.chg), ref:=true); // aktualizuje cas do konca
	      xPvA^.chg	 	  := false;												// urcita zrusi zmenu
   	   xPva2^ 		     := xPvA^;                                    // vyrovna prevadzkovu pamat

			// ak prisiel CMD s inym parametrom ako DEFAULT
			IF xDev^.al.ou.par <> xHet^.cf.par THEN                 		// vykonava sa prichadzajuci parameter, namapovane na prameter je: pHet,xPva,xFix			
				xDev^.al.ou.par := xHet^.cf.par;                         // dalej uz bude len default
				_NhxPar(cp := aCfg[cf].par , np := xDev^.al.ou.par,x:=-1017);
				pHet 				:= xPar;                                  // namapuje default parameter
			   xPvA  			:= ADR(pHet^.par.pva);                   	// predvolby default parametra
				xPvA^ 			:= xPva2^;   			               // do DEFault-par vlozi udaje z prevadzkovej pamate - z vykonavaneho parametra
			END_IF;
			
			// data pre TGL = zobrazenie pri prepnuti
			IF xRegMod^.wht = 1 THEN
				xHet^.al.in.val	:= xRegMod^.req[xPva^.p.pv];				// teplota
			ELSE
				xHet^.al.in.val	:= USINT_TO_REAL(xRegMod^.out[xPva^.p.pv]); 	// OutLVL
			END_IF;
			xHet^.me.led.rgb 	:= _eBtn3;
			xHet^.me.led.chg	:= true;
			CASE xPvA^.p.pv OF
					1 : xHet^.me.led.rgb[2] := true;
      	      2 : xHet^.me.led.rgb[3] := true;
         	   3 : xHet^.me.led.rgb[1] := true;
  			END_CASE;

		ELSIF	xHet^.cx.chg.dtChg = UINT_TO_DT(0) THEN                  // MAN sa nikdy neskonci - nepojde sa do porovnania
			;
		ELSIF xHet^.cx.chg.dtChg <= aSys.NhDT THEN                     // prave sa skoncil MAN
			xPvA^.p.prg   		:= true;	                                 // nastavi sa PRG
			xPva2^ 		      := xPvA^;											// prevazdzkova pamat sa vyrovna z parametrom
			xPvA^.chg			:= true;												// po otocke aktualizuje cas aj predvolbu z POI
		END_IF;

		xPtIO 	:= ADR(xHet^.io[0]);									         // teplota
		IF aSys.RefCyc > 0 THEN
			;
		ELSIF _Nh_IO_DEV(io := xPtIO) = false THEN							// nemame regulovanu velicinu
			xRegMod^.wht 			:= 0;												// pouzije sa hodnota vystupu
		END_IF;
		IF xRegMod^.wht = 1 THEN
			xHet^.al.ou.val		:= xPtIO^.val;									// reguluje sa teplota / CO2/ vlhkost
		ELSE
			xHet^.al.ou.val		:= USINT_TO_REAL(xRegMod^.Out[ xPva2^.p.PV ]);
		END_IF;	
		xHet^.me.DIF(	pvNew		:= xPva2^.p.PV, 	
							sample   := xHet^.cx.pPid.sample,
							out		=> xHet^.me.Out ) ;

		IF xHet^.al.sta <> xHet^.me.DIF.Sta THEN
			xHet^.al.sta := xHet^.me.DIF.Sta;
			_NhDevRef(xR := xHet);						
		END_IF;
		xHet^.al.in.CMD	:= 0;
	ELSE
		_NH_Het_CMD 	:= false;					
	END_IF;	
	xDev^.ok.DevRef	:= false;
END_FUNCTION

FUNCTION _Nh_IO_INI {HIDDEN}   :BOOL     // INICIALIZACIA KAZDEHO nulteho DEV (adresa 1.dev - sz)
   VAR_INPUT
      vz : USINT;
   END_VAR
   _Nh_IO_INI  := true;
   cf          := vz;
   IF aVaz[cf].Rec > 0 THEN
      _NhxVaz(cv:=cf,nd:=1);
	   sPtr  := SIZEOF(NH_VAZ);
      xVaz  := xVaz - sPtr;
   END_IF;
END_FUNCTION


FUNCTION _Nh_IO_OK {HIDDEN}   :BOOL     // INICIALIZACIA KAZDEHO nulteho DEV (adresa 1.dev - sz)
  	_Nh_IO_OK := true;	
	xVaz  := xVaz  + sPtr;
 	IF xVaz^.ok.ok THEN
  		IF _NhxPt(c:=xVaz^.in.c,n:=xVaz^.in.n,err:=0 ,x:=22) THEN
		  	xDev  := xPt;
	      IF _NhxPt(c:=xVaz^.ou.c,n:=xVaz^.ou.n, err:=0 ,x:=24) THEN
				xDev2 := xPt;
			ELSE
//				_NhDelVaz();
			  	_Nh_IO_OK := false;	
			END_IF;
		ELSE
//			_NhDelVaz();
		  	_Nh_IO_OK := false;	
		END_IF;
	ELSE
  		_Nh_IO_OK := false;	
  	END_IF;
END_FUNCTION

FUNCTION _Nh_IO2 {HIDDEN} :BOOL
   _Nh_IO2  := _Nh_IO_INI( vz:=2);
//   yTx1  := CONCAT(_Nh_ADR_LOG,'_EVN.LOG');
   yes   := true;
	FOR nd := 1 TO aVaz[cf].Rec DO
		IF _Nh_IO_OK() THEN
	      xDev^.al.vaz   := true;                                              // In ma vazby
   	   xDev2^.al.vaz  := true;                                              // DEV ma vazby
	      CASE aCfg[xVaz^.in.c].tgrp OF
   	     13: // WSB,TLA,TGL
      	      _NhxPar(cp := aCfg[xVaz^.in.c].par, np := xVaz^.in.p, x:=253);    // parameter WSB, kde je CMD k BTN
         	   pWsb  := xPar;
					xTgl	:= xDev;	
//					ii := _Nh_BTN_LED_NBR(cf:=xVaz^.in.c, btn:=pWsb^.bt);
					ii := MIN(pWsb^.bt,8);
					xTgl^.al.DEV[ii] := true;														// BTN ma vazbu na DEV
            	IF xDev^.al.ou.CMD > 0 THEN                                       // WSB posiela
	               IF xDev^.al.ou.CMD = pWsb^.bt THEN                             // v ou.CMD je stlaceny BTN, ktory sa porovna s vazbou
   	               IF pWsb^.cm.cmd[ xDev^.al.ou.par ] > 0 THEN
      	               xDev2^.al.in.cmd := pWsb^.cm.cmd[ xDev^.al.ou.par ];     // v parametri ou.par je cislo clicku, a v pWsb^.cm.cmd[cmd] prikaz odpovedajuci
         	            xDev2^.al.in.par := xVaz^.ou.p;                          // do DEV sa posle vzdy parameter ou.p
            	         xDev2^.al.wsb    := true;                                // priznak, ze z WSB
               	   END_IF;
	               END_IF;
   	         END_IF;
      	      CASE aCfg[xVaz^.ou.c].tgrp OF                                 		// vystup posiela do WSB
						0 : ;
         	      6: // HET {6}, HEV {47}
            	      xHet  := xDev2;
							xTgl^.al.het[ii] := true; 												// tento btn ovlada regulator
							xTgl^.al.PRG[ii] := xHet^.me.pvm.p.prg; 								// na regulatore bezi PRG
							IF xHet^.me.led.chg OR xTgl^.al.Qf THEN //OR xTgl^.cx.CfL.refresh THEN					
								IF aCfg[xVaz^.in.c].led THEN                             // ak ma ovladac LED 	
									xTgl^.cx.CfL.LEDs.btn[ii].rgb := xHet^.me.led.rgb; 	// kombinacia LED urcena regulatorom
									xTgl^.cx.CfL.refresh := true;
								END_IF;
								IF aCfg[xVaz^.in.c].dis THEN											// ovladac ma HET
									IF xTgl^.cx.cfD.WhtDisp < 3 THEN											// teoplota miestnosti/vonku/vlhkost		
										;
//									ELSIF xTgl^.cx.CfL.BtnHet = xTgl^.cx.CfL.BtnBli THEN			// tento BTN nie je vybraty pre zobrazenie
									ELSIF xTgl^.cx.CfL.BtnHet = ii THEN								// tento BTN JE je vybraty pre zobrazenie
										xTgl^.cx.CfD.refresh := true;   							
	                     		IF xTgl^.cx.CfL.cmd = 2 THEN                           		// zmena = posiela sa pozazovana velicina
                  					xTgl^.al.in.val := xHet^.al.in.val;
										ELSE
	   	               			xTgl^.al.in.val := xHet^.al.ou.val;                  	// bezi program = regulovana velicina
										END_IF;
									END_IF;
								END_IF;
							END_IF;
					END_CASE;
   	
				3: // PSN
//					_Nh_ZON_IOX();						
	      ELSE
   	         IF xDev^.al.ou.cmd > 0 THEN
      	         CASE aCfg[xVaz^.in.c].tgrp OF
         	        15: // PIR                 15: ;                                        		// namapuje aj xRom, kde je PIR
		                  IF _NhxPir(n:=xVaz^.in.n,x:=57) THEN
		                     IF _NhxPar(cp := aCfg[xVaz^.in.c].par, np := xVaz^.in.p,x:=252) THEN
		                        pPir  := xPar;
										IF xRom^.cx.lck.stat > 1 AND pPir^.Day.n[4] = false THEN				// ked je zamknute, nema sa svietit
											;
		                        ELSIF pPir^.Day.n[5] = false OR xRom^.cx.Dark  THEN                  // pir nepozaduje sumrak [5], alebo v miestnosti PIR je tma
		                           IF pPir^.Day.n[ xRom^.me.DayObr ]    THEN                      // a zarovej v miestnosti DEV je taky ModDna, ako pozaduje PIR
      		                        xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;                       // cmd PIR
		                              xDev2^.al.IN.par  := xVaz^.ou.p;                            // tot je Par DEV, kde je cas aj LVL
		                              xDev2^.al.WSB  	:= false;
      		                     END_IF;
            		            END_IF;
		                     END_IF;
      		            END_IF;
            		   ELSE
								xDev2^.al.WSB  	:= false;
		                     IF xDev2^.ok.CmdInBLK  THEN                                             // vystup nemoze prijimat data
      		                  xDev^.ok.CmdOuRpt    := true;                                        // dev ktore posiela sa povie ze OK
		                     ELSE
      		                  xDev2^.al.IN.cmd     := xDev^.al.ou.cmd;                             // hocico ine prenesie CMD na vystup
		                        xDev2^.al.IN.val     := xDev^.al.ou.val;                             // hocico ine prenesie CMD na vystup
      		                  xDev2^.al.IN.par     := xVaz^.ou.p;                                  // do DEV sa posle vzdy parameter ou.p
		                        xDev^.ok.cmdOuRpt    := false;                                       // In - netrebA OPAKOVAT
      		               END_IF;
		               END_CASE;
					END_IF;
		      END_CASE;
		END_IF;
   END_FOR;

(*
   If yes = false THEN
      yTx2 := '';
      _Nh1RowTxt();
   END_IF;
*)

END_FUNCTION
(*
FUNCTION _Nh_IO4 {HIDDEN} :BOOL
	// ACT,ALA,BLK - vykona sa pred SCN. SCN mozu vstupovat do ACT....
//   _Nh_IO_INI( vz:=4);                																	
	FOR nd := 1 TO aVaz[cf].Rec DO
		IF _NhxVaz(cv:=4, nd:=nd) THEN
//			_Nh_IO_OK();

			ok := true;	
  			IF _NhxPt(c:=xVaz^.in.c,n:=xVaz^.in.n,x:=22) THEN
			  	xDev  := xPt;
			ELSE
				ok := false;
			END_IF;
	      IF _NhxPt(c:=xVaz^.ou.c,n:=xVaz^.ou.n,x:=23) THEN
				xDev2 := xPt;
			ELSE
				ok := false;
			END_IF;
			IF ok THEN
		      xDev^.al.lst   := true;                                             				// SCN ma list
   	   	xDev2^.al.lst  := true;                                             				// DEV do scn ma list
      		IF xDev^.al.ou.cmd > 0 THEN
   	   	   xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
		         xDev2^.al.IN.par  := xVaz^.ou.p;                               				// do DEV sa posle vzdy parameter ou.p
//	         xDev2^.al.IN.par  := 8;                               				// do DEV sa posle vzdy parameter ou.p

   	   	   xDev2^.al.IN.val  := xDev^.al.ou.val;                       					// parameter DEV z vazby
      		   xDev2^.al.wsb  	:= xDev^.al.wsb;                       						// zaisi pripadne blokovanie PIR pte DEV v liste
					xDev^.al.wsb		:= false;																// po prebrati vynuluje priznak WSB
		      END_IF;
			END_IF;
		END_IF;
   END_FOR;
END_FUNCTION
*)


FUNCTION _Nh_IO4  {HIDDEN}  :BOOL
	// ACT,ALA,BLK - vykona sa pred SCN. SCN mozu vstupovat do ACT....
   _Nh_IO_INI( vz:=4);                																	
	FOR nd := 1 TO aVaz[cf].Rec DO
		IF _Nh_IO_OK() THEN
	      xDev^.al.lst   := true;                                             				// SCN ma list
      	xDev2^.al.lst  := true;                                             				// DEV do scn ma list
      	IF xDev^.al.ou.cmd > 0 THEN
   	      xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
	         xDev2^.al.IN.par  := xVaz^.ou.p;                               				// do DEV sa posle vzdy parameter ou.p
      	   xDev2^.al.IN.val  := xDev^.al.ou.val;                       					// parameter DEV z vazby
      	   xDev2^.al.wsb  	:= xDev^.al.wsb;                       						// zaisi pripadne blokovanie PIR pte DEV v liste
				// toto sa urovni az akcii v dalsom cykle
//				xDev^.al.wsb		:= false;																// po prebrati vynuluje priznak WSB
	      END_IF;
		END_IF;
   END_FOR;
END_FUNCTION

// z akcii uz vypinaju aj scenu ak je lvl=0.0 alebo ak < 100, tak zapnu len tie DEV pomerom, ktore maju v par, lvl > 0.0
FUNCTION _Nh_IO3    :BOOL
	// SCN - po ACT,(IO4) ktore mozu nastavit SCN nejaky stav
   _Nh_IO_INI( vz:=3);                																	
	FOR nd := 1 TO aVaz[cf].Rec DO
		IF _Nh_IO_OK() THEN
	      xDev^.al.lst   := true;                                             					// SCN ma list
      	xDev2^.al.lst  := true;                                             					// DEV do scn ma list
			xScn				:= xDev;
      	IF xDev^.al.ou.cmd > 0 THEN
				IF xDev^.cf.typ = 1 THEN
      		   xDev2^.al.up  		:= xDev^.al.up;                       						// parameter DEV z vazby
					xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
		         xDev2^.al.IN.par  := xVaz^.ou.p;                               					// do DEV sa posle vzdy parameter ou.p
				ELSE
		         xDev2^.al.IN.par  := xVaz^.ou.p;                               					// do DEV sa posle vzdy parameter ou.p
   	   	   xDev2^.al.IN.val  := xDev^.al.ou.val;                       						// parameter DEV z vazby
					xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
(*
				IF xDev^.al.ou.val = 0.0 THEN
	   	      xDev2^.al.IN.cmd  := 10;
				ELSIF xDev^.al.ou.val < 100.0 THEN
	   	      xDev2^.al.IN.cmd  := 9;
					xDev^.al.Qx 		:= false;
				ELSE				
	   	      xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
				END_IF;
      	   xDev2^.al.wsb  	:= xDev^.al.Wsb;                       						// parameter DEV z vazby
*)

					IF xDev^.al.ou.cmd = 11 THEN
						IF aCfg[xVaz^.ou.c].par > 0 THEN															// DEV v scene ma parameter
							IF _NhxPar(cp := aCfg[xVaz^.ou.c].par, np := xVaz^.ou.p,x:=252) = false  THEN																	   // NEnasiel sa parameter
							;
							ELSIF xPar^.all.lvl = 0 THEN						// LVL>0 ale ine ako ma byt
	   	      			xDev2^.al.IN.cmd  := 10;
							END_IF;
						END_IF;
					END_IF;
      		   xDev2^.al.wsb  	:= xDev^.al.Wsb;                       						// parameter DEV z vazby
				END_IF;
			ELSIF xDev^.cf.typ = 1 THEN																	// len rolety
				IF xDev2^.al.sta > 2  THEN
					xScn^.cx.all.LastScnOn := true;
				END_IF;
			ELSIF xDev2^.al.ou.val > 0. THEN
				xScn^.cx.all.LastScnOn := true;
(*
			ELSIF xDev^.al.Qx = false THEN																// DEV v scene je zapnute
				;
			ELSIF aCfg[xVaz^.ou.c].par > 0 THEN															// DEV v scene ma parameter
				IF _NhxPar(cp := aCfg[xVaz^.ou.c].par, np := xVaz^.ou.p,x:=252) = false  THEN																	   // NEnasiel sa parameter
					;
				ELSIF xPar^.all.lvl <> REAL_TO_USINT(xDev2^.al.ou.val) THEN						// LVL>0 ale ine ako ma byt
					// vypne scenu
//					xDev^.al.In.val 	:= 0.0;	//xDev2^.al.ou.val;
//					xDev^.al.Ou.val 	:= 0.0;	//xDev2^.al.ou.val;
					xDev^.al.Qx 		:= false;
					xDev^.al.in.cmd	:= 3;																	// vypne priznak zapnutia a resetne casy
				END_IF;
*)
			END_IF;
		END_IF;
   END_FOR;
END_FUNCTION


(*
// z akcii uz vypinaju aj scenu ak je lvl=0.0 alebo ak < 100, tak zapnu len tie DEV pomerom, ktore maju v par, lvl > 0.0
FUNCTION _Nh_IO3    :BOOL
	// SCN - po ACT,(IO4) ktore mozu nastavit SCN nejaky stav
   _Nh_IO_INI( vz:=3);                																	
	FOR nd := 1 TO aVaz[cf].Rec DO
		IF _Nh_IO_OK() THEN
	      xDev^.al.lst   := true;                                             					// SCN ma list
      	xDev2^.al.lst  := true;                                             					// DEV do scn ma list
			xScn				:= xDev;
      	IF xDev^.al.ou.cmd > 0 THEN
				IF aCfg[xVaz^.ou.c].par > 0 THEN															// DEV v scene ma parameter
					IF _NhxPar(cp := aCfg[xVaz^.ou.c].par, np := xVaz^.ou.p,x:=252) THEN
						xScn^.me.delayOff := MAX(xScn^.me.delayOff, _Nh_N12(aCfg[xVaz^.ou.c].tgrp=31,xPar^.all.tDelay,xPar^.all.tDelay/10)+2 );	// MAX opozdene spustenie z niektoreho DEV
					ELSE
						yTx2	:= CONCAT('_Nh_IO3: Not Find par: cf:',USINT_TO_STRING(xVaz^.ou.c),',cp:',USINT_TO_STRING(aCfg[xVaz^.ou.c].par),
											', np: ',INT_TO_STRING(xVaz^.ou.p),', vz3:',INT_TO_STRING(nd)  )  ;
    					rb		:= _Nh1RowTxt(logRst := 1);
						ok1 	:= false;
					END_IF;
				ELSE	ok1 := false;
				END_IF;
 				xDev2^.al.wsb  	:= xDev^.al.Wsb;                       						// priznak WSB
				xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
  	   	   xDev2^.al.IN.val  := xDev^.al.ou.val;                       					// parameter DEV z vazby
	         xDev2^.al.IN.par  := xVaz^.ou.p;
				IF xDev^.cf.typ = 1 THEN
      		   xDev2^.al.up  		:= xDev^.al.up;                      						// pre ROL DOLEZITE !!! - nastavi smer pohybu rolety
				END_IF;
				IF xDev^.al.ou.cmd = 11 THEN
					IF ok1 = false THEN
						;
					ELSIF xPar^.all.lvl = 0 THEN						// LVL>0 ale ine ako ma byt
 						xDev2^.al.IN.cmd  := 10;
					END_IF;
				END_IF;
			ELSIF xDev^.al.ou.val = 0. THEN																// scn je vypnuta
				;
			ELSIF xDev^.cf.typ = 1 THEN																	// len rolety
				IF xDev2^.al.sta > 2  THEN
					xScn^.cx.all.LastLvl	:= 100;
				END_IF;
			ELSIF xDev2^.al.ou.val > 0. THEN
				xScn^.cx.all.LastLvl	:= 100;
			END_IF;
		END_IF;
   END_FOR;
END_FUNCTION
*)

(*

// pred Rosochom - z akcii nevypinali scenu, ked bola 0.0

FUNCTION _Nh_IO3  :BOOL
	// SCN - po ACT,(IO4) ktore mozu nastavit SCN nejaky stav
   _Nh_IO_INI( vz:=3);                																	
	FOR nd := 1 TO aVaz[cf].Rec DO
		IF _Nh_IO_OK() THEN
	      xDev^.al.lst   := true;                                             					// SCN ma list
      	xDev2^.al.lst  := true;                                             					// DEV do scn ma list
			xScn				:= xDev;
      	IF xDev^.al.ou.cmd > 0 THEN
	         xDev2^.al.IN.par  := xVaz^.ou.p;                               					// do DEV sa posle vzdy parameter ou.p
      	   xDev2^.al.IN.val  := xDev^.al.ou.val;                       						// parameter DEV z vazby
   	      xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
      	   xDev2^.al.wsb  	:= xDev^.al.Wsb;                       						// parameter DEV z vazby
			ELSIF xDev^.al.Qx = false THEN																// DEV v scene je zapnute
				;
			ELSIF aCfg[xVaz^.ou.c].par > 0 THEN															// DEV v scene ma parameter
				IF _NhxPar(cp := aCfg[xVaz^.ou.c].par, np := xVaz^.ou.p,x:=252) = false  THEN																	   // NEnasiel sa parameter
					;
				ELSIF xPar^.all.lvl <> REAL_TO_USINT(xDev2^.al.ou.val) THEN						// LVL>0 ale ine ako ma byt
					// vypne scenu
//					xDev^.al.In.val 	:= 0.0;	//xDev2^.al.ou.val;
//					xDev^.al.Ou.val 	:= 0.0;	//xDev2^.al.ou.val;
					xDev^.al.Qx 		:= false;
					xDev^.al.in.cmd	:= 3;																	// vypne priznak zapnutia a resetne casy
				END_IF;
			END_IF;
		END_IF;
   END_FOR;
END_FUNCTION
*)


(*
FUNCTION _Nh_IO3  :BOOL
	// SCN - po ACT,(IO4) ktore mozu nastavit SCN nejaky stav
   _Nh_IO_INI( vz:=3);                																	
	FOR nd := 1 TO aVaz[cf].Rec DO
		IF _Nh_IO_OK() THEN
	      xDev^.al.lst   := true;                                             					// SCN ma list
      	xDev2^.al.lst  := true;                                             					// DEV do scn ma list
      	IF xDev^.al.ou.cmd > 0 THEN
   	      xDev2^.al.IN.cmd  := xDev^.al.ou.cmd;
	         xDev2^.al.IN.par  := xVaz^.ou.p;                               					// do DEV sa posle vzdy parameter ou.p
      	   xDev2^.al.IN.val  := xDev^.al.ou.val;                       						// parameter DEV z vazby
//      	   xDev2^.al.wsb  	:= xDev^.cx.all.LastWsb;                       						// parameter DEV z vazby
      	   xDev2^.al.wsb  	:= xDev^.al.Wsb;                       						// parameter DEV z vazby

//  	   	ELSIF xDev^.al.Qx THEN 												      						// test SCN ci je ON/OFF, povoli sa ked je scena v pokoji Qx=true
  	   	ELSIF xDev^.cx.all.LastScnOn THEN 												      						// test SCN ci je ON/OFF, povoli sa ked je scena v pokoji Qx=true
				// ak aspon jedno DEV nema hodotu aku ma mat v scene = vypne scenu
				IF xDev^.al.ou.val > 0.0  THEN																// scena je zapnuta	
					IF aCfg[xVaz^.ou.c].par > 0 THEN															// DEV v scene ma parameter
    					IF _NhxPar(cp := aCfg[xVaz^.ou.c].par, np := xVaz^.ou.p,x:=252) = false THEN	
							;
						ELSIF xPar^.all.lvl <> REAL_TO_USINT(xDev2^.al.ou.val) THEN						// kazde DEV v SCN-liste musi mat aktualny LVL = parametru

							xDev^.cx.all.LastScnOn	:= false;														// ak sa najde prva nezhoda, tato SCN sa oznaci a OFF
							xDev^.al.sta 				:= 0;                                              // a uz sa s nou tu nepracuje
							xDev^.al.IN.val 			:= 0.0;															// vypne scenu
							xDev^.al.OU.val 			:= 0.0;
      					/////15.9.24	vypne prebiehajuce casy vypnutia
//							xDev^.al.et 	:= 0;																	// cas od PIR
//							xDev^.al.ex 	:= 0;																	// max.cas zapnutia
						END_IF;
					END_IF;
				END_IF;
			END_IF;
		END_IF;
   END_FOR;
END_FUNCTION
*)

FUNCTION _Nh_SVX_CMD_1     : BOOL
	IF xDev^.al.in.CMD = 3 THEN         										// len nastavilo proznak vypnutia a resetlo casy
		;
	ELSIF xDev^.al.in.CMD > 0 THEN         										// povolene prikazy testuju blokovanie PIR a oneskorenie
			xDev^.al.Off 			:= xDev^.al.OU.val = 0.0 AND xDev^.al.IN.val > 0.0; // je vypnute a ma sa zapnut - pre lampu, ktora ma dlhy nabeh z OFF->ON
			xDev^.cx.all.LastWsb	:= xDev^.al.wsb;										// prisiel z wsb
			IF xDev^.al.RUN = 255 THEN   													// Koniec Delay
				xDev^.al.RUN := 0;
 			ELSIF xPar^.all.tDelay > 0 THEN 												// opozdene vykonanie
	   	   xDev^.al.RUN   	:= xDev^.al.in.CMD;                              			// po skonceni opozdenia sa zoberie LVL z parametri - tu pridu len DEV s parametrom
				xDev^.al.in.CMD	:= 0;
   	   	xDev^.al.et    	:= xPar^.all.tDelay ;                        //
  	   		xDev^.al.CM    	:= 2;                                        // vykonava sa opozdenie
   	   	xDev^.al.ct    	:= 3;                                     	// Delay je vzdy v [100ms]
   		END_IF;
		   IF xDev^.al.in.CMD = 1 THEN                                    	// prepnut WEB/WSB
         	xDev^.al.in.val   := vr;
      		IF xDev^.al.ou.val > 0.0 THEN                               	// je zapnute, treba vypnut z WEB/WSB
         		xDev^.al.in.val   := 0.0;
				ELSIF xPar^.all.lvl = 0 THEN
           		xDev^.al.in.val	:= 100.0;                              // zapnut naplno
					xPar^.all.lvl 		:= REAL_TO_USINT(xDev^.al.in.val);				// nastavi LVL v prametri - najma pri vazbach
      		ELSE
					xDev^.al.in.val := USINT_TO_REAL(xPar^.all.lvl);				// nastavi LVL v prametri - najma pri vazbach
      		END_IF;
      		_Nh_Dev_RMP();
   		END_IF;
		   IF xDev^.al.in.CMD > 0 THEN         										// povolene prikazy testuju blokovanie PIR a oneskorenie
			   _NhxRom(nr := xDev^.cf.rom, x:=-10);
			   IF xDev^.al.wsb = false THEN                                   // nic sa nedeje neprislo z WSB {mozno z ACT..SCN}
   			   ;
	   		ELSIF  xDev^.al.in.val > 0.0 AND xPar^.all.BlPirON THEN       	// je ON
   	   		xRom^.me.BlPirOn    := 50;  	                             	// zapnutie od WSB/WEB vzdy blokuje PIR
   	   		xRom^.me.BlPirOff   := 0;                               		// resetne sa cas blokovania po vypnuti
	   		ELSIF xPar^.all.BlPirOff AND xRom^.cx.BlPirOFF > 0 THEN 			// kontrola na blokovanie PIR po vypnuti WSB/WEB
   				xRom^.me.BlPirOff := MAX(xRom^.me.BlPirOff,xRom^.cx.BlPirOFF); // max cas blokovania po vypnuti
	   		END_IF;
				// casy vypnutia
	         IF xDev^.al.IN.val < 1.0 THEN                   		// ma sa vypnut
					xDev^.al.IN.val 	:= 0.0;
   	      ELSIF xDev^.al.OU.val < 1.0 THEN                      // je OFF a ma za zapnut
      	      xDev^.al.ex := UINT_TO_INT(xDev^.cx.all.tMaxON);   // max cas zapnutia [min] - pohyb neresetuje
         	END_IF;
	         IF xDev^.al.IN.val > 0.0 THEN
					xDev^.al.up		:= true;
      	      IF xPar^.all.tOff > 0 THEN
         	      xDev^.al.et := xPar^.all.tOff;                  // vypnut po cas
            	   xDev^.al.ct := 3;                               // po 100mSEC
	            ELSE
   	            xDev^.al.et := 0;                               // nema sa vypnut po case
      	      END_IF;
				ELSE
					xDev^.al.ex    	:= 0;
				 	xDev^.al.et    	:= 0;
				END_IF;
				_Nh_Dev_CMD();			                                 // vyvolat zapnutie HW cez CMD
			END_IF;
	END_IF;

END_FUNCTION

FUNCTION _Nh_SVX_Qx    : BOOL
	_Nh_SVX_Qx := false;	
	IF _Dev_Qx_PAR(dpa:=xDev^.cf.par) THEN




		_Nh_SVX_Qx := true;
		xDev^.al.el		:=	0;
		xDev^.al.CM    := 0;													// ak bezi delay cm:=2, novy prikaz ho zrusi
//		xDev^.al.RUN   := 0;	                                    //
		
		
		
		IF aCfg[cf].par > 0 THEN											// dev ma parameter, SIR napr nema parameter
 	   	vr    := USINT_TO_REAL(xPar^.all.Lvl);                // default sa podhodi LVL
		ELSE
			vr := 0.0;                                          	// bez parametra nebude potrebovat, lebo pride konkretne CMD
		END_IF;

	
	
		xDev^.cx.all.LastCMD 	:= xDev^.al.in.CMD;					// zapamata posledny pokyn
// 		xDev^.cx.all.LastCMDin	:= true;                         // pokyn je prichadzajuci

		CASE xDev^.al.in.CMD OF
	      1: // prepnut z WEB
   	      xDev^.al.wsb      := true;									// nasilne sa podhodi ako z WSB, aby sa zablokoval pir
//      	   xDev^.al.in.CMD   := 1;
	      2: // prepnut z WSB												// wsb nastavi priznak WSB vo vazbach automaticky
   	      xDev^.al.in.CMD   := 1;
      	3: // resetovat casy nastavit OFF, ale neposielat nic
				cmd	:= 0;
				_Nh_Dev_OFF(cmd:=3);
				xDev^.al.in.CMD := 0;

			6: // stmievanie z  WSB - start
   	      IF xDev^.al.ou.VAL > 0.0 THEN								// stmieva sa len, ak je ON
      	      xDev^.al.Up    := NOT xDev^.al.Up;
					IF xDev^.al.ou.VAL <= 1.0 THEN
      	      	xDev^.al.Up    := true;
					ELSIF xDev^.al.ou.VAL > 99.0 THEN
    					xDev^.al.Up    := false;
					END_IF;
					IF aCfg[cf].lvl254 THEN
	         	   xDev^.al.rmp   := 1;                            // doladit ???
					ELSE
	         	   xDev^.al.rmp   := 3;
   				END_IF;
	  			ELSIF _NhxRom(nr := xDev^.cf.rom, x:=-13) THEN					// ak svetlo nesvieti, PRESS zrusi blokovanie
      	      xRom^.me.BlPirOn 	:= 0;
         	   xRom^.me.BlPirOff := 0;
					xDev^.al.cm := 255;								// aby sa uz az do pustenia BTN nic nerobilo
	         END_IF;
				xDev^.cx.all.LastLvl	:= REAL_TO_USINT(xDev^.al.Ou.val);
				xDev^.al.in.CMD		:= 0;


   	   7: // slider SVA
				IF aCfg[cf].lvl254 THEN
         	   xDev^.al.rmp   := 1;                            // doladit ???
				ELSE
         	   xDev^.al.rmp   := 2;
  				END_IF;
				xDev^.cx.all.LastLvl	:= REAL_TO_USINT(xDev^.al.Ou.val);
				xDev^.al.in.CMD		:= 0;
				xDev^.al.CM				:= 7;

	      8: // RGB - vyber farby a slidery RGBWA
   	      xDev^.al.rmp      := 0;
				xDev^.al.in.CMD	:= 0;

	      9: // specialne zapnutie/vypnutie
				// ak  je prichadzajuci LVL = 0, tak vypne,
				// ak lvl < 100 tak zapne na pomer k hodnoty z parametra
				// ak lvl = 100% tak zapne na plny parameter
				IF vr  = 0.0 THEN
					xDev^.al.in.val := 0.0;
				ELSIF xDev^.al.in.val < 100.0 THEN	
					xDev^.al.in.val := vr * xDev^.al.in.val * 0.01;
				ELSE
					xDev^.al.in.val := vr;
				END_IF;
				_Nh_Dev_RMP();

	     10: // OFF + zapnut blokovanie PIR
   	      xDev^.al.in.val   := 0.0;

	     11: // zapnutie na 100%
				xDev^.al.in.val   := 100.0;                              // zapnut naplno
				_Nh_Dev_RMP();

	     12: // blikac - priame zapnutie na LVL z parametra ak al.in.val > 0, iba vypnut , bez kontroly casov
   	     	xDev^.al.IN.val   := vr;
      	   xDev^.al.wsb      := false;								// nasilne sa podhodi ako z WSB, aby sa zablokoval pir
				_Nh_Dev_RMP();	

	     13: // zapnutie na to co je al.in.val (blikac), bez kontroly casov
				_Nh_Dev_RMP();

		  14: // zapnut na LVL, ulozenu v parametri, nastavit casy opozdeny start/po case vypnut/max.cas zapnutia
   	      xDev^.al.in.val   	:= vr;
				_Nh_Dev_RMP();

	     15: // len zapamatat/ulozit aktualnu LVL pre dalsiu obnovu (blikac)
				xDev^.cx.all.LastLvl := REAL_TO_USINT(xDev^.al.OU.Val);
				xDev^.al.in.CMD	:= 0;
				xDev^.al.trg.Q  	:= 0;													// aby CMD v dalom cykle vyhodnotilo ako Qr, nieQ
				xDev^.al.trg.Qf 	:= 0;							

   	  16: // obnovit zapamatany LVL po ukonceni blikaca
				xDev^.al.In.Val		:= USINT_TO_REAL(xDev^.cx.all.LastLvl);
				_Nh_Dev_CMD();			                                 // vyvolat zapnutie HW cez CMD
				xDev^.al.in.CMD	:= 0;
							
	     21: // PIR - ON
   	      _NhxRom(nr := xDev^.cf.rom, x:=-14);
      	   IF xRom^.me.BlPirOn = 0 AND xRom^.me.BlPirOFF = 0 THEN  	// nie je blokovana ROM po vypnuti, ani po zapnuti
         	   IF xDev^.al.ou.Val < 0.9 OR xPar^.all.rPir THEN          	// je OFF alebo bezi cas-to-OFF a pohyb resetuje cas
            	   xDev^.al.IN.val   := vr;
						_Nh_Dev_RMP();	
						xDev^.al.CM				:= 14;
   	         END_IF;
      	   ELSE
	      	   xDev^.al.in.CMD   := 0;
   	      END_IF;
      	   xDev^.al.wsb      := 0;

			{$IFDEF __NH_DALI}

   	   43: // ON/OFF DLS + dali 5 in On
				xDLs	:= xDev;
	         IF xDls^.cx.cfg.out5inOne THEN 										// 5 in On
					IF xDev^.al.OU.val > 0.0 THEN										// je zapnute, treba vypnut
						ii						:= 0;	
					ELSE
						ii						:= 254;
					END_IF;	
					FOR i := 1 TO 5 DO
						xPar^.rgb.lvl[i] := ii;          							// default parameter je namapovany
   	  			END_FOR;
					xDev^.al.in.val 	:= 100;                                // vzdy posle prikaz do DLM
	      	   xDev^.al.rmp      := 0;
					cmd					:= 143;		
					xDev^.al.in.CMD	:= 0;
   	      ELSE

      	   END_IF;

	     143: // DLS 5-In-One pokyn z {TVE} nastavenych na RGBWA
				xPtIO 	:= UDINT_TO_PTR( REAL_TO_UDINT(xDev^.al.in.val) ) ;	   		// prenasa sa adresa IO, pre zistenie farby
				IF xPtIO^.val > 0. THEN																	// zapnut
					ii	:= 254;
				ELSE
					ii	:= 0;	
				END_IF;
				IF xPtIO^.dev.o > 0 THEN                                                // zisti sa, ktora farba sa nastavika
//						xPar^.rgb.lvl[xPtIO^.dev.o] := MIN(254,REAL_TO_USINT(xPtIO^.val));   // nastavi sa LVL, vzdy 254
					xPar^.rgb.lvl[xPtIO^.dev.o] := ii;   											// nastavi sa LVL, konkretnehj farby RGBWA vzdy 254
				END_IF;
//				xDev^.al.in.val	:= 255.0;                                               // vzdy vysle sa prikaz - aktualizuje vsetky farby
				xDev^.al.in.val 	:= 100;                                // vzdy posle prikaz do DLM
				cmd					:= 143;		
				xDev^.al.in.CMD	:= 0;



	     144: // DLS 5-In-One dotyk nad konkretnou farbou znamen vyslat to co tam je
//				xDev^.al.in.val 	:= 255.0;
				xDev^.al.in.val 	:= 100;                                // vzdy posle prikaz do DLM
				xDev^.al.in.CMD	:= 0;
   	   	cmd       			:= 143;
			{$END_IF}
   	ELSE
			;
   	END_CASE;
//		_Nh_SVX_CMD_1();
		
	ELSIF xDev^.al.trg.Q THEN                                         // presss alebo len zopar cyklov, ked sa neuvolni cmd

		IF aCfg[cf].lvl254 THEN	                                       // DALI  	
			ok	 	:= (SYSTEM_S.R_EDGE_500MS OR SYSTEM_S.F_EDGE_500MS);  // vysiela sa kazdy 250ms
			kr 	:= 7.;
//			kr 	:= 1.;
			ur		:= 100.;
		ELSE
			ok	 	:= aSys.PULSE_50MS;	//SYSTEM_S.R_EDGE_100MS;			// kazdych 50ms, alebo podla cyklu	
			kr 	:= 1.;
			ur		:= 100.;
		END_IF;	

		IF xDev^.al.up = false THEN
			kr	:= kr * -1.;
		END_IF;
		cmd	:= 0;
		IF xDev^.al.cm = 255 THEN                                      // press, ked svetlo nesvietilo {zrusenie blokovania}
			;
		ELSIF ok = false THEN														// nenastala casova vzorka
			;
		ELSIF xDev^.cx.all.LastCMD = 6 THEN										// drzi sa WSB
			vr						:= xDev^.al.IN.val + kr ;							
  			IF vr > 100. THEN
				vr := 100.;
			ELSIF vr < 1. THEN
				vr := 1.;
			END_IF;	
			xDev^.al.IN.val	:= LIMIT(1.0, vr, ur);	
			IF vr <> xDev^.al.IN.val THEN                              	// uz sa dosiahol niektory limit
				xDev^.al.cm := 255;					
			ELSE
				_Nh_Dev_CMD();															
			END_IF;   	
		ELSIF xDev^.cx.all.LastCMD = 7 THEN	                           // slider
			IF ABS(xDev^.al.ou.val - xDev^.al.In.val) >= ABS(kr)  THEN  // bude vysielat do HW, len ked je zmena vacsia
	 			_Nh_Dev_CMD();			
			END_IF;
		ELSIF xDev^.cx.all.LastCMD = 8 THEN	                           // RGB
 			_Nh_Dev_CMD();			
		END_IF;

	ELSIF xDev^.al.trg.Qf THEN														// koniec CMD
		xDev^.al.wsb 	:= 0;
		IF xDev^.cx.all.LastCMD = 8 	OR									// zmena fazby = vyber predvolby
			xDev^.al.cm = 255				OR                         // prikaz uz bol vykonany
			(xDev^.cx.all.LastCMD >= 4 AND xDev^.cx.all.LastCMD <= 7) THEN	// 4=SW-Dim,6=WSB-dim,7-slider
			xDev^.al.cm		:= 0;
			xDev^.al.et		:= 0;

//			_NhxPar(cp := aCfg[cf].par , np := xDev^.al.ou.par, cf:=cf, nd:=nd, x:=110);

			xPar^.all.lvl := REAL_TO_USINT(xDev^.al.in.val);		// zapamata LVL v default parametri
			_Nh_Dev_CMD();														// este raz posle, lebo slider nemusel zachytit vsetko
		END_IF;

	ELSIF aSys.Restart THEN                         				
		IF xDev^.cf.LvlOnRst  THEN	 								// po restarte obnovit
			_Nh_Dev_CMD();			                                 // zapnut HW
		ELSE		
//			xDev^.al.in.Val := 0.0;                               // vypnut aj IN
		END_IF;
	END_IF;
END_FUNCTION

FUNCTION _Nh_SVX   : BOOL
	VAR_INPUT
		c		: 	USINT;
	END_VAR
	VAR_TEMP
		i		: USINT;
//		ii		: USINT;
	END_VAR
   _Nh_SVX	:= _Dev_INI(c := c);
	nd			:= 1;	
   WHILE nd <= aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN //AND nd = 2 THEN
			IF _Nh_SVX_Qx() THEN
				_Nh_SVX_CMD_1();																// nie pre SCN
			END_IF;			
		   xDev^.al.IN.CMD   := 0;															// reset vstup, aby s v dalsom kole vyhodnotil Q,Qf
			IF xDev^.al.cm = 2 THEN
				cmd	:= 0;				
				IF _Nh_Dev_ET_UINT(t :=3, et:= ADR(xDev^.al.et) ) THEN			// odpocitava Delay [min]
					xDev^.al.in.cmd	:= xDev^.cx.all.LastCMD;
					xDev^.al.in.par	:= xDev^.al.ou.par;
					xDev^.al.RUN		:= 255;
//					xDev^.al.cm 		:= 0;
				END_IF;
			ELSIF xDev^.al.cm = 255 THEN													// bezi press a uz sa nema co vykonat
				cmd	:= 0;				
			ELSIF _Nh_Dev_ET_UINT(t :=3, et:= ADR(xDev^.al.et) ) OR				// odpocitava cas zapnutia [min]
 					_Nh_Dev_ET_INT (t :=2, et:= ADR(xDev^.al.ex) ) THEN			// odpocitava max cas zapnutia [min]
				_Nh_Dev_OFF(cmd:=0);			
				_Nh_Dev_CMD();			                                 			// zapnut HW
			END_IF;
//			ok3	:= true;
			ok3	:= cf <> 42;																// stav DALI-mastra sa robi inak ako cez _Nh_Sta_Rom
			CASE cmd OF
           	 0: ;
				 3: ; //
          	10: ; // SVD,ZAS,SIR.... digital
			      	xSvD 					:= xDev;
						IF xSvD^.hw.d[0] > 0 THEN
	                  xDev^.al.Ou.CMD	:= 180;
   	   			   xPtB 					:= UDINT_TO_PTR(xSvD^.hw.d[0]);

 							_Nh_Log_Evn_ADD(tsk:=10);

      				   xDev^.al.OU.val   := xDev^.al.IN.val;
         			 	xPtB^             := REAL_TO_BOOL(xDev^.al.OU.val);                  // in, nie ou
	 	      		   IF xDev^.cf.inv THEN
 		         			xPtB^ := NOT xPtB^;
	      	  	   	END_IF;
						END_IF;	      	  	

				11:	// SVA
    					xDev^.al.Ou.CMD	:= 180; 																	// default CMD pre vystupne zariadenie
						IF xDev^.hw.typ = 43 THEN
							;
						ELSIF xDev^.hw.d[0] > 0  THEN                                     			// xDev = xSva
							ok := xDev^.cx.dim.DimHW;
							IF ok THEN                                                        // ma sa stmievat HW
								IF xDev^.hw.d[1] = 0 THEN                                     	// ak nie je HW adresa stmievania
									ok := false;                                                // bude sa stmievat SW
								END_IF;
							ELSIF xDev^.hw.d[1] > 0 THEN                                     	// ma sa stmievat SW ale mame HW adresu rampy
								xPtU 					:= UDINT_TO_PTR(xDev^.hw.d[1]);
								xPtU^ 				:= 0;														// rampu nastavi na 0		
							END_IF;		

 							_Nh_Log_Evn_ADD(tsk:=10);
 							
							IF ok THEN
								xPtU 					:= UDINT_TO_PTR(xDev^.hw.d[1]);
								xPtU^ 				:= xDev^.al.rmp;
   	   		         xDev^.al.ou.val   := xDev^.al.in.val;
							ELSE
								_Nh_Dim_SW();
							END_IF;
							xDev^.al.el			:= 0;
							xPtR 					:= UDINT_TO_PTR(xDev^.hw.d[0]);
							xDev^.al.ou.val	:= LIMIT(0.0, xDev^.al.in.val, 100.0);
							xPtR^					:= _Nh_LVL_100(	lvlMin	:=	xDev^.cx.sva.Lv0,
																			lvlMax	:=	xDev^.cx.sva.Lv1,
																			lvlIn		:=	xDev^.al.ou.val);						
							CASE xDev^.hw.typ OF
      	              0:	// BOOL
									xPtB	:= xPtr;
									xPtB^	:= REAL_TO_BOOL(xPtr^);
                    	  1: // REAL
//							  		xPtR^	:= kr;
							  2:	// USINT
									xPtU	:= xPtr;
									xPtU^	:= REAL_TO_USINT(xPtr^);
      	            END_CASE;
						END_IF;



(*

                  xDev^.al.Ou.CMD	:= 180; 																	// default CMD pre vystupne zariadenie
						IF xDev^.hw.d[2] > 0 THEN                                     		// mame adresu HW minima (RLC)
 							xPtR 	:= UDINT_TO_PTR(xDev^.hw.d[2]);
							xPtR^ := _Nh_255_100(xDev^.cx.sva.Lv0);
						END_IF;
						xPtR := UDINT_TO_PTR(xDev^.hw.d[0]);
						IF xDev^.cx.dim.DimHW THEN														// stmieva sa HW - treba mat na to HW !!!!
							IF xDev^.hw.d[1] = 0 THEN                                     	// ak nie je HW adresa
								xDev^.cx.dim.DimHW := 0;	
							ELSE
		    					xPtU := UDINT_TO_PTR(xDev^.hw.d[1]);
							END_IF;
						END_IF;
					   IF xDev^.al.off AND xDev^.cx.dim.tOnL > 0	THEN	     					// prve zapnutie lampy, ktora ma opozdeny nabeh
							xDev^.al.run		:= xDev^.al.cm;
							xDev^.al.cm			:= 2;                                        // delay
							xDev^.al.et		   := USINT_TO_UINT(xDev^.cx.dim.tOnL);			
							xDev^.al.ct		   := 3;
							xDev^.al.ou.val   := USINT_TO_REAL(xDev^.cx.sva.Lv0);				// mSec				
							IF xDev^.cx.dim.DimHW THEN
			               xPtU^ 				:= 0;													// bez rampy
							END_IF;						
						ELSIF xDev^.cx.dim.DimHW THEN
		               xPtU^ 				:= xDev^.al.rmp;
      	         	xDev^.al.ou.val   := xDev^.al.in.val;
						ELSIF xDev^.al.cm = 4 THEN
							xDev^.al.cm := xDev^.al.RUN;					
						ELSE
							xDev^.al.up := xDev^.al.in.val > xDev^.al.OU.val;						
							xDev^.al.cm := 4;					
						END_IF;
						xDev^.al.ou.val			:= LIMIT(0.0, xDev^.al.ou.val, 100.0);
*)

						

				12:  // RGB

            	   xDev^.al.Ou.CMD	:= 180;
						xRgb					:= xDev;
						xDev^.al.ou.val	:= LIMIT(0.0, xDev^.al.in.val, 100.0);
   		      	vr	:= _Nh_LVL_100(	lvlMin	:=	xDev^.cx.sva.Lv0,
													lvlMax	:=	xDev^.cx.sva.Lv1,
													lvlIn		:=	xDev^.al.ou.val);
 							
							 _Nh_Log_Evn_ADD(tsk:=10);

//						_NhxPar(cp := aCfg[cf].par , np := xDev^.al.ou.par,cf:=cf, nd:=nd ,x:=-1019);       // parameter z vazby
						FOR i := 1  TO 5 DO
							IF xRgb^.hw.d[i-1] > 0 THEN
								xPtR 	:= UDINT_TO_PTR(xRgb^.hw.d[i-1]);
		   	 				xPtU 	:= xPtR;
		    					xPtU 	:= xPtU + 4;
								xPtU^ := xDev^.al.rmp;
								xPtR^ := LIMIT(0.0, (USINT_TO_REAL(xPar^.rgb.lvl[i])/255.0) * vr, 100.) ;
							END_IF;
               	END_FOR;		
         254 : ; // DevExt
           ;
			ELSE
				xDev^.al.Ou.CMD	:= 0;
			END_CASE;
			///// toto je pokus 21.12.24 pri oprave stmievania cez DIM {presunute do ELSE}
			{$IFDEF __NH_DALI}
			CASE cf OF
			  	42: 	// DALI MASTER DLma
						xDLm	:= xDev;
						IF xDLm^.al.sta < 2 THEN										// NE-bezi QUERY, alebo RND
							IF cmd = 42 THEN									
								dlma := INT_TO_USINT(nd);
     							_Nh_DL_ADD_Task(wht:=2, sha:=255, par:= 20, val:=xDev^.al.rmp, dlm:=dlma);				// rampa
								_Nh_DL_ADD_Task(wht:=1, sha:=255, lvl:=xDev^.al.IN.val, dlm:=dlma ); // lvl
								xDLm^.me.lvl255 	:= true;                                                          // priznak mastra
								xDLm^.me.Rmp255 	:= xDev^.al.rmp;                                                  // aka rampa do vsetkych DLS
				      	   _NhMemSetPTR(size := SIZEOF(NH_DLM_GRP), dest:= ADR(xDLm^.me.scn) );						// vynuluje sceny
							ELSE
								xDLm^.al.In.val 	:= 0.0;											// vynuluje sa, LVL urobi az sumarne DLs
							END_IF;
							xDev^.al.OU.val	:= xDev^.al.IN.val;              			
							xDLm^.al.sta	:= 0;                               			// stav	sa urobi az v DLs	
						END_IF;
//						ok3 := 0;                               								// nevyhodnoti sta, to az kazde DEV

				44:	// DLg sa robi pred DLs ( ballastom )
    					xDLg 					:= xDev;
				  		dlma 					:= _Nh_DL_sha(nd:=nd, gr:=true, ma:=true);   // 1..2
	              	dlsl 					:= _Nh_DL_sha(nd:=nd, gr:=true);     			// 100..115
						_NhxDLm(dlm:=dlma);															// namapuje xDLm
						IF xDLm^.me.lvl255 THEN														// prikaz z mastra oznaci len v SW sceny vypnute, nic neposiela do HW
							xDev^.al.IN.val := 0.0;						
						ELSIF cmd = 44 THEN									
	 						IF xDLg^.me.rmp <> xDev^.al.rmp THEN                   		// zmena rampy
		         			_Nh_DL_ADD_Task(wht:=2, sha:=dlsl, par:= 20, val:=xDev^.al.rmp, dlm:=dlma);			// rampa dp vsetkych ballastov v scene
	   						xDLg^.me.rmp := xDev^.al.rmp;
   		   	      END_IF;
							
							IF xDev^.al.IN.val > 99.0 THEN								      // zapnut celu scenu na LVL ballastov v scene, na nizsi Level sa drobi v DLs
								_Nh_DL_ADD_Task(wht:=7, sha:=dlsl, par:=dlsl-100, dlm:=dlma );	// par je GRP 0..15,  sha je skupinova adresa 100..115
							ELSE	//IF xDev^.al.IN.val = 0. THEN											// len vypnut
								_Nh_DL_ADD_Task(wht:=1, sha:=dlsl, dlm:=dlma, lvl:=xDev^.al.IN.val );  // sha je skupinova adresa 100..115
							END_IF;		

      					// v mastri oznaci, ze bol set sceny
							xDev^.al.Qx						:= true;									// priznak, ze scena je zapnuta
							xDLm^.me.scn.SET[dlsl-100] := true;									// priznak nastavene sceny						
							xDLm^.me.scn.LVL[dlsl-100] := REAL_TO_USINT(xDev^.al.IN.val);
							xDLm^.me.scn.RMP[dlsl-100] := xDLg^.me.rmp;						//	ramapa do vsetkych SHA					

						ELSIF xDLm^.me.scn.LVL[dlsl-100] > 0  THEN							// SCN je zapnuta
							IF xDLm^.me.scn.DEV[dlsl-100] = false THEN						// ziadne DEV v SCN NIE-je zanute aspon na minimum
								xDLm^.me.scn.LVL[dlsl-100] := 0;									// toto musi byt koli xDlG^.al.in.CMD 	:= 3;
								xDlG^.al.in.CMD 				:= 3;									// len vypne scenu a resetne casy, ALE NEPOJDE DALEJ DO PRIKAZU !!!
							END_IF;
						END_IF;        	
						xDLm^.me.scn.DEV[dlsl-100] := false;
						xDev^.al.OU.val	:= xDev^.al.IN.val;

				43:	// na konci urobi ballast , sumare do mastra aj skontroluje scenu
						xDLs	:= xDev;
  		            dlsl 	:= _Nh_DL_sha(nd:=nd);              								// 0..64 pre master
     					dlma 	:= _Nh_DL_sha(nd:=nd, ma:=true);          						// 1..2
						_NhxDLm(dlm := dlma);                              					// xDLm

						IF xDLm^.me.lvl255 THEN															// bol centralny LVL, ma najvyssiu prioritu
							xDev^.al.In.Val	:= xDLm^.al.Ou.Val;           					// do ballastu zapise LVL z mastra
     						xDLs^.me.rmp 		:= xDlm^.al.rmp;                             // preberie sa aj rampa, ktoru nastavil master do vsetkych SHA
							xDev^.al.OU.Val 	:= xDev^.al.IN.Val;									
						ELSIF cmd = 43 THEN									      					// klasicke dev
							IF xDLs^.me.rmp <> xDev^.al.rmp THEN
 								_Nh_DL_ADD_Task(wht:=2, sha:=dlsl, par:= 20, val:=xDev^.al.rmp, dlm:=dlma);
      						xDLs^.me.rmp := xDev^.al.rmp;
           				END_IF;
							_Nh_DL_ADD_Task(wht:=1, sha:=dlsl, lvl:=xDev^.al.IN.val, dlm:=dlma );
							xDev^.al.OU.Val 	:= xDev^.al.IN.Val;									
						ELSIF  cmd = 143 THEN 															// len pre xDLs^.cx.cfg.out5inOne
							xDev^.al.et 	:= 0;
							xDev^.al.ex 	:= 0;
	         			xDLs^.al.rmp   := 0;                                        // tu sa nestmieva, ide sa na ON/OFF
							IF xDLs^.me.rmp <> xDLs^.al.rmp THEN
  								_Nh_DL_ADD_Task(wht:=2, sha:=dlsl, par:= 20, val:=xDev^.al.rmp, dlm:=dlma);
       						xDLs^.me.rmp := xDev^.al.rmp;
	           			END_IF;
							xDLs^.me.SendDLM := true;
							_Nh_DL_ADD_Task(wht:=6, sha := dlsl, dlm := dlma, lvl := xDev^.al.IN.Val  );
							// zistit stav
							xDev^.al.Ou.Val := 0.0;     											// na zaciatku podhodi sa vypnute			
							FOR i := 1 TO 5 DO
								IF xPar^.rgb.lvl[i] > 0 THEN          							// default parameter je namapovany
//									xDev^.al.Ou.Val := 254;											// ak je nieco z RGBWA zapnute, je cely SHA zapnuty
									xDev^.al.Ou.Val := 100.;										// ak je nieco z RGBWA zapnute, je cely SHA zapnuty
									EXIT;
								END_IF;
          				END_FOR;
							xDev^.al.In.Val := 0.0;													// u tohto typu vynuluje vstup
						
						// ponastavuje DLg
						ELSIF xDLs^.cx.scn.grp <> _eBtn15 THEN									// patri do nejakej sceny
                  	FOR i := 0 TO 15 DO															
								IF xDLs^.cx.scn.grp[i] THEN										// patri do sceny i
									_NhxDLg(grp := i, dlm := dlma);								// namapuje scenu	
									IF xDLm^.me.scn.set[i]	THEN									// scena bola v tomto cykle ON alebo OFF
										IF xDLg^.al.Ou.Val < 100. THEN                 		// scena pola stmievana, toto dev sa nezaplo/nevyplo 	
											xDev^.al.IN.Val := xDLg^.al.Ou.Val;					// scena nastavila len lvl, nezapla DEV
										ELSE
											xDev^.al.IN.Val := USINT_TO_REAL(xDLs^.cx.scn.lvl[i]);	// toto DLs sa nastavilo na LVL, ktoru ma urcenu v SCENE
										END_IF;
										xDLs^.me.rmp 		:= xDLm^.me.scn.RMP[i];				// scena vzdy nastavi rmpu kazdeho DLs
										xDev^.al.OU.Val 	:= xDev^.al.IN.Val;									
										xDLm^.me.scn.DEV[i] := true;
//									ELSIF xDlg^.al.Qx = false THEN								// uz bola vypnuta scena predchadzajucin DEV
										;
									ELSIF xDLs^.cx.scn.lvl[i] > 0 AND xDev^.al.Ou.Val > 0. THEN // DEV ma mat uroven a je vypnute
//										xDlg^.al.Qx 		:= false;
										xDLm^.me.scn.DEV[i] := true;
//										xDlG^.al.in.CMD 	:= 3;										// len vypne scenu a resetne casy

(*
									ELSIF xDev^.al.Ou.Val = 0 AND xDLs^.cx.scn.lvl[i] > 0 THEN // DEV ma mat uroven a je vypnute
										xDlg^.al.Qx 		:= false;
										xDlG^.al.in.CMD 	:= 3;										// len vypne scenu a resetne casy
*)
									
(*
									ELSIF xDlg^.al.Qx = false THEN
										;
									ELSIF xDLg^.al.Ou.Val < 100. THEN                 		// scena pola stmievana, toto dev sa nezaplo/nevyplo 	
										IF xDev^.al.Ou.Val <> xDLg^.al.Ou.Val THEN  // dev ma iny LVL ak o ma mat v ecene
											xDlg^.al.Qx 		:= false;
											xDlG^.al.in.CMD 	:= 3;										// len vypne scenu a resetne casy
										END_IF;
									ELSIF REAL_TO_USINT(xDev^.al.Ou.Val) <> xDLs^.cx.scn.lvl[i] THEN  // dev ma iny LVL ak o ma mat v ecene
										xDlg^.al.Qx 		:= false;
										xDlG^.al.in.CMD 	:= 3;										// len vypne scenu a resetne casy
*)
									END_IF;
								END_IF;
							END_FOR;
						END_IF;

						IF xDLm^.al.sta < 2 AND xDLm^.me.lvl255 = false THEN         		// zapise priznak do mastra, ak neprebieha CHK alebo nebol centralny prikaz		
							xDLm^.al.In.Val	:= MAX(xDLm^.al.In.Val, xDev^.al.IN.Val); 	// do mastra zapise hodnotu z ballastu													
 			  				xDLm^.al.Ou.Val 	:= xDLm^.al.In.Val;                				
							IF xDLm^.al.Ou.Val > 0.0 THEN
								xDLm^.al.sta	:= 1;															// az tu sa oznaci master, ze svieti
							END_IF;
						END_IF;
			ELSE
				xDev^.al.Ou.CMD	:= 0;	
			END_CASE;
			{$END_IF}

			IF ok3 THEN
				_Nh_Sta_Rom(sta := BOOL_TO_USINT(REAL_TO_BOOL(xDev^.al.OU.val)) );             // stav			
			END_IF;

			// vynuluje koli press, ked Qr sem uz nejde
//			xDev^.al.in.par   := 0;
			cmd					:= 0;

      END_IF;
		nd		:= nd 	+ 1;
   END_WHILE;
END_FUNCTION


FUNCTION _Nh_DEV_RESTART_1  {HIDDEN} :  BOOL   											// kontroly DEV po restarte
	_Nh_DEV_RESTART_1 := true;
	WHILE _Dev_DEV() DO
		IF xDev^.ok.OK THEN
			RETURN;
		END_IF;
	END_WHILE;
	_Nh_DEV_RESTART_1 := false;
END_FUNCTION

VAR_GLOBAL
   rrr   : UDINT;
END_VAR

FUNCTION   _Nh_DEV_RESTART  {HIDDEN} :  BOOL   											// kontroly DEV po restarte
//	aMeteo.WindDelayRol.rst := true;										// resetnut silny vietor

	{$IFDEF __NH_DALI}
  	_Nh_DEV_RESTART := _NH_DEV_INI(c:=44);                            // cf,nd=0,xDev na nd:=0
	WHILE _Nh_DEV_RESTART_1() DO
		xDlg  	:= xDev;
      yTx1  :=  xDev^.cf.Name;
//      REPLACE_CHAR(c1:=16#01,c2:=16#00,input:=yTx1);
      REPLACE_CHAR(c1:=16#01,c2:=16#2C,input:=yTx1);
      REPLACE_CHAR(c1:=16#2C,c2:=16#00,input:=yTx1);
      rrr:=rrr+sz;
      xDev^.cf.Name:=yTx1;
	END_WHILE;
   {$END_IF}

(*
  	_Nh_DEV_RESTART := _NH_DEV_INI(c:=1);                            // cf,nd=0,xDev na nd:=0
	WHILE _Nh_DEV_RESTART_1() DO
		xRom  	:= xDev;
		IF xRom^.cx.IniDefault = false THEN 		
				xRom^.cx.IniDefault := 1;
				IF xRom^.cx.LuxMin_OLD > 0 AND xRom^.cx.LuxPar.LuxMin = 0 THEN
					xRom^.cx.LuxPar.LuxMin := xRom^.cx.LuxMin_OLD;
				END_IF;
				xRom^.cx.LuxPar.LuxYes	:= 1; 		
				xRom^.cx.LuxPar.RolYes	:= 1; 		
				xRom^.io[100].FromZon	:= 1; 		
				xRom^.io[101].FromZon	:= 1; 		
				xRom^.io[101].FromOut	:= 1; 		
				xRom^.io[102].FromZon	:= 1; 		
				xRom^.cx.LuxPar.KoefBli	:= 1.2; 		
				xRom^.cx.LuxPar.RolMin	:= 50;
		END_IF;
	END_WHILE;
*)

(*
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=3);                            // cf,nd=0,xDev na nd:=0
	WHILE _Nh_DEV_RESTART_1() DO
		xRom  	:= xDev;
		IF xRom^.cx.IniDefault = false THEN 		
 			xRom  	:= xDev;
				IF xRom^.cx.LuxMin_OLD > 0 AND xRom^.cx.LuxPar.LuxMin = 0 THEN
					xRom^.cx.LuxPar.LuxMin := xRom^.cx.LuxMin_OLD;
				END_IF;
			xRom^.cx.LuxPar.LuxYes	:= 1; 		
			xRom^.cx.LuxPar.RolYes	:= 0; 		
			xRom^.io[100].FromZon	:= 0; 		
			xRom^.io[101].FromZon	:= 0; 		
			xRom^.io[101].FromOut	:= 0; 		
			xRom^.io[102].FromZon	:= 0; 		
			xRom^.cx.LuxPar.KoefBli	:= 1.0; 		
		END_IF;
	END_WHILE;
*)


(*
	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=6);                            // HET
		WHILE _Nh_DEV_RESTART_1() DO
			xHet := xDev;
//			IF xHet^.cx.reg.IniDefault = FALSE THEN
			IF true THEN
//				xHet^.cx 					:= eHet.cx;

				FOR i := 0 TO 1 DO
					xHet^.cx.reg.reg[i].hys 					:= eHet.cx.reg.reg[i].hys;
            END_FOR;

//         xHet^.cx.reg.reg[0].req[0] :=  5.0;
//         xHet^.cx.reg.reg[0].req[1] := 20.0;
//         xHet^.cx.reg.reg[0].req[2] := 23.0;
//			xHet^.cx.reg.reg[0].req[3] := 25.0;


				xHet^.cx.reg.IniDefault := true;
			END_IF;	

		END_WHILE;


	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=47);                            // HEv
		WHILE _Nh_DEV_RESTART_1() DO
			xHet := xDev;
//			IF xHet^.cx.reg.IniDefault = FALSE THEN
			IF true THEN
//				xHet^.cx.reg 					:= eHev.cx.reg;
//				xHet^.cx 					:= eHev.cx;

				FOR i := 0 TO 1 DO
					xHet^.cx.reg.reg[i].hys 					:= eHet.cx.reg.reg[i].hys;
            END_FOR;


				xHet^.cx.reg.IniDefault := true;
			END_IF;	
		END_WHILE;
	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=7);                            // KOT
		WHILE _Nh_DEV_RESTART_1() DO
			xTve := xDev;
//			IF xTve^.cx.reg.IniDefault = FALSE THEN
			IF true THEN
//				xTve^.cx 					:= eKot.cx;

				FOR i := 0 TO 1 DO
					xHet^.cx.reg.reg[i].hys 					:= eHet.cx.reg.reg[i].hys;
            END_FOR;

				xTve^.cx.reg.IniDefault := true;
	
			END_IF;	
		END_WHILE;
	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=8);                            // TVE
		WHILE _Nh_DEV_RESTART_1() DO
			xTve := xDev;
//			IF xTve^.cx.reg.IniDefault = FALSE THEN
			IF true THEN
//				xTve^.cx 					:= eTVE.cx;
				FOR i := 0 TO 1 DO
					xHet^.cx.reg.reg[i].hys 					:= eHet.cx.reg.reg[i].hys;
            END_FOR;

				xTve^.cx.reg.IniDefault := true;
			END_IF;	
		END_WHILE;
	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=9);                            // CER
		WHILE _Nh_DEV_RESTART_1() DO
			xTve := xDev;
//			IF xTve^.cx.reg.IniDefault = FALSE THEN
			IF true THEN
//				xTve^.cx 					:= eCER.cx;
				FOR i := 0 TO 1 DO
					xHet^.cx.reg.reg[i].hys 					:= eHet.cx.reg.reg[i].hys;
            END_FOR;

				xTve^.cx.reg.IniDefault := true;
			END_IF;	
		END_WHILE;
	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=23);                            // VEN,REK
		WHILE _Nh_DEV_RESTART_1() DO
			xTve := xDev;
//			IF xTve^.cx.reg.IniDefault = FALSE THEN
			IF true THEN
//				xTve^.cx 					:= eVEN.cx;
				FOR i := 0 TO 1 DO
					xHet^.cx.reg.reg[i].hys 					:= eHet.cx.reg.reg[i].hys;
            END_FOR;
				xTve^.cx.reg.IniDefault := true;
			END_IF;	
		END_WHILE;

*)

(*
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=31);                            // rolety
	WHILE _Nh_DEV_RESTART_1() DO
 		xRol  	:= xDev;
		IF xRol^.cx.IniDefaul = FALSE THEN
			xRol^.cx.IniDefaul := true;
			xRol^.cx.pLam	:= 0;
			xRol^.cx.uLam	:= 0;
			xRol^.cx.pRol 	:= 0;
			xRol^.cx.uRol	:= 0;
			xRol^.cx.yLam	:= 0.0;
			xRol^.cx.yRol	:= 0.0;
			xRol^.cx.CMD	:= 3;
			xRol^.al.in.val:= 0.0;
			xRol^.al.in.val:= 0.0;
			xRol^.al.ou.val:= 0.0;
			xRol^.cx.NextPar				:= 0;
			xRol^.cx.tStart 				:= UINT_TO_DT(0);							
			xRol^.cx.DelayStart  		:= 0;


		

			xRol^.cx.cf.tUp.Mot 			:= 0;
			xRol^.cx.cf.tUp.chg 			:= 5;
			xRol^.cx.cf.tDn.Mot 			:= 0;
			xRol^.cx.cf.tDn.chg 			:= 5;



			xRol^.cx.cf.tPvHwLam	 	:= 5;
			xRol^.cx.cf.tDelayRev 	:= 10;
			xRol^.cx.cf.tDelayEnd 	:= 2;
			xRol^.cx.cf.LamHWpulse 	 	:= 1;
			xRol^.cx.cf.LamAngle			:= 90;
			xRol^.cx.cf.SetDark 			:= 1;
			xRol^.cx.cf.DarkLam 			:= 40;
			xRol^.cx.cf.DarkRol 			:= 50;
			xRol^.cx.cf.DarkRolLvl 		:= 45;	
			xRol^.cx.cf.WindGuardOn		 := true;
			xRol^.cx.cf.WindWaitOn		 := 60;		   					// po akom case [min] pokial presiahne vietor hodnotu [s]
			xRol^.cx.cf.WindWaitOFF		 := 60;                      // ak prestane vietor, po kolkych minutach sa zatiahne tak ako bolo [min]
			xRol^.cx.cf.WindSpeedOn		 := 9;								//	rychlost, pri ktorej sa aktivuje ochrana 	
			xRol^.cx.cf.WindSpeedOFF	 := 5;								//	rychlost, pri ktorej sa aktivuje koniec ochrany
			xRol^.cx.cf.WindDirFrom	 	 := 0;	
			xRol^.cx.cf.WindDirTo	 	 := 360;	
			xRol^.cx.cf.WindGuardOn		 := 1;			
			xRol^.cx.cf.WindDirOnly		 := 0;			
			xRol^.cx.cf.WindGuardBlkTime:= 120;	
			xRol^.cx.cf.IgnoreReqLam	:= 5;
			xRol^.cx.cf.IgnoreReqRol	:= 5;
		
			IF _NhxPar(cp := aCfg[31].par , np := xRol^.cf.par,x:=-1018) THEN
				pRol := xPar;
//				pRol^.SetPozi 	:= false;
				pRol^.all.tDelay 	:= 0;
			END_IF;
		END_IF
	END_WHILE;
  *)

	IF xHom^.cx.IniDefault = false THEN 		
		xHom^.cx.IniDefault := 1;
	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=1);                            // cf,nd=0,xDev na nd:=0
		WHILE _Nh_DEV_RESTART_1() DO
 			xRom  	:= xDev;
			xRom^.cx.LuxPar.LuxYes	:= 1; 		
			xRom^.cx.LuxPar.RolYes	:= 1; 		
			xRom^.io[100].FromZon	:= 1; 		
			xRom^.io[101].FromZon	:= 1; 		
			xRom^.io[101].FromOut	:= 1; 		
			xRom^.io[102].FromZon	:= 1; 		
			xRom^.cx.LuxPar.LuxMin	:= xRom^.cx.LuxMin_OLD; 		
			xRom^.cx.LuxPar.RolMin	:= 50;
			xRom^.cx.LuxPar.KoefBli	:= 1.2; 		
		END_WHILE;
	   _Nh_DEV_RESTART := _NH_DEV_INI(c:=3);                            // cf,nd=0,xDev na nd:=0
		WHILE _Nh_DEV_RESTART_1() DO
 			xRom  	:= xDev;
			xRom^.cx.LuxPar.LuxYes	:= 1; 		
			xRom^.cx.LuxPar.RolYes	:= 0; 		
			xRom^.io[100].FromZon	:= 0; 		
			xRom^.io[101].FromZon	:= 0; 		
			xRom^.io[101].FromOut	:= 0; 		
			xRom^.io[102].FromZon	:= 0; 		
			xRom^.cx.LuxPar.LuxMin	:= xRom^.cx.LuxMin_OLD; 		
			xRom^.cx.LuxPar.KoefBli	:= 1.0; 		
		END_WHILE;
	END_IF;	



	
	
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=40);                            // cf,nd=0,xDev na nd:=0
	WHILE _Nh_DEV_RESTART_1() DO
 		xTgl  	:= xDev;
      xTgl^.cx.cfC.nBTNs 		:= SINT_TO_USINT(xTgl^.cf.typ);
		IF aCfg[cf].ver = 0 THEN
			xTgl^.cx := eTgl.cx;
		END_IF;
   	IF xTgl^.cf.typ = 0 OR xTgl^.cf.typ > 8 THEN
   		xTgl^.cf.typ 	:= 6;
     	END_IF;
		xTgl^.cx.cfL.BtnBli  := LIMIT(xTgl^.cx.cfL.BtnBli,1,SINT_TO_USINT(xTgl^.cf.typ));
		IF xTgl^.cx.cfL.BtnRgb > 3 THEN
	      xTgl^.cx.cfL.BtnRgb 		:= 3;
		END_IF;
(*
      xTgl^.cx.cfL.BtnRgb 		:= 3;
      xTgl^.cx.cfL.dayLvl[0] 	:= 100;
      xTgl^.cx.cfL.dayLvl[1] 	:= 70;
      xTgl^.cx.cfL.dayLvl[2] 	:= 40;
      xTgl^.cx.cfL.dayLvl[3] 	:= 90;
		FOR i := 0 TO 3 DO
	      xTgl^.cx.cfL.DaySlp[i] 	:= 0;
      END_FOR;
      xTgl^.cx.cfL.Sleep 		:= 0;
      xTgl^.cx.cfL.PirRst 		:= 1;
      xTgl^.cx.cfL.PirRst 		:= 1;
*)
      xTgl^.cx.cfL.etSlp	:= -2;
		xTgl^.cx.cfD.etSlp	:= -2;
		xTgl^.cx.cfD.off		:= false;				

	END_WHILE;
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=13);                            // cf,nd=0,xDev na nd:=0
	WHILE _Nh_DEV_RESTART_1() DO
 		xTgl  	:= xDev;
		IF aCfg[cf].ver = 0 THEN
			xTgl^.cx := eTgl.cx;
		END_IF;
   	IF xTgl^.cf.typ = 0 OR xTgl^.cf.typ > 8 THEN
   		xTgl^.cf.typ 	:= 2;
     	END_IF;
      xTgl^.cx.cfC.nBTNs 	:= SINT_TO_USINT(xTgl^.cf.typ);
		xTgl^.cx.cfL.BtnBli  := LIMIT(xTgl^.cx.cfL.BtnBli,1,SINT_TO_USINT(xTgl^.cf.typ/2));
      xTgl^.cx.cfL.etSlp	:= -2;
	END_WHILE;

   _Nh_DEV_RESTART := _NH_DEV_INI(c:=14);                            // cf,nd=0,xDev na nd:=0
	WHILE _Nh_DEV_RESTART_1() DO
 		xTGl  	:= xDev;
   	IF xTgl^.cf.typ = 0 OR xTgl^.cf.typ > 5 THEN
   		xTgl^.cf.typ 	:= 1;
     	END_IF;
      xTgl^.cx.cfC.nBTNs 	:= SINT_TO_USINT(xTgl^.cf.typ);
	END_WHILE;


   _Nh_DEV_RESTART := _NH_DEV_INI(c:=6);                            // KOT
	WHILE _Nh_DEV_RESTART_1() DO
 		xDev^.cf.cat := 5;
	END_WHILE;
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=7);                            // KOT
	WHILE _Nh_DEV_RESTART_1() DO
 		xDev^.cf.cat := 39;
	END_WHILE;
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=8);                            // TVE
	WHILE _Nh_DEV_RESTART_1() DO
 		xDev^.cf.cat := 39;
	END_WHILE;
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=9);                            // CER
	WHILE _Nh_DEV_RESTART_1() DO
 		xDev^.cf.cat := 39;
	END_WHILE;


	{$IFDEF __NH_DALI}
(*
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=42);                            // cf,nd=0,xDev na nd:=0
	dlma := 1;
	WHILE _Nh_DEV_RESTART_1() DO
// 		_Nh_DL_ADD_Task(dlm:=dlma, wht := 3, par := 0, sha := 255 ,Block:=true );                       // sta:=  2; pritomnost ballastov
//      _Nh_DL_ADD_Task(dlm:=dlma, wht := 3, par := 1, sha := 255 ,Block:=true );                       // sta:=  3; LVL ballastov
//      _Nh_DL_ADD_Task(dlm:=dlma, wht := 113, par := 16, sha := 255 ,Block:=true );                    //sta:= 4+5  uroven vykonu jedneho SHA v scene: PAR
		dlma := dlma + 1;
	END_WHILE;
*)
   _Nh_DEV_RESTART := _NH_DEV_INI(c:=43);                            // cf,nd=0,xDev na nd:=0
	dlma := 1;
	WHILE _Nh_DEV_RESTART_1() DO
		xDLs	:= xDev;
		xDLs^.me.rmp	:= 99;														// po restarte podhodi nezmyselne cislo
	END_WHILE;
	{$END_IF}
END_FUNCTION


FUNCTION _Nh_TER  {HIDDEN}  : BOOL
   VAR_INPUT
      c     : USINT;
   END_VAR
   _NH_TER := _NH_DEV_INI(c:=c);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC() THEN
     		xTer  := xDev;
			IF xTer^.me.man = false THEN												// VYPNUTE manualne ovladanie cez slider
			   xPtR  := UDINT_TO_PTR(xTer^.hw.d[0]);
//				xDev^.al.IN.val	:= ROUND(xPtR^ * 10.0) / 10.0;   			// zaokruhli na 0.1
				xDev^.al.IN.val	:= xPtR^ ;   			
			END_IF;			
			CASE aSys.RefCyc OF
          	2 : 	// 2.vykonny cyklus - nastavia sa TER,LUX.... aj su ukoncene TypDay pre ZON, Dark od roliet ....
						xDev^.al.vaz := false;			 													// reset priradenia - nastavi sa v ROM/ZON
						xDev^.al.lst := false;			 													// reset priradenia - nastavi sa v ROM/ZON
			END_CASE;

			xTer^.me.f1R (	In 	:= 	xDev^.al.in.val + xTer^.cx.kor ,
								fil	:=    USINT_TO_REAL( xTer^.cx.fil ),	// * 800.0,
								hys	:=		xTer^.cx.hys,
								rst	:= 	xDev^.al.in.cmd = 7 ,	//OR aSys.rst.Qr ,
								sample:=    xTer^.cx.sample,
								Out 	=> 	xDev^.al.OU.val		);										// tu uz pride len s 1.des. miestom


			IF xTer^.me.f1R.Qr OR aSys.RefCyc=2 THEN
//				xDev^.al.OU.val := FLOOR(xTer^.me.f1R.out * 10.0)*0.1;								// pevne 1.des.miesto
				_NhDevRef(xR  := xDev);                                                                        // refresh
				IF xDev^.cf.blk = false THEN
					xDev^.al.OU.cmd   := 100;
					IF xTer^.cx.BlkDefRom = false THEN
						CASE cf OF
							16:	// teplota miestnosti
									xDev^.al.OU.cmd   := 100;
									IF _NhxRom(nr := xDev^.cf.rom ,x:=71) THEN
										_Nh_CHG_VAL(io := ADR( xRom^.io[100] ), val := xDev^.al.ou.val, zon:=false);
						  				_NhDevRef(xR  := xRom);
									END_IF;
	       			END_CASE;
					END_IF;
   			END_IF;
  				_NhDevRef(xR  := xDev);			
			END_IF;
		ELSE
			xDev^.al.OU.val := -0.0;
		END_IF;
		xDev^.al.in.cmd 	:= 0;		
	END_FOR;
END_FUNCTION

FUNCTION _Nh_LUX  {HIDDEN}  :BOOL
   VAR_INPUT
      c     : USINT;
   END_VAR
   _NH_LUX := _NH_DEV_INI(c:=c);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC() THEN
	   	xLux  := xDev;
         xPtR  := UDINT_TO_PTR(xLux^.hw.d[0]);                                         // default je hodnota v REAL (%)
     	   CASE xLux^.hw.typ OF
         	   2: // INT - LUX,COX...
	               xPtI          	:= xPtR;
   	            vr    			:= INT_TO_REAL(xPtI^);                        //
         	   3: // UINT priamo v luxoch                (C-RI-0401S)
	               xPtUi          := xPtR;
	   	         vr    			:= UINT_TO_REAL(xPtUi^);                        //
         	   4: // USINT 0..255 - uroven osvetlenia    (SOPHY, C-RC-0005R...
            	   xPtU           := xPtR;
	               vr    			:= USINT_TO_REAL(xPtU^);                        //   LUX,COX
   	       ELSE // REAL -45 ... +300
        	      	vr 					:= xPtR^;
     	   END_CASE;
			IF xLux^.me.man = false THEN
	         xLux^.al.in.val := vr;
			END_IF;			
			CASE aSys.RefCyc OF
          	2 : 	// 2.vykonny cyklus - nastavia sa TER,LUX.... aj su ukoncene TypDay pre ZON, Dark od roliet ....
						xDev^.al.vaz := false;			 													// reset priradenia - nastavi sa v ROM/ZON
						xDev^.al.lst := false;			 													// reset priradenia - nastavi sa v ROM/ZON
//				3 :	// 3.cyklus po nastaveni typovoveho dna v domceku aj nadradenej zone {zona sa robi pred ROM}
			END_CASE;
			ok := false;			
			IF _NhxRom(nr := xDev^.cf.rom ,x:=13) THEN
				// ked sa vypne svetlo, nastartuje sa cakanie na velky reset
				IF cf = 19 AND xRom^.me.Light.Qf THEN							// len pre LUX a po vypnuti svetla v miestnosti
					xLux^.me.nRomQf := xLux^.me.nRomQf + 1;
					xLux^.me.f1R.rstBig	:= true;
				END_IF;
			END_IF;

			xLux^.me.f1R (	In 	:= 	xDev^.al.in.val,	
								fil	:=    USINT_TO_REAL( xLux^.cx.fil ),	// * 800.0,
								hys	:=		xLux^.cx.hys,
								sample:=    xLux^.cx.sample,
								rst	:= 	xDev^.al.in.cmd = 7 , //OR aSys.rst.Qr,
								Out 	=> 	xLux^.me.f1R.Out	);

			IF xLux^.me.f1R.Qr OR aSys.RefCyc=2 THEN

IF xLux^.me.f1R.Qr THEN
	xLux^.me.nf1RQr := xLux^.me.nf1RQr + 1;
ELSE
	xLux^.me.nRefCyc := xLux^.me.nRefCyc + 1;
END_IF;


   		      IF xLux^.cx.dark <=  xLux^.cx.sun THEN ;                   		//  dark < sun
      		      vr                := xLux^.cx.Sun 		- xLux^.cx.Dark;     // dark sa presunie na 0... SUN je vacsi  [0....SUN]
         		   kr                := xLux^.me.f1R.Out  - xLux^.cx.Dark;     // upravena filtrovana hodnota
            	 	xLux^.al.ou.val   := kr / Max(vr * 0.01,0.1);      			// % osvetlenia        // spodna hodnota
           		ELSE                                                           // negativny termistor
   		         vr                := (xLux^.cx.Dark 	- xLux^.cx.Sun);     // Sun sa presunie n 0, Sun je mensi      [-SUN.....0]
      		      kr                := (xLux^.me.f1R.Out - xLux^.cx.Sun);
         		   xLux^.al.ou.val   := 100.0 - kr / Max(vr * 0.01,0.1);  		// obratene vyhodnotenie
         	   END_IF;
  	         	xLux^.al.ou.val      := Round(xLux^.al.ou.val);                // % osvetlenia
      	      xLux^.al.ou.val      := LIMIT(0.0,xLux^.al.ou.val,100.0);      // % osvetlenia
					IF xDev^.cf.blk = false THEN      										// nie je BLK posiela sa
						CASE cf OF
                    51: i := 103;	// RH
						  41: i := 102;	// CO2
                  ELSE 	i := 101;	// LUX
                  END_CASE;
						xDev^.al.OU.cmd   := i;
						IF xLux^.cx.BlkDefRom = false THEN									// aj do default ROM								
//							IF _NhxRom(nr := xDev^.cf.rom ,x:=13) THEN
								IF xLux^.cx.BlkLuxRom AND xRom^.me.Light.Q THEN
	   							_Nh_CHG_VAL(io := ADR( xRom^.io[i] ), val := xRom^.io[i].val, zon:=false);		// posle existujucu hodnotu, ale zapise, ze ma snimac
								ELSE
	   							_Nh_CHG_VAL(io := ADR( xRom^.io[i] ), val := xDev^.al.ou.val, zon:=false);
					  				_NhDevRef(xR  := xRom);
								END_IF;
//							END_IF;
						END_IF;
   				END_IF;
					xLux^.me.lux		:= xLux^.al.ou.val * xLux^.cx.koef ;
	  				_NhDevRef(xR  := xDev);
			END_IF;
		  	xDev^.al.in.cmd := 0;
		END_IF;
   END_FOR;
END_FUNCTION

FUNCTION _Nh_PIR {HIDDEN} :BOOL
   _NH_PIR := _NH_DEV_INI(c:=15);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _NH_DEV_REC() THEN
         xPir              := xDev;                                     // toto len pre filter, ktory pozna len xDev
         IF xDev^.cf.blk = false AND xPir^.hw.d[0] > 0 THEN
            CASE xPir^.cf.typ OF
              1 : // NH analog - signal +70.0, tamper -10.0
                  xPtR  := UDINT_TO_PTR(xPir^.hw.d[0]);
(*
                  ok    := xPtR^ > 70.0; // OR xPtR^ = -40.0;
                  xDev^.al.Off   := xPtR^ > -40.0;                               // zobrazenie bezca pri BLK - ze je elektricky zapojene
                  xDev^.cf.inv   := false;
*)
                  ok    := xPtR^ < -5.0; // OR xPtR^ = -40.0;

              2 : // NH digital - signal pri zopnuti
                  xPtB  := UDINT_TO_PTR(xPir^.hw.d[0]);
                  IF xPir^.cf.inv THEN
                     ok  :=  xPtB^ = false;                                      // signal pri rozopnuti
                  ELSE
                     ok  :=  xPtB^;                                              // signal pri rozopnuti
                  END_IF;

            ELSE  // digital - zopina podla nastavenia
                  xPtB  := UDINT_TO_PTR(xPir^.hw.d[0]);
                  IF xPir^.cf.inv THEN
                     ok  :=  xPtB^ = false;                                      // signal pri rozopnuti
                  ELSE
                     ok  :=  xPtB^;                                              // signal pri rozopnuti
                  END_IF;
            END_CASE;

            IF _Nh_Dev_Qx(In := ok OR xDev^.al.in.cmd = 21 ) THEN       // zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0
					_Nh_Log_Evn_ADD( tsk := 15, wht := 'ON ');
               IF xDev^.al.et  > 0 THEN
                  xPir^.al.ou.cmd   := 21;
               ELSIF xPir^.cx.fUnLock = 0 OR xDev^.al.in.cmd = 21 THEN
                  xDev^.al.et       := 1;
                  xDev^.al.Qf       := true;
               ELSE
                  xDev^.al.et       := 100;
                  xDev^.al.ct       := xPir^.cx.funLock*2;
               END_IF;
				ELSIF xDev^.al.trg.Qf THEN
//					_Nh_Log_Evn_ADD( tsk := 15, wht := 'OFF');				
            END_IF;
            xDev^.al.in.cmd := 0;
            CASE xDev^.al.et OF
              0 : ;
              1 : IF xDev^.al.Qf OR SYSTEM_S.F_EDGE_1SEC THEN
                     xDev^.al.Qf := false;
                     IF xPir^.al.trg.Q THEN
                        xDev^.al.ou.val   := 100.0;
                        xDev^.al.sta      := 1;
                        xPir^.al.ou.cmd   := 21;
                        xDev^.al.et       := 5;                            // x-SEC po poslednom pohybe bude este zobrazeny pohyb
                     ELSE
                        xDev^.al.et       := 0;
                        xDev^.al.ou.val   := 0.0;
                        xDev^.al.sta      := 0;
                     END_IF;
                     _NhDevRef(xR := xDev);                                 // prvykrat okamzite
                  END_IF;
            100 : // nastartovany filter na pocet cyklov
                  IF xPir^.al.trg.Q THEN
                     IF xDev^.al.ct > xPir^.cx.fUnlock THEN                   // prvykrat nastavi CMD a neskor kazdy 255 cyklus, lebo xPir^.al.ex je USINT co sama resetuje
                        xDev^.al.ct := xDev^.al.ct - 1;
                     ELSE
                        xDev^.al.et       := 1;
                        xDev^.al.Qf       := true;
                     END_IF;
                  ELSE
                     xDev^.al.et       := 0;
                     xDev^.al.ct       := 0;
                  END_IF;
            ELSE
                  xDev^.al.et := xDev^.al.et - aSys.u1Sec;
            END_CASE;
            _Nh_Sta_Rom(sta := REAL_TO_USINT(xDev^.al.ou.val)); //, body :=  );    // stav do miestnosti
         ELSE
            xDev^.al.ou.val := 0.0;
            xDev^.al.sta    := 0;
         END_IF;
      END_IF;
   END_FOR;
END_FUNCTION



(*
                           80,  0,                           //  Ziadna akcia
                          181,  2,                           //  Start/Stop
                          178, 14,                           //  nastavit poziciu
                          180, 25,                           //  Natáèalamely
                          188, 26,                           //  Lamely-potvorit
                          189, 27,                           //  Lamely-Pozatvorit
                          179, 10,                           //  zatiahnut uplne dolu 0%
                          238, 11,                           //  vytiahnut uplne hore 100%
*)

FUNCTION _Nh_DOR  {HIDDEN} :BOOL
   VAR_INPUT
      c    : USINT;
   END_VAR
   cf       := c;
   _Nh_DOR  := _Dev_INI(c := cf);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
         xDor  := xDev;
         ok		:= true;
			IF xDev^.cf.DevExt THEN
				;
			ELSIF xDor^.hw.d[0] > 0 THEN
	         xPtB	:= UDINT_TO_PTR(xDor^.hw.d[0]);
			ELSE 	ok	:= false;
			END_IF;
			IF ok THEN 			
				IF xDev^.cf.inv THEN
					ok	:= xPtB^;
				ELSE
					ok	:= NOT xPtB^;
				END_IF;
	         IF _Nh_Dev_Qx(In := ok OR xDev^.al.in.CMD = 1 ) THEN //  );                                  // zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0
					xDev^.al.cm := 2;
					xDev^.al.et := 0;
					_NhxRom(nr:=xDev^.cf.rom);
					IF xDev^.al.in.CMD = 1 THEN
               	;
					ELSIF xRom^.me.Locked THEN
						IF xDor^.cf.psn THEN
							xDev^.al.et := USINT_TO_UINT(xDor^.cx.fLock) * 100;				
						END_IF;				
					ELSE
						xDev^.al.et := USINT_TO_UINT(xDor^.cx.fUnLock) * 100;		// mSec
					END_IF;
				ELSIF xDev^.al.trg.Qf THEN
					xDev^.al.ou.cmd 	:= 10;  												// off signal
					xDev^.al.cm			:= 0;								
					xDev^.al.et 		:= 0;
					_Nh_Sta_Rom(sta := 0);
					_NhDevRef(xR  := xDev);
				END_IF;

				CASE xDev^.al.cm OF
      	      0: // vypnute
						xDev^.al.sta 		:= 0;
						xDev^.al.ou.val   := 0.0;
         	   2: // oneskorenie
						_Nh_Dev_ET(t:=0);														// [mSec]
         	   	IF xDev^.al.et = 0 THEN
							xDev^.al.et 		:= xDor^.cx.tOffRst;		
							xDev^.al.cm			:= 100;
         	   	END_IF;
	          100: // zopnute
						_Nh_Dev_ET(t:=1);    												// [sec]
						IF xDev^.al.sta = 0 THEN
	          			xDev^.al.ou.cmd 	:=  14;                          	// on signal
							_Nh_Sta_Rom(sta := 1);
							_NhDevRef(xR  := xDev);
						ELSE
							xDev^.al.sta 		:= 1;
						END_IF;
						xDev^.al.ou.val 	:= 100.0;
      	   ELSE
         	;
	         END_CASE;
   		END_IF;
			IF xDev^.al.ou.cmd > 0 THEN

			END_IF;
			xDev^.al.in.CMD := 0;
      ELSE
         xDev^.al.ou.val   := 0.0;                                      // pir je zablokovany
			xDev^.al.sta 		:= 0;
      END_IF;
	END_FOR;
END_FUNCTION


(*
FUNCTION _Nh_ZON    : BOOL  // ukladanie hodnot do ROM a nasledne do ZON
   _Nh_ZON 				:= _NH_DEV_INI(c:=3);
   xRoW  				:= xHoW;
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC() THEN
			xRom								:= xDev;												// aktualna zona
			IF _Nh_Dev_Qx(In := xDev^.al.in.CMD > 0) = false THEN						// LOCK/unLOCK	
				IF xRom^.cx.lck.stat	<> xRoW^.LckStat THEN								// zmena stavu alarmu
					IF xRoW^.LckStat = 0 AND xRom^.cx.lck.stat > 1 THEN
						xRom^.al.ou.cmd := 60;           									// prave sa odkodovalo
					ELSIF xRoW^.LckStat = 2 THEN                                   // prave sa zakodovalo
						IF xRom^.cx.lck.stat = 4 THEN
							xRom^.al.ou.cmd := 67;           								// psik zaliezol do budy
						ELSIF xRom^.cx.lck.stat > 4 THEN
							xRom^.al.ou.cmd := 68;           								// obnovenie strazenia zo ALARMU, alebo psik steka
						ELSE
							xRom^.al.ou.cmd := 62;           								// zamknute po odchode
						END_IF;
					ELSE
						xRom^.al.ou.cmd := 60 + xRoW^.LckStat;					
					END_IF;
				ELSIF xHoW^.psn AND  xRom^.cx.lck.stat > 3 THEN
					xRom^.al.ou.cmd := 69;													// impulz pri pohybe		
				END_IF;
		
			END_IF;
			xRom^.cx.lck.ChangeStat	:= xRom^.al.ou.cmd > 0;				
			IF nd = 1 THEN
				IF xDev^.al.trg.Qr THEN														// domcek sa ma zamknut/odomknut
					IF xRom^.cx.lck.LockRom AND xRom^.cx.lck.stat = 0 THEN      // ak sa zamyka a je odomknute
						xDev^.al.ou.CMD := 56;     										// LOCK
					ELSE
						xDev^.al.ou.CMD := 57;     										// pre istotou unLOCK											
					END_IF ;
				END_IF;
         ELSIF _NhxZon(nz := xRom^.cf.rom) THEN                        		// xZon = vyssia domovska zona vyssia zona / Home
				IF xHom^.al.ou.CMD > 0 THEN                                    // v tomto cykle prisiel pokyn z domceka/HOMEzony
					xZon	:= xHom;
					IF xRom^.cx.lck.LockRom THEN											// zona sa centralne zamyka
						xRom^.al.ou.CMD := xZon^.al.ou.CMD;                		// preberie prikaz z HOME
						IF xDev^.al.ou.CMD = 56 THEN						  		   		// len ked Home dava centralne LOCK
							IF xHom^.cx.lck.FromZone THEN								// HOME prepisuje ZON
								xRom^.cx.lck.tdOu	:= xZon^.cx.lck.tdOu;
								xRom^.cx.lck.tdIn	:= xZon^.cx.lck.tdIn;
								xRom^.cx.lck.tDog	:= xZon^.cx.lck.tDog;
								xRom^.cx.lck.tNar	:= xZon^.cx.lck.tNar;
								xRom^.cx.lck.tRst	:= xZon^.cx.lck.tRst;
							END_IF;
						END_IF;
					ELSE
						xDev^.al.ou.CMD := 57;                              		// zona sa centralne nezamyka, pre istotu sa da UNLOCK
					END_IF;

				ELSIF xDev^.al.trg.Qr THEN
					IF xRom^.cx.lck.LockRom AND xRom^.cx.lck.stat = 0 THEN      // ak sa zamyka a je odomknute
						xDev^.al.ou.CMD := 56;     										// LOCK
					ELSE
						xDev^.al.ou.CMD := 57;     										
					END_IF ;
				END_IF;
			END_IF;
			xRom^.al.in.CMD 				:= 0;
			xRom^.cx.lck.stat				:= xRoW^.LckStat;				
			xRom^.cx.lck.et				:= xRoW^.LckEt;				
			xRom^.al.sta					:= xRoW^.LckStat;				

			xRom^.cx.lck.AllLocked		:= true;              								// nastavi priznak, ze vsetky ROM su locked, neskor sa upravi
			xRom^.me.BodyQr    			:= xRom^.me.BodyQ = false AND xRoW^.body;    // impulz pri zaznamenani pritomnosti
			xRom^.me.BodyQ     			:= xRoW^.body;                         		// pritomnost
			xRom^.me.PsnQr    			:= xRom^.me.PsnQ = false AND xRoW^.psn;      // impulz pri zaznamenani pritomnosti z cidiel PSN
			xRom^.me.PsnQ     			:= xRoW^.psn;// AND xRoW^.LckStat > 1;          // pohyb v zamknutej zone
			
			CASE aSys.RefCyc OF
				0 :	;
          	2 : 	_Nh_Typ_Day_Fix(xDay:=ADR(xRom^.cx.pDay), go:=xRom^.cf.typ < 2, home:=1);		// 1.vykonny cyklus - len pre domcek alebo byt
				3 :	_Nh_Typ_Day_Fix(xDay:=ADR(xRom^.cx.pDay), go:=xRom^.cf.typ > 1);             // 2.vykonny cyklus - pre ostatne zony
         END_CASE;

//			xRom^.al.lst					:= false;        			            	// resetne priznak zeleneho SETUP zony = ma nejake ROM
		
			_Nh_IO_VAL(i1:=100, i2:=103, io := ADR(xRom^.io[100]));

          xRom^.al.ou.val := xRom^.io[100].val;
		
		END_IF;
      xRoW     := xRoW + SIZEOF(NH_WRK_ROM);
   END_FOR;

//	xHom^.me.OldStat	:= xHom^.cx.lck.Stat;

//	xHom^.al.ou.CMD := 0;

END_FUNCTION
*)
(*
FUNCTION _Nh_ZON    : BOOL  // ukladanie hodnot do ROM a nasledne do ZON
   _Nh_ZON 				:= _NH_DEV_INI(c:=3);
   xRoW  				:= xHoW;
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC() THEN
			xRom								:= xDev;												// aktualna zona
			IF _Nh_Dev_Qx(In := xDev^.al.in.CMD > 0) = false THEN						// LOCK/unLOCK	
				IF xRom^.cx.lck.stat	<> xRoW^.LckStat THEN								// zmena stavu alarmu
					IF xRoW^.LckStat = 0 AND xRom^.cx.lck.stat > 1 THEN
						xRom^.al.ou.cmd := 60;           									// prave sa odkodovalo
					ELSIF xRoW^.LckStat = 2 THEN                                   // prave sa zakodovalo
						IF xRom^.cx.lck.stat = 4 THEN
							xRom^.al.ou.cmd := 67;           								// psik zaliezol do budy
						ELSIF xRom^.cx.lck.stat > 4 THEN
							xRom^.al.ou.cmd := 68;           								// obnovenie strazenia zo ALARMU, alebo psik steka
						ELSE
							xRom^.al.ou.cmd := 62;           								// zamknute po odchode
						END_IF;
					ELSE
						xRom^.al.ou.cmd := 60 + xRoW^.LckStat;					
					END_IF;
				ELSIF xHoW^.psn AND  xRom^.cx.lck.stat > 3 THEN
					xRom^.al.ou.cmd := 69;													// impulz pri pohybe		
				END_IF;
		
			END_IF;
			xRom^.cx.lck.ChangeStat	:= xRom^.al.ou.cmd > 0;				
			IF nd = 1 THEN
				IF xDev^.al.trg.Qr THEN														// domcek sa ma zamknut/odomknut
					IF xRom^.cx.lck.LockRom AND xRom^.cx.lck.stat = 0 THEN      // ak sa zamyka a je odomknute
						xDev^.al.ou.CMD := 56;     										// LOCK
					ELSE
						xDev^.al.ou.CMD := 57;     										// pre istotou unLOCK											
					END_IF ;
				END_IF;
         ELSIF _NhxZon(nz := xRom^.cf.rom) THEN                        		// xZon = vyssia domovska zona vyssia zona / Home
				IF xHom^.al.ou.CMD > 0 THEN                                    // v tomto cykle prisiel pokyn z domceka/HOMEzony
					xZon	:= xHom;
					IF xRom^.cx.lck.LockRom THEN											// zona sa centralne zamyka
						xRom^.al.ou.CMD := xZon^.al.ou.CMD;                		// preberie prikaz z HOME
						IF xDev^.al.ou.CMD = 56 THEN						  		   		// len ked Home dava centralne LOCK
							IF xHom^.cx.lck.FromZone THEN								// HOME prepisuje ZON
								xRom^.cx.lck.tdOu	:= xZon^.cx.lck.tdOu;
								xRom^.cx.lck.tdIn	:= xZon^.cx.lck.tdIn;
								xRom^.cx.lck.tDog	:= xZon^.cx.lck.tDog;
								xRom^.cx.lck.tNar	:= xZon^.cx.lck.tNar;
								xRom^.cx.lck.tRst	:= xZon^.cx.lck.tRst;
							END_IF;
						END_IF;
					ELSE
						xDev^.al.ou.CMD := 57;                              		// zona sa centralne nezamyka, pre istotu sa da UNLOCK
					END_IF;

				ELSIF xDev^.al.trg.Qr THEN
					IF xRom^.cx.lck.LockRom AND xRom^.cx.lck.stat = 0 THEN      // ak sa zamyka a je odomknute
						xDev^.al.ou.CMD := 56;     										// LOCK
					ELSE
						xDev^.al.ou.CMD := 57;     										
					END_IF ;
				END_IF;
			END_IF;
			xRom^.al.in.CMD 				:= 0;
			xRom^.cx.lck.stat				:= xRoW^.LckStat;				
			xRom^.cx.lck.et				:= xRoW^.LckEt;				
			xRom^.al.sta					:= xRoW^.LckStat;				


			xRom^.cx.lck.AllLocked		:= true;              								// nastavi priznak, ze vsetky ROM su locked, neskor sa upravi
			xRom^.me.BodyQr    			:= xRom^.me.BodyQ = false AND xRoW^.body;    // impulz pri zaznamenani pritomnosti
			xRom^.me.BodyQ     			:= xRoW^.body;                         		// pritomnost
			xRom^.me.PsnQr    			:= xRom^.me.PsnQ = false AND xRoW^.psn;      // impulz pri zaznamenani pritomnosti z cidiel PSN
			xRom^.me.PsnQ     			:= xRoW^.psn;// AND xRoW^.LckStat > 1;          // pohyb v zamknutej zone
			

			CASE aSys.RefCyc OF
				0 :	;
          	2 : 	_Nh_Typ_Day_Fix(xDay:=ADR(xRom^.cx.pDay), go:=xRom^.cf.typ < 2, home:=1);		// 1.vykonny cyklus - len pre domcek alebo byt
				3 :	_Nh_Typ_Day_Fix(xDay:=ADR(xRom^.cx.pDay), go:=xRom^.cf.typ > 1);             // 2.vykonny cyklus - pre ostatne zony
         END_CASE;

//			xRom^.al.lst					:= false;        			            	// resetne priznak zeleneho SETUP zony = ma nejake ROM
		
			_Nh_IO_VAL(i1:=100, i2:=103, io := ADR(xRom^.io[100]));

          xRom^.al.ou.val := xRom^.io[100].val;

		
		END_IF;
      xRoW     := xRoW + SIZEOF(NH_WRK_ROM);
   END_FOR;

//	xHom^.me.OldStat	:= xHom^.cx.lck.Stat;

//	xHom^.al.ou.CMD := 0;

END_FUNCTION
*)


FUNCTION _Nh_ZON   {HIDDEN}   : BOOL  // ukladanie hodnot do ROM a nasledne do ZON
	cf		:= 3;
	xRom	:= xHom;
	xRoW	:= xHoW;
	// najskor sa musia prejst HOME a BYT, lebo BYT	moze byt az za zonou do ktorej patri
   FOR nd := 1 TO aCfg[cf].Rec DO
		IF xRom^.ok.ok AND xRom^.cf.blk = false THEN
			xRom^.me.BodyQr    			:= xRom^.me.BodyQ = false AND xRoW^.body;    // impulz pri zaznamenani pritomnosti
			xRom^.me.BodyQ     			:= xRoW^.body;                         		// pritomnost
			xRom^.me.PsnQr    			:= xRom^.me.PsnQ = false AND xRoW^.psn;      // impulz pri zaznamenani pritomnosti z cidiel PSN
			xRom^.me.PsnQ     			:= xRoW^.psn;// AND xRoW^.LckStat > 1;          // pohyb v zamknutej zone

			IF _Nh_ROM_CMD_IN() THEN
				;
			ELSIF xHom^.al.trg.Qr THEN
				xRom^.al.ou.CMD := xHom^.al.ou.CMD;                   // CMD do zona prebrate z HOM/BYT, kde sa zamyka, aebo bol dotyk
				_Nh_ROM_LOCK_START();
        	ELSIF xRom^.cx.lck.StatOld <> xRom^.cx.lck.Stat THEN	
					CASE xRom^.cx.lck.Stat OF
                 	0: // Unlocked
							IF xRom^.cx.lck.StatOld > 1 AND xRom^.cx.lck.AllLockedOld THEN   // len ked sa odomkli vsetky miestnosti naraz
   							xRom^.al.ou.cmd := 60;
                     END_IF;
						1: // odchod - Locking
							xRom^.al.ou.cmd := 61;
                 	2: // Locked
							IF xRom^.cx.lck.StatOld < 2 THEN
	                     xRom^.al.ou.cmd := 62;
							END_IF;
					   3: // prichodove oneskorenie
							xRom^.al.ou.cmd := 63;
					   4: // Dog - ostrazitost
							xRom^.al.ou.cmd := 64;
					   5: // NARUSENIE = tichy poplach
							xRom^.al.ou.cmd := 65;
					   6: // ALARM
							xRom^.al.ou.cmd := 66;
               ELSE
               END_CASE;
				  xRom^.cx.lck.StatOld	:= xRom^.cx.lck.Stat;

         // ak sa miestnosti/zony uzamykanu s inym casom, signal zamknutia sa vysle az ked je zamknuta posledna miestnost
        	ELSIF xRom^.cx.lck.Stat = 2  AND xRom^.cx.lck.AllLocked AND xRom^.cx.lck.AllLockedOld = false THEN	
             xRom^.al.ou.cmd := 62;


(*
				CASE xZon^.al.ou.cmd OF
              60: // odomknutie
              61: // zacina zamykanie / zakodovanie;
              62: // zamknute po odchode
              63: // niekto prisiel
              64: // psik z budy von
              65: // psik steka
              66: // ALARM
              67: // Psik zaliezol do budy
              68: // Strazenie obnovene
              69: // pohyb
				ELSE  ok := false;
            END_CASE;
*)

			END_IF;								// bol dotyk nad ZON, moze byt len nad jednou

			xRom^.cx.lck.ChangeStat	   := xRom^.al.ou.cmd > 0;				
			xRom^.cx.lck.et 				:= 0;
			xRom^.cx.lck.stat 			:= 0;
			xRom^.cx.lck.AllLockedOld  := xRom^.cx.lck.AllLocked;                   // koli akcie pri LOCK/unLock nie vsetkych miestnosti
			xRom^.cx.lck.AllLocked 		:= true;

			IF xHoW^.chg THEN
				_Nh_ROM_IO_VAL(i1:=100, i2:=103, io := ADR(xRom^.io[100]));
	          xRom^.al.ou.val := xRom^.io[100].val;
				IF nd = 2 THEN																		// vonkajsi sumrak
					aSys.LuxOut := REAL_TO_USINT(xRom^.io[101].val);
				END_IF;
   		END_IF;
			CASE aSys.RefCyc OF
				0 :	;
          	1 : 	_Nh_Typ_Day_Fix(xDay:=ADR(xRom^.cx.pDay), xFix:=ADR(xRom^.cx.FixDay), go:=xRom^.cf.typ < 2, home:=1);		// 1.vykonny cyklus - len pre domcek alebo byt
						xRom^.cx.IniDefault := 1;
				2 :	_Nh_Typ_Day_Fix(xDay:=ADR(xRom^.cx.pDay), xFix:=ADR(xRom^.cx.FixDay), go:=xRom^.cf.typ > 1);             // 2.vykonny cyklus - pre ostatne zony
						_Nh_ROM_Dark();
						// hned za ZON ide ROM, moze sa nastavovat uz v tomto cykle
         END_CASE;
		END_IF;
		xRoM := xRoM + SIZEOF(NH_ROM);
		xRoW := xRoW + SIZEOF(NH_WRK_ROM);
	END_FOR;
END_FUNCTION

FUNCTION _Nh_ROM  {HIDDEN}  :BOOL  // ukladanie hodnot do ROM a nasledne do ZON
	cf			:= 1;
   _NhxRom(nr:=1);																				// xRom
   xRoW  	:= xRoW1;                                                         // xRow
	FOR nd := 1 TO aCfg[cf].Rec DO
		IF xRom^.ok.ok AND xRom^.cf.blk = false THEN
	      xLck 	:= ADR(xRom^.cx.lck);
			_NhxZon(c:=3, nz:=xRom^.cf.Rom, x:=133);											// vyssia zona {xZon, xZow}
(*
			IF xHoW^.chg THEN																		// zmena niektoreho TER/LUX v celom dome
				_Nh_ROM_IO_VAL(clr:=true,i1:=100, i2:=103, io := ADR(xRom^.io[100]));
	          xRom^.al.ou.val := xRom^.io[100].val;
   		END_IF;
*)
			// stav osvetlenia
			_Nh_Qx(in:=xRoW^.cat[1], trg:=ADR(xRom^.me.Light));

			// pritomnost ROM
			xRom^.me.BodyQr    			:= xRom^.me.BodyQ = false AND xRoW^.body;    // impulz pri zaznamenani pritomnosti
			xRom^.me.BodyQ     			:= xRoW^.body;                         		// pritomnost
			xRom^.me.PsnQr    			:= xRom^.me.PsnQ = false AND xRoW^.psn;      // impulz pri zaznamenani pritomnosti z cidiel PSN
			xRom^.me.PsnQ     			:= xRoW^.psn;// AND xRoW^.LckStat > 1;          // pohyb v zamknutej rom
			// rozdelit pritomnost do OUt/In
			IF xRom^.me.BodyQ THEN
				IF xRom^.cf.rom > 2 THEN
					xRoW^.bodyIn 	:= true;
					xZoW^.bodyIn	:= true;		
					xHoW^.bodyIn	:= true;		
				ELSE
					xRoW^.bodyOu 	:= true;				
					xZoW^.bodyOu 	:= true;				
					xHoW^.bodyOu 	:= true;				
				END_IF;
			END_IF;

			IF xZon^.al.trg.Qr THEN               							
				xRom^.al.ou.CMD := xZon^.al.ou.CMD;                   // CMD do zona prebrate z HOM/BYT, kde sa zamyka, aebo bol dotyk
				_Nh_ROM_LOCK_START();											// aktualizovat lck.stat
			ELSIF _Nh_ROM_CMD_IN() THEN
					;
			END_IF;

			_Nh_ROM_LOCK_RUN();

			CASE aSys.RefCyc OF
				0 :	;
			  	1 : 	// 1.vykonny cyklus {vacsinou po prechode na novu minutu, alebo rucne v programe}, vynuluju sa lokalne teploty,lux///
						xRom^.cx.IniDefault := 1;
						xRom^.me.DarkRolLvl := 0; 															// resetne sumrak ktory  vdalsom cykle pozbiera z roliet
//	   		       xRom^.al.ou.val := xRom^.io[100].val;
						_Nh_ROM_IO_VAL(clr:=true, i1:=100, i2:=103, io := ADR(xRom^.io[100]));
           	2 : 	// 2.vykonny cyklus - nastavia sa TER,LUX.... aj su ukoncene TypDay pre ZON,
						// nastavil sa aj  xRom^.cx.DarkRolLvl zo vsetkych roliet
						IF NOT(xM^.pod.po.edit.c = cf AND xM^.pod.po.edit.n = nd) THEN
							xRom^.cx.pDay.Day	:= xZon^.cx.pDay.Day;										// natvrdo preberie z vyssej zony
						END_IF;
				3 :	// 3.cyklus po nastaveni typovoveho dna v domceku aj nadradenej zone {zona sa robi pred ROM}
						_Nh_ROM_IO_VAL(i1:=100, i2:=103, io := ADR(xRom^.io[100]));
   		       	xRom^.al.ou.val := xRom^.io[100].val;                                  // teplota miestnosti
//						ELSE
//		   		       xRom^.al.ou.val := -0.0;                                  // teplota miestnosti
//						END_IF;
//            		xPod              := ADR(xRom^.cx.pDay);                          		// namapuje pre dalsie funkcie
		            xRom^.me.DayObr   := INT_TO_SINT(_Nh_Poi_Obr(wh := 0, nd := xRom^.cx.pDay.poi[ xRom^.cx.pDay.day ] )  );
						_Nh_ROM_Dark();
         END_CASE;


         // odpocitava blokovanie vsetkych PIR v miestnsti [min] po vypnuti WSB
			IF _Nh_Dev_ET_USINT(t := 2, et := ADR(xRom^.me.BlPirOff) ) THEN
            _NhDevRef(xR  := xRom);
         END_IF;
			// ak sa nesvieti, blokovanie PIR po zapnuti sa resetne
         IF xRoW^.cat[1] = false  AND xRom^.me.BlPirOn > 0 THEN     					
				xRom^.me.BlPirOn := xRom^.me.BlPirOn - 1;
			END_IF;	
			xRom^.me.Locked := xRom^.cx.lck.stat > 1 ;
			_NhDevRef(xR:=xRom, ref:= xRom^.me.BodyQ <> xRoW^.body OR aSys.RefCyc = 3);
		END_IF;
		xRoM := xRoM + SIZEOF(NH_ROM);
		xRoW := xRoW + SIZEOF(NH_WRK_ROM);
   END_FOR;
END_FUNCTION

(*
FUNCTION _Nh_ROM  :BOOL  // ukladanie hodnot do ROM a nasledne do ZON
   _Nh_ROM 	:= _NH_DEV_INI(c:=1);
   xRoW  	:= xRoW1;
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC() THEN
//		  	_Nh_Dev_Qx(In := xRoW^.body);												// Qr = zaciatok pohybu
			xRom					:= xDev;
	      xLck  				:= ADR(xRom^.cx.lck);
			xZon^.al.lst		:= true;

			xRom^.me.BodyQr    			:= xRom^.me.BodyQ = false AND xRoW^.body;    // impulz pri zaznamenani pritomnosti
			xRom^.me.BodyQ     			:= xRoW^.body;                         		// pritomnost
			xRom^.me.PsnQr    			:= xRom^.me.PsnQ = false AND xRoW^.psn;      // impulz pri zaznamenani pritomnosti z cidiel PSN
			xRom^.me.PsnQ     			:= xRoW^.psn;// AND xRoW^.LckStat > 1;          // pohyb v zamknutej rom

         IF _NhxZon(nz := xRom^.cf.rom) THEN                          			// xZon, xZoW
//				xZon^.al.lst := true;
			END_IF;
					
			IF xRom^.me.BodyQ THEN
				IF xRom^.cf.rom > 2 THEN
					xRoW^.bodyIn 	:= true;
					xZoW^.bodyIn	:= true;		
					xHoW^.bodyIn	:= true;		
				ELSE
					xRoW^.bodyOu 	:= true;				
					xZoW^.bodyOu 	:= true;				
					xHoW^.bodyOu 	:= true;				
				END_IF;
			END_IF;

			_Nh_IO_VAL(i1:=100, i2:=103, io := ADR(xRom^.io[100]));

	      xRom^.al.ou.val   		:= xRom^.io[100].val;           			// teplota sa prebera v kazdom cykle
			IF xRom^.io[100].chg THEN
		      xRom^.al.ou.CMD   := 100;           			// teplota sa prebera v kazdom cykle
				xRom^.io[100].chg	:= false;
			END_IF;

			_Nh_ROM_LOCK();

			CASE aSys.RefCyc OF
				0 :	;
				1 :   // nastartuje refresh
			  	2 : 	// 1.vykonny cyklus {vacsinou po prechode na novu minutu, alebo rucne v programe}, vynuluju sa lokalne teploty,lux///
          	3 : 	// 2.vykonny cyklus - nastavia sa TER,LUX....
				4 :	// 4.cyklus po nastaveni typovoveho dna v domceku aj nadradenej zone

            		xPod              := ADR(xRom^.cx.pDay);                          	// namapuje pre dalsie funkcie
						IF xM^.pod.po.edit	= false THEN
							xPod^.Day			:= xZon^.cx.pDay.Day;									// natvrdo preberie z vyssej zony
						END_IF;
		            xRom^.me.DayObr   := INT_TO_SINT(_Nh_Poi_Obr(wh := 0, nd := xPod^.poi[ xPod^.day] )  );
	
	
		            IF xRom^.cx.LuxMin = 0 THEN                               					// sumrak sa moze zadat rucne
      	            xRom^.cx.Dark := true;
         		   ELSIF xRom^.io[101].val < USINT_TO_REAL(xRom^.cx.LuxMin) THEN          // osvetlenei je < ako nastavene minimum = je sumrak
               	   xRom^.cx.Dark := true;
		            ELSIF xRom^.io[101].val >= USINT_TO_REAL(xRom^.cx.LuxMin) THEN         // je svetlo
      	            xRom^.cx.Dark := false;
   	      	   END_IF;
						xRom^.cx.Dark 		:= xRom^.cx.Dark OR xRom^.cx.DarkBli;						// akceptuje aj rolety			
						xRom^.me.ClearBli	:= false;															// resetne priznak pre nastavovanie Dark Rolety

				5 :
         END_CASE;




         IF aSys.Cyc_F_Min = 4 THEN													// 3. cyklus po ptrrchode na novu minutu
//				xRom^.cx.pDay.Day  := xZon^.cx.pDay.Day ;
				_Nh_TypDay(xDay:=ADR(xRom^.cx.pDay), xFix:=ADR(xRom^.cx.pDay.Fix), go:=true);

            j                 := xRom^.me.DayObr;                             // len si zapamata stary obrazok, koli zmene
            xPod              := ADR(xRom^.cx.pDay);                          // namapuje pre dalsie funkcie
				xRom^.cx.pDay.day := LIMIT(xRom^.cx.pDay.day,1,11);

            xRom^.me.DayObr   := INT_TO_SINT(_Nh_Poi_Obr(wh := 0, nd := xRom^.cx.pDay.poi[xRom^.cx.pDay.day] )  );
            _NhDevRef(xR:=xRom, ref:= j <> xRom^.me.DayObr);
            // zistenie sumraku
            ok2 := xRom^.cx.Dark;
            IF xRom^.cx.LuxMin = 0 THEN                               					// sumrak sa moze zadat rucne
                  xRom^.cx.Dark := true;
            ELSIF xRom^.io[101].val < USINT_TO_REAL(xRom^.cx.LuxMin) THEN          // osvetlenei je < ako nastavene minimum = je sumrak
                  xRom^.cx.Dark := true;
            ELSIF xRom^.io[101].val >= USINT_TO_REAL(xRom^.cx.LuxMin) THEN         // je svetlo
                  xRom^.cx.Dark := false;
            END_IF;
				xRom^.cx.Dark := xRom^.cx.Dark OR xRom^.cx.DarkBli;					// akceptuje aj rolety			
				xRom^.me.ClearBli	:= false;													// resetne priznak pre nastavovanie Dark Rolety
            _NhDevRef(xR  := xRom, ref := ok2 <> xRom^.cx.Dark);
         END_IF;
         // alarm
         // odpocitava blokovanie vsetkych PIR v miestnsti [min] po vypnuti WSB
			IF _Nh_Dev_ET_USINT(t := 2, et := ADR(xRom^.me.BlPirOff) ) THEN
            _NhDevRef(xR  := xRom);
         END_IF;
			// ak sa nesvieti, blokovanie PIR po zapnuti sa resetne
         IF xRoW^.cat[1] = false  AND xRom^.me.BlPirOn > 0 THEN     					
				xRom^.me.BlPirOn := xRom^.me.BlPirOn - 1;
			END_IF;	
      END_IF;
		xRom^.me.Locked := xRom^.cx.lck.stat > 1 ;
		_NhDevRef(xR:=xRom, ref:= xRom^.me.BodyQ <> xRoW^.body OR aSys.RefCyc = 5);
      xRoW  :=  xRoW + SIZEOF(NH_WRK_ROM);
   END_FOR;
END_FUNCTION
*)


FUNCTION _Nh_ACT    : BOOL
   _Nh_ACT := _Dev_INI(c := 5);
   WHILE _Dev_DEV() DO
      IF xDev^.ok.ok THEN
         xDev^.al.lst   	:= 0;
         xDev^.al.ou.cmd   := 0;

         IF _Nh_Dev_Qx(in := xDev^.al.in.cmd > 0) THEN
				xDev^.al.RMP 		:= xDev^.al.in.cmd;											// len pre ladenie co prislo
				IF xDev^.al.in.cmd = 1 THEN
					xDev^.al.in.cmd := 14;
				END_IF;

				xDev^.al.cm 		:= xDev^.al.in.cmd;											
				IF xDev^.cf.typ = 1 THEN															//ROLETY
		(*	
					CASE xDev^.al.cm OF
	  					10:	// vytiahnut hore
								xDev^.al.Up			:= false;
								xDev^.al.ou.val 	:= BOOL_TO_REAL(xDev^.al.Up); 						// na zaciatku nastavi vsetky rolety rovnakym smerom
								xDev^.al.cm			:= 23;
	  					11:	// zatiahnut dolu
								xDev^.al.Up			:= true;
								xDev^.al.ou.val 	:= BOOL_TO_REAL(xDev^.al.Up); 						// na zaciatku nastavi vsetky rolety rovnakym smerom
								xDev^.al.cm			:= 23;
	  					14:	// predvolena pozicia
								;
	  					23:	// z SCN - centralne START/STOP
								xDev^.al.Up		:= NOT xDev^.al.Up;
								xDev^.al.ou.val := BOOL_TO_REAL(xDev^.al.Up); 						// na zaciatku nastavi vsetky rolety rovnakym smerom
					  	24:	// z SCN -  centralne naklapat lameny
								xDev^.al.Up		:= NOT xDev^.al.Up;
								xDev^.al.ou.val := BOOL_TO_REAL(xDev^.al.Up); 						// na zaciatku nastavi vsetky rolety rovnakym smerom
					END_CASE;	
*)
				END_IF;

				xDev^.al.ou.cmd 	:= xDev^.al.cm;			//xDev^.al.in.cmd;                                      // vypina sa
            xDev^.al.sta 	 	:= 1;
            xDev^.al.et 	 	:= 10;														// 30  x 100ms = 3s											
				xDev^.al.wsb 		:= false;																// akcia nie je WSB, vykona sa okamzite

				
				IF xDev^.al.in.cmd = 1 THEN												// ked sa akcia spusti z WEB, tiez moze blokovat PIR
//					xDev^.al.wsb := true;
//					xDev^.al.wsb := false;													// web neblokuje
				ELSE
               ;		
				END_IF;
            _NhDevRef(xR  := xDev);
				If xDev^.cf.LogAct THEN
					_Nh_Log_Evn_ADD(tsk:=-1, evn:='ACT', wht:='BEG', val1:=USINT_TO_STRINGF(xDev^.al.IN.cmd,'%7u'), val2:=USINT_TO_STRINGF(xDev^.al.OU.cmd,'%7u'));
   			END_IF;
			ELSIF xDev^.al.trg.Q  THEN
				IF xDev^.al.cm = 24 OR xDev^.al.cm = 6 THEN							// stmievat,natacat rolety
					xDev^.al.ou.cmd := xDev^.al.cm;
				ELSE
					xDev^.al.wsb := false;
   			END_IF;
			ELSIF xDev^.al.trg.Qf  THEN
				xDev^.al.wsb 		:= false;
            xDev^.al.ou.val 	:= 0.0;                                       // pre istotu sa nuluje, aj ked by nemalo mat vplyv, lebo vDEV sa nastavi LVL z parametra

			ELSIF _Nh_Dev_ET(t := 3) AND xDev^.al.Qf  THEN
         	_NhDevRef(xR  := xDev);
            xDev^.al.sta 	 := 0;
         END_IF;
//         xDev^.al.in.val := xDev^.al.ou.val;
         xDev^.al.in.cmd := 0;
      END_IF;
   END_WHILE;
END_FUNCTION

FUNCTION _NH_HET   {HIDDEN}   : BOOL
   VAR_INPUT
      c  : USINT;
   END_VAR
   _NH_HET := _NH_DEV_INI(c:=c);

   FOR nd := 1 TO aCfg[cf].Rec DO
//   FOR nd := 1 TO MIN(1,aCfg[cf].Rec) DO
		IF _NH_Het_CMD() THEN
				// TVE
				xPtIO 	:= ADR(xHet^.io[1]);									         // TVE
				IF _Nh_IO_DEV(io := xPtIO, val := false) THEN	       			// mapuje TVE, ale neodcita teplotu, lebo ta nie je v xDev^.al.ou.Val, ale xTve^.io[1].val 		
					xTve := xPt;
					_Nh_CHG_VAL(io := xPtIO, val := xTve^.io[1].val, zon := xTve^.io[1].own);   // do zon sa zapise, ci ma TVE teplotu
					xTve^.al.in.par	:= MAX(xTve^.al.in.par, USINT_TO_INT(xHet^.me.Out));
					IF xTve^.cx.reg.ModeFromSrc THEN
						xTve^.cx.reg.Mode 		 := xHet^.cx.reg.Mode;
					END_IF;
				END_IF;
				// KOT
				xPtIO 	:= ADR(xHet^.io[2]);									         			// KOT
				IF _Nh_IO_DEV(io := xPtIO, val := false) THEN	
					xTve := xPt;
					_Nh_CHG_VAL(io := xPtIO, val := xTve^.io[1].val, zon := xTve^.io[1].own);
					xTve^.al.in.par	:= MAX(xTve^.al.in.par, USINT_TO_INT(xHet^.me.Out));   // do zon sa zapise, ci ma KOT teplotu
					IF xHet^.cx.reg.ModeFromSrc THEN
						xHet^.cx.reg.Mode			 := xTve^.cx.reg.Mode;
					END_IF;
				END_IF;
				// CER
				xPtIO 	:= ADR(xHet^.io[3]);									         			// CER
				IF _Nh_IO_DEV(io := xPtIO, val := false) THEN	
					xTve := xPt;
					_Nh_CHG_VAL(io := xPtIO, val := xTve^.io[1].val);
					xTve^.al.in.par	:= MAX(xTve^.al.in.par, USINT_TO_INT(xHet^.me.Out));
					IF xTve^.cx.reg.ModeFromSrc THEN
						xTve^.cx.reg.Mode 		 := xHet^.cx.reg.Mode;				
					END_IF;
				END_IF;

//			xHet^.cf.cat := 39;													// setup kurenia, do het zapisuju ventily	

			_Nh_Sta_Rom(sta := xHet^.al.sta) ;             				// stav do 			
		
			_NH_Het_LOG();
		
		ELSE
			xHet^.al.sta 			:= 0;		
		END_IF;
   END_FOR;
END_FUNCTION

FUNCTION _NH_TVE    {HIDDEN}   :BOOL
   VAR_INPUT
      c  : USINT;
   END_VAR
   _NH_TVE := _NH_DEV_INI(c:=c);
   FOR nd := 1 TO aCfg[cf].Rec DO
//   FOR nd := 1 TO MIN( 1,aCfg[cf].Rec ) DO
		IF _NH_TVE_CMD() THEN
(*
			IF xTve^.cx.PWM THEN                         								// riadenie PWM ma prednost
			END_IF;
*)			
			CASE xTve^.me.CMD OF
   			0:	// pokoj, alebo pohyb	
					IF xTve^.cf.typ = 1 AND cf = 8 THEN													/// TECO
						xTvTecoIn 			:= UDINT_TO_PTR(xTve^.hw.d[0]);	
						xTvTecoOu 			:= UDINT_TO_PTR(xTve^.hw.d[1]);	
						xTve^.me.stat		:= xTvTecoIn^;										// prenesie status TV do mem
						IF xDev^.al.IN.val <> xTvTecoOu^.POSITION THEN           	// niekto iny zmenil HW alebo ext.App
							xDev^.al.in.val	:= xTvTecoOu^.POSITION;						// preberie sa hodnota aby sa v dalsom cykle zapis

							xPvA^.p.pv 			:= _NH_TVE_VAL_TO_PV();               	// vypocita sa priblizne PV

							xPvA^.p.prg			:= false;                              //
						ELSIF xTvTecoIn^.POSITION <> xTvTecoOu^.POSITION THEN
							_NhDevRef(xR := xDev);						
						END_IF;
						xDev^.al.OU.val	:= xTvTecoIn^.POSITION;
					ELSIF xDev^.al.OU.val = xDev^.al.IN.val THEN
						;
					ELSIF xTve^.cx.guard.tRun > 0 THEN                                 	// ostatne TVE
						_NhInkrValTst(wh:=1, cj:=2, tRun:=xTve^.cx.guard.tRun, in:=ADR(xTve^.al.in.Val), ou:=ADR(xTve^.al.ou.Val) );
						_NhDevRef(xR := xDev);
					 ELSE
  						xTve^.al.ou.val 		:= xTve^.al.in.val;
						_NhDevRef(xR := xDev);
					END_IF;
				1: // nema HW adresu
					;

           10: // nastavenie
					xTve^.me.CMD := 0;														// default je ze sa pojde zatvarat
					IF xTve^.cf.typ = 1 AND cf = 8 THEN                         // len TVE TECO
						IF xTve^.hw.d[1]	> 0 THEN					
							xTvTecoOu 				:= UDINT_TO_PTR(xTve^.hw.d[1]);	
							xTvTecoOu^.POSITION	:= xDev^.al.IN.val;
						ELSE
							xTve^.me.CMD := 1;
						END_IF;
					ELSIF xTve^.io[0].dev.c = 43 THEN										// DALI TVE
						_NhxPt(c:=xTve^.io[0].dev.c, n:=xTve^.io[0].dev.n);		// xDLs
						xDls := xPt;
						IF xDev^.al.IN.val > 0.0 THEN
							ii 	:= 254;
						ELSE
							ii		:= 0;
						END_IF;
						i := xTve^.io[0].dev.o;													// 0..5  (0-R-G-B-W-A)
						IF  i > 0 THEN                                              // je zlozka
						   _NhxPar2 (cp := aCfg[ xTve^.io[0].dev.c ].par , np := xPt^.cf.par);	// default parameter xDLs
							xTve^.io[0].val 	:= USINT_TO_REAL(ii);
							IF xPar2^.rgb.lvl[i] <> ii OR xDLs^.me.SendDLM = false THEN// zlozka je ina ako sa pozaduje, alebo ete nebol poslany prikaz

								xDLs^.al.in.cmd	:= 143;	
								xDLs^.al.in.par := 0;
								xDLs^.al.in.val := UDINT_TO_REAL( PTR_TO_UDINT(ADR(xTve^.io[0])) );	// posle sa cela struktura
							END_IF;
						ELSE																			// 1 SHA
							xPt^.al.in.cmd		:= 11;						
							xPt^.al.in.val		:= MIN(254,xDev^.al.IN.val * 2.54);						
							xDLs^.al.in.par 	:= 0;
						END_IF;

					ELSIF xTve^.hw.d[0] > 0 THEN												// fyzicky poslat do HW							
		      	   xPtB	:= UDINT_TO_PTR(xTve^.hw.d[0]);
						ok 	:= REAL_TO_BOOL(xDev^.al.IN.val);							// predpripavi na BOOL
						CASE xTve^.hw.typ  OF        											// toto si oznaci sam export
                    0 :  // BOOL
								_Nh_Tve_Obr_OnOff(off	:= true,        					// najskor vypne ine rele. ktore by bolo zapnute	
												lvl 	:= xTve^.me.pvm.p.pv,                 // zapne konkretny stupen
												inv	:= xTve^.cf.Inv,                    // zohladni ci su rele inverne
												hw:=ADR(xTve^.hw), reg:=ADR(xTve^.cx.reg));
								// ak hw[1] {PV-1} musi zosta zapnute - pri rekuperacii
								IF xTve^.cx.guard.PV1_IsOn AND xTve^.me.pvm.p.pv > 1 THEN
		      	   			xPtB	:= UDINT_TO_PTR(xTve^.hw.d[0]);
	      	   				xPtB^	:= true;
								END_IF
	                 1 : // REAL
								xPtr	:= xPtB;
								xPtR^ := xDev^.al.IN.val;

                  ELSE	 // ostatne sa bude brat ze maju nespravnu adresu
								xTve^.me.CMD := 1;						
                  END_CASE;
					ELSE
						xTve^.me.CMD := 1;														// nema hw adresu					
					END_IF;			
       	END_CASE;
			IF xDev^.al.ou.val = 0.0 THEN
				xDev^.al.sta := 0;
			ELSE				
				_Nh_Sta_Rom(sta := xPvA^.p.pv);    // stav do miestnosti
			END_IF;

      END_IF;
   END_FOR;
END_FUNCTION























(* Ikony  xKy001Ou^.icons
   0  Lock
   1  Unlock
   2  Lock + vykricnik
   4


*)

(*
FUNCTION _Nh_KEY_BEEP  {HIDDEN} : BOOL
   VAR_INPUT
      set   : BOOL;
      end   : BOOL;
      nx    : USINT  := 2;
      et    : UINT   := 500;
   END_VAR
   IF end THEN
      xDev^.al.el    := 0;
      xDev^.al.et    := 1000;
      xDev^.al.CM    := 99;
      xDev^.al.Up    := 0;
      xDev^.al.rmp   := 0;
   ELSIF set THEN
      xDev^.al.el    := xKey^.cx.tMax;
      xDev^.al.et    := et;
      xDev^.al.ct    := 0;
      xDev^.al.Up    := 0;
      xDev^.al.rmp   := nx;
   ELSIF xDev^.al.rmp > 0 THEN
      xDev^.al.rmp   := xDev^.al.rmp - 1;
      xDev^.al.Up    := NOT xDev^.al.Up;
      xDev^.al.et    := et;
   ELSE
      xDev^.al.et    := 1000;
      IF xDev^.al.cm = 2 THEN
         xDev^.al.CM    := 202;
      ELSE
         xDev^.al.CM    := 200;
      END_IF;
      xDev^.al.Up    := 0;
   END_IF;

   IF xDev^.al.Up THEN
      CASE xDev^.cf.typ OF
         1: xKy001Ou^.SETT := USINT_TO_BYTE(3);          // zapne BEEP
      ELSE
            xWg503Ou^.DOs.DO2 := 0;                      // zapne cervenu
            xWg503Ou^.DOs.DO1 := 1;                      // Beep ON
      END_CASE;
   ELSIF xDev^.cf.typ = 1 THEN
      xKy001Ou^.SETT := USINT_TO_BYTE(1);          // vypne BEEP
   ELSE
      xWg503Ou^.DOs.DO2 := 1;                      // zapne zltu
      xWg503Ou^.DOs.DO1 := 0;                      // Beep OFF
   END_IF;
END_FUNCTION
*)


FUNCTION _Nh_KEY_PIN {HIDDEN}  : BOOL
	FOR  i := 1 TO INT_TO_USINT(aCfg[22].rec) DO
 		IF _NhxUsr(u := i) THEN
			ix := LEN(xKey^.me.KeyPas); 			
	      IF ix >=3 AND xUsr^.cx.keyPas = xKey^.me.KeyPas THEN
				xKey^.me.keyPas 	:= '';
				_Nh_KEY_PIN 		:= true;
				RETURN;
			END_IF;
		END_IF;
   END_FOR;
	_Nh_KEY_PIN := false;
END_FUNCTION


FUNCTION _Nh_KEY {HIDDEN}    : BOOL
   VAR_INPUT
      c  : USINT := 24;
   END_VAR
   _NH_KEY := _NH_DEV_INI(c:=c);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
			xDev^.al.Off		:= false;												// naslo sa helso
         xKey  				:= xDev;
         xRom 					:= xHom;
			xLck					:= ADR(xHom^.cx.lck);	
			xDev^.al.ou.CMD   := 0;
//			xKey^.me.Qf			:= false;												// pusteny btn
//			xKey^.me.Q			:= false;                                   	// drzime btn
			xKey^.me.ChgTx1	:= 0;
			xKey^.me.ChgTx2	:= 0;
			y						:= LEN(xKey^.me.keyPas);							// pocet zadanych znakov 		
         xDev^.al.sta 		:= xHom^.cx.lck.stat;
(*
				CASE xZon^.al.ou.cmd OF
              60: // odomknutie
              61: // zacina zamykanie / zakodovanie;
              62: // zamknute po odchode
              63: // niekto prisiel
              64: // psik z budy von
              65: // psik steka
              66: // ALARM
              67: // Psik zaliezol do budy
              68: // Strazenie obnovene
              69: // pohyb
				ELSE  ok := false;
            END_CASE;
*)
			i	:= 0;
			ii := 1;																				// rozvieteny display

			_Nh_Dev_ET();                                                  // odcitava al.et 500 ms filter pre dalsie odcitanie stlacenie

			IF _Nh_Dev_ET_USINT(t:=1, et:=ADR(xDev^.al.cm)) THEN           // odcitava cas zobrazenia hesla
				IF y > 0 OR xDev^.al.sta = 0 THEN
					xKey^.me.keyPas 	:= '';
					yTx1					:= '';
					xKey^.me.ChgTx2 	:= 1;
				END_IF;
			END_IF;
			IF xHom^.me.bodyQ  THEN                                     	// trva pohyb
//				yTx1 := '';
//				_Nh_ALARM_ROM();															// zoznam, kde je pohyb vlozi do yTx1
				xKey^.me.ChgTx2	:= 1;			
				IF y = 0 THEN
					xDev^.al.cm	:= 5;			                                 // heslo je prazdne, podhadzuje sa 5s
				END_IF;
			END_IF;
			IF xHom^.cx.lck.ChangeStat OR aSys.Restart THEN						// zmena stavu PSN, restart
				_NhxPt(c:=48, n := USINT_TO_INT(xHom^.cx.lck.stat+1), x:=344 );			
				yTx2					:= xPt^.cf.Name;				
				xKey^.me.ChgTx1	:= 1;			
				IF xHom^.al.ou.cmd = 60  THEN                     				// odomknutie
					xKey^.me.beep.wht := 102;
					xKey^.me.beep.nbr := 2;									
					xKey^.me.ChgTx2 	:= 1;
					yTx1					:= '';
				ELSIF xHom^.al.ou.cmd = 62 OR       // zamknutie
						xHom^.al.ou.cmd = 67 OR       // psik zaliezol do budy
						xHom^.al.ou.cmd = 68 THEN    	// obnovenie po alarme
					xKey^.me.beep.wht := 102;
					xKey^.me.beep.nbr := 3;									
					xKey^.me.ChgTx2 	:= 1;
					yTx1					:= '';
				ELSIF xHom^.al.ou.cmd = 69 THEN 										// pohyb v zamknutej zone
					xKey^.me.beep.wht := 102;
					xKey^.me.beep.nbr := 3;									
  				END_IF;
			ELSIF xDev^.al.sta = 0  THEN
				;
			ELSIF xDev^.al.sta = 1 OR (xDev^.al.sta=2 AND xHom^.cx.lck.et > 0) THEN // zamykam alebo je uz zamknute ale vonkajsie zony sa este zamykaju
				IF aSys.PULSE_BEEP THEN
					ii := 67;	// 1 + 2 + 64;											// podsvietenie aj pipanie
				ELSE
					ii := 65;																// len podsvietenie
				END_IF;
			ELSIF xDev^.al.sta = 3 THEN												// Narusenie
				IF SYSTEM_S.PERIOD_PULSE_1SEC THEN
					ii := 67;	// 1 + 2 + 64;									
				ELSE
					ii := 65;	//1 + 0 + 64;																				
				END_IF;
			END_IF;
			IF xKey^.me.beep.wht <> 0 THEN                 						// beeper ma prednost
				IF xKey^.me.beep.Q THEN
					ii := 67;	
				ELSE
					ii := 65;	
				END_IF;
			END_IF;

         CASE xDev^.cf.typ OF
           0: 	// klasicky WG503
               xWg503In := UDINT_TO_PTR(xKey^.hw.d[0]);
               xWg503Ou := UDINT_TO_PTR(xKey^.hw.d[1]);
					IF _Nh_Dev_Qx(In := xDev^.al.et=0 AND xWg503In^.CODE.stat = 1) THEN   // filtruje cas v et, potom pocuva na stlacenie
							xKey^.me.code	:=  xWg503In^.CODE;
							IF xWg503In^.CODE.val[0] = 0 THEN
								i := 0;
							ELSIF xWg503In^.CODE.val[0] <= 144 	THEN           			// 1..9
								i	:= xWg503In^.CODE.val[0] / 16;
							ELSIF xWg503In^.CODE.val[0] = 160	THEN							// ESC odpoveda: <- vymazat vsetko
								i	:= 23;					
							ELSIF xWg503In^.CODE.val[0] = 176	THEN							// ENT odpoveda: #
								i	:= 12;					
							END_IF;
					END_IF;

					// DO1 = beep
					// DO2 := 0 ... cervena
					// DO2 := 1 ... zlta
					xWg503Ou^.DOs.DO1 := 0;
					IF ii = 67 THEN
						xWg503Ou^.DOs.DO1 := 1;														// beep
						IF xDev^.al.sta > 0 THEN													// Narusenie					
							xWg503Ou^.DOs.DO2 := 0;
						END_IF;
					ELSIF ii = 65 THEN
						IF xDev^.al.sta = 1 THEN													// Narusenie					
							xWg503Ou^.DOs.DO2 := 1;
						END_IF;
					ELSIF xDev^.al.sta >= 2 THEN													// Narusenie					
						xWg503Ou^.DOs.DO2 := 0;
					ELSE
						xWg503Ou^.DOs.DO2 := 1;					
					END_IF;
					IF xKey^.me.keyPas <> '' THEN
						xWg503Ou^.DOs.DO1 := 0;										// ak sa zadava heslo, BEEPER nepracuje		
					END_IF; 					

           1: 	// Glass
               xKy001In := UDINT_TO_PTR(xKey^.hw.d[0]);
               xKy001Ou := UDINT_TO_PTR(xKey^.hw.d[1]);
					//				touch		press    vypocet
					// 1..9	: 	1..9		33-41		+32
					// 0     : 	10       42
					// *		:	11       43
					// #		:	12       44
					// <-		:	13       45
					// Up		:	14       46
					// Dn		:	15       47
					// enter	:	16 (sipka dole  vpravo dole pri #)	48

  					i 	:= BYTE_TO_USINT(xKy001In^.BUTTONS);
					_Nh_Dev_Qx(In := i > 0 );			    // tu sa len vyvola Qr, ale filtruje sa


					IF xKey^.me.ChgTx1 THEN                           		// zobrazi text aktualneho LVL
						xKy001Ou^.TEXT1	:= yTx2;
	               IF xDev^.al.sta > 1 THEN
   	  					xKy001Ou^.icons := USINT_TO_BYTE(0);          	// ikona vlavo hore
      	         ELSE
     						xKy001Ou^.icons := USINT_TO_BYTE(1);
            	   END_IF;
					END_IF;
         END_CASE;

			IF xDev^.al.trg.Qr THEN
				xDev^.al.ou.par 	:= 1; 		                           // 1=touch, 6=press
				xDev^.al.ou.Val 	:= USINT_TO_REAL(i); 						// cislo klavesy	
				xDev^.al.cm			:= 4;
				IF i < 13 THEN            											// cisla + #,*	
					IF y >= 6 THEN
						xKey^.me.keyPas := '';
					ELSE
						CASE i OF
                    10 : yTx2 := '0';   										// pri glass vydava pri 0 cislo 10
						  11 : yTx2 := '*';   										// pri WG503 = ESC
                    12 : yTx2 := '#';                                // pri WG503 = ENT
                  ELSE yTx2 := USINT_TO_STRING(i);
                  END_CASE;
						xKey^.me.keyPas := xKey^.me.keyPas + yTx2;
						IF _Nh_KEY_PIN() THEN
//							xHom^.al.in.CMD := 1;									// staci zadat cmd >0 Zone si zisti co robit
							xHom^.al.in.CMD := 55;	
		               IF xDev^.al.sta > 0 THEN
								xDev^.al.ou.CMD	:= 10;						
							ELSE
								xDev^.al.ou.CMD	:= 11;						
							END_IF
							xKey^.me.keyPas	:= '';
						END_IF;
					END_IF;
				ELSIF i = 13 AND y > 0 THEN
					xKey^.me.keyPas := LEFT(xKey^.me.keyPas,y-1);
				ELSIF i = 23  THEN
					xKey^.me.keyPas := '';
				END_IF;
				xKey^.me.ChgTx2 	:= 1;
				yTx1					:= xKey^.me.keyPas;
			ELSIF xDev^.al.trg.Qf THEN
            xDev^.al.et := 200;
         END_IF;
  			CASE xDev^.cf.typ OF
				0: ;
				1:	y := LEN(xKey^.me.keyPas);
					IF y > 0 AND ii > 65 THEN
						xKy001Ou^.sett := USINT_TO_BYTE(65);					
					ELSE
						xKy001Ou^.sett := USINT_TO_BYTE(ii);					
					END_IF;
					IF y > 0 THEN																
   					xKy001Ou^.TEXT2 := '';
						FOR x := 1 TO y DO
							xKy001Ou^.TEXT2	:= xKy001Ou^.TEXT2 + '*';           // v druhom riadku vypise zadany kod
        		   	END_FOR;	
               ELSIF xDev^.al.sta = 1 AND xHom^.cx.lck.et > 0 THEN         // ked sa zamyka
     					xKy001Ou^.TEXT2 := UINT_TO_STRING(xHom^.cx.lck.et);		// zamykam cas [s]
					ELSIF xKey^.me.ChgTx2 THEN
						xKy001Ou^.TEXT2	:= yTx1;
					END_IF;
					// zobrazit cas
					IF SYSTEM_S.R_EDGE_1MIN THEN
						xKy001Ou^.TIM := USINT_TO_INT(SYSTEM_S.COUNTER_HOURS) * 100 + USINT_TO_INT(SYSTEM_S.COUNTER_MINUTES);
   				END_IF;
			END_CASE;
        	xKey^.me.beep();
		END_IF;
	END_FOR;
END_FUNCTION




(*
FUNCTION _Nh_SCN    : BOOL
   _Nh_SCN := _Dev_INI(c := 4);
	FOR nd := 1 TO 1	DO //aCfg[cf].rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
	      xScn	:= xDev;
			cmd	:= 0;										// totyo buede nakoniec vlozene do xDev^.al.in.CMD
			IF _Dev_Qx_PAR(dpa:=xDev^.cf.par) THEN
xScn^.me.in := xDev^.al;

				rb 							:= _Nh_Dev_OFF_SCN(all:=false);
				xScn^.me.delayOff			:= 0;										// resetne delay vyhodnocovania stavu sceny pre OFF po skonceni prikazu
				xDev^.cx.all.LastCMD 	:= xDev^.al.in.CMD;					// zapamata posledny pokyn
				ok1							:= false;
				IF aCfg[cf].par > 0 THEN											// dev ma parameter, SIR napr nema parameter
 	   			vr    := USINT_TO_REAL(xPar^.all.Lvl);                // default sa podhodi LVL
				ELSE
					vr := 0.0;                                          	// bez parametra nebude potrebovat, lebo pride konkretne CMD
				END_IF;
				CASE xDev^.al.in.CMD OF
			      1: // prepnut z WEB
//		   	      xDev^.al.wsb      := true;									// nasilne sa podhodi ako z WSB, aby sa zablokoval pir
			      2: // prepnut z WSB												// wsb nastavi priznak WSB vo vazbach automaticky
						xDev^.al.wsb		:= true;
   			      xDev^.al.in.CMD   := 1;
		      	3: // resetovat casy nastavit OFF, ale neposielat nic
						_Nh_Dev_OFF_SCN(cmd:=3);
			     10: // OFF
						xDev^.al.Ou.CMD 	:= 10;
   			      xDev^.al.in.val   := 0.0;
						ok1					:= true;
			     11: // zapnutie na 100%
						xDev^.al.Ou.CMD 	:= 11;
						xDev^.al.in.val   := 100.0;                              // zapnut naplno
						ok1					:= true;
				  14: // zapnut na LVL, ulozenu v parametri, nastavit casy opozdeny start/po case vypnut/max.cas zapnutia
						xDev^.al.Ou.CMD 	:= 14;
		   	      xDev^.al.in.val   := vr;
						ok1					:= true;
			     21: // PIR - ON
			         _NhxRom(nr := xDev^.cf.rom, x:=-14);
			         IF xRom^.me.BlPirOn = 0 AND xRom^.me.BlPirOFF = 0 THEN  	// nie je blokovana ROM po vypnuti, ani po zapnuti
			            IF xDev^.al.ou.Val < 0.9 OR xPar^.all.rPir THEN       // je OFF alebo bezi cas-to-OFF a pohyb resetuje cas
			               xDev^.al.IN.val   := vr;
			               xDev^.al.ou.CMD   := 21;
			            END_IF;
			         ELSE
	      			   xDev^.al.in.CMD   := 0;
			         END_IF;
         			xDev^.al.wsb      := 0;
			     23: ;// Rolety Start/Stop
						xDev^.al.Ou.CMD 	:= 23;
			     24: ;// Rolety lamely naklapat
						xDev^.al.Ou.CMD 	:= 24;
			     26: ;// Rolety lamely otvorit
						xDev^.al.Ou.CMD 	:= 25;
			     27: ;// Rolety lamely zaklopit
						xDev^.al.Ou.CMD 	:= 27;
 				ELSE
		   		xDev^.al.in.CMD   := 0;
				END_CASE;
				xDev^.cx.all.LastWsb		:= xDev^.al.wsb;								// len sa uchova

				IF xDev^.cf.typ = 1 THEN													// roletova scena
					IF xDev^.al.Ou.val > 0. THEN                                // rolety su v pohybe
//						xDev^.al.in.CMD 	:= 0;                                  // stop
						xDev^.al.Ou.CMD 	:= 3;                                  // stop
					ELSIF xDev^.al.in.CMD = 1 THEN
						xDev^.al.Ou.CMD 	:= 23;
					END_IF;
					xDev^.al.in.CMD := 0;					
				ELSIF xDev^.al.in.CMD = 1 THEN											// prepnut
					IF xDev^.al.OU.val > 0.	THEN
//     		   		xDev^.al.in.val   := 0.0;
						xDev^.al.Ou.CMD 	:= 10;
					ELSIF xPar^.all.lvl = 0 THEN                       			// je vypnute a v  par = 0
//     		     		xDev^.al.in.val	:= 100.0;                              // zapnut naplno
						xPar^.all.lvl 		:= 100;											// nastavi LVL v prametri - najma pri vazbach
	  	   			xDev^.al.Ou.CMD  	:= 14;
	      		ELSIF  xPar^.all.lvl <> 100 THEN
						xDev^.al.in.val := USINT_TO_REAL(xPar^.all.lvl);			// nastavi LVL v prametri - najma pri vazbach
	  	   			xDev^.al.Ou.CMD  	:= 14;
					ELSE
						xDev^.al.in.val 	:= 100;	
	  	   			xDev^.al.Ou.CMD  	:= 14;
	      		END_IF;
  	   			xDev^.al.in.CMD  	:= 0;
				END_IF;
				IF ok1 AND xPar^.all.tDelay > 0 THEN 												// opozdene vykonanie
					xDev^.al.In.CMD	:= 0;
					xDev^.al.Ou.CMD	:= 0;
  			   	xDev^.al.et    	:= xPar^.all.tDelay ;                        //
   				xDev^.al.CM    	:= 2;                                        // vykonava sa opozdenie
  	   			xDev^.al.ct    	:= 3;                                     	// Delay je vzdy v [100ms]
   			END_IF;



				IF xDev^.al.Ou.CMD > 0 THEN
					   _NhxRom(nr := xDev^.cf.rom, x:=-10);
					   IF xDev^.al.wsb = false THEN                                   // nic sa nedeje neprislo z WSB {mozno z ACT..SCN}
		   			   ;
			   		ELSIF  xDev^.al.in.val > 0.0 AND xPar^.all.BlPirON THEN       	// je ON
		   	   		xRom^.me.BlPirOn    := 50;  	                             	// zapnutie od WSB/WEB vzdy blokuje PIR
   			   		xRom^.me.BlPirOff   := 0;                               		// resetne sa cas blokovania po vypnuti
	   				ELSIF xPar^.all.BlPirOff AND xRom^.cx.BlPirOFF > 0 THEN 			// kontrola na blokovanie PIR po vypnuti WSB/WEB
		   				xRom^.me.BlPirOff := MAX(xRom^.me.BlPirOff,xRom^.cx.BlPirOFF); // max cas blokovania po vypnuti
	   				END_IF;

						// casy vypnutia
	   		      IF xDev^.al.IN.val < 1.0 THEN                   		// ma sa vypnut
							xDev^.al.IN.val 	:= 0.0;
		   	      ELSIF xDev^.al.OU.val < 1.0 THEN                      // je OFF a ma za zapnut
      			      xDev^.al.ex := UINT_TO_INT(xDev^.cx.all.tMaxON);   // max cas zapnutia [min] - pohyb neresetuje
		         	END_IF;
	   		      IF xDev^.al.IN.val > 0.0 THEN
							xDev^.al.up		:= true;
		      	      IF xPar^.all.tOff > 0 THEN
      		   	      xDev^.al.et := xPar^.all.tOff;                  // vypnut po cas
            			   xDev^.al.ct := 3;                               // po 100mSEC
			            ELSE
   			            xDev^.al.et := 0;                               // nema sa vypnut po case
		      	      END_IF;
						ELSE
							xDev^.al.ex    	:= 0;
						 	xDev^.al.et    	:= 0;
						END_IF;
					END_IF;
				END_IF;
xScn^.me.qr  		:= xDev^.al;	

			ELSIF xDev^.al.trg.Q THEN                                         // presss alebo len zopar cyklov, ked sa neuvolni cmd
				If xDev^.al.in.Cmd = 24 THEN
					xDev^.al.Ou.Cmd := 30;
				END_IF;
				
			ELSIF xDev^.al.trg.Qf THEN														// koniec CMD
				xScn^.me.delayOff := MAX(2,xScn^.me.delayOff);						// prie Qr. sa sem uz nazzbieral najvyssi delay
				xDev^.al.wsb 		:= 0;
			ELSIF aSys.Restart THEN                         				
				IF xDev^.cf.LvlOnRst  THEN	 												// po restarte obnovit
					;
				END_IF;
			END_IF;

			xDev^.al.IN.CMD   	:= 0;															// uz nebude potrebne
			CASE xDev^.al.cm OF
            0:	// SCN je OFF																					// SCN je OFF
					;
				1: // SCN je ON 																	// xDev^.al.ou.val > 0.  													
					// check SCN ON
					IF xScn^.me.delayOff > 0 THEN
						xScn^.me.delayOff := xScn^.me.delayOff - aSys.u1Sec;				
					ELSIF xScn^.cx.all.LastLvl > 0 THEN										// aspon jedno DEV v SCN JE zanute aspon na minimum
				   	;
					ELSE	//IF xScn^.cx.all.LastLvl = 0 THEN								// ziadne DEV v SCN NIE-je zanute aspon na minimum
						_Nh_Dev_OFF_SCN();
					END_IF;

					IF _Nh_Dev_ET_UINT(t :=3, et:= ADR(xDev^.al.et) ) OR				// odpocitava cas zapnutia [min]
						_Nh_Dev_ET_INT (t :=2, et:= ADR(xDev^.al.ex) ) THEN			// odpocitava max cas zapnutia [min]
						xDev^.al.in.cmd	:= 10;
						xDev^.al.CM			:= 0;
   				END_IF            	
				2: // bezi delay
					xDev^.al.in.cmd	:= 0;
					IF _Nh_Dev_ET_UINT(t :=3, et:= ADR(xDev^.al.et) ) THEN			// odpocitava Delay [min]
						xDev^.al.in.par	:= xDev^.al.ou.par;								//
						xDev^.al.In.CMD	:= xDev^.cx.all.LastCMD;
//						xDev^.al.cm			:= 102;
					END_IF;
         END_CASE;
			CASE xDev^.al.Ou.CMD OF
           	0:	;
			 	3:	// Stop rolety
					_Nh_Dev_OFF_SCN(cmd:=3);	
			   6:	;//
			   7:	;//

			  10:	// off
					_Nh_Dev_OFF_SCN(cmd:=10);
			  11:	// 100%
					xDev^.al.Ou.val 	:= 100.;
			  23:	// ROL - centralne START/STOP
					xDev^.al.Ou.val	:= 100.;
					xDev^.al.Up 		:= NOT xDev^.al.Up;
			  24:	// ROL - centralne lamely Up/Dn
//					xDev^.al.In.val	:= 100.;
					xDev^.al.Ou.val	:= 100.;
					xDev^.al.Up 		:= NOT xDev^.al.Up;
			  30:	// ROL -  lamely Up/Dn - bezi pres
					xDev^.al.Ou.val	:= 100.;
         ELSE	// 14,21
					xDev^.al.OU.val 	:= xDev^.al.In.val;
//					xDev^.al.OU.par 	:= xDev^.al.In.val;
         END_CASE;

			IF xDev^.al.Ou.CMD > 0 THEN
xScn^.me.ou  		:= xDev^.al;
			END_IF;

			xScn^.cx.all.LastLvl := 0;			


		END_IF;
	END_FOR;
END_FUNCTION
*)


FUNCTION _Nh_SCN    : BOOL
   _Nh_SCN := _Dev_INI(c := 4);
	FOR nd := 1 TO aCfg[cf].rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
	      xScn	:= xDev;
			IF _Dev_Qx_PAR(dpa:=xDev^.cf.par) THEN

//xScn^.me.in := xDev^.al;

				xDev^.al.ex    			:= 0;
			 	xDev^.al.et    			:= 0;
				xDev^.al.el					:=	0;
 			
//			 	xDev^.al.cm    			:= 0;

				xDev^.cx.all.LastCMD 	:= xDev^.al.in.CMD;					// zapamata posledny pokyn
//				xDev^.cx.all.LastCMDin	:= true;                         // pokyn je prichadzajuci
				
//				xScn^.cx.all.LastScnOn 	:= true;			
				xDev^.al.rmp 				:= 0;	

				IF aCfg[cf].par > 0 THEN											// dev ma parameter, SIR napr nema parameter
 	   			vr    := USINT_TO_REAL(xPar^.all.Lvl);                // default sa podhodi LVL
				ELSE
					vr := 0.0;                                          	// bez parametra nebude potrebovat, lebo pride konkretne CMD
				END_IF;

				ok		:= false;
				CASE xDev^.al.in.CMD OF
			      1: // prepnut z WEB
		   	      xDev^.al.wsb      := true;									// nasilne sa podhodi ako z WSB, aby sa zablokoval pir
			      2: // prepnut z WSB												// wsb nastavi priznak WSB vo vazbach automaticky
						xDev^.al.wsb		:= true;
   			      xDev^.al.in.CMD   := 1;
		      	3: // resetovat casy nastavit OFF, ale neposielat nic
						_Nh_Dev_OFF(cmd:=3);
						xDev^.al.in.CMD := 0;
			     10: // OFF + zapnut blokovanie PIR
   			      xDev^.al.in.val   := 0.0;
			     11: // zapnutie na 100%
						xDev^.al.in.val   := 100.0;                              // zapnut naplno
				  14: // zapnut na LVL, ulozenu v parametri, nastavit casy opozdeny start/po case vypnut/max.cas zapnutia
		   	      xDev^.al.in.val   := vr;
			     21: // PIR - ON
			         _NhxRom(nr := xDev^.cf.rom, x:=-14);
			         IF xRom^.me.BlPirOn = 0 AND xRom^.me.BlPirOFF = 0 THEN  	// nie je blokovana ROM po vypnuti, ani po zapnuti
			            IF xDev^.al.ou.Val < 0.9 OR xPar^.all.rPir THEN       // je OFF alebo bezi cas-to-OFF a pohyb resetuje cas
			               xDev^.al.IN.val   := vr;
			               xDev^.al.ou.CMD   := 21;
			            END_IF;
			         ELSE
	      			   xDev^.al.in.CMD   := 0;
			         END_IF;
         			xDev^.al.wsb      := 0;
			     23: // Rolety Start/Stop
			     24: // Rolety lamely naklapat
			     26: // Rolety lamely otvorit
			     27: // Rolety lamely zaklopit
 				ELSE
		   		xDev^.al.in.CMD   := 0;
				END_CASE;
				xDev^.cx.all.LastWsb		:= xDev^.al.wsb;										// prisiel z wsb
				IF xDev^.cf.typ = 1 AND xDev^.al.Ou.val > 0. THEN
					xDev^.al.In.CMD 	:= 3;
  	   			xDev^.al.CM    	:= 0;                                        // vykonava sa opozdenie
					ok						:= true;
				ELSIF xDev^.al.in.CMD = 1 THEN
					xDev^.al.CM 		:= 0;
					ok						:= true;
					IF xDev^.cf.typ = 1	THEN
						xDev^.al.in.CMD 	:= 23;

						IF xDev^.al.OU.val > 0. THEN
							xDev^.al.CM 	:= 3;
						ELSE					
  		   				xDev^.al.in.val   := 100.0;
							xDev^.al.OU.val	:= 100.0;
							xDev^.al.Up := NOT xDev^.al.Up;
							IF xDev^.al.Up THEN
								xDev^.al.CM 		:= 10;
							ELSE
								xDev^.al.CM 		:= 11;
							END_IF;
						END_IF;

								
					ELSIF xDev^.al.OU.val > 0.	THEN
     		   		xDev^.al.in.val   := 0.0;
						xDev^.al.in.CMD 	:= 10;
					ELSIF xPar^.all.lvl = 0 THEN
     		     		xDev^.al.in.val	:= 100.0;                              // zapnut naplno
						xPar^.all.lvl 		:= REAL_TO_USINT(xDev^.al.in.val);				// nastavi LVL v prametri - najma pri vazbach
	  	   			xDev^.al.in.CMD  	:= 14;
	      		ELSIF  xPar^.all.lvl <> 100 THEN
						xDev^.al.in.val := USINT_TO_REAL(xPar^.all.lvl);				// nastavi LVL v prametri - najma pri vazbach
//	  	   			xDev^.al.CM    	:= 13;
	  	   			xDev^.al.in.CMD  	:= 14;
					ELSE
						xDev^.al.in.val 	:= 100;	
	  	   			xDev^.al.in.CMD  	:= 14;
	      		END_IF;
				END_IF;
				IF xDev^.cf.typ <> 0	THEN
					;
				ELSIF xDev^.al.in.CMD > 0 THEN
					IF ok THEN
  	   				xDev^.al.CM    	:= 0;                                        // vykonava sa opozdenie					
					ELSIF xDev^.al.CM = 102 THEN
  	   				xDev^.al.CM    	:= 0;                                        // vykonava sa opozdenie					
 					ELSIF xPar^.all.tDelay > 0 THEN 												// opozdene vykonanie
						xDev^.al.in.CMD	:= 0;
   			   	xDev^.al.et    	:= xPar^.all.tDelay ;                        //
  	   				xDev^.al.CM    	:= 2;                                        // vykonava sa opozdenie
   	   			xDev^.al.ct    	:= 3;                                     	// Delay je vzdy v [100ms]
   				END_IF;
					IF xDev^.al.in.CMD > 0 THEN
					   _NhxRom(nr := xDev^.cf.rom, x:=-10);
					   IF xDev^.al.wsb = false THEN                                   // nic sa nedeje neprislo z WSB {mozno z ACT..SCN}
		   			   ;
			   		ELSIF  xDev^.al.in.val > 0.0 AND xPar^.all.BlPirON THEN       	// je ON
		   	   		xRom^.me.BlPirOn    := 50;  	                             	// zapnutie od WSB/WEB vzdy blokuje PIR
   			   		xRom^.me.BlPirOff   := 0;                               		// resetne sa cas blokovania po vypnuti
	   				ELSIF xPar^.all.BlPirOff AND xRom^.cx.BlPirOFF > 0 THEN 			// kontrola na blokovanie PIR po vypnuti WSB/WEB
		   				xRom^.me.BlPirOff := MAX(xRom^.me.BlPirOff,xRom^.cx.BlPirOFF); // max cas blokovania po vypnuti
	   				END_IF;
						// casy vypnutia
	   		      IF xDev^.al.IN.val < 1.0 THEN                   		// ma sa vypnut
							xDev^.al.IN.val 	:= 0.0;
		   	      ELSIF xDev^.al.OU.val < 1.0 THEN                      // je OFF a ma za zapnut
      			      xDev^.al.ex := UINT_TO_INT(xDev^.cx.all.tMaxON);   // max cas zapnutia [min] - pohyb neresetuje
		         	END_IF;
	   		      IF xDev^.al.IN.val > 0.0 THEN
							xDev^.al.up		:= true;
		      	      IF xPar^.all.tOff > 0 THEN
      		   	      xDev^.al.et := xPar^.all.tOff;                  // vypnut po cas
            			   xDev^.al.ct := 3;                               // po 100mSEC
			            ELSE
   			            xDev^.al.et := 0;                               // nema sa vypnut po case
		      	      END_IF;
						ELSE
							xDev^.al.ex    	:= 0;
						 	xDev^.al.et    	:= 0;
						END_IF;
					END_IF;
				END_IF;
				
//xScn^.me.qr  		:= xDev^.al;	
				
				
			ELSIF xDev^.al.trg.Q THEN                                         // presss alebo len zopar cyklov, ked sa neuvolni cmd
				xDev^.al.rmp 	:= 0;
				If xDev^.al.in.Cmd = 24 THEN
					xDev^.al.in.Cmd := 30;
				END_IF;
				
			ELSIF xDev^.al.trg.Qf THEN														// koniec CMD
				xDev^.al.rmp 	:= 0;
				xDev^.al.wsb 	:= 0;
//				IF xDev^.al.OU.val > 0. THEN
//					xPar^.all.lvl := REAL_TO_USINT(xDev^.al.OU.val);		// zapamata LVL v default parametri
//				END_IF;
			ELSIF aSys.Restart THEN                         				
				IF xDev^.cf.LvlOnRst  THEN	 								// po restarte obnovit
					;
				END_IF;
			END_IF;

			// check SCN ON
			IF xDev^.al.ou.val > 0.  THEN							// SCN je zapnuta
				IF xDev^.al.rmp > 1 THEN
					IF xScn^.cx.all.LastScnOn = false THEN						// ziadne DEV v SCN NIE-je zanute aspon na minimum
						_Nh_Dev_OFF_SCN();
					END_IF;
				ELSE
					xDev^.al.rmp := xDev^.al.rmp + 1;				
				END_IF;
				xScn^.cx.all.LastScnOn := false;			
			END_IF;

			cmd	:= 0;
			CASE xDev^.al.cm OF
            0: ;
					IF _Nh_Dev_ET_UINT(t :=3, et:= ADR(xDev^.al.et) ) OR						// odpocitava cas zapnutia [min]
						_Nh_Dev_ET_INT (t :=2, et:= ADR(xDev^.al.ex) ) THEN			// odpocitava max cas zapnutia [min]
						xDev^.al.in.cmd	:= 10;
						xDev^.al.CM			:= 0;
   				END_IF            	


				2: // bezi delay
					xDev^.al.in.cmd	:= 0;
					IF _Nh_Dev_ET_UINT(t :=3, et:= ADR(xDev^.al.et) ) THEN			// odpocitava Delay [min]
						cmd					:= xDev^.cx.all.LastCMD;
						xDev^.al.in.par	:= xDev^.al.ou.par;								//
						xDev^.al.In.CMD	:= 0;
						xDev^.al.cm			:= 102;
					END_IF;
//				1: // bezia casy OFF
				ELSE
         END_CASE;



			CASE xDev^.al.IN.CMD OF
           	0:	;
			 	3:	// Stop rolety
					xDev^.al.OU.CMD 	:= 3;
					xDev^.al.Ou.val	:= 0.;
			   6:	;//
			   7:	;//

			  10:	// off
					_Nh_Dev_OFF_SCN(cmd:=10);
					xDev^.al.Ou.val	:= 100.;
			  11:	// 100%
					xDev^.al.Ou.CMD 	:= 11;
					xDev^.al.Ou.val 	:= 100.;

			  23:	// ROL - centralne START/STOP
//					xDev^.al.In.val	:= 100.;
					xDev^.al.Ou.val	:= 100.;
					xDev^.al.Ou.CMD 	:= 23;
					xDev^.al.Up 		:= NOT xDev^.al.Up;
			  24:	// ROL - centralne lamely Up/Dn
					xDev^.al.In.val	:= 100.;
					xDev^.al.Ou.val	:= 100.;
					xDev^.al.Ou.CMD 	:= 24;
					xDev^.al.Up 		:= NOT xDev^.al.Up;
			  30:	// ROL -  lamely Up/Dn - bezi pres
					xDev^.al.Ou.val	:= 100.;
					xDev^.al.Ou.CMD 	:= 30;
         ELSE
					xDev^.al.OU.CMD 	:= xDev^.al.In.CMD;
					xDev^.al.OU.val 	:= xDev^.al.In.val;
//					xDev^.al.OU.par 	:= xDev^.al.In.val;



         END_CASE;
			IF xDev^.al.IN.CMD > 0 THEN
//xScn^.me.ru  		:= xDev^.al;
			END_IF;
			xDev^.al.IN.CMD   := cmd;									
		END_IF;
	END_FOR;
END_FUNCTION





{$IFDEF __NH_DALI}
FUNCTION _Nh_DALI     :BOOL               // UNIVERZALNY BLIKAC viditelny v browse pre hocikolko dev, spustitelny APP prostriedkami
	VAR
//		xPtrDLm	: PTR_TO USINT;
	END_VAR;
	// prechadza vsetky vety a zbiera zmenu  do buduceho cyklu
 	_Nh_SVX(c:=42);      											// DLm
   _Nh_SVX(c:=44);      											// DLg
   _Nh_SVX(c:=43);      											// DLs dls na konci robi este sumare LVL podla DLm/DLg
	FOR dlma := 1 TO INT_TO_USINT(aCfg[42].rec)  DO       // prechadzaju sa mastre
		IF _NhxDLm(dlm := dlma) THEN
			xDev     			:= xDLm;
   		xDLfb    			:= ADR(aDali[dlma]) ;
			xDLMc    			:= ADR(xDLfb^.cmd[1]);        // CMD, ktory sa priamo vykonava
			xDLm^.me.lvl255	:= false;               	   // vynuluje centralny prikaz nastavenia LVL

         xDLm^.me.scn.SET	:= _eBtn15;							// vynuluje priznak nastavenia sceny od DLs   		

			IF xDLm^.hw.d[0] > 0 AND xDLm^.hw.d[1] > 0 THEN
				_NH_DLM_RUN(In := UDINT_TO_PTR(xDLm^.hw.d[0]) , Out := UDINT_TO_PTR(xDLm^.hw.d[1]) );
        	END_IF;
		END_IF;
	END_FOR;

END_FUNCTION
{$END_IF}

(*
   IF aSys.Restart THEN
      cf := 43;
      aSys.frw.FN    := CONCAT(_Nh_ADR_USB,'DLS.RAM');               // nazov noveho suboru
      aSys.frw.fP    := BEGIN_POS;                 // dolezite nastavit na zaciatok
      IF _NhFopen( fh := aSys.frw.fH, fN := aSys.frw.FN) THEN
         sz := fS / 128;
         FOR nd := 1 TO aCfg[cf].rec DO
            _NhxPt(cf:=cf,nd:=nd);
            IF _Nhfrw(wht := 0, fW := ADR(yDls[1]),  sz := sz, row := false)  THEN
               xPt^.ok.ok  := yDls[1].ok.ok;
//               xPt^.ok.ok  := 0;
               xPt^.cf.Rom := yDls[1].cf.rom;
               xPt^.cf.Name:= yDls[1].cf.Name;
               xPt^.cf.cat := yDls[1].cf.cat;
               xPt^.cf.typ := yDls[1].cf.typ;

            END_IF;
         END_FOR;
      END_IF;
      cf := 44;
      aSys.frw.FN    := CONCAT(_Nh_ADR_USB,'DLG.RAM');               // nazov noveho suboru
      aSys.frw.fP    := BEGIN_POS;                 // dolezite nastavit na zaciatok
      IF _NhFopen( fh := aSys.frw.fH, fN := aSys.frw.FN) THEN
         sz := fS / 32;
         FOR nd := 1 TO aCfg[cf].rec DO
            _NhxPt(cf:=cf,nd:=nd);
            IF _Nhfrw(wht := 0, fW := ADR(yDlg[1]),  sz := sz, row := false)  THEN
               xPt^.ok.ok  := yDlg[1].ok.ok;
//               xPt^.ok.ok  := 0;
               xPt^.cf.Rom := yDlg[1].cf.rom;
               xPt^.cf.Name:= yDlg[1].cf.Name;
               xPt^.cf.cat := yDlg[1].cf.cat;
               xPt^.cf.typ := yDlg[1].cf.typ;
            END_IF;
         END_FOR;
      END_IF;
   END_IF;
   yTx1  := CONCAT(_Nh_ADR_LOG,'_EVN.LOG');
	RETURN;	
*)



FUNCTION _Nh_BLK_CMD  {HIDDEN}   :BOOL               // UNIVERZALNY BLIKAC viditelny v browse pre hocikolko dev, spustitelny APP prostriedkami
   VAR_INPUT
      off   : BOOL;
   END_VAR
	_Nh_BLK_CMD := true;
   IF off THEN                                              // OFF = vypnut
      xBlk^.al.et       := MAX(1,xBlk^.cx.tDn * 50);       //1*50 -> mSEC
      xBlk^.me.CMD      := 130;
      IF xBlk^.cx.lOwn THEN
         xBlk^.al.ou.Val   := USINT_TO_REAL(xBlk^.cx.lDn);
//         xBlk^.al.ou.CMD   := 11;
         xBlk^.al.ou.CMD   := 13;
      ELSE
         xBlk^.al.ou.Val   := 0.0;
//         xBlk^.al.ou.CMD   := 11;
         xBlk^.al.ou.CMD   := 13;
      END_IF;
   ELSE
      xBlk^.al.et       := MAX(1,xBlk^.cx.tUp * 50);       //1*50 -> 50 mSEC
      xBlk^.me.CMD      := 140;
      IF xBlk^.cx.lOwn THEN
         xBlk^.al.ou.Val   := USINT_TO_REAL(xBlk^.cx.lUp);
//         xBlk^.al.ou.CMD   := 11;
         xBlk^.al.ou.CMD   := 13;
      ELSE
         xBlk^.al.ou.Val   := 100.0;
         xBlk^.al.ou.CMD   := 12;
      END_IF;
   END_IF;
END_FUNCTION

FUNCTION _Nh_BLK  {HIDDEN} :BOOL   // UNIVERZALNY BLIKAC viditelny v browse pre hocikolko dev, spustitelny APP prostriedkami
   _Nh_BLK := _Nh_Dev_INI(c := 35 );
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
			xDev^.al.lst		:= 0;
         xBlk              := xDev;
         xBlk^.al.ou.cmd   := 0;
         IF _Nh_Dev_Qx(In := xBlk^.al.in.CMD > 0 ) THEN            	// zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0
//            _Nh_Dev_Qr_CMD();
            // vlastna uprava globalneho CMD

xDev^.al.cm := xBlk^.al.in.CMD;

            xBlk^.me.CMD := 100;                                  		// default je start
            CASE xBlk^.al.in.CMD OF
              1 : // prepnut z WEB
              2 : // prepnut z WSB
              		xBlk^.al.in.CMD := 1;
              21: // PIR sa prevedie na 14
              		xBlk^.al.in.CMD := 14;
            ELSE
                  xBlk^.me.CMD := 190;
            END_CASE;
				CASE xBlk^.al.in.CMD OF
              1 :	// prepnut
				  		IF xBlk^.al.sta > 0 THEN
     						xBlk^.me.CMD := 190;                            	// ak bezi, vypne sa
						END_IF;	
              10:	// zapnut/restart
  						xBlk^.me.CMD := 190;                            	// ak bezi, vypne sa
              11:	// zapnut/restart
  						xBlk^.me.CMD := 100;                            	// restart

              14:	// zapnut/restart
                  IF xBlk^.me.CMD > 0 THEN
     						xBlk^.me.CMD := 101;                            	// restart
//	                  xBlk^.al.rmp  := MAX(1,xBlk^.cx.nSer);
                  END_IF;
            END_CASE;
         END_IF;
         xBlk^.al.in.CMD   := 0;

         // xBlk^.al.et       odpocitavany cas podla ct
         // xBlk^.al.ct       0=mSEC,1=sec
         // xBlk^.al.el       pocet bliknuti
         // xBlk^.al.rmp      pocet serii


			IF _Nh_Dev_ET_UINT(t:=2, et := ADR(xBlk^.me.tMax) ) THEN			// odpocitava max cas zapnutia [min]
            xBlk^.me.CMD := 190;                                      	// vypne
			END_IF;
         ok	:= _Nh_ET_MS(et := ADR(xBlk^.al.et));                       // odpocitava z xBlk^.al.et mSec z minuleho cyklu, ked bude 0 frati true
         xBlk^.al.sta := 1;
         CASE xBlk^.me.CMD OF
           0 : xBlk^.al.sta := 0;
           2 : // bezi delay
               IF ok THEN
						// tu je jediny restart
						IF xBlk^.cx.nSer > 0 THEN
		               xBlk^.me.nSer   	:= xBlk^.cx.nSer-1;            // nastavi pocet serii
						END_IF;
	               xBlk^.me.nBlk     := MAX(1,xBlk^.cx.nBlk);        		// pocet bliknuti
               	_Nh_BLK_CMD(off := xBlk^.cx.OffS);
//                  xBlk^.me.CMD    := xBlk^.me.RUN;
               END_IF;

         100 : // uplne novy start
               xBlk^.me.tMax  	:= xBlk^.cx.tMax;
               xBlk^.me.CMD   	:= 2;
               xBlk^.al.ou.CMD   := 15;                           // VZDY zapamata aktualnu LVL u DEV v tomco cykle, kde sa nic nedeje
               IF xBlk^.cx.delay > 0 THEN
                  xBlk^.al.et    := xBlk^.cx.delay * 100;			// odlozenie je v 100mS
               ELSE
                  xBlk^.al.et    := 1;
               END_IF;                                            // aby sa v dalsom kole vukonalo ukoncenie delay

         101 : // restart
               xBlk^.me.CMD   	:= 2;
               xBlk^.al.et    	:= 1;

         130 : // bezi cas vypnutia
               IF ok THEN                                            // skoncil cas vypnutia
                  IF xBlk^.me.nBlk > 0 THEN                       	
                     _Nh_BLK_CMD();
                  ELSIF xBlk^.me.nSer = 0 THEN                  		// pocet serii sa dosiahol
                     xBlk^.me.CMD   := 190;
                  ELSE
                     xBlk^.me.CMD  		:= 150;                      	// cakanie na dalsiu seriu
							xBlk^.me.nSer		:= xBlk^.me.nSer - 1;
                     xBlk^.al.et   		:= xBlk^.cx.tSer ;       		// cas cakania na dalsiu seriu SEC -> 100mS
                     xBlk^.al.ou.Val   := USINT_TO_REAL(xBlk^.cx.lSer);
//                     xBlk^.al.ou.CMD   := 11;
                     xBlk^.al.ou.CMD   := 15;
                  END_IF;
               END_IF;

         140 : // bezi cas zapnutia
               IF ok THEN                                // skoncil cas ON
                  _Nh_BLK_CMD(off := true);
                  xBlk^.me.nBlk	:= xBlk^.me.nBlk - 1;
               END_IF;

         150 : // bezi cas cakania na dalsiu seriu
               IF ok THEN                                // skoncil cas ON
	               xBlk^.me.nBlk     := MAX(1,xBlk^.cx.nBlk);        		// pocet bliknuti
               	_Nh_BLK_CMD(off := xBlk^.cx.OffS);
               END_IF;

         190 : // koniec
               IF xBlk^.cx.OffE THEN
                  xBlk^.al.ou.cmd := 10;
               ELSE
                  xBlk^.al.ou.cmd := 16;                          // obnovi zapamatanu LVL u vsetkych DEV
               END_IF;
               xBlk^.al.et    := 0;
               xBlk^.me.nBlk  := 0;
               xBlk^.me.nSer  := 0;
               xBlk^.me.CMD   := 0;
               _NhDevRef(xR  := xDev);
         END_CASE;
//         xBlk^.al.sta := _Nh_U12(xBlk^.al.cm = 0,0,1);
      END_IF;
	END_FOR;
END_FUNCTION


FUNCTION   _Nh_TGL  {HIDDEN} :  BOOL
   _NH_TGL := _NH_DEV_INI(c:=40);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
         xTgl  	:= xDev;																	// xTgl ma
         xCfL  	:= ADR(xTgl^.cx.cfL);
         xCfd  	:= ADR(xTgl^.cx.cfD);
         xGlas    := UDINT_TO_PTR(xTgl^.hw.d[1]);
         xBtnS    := UDINT_TO_PTR(xTgl^.hw.d[0]);
         _NhxRom(c:=1, nr:=xTgl^.cf.rom, x:=-111);

			xDevOka	:= xDev;
			xPtB		:= ADR(xBtnS^.BTN.BTN1);
			xTgl^.al.cli.trg( In :=	xBtnS^.BTN <> _eBtnS.BTN);
			xTgl^.al.cli(cfc := ADR(xTgl^.cx.cfc), InBtn := 0);		

			IF xTgl^.al.cli.trg.Qr THEN
				_Nh_Log_Evn_ADD( tsk := USINT_TO_INT(aCfg[cf].tgrp), wht := 'BEG');
			END_IF;	



			IF xTgl^.al.cli.Lock THEN                                           // ak je Lock = stlacene viac ako 10s
   			xGlas^.cont.PX 	:= NOT xGlas^.cont.PX;								// reset TGL
			ELSIF xGlas^.cont.PX THEN
				xGlas^.cont.PX := false;			
			END_IF;

			_Nh_TGL_LED_RUN();
			IF xCfL^.refresh THEN
				xCfL^.refresh := false;
				IF xCfL^.Sleep THEN
					;
				ELSE
					IF xTgl^.al.cm = 2 THEN
						xGlas^.BLIGHT  := 100;
					ELSE
						xGlas^.BLIGHT  := xcfL^.DayLVL[xRom^.me.DayObr];
					END_IF;
				END_IF;
				xLedR	:= ADR(xGlas^.LED.RED1);
				xLedG	:= ADR(xGlas^.LED.GREEN1);
				xLedO	:= ADR(xGlas^.LED.LED1);
				_Nh_LED_REFRESH_TGL();
			END_IF;	
			
			_Nh_TGL_DIS_RUN();
			IF xCfd^.refresh THEN
				xCfd^.refresh := false;
				IF xCfd^.Sleep OR xCfd^.off THEN
					xGlas^.CONT.DBA  	:= 0 ; 	
				ELSE
					xGlas^.CONT.DBA  	:= 1 ; 	
					IF xTgl^.al.cm = 2  THEN
						xGlas^.BLIGHT  := 100;
					ELSE
						xGlas^.BLIGHT  := xcfD^.DayLVL[xRom^.me.DayObr];
					END_IF;
				END_IF;
				_Nh_DIS_REFRESH();
			END_IF;	
			xTgl^.al.in.cmd 	:= 0;       						// koli slideru (7)
         _Nh_Sta_Rom(sta 	:= xDev^.al.sta);    			// stav do miestnosti			
		END_IF;
   END_FOR;
END_FUNCTION


FUNCTION   _Nh_TG2  {HIDDEN}  :  BOOL
   _NH_TG2 := _NH_DEV_INI(c:=40);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
         xTgl  	:= xDev;																	// xTgl ma
         xCfL  	:= ADR(xTgl^.cx.cfL);
         xCfd  	:= ADR(xTgl^.cx.cfD);
     	   _NhxRom(c:=1, nr:=xTgl^.cf.rom, x:=-111);
			xDevOka	:= xDev;
   		IF xTgl^.cx.cfD.TG2 THEN
	         xGlas2   := UDINT_TO_PTR(xTgl^.hw.d[1]);
   	      xBtnS2   := UDINT_TO_PTR(xTgl^.hw.d[0]);
				xPtB		:= ADR(xBtnS2^.BTNs.BTN.BTN1);
				xTgl^.al.cli.trg( In :=	xBtnS2^.BTNs.BTN <> _eBtnS2.BTN);
				xTgl^.al.cli(cfc := ADR(xTgl^.cx.cfc), InBtn := 0);		
				_Nh_TGL_LED_RUN();
				IF xCfL^.refresh THEN
					xCfL^.refresh := false;
					IF xCfL^.Sleep THEN
						;
					ELSE
						IF xTgl^.al.cm = 2 THEN
							xGlas2^.BLIGHT  := 100;
						ELSE
							xGlas2^.BLIGHT  := xcfL^.DayLVL[xRom^.me.DayObr];
						END_IF;
					END_IF;
					xLedR	:= ADR(xGlas2^.LED.RED1);
					xLedG	:= ADR(xGlas2^.LED.GREEN1);
					xLedO	:= ADR(xGlas2^.LED.BLUE1);
					_Nh_LED_REFRESH_TGL();
				END_IF;	
				_Nh_TGL_DIS_RUN();
				IF xCfd^.refresh THEN
					xCfd^.refresh := false;
					IF xCfd^.Sleep OR xCfd^.off THEN
						xGlas2^.CONT.DBA  	:= 0 ; 	
					ELSE
						xGlas2^.CONT.DBA  	:= 1 ; 	
						IF xTgl^.al.cm = 2  THEN
							xGlas2^.DLIGHT  := 100;
						ELSE
							xGlas2^.DLIGHT  := xcfD^.DayLVL[xRom^.me.DayObr];
						END_IF;
					END_IF;
					_Nh_DIS_REFRESH(tg2:=1);
				END_IF;	
   		ELSE
	         xGlas    := UDINT_TO_PTR(xTgl^.hw.d[1]);
   	      xBtnS    := UDINT_TO_PTR(xTgl^.hw.d[0]);
				xPtB		:= ADR(xBtnS^.BTN.BTN1);
				xTgl^.al.cli.trg( In :=	xBtnS^.BTN <> _eBtnS.BTN);
				xTgl^.al.cli(cfc := ADR(xTgl^.cx.cfc), InBtn := 0);		
				IF xTgl^.al.cli.Lock THEN                                           // ak je Lock = stlacene viac ako 10s
   				xGlas^.cont.PX 	:= NOT xGlas^.cont.PX;								// reset TGL
				ELSIF xGlas^.cont.PX THEN
					xGlas^.cont.PX := false;			
				END_IF;
				_Nh_TGL_LED_RUN();
				IF xCfL^.refresh THEN
					xCfL^.refresh := false;
					IF xCfL^.Sleep THEN
						;
					ELSE
						IF xTgl^.al.cm = 2 THEN
							xGlas^.BLIGHT  := 100;
						ELSE
							xGlas^.BLIGHT  := xcfL^.DayLVL[xRom^.me.DayObr];
						END_IF;
					END_IF;
					xLedR	:= ADR(xGlas^.LED.RED1);
					xLedG	:= ADR(xGlas^.LED.GREEN1);
					xLedO	:= ADR(xGlas^.LED.LED1);
					_Nh_LED_REFRESH_TGL();
				END_IF;	
				_Nh_TGL_DIS_RUN();
				IF xCfd^.refresh THEN
					xCfd^.refresh := false;
					IF xCfd^.Sleep OR xCfd^.off THEN
						xGlas^.CONT.DBA  	:= 0 ; 	
					ELSE
						xGlas^.CONT.DBA  	:= 1 ; 	
						IF xTgl^.al.cm = 2  THEN
							xGlas^.BLIGHT  := 100;
						ELSE
							xGlas^.BLIGHT  := xcfD^.DayLVL[xRom^.me.DayObr];
						END_IF;
					END_IF;
					_Nh_DIS_REFRESH();
				END_IF;	
			END_IF;
			xTgl^.al.in.cmd 	:= 0;       						// koli slideru (7)
         _Nh_Sta_Rom(sta 	:= xDev^.al.sta);    			// stav do miestnosti			
		END_IF;
   END_FOR;
END_FUNCTION




FUNCTION   _Nh_WSB  {HIDDEN}   :BOOL
   _Nh_WSB := _NH_DEV_INI(c:=13);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
         xWsb  	:= xDev;																	// xTgl ma
         xTgl  	:= xDev;																	// xTgl ma
         xCfL  	:= ADR(xWsb^.cx.cfL);
         _NhxRom(c:=1, nr:=xTgl^.cf.rom, x:=-111);


(*
			xPtB := UDINT_TO_PTR(xWsb^.hw.d[0]);
			IF xWsb^.me.Btn > 0 THEN
			ELSIF _Nh_Click_BTN(n:=xWsb^.cx.cfc.nBTNs) THEN 												// ziadny stlaceny BTN
				xWsb^.me.Btn := i;
			ELSE
				xWsb^.me.Btn := 0;			
			END_IF;
*)
			xPtB := UDINT_TO_PTR(xWsb^.hw.d[0]);
			IF _Nh_Click_BTN(n:=xWsb^.cx.cfc.nBTNs) THEN 												// ziadny stlaceny BTN
				xWsb^.me.Btn := i;
			ELSE
				xWsb^.me.Btn := 0;
			END_IF;
         xDevOkA	:= xDev;
			xTgl^.al.cli.trg( In :=	xWsb^.me.Btn > 0);
			xTgl^.al.cli(cfc := ADR(xWsb^.cx.cfc), InBtn := xWsb^.me.Btn);		

			IF xTgl^.al.cli.trg.Qr THEN
				_Nh_Log_Evn_ADD( tsk := USINT_TO_INT(aCfg[cf].tgrp), wht := 'BEG');
			END_IF;	

(*
			xTgl^.al.cli(	InBtn	:= xWsb^.me.btn,										// FB zabezpeci n-Click,press, impulz pri 1.stlaceni
                        cfc 	:= ADR(xWsb^.cx.cfc)) ;


			IF _Nh_Click_OUT() THEN                                           // ak je Lock = stlacene viac ako 10s
				xWsb^.al.ou.cmd	:= 0;                                     	// nic sa neposiela
				xWsb^.al.sta		:= 0;                                    		//
			END_IF;

*)
			_Nh_TGL_LED_RUN();
			IF xCfL^.refresh THEN
				xCfL^.refresh := false;
				xLedG	:= UDINT_TO_PTR(xWsb^.hw.d[1]);
				xLedR	:= xLedG + 1;
				_Nh_LED_REFRESH_WSB();
			END_IF;	
			xTgl^.al.in.cmd 	:= 0;       						// koli slideru (7)
         _Nh_Sta_Rom(sta 	:= xDev^.al.sta);    			// stav do miestnosti			
		END_IF;
   END_FOR;
END_FUNCTION

FUNCTION _Nh_TLA {HIDDEN} :BOOL
	_Nh_TLA := _NH_DEV_INI(c := 14);
	FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
			xTla	:= xDev;
			xTgl	:= xDev;
			xTla^.me.Btn := 0;

			FOR j := 1 TO xTla^.cf.typ DO
				xPtB	:= UDINT_TO_PTR(xTla^.hw.d[j-1]);			
				IF xPtB^ THEN                                  					// prvy btn
					xTla^.me.Btn := SINT_TO_USINT(j);
					_NhDevRef(xR  := xTla);												// urobi sa aj refresh pre WEB
					EXIT;
				END_IF;
			END_FOR;

         xDevOkA	:= xDev;
			xTgl^.al.cli.trg( In :=	xTla^.me.Btn > 0);
			xTgl^.al.cli(cfc := ADR(xTla^.cx.cfc), InBtn := xTla^.me.Btn);		

			IF xTgl^.al.cli.trg.Qr THEN
				_Nh_Log_Evn_ADD( tsk := USINT_TO_INT(aCfg[cf].tgrp), wht := 'BEG');
			END_IF;	
(*
			xTla^.al.cli(	InBtn	:= xTla^.me.btn,										// FB zabezpeci n-Click,press, impulz pri 1.stlaceni
                        cfc 	:= ADR(xTla^.cx.cfc)) ;
			IF _Nh_Click_OUT() THEN                                           // ak je Lock = stlacene viac ako 10s
				xTla^.al.ou.cmd	:= 0;                                     	// nic sa neposiela
				xTla^.al.sta		:= 0;                                    		//
			END_IF;
*)
	      _Nh_Sta_Rom(sta := xTla^.al.sta);    // stav do miestnosti
			xTla^.al.DEV		:= _eBtn8;	
			xTla^.al.HET 		:= _eBtn8;
			xTla^.al.PRG		:= _eBtn8;
		ELSE
			xTla^.al.sta		:= 0; 				
		END_IF;
		xTla^.al.in.cmd 	:= 0;
	END_FOR;    	
END_FUNCTION






FUNCTION _Nh_GATE_HW {HIDDEN} :BOOL
	VAR_INPUT
		door		: BOOL;
		set		: BOOL;
		close    : BOOL;                                       	
		stop		: BOOl;
	END_VAR
	_Nh_GATE_HW			:= true;
	xGat^.al.et 		:= USINT_TO_UINT(xGat^.cx.tImp);   			// pri zopnuti sa  nastavi dlzka impulzu 5x100 [ms]
	xGat^.cx.cmd 		:= 110;					
	IF door  THEN														
		xGat^.cx.what 	:= 0;
		IF stop	THEN
			set 				:= 0;
			xGat^.al.et		:= 0;
		ELSE
			set				:= 1;
		END_IF;		
	ELSIF set  THEN														
		If Close THEN			
			i	:= 2;
			IF xGat^.me.RelayCloseOk THEN   								   // mame adresu ZATVOR {v hw.d[0] jer potol len OTVOR}
				xGat^.cx.what		:= 2;                            // zatvor ma svoj port
			ELSE
				xGat^.cx.what		:= 0;										// open/close jeden port
			END_IF;
		ELSE
			i						:= 1;			
			xGat^.cx.what		:= 0;										// open/close jeden port
		END_IF;	
		
		xGat^.me.inkr	:= 100.0 / (UINT_TO_REAL(xGat^.cx.tOpenClose[ i ]) * 100 );
	ELSIF stop THEN
		set := true;
	END_IF;
  	xPtB := UDINT_TO_PTR(xGat^.hw.d[ xGat^.cx.what ]);
	IF xGat^.cx.MotIsReal[ xGat^.cx.what ] THEN										// ak je
   	xPtR 	:= xPtB;
		xPtR^ := BOOL_TO_REAL(set) * 100.0;
	ELSE
		xPtB^ := set;
	END_IF;
	_NhDevRef(xR  := xDev);
END_FUNCTION

FUNCTION _Nh_GATE_CLOSE {HIDDEN} :BOOL					// nastavit OPEN/CLOSE
	VAR_INPUT
		close	: BOOL;
	END_VAR	
	_Nh_GATE_CLOSE	:= true;
	IF close THEN
		vr							:= 0.0;
		xGat^.cx.yGat 			:= 0.0;
		xGat^.cx.btn   		:= true;
		xGat^.cx.LastClose	:= true;
	ELSE
		vr							:= 100.0;
		xGat^.cx.yGat 			:= 100.0;
		xGat^.cx.btn   		:= false;
		xGat^.cx.LastClose	:= false;
	END_IF;
	IF xGat^.cx.cmd <> 2 OR xGat^.cx.pGat = vr THEN   	// nebezi odlozeny start alebo sa pozaduje tak ako prave je
		xGat^.al.et				:= 0; 							// cas otvorenia sa vynuluje
		xGat^.cx.pGat 			:= vr;
	END_IF;
	_NhDevRef(xR  := xDev);
END_FUNCTION

FUNCTION _Nh_GATE_GO {HIDDEN} : BOOL;
	IF xDev^.cf.typ > 1 THEN												// branicka,dvere,zavora		
		xGat^.cx.cmd 		:= 103;											// vzdy zasle impulz na otvorenie elektromagnetu
		xGat^.cx.run 		:= 0;												// nic
	ELSIF xGat^.cx.pGat > xGat^.cx.yGat THEN
		xGat^.cx.cmd 		:= 101;	
		xGat^.cx.run 		:= 201;											// otvor
	ELSIF xGat^.cx.pGat < xGat^.cx.yGat THEN
		xGat^.cx.cmd 		:= 102;	
		xGat^.cx.run 		:= 202;											// zatvor
	ELSE
		xGat^.cx.cmd 		:= 0;
		xGat^.cx.run 		:= 0;												
	END_IF;	
	_NhDevRef(xR  := xDev);
END_FUNCTION


FUNCTION _Nh_GAT {HIDDEN} :BOOL
	VAR_INPUT
   	c		: USINT;
	END_VAR
	_Nh_GAT := _Dev_INI(c := c);
	FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
			xGat						:= xDev;
        xGat^.me.RelayCloseOk := xGat^.hw.d[2] > 0 AND xGat^.cx.RelayClose;  			// ma samostatne rele zatvorenia
			// kontrola na koncovy spinac - open/close

			IF xGat^.cx.hwEndUse THEN                 						// pouzivat koncak
				IF xGat^.io[0].dev.c > 0 THEN                             	// mame aj adresu
					IF _NhxPt(c:=xGat^.io[0].dev.c, n:=xGat^.io[0].dev.n) THEN
						ok := REAL_TO_BOOL(xPt^.al.ou.val);						//100%=dvere su otvorene, 0% = zatvorene
						IF xGat^.cx.hwEndOpen THEN									// signal je pri otvoreni {rozopnuti spinaca} = ked su otvorene dvere
							ok	:= NOT ok;											   // potrebujem signal pri ZATVORENI
						END_IF;
						// zmena v koncovom doraze
						IF xGat^.cx.cmd > 99 THEN									// prestavuje sa programom
							;
(*
						ELSIF _Dev_TRG(trg:=ADR(xGat^.me.hwEnd), in:=ok ) THEN	// Qr - prave sa zatvorilo (Dialkovym alebo IQ)
							xGat^.cx.cmd 	:= 0;
							_Nh_GATE_CLOSE(close:=true);                    // nastavi zatvorene
						ELSIF xGat^.me.hwEnd.Qf THEN								// IQ je v klude - asi sa otvorilo dialkovym alebo sa nastavilo otvorene
							xGat^.cx.cmd 	:= 0;
							_Nh_GATE_CLOSE();                            	// nastavi otvorene
*)
						ELSIF ok AND xGat^.al.ou.val  > 0.0 THEN
							xGat^.cx.cmd 	:= 0;
							_Nh_GATE_CLOSE(close:=true);                    // nastavi zatvorene
						ELSIF ok=false AND xGat^.al.ou.val = 0.0 THEN						
							xGat^.cx.cmd 	:= 0;
							_Nh_GATE_CLOSE();                            	// nastavi otvorene
						END_IF;
					ELSE
						xGat^.io[0].dev.c := 0;
						xGat^.cx.hwEndUse	:= 0;
					END_IF;
				ELSE
					xGat^.cx.hwEndUse := false;                     		// nemame adresu, zablokuje sa pouzivanie koncaka
				END_IF;			
			END_IF;


			IF _Dev_Qx_PAR(dpa := xGat^.cf.par) THEN                       	// zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0, namapuje parameter
				pGat 	:= xPar;
				CASE xDev^.al.in.CMD OF
		 			1:  ;                                                        // z webu
		   		2:  xDev^.al.in.CMD    := 1;                                 // z WSB - jenotlacitkove
			    	3:  ;                                                        // STOP
			     	7: // ;                                                      // slider
      				xDev^.al.in.CMD 	:= 0;
						IF xGat^.cx.cmd = 0 THEN											 // musi byt klud, inak sa nic nedeje
							xGat^.cx.cmd		:= 7;	
						END_IF;
			     10: // uplne zatvorit
      				xGat^.cx.pGat  := 0.0;
			     11: // uplne otvorit
      				xGat^.cx.pGat  := 100.0;
		   	  14: // nastavit LVL podla parametra
                  xGat^.cx.pGat  := USINT_TO_REAL(pGat^.all.lvl);
						IF pGat^.all.tDelay > 0 THEN
							xGat^.al.et			:= pGat^.all.tDelay * 600;	// min -> 100ms
	                  xGat^.cx.cmd 		:= 2;
							xDev^.al.in.CMD 	:= 0;
						END_IF;
			     50:  // potvrdit otvorene
						_Nh_GATE_CLOSE(close:=false);
						xDev^.al.in.CMD := 0;
			     51:  // potvrdit zatvorene
						_Nh_GATE_CLOSE(close:=true);
						xDev^.al.in.CMD := 0;
				ELSE
						xDev^.al.in.CMD := 0;				
				END_CASE;
				IF xDev^.al.in.CMD = 0 THEN									// nic
					;
				ELSIF xDev^.cf.typ > 1 THEN									// branicka,dvere,zavora		
					_Nh_GATE_GO();		
					xGat^.cx.cmd := 103;											// u branicky pri akomkolvek CMD vysle impulz
				ELSIF xGat^.cx.cmd > 200 THEN									// prave sa pohybuje
					IF xDev^.al.in.CMD = 1 THEN
						_Nh_GATE_HW(stop:=true);								// STOP impulz na ten isty port, ktory zahajil pohyb
						xGat^.cx.run 		:= 0;                         // len zastavi
//					ELSIF xGat^.me.RelayCloseOk = false THEN				// je len jedno rele START/STOP
					ELSE
						i	:= xGat^.cx.cmd;							// zapamate si kam sa pohybuje (al.cm je volne)	
						_Nh_GATE_GO();                                	// zisti potrebny smer pohybu
						IF xGat^.cx.cmd = 0 THEN                        // je akurat nastavene, bude len stop
							xGat^.cx.cmd := 110;                         // toto asi nikdy nenastane	
							xGat^.cx.run := 0;
							xGat^.al.et  := 0;
						ELSIF	xGat^.cx.RUN = i	THEN				// buduci pohyb = aktualnemu. pokracuje sa v pohybe
							xGat^.cx.cmd := i;
							xGat^.cx.run := 0;
						ELSIF xGat^.me.RelayCloseOk = false THEN				// je len jedno rele START/STOP
							xGat^.cx.run 		:= 111;                    // zmena pohybu: najskor treba stop, potom 1sec pockat a pripadne zahajit iny smer												
						END_IF;
					END_IF;
				ELSIF xDev^.al.in.CMD = 1 THEN
					IF xGat^.cx.btn OR                               	// je HW/SW zavrete
						(	xGat^.cx.LastClose  AND                   	// alebo posledny pohyb bol zatvaranie
							xGat^.cx.yGat < 100.0)								// este nie je uplne zatvorene
							THEN 						
						IF pGat^.all.lvl < 2 THEN                           // opravi LVL otvorenia
                  	pGat^.all.lvl := 100;                             	
						END_IF;
						xGat^.cx.pGat  := USINT_TO_REAL(pGat^.all.lvl);     // nastavi LVL otvorenia z parametra
						_Nh_GATE_GO();		                    				// malo by sa otvorit
					ELSE
						xGat^.cx.pGat  := 0.0;        						// poziadavok na uplne zatvorenie
						_Nh_GATE_GO();		
					END_IF;			
				ELSE  																// lvl je nastaveny z cmd: 14,10,11
					_Nh_GATE_GO();		
				END_IF;
			ELSIF xGat^.al.trg.Qf THEN			
				IF xGat^.cx.cmd = 7 THEN	
//					pGat 				:= xPar;
					xGat^.cx.pGat  := xGat^.al.in.val;
					_Nh_GATE_GO();	
				END_IF;   	
			ELSIF aSys.Restart THEN
				;
         END_IF;
			pGat 	:= xPar;															// tu sa este raz priradi, to co sa vypocita v _Dev_Qx_PAR
			_Nh_Dev_ET(t:=3);															// vzdy sa odpocitava 100ms
			CASE xGat^.cx.cmd OF
		     0 :	// je pokoj
					xGat^.cx.run 	:= 0;						
					IF xGat^.cx.yGat = 0.0 THEN
						xGat^.al.sta := 0;
					ELSIF pGat^.gat.tCloseUnl > 0 OR pGat^.gat.tCloseLck > 0 THEN
						IF _NhxRom (nr := xGat^.cf.rom) = false THEN
							;
						ELSIF pGat^.gat.tCloseLck 	> 0 AND xRom^.me.Locked THEN
	                  xGat^.al.et 	:= USINT_TO_UINT(pGat^.gat.tCloseLck) * 600;
							xGat^.cx.cmd	:= 1;
						ELSIF pGat^.gat.tCloseUnl 		> 0 AND xRom^.me.Locked = false THEN
	                  xGat^.al.et 	:= USINT_TO_UINT(pGat^.gat.tCloseUnl) * 600;
							xGat^.cx.cmd	:= 1;
						END_IF;																			
					ELSE
				      _Nh_Sta_Rom(sta := SINT_TO_USINT(xGat^.cf.typ)+1 );    // stav do miestnosti
					END_IF;

			  1 :	// caka sa na zavretie
					IF xGat^.al.Qf THEN     										// nstavi _Nh_Dev_ET()
						xGat^.cx.pGat := 0.0;
                  _Nh_GATE_GO();													// po case sa moze zmenit pozicia, treba este raz zistit co sa ma urobit
					END_IF;
			      _Nh_Sta_Rom(sta := SINT_TO_USINT(xGat^.cf.typ)+1 );    // stav do miestnosti

			  2 :	// bezi odlozeny start
					IF xGat^.al.Qf THEN     		
                  _Nh_GATE_GO();													// po case sa moze zmenit pozicia, treba este raz zistit co sa ma urovit
//						xGat^.cx.cmd 	:= xGat^.cx.run;
					ELSIF SYSTEM_S.R_EDGE_1SEC THEN
						_NhDevRef(xR  := xDev);					
					END_IF;
		     7 :	// nastastavuje sa slider
					;
		   101 :	// impulz = otvor
					_Nh_GATE_HW(set := true);										// zaciatok impulzu vzdy zopne konkretne rele
		   102 :	// impulz = zatvor {moze byt aj ine rele ako OTVOR}
					_Nh_GATE_HW(set := true, close := true );					// zaciatok impulzu vzdy zopne konkretne rele
		   103 :	// impulz = zapni elektromagnet
//					_Nh_GATE_CLOSE();                               		// predNastavi otvorene
					_Nh_GATE_HW(door := true);										// zopne elektromagnet
               xGat^.cx.cmd	:= 203;
		   110 :	// koniec impulzu
					IF xGat^.al.Qf THEN     		
						_Nh_GATE_HW();													// skoncil impulz = vypne montor
						xGat^.cx.cmd 	:= xGat^.cx.run;					
      			END_IF;

		   111 :	// STOP impulz - pri zmene smeru
					IF xGat^.al.Qf THEN     		
						_Nh_GATE_HW();													// skoncil impulz = vypne montor
						xGat^.cx.cmd 	:= 112;					
						xGat^.al.et		:= USINT_TO_UINT(xGat^.cx.tRev);		// reverz.cas
      			END_IF;
		   112 :	// start opacneho pohybu po reverznej pauze
					IF xGat^.al.Qf THEN     		
						_Nh_GATE_GO();		                    				// malo by sa otvorit
      			END_IF;

     		201 : // otvara sa SW
					xGat^.cx.LastClose 	:= false;									// uz prve otvorenie resetne priznak zatvorenie		
					xGat^.cx.btn 			:= false;
					xGat^.cx.yGat 			:= xGat^.cx.yGat + (xGat^.me.inkr * aSys.rSec);            	
					IF xGat^.cx.yGat >= xGat^.cx.pGat THEN
						xGat^.cx.yGat 		:= xGat^.cx.pGat;
						IF xGat^.cx.yGat	= 100.0 THEN							// uplne sa OTVORILO, motor sa uz vypol sam
							xGat^.cx.cmd 	:= 0;
						ELSE
							_Nh_GATE_HW(stop := true);								// zopne nastaveny port = STOP
							xGat^.cx.run 	:= 0;						
						END_IF;					
					END_IF;
			      _Nh_Sta_Rom(sta := 7);
					_NhDevRef(xR  := xDev);

     		202 :	// zatvara sa SW
					xGat^.cx.LastClose 	:= true;
					xGat^.cx.yGat 			:= xGat^.cx.yGat - (xGat^.me.inkr * aSys.rSec);            	
					IF xGat^.cx.yGat <= xGat^.cx.pGat THEN
						xGat^.cx.yGat := xGat^.cx.pGat;
						IF xGat^.cx.yGat	= 0.0 THEN							// uplne sa zatvorilo, motor sa vypne sam
							xGat^.cx.btn   := true;                 		// priznak zatvorenia
							xGat^.cx.cmd 	:= 0;
						ELSE
							_Nh_GATE_HW(stop := true);								// zopne nastaveny port = STOP
							xGat^.cx.run 	:= 0;						
						END_IF;					
//						xGat^.me.HwEnd.Q := true;									// resetne HW snimac, aby bol Qr, Qf,
					END_IF;
			      _Nh_Sta_Rom(sta := 8);
					_NhDevRef(xR  := xDev);

		   203 :	// branicka/dvere
					IF xGat^.al.et = 0 THEN     		
						_Nh_GATE_HW(door:=true, stop:=true);					// vypne impulz
//						_Nh_GATE_CLOSE(close:=true);                      	// nastavi zatorene, ale koncovy snimac to opravi
						xGat^.cx.cmd 	:= 0;					
					ELSE
				      _Nh_Sta_Rom(sta := 7 );    								// otvara sa
      			END_IF;
		   ELSE
				   ;
		   END_CASE;
			xDev^.al.ou.val := xGat^.cx.yGat;
			xDev^.al.in.CMD := 0;
	 	END_IF;
	END_FOR;    	
END_FUNCTION







FUNCTION _Nh_VVO {HIDDEN} :BOOL
	VAR_INPUT
   	c		: USINT := 49;
	END_VAR
	_Nh_VVO := _Dev_INI(c := c);
	FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
			xVVo := xDev;
			IF _Dev_Qx_PAR(dpa := xVvo^.cf.par) THEN                       	// zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0, namapuje parameter
				// xDev^.al.cm	:= xDev^.al.in.CMD;
				CASE xDev^.al.in.CMD OF
		 			1: ;	// z webu - START/STOP                                                        // z webu
		   		2:		// z WSB - jednotlacitkove START/STOP
						xDev^.al.in.CMD    := 1;
		   	  10: // OFF
						xDev^.al.in.val := 0.0;
		   	  11: // ON
						xDev^.al.in.val := 100.0;
		   	  14: // nastavit LVL podla parametra
						xDev^.al.in.val := USINT_TO_REAL(xPar^.all.lvl);						
				ELSE
					xDev^.al.in.CMD := 0;				
				END_CASE;
			   IF xDev^.al.in.CMD = 1 THEN                                    	// prepnut WEB/WSB
		      	IF xDev^.al.ou.val > 0.0 THEN                               	// je zapnute, treba vypnut z WEB/WSB
      		   	xDev^.al.in.val   := 0.0;
			      ELSIF xDev^.al.ou.val = 0.0 THEN                            	// je vypnute, ttreba zapnut, ale v LVL bola 0
		            xDev^.al.in.val   := 100.0;                              // zapnut naplno
      		   END_IF;
      		END_IF;
			ELSIF aSys.Restart	THEN
				IF xVvo^.cf.LvlOnRst THEN
					xDev^.al.in.CMD := 254;			
				END_IF;
			END_IF;
			xLedR	:= UDINT_TO_PTR(xVvo^.hw.d[0]);
			xLedG	:= UDINT_TO_PTR(xVvo^.hw.d[1]);			
			IF _Nh_Dev_ET_UINT(et:=ADR(xDev^.al.et), t:=1) THEN
//  				xLedR^ := 0;
//				xLedG^ := 0;
			END_IF;
			IF xDev^.al.in.CMD > 0 THEN
				ok	:= REAL_TO_BOOL(xDev^.al.IN.val);
// xVvo^.cx.typ := 2;
				CASE xVvo^.cf.typ OF
              0 : xLedR^ := ok;					// len otvorit		{bez napatia ZAtvorene NC} default
              1 : xLedR^ := NOT ok;				// len zatvorit	{bez napatia OTvorene NO}
              2 : IF ok THEN						// 2x rele .d[0] = Open, d[1] Close
						  xLedR^ := 1;
						  xLedG^ := 0;
						ELSE
						  xLedR^ := 0;
						  xLedG^ := 1;
						END_IF;
				END_CASE;
				xDev^.al.et 		:= USINT_TO_UINT(xVvo^.cx.impulz);
				xDev^.al.ou.val 	:= xDev^.al.in.val;
				_NhDevRef(xR  := xDev);
			END_IF;
			xDev^.al.sta 		:= BOOL_TO_USINT(REAL_TO_BOOL(xDev^.al.ou.val));
			xDev^.al.in.CMD 	:= 0;
   	END_IF;
	END_FOR;
END_FUNCTION

(*
FUNCTION _NH_DT_TO_TIME {HIDDEN} : TIME
	VAR_INPUT
		xNhDT	: PTR_TO NH_DT;			// +4 294  295967
	END_VAR
	_NH_DT_TO_TIME := UDINT_TO_TIME( USINT_TO_UDINT(xNhDT^.sec)*1000 + USINT_TO_UDINT(xNhDT^.min)*60000 + USINT_TO_UDINT(xNhDT^.sec)*60*60000 );

END_FUNCTION
*)






VAR_GLOBAL
	outQf		: BOOL;
	outCMD	: USINT;
	outET		: UINT;
	outRND	: USINT;
END_VAR


FUNCTION _Nh_TIM_RND {HIDDEN} :BOOL
	ok2 := false;
//	_Nh_Dev_ET(t:=2);   																// odpocitava minuty
	_Nh_Dev_ET(t:=1);   																// test = sec
	CASE xTim^.al.cm  OF
  		   10:	// minim.cas zapnutia
					IF xDev^.al.Qf THEN
						xDev^.al.et 	:= xTim^.cx.RND.TimeOnMax - xTim^.cx.RND.TimeOnMin;			
						xTim^.al.cm  	:= 20;
					END_IF;
         20:	// MAX.cas zapnutia
					IF xDev^.al.Qf OR xTim^.me.rnd < 21 THEN
						outQf					:= xDev^.al.Qf;
						outET					:= xDev^.al.et;						
						outRND				:= xTim^.me.rnd;						
						xTim^.al.ou.cmd	:= 10;									// vypne
						xTim^.al.cm  		:= 30;
						xDev^.al.et			:= xTim^.cx.RND.TimeOffMin;		// nastavi min OFF
					END_IF;
     		30:	// min.cas vypnutia - tu nebude RND zasahovat
					IF xDev^.al.Qf THEN
						xDev^.al.et 	:= xTim^.cx.RND.TimeOffMax - xTim^.cx.RND.TimeOffMin;			// zostatok do MAx OFF
						xTim^.al.cm  	:= 40;
					END_IF;
     		40 : 	// MAX.cas vypnutia
					IF xDev^.al.Qf OR xTim^.me.rnd > 216 THEN
						outQf					:= xDev^.al.Qf;
						outET					:= xDev^.al.et;						
						outRND				:= xTim^.me.rnd;						
						xDev^.al.et 		:= xTim^.cx.RND.TimeOnMin;			// nastavi caz zapnutia
						xTim^.al.cm  		:= 10;
						xTim^.al.ou.cmd	:= 14;									// zapne
					END_IF;
          ELSE // nic nebezi
					xTim^.al.ou.cmd	:= 10;										// vypne
					xTim^.al.cm  		:= 30;
					xDev^.al.et			:= xTim^.cx.RND.TimeOffMin;			// nastavi min OFF
					xTim^.cx.RND.TimeOffMax := MAX(xTim^.cx.RND.TimeOffMax,xTim^.cx.RND.TimeOffMin+1);	// Max musi byt > Min
					xTim^.cx.RND.TimeOnMax  := MAX(xTim^.cx.RND.TimeOnMax ,xTim^.cx.RND.TimeOffMin+1);	// Max musi byt > Min
					ok2 := true;
   END_CASE;
	IF xTim^.al.ou.cmd > 0 THEN
		outCMD 	:= xTim^.al.ou.cmd;
//		ok2 		:= true;
	END_IF;		
	IF ok2 THEN
		RandomU(seed := _NhSeed, init:=true);
	END_IF;
	IF xTim^.cx.rnd.etRND = 0 THEN
		xTim^.cx.rnd.etRND 	:= xTim^.cx.rnd.IntGenRND;		
		xTim^.me.rnd 			:= REAL_TO_USINT( RandomU(seed := _NhSeed)  * 255 );			
	ELSIF SYSTEM_S.F_EDGE_1SEC THEN
		xTim^.cx.rnd.etRND := xTim^.cx.rnd.etRND - 1;	
	END_IF;		
END_FUNCTION

FUNCTION _Nh_TIM {HIDDEN} :BOOL
   _Nh_TIM := _Nh_Dev_INI(c := 50 );
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC(blk:=true) THEN
			xTim	:= xDev;
			xTim^.me.hour		:= SYSTEM_S.COUNTER_HOURS;
			xTim^.me.min		:= SYSTEM_S.COUNTER_MINUTES;
			xTim^.me.sec		:= SYSTEM_S.COUNTER_SECONDS;
			xTim^.me.tim		:= aSys.NhTime;			

         IF aSys.Restart THEN
				xTim^.al.cm  := 0;
         END_IF;
         

			IF xTim^.cf.typ = 6 THEN												// RND
				_Nh_TIM_RND();
			ELSIF SYSTEM_S.F_EDGE_1MIN OR aSys.Restart THEN
//			ELSIF SYSTEM_S.F_EDGE_1SEC OR aSys.Restart THEN
				i	:= 1;
				CASE xTim^.cf.typ OF
              0 : // Nacasovat
						IF xTim^.al.cm  = 10 OR xTim^.cx.WhatOut = 1 THEN 	// uz bezi vypnutie, alebo treba len vypnut
							i 					:= 2;
							xTim^.al.cm  	:= 10;
						ELSIF xTim^.cx.WhatOut = 2 THEN                       // ON-OFF
							xTim^.al.cm  	:= 20;						
						ELSE
							xTim^.al.cm  	:= 14;						            // len ON
						END_IF;						
              2 : // sunrise
						i := 3;
						IF xTim^.al.cm  = 10 THEN 										// uz je nSTAVENE vypnutie
							i 					:= 0;
						ELSIF xTim^.cx.WhatOut = 1 THEN                       	// OFF
							xTim^.al.cm  	:= 10;						
						ELSIF xTim^.cx.WhatOut = 2 THEN
							xTim^.al.cm  	:= 20;						            // len ON
						ELSIF xTim^.cx.WhatOut = 0 THEN						
							xTim^.al.cm  	:= 14;						            // len ON
						END_IF;
				  3 : // sunset - zapad	
						i := 4;
						IF xTim^.al.cm  = 10 THEN 										// uz je nSTAVENE vypnutie
							i 					:= 0;
						ELSIF xTim^.cx.WhatOut = 1 THEN                       	// OFF
							xTim^.al.cm  	:= 10;						
						ELSIF xTim^.cx.WhatOut = 2 THEN
							xTim^.al.cm  	:= 20;						            // len ON
						ELSIF xTim^.cx.WhatOut = 0 THEN						
							xTim^.al.cm  	:= 14;						            // len ON
						END_IF;
				ELSE	i := 0;

				END_CASE;
            
				CASE i OF
              1 : xTim^.cx.TimeEnd.hour 	:= xTim^.cx.TimeFrom.hour;
						xTim^.cx.TimeEnd.min 	:= xTim^.cx.TimeFrom.min;
              2 : xTim^.cx.TimeEnd.hour 	:= xTim^.cx.TimeTo.hour;
						xTim^.cx.TimeEnd.min 	:= xTim^.cx.TimeTo.min;
				  3 : // sunrise
              		xTim^.cx.TimeEnd.hour 	:= HOUR_OF_TIME(aMeteo.SunriseTime);
						xTim^.cx.TimeEnd.min 	:= MIN_OF_TIME(aMeteo.SunriseTime);

              		xTim^.cx.TimeEnd.hour 	:= 16;
						xTim^.cx.TimeEnd.min 	:= 0;


						_NH_ADD_TIME_TIME(xDTa:=ADR(xTim^.cx.TimeEnd), xDTb:=ADR(xTim^.cx.TimeFrom) );
				  4 : // sunset - zapad	
              		xTim^.cx.TimeEnd.hour 	:= HOUR_OF_TIME(aMeteo.SunSetTime);
						xTim^.cx.TimeEnd.min 	:= MIN_OF_TIME(aMeteo.SunSetTime);

              		xTim^.cx.TimeEnd.hour 	:= 16;
						xTim^.cx.TimeEnd.min 	:= 0;

						_NH_ADD_TIME_TIME(xDTa:=ADR(xTim^.cx.TimeEnd), xDTb:=ADR(xTim^.cx.TimeFrom));
				  5 : // vypnut po case

				  	
            END_CASE;
//			ELSIF SYSTEM_S.F_EDGE_1MIN OR aSys.Restart THEN
				IF SYSTEM_S.F_EDGE_1MIN    AND xTim^.cx.TimeEnd.hour = SYSTEM_S.COUNTER_HOURS AND xTim^.cx.TimeEnd.min = SYSTEM_S.COUNTER_MINUTES THEN
					CASE xTim^.al.cm  OF
					 10 : // vypnut
							xTim^.al.ou.CMD := 10;
					 14 : // zapnut
							xTim^.al.ou.CMD := 14;
					 20 : // zapnut a vypnut
							xTim^.al.ou.CMD 	:= 14;
               END_CASE;
					IF xTim^.al.ou.CMD > 0 THEN
						IF xTim^.al.cm  = 20 THEN
							IF xTim^.cf.typ > 1 AND xTim^.cf.typ < 6 THEN // pripocita k aktualnemu casu + vypnut po case
								_NH_ADD_TIME_TIME(xDTa:=ADR(xTim^.cx.TimeEnd), xDTb:=ADR(xTim^.cx.TimeTo));							
							END_IF;
							xTim^.al.cm  := 10;
						ELSE
							xTim^.al.cm  := 0;
						END_IF;
					END_IF;
				END_IF
			END_IF;
			IF xTim^.al.cm > 0 THEN
				xDev^.al.sta 		:= 1;
			ELSE
				xDev^.al.sta 		:= 0;
			END_IF;
			xDev^.al.in.CMD 	:= 0;
   	END_IF;
	END_FOR;
END_FUNCTION

FUNCTION _Nh_ALA  {HIDDEN}   : BOOL  // ukladanie hodnot do ROM a nasledne do ZON
   _Nh_ALA 				:= _NH_DEV_INI(c:=48);
   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Nh_Dev_REC() THEN
			xAla	:= xDev;														// aktualna zona
   		_NhxZon(nz:=xAla^.cf.rom);
   		IF xZon^.cx.lck.stat = SINT_TO_USINT(xAla^.cf.typ) THEN

				ok	:= true;
				CASE xZon^.al.ou.cmd OF
              60: // odomknutie - sem pride len ked sa odomknu vsetky zony
//						yTx1 := CONCAT('{',xHom^.cf.Name,'}: Odomknuté.');
						_Nh_MSG_TXT := 'Odomknuté.';
						_Nh_MSG_ALARM_ROM();
              61: // zacina zamykanie / zakodovanie;
              62: // zamknute po odchode
                  IF xZon^.cx.lck.AllLocked THEN                                 // len ked su zamknute vsetky zony, ktore maju byt zamknute
//   						yTx1 := CONCAT('{',xHom^.cf.Name,'}: Zamknuté.');
							_Nh_MSG_TXT := 'Zamknuté.';
	     					_Nh_MSG_ALARM_ROM();
                  ELSE
                     ok := false;
                  END_IF;
              63: // niekto prisiel
              64: // psik z budy von
              65: // psik steka
              66: // ALARM
//						yTx1 := CONCAT('{',xHom^.cf.Name,'}: ALARM: ');
						_Nh_MSG_TXT := '[ALARM]: ';
						_Nh_MSG_ALARM_ROM(rom:=1);

              67: // Psik zaliezol do budy
              68: // Strazenie obnovene
//						yTx1 := CONCAT('{',xHom^.cf.Name,'}: Stráženie obnovené.');
						_Nh_MSG_TXT := 'Stráženie obnovené.';
						_Nh_MSG_ALARM_ROM();
              69: // pohyb

				ELSE  ok := false;
            END_CASE;
            IF ok THEN
					xDev^.al.in.cmd := 14;				
            END_IF;
			END_IF;
         IF _Nh_Dev_Qx(in := xDev^.al.in.cmd > 0) THEN
            _NhDevRef(xR  := xDev);
				IF xDev^.al.in.cmd = 1 THEN												// ked sa akcia spusti z WEB, tiez moze blokovat PIR
					xDev^.al.wsb := true;
					IF xM^.set THEN		
//						yTx1 := CONCAT('[Test]: {',xHom^.cf.Name,'}',xDev^.cf.Name,'] ');
						_Nh_MSG_TXT := CONCAT('[Test]: ',xDev^.cf.Name,': ');
						_Nh_MSG_ALARM_ROM(rom:=0);
      			END_IF;
				END_IF;
				xDev^.al.ou.cmd := 14;				
            xDev^.al.ou.val := 0.0;                                       // pre istotu sa nuluje, aj ked by nemalo mat vplyv, lebo vDEV sa nastavi LVL z parametra
            xDev^.al.ou.par := 0;
            xDev^.al.sta 	 := 1;
            xDev^.al.et 	 := 10;										// 30  x 100ms = 3s											
         ELSIF _Nh_Dev_ET(t := 3) AND xDev^.al.Qf  THEN
         	_NhDevRef(xR  := xDev);
            xDev^.al.sta 	 := 0;
         END_IF;
         xDev^.al.in.cmd := 0;
		END_IF;
   END_FOR;
END_FUNCTION


(*
	KALIBRACIA
	- DOLU
	- web:  ikona pohybu dolu
	- WSB = stop  - nastavi poloha 100%  lam zaklopene
	- WSB = spusti phyb hore - lamely sa zacinaju otvarat
	- WSB = treba stihnut, ked sa nezacne posuvat roleta smerom hore - nastavi cas lamely
	- WSB = test lamely - stiahne uplen dolu a otvori lamely podla nastaveneho casu casu
	- WSB = pokracuje pohyb hore
						ak sa lamely uplne otvoria a neposunie sa roleta hore - je OK, mozeme dalsi klik
						ak nie, zacat odznova web-click pohyb dolu
	- WSB click = stlacit, ked sa zastavi motor
*)

FUNCTION _Nh_ROL_ForceUpDn {HIDDEN} :BOOL				// pri dialkovom ovladani nastavi opacnu polohu, aby sa zarucene presla cela draha
	IF xRol^.cx.cf.ForceUpDn THEN
		IF pRol^.rol.pRol > 0 THEN
			xRol^.cx.uRol	:= 0;
			xRol^.cx.yRol	:= 0.;
			xRol^.cx.uLam	:= 0;
			xRol^.cx.yLam	:= 0.;
		ELSe
			xRol^.cx.uRol	:= 100;
			xRol^.cx.yRol	:= 100.;
			xRol^.cx.uLam	:= 100;
			xRol^.cx.yLam	:= 100.;
		END_IF;
	END_IF;
END_FUNCTION

FUNCTION _Nh_ROL  :BOOL
	VAR_INPUT
   	c		: USINT;
	END_VAR

	_Nh_ROL := _Dev_INI(c := c);
	FOR nd := 1 TO aCfg[cf].Rec DO
//	FOR nd := 1 TO 1 DO
      IF _Nh_Dev_REC(blk:=true) THEN
			xRol						:= xDev;
			xLedR					:= UDINT_TO_PTR(xRol^.hw.d[0]);                    // Hw-Up
			xLedG					:= UDINT_TO_PTR(xRol^.hw.d[1]);                    // Hw-Dn
			IF aSys.Restart THEN
//				_NhMemSetPTR(size := USINT_TO_UINT(aCfg[cf].al), dest:= ADR(xRol^.al) );
				_Nh_ROL_Stat();
			END_IF;
			IF _Dev_Qx_PAR(dpa := xRol^.cf.par) THEN                       	// zabezpeci Qr,Q,Qf, pre prichdzjuce CMD > 0, namapuje parameter
				pRol 					:= xPar;
				//** ladenie
				xRol^.me.in 			:= xRol^.al;				
				xRol^.me.in.in.par 	:= xRol^.al.ou.par;				
				//**
				_Nh_ROL_Tst_Real();															// otestuje Real cislo, aj nastavi limity
				xRol^.cx.NextCmd 		:= 0;
				xRol^.me.Que.Yes  	:= 0;
				xRol^.cx.DelayStart  := 0;
				xRol^.cx.NextPar 		:= xRol^.al.ou.par;
				ok							:= xRol^.cx.cmd > 200 AND xRol^.cx.cmd < 203 ;								// ak je zapnuty motor, DEFAULT sa nic sa nevykona
				CASE xRol^.al.in.CMD OF
					2:	// z WSB - jednotlacitkove START/STOP
						///*** 26.5.25 - pri novej verzii sa vzdy sa do Delay dostali velke casy , tak sa z WSB nuluju
						pRol					:= xPar;
						pRol^.all.tDelay	:= 0;					
					 	_NhxPar2(cp := aCfg[cf].par , np := xRol^.cx.NextPar,x:=-1021);
   					pRol2					:= xPar2;
						pRol2^.all.tDelay	:= 0;					
						///***

						IF ok THEN
							xRol^.al.in.CMD := 3;			
						ELSIF xRol^.cx.up THEN     											// posledny pohyb hore, teraz sa ma zatiahnut na parameter
							xRol^.al.in.CMD := 14;
							xRol^.cx.Up := false;						
						ELSE
							xRol^.al.in.CMD := 10;											// je dolu, ma sa uplne vytiahnut	
							xRol^.cx.Up := true;
						END_IF;
				  23:	// z SCN - centralne START/STOP
						xRol^.cx.up			:= xRol^.al.up;	// UP: v SCN uz bolo prepnute. prvykrat nastavi rovnaky smer pre vsetky
						IF ok THEN
							xRol^.al.in.CMD := 3;			
						ELSIF xRol^.cx.up THEN     											// posledny pohyb hore, teraz sa ma zatiahnut na parameter
							xRol^.al.in.CMD := 10;											// je dolu, ma sa uplne vytiahnut	
						ELSE
							xRol^.al.in.CMD := 14;
						END_IF;
				  24:	// z SCN -  centralne naklapat lameny
						xRol^.cx.up			:= xRol^.al.up;	// UP: v SCN uz bolo prepnute. prvykrat nastavi rovnaky smer pre vsetky
			         xRol^.al.in.CMD   := 25;
				END_CASE;
				CASE xRol^.al.in.CMD OF
		 			1: // z browsu webu - START/STOP                            // z webu
						xRol^.al.wsb		:= true;
						pRol2					:= xPar;
						pRol2^.all.tDelay	:= 0;												// z webu sa ide okamzite, ziadny delay						
	
(*
					2:	// z WSB - jednotlacitkove START/STOP
						IF ok THEN
							xRol^.al.in.CMD := 3;			
						ELSIF xRol^.cx.up THEN     										// posledny pohyb hore, teraz sa ma zatiahnut na parameter
							xRol^.al.in.CMD := 14;
							xRol^.cx.Up := false;						
						ELSE
							xRol^.al.in.CMD := 10;											// je dolu, ma sa uplne vytiahnut	
							xRol^.cx.Up := true;
						END_IF;
*)
			    	3: // STOP	- ak je v pohybe
						xRol^.al.et := 1;
						ok 			:= true;
			     	7:	;// zacina slider
						ok := true;
		   	  10: ;// Lamely uplne otvorit (0%) a Rol uplne vytiahnut (0%)
//						IF ok AND xRol^.al.wsb AND xRol^.cx.Up  THEN					// pohybuje sa hore a prikaz prisiel z ovladaca			
						IF ok AND xRol^.al.wsb   THEN										// pohybuje sa a prikaz prisiel z ovladaca			
							;                                                     // urobi sa len stop
						ELSE
							pRol2	:= pRol;
							xRol^.cx.NextPar 		:= xRol^.cf.par;              	// koli oneskorenemu spuistenie sa do def.parametra presunie Delay
						 	_NhxPar(cp := aCfg[cf].par , np := xRol^.cx.NextPar,x:=-1020);
							pRol 					:= xPar;					
							pRol^.all.tDelay	:= pRol2^.all.tDelay;
							pRol^.rol.pLam 	:= 0;
							pRol^.rol.pRol 	:= 0;
							_Nh_ROL_ForceUpDn();
   						ok 			:= false;
						END_IF;

		   	  11: // Lamely uplne Zatvotit (100%) a Rol uplne zatiahnut (100%)
//						IF ok AND xRol^.al.wsb AND xRol^.cx.Up=false THEN			// pohybuje sa dolu a prikaz prisiel z ovladaca			
						IF ok AND xRol^.al.wsb  THEN			// pohybuje sa dolu a prikaz prisiel z ovladaca			
							;                                                     // urobi sa len stop
						ELSE
							pRol2	:= pRol;
							xRol^.cx.NextPar 		:= xRol^.cf.par;
						 	_NhxPar(cp := aCfg[cf].par , np := xRol^.cx.NextPar,x:=-1021);
							pRol 					:= xPar;					
							pRol^.all.tDelay	:= pRol2^.all.tDelay;
							pRol^.rol.pLam 	:= 100;
							pRol^.rol.pRol 	:= 100;
							_Nh_ROL_ForceUpDn();
							ok				:= false;
						END_IF;
		   	  13: ;// nastavit LVL podla parametra - prikaz zo slidera webu
						ok := false;
		   	  14: ;//nastavit LVL podla parametra - prikaz z SCN/ACT/BLK...
//					 	_NhxPar(cp := aCfg[cf].par , np := xRol^.cf.par,x:=-1022);
//						pRol 			:= xPar;					
   					// parameter je uz namapovany
						IF (ok AND xRol^.al.wsb) THEN										// pohybuje sa a prikaz prisiel z ovladaca			
							;
						ELSE

(*(
						IF (ok AND xRol^.al.wsb) 										// pohybuje sa a prikaz prisiel z ovladaca			
							AND 	( 	
										(xRol^.cx.Up AND pRol^.rol.pRol < 100)					// pohybuje sa hore a ziada sa hore
											OR 							
										(xRol^.cx.Up=false AND pRol^.rol.pRol > 0)        // pohybuje sa dolu a ziada sa dolu
									)	THEN	
							;                                                     // urobi sa len stop
						ELSE
*)
//							xRol^.cx.NextPar 		:= xRol^.cf.par;
							
                     _Nh_ROL_ForceUpDn();
							ok		:= false;
						END_IF;
			     25: ;// natacat lamemly UP/DN (1.tlacitko)
			     26: ;// Lamely otvorit  = 0%
			     27: ;// Lamely zaklopit = 100%
			     28: ;// Lamely do opacnej strany								// len z Webe
						IF xRol^.cx.uLam >= 95 THEN                  			// LAM zaklopena
							xRol^.al.in.CMD	:= 26;						
						ELSIF xRol^.cx.uLam <= 5 THEN                  			// LAM odklopena
							xRol^.al.in.CMD	:= 27;
						ELSIF xRol^.cx.Up THEN
							xRol^.al.in.CMD	:= 27;						
						ELSE
							xRol^.al.in.CMD	:= 26;							
						END_IF;
			     30: ;// prikaz z WSB - natacat lamely

				ELSE
					ok	:= true;
				END_CASE;

				IF xDev^.al.OU.par <> xRol^.cf.par THEN				// prisiel realny CMD
					xDev^.al.OU.par 	:= xRol^.cf.par;              //
					 _NhxPar(cp := aCfg[cf].par , np := xDev^.al.OU.par,x:=-1023);
					pRol := xPar;					
				END_IF;

				IF ok THEN														// nic sa nevykona, bezi ochrana pre vetrom
					xRol^.cx.NextPar 		:= 0;				
				ELSIF xRol^.al.in.CMD = 1 THEN							// prepnut z Webu/wsb
					xRol^.al.et := 0;									      // ak by bolo 203
					IF xRol^.cx.uRol >= 99 THEN                  	// roleta zatiahnnua
						pRol^.rol.pLam 	:= 0;										// lamely sa uplne otvoria
						pRol^.rol.pRol		:= 0;										// rolety sa uplne vytiahnu
					ELSIF xRol^.cx.uRol <= 1 THEN					   	// roleta vytiahnuta
						pRol^.rol.pLam 	:= 100;										
						pRol^.rol.pRol		:= 100;										
					ELSE
						xRol^.cx.Up := NOT xRol^.cx.Up;
						IF xRol^.cx.Up THEN
							pRol^.rol.pLam 	:= 0;									// lamely sa uplne otvoria
							pRol^.rol.pRol		:= 0;									// rolety sa uplne vytiahnu
						ELSE
							pRol^.rol.pLam 	:= 100;										
							pRol^.rol.pRol		:= 100;										
						END_IF;
					END_IF;
				ELSIF xRol^.al.in.CMD = 26 THEN							// Lamely otvorit  = 0%
					xRol^.cx.NextPar 	:= xDev^.al.OU.par;				// podhodi sa default par, do ktoreho sa zapisu LVL
					pRol^.rol.pLam 	:= 0;
					pRol^.rol.pRol 	:= xRol^.cx.uRol;
					xRol^.al.CM 		:= 30;	//25;
				ELSIF xRol^.al.in.CMD = 27	THEN							// Lamely zaklopit  = 100%
					xRol^.cx.NextPar 	:= xDev^.al.OU.par;				// podhodi sa default par, do ktoreho sa zapisu LVL
					pRol^.rol.pLam 	:= 100;
					pRol^.rol.pRol 	:= xRol^.cx.uRol;
					xRol^.al.CM 		:= 30;	//25;
				ELSIF xRol^.al.in.CMD = 25 THEN								// natocit lamely - jedno tlacitko
					xRol^.cx.NextPar 		:= 0;
					xRol^.al.CM 			:= 30;
					IF xRol^.cx.uLam <= 5 THEN                        // lamely su OTVORENE
						xRol^.cx.Up 	:= 0;                            // smer DOLU
						xRol^.cx.cmd	:= 112;
					ELSIF xRol^.cx.uLam >= 95 THEN						      // lamely su ZAKLOPENE
						xRol^.cx.Up 	:= 1;                            // smer HORE = maju sa Otvaratt
						xRol^.cx.cmd	:= 111;
					ELSIF xRol^.cx.Up THEN										// pokracuje sa rovnakym smerom az do konca
						xRol^.cx.cmd	:= 111;
					ELSE
						xRol^.cx.cmd	:= 112;	
					END_IF;
				END_IF;
				// ladenie

				IF _Nh_ROL_HW() THEN												// STOP,ak sa pohybuje  a potom podla NexPar
					_NhDevRef(xR  := xRol);
				ELSIF xRol^.cx.MotStat	>= 7 THEN							// prebieha proces zastavenie
					;				
				ELSIF xRol^.cx.NextPar > 0 THEN											//	bude sa nastavovat podla parametra					            	
					xRol^.cx.cmd 		:= 3;					
				END_IF;

				IF true THEN
					_Nh_Log_Evn_ADD(tsk:=31);
					
//							val1:= USINT_TO_STRINGF(xRol^.cx.uRol,'%3u') + '-' + USINT_TO_STRINGF(pRol^.rol.pRol,'%3u'),
//							val2:= CONCAT( USINT_TO_STRINGF(xRol^.cx.uLAm,'%3u'),'-',USINT_TO_STRINGF(pRol^.rol.pLam,'%3u') );							
				END_IF;	

				// ladenie
				xRol^.me.ou 			:= xRol^.al;				
				xRol^.me.cx 			:= xRol^.cx;					
				
			ELSIF xRol^.al.trg.Q THEN
				IF xRol^.al.CM = 25 OR xRol^.al.CM = 24 OR xRol^.al.in.CMD = 30 THEN					// pricadza z WSB/ SCN/ACT
					xRol^.al.CM := 30;
				END_IF;
			ELSIF xRol^.al.trg.Qf THEN
				xRol^.al.wsb	:= false;											// vymaze priznak CMD, ktory pochadza z HW (WSB,TGL...)		
				IF xRol^.al.CM = 7 THEN												// pustenier slider
					IF xRol^.cx.SetLam = false THEN								// slider ROL
						xRol^.cx.pRol := REAL_TO_USINT(xRol^.al.in.Val);
					ELSE
						xRol^.cx.pLam := REAL_TO_USINT(xRol^.al.in.Val);
      	   	END_IF;
					_Nh_ROL_Go_Pozi();
				ELSIF xRol^.al.CM = 30 THEN                           	// pustenie natacania lamiel, alebo samostatne tlac Up/Dn
					xRol^.al.CM 	:= 0;
				END_IF;
			END_IF;
				

			CASE xRol^.cx.cmd OF
		     0 :	// je pokoj
					xRol^.me.dDark(tOn:=5, tOf:=15);											// po ukonceni pohybu delay aby vyhodnotilo Dark 5s po zatriahnuti, 15s po vytiahnuti
					IF xRol^.me.dDark.Qr OR xRol^.me.dDark.Qf THEN	
						aSys.RefCycNeW := 1;
					END_IF;
					CASE aSys.RefCyc OF
						2:	//
							_NhxRom(c := 1, nr := xRol^.cf.rom, x:=147);
							IF xRol^.cx.cf.SetDark AND xRol^.me.dDark.Q THEN				// ak po Delay ma byt sumrak, pripocita pomer tejto rolety
								xRom^.me.DarkRolLvl := MIN(100, xRom^.me.DarkRolLvl + xRol^.cx.cf.DarkRolLvl);
   						END_IF;
         		END_CASE;


					
					// riadenie delay WindGuard			
//					xRol^.cx.dWindG();

					IF xRol^.cx.cf.WindGuardOn THEN
//						xRol^.me.dWindUp(In:=aMeteo.WindSpeedRol > xRol^.cx.cf.WindSpeedOn, 	PT:=USINT_TO_UINT(xRol^.cx.cf.WindWaitOn));					
//						xRol^.me.dWindDn(In:=aMeteo.WindSpeedRol < xRol^.cx.cf.WindSpeedOFF, PT:=USINT_TO_UINT(xRol^.cx.cf.WindWaitOff)*60);					

						xRol^.me.dWindUp(In:=aMeteo.WindSpeedRol > xRol^.cx.cf.WindSpeedOn, 	PT:=15);					
						xRol^.me.dWindDn(In:=aMeteo.WindSpeedRol < xRol^.cx.cf.WindSpeedOFF, PT:=15);					



						CASE xRol^.cx.CmdWind OF
            	     	0:	// cakanie na silny vietor
							      IF xRol^.me.dWindUp.Qr THEN
										IF xRol^.cx.cf.WindDirOnly = false														// hociaky uhol vetra	
											OR	(	aMeteo.WindSpeedRol > REAL_TO_USINT(xGlb^.cx.meteo.wind[2])  // kriticky vietor ide okamzite na vsetky uhly
											      OR (	aMeteo.WindDirMan360 >= xRol^.cx.cf.WindDirFrom              // uhol OD                  			
															AND aMeteo.WindDirMan360 <= xRol^.cx.cf.WindDirTo )          // uhol DO
	                  					)	THEN

											// pripavi sa vyfiahnutie rolety
											_NhxPar(cp := aCfg[cf].par , np := xRol^.cf.par,x:=-1024);
										   pRol				:= xPar;            								// len pre delay
											pRol^.rol.pRol		:= xRol^.cx.uRol; 							   // zapamataju sa pozicie pred startom do default parametra
											pRol^.rol.pLam		:= xRol^.cx.uLam; 							
											xRol^.cx.pLam 	:= xRol^.cx.cf.WindGuardLam;					// nastavi sa ochranna pozicia	
											xRol^.cx.pRol 	:= xRol^.cx.cf.WindGuardRol;
											xRol^.al.wsb 	:= false;
											_Nh_ROL_Go_Pozi();                                       // vytiahne sa roleta
											xRol^.cx.CmdWind 		:= 10;
											_NhDevRef(xR  := xRol);
										END_IF;
									END_IF;
						
							4:		// uplne ukoncenie sledovania rolety
									xRol^.cx.CmdWind 			:= 0;
									xRol^.cx.etHandBlkWind	:= 0;
									xRol^.me.dWindUp.rst		:= true;											// v pripade restartu zacne nove pocitanie
									xRol^.me.dWindDn.rst		:= true;

							10:	// je silny vietor, caka sa na zoslabnutie
							      IF xRol^.me.dWindDn.Qr THEN
										IF xRol^.cx.cf.WindDay.n[ xRom^.me.DayObr ] 						// v tejto dennej dobe sa nevracia roleta
											AND xRom^.me.Locked = FALSE THEN							      // len ked je odomknute
											;																			// nevrati do povodnej polohy				
										ELSE
	         			   	      xRol^.cx.NextPar			:= xRol^.cf.par;                 // hned v tomto cykle spusti pohyb rolety
											xRol^.cx.tStart 			:= UINT_TO_DT(0);							
											xRol^.cx.DelayStart  	:= true;
										END_IF;
										xRol^.cx.CmdWind 		:= 4;                                  // ukonci korektne
										_NhDevRef(xR  := xRol);
  									END_IF;

							20:	// bezi rucne blokovanie pri silnom vetre
//								xRol^.cx.etHandBlkWind := xRol^.cx.etHandBlkWind - aSys.u1Min;
								xRol^.cx.etHandBlkWind := xRol^.cx.etHandBlkWind - aSys.u1Sec;
								IF xRol^.cx.etHandBlkWind	= 0 THEN
									xRol^.cx.CmdWind 		:= 4;
								END_IF;
								_NhDevRef(xR  := xRol);	
						ELSE
								xRol^.cx.CmdWind 		:= 4;
         	      END_CASE;
					ELSE
	               xRol^.cx.CmdWind	:= 0;
					END_IF;
					// vykonat prikazaz
					IF xRol^.cx.DelayStart THEN
						IF aSys.NhDT >=  xRol^.cx.tStart  THEN													// mo
							_NhxPar(cp := aCfg[cf].par , np := xRol^.cx.NextPar,x:=-1025);
				   		pRol						:= xPar;
							xRol^.cx.pLam 			:= pRol^.rol.pLam;
							xRol^.cx.pRol 			:= pRol^.rol.pRol;
							xRol^.cx.DelayStart 	:= false;
							xRol^.cx.NextPar		:= 0;
							_Nh_ROL_Go_Pozi();	
							
						xRol^.al.Up := xRol^.cx.up;
																		// ziadny pohyb, nastavia sa poziadavky
						END_IF;
					END_IF;


		     3 :	// STOP + reverse delay
					IF _Nh_Dev_ET() THEN
						IF xRol^.cx.NextPar > 0 THEN											//	bude sa nastavovat podla parametra
							xRol^.cx.DelayStart  := true;
							_NhxPar(cp := aCfg[cf].par , np := xRol^.cx.NextPar,x:=-1026);   // len pre zistenie delay
						   pRol						:= xPar;            					
							IF pRol^.all.tDelay = 0 THEN
	                     xRol^.cx.tStart 		:= UINT_TO_DT(0);						// nastavi DT spustenia, ked delay=0, spsti sa v nasl.cykle
								xRol^.cx.cmd			:= 0;                            // okamzite ide
							ELSE
	                     xRol^.cx.tStart 		:= ADD_DT_TIME(aSys.NhDT , (UINT_TO_TIME(pRol^.all.tDelay)) * 1000 );	// nastavi DT spostenia, ,ked delay=0, spsti sa v nasl.cykle
								xRol^.cx.cmd			:= 1;                            // nastavi stat a pojde cakat za casom
							END_IF;
						ELSIF xRol^.me.Que.Yes THEN											//	preberie sa poziacia z fronty
							xRol^.cx.pLam 		:= xRol^.me.Que.pLam;
							xRol^.cx.pRol 		:= xRol^.cx.uRol;								// v druhom kroku sa mozu uz pohybovat len LAM, tak roleta sa ma vyrovnat
//							xRol^.cx.pRol 		:= xRol^.me.Que.pRol;
							xRol^.me.Que.Yes	:= false;
							xRol^.al.Qf			:= xRol^.cx.UP;								// zapamata sa hlavny pohyb, ktory ma zostat aj po korekcii
							_Nh_ROL_Go_Pozi();													// ziadny pohyb, nastavia sa poziadavky							
                     xRol^.cx.UP 		:= xRol^.al.Qf;								// obnovi sa hlavny pohyb (lamely sa pravdepodobne vracali do pozicie)
						ELSIF xRol^.cx.NextCmd = 0 THEN
							xRol^.cx.cmd := 1;
						ELSE
							xRol^.cx.cmd := xRol^.cx.NextCmd;
						END_IF;
					ELSIF	xRol^.al.et > 10000 THEN											// ak je prilis velky cas, skrati ho a ukonci
						xRol^.al.et := 1000;
					END_IF;		

		   111 :	// drzim tlacitko Lamely Up:
					IF _Nh_ROL_Lam_UpDn(Up:=true) THEN
						_Nh_ROL_Go_Pozi();														
					ELSE
						xRol^.cx.cmd 	:= 1;
					END_IF;

		   112 :	// drzim tlacitko Lamely Dn:
					IF _Nh_ROL_Lam_UpDn() THEN
						_Nh_ROL_Go_Pozi();													
					ELSE
						xRol^.cx.cmd 	:= 1;
					END_IF;


     		201 : // HORE 100%->0% : OTVORIT lamely na 100->0% + VYTIAHNUT 100->0%
					IF _Nh_ROL_200_Begin() THEN
						IF xRol^.al.sta	= 3 THEN																	// skusi lamely						
							IF xRol^.me.iLam > 0.0 THEN										   				// pri pohybe DOLU sa najskor ZATVORIA lamely na 0%
								vr 				:= xRol^.me.tToBegin * xRol^.me.iLam;                 // ak je MotStat - 0, xRol^.me.tToBegin :=0, vr := 0
								xRol^.cx.yLam	:= xRol^.me.yLamOld - xRol^.me.tRun* xRol^.me.iLam;	// od poslednej pozicii odpocita celkovy cas * % posunu za 1mS
                        xRol^.cx.uLam	:= REAL_TO_USINT(MAX(0.0,xRol^.cx.yLam - vr));        // akt.pozicia aj s odhadom do konca cyklu
								IF xRol^.cx.yLam   <= 0.0 THEN													// kontrola na koncovy doraz
                        	_Nh_ROL_Go_Rol(sta:=4);
								ELSIF xRol^.cx.uLam  <= xRol^.cx.pLam THEN									// Lamela dosihla alebo presvihla poziadavku
									IF xRol^.al.cm = 30 THEN													// lamely sa posuvaju po poziciach
										cmd					:= 203;	//30;		
										xRol^.cx.NextCmd	:= 111;
									ELSIF xRol^.cx.uRol = xRol^.cx.pRol THEN								// roleta sa neposuva
										cmd := 203;                                                 // STOP + vratit sa sem a dopocitat posun do konca cyklu a ukoncit
									ELSE                                                          	// presunut na roletu aj datum aj zbytok posunu po LAM
                        		_Nh_ROL_Go_Rol(sta:=4);
 									END_IF;
								END_IF;
							ELSE
								xRol^.al.sta	:= 4;						
							END_IF;					
						END_IF;
						// roleta
						IF xRol^.al.sta	= 4 THEN													
							vr 			  := xRol^.me.tToBegin * xRol^.me.iRol;                 // ak je MotStat - 0, xRol^.me.tToBegin :=0, vr := 0
							xRol^.cx.yRol := xRol^.me.yRolOld - xRol^.me.tRun * xRol^.me.iRol;	// kolko sa preslo celkovo		
                     xRol^.cx.uRol := REAL_TO_USINT( MAX(0.0,xRol^.cx.yRol - vr) );
							IF xRol^.cx.yRol <= 0.0 THEN														// ROL ja uple HORE
  								cmd := 203;
							ELSIF xRol^.cx.uRol <= xRol^.cx.pRol THEN										
  								cmd := 203;
							END_IF;
						END_IF;
						_Nh_ROL_200_End();   			
					END_IF;

     		202 : // DOLU : 1. ZAKLOPIT lamely na 0->100% + ZATIAHNUT 0->100%
					IF _Nh_ROL_200_Begin() THEN
						IF xRol^.al.sta	= 5 THEN																// skusi lamely						
							// v	tRun je skutocny cas + odhad kolko asi este prejde do konca tohto cyklu	
							IF xRol^.me.iLam < 100.0 THEN										   				// pri pohybe hore sa najskor otvoria lamely na 100%
								vr 				:= xRol^.me.tToBegin * xRol^.me.iLam;                 // ak je MotStat - 0, xRol^.me.tToBegin :=0, vr := 0
								xRol^.cx.yLam	:= xRol^.me.yLamOld + xRol^.me.tRun * xRol^.me.iLam;	// k poslednej pozicii pripocita celkovy cas * % posunu za 1mS
								xRol^.cx.uLam  := REAL_TO_USINT(xRol^.cx.yLam + vr);						// akt.pozicia aj s odhadom do konca cyklu
								IF xRol^.cx.uLam   >= 100 THEN													// kontrola na koncovy doraz
                        	_Nh_ROL_Go_Rol(sta:=6);
								ELSIF xRol^.cx.uLam >= xRol^.cx.pLam THEN											// Lamela dosihla alebo presvihla poziadavku
									IF xRol^.al.cm = 30 THEN														// lamely sa posuvaju po poziciach
										cmd					:= 203;	//30;		
										xRol^.cx.NextCmd	:= 112;
									ELSIF xRol^.cx.uRol = xRol^.cx.pRol THEN									// roleta sa neposuva
										cmd := 203;                                                    // STOP + vratit sa sem a dopocitat posun do konca cyklu a ukoncit
									ELSE                                                          		// presunut na roletu aj datum aj zbytok posunu po LAM
                        		_Nh_ROL_Go_Rol(sta:=6);
									END_IF;
								END_IF;
							ELSE
								xRol^.al.sta	:= 6;						
							END_IF;					
						END_IF;
						// roleta
						IF xRol^.al.sta	= 6 THEN													
							vr 			  	:= xRol^.me.tToBegin * xRol^.me.iRol;
							xRol^.cx.yRol	:= xRol^.me.yRolOld + xRol^.me.tRun * xRol^.me.iRol;			// kolko sa preslo celkovo		
                     xRol^.cx.uRol 	:= REAL_TO_USINT(xRol^.cx.yRol + vr );
							// ak je BLI povytiahnuta, musia byt uplne otvorene lamely, ktore sa otvoria ako prerve	
							IF xRol^.cx.yRol >= 100.0 THEN														// ROL ja uple hore, alebo vyssie
								cmd := 203;        															      // vyskocit rovno do kalibracie
							ELSIF xRol^.cx.uRol  >= xRol^.cx.pRol THEN										
								cmd := 203;        															      // vyskocit rovno do kalibracie
							END_IF;
						END_IF;
						_Nh_ROL_200_End();   			
					END_IF;

     		203 : // dobeh v hranicnej polohe
					IF _Nh_Dev_ET() THEN     											// motor ide, caka sa na dobeh
						_Nh_ROL_HW();                                       	
						xRol^.cx.MotStat 	:= 0;	                         		// tot uz nie je potrebne
						xRol^.al.et 		:= USINT_TO_UINT(xRol^.cx.cf.tDelayRev) * 100; // nastavi sa delay
						xRol^.cx.cmd		:= 3;	                              // pojde do cakacky
					END_IF;		

		     1 :	// jeden cyklus pred pokojom
					xRol^.cx.NextCmd	:= 0;		
               xRol^.cx.cmd  		:= 0;
               xRol^.cx.MotStat 	:= 0;
					_Nh_ROL_Stat();

		     7 :	// nastavuje sa slider
					;

		   END_CASE;

			xRol^.me.RtcStamp	:= _NhDT;                                				// strojovy cas tejto ulohy - pre zistenie casu do dalsieho cyklu
  	   	_Nh_Sta_Rom(sta := xRol^.al.sta );    								// otvara sa
			xRol^.al.in.CMD := 0;
	 	END_IF;
	END_FOR;    	
END_FUNCTION


(*
VAR_GLOBAL
	k0 	:	UDINT;
	k1 	:	UDINT;
	kCM	:	UDINT;
	kcf 	:	UDINT;
	kd0 	:	UDINT;
	kQ	 	:	UDINT;
	kWh2	:	UDINT;

	kdum1	:	UDINT;
	kRo	:	UDINT;
	kRo2	:	UDINT;


END_VAR
*)






FUNCTION	_NhDevControl  {HIDDEN}  : BOOL
	memsetEx(val := 0, length := aSys.sRoW + aSys.sZoW, dest := VOID(mRam[ aSys.aRoW1 ]));     // resetne sa stavovy subor vsetkych CAT,DEV...
	xHoW^.chg	:= aSys.RefCyc = 1;						// aby sa vymazali  OWN v rom



   _Nh_DOR(c:=33);                                 // DOR
   _Nh_DOR(c:=34);                                 // WIN
   _Nh_TER(c:=16);                                 // teplota ROM
   _Nh_TER(c:=17);                                 // teplota radiator-HET
   _Nh_TER(c:=18);                                 // teplota Kotol
   _Nh_LUX(c:=19);                                 // LUX
   _Nh_LUX(c:=41);                                 // CO2,CO
   _Nh_LUX(c:=51);                                 // RHX
   _Nh_PIR();

   _Nh_WSB();                                 // WSB
   _Nh_TLA();                                 // TLA
   _Nh_TGL();                                 // TouchGlass
//   _Nh_TG2();                                 // TouchGlass TG1+TG2



   _Nh_KEY();
   _Nh_TIM();

   // aktualizacie vstupov sa prenesu na vystupy (aj vazby k HET,ROM)

   _Nh_IO2();                                      // prejde vazby WSB->DEV

   _Nh_BLK();
   _Nh_ACT();													// XXX->ACT
	_Nh_ALA();                                      // ROM->ALA

   _Nh_IO4();                                      // prejde ACT,ALA,BLK->DEV/SCN/DLg


 	_Nh_SCN();  	    										// XXX->SCN	
	_Nh_IO3();                                      // prejde SCN->DEV/DLg


	
//	_Nh_MSG(c:=46);											// spravy



	_Nh_TVE(c:=8);    // TVE
  	_Nh_TVE(c:=9);    // CER
  	_Nh_TVE(c:=7);    // KOT
  	_Nh_TVE(c:=23);   //VEN..REKUP

   // regulatory az za TVE,CER,KOT,VEN...., lebo TVE musi najskor resetnut poziadavku a HET ju prepisuje ako MAX
   _Nh_HET(c:=47);		// HEV - vetranie
	_Nh_HET(c:=6);			// HET




	_Nh_SVX(c:=10);      // SVD
   _Nh_SVX(c:=11);      // SVA
   _Nh_SVX(c:=12);		// RGB
   _Nh_SVX(c:=21);		// ZAS
   _Nh_SVX(c:=32);   	// SIR

   _Nh_VVO(c:=49);   	// VVO

   _Nh_GAT(c:=37); 	// GAR/BRA/BRAnicka


	{$IFDEF __NH_DALI}
	   _Nh_DALI();
   {$END_IF}



//   _Nh_ROL(c:=30);  		// MAR
   _Nh_ROL(c:=31);  		// ROLETY

 	_Nh_ZON();											//// 2.6.24 sa ZON prehodilo pre ROM
 	_Nh_ROM();




	{ $IFDEF __NH_METEO_IQWS_4000 }
//	    chanCode         : uint 				:= ETH1_UNI1;  					(*kód kanálu ANY_UNI nebo ETH1_uni0, ETH1_uni1,... (TCP Client, 512 IN, 512 OUT)*)
//	    ipIQWS           : string [16]		:='192.168.3.100'; 	(*IP adresa anemometru IQWS 4000*)

//      IF aMeteo.Manual = false THEN
			fbMeteo( 	// chanCode 	:= chanCode,
						chanCode 	:= ANY_UNI,
 						ipIQWS   	:= _NhipIQWS,
				  		weatherInfo := aMeteo.station);
		aMeteo.err		:= fbMeteo.err;
			// prepocet : osvetlenie [lx] := slnecne ziarenie * 126.7
      aMeteo.WindSpeed_F(in	:=	aMeteo.station.windspeed, hys :=0.5	);
      aMeteo.sPower_F	(in	:=	aMeteo.station.spower	);             // filter LUX
		IF fbMeteo.newData OR aMeteo.newData THEN
			aMeteo.newData			:= false;														// len z webu
			IF xGlb^.cx.meteo.Manual = false THEN
				aMeteo.WindDirMan360 	:= REAL_TO_UINT(aMeteo.station.wdird);	
				aMeteo.WindSpeedMan 		:= aMeteo.WindSpeed_F.Out;	
				aMeteo.spowerMan			:= aMeteo.sPower_F.Out;
			END_IF;

			// vypocita sa sumrak do generovanej premennej z Meteostanice                                                                                                                  		
			aMeteo.sPower_F.fil := UINT_TO_REAL(xGlb^.cx.meteo.FilsPower);
			IF aMeteo.spowerMan <= 1. THEN
				aMeteo.sPower_F.fil := UINT_TO_REAL(xGlb^.cx.meteo.FilsPower)/10.;
				aMeteo.sPower_F.hys := 0.;
				LUX_MTS_1  := aMeteo.spowerMan * 10. ;                            	// [0.1..1] => 1..10
			ELSIF aMeteo.spowerMan >= 100. THEN
				aMeteo.sPower_F.hys := 3.;
				LUX_MTS_1  := aMeteo.spowerMan + 10 - FLOOR(aMeteo.spowerMan/10.);    // moj koeficient zisteny z excelu pokusne
			ELSE
				LUX_MTS_1  := aMeteo.spowerMan +  9 - FLOOR(aMeteo.spowerMan/10.);    // moj koeficient zisteny z excelu pokusne
				aMeteo.sPower_F.hys := 0.9;
			END_IF;							
         aMeteo.WindSpeed_F.fil	:= UINT_TO_REAL(xGlb^.cx.meteo.FilWindSpeed);	// filter pre vietor
			// do dashboardu sa prenesu hodnoty vzdy namerane, nie manual	
			aMeteo.idx[0].val	:= aMeteo.station.windspeed;
				aMeteo.idx[0].v1	:= aMeteo.station.windgust;									// Nárazová(maximalna) rychlost vetru v metrech za sekundu
				aMeteo.idx[0].v2	:= MAX(aMeteo.idx[0].v2 , aMeteo.idx[0].val);
			aMeteo.idx[1].val	:= aMeteo.station.pressure;
				aMeteo.idx[1].v1	:= MIN(aMeteo.idx[1].v1,aMeteo.station.pressure);
				aMeteo.idx[1].v2	:= MAX(aMeteo.idx[1].v2,aMeteo.station.pressure);
			aMeteo.idx[2].val	:= aMeteo.station.temperature;
				aMeteo.idx[2].v1	:= MIN(aMeteo.idx[2].v1,aMeteo.station.temperature);
				aMeteo.idx[2].v2	:= MAX(aMeteo.idx[2].v2,aMeteo.station.temperature);
			aMeteo.idx[3].val	:= aMeteo.station.windChill;
				aMeteo.idx[3].v1	:= MIN(aMeteo.idx[3].v1,aMeteo.station.windChill);
				aMeteo.idx[3].v2	:= MAX(aMeteo.idx[3].v2,aMeteo.station.windChill);
			aMeteo.idx[4].val	:= aMeteo.station.relhumidity;
				aMeteo.idx[4].v1	:= MIN(aMeteo.idx[4].v1,aMeteo.station.relhumidity);
				aMeteo.idx[4].v2	:= MAX(aMeteo.idx[4].v2,aMeteo.station.relhumidity);
			aMeteo.idx[5].val	:= aMeteo.station.abshumidity;									 	
				aMeteo.idx[5].v1	:= MIN(aMeteo.idx[5].v1,aMeteo.station.abshumidity);
				aMeteo.idx[5].v2	:= MAX(aMeteo.idx[5].v2,aMeteo.station.abshumidity);

			aMeteo.idx[6].val	:= aMeteo.station.spower;									 				// sPower: realna filtrovana hodnota z meteostanice
				aMeteo.idx[6].v1	:= MIN(aMeteo.idx[6].v1,aMeteo.idx[6].val);
				aMeteo.idx[6].v2	:= MAX(aMeteo.idx[6].v2,aMeteo.idx[6].val);

(*
			aMeteo.idx[6].val	:= aMeteo.station.spower;									 	
				aMeteo.idx[6].v1	:= MIN(aMeteo.idx[6].v1,aMeteo.station.spower);
				aMeteo.idx[6].v2	:= MAX(aMeteo.idx[6].v2,aMeteo.station.spower);
*)
			aMeteo.idx[7].val	:= aMeteo.station.sdist;									 	
			xHom^.ok.ref := true;
		END_IF;	

		aMeteo.rr := ROUND(aMeteo.WindSpeed_F.New);

			IF xGlb^.cx.meteo.SendToBlind THEN
				aMeteo.WindSpeedRol := REAL_TO_USINT( CEIL(aMeteo.WindSpeed_F.Out) );
   		END_IF;

		
	{ $END_IF}


//	_Nh_Qx2( trg:=ADR(aSys.rst));
//	aSys.rst.In	:= false;
//	aSys.rst();
//	aSys.rst.in	:= false;

(*
	CASE aSys.RefLvl OF
     0 : IF SYSTEM_S.F_EDGE_1MIN  THEN
				aSys.RefLvl := 1;							// vynuluju sa vazby own
			END_IF;
     1 : aSys.RefLvl := 2;                     	// nacitaju sa nove hodnoty zo snimacov a zapisu sa do do DEV, aj sa obnovia vaby
     2 : aSys.RefLvl := 3;                     	// v dalsom cykle sa aktualizuju zony
   ELSE  aSys.RefLvl := 0;
         xHom^.ok.ref   := true;       // zabezpeci refresh aktivnych vsetkych browsov
   END_CASE;
*)



END_FUNCTION









