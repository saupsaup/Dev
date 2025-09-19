{ $ IFDEF __NH_WEB }

(*   vyhodnotenie vybrateho menu prebieha

   -  _Nh_Web_CMD (_NhCmd)         - vyvola akciu :
   -  _NhCmdAction   - co sa ma urobit po vybrati volby menu + podporne akcie (ulozi udaje z klasickej web-maker PAGE...)
   -  _NhCmdScreen   - nadefinuje objekty obrazovky + filtre a typ obrazovky (obj)

*)



//********* MNU *******************************************

VAR_GLOBAL
  aWht   : NH_TCH_WHT;
END_VAR













FUNCTION _NhFavNaz {HIDDEN}  : BOOL    // najde aktualne vybraty FAV a zapise veho nazov
   VAR_INPUT
      sav   : BOOL;
   END_VAR
   _NhFavNaz := true;
   FOR nd := 1 TO aCfg[20].rec DO
      _NhxDev(c := 20, n := nd, x:=16);
      xFav := xDev;
      IF xFav^.cx = xA^.fav THEN
         IF sav THEN
            xFav^.cf.Name := xL^.naz;
         ELSE
            xL^.naz := xFav^.cf.Name;
         END_IF;
         nd := 0;
         RETURN;
      END_IF;
   END_FOR;
   _Nh_Lang(id := 18 ,txt := ADR( xL^.naz ), zn:=20);             // oblubene
   nd := 0;
END_FUNCTION

FUNCTION _NhDefSet {HIDDEN}  : BOOL    // vzdy na zaciatku LEN na tomto mieste sa nadefinuju parametre vsetkych browsov, frame....
   VAR_INPUT
      chg      : BOOL;
   END_VAR
   _NhDefSet      := true;
   xU^.o[1]       :=  eMnH.o[1];                                   // aktivuje logo
   IF chg THEN

      xM^.set           := false;

      xUsr^.cx.LastSet  := false;
      CASE xU^.o[2].fn OF
         23:   xU^.o[2].fn := 25;   xM^.set           := true;
                                    xUsr^.cx.LastSet  := true;
         25:   xU^.o[2].fn := 23;
        ELSE   xU^.o[2].fn := 0;
      END_CASE;
   ELSIF xUsr^.cx.Set THEN
      xU^.o[2]       :=  eMnH.o[2];                               // default setup (sivy)
      IF xUsr^.cx.LastSet THEN      //OR aSys.NewDbx THEN
         xM^.set     := true;
         xU^.o[2].fn := 25;
      ELSE
         xM^.set := false;
         xU^.o[2].fn := 23;
      END_IF;
   ELSE
      xU^.o[2].cm := 0;                                              // nezobrazi sa
      xU^.o[2].fn := 0;
      xM^.set     := 0;
   END_IF;
END_FUNCTION


/// *******************************


FUNCTION _Nh_Web_CMD_Screen    : BOOL       // NADEFINUJE OBJEKTY OBRAZOVKY podla akcie od CMD
   (*
    screen sa rozlisuje podla xL^.obj
    - vytvori cistu LVL
    - nadefinuje vrchne a spodne menu
    - v naplni nazov screenu
    - naplni filter DEV (pre brows)
    - naplni filter ROM
    - prelozi nazov do vybrateho jazyka
   *)
   VAR_INPUT
      eMnu     : BOOL;
      obr      : INT;
      obj      : USINT;
      mnu      : USINT := 0;                                               // povolenie menu zmeny DSH (cislo vrchneho menu) 1,2
		n			: USINT;
   END_VAR
   _Nh_Web_CMD_Screen   := 0;
   xM^.wht        := 20;                                                   // pokusi sa najst 1 vetu podla usra
   xL^.brw        := true;
   xL^.obj        := obj;
   xL^.vis        := true;

//   _NhxUsr(u:= xA^.usr);                                                   // namapuje usra
   IF xL^.obj > 30 THEN
      xL^.dsh        := 1;
      mnu            := 0;
   ELSE
      xL^.dsh        := xUsr^.cx.brw[ xL^.obj ];
   END_IF;
   nd             := 0;                                                    // ID textu do xL^.naz

	IF xF^.cf.c > 0 AND xF^.cf.c <> 2 THEN
	   _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=47);               				// namapuje hlavicku, napr. koli zisteniu ROM
	END_IF;
	
   CASE obj OF
     0:  // home page
         mnu            := 0;
         _NhDefSet();
         xL^.vaz        := 1;
         xL^.fvz        := true;
         xU^.o[3].fn   := 0;                                              // zrusi HOME
         xU^.o[8].fn   := 0;                                              // zrusi ON/OFF
         xF^.cf.c      := 3;                                               // default DEV je zon pre cely dom
         xF^.cf.n      := 1;
         xU^.n         := 0;                                               // ziadne vybrate menu
         _NhName(xName := ADR(xL^.Naz) , cf := xF^.cf.c, nd := xF^.cf.n);  //'Môj domov';
         xM^.naz        := xL^.Naz;
         xF^.dev.n[0]   := true;
         xM^.wht        := 25;                                              // pokusi sa najst 1 vetu podla usra
         xL^.dsh        := 0;
         mnu            := 0;

     1: // brow-Zoznam FAV
            nd             := 19;                                          // cislo textu v _NhLang
            xF^.dev.n[20]  := 1;
            xU^.o[2].fn    := 32;                                          // +
            xU^.o[2].cm    := 101;                                          // pridat oblubeny do zoznamu usra
            xF^.cf.c       := 20;                                               // default DEV je zon pre cely dom
            xL^.dsh        := 1;
            mnu            := 0;

     2: // brow-FVL
            _NhFavNaz();
            xF^.dev.n[0]   := 1;
            xL^.vaz        := 1;                                           // cislo vazby
//            xL^.fvz        := true;
            xF^.cf         := xA^.fav;

     3:  // brow-Quick (FAV)
            _NhFavNaz();
            xF^.dev.n[0]   := 1;
            xL^.vaz        := 1;
//            xL^.fvz        := true;
            xF^.cf         := xA^.fav;

     4: // brow-DASH (FAV)
            _NhFavNaz();
            xF^.dev.n[0]   := 1;
            xL^.vaz        := 1;
//            xL^.fvz        := true;
            xF^.cf         := xA^.fav;

     5: // brow-Rooms
            nd             := 7;
            xF^.cf.c       := 1;
            xF^.dev.n[1]   := 1;
            IF xA^.admin THEN
               xU^.o[2].fn    := 32;                                       // pridat ROM
               xU^.o[2].cm    := 101;
            END_IF;
            mnu   := 0;

     6: // brow-ZONES
            nd             := 8;
            xF^.cf.c       := 3;
            xF^.cf.n       := 0;
            xL^.dsh        := 1;
            mnu            := 0;
            IF xA^.admin THEN
               xU^.o[2].fn    := 32;                                       // pridat zonu
               xU^.o[2].cm    := 101;
               _NhFilDev(wht:=2, row:=201);
            ELSE
               _NhFilDev(wht:=2, row:=200);
            END_IF;

     7: // brow-CAT
            IF xU^.o[6].wh = 24 THEN
               xF^.typ        := -2;   									// setup menu				
               nd             := 12;                           	
	            IF xM^.set THEN
   	            xU^.o[2].fn    := 230;                         	// save
      	         xU^.o[2].cm    := 101;
	            END_IF;
            ELSE
               xF^.typ        := -1;                              // odfiltruje kategorie na 1.urovni  (xCid^.typ=1);
               nd             := 9;
            END_IF;
            xF^.cf.c          := 2;
//            xF^.dev.n[2]      := 1;

     8: // brow-ACT
            nd             := 10;
            xF^.cf.c       := 5;
            xF^.dev.n[2]  	:= true;											// povoli kategorie
            xF^.dev.n[5]   := 1;
//            xF^.cat.n[54]  := 1;											// + DALI SCENY
            IF xM^.set THEN
               xU^.o[2].fn    := 32;                           // pridat akciu
               xU^.o[2].cm    := 101;
	            xF^.cat.n[55]  := true;									// + Akcie PSN
            END_IF;
            mnu := 0;

     9: // brow-SCN
            nd             := 11;
            xF^.cf.c       := 4;
            xF^.dev.n[4]   := true;                              	// len sceny
            xF^.dev.n[2]  	:= true;											// povoli kategorie
//            xF^.cat.n[53]  := true;											// + NH SCENY
            xF^.cat.n[54]  := true;											// + DALI SCENY

            IF xM^.set THEN
               xU^.o[2].fn    := 31;                           // pridat scenu
               xU^.o[2].cm    := 101;
            END_IF;
            mnu := 0;

    10: // brow- 1 miestnost
				IF xL^.psn THEN
	            xU^   := xM^.mnu[0];                           // ak pride vnorenim z psn nastavi menu z domceka
				END_IF;
            xU^.n             := 5;                            // cislo vybrateno menu
            xU^.o[xU^.n].wh   := 18;                           // 1.miestnost sive
            xU^.o[xU^.n].fn   := 16;                           // miestnosti biele
            xF^.rom           := INT_TO_USINT(xF^.cf.n);       // filtrovanie 1.miestnosti
            IF xDev^.cf.typ = 0 THEN                        	// 0=len pre administratora, setup miestnost, kde su vsetky co nemaju room
               _NhFilDev(wht:=1, row:=203);
//               xF^.dev.n[43] := false;                           // v setup sa zobrazuju DLs a DLg, tie su v DALI
//               xF^.dev.n[44] := false;
            ELSE
//               xF^.rom           := INT_TO_USINT(xF^.cf.n);       // filtrovanie 1.miestnosti
               IF xM^.set THEN
                  _NhFilDev(wht:=1, row:=_Nh_U12(xA^.admin,204,201));
                  IF xDev^.cf.typ < 10 THEN
                     xU^.o[2].fn := 31;
                     xU^.o[2].cm := 101;                              // pridat scenu
                  END_IF;
                  mnu         := 0;                               // zmenit dash vlavo
               ELSE
                  _NhFilDev(wht:=1, row:=200);
                  mnu            :=  0;
               END_IF;
            END_IF;

    11: // brow - 1 zona
            xU^.n             := 5;                                     // cislo vybrateno spodneho menu
            xU^.o[xU^.n].wh   := 22;
            xU^.o[xU^.n].fn   := 20;
            xF^.dev 				:= eFilt_LIST;                             // empty filter
            xF^.dev.n[1]	 	:= true;
//            xF^.dev.n[22] := true;                          // users
            IF xF^.cf.n = 1 THEN
               xF^.rom := 0;
            ELSE
               xF^.rom := INT_TO_USINT(xF^.cf.n);
            END_IF;

    12: // brow - 1.kategoria
            IF xU^.n = 0 THEN                                           // cislo vybrateno menu

				ELSE
					xU^.n    			:= 6;                                      	// vyberie menu CAT
               xU^.o[xU^.n].fn  	:= 13;                               // nastavi obr 1.CAT sivy
               xU^.o[xU^.n].wh  	:= 13;                               // nastavi obr 1.CAT sivy
				END_IF;
            xF^.rom        := 0;
            xF^.typ        := INT_TO_SINT(xF^.cf.n);
				_NhFilDev(wht:=0);													// vymaze filter DEV,CAT
            xF^.dev.n[2]   := true;												// vsetky CAT
            _NhxRoW(nbr:=xA^.sbj, zon:=true);                        // namapuje xRow na Domcek alebo ak sa pouzivaju subjekty tak na subjekt-byt
				_Nh_Set_ONOFF(set:=xRoW^.cat[ xF^.cf.n ]);

(*
				xU^.o[1].fn   	:= 1;													// NH
 				xU^.o[1].wh   	:= 1; 										
				xU^.o[1].cm   	:= 24;                            			// menu NH
*)
            mnu         := 0;
            IF xM^.set THEN
               CASE xF^.cf.n OF
                  3:    // Tienenie = ROL
			 					xU^.o[1].fn   	:= 0; 										
		 						xU^.o[1].wh   	:= 0; 										
								IF xM^.set THEN
									xU^.o[2].fn   	:= 45;										// sivy COPY
				 					xU^.o[2].cm   	:= 129;                            	// zmena siveho copy na zlty
								ELSE
									xU^.o[2].fn   	:= 0;	
				 					xU^.o[2].cm   	:= 0;
								END_IF;
								mnu 				:= 1;

_Nh_Set_ONOFF(set:=false);										


				      4:    // vetranie
                        _Nh_Set_ONOFF(set:=false);										
                        IF xM^.set THEN
                           xU^.o[2].fn := 339;                                // pridat regulator
                           xU^.o[2].cm := 101;                                // pridat regulator akcia
                        ELSE
                           xU^.o[2].fn := 0;                                // pridat regulator
                        END_IF;

                  5:    // KOMFORT : dodefinuje pridanie regulatora
                        _Nh_Set_ONOFF(set:=false);										
                         xU^.o[2].fn := 182;                                // pridat regulator
                         xU^.o[2].cm := 101;                                // pridat regulator akcia

                  7:    // brany
                        _Nh_Set_ONOFF(set:=false);										// bran nie je vela, NEnastavi sa filter
//                        mnu            := 1;
                  39:    // setup HET
								_Nh_Set_ONOFF(set:=false);
                        IF xA^.admin THEN
	                         xU^.o[2].fn := 225;                                // pridat vsetky regulatory
   	                      xU^.o[2].cm := 141;                                // pridat regulator akcia
								END_IF;
(*

                 44:    // vsetky dev bez miestnosti alebo zle priradene
                        _NhFilDev(wht:=1, row:=199);

//                        xF^.dev     := _NhfDev.rom[199];                // zoznam DEV pri rezime SET
                        xU^.o[6].wh    := 11;                                                 // default prave horne menu je nic
                        xU^.o[6].cm    := 34;
                        xU^.o[6].fn    := 10;                                                 // default prave horne menu je nic                                                                         // default prave horne menu je nic
                        xL^.obj        := 13;
//                        xL^.fdv        := 0;
//                        mnu            := 1;
*)
                  41:   //

               ELSE
               END_CASE;
            END_IF;
		   	rb:=_Nh_FRM_Read(frm:=232);     						// CAT
  	         nd := yFrm_232.cat[xF^.cf.n].txt;                                  	// hlavny text {druhy riadok je vzdy o cislo vacie"
            xL^.dsh     := 1;




(*
            xU^.n    := 6;                                           // cislo vybrateno menu
            IF xU^.o[xU^.n].wh  <>  24 THEN                          // setup zostava
               xU^.o[xU^.n].fn  := 13;
               xU^.o[xU^.n].wh  := 13;
               xU^.o[3]       := eMnH.o[3];                                     // aktivuje HOME
            END_IF;
            xU^.o[2].fn    := 0;                                                 // default prave horne menu je nic
            xU^.o[2].cm    := 0;
            xF^.rom        := 0;
            xF^.typ        := INT_TO_SINT(xF^.cf.n);
*)






    13:  // brow - vsetky zony pre SEC

(*

            xL^.psn  := true;
            xU^.n    := 6;                                           // cislo vybrateno menu
            IF xU^.o[xU^.n].wh  <>  24 THEN                          // setup zostava
               xU^.o[xU^.n].fn  := 13;
               xU^.o[xU^.n].wh  := 13;
               xU^.o[3]       := eMnH.o[3];                                     // aktivuje HOME
            END_IF;
            xU^.o[2].fn    := 0;                                                 // default prave horne menu je nic
            xU^.o[2].cm    := 0;
//            xF^.dev.n[2]   := true;
            xF^.rom        := 0;
            xF^.typ        := INT_TO_SINT(xF^.cf.n);
//            nd             := _NhDefCat[xF^.cf.n].ID;
//            xL^.dsh        := xUsr^.cx.brw[ xL^.obj ];
            mnu            := 2;
*)


    14:  // brow - 1 zona SEC
            xL^.psn           := true;
            xU^.n             := 5;                                     // cislo vybrateno menu
            xU^.o[xU^.n].wh   := 22;
            xU^.o[xU^.n].fn   := 20;
            xU^.o[2].fn       := 0;
            xF^.dev.n[1]      := true;                            // zobrazuju sa len mistnosti, ktore vstupuju do zony
            xF^.rom           := 0;
//            xL^.dsh           := xUsr^.cx.brw[ xL^.obj ];
            mnu               := 0;

    15: // brow- 1.miestnost zobrazuje len SEC
//            xL^.psn           := true;
            xU^.n             := 5;                            // cislo vybrateno menu
            xU^.o[xU^.n].wh   := 18;                           // 1.miestnost sive
            xU^.o[xU^.n].fn   := 16;                           // miestnosti biele
            xF^.rom           := INT_TO_USINT(xF^.cf.n);       // filtrovanie miestnosti
//            xL^.fRom          := true;
            _NhFilDev(wht:=1, row:=202);
//            xF^.dev           := _NhfDev.rom[202];                // zoznam DEV pri rezime SET
//            xL^.dsh           := xUsr^.cx.brw[ xL^.obj ];
            mnu               := 2;


    20: // brow-BLK
            nd             := 107;
            xF^.cf.c       := 35;
            xF^.dev.n[35]  := 1;
            IF xM^.set THEN
               xU^.o[2].fn    := 195;                           // + BLK
               xU^.o[2].cm    := 101;
            END_IF;

    21: // brow-TIM
            nd             := 333;
            xF^.cf.c       := 50;
            xF^.dev.n[50]  := 1;
            IF xM^.set THEN
               xU^.o[2].fn    := 294;                           // + TIM
               xU^.o[2].cm    := 101;
            END_IF;


    22: // brow-SMW
            nd             := 339;
            xF^.cf.c       := 25;
            xF^.dev.n[25]  := 1;
            IF false THEN // xM^.set THEN
               xU^.o[2].fn    := 299;                           // + SMW
               xU^.o[2].cm    := 101;
            END_IF;


    30: // brow priradenie ROM/KLA do ZON
				xF^.dev 				:= eFilt_LIST;                             // empty filter
(*
				IF n = 7 THEN
	            xF^.dev.n[24] 	:= true;									// len KLAvesnice
            	xU^.n       	:= 7;
            	nd             := 413;									// miestnosti v zone
				ELSE
	            xF^.dev.n[1] 	:= true;									// len ROM
            	xU^.n       	:= 8;
            	nd             := 407;									// miestnosti v zone
				END_IF;
*)
				xPt^.al.lst		:= false;
           	xU^.n       	:= 8;
            xF^.dev.n[1] 	:= true;									// len ROM
	         xU^.o[4].fn    := 0;                           	// vypne CAT
            xL^.fvz    	 	:= true;                      	// default filtruje
	         xU^.o[2].fn    := 0;                           	// vypne +
         	xU^.o[3].fn    := 38;
            mnu            := 0;
            xL^.brw     	:= 1;
            xL^.dsh     	:= 1;                                              // pevny DASH, 1 riadok
            xL^.chk     	:= true;                                           // priznak ze sa zaskrtava CHK, nie FAV
            xL^.vaz     	:= 0;


(*
    31: // akcie LOCK/UNLOCK
				xF^.dev 				:= eFilt_LIST;                             // empty filter
            xF^.dev.n[3] := true;
            xU^.o[4].fn    := 10;
            nd             := 0;

            nd             := 408;									// akcie od alarmu

            mnu            := 0;
            xL^.brw     := 1;
            xL^.dsh     := 1;                                              // pevny DASH, 1 riadok
            xL^.chk     := true;                                           // priznak ze sa zaskrtava CHK, nie FAV
            xL^.vaz     := 2;
            xU^.n       := 5;
*)


    32: // akcie od ALARMU
    			xF^.dev 				:= eFilt_LIST;                             // empty filter
            xF^.dev.n[48] 	:= true;
//            xF^.dev.n[35] 	:= true;
//            xF^.rom 			:= INT_TO_USINT(xF^.cf.n);
            nd             := 408;									// akcie od alarmu
            mnu            := 0;
            xL^.brw     	:= 1;
            xL^.dsh     	:= 1;                                              // pevny DASH, 1 riadok
            xL^.chk     	:= false;                                           // priznak ze sa zaskrtava CHK, nie FAV
            xL^.vaz     	:= 0;
            xU^.n       	:= 6;
            IF xA^.UsrRight > 1 THEN
               xU^.o[2].fn    := 32;                           // pridat akciu
               xU^.o[2].cm    := 101;
            END_IF;

    33: // simulacie pritomnosti
    			xF^.dev 				:= eFilt_LIST;                             // empty filter
            xF^.dev.n[10] 	:= true;
            xF^.dev.n[35] 	:= true;
            nd             := 410;	
            mnu            := 0;
            xL^.brw     	:= 1;
            xL^.dsh     	:= 1;                                              // pevny DASH, 1 riadok
            xL^.chk     	:= true;                                           // priznak ze sa zaskrtava CHK, nie FAV
            xL^.vaz     	:= 0;
            xU^.n       	:= 5;
            IF xA^.UsrRight > 1 THEN
               xU^.o[2].fn    := 32;                           // pridat akciu
               xU^.o[2].cm    := 101;
            END_IF;

    47: // brow- dali Sceny
         mnu            := 2;
         _Nh_FRM_Read(frm:=6);
         xF^.dev.n[44]  := 1;
         xU^.o[7].fn := 334;                            // browser DLg  47
         xU^.o[4].fn    := 0;                           // CAT nebude viditelne
         xL^.dsh        := 1;
         xU^.o[3].fn := 35;                                      // bez vazieb aj s
         xU^.o[5].fn := 16;                                      // vsetky ROM
         xU^.o[6].fn := 335;                                     // len jeden master co je v hlavicke
         xU^.o[8].fn := 49;                                      // aj  ON aj OFF

    48: // brow- zoznam SLAVE k MASTRU v hlavicke
         mnu            := 2;
         _Nh_FRM_Read(frm:=6);
         xF^.dev.n[43]  := 1;
         xU^.o[6].fn    := 335;
         xL^.dsh        := 1;
			_Nh_Set_ONOFF(set:=xDev^.al.sta=1);


    49: // brow-DALI - zoznam Master
            nd             := 334;
            xF^.dev.n[42]   := 1;
            xM^.set := true;
            xL^.dsh := 1;

    50: // vstup do VAZIEB cez setup v riadku
            IF eMnu THEN
	            _Nh_FRM_Read(frm:=17);
               IF obr = 0 THEN
                  obr := xU^.o[2].fn;
               END_IF;
//               xU^         := eMvz;                                        // default menu 1
               xU^.o[2].fn := obr;  //_NhObrNbr(cf := xF^.cf.c, t := xDev^.cf.typ);      // default obrazok vyssej casti
					IF aCfg[ xF^.cf.c ].lst = false THEN
//						xU^.o[7].cm	:= 0;
//						xU^.o[7].fn := 0;								
					END_IF;
//					xL^.vis		:= false;
            END_IF;
//					IF aCfg[ xF^.cf.c ].Visible = false THEN					
//						xU^.o[6].fn	:= 0;
//						xU^.o[6].cm	:= 0;
//   				END_IF

            xU^.n       := 8;                                           // prednastavi LIST-menu
            xL^.obj     := 50;
            xL^.brw     := 1;                			
            xL^.dsh     := 1;
            xL^.chk     := true;                      // priznak ze sa zaskrtava CHK, nie FAV
				xL^.vaz     := 2;
				xL^.fvz     := xPt^.al.vaz;					// ak ma vazby, nastavi sa filter
            mnu 			:= 0;                         // nevybera sa DSH
            IF xL^.fvz THEN									// ak je zapnuty filter, vypne filtrovanie ROM
            	xF^.rom  := 0;
     	      ELSE
     	      	xF^.rom  := xPt^.cf.rom;
           	END_IF;
//            _Nh_Vaz_ROM();
//            _Nh_Vaz_DEV();
				_Nh_Vaz_DEV();
            _Nh_Vaz_CHK();





    51: // vstup do DEV-listu.	moze vzniknut xL^.obj :=     43 Dls, 44 DLg v hlavicke
            IF eMnu THEN
	            _Nh_FRM_Read(frm:=17);
               IF obr = 0 THEN
						_NhTypObr(cf:=xF^.cf.c, typ:=xPt^.cf.typ);
						obr := xObrWht^.obr;
               END_IF;
               xU^.o[2].fn := obr;
               xL^.chk     := true;                                     // priznak ze sa zaskrtava CHK, nie FAV
               xL^.brw     := 1;
               xL^.dsh     := 1;                                        // pevny DASH, 1 riadok
					xL^.vis		:= false;
            END_IF;
				xL^.vaz     := 0;
				IF xU^.o[6].cm	= 77 OR xU^.o[6].cm	= 75 THEN 		// Ext.vazby OR RGBWA
					xL^.vis		:= false;
					xU^.o[6].fn	:= xU^.o[6].fn;
				ELSIF xU^.o[6].cm	= 36 THEN //aCfg[ xF^.cf.c ].Visible  THEN					
					xU^.o[6].fn	:= _Nh_O12(in := xL^.vis , o1:=113, o2:=112);
				ELSIF aCfg[ xF^.cf.c ].Visible THEN
					xU^.o[6].fn	:= 112;
					xU^.o[6].wh	:= 113;
					xU^.o[6].cm	:= 36;
					xU^.o[6].fn	:= _Nh_O12(in := xL^.vis , o1:=113, o2:=112);
				ELSE
					xU^.o[6].fn	:= 0;
					xU^.o[6].cm	:= 0;
				END_IF;
            xL^.fvz     := xPt^.al.lst;
            xU^.n       := 7;                                           // prednastavi LIST-menu
            IF xL^.fvz THEN
               xF^.rom  		:= 0;
               xF^.dev.n[1]	:= 1;    											// vsetky dev
               xL^.fdv			:= 0;  	                               	// vsetky CAT
            ELSE
               xF^.rom  := xPt^.cf.rom;
            END_IF;
            mnu 			:= 0;
				ok				:= false;
            CASE xF^.cf.c OF
              4 : // SCN-LIST
                  xL^.vaz     	:= 3;
              5 : // ACT-LIST
                  xL^.vaz     	:= 4;
              6 : // HET-reg
                  xL^.vaz     	:= 4;
						;
              7 : // KOT-teplota
						;
              8 : // TVE-teplota
						;
              9 : // CER
						;
             47 : // HEV-reg
                  xL^.vaz     	:= 4;
             35 : // BLK-LIST
                  xL^.vaz     	:= 4;
             37 : // GATE-koncovy snimac DOOR/WIN
                  xL^.vaz     := 0;
             43 : // DLS-Dali-DEV LIST - len dali sceny do ktorych DLs patri
             		xL^.obj  		:= 43;						
                  xL^.vaz  		:= 0;
						xDLs				:= xPt;
						xF^.dev.n[44] := true;
						{$IFDEF __NH_DALI}
		            xL^.fvz     := xDLs^.cx.scn.grp <> _eBtn15;
                  {$END_IF}
		            IF xL^.fvz THEN
      		         xF^.rom  := 0;
		            ELSE
      		         xF^.rom  := xPt^.cf.rom;
            		END_IF;
						xPt^.al.lst 	:= false;			// resetne zobrazovanie pouzitej sceny (siva farba pod cislom sceny)				
						IF xDls^.cx.cfg.out5inOne THEN								// do TVE, bude zobrazena RGBWA +
							xU^.o[6].fn	:= 124;
							xU^.o[6].wh	:= 125;
							xU^.o[6].cm	:= 75;
						END_IF;

             44 : // DLg-LIST : v hlavicke je DALI scena (DLg), v liste su len DLs  DLg->DLs
						{$IFDEF __NH_DALI}
                  xL^.obj     			:= 44;
						xDLg						:= xPt;
						xDLg^.cx.sta.Present := false;			// resetne zobrazovanie pouzitej sceny (siva farba pod cislom sceny)				
                  xU^.o[4].fn := 0;          				// CAT sa pri DLg nezobrazuju, mozu byt len DLs
						xPt^.al.lst 			:= false;			// resetne zobrazovanie pouzitej sceny (siva farba pod cislom sceny)				

                  {$END_IF}
             48 : // ALA
                  xL^.vaz     := 4;
            ELSE  // v hlavicke je klasicke DEV avaz[3], alebo DEV-ballast - ma svoju strukturu scn

//                  xL^.vaz     := 3;          // dali sceny maju vazby len k DLs
            END_CASE;
				_Nh_Vaz_DEV();
            _Nh_Vaz_CHK(ini:=true);


	 52: 	// vstup do menu - SETUP - priradeneie do ROM/ZON

            xL^.fvz     	:= 0;
            xL^.chk     	:= 1;                                           // priznak ze sa zaskrtava CHK, nie FAV
            xL^.dsh     	:= 1;
  	 			xL^.vaz     	:= 0;	
            xF^.dev.n[1]  	:= true;						
				IF xL^.obj <> 70 THEN
	            _Nh_FRM_Read(frm:=54); 										// nacita menu
					IF aCfg[xF^.cf.c].zone THEN
		            xF^.dev.n[3]  	:= 1;						
					END_IF;
//	           	xU^.o[2].fn 	:= _NhObrNbr(cf := xF^.cf.c, t := xDev^.cf.typ);      // default obrazok vyssej casti
					_NhTypObr(cf:=xF^.cf.c, typ:=xPt^.cf.typ);
					xU^.o[2].fn := xObrWht^.obr;

//					IF xDev^.cf.rom > 0 THEN
					IF xPt^.cf.rom > 0 THEN
		            xL^.fvz     	:= 1;
					END_IF;
				END_IF;
//            xU^.n       	:= 8;
				xL^.obj     	:= 70;							// aj rom , u niektor aj ZON
            mnu 				:= 0;
				_Nh_Vaz_CHK();

    55: // Extrne vazby DEV - na DALI,MQTT,....
				xL^.vaz     := 0;
            IF eMnu THEN
	            _Nh_FRM_Read(frm:=17);
               IF obr = 0 THEN
//                  obr := _NhObrNbr(cf := xF^.cf.c, t := xPt^.cf.typ);      // default obrazok vyssej casti;
						_NhTypObr(cf:=xF^.cf.c, typ:=xPt^.cf.typ);
						obr := xObrWht^.obr;

               END_IF;
               xU^.o[2].fn := obr;
               xL^.chk     := true;                                     // priznak ze sa zaskrtava CHK, nie FAV
               xL^.brw     := 1;
               xL^.dsh     := 1;                                        // pevny DASH, 1 riadok

					xU^.o[6].fn	:= 367;
					xU^.o[6].wh	:= 368;
					xU^.o[6].cm	:= 77;
					n				:= 6;

(*
					xU^.o[7].fn	:= 367;
					xU^.o[7].wh	:= 368;
					xU^.o[7].cm	:= 77;
					n				:= 7;
*)

            END_IF;
            xU^.n       := n;                                           // prednastavi LIST-menu
//				xL^.vis		:= false;
            mnu 			:= 0;
				ok				:= false;
            CASE xF^.cf.c OF
              6 : // HET
						xHet		:= xPt;
              7 : // KOT
						xTve		:= xPt;

              8 : // TVE
						xTve		:= xPt;

              9 : // CER
						xTve		:= xPt;
(*
             43 : // DLS-Dali-DEV LIST - len dali sceny do ktorych DLs patri
						xDLs := xPt;
						IF xDls^.cx.cfg.out5inOne THEN								// do TVE, bude zobrazena RGBWA +
							xU^.o[6].fn	:= 124;
							xU^.o[6].wh	:= 125;
							xU^.o[6].cm	:= 75;
						END_IF;
						xF^.dev.n[43] := true;
*)
            ELSE  // v hlavicke je klasicke DEV avaz[3], alebo DEV-ballast - ma svoju strukturu scn
					;
            END_CASE;
				_Nh_Vaz_DEV();
            _Nh_Vaz_CHK(ini:=true);




    56: // list RGBWA je DLs v hlavicke
            IF eMnu THEN
	            _Nh_FRM_Read(frm:=17);
               xU^.o[2].fn := obr;
               xL^.chk     := true;                                     // priznak ze sa zaskrtava CHK, nie FAV
               xL^.brw     := 1;
               xL^.dsh     := 1;                                        // pevny DASH, 1 riadok
					xL^.vis		:= false;
					xL^.fvz 		:= true;

					xU^.o[6].fn	:= 124;
					xU^.o[6].wh	:= 125;
            END_IF;
            xU^.n       		:= 6;                                           // prednastavi LIST-menu
				xL^.vaz     		:= 0;
				_Nh_Vaz_DEV();
            _Nh_Vaz_CHK();

(*
    56: // brow-MSG (all)
            nd             := 56;
            xF^.cf.c       := 46;
            xF^.dev.n[46]  := 1;
            mnu            := 1;
            IF xM^.set THEN
               xU^.o[2].fn    := 237;                           // pridat akciu
               xU^.o[2].cm    := 101;
	            xF^.cat.n[57]  := true;									// + Akcie PSN
            END_IF;
*)

    57: // brow-MSG (len alarm)
            nd             := 388;
            xF^.cf.c       := 46;
            xF^.dev.n[46]  := 1;
            mnu            := 1;


    60: // brow - uzky vyber pre kopirovanie POI: ROM/HET/VEN
           	_Nh_FRM_Read(frm:=79);							// menu kopirovania
            xF^.dev.n[xF^.cf.c]  := true;                    	// filter na CF podla hlavicky
				xL^.naz 					:= xPt^.cf.Name;					// nazov dev z ktoreho sa kopiruje
            xL^.dsh 					:= 4;                         // tenky browser

(*
   100: // Dashboard meteostanica

         xL^.obj        := 205;                                      // podhodi sa 200
         xA^.tch.cm     := 206;
         xA^.tch.cmd    := 206;                                      // vrati sa uz do 200
			_Nh_FRM_Read(wht := 3, frm :=  69);
         xF^.rom        := 0;                                      // podla tohto sa nadefinuje menu
			xF^.cf.c			:= 3;
			xF^.cf.n			:= 1;	
			nd					:= 240;
			mnu				:= 0;

      _NhLang(id := nd ,txt := ADR( xL^.naz ));


   xM^.wht        := 0;                                                   // pokusi sa najst 1 vetu podla usra
   xL^.brw        := 0;
//   xL^.obj        := obj;
   xL^.vis        := 0;
*)

   END_CASE;
   IF mnu > 0 THEN
      _Nh_Brw_Dsh_Chg(mnu := mnu);
   END_IF;
   IF nd > 0 THEN
      _Nh_Lang(id := nd ,txt := ADR( xL^.naz ),zn:=20);
   END_IF;
   
END_FUNCTION


FUNCTION _NhxLvl {HIDDEN}  : BOOL
   i     := xM^.lvl;
   xL    := ADR(xM^.lvd[i]);                                // old Level
   xF    := ADR(xL^.fil);
   xU    := ADR(xM^.mnu[i]);
END_FUNCTION

FUNCTION _NheLvl  {HIDDEN}   : BOOL                                // dopredu,dozadu
   VAR_INPUT
      lvl      : SINT;
   END_VAR
   _NheLvl 		:= true;
   CASE lvl OF
     1 : // o uroven dopredu
         IF xM^.lvl < 3 THEN
            xM^.lvl     := xM^.lvl + 1;                        // zvysi sa lvl
            _NheBrw(wht := 3);                                 // vymaze sa veta lvd[lvl] (nie data ani riadok odkial odskok je)
            _NhxLvl();                                         // namapuju sa k novemu lvl

//            xB^.r[0]    := xR^;                             // v r[0] bude cela veta a odial r[0].h.chk - ci bola vazba


            xU^         := xM^.mnu[xM^.lvl-1];                 // na zaciatok sa preberie menu
            xU^.o[1].fn := 6;                                  // sipka spat
            xU^.o[1].cm := 31;                                 // cmd spat
            xL^.vis     := xM^.lvd[xM^.lvl-1].vis;
            xL^.psn     := xM^.lvd[xM^.lvl-1].psn;

            // preberu sa udaje z riadka do pomocnej struktury
            IF xR^.h.chk THEN
               yIO      := xR^.o.ob[4].cf;                     // pre detail aby sme vedeli vazby
            ELSE
               yIO      := xR^.h.cf;
            END_IF;
            IF xR^.h.chk AND xA^.tch.obj = 4 THEN              // v zaskrtnutej vazbe sa ide do properties vyssej casti
               yIO      := xR^.h.cf;
               xF^.cf   := xR^.o.ob[4].cf;                     // hlavicka sa preberie z vyssej casti s parametrom v riadku
               IF xA^.tch.cmd = 200 OR xA^.tch.cmd = 204 THEN

//                  xL^.vaz   := xR^.h.cf.c;                     //**-** ak sa ide z vazby, zapamata sa cf z vazby

               END_IF;
            ELSE
               xF^.cf   := xR^.h.cf;                           // hlavicka sa preberie z riadka
            END_IF;
            IF xF^.cf.c <> 2 THEN                              // nazov u CAT sa zoberie priamo z textov
               _NhName(xName := ADR(xL^.naz) , cf := xF^.cf.c, nd := xF^.cf.n);
            END_IF;





            xA^.tch.Q    := false;                              // pri vstupe do noveho LVL sa resetuje sa priznak stlacenia nad objektom
            xA^.tch.Qr   := false;                              // pri vstupe do noveho LVL sa resetuje sa priznak stlacenia nad objektom
            xA^.tch.Qf   := false;                              // pri vstupe do noveho LVL sa resetuje sa priznak stlacenia nad objektom
         ELSE
            xM^.wht     := 10;
            _NheLvl     := false;
         END_IF;

    -1: // o uroven spat
			aSys.RefCycNew := 1;															// pri vsupe/spat sa urobi refresh												
   		_NheBrw(wht := 9);                                 	// vymaze pod = editacia TypeDay
         IF xM^.lvl > 0 THEN
            xM^.lvl   := xM^.lvl - 1 ;
         ELSE
            xM^.lvl   := 0 ;
         END_IF;
         _NhxLvl();
         xM^.wht     := 25;                                    // od 1.zapamataneho riadku
    -2: // o uroven spat
			aSys.RefCycNew := 1;															// pri vsupe/spat sa urobi refresh												
   		_NheBrw(wht := 9);                                 	// vymaze pod = editacia TypeDay
         IF xM^.lvl > 1 THEN
            xM^.lvl   := xM^.lvl - 2 ;
         ELSE
            xM^.lvl   := 0 ;
         END_IF;
         _NhxLvl();
         xM^.wht     := 25;                                    // od 1.zapamataneho riadku

     3 : // o uroven dopredu
         xM^.lvl     := xM^.lvl + 1;                        // zvysi sa lvl
         _NheBrw(wht := 3);                                 // vymaze sa veta lvd[lvl] (nie data ani riadok odkial odskok je)
         _NhxLvl();                                         // namapuju sa k novemu lvl
     4 : // o uroven dopredu , ponecha data pre kopirovanie
         IF xM^.lvl < 3 THEN
	         yIO      := xF^.cf;
   	      xM^.lvl     := xM^.lvl + 1;                        // zvysi sa lvl
      	   _NheBrw(wht := 8);                                 // vymaze sa veta lvd[lvl] (nie data ani riadok odkial odskok je)
         	_NhxLvl();                                         // namapuju sa k novemu lvl
	         xF^.cf   := yIO;                           			// hlavicka sa preberie z riadka
			END_IF;
   ELSE                                                        // v tej istej urovni
         _NheBrw(wht := 3);                                 // vymaze sa veta lvd[lvl] (nie data ani riadok odkial odskok je)
         _NhxLvl();                                         // namapuju sa k novemu lvl
         // preberu sa udaje z riadka do pomocnej struktury
         yIO      := xR^.h.cf;
         xF^.cf   := xR^.h.cf;                           // hlavicka sa preberie z riadka
         _NhName(xName := ADR(xL^.naz) , cf := xF^.cf.c, nd := xF^.cf.n);
   END_CASE;
END_FUNCTION

FUNCTION _NhWebSave  {HIDDEN} : BOOL    // prestavi menu vazieb aj suvisiacich filtrov
   VAR_INPUT
      NoLvl    : BOOL;
   END_VAR
   _NhWebSave  := true;
   IF xF^.cf.c > 0 THEN
      _NhxDev2(c := xF^.cf.c, n := xF^.cf.n, x:=17);
      CASE xF^.cf.c OF
         22 :  xUsr2  := xDev2;
               IF xF^.cf.n = 1 THEN
                  yUSR.cf.blk    := 0;                                  // admin si nemoze prepisat sbj z 0
						xA^.admin 		:= 1;
					ELSE
						xA^.admin 		:= 0;	
               END_IF;
               xUsr2^  			:= yUsr;
					xA^.UsrRight 	:= xUsr2^.cx.UsrRight;

(*
               IF xF^.cf.n = 1 THEN
//                  yUSR.cf.sbj       := 0;                                  // admin si nemoze prepisat sbj z 0
                  yUSR.cf.blk       := 0;                                  // admin si nemoze prepisat sbj z 0
//                  yUSR.cx.UsrRight  := 2;                                  // admin si nemoze prepisat sbj z 0
               END_IF;
               IF xUsr^.cx.UsrRight = 2 THEN
                  xUsr2^  := yUSR;
               ELSIF xUsr^.cx.UsrRight = 1 THEN                      // superuzivatel
                  IF yUSR.cx.UsrRight > 1 THEN
                     yUSR.cx.UsrRight := 1;
                  END_IF;
//                  yUSR.cf.sbj := xUsr^.cf.sbj;                       // nemoze subjekt
                  xUsr2^      := yUSR;
               ELSIF xF^.cf.c = xA^.usr THEN                         // uset moze opravit len sam seba
                     xUsr2^.cf.Name       := yUSR.cf.Name;
                     xUsr2^.cx.mail       := yUSR.cx.Mail;
                     xUsr2^.cx.gsm        := yUSR.cx.gsm;
                     xUsr2^.cx.KeyPas     := yUSR.cx.KeyPas;
                     xUsr2^.cx.LoginHome  := yUSR.cx.LoginHome;
               END_IF;
*)
      END_CASE;
   END_IF;
   IF NoLVL = false THEN
      _NheLvl( lvl := -1 );                                              // o LVL dopredu
   END_IF;
   xM^.frm := false;
   xM^.htx := 0;
   xM^.htt :=  '';
END_FUNCTION







FUNCTION  _Nh_Web_CMD_Action       : BOOL  // _NhObrMnu NADEFINUJE HOME SCREEN, VYVOLA AKCIU PO STLACENI MENU/DASH, TIEZ ulozi udaje z klasickej web-maker PAGE
   (*
   - uplne na zaciatku nadefunuje HOME screen (pre kazdy subjekt iny)
   - ak je aktivna klasicka webmaker-page s editaciou premennych, ulozi tieto premenne
   - zisti sa stlacenie menu vrchneho, spodneho, niektoreho s dashboardu v HOME-screen
   - ina akcia je pri stlaceni toho isteho menu, ktore je prave aktivne, a ina pri novej volbe
   - pri stlaceni dashboardu, v HOME sa vyvola prislusna kategoria
   - podla vysledneho vyhodnotenia sa vacsinou prepne / nadefinuje nova obrazovka
   *)
   VAR_INPUT
      mnu      : USINT;
   END_VAR
   _Nh_Web_CMD_Action      := true;
   IF xM^.htx > 0 THEN                                           // ak je nejaky frame
      _NhWebSave(NoLvl := true);                                 // ulozi ak je co
   END_IF;
   rb          := xM^.lvl = 0;                                          // ovplyvni prepinaju volby nad tym istym tlacitko, ked sa vracia z inej urovni, neprepina sa
   xM^.lvl     := 0 ;
   _NhxLvl();
   IF xM^.naz = '' THEN                                                 // uplne nove prihlasenie
      _NheBrw( wht:=1 );
      mnu         := 0;
      xU^         := eMnH;                                              // prida prvotne ciste mnu
      _NhUsrPar( fav := 1);
      xM^.set     := xUsr^.cx.set OR xA^.usr = 1 OR aSys.NewDbx;
      xM^.srt     := xM^.set;
   ELSE
      _NheBrw( wht := 6);                                         // vsetky lvl aj brw
   END_IF;
   xL^.vis     := true;
   IF mnu = 0 THEN                                                      // HOME page
      _Nh_Web_CMD_Screen(obj := 0);
      RETURN;
   ELSIF mnu = xU^.n AND rb THEN                           // vybrate to iste menu v zakladnom leveli = prepnut
      CASE mnu OF
        4  :  // FAV
               CASE xU^.o[mnu].fn OF
                 41: xU^.o[mnu].fn := 59;                   // z FAV na FAV list
                     xU^.o[mnu].wh := 60;
                 59:                                        // prepnutie zo zoznamu FAV
                        CASE xA^.fav.n  OF
                          -1 :   xU^.o[mnu].fn := 199;        // DASH
                                 xU^.o[mnu].wh := 199;
                          -2 :   xU^.o[mnu].fn := 198;        // QUICK
                                 xU^.o[mnu].wh := 198;
                        ELSE     xU^.o[mnu].fn := 41;          // vybraty FAV
                                 xU^.o[mnu].wh := 42;
                        END_CASE;
                  ELSE
                     xU^.o[mnu].fn := 59;
                     xU^.o[mnu].wh := 60;
               END_CASE;
        5  :  // ROOMS
               CASE xU^.o[mnu].fn OF
                 16: xU^.o[mnu].fn := 20;                   // z romms na zone
                     xU^.o[mnu].wh := 21;
                 20: xU^.o[mnu].fn := 16;                   // zo zone na rooms
                     xU^.o[mnu].wh := 17;
               END_CASE;
        7  :  // ACT
               IF xM^.set = false THEN
                  CASE xU^.o[mnu].fn OF
                    27: xU^.o[mnu].fn := 29;                   // z ACT na SCN
                        xU^.o[mnu].wh := 30;
                    29: xU^.o[mnu].fn := 27;                   // SMW->ACT
                        xU^.o[mnu].wh := 28;
                  END_CASE;
               ELSE
                  CASE xU^.o[mnu].fn OF
                    27: xU^.o[mnu].fn := 29;                   // z ACT na SCN
                        xU^.o[mnu].wh := 30;
                    29: xU^.o[mnu].fn :=196;                   // SCN->BLK
                        xU^.o[mnu].wh :=197;
                   196: xU^.o[mnu].fn :=295;                   // BLK->TIM
                        xU^.o[mnu].wh :=296;
(*
                   295: xU^.o[mnu].fn :=235;                   // TIM->MSG
                        xU^.o[mnu].wh :=236;
                   235: xU^.o[mnu].fn := 27;                   // MSG->ACT
                        xU^.o[mnu].wh := 28;
*)
(*
                   295: xU^.o[mnu].fn :=297;                   // TIM->SMW
                        xU^.o[mnu].wh :=298;
                   297: xU^.o[mnu].fn := 27;                   // SMW->ACT
                        xU^.o[mnu].wh := 28;
*)
						 ELSE
                   		xU^.o[mnu].fn := 27;                   // BLK->TIM
                        xU^.o[mnu].wh := 28;
                  END_CASE;
               END_IF;
      END_CASE;
   ELSIF xU^.n = 0 THEN                                     // je aktivne HOME page
      IF mnu = 1 THEN
         xU^.o[6].wh := 24;   										// do spodneho menu cat nastavi setup
         mnu         := 6;                                  // vyberie cas = setup
      ELSE
         xU^.o[6].wh := 11;
      END_IF;
   ELSE
      CASE xU^.o[xU^.n].wh OF
        18  :  // jedna miestnost - vrati na miestnosti
               xU^.o[xU^.n].fn := 16;           // miestnosti siva
               xU^.o[xU^.n].wh := 17;           // miestnosti biela

        22  :  // jedna zona      - vrati na zony
               xU^.o[xU^.n].fn := 20;           // zona siva
               xU^.o[xU^.n].wh := 21;           // zona biela
        24  :  // setup z ikony NH
               xU^.o[xU^.n].fn := 10;           // siva CAT
               xU^.o[xU^.n].wh := 11;           // zona biela
      ELSE
      ;
      END_CASE;
   END_IF;
   xU^.n          := mnu;                       // cislo menu, ktore bude vybrate
   xU^.o[1].fn    :=  0;                                            // zrusi LOGO
   xU^.o[2].fn    :=  0;                                            // zrusi SETUP
   xU^.o[3]       := eMnH.o[3];                                     // aktivuje HOME
   IF xU^.o[8].fn = 0 THEN                                          // prislo sa z HOME
      xU^.o[8]    := eMnH.o[8];                                     // aktivuje ON/OFF
   END_IF;
   xL^.vaz        := 0;
   xL^.fvz        := 0;
   CASE xU^.o[xU^.n].fn OF
      59:   _Nh_Web_CMD_Screen(obj := 1);                      // zoznam FAV
      41:   _Nh_Web_CMD_Screen(obj := 2);                      // sivy FAV = vazby
     198:   _Nh_Web_CMD_Screen(obj := 3);                      // Quick menu = vazby FAV
     199:   _Nh_Web_CMD_Screen(obj := 4);                      // DASH = vazby FAV
      16:   _Nh_Web_CMD_Screen(obj := 5);                      // ROMS

//            xF^.cf.c       := 1;
//            xF^.dev.n[1]   := 1;



      20:   _Nh_Web_CMD_Screen(obj := 6);                      // ZONES
     10:    _Nh_Web_CMD_Screen(obj := 7);                      // setup menu             sivy CATS
     27:    _Nh_Web_CMD_Screen(obj := 8);                      // sivy ACT
     29:    _Nh_Web_CMD_Screen(obj := 9);                      // sivy ACN
    196:    _Nh_Web_CMD_Screen(obj :=20);                      // sivy BLK
    295:    _Nh_Web_CMD_Screen(obj :=21);                      // sivy TIM
    235:    _Nh_Web_CMD_Screen(obj :=56);                      // sivy MSG

//    297:    _Nh_Web_CMD_Screen(obj :=22);                      // sivy SMW

(*
    196:    _Nh_Web_CMD_CmdScreen(obj :=15);                      // sivy BLK
    295:    _Nh_Web_CMD_CmdScreen(obj :=16);                      // sivy TIM
    297:    _Nh_Web_CMD_CmdScreen(obj :=17);                      // sivy SMW
*)
   END_CASE;
END_FUNCTION



{ $ END_IF }
