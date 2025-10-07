{ $ IFDEF __NH_WEB }

FUNCTION _NhSetObjDsh   {HIDDEN}  : BOOL        // zobrazi Day a sumrk pre ROM,ZON,PIR
   VAR_INPUT
      grp      : USINT;
//      row      : USINT;
   END_VAR
   VAR_TEMP
      sld6     : BOOL := true;
   END_VAR
   _NhSetObjDsh := true;
   _NhxDev(c := xR^.h.cf.c, n := xR^.h.cf.n, x:=12 );
   CASE grp OF
		0 : ;
   ELSE	;

   END_CASE;
   If sld6 THEN
      IF xL^.dsh > 1 THEN                                            // posunut browser namiesto FAV
         xR^.o.ob[6].x     := xR^.o.ob[5].x ;
         xR^.o.ob[6].w     := 150 ;
         xR^.o.ob[5].x     := xR^.o.ob[3].x ;                        //
         xR^.o.ob[3].wh    := 0;                                     // FAV sa nevykonava
         xR^.o.ob[4].wh    := 0;                                     // FAV sa nevykonava
      END_IF;
      IF xL^.dsh = 3 THEN                                            // najmensi dash nema slider
//         xR^.o.ob[6].wh    := 0 ;
      END_IF;
   END_IF;

END_FUNCTION

FUNCTION _NhShwDay   {HIDDEN}  : BOOL                 // zobrazi Day a sumrk pre ROM,ZON,PIR
   VAR_INPUT
      rom   : BOOL := true;               // dalsi nastavenia pre ROM
//      day   : BOOL ;                      // zobrazi aj slniecko =den
      cf    : USINT := 1;
      nr    : USINT;

   END_VAR
   _NhShwDay := false;
   IF nr = 0 THEN                         // nepriradene cislo miestnosti
      xR^.o.ob[ 2].wh   :=  0;
//      xR^.ob[ 4].cm   := 22;
      xR^.o.ob[ 9].cm   := 6;
      xR^.o.ob[ 9].cf.c := 0;
      xR^.o.ob[ 9].cf.n := 359;
      xR^.o.ob[10].cf.c := 0;
      xR^.o.ob[10].cf.n := 358;


      RETURN;

   END_IF;

   _NhxPt(c := cf, n := USINT_TO_INT(nr),x:=44); xRom := xPt;
   // zobrazenie sumraku vlavo hore nad ikonou
(*
   IF xRom^.cx.Dark THEN
      _NhSetObjBrw(wh:=4, ob:=7, w := xR^.o.ob[7].w, h:= xR^.o.ob[7].w, o1 := USINT_TO_INT(_NhListObr.Dark[1]), c:=1 ,n:=1, cm := 200, vb := adr(vr)  );
   END_IF;
   // zobrazenie DayObr vpravo hore nad ikonou
   IF xRom^.cx.DayObr > 0 OR day THEN
      _NhSetObjBrw(wh:=4, ob:=8,  w := xR^.o.ob[8].w, h:= xR^.o.ob[8].w, o1 := USINT_TO_INT(_NhListObr.Day[1,xRom^.me.DayObr]), c:=1 ,n:=1, cm := 200, vb := adr(vr)  );
   END_IF;
*)
(*  ///???

   IF rom THEN
      IF  xL^.psn THEN                                         // nadefinuje zobrazenie LOCK btn
         ok := 0;
         IF xRoW^.stat > 4 THEN
            i := 7; ix := 94; z:= 80;                         // Alarm
         ELSIF xRoW^.Lock AND xRoW^.Full THEN
            i := 7; ix:= 69; z:= 72;
         ELSIF xRoW^.Lock THEN
            i := 6; ix:= 68; z:= 72;
         ELSE
            i := 0; ix:= 66; z:= 72;
         END_IF;
         _NhSetObjBrw(wh:=12, ob:=2, w:=z, h:=z+10, o1:=ix, FgC:=0, Bgc:=i , x:= xR^.o.ob[2].x, y:= xR^.o.ob[2].y , vb := adr(vr), cm:=28, btn:=ok);
         CASE xRoW^.stat OF
           0 : i := 0;
//           1 : i := 0;
           2 : i := 7; ix := 69;                               // zamyka sa - odchod
           3 : i := 8; ix := 89;                               // prichod, caka sa na kod
           4 : i := 7; ix := 291;                              // strazenie - pes
         ELSE
            IF xRoW^.MemAlarm THEN
               i := 7; ix := 94;                               // zapamatany alarm
            ELSE
               i := 0;
            END_IF;
         END_CASE;

         IF i > 0 THEN
            _NhSetObjBrw(wh:=12, ob:=6, w:=46, h:=56, o1:=ix, FgC:=1, Bgc:=i , x:= xR^.o.ob[2].x-xR^.o.ob[2].h/2, y:= xR^.o.ob[2].y-xR^.o.ob[2].h/5 , vb := adr(vr), nTch:=1, btn:=1 );
         END_IF;
      ELSE                                                     // nadefinuje zobrazenie teploty
         xR^.o.ob[2].cm   := 30;
//         xR^.o.ob[2].cm   := 30;

//         _NhSetObjBrw(ob:=2, wh:=219, w:=80, h := _Nh_O12(xL^.dsh<3,30,25), cm:=30, vb := adr(xDev^.al.ou.val), BgC:=1);
      END_IF;
*)


      xR^.o.ob[10].cm   := 30;                                 // dotyk nad nazvom = vnorit sa
      IF cf = 1 AND xL^.dsh =1 THEN
         xR^.o.ob[9].cf.c:= 254;
         xR^.o.ob[9].fmt := LEFT(xRom^.cf.ID,3);
         xR^.o.ob[9].fmt := insert(xRom^.cf.ID,'.',2) ;
      ELSE
         xR^.o.ob[9].wh    := 0;                                  // disable nazov 2
      END_IF;
      xR^.o.ob[5].wh    := 5;                                  // zobrazenie sumarov
      CASE xL^.dsh OF
           3 : // 12*2
               xR^.o.ob[5].y   := xR^.o.ob[5].y-30;
               xR^.o.ob[5].x   := xR^.o.ob[5].x-10;
               xR^.o.ob[5].w   := 35;
               xR^.o.ob[5].h   := 33;


               xR^.o.ob[2].y   := xR^.o.ob[3].y+5;               // presunie teplotu u ROM dolu, aby bolo vidiet naov room


               IF rom = false THEN
                  xR^.o.ob[2].w   := xR^.o.ob[2].w-10;
                  xR^.o.ob[2].h   := xR^.o.ob[2].h-10;
                  xR^.o.ob[2].fn  := 0;                        // aby  sa zobrazil stav DEV, inak je to naformatovanie hodnoty zprava do lava
               END_IF;
           2 :
               xR^.o.ob[5].y   := xR^.o.ob[5].y-45;
               xR^.o.ob[5].x   := xR^.o.ob[5].x-48;
               xR^.o.ob[5].w   := 35;
               xR^.o.ob[5].h   := 33;
               xR^.o.ob[2].w   := xR^.o.ob[2].w+xR^.o.ob[2].w/4;
               xR^.o.ob[2].h   := xR^.o.ob[2].h+xR^.o.ob[2].h/4;
         ELSE
               xR^.o.ob[5].y  := xR^.o.ob[5].y - 5;
      END_CASE;
(* ///???
      IF xRoW^.Body  THEN                                      // pohyb v rom/zone
         xR^.o.ob[0].FgC  := 3;
         xR^.o.ob[0].BgC  := 1;
      ELSIF xRoW^.stat > 4 THEN                                // narusenie
         xR^.o.ob[0].FgC  := 1;
//         xR^.o.ob[0].BgC  := 28;
         xR^.o.ob[0].BgC  := 7;
      ELSIF xRoW^.Lock AND xRoW^.Full THEN                     // uplne zamknutie
         xR^.o.ob[10].FgC  := 4;
         xR^.o.ob[0].FgC  := 1;
//         xR^.o.ob[0].BgC  := 7;
         xR^.o.ob[0].BgC  := 6;
      ELSIF xRoW^.Lock THEN                                    // ciastocne zamknutie
         xR^.o.ob[10].FgC  := 4;
         xR^.o.ob[0].FgC  := 1;
         xR^.o.ob[0].BgC  := 16;

      END_IF;
   END_IF;
*)

   _NhShwDay := true;
END_FUNCTION



FUNCTION _NhRowDSH {HIDDEN} : BOOL           //   NAPLNI RIADOK FIXNYMI HODNOTAMI
   VAR_INPUT
      row      : USINT;
   END_VAR
   _NhRowDSH  := true;

//   yTx3 := CONCAT(_Nh_ADR_ROT,'/CFG/FRM/_', USINT_TO_STRINGF(aCfg[xR^.h.cf.c].frm,'%03d'),'.RW',USINT_TO_STRING(xL^.dsh));
//   _NhSdcVar(src := PTR_TO_UDINT(ADR( xR^.o.ob[0] )), siz := SIZEOF(NH_ROW_O)  );

//   _NhFrmName(read:=true, src:=ADR(xR^.o.ob[0]), cfg := aCfg[xR^.h.cf.c].frm, dsh:= xL^.dsh);

	rb:=_Nh_FRM_Read(frm:=USINT_TO_UINT(aCfg[xR^.h.cf.c].fBr), row := row);
   CASE xL^.dsh OF
     2:  //xR^.o    :=  _eRowBrw4;                                                 // dash ikony velke 3 riadkoy x 2 stlpce
         xIxB^.row.rws := 6;
         xIxB^.row.clm := 2;
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
         ELSIF row < 11 THEN  y := y1 + xR^.o.ob[0].h * 4  + 56;
         ELSE               y := y1 + xR^.o.ob[0].h * 5  + 70;
         END_IF;
         CASE xR^.h.cf.c OF
           1 : ;
           2 : ;
           3 : ;
           4 : ;
           5 : ;
          42 : ;
         ELSE
            IF xR^.o.ob[4].wh > 0 THEN                                           // ak je setup a nie je rom,cat,zon
               xR^.o.ob[4].x := xR^.o.ob[1].x +60;                               // pri malom DSH vypne stavovy obrazok
               xR^.o.ob[4].y := xR^.o.ob[1].y ;                                  // pri malom DSH vypne stavovy obrazok
            END_IF;
         END_CASE;

     3:  //xR^.o    :=  _eRowBrw12;                                                 // dash ikony male 12 riadkov x 2 stlpce
         IF yk > 1.0 THEN
            xIxB^.row.rws :=14;
//            xIxB^.row.rws :=12;
         ELSE
            xIxB^.row.rws :=12;
         END_IF;
         xIxB^.row.clm := 2;
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
         IF aCfg[xR^.h.cf.c].fBr = 0 THEN
            xR^.o.ob[4].wh := 0;                                                 // pri malom DSH vypne stavovy obrazok
         END_IF;

   ELSE  //xR^.o          :=  _eRowBrw6;       // 1 siroky riadok = default, 1 stlpec
         IF yk > 1.0 THEN
            xIxB^.row.rws  := 7;
         ELSE
            xIxB^.row.rws  := 6;
         END_IF;
         xIxB^.row.clm  := 1;
         x              := 0;
         y              := (y1-5) + (xR^.o.ob[0].h+7) * USINT_TO_INT(row-1);

   END_CASE;
END_FUNCTION

FUNCTION _Nh_Row_BRW_Data {HIDDEN} : BOOL           //   NAPLNI RIADOK FIXNYMI HODNOTAMI
   VAR_INPUT
      //ref      : BOOL;
      row      : USINT;
      x        : USINT;
   END_VAR
   VAR_TEMP
      sld      : BOOL;
      blk      : BOOL;
//      cp       : USINT;
//      np       : INT;
      FgC      : USINT := 4;        // biela gulicka
      BgC      : USINT := 5;        // zlty slider
//      c        : USINT;
   END_VAR
   _Nh_Row_BRW_Data := true;
  _NhRowDSH(row := row);
   ii                := xR^.h.cf.c;
   aWeb.M[1].brw.r[0] :=  xR^;   aWeb.M[1].brw.r[0].o.ob[10].fmt := CONCAT(USINT_TO_STRING(ii),',',USINT_TO_STRING(row));
   xL^.brw            := true;
	_NhTypObr(cf:=xR^.h.cf.c, typ:=xDev^.cf.typ);
	xR^.o.ob[ 1].fn 	 := xObrWht^.obr;

   xR^.o.ob[ 1].cf    := xR^.h.cf;
   xR^.o.ob[ 2].cf    := xR^.h.cf;
   xR^.o.ob[ 4].cf    := xR^.h.cf;

   xR^.o.ob[ 9].cf.c  := 1;                                                   // nazov miestnosti
   xR^.o.ob[ 9].cf.n  := USINT_TO_INT(xDev^.cf.rom);                             // cislo

   xR^.o.ob[10].cf.c  := xR^.h.cf.c;                                          // nazov Dev
   xR^.o.ob[10].cf.n  := xR^.h.cf.n;                                          // nazov Dev
   sld                := aCfg[ii].sld;

   xO := ADR(xR^.o.ob[2]);                                                 // nampuje stavovy objekt [2]

   _Nh_Chk_FAV();


   CASE xR^.h.cf.c OF
(*
     6:  // HET
         xHet  := xDev;
         IF xR^.h.chk THEN

            pHet  := xPar;
            xPva  := ADR(pHet^.pva);
         ELSE
            xPva  := ADR(xHet^.me.pva);
         END_IF;
         _NhSetObjBrw(wh:=219,ob:=2, y:=xR^.o.ob[2].y-10,  h:= 33,  vb := adr(xHet^.me.tmp[100]), Fgc:=4, BgC:=1, o1 := 0, nTch:=1);                  // teplota HET
         _NhSetObjBrw(wh:=222,ob:=5,  vb := xPva);                                                    // predvolby 0,1,23 + zidana telota
         IF xL^.dsh > 1 THEN
            xR^.o.ob[5].x  := xR^.o.ob[3].x;                            // hand/auto dat na poziciu oblubene
            xR^.o.ob[3].wh := 0;                                        // oblubene nebude
            xR^.o.ob[4].wh := 0;                                        // setup nebude
         END_IF;
         IF xL^.dsh < 3 THEN
            IF xHet^.me.own[99] THEN
               _NhSetObjBrw(ob:=7, wh:=219, x:=xR^.o.ob[2].x-5, y:=xR^.o.ob[2].y+35 ,  h:= 22,  vb := adr(xHet^.me.tmp[99]), Fgc:=16, BgC:=1, o1 := 0, nTch:=1);                  // teplota HET
            END_IF;
         ELSE
            xR^.o.ob[2].y := xR^.o.ob[10].y;                         // teplotu vratit na uroven nazvu
            xR^.o.ob[2].w := 25;                                     // teplotu vratit na uroven nazvu
            xR^.o.ob[10].cf.p := 6;                                  // 8 - znakov nazvu
         END_IF;
         xR^.o.ob[1].wh := 9;
         xR^.o.ob[1].fn := 0;
*)
    10: // SVD
         _NhSetObjBrw(wh:=7,ob:=7, w:=48, cm := 44,  vb := ADR(vr));        // zobrazenie blokovania PIR nad stavovym obrazkom
          xR^.o.ob[ 2].wh := 9;
    11:   _NhSetObjBrw(wh:=7,ob:=7, w:=48, cm := 44, vb := ADR(vr));        // zobrazenie blokovania PIR nad stavovym obrazkom  // SVA
          xR^.o.ob[ 2].wh := 9;
    12:   // RGB
          _NhSetObjBrw(wh:=7,ob:=7, w:=48, cm := 44, vb := ADR(vr));        // zobrazenie blokovania PIR nad stavovym obrazkom
          xR^.o.ob[ 2].wh := 9;
    13:  // WSB
         _NhSetWSB(o := 1, chk := xR^.h.chk);
//         _NhSetObjBrw(ob := 5, sl := 1, o1  := 127, o2 := 129, vb := ADR(xDev^.ok.blk));
    14:  // TLA
         _NhSetWSB(o := 1, chk := xR^.h.chk);

(*
    23:  // VEN
//         xR^.o.ob[ 6].wh := 7;   // cas do vypnutia / PIR, blokovanie
         _NhSetObjBrw(wh:=7,ob:=7, w:=48, cm := 44, vb := ADR(vr));        // zobrazenie blokovania PIR nad stavovym obrazkom
         xVen := xDev;
         IF xVen^.cf.typ < 1 THEN
            sld := 0;
         END_IF;
*)

    35:  // BLK
         xR^.o.ob[ 2].wh   := 9;
    36:  // TIM
         xR^.o.ob[ 2].wh   := 9;
    37:  // BRA
         _NhSetObjDsh(grp := 37);
//         sld   := false;                                                // nasilne sa zrusi slider

    40:  // TGL

          _NhSetWSB(o := 1, chk := xR^.h.chk);
    42:  ;// DLM
(*
         xDLm  := xDev;
         xPtD  := ADR(xR^.o.ob[9].cf.n);
         xPtD^ := PTR_TO_UDINT( ADR(xDlm^.hw.txt) );
*)

    43:  ;// DLS
         sld   := false;
//         xDLs  := xDev;
//         _NhSetObjBrw(wh := 251, ob := 5, sl := USINT_TO_SINT(row), vb := ADR(xDLs^.hw.set.ActualLevel));

    44:  ;// DLQ




   ELSE

   END_CASE;

   CASE xR^.h.cf.c OF
     4:  // SCN
         xO^.wh := 3;
         xR^.o.ob[ 6].wh := 7;   // SVD
     5:  // ACT


     7:  // KOT

//         _NhSetObjBrw(wh := 222, ob:=5, vb := ADR(vr));
//         sld := 0;

//         xR^.o.ob[ 9].wh := 0;                      // nevypisuje sa druhy riadok
//         _NhSetObjBrw(wh := 222, ob := 5, w := 48, h := 68, c:= 3, n := 1, vb := ADR(xHet^.cx.ter));

     8:  // TVE



     9:  // CER
//         _NhSetObjBrw(wh := 222, ob:=5, vb := ADR(vr));
//         sld := 0;

//         xR^.o.ob[ 9].wh := 0;                      // nevypisuje sa druhy riadok
//         _NhSetObjBrw(wh := 222, ob := 5, w := 48, h := 68, c:= 3, n := 0, vb := ADR(xCfx^));


    15:  // PIR
         blk               := xR^.h.chk = false;                                       // blk len ked nie je vo vazbe
         IF xR^.h.chk THEN
            _NhxDev2(c := xR^.o.ob[ 4].cf.c, n := xR^.o.ob[ 4].cf.n, x:=13);
            IF xDev2^.cf.rom = 0 THEN
               _NhxDev2(c := xR^.h.cf.c , n := xR^.h.cf.n, x:=14);
            END_IF;
            _NhShwDay(cf := 1, nr := xDev2^.cf.rom, rom := false);
            xR^.o.ob[ 8].y   :=xR^.o.ob[ 8].y  + xR^.o.ob[ 1].w / 2;                      // pozicia DAY-mode bude dolu
//         ELSE
//            xR^.o.ob[ 2].wh   := 3;

         ELSIF xDev^.cf.typ = 1 THEN
            _NhSetObjBrw(wh:=200, ob := 6, w := 48, h:= 0, FgC := 8, c := 0, vb := ADR(xDev^.al.Off ), nTch:=1 );     // pritomnost tamperu na pir
         END_IF;

    16:  // TER
         _NhSetObjBrw(ob:=2, wh:=219, vb := adr(xDev^.al.ou.val),BgC:=1);
         blk := true;
    17:  // TER
         _NhSetObjBrw(ob:=2, wh:=219, vb := adr(xDev^.al.ou.val),BgC:=1);
         blk := true;
    18:  // TER
         _NhSetObjBrw(ob:=2, wh:=219, vb := adr(xDev^.al.ou.val),BgC:=1);
         blk := true;

    19:  // LUX
         _NhSetObjBrw(ob:=2, wh:=219, vb := adr(xDev^.al.ou.val),BgC:=1,fmt := '%4.0f%%');
         blk := true;
//         _NhSetObjBrw(vb := ADR(xDev^.al.ou.val),  wh := 255, ob := 2);

    20:  // FAV LIST
         xO^.wh   := 1 ;                               // len obrazok
         xO^.cm   := 27 ;                             // zmena oblubeneho
         xFav     := xDev;
         IF xFav^.cx = xA^.fav THEN
            xR^.o.ob[ 2].fn := 38;
         ELSE
            xR^.o.ob[ 2].fn := 35;
         END_IF;
         xR^.o.ob[ 3].wh := 0;
         xR^.o.ob[ 4].wh := 0;
         IF xFav^.cx.n > 0 THEN
            xR^.o.ob[ 9].cf.c := 22; xR^.o.ob[ 9].cf.n := USINT_TO_INT(xFav^.cx.c);      // do 2.riadku cislo usra
         ELSE
            xR^.o.ob[ 9].wh := 0;                      // nevypisuje sa druhy riadok
         END_IF;

    21:  xR^.o.ob[ 6].wh := 7;   // ZAS

    22:  xR^.o.ob[ 1].cm := 201;   // USR - WEB_FRM
         xR^.o.ob[ 4].wh := 0;                         // nebude text 2
         xR^.o.ob[ 9].wh := 0;                         // nebude text 2
         xR^.o.ob[ 2].wh := 1;                           // vypisat check
//         xR^.o.ob[ 2].fn := 35;
         xR^.o.ob[ 2].w  := 72;                       // vypisat check

    24:  // KEY;
         xR^.o.ob[ 4].cm := 81;                         // zatial posde do ROM



    33:
    38:  // RFI
         xRFI := xDev;
         _NhSetObjBrw(ob := 5, sl := 1, o1  := 127, o2 := 129, vb := ADR(xRFI^.cx.blk));

         _NhSetObjBrw(ob := 6, sl := 2, o1  := 275, o2 := 276, vb := ADR(xRFI^.cx.Beep), w:= 48 );
         _NhSetObjBrw(ob := 7, sl := 3, o1  := 270, o2 := 271, vb := ADR(xRFI^.cx.LedG), w:= 32 );
         _NhSetObjBrw(ob := 8, sl := 4, o1  := 270, o2 := 272, vb := ADR(xRFI^.cx.LedR), w:= 32 );

    39:  // RFK
         IF xM^.new = xR^.h.nd THEN                // novo pridany alebo najdena karta zmeni farbu boxu na zeleno
            xM^.new := 0;
            xR^.o.ob[0].FgC   := 8;
            xR^.o.ob[0].BgC   := 1;
         END_IF;

   ELSE  ;
//      _NhSetObjBrw(wh := xR^.h.cf.c, ob := 2, vb := ADR(xR^.o.ob[2].cf.n) );
   END_CASE;
   IF sld  THEN                                         // nadefinuje slider
      rb := _NhSetObjBrw(wh := 250, ob := 5, sl := USINT_TO_SINT(row), vb := ADR(xDev^.al.in.val), t:= 0, w:=_Nh_O12(xL^.dsh<2,350,160), FgC := Fgc,BgC := BgC,  x:= xR^.o.ob[5].x );
      IF xL^.dsh > 2 THEN
         xR^.o.ob[2].wh := 0;                            // pri malom DSH vypne stavovy obrazok
         xR^.o.ob[6].wh := 0;                            //
      END_IF;
   ELSIF blk   THEN
      _NhSetObjBrw(wh:=200, ob := 5, w := 48, h:= 0, FgC := 4, c := 0, vb := ADR(xDev^.cf.blk ) );     // blokovat (ON/OFF)
   END_IF;

(*
   IF xL^.dsh > 2 THEN                                      // pri malom DSH sa posunie hodnota dolu
      IF xR^.o.ob[2].wh = 19 AND xR^.o.ob[2].fn = 0 THEN    // len hodnota bez podkladu BTN
         xR^.o.ob[2].y   := xR^.o.ob[2].y+60;
      END_IF;
   END_IF;
*)


END_FUNCTION

FUNCTION _NhBrwND {HIDDEN} : BOOL         // vrati index odpovedajuci cf
   VAR_INPUT
      rws      : SINT := 11;
   END_VAR
   _NhBrwND := 1;
   WHILE nd > 2 AND rws > 0 DO
      nd := nd - 1 ;
      IF _NhxDev(c := cf, n := nd, x:=252 ) THEN
         rws := rws - 1;
      END_IF;
   END_WHILE;
END_FUNCTION

FUNCTION _NhBrwIX {HIDDEN} : INT         // vrati index odpovedajuci cf
   VAR_INPUT
      cf    : USINT;
   END_VAR
   _NhBrwIX := 1;
   WHILE _Nh_IxC[_NhBrwIX] > 0 AND _Nh_IxC[_NhBrwIX] <> cf DO
      _NhBrwIX := _NhBrwIX + 1;
   END_WHILE;
END_FUNCTION

VAR_GLOBAL
   row      {HIDDEN} : USINT;
   nx       {HIDDEN} : USINT;
END_VAR

FUNCTION  _Nh_Web_BRW {HIDDEN} : BOOL     // RIADKOVY BROWSER
   VAR_TEMP
      brw      :  BOOL := true;        // z indexu prenesie data do row browseru
      wht      :  USINT;
   END_VAR
   VAR_TEMP
      row0     : BOOL;
      kx       : INT;
//      ya       : INT;
   END_VAR
   _Nh_Web_BRW   := true;
//   aSys.cnt    := aSys.cnt + 1;
   xIxB := ADR(xM^.ixb[0]);
   IF xIxB^.idx = 0 OR xM^.wht >= 20 THEN                                                   // novy index, vypis od prvej vety
      _Nh_Brw_Idx();                                                                           // vymaze vsetko a vytvori novy index

   END_IF;


   GC_Begin(GrData := xCan);
   GC_ReSetOrigin(GrData := xCan);
   CASE xM^.wht OF
     -1: // len refresh riadkov
         brw := false;
     -2: // refresh   Frame (len menu)
         brw := false;
      1: // dolu
         IF xM^.iter = 0 THEN
            xM^.iter    := 1;                                                    // krd sa sem vrati v druhom cykle uz sem nepojde
            brw         := false;                                                // len sa prekresli co je na obrazovke, nie nove data
            xA^.tch.cmd := 255;                                                  // v druhom cykle ide rovno sem
            _Nh_Web_BRW   := false;                                                // zabezpeci, aby sa neresetol cmd
            IF xIxB^.ix1 > 1 THEN
               row0        := true;                                              // vykresli sa riadok, aj sa skoriguje suradnica y
               IF xL^.dsh = 1 THEN
                  GC_MoveTo(x:=0,y:= 95,GrData := xCan);                               // posun dolu
//                  GC_MoveTo(x:=0,y:= 95,GrData := xCan);                               // posun dolu
               ELSE
                  GC_MoveTo(x:=0,y:= 0,GrData := xCan);                               // posun dolu
                  row0        := false;                                              // vykresli sa riadok, aj sa skoriguje suradnica y
               END_IF;
               xM^.delay   := 1;                                                 // vylistuje sa prazna cast riadka a caka sa, aby sa vratila obrazovka
            ELSE                                                                 // nie je dalsi riadok
               GC_MoveTo(x:=0,y:= 45,GrData := xCan);                               // posun dolu
               xM^.delay := 500;                                                 // vylistuje sa prazna cast riadka a caka sa, aby sa vratila obrazovka
              END_IF;
            GC_SetOrigin(GrData := xCan);                                        // prestavi na tendo cyklus

         ELSE
            _NhSet1Row(fnd := false, dn := true, row := xIxB^.row.rws );
            xM^.iter := 0;                                                       // vrati sa do povodnehostavu
         END_IF;

      2: // hore
         IF xM^.iter = 0 THEN
            xM^.iter    := 1;                                                    // krd sa sem vrati v druhom cykle uz sem nepojde
            brw         := false;                                                // len sa prekresli co je na obrazovke, nie nove data
            xA^.tch.cmd := 255;                                                  // v druhom cykle ide rovno sem
            _Nh_Web_BRW   := false;                                                // zabezpeci, aby sa neresetol cmd
            IF xIxB^.ix2 < xIxB^.idx AND xB^.rw > 0 THEN
               row0        := true;                                              // vykresli sa riadok, aj sa skoriguje suradnica y
               IF xL^.dsh = 1 THEN
                  GC_MoveTo(x:=0,y:=-50,GrData := xCan);                               // posun hore
//                  GC_MoveTo(x:=0,y:=-90,GrData := xCan);                               // posun hore
               ELSE
                  GC_MoveTo(x:=0,y:=0,GrData := xCan);                               // posun hore
                  row0        := false;                                              // vykresli sa riadok, aj sa skoriguje suradnica y
               END_IF;
               xM^.delay   := 1;                                                 // vylistuje sa prazna cast riadka a caka sa, aby sa vratila obrazovka
            ELSE                                                                 // nie je dalsi riadok
               xM^.delay := 500;                                                 // vylistuje sa prazna cast riadka a caka sa, aby sa vratila obrazovka
               GC_MoveTo(x:=0,y:=-45,GrData := xCan);                               // posun hore
            END_IF;
             GC_SetOrigin(GrData := xCan);                                        // prestavi na tendo cyklus
         ELSE
            _NhSet1Row(fnd := false, up := true, row := xIxB^.row.rws );         // ziskaju sa nove data od 1.riadka
            xM^.iter := 0;                                                       // vrati sa do povodneho stavu
         END_IF;

     10: // vypis od 1.riadka s predefinovanim dat v riadku, nie novy index
         _Nh_Map_Idx(ixb := 0, idx := xIxB^.ix1);

     15 : // zmazat vetu = novy index a refresh od 1.riadku alebo za DEL-rec
         _NhSet1Row(fnd := false, del := true);                                     // nastavi rw1 no-del vetu
         _Nh_Brw_Idx();                                                             // vytvori novy index bez zmazaneho zaznamu
         wht := 25;                                                                 // vypis od zapamatanej vety

     20: // vytvoreny novy index, refresh tak aby zapamatana veta zostala v 1.riadku
         xIxB^.ix1 := 1;
         _NhSet1Row(fnd := false);                                     // nastavi rw1 no-del vetu
//         _NhSet1Row(fnd := false);

     25: // navrat spat = vytvorit novy index, vypis od zapamatanej vety v 1.RIADKU
          wht    := 25;

     30 : // nova veta   = novy index a pridanu vetu zobrazit na konci browsu ak sa da
            _NhSet1Row(end := true);
   END_CASE;
   CASE wht OF
     25 :   // najde v indexe vetu, ktora odpoveda zapamatanej vete a to bude 1.veta v browse = posunie vetu na 1.riadok
            _NhSet1Row();
   END_CASE;





   row   := 1; //xIxB^.ix1;
   nx    := xIxB^.ix1;                                      // index na data
   // xIdx je namapovane na vetu xIxB^.ix1;
   // xIxB je namapovane na sadu dat pre browser xM^.ixb[0]
   xB^.rw  := 0;

//IF false THEN

   IF xL^.obj > 200 THEN
      WHILE nx > 0 AND row <= xIxB^.row.rws DO
         xR := ADR(xB^.r[ row  ]);
         IF nx <= xIxB^.idx THEN                                        // mame vetu
            xB^.rw      := row;                                             // posledny naplneny ridok
            xIxB^.ix2   := nx;
            IF xL^.obj=255 THEN
					yTx2	:= CONCAT('Err:_Nh_Web_BRW,xL^.obj=255: nx:',USINT_TO_STRING(nx),' row:',USINT_TO_STRING(row),' c:',USINT_TO_STRING(xR^.h.cf.c),' n:',INT_TO_STRING(xR^.h.cf.n))  ;
   	 			rb		:= _Nh1RowTxt(logRst := 1);
					aSys.ErrPt	:= aSys.ErrPt + 1;
(*
               nx             := nx + 1;
               xR^.o.ob[0]    := _eRowBrw6.ob[0];       // 1 siroky riadok = default, 1 stlpec
               xR^.o.ob[1]    := _eRowBrw6.ob[1];       // 1 siroky riadok = default, 1 stlpec
               xR^.o.ob[1].wh := 255;
               xR^.h.cf       := xIdx^.ix[aWeb.nbr].dev;
               x              := 0;
               y              := (y1-5) + (xR^.o.ob[0].h+7) * USINT_TO_INT(row-1);
               _Nh_Shw_Obj(row:=row,x := x, y:= y);                         // koriguje x,y o kazdeho objektu riadka a vykresli
*)
            END_IF;
         END_IF;
         xIdx  := xIdx + SIZEOF(NH_IDX);
         row   := row + 1;
      END_WHILE;
   ELSE
      WHILE nx > 0 AND row <= xIxB^.row.rws DO
         xR := ADR(xB^.r[ row  ]);
         yIdxR       := xIdx^.ix[aWeb.nbr];                                   // nove od 21.10.22
         IF brw THEN                                     						// natahuju sa struktiry kazdej vety nanovo
            IF nx <= xIxB^.idx THEN                                        // mame vetu
               kx := 0;
               xR^.h.cf    := xIdx^.ix[aWeb.nbr].dev;
					IF xR^.h.cf.c > 0 THEN
						IF yIdxR.chk AND yIdxR.vaz AND yIdxR.nd > 0 THEN
	                  xR^.h.nd    := yIdxR.nd;
						ELSE
	                  xR^.h.nd    := USINT_TO_INT(nx);
   					END_IF;
                  xIxB^.ix2   := nx;
                  nx          := nx + 1;

                  _NhxCfg(c := xR^.h.cf.c, n := xR^.h.cf.n, par := true, p := xR^.h.cf.p, x:=19);                     // xDev,xCfg,xPar pre aktualny riadok
                  IF aCfg[xR^.h.cf.c].fBr > 0 THEN
                     _Nh_Frm_Row_BRW(row := row, new := true);
                  ELSE
                     _Nh_Row_BRW_Data(row := row , x:=11);                                                              // naplni riadky
                  END_IF;

                  IF xM^.new = USINT_TO_INT(row) THEN                		// je DEL, alebo CPY - dodefinuje objekt namiesto obj[1]
                     IF xA^.tch.del OR xA^.tch.cpy THEN
                    		_NhSetObjBrw( wh := 202, vb := adr(vr) );
                       	x           := x -94;
							ELSE
	                     xM^.new := 0;
                     END_IF;
                  END_IF;
               ELSE
                  yTx2     := CONCAT('ERR!-02 _NhWebBrw vypis idx/nx/c/n: ',
                           USINT_TO_STRING(xIxB^.idx),'/',USINT_TO_STRING(nx),'/',USINT_TO_STRING(xR^.h.cf.c),'/',INT_TO_STRING(xR^.h.cf.n));
                  _Nh1RowTxt(logRst := 1, adTime := 3);
                  EXIT;
               END_IF;
            ELSE
               EXIT;
            END_IF;
         ELSE
            x  := 0;
            y  := 0;
         END_IF;
         IF xR^.h.nd > 0 AND xR^.h.cf.c > 0 THEN
             xB^.rw  := row;                                             // posledny naplneny ridok
            _NhxCfg(c := xR^.h.cf.c, n := xR^.h.cf.n, par := true, p := xR^.h.cf.p, x:=19);                     // xDev,xCfg,xPar pre aktualny riadok
            IF aCfg[xR^.h.cf.c].fBr > 0 THEN
               _Nh_Frm_Row_BRW(row := row);
            END_IF;
//  				_Nh_Shw_Obj(row:=row, x := x, y:= y);                         // koriguje x,y o kazdeho objektu riadka a vykresli

				IF xR^.h.new THEN
    				_Nh_Shw_Obj(row:=row);                         				// koriguje x,y o kazdeho objektu riadka a vykresli				
				ELSE
    				_Nh_Shw_Obj(row:=row, x := x, y:= y);                    // koriguje x,y o kazdeho objektu riadka a vykresli
//					IF xM^.wht = -1 AND xR^.h.cf.c = 31 THEN     				// vynimka pre rolety
//					IF xR^.h.cf.c = 31 THEN     										// vynimka pre rolety
//						xR^.h.new := true;					
//					END_IF;
				END_IF;
         ELSE
            EXIT;
         END_IF;
         xIdx  := xIdx + SIZEOF(NH_IDX);
         row   := row + 1;
      END_WHILE;
      


(*
//   IF row0 THEN                                                      // dodatocny vypis riadka 0/7 pri rorovani hore dolu
   IF false THEN                                                      // dodatocny vypis riadka 0/7 pri rorovani hore dolu
      IF xM^.wht = 2 THEN
         row := 7;
//**-**         _NhMapIdx(ixb := 0, idx := xIxB^.ix1, idx := xIxB^.ix2 + 1);
         _Nh_Map_Idx(ixb := 0, idx := xIxB^.ix2 + 1);
         xB^.xy.yp := 0;
      ELSE
         row := 1;
//**-**         _NhMapIdx(ixb := 0, idx := xIxB^.ix1, idx := xIxB^.ix1 - 1);
         _Nh_Map_Idx(ixb := 0, idx := xIxB^.ix1 - 1);
         xB^.xy.yp := -kyr;
      END_IF;

         xR 			:= ADR(xB^.r[ 0  ]);
         xR^.h.cf    := xIdx^.ix[aWeb.nbr].dev;
         xR^.h.nd    := USINT_TO_INT(xIxB^.ix2+1);

         IF xR^.h.cf.c > 0 THEN
            _NhxCfg(c := xR^.h.cf.c, n := xR^.h.cf.n, par := true, n := xR^.h.cf.p, x:=20);                     // xDev,xCfg,xPar pre aktualny riadok
            IF aCfg[xR^.h.cf.c].fBr > 0 THEN
               _Nh_Frm_Row_BRW(row := row, new := true);
            ELSE
               _Nh_Row_BRW_Data(row := row , x:=12);                                                              // naplni riadky
            END_IF;
            _Nh_Shw_Obj(row:=0, y := y + xB^.xy.yp);                         // koriguje x,y o kazdeho objektu riadka a vykresli
         END_IF;

      END_IF;
*)

   END_IF;
//END_IF;

   GC_ReSetOrigin(GrData := xCan);
   _NhShwMnu();
   _NhPgNav();

   GC_End(GrData := xCan);
END_FUNCTION



{ $ END_IF }
