//    VYKONANIE AKCIE PODLA CMD VACSINOU PREPNUTIE DO INEJ OBRAZOVKY/BROWSU

{ $ IFDEF __NH_WEB }



FUNCTION _Nh_Web_CMD    : BOOL
   VAR_IN_OUT

//      m           :  NH_M;

   END_VAR
   VAR_TEMP
      ok          : BOOL;
      yz          : SINT;
   END_VAR
   _Nh_Web_CMD   := true;
   IF xA^.tch.cmd < 255 THEN
      cmd        := 0;
      delay      := 0;
      _NhxLvl();
   END_IF;


   CASE xA^.tch.cmd OF
      0: ;

     99: // pridat specialne novu vetu v browse
            yIO := xF^.cf;
            WHILE true DO
               x := _NhFindDel(wh := 0, cx := 35, new := true);
               y := _NhFindDel(wh := 2, cx := 2,  new := true);
               IF aCfg[xF^.cf.c].par > 0 THEN
                  z := _NhFindDel(wh := 1, cx := aCfg[xF^.cf.c].par,  new := true);
               ELSE
                  z := 1;
               END_IF;
               IF x > 0 AND y > 0 AND z > 0 THEN
                  _NhxDev(c := 35, n := x, x:=18);  xDev^.ok.ok := true;
                  _NhxVaz(cv :=  2, nd := y);  xVaz^.ok.ok := true;
                  xVaz^.in.c := 35;
                  xVaz^.in.n := x;
                  xVaz^.ou   := yIO;
                  IF aCfg[xF^.cf.c].par > 0 THEN
                     _NhxPar(cp := aCfg[xF^.cf.c].par, np := z ,x:=246);  xPar^.ok.ok := true;
                     xVaz^.ou.p := z;
                  END_IF;
                  EXIT;
               ELSE
                  _Nh_Go_DbxToMem(ram := true, dbx := false );          // v 1.iteracii sa neuklada do dbx, lebo este sa budu zapisovat data
               END_IF;
            END_WHILE;
            xM^.wht        := 30;                                    // nova veta ma byt na konci browsu

    100: // prebieha editovanie nazvu  alebo pridavanie vety (editacia)

            IF xM^.new = -1   THEN                                      // CANCEL
               xM^.Naz     := xL^.Naz;                                  // do editacneho pola preberie aktualny nazov
               xM^.wht     := -1;                                       // len prekreslenie, nie nove data
            ELSIF xM^.naz <> xL^.naz AND xM^.new = 1 THEN               // uspesna modifikacia
               xL^.naz := xM^.naz;
               xM^.edt := false;
               IF xL^.obj = 2 THEN                                      // browser FAV, zmenit nazov user-fav v FAV-LIST
                  _NhFavNaz(sav := true);
               ELSE
                  _NhxCfg(c := xF^.cf.c, n := xF^.cf.n, x:=26);              // xDev,xCfg,xPar pre aktualny riadok
                  xDev^.cf.Name  := xL^.naz;
               END_IF;
               xM^.wht     := 25;

            ELSIF xM^.naz <> '' AND xM^.new = 2 THEN                       // pridanie zaznamu
                  yLVL           := xL^;
                  xM^.wht        := 30;                                    // nova veta ma byt na konci browsu
                  xU^.o[8].fn    := 49;                                    // ak by bo filter na ON, zrusi sa
                  IF xF^.cf.c = 2 THEN                                     // v niektorej kategorii sa pridava
                     CASE xF^.cf.n OF                                      // kat:2/n=5(kurenie/chladenie)
                        5 :   yIO.c :=  6;                                 // KOMFORT = pridanie regulatora
                        4 :   yIO.c := 47;                                 // VETRANIE = pridanie regulatora
                     END_CASE;
                  ELSIF xL^.obj = 5 THEN                                   // nova miestnost
                     yIO.c :=  1;
                  ELSIF xL^.obj = 47 THEN                                   // nova SVA do DALI
                     yIO.c :=  11;
                  ELSIF xL^.obj = 32 THEN                                  // nova akcia od alarmu
                     yIO.c 	:= 48;
							yCfg.rec := xF^.cf.n;											// zapamata sa cislo zony (yCfg sa vyuziva len v _Nh_INI)
                  ELSE
                     CASE xF^.cf.c OF                                      // z browsu vazieb sa pridava SCN
                         1:   yIO.c := 4;
                       ELSE   yIO.c := xF^.cf.c;
                     END_CASE;
                  END_IF;
                  yIO.n   := 0;                                            // sem pride cislo vety DEV
                  yIO.p   := 0;                                            // sem pride cislo pripadnej vety PAR
                  FOR yz := 1 TO 2 DO                                      // ak sa v 1 iteracii nenajde DEL-veta, pripadne DEL-parameter, v 2.iteracii prida nove DEL-vety, ktore sa uz najdu
                     ok3 := false;
                     IF aCfg[yIO.c].par > 0 THEN
//                       ok3   :=  aPar[ aCfg[yIO.c].par ].grp = false;      //
                         ok3   :=  true;      //9.5.23 - nove SCN s parametrom gr nopridavalo do SCN
                     END_IF;
                     IF ok3  THEN                                          // pridava sa aj parameter, nie je skupinovy
                        IF yIO.p = 0 THEN                                  // ochrana, ak by bola 2.iteracia a v prvej by sa veta nasla, uz mame je cislo
                           yIO.p := _NhFindDel(wh := 1, cx := aCfg[yIO.c].par, new := true);    // hlada sa DEL parameter, ak sa najde oznaci sa
                       END_IF;

                     END_IF;
                     IF yIO.n = 0 THEN                                     // ochrana, ak by bola 2.iteracia a v prvej by sa veta nasla, uz mame je cislo
                        yIO.n := _NhFindDel(wh := 0, cx := yIO.c, new := true);
                     END_IF;
                     IF yIO.n > 0 AND (yIO.p > 0 OR ok3 = false) THEN
                        ok3   := true;
                        CASE yIO.c OF                                   // podla hlavicky sa zisi co sa pridava
                           1 :   // ROM
                                 xRom           := xDel;
                                 xRom^.cf.rom   := 1;		//INT_TO_USINT(yIO.n);
                                 xRom^.cf.idx   := yIO.n;
                                 xRom^.cf.typ   := 1;                      // default je vnutorna zona
                                 xRom^.cf.Name  := xM^.naz;
                                 xRom^.cf.ID    := INT_TO_STRINGF(yIO.n,'%03d');
											// prida poi
											_Nh_POI_INI_NEW(cf:=yIO.c, nd1:=yIO.n, nd2:=yIO.n);

                           3 :   // zona
                                 xZon           := xDel;
                                 xZon^.cf.idx   := yIO.n;
                                 xZon^.cf.typ   := 3;                      // vnutorna zona
                                 xZon^.cf.Name  := xM^.naz;
											xZon^.cf.Rom   := _NhDefHom;  				// zona ma cislo svojho domceka

                           4 :   // SCN vseobecna, aj s ROM
                                 xScn 				:= xDel;
                                 xScn^.cf.idx   := yIO.n;
                                 xScn^.cf.Name  := xM^.naz;
                                 xScn^.cf.par   := yIO.p;                  // zona ma aj parameter
											IF xF^.cf.c = 2 THEN
												 xScn^.cf.rom   := MAX(1,_NhDefRom);
											ELSE											
												xScn^.cf.rom   := xF^.rom;
											END_IF;
(*
											IF xF^.rom = 0 THEN
	                                 xScn^.cf.rom   := MAX(1,_NhDefRom);
											ELSe
	                                 xScn^.cf.rom   := MAX(1,xF^.rom);
   										END_IF;
*)
                           5 :   // ACT vseobecna, vzdy setup ROM
                                 xAct := xDel;
                                 xAct^.cf.idx   := yIO.n;
                                 xAct^.cf.Name  := xM^.naz;
											xAct^.cf.rom   := MAX(1,_NhDefHom);
//                                 xAct^.cf.rom   := INT_TO_USINT( MAX(1,MIN(xF^.cf.n,aCfg[3].rec)));

                           6 :   // HEAT
                                 xHet           := xDel;
                                 xHet^.cf.idx   := yIO.n;
                                 xHet^.cf.Name  := xM^.naz;
                                 xHet^.cf.rom   := MAX(1,_NhDefRom);
                                 xHet^.cf.par   := yIO.p;
                                 xHet^.cf.cat   := INT_TO_USINT(xF^.cf.n);
											xHet^.cf.typ 	:= 0;
											// prida poi
											_Nh_POI_INI_NEW(cf:=yIO.c, nd1:=yIO.n, nd2:=yIO.n);
(*
                                 IF xHet^.cf.cat   = 4 THEN                      // vetranie
                                    xHet^.cf.typ := 1;                           // regulator vetrania
                                 ELSE
                                    xHet^.cf.typ := 0;
                                 END_IF;
*)

                          11 :   // sva
                                 xDev2 := xDel;
                                 xDev2^.cf.idx   := yIO.n;
                                 xDev2^.cf.Name  := xM^.naz;
                                 xDev2^.cf.rom   := xF^.rom;
                                 xDev2^.cf.par   := yIO.p;

                          20 :   // zoznam FAV,DSH,QUICK
                                 xFav           := xDel;
                                 xFav^.cf.idx   := yIO.n;
                                 xFav^.cf.Name  := xM^.naz;
                                 xFav^.cx.c     := xA^.usr;
                                 xFav^.cx.n     := yIO.n;
                                 xUsr^.cx.fav   := xFav^.cx;
                                 xA^.fav        := xFav^.cx;

(*
                          35 :   // BLK vseobecna, vzdy bez ROM
                                 xBlk 				:= xDel;
                                 xBlk^.cf.idx   := yIO.n;
                                 xBlk^.cf.Name  := xM^.naz;
                                 xBlk^.cf.rom   := MAX(1,_NhDefRom);
*)

                          47 :   // HEV	- vetranie
                                 xHet           := xDel;
                                 xHet^.cf.idx   := yIO.n;
                                 xHet^.cf.Name  := xM^.naz;
                                 xHet^.cf.rom   := MAX(1,_NhDefRom);
                                 xHet^.cf.par   := yIO.p;
                                 xHet^.cf.cat   := INT_TO_USINT(xF^.cf.n);
											xHet^.cf.typ 	:= 1;
											// prida poi
											_Nh_POI_INI_NEW(cf:=yIO.c, nd1:=yIO.n, nd2:=yIO.n);

                          48 :   // ACT vseobecna, vzdy setup ROM
                                 xAla := xDel;
                                 xAla^.cf.idx   := yIO.n;
                                 xAla^.cf.Name  := xM^.naz;
//                                 xAct^.cf.rom   := INT_TO_USINT( LIMIT(xF^.cf.n,1,aCfg[3].rec) );
//											xAct^.cf.typ 	:= INT_TO_SINT(aCfg[48].rec);
                                 xAla^.cf.rom   := INT_TO_USINT( xF^.cf.n );

                          50 :   // TIM vseobecna, vzdy setup ROM
                                 xTim := xDel;
                                 xTim^.cf.idx   := yIO.n;
                                 xTim^.cf.Name  := xM^.naz;
                                 xTim^.cf.rom   := MAX(1,_NhDefRom);
                                 xTim^.cf.typ   := 1;
											ok3 				:= false;											// nema parameter
                        ELSE
                        	xDev2 				:= xDel;
                         	xDev2^.cf.idx   	:= yIO.n;
                          	xDev2^.cf.Name  	:= xM^.naz;
									ok3 				:= false;											// nema parameter
                        END_CASE;
                       	xDev2 				:= xDel;
								IF xDev2^.cf.rom > 0 THEN												// ak sa nepriradila rom
									;
								ELSIF  aCfg[yIO.c].RomIsZone THEN
									xDev2^.cf.rom   := MAX(1,_NhDefHom);							// default Room					
								ELSE
									xDev2^.cf.rom   := MAX(1,_NhDefRom);							// default hlavna zona / domcek																											
								END_IF;

                        xL^.rw1.c  := yIO.c;                                  		// pre spravny refresh
                        xL^.rw1.n  := yIO.n;;

								xDev2 := xDel;
                        _NhxUsr(u := xA^.usr );                                  	// pri vstupe do session namapuje usra, potom uz v programe nikdy
                        EXIT;
                     ELSE
                        _Nh_Go_DbxToMem(ram := true, dbx := false );          			// v 1.iteracii sa neuklada do dbx, lebo este sa budu zapisovat data
                     END_IF;
                  END_FOR;
            ELSE
               RETURN;
            END_IF;
            xM^.edt     := false;
            xU^.o[1] := xM^.mno[1];
            xU^.o[2] := xM^.mno[2];
            xM^.wht        := 30;                                    // nova veta ma byt na konci browsu


    101: // vstup do modifikacie nazvu alebo pridanie novej vety cez nazov


            xM^.new := 1;                                         // znak pridavania vety
            IF xF^.rom > 0 THEN
               _NhxRom(nr := xF^.rom,x:=-5);
            END_IF;
            IF xM^.edt = false THEN                                  // pridanie
               IF xL^.obj = 47 THEN                                  // pridanie SVA
                  xM^.naz := xL^.Naz;
               ELSE
                  xM^.naz := '';
               END_IF;
               xM^.edt := true;
               xM^.new := 2;                                         // znak pridavania vety
            ELSE

               xM^.naz := xL^.naz;
            END_IF;

            yTx1 := xM^.naz;
            REPLACE_CHAR(c1:=16#01,c2:=16#00,input:=yTx1);           // vyhodenie znaku SOH {Start Of Header}
            xM^.naz :=yTx1;

            xM^.mno[1]  := xU^.o[1];                                 // zalohovanie m1
            xM^.mno[2]  := xU^.o[2];
            xU^.o[1].fn := 46;                                    // CANCEL vlavo hore
            xU^.o[1].cm := 100;                                   // CANCEL vlavo hore
            xU^.o[2].fn := 0;
            cmd         := 100;
            xM^.wht     := -1;                                     // len prekreslenie, nie nove data


     102: // VYMAZAT ZAZNAM
            _NhxDev(c := xR^.h.cf.c, n:= xR^.h.cf.n, x:=19);                                   // namapuje vetu aby sme odcitali cf,nd
            yVaz.in  := xR^.h.cf;
            yVaz.ou  := xR^.h.cf;                                                               // pre SCN/FAV-list
				If xA^.usr = 1 THEN
            	vi      	:= xR^.h.cf.c;
	            rmp      := 1;
   	         xM^.wht  := 0;
      		ELSE
					vi  			:= 255;
					rmp			:= 255;		
   	         xM^.wht  	:= 10;
				END_IF;	
            CASE vi OF
              1 : // ROM
						_Nh_POI_INI_NEW(cf:=xR^.h.cf.c, nd1:=xR^.h.cf.n, nd2:=xR^.h.cf.n, del:=true);

              3 : // ZON
                  xZon     := xDev;
						ii			:=	INT_TO_USINT(xR^.h.cf.n);
	               FOR nd := 1 TO aCfg[1].rec DO
							//PRERADIT rom do DEFAULT domceka
							IF _NhxPt(c:=1, n := nd,x:=-123) THEN
			               IF xPt^.cf.rom = ii THEN
									xPt^.cf.rom := MAX(1,_NhDefHom);
								END_IF;
							END_IF;
            	   END_FOR;
				

              4: 	// DEL SCN
						;
//  _NhfVaz(vaz := 3, row := false, whf := 3, del := true, all := true);           // aVaz[2] - SCN list  in+ou , kde je ACT
              5: // DEL ACT
						;
//                  _NhfVaz(vaz := 4, row := false, whf := 3, del := true, all := true);          // IO : in+ou , kde je ACT

//             35 : // DEL BLK
//                  _NhfVaz(vaz := 1, row := false, whf := 2, del := true, all := true);          // zoznam FAV, k SCN, sCN je v ou
//                  _NhfVaz(vaz := 2, row := false, whf := 3, del := true, all := true);          // IO : in+ou , kde je ACT

              6: // HET
						_Nh_POI_INI_NEW(cf:=xR^.h.cf.c, nd1:=xR^.h.cf.n, nd2:=xR^.h.cf.n, del:=true);

//                  _NhfVaz(vaz := 1, row := false, whf := 2, del := true, all := true);          // zoznam FAV, k HET ou
//                  _NhfVaz(vaz := 2, row := false, whf := 3, del := true, all := true);          // IO : in+ou , kde je ACT

             20: // hlavicka FAV + obsah
                  xFav           := xDev;
                  yVaz.in        := xFav^.cx;
                  xUsr^.cx.fav   := xFav^.cx;
                  _NhfVaz(vaz := 1, row := false, whf := 1, del := true, all := true);          // zoznam FAV, k hlavicke, hlavicka je v in
                  // usrovi nastavi FAV-ALL
                  _NhxDev(c := 20, n:= 4, x:=19);                                              // oblubene vsetkych
                  xFav           := xDev;
                  xA^.fav        := xFav^.cx;
                  xUsr^.cx.fav   := xFav^.cx;

           	  40:	// TGL
						;	               	   	
              46 : // MSG  - zmazat aj vaz[] = zoznam usrov, ktori dostanu SMS
                  xM^.wht  := 0;
                  rmp  		:= 0;

              47 : // HEV
						_Nh_POI_INI_NEW(cf:=xR^.h.cf.c, nd1:=xR^.h.cf.n, nd2:=xR^.h.cf.n, del:=true);
(*


             39 : // RFID card
                  _NhfVaz(pg := 133,  wh := 2, all := true);                   // vymaze vsetky vazby tohto oblubeneho ()
                  _NhDelRec(cf := xR^.h.cf.c, nd := xR^.h.cf.n);                  // vymaze zaznam
*)
//            ELSE
//                  xM^.wht  := 10;                                                                // nic sa nevymazalo, refresh dat od 1.riadku
//                  rmp      := 1;

             255 : // not acces right
		   			;
				END_CASE;
				IF rmp = 1 THEN
               _NhfVaz(vaz := 1, row := false, whf := 2, del := true, all := true);          // zoznam FAV, k HET ou
               _NhfVaz(vaz := 2, row := false, whf := 3, del := true, all := true);          // IO : in+ou WSB,TLA..PIR
               _NhfVaz(vaz := 3, row := false, whf := 3, del := true, all := true);          // IO : in+ou, vazby sCN
               _NhfVaz(vaz := 4, row := false, whf := 3, del := true, all := true);          // IO : in+ou, vazby ACT
            END_IF;
            IF xM^.wht = 0 THEN
               _NhxCfg(c := xR^.h.cf.c, n:= xR^.h.cf.n, x:=57);                                      // koli parametru
               IF xDev^.cf.par > 0 THEN
                  _NhFindDel(wh := 1, cx := aCfg[xR^.h.cf.c].par, nx := xDev^.cf.par, ok := false ); // vymazat parameter
               END_IF;
               _NhFindDel(wh := 0, cx := xR^.h.cf.c, nx := xR^.h.cf.n, ok := false );           // vymazat samotnu vetu aj jej pripadne parametre
               xM^.wht := 15;                                                                   // refresh pre vymazanu vetu
            END_IF;
            xM^.new     := 0;
            xA^.tch.cpy := 0;
            xA^.tch.del := 0;


     103: // kopirovat VETU VAZBY a ZOSORTOVAT
            xM^.wht := 10;
            IF _NhfVaz(vaz := 2, whf := 10) THEN                                             // najde vetu vaz, ktora odpoveda riadku. AJ S PARAMTRAMI
               nd    := nDel+1;                                                              // nova veta by mala byt fyzicky za kopirovanou vetou
               yVaz  := xVaz^;                                                               // data kopirovanej vety
               yIO   := yVaz.ou;                                                             // zapamatanie zdroja DEV najma parametra
               nDel  := _NhFindDel(wh := 2, cx := 2, new := false, ok := false);             // skusi najst DEL-vetu vazby
               nDel  := _NhNewVaz(ok := nDel > 0, par := true, vaz := 2, nv := nDel);
               IF yIO.p > 0 AND yVaz.ou.p > 0  THEN
                  rb := _NhCpyRec(wh := 1,cf := aCfg[yIO.c].par ,ns := yIO.p, nd :=yVaz.ou.p);  // prekopiruje parameter
               END_IF;
               IF nDel > 0 THEN
                  _NhSrtVaz(vaz := 2, poz := nd, new := nDel);
//                  _NhSrtVaz(poz := nd, new := nDel);
                  xM^.wht  := 25;
               END_IF;
	            xM^.new     := 0;
   	         xA^.tch.cpy := 0;
      	      xA^.tch.del := 0;
            END_IF;

      1: // potiahnutie dolu
            xM^.wht        := 1;
            cmd := 0;         ///***
//            xA^.tch.cm     := 1;

      2: // potiahnutie hore
            xM^.wht        := 2;
            cmd := 0;         ///***
//            xA^.tch.cm     := 2;


      3: // POTIAHNUTIE DOLAVA = DELETE/COPY
            xM^.wht := 0;
            IF xL^.dsh <> 1                  THEN                 // del iba dsh = 1
               ;
            ELSIF xA^.tch.row = 0               THEN
               ;
            ELSIF xR^.h.cf.c = 0                THEN
               ;
            ELSIF xL^.obj = 50 AND xR^.h.chk    THEN                 // kopirovanie vazby
               // obmedzit !! co sa da kopirovat
                xM^.new     := SINT_TO_INT(xA^.tch.row);
                xA^.tch.cpy := true;
                xM^.wht     := 10;                                    // prekreslenie dat bez vytvorenia indexu

            ELSIF aCfg[xR^.h.cf.c].del THEN
               xM^.wht     := 10;                                    // prekreslenie dat bez vytvorenia indexu
               _NhxDev(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=20);
               IF xR^.h.cf.c = 20 THEN                    					// zoznam skupin FAV
                  IF xR^.h.cf.n  > 4 THEN                               // prve 4 sa nezmazavaju
                     xFav := xDev;
                     IF xM^.set = false THEN
                        xM^.wht := 0;
                     ELSIF xFav^.cx.c <> xA^.usr THEN
                        xM^.wht := 0;
                     END_IF;
                  ELSE
                     xM^.wht     := 0;                                    // prekreslenie dat bez vytvorenia indexu
                  END_IF;
               ELSIF xR^.h.cf.c = 4 OR xR^.h.cf.c = 5 THEN                // SCN, ACT
                  If xA^.usr = 1 OR xUsr^.cx.ZonList[ xDev^.cf.rom ] THEN
                     ;
                  ELSE
                     xM^.wht := 0;
                  END_IF;
               ELSIF xA^.usr <> 1                  THEN
                  xM^.wht     := 0;
               ELSIF xR^.h.cf.c = 3 AND xR^.h.cf.n < 4 THEN                // zony
                  xM^.wht := 0;
               END_IF;
               IF xM^.wht = 10 THEN
                  xM^.new     := SINT_TO_INT(xA^.tch.row);					// toto rozhoduje
                  xA^.tch.del := true;
               END_IF;
            END_IF;

      4: // potiahnutie doprava
            xM^.wht     := -1;
      5: // neznamy prikaz - sposoboval rozhodenie obrazovky, posun o lvl dopredu a xL^.obj := 0
            xM^.wht     := -1;
      6: // press bez CMD
            xM^.wht     := -1;
     20:    _Nh_Web_CMD_Action(mnu := 0);                                              // HOME screen
     21:    _Nh_Web_CMD_Action(mnu := 4);                                              // FAV
     22:    _Nh_Web_CMD_Action(mnu := 5);                                              // ROOMS
     23:    _Nh_Web_CMD_Action(mnu := 6);                                              // CATS
     24:    _Nh_Web_CMD_Action(mnu := 7);                                              // ACT/SCN/TIM/BLK/SMW

     25: // SETUP MENU (z ikony NachHouse)
            _Nh_Web_CMD_Action(mnu := 1);

     26: // filter ON/OFF
            IF xF^.cf.c = 1 THEN
               CASE xU^.o[8].fn OF
                  49 : xU^.o[8].fn := 51;              // OFF (52)--> ON
                  51 : xU^.o[8].fn := 57;              // Pohyb
                 ELSE  xU^.o[8].fn := 49;              // off
               END_CASE;
            ELSE
               CASE xU^.o[8].fn OF
                  49 : xU^.o[8].fn := 51;              // OFF (52)--> ON
                    ELSE  xU^.o[8].fn := 49;              // off
               END_CASE;
            END_IF;
            xM^.wht  := 20;                        // nove data


     27: // ZMENA OBLUBENEHO
            _NhxDev2(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=21);  // NAMAPUJE riadok
            xFav     := xDev2;
            xA^.fav  := xFav^.cx;
(*
            _NhxUsr(u := xA^.usr);
            CASE xA^.fav.n OF
              -1: xA^.fav.c := _Nh_U12(xUsr^.cx.OwnDsh,xA^.usr,1);
                  xUsr^.cx.dsh := xA^.fav;
              -2: xA^.fav.c := _Nh_U12(xUsr^.cx.OwnQck,xA^.usr,1);
                  xUsr^.cx.qck := xA^.fav;
            ELSE  xUsr^.cx.fav := xA^.fav;
            END_CASE;
*)
            xUsr^.cx.fav := xA^.fav;
            xU^.n   := 4;                                            // podhodi, ze bolo predtym stlacene menu FAV
            _Nh_Web_CMD_Action(mnu := 4);                                     // este raz stlaci menu FAV aby sa preplo na nieco ine

     28: // PREPNI STAV ON/OFF na DEV
            IF xL^.obj = 0 THEN                                      // HOME QUICK
               _NhxCfg(c := xO^.cf.c, n := xO^.cf.n, x:=62);                 // xDev,xCfg,xPar
            ELSE
               _NhxCfg(c := xR^.h.cf.c, n := xR^.h.cf.n, par := true, p := xR^.h.cf.p, x:=29);  // xDev,xCfg,xPar
            END_IF;
            IF xL^.psn THEN														// len u ZON/ROM
					xDev^.al.in.cmd := 55; 			
//					xRom	:= xDev;

(*
					IF xO^.cf.c = 3 THEN												// zona zamyka svoje miestnosti		
						xRom^.al.in.cmd := 55; 							         // LOCK/UNLOCK
					ELSIF xRom^.cx.lck.stat > 0 THEN		
						xRom^.cx.lck.stat 	:= 0;
						xRom^.cx.lck.et   	:= 0;
					ELSE
						xRom^.cx.lck.stat 	:= 1;
						xRom^.cx.lck.et   	:= MAX(xRom^.cx.lck.tdOu,1);
					END_IF;
*)
(*
					IF xRom^.cx.lck.stat > 0 THEN		
						xRom^.cx.lck.what := 2;												// odomkni	
					ELSE
						xRom^.cx.lck.what := 1;		                           	// zamkni
					END_IF;										

					
							IF xRom^.cx.lck.stat < 6 THEN
								xRom^.cx.lck.stat := xRom^.cx.lck.stat + 1;
							ELSE
								xRom^.cx.lck.stat := 0;
							END_IF;
                     xRom^.cx.lck.et := 13;
*)

            ELSIF xR^.h.cf.c = 15 THEN                                        // PIR - vysle testovaci signal
               IF xM^.set THEN
                  xDev^.al.in.cmd   := 21;                                 // z webu vysle testovaci signal
                  xDev^.al.in.par   := xR^.h.cf.p;
               END_IF;

            ELSIF xR^.h.cf.c = 35 THEN                                     // BLK
               xDev^.al.in.cmd   := 1;                                     // prepni

//            ELSIF xR^.h.cf.c = 44 THEN                                     // DLg
//               xDev^.al.in.cmd   := 1;                                     // prepni

            ELSIF xR^.h.cf.c = 22 THEN                                     // Prepnut usra

//               aWeb.A[1].usr :=  SINT_TO_USINT(xA^.tch.row);
//               _NhxUsr(u := xA^.usr );                                  // pri vstupe do session namapuje usra, potom uz v programe nikdy
//               aWeb.A[1].fav  := xUsr^.cx.fav;

            ELSIF xR^.h.chk THEN                                           // ovplyvnuje len parmeter vazby - pri vybratej vazbe sa zmeni LVL v parametri
              	IF xPar^.all.lvl > 0 THEN
                 xPar^.all.lvl   := 0;
               ELSIF xDev^.al.ou.Val > 0.0 THEN
                  xPar^.all.lvl   := REAL_TO_USINT(xDev^.al.ou.Val);
//		         ELSIF aCfg[xR^.h.cf.c].lvl254 THEN
//                  xPar^.all.lvl   := 254;
               ELSE
                  xPar^.all.lvl   := 100;
               END_IF;
               IF xL^.vis  THEN                                            // ak je vis zapne/vypne sa ale neulozi sa do default parametra z webu
                  xDev^.al.in.cmd 	:= 14;
                  xDev^.al.in.par   := xR^.h.cf.p;
               END_IF;
            ELSE
               xDev^.al.in.cmd   := 1;                                     // prepni bez oneskorenia
               xDev^.al.in.par   := 0;                                     // pri takomto zadani sa zoberie default parameter
            END_IF;
            xA^.tch.End       := true;                                     //ukoncenie vyhodnocovanie pres
            xM^.wht           := 0;                                        // v tomto cykle sa nepokracuje do browsu, lebo sa nastavuje DEV , az v druhom cykle
            cmd               := 251;                                      // aby sa vratilo do browsu po nastaveni

     29: // ZAPNI (AKCIU)
            _NhxCfg(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=30);  // xDev,xCfg,xPar
            xDev^.al.in.cmd := 11;
            xDev^.al.in.par := 0;                                        // pri takomto zadani sa zoberie default parameter
            xM^.wht         := -1;                                       // len prekreslenie riadkov, nie nove data


     30: // >>  O UROVEN DOPREDU Z RIADKA
         CASE xR^.h.cf.c OF
           0 : ;	// _NheLvl( lvl := 0 );
         ELSE
         	IF _NheLvl( lvl := 1 ) = false THEN                            // o LVL dopredu
          		xA^.tch.cmd := 0;
           		RETURN;
          	END_IF;
         END_CASE;
			IF xF^.cf.c <> 2 THEN
	         _NhxDev(c := xF^.cf.c ,n := xF^.cf.n, x:=631);
			END_IF;
         CASE xF^.cf.c OF
            1:
					IF xM^.lvd[xM^.lvl-1].obj = 14 THEN                      // ide sa do 1.ROM z browsu zon SEC
                  _Nh_Web_CMD_Screen(obj := 15);                                    // >> 1 ROM/SEC
               ELSE
                  _Nh_Web_CMD_Screen(obj := 10);                                    // >> 1 ROM
               END_IF;
            2: CASE xF^.cf.n OF                                         // hlbsie do podkategorii
//                 6 : _Nh_Web_CMD_Screen(obj := 13);                                 // >> 1 CAT = SEC
                41 : _Nh_Web_CMD_Screen(obj := 49);                                 // >> zoznam DALI master
               ELSE  _Nh_Web_CMD_Screen(obj := 12);                                 // >> 1 CAT (ostatne)
               END_CASE;
            3:
               _Nh_Web_CMD_Screen(obj := 11);                                 // >> 1 ZONE
         ELSE
            xM^.lvl     := xM^.lvl-1;
            xA^.tch.cmd := 0;
            RETURN;
         END_CASE;

     31: // <  O UROVEN SPAT
         _NheLvl(lvl:=-1);                                              // o LVL dopredu
         xM^.htt :=  '';

     32: // SETUP O UROVEN DOPREDU Z RIADKA
         IF _NheLvl(lvl:=1) THEN                      // o LVL dopredu bez prebratia menu
            _Nh_Web_CMD_Screen(obj := 50,obr:=xR^.o.ob[1].fn, eMnu:=1 );                        // VAZBY,LIST....
         END_IF;

     33: // CHECK SPODNE MENU VAZIEB ON/OFF  - vo vazbach
            _Nh_Vaz_CHK(chg:=true );
            xM^.wht := 20;
     34 :   // zmena kategorie
            xM^.wht := 20;
            _Nh_Vaz_CAT(chg:=true);
     35: // ROM: ALL / 1.rom
            xM^.wht := 20;
            _Nh_Vaz_ROM(chg:=true);

     36: // VISIBLE  - vo vazbach
            xU^.o[6].fn :=  _Nh_O12(xU^.o[6].fn = 112,113,112);
            xL^.vis := xU^.o[6].fn = 113;                                     // vsetko prestavovanie prenasat do HW ()
            xM^.wht := 25;                                                     // refresh od 1.riadka s novymi datatmi do riadkov

     37: // prepnut na SCN,ACT-LIST
            _Nh_Web_CMD_Screen(obj := 51);                        // LIST....
            xM^.wht := 20;

     38: // prepnut na PLAY (IO) v SCN/ACT
            _Nh_Web_CMD_Screen(obj := 50);                        // VAZBY,LIST....
            xM^.wht := 20;

     39: // prepnut filter ROM v browse 1.ZONE
         xL^.fvz := NOT xL^.fvz;                               // pri clicku zmeni
         IF xL^.fvz THEN
            xF^.rom := INT_TO_USINT(xF^.cf.n);
            xU^.o[1].fn := 38;
         ELSE
            xF^.rom := 0;
            xU^.o[1].fn := 36;
         END_IF;
         xM^.wht := 20;


     40: // priradit FAV z riadku
            _NhfVaz(vaz := 1, new := xR^.o.ob[3].fn <> 43, del := xR^.o.ob[3].fn = 43, par := false);
            xM^.wht := 25;

     41: // CHECK z riadku - priradit/vymazat vazby aVaz[2]

				aSys.RefCycNew		:=	1;												// zabezpeci vymazanie OWN a aktualizaciu vstupoc
             xM^.wht     	:= 25;

            IF xR^.h.cf.c > 0 THEN                                                           // ochrana pre Err
               _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=55);
               xDev2       := xPt;
               _NhxPt(c := xR^.h.cf.c, n := xR^.h.cf.n,x:=48);
               xDev        := xPt;
               yIdxR.dev   := xR^.h.cf;                           // potrebne pre _NhChkRoM
            END_IF;

            IF xR^.h.cf.c = 0 OR xR^.h.cf.c > _Nh_CFG THEN                                                           // ochrana pre Err
               yTx2     := CONCAT('ERR!-01 VAZ _NhBrwMenu 41:CHECK z riadku. xR^.h.cf.c/n/p: ',
                                    USINT_TO_STRING(xR^.h.cf.c),'/',INT_TO_STRING(xR^.h.cf.n),'/',INT_TO_STRING(xR^.h.cf.p));
               _Nh1RowTxt(logRst := 1, adTime := 3);
            ELSIF _Nh_Chk_IODev(set := true) THEN             // vo vazbe je ROM ... kde sa inak priradzuje ako pri VAZ
//				ELSIF _Nh_Chk_SCN(set := true) THEN	;
                           ;
//				{$IFDEF __NH_DALI}
         	   ELSIF _Nh_Chk_DALI(set := true) THEN ;           // vazbe DLg -> DLs  ... kde sa inak priradzuje ako pri VAZ
//			   {$END_IF}

            ELSIF xL^.vaz  = 3 THEN
               IF xR^.h.chk THEN
                  _NhfVaz(del := true, vaz := xL^.vaz, whf := 10);               // vymaze sa veta  hladana aj s parametrami
               ELSE
                  xR^.h.in := false;
                  _NhfVaz(new := true, vaz := xL^.vaz);
               END_IF;

            ELSIF xL^.vaz  = 4 THEN
               IF xR^.h.chk THEN
                  _NhfVaz(del := true, vaz := xL^.vaz);               // vymaze sa veta  hladana aj s parametrami
               ELSE
                  xR^.h.in := false;
                  _NhfVaz(new := true, vaz := xL^.vaz);
               END_IF;

            ELSIF xR^.h.chk = false  THEN
               xR^.h.in := _NhFilDev(wht:=5, row:=xR^.h.cf.c, n:=xF^.cf.c);
               _NhfVaz(new := true, vaz := xL^.vaz);
               ok := true;
               _NhxCfg (c := xVaz^.in.c, n := xVaz^.in.n, par := true, p := xVaz^.in.p, x:=61 );         // namapuje In s parametrom
               _NhxCfg2(c := xVaz^.ou.c, n := xVaz^.ou.n, par := true, p := xVaz^.ou.p, x:=67 );         // namapuje Ou s parametrom
//               IF xVaz^.in.c = 13 OR xVaz^.in.c = 14 OR xVaz^.in.c = 40 THEN                                // prednastavi CMD do clickov vo WSB
               IF aCfg[xVaz^.in.c].tgrp = 13 THEN                                // prednastavi CMD do clickov vo WSB
                  ok    := false;
                  cmd   := 0;
                  pWsb := xPar;
                  xWsb := xDev;
						_Nh_Get_Frm260(cmd := true, cf := xVaz^.ou.c, nd := xVaz^.ou.n, grp := aCfg[ xVaz^.ou.c ].mWsb );
               ELSIF xVaz^.in.c = 15 THEN                                              // PIR

//                  xPar2^.out.Delay := 30;

               ELSIF xF^.cf.c = 6 THEN                                               // KURENIE

//                  xDev2^.cf.typ  := USINT_TO_SINT(xVaz^.in.c);
//                  IF _Nh_ADD_FIL_BRW(cf := xF^.cf.c, typ := xDev2^.cf.typ ) THEN
//                    xDev2^.cf.rom  := xDev^.cf.rom ;
//                    xF^.rom        := xDev2^.cf.rom;
//                    xU^.o[5].fn    := 18;                                             // filter miestnosti na 1.rom
//                  END_IF;

               END_IF;
               IF ok AND xVaz^.ou.p > 0 AND aCfg[xVaz^.ou.c].ou  THEN                  // ak nebolo WSB a len pre vystupne DEV
                  yIO    := xVaz^.ou;
                  _NhxCfg (c := yIO.c, n := yIO.n, x:=35);                                  // este raz Dev, bez parametra
                  _NhxPar(cp := aCfg[yIO.c].par, np := xDev^.cf.par,x:=-1014);                 // zisti default paramter, kde je aktualny stav
                  _NhxCfg2(c := yIO.c, n := yIO.n, par := true, p := yIO.p, x:=36 );       // namapuje novy parameter
                  IF xDev^.al.ou.val > 0.0   THEN                                      // dev aktualne ON
                     i  := 0;
                     CASE yIO.c OF
                       0 : ;
                       4 : yIO.c := 0;																	// SCN
                      10 : i := 1;                                             			// SVD
                      11 : i := 2;                                                     // SVA
                      12 : i := 3;																		// RGB
							 		xPar2^ := xPar^;                                            // do parametra vlozi aktualny stav pre RGB moze cely par
                      21 : i := 1;                                                     // ZAS
                     END_CASE;
                     CASE i OF                                                         // skupinove vlastnosti
                       1 : //SVD,SVA,ZAS
                           xPar2^.all := xPar^.all;                                    // defult casy
                       2 : //SVD,SVA,ZAS
                           xPar2^.all := xPar^.all;                                    // defult casy
                           xPar2^.sva := xPar^.sva;                                    // defult casy
                     END_CASE;
	                  xPar2^.all.lvl  	:= REAL_TO_USINT(xDev^.al.ou.val);
//						ELSIF acfg[yIO.c].Lvl254 THEN
//	                  xPar2^.all.lvl  	:= 254;
 						ELSE
       					xPar2^.all.lvl  	:= 100;
            		END_IF;
//                  IF xVaz^.in.c = 15 AND i > 0 THEN                                 	// PIR oproti OUT, ktore ma PAR
                  IF xVaz^.in.c = 15 THEN                                 					// PIR oproti OUT, ktore ma PAR
                     xPar2^.all.tOff 		:= 450;                                      // default cas 45s
                     xPar2^.all.BlPirOff 	:= 0;														// sam pir sa neblokuje
                     xPar2^.all.BlPirOn  	:= 0;
                  END_IF;
               END_IF;
               xL^.rw1 := xR^.h.cf;
            ELSE
(*
               _Nh_Chk_RoW(chk:=false,vaz:=true);
               IF xF^.cf.c = 6 THEN                                               // KURENIE
                  _NhxDev2(c := xF^.cf.c, n := xF^.cf.n, x:=59 );         // namapuje Ou s parametrom
                  IF _Nh_ADD_FIL_BRW(cf := xF^.cf.c, typ := xDev2^.cf.typ, set:=false ) THEN
                     xDev2^.cf.typ := 0;
                     xDev2^.cf.rom  := 0 ;
                     IF xF^.rom = 0 THEN
                        xU^.o[5].fn    := 17;                                             // filter miestnosti na 1.rom
                     END_IF;
                  END_IF;
               END_IF;

*)

               _Nh_Chk_RoW(chk:=false,vaz:=true);
               _NhfVaz(del := true, vaz := xL^.vaz, whf := 10);               // vymaze sa veta  hladana aj s parametrami
            END_IF;


     42: // LED na WSB ON/OFF
            _NhxDev(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=21);                      // pre zistenie xCfg toho co je v hlacivke (DEV alebo SCN), ACT sem vobec nepride
            xDev^.al.in.cmd   := 17;                                          // prepni LED
            xDev^.al.in.par   := SINT_TO_INT(xA^.tch.obj-5);                  // 1.led je v objekte 5
            cmd      := 252;
            xM^.wht  := -1;
//            xA^.tch.cmd       := 252;                                         // ked sa vrati, len prekresli browser
//            RETURN;

     43: // zmena zobrazenia riadok - dash
//            rb := _NhBrwDsh(chg := true, mnu := SINT_TO_USINT(xA^.tch.obj));

            rb       := _Nh_Brw_Dsh_Chg(chg := true, mnu := xL^.obd);
            xM^.wht  := 20;                                                      // prekreslenie browsu + nove data

     44: // zrusenie beziaceho OFF-casu nad DEV/PIR
				IF _NhxDev2(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=23 ) THEN
					IF xR^.h.cf.c = 15 THEN														// PIR
		            IF _NhxRom(nr := xDev2^.cf.rom, x:=23 )THEN                 // rom, kde je PIR
		               xRom^.me.BlPirOff 	:= 0;
				      END_IF;
					ELSE
            		xDev2^.al.et   := 0;                                        // po case vypnut
//  		          xDev2^.al.ex   := 0;                                       // celkovy cas zapnutia
					END_IF;
					_NhDevRef(xR  := xDev2);
				END_IF;
            xM^.wht        := -1;                                             // len prekreslenie, nie nove data

     45: // zrusenie blokovania PIR v miestnosti

            _NhxDev2(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=23 );                    // xDev,xCfg,xPar pre aktualny riadok
            IF _NhxRom(nr:=xDev2^.cf.rom, x:=-12) THEN
               xRom^.me.BlPirOn 		:= 0;
               xRom^.me.BlPirOff 	:= 0;
					_NhDevRef(xR  := xDev2);
            END_IF;
            xM^.wht        := -1;                                             // len prekreslenie, nie nove data


     46: // CHECK z riadku - priradit ROM
            xM^.wht := 10;
            _NhxDev(c := xF^.cf.c, n := xF^.cf.n, x:=327);
            IF xR^.h.chk = false THEN
               IF xDev^.cf.rom > 0 THEN
                  _NhxDev2(c := 1, n := xR^.h.cf.n, x:=427);
                  yTx2  := CONCAT(xDev2^.cf.ID,' ',xDev2^.cf.Name);
                  yTx2  := LEFT(yTx2,20);
               END_IF;
               ok             := xDev^.cf.rom <> INT_TO_USINT(xR^.h.cf.n);
               xDev^.cf.rom   := INT_TO_USINT(xR^.h.cf.n);                  // priradi novy ROM
               CASE xF^.cf.c OF
                 13 : xDev^.al.rmp := 1;                                   // vypne stlacenie
                 14 : xDev^.al.rmp := 1;
                 43 : // DLs
                     // pri zmene uklada
//                     yTx3 := CONCAT(_Nh_ADR_ROT,'/CFG/_',USINT_TO_STRINGF(43,'%03d'),'.DEV');
//                     _NhVarSdc(src := PTR_TO_UDINT(xDev), siz := UINT_TO_UDINT(aCfg[43].Siz) * 128   );
               END_CASE;
               rb             := _NhSysUpd();
            END_IF;

     47:    _Nh_Web_CMD_Action(mnu := 5);                                              // ROOMS

     48:   // ROL - prepni slider ROL/LAM

         _NhxDev(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=66 );
         xRol              := xDev;
         xRol^.cx.SetLam   := NOT xRol^.cx.SetLam;                            // robi sa to inak v procedure, ale ked nasleduje wht=25, tak tu
         xR^.o.ob[6].BgC   := _Nh_U12(xRol^.cx.SetLam,2,3);
         xM^.wht 				:= 25;


     49:   // BRA - zafixovat zatvorene
         _NhxDev(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=29 );
         xGat := xDev;
         IF xGat^.cx.btn THEN 								//
            xGat^.al.in.CMD := 50;                       // potvrdit otvorene
			ELSE
            xGat^.al.in.CMD := 51;                     	// potvrdit zatvorene
         END_IF;
         xM^.wht           := -1;

     50: // odskok z Home screen DEV/CAT/ROM

         yIO  := xB^.r[ xA^.tch.row ].o.ob[xA^.tch.obj].cf;
         _NheBrw(wht := 6);
	   	xU^.o[3]    := eMnH.o[3];                                     // aktivuje HOME
		   xU^.o[8]    := eMnH.o[8];                                     // aktivuje ON/OFF
			xF^.cf 		:= yIO;
         CASE xF^.cf.n OF                                         // hlbsie do podkategorii
//           6 :	_Nh_Web_CMD_Screen(obj := 13);                                 // >> 1 CAT = SEC
           6 :	xL^.psn  := true;
			  		_Nh_Web_CMD_Screen(obj :=  6);                                 // >> 1 CAT = SEC
          41 : _Nh_Web_CMD_Screen(obj := 49);                                 // >> zoznam DALI master
         ELSE  _Nh_Web_CMD_Screen(obj := 12);                                 // >> 1 CAT (ostatne)
         END_CASE;

     51: // >>  do podkategorie
    		IF _NheLvl(lvl:=1) = false THEN                            // o LVL dopredu
    			xA^.tch.cmd := 0;
     			RETURN;
       	END_IF;
         CASE xF^.cf.n OF
           41:  _Nh_Web_CMD_Screen(obj := 49);                                 // >> zoznam DALI master
           ELSE  _Nh_Web_CMD_Screen(obj := 12);                                 // >> 1 CAT (ostatne)
         END_CASE;

     52:   // ROL - zafixovat zatvorene
         _NhxDev(c := xF^.cf.c, n := xF^.cf.n, x:=63 );
         xDev^.al.in.cmd    := 52;
         xM^.wht           := -1;

     53:   // ROL - zafixovat otvorene
         _NhxDev(c := xF^.cf.c, n := xF^.cf.n, x:=33 );
         xDev^.al.in.cmd := 53;
         xM^.wht           := -1;




     60:    // HOME - objekty
            CASE   xB^.r[xA^.tch.row].o.ob[xA^.tch.obj].fn OF
             87 : // pir
                  xU^.o[8].fn := 57;
                  _Nh_Web_CMD_Action(mnu := 5);
            ELSE
            ;
            END_CASE;
            xM^.wht           := 25;




     63: // spodne menu xU[3] CHECK - CH2 zapnut=vypnut iba priradene : DLg
         xM^.wht := 20;                                                    // nove data
         IF xF^.cf.c = 43 THEN                                             // hed:DLS -> DLg:row
            xL^.fvz := NOT xL^.fvz;
            IF xL^.fvz THEN
               xF^.rom := 0;
            END_IF;
			ELSE
            xL^.fvz := NOT xL^.fvz;
         END_IF;
         xU^.o[3].fn    := _Nh_O12(xL^.fvz,38,35);

     64: // spodne menu xU[4] vacsinou CAT
         xM^.wht := -1;                                                    // nove data

     65: // spodne menu xU[5] MIESTNOSTI
     66: // spodne menu xU[6] visible
     67: // spodne menu xU[8] List DEV
     68: // spodne menu xU[9] PLAY/ ON*OFF...



(*
     54: // aktivovat/deaktivovat blikac/opozdovac pre DEV  (pridat/odobrat vetu v acfg[36])
(*

            xPar^.out.Bl1 := NOT xPar^.out.Bl1;
            IF xPar^.out.Bl1 THEN                                // treba najst vetu
               xPar^.out.BlX := _NhFindDel(wh:=0, cx:=36, new:=true, nOk :=true);
               IF xPar^.out.BlX = 0 THEN
                  xPar^.out.BlX := aCfg[36].rec + 1;
                  _NhDbxRam(ram := true, dbx := false );          // v 1.iteracii sa neuklada do dbx, lebo este sa budu zapisovat data
               END_IF;
            ELSIF xPar^.out.BlX > 0 THEN                         // vymazat
               _NhFindDel(cx:=36, nx :=xPar^.out.BlX, ok:=0,new:=0);
               xPar^.out.BlX := 0;
            END_IF;
            xM^.wht := 30;                                       // v tomto cykle sa nepokracuje do browsu, lebo sa nastavuje DEV , az v druhom cykle
*)
(*



     59: // akcie menu - filtre pre priradenie miestnosti
          xM^.wht := -1;
         IF xF^.cf.c = 43 THEN                                          // hlavicke je DLS, riadky DLg
            CASE xA^.tch.obj OF
//              2 : xL^.dsh := _Nh_U12(xL^.dsh = 3,1,3);                  // DSH
              3 : xU^.o[3].fn := _Nh_O12(xU^.o[3].fn = 35,38,35);       // len s priradenym DEV
                  xM^.wht := 20;
//              4 : // cat
              8 : xU^.o[8].fn := _Nh_O12(xU^.o[8].fn = 49,51,49);       // ON/OFF
            ELSE
               xM^.wht := 25;
            END_CASE;
         END_IF;
*)


     69: // zmena modu nastavit pridanie RFID karty / hladanie
            _NhxDev(c := 38, n := 1, x:=34 );                                   // nastavit sa na RFID snimac vratnicovy
            IF xU^.o[2].fn = 32 THEN
               xU^.o[2].fn       := 47;                                    // obrazok + na zelenom = pridanie karty
               xDev^.al.in.cmd   := 102;
            ELSE
               xU^.o[2].fn       := 32;                                    // hladanie karty
               xDev^.al.in.cmd   := 101;
            END_IF;
            xM^.wht := -1;                                     // len prekreslenie, nie nove data

     74: // prepnut v spodnom menu na RBBWA
         IF _NheLvl(lvl:=1) THEN
            _Nh_Web_CMD_Screen(obj := 56,obr:=xR^.o.ob[1].fn,eMnu:=1);
         END_IF;
     75: // prepnut v spodnom menu na RGBWA
     		_Nh_Web_CMD_Screen(obj := 56, n := SINT_TO_USINT(xA^.tch.obj));


     76: // prepnut v spodnom menu na Externe vazby
         IF _NheLvl(lvl:=1) THEN
            _Nh_Web_CMD_Screen(obj := 55,obr:=xR^.o.ob[1].fn,eMnu:=1);
         END_IF;
     77: // prepnut v spodnom menu na Externe vazby
     		_Nh_Web_CMD_Screen(obj := 55, n:= SINT_TO_USINT(xA^.tch.obj));

     78: // prepnut v spodnom menu na DEV - > SCN/ACT/BLK/DLg
     		_Nh_Web_CMD_Screen(obj := 53, n:= SINT_TO_USINT(xA^.tch.obj));

     79: // prepnut v spodnom menu na DEV-LIST
     		_Nh_Web_CMD_Screen(obj := 51, n:= SINT_TO_USINT(xA^.tch.obj));

     80: // vstup do DEV-List O UROVEN DOPREDU Z RIADKA
         IF _NheLvl(lvl:=1) THEN
            _Nh_Web_CMD_Screen(obj := 51,obr:=xR^.o.ob[1].fn, eMnu:=1);
         END_IF;
     81: // vstup do SETUP-List O UROVEN DOPREDU Z RIADKA
         IF _NheLvl( lvl := 1) THEN
            _Nh_Web_CMD_Screen(obj := 52,obr:=xR^.o.ob[1].fn, eMnu:=1);
         END_IF;
     82: // prepnut v spodnom menu na priradit ROM
            _Nh_Web_CMD_Screen(obj := 52, n:= SINT_TO_USINT(xA^.tch.obj));                        // VAZBY,LIST....
            xM^.wht := 20;
     83: // Lock/Unlock  LEN v Zone
            IF _NhxPt(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=83) THEN
               xZon  := xPt;
            ELSE
               xZon  := xHom;
            END_IF;
            xZon^.cx.lck.WebCode := NOT xZon^.cx.lck.WebCode;  // true ;

            xM^.wht := -1;
     84: // prve nacitanie menu k ZONe, pripadne rom : rom-list,USR,LOCK,ALARM.. prepnutie ro rom-listu
         IF _NheLvl( lvl := 1) THEN
				ix	:= xR^.o.ob[1].fn;
  				_Nh_FRM_Read(frm:=18);
             xU^.o[2].fn := ix;
      		_Nh_Web_CMD_Screen(obj := 30);
         END_IF;

     85: // zoznam ROM do ZONE
     		_Nh_Web_CMD_Screen(obj := 30, n:= SINT_TO_USINT(xA^.tch.obj));
(*
     86: // akcie, ktore spustaju LOCK/UNLOCK
     		_Nh_Web_CMD_Screen(obj := 31);
*)

     87: // akcie, od alarmu
     		_Nh_Web_CMD_Screen(obj := 32);

     88: // Simulacie pritomnost
     		_Nh_Web_CMD_Screen(obj := 33);
     89: // refresh vsetkych DEV
         aSys.RefCycNew    := 1;
			xM^.wht 				:= -1;
	  90: // prepinanie stavov ALARMU na vstupe do akcie
			IF xR^.h.cf.c = 48 THEN
				xAla	:= xDev;
				xAla^.cf.typ := xAla^.cf.typ + 1;
				IF xAla^.cf.typ > 6 THEN
					xAla^.cf.typ := 0;
				END_IF;
			END_IF;
(*
			xRom := xDev;
			IF xR^.h.chk AND xR^.h.nd > 0 THEN
				_NhxVaz(cv:=xL^.vaz, nd := xR^.h.nd);
				IF _NhxPar(cp := aCfg[3].par, np:= xVaz^.in.p ,x:=240) THEN
					pZon := xPar;
					IF pZon^.cmd < 60 THEN
						pZon^.cmd := 60;
					ELSIF pZon^.cmd >= 68 THEN
						pZon^.cmd := 60;
					ELSE
						pZon^.cmd := pZon^.cmd + 1;														
					END_IF;
				END_IF;
			END_IF;
*)

    128: // oznacenie co kopirovat a kde
         _NhxPt(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=33 );
			xRol := xPt;
			IF xU^.o[1].wh = 0 THEN 							// nemame zroj
				xU^.o[1].wh 	:= xR^.h.cf.n;             // vyberie sa zdroj
				xRol^.me.cpy 	:= 0;			
			ELSIF xU^.o[1].wh = xR^.h.cf.n THEN       	// odznaci sa zdroj
				xU^.o[1].wh 	:= 0;			
			ELSIF xRol^.me.cpy THEN
				xRol^.me.cpy 	:= 0;			              	// odznaci sa riadok
			ELSE
				xRol^.me.cpy 	:= 1;			          		// vyberie sa riadok ako ciel
			END_IF;

    129: // zmena obrazka kopirovania v cat ROLETY + kopirovanie
			IF xA^.tch.obj = 2 THEN																	// START/Cancel
				xU^.o[1].wh := 0;
			END_IF;	
			IF xU^.o[1].wh > 0 THEN                                              // mame cislo vety zdroja kopirovania
    			_NhxPt(c := 31, n := xU^.o[1].wh, x:=32 );
				xRol2 := xPt;                                                    	
			END_IF;
			FOR nd := 1  TO aCfg[31].rec DO
				_NhxPt(c := 31, n := nd, x:=31 );
				xRol 				:= xPt;
				IF xU^.o[1].fn = 44 AND xRol^.me.cpy AND xU^.o[1].wh > 0 THEN     // mame zdroj aj tato veta je oznacena
					xRol^.cx.cf := xRol2^.cx.cf;												// prekopiruje zo zdroja
				END_IF;
				xRol^.me.cpy 	:= 0; 															// vymaze ciel kopirovania
  			END_FOR;
//			xU^.o[1].wh 		:= 0;


			IF xU^.o[2].fn  = 45 THEN														// sivy COPY vpravo
				// prepnute na kopirovanie
				xU^.o[2].fn  :=  46;				 	                              	// cancel vpravo
				xU^.o[1].fn  :=  44;																// zlty copy vlavo
				xU^.o[1].cm  := 129;
			ELSE
				// default
				xU^.o[2].fn  :=  45;	
				xU^.o[1].fn  :=  0;																
				xU^.o[1].cm  :=  0;																
				_Nh_Brw_Dsh_Chg();																// nastavi ikonu kopirovania
			END_IF;


    
    130: // kopirovanie POI pre typove dni {predtym 45}
				_Nh_xPod_Map(cf:=xF^.cf.c, nd:=xF^.cf.n, WhtPoi:=xM^.pod.po.WhtPoi);
				xPod2 := xPod;															// zdroj dni kopirovania

				IF xM^.pod.cp.all  THEN                                		
            	FOR nd := 1 TO aCfg[xF^.cf.c].rec DO
						IF _NhxPt(c:=xF^.cf.c, n:=nd, x:=130) AND nd <> xF^.cf.n AND xPt^.ok.cpy THEN	// prechadza DEV kam sa ma kopirovat (ROM/HET/VEN..., vyluci zdroj
							xPt^.ok.cpy := false;                                       // odznaci priznak kopirovania
							_Nh_xPod_Map(cf:=xF^.cf.c, WhtPoi:=xM^.pod.po.WhtPoi);											// ciel namapuje dni xPod podla druhu CF			
							FOR i := 1 TO 11 DO
		                  IF xM^.pod.cp.dst[i] AND xPod2^.poi[ i ] > 0 THEN			// den v zdroji sa kopiruje a ma vetu POI
	   	         			IF _NhxPt(c := 26, n := xPod2^.poi[ i ],x:=26) THEN  	
					   				xPox  	:= xPt;												// zdrojova veta POI	
										IF xPod^.poi[ i ] > 0 THEN									// ciel ma vetu POI
			   	         			IF _NhxPt(c := 26, n := xPod^.poi[ i ],x:=26) THEN  	
							   				xPox2  	:= xPt;										// cielova veta POI	
      										xPox2^	:= xPox^;                           // prepise ciel zdrojom	
      									END_IF;
										END_IF;
									END_IF;
								END_IF;						
	                  END_FOR;
						END_IF;
					END_FOR;
//					_NhDevSetCpy(set:=false, cf:=xF^.cf.c, nd:=1, rec:=aCfg[xF^.cf.c].rec);
		         _NheLvl(lvl:=-2);                                              // o LVL dopredu

				ELSIF xPod2^.poi[ xM^.pod.cp.src ] > 0 THEN                                // mame zdroj > 0
	            IF _NhxPt(c := 26, n := xPod2^.poi[ xM^.pod.cp.src ],x:=25) THEN  	// najde zdroj
	   				xPox  := xPt;																	// zdrojova veta POI
						FOR i := 1 TO 11 DO
	                  IF xM^.pod.cp.dst[i] AND xPod2^.poi[ i ] > 0 THEN				// do ciela sa kopiruje a ciel ma vetu POI
	            			IF _NhxPt(c := 26, n := xPod2^.poi[ i ],x:=26) THEN  		// cielova veta POI
				   				xPox2  	:= xPt;													// cielova veta POI
									xPox2^	:= xPox^;                                    // prepise ciel zdrojom
								END_IF;
							END_IF;						
                  END_FOR;
   				END_IF;
				END_IF;
				_NheBrw(wht:=12);

    131: // kopirovanie celych ROM + oznacenie kopirovanie
			_NheBrw(wht:=12);
         xU^.o[2].cm := 131;
    		CASE xU^.o[2].fn OF
			 	45: 	// sive copy
						xU^.o[2].fn := 44;														// zlte copy
						xM^.pod.cp.all	:= 1;
						FOR i := 1 TO 11 DO
							xM^.pod.cp.dst[i] := 1;
                  END_FOR;
			 	44: 	// zlte copy
						xU^.o[2].fn := 45;														// zlte copy
						xM^.pod.cp.all	:= 0;

				ELSE  xU^.o[2].fn := xU^.o[2].wh;
						xM^.pod.cp.all	:= 0;
						xM^.pod.cp.cpy	:= 0;
			END_CASE;
			xA^.tch.obj	:= -1;										// zaisti aby sa objekt nevybral , inak by sa zobrazovalo to co je xU^.o[2].wht
			xA^.tch.cmd := 207;										// urobi refresh uz nadefinovaneho screenu

    132: // browser - vyber kopirovania
         IF _NheLvl( lvl := 4) THEN
            _Nh_Web_CMD_Screen(obj := 60);
				_NhDevSetCpy(set:=false, cf:=xF^.cf.c, nd:=1, rec:=aCfg[xF^.cf.c].rec);		// resetne priznak cpy
         END_IF;
    133: // oznacenie - kopirovania
			IF xA^.tch.mnu AND xA^.tch.obj = 2 THEN												// oznacit vsetko
				_NhDevSetCpy(set:=NOT xM^.pod.cp.chk, cf:=xF^.cf.c, nd:=1, rec:=aCfg[xF^.cf.c].rec);
				xM^.pod.cp.chk := NOT xM^.pod.cp.chk;
			ELSIF xA^.tch.row >= 0 THEN
				IF xF^.cf.n <> xB^.r[xA^.tch.row].h.cf.n THEN										// dotyk nad inym ako zdrojom
					_NhDevSetCpy(set:=NOT xPt^.ok.cpy, cf:=xB^.r[xA^.tch.row].h.cf.c, nd:=xB^.r[xA^.tch.row].h.cf.n, rec:=xB^.r[xA^.tch.row].h.cf.n);
					xM^.pod.cp.chk := _NhDevSetCpy(chk:=true, set:=NOT xM^.pod.cp.chk, cf:=xF^.cf.c, nd:=1, rec:=aCfg[xF^.cf.c].rec);
				END_IF;
			END_IF;
			xA^.tch.mnu	:= 0;
//			xU^.o[1].fn := _Nh_O12(xM^.pod.cp.chk,44,45);
			xU^.o[1].fn := _Nh_O12(xM^.pod.cp.chk,44,6);			


    136: // <  O UROVEN SPAT z REGulatora
         _NhxPt(c := xF^.cf.c, n := xF^.cf.n, x:=136 );                     // xDev,xCfg,xPar pre aktualny riadok
			xHet := xPt;
			xHet^.cx.reg.ModeFromSrc := true;			
         _NheLvl(lvl:=-1);                                              // o LVL dopredu
         xM^.htt :=  '';

    137: // prepnut MAN/AUTO
         xDev^.al.in.cmd := 37;
    138: // nastav MAN
         xDev^.al.in.cmd := 38;
    139: // nastav AUTO
         xDev^.al.in.cmd := 39;
    140: // nastavit wRGBo na TGL
         _NhxDev(c := xF^.cf.c, n := xF^.cf.n, x:=36 );                     // xDev,xCfg,xPar pre aktualny riadok
         xDev^.al.in.cmd := 36;
    141: // vyrobit HET
			aSys.ini := 11;
			RETURN;

    190: // roleta - vyber hore / dolu
         _NhxDev2(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=35 );                     // xDev,xCfg,xPar pre aktualny riadok
         ok := false;
         FOR j := 1 TO 10 DO
            IF ok THEN
               xR^.o.ob[j].btn := false;
            ELSIF xA^.tch.obj = j THEN
//               xDev2^.al.in.cmd := 239+SINT_TO_USINT(j);                // cislo cmd od 240...249
//               xR^.o.ob[j].btn := NOT xR^.o.ob[j].btn;

               IF xR^.o.ob[j].btn=false THEN                               // teraz je este vypnuty, ale bude zapnuty btn v pocedure show...
                  xDev2^.al.in.cmd := 239+SINT_TO_USINT(j);                // cislo cmd od 240...249
               ELSE                                                        // bude vypnuty
                  xDev2^.al.in.cmd := 255;                                 // stop vsetkemu co bezi
               END_IF;
               ok := true;
            END_IF;
         END_FOR;


         xM^.wht := -1;                                     // len cisty refresh existujucich dat v riadku bez predefinovania dat

(*
    191: // roleta setup : prepnut HORE/DOLU
         _NhxDev2(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=36 );                     // xDev,xCfg,xPar pre aktualny riadok
         xRol := xDev2;
         CASE xA^.tch.obj OF
           7 : xRol^.al.Qf := 1; xRol^.al.Qx := 0;
           8 : xRol^.al.Qf := 0; xRol^.al.Qx := 1;
         END_CASE;
         xM^.wht     := 30;
*)


    199: // DOTYK NAD IKONOU Day Of Week
         IF _NheLvl( lvl := 1 ) THEN                                 // nadefinuje menu stanky
            xL^.obj        := 200;                                      // podhodi sa 200
            xA^.tch.obj    := 3;                                        // prvy objekt = 3
            xF^.rom        := 199;                                      // podla tohto sa nadefinuje menu
            xA^.tch.cm     := 200;
            xA^.tch.cmd    := 200;                                      // vrati sa uz do 200
            RETURN;
         END_IF;

    200: // DOTYK NAD HLAVNYM OBRAZOK RIADKA = VLASTNOSTI
         xM^.wht     := -1;
         IF xL^.obj = 200 THEN                                           // stranka uz je, zmenilo sa nieco v menu
            xU^.n    := SINT_TO_USINT(xA^.tch.obj);                        // nastavi sa stranka odpovedajuca obj
            xM^.wht  := 20;                                             // predefinuju sa objekty
            yIO      := xB^.r[0].h.cf;

         ELSIF _NheLvl( lvl := 1 ) THEN                                 // nadefinuje menu stanky
            xL^.obj     := 200;
            xM^.wht     := 20;

(*
            IF xR^.h.chk AND xA^.tch.obj = 4 THEN //AND xR^.o.ob[4].cf.c > 0 THEN // v objekte 4 je vaba so spravnym parametrom
               xF^.cf  := xR^.o.ob[4].cf;                             // hlavicka sa preberie z riadka
            END_IF;
*)

         END_IF;



    201: // nadefinovat LOKALNU,externu stranku
            IF xL^.obj  = 201 THEN
               _NhxDev2(c := xF^.cf.c, n := xF^.cf.n, x:=61);
               xUsr2       := xDev2;
              IF xM^.htx = 10 THEN //; xM^.htt = 'USR_NHF.XML' THEN
                  xM^.htx     := 11;
                  xM^.htt     := 'US2_NHF.XML';
                  xU^.o[2].fn := 0;                                             // vsetky rom
                  xU^.o[2].cm := 0;                                             // vsetky rom
                  xU^.o[1].cm := 201;                                             // vsetky rom
						IF xUsr^.ok.ref THEN
	                  xUsr2^      := yUSR;
						END_IF;
               ELSIF xM^.htx = 11   THEN  //;xM^.htt = 'US2_NHF.XML' THEN
                  xM^.htx     := 10;
                  xM^.htt     := 'USR_NHF.XML';
                  xU^.o[2].fn := 7;                                             // vsetky rom
                  xU^.o[2].cm := 201;                                             // vsetky rom
                  xU^.o[1].cm := 202;                                             // vsetky rom
						IF xUsr^.ok.ref THEN
	                  xUsr2^      := yUSR;
						END_IF;
               END_IF;
					xUsr^.ok.ref := false;

            ELSIF _NheLvl( lvl := 1 ) THEN                                 // nadefinuje menu stanky
               xL^.obj     := 201;
               _NhxDev2(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=68);
               xUsr2       	:= xDev2;
					xUsr^.ok.ref	:= false;
               CASE xR^.h.cf.c OF
                 22: // USRs;
							yUsr        := xUsr2^;
                     IF  xA^.usr = 1 OR xA^.UsrRight >=2 THEN       							// moze lne spravca a admin
                        xM^.htx     := 10;
                        xM^.htt     := 'USR_NHF.XML';
                        xU^.o[2].fn := 7;                                             // vsetky rom
                        xU^.o[2].cm := 201;                                             // vsetky rom
                     ELSE
                        _NheLvl( lvl := -1 );
                     END_IF;
               ELSE
                    	_NheLvl( lvl := -1 );
                     RETURN;
               END_CASE;
               xU^.o[1].cm := 202;                                             // vsetky rom
               xM^.frm     := true;
            END_IF;
            xM^.wht := -1;

    202: // ukoncit-ulozit data lokalnej stranky
            _NhWebSave();


    203: // VSTUP DO SUB-MENU FRAME
 				_Nh_FRM_Read(frm:=USINT_TO_UINT(xU^.o[ xA^.tch.obj ].frm)); 	// v tom istom LVL nacita ine menu vo FRM
				xA^.tch.obj := USINT_TO_SINT(xU^.n);
      	   xA^.tch.cmd    := 206;                                      // vrati sa uz do 200

    204: // VSTUP DO MENU FRAME
         IF _NheLvl( lvl := 1 ) THEN                                 // nadefinuje menu stanky
            xL^.vaz     := xM^.lvd[xM^.lvl-1].vaz;
            xL^.chk     := xM^.lvd[xM^.lvl-1].chk;
            xL^.rw1     := xM^.lvd[xM^.lvl-1].fil.cf;       // hlavicku browsu, kde bola veta z ktorej sa islo
            xB^.r[0]    := xR^;                             // v r[0] bude cela veta a odial r[0].h.chk - ci bola vazba
            xL^.obj     := 205;
         END_IF;
    205: // ZMENA MENU VO FRAME



	 210: // DOTYK Weather
         IF _NheLvl( lvl := 3) THEN
				xF^.cf.c			:= 3;
				xF^.cf.n			:= 1;	
	   	   _Nh_Lang(id := 354 ,txt := ADR( xL^.naz ),zn:=20);
				_Nh_FRM_Read(frm:=68);
   	      xL^.obj        := 205;                                      // podhodi sa 200
      	   xA^.tch.cmd    := 206;                                      // vrati sa uz do 200
         END_IF;


    215: // DOTYK HOME-typove dni
         IF _NheLvl( lvl := 3) THEN
				xF^.cf.c			:= 3;
				xF^.cf.n			:= 1;	
            _NhxPt(c := xF^.cf.c, n := xF^.cf.n, x:=7);                               // nazov DEV
            xL^.naz := xPt^.cf.Name;
				_Nh_FRM_Read(frm:=75);
   	      xL^.obj        := 205;                                      // podhodi sa 200
      	   xA^.tch.cmd    := 206;                                      // vrati sa uz do 200
         END_IF;


   { $IFDEF __NH_DALI }


    247: // funkcie brw-DALI-SLAVE-zmena v spodnom menu - rozne filtre, akcie na BTN
         xM^.wht := 20;
         IF xF^.cf.c = 42 THEN                                     // spodne menu pre browser DLS/DLg - v hlavicke je master
            _Nh_Chk_DALI(set:=true, mnu:=xA^.tch.obj);
            xU^.n := 0;
         ELSIF xR^.h.cf.c = 42 THEN                               // riadok je DLM - akcia od btn
            xM^.wht  := -1;                                        // v tomto cykle sa nepokracuje do browsu, lebo sa nastavuje DEV , az v druhom cykle
            xDLm     := xDev;
            ii       := INT_TO_USINT(xR^.h.cf.n);
            xDlfb    := ADR(aDali[ii]);
            CASE xA^.tch.obj OF
              2 : // ON/OFF - master
                  IF xDLfb^.cmd[1].cmd > 0 THEN                                                   // ak prebieha nejaku task, breakne ho
//                     IF xDlfb^.cmd[1].Break THEN                          // bezi proces, ktory sa neda braknut                                 // ak prebieha nejaku task, breakne ho
//                        xDLfb^.Break := true;
//                     END_IF;
                  ELSE
                     xDev^.al.in.cmd   := 1;                      // prepni bez oneskorenia
                     xDev^.al.in.par   := 0;                      // pri takomto zadani sa zoberie default parameter
                     xM^.wht           := 0;                      // v tomto cykle sa nepokracuje do browsu, lebo sa nastavuje DEV , az v druhom cykle
                  END_IF;
              4 : // vstup do brw-DLs z mastra
                  IF _NheLvl( lvl := 1) THEN                      // o LVL dopredu bez prebratia menu
                     _Nh_Web_CMD_Screen(obj := 48);
                  END_IF;
              6 : // vstup do brw-DLg z mastra
                  IF _NheLvl( lvl := 1) THEN                      // o LVL dopredu bez prebratia menu
                     _Nh_Web_CMD_Screen(obj := 47);                        // VAZBY,LIST....
                  END_IF;

            END_CASE;
         END_IF;


    249: // DALI- browser MASER + SLAVE
            xM^.wht        := -1;
            IF xA^.tch.Q THEN
               j  := xA^.tch.obj;
               xO := ADR(xR^.o.ob[j]);
            END_IF;
            CASE xR^.h.cf.c OF
            42:   // master
                  xDLm     := xDev;
                  ii       := INT_TO_USINT(xR^.h.cf.n);
                  xDlfb    := ADR(aDali[ii]);
                  CASE xA^.tch.obj OF
                     2: // ON/OFF
                        xDev^.al.in.cmd   := 1;                                     // prepni bez oneskorenia
                        xDev^.al.in.par   := 0;                                     // pri takomto zadani sa zoberie default parameter
                        xM^.wht           := 0;                                        // v tomto cykle sa nepokracuje do browsu, lebo sa nastavuje DEV , az v druhom cykle
                     4 : // brows Sha
                        IF _NheLvl( lvl := 1) THEN                      // o LVL dopredu bez prebratia menu
                           _Nh_Web_CMD_Screen(obj := 48);                        // VAZBY,LIST....
                        END_IF;
                  END_CASE;
            43:   // slave
                  xDLs  	:= xDev;
		            dlsl     := _Nh_DL_sha(nd := xR^.h.cf.n);
   		         dlma     := _Nh_DL_sha(ma := true, nd := xR^.h.cf.n);

                  CASE xA^.tch.obj OF
                     1: // hlavna ikona = frame
                        IF _NheLvl( lvl := 1 ) THEN                                 // nadefinuje menu stanky
                           xL^.obj     := 205;
                        END_IF;
                     6 : // priradit DLs->DLs
                        IF _NheLvl( lvl := 1) THEN
                           _Nh_Web_CMD_Screen(obj := 47);
                        END_IF;
                     2: // ON/OFF len pre Miboxer z 1 adresou a RGBW

                        xDev^.al.in.cmd   := 43;                                     // prepni bez oneskorenia
                        xDev^.al.in.par   := 0;                                     // pri takomto zadani sa zoberie default parameter
                        xM^.wht           := 0;                                        // v tomto cykle sa nepokracuje do browsu, lebo sa nastavuje DEV , az v druhom cykle


                  END_CASE;
            ELSE
            ;
            END_CASE;

   { $END_IF }

    250: //   prepinanie rezimu setup
            _NhDefSet(chg := true);
            xM^.wht     := -1;

    251: // dotyk/podrzanie na SLIDER
            xM^.wht := -1;                                     // len cisty refresh existujucich dat v riadku bez predefinovania dat
    252: // // vypis od 1.riadka s predefinovanim dat v riadku
            xM^.wht := 10;                                     //***---*** POZOR !!! zmena - dotyk sa presuva do objektu spat
    253: // len pre predefinovanie objektov v NhBrw200
            xM^.wht := 30;
    254: // kompletny refresh browsu s novym indexom a datami od existujuceho 1.riadka
            xM^.wht := 25;
    255: // nic sa nedeje, riadi si to
         ;
//         aSys.RestDev := true;
   END_CASE;

   IF aWht.n < 6 THEN
      xA^.tch.wht := xM^.wht;
      aWht.t[aWht.n] := xA^.tch;
      aWht.t[aWht.n].cmdNext := cmd;
      aWht.t[aWht.n].xMwht  := xM^.wht;
      aWht.n := aWht.n + 1;
   END_IF;

   IF xL^.obj = 205   THEN
      IF _Nh_Shw_FRM() = false THEN
         RETURN;
      END_IF;
   ELSIF xM^.wht = 0 THEN                                            // neprekreslule sa brows
      ;
   ELSIF xM^.delay > 0 THEN                                       // cakanie na delay
      xM^.delay := xM^.delay - MIN(xM^.delay, aSys.mSec);
      RETURN;
   ELSIF xL^.obj = 0 THEN                                          // HOME screen
      IF _Nh_Frm_HOM() = false THEN
         RETURN;
		END_IF;
(*
   ELSIF xL^.obj = 200 THEN                                           // PARAMETERS
      IF _NhBrw200() = false THEN
         RETURN;
      END_IF;
*)
   ELSIF _Nh_Web_BRW() = false THEN                              // ZAKLADNY 6-riadkovy BROWSER
      RETURN;
   END_IF;

	
   xM^.wht     := 0;
   xA^.tch.cmd := cmd;
   xM^.delay   := delay;


END_FUNCTION

{ $ END_IF }



