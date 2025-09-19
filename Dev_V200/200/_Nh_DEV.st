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
								rst	:= 	xDev^.al.in.cmd = 7 OR aSys.rst.Qr ,
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
								rst	:= 	xDev^.al.in.cmd = 7 OR aSys.rst.Qr,
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

(*FUNCTION _Nh_ROM  :BOOL  // ukladanie hodnot do ROM a nasledne do ZON
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



(*
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
*)
(*
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
	aSys.rst();
	aSys.rst.in	:= false;

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









