{ $ IFDEF __NH_WEB }
FUNCTION _Nh_Frm_Row_O13 {HIDDEN}  : BOOL
   VAR_INPUT
		off	: BOOL;
      adm   : BOOL;
		nTch	: BOOL;
      ob    : USINT;
      vb    : UDINT;
		t     : SINT := -1;	
   END_VAR
   _Nh_Frm_Row_O13  := true;
   IF off OR (adm AND xA^.usr <> 1) THEN
      xR^.o.ob[ob].wh := 0;
      RETURN;
	ELSE
      xR^.o.ob[ob].wh := 13;	
   END_IF;
   ix       := xR^.o.ob[ob].fn;
   xS       := ADR( xB^.s[ ix  ]);
   IF t > -1 THEN
		xS^.t := SINT_TO_USINT(t);
   END_IF;
	xR^.o.ob[ob].nTch	:= nTch;
   IF xR^.h.chk THEN
	   xR^.o.ob[ob].BgC  := 8;                                                 // pri vazbach je zelena ciara
	END_IF;
   IF vb > 0 THEN                                                 // priamo zadana adresa
		xPtD := UDINT_TO_PTR(vb);
   ELSIF xR^.h.chk THEN
      IF xR^.h.in THEN                                            // ak je riadok in DEV CFG je v [4]
         xR^.o.ob[ob].cf := xR^.o.ob[4].cf;
      ELSE
         xR^.o.ob[ob].cf := xR^.h.cf;                             // CFG je v hlavicke
      END_IF;
      IF xR^.o.ob[ob].cf.p > 0 THEN
         _NhxPar(cp := aCfg[xR^.o.ob[ob].cf.c].par, np := xR^.o.ob[ob].cf.p ,x:=249);             // xDev,xCfg,xPar pre aktualny riadok
         xPtD     := ADR(xPar^.all.lvl);
         xS^.t             := 1;                                                 // usint
         xR^.o.ob[ob].BgC  := 8;                                                 // pri vazbach je zelena ciara
      ELSE                                                                       // ak nema parameter - vacsinou je to pri TER,TEH..
         xPtD     := ADR(xDev^.al.in.Val);
         xS^.t             := 0;
         xR^.o.ob[ob].BgC  := 2;                                                 // zostane siva
      END_IF;
      xR^.o.ob[ob].h    := _Nh_O12(xL^.vis OR aCfg[xR^.h.cf.c].ou=false,7,0);
   ELSE
      xPtD      			:= ADR(xDev^.al.in.Val);
      xR^.o.ob[ob].h    := _Nh_O12(xL^.vis,7,0);
   END_IF;
   xS^.vb := PTR_TO_UDINT(xPtD);
(*
	IF aCfg[xR^.h.cf.c].lvl254 THEN
		xS^.v2 := 254.0;
	END_IF;
*)
END_FUNCTION

FUNCTION _Nh_SHV_INFO  {HIDDEN} : BOOL
   VAR_INPUT
      o     : USINT;
		wh		: USINT := 6;
   END_VAR
	_Nh_SHV_INFO	:= true;
	IF xA^.usr <> 1 THEN
		xR^.o.ob[o].wh := 0;
	ELSE
		xR^.o.ob[o].wh := wh;
      xR^.o.ob[o].fmt := CONCAT( USINT_TO_STRING(aCfg[xF^.cf.c].par),'/',INT_TO_STRING(xF^.cf.p)) ;
	END_IF;
END_FUNCTION

FUNCTION _Nh_DEF_VAR  {HIDDEN} : BOOL
   VAR_INPUT
		off	: BOOL;
		adm	: BOOL;
		wh		: USINT;
      r     : SINT := -1;
      o     : USINT;
      x     : PTR_TO USINT;
   END_VAR
	_Nh_DEF_VAR	:= true;
	IF off  OR (adm AND xA^.usr <> 1) THEN
		xR^.o.ob[o].wh := 0;
	ELSIF wh > 0 THEN
		xR^.o.ob[o].wh := wh;
	END_IF;
   IF r < 0 THEN
      xPtD  := ADR( xR^.o.ob[o].cf.n) ;
   ELSE
      xPtD  := ADR( xB^.r[r].o.ob[o].cf.n) ;
   END_IF;
   xPtD^ := PTR_TO_UDINT( x )  ;
END_FUNCTION

FUNCTION _Nh_DEF_SLD {HIDDEN} : BOOL
   VAR_INPUT
		off	: BOOL;
		adm	: BOOL;	
		o		: SINT := -1;
      s  	: USINT;
      v  	: PTR_TO USINT;
   END_VAR
	_Nh_DEF_SLD	:= true;
	IF o > -1 THEN
		IF off  OR (adm AND xA^.usr <> 1)  THEN
			xR^.o.ob[o].wh := 0;
		ELSE
			xR^.o.ob[o].wh := 13;
		END_IF;
	END_IF;
   xPtD  := ADR(xB^.s[ s ].vb);
   xPtD^ := PTR_TO_UDINT(v);
END_FUNCTION


FUNCTION _Nh_YYMMDD {HIDDEN} : BOOL
   VAR_INPUT
		xYear	: PTR_TO USINT;
		row	: USINT;
   END_VAR
	_Nh_YYMMDD	:= true;
	xR	:= ADR(xB^.r[row]);
	FOR i:=1  TO 6 DO
		xPtD 	:= ADR(xR^.o.ob[i].cf.n);
		xPtD^ := PTR_TO_UDINT(xYear);
		xYear := xYear + 1;
  	END_FOR;
END_FUNCTION


FUNCTION _Nh_DEF_TIM {HIDDEN} : BOOL
   VAR_INPUT
		lock	: USINT := 9;
		day	: USINT := 10;
		week	: USINT ;				// riadok kde je pole typovych dni
		rFrom	: USINT;
		rTo	: USINT;
   END_VAR
	_Nh_DEF_TIM	:= true;
	xR	:= ADR(xB^.r[1]);
  	_Nh_DEF_VAR(o:=lock, x:=ADR(xTim^.cx.rnd.LockDark[0]), off:=lock=0);			 	
	_Nh_DEF_VAR(o:=day, x:=ADR(xTim^.cx.rnd.PartOfDay[0]), off:=day=0);			 	
	If week > 0 THEN
		xR	:= ADR(xB^.r[week]);
  		_Nh_DEF_VAR(o:=0, x:=ADR(xTim^.cx.rnd.DayOfWeek[0]) );			 	
	END_IF;
	IF rFrom > 0 THEN
		_Nh_YYMMDD(row:=rFrom, xYear:=ADR(xTim^.cx.TimeFrom.year));
	END_IF;
	IF rTo > 0 THEN
		_Nh_YYMMDD(row:=rTo, xYear:=ADR(xTim^.cx.TimeTo.year));
	END_IF;
END_FUNCTION

FUNCTION _NH_Frm_SCR_72_CHG {HIDDEN} :	BOOL
	VAR_INPUT
		chg	: BOOL;
	END_VAR
	_NH_Frm_SCR_72_CHG := chg;
	xTim^.cf.Typ := LIMIT(1,xTim^.cf.Typ,6);
	IF chg THEN
		xTim^.al.cm := 0;
		IF xTim^.me.TypOld <> xTim^.cf.Typ THEN
			xTim^.cx.WhatOut := 0;
			xTim^.cx.TimeFrom.hour 	:= SYSTEM_S.COUNTER_HOURS;
			xTim^.cx.TimeFrom.min 	:= SYSTEM_S.COUNTER_MINUTES;
			xTim^.cx.TimeTo.hour 	:= SYSTEM_S.COUNTER_HOURS;
			xTim^.cx.TimeTo.min 		:= SYSTEM_S.COUNTER_MINUTES;

			xTim^.cx.rnd.TimeOffMin := 0;
			xTim^.cx.rnd.TimeOffMax := 0;
			IF  xTim^.cf.Typ = 1 THEN
           	xTim^.cx.rnd.TimeOffMin := 60;
				xTim^.cx.rnd.TimeOffMax := 60;
			ELSIF xTim^.cf.Typ = 6 THEN
				xTim^.cx.rnd.IntGenRND  := 60;
			  	xTim^.cx.rnd.TimeOffMin := 5;
				xTim^.cx.rnd.TimeOffMax := 30;
			  	xTim^.cx.rnd.TimeOffMin := 60;
				xTim^.cx.rnd.TimeOffMax := 150;
			ELSIF xU^.n > 3 THEN
				xTim^.cx.TimeFrom.hour 	:= 0;
				xTim^.cx.TimeFrom.min 	:= 0;
				xTim^.cx.TimeTo.hour 	:= 0;
				xTim^.cx.TimeTo.min 		:= 0;
         END_IF;
		END_IF;
		xTim^.me.TypOld	:= xTim^.cf.Typ;
	END_IF;

	xOh^.Qs			:= 0;
	xOh2^.Qs			:= 0;
	xOh^.Qr			:= 0;
	xOh2^.Qr			:= 0;
END_FUNCTION

FUNCTION _NH_Frm_SCR_72 {HIDDEN} :	BOOL
	VAR_INPUT
		ini	: BOOL;
	END_VAR
	_NH_Frm_SCR_72 := true;
			xTim 			:= xDev;
         xOh         := ADR(xR^.o.ob[0]);			  						
         xOh2        := ADR(xR^.o.ob[2]);			  						
			IF ini  THEN
//				xTim^.cx.RND.DayOfWeek[0] := 0;											// toto sa riadi v browse cf.c:=0,      len pre istotu, abuy sa oznacovali vsetky
				xOh^.aVar   := PTR_TO_UDINT(ADR(xTim^.cf.Typ));          		// typ casovaca
				xOh2^.aVar  := PTR_TO_UDINT(ADR(xTim^.cx.WhatOut));          	// typ casovaca

	      	_Nh_DEF_SLD(s:=2, v:=ADR(xTim^.cx.rnd.TimeOffMin));			
	      	_Nh_DEF_SLD(s:=3, v:=ADR(xTim^.cx.rnd.TimeOffMax));			

				_Nh_DEF_TIM(week:=2, lock:=9, day:=10, rFrom:=3, rTo:=4);  							
				xOh^.Qr 	:= true;
				xOh2^.Qr := true;
			END_IF;
			IF _NH_Frm_SCR_72_CHG(chg:=xOh^.Qr OR xOh2^.Qr) THEN
				i					:= 20;
				ii					:= 20;
			  	vi 				:= 13;      		// slider 1
			  	vo 				:= 13;      	// slider 2
				xOh2^.btn		:= 0;					// zobrazit On/OFF/on+off
				CASE xTim^.cf.Typ OF
              0 :	// Nacasovat		
					  	vi 	:= 0;
					  	vo 	:= 0;
              1 :	;// Cyklus	
//						ok1	:= 0;
//						ok2	:= 0;
              2 :	;// Sunsise
//					  	vi 	:= 13;
//					  	vo 	:= 13;
              3 :	;// Sunset
//				  		vi := 13;
              4 :	;// Twilight
//				  		vi := 13;
              5 :	;// svetlo
//				  		vi := 13;
            END_CASE;

				CASE xTim^.cx.WhatOut OF				// ovplyvnuje zobrazenie OD-Do
              0 : ok1 	:= 0;
            		ok2	:= 1;
              1 : ok1 	:= 1;
            		ok2	:= 0;
            ELSE	ok1 	:= 0;
            		ok2	:= 0;
            END_CASE;
				CASE xU^.n OF
      	     4 : xOh^.cf.rw1 := 3;
				  		xOh^.cf.rw2 := 4;
//	         		xB^.r[1].o.ob[10].wh := 0;											// nezobrazi DayMode
						ok3 := xTim^.cf.typ < 2 OR xTim^.cf.typ > 3;
	           5 : xOh^.cf.rw1 := 5;
				  		xOh^.cf.rw2 := 6;
//	   	      	xB^.r[1].o.ob[9].cf.c := 1;										// nezobrazi sviecku, len lock
						ok3 := xTim^.cf.typ < 4 OR xTim^.cf.typ > 5;
	         ELSE  xOh^.cf.rw1 := 1;
				  		xOh^.cf.rw2 := 2;
						ok3 := xTim^.cf.typ > 1;
         	END_CASE;
				IF xU^.n > 3 THEN
		        	xB^.r[3].o.ob[9].cf.n := 115;									// text 'Vykonat s opozdenim'
		        	xB^.r[4].o.ob[9].cf.n :=  64;									// text 'Vypnut po case'
					vi		:= 0;
					vo		:= 0;
				END_IF;
				IF ok3 THEN
					vi		:= 0;
					vo		:= 0;
					i		:= 0;
					ii		:= 0;
					ok1	:= 1;
					ok2	:= 1;	
					xOh2^.btn				:= 1;
				END_IF;
				// toto je pri 72 aj 73
   	     	xB^.r[1].o.ob[9].wh  := i; 										// zobrazit Lock Mode
      	  	xB^.r[1].o.ob[10].wh := ii; 										// zobrazit DayMode
     	   	xB^.r[2].o.ob[0].btn := ok3;										// zobrazit PO-NO
				// toto nie je pri 73, ale vobec to nevadi
  	     		xB^.r[3].o.ob[0].btn := ok1;										// time Od
   	     	xB^.r[4].o.ob[0].btn := ok2;										// time Do
        		xB^.r[1].o.ob[4].wh 	:= vi;										// Cas vypnutia / opozdenie
        		xB^.r[1].o.ob[5].wh 	:= vo;										// Cas zapnutia / oneskorene vypnutie
			END_IF;
END_FUNCTION

FUNCTION _Nh_Shw_107_ROM {HIDDEN}  : BOOL   //   v objekte zobrazi DayObr / sviecka
 	VAR_INPUT
		day	: BOOL;
		off	: BOOL;
		o		: USINT := 7;
	END_VAR
	_Nh_Shw_107_ROM := true;	
 	x4o    	:= ADR(xR^.o.ob[o]);
	IF xM^.set = false OR OFF THEN
		x4o^.wh	:= 0;
		RETURN;
	END_IF;
	x4o^.wh	:= 107;
  	IF xRom^.me.DayObr = 0 AND day = false THEN
  		x4o^.ok[1]    := 0;
	ELSE
 		x4o^.ok[1]    := 1;
   	x4o^.obr[1]   := _NhDayObr(day := xRom^.me.DayObr);
   END_IF;
	x4o^.ok[2]		:= xRom^.cx.Dark ;
// 		x4o^.ok[1]    := 1;
// 		x4o^.ok[2]    := 1;
//y4o := x4o^;
//yy4o := x4o^;
END_FUNCTION

FUNCTION _Nh_Shw_CPY   {HIDDEN}   : BOOL   //  CHECK prie COPY
	IF xR^.h.cf.n = xF^.cf.n THEN
		xDev^.ok.cpy 	:= 0;
		xR^.o.ob[2].fn := 44;
	ELSE
		xR^.o.ob[2].fn := _Nh_O12(xDev^.ok.cpy,38,35);
	END_IF;

END_FUNCTION

FUNCTION _Nh_Shw_ROM_ROW   {HIDDEN}   : BOOL   //
	_Nh_Shw_ROM_ROW := true;
	xRom := xDev;
	IF xL^.dsh = 4 THEN
		_Nh_Shw_CPY();
		RETURN;
	ELSIF xR^.o.ob[2].wh = 4 AND xR^.o.ob[2].btn THEN	// v riadku je DEL, aleno CPY
		RETURN;	
	END_IF;
   IF xRom^.me.BodyQ THEN
   	xR^.o.ob[0].FgC := 3;
    	xR^.o.ob[0].BgC := 1;
	ELSE
   	xR^.o.ob[0].FgC :=  1;
      xR^.o.ob[0].BgC := 25;
	END_IF;
//	IF xL^.chk  THEN
//		xR^.o.ob[4].wh := 0;
//	END_IF;

 	IF xR^.h.chk  THEN
  		IF xL^.obj = 70  THEN										// priradenie do ROM,ZON			
		  _NhxPt(c:=xF^.cf.c, n:=xF^.cf.n, x:=80);
			IF xR^.h.cf.c = 3 OR INT_TO_USINT(xR^.h.cf.n) <> xPt^.cf.rom THEN
	    		xR^.o.ob[3].fn := 37;								// modry check, priradene do io[xx]
			END_IF;
    	END_IF;
  	END_IF;

	IF xL^.obj = 50 THEN
		xR^.o.ob[1].wh 	:= 234;									// ROM,ZON vo vazbe io vstupuje do ACT aj hlavny obrazok sa spracuje inde
		xR^.o.ob[2].wh		:= 0;
		xR^.o.ob[6].wh		:= 234;
		IF xR^.h.chk THEN
			xR^.o.ob[6].cm		:= 90;
		ELSE
			xR^.o.ob[6].cm		:= 0;
		END_IF;
	ELSIF xL^.psn  THEN
		IF xL^.obj = 6 AND xM^.set THEN					
			xR^.o.ob[4].fn := _Nh_O12(xRom^.al.lst,25,23);
			xR^.o.ob[4].cm := 84;	
		END_IF;
		xR^.o.ob[2].wh		:= 0;
		xR^.o.ob[6].wh		:= 234;
 		x4o   := ADR(xR^.o.ob[8]);

//		_Nh_Shw_LCK_ET(ala:=xZon^.cx.lck.stat > 4, et:=xZon^.cx.lck.et, o := 4);
		_Nh_Shw_LCK_ET(sta:=xRom^.cx.lck.stat, et:=xRom^.cx.lck.et, o := 4);
(*

		IF xRom^.cx.lck.et > 0 THEN	//xM^.set THEN
			x4o^.wh			:= 107;
   		x4o^.ok[2]   	:=  true;
			IF xRom^.cx.lck.et > 120 THEN
	   		x4o^.obr[2]   	:=  UINT_TO_INT(xRom^.cx.lck.et/60);
			ELSE
	   		x4o^.obr[2]   	:=  UINT_TO_INT(xRom^.cx.lck.et);
			END_IF;
		END_IF;
*)
	END_IF;




(*
	IF xL^.psn  THEN
		xR^.o.ob[2].wh 	:= 231;
		xR^.o.ob[2].x		:= x2-60;
		xR^.o.ob[2].y		:= 50;		
		xR^.o.ob[2].w 		:= 64;
		xR^.o.ob[2].h 		:= 0;
		xR^.o.ob[2].cm 	:= 28;
		xR^.o.ob[2].cf.c 	:= xF^.cf.c;
		xR^.o.ob[2].cf.n 	:= xF^.cf.n;
		IF xF^.cf.c = 3 THEN
			IF xM^.set THEN
				xR^.o.ob[4].wh := 0;	
				xR^.o.ob[6].wh := 1;	
			END_IF;
		END_IF;
//		xDev^.al.sta := 2;

	ELSE
//		xR^.o.ob[2].cf.c 	:= 254;
		xR^.o.ob[2].fmt 	:= REAL_TO_STRINGF(xDev^.al.ou.val,'%5.1f°');

	END_IF;
*)


   // sviecka a dayObr
	IF xR^.o.ob[7].wh = 107 THEN
			_Nh_Shw_107_ROM(o:=7);
	END_IF;
END_FUNCTION

FUNCTION _Nh_Shw_B20_ROW   {HIDDEN}   : BOOL   // pre browser 20 {LUX/TER/TEK/TEH}
	CASE xR^.h.cf.c OF
		19:	xLux := xDev;
				xPtB	:= ADR(xLux^.me.man);
            xR^.o.ob[8].fmt   := REAL_TO_STRINGF(xLux^.me.lux,'%5.0f');
		41:	xLux := xDev;
				xPtB	:= ADR(xLux^.me.man);
            xR^.o.ob[8].fmt   := REAL_TO_STRINGF(xLux^.me.lux,'%5.0f');
		ELSE	xTer 	:= xDev ;
				xPtB	:= ADR(xTer^.me.man);
	END_CASE;

	IF xA^.admin AND xM^.set THEN
      _Nh_Frm_Row_O13(ob:=5, vb:= PTR_TO_UDINT( ADR(xDev^.al.in.Val) ) );
		_Nh_DEF_VAR(wh:=24, o:= 7, x:=xPtB);
	ELSE
		xR^.o.ob[5].wh := 0;				
		xR^.o.ob[7].wh := 0;				
		xPtB^				:= false;		
	END_IF;
	IF xR^.o.ob[7].Qf THEN
		xDev^.al.in.CMD := 7;							// po stlaceni manualu vysle refresh pre TER,LUX...
	END_IF;

END_FUNCTION



FUNCTION _NhSetPIR   {HIDDEN}   : BOOL
   // PIR a ostatne
		xR^.h.pir  		:= true;
(*
		IF xR^.h.cf.c = 44 OR _NhSetPIR THEN							// u DLG sa zobracuje cislo sceny a DLm
			IF _NhxPir(n:=xIO^.n,x:=56) THEN	
			   memcpyPtr(Source := ADR(_NhObjO4rom), dest := ADR(xR^.o.ob[7]), length := SIZEOF(NH_OBJ_DAT));
				_Nh_Shw_107_ROM(o:=7, day:=1);
			ELSE
				xR^.o.ob[7].wh		:= 0;   		
			END_IF;
		END_IF;
*)
		IF _NhxPar(cp := aCfg[xIO^.c].par, np := xIO^.p,x:=250 ) THEN
			pPir 				:= xPar;	
			xR^.o.ob[5].wh := 0; 		
			xR^.o.ob[6]		:= _NhObjD1pir;
   		_Nh_DEF_VAR(wh:=20, o:=6, x:=ADR(pPir^.Day.n[0]) );
		END_IF;
END_FUNCTION


FUNCTION _NhSetWSB  {HIDDEN}    : BOOL           //   upravi WSB,TLA
   // uz pride namapovane xO
   VAR_INPUT
//      led      : BOOL;                       // vykresli LEDky
      chk      : BOOL;                       // vykresli
//      tgl      : BOOL;
      o        : USINT;                      // objekt
   END_VAR
   VAR_TEMP
      xO       : PTR_TO NH_OBJ_DAT;
//      i        : SINT;
   END_VAR
   _NhSetWSB := true;
   xO     := ADR(xR^.o.ob[o]);
   _NhxDev2(c := xO^.cf.c, n := xO^.cf.n, x:=11);
   xWsb  := xDev2;
   IF xR^.h.chk THEN                                                          // priradena vazba vykresli aj BTN v hlavnom obrazku
      _NhxPar2(cp := aCfg[xO^.cf.c].par, np := xO^.cf.p ,x:=244);           // parameter do xPar2
      pWsb      := xPar2;
      xO^.wh    := 10;
      xO^.BgC   := 8;                                                 // farba zobrazenia BTN (Green)
      xO^.FgC   := pWsb^.bt;                                          // cislo BTN z parametra vazby
   ELSE
      xO^.wh    := 3;
   END_IF;
   IF o = 4 AND xR^.h.chk THEN
      ;
   ELSIF xO^.cf.c  = 14 THEN
      xR^.o.ob[5].wh    :=  0;

   ELSIF xO^.cf.c  = 40 THEN
      xTgl := xDev;

      xR^.o.ob[5].fn    :=  0;
      xR^.o.ob[5].wh    :=  120;
      xR^.o.ob[5].w     :=  300;                                         // welkost obrazka
      xR^.o.ob[5].h     :=  55;                                         // vzdialenost medzi obrazkami


(*
      xR^.o.ob[5].wh    :=  20;
      xR^.o.ob[5].fn    :=  0;
//      xR^.o.ob[5].cf.c  :=  6;
      xR^.o.ob[5].w     :=  35;                                         // welkost obrazka
      xR^.o.ob[5].h     :=  40;                                         // vzdialenost medzi obrazkami
      CASE xL^.dsh OF
         1: //xR^.o.ob[5].w     :=  28;
//            xR^.o.ob[5].h     :=  52;
            xR^.o.ob[5].cf.c  :=  5;
         ELSE
            xR^.o.ob[5].cf.c  :=  3;
      END_CASE;
      xR^.o.ob[5].FgC   :=   2;
      xPtD  := ADR( xR^.o.ob[5].cf.n) ;
      xPtD^ := PTR_TO_UDINT(ADR(xTgl^.cx.Led.Led1)) ;                     // adresa zoznamu DayMode
*)
      ;
   ELSIF xWsb^.cx.cfC.nBtns > 0 THEN
      xR^.o.ob[5].fn    :=  0;
      xR^.o.ob[5].wh    :=  120;
      xR^.o.ob[5].w     :=  300;                                         // welkost obrazka
      xR^.o.ob[5].h     :=  55;                                         // vzdialenost medzi obrazkami


      CASE xL^.dsh OF
         1: //xR^.o.ob[5].w     :=  28;
//            xR^.o.ob[5].h     :=  52;
//            xR^.o.ob[5].cf.c  :=  xWsb^.cx.LedNbr-1;
         ELSE
            xR^.o.ob[5].cf.c  :=  3;
      END_CASE;
      xR^.o.ob[5].FgC   :=   2;
//      xPtD  := ADR( xR^.o.ob[5].cf.n) ;
//      xPtD^ := PTR_TO_UDINT(ADR(xWsb^.cx.Led[1])) ;                     // adresa zoznamu DayMode
   ELSE
      xR^.o.ob[5].wh    :=  0;
   END_IF;
//         blk               := xR^.h.chk = false;                                       // blk len ked nie je vo vazbe
   IF aCfg[ xR^.h.cf.c].tgrp = 13 THEN                                                    // vo vazbe nie je v riadku wsb
      xR^.o.ob[ 2].w    := 72;                                                      // zvacsi sa velkot obrazka PIR-On (088)
      xR^.o.ob[ 2].fn   := xR^.o.ob[ 1].fn;                                         // zvacsi sa velkot obrazka PIR-On (088)
      IF xDev^.al.ou.Val > 0.0 THEN                                                 // v riadku je WSB
         xR^.o.ob[2].wh    :=  10;
         xR^.o.ob[2].BgC   :=  3;                                                   // zlta
         xR^.o.ob[2].FgC   :=  REAL_TO_USINT(xWsb^.al.ou.Val);                                          // cislo BTN z parametra vazby
      ELSE
         xR^.o.ob[2].wh    :=  0;
      END_IF;
   END_IF;
END_FUNCTION

FUNCTION _Nh_Chk_OFF  {HIDDEN} : BOOL         // ak je filter [8]:= 49,51,57  filtruje len zapnute/ vypnute
   VAR_INPUT
//      set   : BOOL;           // nastavit
   END_VAR
   _Nh_Chk_OFF := true;
   IF xU^.o[8].fn = 49  THEN                          // bez filtra
      ;
   ELSIF xU^.o[8].fn = 57 THEN                        // v rom/zon filtrujew let kde je pritomnost / pohyb
      xRom  := xDev;
      yes   := yes AND xRom^.me.BodyQ;
   ELSIF xU^.o[8].fn = 51 THEN
   	yes := yes AND xDev^.al.sta > 0;                   // vacsina pripadov
	END_IF;
(*
      IF yIdxR.dev.c = 2 THEN                          // riadok je CAT
         _NhxRoW(nbr:=xA^.sbj, zon:=true);                         // namapuje xRow na Domcek alebo ak sa pouzivaju subjekty tak na subjekt-byt
         yes :=  yes AND xRoW^.cat[ yIdxR.dev.n ];
      ELSE
         yes := yes AND xDev^.al.ou.val > 0.0;                   // vacsina pripadov
      END_IF;
   END_IF;
*)
END_FUNCTION


(*
FUNCTION _Nh_Chk_OFF : BOOL         // ak je filter [8]:= 49,51,57  filtruje len zapnute/ vypnute
   VAR_INPUT
      set   : BOOL;           // nastavit
   END_VAR
   _Nh_Chk_OFF := true;
   IF xU^.o[8].fn = 49  THEN                          // bez filtra
      ;
   ELSIF xU^.o[8].fn = 57 THEN                        // v rom/zon filtrujew let kde je pritomnost / pohyb
      xRom  := xDev;
      yes   := yes AND xRom^.me.Body;
   ELSIF xU^.o[8].fn = 51 THEN
      IF yIdxR.dev.c = 2 THEN                          // riadok je CAT
         _NhxRoW(nbr:=xA^.sbj, zon:=true);                         // namapuje xRow na Domcek alebo ak sa pouzivaju subjekty tak na subjekt-byt
         yes :=  yes AND xRoW^.cat[ yIdxR.dev.n ];
      ELSE
         yes := yes AND xDev^.al.ou.val > 0.0;                   // vacsina pripadov
      END_IF;
   END_IF;
END_FUNCTION
*)

FUNCTION _Nh_Chk_Dev_SET {HIDDEN}: BOOL
   VAR_INPUT
      set      : BOOL;
      dev      : PTR_TO NH_DEV_SW;
   END_VAR
   IF set THEN
      IF dev^.c = yIdxR.dev.c AND dev^.n = yIdxR.dev.n THEN
         dev^.c := 0;
         dev^.n := 0;
      ELSE
         dev^.c := yIdxR.dev.c;
         dev^.n := yIdxR.dev.n;
      END_IF;
      xPt^.al.in.CMD := 255;                                            // do DEV v hlavicke sa posle REFRESH/ ako pri restarte
   ELSE
      yIdxR.chk := dev^.c = yIdxR.dev.c AND dev^.n = yIdxR.dev.n;
   END_IF;
END_FUNCTION

(*
FUNCTION _Nh_Chk_Dev_ROM {HIDDEN}: BOOL         // pridelit LEN do JEDNEJ miestnosti
   VAR_INPUT
      set      : BOOL;
      dev      : PTR_TO NH_DEV_SW;
   END_VAR
   IF set THEN
      IF dev^.c = yIdxR.dev.c AND dev^.n = yIdxR.dev.n THEN
         dev^.c := 0;
         dev^.n := 0;
      ELSE
         dev^.c := yIdxR.dev.c;
         dev^.n := yIdxR.dev.n;
      END_IF;
      xPt^.al.in.CMD := 255;                                            // do DEV v hlavicke sa posle REFRESH/ ako pri restarte
   ELSE
      yIdxR.chk := dev^.c = yIdxR.dev.c AND dev^.n = yIdxR.dev.n;
   END_IF;
END_FUNCTION
*)

(*
FUNCTION _Nh_Chk_Rom_SET {HIDDEN}: BOOL            // TER,LUX - moze pridat aj do inych miestnosti nielen do DOMOVSKEJ
   VAR_INPUT
      set      : BOOL;
      val      : USINT := 100;
   END_VAR
   xRom := xDev;
   IF xRom^.cx.dev[val].c = xF^.cf.c AND xRom^.cx.dev[val].n = xF^.cf.n THEN
      IF set THEN
         xRom^.cx.dev[val].c := 0;
         xRom^.cx.dev[val].n := 0;
         xPt^.al.in.CMD := 255;                                            // do DEV v hlavicke sa posle REFRESH/ ako pri restarte
      ELSE
         yIdxR.chk := true;
      END_IF;
   ELSIF yIdxR.dev.c = 1 AND  xPt^.cf.rom = 0 THEN                   // len ROM, nie ZONE
      IF set THEN
         xPt^.cf.rom := INT_TO_USINT(yIdxR.dev.n);
      ELSE
         yIdxR.chk := false;           // ROM odpoveda Rec ZON
      END_IF;
   ELSIF yIdxR.dev.c = 1 AND xPt^.cf.rom = INT_TO_USINT(yIdxR.dev.n) THEN               // TER.LUX.. je momentalne v tejto ROM
      IF set THEN
         xPt^.cf.rom    := 0;
         xPt^.al.in.CMD := 255;                                            // do DEV v hlavicke sa posle REFRESH/ ako pri restarte
      ELSE
         yIdxR.chk := xPt^.cf.rom = INT_TO_USINT(yIdxR.dev.n);           // ROM odpoveda Rec ZON
      END_IF;
   ELSIF set THEN
      xRom^.cx.dev[val].c := xF^.cf.c;
      xRom^.cx.dev[val].n := xF^.cf.n;
      xPt^.al.in.CMD := 255;                                            // do DEV v hlavicke sa posle REFRESH/ ako pri restarte
   ELSE
      yIdxR.chk := xRom^.cx.dev[val].c = xF^.cf.c AND xRom^.cx.dev[val].n = xF^.cf.n;
   END_IF;
END_FUNCTION
*)


FUNCTION _Nh_Chk_Rom_SET {HIDDEN}: BOOL            // TER,LUX - moze pridat aj do inych miestnosti nielen do DOMOVSKEJ
   VAR_INPUT
      set      : BOOL;
      //val      : USINT := 100;
   END_VAR
	_Nh_Chk_Rom_SET := true;
   xRom := xDev;						// v riadku
   IF xPt^.cf.rom = 0 THEN                   // len ROM, nie ZONE
      IF set THEN
         xPt^.cf.rom := INT_TO_USINT(yIdxR.dev.n);
      ELSE
         yIdxR.chk := false;           // ROM odpoveda Rec ZON
      END_IF;
	ELSIF xPt^.cf.rom = INT_TO_USINT(yIdxR.dev.n) THEN
      IF set THEN
         xPt^.cf.rom := 0;
      ELSE
         yIdxR.chk := true;           // ROM odpoveda Rec ZON
      END_IF;
	ELSE
		_Nh_Chk_Rom_SET := false;	
      yIdxR.chk 		 := false;           // ROM odpoveda Rec ZON
   END_IF;
END_FUNCTION


FUNCTION _Nh_DEV_IO  {HIDDEN} : BOOL
	VAR_INPUT
		set		: BOOL;
		dev		: PTR_TO NH_DEV_IO;
   END_VAR
	_Nh_DEV_IO	:= xPtIOa^.dev.c = dev^.c AND xPtIOa^.dev.n = dev^.n;
	IF set = false THEN
		;
	ELSIF _Nh_DEV_IO THEN											// del
		_NhMemClrPTR(size:=SIZEOF( NH_VAL_IO ), dest := xPtIOa );
		_Nh_DEV_IO	:= false;
	ELSE
		xPtIOa^.dev.c	:= dev^.c;
		xPtIOa^.dev.n	:= dev^.n;
		_Nh_DEV_IO		:= true;
	END_IF;
END_FUNCTION


FUNCTION _Nh_ROM_IO  {HIDDEN} : BOOL
	VAR_INPUT
		set		: BOOL;
   	del		: BOOL;
   	io			: PTR_TO NH_VAL_IO;
   END_VAR
	_Nh_ROM_IO	:= true;
	ok				:= io^.dev.c = xF^.cf.c AND io^.dev.n = xF^.cf.n;
	IF del THEN
		_NhMemClrPTR(size:=SIZEOF( NH_VAL_IO ), dest := io );
(*
		IF ok THEN
			_NhMemClrPTR(size:=SIZEOF( NH_VAL_IO ), dest := io );
		ELSE
			io^.own	:= false;
			io^.chg	:= false;
		END_IF;
*)
		ok			:= false;
		io^.val	:= -0.0;
	ELSIF set THEN                         // nastavi do ROM/ZON udaje z hlavicky (TER/TEH..,LUX...)
		io^.dev.c	:= xF^.cf.c;
		io^.dev.n	:= xF^.cf.n;		
		ok				:= true;
	ELSIF ok THEN             					// riadok je CHK
		yIdxR.chk 	:= true;
	ELSE
		_Nh_ROM_IO	:= false;             	// riadok nie je CHK
		ok				:= false;
	END_IF;

	IF yIdxR.dev.c = 3 THEN   					// v riadku je ZONE
		yIdxR.chk 	:= ok;	
	ELSIF xPt^.cf.rom = INT_TO_USINT(yIdxR.dev.n) THEN   // ROM v riadku odpoveda ROM v DEV-v hlavicke - brz vazby
		yIdxR.chk 	:= true;
	ELSIF	ok THEN
		yIdxR.chk 	:= true;
	ELSE
		yIdxR.chk 	:= false;				
		_Nh_ROM_IO	:= false;
	END_IF;
END_FUNCTION

FUNCTION _Nh_IO_MAP {HIDDEN} : BOOL 				// vsetky vazby schema namapuje _xPtIOa na konkretne xDev^.io[x]
	VAR_INPUT
		cIO	:	USINT;			// cf DEV ktore ma IO
		Dev 	:	USINT;		   // vg
	END_VAR
	jj	:= -128;
	CASE cIo OF
     1 :	CASE Dev OF			// ROM
           16: jj := 0;     	// TER
           19: jj := 1;       // LUX
         END_CASE;
     3 :	CASE Dev OF		 	// ZON
           16: jj := 0;     	// TER
           19: jj := 1;       // LUX
         END_CASE;
     6 :	CASE Dev OF			// HET
           1 : jj := 0;  		// rom teplota
           7 : jj := 2;       // KOT
           8 : jj := 1;       // TVE
           9 : jj := 3;       // CER
           16: jj := 0;     	// TER
           17: jj := 0;       // TEH
           18: jj := 0;       // TEK
         END_CASE;
     7 :	jj := 0;			// KOT
	  		CASE Dev OF			
          43 : jj := 0;  		// DALI-s
          18 : jj := 1;			// TEK
         END_CASE;
     8 :	// TVE
	  		CASE Dev OF			
          43 : jj := 0;  		// DALI-s
          17 : jj := 1;			// TEH
         END_CASE;
     9 :	jj := 0;			// CER
	  		CASE Dev OF			
          43 : jj := 0;  		// DALI-s
          18 : jj := 1;			// TEK
         END_CASE;
    23 :	// VEN
	  		CASE Dev OF			
          43 : jj := 0;  		// DALI-s
         END_CASE;
    37 :	CASE Dev OF		// GAT
           33: jj := 0;       // DOR
         END_CASE;
    47 :	CASE Dev OF			// HEV
          41 : jj := 0;  		// CO2
          23 : jj := 2;       // VEN/REK = kotol
         END_CASE;
   END_CASE;
	IF jj = -128 THEN
		_Nh_IO_MAP := false;	
	ELSE
		_NhxPtIOa(xIO:=xPt, c:=cIo, io:= SINT_TO_UDINT(jj));
		_Nh_IO_MAP := true;
	END_IF;

END_FUNCTION


FUNCTION _Nh_Chk_IODev  {HIDDEN} : BOOL       		// nahradza vazby [5] pre dev ktore sa priamo zapisujeu do xDev^.io[ ]  {HET,HEV,ROM}
   VAR_INPUT
      set   : BOOL;           // nastavit
		iov	: USINT;				// skupina do ktore patri DEV v hlavicke
   END_VAR
	IF xF^.cf.c = 2 THEN																	// hlavicka je CAT
		_Nh_Chk_IODev := false;
		RETURN;
	ELSIF xF^.cf.n > 0 THEN																// hlavickuu ROM nemapuje
	   ok 	:= _NhxPt(c := xF^.cf.c, n := xF^.cf.n, x:=431);                        // DEV v hlavicke + namapuje hlavicku
	END_IF;	
	_Nh_Chk_IODev := true;	
	CASE xF^.cf.c OF
        16:	iov := 100;    // TER
        19: iov := 101;    // LUX
        41: iov := 102; 	// CO2
 	ELSE	iov := 100;
   END_CASE;		

	IF xL^.obj = 50 THEN																				// vaz[2]  TGL,WSB
		 yes := xF^.rom = 0 OR xDev^.cf.rom = xF^.rom;                         // riadok ma ten isty rom ako hlavicka
		_Nh_Chk_IODev := false;
	ELSIF xL^.obj = 55 THEN																	// priradit Nejake DEV do IO
		IF aCfg[xF^.cf.c].io > 0 	THEN													// dev v hlavicke ma IO a zapisuje sw dev v riadku, ktore ma cislo iov
			IF _Nh_IO_MAP(cIo:=xF^.cf.c, Dev:=yIdxR.dev.c)  THEN
				yIdxR.chk 	:= _Nh_DEV_IO(set:=set, dev := ADR(yIdxR.dev) );	
			ELSE
				_Nh_Chk_IODev := false;		
			END_IF;
		ELSIF aCfg[yIdxR.dev.c].io > 0 THEN 					// do dev v riadku sa zapisuje adresa v hlavicke
			xPt := xDev;
			IF _Nh_IO_MAP(cIo:=yIdxR.dev.c, Dev:=xF^.cf.c) THEN
				yIdxR.chk 	:= _Nh_DEV_IO(set:=set, dev := ADR(yIdxR.dev) );	
			ELSE
				_Nh_Chk_IODev := false;		
			END_IF;
		ELSE
			_Nh_Chk_IODev := false;		
		END_IF;
      yes := xF^.rom = 0 OR xDev^.cf.rom = xF^.rom;                         // riadok ma ten isty rom ako hlavicka
	ELSIF yIdxR.dev.c = 1 THEN //AND 													// ROM->DEV
		xRom := xDev;
(*
					IF xF^.cf.c = 1 AND xF^.cf.n = USINT_TO_INT(_NhDefRom) THEN   			// default room
						yes := xDev^.cf.rom = _NhDefRom;
					ELSIF xF^.cf.c = 3 THEN																// 1. zona
						yes := xDev^.cf.rom = xF^.rom OR xL^.fvz = false;                 // riadok ma ten isty rom ako hlavicka					
					ELSIF xL^.obj = 5  THEN   															// miestnosti
               	yes := true;
					ELSIF xF^.cf.c = 6 THEN	
						yes := xF^.rom = 0 OR xDev^.cf.rom = xF^.rom;                         // riadok ma ten isty rom ako hlavicka
					ELSIF aCfg[cf].RomIsZone = false THEN
						yes := xF^.rom = 0 OR xDev^.cf.rom = xF^.rom;                         // riadok ma ten isty rom ako hlavicka
					ELSE
						Yes := false;
					END_IF;

*)


		IF set = false  THEN

			IF xL^.obj = 5  THEN   																		// zoznam vsetkych miestnosti
//  				yes 			:= xM^.set OR xDev^.cf.rom <> _NhDefRom OR xDev^.cf.rom =0;      // vsetko pre setup alebo
  				yes 			:= (xM^.set AND (xDev^.cf.typ <> 0 OR xA^.admin)) OR xDev^.cf.typ <> 0 ;	//xDev^.cf.rom <> _NhDefRom OR xDev^.cf.rom =0;      // vsetko pre setup alebo
			ELSIF xL^.obj = 10  THEN   																// 1.miestnost
				yes 			:= xDev^.cf.rom = INT_TO_USINT(xF^.cf.n);
			ELSIF xL^.obj = 70  THEN   																// 1.miestnost

				yes 			:= true;
				_Nh_ROM_IO(io:=ADR(xRom^.io[ iov ]));												// zapise do CHK yIdxR.chk ak je DEV v io[]			
				IF xPt^.cf.rom = INT_TO_USINT(yIdxR.dev.n) THEN
					yIdxR.chk 	:= true;                                                 // pre beznu zhodu
				END_IF;
			ELSIF xF^.cf.c = 3 THEN																	// 1. zona  ostatne
				yes := xDev^.cf.rom = INT_TO_USINT(xF^.cf.n);                 // riadok ma ten isty rom ako hlavicka					
				IF xL^.obj = 30 THEN
					_NhxPt(c := xF^.cf.c, n := xF^.cf.n, x:=431);                        // DEV v hlavicke + namapuje hlavicku
					xPt^.al.lst := yes;
					yIdxR.chk 	:= yes;           			// rom v miestnosti  = cislo rec ZON (v xZon^.cf.rom je cislo domceka {1})
					yes 		 	:= yes  OR xL^.fvz = false;                 				
				END_IF;
//			ELSIF aCfg[xF^.cf.c].RomIsZone = false THEN										 // zo zonamu 1.rom vyluci	
			ELSE
				yes := xF^.rom = 0 OR xDev^.cf.rom = xF^.rom;                         // riadok ma ten isty rom ako hlavicka
				IF xL^.chk THEN
					yIdxR.chk 	:= yes;           			// rom v miestnosti  = cislo rec ZON (v xZon^.cf.rom je cislo domceka {1})
				END_IF;
//			ELSE
//				yes := false
			END_IF;

		ELSIF xF^.dev.n[1] = false THEN
			;
		ELSIF xL^.obj = 30 THEN	//xF^.cf.c = 3 THEN											// v hlavicke je ZON / setup / check
			IF xR^.h.chk THEN
				xDev^.cf.rom := _NhDefHom;															// vyradi zo zony a priradi do domceka
			ELSE
				xDev^.cf.rom  := INT_TO_USINT(xF^.cf.n);										// priradi zo zony
			END_IF;
			yIdxR.chk := xDev^.cf.rom  = INT_TO_USINT(xF^.cf.n);    					// ROM je v zone
		ELSIF xL^.obj <> 70 THEN
			;
		ELSIF aCfg[xF^.cf.c].zone = false THEN													// priradit ROM -> DEV. Ostatne ako TER,LUX , ktore sa priradzuju len do 1 miestnosti
			xPt^.cf.rom := INT_TO_USINT(yIdxR.dev.n);           							// LEN prepise ROM
			yIdxR.chk 	:=  true;

//		ELSIF yIdxR.dev.n <> 2 THEN															// TER/LUX aj do viacerych ROM ale aj do default ROM
		ELSIF yIdxR.dev.n <> USINT_TO_INT(_NhDefRom) THEN								// default rom sa necheckuje
			IF xPt^.cf.rom = INT_TO_USINT(yIdxR.dev.n)										// vyradit z rom
				OR xPt^.cf.rom = 0  THEN                              					// zo startych dat
					xPt^.cf.rom := _NhDefRom;           										// def.ROM						
					_Nh_ROM_IO(del:=true, io:=ADR(xRom^.io[ iov ]));	
			
			ELSIF xPt^.cf.rom  = _NhDefRom THEN  												// default room prepise na novu
				xPt^.cf.rom := INT_TO_USINT(yIdxR.dev.n);           		// prepise ROM
				_Nh_ROM_IO(del:=true, io:=ADR(xRom^.io[ iov ]));	
			ELSIF xR^.h.chk THEN														// vymazat DEV-vazbu
				_Nh_ROM_IO(del:=true, io:=ADR(xRom^.io[ iov ]));
			ELSE //xPt^.cf.rom <> _NhDefRom THEN                    		// pridat DEV-vazbu
				_Nh_ROM_IO(set:=true, io:=ADR(xRom^.io[ iov ]));	
			END_IF;
			_Nh_ROM_IO(io:=ADR(xRom^.io[ iov ]));									// zapise do CHK yIdxR.chk			
		END_IF;

	ELSIF yIdxR.dev.c =  3 THEN //AND xL^.obj = 70  THEN 		// TER/LUX -> ZONE (v riadku)
		xRom := xDev;
		IF set THEN
			IF xR^.h.chk THEN
				_Nh_ROM_IO(del:=true, io:=ADR(xRom^.io[ iov ]));
			ELSE
				_Nh_ROM_IO(set:=true, io:=ADR(xRom^.io[ iov ]));
			END_IF;
		ELSE
 		END_IF;
		_Nh_ROM_IO(io:=ADR(xRom^.io[ iov ]));									// zapise do yIdxR.chk				

	ELSIF xL^.obj = 51 THEN															// priradit Nejake DEV do IO

		IF xL^.vaz > 0 	THEN														// su tu klasicke vazby
			_Nh_Chk_IODev := false;		
		ELSIF aCfg[xF^.cf.c].io > 0 	THEN										// dev v hlavicke ma IO a zapisuje sw dev v riadku, ktore ma cislo iov
			IF _Nh_IO_MAP(cIo:=xF^.cf.c, Dev:=yIdxR.dev.c)  THEN
				yIdxR.chk 	:= _Nh_DEV_IO(set:=set, dev := ADR(yIdxR.dev) );	
			ELSE
				_Nh_Chk_IODev := false;		
			END_IF;
		ELSIF aCfg[yIdxR.dev.c].io > 0 THEN 					// do dev v riadku sa zapisuje adresa v hlavicke
			xPt := xDev;
			IF _Nh_IO_MAP(cIo:=yIdxR.dev.c, Dev:=xF^.cf.c) THEN
				yIdxR.chk 	:= _Nh_DEV_IO(set:=set, dev := ADR(yIdxR.dev) );	
			ELSE
				_Nh_Chk_IODev := false;		
			END_IF;
		ELSE
			_Nh_Chk_IODev := false;		
		END_IF;
       yes := xF^.rom = 0 OR xDev^.cf.rom = xF^.rom; 		

	ELSIF xL^.obj = 10 THEN 															// DEV do 1.miestnosti
	 	// zo zoynamu 1.rom vyluci ACT,BLK,	
		yes := (xF^.rom = 0 OR xDev^.cf.rom = xF^.rom) AND aCfg[yIdxR.dev.c].RomIsZone = false;
	ELSE
		_Nh_Chk_IODev := false;	
	END_IF;
END_FUNCTION

FUNCTION _Nh_Chk_FAV  {HIDDEN} : BOOL      // pre riadok browsu dokresli FAV/CHK/>>, k PIR a niektorym DEV pri CHK dokresli obrazky
   _Nh_Chk_FAV := true;
   IF xL^.chk THEN                                                   // riadok je do ob
      xR^.h.chk         := yIdxR.chk;
      xR^.o.ob[3].cm    := 41;                                       // defaut CHECK, moze sa upravit pri DEV (ROM,DLg)
      xR^.o.ob[3].fn 	:= _Nh_O12(xR^.h.chk,38,35);                 // obrazok check
   ELSE
      // pre kompatibilitu, pokial nebudu vsetky frame prerobene, default je 200, inak v cfg[].fSc moze byt 204 (novy sposob screenu)
		IF xL^.dsh <> 4 THEN
	      xR^.o.ob[1].cm    := aCfg[xR^.h.cf.c].fSc ;							// click na hlavnu ikonu
   	END_IF;
      xR^.o.ob[3].cm    := 40 ;                                      // FAV
      IF _NhfVaz(vaz := 1, par := false) THEN
         xR^.o.ob[3].fn    := 43;       // FAV modry
      ELSE
         xR^.o.ob[3].fn    := 42;       // FAV sivy
      END_IF;
		IF xR^.h.cf.c = 2 THEN													// CAT nema ziadne zaznamy
			RETURN;
		END_IF;
      xR^.h.cf.p        	:= xDev^.cf.par;
      IF xM^.set THEN                                   // ma sa vypisovat stp
         IF aCfg[xR^.h.cf.c].stp THEN                                   // ma sa vypisovat stp
//            xR^.o.ob[4].fn   := _Nh_O12(in := xDev^.al.vaz OR xDev^.al.lst, o1:=25, o2:= 23);  // SETUP zeleny/sivy
            xR^.o.ob[4].fn   := _Nh_O12(in := xDev^.al.vaz, o1:=25, o2:= 23);  // SETUP zeleny/sivy
            IF xR^.o.ob[4].cm > 250 THEN
               xR^.o.ob[4].cm   := 32 ;
            END_IF;
         END_IF;
      ELSIF  aCfg[xR^.h.cf.c].ar2 THEN                                              // odskok dalej ( >> alebo > sa vykreslia vzdy)
         xR^.o.ob[4].fn   := 8;                                                 // >>
         xR^.o.ob[4].cm   := 30;
		ELSE
		   xR^.o.ob[4].wh   := 0;
		   xR^.o.ob[4].fn   := 0;
         xR^.o.ob[4].cm   := 0;		
      END_IF;
//      xR^.o.ob[3].fn := _Nh_O12(xR^.h.chk,43,42);
   END_IF;

   IF yIdxR.vaz THEN                                                    // riadok je z vazby, vzdy sa do ob[4] vlozi hlavicka
      xR^.o.ob[2].w  := xR^.o.ob[2].w * 20 / 22;	//50;
      xR^.o.ob[3].cm := 41;
      xR^.o.ob[4].w  := xR^.o.ob[4].w * 20 / 16; 	//60;
      xR^.h.in       := yIdxR.in;
      IF yIdxR.nd > 0 THEN
         _NhxVaz(cv := xL^.vaz, nd := yIdxR.nd);
         IF xR^.h.in THEN
//            _NhxPt(cf:= xVaz^.in.c, nd := xVaz^.in.n,x:=33);
            xR^.o.ob[4].cf    := xVaz^.ou;
            xR^.o.ob[1].cf    := xVaz^.in;
            xR^.h.cf          := xVaz^.in;

         ELSE
            xR^.o.ob[4].cf    := xVaz^.in;
            xR^.o.ob[1].cf    := xVaz^.ou;
            xR^.h.cf          := xVaz^.ou;
         END_IF;
         xR^.o.ob[1].cm    := aCfg[xR^.o.ob[1].cf.c].fSc;
         xR^.o.ob[4].cm    := aCfg[xR^.o.ob[4].cf.c].fSc;
         xR^.o.ob[4].fn    := xU^.o[2].fn;
      ELSE
         xR^.o.ob[4].fn := xU^.o[2].fn;
         xR^.o.ob[4].cm := aCfg[xF^.cf.c].fSc;
      END_IF;

///!!!      xDev  := xPt;


      // WSB
//      IF xL^.lst THEN																			// v DEV-liste sa nezobrazuje ikona DEV namiesto setup
//         xR^.o.ob[4].fn := 0;
//         xR^.o.ob[4].cm := 0;
      IF acfg[xR^.o.ob[4].cf.c].tgrp = 13 THEN                                 // zobrazit BTN nad TLA/WSB
         _NhSetWSB(o := 4, chk := 1);
      ELSIF acfg[xR^.o.ob[1].cf.c].tgrp = 13 THEN                              // zobrazit BTN nad TLA/WSB
         _NhSetWSB(o := 1, chk := 1);
      ELSIF acfg[xR^.o.ob[4].cf.c].tgrp = 15 THEN
      	xIO := ADR(xR^.o.ob[4].cf);
         _NhSetPIR();
      ELSIF acfg[xR^.o.ob[1].cf.c].tgrp = 15 THEN
			xIO := ADR(xR^.h.cf);
         _NhSetPIR();
      END_IF;
	ELSE
		xR^.h.in := _NhFilDev(wht:=5, row:=xR^.h.cf.c, n:=xF^.cf.c);
	END_IF;
	// zaznaci obrazok lsl k SCN/ACT/BLK/DLg
	IF aCfg[xR^.h.cf.c].lst AND xR^.o.ob[6].wh = 1 THEN
		xR^.o.ob[6].fn := _Nh_O12(xDev^.al.lst,192,039);
	END_IF;	

END_FUNCTION

FUNCTION _Nh_Chk_SCN  {HIDDEN} : BOOL
   VAR_INPUT
      set   : BOOL;           // nastavit
//      mnu   : SINT;
   END_VAR
   _Nh_Chk_SCN := false;
	_NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=531);                              // namapuje hlavicku
   xDev2 := xPt;
	// xDev2 je uz namapovane na hlavicku !!!!
   // xDev  je uz namapovany riadok
	IF yIdxR.dev.c = 4 THEN
		_Nh_Chk_SCN := true;
  		IF set THEN    																// ked sa robi check/uncheck s browsu	
				xR^.h.chk := NOT xR^.h.chk;
	  		IF xR^.h.chk THEN
     			_NhfVaz(del := true, vaz := 3, whf := 10);               // vymaze sa veta  hladana aj s parametrami
        	ELSE
         	xR^.h.in := false;
          _NhfVaz(new := true, vaz := 3);
         END_IF;
		ELSE
	      yIdxR.chk  := xR^.h.chk;
      	yes   := xF^.rom = 0 OR xDev^.cf.rom = xF^.rom;
   	   IF xL^.fvz THEN                                                   // dev len s vazbou
      		yes   := yes AND yIdxR.chk;
	      END_IF;
		END_IF;
	END_IF;
END_FUNCTION

FUNCTION _Nh_Frm_STA_OU  {HIDDEN} : BOOL   	// nad stat [2] zobrazit blokovanie/cas do         				
   VAR_INPUT
      obj   : USINT := 2;
      o     : USINT := 8;
   END_VAR
   x4o               := ADR(xR^.o.ob[o]);
	IF xR^.h.cf.c = 49 THEN													// ventil vody
		;	
   ELSIF obj = 2 THEN                                             // v riadku o
      x4o^.ok [1] := 0;				
  	   x4o^.ok [2] := 0;
		IF xM^.set THEN
	      _Nh_Frm_STA_OU   := true;
			x4o^.wh	:= 107;
			CASE xR^.h.cf.c OF
      	  15 :	// pir	                                   	// nad pir cas o odblokovania a vypnute WSB
		         IF xRom^.me.BlPirOn > 0  THEN               		// deaktivovane WSB - svieti nejake svetlo
   		         x4o^.ok [1] := 1;
   	         	x4o^.obr[1] := 193;    								// cas
					ELSIF xRom^.me.BlPirOff > 0 THEN
   		         x4o^.ok [1] := 1;
   	         	x4o^.obr[1] := 232;    								// off
      		   END_IF;
      	  37 :	// GAT - odlozeny start
					IF xGat^.cx.cmd = 2 THEN				
   		         x4o^.ok [1] := 1;
      		      x4o^.crc[1] := 0;
	         	   x4o^.txt[1] := 0;
   	         	x4o^.obr[1] := 232;    								// cas
(*
   		         x4o^.ok [2] := 1;
   		         x4o^.fil[2] := 1;
      		      x4o^.crc[2] := 1;
	         	   x4o^.txt[2] := 1;
   	         	x4o^.obr[2] :=  REAL_TO_INT( CEIL(UINT_TO_REAL(xGat^.al.et) / 600.0)); ;    								// cas
						IF xGat^.al.et < 600 THEN
							x4o^.obr[2] := x4o^.obr[2] / 10;
						END_IF;						
*)
					ELSE
				      x4o^.wh	:= 0;
					END_IF;

			ELSE
		      IF xDev^.al.et > 0 THEN										// nad DEV len cas do vypnutia
   		      x4o^.ok [1]    := 1;
				END_IF;
		      IF xDev^.al.ex > 0 THEN									// nad DEV max.cas `apnutia
	       		x4o^.ok [2] := 1;
   	   	   x4o^.crc[2] := 0;
      	   	x4o^.txt[2] := 0;         							
	            x4o^.obr[2] := 193; 									// obrazok OFF
   	         x4o^.cmd[2] := 0; 									// neda sa zrusit
				END_IF;
	      END_CASE;
   	END_IF;
   ELSIF o = 7 THEN
      ;
   ELSE
      _Nh_Frm_STA_OU   := false;
   END_IF;
END_FUNCTION

FUNCTION _Nh_Brw_Row_OBJ   {HIDDEN}  : BOOL      // do objektoj 1.riadka dorobi najm CF a ine hodnoty
   VAR_INPUT
      row   : USINT;
   END_VAR
	_Nh_Brw_Row_OBJ   := true;
      FOR j := 0 TO _RowObr DO
         CASE xR^.o.ob[j].wh OF
	         0 :   ;	
            4 :   ;
            6 :   // text
                  IF xR^.o.ob[j].cf.c = 0 THEN
                     // nesmie sa parameter, v nom je sirka textu
                     xR^.o.ob[j].cf.c   := xR^.h.cf.c;
                     xR^.o.ob[j].cf.n   := xR^.h.cf.n;
                  END_IF;

           13 :   xR^.o.ob[j].fn  := USINT_TO_INT(row);                           // cislo slidera je cislo riadka
                  xR^.o.ob[j].cf   := xR^.h.cf;
           12 :   ;
           20 :  ;// pocet obrazkov
           22 :  ;// HET
           24 :  ;// 3 obrazky vo fmt
          107 :  ;// doplnujuce objekty
          109 :  ;// doplnujuce objekty
						xR^.o.ob[j].cf   := xR^.h.cf;
         ELSE
               xR^.o.ob[j].cf.c   := xR^.h.cf.c;
               xR^.o.ob[j].cf.n   := xR^.h.cf.n;
//               xR^.o.ob[j].cf   := xR^.h.cf;
         END_CASE;
      END_FOR;
END_FUNCTION


FUNCTION _Nh_Brw_Row_DSH  {HIDDEN}   : BOOL      // nacifa formular a podla DASH pripravi korekcie X,Y
   VAR_INPUT
//      sld   : BOOL;
      row   : USINT;
      frm   : UINT;
   END_VAR
   _Nh_Brw_Row_DSH  := false;
	_Nh_FRM_Read(frm := frm, row := row);
	xL^.brw        := true;
   CASE xL^.dsh OF
        2:  // 3 x 2
            xIxB^.row.rws  := 6;
            xIxB^.row.clm  := 2;
            IF MOD(row,2) = 0 THEN
               x := xc + 5;
            ELSE
               x  := 0;
            END_IF;
            IF    row = 0 THEN y := 0;
            ELSIF row < 3 THEN y := y1 ;
            ELSIF row < 5 THEN y := y1 + xR^.o.ob[0].h      + 14;
            ELSIF row < 7 THEN y := y1 + xR^.o.ob[0].h * 2  + 28;
            ELSIF row < 9 THEN y := y1 + xR^.o.ob[0].h * 3  + 42;
            ELSE               y := y1 + xR^.o.ob[0].h * 4  + 56;
            END_IF;

     3:  // 6 x 2
         xIxB^.row.rws :=14;
         IF MOD(row,2) = 0 THEN
            x := xc;
         ELSE
            x  := 0;
         END_IF;
         IF    row = 0 THEN y := 0;
         ELSIF row < 3 THEN y := y1 ;
         ELSIF row < 5 THEN y := y1 + xR^.o.ob[0].h      + 10;
         ELSIF row < 7 THEN y := y1 + xR^.o.ob[0].h * 2  + 20;
         ELSIF row < 9 THEN y := y1 + xR^.o.ob[0].h * 3  + 30;
         ELSIF row <11 THEN y := y1 + xR^.o.ob[0].h * 4  + 40;
         ELSIF row <13 THEN y := y1 + xR^.o.ob[0].h * 5  + 50;
         ELSE               y := y1 + xR^.o.ob[0].h * 6  + 60;
         END_IF;

		4:  // 14 tenkych riadkov pre oznacenie/ vyber / copy
            xIxB^.row.rws  := 14;
            xIxB^.row.clm  := 1;
            x              := 0;
            y              := (y1-5) + (xR^.o.ob[0].h+7) * USINT_TO_INT(row-1);
      ELSE  // 6 x 1
            xIxB^.row.rws  := 7;
            xIxB^.row.clm  := 1;
            x              := 0;
            y              := (y1-5) + (xR^.o.ob[0].h+7) * USINT_TO_INT(row-1);
	END_CASE;

END_FUNCTION

FUNCTION _Nh_Fix_FRM  {HIDDEN}  : BOOL
	VAR_INPUT
		rOh		: USINT := 1;				// riadok kde je definicia menu	
		oOh		: USINT := 5;				// objekt v riadku rOh kde je definicia menu	
		rYY		: USINT := 2;	         // riadok kde je definicia YYmmDDhhMM
	END_VAR
        					// namapuje xPod, xFix

	_Nh_Fix_Frm   := true;
	xOh         := ADR(xB^.r[ rOh ].o.ob[ oOh ]);
	xOh^.aVar   := PTR_TO_UDINT(ADR(xFix^.wht));          		// kedy vratit na kalendar
	_Nh_YYMMDD(row:=2, xYear:=ADR(xFix^.tme.Year));
	xR						:= ADR(xB^.r[ rYY ]);							// riadok z sliderom datumu/casu
	xR^.o.ob[0].btn 	:= true;												// zablokuje YYMMDD
	CASE xFix^.wht OF
 		0:	;// Nikdy
 		1:	;// prave teraz - len pre ZON/ROM
			IF xF^.cf.c=1 OR xF^.cf.c=3 THEN
				IF xOh^.Qr THEN
					IF xZon^.cf.typ < 2 THEN
						xZon^.cx.pDay.Day := SYSTEM_S.COUNTER_DAYS_OF_WEEK ;
					END_IF;
				END_IF;
			END_IF;
		2:	// po case
			xR^.o.ob[0].btn 	:= false;
				IF xOh^.Qr THEN
					xR^.o.ob[1].Fgc := 34;			
					xR^.o.ob[4].tch := true;			
					IF xOh^.Qs THEN
						xFix^.tme.Year	:= 0;
						xFix^.tme.Month:= 0;
						xFix^.tme.Day	:= 0;
						xFix^.tme.Hour	:= 2;
						xFix^.tme.Min	:= 0;
					END_IF;
				END_IF;
				xR^.o.ob[1].wh := 0;			
				xR^.o.ob[2].wh := 0;			
				xR^.o.ob[3].wh := 0;			

      3:	// po datume
			xR^.o.ob[0].btn 	:= false;
				IF xOh^.Qr THEN
					xR^.o.ob[3].tch := true;			
					xR^.o.ob[1].Fgc := 33;			
					IF xOh^.Qs THEN
						xFix^.tme.Year	:= SYSTEM_S.COUNTER_YEARS;
						xFix^.tme.Month:= SYSTEM_S.COUNTER_MONTHS;
						xFix^.tme.Day	:= SYSTEM_S.COUNTER_DAYS_OF_MONTH;
						xFix^.tme.Hour	:= 0;
						xFix^.tme.Min	:= 0;
					END_IF;
				END_IF;
				xR^.o.ob[1].wh := 125;		
				xR^.o.ob[2].wh := 125;			
				xR^.o.ob[3].wh := 125;			
		4:	;// od zajtra
		5:	;// od zaciatku tyzdna
		6:	;// ked bude den v tyzdni
		7:	;// po zmene sumraku v zone
		8:	;// zmenou fazy dna
		9:	;// zmenou v nadradenej zone
    END_CASE;
	IF xOh^.Qr OR xO^.tch THEN
		aSys.RefCycNew	:=	1;											//  nastartuje zmeny v TypDay, ale aj TER,LUX...
	END_IF;
	xOh^.Qs := 0;
	xOh^.Qr := 0;			
END_FUNCTION


FUNCTION _NH_DEF_REG {HIDDEN} : BOOL
   VAR_INPUT
      wh    : USINT;
   END_VAR
   CASE wh OF
     29: // HET   - automatika
         xHet := xDev;
         xPod := ADR(xHet^.cx.pDay);
   ELSE  // ROM/ZON
   END_CASE;
   _Nh_DEF_VAR(o:=5,  x:=xPod);
   _Nh_DEF_VAR(o:=6,  x:=ADR(xM^.pod.po.Day));                  // cislo Typ.dn, ktory editujeme
   IF xA^.usr = 1 THEN
      // zobrazit dolu cislo poi
//      xR^.o.ob[4].fmt := CONCAT(USINT_TO_STRING(xB^.po.zon),'/',INT_TO_STRING(xB^.po.poi));
      xR^.o.ob[4].fmt := INT_TO_STRING(xM^.pod.po.poi);
//      _Nh_DEF_VAR(o:=9,  x:=ADR(xPod^.pHom));               // Sablona z Domceka
//      _Nh_DEF_VAR(o:=10, x:=ADR(xPod^.Fix));               // Zmrazit den miestnosti
   ELSE
      xR^.o.ob[ 4].wh := 0;
      xR^.o.ob[ 9].wh := 0;
      xR^.o.ob[10].wh := 0;
   END_IF;
END_FUNCTION

FUNCTION _Nh_Shw_TVE_ROW {HIDDEN}  : BOOL   //   v objekte zobrazi DayObr / sviecka
	xTve     := xDev;
	IF xA^.usr <> 1 THEN
      xR^.o.ob[ 2].nTch := true;
      xR^.o.ob[ 7].nTch := true;
	END_IF;
	IF xR^.o.ob[ 6].tch OR xR^.o.ob[ 2].tch THEN
		xTve^.cx.par.pva.p.prg := false;
	END_IF;
	IF xTve^.io[1].own THEN						// teplota podlahy	
      xR^.o.ob[ 8].fmt 	:= REAL_TO_STRINGF(xTve^.io[1].val,'%5.1f°');
		xDev^.al.lst 		:= true;
	ELSE
		xR^.o.ob[ 8].wh 	:= 0;	
		xDev^.al.lst 		:= false;
	END_IF;
   x4o               := ADR(xR^.o.ob[7]);
   x4o^.ok [1] := 1;				
	IF xTve^.cf.typ = 1 AND xR^.h.cf.c = 8 THEN									// TECO
		IF xTve^.me.stat.RUN AND xTve^.me.stat.READY THEN        // otvara/zatvara v prevadzke
			x4o^.obr[1] := 227;
		ELSIF xTve^.me.stat.RUN AND xTve^.me.stat.READY = false THEN   // servis = INIT
			x4o^.obr[1] := 85;
		ELSIF xTve^.me.stat.RUN = false AND xTve^.me.stat.READY = false THEN   // chyba
			x4o^.obr[1] := 128;
		ELSE
			x4o^.ok [1] := 0;		
		END_IF;
	ELSIF xTve^.al.OU.val = xTve^.al.in.val THEN
		x4o^.ok [1] := 0;	
	END_IF;
	x4o^.ok [2] := 1;
	xR^.o.ob[8].FgC	:= 6;										// orange
	IF xTve^.cf.blk THEN		
	ELSIF xTve^.al.cm = 110 THEN
		x4o^.obr[2] := 233;         							// vysoka teplota
		xR^.o.ob[8].FgC	:= 18;
	ELSIF xTve^.al.cm = 120 THEN
    	x4o^.obr[2] := 234;         							// nizka teplota
		xR^.o.ob[8].FgC	:= 4;
	ELSIF xTve^.al.cm = 101 THEN
    	x4o^.obr[2] := 173;         							// pohotovostna teplota
		xR^.o.ob[8].FgC	:= 8;                         // green
   ELSE	
		x4o^.ok [2] := 0;
   END_IF;			
	x4o^.ok [4] := 1;
	If xTve^.cx.reg.Mode = 0 THEN								// chladenie/odvlcenie
		x4o^.ok [4] := 0;
	ELSIF xR^.h.cf.c = 23 THEN
		x4o^.obr[4] := 415;         						// odvlhcenie
	ELSE	
		x4o^.obr[4] := 410;         						// chladenie
	END_IF;


END_FUNCTION

FUNCTION _Nh_Chk_DALI  {HIDDEN}   : BOOL
   VAR_INPUT
      set   : BOOL;           // nastavit
      mnu   : SINT;
   END_VAR
   _Nh_Chk_DALI := false;
	{$IFDEF __NH_DALI}
//	ok 	:= _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=-431);  	
//   xDev2 := xPt;
	// xPt je uz namapovane na hlavicku !!!!
   // xDev  je uz namapovany riadok
	ok3	:= false;
	IF xL^.obj = 70 THEN                                                	// ROM->DEV
		;
	ELSIF xL^.obj = 50 THEN                                              // vazby [2] TGL,WSB....
		;
	ELSIF xF^.cf.c = 42 THEN                                                // xL^.obj:=48,47 zoznam DLs k masteru DLm
		_Nh_Chk_DALI:= true;
      dlma        := INT_TO_USINT(xF^.cf.n);                            // v hlavicke je vzdy master co je cislo vety
      xDls        := xDev;
      IF set   THEN
         CASE mnu OF
              2 : xL^.dsh := _Nh_U12(xL^.dsh = 3,1,3);                  // DSH
              3 : IF xL^.obj = 47 THEN                                     // zoznam DLg
                     CASE xU^.o[3].fn OF
                       35 : xU^.o[3].fn := 38;                             // vsetky         -> len priradene
                     ELSE   xU^.o[3].fn := 35;                             // vsetky
                     END_CASE;
                  ELSE
                     CASE xU^.o[3].fn OF
                       35 : xU^.o[3].fn := 38;                             // vsetky         -> len priradene
                       38 : xU^.o[3].fn := 37;                             // len priradene  -> len nepriradene
                     ELSE   xU^.o[3].fn := 35;                             // vsetky
                     END_CASE;

(*
                     CASE xU^.o[3].fn OF
                       35 : xU^.o[3].fn := 38;                             // vsetky         -> len priradene
                       38 : xU^.o[3].fn := 37;                             // len priradene  -> len nepriradene
                       37 : xU^.o[3].fn := 35;                             // len nepriradene-> vsetky
                     ELSE   xU^.o[3].fn := 35;                             // vsetky
                     END_CASE;
*)
                  END_IF;
              4 : // cat
              5 : // vsetky->s ROM->bez ROM
                  CASE xU^.o[5].fn OF
                    16 : xU^.o[5].fn := 18;                             // vsetky      -> len s ROM
                    18 : xU^.o[5].fn := 200;                            // len s ROM   -> len bez ROM
                    200: xU^.o[5].fn := 16;                             // len s ROM   -> len bez ROM
                  ELSE   xU^.o[5].fn := 16;                             // vsetky
                  END_CASE;
              6 : xU^.o[6].fn := _Nh_O12(xU^.o[6].fn = 291,335,291);    // Len jeden master co je v hlavicke
              7 : // Dali Sceny zapni/vypni
                  xF^.dev.n[43]  := 0;
                  xF^.dev.n[44]  := 0;
                  CASE xU^.o[7].fn OF
                    333 :  xU^.o[7].fn := 334;                          // browser DLg  47
                           xF^.dev.n[44]  := 1;
                           xL^.obj        := 47;
                           xU^.o[4].fn    := 0;                         // CAT nebude viditelne
                           xL^.dsh        := 1;
                    334 :  xU^.o[7].fn := 333;                          // browser DLs  48
                           xF^.dev.n[43]  := 1;
                           xL^.obj        := 48;
                           xU^.o[4].fn    := 10;                        // vsetky CAT
                  END_CASE;
                  xU^.o[3].fn := 35;                                    // bez vazieb aj s
                  xU^.o[5].fn := 16;                                    // vsetky ROM
                  xU^.o[6].fn := 335;                                   // len jeden master co je v hlavicke
                  xU^.o[8].fn := 49;                                    // aj  ON aj OFF
                  xM^.wht     := 20;

              8 : // OFF->ON->Off+DEL
                  CASE xU^.o[8].fn OF
                    49 : xU^.o[8].fn := 51;                             // vsetky      -> len s ROM
                    51 : xU^.o[8].fn := 56;                            // len s ROM   -> len bez ROM
//                    55 : xU^.o[8].fn := 49;                            // len s ROM   -> len bez ROM
                  ELSE   xU^.o[8].fn := 49;                             // vsetky
                  END_CASE;
            ELSE
               xM^.wht := 10;
         END_CASE;
         RETURN;

      ELSIF xL^.obj = 47 THEN                                        // xL^.obj:=47  zoznam DLg ku mastru
         dlsl        := _Nh_DL_sha(gr:=1,ma:=1, nd := nd) ;
      ELSE
         dlsl        := _Nh_DL_sha(ma:=1, nd := nd) ;                // xL^.obj:=48  zoznam DLs ku mastru
      END_IF;
      yes := false;
      // vazby
      CASE xU^.o[3].fn OF
         38 : yes := xDev^.al.lst;
         37 : yes := xDev^.al.lst = false;
        ELSE  yes := true;
      END_CASE;
      // miestnost
      CASE xU^.o[5].fn OF
         18 : yes := yes AND xDev^.cf.rom > 0;
        200 : yes := yes AND xDLs^.cf.rom = 0;
      END_CASE;
      CASE xU^.o[6].fn OF
         335 : yes := yes AND dlsl = dlma;
      END_CASE;
      // ON/OFF
      CASE xU^.o[8].fn OF
         51 : yes := yes AND xDev^.al.ou.val > 0.0;                          // ON
         56 : yes := yes AND xDLs^.cx.sta.errID > 0;                         // Err
      END_CASE;

   ELSIF xF^.cf.c = 44 THEN                                                   // xL^.obj:=54 zoznam DLs k DLg (DALI scene/grupe)
      IF yIdxR.dev.c = 43 THEN                                                // nemusi byt
//			_Nh_Chk_DALI := true;
			_NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=331);                              // namapuje hlavicku
   			yes 	:= false;
            dlma        := _Nh_DL_sha(gr:=1, ma:=1, nd := xF^.cf.n);          // master DLg v hlavicke
            IF dlma = _Nh_DL_sha(       ma:=1, nd := yIdxR.dev.n ) THEN       // master DLg a master DLs musia byt zhodne, inak je asi filter na vsetky DLc
					dlGr  := _Nh_DL_sha(gr:=1,        nd := xF^.cf.n)-100;         // cislo sceny 0..16 DLg z hlavicky  (vracia cislo GRP [100..115]
               dlsl  := _Nh_DL_sha(nd := yIdxR.dev.n);
               xDLs  := xDev;
					xDLg	:= xPt;
					ok3	:= true;
					IF xDLs^.cx.scn.grp[dlGr] = false THEN
//						xDLg^.cx.sta.Present		:= 0;
					END_IF;
		   		yes   := xF^.rom = 0 OR xDLs^.cf.rom = xF^.rom;
            ELSIF set = false THEN
               yIdxR.chk   := false;
		      END_IF;
         _Nh_Chk_DALI := true;
      ELSE
      ;        // sem sa pride z menu 41: - check, ked je v riadku nieco ine ako 42 {DLs}
      END_IF;

   ELSIF xF^.cf.c = 43 THEN
      IF yIdxR.dev.c = 44 THEN                                                // DLg do ktorej DLS z hlavicky ma vstupovat
	      _Nh_Chk_DALI := true;
			_NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=331);                      // hlavicka je namapovana na xPt
			xDLs	:= xPt;
   		yes 	:= false;
         dlma        := _Nh_DL_sha(ma:=1, nd := xF^.cf.n);          // master DEV hlavicke
         IF dlma = _Nh_DL_sha(gr:=1,ma:=1, nd := yIdxR.dev.n ) THEN       // master DLg a master DLs musia byt zhodne, inak je asi filter na vsetky DLc
         	dlGr  := _Nh_DL_sha(gr:=1,nd := yIdxR.dev.n)-100;              // cislo sceny 0..16 DLg z riadka
            dlsl  := _Nh_DL_sha(nd := xF^.cf.n);                           // cislo dls z hlavicky
            xDLg  := xDev;                                                 // scena je v riadku
  				ok3	:= true;
		   		yes   := xF^.rom = 0 OR xDLg^.cf.rom = xF^.rom;
         ELSIF set = false THEN
               yIdxR.chk   := false;
         END_IF;
	   END_IF;
	ELSIF yIdxR.dev.c = 43	THEN													// v riadku je DLs
   	IF xL^.obj = 12 THEN								// skupina Osvetlenie
    		yes   :=  xDev^.cf.cat = INT_TO_USINT(xF^.cf.n);                          	// len svetlo
	      _Nh_Chk_DALI := true;
		ELSIF xL^.obj = 55 THEN
			xDLs := xdev;
			IF _NhTypObr(cf:=43 ,typ:=xDev^.cf.typ ,dev := xF^.cf.c) THEN
				yes := true;
			ELSE
				yes := false;
			END_IF;
		
		END_IF;
	ELSE
//      _Nh_Chk_DALI := true;
		;
	END_IF;
	IF ok3 THEN
 		IF set THEN    																// ked sa robi check/uncheck s browsu	
   		xDLs^.cx.scn.grp[dlGr] := NOT xDLs^.cx.scn.grp[dlGr];   		
         IF xDLs^.cx.scn.grp[dlGr] THEN										// CHECK
         	IF xDLg^.cf.rom = 0 OR xDLg^.cf.rom = _NhDefRom THEN                                // CHECK a scena este nema ROM
            	xDLg^.cf.rom := xDLs^.cf.rom;                        // scene priradi ROM z DLs, hoci aj 0
          	ELSIF xDLs^.cf.rom = 0 OR xDLs^.cf.rom = _NhDefRom THEN
            	xDLs^.cf.rom := xDLg^.cf.rom;                        // scena ma rom, ale DLs nie, priradi DLg.rom -> DLs.Rom
            END_IF;
				IF xL^.vis THEN
    				xDLs^.cx.scn.lvl[ dlgr ] := REAL_TO_USINT(xDls^.al.in.val);	// priradi LVL dev v scen  podla aktualne nastavenej
				ELSE
    				xDLs^.cx.scn.lvl[ dlgr ] := 100;								// maximum
				END_IF;
    			i 								:= 1;
				xDLs^.cx.scn.grp[dlGr] 	:= true;
				xDLg^.cx.sta.Present		:= 1;
    		ELSE
				xDLg^.cx.sta.Present		:= 0;
            xDLs^.cx.scn.lvl[ dlgr ]:= 0;
				xDLs^.cx.scn.grp[dlGr] 	:= 0;
				i								:= 0;
    		END_IF;
      	_Nh_DL_ADD_Task(wht:=4, par:= i, sha := dlsl , val := dlGr+100, dlm := dlma  );
     	   _Nh_DL_ADD_Task(wht:=2, 	par := dlgr,  	//   scena		0..15
           									sha := dlsl,    //   ballast	0..63
                                    val := xDLs^.cx.scn.LVL[ dlgr ],
                                    dlm := dlma );
		ELSE
  			yIdxR.chk  := xDLs^.cx.scn.grp[dlGr];
			IF yIdxR.chk THEN
				xDLg^.cx.sta.Present := true;
			END_IF;
//   		yes   := xF^.rom = 0 OR xDLs^.cf.rom = xF^.rom;
     		IF xL^.fvz THEN                                                   // dev len s vazbou
       		yes   := yes AND yIdxR.chk;
       	END_IF;
		END_IF;			
	END_IF;
	{$END_IF}
END_FUNCTION


FUNCTION _Nh_Set_ONOFF {HIDDEN} : BOOL
  	VAR_INPUT
		set		: BOOL;
		obr		: INT;
  	END_VAR
	_Nh_Set_ONOFF := true;
   IF obr > 0 THEN
		;
	ELSIF set   THEN
		obr	:= 51;   	
   ELSE
		obr 	:= 49;                                    // aktivuje ON/OFF, ale nezapne
	END_IF;
	xU^.o[8].fn := obr;                                    // nastavit filter na zapnute
END_FUNCTION

(*
FUNCTION _Nh_IO_Filt_Fvz  : BOOL
  	VAR_INPUT
		go		: BOOL;
		n		: USINT;
  	END_VAR
	_Nh_IO_Filt_Fvz := false;
	IF go THEN
	   xF^.rom  		:= xPt^.cf.rom;                           // zacne s filtrom ROM
		xL^.fvz  		:= 0;		                                 // vypnute vazby
		xF^.dev.n[0]   := false;											// off
		FOR i := 0 TO 3 DO
			IF xPtIO^.dev.c > 0 THEN
				xF^.dev.n[0]   	:= true;									// vsetky DEV
				xL^.fvz     		:= true;                   		// filter ON
				xL^.fdv     		:= 0;                            // vsetky CAT
				xF^.rom  			:= 0;                            // vsetky ROM
				_Nh_IO_Filt_Fvz 	:= true;
				EXIT;
   		END_IF;
			xPtIO	:= xPtIO + SIZEOF(NH_VAL_IO);
	    END_FOR;
	END_IF;
END_FUNCTION
*)

FUNCTION _Nh_ADD_FIL_BRW  {HIDDEN} : BOOL                             // modifikuje filter HET,REK
   VAR_INPUT
      set   : BOOL   := true;                               // nastavi filter
      cf    : USINT;
      typ   : SINT;
   END_VAR
   _Nh_ADD_FIL_BRW := true;
   CASE cf OF
     6 : //HET
         IF set THEN
            CASE typ OF
               1 : // ROM priradi do het
                   xF^.dev.n[ 1]  :=1;
                   xF^.dev.n[16]  :=0;
                   xF^.dev.n[17]  :=0;
                   xF^.dev.n[18]  :=0;
              16 : // TER
                   xF^.dev.n[ 1]  :=0;
                   xF^.dev.n[16]  :=1;
                   xF^.dev.n[17]  :=0;
                   xF^.dev.n[18]  :=0;
              17 : // ROM priradi do het
                   xF^.dev.n[ 1]  :=0;
                   xF^.dev.n[16]  :=0;
                   xF^.dev.n[17]  :=1;
                   xF^.dev.n[18]  :=0;
              18 : // ROM priradi do het
                   xF^.dev.n[ 1]  :=0;
                   xF^.dev.n[16]  :=0;
                   xF^.dev.n[17]  :=0;
                   xF^.dev.n[18]  :=1;
              ELSE
                  _Nh_ADD_FIL_BRW := false;                  ;
            END_CASE;
         ELSE
            CASE typ OF
               1 : ;// ROM priradi do het
              16 : ;// TER
              17 : ;// ROM priradi do het
              18 : ;// ROM priradi do het
              ELSE _NH_ADD_FIL_BRW := false;                  ;
            END_CASE;
            IF _Nh_ADD_FIL_BRW THEN
               xF^.dev.n[ 1]  :=1;
               xF^.dev.n[16]  :=1;
               xF^.dev.n[17]  :=1;
               xF^.dev.n[18]  :=1;
            END_IF;
         END_IF;
   END_CASE;
END_FUNCTION

FUNCTION _Nh_Frm_Het_REQ_INI {HIDDEN}: BOOL		// presunie aktualne hodnoty HET do formulara
	VAR_INPUT
		out	: BOOL;
	END_VAR
	_Nh_Frm_Het_REQ_INI := true;
	// musi byt namapovana xHet;
	_NH_Het_Map_Reg();
	IF out THEN												// presuva hodnotu vysypu
		FOR i := 0 TO 3 DO
 			xM^.pod.po.cf.va[i] := USINT_TO_REAL(xRegMod^.out[i]);
    	END_FOR;
	ELSE
		xM^.pod.po.cf.va := xRegMod^.req;
	END_IF;
END_FUNCTION

FUNCTION _Nh_Frm_Het_Hys  {HIDDEN} : BOOL
	VAR_INPUT
		ven	: BOOL;        // vetranie/odvlhcenie - ma iny rozsah ako
   	het	: BOOL;			// ohrev - prvy interval je stupen 3, inak 0
		save	: BOOL;			// ulozit, inak nacitat
	END_VAR
	_Nh_Frm_Het_Hys := true;
	_NH_Het_Map_Reg();
	i		:= BOOL_TO_USINT( xR^.o.ob[0].Bgc=1 );    							// zobrazuje sa 0: ked klesa, 1: ked stupa
	het 	:= false;			
	IF xF^.cf.c = 47	THEN                       // HEV (vetranie/odvlhcenie)
		ven	:= true;		
	ELSIF xReg^.mode = 0 THEN							// kurenie
		het := true;
	END_IF;
	If save THEN
		IF aWeb.M[1].pod.po.p = 4 THEN
			IF het THEN										// kurenie zacina st.3									
				xRegMod^.hys[ i,3 ] := INT_TO_REAL(xPox^.cx.p[1].t - 30) / 10.;
				xRegMod^.hys[ i,2 ] := INT_TO_REAL(xPox^.cx.p[2].t - 30) / 10.;
				xRegMod^.hys[ i,1 ] := INT_TO_REAL(xPox^.cx.p[3].t - 30) / 10.;
			ELSE
				xRegMod^.hys[ i,1 ] := INT_TO_REAL(xPox^.cx.p[1].t - 30) / 10.;
				xRegMod^.hys[ i,2 ] := INT_TO_REAL(xPox^.cx.p[2].t - 30) / 10.;
				xRegMod^.hys[ i,3 ] := INT_TO_REAL(xPox^.cx.p[3].t - 30) / 10.;
			END_IF;
		END_IF;
	ELSE
		xPox^.cx.p[0].t := 0;            //-3
		xPox^.cx.p[4].t := 60;          //+3
		IF het THEN										// kurenie zacina st.3									
			xPox^.cx.p[0].o := 3;
			xPox^.cx.p[1].o := 2;
			xPox^.cx.p[2].o := 1;
			xPox^.cx.p[3].o := 0;
			xPox^.cx.p[4].o := 0;

			xPox^.cx.p[1].t := REAL_TO_INT(30.+xRegMod^.hys[i,3]*10.);				//-2
			xPox^.cx.p[2].t := REAL_TO_INT(30.+xRegMod^.hys[i,2]*10.);				//-1
			xPox^.cx.p[3].t := REAL_TO_INT(30.+xRegMod^.hys[i,1]*10.);				//-0
		ELSE                                	// chladenie, vetranie, odvlhcenie zacina st.1
			xPox^.cx.p[3].t := REAL_TO_INT(30.+xRegMod^.hys[i,3]*10.);				//-2
			xPox^.cx.p[2].t := REAL_TO_INT(30.+xRegMod^.hys[i,2]*10.);				//-1
			xPox^.cx.p[1].t := REAL_TO_INT(30.+xRegMod^.hys[i,1]*10.);				//-0

			xPox^.cx.p[0].o := 0;
			xPox^.cx.p[1].o := 1;
			xPox^.cx.p[2].o := 2;
			xPox^.cx.p[3].o := 3;
			xPox^.cx.p[4].o := 3;
		END_IF;
      FOR i := 5 TO 7 DO
			xPox^.cx.p[i].t := -1;
			xPox^.cx.p[i].o := 0;
      END_FOR;
	  	xM^.pod.po.p := -1;
		xM^.pod.po.x := -1;
	END_IF;
END_FUNCTION




(*
FUNCTION _Nh_Frm_Het_Hys : BOOL
	VAR_INPUT
		ven	: BOOL;        // vetranie/odvlhcenie - ma iny rozsah ako
   	het	: BOOL;			// ohrev - prvy interval je stupen 3, inak 0
		save	: BOOL;			// ulozit, inak nacitat
	END_VAR
	_NH_Het_Map_Reg();
	i		:= BOOL_TO_USINT( xR^.o.ob[0].Bgc=1 );    							// zobrazuje sa 0: ked klesa, 1: ked stupa
	het 	:= false;			
	IF xF^.cf.c = 47	THEN                       // HEV (vetranie/odvlhcenie)
		ven	:= true;		
	ELSIF xReg^.mode = 0 THEN							// kurenie
		het := true;
	END_IF;
	If save THEN
		IF aWeb.M[1].pod.po.p = 4 THEN
			xRegMod^.hys[ i,3 ] := INT_TO_REAL(xPox^.cx.p[1].t - 30) / 10.;
			xRegMod^.hys[ i,2 ] := INT_TO_REAL(xPox^.cx.p[2].t - 30) / 10.;
			xRegMod^.hys[ i,1 ] := INT_TO_REAL(xPox^.cx.p[3].t - 30) / 10.;
		END_IF;
	ELSE
		xPox^.cx.p[0].t := 0;            //-3
		xPox^.cx.p[1].t := REAL_TO_INT(30.+xRegMod^.hys[i,3]*10.);				//-2
		xPox^.cx.p[2].t := REAL_TO_INT(30.+xRegMod^.hys[i,2]*10.);				//-1
		xPox^.cx.p[3].t := REAL_TO_INT(30.+xRegMod^.hys[i,1]*10.);				//-0
		xPox^.cx.p[4].t := 60;          //+3

		IF het THEN										// kurenie zacina st.3									
			xPox^.cx.p[0].o := 3;
			xPox^.cx.p[1].o := 2;
			xPox^.cx.p[2].o := 1;
			xPox^.cx.p[3].o := 0;
			xPox^.cx.p[4].o := 0;
		ELSE                                	// chladenie, vetranie, odvlhcenie zacina st.1
			xPox^.cx.p[0].o := 0;
			xPox^.cx.p[1].o := 1;
			xPox^.cx.p[2].o := 2;
			xPox^.cx.p[3].o := 3;
			xPox^.cx.p[4].o := 3;
		END_IF;
      FOR i := 5 TO 7 DO
			xPox^.cx.p[i].t := -1;
			xPox^.cx.p[i].o := 0;
      END_FOR;
	  	xM^.pod.po.p := -1;
		xM^.pod.po.x := -1;
	END_IF;
END_FUNCTION
*)



{ $ END_IF }
