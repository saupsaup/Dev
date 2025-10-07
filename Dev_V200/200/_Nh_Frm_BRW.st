FUNCTION _Nh_Frm_Row_BRW {HIDDEN}    : BOOL        // naplni, alebo refreshne objekty jedneho riadka browsu/frame/home
	{ $ IFDEF __NH_WEB }
   VAR_INPUT
      new   : BOOL;
      row   : USINT;
   END_VAR
   VAR_TEMP
		blk	: USINT;
      cp    : USINT;
//      np    : INT;
   END_VAR
   _Nh_Frm_Row_BRW := true;
   IF new THEN
		cp := xR^.h.cf.c;
      IF xL^.obj = 11 AND xR^.h.cf.c = 1 THEN                                           // ZONA domcek       1 ZON -> ROMs
			cp := 3;
		ELSIF xR^.h.new  THEN
			new := false;
      END_IF;
		IF new THEN
      	_Nh_Brw_Row_DSH(row := row, frm := USINT_TO_UINT(aCfg[ cp ].fBr) );   	// nacita FRM a podla DSH pripravi korekcie X,Y
			_Nh_Brw_Row_OBJ(row := row);								
	      _Nh_FRM_Read(frm:=246);   	// nacita rozne preddefinovane objekty v riadku	 xR^.o.ob[]			
	     	_Nh_Chk_FAV();
   	   CASE xR^.h.cf.c OF
			 0:	;
			50:	// timer - v priebehu refreshu sa nemeni
					xTim	:= xDev;
					memcpyPTR(length:=SIZEOF(NH_OBJ_DAT), source:=ADR(yFrm_246.tim_1), dest:=ADR(xR^.o.ob[6]) );		// nastavi zobrazovanie obrazka typu casovaca nad hlavnou ikonou
					memcpyPTR(length:=SIZEOF(NH_OBJ_DAT), source:=ADR(yFrm_246.e4O1), dest:=ADR(xR^.o.ob[7]) );		// vypne zobrazovanie na stavovou ikonou
			 		x4o   			:= ADR(xR^.o.ob[6]);
					x4o^.obr[2]    :=	yFrm_246.tim_1_typ_obr[ xTim^.cf.typ ];			// podla typu vyberie obrazok
					blk	:= 5;
	      END_CASE;

	   END_IF;
	END_IF;


   CASE xR^.h.cf.c OF

   	0: ;
    	1:	_Nh_Shw_ROM_ROW();
		2: // CAT
		   	_Nh_FRM_Read(frm:=232);
            xR^.o.ob[5].cf.c := 0;
  	         xR^.o.ob[5].cf.n := yFrm_232.cat[xR^.h.cf.n].txt;                                  // cislo textu v 1.riadku
            xR^.o.ob[6].cf.c := 0;
  	         xR^.o.ob[6].cf.n := yFrm_232.cat[xR^.h.cf.n].txt+1;                                  // cislo textu v 2.riadku je za prvym
				IF yFrm_232.cat[xR^.h.cf.n].cmd4 = 0 THEN
					xR^.o.ob[4].wh := 0;				
				ELSE
					xR^.o.ob[4].cm := yFrm_232.cat[xR^.h.cf.n].cmd4;								
				END_IF
				IF yFrm_232.cat[xR^.h.cf.n].cmd2 = 0 THEN
					xR^.o.ob[2].wh := 0;				
				ELSE
					xR^.o.ob[2].cm := yFrm_232.cat[xR^.h.cf.n].cmd2;								
				END_IF
				xR^.o.ob[1].cm := yFrm_232.cat[xR^.h.cf.n].cmd1;								

            IF xA^.usr= 1 THEN                                                   // pre admina vypise cislo CAT
               xR^.o.ob[7].wh    := 6;
               xR^.o.ob[7].cf.c  := 254;
               xR^.o.ob[7].fmt   := CONCAT(INT_TO_STRINGF(xR^.h.cf.n,'%2u'), '');
            END_IF;
		3:	xR^.o.ob[9].cf.c:=252;										// vypisuje sa nazov domceka (domovskej zony)
				_Nh_Shw_ROM_ROW();
		6: // HET
  				xHet  	:= xDev;
				IF xL^.dsh = 4 THEN
					_Nh_Shw_CPY();
      		ELSE
					_NH_Het_Map_Reg();
//					IF xHet^.io[0].own THEN                // DEV regulovanej teploty
               	IF xRegMod^.wht = 1 THEN
							xR^.o.ob[2].fmt := REAL_TO_STRINGF(xHet^.al.ou.val,'%5.1f°');
						ELSE
							xR^.o.ob[2].fmt := REAL_TO_STRINGF(xHet^.al.ou.val,'%5.0f %%');
						END_IF
//					END_IF ;
					IF xHet^.io[1].own THEN                // ma termoventil
						IF xHet^.io[1].zon THEN             // TVE ma teplotu
							xR^.o.ob[5].fmt := REAL_TO_STRINGF(xHet^.io[1].val,'%5.1f°');
						ELSE
						   xR^.o.ob[5].wh := 0;
						END_IF;
						xHet^.al.lst := true;
					ELSE
		   			xR^.o.ob[5].wh := 0;					
						xHet^.al.lst := false;				
					END_IF;
//	 			IF xA^.admin = false THEN
	 				IF xM^.set=false OR xA^.UsrRight < 2 THEN
	 					xR^.o.ob[1].cm   := 0;
 						xR^.o.ob[4].fn   := 0;
 						xR^.o.ob[6].fn   := 0;
					END_IF;
				END_IF;
  		47: // HEV
            xHet  := xDev;
				IF xL^.dsh = 4 THEN
					_Nh_Shw_CPY();
         	END_IF;
      		IF xHet^.io[0].own THEN                // aktualne % CO2 zo snimaca
					xR^.o.ob[2].fmt := REAL_TO_STRINGF(xHet^.io[0].val,'%6.0f %%');
				END_IF;
				IF xHet^.io[2].own THEN                // ma termoventil
					xHet^.al.lst := true;
				ELSE
					xHet^.al.lst := false;				
				END_IF;
//  	 			IF xA^.admin = false THEN
	 			IF xM^.set=false OR xA^.UsrRight < 2 THEN
 					xR^.o.ob[1].cm   := 0;
	 				xR^.o.ob[4].fn   := 0;											// setup nie je 	
 					xR^.o.ob[6].fn   := 0;                               	// lst vazby nie su
  				END_IF;
				IF xL^.chk AND xR^.o.ob[4].cf.c > 0 THEN
					IF acfg[xR^.o.ob[4].cf.c].tgrp = 15 THEN
 						xR^.o.ob[7].wh   := 0;                      			// ked je vo vazbe PIR, vypnu sa predvolby a zobrazuju sa prvky PIR
					END_IF;
				END_IF;		

		7: // KOT
 			_Nh_Shw_TVE_ROW();

		8: // TVE
 			_Nh_Shw_TVE_ROW();

		9: // CER
 			_Nh_Shw_TVE_ROW();

		15: //PIR
				IF	xR^.h.pir THEN					// je vo vazbe
					;
				ELSIF	_NhxRom(nr := xDev^.cf.rom ,x:=55) THEN	
					_Nh_Shw_107_ROM(o:=7, day:=true);
	            _Nh_Frm_STA_OU(obj:=2, o:=8);
					blk	:= 5;
//   				_Nh_DEF_VAR(wh:=20, o:=6, x:=ADR(xDev^.cf.blk) );
				ELSE
					xR^.o.ob[7].wh		:= 0;   		
				END_IF;

		23: // REK
				 _Nh_Shw_TVE_ROW();

		31: // ROL
				xRol 		:= xDev;
				IF new  THEN                        // pri prvom vstupe do FRM. nacitat iny formular podla menu. n
					xRo		:= ADR(xR^.o.ob[5]);
					IF xR^.h.cf.p=0 THEN
						xR^.h.cf.p := xRol^.cf.par;      		
					END_IF;
					xRo^.cf	:= xR^.h.cf;
					xRo^.chk	:= xL^.chk;					// priznak vazby
				END_IF;

  	 			IF xM^.set AND xF^.cf.c = 2 AND xF^.cf.n = 3 THEN		// pristupne kopirovanie	
		  	 			IF xU^.o[1].fn  = 44 AND xL^.dsh = 1 THEN									// zlte COPY
//      D1_7       : NH_OBJ_4O1 	:= (obj:=1, obr:=[44,38,0,0], cmd:=[0,0,0,0], wxy:=[0,0,0,0],ok:=[0,0,0,0], txt:=[0,0,0,0],  );                          // 5=slider;
//							xR^.o.ob[7]		:= xR^.o.ob[8];
						 	x4o    			:= ADR(xR^.o.ob[8]);
							xR^.o.ob[1].cm 	:= 128;									// click na hlavnu ikonu = oznacovanie
							xR^.o.ob[10].cm 	:= 128;									// nazov
							x4o^.wh			:= 107;
							x4o^.obj			:= 1;
   	 					x4o^.wxy[1]    := 52;
    						x4o^.wxy[2]    := 42;
							x4o^.obr[1]		:= 44;
							x4o^.obr[2]		:= 38;
							x4o^.ok[1] 		:= xU^.o[1].wh = xR^.h.cf.n;
							x4o^.ok[2] 		:= xRol^.me.cpy;
						ELSE
							xR^.o.ob[1].cm 	:= 204;                         	// standardne parametre rolety
							xR^.o.ob[10].cm 	:= 204;								// nazov
							x4o^.wh				:= 0;
						END_IF;
				END_IF;

		131: // ROL
            xRol     := xDev;
				IF new THEN
	            ix       := xR^.o.ob[6].fn;                                             // slider je v 8
   	         xS       := ADR(xB^.s[ix]);
		         _NhSetObjBrw(ob:=5, wh:=24, w:=50,  t:=4, c:=1, cm:=48,  vb := ADR(xRol^.cx.SetLam),   fmt := '119500');        // ROL/LAM
         	   _Nh_Frm_Row_O13(ob:=6, vb:= PTR_TO_UDINT( ADR(xRol^.al.in.Val) ) );
	  	 			IF xM^.set AND xF^.cf.c = 2 AND xF^.cf.n = 3 THEN		// pristupne kopirovanie	
		  	 			IF xU^.o[1].fn  = 44 THEN									// zlte COPY
//      D1_7       : NH_OBJ_4O1 	:= (obj:=1, obr:=[44,38,0,0], cmd:=[0,0,0,0], wxy:=[0,0,0,0],ok:=[0,0,0,0], txt:=[0,0,0,0],  );                          // 5=slider;
							xR^.o.ob[7]		:= xR^.o.ob[8];
						 	x4o    			:= ADR(xR^.o.ob[7]);
							xR^.o.ob[1].cm := 128;									// click na hlavnu ikonu = oznacovanie
							x4o^.wh			:= 107;
							x4o^.obj			:= 1;
   	 					x4o^.wxy[1]    := 52;
    						x4o^.wxy[2]    := 42;
							x4o^.obr[1]		:= 44;
							x4o^.obr[2]		:= 38;
							x4o^.ok[1] 		:= xU^.o[1].wh = xR^.h.cf.n;
							x4o^.ok[2] 		:= xRol^.me.cpy;
						ELSE
							xR^.o.ob[1].cm := 204;                         	// standardne parametre rolety
							x4o^.wh			:= 0;
						END_IF;
					END_IF;
				 	x4o    			:= ADR(xR^.o.ob[8]);
					x4o^.wh			:= 107;
					y4o := x4o^;
					IF xRol^.cx.yLam <= 0.0 THEN
						x4o^.obr[1]		:= 500;			
					ELSIF xRol^.cx.yLam >= 100.0 THEN
						x4o^.obr[1]		:= 502;			
					ELSE
						x4o^.obr[1]		:= 501;			
					END_IF;
					IF xRol^.cx.CMD = 12 THEN					
						x4o^.ok[2]		:= true;										// zobrazi blokovanie vetrom			
					ELSE
						x4o^.ok[2]		:= false;			
					END_IF;					

//					x4o^.obr[1]		:= 10000+REAL_TO_INT(xRol^.cx.yBli);			// namiesto obr sa vypise text = poziacia rolety
//					x4o^.obr[3]		:= 10000+REAL_TO_INT(xRol^.cx.yLam);			//

				END_IF;
				IF xRol^.cx.SetLam = false THEN								// slider ROL
//    				xR^.o.ob[6].BgC := 9;                              // modra
    				xR^.o.ob[6].BgC := 3;                              // modra
					IF xRol^.cx.CMD > 200 THEN				
						xRol^.al.in.Val := xRol^.cx.yrol;
					END_IF;
				ELSE
//					xR^.o.ob[6].BgC := 10;                                	// biela pre LAM
					xR^.o.ob[6].BgC := 27;                                	// biela pre LAM
					IF xRol^.cx.CMD > 200 THEN				
						xRol^.al.in.Val := xRol^.cx.yLam;
					END_IF;
         	END_IF;

		37: // GATE
				xGat	:= xDev;
            xR^.o.ob[5].fn := _Nh_O12(xGat^.cx.btn,69,66);                   // slider - aktivovana SCN je oranzova, inak zlta
				IF  xGat^.cf.typ < 2 THEN											// garaz,brana
					_Nh_Frm_Row_O13(ob:=6, t:=0, vb:=PTR_TO_UDINT( ADR(xDev^.al.ou.val) ));
				ELSE
					xR^.o.ob[6].wh := 0;				
				END_IF;
				_Nh_Frm_STA_OU(obj:=2, o:=8);


		{$IFDEF __NH_DALI}
		42: // DL-M
   	         xDlm              := xDev;
      	      ix                := xR^.h.cf.n;
         	   xDLfb             := ADR(aDali[ix]) ;
	            _Nh_Frm_Row_O13(ob:=5);

//    				xB^.s[ 0 ].v2 := 254.0;                         // ine ako DALI maju max 100%


   	         xPtD              := ADR(xR^.o.ob[9].cf.n);
      	      xPtD^             := PTR_TO_UDINT( ADR(xDlfb^.txt) );                   // v druhom riadku sa zobrazuje INFO o aktualnom parametre
         	   xR^.o.ob[9].cf.c  := 253;                                               // hodnota v pointri
(*
            xR^.o.ob[8].fmt   := INT_TO_STRING(xR^.h.cf.n);                         // cislo DLM l hlavnej ikone
            xR^.o.ob[8].BgC   := _Nh_U12(xDlm^.cx.sta.Present,8,1);                 // vykonany random/nevykonany
            xR^.o.ob[7].wh    := 0;
*)
	            xR^.o.ob[4].fn := _Nh_O12(xDlm^.cx.dlm.nShA>0,25,23 );                  // zeleny/sivy setup
//            xR^.o.ob[6].fn := _Nh_O12(xDLm^.al.lst,334,333);                  		// zeleny/sivy setup

      	      IF xDLm^.cx.sta.Err  THEN
         	      xDlfb^.txt := CONCAT(xDlfb^.txt,' E:');
            	   xDlfb^.txt := CONCAT(xDlfb^.txt,' '
               	                                                                     // RndAdr               Query
                  	                  ,USINT_TO_STRING(xDLm^.me.err.nErrS[1]),';'     // neprisla odpoved     Neprisla odpoved
                     	               ,USINT_TO_STRING(xDLm^.me.err.nErrS[2]),';'     // kolizia adries       Kolizia 2 adries
                        	            ,USINT_TO_STRING(xDLm^.me.err.nErrS[3]),';'     // niet co hladat
                           	         ,USINT_TO_STRING(xDLm^.me.err.nErrS[4]) );
	               xDlfb^.txt := CONCAT(xDlfb^.txt,'/'
   	                                 ,USINT_TO_STRING(xDLm^.me.err.nErrG[1]),';'
      	                              ,USINT_TO_STRING(xDLm^.me.err.nErrG[2]),';'
         	                           ,USINT_TO_STRING(xDLm^.me.err.nErrG[3]),';'
            	                        ,USINT_TO_STRING(xDLm^.me.err.nErrG[4]) );
               	
//					ELSIF xDLfb^.cmd[1].cmd = 0 THEN
//	   	         xDlfb^.txt        := USINT_TO_STRINGF(xDlm^.cx.dlm.nSha,'%2d');         // pocet SHA					
					ELSE
//	   	         xDlfb^.txt        := USINT_TO_STRINGF(xDlfb^.cmdQue,'%2u');         // pocet SHA										
	            END_IF;
   	         // skupina
      	      // nazov DLM
         	   xR^.o.ob[10].cf   := xR^.h.cf;
	            x4o            := ADR(xR^.o.ob[7]);
   	         x4o^.obr[1]   := USINT_TO_INT( xDlm^.cx.dlm.nShA );
      	      IF xDLm^.cx.sta.Present = false THEN
         	      x4o^.BgC[1] := 2;
	            ELSE
   	            x4o^.BgC[1] := 3;
      	      END_IF;
		         x4o^.ok[2]        := 1;
      	      x4o^.obr[2]       := xR^.h.cf.n;


	            IF xDLm^.me.err.nErrS[2] > 0 THEN
   	            x4o^.ok [3] := 1;
      	         x4o^.obr[3] := USINT_TO_INT( xDLm^.me.err.nErrS[2] );
         	   ELSE
            	   x4o^.ok[3]        := 0;
	            END_IF;


      43: 	// DLS
    	      // xL^.obj :
				// 47 DLm/DLg
				// 48 DLm/DLs

				// 43 v hlavicke je toto 	DLs riadok je DLg 		priradzuje sa DLs->DLg
				// 44 v hlavicke je 			DLg riadok je toto DLs  priradzuje sa DLs->DLg
				xDLs     := xDev;
	         dlsl     := _Nh_DL_sha(nd := xR^.h.cf.n);
   	      dlma     := _Nh_DL_sha(ma := true, nd := xR^.h.cf.n);
				IF new THEN
	            x4o   := ADR(xR^.o.ob[7]);
					IF xM^.set AND xA^.UsrRight > 2 THEN														
						x4o^.wh			:= 107;
	   	         x4o^.obr[1]   	:= USINT_TO_INT( dlsl );
  	      	      IF xDLs^.cx.sta.Present = false THEN
     	      	      x4o^.BgC[1] := 2;
      	         ELSE
  	      	         x4o^.BgC[1] := 5;
     	      	   END_IF;
        	      	IF xDLs^.cx.sta.ErrID > 0 THEN
           	      	x4o^.ok [3] := 1;
               	   x4o^.obr[3] := USINT_TO_INT( xDLs^.cx.sta.ErrID );;
	                  xR^.o.ob[0].FgC := 7;                                 				// cela dlazdica bude cevena
  		            ELSE
     		            x4o^.ok[3]        := 0;
        		         xR^.o.ob[0].FgC   := 1;
           		   END_IF;
	               x4o^.ok[2]  := 1;
  		            x4o^.obr[2] := USINT_TO_INT( dlma );

						IF xR^.h.chk  = false  THEN                                 		// len ked nie je vo vazbach
							xR^.o.ob[5].w  	:= 300;        											// skrati slider {mozno ho out5inOne aj tak prepise}
							xR^.o.ob[6] 		:= _NhBrwObj.dlgl;										// obrazok vseobecneho listu
							IF xDLs^.cx.scn.grp<>_eBtn15 THEN
  	   						xR^.o.ob[6].fn   	:= 334;
							ELSIF xDev^.al.lst THEN
     							xR^.o.ob[6].fn   	:= 192;
							ELSE
     							xR^.o.ob[6].fn   	:= 39;
							END_IF;													       					
						END_IF;
					ELSE
						x4o^.wh			:= 0;						
					END_IF;

						IF xDls^.cx.cfg.out5inOne THEN
							xR^.o.ob[5] 		:= _NhBrwObj.rgbwa;										// RGBWA namiesto slidera
							xR^.o.ob[5].wh		:= 121;
							xR^.o.ob[4].fn		:= 124;
							xR^.o.ob[4].cm		:= 74;	                                       // otvori priradenie RGBWA k DEV
							xR^.o.ob[2].cm 	:= 249;														// posle prikaz ON/OFF pre 5in1, hoci je aj chk						
						END_IF;


					IF xR^.h.chk THEN
						_NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=432);
						IF xF^.cf.c = 44 THEN                                			// do DLg
							// DLs v scene nema parameter, nastavuje sa len LVL v strukture
	     					dlgr := _Nh_DL_sha(gr:=1,nd := xF^.cf.n)-100 ;				// 0..15
							_Nh_Frm_Row_O13(ob:=5, t:=1, vb:=PTR_TO_UDINT(ADR(xDLs^.cx.scn.LVL[ dlgr ])) );
							xR^.o.ob[2].cm 	:= 0;
						ELSIF xDls^.cx.cfg.out5inOne THEN
							IF xF^.cf.c = 8 THEN													// zatial len pre TVE
								xR^.o.ob[6] 		:= _NhBrwObj.srgbwa;							// led na sebe = ktory port {RGBWA} je priradeny k DEV v hlavicke
								xR^.o.ob[6].cm 	:= 251;											// posle prikaz ON/OFF pre 5in1						
								_NhxPt(c:=xF^.cf.c, n:=xF^.cf.n, x:=-154);
								xTve := xPt;
								_Nh_DEF_VAR(wh:=20, o:=6, x:=ADR(xTve^.io[0].dev.o));				
							ELSE
								xR^.o.ob[6].wh 	:= 0;											// nebude zobrazovat vyber konkretnej farby
							END_IF;
						ELSIF _Nh_IO_MAP(cIo:=xF^.cf.c, Dev:=xR^.h.cf.c)  THEN
							_Nh_Frm_Row_O13(ob:=5, t:=0, vb:=PTR_TO_UDINT(ADR( xPtIOa^.val ) ));
							xR^.o.ob[2].cm 	:= 0;
						ELSIF xR^.o.ob[4].cf.c = 15 THEN                                				// check PIR ma prednost
      					xR^.o.ob[5].wh 	:= 0;
						ELSIF _NhxPar(cp := aCfg[xR^.h.cf.c].par , np := xR^.h.cf.p,x:=-1006) THEN		// SCN,ACT,BLK
							_Nh_Frm_Row_O13(ob:=5, t:=1, vb:=PTR_TO_UDINT(ADR(xPar^.all.lvl)) );											
						ELSE
							xR^.o.ob[5].wh := 0;								
							xR^.o.ob[2].cm := 0;								
						END_IF;

(*
					ELSIF xDls^.cx.cfg.out5inOne THEN								// do TVE, bude zobrazena RGBWA +
						xR^.o.ob[5] 		:= _NhBrwObj.rgbwa;											// obrazok vseobecneho listu
						xR^.o.ob[5].wh		:= 121;
						xR^.o.ob[2].cm 	:= 249;													// posle prikaz ON/OFF pre 5in1						
*)
					END_IF;

				ELSIF	xR^.h.chk THEN
						IF xF^.cf.c = 44 THEN                                		// do DLg
      					dlgr := _Nh_DL_sha(gr:=1,nd := xF^.cf.n)-100 ;				// 0..15
							IF  xR^.o.ob[2].tch THEN												// prepnut LVL s status - LVL je uz zapisany v parametri
								xDLs^.cx.scn.LVL[ dlgr ] := xPar^.all.lvl;
							END_IF;
							IF xR^.o.ob[2].tch OR (xR^.o.ob[5].tch AND xA^.tch.Qf) THEN
//		                  _Nh_DL_ADD_Task(wht:=  4, par:= 1, sha := dlsl , val := dlGr+100, dlm := dlma  );	// prida ballast do sceny, hoci tam uz moze byt
//      		            _Nh_DL_ADD_Task(wht:=102, par := dlgr,  	//   scena		0..15                    	// nastavi LVL pre ballast v scene
      		            _Nh_DL_ADD_Task(wht:=2, par := dlgr,  	//   scena		0..15                    	// nastavi LVL pre ballast v scene
         	                                   	sha := dlsl,    //   ballast	0..63
            	                                	val := REAL_TO_USINT(USINT_TO_REAL(xDLs^.cx.scn.LVL[ dlgr ])*2.45) ,
               	                             	dlm := dlma );
							END_IF;
						END_IF;
				ELSIF xDls^.cx.cfg.out5inOne THEN								// do TVE, bude zobrazena RGBWA +
					;
//					xR^.o.ob[4].fn	:= 124;
//					xR^.o.ob[4].cm	:= 76;	

				ELSE
					_Nh_Frm_Row_O13(ob:=5, t:=0, vb:=PTR_TO_UDINT(ADR(xDev^.al.in.val)) );											
				END_IF;

				IF xDls^.cx.cfg.out5inOne THEN
						;
				ELSE
					_Nh_Frm_STA_OU(obj:=2, o:=8);											// ikony nad stavovym obrazkom
				END_IF;

      44: // DLg
			      // 56:  DLs ->  DLg		... v hlavicke je DLsa v riadkoc su sceny do ktorych moze ist
				   xDLg     := xDev;
   	         dlma     := _Nh_DL_sha(gr:=1, ma := true, nd := xR^.h.cf.n);            // master
      	      dlgr     := _Nh_DL_sha(gr:=1, nd := xR^.h.cf.n)-100;                    // cislo GRP - 100 prevedie na 0..15
					xDLg^.al.lst	:= xDLg^.cx.Sta.Present;											// dolezitejsi je Present, je aj po restarte aktivny
	            x4o   := ADR(xR^.o.ob[7]);
       			IF xR^.h.chk  THEN
						IF xF^.cf.c = 43  THEN																// DLs v hlavicke do tejto sceny
							IF _NhXPt(c:=xF^.cf.c, n:=xF^.cf.n,x:=-135) THEN
								xDLs := xPt;
					         dlsl     := _Nh_DL_sha(nd := xF^.cf.n);
								_Nh_Frm_Row_O13(ob:=5, t:=1, vb:=PTR_TO_UDINT(ADR(xDLs^.cx.scn.lvl[dlgr])) );					
								IF (xR^.o.ob[5].tch AND xA^.tch.Qf) THEN
      			            _Nh_DL_ADD_Task(wht:=2,par := dlgr,  	//   scena		0..15                    	// nastavi LVL pre ballast v scene
         		                                   sha := dlsl,    //   ballast	0..63
            		                                val := REAL_TO_USINT(USINT_TO_REAL( xDLs^.cx.scn.LVL[ dlgr ])*2.45),
               		                             dlm := dlma );
								END_IF;
							ELSE
								xR^.o.ob[5].wh := 0;
							END_IF;
						ELSIF xR^.o.ob[4].cf.c <>  15 THEN
		         	   _Nh_Frm_Row_O13(off:=xR^.h.pir, ob:=5);						
						END_IF;

					ELSE
	         	   _Nh_Frm_Row_O13(off:=xR^.h.pir, ob:=5);
//		            xR^.o.ob[5].BgC := _Nh_U12(xDLg^.al.ou.val=254.0,6,5);                   // slider - aktivovana SCN je oranzova, inak zlta
		            xR^.o.ob[5].BgC := _Nh_U12(xDLg^.al.ou.val=100.0,6,5);                   // slider - aktivovana SCN je oranzova, inak zlta
					END_IF;

					IF xM^.set AND xA^.UsrRight > 2 THEN														
							x4o^.wh	:= 107;
      		         x4o^.obr[1]   := USINT_TO_INT( dlgr );
         		      IF xDLg^.cx.sta.Present = false THEN
            		      x4o^.BgC[1] := 2;
	          	     	ELSE
   	         	      x4o^.BgC[1] := 6;
	   	            END_IF;
   	   	         IF xDLg^.cx.sta.ErrID > 0 THEN
      	   	         x4o^.ok [3] := 1;
         	   	      x4o^.obr[3] := USINT_TO_INT( xDLg^.cx.sta.ErrID );;
            	   	   xR^.o.ob[0].FgC := 7;                                 // cela dlazdica bude cevena
	               	ELSE
		                  x4o^.ok[3]        := 0;
   		               xR^.o.ob[0].FgC   := 1;
      		         END_IF;
         		      x4o^.ok[2]  := 1;
            		   x4o^.obr[2] := USINT_TO_INT( dlma );

                  IF xR^.o.ob[4].cf.c = 15 THEN
   			         xR^.o.ob[5].wh 	:= 0;
						ELSIF xR^.o.ob[6].wh <> 1 THEN
   						xR^.o.ob[6] 		:= _NhBrwObj.list;											// obrazok vseobecneho listu
	     	            xR^.o.ob[6].fn   	:= _Nh_O12(in := xDev^.al.lst , o1:=192, o2:=39); // LIST zeleny/sivy
						   xR^.o.ob[5].w  	:= 300;        												// skrati slider
						END_IF;

   				ELSE
						x4o^.wh	:= 0;
   				END_IF;





(*
					IF NOT( xR^.o.ob[4].cf.c = 15 AND xR^.h.chk ) THEN
						xR^.o.ob[6].wh	:= 1;															// ked je vo vazbe PIR
   				END_IF;
*)
      	      IF xDlg^.cf.rom = 0 THEN
         	      xR^.o.ob[9].wh := 0;
	            END_IF;
            	// 53 DLs/DLg
					_Nh_Frm_STA_OU(obj:=2, o:=8);

		{$ELSE}
	        	42: // DL-M
					;
  				43: // DLS
					;
	        	44: // DL-M
					;
		{$END_IF}

	  48:	// ALA
   		xAla  := xDev;
   		_NhxZon(nz:=xAla^.cf.rom);
	   	xR^.o.ob[4].cm := 204;
   		IF xZon^.cx.lck.stat = SINT_TO_USINT(xAla^.cf.typ) THEN
		   	xR^.o.ob[0].FgC := 3;
    			xR^.o.ob[0].BgC := 1;
			END_IF;

	 150: //TIMER
			xTim	:= xDev;
//			xR^.o.ob[6] 		:= _NhBrwObj.rgbwa;	//_NhBrwObj.dlgl;										// obrazok vseobecneho listu
//_NhBrwObj.dlgl
//			xR^.o.ob[7] 		:= _NhBrwObj.tim_1;										// obrazok vseobecneho listu
	 		x4o    			:= ADR(xR^.o.ob[7]);
			IF xTim^.cf.typ < 2 THEN
						
(*

						 	x4o    			:= ADR(xR^.o.ob[7]);
							xR^.o.ob[1].cm := 128;									// click na hlavnu ikonu = oznacovanie
							x4o^.wh			:= 107;
							x4o^.obj			:= 1;
   	 					x4o^.wxy[1]    := 52;
    						x4o^.wxy[2]    := 42;
							x4o^.obr[1]		:= 44;
							x4o^.obr[2]		:= 38;
							x4o^.ok[1] 		:= xU^.o[1].wh = xR^.h.cf.n;
							x4o^.ok[2] 		:= xRol^.me.cpy;


				_Nh_Shw_107_ROM(off:=1, o:=7);			// vypne zobrazenie nad hl.obrazkom
*)       END_IF;
				_Nh_Shw_107_ROM(off:=1, o:=8);
				blk	:= 5;
	
      ELSE
         IF xR^.h.cf.c > 0 THEN
				IF aCfg[xR^.h.cf.c].fbr = 15 THEN											// PODLA FORMULARA BROWSU
              	// DOR
						blk	:= 5;
						IF xA^.admin  THEN
						ELSE
                     xR^.o.ob[6].wh :=  0;                        // u WSB vypne predvolby
                     xR^.o.ob[2].cm :=  0;                        // u WSB vypne predvolby
						END_IF;					
              ELSIF aCfg[xR^.h.cf.c].fbr = 20 THEN
					  // LUX,TER,TEH,TEK, 41=CO2
						_Nh_Shw_B20_ROW();
   					blk	:= 6;
	           ELSIF 	aCfg[xR^.h.cf.c].fbr = 43 							// SVD,SVA,RGB,ZAS,32=SIR,49=VVO
	           		OR aCfg[xR^.h.cf.c].fbr =  5 THEN					// SCN,ACT,DLS,DLG,DLM
		            _Nh_Frm_STA_OU(obj:=2, o:=8);
						IF aCfg[xR^.h.cf.c].analog THEN
		         	   _Nh_Frm_Row_O13(off:=xR^.h.pir ,ob:=5);
						ELSIF xM^.set THEN
//							blk 					:= 5;
							xR^.o.ob[5].wh    := 0;
						ELSE
							xR^.o.ob[5].wh    := 0;
						END_IF;
            ELSE
            ;
            END_IF;
      	END_IF;
	END_CASE;

	IF xM^.set AND new AND blk > 0 THEN
		_Nh_DEF_VAR(wh:=20, o:=blk, x:=ADR(xDev^.cf.blk));				

//		xR^.o.ob[blk].x     := 125;							
		xR^.o.ob[blk].w     := 48;							
		xR^.o.ob[blk].h     := 48;							
		xR^.o.ob[blk].FgC   := 4;
		xR^.o.ob[blk].BgC   := 2;
		xR^.o.ob[blk].fn    := 0;

	END_IF;     			



	{$ END_IF }
END_FUNCTION





