{ $IFDEF __NH_EXP }


(*
VAR_GLOBAL
	yWSBx	: NH_WSB;
	yTxXa	: STRING[255];
	yTxXb	: STRING[255];
END_VAR
*)

(*                                                                          (*
   - ROM - zmena typu miestnosti - do IO pridat za nazov typ  0=vnutorna,1=vonkajsia,2=suteren
   - TVE zmena hw.d[1] n ad[0], do d[1] sa zapisuje TECO ventil stat
         xTvTecoIn := UDINT_TO_PTR(xTve^.hw.d[1]);          // VSTAT musi mat teraz 'Q' lebo sa zapisuje do d.[1], predtym bolo hw.d[0]
         xTvTecoOu := xPtB;                  // VCONT
   - WSB,TLA d[0] bola led, teraz je d[1] 'Q',  teraz je d[0] btn d[1] LED
   - WSB - preverit LEdNbr - nezapisuje sa teraz, LED nebudu dobre
   - TGL zmenili sa adresy d[1] <-> d[0]
*)

(*
VAR_GLOBAL CONSTANT
                           //123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
                           //PIR;1;   ;   0;   ;  0;   ;Vonku               ; ;0;X02   ;         ;         ;         ;         ;         ;         ;
   // yTx1 :=               'CFG;D;IDX;-123;rID;ROM;SBJ;Name                ;B;I;ID    ;         ;         ;         ;         ;         ;         ;$r$n';   // LEN=52
   _ExpRow {HIDDEN} : STRING[119] :=   '   ;1;   ;    ;   ;  0;   ;                    ; ; ;      ;         ;         ;         ;         ;         ;         ;';
   _ExpDev {HIDDEN} :  ARRAY[0..12,0..1] OF USINT :=
                  [  1,121,      // 0 dlzka celej vety aj s CR pre zapis. pre citanie je len 116 (bez vozika)
                    11,  4,      // 1 typ
                    20,  3,      // 2 rom - Rec
                    24,  3,      // 3 SBJ
                    28, 20,      // 4 Name
                    53,  6,      // 5 ID
                    60,  9,      // 6 HW0. Dalsie HW sa vypocita +10
                    16,  3,      // 7 RomID
                     5,  1,      // 8 del
                    51,  1,      // 9 INV
                    49,  1,      //10 blk
                     7,  3,      //11 IDX
                     1,  3       //12 CFG
                  ];
END_VAR
*)
(*
TYPE
   NH_EXP_RAM		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK := (ok:=true);
      cf          : NH_CFG_ALL;
		hw				: NH_DEV_HW5;                     // zakladna adresa HW
      c           : USINT;
      cfg         : STRING[3];
      RomID       : STRING[3];                  // ROM z exportu
	END_STRUCT;
  	NH_IMP_EXP_WRK   {HIDDEN}  :   STRUCT 			    //  strura importu z prebrateho exportu 'NH2.ADR'
      cfg         : STRING[3] ;
  		typ			: string[1] ;
      typRom      : SINT;
      Rom         : USINT;                   // cislo rom
//      ID          : STRING[6] ;              // nacitane z exportu
      ///***10.11.22
      ID          : STRING[5] ;              // nacitane z exportu

      RomID       : STRING[ 3 ] ;
      Name        : STRING[20];
      HW          : UDINT;                   // jedna adresa
      HWs         : STRING[10];
      IO          : STRING[1];               // I=vstup, Q=vystup
      MEM         : STRING[1];               // 0=BOOL,1=REAL,
      yTx         : STRING;
	END_STRUCT;
END_TYPE

VAR_GLOBAL
      yEx1     {HIDDEN} : NH_EXP_RAM;

      yExp     {HIDDEN} AT mRam[_Ram0]   : ARRAY[1..100] OF NH_EXP_RAM;

      xExp     {HIDDEN} : PTR_TO NH_EXP_RAM;                   // len adresa pointra

      xRwa     {HIDDEN} : PTR_TO NH_IMP_EXP_WRK;
      w1       {HIDDEN} :  STRING[10];
      Base0    {HIDDEN} : UDINT;
      xHw      {HIDDEN} : PTR_TO NH_DEV_HW5;
      yRwa     : NH_IMP_EXP_WRK;
//   ok43  : BOOL;
//   sz43  : UDINT := 22222;

END_VAR
*)
(*
FUNCTION _Nh_EXP_HW  {HIDDEN}  : BOOL
   VAR_INPUT
      MapHw     : BOOL;
   END_VAR
   IF aCfg[cf].hw > 3 THEN
      IF MapHw THEN
         xHw := xPt + 1 + USINT_TO_UDINT(aCfg[cf].cf) + USINT_TO_UDINT(aCfg[cf].al) + aCfg[cf].cx;        // posun o to co je v DBX
      END_IF;
      FOR ii := 0 TO (aCfg[cf].hw / 4) - 1 DO
         xRwa^.yTx      := UDINT_TO_STRINGF(xHw^.d[ii], '%9d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[6,1] ,_ExpDev[6,0] + (ii * 10)   );
      END_FOR;
   END_IF;
END_FUNCTION


FUNCTION _Nh_EXP_DATA  {HIDDEN}  : BOOL
   VAR_INPUT
      MapHw       : BOOL := true;
      wht         : USINT;
   END_VAR
   _Nh_EXP_DATA   := true;
   CASE wht OF
     0 : //
         memset(val := 0, length := SIZEOF(yEx1), dest := VOID(yEx1));
         yEx1           := xExp^;
         yEx1.ok.ok     := true;

     1 : // z namapovanej vety v RAM do yTx2
         yTx2           :=_ExpRow; // CONCAT(_ExpRow,'$r$n');                                                 // prazdna maska

         xRwa^.yTx      := BOOL_TO_STRING(xPt^.ok.Ok);
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[8,1] ,_ExpDev[8,0]);
         xRwa^.yTx      := SINT_TO_STRINGF(xPt^.cf.Typ,'%4d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[1,1] ,_ExpDev[1,0]);
         xRwa^.yTx      := USINT_TO_STRINGF(xPt^.cf.Rom,'%3d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[2,1] ,_ExpDev[2,0]);
         xRwa^.yTx      := USINT_TO_STRINGF(xPt^.cf.cat,'%3d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[3,1] ,_ExpDev[3,0]);
         xRwa^.yTx      := xPt^.cf.Name;
         aBlank(txt := ADR(xRwa^.yTx), n := USINT_TO_INT(_ExpDev[4,1]));
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[4,1] ,_ExpDev[4,0]);
         xRwa^.yTx      := xPt^.cf.ID;
         aBlank(txt := ADR(xRwa^.yTx), n := USINT_TO_INT(_ExpDev[5,1]));
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[5,1] ,_ExpDev[5,0]);
         xRwa^.yTx      := BOOL_TO_STRING(xPt^.cf.Blk);
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[10,1] ,_ExpDev[10,0]);
         xRwa^.yTx      := BOOL_TO_STRING(xPt^.cf.Inv);
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[9,1] ,_ExpDev[9,0]);

         // prirobene 7.10.22
         yTx2        := REPLACE(yTx2,aCfg[cf].cfg,_ExpDev[12,1] ,_ExpDev[12,0]);

         _Nh_EXP_HW( MapHw := MapHw);

   END_CASE;
END_FUNCTION

FUNCTION _Nh_EXP_Find_ID {HIDDEN}   : INT
   VAR_INPUT
      Del   : BOOL := true;
      ID    : STRING[5];
   END_VAR
   _Nh_Exp_find_ID   := 0;
   ix                := 0;                        // ak sa najde cista del veta
   FOR nd := 1  TO aCfg[cf].rec DO
      _NhxPt(c := cf, n := nd,x:=3);
      IF xPt^.cf.ID = ID AND _Nh_Exp_find_ID = 0 THEN
         xPt^.ok.ok        := true;

			////???? 6.7.2023 - ak uz predtym bola tato veta, mohol uzivatel prestavit INV, tak sa zoberie co tam je
			yEx1.cf.inv := xPt^.cf.inv;

         xDev2  := xPt;
         _Nh_Exp_find_ID := nd;
         IF del = false THEN
            RETURN;
         END_IF;
      END_IF;
      IF ix = 0 AND xPt^.cf.ID = '' THEN
         ix    := nd;
         xDel  := xPt;
      END_IF;
   END_FOR;
   IF _Nh_Exp_find_ID = 0 AND del THEN
      If ix > 0 THEN
         xPt               := xDel;
         xPt^.cf           := yEx1.cf;                  // do cistej vety sa preberu vsetky dostupne udaje
         xPt^.ok.ok        := true;                     // v yTx1 bude ok false
         _Nh_Exp_find_ID   := ix;
      END_IF;
   ELSIF _Nh_Exp_find_ID > 0 THEN
      xPt := xDev2;
   END_IF;
END_FUNCTION
*)

(*
FUNCTION_BLOCK _Nh_EXP_ALL	    // z existujuceho suboru .EXP vytvori uplne novy .ADR,
   VAR_INPUT
		IniDone	: USINT := 210;
   END_VAR
   VAR
      rom      : BOOL;
      data     : BOOL;
      go       : USINT;
      mxRW     : UDINT := 1000;
      nExp     : INT;
      nBck     : USINT;
      ie       : USINT;
   END_VAR

   CASE go OF
     0 : // Start
         yTx2     := '_Nh_EXP_ALL  0: Start';
         _Nh1RowTxt(logRst:=1);
         cf    	:= 0;
         Go    	:= 20;

    20 : // rozhodne o aktualizacii HW
         IF aSys.ActHWA = false THEN
            yTx2     := '_Nh_EXP_ALL 20: Nevyzaduje sa aktualizacia HW-adries (aSys.ActHWA = false)';
            _Nh1RowTxt(logRst:=1);
            Go :=    99;
         ELSE
            Go :=    50;
         END_IF;

    50 : // otvori sa exportny subor, nastartuje hladanie najskor ROM
         yTx1  := _Nh_EXP;                                                    //'NH2.EXP';
         va    := _NH_RAM - _Ram0;
         memsetEx(val := 0, length := va, dest := VOID(mRam[_Ram0]));  // pouzije yTx1-yTx2 na cistu oblast, v ktorej vymaze 999b

         IF _NhFopen(fH := fh, fN := yTx1) THEN
            fP       := 0;                                                    // nastavi sa na zaciatok exportu
            Go       := 52;
            yTx2     := CONCAT('_Nh_EXP_ALL 50: Otvoreny subor exportu: ',yTx1);
         ELSE
            yTx2     := CONCAT('_Nh_EXP_ALL 50: NENAJDENY subor exportu: ',yTx1);
            Go       := 98;
         END_IF;
         _Nh1RowTxt(logRst:=1);
			RETURN;

    51 : // vyhodnoti exportnu vetu z NH2.EXP, najde v docasnej pamati a modifikuje, alebo prida v docasneh pamati od _Ram0

         xExp  := ADR(mRam[_Ram0]);
         FOR  ix := 1 TO nExp DO
            IF xExp^.CFG = xRwa^.CFG AND xExp^.cf.ID = xRwa^.ID THEN
               Exit;
            END_IF;
            xExp := xExp + SIZEOF(NH_EXP_RAM);
         END_FOR;
         IF ix > nExp THEN
            aCfg[cf].NewExp := true;                                          // tot cfg treba aktualizovat
            nExp        := ix;
            xExp^.ok.ok := true;
            xExp^.c     := cf;
            xExp^.cfg   := aCfg[cf].cfg;
            xExp^.cf.ID := xRwa^.ID;
         END_IF;
         IF xExp^.c = 1 THEN
            xExp^.romID   := xRwa^.ID;
         ELSIF xExp^.romID = '' AND xRwa^.romID <> '' THEN
            xExp^.romID   := xRwa^.romID;
         END_IF;
         IF xExp^.cf.Name = '' AND xRwa^.Name <> '' THEN
            xExp^.cf.Name  := xRwa^.Name;
         END_IF;
         ok       := false;                              // typ sa prepise tym co je v j
         j        := STRING_TO_SINT(xRwa^.typ);
         i        := 0;                                  // poradie HW adresy
         IF cf <> 1 THEN                                    // je DEV - najde odpoverajuci ROM
            // xRwa^.RomNbr   := INT_TO_USINT(_Nh_EXP_FIND_ID_RAM(c := 1, ID := xRwa^.ROM ));
         END_IF;
         IF cf = 1 OR cf = 3 OR xExp^.cf.DevExt THEN                            // ROM
            i  := 255;
            j  := xRwa^.TypRom;
            IF j > 10 OR j < 0 THEN
               j  := 0;
            END_IF;
				CASE j OF
              1 : xExp^.cf.Rom   := 3;                           //
              2 : xExp^.cf.Rom   := 2;                           //
            ELSE xExp^.cf.Rom    := 1;                           //
            END_CASE;
            IF aSys.NewDbx THEN
					CASE j OF
   	           1 : xExp^.cf.Rom   := 3;                           //
      	        2 : xExp^.cf.Rom   := 2;                           //
         	   ELSE xExp^.cf.Rom    := 1;                           //
            	END_CASE;
            END_IF;
				xExp^.cf.Rom := MAX(1,xExp^.cf.Rom);
            ok             := true;
         ELSIF xRwa^.typ   = 'Q' THEN                    // vystup d[0]
            i := 1;
         ELSIF xRwa^.typ   = 'Y' THEN                    // vystup d[2]
            i := 2;
         ELSIF xRwa^.typ   = 'R' THEN							
            ;
         ELSIF xRwa^.typ   = 'G' THEN
            i  := 1;
         ELSIF xRwa^.typ   = 'B' THEN
            i := 2;
         ELSIF xRwa^.typ   = 'W' THEN                    // WW
            i := 3;
         ELSIF xRwa^.typ   = 'C' THEN                    // CW
            i := 5;
         ELSIF xRwa^.typ   = 'U' THEN                    // ROL-up
               ;
         ELSIF xRwa^.typ   = 'D' THEN                    // ROL-Dn
            i  := 1;
         ELSIF xRwa^.cfg   = 'TLA' THEN                  // tlacitko bude mat typ najvacsi
            IF j = 0 THEN                                // jednotlacitko nemusi mat sufix
               j := 1;
            END_IF;
            xExp^.cf.typ   := MAX(xExp^.cf.typ, j );
				i := SINT_TO_USINT(j-1);
         ELSE  ok := true;
               CASE cf OF
                   21 :    // ZAS
                     IF j = 1 THEN                                                      // zapni = vypni (inverzia),
                        xExp^.cf.inv := true;
								ok				 := false;		                                     // nema vplyv na typ, urcuje sa v SW
                     END_IF;
                   15 :    // PIR
                     IF j = 0 THEN                                                      // zapni = vypni (inverzia)
                        xExp^.cf.inv := true;                                           // signal pri rozopnuti
                     END_IF;
                    8 : ;  //TVE
						
                   23 : ;  //REK

                  END_CASE;
         END_IF;
         IF i < 255 THEN
				IF xRwa^.MEM = 'R' THEN														// z exportu sa samo oznaci podla typu premennej R/B
	            xExp^.hw.typ := 1;                                				// 0=bool,1=real
				END_IF;
          	xExp^.hw.d[i] := xRwa^.hw;                                		// HW adresy
         END_IF;
         If ok THEN
            xExp^.cf.typ := j;                                             // typ
         END_IF;
         Go := 52;
			RETURN;

    52 : // prechadza exportny subor
         WHILE _NhRowTxtNext() DO
            j := FIND(yTx1,' AT %');
            IF j > 0 THEN                                                     // len veta, ktora ma adresu
               yTx3  := LEFT(yTx1,3);
               cf    := _NhGetCFG(cfg := yTx3);                               // zisti ci mame taketo dev
               ok    := false;
               IF cf = 0 THEN ;                                               // nezname CFG
						;
               ELSIF acfg[cf].imp OR cf=1 THEN                      				// toto DEV sa importuje
                  yTx3 := yTx1;
                  va    := _NH_RAM - SIZEOF(NH_IMP_EXP_WRK);                  // uplne na konci RAM
                  xRwa  := ADR(mRam[ va ]);
                  memset(val := 0, length := SIZEOF(NH_IMP_EXP_WRK), dest := VOID(mRam[va]));  // pouzije yTx1-yTx2 na cistu oblast, v ktorej vymaze 999b
                  xRwa^.CFG   := MID(yTx1,3,1);
                  xRwa^.ID    := MID(yTx1,3,5); STRING_TO_UPPER(xRwa^.ID);
                  xRwa^.yTx   := MID(yTx1,5,8); STRING_TO_UPPER(xRwa^.yTx);
                  IF xRwa^.yTx = ' AT %' THEN                                 // nema priponu
                     xRwa^.TYP   := ' ';
                  ELSE
                     xRwa^.TYP   := MID(xRwa^.yTx,1,2);
                  END_IF;
                  IF xRwa^.ID <> 'ROM' THEN                                   // ROM nema adresu
                     // podla typu premennej sa ulozi zdresa oblasi
                     IF 	FIND(yTx1,'%QB') > 0 THEN        // vystup
                              xRwa^.IO   := 'Q';
                           {asm}
                              LEA %Y0
                              WR  Base0
            	  	         {end_asm}
                     ELSIF 	FIND(yTx1,'%IB') > 0 THEN        // vstup
                           xRwa^.IO   := 'I';
                           {asm}
          	                  LEA %X0
                              WR  Base0
                           {end_asm}
                     ELSIF 	FIND(yTx1,'%MB') > 0 THEN        // pamat
                           xRwa^.IO   := 'M';
                           {asm}
                        	  LEA %R0
                        	  WR  Base0
                           {end_asm}
//Base0 := 0;
                     END_IF;	
                     j     := FIND(yTx1,'AT %');                       // 'WSB_101_4 AT %IB486.0 : BOOL;
                     yTx1  := DELETE(yTx1,j+5,1);                      // '486.0 : BOOL;
                     j     := FIND(yTx1,' : ');
                     yTx3  := MID(yTx1,j-1,1);                         // '486.0'
                     j     := FIND(yTx3,'.');
                     IF j > 0 THEN                                      // yTx3    '172.3'
                           xRwa^.MEM   := 'B';
                           w1    := MID(yTx3,j-1,1);                    // '172'
                           yTx3  := DELETE(yTx3,j,1);                   // '3 :'
                           sz    := (Base0 + STRING_TO_UDINT( w1 ) ) * 8 + STRING_TO_UDINT( yTx3 );
                     ELSE
                           xRwa^.MEM   := 'R';
                           sz := Base0 + STRING_TO_UDINT(yTx3);         // '172'
                     END_IF;
                     xRwa^.HW   := sz;
                  END_IF;
                  // nazov, miestnost
                  j := FIND(yTx1,'(*');                     // zaciatok poznamky
                  IF j > 0 THEN
                     yTx1  := DELETE(yTx1,j+2,1);           // odreze zaciatok a zostane : ' nazov DEV ; rom ; nazov miestnosti
                     j     := FIND(yTx1,' )');
(*
                                  // koniec poznamky
                     yTx1  := DELETE(yTx1,3,j-1);           // odreze koniec
                     j := FIND(yTx1,';');                   // za nazvom je cislo miestnosti
                     IF j > 0 THEN
                        xRwa^.Name := MID(yTx1,j-1,1);      // zapise nazov
                        yTx1        := DELETE(yTx1,j,1);    // odreze zaciatok a zostane : 'nazov miestnosti '
                        IF xRwa^.cfg = 'ROM' OR xRwa^.cfg = 'ZON' THEN
                           xRwa^.TypRom   := STRING_TO_SINT(yTx1);      // pripadny typ ROM -1=nezaradene
                           xRwa^.RomID    := xRwa^.ID;          // co zostalo je ROM
                        ELSE
                           xRwa^.RomID  := yTx1;              // co zostalo je ROM
                        END_IF;
                     ELSE
                        xRwa^.Name  := yTx1;                   // cely zbytok stringu je nazov
                     END_IF;     // koniec hladania nazvu
                     aTrim(txt := ADR(xRwa^.Name), wht := 1);        // zo vsetkych stran odstrani medzewry
                  END_IF;
                  Go    := 51 ;
                  RETURN;
               END_IF;
            END_IF;
         END_WHILE;
         rb    := _NhFclose(fh := fh);                                        // zavrie exportny subor, uvolni fH
         yTx2     := CONCAT('_Nh_EXP_ALL 52: Export spracovany. Najdene CFG: ',INT_TO_STRING(nExp));
         _Nh1RowTxt(logRst:=1);

         cf             := 1;          // zacina ROM
         nd             := 1;          // zaciatok exportu
         aCfg[cf].rExp  := 0;
         aCfg[cf].new   := 0;
         xExp           := ADR(mRam[_Ram0]);

			 _Nh_Log_Path(wh:=4,fN:='EXP');
         aSys.frw.FN    := CONCAT(yTx2, 'a.REC');               // nazov noveho suboru
         rb             := FileDelete(fileName := aSys.frw.FN);
			_Nh_Log_Path(wh:=4,fN:='EXP');

			aSys.frw.FN    := CONCAT(yTx2, 'NH2.ADR');               // nazov noveho suboru
         rb             := FileDelete(fileName := aSys.frw.FN);
         aSys.frw.FN    := CONCAT(yTx2, 'NH2.SRT');               // nazov noveho suboru
         rb             := FileDelete(fileName := aSys.frw.FN);
         Go             := 60;


			RETURN;

    60 : // sortuje vety exportu pre rovnake CFG a vytvara NH2.ADR, pocita nove vety. prva je rom
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW DO
            IF xExp^.ok.ok THEN
               IF cf = 0 THEN
                  cf             := xExp^.c;
                  aCfg[cf].rExp  := 0;
                  aCfg[cf].new   := 0;
               END_IF;
               IF xExp^.c = cf THEN
                  xExp^.ok.ok       := false;                                       // oznaci za spracovanu
                  _Nhfrw(mode := 2, fW := xExp,  sz := SIZEOF(NH_EXP_RAM), row := false);
               END_IF;
            END_IF;
            xExp  := xExp + SIZEOF(NH_EXP_RAM);
            nd    := nd + 1;
            IF nd > nExp THEN
               IF cf = 0 THEN                                        // vsetky Cf , ktore su v exporte boli spracovane
                  yTx2  := '_Nh_EXP_ALL 60: Export zosortovany';
                  _Nh1RowTxt(logRst:=1);
                  _NhFclose(fh := aSys.frw.fH);
                  Go    := 62;
               ELSE
                  cf       := 0;
                  nd       := 1;
                  xExp     := ADR(mRam[_Ram0]);                                     // od prvej exportnej vety
               END_IF;
					RETURN;
            END_IF;
         END_WHILE;

     62 : // prvykrat obnovi DBX->RAM bez pridania viet , v DBX uz budu urcite dobre data, lebo ich vytvorila INI procedura
	         yTx2  := '_Nh_EXP_ALL 62: Vrati DBX->RAM po spracovani exportu';
   	      _Nh1RowTxt(logRst:=1);
      	   _Nh_Go_DbxToMem(dbx := false);
				go          := 63;

     63 : // oznaci za vymazane vsetky vety , ktore maju priznak import, teda budu naexportovane
         yTx2  := '_Nh_EXP_ALL 63: Oznaci DEL vety aCfg[cf].imp ';
         _Nh1RowTxt(logRst:=1);
			FOR cf := 1 TO _Nh_CFG DO
				IF aCfg[cf].imp THEN
					FOR nd := 1 TO aCfg[cf].rec DO
						_NhxPt(c:=cf, n:=nd ,x:=73);
						xPt^.ok.ok := false;
   	         END_FOR;
      		END_IF;
         END_FOR;
         go          := 64;
         nExp        := 0;
         aSys.frw.fP := BEGIN_POS;                 // dolezite nastavit na zaciatok
			RETURN;

     64 : // cita vety z exportu, hlada ju v RAM
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW * 10 DO
            nExp := nExp + 1;
            sz := SIZEOF(NH_EXP_RAM);
            IF _Nhfrw(mode := 0, fW := ADR(yEx1),  sz := sz, row := false)  THEN
               cf := yEx1.c   ;
               xPt := ADR(yEx1);
                  _Nh_Log_Path(wh:=4,fN:='EXP');
               yTx1 := CONCAT(yTx2,'a.REC');             // subor vsetkych exportovanych DEV = to iste co je
               xHw  := ADR(yEx1.hw);
               _Nh_EXP_DATA( wht := 1, MapHw := 0);             // naplni z realnej vety RAM -> yTx2
               _Nh1RowTxt();
               IF _Nh_Exp_find_ID(ID := yEx1.cf.ID) = 0 THEN
                  aCfg[cf].new := aCfg[cf].new + 1;
					END_IF;
            ELSE
               _NhFclose(fh := aSys.frw.fH);
               Go := 66;
               RETURN;
            END_IF;
         END_WHILE;

     66 : // zalohuje modifikacie ID, a spat obnovi DBX->RAM a prida nove vety



         yTx2  := '_Nh_EXP_ALL 66: RAM->DBX , DBX->RAM prida nove vety ';
         _Nh1RowTxt(logRst:=1);



         _Nh_Go_DbxToMem(ForceRamOk := true, dbx := false);


// aSys.Ini := 217;
//	RETURN;



         go          := 70;
         aSys.frw.fP := BEGIN_POS;                 // dolezite nastavit na zaciatok
         yTx2     := '_Nh_EXP_ALL 66: Zacina Update ROM.';
         _Nh1RowTxt(logRst:=1);
         nExp  := 0;

    70 : // prechadza NH2.SRT , najskor len ROM
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW * 2 DO
            IF _Nhfrw(mode := 0, fW := ADR(yEx1),  sz := SIZEOF(NH_EXP_RAM), row := false)  THEN
               IF yEx1.c <> 1 THEN
                  aSys.frw.fP := aSys.frw.fP - aSys.frw.fR;
                  yTx2     := CONCAT('_Nh_EXP_ALL 70: Koniec Update ROM. n: ',INT_TO_STRINGF(ix,'%3d'));
                  _Nh1RowTxt(logRst:=1);
                  Go := 71;
                  RETURN;
               ELSE
                  nExp := nExp + 1;
               END_IF;
               cf    := yEx1.c;
               nd    := _Nh_Exp_find_ID(ID := yEx1.cf.ID);                                   // vzdy najskor hlada ROM
               IF nd > 0 THEN             // nasla sa veta s ID, alebo cista DEL-veta do ktorej sa prave zapisalo ID
//                  xPt^.cf := yEx1.cf;
                  xPt^.cf.typ := yEx1.cf.typ;
                  IF xPt^.cf.Name = '' THEN                                         // prazdny nazov sa pokusi nahrdit
                     xPt^.cf.Name := yEx1.cf.Name;
                  END_IF;
                  IF xPt^.cf.Rom <= 1 THEN                                         // prazdny nazov sa pokusi nahrdit
                     xPt^.cf.Rom := MAX(1, yEx1.cf.rom);
                  END_IF;
                  xPt^.ok.ok := true;                                                     // kazda vz exportu bude platna
               ELSE                                                                    // nesmie byt
                  yTx2     := CONCAT('_Nh_EXP_ALL 70: ERR!!! Nenaslo sa CFG,ID;ix: ',yEx1.CFG,';',yEx1.cf.ID,';',INT_TO_STRINGF(ix,'%3d'));
                  _Nh1RowTxt(logRst:=1);

			// ak bude problem zostane v 2177
         aSys.Ini := 217;
			RETURN;

               END_IF;
            ELSE                                                                 // vsetky vety NH2.ADR prejdene, xDEV aktualizovane
               Go := 98;
               RETURN;
            END_IF;
         END_WHILE;

    71 : // prechadza NH2.SRT pre ostatne DEV ako ROM
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW DO
            IF _Nhfrw(mode := 0, fW := ADR(yEx1),  sz := SIZEOF(NH_EXP_RAM), row := false)  THEN
               cf    := yEx1.c;
               nd := _Nh_Exp_find_ID(ID := yEx1.cf.ID);                                  // teraz sa hlada veta DEV

               IF nd > 0 THEN             // nasla sa veta s ID, alebo cista DEL-veta do ktorej sa prave zapisalo ID aj cele .cf
                  IF xPt^.cf.Name = '' THEN                                         // prazdny nazov sa pokusi nahrdit
                     xPt^.cf.Name := yEx1.cf.Name;
                  END_IF;
                  xPt^.cf.typ := yEx1.cf.typ;                                     // ?? Typ by mal byt urceny uz v IO manazeri
                  xPt^.cf.inv := yEx1.cf.inv;                                     // INV je dolezite u PIR,ZAS,TVE

                  // aktualizuju sa HW adresy
                  xHw   := xPt + 1 + USINT_TO_UDINT( aCfg[cf].cf) + USINT_TO_UDINT(aCfg[cf].al) + aCfg[cf].cx;
                  jj    := USINT_TO_SINT(aCfg[cf].hw) / 4 - 1 ;                           // pocet HW-adries  1=0, lebo sa zadina d.[0]

                  xHw^.typ :=  yEx1.hw.typ;
                  xHw^.cfg :=  yEx1.hw.cfg;
                  FOR j := 0 TO jj DO
                     xHw^.d[j] :=  yEx1.hw.d[j];
                  END_FOR;
                  xPt^.ok.ok  := true;                                              // kazda vz exportu bude platna
                  xDev        := xPt;
                  // nakoniec najde ROM. POZOR !!! zmeni sa CF, ale uz sa dalej nebude potrebovat
                  IF xPt^.cf.rom = 0 THEN                                         // prazdny nazov sa pokusi nahrdit
                     cf    := 1;
                     xDev^.cf.Rom := INT_TO_USINT(_Nh_Exp_find_ID(ID := yEx1.RomID, del := false)); // len sa najde cislo rom
                  END_IF;
               ELSE                                                                // nesmie byt
                  yTx2     := CONCAT('_Nh_EXP_ALL 71: ERR!!! Nenaslo sa CFG,ID;ix: ',yEx1.CFG,';',yEx1.cf.ID,';',INT_TO_STRINGF(ix,'%3d'));
                  _Nh1RowTxt(logRst:=1);

			// ak bude problem zostane v 2177
//         aSys.Ini := 217;
//			RETURN;

               END_IF;
            ELSE                                                                 // vsetky vety NH2.ADR prejdene, xDEV aktualizovane
               Go := 98;
               RETURN;
            END_IF;
         END_WHILE;

    90 : // cakacka pre ladenie
         aSys.Ini := 217;

    98 : // zatvori subory
         yTx2     := '_Nh_EXP_ALL 98: Koniec exportu.';
         _Nh1RowTxt(logRst:=1);
         _NhCloseAllFiles();
         Go       := 99;
    99 : // koniec
         _Nh_Go_MemToDBX();                               // ulozi aj s novymi adresami
         go       := 0;
         aSys.Ini := IniDone;
   END_CASE;
END_FUNCTION_BLOCK
*)



// ****************** EXP ******





{ $ END_IF  } 	


