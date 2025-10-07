{ $ IFDEF __NH_WEB }

FUNCTION _Nh_Map_Idx  {HIDDEN}  : BOOL     // premapuje xIdx (Veta browsu (ixb) v wrk pamati ) podla zvolenej sady indexu (ixb), pripadne vycisti browser
   VAR_INPUT
      ini   : BOOL;                       // vymaze data browsu aj indexov
      ixb   : USINT:= 0;                  // sada dat
      idx   : USINT:= 1;                  // cislo vety (index v sade dat), ktoru ma namapovat (0=1.veta)
   END_VAR
   xIxB  := ADR(xM^.ixb[ixb]);
   IF ini THEN
      IF ixb > 0 THEN
         xIxB^.ofs := xM^.ixb[ixb-1].ofs + xM^.ixb[ixb-1].idx;
//         xIxB^.row.rws   := 6;                                                // len pre Quick menu
      ELSE
         _NheBrw( wht := 4);                                                  // vymaze kompletny browser aj s IX
         xIxB^.row   :=_NhDsh.dsh[xL^.dsh];                                   // nastavi riadky aj
      END_IF;
   END_IF;
   sz          := SIZEOF(NH_IDX) * USINT_TO_UDINT( xIxB^.ofs + idx - 1 ) ;
   xIdx        := ADR(mRam[aSys.vIx1]) + sz;    // za poslednu vetu zo vsetkych vazieb
   _Nh_Map_Idx := xIxB^.idx > 0;

END_FUNCTION

//FUNCTION _NhFinIdx {HIDDEN} : USINT    // najde v indexe DEV ulozene v 1.riadku, alebo prida a uberie zadany pocet riadkov s nastavi tak 1.riadok

FUNCTION _Nh_Chk_RoW   {HIDDEN}  : BOOL    //
   VAR_INPUT
      chk   : BOOL;                                   // posun dohora (dalej ) o pocet riadkov row
      vaz   : BOOL;
   END_VAR
   _Nh_Chk_RoW := false;
   IF xL^.fvz THEN
      xM^.wht := 20;                                           // nove data, vypis od zaciatku
      RETURN;
   END_IF;
   i := 0;                                   //
   xM^.wht := 25;                                              // novy index, vypis od zpamatanej vety v 1.riadku
   IF chk THEN                                                 // zaskrtnutie
      IF vaz AND xL^.fdv = 0 THEN                              // veta je VAZ[2] a nie je zapnuty filter na DEV = nevieme kde v browse sme
         xL^.rw1 := xR^.h.cf;                                  // check veta sa nastvi na 1.riadok
      END_IF;
   ELSIF vaz THEN
      IF xA^.tch.row = 1 THEN
         IF xIxB^.ix2 > xIxB^.ix1 THEN
            i := xIxB^.ix1 + 1;
         ELSIF xIxB^.ix1 > 1 THEN
            i := xIxB^.ix1 - 1;
         ELSE
            xM^.wht := 20;
         END_IF;
      END_IF;
//   ELSE
//      xM^.wht := 10;
   END_IF;
   IF i > 0 THEN
      _Nh_Map_Idx(idx:=i);
      xL^.rw1     := xIdx^.ix[aWeb.nbr].dev;       // check vazby presunie na 1.riadok                            //
   END_IF;
END_FUNCTION


FUNCTION _NhSet1Row {HIDDEN}  : BOOL    // najde v indexe DEV ulozene v 1.riadku, alebo prida a uberie zadany pocet riadkov s nastavi tak 1.riadok
   VAR_INPUT
      up    : BOOL;                                   // posun dohora (dalej ) o pocet riadkov row
      dn    : BOOL;                                   // posun dolu   (spat) o pocet riadkov row
      end   : BOOL;                                   // pokusi sa zaradit pridavanu vetu n koniec browsu
      del   : BOOL;                                   // zisti, ci nedoslo k vymazaniu vety v 1.riadku, ak ano prestavi na dalsiu alebo na prvy index
      fnd   : BOOL := true;                           // vzdy sa hlada
      ixb   : USINT := 0;                             // indexova sada 0,1
      row   : USINT;                                  // prida, alebo uberie riadky, ak sa najde pozadovana veta
   END_VAR
   _NhSet1Row := false;
   rb := _Nh_Map_Idx(ixb := ixb);                                               // namapuje 1.index
   xIxB^.ix2   := 0;                                                    // tu sa vkladaju data do ROW
   IF fnd THEN
      FOR i := 1 TO xIxB^.idx DO                                        // prechadza vsetky indexy
         IF xL^.rw1.c  = xIdx^.ix[aWeb.nbr].dev.c AND
            xL^.rw1.n  = xIdx^.ix[aWeb.nbr].dev.n THEN
            _NhSet1Row := true;
            IF end THEN
               IF i <= xIxB^.row.rws THEN
                  i := 1;
               ELSE
                  i := i - xIxB^.row.rws + 1;
               END_IF;
            END_IF;
            EXIT;
         END_IF;
         xIdx  := xIdx + SIZEOF(NH_IDX);
      END_FOR;
   ELSIF xIxB^.ix1 > 0 THEN                                             // nehlada sa. nastavi prva veta zobrazena v browse
      i           := xIxB^.ix1;
      _NhSet1Row  := true;
   ELSE
      i  := 1;
   END_IF;
   IF xIxB^.idx = 0 THEN
      xIxB^.ix1 := 0;                                                   // nemame data
      RETURN;
   ELSIF xIxB^.idx <= xIxB^.row.rws THEN                                // mame menej dat ako jedna stranka riadkov
      i   := 1;
   ELSIF _NhSet1Row THEN
      IF del THEN                                                       // v indexe sa nasla veta z 1.riadku
         IF _NhxDev(c := xL^.rw1.c, n := xL^.rw1.n, x:=10) = false THEN      // veta v 1.radku bola prave vymazana
            IF xIxB^.idx <= i THEN                                      // tato veta je posledna
               i := 1;                                                  // bude sa vypisobvat kompletny vypis
            ELSE
               i := i + 1;                                              // nastavi sa nasledujuca veta
            END_IF;
         END_IF;
      ELSIF dn THEN
         i := MAX(1,i - MIN( i, row )) ;                                // +1 aby sa nastavil riadok 1, nie 0;
      ELSIF up THEN
         i := i + row;                                                  // toto by mohol byt prvy riadok (za poslednym doterajsim)
         IF i + xIxB^.row.rws > xIxB^.idx THEN                          // ci po pridani riadkov, bude zaplnena cela stranka
            i := xIxB^.idx - xIxB^.row.rws + 1;
         END_IF;
      END_IF;
   ELSIF xIxB^.idx > 0 THEN                                             // nenasla sa veta, mame data, ide sa od zaciatku, nastavi sa 1.veta,
      i  := 1;
   END_IF;
   _Nh_Map_Idx(ixb := ixb, idx := i);                                     // namapuje najdeny index
   xIxB^.ix1   := i;                                                    //

   xL^.rw1     := xIdx^.ix[aWeb.nbr].dev;                                   //

   _NhSet1Row  := true;                                                 //

(*
   IF xIxB^.ix1 > 0 AND xIxB^.row.rws > 0 THEN
      xIxB^.n  := xIxB^.idx / xIxB^.row.rws;
      IF mod(xIxB^.idx,xIxB^.row.rws) > 0 THEN
         xIxB^.n  := xIxB^.n + 1;
      END_IF;
      IF xIxB^.n > 1 THEN                                                              // bude vykreslovat gulicky stran
         xIxB^.w  := 40;
         xIxB^.x1 := (x2 - USINT_TO_INT(xIxB^.n-1) * 40)/2;
      ELSIF xIxB^.n > 0 THEN                                                              // bude vykreslovat gulicky stran
         xIxB^.x1 := x2/2;
      END_IF;
//     xIxB^.pg  := 1;
   END_IF;
*)

END_FUNCTION

FUNCTION _NhVazErr {HIDDEN} : BOOL                // prida vetu do indexu browsu
   yTx2 := CONCAT(yTx2,' in: ',USINT_TO_STRINGF(xVaz^.in.c,'%3d'),';',INT_TO_STRINGF(xVaz^.in.n,'%4d'),';',INT_TO_STRINGF(xVaz^.in.p,'%3d'),';',
                       ' ou: ',USINT_TO_STRINGF(xVaz^.ou.c,'%3d'),';',INT_TO_STRINGF(xVaz^.ou.n,'%4d'),';',INT_TO_STRINGF(xVaz^.ou.p,'%3d') );
   rb := _Nh1RowTxt(logRst := 1,adTime := 3, EmpRow:=1);
END_FUNCTION

(*
FUNCTION _NhSbjOk {HIDDEN} : BOOL                // prida vetu do indexu browsu
   VAR_INPUT
      cf    : USINT;
      rom   : USINT;
   END_VAR
   _NhSbjOk := true;
   IF xA^.admin OR xA^.sbj = 1 OR rom = 0 THEN
      ;
   ELSIF cf = 1 THEN
      _NhSbjOk := rom = xA^.sbj OR rom = 4;
   ELSIF cf = 3 THEN
      _NhSbjOk := rom = xA^.sbj;  //  OR rom = 4;
   ELSIF _NhxPt(cf:=1, nd := USINT_TO_INT(rom), x:=85) AND xPt^.cf.rom > 0 THEN
      _NhSbjOk := xPt^.cf.rom = xA^.sbj ;
   END_IF;
END_FUNCTION
*)

FUNCTION _Nh_DEV_AL_VAZ {HIDDEN} : BOOL
	VAR_INPUT
		clr	: BOOL;
		i1		: USINT := 100;
		i2		: USINT := 100;
//		io		: PTR_TO NH_VAL_IO;
	END_VAR		
	_Nh_DEV_AL_VAZ	:= true;
	IF clr THEN
		IF aCfg[cf].al > 0 THEN                                     // al ma /al, resetne priznak, IOX ho vrati

   		CASE cf OF
     			42 : ;
     			43 : ;
     			44 : ;
     		ELSE  xDev^.al.lst  := false;                            // lst sa vymaze len pre NE-DALI
     		END_CASE;
		END_IF;
	ELSE	
		WHILE i1 <= i2 DO
			IF xPtIO^.dev.c > 0 THEN
				IF _NhxPt(c:=xPtIO^.dev.c, n := xPtIO^.dev.n,x:=-124) THEN							
					;
				ELSE
					xPtIO^.dev.c 	:= 0;				
				END_IF;
			END_IF;
			xPtIO := xPtIO + SIZEOF(NH_VAL_IO);
			i1 	:= i1+1;
   	END_WHILE;	
	END_IF;
END_FUNCTION

(*
FUNCTION _NhSbjOk {HIDDEN} : BOOL                // prida vetu do indexu browsu
   VAR_INPUT
      cf    : USINT;
      rom   : USINT;
   END_VAR
   _NhSbjOk := true;
   IF xA^.admin OR xA^.sbj = 1 OR rom = 0 THEN
      ;
   ELSIF xL^.obj=0 THEN                                                 // HOME DASH
      ;
   ELSIF xL^.obj=2 THEN                                                 // FAV
     _NhSbjOk := rom = xA^.sbj;
   ELSIF xF^.cf.c=1 AND xF^.cf.n=0 THEN                                 // zoznam miestnosti
     _NhSbjOk := rom = xA^.sbj;
   ELSIF xF^.cf.c=1 THEN                                                // 1.miestnost
      _NhSbjOk := true;
   ELSIF xF^.cf.c=3 OR (xF^.cf.c=2 AND xF^.cf.n=6) THEN                 // ZONE alebo SEC
      _NhSbjOk := rom = xA^.sbj OR rom = 4;
   ELSIF _NhxPt(cf:=1, nd := USINT_TO_INT(rom), x:=85) AND xPt^.cf.rom > 0 THEN
      _NhSbjOk := xPt^.cf.rom = xA^.sbj ;
   END_IF;
END_FUNCTION
*)


FUNCTION _Nh_Brw_Idx  {HIDDEN}  : BOOL                      (* VYTVORI ZOZNAM VIET PRE BROWSER VYHOVUJUCICH FILTRU *)
   VAR_INPUT
      ixb   : USINT  := 0;
   END_VAR
   VAR_TEMP
      io    : BOOL;
      dev   : BOOL;
      ix    : USINT;          // lokalne ix, nie globalne
      nx    : INT;
      xIdx1 : PTR_TO NH_IDX;
   END_VAR



   _Nh_Map_Idx(ini := true, ixb := ixb);
   xIdx1 := xIdx;                                              // zapamata si 1.vetu indexu
   _Nh_FRM_Read(frm:=235);                // typy DEV, Dev->Cat, Cat->Cat

      ix    := 1;
      cf    := _Nh_IxC[ix];                                    // vybrata veta CFG
      IF xL^.obj = 44 THEN                                     // BRW-DLg v hlavicke je 1.dali scena
         _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=44);
         xDev2 := xPt;                                            // namapuje hlavicku do xDev2
      END_IF;


   IF xL^.vaz = 1 THEN                                         // FAV, xL^.fvz je vzdy true
      nd := 1;                                                                   //
      WHILE  nd  <= aVaz[xL^.vaz].Rec DO                                         // vsetky vety CFG
         IF _NhxVaz(cv := xL^.vaz, nd := nd ) THEN
            // oblubene
            // xA^.fav.c  ... user
            // xA^.fav.n = -1 dash menu
            // xA^.fav.n = -2 Quick menu
            // xA^.fav.n =  0 oblubene vsetkych usrov   (vtedy aj c:=0)
            // xA^.fav.n =  4 Quick setup
            // xA^.fav.n  > 4 konkretna veta v aCfg[20] ... oblubene pre usra c:=...
            // xVaz^.in.c ... podla xA^.fav.c ... user 0=vsetci
            // xVaz^.in.n ... podla xA^.fav.n
            IF xVaz^.in = xA^.fav THEN                         // zoznam FVL k vybratemu FAV v
               yIdxR      := _e_NH_IDX_ROW;
               yIdxR.fav  := true;
               yIdxR.dev  := xVaz^.ou;
               yIdxR.nd   := nd;
               yes        := true;
					cf 		  := xVaz^.ou.c;
					
					IF _NhxPtIO(c := xVaz^.ou.c, n := xVaz^.ou.n, x:=54) THEN
						xDev := xPt;
						_Nh_DEV_AL_VAZ(i1:=100, i2:=100 );
					END_IF;

            ELSE
               yes        := false;
            END_IF;
	         _NhCrIx(ok := yes);
         END_IF;
         nd := nd + 1;
      END_WHILE;
      cf    := 0;                                              // dalse sa nejde

   ELSIF xL^.obj=70 OR xL^.obj=71 THEN
		;
   ELSIF xL^.fvz AND xL^.vaz > 1 THEN
      cf    := 0;                                              // dalse sa nejde
   ELSE

   END_IF;

(*
   IF cf > 0 AND xF^.cf.c = 2 THEN                     // vstup do hlavnej urovne CAT
   	memset(val := 0, length := SIZEOF(NH_WRK_CAT), dest := VOID( aWeb.A[ aWeb.nbr ].cat ));        // vynuluje zoznam CAT pritomnych pre aktualny subj
		xF^.dev.n[ 0 ] := true;
   END_IF;
*)


   WHILE  cf > 0  DO        															// prechadza sa podla  _Nh_ixc[]. CAT [2] tam nie je                         							
      IF xF^.dev.n[ cf ] OR xF^.dev.n[ 0 ] OR xF^.cf.c = 2 THEN   		// cf je v DEV liste alebo v hlavicke je CAT (DEV do browsu CAT)
         nx := 1;
      ELSE
         nx := 5000;
         cf := _Nh_CFG;                                                 // LEN poistka = nastavi sa na poslednu vetu CFG, ktura nema vety                 // vybrate CFG
      END_IF;

      WHILE nx <= aCfg[cf].Rec DO                                       // jedno CFG

			ok := xL^.obj=47 AND xU^.o[8].fn = 56;
         IF _NhxPt(c := cf, n := nx,x:=37) OR ok THEN
				xPtY	:= xPt;


(*//????12.12.23 nevieme na co ?
				IF _NhxPtIO(c := xVaz^.ou.c, n := xVaz^.ou.n, x:=55) THEN
					xDev := xPt;
					_Nh_DEV_AL_VAZ(i1:=100, i2:=100 );
				END_IF;
*)

				xDev := xPtY;
            sbj            := true;
            IF xF^.cf.c > 0 AND xF^.cf.n > 0 AND xF^.cf.c <> 2 THEN
               _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=60);
               xDev2 := xPt;                                            // hlavicka
            ELSE                                                        // 0-ta uroven (FAV,ROM,CAT,ACT,SCN,SMW.....)
               xDev2 := xDev;                                           // toto je nespravne, len aby pointer neukazova do bludu (ked je v hlavicke
            END_IF;

            IF xDev^.ok.adm THEN                                        // len admin
               yes   := xA^.admin;
            ELSIF xDev^.ok.stp THEN                                     // len v rezime setup
               yes   := xM^.set;
            ELSE
               yes   := true;                                           // neobmedzeny pristup
            END_IF;
//				rom            := xF^.rom > 0 OR xF^.cf.c = 1 OR xF^.cf.c = 3;
				rom				:= true;
            nd             := nx;
            ok             := true;
            yIdxR          := _e_NH_IDX_ROW;
            yIdxR.dev.c    := cf;
            yIdxR.dev.n    := nd;
            yIdxR.dev.p    := xDev^.cf.par;

				IF xL^.vaz > 1 THEN
					xDev2^.al.vaz  := 0;
			   	xDev2^.al.lst  := 0;
				END_IF;

				IF xF^.cf.c = 2 THEN                                   			// browser CAT v hlavicke - prechadza DEV ine ako 2, ci sa zobrazia v CAT
	  				ok    := false;
					yes	:= yFrm_235.DevToCat[cf].n[xF^.cf.n];						// DEV sa zobrazuje aj v kategorii
					IF yes THEN
						IF xA^.CatOk = false THEN
							xA^.cat.cat[xF^.cf.n] := true;                        // oznaci CAT
						ELSIF xA^.cat.cat[xF^.cf.n] = false THEN
							yes := false;
						END_IF;
					END_IF;
	            _Nh_Chk_DALI();															// odfiltruje len dali do kategorie	
				ELSIF cf = 2 THEN                                   				// CAT - v riadku
					yes := yes AND xF^.cat.n[cf];											// zaradi aj CAT				
				ELSIF xDev^.cf.Idx <= 0 OR xDev^.cf.Idx > aCfg[cf].rec THEN    // nie je definovany index, alebo kekorektne data,  zostava cislo vety
               xDev^.cf.Idx := nd;
            ELSIF nx <> xDev^.cf.Idx THEN
               nd          := xDev^.cf.Idx;                                      // index je ukazuje na inu vetu. nx zostane, nd bude veta kam ukazuje index
               yIdxR.dev.n := nd;                                                // defaul sa pozije cislo vety
               ok          := _NhxPt(c := cf, n := nd,x:=38);
               xDev        := xPt;
            END_IF;

				IF xL^.obj=1 THEN                                           // FAV - zoznam oblubenych
                  xFav  := xDev;
                  //                                DSH,QCK,FV
                  yes   := Yes AND  (xA^.Admin OR
                                     xFav^.cx.n <= 0 OR
                                     xFav^.cx.c = xA^.usr);   // 0=vsetkych alebo konkretny FAV k usrovi
//                                     xFav^.cx.c = xA^.fav.c);   // 0=vsetkych alebo konkretny FAV k usrovi
				END_IF;

				IF ok THEN
               // kontrola konzistencie pre ROM,ZON
               CASE cf OF
                 1 : // ROM
							_Nh_TST_ROM();
                 3 : // ZON
							_Nh_TST_ZON();
							rom := false;
                 5 : // ACT
							IF xDev^.cf.rom > INT_TO_USINT(aCfg[3].Rec) THEN
	                     xDev^.cf.rom := 1;                  // naplni sa Rom = cislo vety
							END_IF;
               END_CASE;

	            IF _Nh_Chk_DALI() THEN ;
//						rom := false;
//	            ELSIF _Nh_Chk_SCN() THEN
					END_IF;					


               IF xL^.chk THEN                                          // bude CHK, nie FAV
                  If yes THEN
                     IF _Nh_Chk_IODev() THEN
								rom := false;
							END_IF;
                     IF xL^.fvz THEN                                    // dev len s vazbou
                        yes := yes AND yIdxR.chk;
								rom := false;
                     END_IF;
                  END_IF;
               END_IF;
			
				END_IF;
				IF cf=1 OR cf=3 THEN
					xRom := xDev;

					xPtIO := ADR(xRom^.io[100]);
					_Nh_DEV_AL_VAZ(i1:=100,i2:=103 );														// oznaci al.vaz u DEV, ktore do ROM/ZON vstupuje DEV-vaz
				END_IF;

            // vo vacsine ROM podla hlavicky
            IF yes AND rom THEN
					IF  _Nh_Chk_IODev() THEN																		// otestuje ROM
						;
					ELSE
						;
					END_IF;
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
//						Yes := false;
					END_IF;
*)						
            END_IF;
            // ak je uz DEV v indexe pridane z vazieb, uz sa nepridava
            If sbj THEN
//               yes := yes AND _NhSbjOK(cf:=yIdxR.dev.c ,rom := xDev^.cf.rom);;
            END_IF;
            // ON/OFF filter
            _Nh_Chk_OFF();
            _NhCrIx(ok := yes);
         END_IF;
         nx := nx + 1;
      END_WHILE;
      ix    := ix + 1;                                                           // presunie sa na dalsie CFG
      cf    := _Nh_IxC[ix];                                                     // vybrate CFG
   END_WHILE;


	// prechadza kategorie

//	xA^.CatOk := true;

   IF xF^.cf.c = 2 THEN                                              			// do CAT v hlavicke prida aj podkategorie
		xA^.cat.cat[35] := true;																// dali
		IF xA^.CatOk = false THEN
			FOR cf := 1 TO _NH_CFG DO
				IF aCfg[cf].rec > 0 THEN
					IF yFrm_235.DevToCat[cf] <> yFrm_235.DevToCat[0] THEN  				// oznacit, ci DEV vstupuje do nejakej CAT
						FOR i := 1 TO _Nh_CAT DO
							IF yFrm_235.DevToCat[cf].n[i] THEN
		      	         xA^.cat.cat[i] := true;                                         // SEC
							END_IF;

                  END_FOR;
					END_IF;
				END_IF;
         END_FOR;
		END_IF;
   	_Nh_FRM_Read(frm:=232);
		IF xA^.CatOk = false THEN
			// oznaci CAT, ktore maju nejake DEV
			FOR cf := 1 TO _Nh_CAT DO
				IF xA^.cat.cat[cf] THEN                                       		
					IF yFrm_232.CatToCat[cf] <> yFrm_232.CatToCat[0] THEN  				// DEV sa porovna s Empty, ma jejaku CAT
						FOR i := 1 TO _Nh_CAT DO
							IF yFrm_232.CatToCat[cf].n[i] THEN
      						xA^.cat.cat[i] := true;                                         // SEC
							END_IF;
						END_FOR;
            	END_IF;
				END_IF;
			END_FOR;
		END_IF;

//      xA^.cat.cat[35] := true;


		FOR nd := 1 TO USINT_TO_INT(_Nh_CAT) DO
			yes := yFrm_232.cat[nd].txt > 0;
			IF yes = false THEN
			ELSIF	xF^.typ  < 0 THEN
				yes := yFrm_232.CatToCat[xF^.typ].n[nd] AND (xA^.cat.cat[nd] OR xF^.typ =-2) ;  // podkategorie, ktore maju nejaky DEV alebo cely setup
			ELSIF xA^.cat.cat[nd] = false THEN
				yes := false;				
			ELSIF xF^.cf.n > 0 THEN
				yes := yFrm_232.CatToCat[nd].n[xF^.cf.n];
			ELSE
				yes := false;
			END_IF;
			IF yes THEN
				CASE yFrm_232.cat[nd].rght OF                                // kto moze vidiet
    				1 :	yes := yes AND xA^.UsrRight > 0;
   	   	   2 :	yes := yes AND xA^.UsrRight > 1;
   	   	   3 :	yes := yes AND xA^.UsrRight > 2;
   	   	   9 :	yes := yes AND xA^.admin;
				END_CASE;

(*
				CASE yFrm_232.cat[nd].rght OF                                // kto moze vidiet
    				1 :	yes := yes AND xM^.set;
   	   	   2 :	yes := yes AND xA^.admin;
				END_CASE;
*)
				IF yes THEN
  					yIdxR          := _e_NH_IDX_ROW;
	   	      yIdxR.dev.c    := 2;
   	   	   yIdxR.dev.n    := nd;                                                // defaul sa pozije cislo vety
//   	      	yIdxR.dev.n    := 1;                                                // defaul sa pozije cislo vety
		   	   _NhCrIx(ok := yes);
				END_IF;
			END_IF;

	  	END_FOR;
	END_IF;

	IF xF^.dev.n[2] THEN																				// aj CAT do browsu
     	yIdxR          := _e_NH_IDX_ROW;
		yIdxR.dev.c    := 2;
		FOR i := 1 TO _Nh_CAT DO
			IF (xF^.cat.n[0] OR xF^.cat.n[i]) THEN //AND  xA^.cat.cat[i] THEN
            yIdxR.dev.n    := USINT_TO_INT(i);
			  _NhCrIx(ok := true);
			END_IF;
     	END_FOR;
	END_IF;

   IF xL^.vaz > 1 THEN                                                           // vazby, list
      _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=35);
      xDev2          := xPt;
      // pri vstupe do browsu vazieb/lst resetne priznak pre dev v hlavicke. Vazby ich v dalsom cykle vratia spat ak tam budu
      nd             := 1;
      WHILE nd  <= aVaz[xL^.vaz].Rec DO                                         // vsetky vety CFG
         yIdxR          := _e_NH_IDX_ROW;
         IF _NhxVaz(cv := xL^.vaz, nd := nd ) THEN
            yIdxR          := _e_NH_IDX_ROW;
            yIdxR.chk      := 1;
            yIdxR.nd       := nd;
           	yIdxR.in  		:= 0;
           	yIdxR.vaz  		:= 1;
			   yes            := true;
																									// SCN=3 ACT=4
            IF xVaz^.in.c = xF^.cf.c AND xVaz^.in.n = xF^.cf.n THEN     	// hlavicka IN => riadok je OUT
	            yIdxR.dev := xVaz^.ou;
	           	yIdxR.in  := 0;
		      ELSIF xVaz^.OU.c = xF^.cf.c AND xVaz^.OU.n = xF^.cf.n THEN     // hlavicka OU => riadok je IN
            	yIdxR.in  := 1;
	            yIdxR.dev := xVaz^.IN;
				ELSE
					Yes := false;
				END_IF;
(*
				CASE xL^.vaz OF
      			3:	// SCN-list
		           	yIdxR.in  		:= false;
		            yIdxR.dev 		:= xVaz^.ou;
//	   	   		xDev2^.al.lst  := 1;
						aVaz[3].ref		:= true;
//        			4: // vazby TER,TEH,LUX... -> ROM
//   	   			xDev2^.al.lst  := 1;

        			4: // vazby ACT,ALA,BLK
		           	yIdxR.in  		:= false;
		            yIdxR.dev 		:= xVaz^.ou;
//   	   			xDev2^.al.lst  := 1;

(*
      		ELSE // 2 = WSB -> DEV
						IF yes THEN
							xDev2^.al.vaz  := 1;      		
						END_IF;
)
				END_CASE;		
*)
				yes	:= yes AND xF^.dev.n[yIdxR.dev.c];

            IF xL^.fDv > 0 THEN
//               yes := yes AND xF^.dev.n[ yIdxR.dev.c ] ;                           // zapnuty fil=ter DEV
            END_IF;
            IF yes = false THEN
					;
				ELSIF xF^.rom > 0 THEN
               _NhxPt(c := yIdxR.dev.c, n := yIdxR.dev.n,x:=36);
               yes := xPt^.cf.rom = xF^.rom;                          // riadok ma ten isty rom ako hlavicka
            END_IF;
            IF yes THEN
               xPtU  := xIdx;                                           // zapamata si aktualny index
               xIdx  := xIdx1;                                          // nastavi sa na prvy index
               // hlada sa v indexe
               FOR i := 1 TO xIxB^.idx DO
                  IF xIdx^.ix[aWeb.nbr].dev.c = yIdxR.dev.c AND
                     xIdx^.ix[aWeb.nbr].dev.n = yIdxR.dev.n THEN
                     IF xIdx^.ix[aWeb.nbr].nd = 0 OR                    // tato veta nie je z vaz
                        xIdx^.ix[aWeb.nbr].nd = yIdxR.nd THEN           // je to tato ista veta
                        yes := false;
                        xIdx^.ix[aWeb.nbr].chk  := true;
                        xIdx^.ix[aWeb.nbr].vaz  := true;
                        xIdx^.ix[aWeb.nbr].in   := yIdxR.in;
                        xIdx^.ix[aWeb.nbr].nd   := yIdxR.nd;
                        EXIT;
                     END_IF;
                  END_IF;
                  xIdx := xIdx + SIZEOF(NH_IDX);
               END_FOR;
               xIdx := xPtU;                                            // vrati adresu aktualneho indexu
            END_IF;
            _NhCrIx(ok := yes);
         END_IF;
         nd := nd + 1;
      END_WHILE;
   END_IF;

   aSys.vIx2   := MAX(aSys.vIx2, aSys.vIx1 +  USINT_TO_UDINT(xIxB^.ofs) + USINT_TO_UDINT(xIxB^.idx) * SIZEOF(NH_IDX)); // najdlhsi koniec indexu
   IF aSys.vIx2 > _NH_RAM THEN // 65535 THEN
      aSys.Err_vIx2   := aSys.vIx2 - _NH_RAM;
   END_IF;

   _Nh_Brw_Idx   := xIxB^.idx > 0;                                                   // nieco nacitalo
   // vytvorit navigacne menu stranok
   IF xIxB^.idx > 0 THEN
      vr  		:= USINT_TO_REAL(xIxB^.idx) / USINT_TO_REAL(xIxB^.row.rws);				// zostane realne cislo s desatinou
		xIxB^.n	:= REAL_TO_USINT( CEIL(vr) );                                        // zaokruhli hore
      IF xIxB^.n > 1 THEN                                                           // bude vykreslovat gulicky stran
         xIxB^.w  := 40;
         xIxB^.x1 := (x2 - USINT_TO_INT(xIxB^.n-1) * 40)/2;
      ELSIF xIxB^.n > 0 THEN                                                              // bude vykreslovat gulicky stran
         xIxB^.x1 := x2/2;
      END_IF;
   END_IF;

(*
   IF xIxB^.idx > 0 THEN
      xIxB^.n  := USINT_TO_REAL(xIxB^.idx) / USINT_TO_REAL(xIxB^.row.rws);
      IF mod(xIxB^.idx,xIxB^.row.rws) > 0 THEN
         xIxB^.n  := xIxB^.n + 1;
      END_IF;
      IF xIxB^.n > 1 THEN                                                              // bude vykreslovat gulicky stran
         xIxB^.w  := 40;
         xIxB^.x1 := (x2 - USINT_TO_INT(xIxB^.n-1) * 40)/2;
      ELSIF xIxB^.n > 0 THEN                                                              // bude vykreslovat gulicky stran
         xIxB^.x1 := x2/2;
      END_IF;
   END_IF;
*)
   RETURN;
END_FUNCTION







FUNCTION _Nh_Frm_HOM {HIDDEN} : BOOL     // HOME menu
   VAR_TEMP
      brw      : bool;
      row      : USINT;
      obj      :  SINT;
      wht      :  SINT;
   END_VAR
   _Nh_Frm_HOM   := true;

//   xA^.usr     := 1;

//   _NhxUsr(u := xA^.usr);                                                 // namapuje usra

   CASE xM^.wht OF
     -1: ;

      1: // 1.kolo dolu (spat) = prekreslenie suradnic (animacia)
         xR := ADR(xB^.r[1]);
         FOR i := 1 TO 8 DO
            xR^.o.ob[i].x := _ePg0.xy[i].x;
            xR^.o.ob[i].y := REAL_TO_INT(INT_TO_REAL(_ePg0.xy[i].y)*yk);
         END_FOR;
         xA^.tch.cmd := 255;
         xM^.delay   := 50;
         xM^.wht     := -10;
         _Nh_Frm_HOM   := false;

      2: // 1.kolo hore (dalej) = prekreslenie suradnic (animacia)
         xR := ADR(xB^.r[1]);
         i := 8;
         WHILE i > 1 DO
            xR^.o.ob[i].x := _ePg0.xy[i-1].x;
            xR^.o.ob[i].y := REAL_TO_INT(INT_TO_REAL(_ePg0.xy[i-1].y)*yk);   //_ePg0.xy[i-1].y;
            i := i - 1;
         END_WHILE;
         xR^.o.ob[i].x := _ePg0.xy[8].x;
         xR^.o.ob[i].y := REAL_TO_INT(INT_TO_REAL(_ePg0.xy[8].y)*yk);   //_ePg0.xy[8].y;

         xA^.tch.cmd := 255;
         xM^.delay   := 50;
         xM^.wht     := -20;
         _Nh_Frm_HOM   := false;


     -10: // v 2.kole dolu
         IF _NhSet1Row(fnd := false, dn := true, row := xM^.ixb[0].row.rws ) THEN
            xUsr^.cx.ds1 := xL^.rw1;
         END_IF;
         brw := true;
//         wht := 25;

    -20: // v 2.kole hore
         IF _NhSet1Row(fnd := false, up := true, row := xM^.ixb[0].row.rws ) THEN
            xUsr^.cx.ds1 := xL^.rw1;
         END_IF;
         brw := true;
//         wht := 25;


      3: // dolava

      4: // doprava

     25: // nova stranka
         wht := 25;
//            _NhHomDat();

   END_CASE;


   CASE wht OF
      25:   // nacitat
//            _NhUsrPar(fav := 1, sav := 1, usr:=1 );
            xA^.fav  := xUsr^.cx.dsh;
            _Nh_Brw_Idx();
            xA^.fav  := xUsr^.cx.qck;
            _Nh_Brw_Idx(ixb := 1);
            xA^.fav  := xUsr^.cx.fav;
            brw      := true;

      1 : // dalej DASH
      2 : // spat DASH
      3 : // dalej QUICK
      4 : // spat QUICK
   ELSE     //xA^.fav := xUsr^.cx.qck;
            // _NhHomDat();
   END_CASE;

   IF brw THEN                                                    // naplni browser podla 1.row
(*
      NH_EMPTY : NH_HOM_DSH ;             // 0    rezeva
      DSH      : NH_HOM_DSH ;             // 1     DASH
      QCK      : NH_HOM_QCK ;             // 2     Quick-menu
      HOM      : NH_HOM_HOM ;             // 3     domcek s okolim
      LUP      : NH_HOM_LUP ;             // 4     objekt k DSH vlavo hore
      PUP      : NH_HOM_PUP ;             // 5     objekt k DSH vpravo hore
      LDN      : NH_HOM_LDN ;             // 6     objekt k DSH vlavo dolu
      PDN      : NH_HOM_PDN ;             // 7     objekt k DSH vpravo dolu
      WHT      : NH_HOM_WHT ;             // 8     wheater
      OTH      : NH_HOM_OTH ;             // 9     ostatne

*)
      _NheBrw( wht := 5);                                         		// vymaze data LEN brw
      _Nh_FRM_Read(frm:=11);
      xPtD  := ADR(xB^.r[9].o.ob[1].cf.n); 	      // adresa premennej USINT;
      xPtD^ := PTR_TO_UDINT(ADR(xHom^.cx.pDay));	      // adresa xPod aktualneho domceka/bytu

      IF yk > 1.0 THEN
         FOR i := 1 TO 7 DO
            xR    := ADR(xB^.r[ i ]);
            FOR jj := 0 TO _RowObr DO
               IF i=2 THEN
                  ix :=100;
               ELSE
                  ix := 70;
               END_IF;
               xR^.o.ob[jj].y := xR^.o.ob[jj].y + ix; //REAL_TO_INT( INT_TO_REAL(xR^.o.ob[jj].y) * yk );
            END_FOR;
         END_FOR;
      END_IF;
      FOR j := 0 TO 1 DO
         IF _Nh_Map_Idx(ixb := SINT_TO_USINT(j)) THEN
            ii := MIN(xIxB^.idx,xIxB^.row.rws);
            IF j = 0 THEN                                            // DASH
               xR := ADR(xB^.r[ 1 ]);
               xL^.rw1  := xUsr^.cx.ds1;                             // nacita poslene zapamatany 1.DEV pre aktualneho usra
               IF _NhSet1Row(ixb := 0 ) THEN
                  xUsr^.cx.ds1 := xL^.rw1;                           // zapamata si novy, alebo povodny DEV
               END_IF;
            ELSE                                                     // QUICK
               xR := ADR(xB^.r[ 2 ]);
               xL^.rw1  := xUsr^.cx.qc1;                             // nacita poslene zapamatany 1.DEV pre aktualneho usra
               IF _NhSet1Row(ixb := 1 ) THEN
                  xUsr^.cx.qc1 := xL^.rw1;                           // zapamata si novy, alebo povodny DEV
               END_IF;
            END_IF;
            xIxB^.ix1 := 1;
            xIxB^.ix2 := 0;
            FOR i := 1 TO ii DO
               xR^.o.ob[i].cf := xIdx^.ix[aWeb.nbr].dev;
               cf := xR^.o.ob[i].cf.c;
               IF cf =  2 THEN                  xR^.o.ob[i].wh := 232;     // obrazok z CAT-stat
               ELSE                             xR^.o.ob[i].wh := 233;     // obrazok z DEV / sekcie QCK
               END_IF;
               xIxB^.ix2      := xIxB^.ix2 + 1;
               xIdx           := xIdx + SIZEOF(NH_IDX);
            END_FOR;
         ELSE
            xIxB^.ix1 := 0;
            xIxB^.ix2 := 0;
         END_IF;
      END_FOR;
      xL^.rw1  := xUsr^.cx.ds1;                             // zapamatany DEV v 1.riadku pre usra
   END_IF;

   GC_Begin(GrData := xCan);
//   aSys.cnt    := aSys.cnt + 1;
   row := 1;
   WHILE row <= _RowBrw DO
      xR := ADR(xB^.r[ row  ]);
      IF true THEN //xR^.h.nd > 0 THEN
         obj := 0;
         WHILE obj <= _RowObr DO
            IF xR^.o.ob[obj].wh > 0 THEN
               IF xL^.obj = 0 THEN										// home page
                 	_NhxCfg(c := xF^.cf.c, n := xF^.cf.n, x:=43);                     // xDev,xCfg,xPar pre aktualny riadok
					ELSIF xR^.o.ob[obj].cf.c = 2 OR xR^.o.ob[obj].wh = 107 THEN
						;
               ELSIF xR^.o.ob[obj].cf.c > 0 AND xR^.o.ob[obj].cf.n > 0 THEN
                  _NhxCfg(c := xR^.o.ob[obj].cf.c, n := xR^.o.ob[obj].cf.n,x:=43);                     // xDev,xCfg,xPar pre aktualny riadok
               ELSIF row = 1 THEN
						;
               END_IF;
               _Nh_Shw_Obj(row:=row, obj := obj);                       // zobrazi 1.objekt a necha namapovane xO
            END_IF;
            obj := obj + 1;
         END_WHILE;
      END_IF;
      row := row + 1;
   END_WHILE;

   _NhShwMnu();
   GC_End(GrData := xCan);



END_FUNCTION


{ $ END_IF }
