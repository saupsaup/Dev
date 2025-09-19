FUNCTION _Nh_Shw_FRM  {HIDDEN} : BOOL     // nadefinuje menu podla DEV a pristupovych prav usra
	VAR_TEMP
		init	: BOOL;
//		stat  : BOOL;
		kk		: USINT;
	END_VAR
	_Nh_Shw_FRM := false;
{ $ IFDEF __NH_WEB }

(*
						yTx2	:= CONCAT(	//UINT_TO_STRINGF(aSys.RestCyc,'%3u ; ')
												USINT_TO_STRINGF(xA^.tch.cmd,'%3u ; ' ),		
												USINT_TO_STRINGF(cmd,'%3u ' )	
											);		
						_Nh1RowTxt(logRst:=1);
*)


   rst   := false;
   IF xA^.tch.cmd = 101  THEN                                  // editacia nazvu
		cmd			:= 100;
		_Nh_Shw_FRM := true;
		RETURN;
	ELSIF xF^.cf.c <> 2 THEN
 		_NhxPt (c := xF^.cf.c, n := xF^.cf.n,x:=34);
		xDev := xPt;
	ELSE
		xDev	:= xHom;
	END_IF;
  	_NhxRom(c := 1, nr := xDev^.cf.rom,x:=34);
   IF xA^.tch.cmd = 204  THEN                                  // prvy vstup = nadefinovat menu
	   IF xF^.cf.c = 2 THEN
	   	_Nh_FRM_Read(frm:=232);
			_Nh_Lang(id := yFrm_232.cat[xF^.cf.n].txt ,txt := ADR( xL^.naz ), zn:=20);
  			xU^.o[2].fn 			:= yFrm_232.cat[xF^.cf.n].obr0;;                                 // cmd spat
			xU^.o[  xU^.n ].frm  := yFrm_232.cat[xF^.cf.n].frm;
      ELSIF aCfg[xF^.cf.c].mnu > 0 THEN
      	_Nh_FRM_Read(frm:=USINT_TO_UINT(aCfg[xF^.cf.c].mnu) );
         rst         := true;                                     // prvy vstup z BRW
			_NhTypObr(cf:=xF^.cf.c, typ:=xDev^.cf.typ);
	      xU^.o[2].fn := xObrWht^.obr;
			xU^.o[2].w	:= 72;
      END_IF;
		cmd			:= xA^.tch.cmd;
		xA^.tch.cmd := 205;
		init			:= true;
	   rst   		:= true;
		IF xB^.r[0].h.chk THEN
			IF xA^.tch.obj = 1 AND xB^.r[0].o.ob[4].cf.c > 0 THEN
//	     		xB^.r[0].o.ob[0].cf := xB^.r[0].o.ob[4].cf;         		// do [0] sa vlozi opacnne CF z vazby
	     		xB^.r[0].h.cf := xB^.r[0].o.ob[4].cf;         		// do [0] sa vlozi opacnne CF z vazby
			END_IF;
		END_IF;

   ELSIF xA^.tch.obj > 0 AND xA^.tch.mnu AND xU^.n  <> SINT_TO_USINT(xA^.tch.obj) THEN
      xU^.n       := SINT_TO_USINT(xA^.tch.obj);
      xA^.tch.mnu := false;
		xA^.tch.cmd := 205;
		init			:= true;
      rst         := xU^.n  <> SINT_TO_USINT(xA^.tch.obj);
   ELSIF xA^.tch.cmd = 206  THEN                                  // prvy vstup z HOME DASH {Meteo,Typovy den}
		init			:= true;
	   rst   		:= true;
      xA^.tch.mnu := false;
		xA^.tch.cmd := 205;
   ELSIF xA^.tch.cmd = 207  THEN                                  // refresh = navrat z inej pocedury, ked je uz vsetko nadefinovane
		_Nh_Shw_FRM := false;
		xA^.tch.cmd := 205;

(*
   ELSIF xA^.tch.cmd = 208  THEN                                  // nadefinovanie FRM bez dalsieho menu
		_Nh_Shw_FRM := false;
   ELSIF xA^.tch.cmd = 209  THEN                                  // nadefinovanie FRM bez dalsieho menu
//		_Nh_Shw_FRM_209();
		RETURN;
*)
   ELSE
		xA^.tch.cmd := 0;
		rst			:= false;
   END_IF;

   xR          := ADR(xB^.r[ 1 ]);                             // default namapovat riadok[1], v ktorom su objekty
   // nevstupuje sa ak sa edituje menu
	IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
      _NheBrw(7);
		xR^.h 		:= xB^.r[0].h;											// preberie celu vazbu, dolezite je .chk
		xR^.h.cf 	:= xF^.cf;                                   // preberie hlavicku aj s parametrom - dolezite pre
		IF xA^.tch.cmd = 206 THEN
			;
		ELSE
   	   // spolocne menu pre to iste CFG ale iny typ
	      CASE aCfg[xF^.cf.c].mnu  OF
				4:  // DLm,DLs,DLg - 9-SW.par (aj pre SVD,SVA...), 1=HW.par, 2=tools (vymazat adresy), 44=setup aje pre SVA...
//					IF xB^.r[0].h.cf.c = 43 AND xB^.r[0].h.cf.p = 0 THEN		// do Dls sa vstupilo z vazby k DLg alebo inde bez par
	    			IF xA^.admin = false THEN
    					xU^.o[4].fn := 0;                                  // HW NIE JE
    					xU^.o[5].fn := 0;                                  // TOOL nie je
					END_IF;
					IF xF^.cf.c=42 THEN												// DLm
    					xU^.o[4].fn := 0;                                  // HW NIE JE
   	 				xU^.o[7].fn := 0;                                  // colcotE
//	    				xU^.o[8].fn := 0;                                  // SETUP nie je
						IF xU^.n = 4 OR xU^.n = 7 THEN
							xU^.n  	:= 3;
						END_IF;
					ELSIF xB^.r[0].h.cf.c = 44 THEN		// do Dls sa vstupilo z vazby k DLg alebo inde bez par
    					xU^.o[4].fn := 0;                                  // HW NIE JE
    					xU^.o[5].fn := 0;                                  // tools
   	 				xU^.o[7].fn := 0;                                  // colcotE
//	    				xU^.o[8].fn := 0;                                  // SETUP nie je
						IF xU^.n = 4 OR xU^.n = 5 OR xU^.n = 7 THEN
							xU^.n  	:= 3;
						END_IF;
					END_IF;
			  		  				
			  24:  // ZON
         	   IF cmd = 204 AND xL^.psn THEN                            				
      	      	xU^.n       := 7;                                  // nastavi sa na menu PSN
   	         END_IF;

			  25:  // ROM
	            IF cmd = 204 AND xL^.psn THEN                            				
   	         	xU^.n       := 7;                                  // nastavi sa na menu PSN
      	      END_IF;

			  27:	// WSB/TGL/TLA
					CASE xF^.cf.c OF
                 13:	//WSB
							xU^.o[5].fn := 0;		
							xU^.o[6].fn := 0;		
                 14:	// TLA
							xU^.o[4].fn := 0;		
							xU^.o[5].fn := 0;		
							xU^.o[6].fn := 0;		
							If cmd = 204 THEN
	     						xU^.n 		:= 7;					
							END_IF;
               END_CASE;			  		
			  		IF xB^.r[0].h.chk = false THEN
						xU^.o[3].fn := 0;												// play sa vyradi
					ELSIF cmd = 204 THEN
     					xU^.n 		:= 3;					
			  		END_IF;

		  	  28:  // regulator HET, HEV
         	   IF rst THEN                            // uz sme v menu, len ina volba
      	         xHet  := xDev;
			      	IF xB^.r[0].h.chk  THEN
            	      FOR i := 5 TO 8 DO
         	            xU^.o[i].fn := 0;                                  // predvolby nie su
      	            END_FOR;
        	            xU^.o[3].frm 	:= 83;               						// FRM predvolby v chceck
	                  xU^.n       	:= 3;
               	ELSIF xHet^.me.pvm.p.prg THEN
            	      xU^.n       := 5;
         	      ELSE
      	            xU^.n       := 4;
   	            END_IF;
	            END_IF;
	        36:   // TVE,VeN, REK
					CASE xF^.cf.c OF
                  9: // CER
	      	         xU^.o[6].fn 	:= 0;
                 23: // VEN
	      	         xU^.o[6].fn 	:= 0;                               // VEN nema ochranu
   	   	         xU^.o[8].frm	:= 29;                              // VEN ma iny setup
               END_CASE;
	      END_CASE;
      // vynimky FRM
		END_IF;


      _Nh_FRM_Read(frm:=USINT_TO_UINT(xU^.o[ xU^.n ].frm) );

      CASE xU^.o[  xU^.n ].frm OF
        0:  ;

        2:  // FRM-DALI-M vymazat adresy, pridat nove             bez parametra
            // FRM DLs/DLg vymazat jednu adresu

		  9:  // FRM-PAR   SVD,SVA/RGB/DALI/ZAS/SCN
				IF xF^.cf.p = 0 THEN
					xF^.cf.p := xDev^.cf.par;
				END_IF;		
            IF xA^.usr = 1 THEN
               xR^.o.ob[10].fmt := CONCAT( USINT_TO_STRING(aCfg[xF^.cf.c].par)
                                          ,'p',INT_TO_STRING(xF^.cf.p)) ;
            ELSE
               xR^.o.ob[10].wh := 0;
            END_IF;
            _NhxPar(cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-1007);
            _Nh_DEF_SLD(s:=0,v:=ADR(xPar^.all.lvl), off:=aCfg[xF^.cf.c].analog = false);              // lvl sa zobrazuje aj pri SVD,ZAS....
(*
				IF aCfg[xF^.cf.c].lvl254 THEN
//    				xB^.s[ 0 ].fmt := 'L' + xB^.s[ 0 ].fmt;
    				xB^.s[ 0 ].v2 := 254.0;                         // ine ako DALI maju max 100%
					xPar^.all.lvl	:= MIN(xPar^.all.lvl,254);
      		ELSE
               xB^.s[ 0 ].v2  := 100.0;                         // ine ako DALI maju max 100%
//               xB^.s[ 0 ].ink := 1.0;                            // digitalne maju 0-100
					xPar^.all.lvl	:= MIN(xPar^.all.lvl,100);
				END_IF;
*)				

               xB^.s[ 0 ].v2  := 100.0;                         // ine ako DALI maju max 100%
					xPar^.all.lvl	:= MIN(xPar^.all.lvl,100);

				
				
    			_Nh_DEF_SLD(off := NOT aCfg[xF^.cf.c].sld , o:= 1, s:=1,v:=ADR(xPar^.sva.rUp));
            _Nh_DEF_SLD(off := NOT aCfg[xF^.cf.c].sld , o:= 2, s:=2,v:=ADR(xPar^.sva.rDn));
				ok 	:= 1; 		// vypnut po case
				ok1 	:= 1;			// vykonat s opozdenim
//				ok2 	:= 0;			// wsb blokuje PIR

				IF xB^.r[0].h.chk THEN                                // z vazby
(*
               IF xL^.Fil.typ = 1 THEN  									// dotyk na hlavnej ikone  [1]
                  i := xB^.r[0].o.ob[4].cf.c;              			// zisti sa co je vo vazbe [4]
               ELSE                                               // dotyk na [4]
                  i := xB^.r[0].h.cf.c;                    			// vazba je v [1]
               END_IF;
*)
					i := xB^.r[0].h.cf.c;
					IF aCfg[i].tgrp = 13 THEN						         // WSB,TLA,TGL
//           	  		ok2 	:= 1;
					ELSIF i = 35 THEN                            		// blikac
           	  		ok 	:= 0;					
					END_IF;
   			ELSE
//					ok2 	:= 1;			// wsb blokuje PIR   			
	         END_IF;
  									
  				IF ok THEN
	           	_Nh_DEF_SLD(s:=3,v:=ADR(xPar^.all.tOff));          // vypnut po case
		         _Nh_DEF_VAR(o:= 4, x:=ADR(xPar^.all.rPir));			// pohyb resetuje case
   			ELSE
					xR^.o.ob[ 3 ].wh 	:= 0;										
					xR^.o.ob[ 4 ].wh 	:= 0;										
					xPar^.all.tOff := 0;
  				END_IF;
  				IF ok1 THEN
	            _Nh_DEF_SLD(s:=5,v:=ADR(xPar^.all.tDelay));
   			ELSE
					xR^.o.ob[ 6 ].wh 		:= 0;										
					xPar^.all.tDelay  := 0;
  				END_IF;
  				IF ok2 THEN
		         _Nh_DEF_VAR(o:= 7, x:=ADR(xPar^.all.BlPirOff));                     	// vazba blokuje pir po vypnuti 	
	 	         _Nh_DEF_SLD(o:= 8,s:=6,v:=ADR(xRom^.cx.BlPirOff));
		         _Nh_DEF_VAR(o:= 9, x:=ADR(xPar^.all.BlPirOn));                     	// vazba blokuje pir po zapnuti	
   			ELSE
					xR^.o.ob[ 7 ].wh 			:= 0;										
					xR^.o.ob[ 8 ].wh 			:= 0;										
					xR^.o.ob[ 9 ].wh 			:= 0;															
					xPar^.all.BlPirOff   	:= 0;
					xPar^.all.BlPirOn    	:= 0;
  				END_IF;
            _Nh_DEF_SLD(s:=4,v:=ADR(xDev^.cx.all.tMaxON));

		 16:  // PSN ROM/ZON
				xRom	:= xDev;
				xLck  := ADR(xRom^.cx.lck);
	         _Nh_DEF_VAR(o:=0,x:=ADR(xLck^.LockRom));									// pohyb resetuje case
           	_Nh_DEF_SLD(s:=0,v:=ADR(xLck^.tdOu));
           	_Nh_DEF_SLD(s:=1,v:=ADR(xLck^.tdIn));
           	_Nh_DEF_SLD(s:=2,v:=ADR(xLck^.tDog));
           	_Nh_DEF_SLD(s:=3,v:=ADR(xLck^.tNar));
           	_Nh_DEF_SLD(s:=4,v:=ADR(xLck^.tRst));
				IF xB^.r[0].h.cf.c = 3 THEN                                			// zona
		         _Nh_DEF_VAR(o:=6, wh:= 20,x:=ADR(xLck^.FromZone));					// Prepísat do miestností v zóne 				
					IF xB^.r[0].h.cf.n = 1 THEN												// domcek
	               xR^.o.ob[6].fn := 422;                                      // Prepísat do všetkých zón
					END_IF;
				ELSE
		         _Nh_DEF_VAR(o:=7, wh:= 20,x:=ADR(xLck^.FromZone));					// Použit hodnoty z vyššej zóny
				END_IF;


        35:  // FRM - TER
    	     	xTer := xDev;
           	_Nh_DEF_SLD(s:=0,v:=ADR(xTer^.cx.kor));
          	_Nh_DEF_SLD(s:=1,v:=ADR(xTer^.cx.hys));
           	_Nh_DEF_SLD(s:=2,v:=ADR(xTer^.cx.fil));
           	_Nh_DEF_SLD(s:=3,v:=ADR(xTer^.cx.sample));
            _Nh_DEF_VAR(o:=9, x:=ADR(xTer^.cx.BlkDefRom));
            _Nh_DEF_VAR(o:=10, x:=ADR(xTer^.cf.blk));



    	  29:  // FRM - setup VEN/REK
				xTve        := xDev;
	         xOh         := ADR(xR^.o.ob[0]);
   	      xOh^.aVar   := PTR_TO_UDINT(ADR(xTve^.cf.typ));
	         _Nh_DEF_VAR(o:=8, x:=ADR(xDev^.cf.Blk));
	         _Nh_DEF_SLD(s:=0, v:=ADR(xTve^.cx.guard.tRun));
	         _Nh_DEF_SLD(s:=1, v:=ADR(xTve^.cx.reg.Delay));

    	  37:  // FRM - setup TVE
				xTve        := xDev;
	         xOh         := ADR(xR^.o.ob[0]);
   	      xOh^.aVar   := PTR_TO_UDINT(ADR(xTve^.cf.typ));

	         _Nh_DEF_VAR(o:=2, x:=ADR(xTve^.cf.inv));               	// NO-NC len u TV ON/OFF aj REAL
//   	      _Nh_DEF_VAR(o:=3, x:=ADR(xTve^.cx.OutIsReal));          	// NO-NC len u TV ON/OFF aj REAL
	         _Nh_DEF_VAR(o:=4, x:=ADR(xTve^.cx.reg.PWM));               	
	         _Nh_DEF_VAR(o:=7, x:=ADR(xDev^.cf.LogAct));	
	         _Nh_DEF_VAR(o:=8, x:=ADR(xDev^.cf.Blk));
	         _Nh_DEF_VAR(o:=9, x:=ADR(xDev^.cf.DevExt));	

	         _Nh_DEF_SLD(s:=0, v:=ADR(xTve^.cx.guard.tRun));
	         _Nh_DEF_SLD(s:=1, v:=ADR(xTve^.cx.reg.Delay));

    	  38:  // FRM - TVE - ochranne teploty
         	xTve := xDev;
				_Nh_DEF_VAR(o:= 0, x:=ADR(xTve^.cx.reg.Guard));				// PV-1 je ON pre VEN         	
         	_Nh_DEF_SLD(s:=0, v:=ADR(xTve^.cx.guard.val[0,0]));
         	_Nh_DEF_SLD(s:=1, v:=ADR(xTve^.cx.guard.val[0,1]));
         	_Nh_DEF_SLD(s:=2, v:=ADR(xTve^.cx.guard.tDis));
         	_Nh_DEF_SLD(s:=3, v:=ADR(xTve^.cx.guard.val[1,0]));
         	_Nh_DEF_SLD(s:=4, v:=ADR(xTve^.cx.guard.val[1,1]));
				_Nh_DEF_SLD(s:=6, v:=ADR(xTve^.cx.guard.eMax));
				

(*
           	(wh:=6 , x:=xc,       y:= y1 + 60,  w:= 400, h:=28, Fgc:=4, fn:=2, nTch:=1, cf:=(n:=47)),   		// Teplotna ochrana-kurenie
            (wh:=13, x:= 50     , y:= y1 + 200,   w:= x2-110 , FgC := 4, BgC := 4, fn := 0),              	// min teplota
            (wh:=13, x:= 50     , y:= y1 + 280,   w:= x2-110 , FgC := 4, BgC := 7, fn := 1),              	// max.teplotoa
            (wh:=13, x:= 50     , y:= y1 + 360,   w:= x2-110 , FgC := 4, BgC := 8, fn := 2),              	// Optimalna teplota - zelena
           	
	  			(wh:=6 , x:=xc,       y:= y1 + 450,  w:= 400, h:=28, Fgc:=3, fn:=2, nTch:=1, cf:=(n:=580)),  		// Teplotna ochrana-chladenie
            (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 4, fn := 3),              	// min teplota
            (wh:= 0, x:= 50     , y:= y1 + 680,   w:= x2-110 , FgC := 4, BgC := 7, fn := 4),              	// max.teplotoa
            (wh:= 0, x:= 50     , y:= y1 + 760,   w:= x2-110 , FgC := 4, BgC := 8, fn := 6),              	// Optimalna teplota - zelena


            (wh:=13, x:= 50     , y:= y1 + 850,   w:= x2-110 , FgC := 4, BgC := 3, fn := 6)             		// max cas zapnutia


				IF xA^.admin THEN
					xPtUi := ADR(xTve^.me.cntOn);
					FOR j := 5 TO 7 DO
		         	_Nh_DEF_SLD(o:= j, s := INT_TO_USINT(xR^.o.ob[j].fn), v:=xPtUi);			
						xPtUi := xPtUi + 2;	
               END_FOR;
				END_IF;
*)
		  40:  // FRM - parametre blikaca
	         xBlk  := xDev;
   	      xPtU  := ADR(xBlk^.cx.nBlk);                  // jas LED
      	   FOR i := 0 TO 3 DO                           // 0..3 su USINT
         	   _Nh_DEF_SLD(s:=i ,v := xPtU);
            	xPtU := xPtU + 1;
	         END_FOR;
   	      xPtUi := ADR(xBlk^.cx.tUp);
      	   FOR i := 4 TO 6 DO                           // 3..5 su UINT
         	   _Nh_DEF_SLD(s:=i ,v := xPtUi);
            	xPtUi := xPtUi + 2;
	         END_FOR;
   	      _Nh_DEF_VAR(o:= 3, x:=ADR(xBlk^.cx.lOwn));
      	   _Nh_DEF_VAR(o:= 8, x:=ADR(xBlk^.cx.OffS));
         	_Nh_DEF_VAR(o:= 9, x:=ADR(xBlk^.cx.OffE));
	     42:  // FRM - blikaca - pocet serii
   	      xBlk  := xDev;
      	   _Nh_DEF_SLD(s:=0 ,v := ADR(xBlk^.cx.nSer));
         	_Nh_DEF_SLD(s:=1 ,v := ADR(xBlk^.cx.lSer));
	         _Nh_DEF_SLD(s:=2 ,v := ADR(xBlk^.cx.tSer));
   	      _Nh_DEF_SLD(s:=3 ,v := ADR(xBlk^.cx.tMax));

    	  50:  // FRM - ALA setup
				xAla 	:= xDev;
   	      _Nh_DEF_VAR(o:= 0, x:=ADR(xAla^.cx.Qr));
   	      _Nh_DEF_VAR(o:= 1, x:=ADR(xAla^.cx.pir));

(*
				xPtB 	:= ADR(xAla^.cx.Qr);
				ix	  	:=	SINT_TO_INT(xAla^.cf.typ);
				FOR i := 0  TO 3 DO
	   	      _Nh_DEF_VAR(o:= i, x:=xPtB);
					xPtb := xPtB + 1;
      	   END_FOR;
*)
				IF xAla^.cf.typ = 2 THEN
	   	      _Nh_DEF_VAR(o:= 2, wh:=20, x:=ADR(xAla^.cx.dogOff));
   		      _Nh_DEF_VAR(o:= 3, wh:=20, x:=ADR(xAla^.cx.alaRst));
				END_IF;
//            xR^.o.ob[0].fn    := xR^.o.ob[0].fn + ix;
   	      _Nh_DEF_SLD(s:=0 ,v := ADR(xAla^.cx.PirFilt));

    	  51:  // FRM - GATE param
				xGat	:= xDev;
            IF xA^.usr = 1 THEN
               xR^.o.ob[10].wh := 6;
               xR^.o.ob[10].fmt := CONCAT( USINT_TO_STRING(aCfg[xF^.cf.c].par)
                                          ,'p',INT_TO_STRING(xF^.cf.p)) ;
            END_IF;
            _NhxPar(cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-1008);
				pGat := xPar;
				IF  xGat^.cf.typ < 2 THEN											// garaz,brana
	            _Nh_DEF_SLD(o:=0,		s:=0,v:=ADR(pGat^.all.lvl));
					IF xF^.cf.p = xGat^.cf.par THEN
						pGat^.all.tDelay := 0;
					ELSE
		            _Nh_DEF_SLD(o:=1,		s:=1,v:=ADR(pGat^.all.tDelay));
					END_IF;
	            _Nh_DEF_SLD(o:=2,		s:=2,v:=ADR(pGat^.gat.tCloseUNL));
   	         _Nh_DEF_SLD(o:=3,		s:=3,v:=ADR(pGat^.gat.tCloseLCK));
	   	      _Nh_DEF_VAR(wh:=20, 	o:=4, x:=ADR(pGat^.all.rPir));
				END_IF


    	  52:  // FRM - GATE setup

				xGat	:= xDev;
            _Nh_DEF_SLD(o:=0, s:=0,v:=ADR(xGat^.cx.tImp));
				IF  xGat^.cf.typ < 2 THEN											// garaz,brana
	            _Nh_DEF_SLD(o:=1, s:=1,v:=ADR(xGat^.cx.tRev));
	            _Nh_DEF_SLD(o:=2, s:=2,v:=ADR(xGat^.cx.tOpenClose[1]));
   	         _Nh_DEF_SLD(o:=3, s:=3,v:=ADR(xGat^.cx.tOpenClose[2]));
				END_IF;
				IF xGat^.io[0].dev.c > 0 THEN
		         _Nh_DEF_VAR(wh:=20, o:=4, x:=ADR(xGat^.cx.HwEndUse));
		         _Nh_DEF_VAR(wh:=20, o:=5, x:=ADR(xGat^.cx.HwEndOpen));
      		END_IF;
				IF xGat^.hw.d[2] > 0 THEN
		         _Nh_DEF_VAR(wh:=20, o:=6, x:=ADR(xGat^.cx.RelayClose));
		         _Nh_DEF_VAR(wh:=20, o:=8, x:=ADR(xGat^.cx.MotIsreal[2]));
      		END_IF;
	         _Nh_DEF_VAR(o:=7, x:=ADR(xGat^.cx.MotIsreal[0]));
	         _Nh_DEF_VAR(o:=9, x:=ADR(xDev^.cf.LogAct));	
	         _Nh_DEF_VAR(o:=10, x:=ADR(xDev^.cf.Blk));


    	  55:  // FRM - pir,dor,win
				xDor	:= xDev;
            _Nh_DEF_SLD(s:=0, v:=ADR(xDor^.cx.fUnLock));
            _Nh_DEF_SLD(s:=1, v:=ADR(xDor^.cx.fLock));
            _Nh_DEF_SLD(s:=2, v:=ADR(xDor^.cx.tOffRst));

	         _Nh_DEF_VAR(o:=0, x:=ADR(xDev^.cf.inv));
	         _Nh_DEF_VAR(o:=2, x:=ADR(xDev^.cf.psn));
	         _Nh_DEF_VAR(o:=5, x:=ADR(xDor^.cx.tam1));
	         _Nh_DEF_VAR(o:=6, x:=ADR(xDor^.cx.tam2));
	         _Nh_DEF_VAR(o:=7, x:=ADR(xDev^.cf.LogAct));
	         _Nh_DEF_VAR(o:=8, x:=ADR(xDev^.cf.blk));
	         _Nh_DEF_VAR(o:=9, x:=ADR(xDev^.cf.DevExt));

        49:  // SETUP v strede n:=8 (ALA...)

		  56:  // setup+rom - default je frm 55=PIR
				CASE xF^.cf.c OF
              49: xU^.o[3].frm := 70;							// ventil vody
            ELSE
            ;
            END_CASE;

        58:  // FRM - LUX/CO2/CO
    	     	xLux := xDev;
           	_Nh_DEF_SLD(s:=0,v:=ADR(xLux^.cx.koef));
          	_Nh_DEF_SLD(s:=1,v:=ADR(xLux^.cx.Dark));
           	_Nh_DEF_SLD(s:=2,v:=ADR(xLux^.cx.Sun));
          	_Nh_DEF_SLD(s:=3,v:=ADR(xLux^.cx.hys));
        	   _Nh_DEF_SLD(s:=4,v:=ADR(xLux^.cx.fil));
        	   _Nh_DEF_SLD(s:=5,v:=ADR(xLux^.cx.sample));

				_Nh_DEF_VAR(o:= 9, x:=ADR(xLux^.cx.BlkDefRom));
				IF xB^.r[0].h.cf.c = 19 THEN                          // LUX
					xB^.r[1].o.ob[10].fn := 608;								// zablokovat ak sa v miestnosti svieti
	            _Nh_DEF_VAR(o:=10, x:=ADR(xLux^.cx.BlkLuxRom));
				ELSe
	            _Nh_DEF_VAR(o:=10, x:=ADR(xLux^.cf.blk));
				END_IF;
//            xB^.r[2].o.ob[i].nTch := false;                       // zviditelni vsetko do RR.MM.DD  HH:MM
            CASE xB^.r[0].h.cf.c OF
              41 :   // COX
                     xB^.s[1].v1 := 0.0; xB^.s[1].v2 := 5000.0;
                     xB^.s[2].v1 := 0.0; xB^.s[2].v2 := 5000.0;
            END_CASE;

    	  60:  // FRM - pir,dor,win
				CASE xB^.r[0].h.cf.c OF
              	19:	xLux 	:= xDev;
              			xHw	:= ADR(xLux^.hw);
              ;
            ELSE xHw := ADR(xDev^.hw);
            ;
            END_CASE;
	         xOh         := ADR(xR^.o.ob[0]);
   	      xOh^.aVar   := PTR_TO_UDINT(ADR(xHw^.typ));

    	  61:  // FRM - setup/typ dali slave
				xDLs			:= xDev;
				IF xF^.cf.c=43 THEN												// DLs
	         	xOh         := ADR(xR^.o.ob[0]);
   	      	xOh^.aVar   := PTR_TO_UDINT(ADR(xDev^.cf.typ));
				ELSE
					xR^.o.ob[0].wh:=0;
					xR^.o.ob[1].wh:=0;
					xR^.o.ob[8].wh:=0;
				END_IF;
				IF xF^.cf.c=42 THEN												// DLs
					xR^.o.ob[9].fn:=615;
					xR^.o.ob[7].wh:=0;
					xDLs^.cf.LvlOnRst := false;
				END_IF;	
	         _Nh_DEF_VAR(o:=7,  x:=ADR(xDLs^.cf.LvlOnRst));
	         _Nh_DEF_VAR(o:=8,  x:=ADR(xDLs^.cx.cfg.out5inOne));
	         _Nh_DEF_VAR(o:=9, x:=ADR(xDLs^.cf.LogAct));
	         _Nh_DEF_VAR(o:=10, x:=ADR(xDLs^.cf.blk));


    	  62:  // FRM - RGBWA - dali
				xDLs	:= xDev;
				 _NhxPar(cp := aCfg[xF^.cf.c].par, np := xDls^.cf.par ,x:=250 );
				xPtU	:= ADR(xPar^.rgb.lvl[1]);
				FOR i := 0  TO 4 DO
	            _Nh_DEF_SLD(s:=i,v:=xPtU);
					xPtU := xPtU + 1;
            END_FOR;

		  71:  // casovac
					IF xU^.n > 2 THEN			
						;
					ELSIF xDev^.cf.typ = 6 THEN
						xU^.n := 6;									
			  		ELSIF xDev^.cf.typ > 3 THEN
						xU^.n := 5;
		  			ELSIF xDev^.cf.typ > 1 THEN
						xU^.n := 4;
					ELSE
						xU^.n := 3;	
					END_IF;

       70:  // ventil vody
				xVvo			:= xDev;
	         xOh         := ADR(xR^.o.ob[0]);
   	      xOh^.aVar   := PTR_TO_UDINT(ADR(xVvo^.cf.typ));
           	_Nh_DEF_SLD(s:=0,v:=ADR(xVvo^.cx.impulz));
	         _Nh_DEF_VAR(o:=3,  x:=ADR(xVvo^.cf.LvlOnRst));
	         _Nh_DEF_VAR(o:=4,  x:=ADR(xVvo^.cf.blk));

		88:  // WSB - set parametre (pocet clickov, cakanie )
				CASE xF^.cf.c OF
              14:	// TLA
               xTla 	:= xDev;
					xCfc	:= ADR(xTla^.cx.cfc);
            ELSE
               xWsb 	:= xDev;
					xCfc	:= ADR(xWsb^.cx.cfc);
          	END_CASE;
	      	_Nh_DEF_SLD(s:=1, v:=ADR(xCfc^.Click));
	      	_Nh_DEF_SLD(s:=2, v:=ADR(xCfc^.Press));
	      	_Nh_DEF_SLD(s:=3, v:=ADR(xCfc^.Hold));
            _Nh_DEF_VAR(o:=9, x:=ADR(xDev^.cf.blk));

    	  89:  // FRM - TGL-co zobrazit
				xTgl        := xDev;
	         xOh         := ADR(xR^.o.ob[1]);
   	      xOh^.aVar   := PTR_TO_UDINT(ADR(xTgl^.cx.cfd.WhtDisp));
    	
		  90:  // TGL/WSB - priradit akciu ko clicku
     			_NhxPar (cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-21);
				pWsb 	:= xPar;
				CASE xF^.cf.c OF
              14:	// TLA
               xTla 	:= xDev;
					xCfc	:= ADR(xTla^.cx.cfc);
            ELSE
               xTgl 	:= xDev;
					xCfc	:= ADR(xTgl^.cx.cfc);
            END_CASE;
				_NhTypObr(cf:=xF^.cf.c, typ:=xDev^.cf.typ);
				xB^.r[1].o.ob[0].fn := xObrWht^.obr;

				// riadkove menu + sablona
	         xOh         := ADR(xR^.o.ob[8]);
   	      xOh^.aVar   := PTR_TO_UDINT(ADR(xR^.o.ob[2].cf.c));   		// cmd z riadka
				_Nh_Get_Frm260( cf:=xB^.r[0].h.cf.c, nd:= xB^.r[0].h.cf.n, grp:=aCfg[ xB^.r[0].h.cf.c ].mWsb );
				_Nh_SHV_INFO(o:=10);					// zobrazit cislo par

    	  91:  // FRM - SCN
				xDLs			:= xDev;
         	xOh         := ADR(xR^.o.ob[1]);
  	      	xOh^.aVar   := PTR_TO_UDINT(ADR(xDev^.cf.typ));
(*
					xR^.o.ob[0].wh:=0;
					xR^.o.ob[1].wh:=0;
					xR^.o.ob[8].wh:=0;
				END_IF;
*)
	         _Nh_DEF_VAR(o:=8, x:=ADR(xDLs^.cf.LogAct));
	         _Nh_DEF_VAR(o:=9, x:=ADR(xDLs^.cf.blk));

    	  92:  // FRM - ACT
				xDLs			:= xDev;
         	xOh         := ADR(xR^.o.ob[1]);
  	      	xOh^.aVar   := PTR_TO_UDINT(ADR(xDev^.cf.typ));
	         _Nh_DEF_VAR(o:=8, x:=ADR(xDLs^.cf.LogAct));
	         _Nh_DEF_VAR(o:=9, x:=ADR(xDLs^.cf.blk));

		END_CASE;
	ELSe
		_NhIsObrOk(frm:=USINT_TO_UINT(xU^.o[ xU^.n ].frm));				// krd jr otvoreny FRM a nieco {napr.zalohovanie RAM} prepise obj, toto kontroluje cislo a pripadne len natiajne data
	END_IF;

   // tu je uz namapovany FRM, ide sa sem pri zmenach, podla toho, ktory FRM to potrebuje. Slidery nepotrebuju
   CASE xU^.o[  xU^.n ].frm OF
      0:  ;
	  69:

      1:  // FRM-DLS/DLg-HW
        {$IFDEF __NH_DALI}
				_Nh_Frm_SCR_DLpar();
				IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
	            IF xA^.usr = 1 THEN      					// len ino naspodku dls/dlm
   	            xR^.o.ob[9].wh    := 6;
      	         xR^.o.ob[9].cf.c  := 254;
         	      xR^.o.ob[9].w     := 200;
            	   xR^.o.ob[9].y     := 1020;
	               xR^.o.ob[9].fmt   := CONCAT(USINT_TO_STRING(dlsl),'#',USINT_TO_STRING(dlma)) ;
   	         END_IF;
      	      xDLpar            := ADR(xR^.o.ob[10]);                              // tu budu data parametrov DLS,DLg....
	            xDLpar^.wh        := 0;
   	         xPtU     			:= ADR(xDLpar^.par[3]);
			      // par :  ARRAY[1..8] OF USINT;  	// 1.LVL 2.FADE.TIME 3.FADE_RATE 4.min LVL 3.HW min LVL 6.MAx LVL 7.LVL po rest. 8.LVL on Error				
	            FOR i := 1 TO 8  DO
   	            ix    := xR^.o.ob[i].fn;                                          // CISLO SLIDERA
      	         xB^.s[ ix ].vb := PTR_TO_UDINT(ADR(xDLpar^.par[i]));
						IF xF^.cf.c = 44 AND i > 3 THEN
	   	            xR^.o.ob[i].wh := 0;
						END_IF;
	            END_FOR;
//   	         xDLpar^.par[1] := _Nh_100_254(xDev^.al.in.val);
					IF xF^.cf.c = 42 THEN                                     				// ide sa z mastra, alebo DLG
   	            xR^.o.ob[5].wh := 0;
					ELSE
						FOR i := 1 TO 8 DO
		    				_Nh_DL_ADD_Task(wht:=3 ,dlm :=dlma ,sha:=dlsl, sh2:=dlsl ,par:=INT_TO_USINT(xR^.o.ob[i].cf.p), web:=true);    // zakladne parametre DLg/DLs
                  END_FOR;
					END_IF;
				ELSE
	      		IF xR^.o.ob[1].tch   THEN                            										// drzime slider ActLvl
						IF xA^.tch.Qf OR (xDlfb^.cmd[1].cmd = 0 AND SYSTEM_S.F_EDGE_500MS)  THEN         // pustenie slideru alebo je volno alebo vzdy po 500ms
							IF xA^.tch.Qf THEN
								xR^.o.ob[1].tch := false;
							END_IF;
         	      	xDev^.al.in.val :=  ROUND(USINT_TO_REAL(MIN(254,xDLpar^.par[1])) / 2.54);
         	      	xDev^.al.ou.val := xDev^.al.in.val;
      	         	_Nh_DL_ADD_Task(wht:=1, sha:=dlsl, lvl := xDev^.al.in.val, dlm:=dlma);        // nastavit LVL ballastu
						END_IF;
					ELSE
	            	FOR i := 2 TO 8 DO
   	      	      IF xR^.o.ob[i].tch AND xA^.tch.Qf THEN                                     // parametre len po pustenie slidera
								IF xA^.tch.Qf THEN
									xR^.o.ob[i].tch := false;
   		   	            _Nh_DL_ADD_Task(wht := 2, sha := dlsl, par := INT_TO_USINT(xR^.o.ob[i].cf.p), val := xDLpar^.par[i], dlm :=dlma );
									EXIT;
								END_IF;
      		         END_IF;
   	      	   END_FOR;
					END_IF;
			END_IF;
//				yDLpar := xDLpar^;
        {$END_IF}


     2:  // FRM- TOOLS : DALI-M, DLS
        {$IFDEF __NH_DALI}
				_Nh_Frm_SCR_DLpar();
				IF init  THEN                        										// pri prvom vstupe do FRM.
					xB^.r[0].o.ob[10].wh	:= 0;
            	IF xF^.cf.c = 42 THEN
						xB^.r[0].o.ob[10].FgC	:=  0;											// toto sa pouzije, pre adresy, lebo uz dalej nebude treba
						xB^.r[0].o.ob[10].BgC	:= 63;
					ELSE
						xB^.r[0].o.ob[10].FgC	:= dlsl;											// toto sa pouzije, pre adresy
						xB^.r[0].o.ob[10].BgC	:= dlsl;
					END_IF;
					xDLfb^.NewSha	:= xB^.r[0].o.ob[10].FgC;
               FOR i := 0 TO 10 DO
						IF i <> 3 THEN
	                  xPtD     :=  ADR(xR^.o.ob[i].cf.n);
   	               xPtD^    :=  PTR_TO_UDINT( ADR(xR^.o.ob[i].btn) );						// priznak je .btn v riadku
						END_IF;
               END_FOR;
               IF xA^.usr <> 1 THEN
                  xR^.o.ob[0].wh := 0;                           						// vymazat vsetky SHA
                  xR^.o.ob[1].wh := 0;                           						// vymazat 1 SHA
                  xR^.o.ob[2].wh := 0;                           						// prepisat
                  xR^.o.ob[3].wh := 0;                           						// slider
					ELSIF xF^.cf.c <> 42 THEN
                  xR^.o.ob[0].wh := 0;   									                        						
		           	_Nh_DEF_SLD(s:=0,v:=ADR(aDali[dlma].NewSha));					
					ELSE
                  xR^.o.ob[1].wh := 0;                           						
                  xR^.o.ob[2].wh := 0;                           						
                  xR^.o.ob[3].wh := 0;                           						
               END_IF;

               xR^.o.ob[0].wh := 0;  															// vymazat vsetky SHA 									                        										

(*
0. VYMAZAT VŠETKY DALI-ADRESY!;                              ;	371
1. VYMAZAT DALI-adresu:       ;                              ;
2. PREPÍSAT adresu    :       ;                              ;
3. Vyhladat NOVÉ DALI-adresy  ;                              ;
4. Obnovit EXISTUJÚCE adresy  ;                              ;
5. Nacítat parametre z adries ;                              ;
6. Nacítat nastavenie scén    ;
       0     (wh:= 20, x:= x2-85  , y:= y1 + 100,   w:= 68     , FgC := 0, BgC :=50, fn := 371),  // 0 0.Vymazat VŠETKY adresy  !!!
       1     (wh:= 20, x:= x2-85  , y:= y1 + 100,   w:= 68     , FgC := 0, BgC :=50, fn := 372),  // 1 1.VYMAZA túto DALI-adresu
       2     (wh:= 20, x:= x2-85  , y:= y1 + 200,   w:= 68     , FgC := 0, BgC :=50, fn := 373),  // 2 2.PREPISAT túto DALI-adresu
       3     (wh:= 13, x:= 50     , y:= y1 + 350,   w:= x2-110  ,FgC := 4, BgC := 3, fn := 0),    // 3 Nova adresa
       4     (wh:= 20, x:= x2-85  , y:= y1 + 400,   w:= 68     , FgC := 0, BgC :=50, fn := 374),  // 4 3.Vyh¾ada nové adresy
       5     (wh:= 20, x:= x2-85  , y:= y1 + 500,   w:= 68     , FgC := 0, BgC :=50, fn := 375),  // 5 4.Obnovi existujúce adresy
       6     (wh:= 20, x:= x2-85  , y:= y1 + 600,   w:= 68     , FgC := 0, BgC :=50, fn := 376),  // 6 5.Naèíta parametre z adries
       4     (wh:= 20, x:= x2-85  , y:= y1 + 700,   w:= 68     , FgC := 0, BgC :=50, fn := 377),  // 7 6.Naèíta nastavenie scén
				(fn := 394),                                                                         //  8
            (fn := 395), 																								 //  9
            (wh:= 20, x:= x2-85  , y:= y1 + 800,   w:= 80     , FgC := 8, BgC :=50, fn := 396)   // 10.Run

*)
				END_IF;
            IF xR^.o.ob[10].tch THEN
					xR^.o.ob[10].tch := 0;
					IF xR^.o.ob[0].btn THEN											// 0.Vymazat VŠETKY adresy  !!!							
	 					_Nh_DL_ADD_Task(wht:=60,dlm :=dlma, sha:=255);					
					END_IF;
					IF xR^.o.ob[1].btn THEN											// 1.VYMAZA túto DALI-adresu						
	 					_Nh_DL_ADD_Task(wht:=60,dlm :=dlma, sha:=xB^.r[0].o.ob[10].FgC, sh2:=0);	//sh2:=xB^.r[0].o.ob[10].BgC);					
					END_IF;

					IF xR^.o.ob[2].btn THEN											// 2.Prepisat DALI-adresu						
						IF xDLfb^.NewSha <> xB^.r[0].o.ob[10].FgC THEN
	 						_Nh_DL_ADD_Task(wht:=51 ,dlm :=dlma ,sha:=xB^.r[0].o.ob[10].FgC, sh2:=xDLfb^.NewSha);
						END_IF;
					END_IF;

					IF xR^.o.ob[4].btn THEN											// 4.Vyh¾ada nové adresy		
	 					_Nh_DL_ADD_Task(wht:=50,dlm :=dlma);					
					END_IF;
					IF xR^.o.ob[5].btn THEN											// 4.Obnovi existujúce adresy		
 						_Nh_DL_ADD_Task(wht:=3 ,dlm :=dlma ,sha:=0, sh2:=63 ,par:=22);
					END_IF;
					IF xR^.o.ob[6].btn THEN											// 6.Naèíta parametre z adries		
	 					_Nh_DL_ADD_Task(wht:=3 ,dlm :=dlma ,sha:=xB^.r[0].o.ob[10].FgC, sh2:=xB^.r[0].o.ob[10].BgC ,par:=34);	// LVL
 						_Nh_DL_ADD_Task(wht:=3 ,dlm :=dlma ,sha:=xB^.r[0].o.ob[10].FgC, sh2:=xB^.r[0].o.ob[10].BgC ,par:=20);  // FADE_TIME
					END_IF;
					IF xR^.o.ob[7].btn THEN											// 5.Naèíta nastavenie scén		
 						_Nh_DL_ADD_Task(wht:=5 ,dlm :=dlma ,sha:=xB^.r[0].o.ob[10].FgC, sh2:=xB^.r[0].o.ob[10].BgC);           // GRP+LVL - parameter netreba
					END_IF;
               cmd := 31;                                                           		// vrati sa do browsu
					xA^.tch.cmd := cmd;
            END_IF;
        {$END_IF}

		  9:  // FRM-PAR   SVD,SVA/RGB/DALI/ZAS
        		;
       26:  // FRM-ROM sumrak
	         xRom := xDev;
   	      xZon := xDev;
      	   xPod := ADR(xRom^.cx.pDay);                   									// rozvrh Day-Mode
				IF init  THEN                        										// pri prvom vstupe do FRM.
		         _Nh_DEF_VAR(o:=0, x:=ADR(xRom^.cx.Dark));         							// obrazok sviecky
		         _Nh_DEF_VAR(o:=1, x:=ADR(xRom^.cx.LuxPar.LuxYes));
   	         _Nh_DEF_SLD(s:=0,	v:=ADR(xRom^.cx.LuxPar.LuxMin) );
					IF xF^.cf.c = 1 THEN			                                             // sme v ROM
			         _Nh_DEF_VAR(o:=7, x:=ADR(xRom^.cx.LuxPar.RolYes));							
   		         _Nh_DEF_SLD(s:=1,	v:=ADR(xRom^.cx.LuxPar.RolMin) );
   		         _Nh_DEF_SLD(s:=2,	v:=ADR(xRom^.cx.LuxPar.KoefBli) );
         			_Nh_DEF_VAR(r:=1,o:=5, x:=ADR(xRom^.io[101].FromZon));         							// LUX Miestnost/zona
			         _Nh_DEF_VAR(r:=1,o:=6, x:=ADR(xRom^.io[101].FromOut));         							// LUXa zona
					ELSE
		   	      xR^.o.ob[5].wh   := 0;
		   	      xR^.o.ob[6].wh   := 0;
		   	      xR^.o.ob[7].wh   := 0;
		   	      xR^.o.ob[8].wh   := 0;
		   	      xR^.o.ob[9].wh   := 0;
		   	      xR^.o.ob[10].wh  := 0;
					END_IF;		
				END_IF;
         			
				// nazov miestnosti/zony
      	   xR^.o.ob[3].wh 	:= 6;
      	   xR^.o.ob[4].wh 	:=13;
	         xR^.o.ob[3].cf.c  := 3;                                                 // default ZONE
				xR^.o.ob[2].FgC   := 5;																	// defaul je zlta
				ok := false;
				IF xRom^.io[101].dev.c > 0 AND xRom^.io[101].dev.n > 0 THEN
    				xR^.o.ob[2].fn    := 133;															// pouzity snimac
					xR^.o.ob[3].cf.c	:= xZon^.io[101].dev.c;
	 				xR^.o.ob[3].cf.n	:= xZon^.io[101].dev.n;
	  			ELSIF xF^.cf.c = 1 THEN			
					IF xRom^.io[101].own  THEN															// svoj vlastny snimac		
						xR^.o.ob[2].FgC   := 8;															// zelena
	   	         xR^.o.ob[2].fn    := 353;														// miestnost ma svoj snimac
//	      	      xR^.o.ob[2].cf.c  := 1;
//	         	   xR^.o.ob[2].cf.n  := xF^.cf.n;
	      		   xR^.o.ob[3].wh 	:= 0;
	   			ELSIF xRom^.io[101].zon	THEN														// snimac z nadradenej
      			   IF xRom^.cf.rom = 1 THEN
		   	         xR^.o.ob[2].fn    := 314;													// z donceka
						ELSE
		   	         xR^.o.ob[2].fn    := 315;													// z nadradenej zony
						END_IF;
      			   xR^.o.ob[3].cf.n  := USINT_TO_INT(xRom^.cf.rom);
	   			ELSIF xRom^.io[101].out	THEN														// snimac z vonkajsej zony
	   	         xR^.o.ob[2].fn    := 352;														// z vonkajsej zony
      			   xR^.o.ob[3].cf.n  := xZOu^.cf.idx;
   				ELSE ok := true;																			// nenajdeny ziadny snimac	
	      		   xR^.o.ob[3].wh 	:= 0;
   				END_IF;
				ELSIF xRom^.io[101].own  THEN															// ZON ma svoj snimac		
						xR^.o.ob[2].FgC   := 8;																// zelena
	   	         xR^.o.ob[2].fn    := 353;														// svoj vlastny snimac
	      		   xR^.o.ob[3].wh 	:= 0;
      		ELSE	ok := true;																			// nenajdeny ziadny snimac	
					
				END_IF;
				IF ok THEN			
						xR^.o.ob[2].FgC   := 7;
	            	xR^.o.ob[2].fn    := 417;
						xR^.o.ob[2].fmt   := '  !!!';
	      		   xR^.o.ob[3].wh 	:= 0;
	      		   xR^.o.ob[4].wh 	:= 0;
				END_IF;
				// hodnota sumraku + odkial je sumrak
   	      xR^.o.ob[2].fmt   := REAL_TO_STRINGF(xRom^.io[101].val, '%3.0f %%');		// hodnota sumraku  % snimaca
   	      xR^.o.ob[8].fmt   := USINT_TO_STRINGF(xRom^.me.DarkRolLvl, '%u %%');    // hodnota sumraku  % roliet



//     29:  // FRM - HET/VEN automatika
//         _NH_DEF_REG(wh:=29);

     30:  // FRM - MAN
			xHet  := xDev;
         IF xA^.usr = 1 THEN
          	 xR^.o.ob[10].fmt := INT_TO_STRING(xF^.cf.p) ;
         ELSE
         	xR^.o.ob[10].wh := 0;
         END_IF;
         IF xF^.cf.c = 6 OR xF^.cf.c = 47 THEN	// HET,HEV
         	_NhxPar(cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-1009);
            pHet  := xPar;
            xFix  := ADR(pHet^.par.Fix);
    		ELSE
      		xTve  := xDev;
				xFix	:= ADR(xTve^.cx.par.Fix);
         END_IF;
			_Nh_Fix_Frm();

(*
			IF xOh^.Qr OR xO^.tch THEN
				aSys.Cyc_F_Min	:=	1;											//  nastartuje zmeny v TypDay, ale aj TER,LUX...
			END_IF;
*)
//			xOh^.Qr := 0;			

(*
    130 : // FRM - MAN
         xHet  := xDev;
         CASE xF^.cf.c OF
            6 : // HET
               _NhxPar(cp := aCfg[xF^.cf.c].par , np := xF^.cf.p);
               pHet  := xPar;
               xMan  := ADR(pHet^.par.man);
               IF xA^.usr = 1 THEN
                  // zobrazit dolu cislo poi
                  xR^.o.ob[10].fmt := INT_TO_STRING(xF^.cf.p);
               ELSE
                  xR^.o.ob[10].wh := 0;
               END_IF;
            ELSE
               xTve  := xDev;
               xMan  := ADR(xTve^.cx.par.man);
         END_CASE;
         xOh          := ADR(xR^.o.ob[1]);
         xOh^.aVar    := PTR_TO_UDINT(ADR(xMan^.manTyp));
         _Nh_DEF_VAR(r:=2, o:=1, x:=ADR(xMan^.manMem.year));      // datum/cas
         xTTdt := ADR(xMan^.manMem.year);

         xB^.r[2].o.ob[1].nTch   := true;
         xB^.r[2].o.ob[2].nTch   := true;
         xB^.r[2].o.ob[7].wh     := 0;                          // nebude bodka za YY
         xB^.r[2].o.ob[8].wh     := 0;                          // nebude bodka za MM
         xB^.r[2].o.ob[1].btn    := false;
         xB^.r[2].o.ob[3].h      := 0;                          // dni v tyzdni Po-Ne, namiesto cisla dna

         CASE xMan^.manTyp OF
           1 : IF xB^.r[1].h.chk THEN                             // bola zmena volby
                  xTTdt^.day     := 0;
                  xTTdt^.hour    := 2;
                  xTTdt^.min     := 0;
                  xB^.r[2].o.ob[1].cf.c := 0;
               END_IF;
               xB^.r[2].o.ob[3].h  := 2;                          // pocet dni 0-255
               IF xB^.r[2].o.ob[1].cf.c = 0 THEN
                  xB^.r[2].o.ob[1].cf.c := 4;                     // podfarbi sa HH
               END_IF;
           3 : IF xB^.r[1].h.chk  THEN                            // po uplynuti casu
                  xTTdt^.day     := SYSTEM_S.COUNTER_DAYS_OF_WEEK;
                  xTTdt^.hour    := 0;
                  xTTdt^.min     := 0;
                  xB^.r[2].o.ob[1].cf.c := 0;                     // podfarbi sa PO-NeDay
               ELSIF xTTdt^.day < 1 AND xTTdt^.day > 7 THEN
                  xTTdt^.day     := SYSTEM_S.COUNTER_DAYS_OF_WEEK;
               END_IF;
               xB^.r[2].o.ob[3].h  := 1;                          // dni v tyzdni Po-Ne, namiesto cisla dna
               IF xB^.r[2].o.ob[1].cf.c = 0 THEN
                  xB^.r[2].o.ob[1].cf.c := 3;                     // podfarbi sa HH
               END_IF;

           4 : IF xB^.r[1].h.chk THEN
                  xTTdt^.year    := SYSTEM_S.COUNTER_YEARS;
                  xTTdt^.month   := SYSTEM_S.COUNTER_MONTHS;
                  xTTdt^.day     := SYSTEM_S.COUNTER_DAYS_OF_MONTH;
                  xTTdt^.hour    := 0; //SYSTEM_S.COUNTER_HOURS;
                  xTTdt^.min     := 0;
                  xB^.r[2].o.ob[1].cf.c := 0;
               END_IF;
               IF xB^.r[2].o.ob[1].cf.c = 0 THEN
                  xB^.r[2].o.ob[1].cf.c := 3;                     // podfarbi sa HH
               END_IF;
               xB^.r[2].o.ob[1].nTch   := 0;
               xB^.r[2].o.ob[2].nTch   := 0;
               xB^.r[2].o.ob[7].wh     := 1;
               xB^.r[2].o.ob[8].wh     := 1;
         ELSE
            xB^.r[2].o.ob[1].btn := true;
         END_CASE;
         xB^.r[1].h.chk := false;                              // vynuluje zmenu volby

*)


		35:  // FRM - TER
    	     	xTer := xDev;
				xR^.o.ob[0].fmt   := REAL_TO_STRINGF(xTer^.al.in.Val,'%6.1f°C ');
				xR^.o.ob[2].fmt   := REAL_TO_STRINGF(xTer^.al.ou.Val,'%6.1f°C');


    31:  // FRM - typ ROM
         xRom        := xDev;
         xOh         := ADR(xR^.o.ob[1]);
         xOh^.aVar   := PTR_TO_UDINT(ADR(xRom^.cf.typ));
         _Nh_DEF_VAR(r:=1,o:=4, x:=ADR(xRom^.io[100].FromZon));         							// TER zo Zony
//         _Nh_DEF_VAR(r:=1,o:=5, x:=ADR(xRom^.io[101].FromOut));         							// LUXa zona
//         _Nh_DEF_VAR(r:=1,o:=6, x:=ADR(xRom^.io[101].FromZon));         							// LUX Miestnost/zona
         _Nh_DEF_VAR(r:=1,o:=7, x:=ADR(xRom^.io[102].FromZon));         							// CO2 z zony



    32:  // FRM - typ ZON
         xRom        := xDev;
         xOh         := ADR(xR^.o.ob[1]);
         xOh^.aVar   := PTR_TO_UDINT(ADR(xRom^.cf.typ));
         If xF^.cf.n = 1 THEN
            xOh^.cf.rw2    := 1;
         END_IF;

	 33:  // FRM-predvolby  HET/HEV/TVE/VEN/REK
     		xHet 			:= xDev;
     		xTve 			:= xDev;
         xOh         := ADR(xR^.o.ob[1]);
         xOh2        := ADR(xR^.o.ob[4]);
			_NH_Het_Map_Reg();
//			xReg			:= ADR(xHet^.cx.reg);						
//			i				:= xReg^.mode;
//			xRegMod		:= ADR(xReg^.reg[i]);
			xOh^.aVar   := PTR_TO_UDINT(ADR(xReg^.Mode));			
			xOh2^.aVar  := PTR_TO_UDINT(ADR(xRegMod^.Wht));			
//			yOh			:= xOh2^;
			IF  init OR  xOh^.Qr OR xOh2^.Qr THEN
				xReg^.mode 	:= LIMIT(0,xReg^.mode,1);
		      _Nh_FRM_Read(frm:=246);   	// nacita rozne preddefinovane objekty v riadku	 xR^.o.ob[]			

				// menu 1 HET/VEN
				xPtU	:= ADR(yFrm_246.PV_OBJ_REG_REK);				
				CASE xF^.cf.c OF
			     23 : ;//VEN					
//						xPtU	:= ADR(_e246.PV_OBJ_REG_xVEN);				

		   	  47 : ;//HEV					
				ELSE	//6:HET,7:KOT,8:TVE,9:CER
					xPtU	:= ADR(yFrm_246.PV_OBJ_REG_HET);				
     			END_CASE;
				// menu 1
				memcpyPTR(length:=SIZEOF(NH_OBJ_DAT)*2, source:=xPtU,		dest:=ADR(xR^.o.ob[1]) );

				// menu 2 vykon/teplota , vykon/CO2 , vykon/RH
				ok1 	:= false;
				ok2	:= false;
				CASE xF^.cf.c OF
    				6 :	;//HET										
						xPtB	:= ADR(yFrm_246.PV_OBJ_WHT_TER);				
//    				7: ;//KOT											
//    				8: ;//TVE											
				  47 : // HEV
						IF xReg^.Mode = 1 THEN											
							xPtB	:= ADR(yFrm_246.PV_OBJ_WHT_RH);				
						ELSE
							xPtB	:= ADR(yFrm_246.PV_OBJ_WHT_CO2);				
						END_IF;
				
				ELSE 	// TVE,KOT,CER,VEN
						xPtB	:= ADR(yFrm_246.PV_OBJ_WHT_VYKON);				
						xRegMod^.Wht := 0;
						Ok1	:= xTve^.hw.typ = 0;
						Ok2	:= Ok1 AND xReg^.btn[3];
				END_CASE;

				// browser: obrazky a data+znacky
				xPtU	:= ADR(yFrm_246.PV_OBJ_SLD_PV);					
				IF xRegMod^.Wht = 0 THEN                                 // % out
					xPtU	:= ADR(yFrm_246.PV_OBJ_SLD_VYKON);						// slidery browser	= obrazky							
					xPtI	:= ADR(yFrm_246.PV_SLD_VYKON);							// slidery data 		= texty + %
				ELSIF xF^.cf.c=23 OR xF^.cf.c = 47 THEN
					IF xReg^.mode = 1 THEN										   // RH
						xPtI	:= ADR(yFrm_246.PV_SLD_CO2);						
					ELSE                                                  // CO2
						xPtI	:= ADR(yFrm_246.PV_SLD_CO2);						
					END_IF;
				ELSE
					xPtI	:= ADR(yFrm_246.PV_SLD_TMP_HET);							
				END_IF;
				// menu vykon/teplota, vykon-CO2-vlhkost
				memcpyPTR(length:=SIZEOF(NH_OBJ_DAT)*2, source:=xPtB,		dest:=ADR(xR^.o.ob[4]) );
				// 4 riadky browsu slideru - obrazky
				memcpyPTR(length:=SIZEOF(NH_OBJ_DAT)*4, source:=xPtU, 	dest:=ADR(xR^.o.ob[6]) );
				// 4 slidery - premenne a text
				memcpyPTR(length:=SIZEOF(NH_SLD_DAT)*4, source:=xPtI, 	dest:=ADR(xB^.s[0]) );		

				_NH_Het_Map_Reg();
				xRegMod^.Wht:= LIMIT(0,xRegMod^.Wht,1);

				IF xRegMod^.Wht = 0 THEN                                   // % out
					FOR i := 0 TO 3 DO
  						_Nh_DEF_SLD(s:=i,v:=ADR(xRegMod^.out[i]) );
     			   END_FOR;
				ELSE
					FOR i := 0 TO 3 DO
  						_Nh_DEF_SLD(s:=i,v:=ADR(xRegMod^.req[i]) );
     			   END_FOR;
				END_IF;
				// text 1 + manual
				xPtB	:= ADR(yFrm_246.PV_OBJ_TX0_21);				
				IF xF^.cf.c=7 OR xF^.cf.c=23 THEN
					memcpyPTR(length:=SIZEOF(NH_OBJ_DAT),   source:=ADR(yFrm_246.PV_OBJ_TX0_6),		dest:=ADR(xR^.o.ob[0]) );
				ELSE
					memcpyPTR(length:=SIZEOF(NH_OBJ_DAT),   source:=ADR(yFrm_246.PV_OBJ_TX0_21),		dest:=ADR(xR^.o.ob[0]) );
 					_Nh_DEF_VAR(o:= 0, x:=ADR(xReg^.ModeFromSrc));				// manualne rezim
				END_IF;
				IF Ok1 THEN
					FOR i := 6 TO 9 DO
						IF xReg^.btn[i-5] = false  THEN
							xR^.o.ob[i].wh := 0;											// pri bool premenneh vymazt neaktivne stupne
						END_IF;
      		   END_FOR;
				END_IF;
				IF ok2 THEN
					IF xReg^.btn[3] THEN					 					// PV-1 je ON/OFF
						memcpyPTR(length:=SIZEOF(NH_OBJ_DAT),   source:=ADR(yFrm_246.PV1_IsOn),		dest:=ADR(xR^.o.ob[10]) );
			 			_Nh_DEF_VAR(o:= 10, x:=ADR(xTve^.cx.guard.PV1_IsOn));				// PV-1 je ON pre VEN
					END_IF;
				ELSE
					memcpyPTR(length:=SIZEOF(NH_OBJ_DAT),   source:=ADR(yFrm_246.PV_OBJ_SLD_DELAY),	dest:=ADR(xR^.o.ob[10]) );
					_Nh_DEF_SLD(s:=4,v:=ADR(xReg^.Delay) );
				END_IF;
				xOh^.Qr 		:= false;
				xOh2^.Qr 	:= false;

				// toto je nasilny refresh SCR
   			_Nh_Shw_FRM	:= false;			
				xA^.tch.cmd := 205;

			END_IF;

    39:  // FRM - LED WSB/TGL  - casy uspatia
         xTgl  := xDev;
			// neviem preco toto tu je
			IF xTgl^.cx.cfL.BtnRgb > 3 THEN
		      xTgl^.cx.cfL.BtnRgb 		:= 3;
			END_IF;
         _Nh_DEF_VAR(o:= 9, x:=ADR(xTgl^.cx.cfL.PirRst));
         _Nh_DEF_VAR(o:=10, x:=ADR(xTgl^.cx.cfL.PirWake));
			_Nh_DEF_VAR(o:=8,  x:=ADR(xTgl^.cx.cfL.BtnRGB));
         IF xU^.o[ xU^.n ].cm = 122 THEN                          // jas display
            xPtU 	:= ADR(xTgl^.cx.cfL.DayLvl[0]);						 // zatial je jas spolocny aj pre DISP aj LED	
         ELSE
            xPtU 	:= ADR(xTgl^.cx.cfL.DayLvl[0]);                  // jas LED
         END_IF;
         FOR i := 0 TO 7 DO
            _Nh_DEF_SLD(s:=i ,v := xPtU);
            xPtU 				:= xPtU + 1;
         END_FOR;

    57:  // FRM - TGL-display casy uspatia
         xTgl  := xDev;
         _Nh_DEF_VAR(o:= 9, x:=ADR(xTgl^.cx.cfD.PirRst));
         _Nh_DEF_VAR(o:=10, x:=ADR(xTgl^.cx.cfD.PirWake));
			xB^.r[1].o.ob[8].wh := 0; 											// nezobrazuje sa wRGB
			
         IF xU^.o[ xU^.n ].cm = 122 THEN                          // jas display
            xPtU 	:= ADR(xTgl^.cx.cfD.DayLvl[0]);						 // zatial je jas spolocny aj pre DISP aj LED	
         ELSE
            xPtU 	:= ADR(xTgl^.cx.cfD.DayLvl[0]);                  // jas LED
         END_IF;
         FOR i := 0 TO 7 DO
            _Nh_DEF_SLD(s:=i ,v := xPtU);
            xPtU 				:= xPtU + 1;
         END_FOR;



    40:  // FRM - parametre blikaca
         xBlk  := xDev;
         IF xBlk^.cx.lOwn THEN
            ii := 13;
         ELSE
            ii := 0;
         END_IF;
         FOR i := 4 TO 6 DO
            xR^.o.ob[i].wh    := ii;                                  // ak nie je vlastna uroven, vypne slidery lOn...
         END_FOR;

    44:  // FRM - setup SVD,SVA,RGB,ZAS....
//      	xRgb := xDev;
		   _Nh_DEF_VAR(o:=0, x:=ADR(xDev^.cf.Blk));
         _Nh_DEF_VAR(o:=1, x:=ADR(xDev^.cf.Inv));
       	_Nh_DEF_VAR(off:=aCfg[xF^.cf.c].dali, o:=3, 	x:=ADR(xDev^.cf.LvlOnRst));
      	_Nh_DEF_VAR(off:=aCfg[xF^.cf.c].dali,o:=2, 	x:=ADR(xDev^.cf.DevExt));			
         _Nh_DEF_SLD(s:=0, v:=ADR(xDev^.cx.all.Pwr));
			IF aCfg[xF^.cf.c].analog AND aCfg[xF^.cf.c].dali = false THEN
	         _Nh_DEF_SLD(s:=1, v:=ADR(xDev^.cx.sva.Lv0));
   	      _Nh_DEF_SLD(s:=2, v:=ADR(xDev^.cx.sva.Lv1));
	       	_Nh_DEF_VAR(o:=7, x:=ADR(xDev^.cx.dim.DimHW));
//  	      	_Nh_DEF_SLD(off:=xDev^.cx.dim.DimHW,o:=8,s:=3, v:=ADR(xDev^.cx.dim.FadeRate));
//   	      _Nh_DEF_SLD(off:=xDev^.cx.dim.DimHW,o:=9,s:=4, v:=ADR(xDev^.cx.dim.FadeTime));
      	   _Nh_DEF_SLD(s:=5, v:=ADR(xDev^.cx.dim.tOnL));
			ELSE
				FOR i := 5 TO 10 DO
					xR^.o.ob[i].wh := 0; 			
            END_FOR;
   		END_IF;

    47:  // FRM - RGB

          _NhxPar(cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-1010);
			xRgb	:= xDev;
			ok		:= xF^.cf.c = 12;
			FOR i := 0  TO 4 DO
      	   _Nh_DEF_SLD(off:= (ok AND xRgb^.hw.d[i]=0), o:=USINT_TO_SINT(i+3), s:=i, v:=ADR(xPar^.rgb.lvl[i+1]));
         END_FOR;

    58:  // FRM - LUX/CO2/CO
    		xLux := xDev;
         xR^.o.ob[0].fmt	:= REAL_TO_STRINGF(xLux^.al.in.val,'%5.1f');
         xR^.o.ob[3].fmt	:= REAL_TO_STRINGF(xLux^.al.ou.val,'%5.0f %%');
         xR^.o.ob[5].fmt	:= REAL_TO_STRINGF(xLux^.me.lux,'%5.0f');


    64:  // FRM - ROL-parametre
			xRol := xDev;
			IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
				IF xF^.cf.p=0 THEN
					xF^.cf.p := xRol^.cf.par;      		
				END_IF;
     			_NhxPar(cp := aCfg[31].par , np := xF^.cf.p, x:=79);
				pRol	:= xPar;
//      	   _Nh_DEF_SLD(s:=0, v:=ADR(pRol^.pRol));
//      	   _Nh_DEF_SLD(s:=1, v:=ADR(pRol^.pLam));
	       	_Nh_DEF_VAR(o:=0, x:=ADR(xRol^.cx.cf.ForceUpDn));
      		FOR i := 0  TO 3 DO
				   _Nh_DEF_SLD(s:=i+2, v:=ADR(xRol^.cx.cf.PV.hwLam[i]));
            END_FOR;
//			   _Nh_DEF_SLD(s:=6, v:=ADR(pRol^.Delay));
			   _Nh_DEF_SLD(s:=7, v:=ADR(xRol^.cx.cf.LamAngle), adm:=1);			
	      	_Nh_DEF_SLD(s:=8, v:=ADR(xRol^.cx.cf.tPvHwLam) );			
//	      	_Nh_DEF_VAR(o:=10,x:=ADR(pRol^.SetPozi), off:= xF^.cf.p > 0 AND(xRol^.cf.par <> xF^.cf.p), wh:=20);		// nezobrazuje sa ked je z vazby	
(*
            IF xA^.usr = 1 THEN
               xR^.o.ob[10].fmt := CONCAT( USINT_TO_STRING(aCfg[xF^.cf.c].par)
                                          ,'p',INT_TO_STRING(xF^.cf.p)) ;
            END_IF;
*)
			END_IF;

    65:  // FRM - ROL - Up/Dn casy
			xRol := xDev;
			IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
      	   _Nh_DEF_SLD(s:=0, v:=ADR(xRol^.cx.cf.tUp.Rol));
      	   _Nh_DEF_SLD(s:=1, v:=ADR(xRol^.cx.cf.tUp.Lam));
      	   _Nh_DEF_SLD(s:=2, v:=ADR(xRol^.cx.cf.tUp.Mot));
			   _Nh_DEF_SLD(s:=3, v:=ADR(xRol^.cx.cf.tDn.Rol));
      	   _Nh_DEF_SLD(s:=4, v:=ADR(xRol^.cx.cf.tDn.Lam));
      	   _Nh_DEF_SLD(s:=5, v:=ADR(xRol^.cx.cf.tDn.Mot));
      	   _Nh_DEF_SLD(s:=6, v:=ADR(xRol^.cx.cf.tDelayRev));
      	   _Nh_DEF_SLD(s:=7, v:=ADR(xRol^.cx.cf.tDelayEnd));

      	   _Nh_DEF_SLD(s:=8, v:=ADR(xRol^.cx.cf.tUp.chg));
      	   _Nh_DEF_SLD(s:=9, v:=ADR(xRol^.cx.cf.tDn.chg));
			END_IF;

    66:  // FRM - ROL - SETUP
			xRol := xDev;
			IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
	      	_Nh_DEF_VAR(o:=0, x:=ADR(xRol^.cx.cf.SetDark));			
      	   _Nh_DEF_SLD(s:=0, v:=ADR(xRol^.cx.cf.DarkRol), 		off:= NOT xRol^.cx.cf.SetDark);
      	   _Nh_DEF_SLD(s:=1, v:=ADR(xRol^.cx.cf.DarkLam), 		off:= NOT xRol^.cx.cf.SetDark);
      	   _Nh_DEF_SLD(s:=2, v:=ADR(xRol^.cx.cf.DarkRolLvl), 	off:= NOT xRol^.cx.cf.SetDark);
	      	_Nh_DEF_VAR(o:=10,x:=ADR(xRol^.cx.cf.LamHWPulse));			
			END_IF;

    67:  // FRM - ROL - Wind ochrana
			xRol := xDev;
			IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
	      	_Nh_DEF_VAR(o:=0, x:=ADR(xRol^.cx.cf.WindGuardOn));			
	      	_Nh_DEF_VAR(o:=6, x:=ADR(xRol^.cx.cf.WindDay.n[0]));			
	      	_Nh_DEF_VAR(o:=7, x:=ADR(xRol^.cx.cf.WindDirOnly));			
	      	
      	   _Nh_DEF_SLD(s:=0, v:=ADR(xRol^.cx.cf.WindSpeedOn));
      	   _Nh_DEF_SLD(s:=1, v:=ADR(xRol^.cx.cf.WindWaitOn));
      	   _Nh_DEF_SLD(s:=2, v:=ADR(xRol^.cx.cf.WindWaitOff));
      	   _Nh_DEF_SLD(s:=3, v:=ADR(xRol^.cx.cf.WindSpeedOff));
      	   _Nh_DEF_SLD(s:=4, v:=ADR(xRol^.cx.cf.WindDirFrom));
      	   _Nh_DEF_SLD(s:=5, v:=ADR(xRol^.cx.cf.WindDirTo));
      	   _Nh_DEF_SLD(s:=6, v:=ADR(xRol^.cx.cf.WindGuardBlkTime));


			END_IF;
(*
     72 :  // FRM - Casovac - RND
			xTim := xDev;

			IF _Nh_Shw_FRM  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
	      	_Nh_DEF_VAR(o:=0, x:=ADR(xTim^.cx.WhatTyp[1]));			
	      	_Nh_DEF_SLD(s:=1, v:=ADR(xTim^.cx.rnd.IntGenRND));			
	      	_Nh_DEF_SLD(s:=2, v:=ADR(xTim^.cx.rnd.TimeOnMin));			
	      	_Nh_DEF_SLD(s:=3, v:=ADR(xTim^.cx.rnd.TimeOnMax));			
	      	_Nh_DEF_SLD(s:=4, v:=ADR(xTim^.cx.rnd.TimeOffMin));			
	      	_Nh_DEF_SLD(s:=5, v:=ADR(xTim^.cx.rnd.TimeOffMax));			

//				_Nh_DEF_TIM(week:=2, rFrom:=3, rTo:=4);  														// v riadku
			END_IF;
*)
(*
     73 : // FRM - Casovac - Nacasovanie na konkretny cas
			xTim 			:= xDev;
         xOh         := ADR(xR^.o.ob[6]);
  	      xOh^.aVar   := PTR_TO_UDINT(ADR(xTim^.cx.CMD));
			IF _Nh_Shw_FRM  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
	      	_Nh_DEF_VAR(o:=0, x:=ADR(xTim^.cx.rnd.choice[1]));			
				_Nh_DEF_TIM(week:=2, rFrom:=3, rTo:=4);  														// v riadku
				_Nh_YYMMDD(row:=5, xYear:=ADR(xTim^.cx.ValidFrom.year));
				_Nh_YYMMDD(row:=6, xYear:=ADR(xTim^.cx.ValidTo.year));
				xOh^.Qr := true;
			END_IF;
			IF xOh^.Qr THEN
				xB^.r[5].o.ob[0].FgC	:= 0;
				IF xOh^.Qs THEN

				END_IF;
				CASE xTim^.cx.CMD OF
              0 : xB^.r[5].o.ob[0].btn := true;
				  		xB^.r[6].o.ob[0].btn := false;

              1 : xB^.r[5].o.ob[0].btn := false;
				  		xB^.r[6].o.ob[0].btn := true;
            ELSE
              		xB^.r[5].o.ob[0].btn := false;
				  		xB^.r[6].o.ob[0].btn := false;
            END_CASE;
				xOh^.Qr 					:= false;
				xOh^.Qs 					:= false;
			END_IF;
*)

(*
   NH_073 {HIDDEN}:  STRUCT 	// FRM-TIM / Sunrise/Sunshine, Datk/Light
      r1o0_1_Type : NH_OBJ_SWR := // 	Sunrise/Sunshine
      	(	wh:=123,x:= xc-220,     y:= y1 + 60, typ:=1, rws:=7, h:= 40, hTxt:= 28,
            txt:=[547,548,549,550,551,552,553]       	// 2 objekty = prepinac riadkov
			);
      r1o2_3_OnOff : NH_OBJ_SWR := // On/Off/On+Off
      	(	wh:=123,x:= xc-140,     y:= y1 + 370, typ:=1, rws:=3, h:= 45, hTxt:= 28,
            txt:=[544,545,546]
			);
      r1o4_8  	: ARRAY[4..8] OF NH_OBJ_DAT :=
      r1o9_10  : ARRAY[9..10] OF NH_OBJ_DAT :=
		r2_On		: NH_DAT_TIM2:= ( txt := [          // riadok 3
		r3_Off	: NH_DAT_TIM2 := ( txt := [            // riadok 4 ToDate
		r4			: NH_DAYS_OF_WEEK;
   END_STRUCT;
*)




     72:  // FRM - Casovac - Nacasov akciu + cyklus
			_NH_Frm_SCR_72(ini:=init);
     73:  // FRM - Casovac - Slnko+Sumrak
			_NH_Frm_SCR_72(ini:=init);
     74:  // FRM - Casovac - RND
			xTim 			:= xDev;
         xOh         := ADR(xR^.o.ob[0]);			  						
         xOh2        := ADR(xR^.o.ob[0]);			  						
			IF init  THEN
//				xTim^.cx.RND.DayOfWeek[0] := 0;											// len pre istotu, abuy sa oznacovali vsetky
				xOh^.aVar   := PTR_TO_UDINT(ADR(xTim^.cf.Typ));          		// typ casovaca
	      	_Nh_DEF_SLD(s:=2, v:=ADR(xTim^.cx.rnd.IntGenRND));			
	      	_Nh_DEF_SLD(s:=3, v:=ADR(xTim^.cx.rnd.TimeOnMin));			
	      	_Nh_DEF_SLD(s:=4, v:=ADR(xTim^.cx.rnd.TimeOnMax));			
	      	_Nh_DEF_SLD(s:=5, v:=ADR(xTim^.cx.rnd.TimeOffMin));			
	      	_Nh_DEF_SLD(s:=6, v:=ADR(xTim^.cx.rnd.TimeOffMax));			
				_Nh_DEF_TIM(week:=2, lock:=9, day:=10, rFrom:=3, rTo:=4);  							
				xOh^.Qr 	:= true;
				xOh2^.Qr := true;
			END_IF;
			IF _NH_Frm_SCR_72_CHG(chg:=xOh^.Qr) THEN

				ok3 	:= xTim^.cf.typ <> 6;
				IF ok3 THEN
					vi	:= 0;
					vo	:= 0;
				ELSE
					vi	:= 20;
					vo	:= 13;
				END_IF;
   	     	xB^.r[1].o.ob[9].wh  := vi; 											// zobrazit Lock Mode
      	  	xB^.r[1].o.ob[10].wh := vi; 											// zobrazit DayMode
     	   	xB^.r[2].o.ob[0].btn := ok3;										// zobrazit PO-NO
				FOR i := 4 TO 8 DO
         		xB^.r[1].o.ob[i].wh := vo;															// slidery RND
	         END_FOR;
			END_IF;

    76:  // HOM/ZON - typovy den + kedy vratit

			xZon	:= xDev;
	   	_Nh_DEF_VAR(r:=3, o:=0, x:=ADR(xZon^.cx.pDay.Day));			
			xFix	:= ADR(xZon^.cx.FixDay);
			_Nh_Fix_Frm();	

    77:  // ROM-fazy dna rano-vecer, HET,HEV - rozvrh
			i	:= 0;
			IF xF^.cf.c=6 OR xF^.cf.c=47 THEN
				xHet	:= xDev;
				i 		:= xHet^.cx.reg.Mode;
			END_IF;
			_Nh_xPod_Map(cf:=xF^.cf.c, nd:=xF^.cf.n, WhtPoi := i);
			IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
	     		_Nh_DEF_VAR(r:=2, o:=0, x:=ADR(xPoD^.Day));			
            _Nh_FRM_Read(frm:=247);
				_NheBrw(wht:=9);																// vymaze data POD
	         CASE xF^.cf.c OF
				  6 : xM^.pod.po.cf   	:= yFrm_247.poi[1];                        	// Het-Rozvrh			
						_Nh_Frm_Het_REQ_INI();
						xM^.pod.po.WhtPoi := xHet^.cx.reg.Mode;
						xB^.r[1].o.ob[1].cf.n := yFrm_247.txt[1];			
				 47 : xM^.pod.po.cf   := yFrm_247.poi[2];                        	// VEN-Rozvrh			
						xM^.pod.po.WhtPoi := xHet^.cx.reg.Mode;
						xM^.pod.po.WhtPoi := xHet^.cx.reg.Mode;
						xB^.r[1].o.ob[1].cf.n := yFrm_247.txt[2];			
				ELSE	xM^.pod.po.cf   := yFrm_247.poi[0];                        	// ROM-Rozvrh			
						xM^.pod.po.WhtPoi := 0;
						xB^.r[1].o.ob[1].wh 		:= 0;											// vypist textu zlava
						xB^.r[1].o.ob[1].cf.n 	:= yFrm_247.txt[0];			
						_Nh_DEF_VAR(wh:=20, r:=1, o:=2, x:=ADR(xRom^.me.DayObr)); // obrazok TypeDay
	         END_CASE;
				xB^.r[2].o.ob[0].Qr := 1;											// refresh grafu
//				xM^.pod.po.edit			:= true;											// zablokuje zmenu typ.dna pri editacii
				xM^.pod.po.edit.c	:=	xF^.cf.c;
				xM^.pod.po.edit.n	:=	xF^.cf.n;
				
				IF xM^.set THEN
               xU^.o[2].fn := 45;
               xU^.o[2].cm := 131;
					xU^.o[2].frm:= 77;
				ELSE
               xU^.o[2].fn := xU^.o[2].wh;				
               xU^.o[2].cm := 0;
					xU^.o[2].frm:= 0;
				END_IF;
   		END_IF;
			IF xB^.r[2].o.ob[0].Qr OR xM^.pod.po.Day <> xPoD^.Day THEN      // refresh grafu
		      xM^.pod.po.p := -1;
		      xM^.pod.po.x := -1;
			END_IF;
			xM^.pod.po.Day		:= xPoD^.Day;
		   xM^.pod.po.poi  	:= _Nh_Poi_Day(day:=xPoD^.Day, xPd:=xPod);

     80:  // FRM - Meteo
//         xOh         := ADR(xR^.o.ob[0]);			  						
			xDev			:= ADR(aMeteo);				// koli sliderom
			IF init  THEN
//				xOh^.aVar   := PTR_TO_UDINT( ADR(xGlb^.cx.meteo.typ) );          		// typ meteostanice
	      	_Nh_DEF_SLD(s:=0, v:=ADR(xGlb^.cx.meteo.wind[0]));
	      	_Nh_DEF_SLD(s:=1, v:=ADR(xGlb^.cx.meteo.wind[1]));
	      	_Nh_DEF_SLD(s:=2, v:=ADR(xGlb^.cx.meteo.wind[2]));
	     		_Nh_DEF_VAR(o:=3, x:=ADR(xGlb^.cx.meteo.Manual)) ;			
	      	_Nh_DEF_SLD(s:=4, v:=ADR(aMeteo.WindSpeedMan));
	      	_Nh_DEF_SLD(s:=5, v:=ADR(aMeteo.WindDirMan360));
	      	_Nh_DEF_SLD(s:=6, v:=ADR(aMeteo.spowerMan));	      	

	     		_Nh_DEF_VAR(o:=7, x:=ADR(xGlb^.cx.meteo.SendToBlind)) ;			
	      	_Nh_DEF_SLD(s:=3, v:=ADR(xGlb^.cx.meteo.FilWindSpeed));
	      	_Nh_DEF_SLD(s:=7, v:=ADR(aMeteo.WindSpeedRol));
				xL^.vis 				:= true;          												 // zabezpeci xDev^.ok.DevRef:=true pri pusteni slidera
				aMeteo.newData 	:= true;
				IF xGlb^.cx.meteo.Manual THEN
					xB^.s[ 6 ].v2 := 200.;
				ELSE
					xB^.s[ 6 ].v2 := 5000.;
				END_IF;
			ELSE
				aMeteo.newData 	:= xDev^.ok.DevRef;			
			END_IF;
			xDev^.ok.DevRef	:= false;


     84:  // FRM - Meteo
			xDev			:= ADR(aMeteo);				// koli sliderom
         xOh         := ADR(xR^.o.ob[0]);			  						
			IF init  THEN
				xOh^.aVar   := PTR_TO_UDINT( ADR(xGlb^.cx.meteo.typ) );          		// typ meteostanice
	      	_Nh_DEF_SLD(s:=0, v:=ADR(xGlb^.cx.meteo.temp[0]));
	      	_Nh_DEF_SLD(s:=1, v:=ADR(xGlb^.cx.meteo.temp[2]));
	      	_Nh_DEF_SLD(s:=2, v:=ADR(xGlb^.cx.meteo.KoefTo100));
	      	_Nh_DEF_SLD(s:=3, v:=ADR(xGlb^.cx.meteo.sPower100));
	      	_Nh_DEF_SLD(s:=4, v:=ADR(xGlb^.cx.meteo.FilsPower));
				xOh^.Qr 			:= true;
//				xL^.vis 			:= true;          												 // zabezpeci xDev^.ok.DevRef:=true pri pusteni slidera
				aMeteo.newData := true;
			ELSE
				aMeteo.newData 	:= xDev^.ok.DevRef;
			END_IF;
			xDev^.ok.DevRef	:= false;


    82:  // FRM - ROL - graficky LVL
			xRol 		:= xDev;
			IF init  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
				xRo		:=  ADR(xR^.o.ob[5]);
				IF xF^.cf.p=0 THEN
					xF^.cf.p := xRol^.cf.par;      		
				END_IF;
				xRo^.cf	:= xF^.cf;								// prebrat DEV a hlavne parameter
				xRo^.chk	:= xB^.r[0].h.chk;					// priznak vazby
        		_NhxPar(cp := aCfg[xF^.cf.c].par , np := xF^.cf.p, x:=78);
				pRol	:= xPar;
				ok := xF^.cf.p = xRol^.cf.par;
			   _Nh_DEF_SLD(s:=0, o:=9,  v:=ADR(pRol^.all.tDelay));
				IF xA^.admin THEN //AND ok THEN
					xR^.o.ob[7].wh := 6;
					xR^.o.ob[8].wh := 6;
					xR^.o.ob[10].wh := 6;
				END_IF
			END_IF;
			xR^.o.ob[7].fmt :=  REAL_TO_STRINGF(xRol^.cx.yRol,'%8.3f');
			xR^.o.ob[8].fmt :=  REAL_TO_STRINGF(xRol^.cx.yLam,'%8.3f');
			xR^.o.ob[10].fmt :=  CONCAT( INT_TO_STRING(xF^.cf.p),'/',INT_TO_STRING(xRo^.cf.p));

    83:  // FRM - predvolby HET/HEV vo vazbe PIR/SVE ...
         xHet  := xDev;
         xOh         := ADR(xR^.o.ob[4]);
       	_NhxPar(cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-1012);
         pHet  := xPar;
			xOh^.aVar   := PTR_TO_UDINT(ADR(pHet^.What));			
    		If init THEN
//				i	:= aCfg[ xB^.r[0].o.ob[0].cf.c ].tgrp;
				i	:= aCfg[ xB^.r[0].h.cf.c ].tgrp;
				IF  i = 15 OR i = 13 THEN
					xR^.o.ob[4].btn 	:= true;				
					pHet^.What			:= 0;
				END_IF;
				
		    	_Nh_DEF_SLD(s:=0, v:=ADR(pHet^.Delay));
		     	_Nh_DEF_SLD(s:=1, v:=ADR(pHet^.Wait));
	         IF xA^.usr = 1 THEN
   	       	 xR^.o.ob[10].fmt := INT_TO_STRING(xF^.cf.p) ;
      	   ELSE
         		xR^.o.ob[10].wh := 0;
	         END_IF;
         END_IF;

    85:  // FRM - setup-LOG HET/VEN
			xHet := xDev;
    		If init THEN	//AND xHet^.io[0].own THEN
	     		_Nh_DEF_VAR(o:=0, x:=ADR(xDev^.cf.blk)) ;			
	     		_Nh_DEF_VAR(o:=4, x:=ADR(xHet^.cx.pLog.Enable)) ;			
	     		_Nh_DEF_VAR(o:=5, x:=ADR(xHet^.cx.pLog.ChgOut)) ;			

	      	_Nh_DEF_SLD(s:=0, v:=ADR(xHet^.cx.pLog.Sample));
	      	_Nh_DEF_SLD(s:=1, v:=ADR(xHet^.cx.pLog.ChgReQ));
	      	_Nh_DEF_SLD(s:=2, v:=ADR(xHet^.cx.pLog.ChgRom));
				ok	:= xF^.cf.c = 6;				
				IF ok AND xHet^.io[1].zon THEN  // v zon je ci ma TVE teplotu					
		      	_Nh_DEF_SLD(s:=3, v:=ADR(xHet^.cx.pLog.ChgHet));
				ELSE
   	       	 xR^.o.ob[9].wh := 0;
				END_IF;
				IF ok AND xHet^.io[2].zon THEN	// v zon je ci ma kotol teplotu					
	      		_Nh_DEF_SLD(s:=4, v:=ADR(xHet^.cx.pLog.ChgKot));
				ELSE
   	       	 xR^.o.ob[10].wh := 0;
				END_IF;
			END_IF;

    86:  // HET-rozdiely teplot
         xOh         := ADR(xR^.o.ob[2]);			  						
			xOh^.aVar   := PTR_TO_UDINT(ADR(xR^.o.ob[0].Bgc));         		// len nejaka volna premenna na prepinanie
			xHet			:= xDev;
			IF init THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
            _Nh_FRM_Read(frm:=247);
				_NheBrw(wht:=9);															// vymaze data POD
				xM^.pod.po.cf   	:= yFrm_247.poi[3];                        	// vcasinou obrazky
				xM^.pod.po.poi  	:= -1;                                   	// pouzije sa virtualna pamat, nie POI
				_Nh_Frm_Het_REQ_INI(out:=true);										// presype OUT hodnoty
				xR^.o.ob[0].Bgc 	:= BOOL_TO_USINT(xHet^.me.dif.up );
				xOh^.Qr				:= true;
	      	_Nh_DEF_SLD(s:=1, v:=ADR(xHet^.cx.pPid.sample));
   		END_IF;
      	xPox  := ADR(aWeb.M[ aWeb.nbr ].brw.r[10].o.ob[0].x);          // virtualna pamat pre zobrazenie
			IF xOh^.Qr THEN      														
				_Nh_Frm_Het_Hys(  );			                                 // nacitat
				xOh^.Qr	:= false;
			END_IF;
			IF xM^.pod.po.Qf THEN
				_Nh_Frm_Het_Hys(save:=true );											// zapisat
			END_IF;


(*	      	

   NH_085  {HIDDEN} :  STRUCT 	// Setup HET/VEN
  		r0_10 : ARRAY[0..10] OF NH_OBJ_DAT :=
		  	[  (wh:=20, x:=x2-60 ,y:= y1 + 50, w:= 48     , 				FgC := 4, BgC :=50, 	fn := 100), //0 zablokovat
				(),
				(),	
				(),
				(wh:=20, x:=x2-60 ,y:= y1 + 400, w:= 48     , 				FgC := 0, BgC :=50, 	fn := 615),	//  4 logovat
			   (wh:=20, x:=x2-60 ,y:= y1 + 480, w:= 48     , 				FgC := 0, BgC :=50, 	fn := 614),	//  5 kazda zmena Out
			  	(wh:=13, x:=50    , y:= y1+ 580,w:= x2-110  ,FgC := 4, BgC := 8 , fn := 0 ), 					//  6 sample
			  	(wh:=13, x:=50    , y:= y1+ 660,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 1 ), 					//  7 ReQ
			  	(wh:=13, x:=50    , y:= y1+ 740,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 2 ), 					//  8 Rom
			  	(wh:=13, x:=50    , y:= y1+ 820,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 3 ), 					//  9 Het
			  	(wh:=13, x:=50    , y:= y1+ 900,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 4 ) 					// 10 Kot
         ];
      s  : ARRAY[0..10] OF NH_SLD_DAT := [
				(t:=3,	v2 := 3600.0, fmt := '1%Tm:ss.z m', 	txt := 608, xv := x2-53 ), 					// 0 vzorka
				(t:=2,	v2 := 255.0,  fmt := '%4.1f °', 			txt := 610, xv := x2-53 ), 					// 1 Zmena ReQ
				(t:=2,	v2 := 255.0,  fmt := '%4.1f °', 			txt := 611, xv := x2-53 ), 					// 2 Zmena Rom	
				(t:=2,	v2 := 255.0,  fmt := '%4.1f °', 			txt := 612, xv := x2-53 ), 					// 3 Zmena Het
				(t:=2,	v2 := 255.0,  fmt := '%4.1f °', 			txt := 613, xv := x2-53 ) 						// 4 ZmenaKot
         ];
   END_STRUCT;
*)
    90:  // Akcia na WSB PLAY
     			_NhxPar (cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-21);	
				xWsb     	:= xDev;
            pWsb     	:= xPar;
	         xOh         := ADR(xR^.o.ob[8]);
   	      xOh^.aVar   := PTR_TO_UDINT(ADR(xR^.o.ob[2].cf.c));   		// cmd z riadka
            xO 			:= ADR(xR^.o.ob[0]);
				If xO^.tch THEN
            	pWsb^.bt := pWsb^.bt + 1;
	            IF pWsb^.bt > SINT_TO_USINT(xWsb^.cf.typ) THEN                 // kontrola na max. pocet BTN
   	            pWsb^.bt := 1;
      	      END_IF;
					xO^.tch := false;
				END_IF;				
				xO^.FgC  := pWsb^.bt;                                  // preberie btn
           	// zobrazenie a prepinanie nad click+P+H
          	FOR i := 1 TO 7 DO
            	xO 		:= ADR(xR^.o.ob[i]);
               xO^.BgC 	:= 0;
               xO^.cf.p := 35;
               IF xO^.tch OR xR^.o.ob[1].cf.c = i THEN
                  xO^.FgC := 1;
                  xO^.BgC := 8;
                  xO^.tch := false;
                  xR^.o.ob[1].cf.c := i;											// Click 1,2.3.4,5,push,Hold
                  IF i >= 6 THEN
                     xO^.cf.p := 26;    											// vyska textu
                  END_IF;
               ELSIF i > 1 AND i < 6 AND xWsb^.cx.cfc.Click = 0 THEN
                  xO^.FgC := 1;                                         // cierna
               ELSIF i = 6 AND xWsb^.cx.cfc.Press = 0 THEN
               	xO^.FgC := 1;                                         // cierna
    				ELSIF i = 7 AND xWsb^.cx.cfc.Hold = 0 THEN
                  xO^.FgC := 1;                                         // cierna
               ELSIF pWsb^.cm.cmd[i] > 0 THEN
                  xO^.FgC := 8;
               ELSE
                  xO^.FgC := 2;
               END_IF;
        		END_FOR;
         	i     				:= xR^.o.ob[1].cf.c;
				If xOh^.Qs THEN
					xOh^.Qs				:= false;
					pWsb^.cm.cmd[i]   := xR^.o.ob[2].cf.c;
				ELSE
					xR^.o.ob[2].cf.c	:= pWsb^.cm.cmd[i];
					xOh^.Set0 			:= true;
					xOh^.cmd				:= xR^.o.ob[2].cf.c;
				END_IF;
				yOh := xOh^;
	END_CASE;
   GC_Begin(GrData := xCan);
//   FOR ii := 1 to _Nh_FRM_CFG[ xU^.o[  xU^.n ].frm ].rws DO
   FOR kk := 1 to yFrmName.row	DO
      xR    := ADR(xB^.r[ kk ]);
     _Nh_Shw_Obj(row:=kk);
   END_FOR;
   _NhShwMnu();
   GC_End(GrData := xCan);

{ $ END_IF }

END_FUNCTION





