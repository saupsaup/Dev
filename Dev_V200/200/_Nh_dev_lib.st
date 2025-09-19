


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
(*
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

