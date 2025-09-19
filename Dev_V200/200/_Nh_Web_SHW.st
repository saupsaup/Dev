{ $ IFDEF __NH_WEB }

FUNCTION _Nh_Shw_Val {HIDDEN}: BOOL
   VAR_INPUT
      jj         : SINT := 0;
   END_VAR
   _Nh_Shw_Val := true; 
   WHILE yRn.v[jj].ok  AND jj <= 4 DO
      IF yRn.v[jj].ob >  0 THEN
         xO := ADR(xR^.o.ob[jj]);
      END_IF;
      _NhVal2( wh    := yRn.v[jj].wh,
               crc   := yRn.v[jj].crc,
               wC    := yRn.v[jj].wC,
               grd   := yRn.v[jj].grd,
               obr   := yRn.v[jj].obr,
               wO    := yRn.v[jj].wO,
               txt   := yRn.v[jj].txt,
               wT    := yRn.v[jj].wT,
               fmt   := yRn.v[jj].fmt,
               FgT   := yRn.v[jj].Fgt,
               x     := yRn.v[jj].x,
               y     := yRn.v[jj].y,
               FgC   := yRn.v[jj].FgC,
               BgC   := yRn.v[jj].BgC,
               val   := yRn.v[jj].val
                             );
      jj  := jj +1;
   END_WHILE;
END_FUNCTION

FUNCTION _Nh_Shw_Obj   {HIDDEN}    : BOOL                    // vykresli objekty riadka alebo vsetkych riadkov
   VAR_INPUT
      shw         : BOOL := true;
      obj         : SINT := -1;                       // > -1 = lej jeden objekt v riadku
      x,y         : INT;
		row 			: USINT;
   END_VAR
   VAR_TEMP
      nj          : SINT;
      o,s         : USINT;
      c           : USINT;
      p,pp        : INT;
      tx          : STRING[1];
      mie         : REAL;
      set         : BOOL;
      tch         : BOOL;
      NoGo        : BOOL;
   END_VAR
   _Nh_Shw_Obj := true;


   IF obj > -1 THEN
      j     := obj;
      nj     := j;
   ELSE
      j     := 0;
      nj     := _RowObr;
   END_IF;
//   cmd := 0;         ///***
   WHILE j  <= nj DO
      xO       := ADR(xR^.o.ob[j]);
     	tch      := xO^.tch ;         //AND xA^.tch.tOb;         //**--** PREVERIT!!!
      CASE xO^.wh OF
			 0 :  NoGo := false;
        107:  NoGo := false;
					IF xL^.obj = 0 THEN
						xO2 := ADR(xB^.r[1].o.ob[j]);
	        			_Nh_Web_SHW_107(row:=true, obj:=j);
					ELSE
	        			_Nh_Web_SHW_107();
   				END_IF;
        109:  NoGo := false;
					xRo			:=  xO;
					IF xA^.tch.obj =  j AND xA^.tch.row = USINT_TO_SINT(row) THEN
						xRo^.Q		:= xA^.tch.Q;
						xRo^.Qr		:= xA^.tch.Qr;
						xRo^.Qf		:= xA^.tch.Qf;
   				END_IF
					xRo^.y		:=  xRo^.y 		+ y;
					xRo^.yLam	:=  xRo^.yLam 	+ y;
					xRo^.yObr	:=  xRo^.yObr 	+ y;

					// treba vyriesit !!!!
					xRo^.yCirRol	:= MAX(xRo^.yCirRol, xRo^.y);  					
					xRo^.yCirLam	:= MAX(xRo^.yCirLam, xRo^.yLam);       	// pri kresleni hrubej casi slideru LAM bolo po 1.dotyku chyba

					xRo^.x		:=  xRo^.x 		+ x;
					xRo^.xLam	:=  xRo^.xLam 	+ x;
					xRo^.xObrR	:=  xRo^.xObrR + x;
					xRo^.xObrL	:=  xRo^.xObrL + x;

					_Nh_ROL_Sld();	
					j := j + 1;												// dalsi objekt je sucastou tohto {su to 2obj)

	   ELSE
         NoGo := true;
      END_CASE;
      IF shw AND NoGo THEN
         xO^.x    := xO^.x + x;                                                     // na zaciatok zapise korekciu, na konci ju vrati
         xO^.y    := xO^.y + y;
         GC_SetFillStyle      (style := GFILL_STYLE_FRAME, GrData := xCan);					

         CASE xO^.wh OF
            0 :  ;// ziadny prikaz
//                  TchClr := false;
            1 :   // LEN obrazok
                     // xO^.fn                  cislo obrazka
                     // xO^.h                   primer kruhu co bude pod obrazkom - farba BgC
                     // xO^.btn = true          po dotyku zapise do premennej hodnotu
                     // xO^.cf.c                typ premennej 0=REAL,1=USINT,2=SINT,3=UINT,4=BOOL,5=INT
                     // xO^.cf.n                adresa premennej v UDINT
                     // xO^.fmt                 hodnota premennj v stringu

                     IF xO^.fn  > 0 THEN
                        If xO^.h > 0 THEN
                           _NhVal2(obr:=xO^.fn, wo:=xO^.w, crc:=1, wC:=xO^.h, grd:=1, Fgc:=xO^.FgC, BgC:=xO^.BgC);
                        ELSe
                           _NhVal2(obr := xO^.fn, wo := xO^.w,);
                        END_IF;
                        IF tch AND xO^.btn AND xO^.cf.n > 0 THEN                          // dotyk nad obr nieco vykona
                           tch   := 0; xO^.tch  := tch;                                   // vynuluje sa dotyk
					            _NhxPtrCfN(set:=true, typ:=xO^.cf.c, val:=STRING_TO_REAL(xO^.fmt));
                        END_IF;
                     END_IF;

           200:   // len ON/OFF : xDev^.cf.BLK
                  xPtB  := ADR(xDev^.cf.blk);                                                       // pointer prvej bool premennej / pola
                  IF tch THEN
                     xPtB^       := NOT xPtB^;
                     xO^.tch     := 0;                ///***
                  END_IF;





            2:   //

            3:   // hlavny obrazok a status pre DEV, alebo zobrazenie DEV v HOME-PAGE

            		// toto je to iste co 230 - treba zjednotit !!!!

                  yRn.v[0].wO    := xO^.w;
                  _Nh_Shw_ini();
						_NhTypObr(cf:=xO^.cf.c, typ:=xDev^.cf.typ);
						xO^.fn			:= xObrWht^.obr;
	               yRn.v[0].obr   := xObrWht^.obr;
                  yRn.v[0].wh 	:= xObrWht^.wht;
						IF yRn.v[0].wh > 0 THEN
							yRn.v[0].wO := xO^.w * 20 / 24;
						ELSE
	                  yRn.v[0].wO := xO^.w;						
						END_IF;
                  _Nh_Shw_Val();

            4:   // text alebo obrazok v kruhu, alebo boxe ( podla cf.c) (vymazanim podkladu kruznicou alebo boxom)

                  // xO^.cf.c : 0-ziadny podklad, 1-kruznica,2-box
                  // xO^.cf.n : 1 = bez vyplne, 0 = s vyplnou
                  // xO^.cf.p : prebije vsetko
                  _NhVal2( wh := INT_TO_USINT(xO^.cf.p),
                           txt   := 102,                 // ak je nieco v xO^.fmt, vypise sa farbou Fgc
                           wT    := xO^.w*10/13,         // vyska textu
                           FgT   := xO^.Fgc,             // farba textu
                           obr   := xO^.fn,              // obrazok
                           wO    := xO^.w*10/12,         // velkost obrazka pomerom zo sirky
                           grd   := 2,                   // podklad bude STYLE_FRAME : vypln:=BgC, ohranicenie:=FgC ( farba 0 nebude viditelna)
                           wC    := xO^.w,               // primer kruznice / sirka boxu
                           hB    := xO^.h,               // vyska boxu
                           fil   := xO^.cf.n = 0,        // len pre kruh/box s vyplnou
                           FgC   := xO^.Fgc,             // ohranicenie / kruznica
                           BgC   := xO^.Bgc,             // vypln
                           box   := xO^.cf.c=2,          // vykresli centrovany box
									r		:= 10,
                           crc   := xO^.cf.c=1);         // kruznica/kruh


            5:   // vypis stavov DEV pre ROM,ZON
						_NhxRoW(zon := xR^.h.cf.c = 3 ,nbr := INT_TO_USINT(xR^.h.cf.n));		
					 	_Nh_FRM_Read(frm:=232);
                  pp := 0;
						p	:= 0;	//xO^.x;
						i	:= 1;
						WHILE pp <= xO^.fn AND i <= _Nh_CAT DO
							IF xRoW^.cat[i] THEN
								IF true THEN //xCat^.cf.shw THEN
								  	_Nh_Shw_ini();
									yRn.v[0].wO	:= xO^.w * 20 / 24;							
									yRn.v[0].x	:= p;							
									_Nh_Shw_232(cat := USINT_TO_INT(i), sta := 1);
			                  _Nh_Shw_Val();
									pp := pp + 1;
									p 	:= p 	+ xO^.h;
								END_IF;
							END_IF;
							i := i + 1;
                  END_WHILE;												

            6:   // vypis textu : Nazov dev, text zo suboru textov , cislo s pripadnym podfarbenim,
                  // xO^.h          vyska textu
                  // xO^.w          sirka textu (len pre dotyk)
                  // xO^.cf.c > 0   nazov Dev s podfarbenim
                              //    xO^.BgC > 0    : podfarbenie
                              //    xO^.cf.p > 0   : pocet znakov textu = xO^.cf.p
                              //    xO^.cf.p <= 0  : pocet znakov textu sa vypocita z sirky : xO^.w/7
                  // xO^.cf.c = 0
                              //    xO^.cf.n <= 0  : cislo zadane do xO^.cf.n
                              //    xO^.cf.n < 1000 : cislo textu zo suboru textov

                  //    xO^.cf.p > 0   : pocet znakov textu = xO^.cf.p
                  //    xO^.cf.p <= 0  : pocet znakov textu sa vypocita z sirky : xO^.w/7


						
						rji := _Nh_Sty[xO^.fn];                 ///***29.11.2022
                  CASE xO^.cf.c OF
                    0 :    //
//                           rj := _Nh_Sty[xO^.fn];
                           IF xO^.cf.n <= 0 THEN                                                // vypise sa ulozene cislo
                              yTx1 := INT_TO_STRING(xO^.cf.n * -1);
                           ELSE                                                                 // vypise sa text so suboru _NhLang.txt
                              _Nh_Lang(id :=  xO^.cf.n ,txt := ADR(yTx1));
                           END_IF;
                    2 :    // CAT
									rji := _Nh_Sty[0];
                           _Nh_Lang(id :=  xO^.fn ,txt := ADR(yTx1));

                  245 :    // Sunrise - vychod
									yTx1 := TIME_TO_STRINGF(aMeteo.SunriseTime,xO^.fmt);
                  246 :    // Sunset - zapad
									yTx1 := TIME_TO_STRINGF(aMeteo.SunSetTime,xO^.fmt);
                  247 :    // Cas
									yTx1 := TIME_TO_STRINGF(aSys.NhTime,xO^.fmt);
                  248 :    // Datum
									yTx1 := DATE_TO_STRINGF(aSys.NhDate,xO^.fmt);
					   249 :     // nazov ZON
                           IF xDev^.cf.rom = 0 OR USINT_TO_INT(xDev^.cf.rom) > aCfg[3].rec THEN
                              yTx1 := CONCAT('!!!-Zon: ', USINT_TO_STRING(xDev^.cf.rom));
                           ELSE
                              _NhxPt(c := 3, n := USINT_TO_INT(xDev^.cf.rom),x:=27);
                              yTx1 := xPt^.cf.Name;
                           END_If;

                  250 :     // nazov typoveho dna premenna je ulozena v cf.n
                           xPtD  := ADR(xO^.cf.n);
                           xPtU  := UDINT_TO_PTR(xPtD^);
                           IF xPtU^ > 7 THEN                                                    // den v tyzdni sa nevypisuje
                              pp    := 201 + USINT_TO_INT(xPtU^-7);                             // dalsie text ysu za sebou
                              _Nh_Lang(id := pp ,txt := ADR(yTx1));
                           ELSE
                              yTx1 := '';
                           END_IF;
                  251 :     // to co je v cf.ID, formatom 1.12
                           yTx1 := INSERT(xDev^.cf.ID,'.',2);
                           yTx1 := CONCAT(yTx1,'   (',INT_TO_STRINGF(xR^.h.cf.n,'%d'),')')  ;
                  252 :     // nazov ROM alebo zony
                           IF xDev^.cf.rom = 0 OR USINT_TO_INT(xDev^.cf.rom) > aCfg[1].rec THEN
										c := 0;
                              yTx1 := CONCAT('!!!-Rom: ', USINT_TO_STRING(xDev^.cf.rom));
				               ELSIF aCfg[xR^.h.cf.c].RomIsZone THEN
										c := 3;
                           ELSE
										c := 1;
                           END_If;
									IF c > 0 THEN
                              _NhxPt(c := c, n := USINT_TO_INT(xDev^.cf.rom),x:=227);
                              yTx1 := xPt^.cf.Name;
									END_IF;

                  253 :     // hodnota DEV ulozena v pointri, naformatovana ako text
                           xPtD  := ADR(xO^.cf.n);
                           xPtC  := UDINT_TO_PTR(xPtD^);
                           yTx1  := xPtC^;            // vystredene cislo

                  254 :     // to co je v ob.fmt
                              yTx1 := xO^.fmt;            // text
									// 99.5%  123.14578

                  ELSE     // nazov DEV
//                 rj := _Nh_Sty[xO^.fn];

                              IF xO^.cf.n = 0 THEN
                                 yTx1 := CONCAT('Err-6. cf:',USINT_TO_STRING(xO^.cf.c));
                              ELSE
                                 _NhxPt(c := xO^.cf.c, n := xO^.cf.n,x:=28);
                                 yTx1 := xPt^.cf.Name;
                              END_IF;
                  END_CASE;
                  // pocet znakov
///*** 15.10.22 - pocet znakov sa vypocita z .w, nie cf.p
                  yTx1 := LEFT(yTx1 , xO^.w/13);
                  // dsh3 .. 20 zn
                  IF xO^.BgC > 0 THEN
                     GC_SetBgColor  (Color 	:= _NhColor[xO^.BgC], GrData := xCan);
                     rji := rji + GTEXT_STYLE_FILLBG;
                  ELSE
                     GC_SetBgColor  (Color 	:= _NhColor[0], GrData := xCan);
                  END_IF;
                  GC_SetTextSize (size 	:= INT_TO_USINT(xO^.h) , GrData := xCan);           // vyska textu
                  GC_SetFgColor  (Color 	:= _NhColor[xO^.FgC]    , GrData := xCan);           // farba textu
                  GC_SetTextstyle(style   := rji , GrData := xCan);                         // formatovanie textu zlava do prava
                  GC_MoveTo      (x := xO^.x , y := xO^.y , GrData := xCan);
                  GC_WriteText   (text    := yTx1             , GrData := xCan);           //


//                  GC_SetTextstyle(style   := 0 , GrData := xCan);                         // formatovanie textu zlava do prava


(*
            7:   // stav rolety  a lamely
						xRol	:= xDev;
						yTx1 	:= USINT_TO_STRINGF(xRol^.cx.uLam,'%4u%%');;
//						yTx1 	:= '23%';
                  _NhVal2(txt:=0, wT:=xO^.h, y:=-xR^.o.ob[2].w*10/14, FgT:=4, fmt:=1);
						yTx1 	:= USINT_TO_STRINGF(xRol^.cx.uRol,'%4u%%');;
                  _NhVal2(txt:=0, wT:=xO^.h, FgT:=3, fmt:=1);
//                 _NhVal2(obr:=119, wO:=xO^.w, x:=-100);

*)

            8:   // vykreslit oramovany farebny alebo RGB kruh, pripadne kratky text v xO^.fmt

                  set   := 1;
                  jj    := -1;
                  c     := 2;
                  yTx1  := '';
                  CASE xO^.fn OF
                    1 : rb := 1;       // kruh farba bez gradientu
                    2 : rb := 1;       // kruh RGB
                        xClr	   := ADR(xO^.cf);                // tu su data v strukture R/G/B
                        rgb      := xClr^;
                        xO^.FgC  := 255;
                        xO^.BgC  := 255;
                    3 : rb := 1;       // kruh bez gradientu , bez oramovania s textom
                        c  := 1;
                        yTx1 := xO^.fmt;
                        aTrim(txt:=ADR(yTx1), wht:=1);
                        IF xO^.Bgc = 0 THEN
                           set := 0;
                        END_IF;
                  ELSE  rb := 0;       // kruznica
                  ;
                  END_CASE;
                  _NhVal2( crc:=set,fil:=rb, wC:=xO^.w, grd := c, wL:=INT_TO_USINT(xO^.cf.p), FgC:=xO^.FgC, BgC:=xO^.BgC,    // kruznica (fil=0), kruh s oramovanim (fil:=1)
                           txt:=INT_TO_SINT(_Nh_O12(yTx1='',-1,0))  , wT := xO^.cf.p, FgT := xO^.FgC
                           );                                                                   // text

           10:   // obrazok WSB, TLA so zobrazenim bodky nad tlacitkom
                  GC_MoveTo            (x:= xO^.x, y:= xO^.y  , GrData := xCan);
                  GC_CImage   (filename := _NhFnObr(fn := xO^.fn), width := xO^.w, height := xO^.w,	GrData := xCan);
                  _NhShwBtn(btn := xO^.FgC);                                              // zobrazit BTN

           11:   // VYMAZANIE RIADKA
                  GC_SetFillStyle   (style := GFILL_STYLE_BGCOLOR, GrData := xCan);					
                  GC_SetBgColor     (Color 	:= _NhColor[7] ,GrData := xCan);		                                         // farba pozadia
                  GC_RoundBox       (fill:=1, r:=15, x:= xO^.x-50 , y:= xO^.y-kyr/2+5 , width := 90  ,height := kyr-10, GrData := xCan);
                  GC_CImage         (filename := _NhFnObr(fn := 58), width := 80, height := 80,	GrData := xCan);


           12:   // obrazok v kruhu s oramovanim, s moznostou preddefinovanych volieb gradientu

                  p  := -1;                              // nevypisuje sa text
                  IF xO^.fmt <> '' THEN
                     p  := 102;                          // vypise sa text ulozeny v xO^.fmt
                  END_IF;
                  _NhVal2( wh    := xO^.cf.c,            // ak je zadane, prebije : crc := 1; grd := 11;  FgC := 2; BgC :=  1; wC := 60;
                           crc   := xO^.btn,             // kruh farbou FgC/BgC
                           grd   := INT_TO_USINT(xO^.cf.p),      // podklad bude: 2=STYLE_FRAME : vypln:=BgC, ohranicenie:=FgC ( farba 0 nebude viditelna)
                           obr   := xO^.fn,              // obrazok - vykresluje sa vzdy
                           wO    := xO^.w,               // velkost obrazka pomerom zo sirky
                           wC    := xO^.h,               // primer kruznice / sirka boxu
                           fil   := xO^.Bgc > 0,         // len pre kruh/box s vyplnou
                           FgT   := INT_TO_USINT(xO^.cf.n), // farba textu
                           FgC   := xO^.Fgc,             // ohranicenie / kruznica

                           BgC   := xO^.Bgc,
///ZMENA 22.6.22 - pridane txt
                           txt   := INT_TO_SINT(p) );               // vypise to co je v xO^.fmt



(*

///ZMENA 22.6.22             _NhVal2( wh    := 0,                    // ak je zadane, prebije grd,crc,farby
//                  yTx1 := xO^.fmt;
                  p  := -1;
                  IF xO^.fmt <> '' THEN
                     p  := 102;
                  END_IF;
                  _NhVal2( wh    := xO^.cf.c,                    // ak je zadane, prebije grd,crc,farby
                           crc   := xO^.btn,            // kruh
                           obr   := xO^.fn,              // obrazok
                           wO    := xO^.w,               // velkost obrazka pomerom zo sirky
///ZMENA 22.6.22                           grd   := 2,                   // podklad bude STYLE_FRAME : vypln:=BgC, ohranicenie:=FgC ( farba 0 nebude viditelna)
                           grd   := INT_TO_USINT(xO^.cf.p),      // podklad bude: 2=STYLE_FRAME : vypln:=BgC, ohranicenie:=FgC ( farba 0 nebude viditelna)

                           wC    := xO^.h,               // primer kruznice / sirka boxu
                           fil   := xO^.Bgc > 0,         // len pre kruh/box s vyplnou
                           FgT   := INT_TO_USINT(xO^.cf.n), // farba textu
                           FgC   := xO^.Fgc,             // ohranicenie / kruznica
                           FgC   := xO^.Fgc,             // ohranicenie / kruznica
                           BgC   := xO^.Bgc,
///ZMENA 22.6.22 - pridane txt
                           txt   := INT_TO_SINT(p) );               // vypise to co je v xO^.fmt
*)



				13:   // slider
                  // AK xO^.h <> 0, pouzivaju sa
                  //    xO^.cf.c
                  //    xO^.cf.n
                  //    xO^.cf.p
                  // ak xO^.h = 0, xO^.cf.xx  ju volne
                  // xO^.fmt           cislo obrazka

                  pp := 15;
                  IF xL^.dsh > 1 THEN
                     pp := 15;                                                               // velkost gulicky sa zmensi
                  END_IF;
                  ix       := xO^.fn;
                  xS       := ADR(xB^.s[ ix ]);                                             // namapuje slider riadka
					   set 		:= xO^.tch;
                  nDel		:= xS^.xv;					// zapamata si poziciu slidera, pre vyhodnotenie 				
					   GC_SetLineStyle   (style   := GLINE_CAP_ROUND, GrData := xCan);                                      // hrubka oramovania gulicky (ciary)
                  GC_SetLineWidth   (Width   := 2, GrData := xCan);                                      // hrubka oramovania gulicky (ciary)
                  GC_SetFgColor     (Color 	:= _NhColor[2], GrData := xCan);                            //
                  GC_Line           (x1:= xO^.x, x2:= xO^.x + xO^.W, y1:=xO^.y,y2:=xO^.y, GrData := xCan);// siva zakladna ciara
                  IF xS^.tun THEN      // zoom slider
                     ix       := xO^.x+xO^.w/2;                                                                 // stred slidera
                     GC_SetFillStyle(style   := GFILL_STYLE_FRAME, GrData := xCan);					          // kruh
                     GC_SetFgColor  (Color 	:= _NhColor[0], GrData := xCan);                                // kruznica okolo kruhu
                     GC_SetBgColor  (Color 	:= _NhColor[0], GrData := xCan);                                // kruh
                     GC_Circle      (fill := 1, r:= 15, x := xO^.x+xO^.w, y := xO^.y , GrData := xCan);              // nastavi sa na '+' a zmaze podklad
                     GC_CImage      (filename := _NhFnObr(fn := 32 ), width := 33, height := 33,	GrData := xCan); // +
                     GC_Circle      (fill := 1, r:= 15, x := xO^.x, y := xO^.y , GrData := xCan);                    // nastavi sa na '+' a zmaze podklad
                     GC_CImage      (filename := _NhFnObr(fn := 55 ), width := 33, height := 33,	GrData := xCan);  // -
                     _NhSldVal();                                                                                    // vlozi hodnotu do vr
							kr	:= vr;		// zapamata si povodnu hodnotu
                     IF set  THEN                                                             // set z webu
                        aSys.chg := true;
                        xS^.xv   := LIMIT(xA^.tch.x2, xO^.x, xO^.x + xO^.w);                                // osetrenie pozicie gulicky
                        p        := (xS^.xv-ix) / (xO^.w/20);                                  // koeficient 1..4 podla vzdialenosti od stredu

                        IF xA^.tch.Qf THEN                                                                       // vyhodnoteni clicku alebo uvolnenie press
                           IF xA^.tch.tme < 250 THEN                                                      // koniec click
                              vr       := vr + (xS^.ink * INT_TO_REAL(p));
                           END_IF;
//                        ELSIF SYSTEM_S.F_EDGE_500ms = false THEN
                        ELSIF SYSTEM_S.F_EDGE_1SEC = false THEN
									;
                        ELSIF xA^.tch.tme > 4000 THEN                                                      // koniec click
                           vr := vr + (xS^.ink * INT_TO_REAL(p))*3.0;
                        ELSIF xA^.tch.tme > 2000 THEN                                                      // koniec click
                           vr := vr + (xS^.ink * INT_TO_REAL(p))*2.0;
                        ELSIF xA^.tch.tme > 400 THEN                                                      // koniec click
                           vr := vr + (xS^.ink * INT_TO_REAL(p));
                        END_IF;
                        GC_MoveTo      (x:= ix, y:= xO^.y  , GrData := xCan);                              // nastavit do stredu
                        GC_SetFgColor  (Color   := _NhColor[xO^.BgC], GrData := xCan);                     // farba aktivnej ciary
                        GC_SetLineWidth(Width   := 10, GrData := xCan);                                    // hrubka ciary
                        GC_LineTo      (x:= xS^.xv, y:=xO^.y, GrData := xCan);
                        GC_SetLineWidth(Width   := 4, GrData := xCan);                                    // hrubka ciary
                        GC_SetFgColor  (Color   := _NhColor[0], GrData := xCan);                           // ohranicenie = farba podklad
                        GC_SetBgColor  (Color   := _NhColor[4], GrData := xCan);                           // biela gulicka
                        GC_cCircle      (fill := 1, r:= 17, GrData := xCan);                               // biela gulicka na pozicii dotyy
                     END_IF;
                     GC_SetFgColor  (Color   := _NhColor[0], GrData := xCan);                                  // kruznica
                     GC_SetBgColor  (Color   := _NhColor[2], GrData := xCan);                                  // siva gulicka
                     GC_SetLineWidth(Width   := 4, GrData := xCan);                                      // hrubka oramovania gulicky (ciary)
                     GC_Circle      (fill := 1, r:= 17, x := ix, y := xO^.y , GrData := xCan);                 // kruznica v strede slidera

                  ELSIF xS^.sld THEN      // klasicky slider
                     mie := INT_TO_REAL(xO^.w)/(xS^.v2-xS^.v1);        // mierka
                     GC_SetFillStyle(style   := GFILL_STYLE_FRAME, GrData := xCan);					          // kruh
                     IF set = false AND xS^.tep THEN                                                     // vykresluje teplomer hodnty va
                        aSys.chg := true;
                        GC_SetLineWidth(Width   := 3, GrData := xCan);                                      // hrubka oramovania gulicky (ciary)
                        GC_SetFgColor  (Color   := _NhColor[2], GrData := xCan);                         // sive oramovanie
                        GC_SetBgColor  (Color   := _NhColor[0], GrData := xCan);
                        GC_RoundBox    (fill:=1, r:=10,  x := xO^.x, y := xO^.y-3, width := xO^.W ,height := 10, GrData := xCan);  // aktivna plna hruba ciara
                        GC_SetBgColor  (Color 	:= _NhColor[xO^.BgC], GrData := xCan);                   // farba aktuvnej gulicky
                        _NhSldVal();               // vlozi hodnotu do vr
                        xS^.xv 	:= xO^.x + REAL_TO_INT(   (vr-xS^.v1) * mie    );
                        IF xS^.xv > xO^.x AND vr > xS^.v1 THEN      // gulicka je v slideri
                           GC_SetFillStyle(style   := GFILL_STYLE_BGCOLOR, GrData := xCan);					          // kruh
                           GC_RoundBox    (fill:=1, r:=10,  x := xO^.x-1, y := xO^.y-5, width := xS^.xv-xO^.x+5 ,height := 13, GrData := xCan);  // aktivna plna hruba ciara
                        END_IF;
                     ELSE
                        GC_SetFgColor  (Color   := _NhColor[0], GrData := xCan);
                        IF set  THEN                                                                         // set z webu
                          xS^.xv      := MAX(xO^.x , MIN(xA^.tch.x2 , xO^.x + xO^.w));                                              // pozicia gulicky od 0 po dotyk
                          vr          :=  xS^.v1 + (INT_TO_REAL(xS^.xv - xO^.x))/ mie;
                        ELSE                          // len zobrazi                                                                              // hodnota z premennej
	                        _NhSldVal();               // vlozi hodnotu do vr
									kr			:= ROUND(vr);		// zapamata si povodnu hodnotu
      	                  xS^.xv 	:= xO^.x + REAL_TO_INT(   (vr-xS^.v1) * mie    );
                        END_IF;
                        IF xS^.xv > xO^.x AND vr > xS^.v1 THEN      // gulicka je v slideri
(*
									IF xR^.h.cf.c = 12 THEN
										GC_SetBgColor     (Color := _NhColor[30], GrData := xCan);
									ELSE	
										GC_SetBgColor     (Color := _NhColor[xO^.BgC], GrData := xCan);
   								END_IF;
*)									
									GC_SetBgColor     (Color := _NhColor[xO^.BgC], GrData := xCan);
									IF false  THEN
                              GC_SetLineWidth(Width   := 3, GrData := xCan);                                      // hrubka oramovania gulicky (ciary)
                              GC_RoundBox       (fill:=1, r:=8,  x := xO^.x, y := xO^.y-5, width := (xS^.xv - xO^.x) ,height := 13, GrData := xCan);  // aktivna plna hruba ciara
                              GC_SetBgColor     (Color 	:= _NhColor[xO^.FgC], GrData := xCan);                                     // farba aktuvnej gulicky
                              GC_Circle         (fill := 1, r:=15, x := xS^.xv, y := xO^.y , GrData := xCan);                      // gulicka oramovana farbou pozadia
                           ELSE
										IF xR^.h.cf.c = 12 AND xL^.brw THEN     									// u RGB zobrazuje v browsi slider konkretnou farbou
		          						_NhxPar (cp := aCfg[xF^.cf.c].par , np := xDev^.al.ou.par,x:=-1013);
											GC_SetBgColor     (Color := RGBA_TO_COLOR(	r := xPar^.rgb.lvl[1],g := xPar^.rgb.lvl[2],	b := xPar^.rgb.lvl[3], a:=0)
													, GrData := xCan);
										ELSE	
											GC_SetBgColor     (Color := _NhColor[xO^.BgC], GrData := xCan);
   									END_IF;
                              GC_SetLineWidth(Width   := 5, GrData := xCan);                                      // hrubka oramovania gulicky (ciary)
                              GC_RoundBox       (fill:=1, r:=10,  x := xO^.x, y := xO^.y-7, width := (xS^.xv - xO^.x) ,height := 18, GrData := xCan);  // aktivna plna hruba ciara
//                              GC_SetBgColor     (Color 	:= _NhColor[xO^.FgC], GrData := xCan);                                     // farba aktuvnej gulicky
                              GC_Circle         (fill := 1, r:= 22, x := xS^.xv, y := xO^.y , GrData := xCan);                      // gulicka oramovana farbou pozadia
                           END_IF;
                           xS^.bal        := true;
                        ELSE
                           xS^.bal        := false;
                           GC_SetBgColor     (Color := _NhColor[2], GrData := xCan);
                           GC_Circle         (fill := 1, r:= pp, x := xO^.x+3, y := xO^.y , GrData := xCan);                     // kruznica okolo gulicky ciernou farbou
                        END_IF;
                     END_IF;
                  END_IF;


                  IF set THEN                                                    // je dotyk = nastavuje sa
                    // zaokruhlenie
                     IF xS^.ink < 0.1 THEN
                        vr := ROUND(vr*100.0)/100.0;
                     ELSIF xS^.ink < 1.0 THEN
//                         xDev^.al.ou.val   := ROUND(xDev^.al.in.val*10.0)/10.0;                                         // zaokruhlit n 1.des.ciarku
                        vr := ROUND(vr*10.0)/10.0;
                     ELSE
                        vr := ROUND(vr);
                     END_IF;
                     _NhSldVal(set := true);                                     // aktualizuje sa DEV
                     IF xL^.vis THEN
                        IF xO^.h = 250  THEN                                      // neposiela sa nic
//									aSys.RefCyc     	:= 1;
                        ELSIF xO^.h = 251 THEN
                           xDev^.al.in.cmd := 7;                                 // len refresh od slideru (neovplyvni IN.val)
                        ELSIF xO^.h = 252 THEN                                   // aj CMD, aj hodnotu
                           xDev^.al.in.cmd := 7;
                           xDev^.al.in.val := vr;
                        ELSIF xO^.h = 253 THEN                                   // po uvolneni slidera posle CMD z objektu
									IF xS^.ref > 0  THEN												// pri zmene hodnoty podiela signal
										xPtB 	:= UDINT_TO_PTR(xS^.ref);
          							xPtB^ :=  nDel<> xS^.xv;									// len zmena pozicie slidera = zmena hodnoty
         						END_IF;
                        ELSIF xO^.h = 254 THEN                                   // po uvolneni slidera posle CMD z objektu
									;
                        ELSIF xO^.h < 0 THEN
                           xDev^.al.in.cmd := INT_TO_USINT(xO^.h * -1);          // vlastnu hodnotu (prevedie z - na +)
                           xDev^.al.in.par := xO^.cf.p;
                           xDev^.al.in.val := vr;
                        ELSIF xO^.h = 8 THEN                                     // RGB neposiela in.Val
                           xDev^.al.in.cmd := INT_TO_USINT(xO^.h);
                           xDev^.al.in.par := xO^.cf.p;
                        ELSIF xO^.h > 0 THEN
                           xDev^.al.in.cmd := INT_TO_USINT(xO^.h);               // kompletu hodnotu (7)
                           xDev^.al.in.par := xO^.cf.p;
                           xDev^.al.in.val := vr;
								END_IF;
                     END_IF;
                     _NhDevRef(xR := xDev);
							IF xA^.tch.Qf THEN
								xDev^.ok.DevRef	:= true;											// dev si urobi refresh nastaveni
							END_IF;
						END_IF;
                  // vypis hodnoty
                  yTx1 := LEFT(xS^.fmt,1);                                                               // prvy znak urcuje typ vypisu
                  yTx2 := DELETE(xS^.fmt,1,1);                                                           // z formatu sa vymaze riadiaci prvy znak
                  IF xS^.fmt = '' THEN                                                             // nevypisuje sa hodnota
                     yTx1 := '';                                                                         // nevypise sa hodnota
                  ELSIF yTx1  = '>' THEN                                                                    // vypisuje sa za slider
                     GC_MoveTo   (x := xO^.x + xO^.w + 95, y := xO^.y, GrData := xCan);
                     yTx1 := REAL_TO_STRINGF(vr,yTx2);
                  ELSIF xS^.fmt <> ''   THEN                                                             // treba vypisat hodnotu
                     GC_MoveTo   (x := xO^.x + xO^.w + 10, y := xO^.y-40, GrData := xCan);        // nad slider vpravo
                     yTx1  := LEFT(xS^.fmt,3);
                     Tx    := LEFT(xS^.fmt,1);
                     IF Tx = 'L' THEN                          														// LVL 254 -> 100%
                        yTx1  := REAL_TO_STRINGF(vr/2.54,yTx2);
                     ELSIF Tx = '-' THEN                          													// opacne znamienko
                        yTx1  := REAL_TO_STRINGF(vr*-1.0,yTx2);
                     ELSIF Tx = '.' THEN                          													// opacne znamienko
                        yTx1  := REAL_TO_STRINGF(vr*0.1,yTx2);
							ELSIF yTx1 = 'h%T'  THEN                                                               // minuty,hod
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*1000.*60.*60.),yTx2);
							ELSIF yTx1 = 'm%T'  THEN                                                            // minuty,hod
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*1000.*60.),yTx2);
                     ELSIF yTx1 = '3%T'  THEN                                                            // kazdych 30 sec
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*1000.*15.),yTx2);
                     ELSIF yTx1 = '1%T'  THEN                                                            // kazdych 100ms
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*100),yTx2);  //'%Thh:mm h');
                     ELSIF yTx1 = '2%T'  THEN                                                            // kazdych 10ms
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*10.),yTx2);  //'%Thh:mm h');
                     ELSIF yTx1 = '3%T'  THEN                                                            // kazdych 10ms max 1000ms
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*10.),yTx2);  //'%Thh:mm h');
                     ELSIF yTx1 = '5%T'  THEN                                                            // kazdych 50ms
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*50.),yTx2);  //'%Thh:mm h');
                     ELSIF yTx1 = '0%T'  THEN                                                            // 1 ms
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr),yTx2);
                     ELSIF yTx1 = 's%T'  THEN                                                            // 1.s
                        yTx1  := TIME_TO_STRINGF(REAL_TO_TIME(vr*1000.),yTx2);  //'%Thh:mm:ss');
                     ELSIF tx = 'c'  THEN                                                                // pocet cyklov * 30ms
                        yTx1 := UINT_TO_STRINGF(REAL_TO_UINT(vr) * 30,yTx2);
                     ELSIF yTx1 = 'Q.V'  THEN                                                            // xDev^.ou.val
                        yTx2 := DELETE(xS^.fmt,3,1);                                                           // z formatu sa vymaze riadiaci prvy znak
                        yTx1 := REAL_TO_STRINGF(xDev^.al.ou.val,yTx2);
                     ELSE yTx1 := REAL_TO_STRINGF(vr,xS^.fmt);                                           // ine ako cas
                     END_IF;
                  ELSE
                     yTx1 := '';                                                                         // nevypise sa hodnota
                  END_IF;
                  // hodnota
                  IF yTx1 <> '' AND xO^.set6 = false THEN
                     _NhVal2(txt := 0, fmt := 1, wt:= 30, FgT := xO^.FgC, noxy := 1);
                  END_IF;
                  // vykreslenie obrazka
                  yTx3 := MID(xO^.fmt,3,1);
                  pp := STRING_TO_INT(yTx3);
                  IF pp > 0 THEN                                                                // obrazok slidera
                     GC_MoveTo   (x := xO^.x + 20 , y := xO^.y - 50, GrData := xCan);
                     GC_CImage   (filename := _NhFnObr(fn := pp), width := 50, height := 50,	GrData := xCan);
                     xO^.cf.p := 60;

                  END_IF;
                  // popis slidera
                  IF xS^.txt > 0 THEN                                                                // popis slidera nad sliderom zlava
                     _Nh_Lang(id :=  xS^.txt ,txt := ADR(yTx1));
                     _NhVal2(txt:=0, fmt:=0, wt:=25, FgT:=xO^.BgC, xy:= 1, x:= xO^.x + xO^.cf.p , y := xO^.y-40);  // v xO^.cf.p je korekcia x-suradnica ak sa vypisuje obrazok
                  END_IF;


            14:  // SLIDER s viacrymi pointmi a zobrazenim boxu,hodnoty obrazka - je len jeden
                  IF _Nh_Poi_SLD() = false THEN
							;
                  END_IF;

            15:  // SLIER typových dní  + Light,Heat....
(*
                  IF _Nh_Typ_Day() = false THEN

                  END_IF;

*)

            16:  // BOOL premenna ON/OFF - reprezentovana dvojstavovym obrazkom

                  // xO^.x, y - suradnica zobrazenia obrazka bool premennej
                  // xS^.v1 - cislo obrazka ked je BOOL = 0
                  // xS^.v2 - cislo obrazka ked je BOOL = 1

                  i  := INT_TO_USINT(xO^.fn);
                  xS := ADR(xB^.s[ i ]);                                             // namapuje slider riadka
                  IF xS^.txt > 0 THEN
                     _Nh_Lang(id :=  xS^.txt ,txt := ADR(yTx1));
                     GC_SetFgColor  (Color := _NhColor[xO^.FgC], GrData := xCan);
                     GC_SetTextstyle(style   := _Nh_Sty[0], GrData := xCan);                         // formatovanie textu zlava do prava
                     GC_SetTextSize (size 	:= INT_TO_USINT(xO^.h), GrData := xCan);                // vyska textu
                     GC_MoveTo      (x := xS^.xv, y := xO^.y, GrData := xCan);
                     GC_WriteText   (text    := yTx1, GrData := xCan);                               //
                  END_IF;
                  xPtB := UDINT_TO_PTR(xS^.vb);
                  IF tch THEN                                                             // set z webu
                     aSys.chg    := true;
                     xPtB^       := NOT xPtB^;
                     tch         := 0;
                     xO^.tch     := 0;
                  END_IF;
                  p := REAL_TO_INT(xS^.v1);
                  IF xPtB^ THEN
                     p := REAL_TO_INT(xS^.v2);
                  END_IF;
                  GC_MoveTo   (x := xO^.x, y := xO^.y, GrData := xCan);
                  GC_CImage   (filename := _NhFnObr(fn := p), width := xO^.w, height := xO^.w,	GrData := xCan);


           18:   // ciara
                  GC_SetLineWidth   (Width   := INT_TO_USINT(xO^.fn), GrData := xCan);
                  GC_SetFgColor  (Color 	:= _NhColor[xO^.fgC], GrData := xCan);
                  GC_MoveTo      (x := xO^.x, y:= xO^.y, GrData := xCan);
                  GC_LineFwd     (length := xO^.w  , GrData := xCan);


           19:   // vypisanie hodnoty z premennej + kruhovy podklad pri > 0, BEZ pouzitia vety slideru (zo sliderom je to pre kompatibilitu v 21 :)

                  xPtD  := ADR(xO^.cf.n);                                              // na adrese xO^.cf.n + xO^.cf.p je adresa premennej v UDINT
                  xPtR  := UDINT_TO_PTR(xPtD^);                                        // pointer prvej bool premennej / pola
                  rb    := _NhKnvVal(typ := xO^.cf.c );                                // vlozi hodnotu po konverzii do vr

                  IF FIND(xO^.fmt,'%T') > 0 THEN
                     xPtT  := xPtr;
                     IF xPtT^ > USINT_TO_TIME(0) THEN
                        yTx1  := TIME_TO_STRINGF(xPtT^,xO^.fmt);                                // xO^.fmt naformatuje
                     ELSE
                        yTx1  := '';                                // xO^.fmt naformatuje
                     END_IF;
                  ELSIF FIND(xO^.fmt,'d') > 0 THEN
                     o     := REAL_TO_USINT(vr);
                     yTx1  := USINT_TO_STRINGF(o,xO^.fmt);                                // xO^.fmt naformatuje
                  ELSE
                     yTx1  := REAL_TO_STRINGF(vr,xO^.fmt);                                // xO^.fmt naformatuje
                  END_IF;
                  o     := 0;                                     // cislo textu (0=to coje v yTx1)
                  s     := 0;                                     // wh
                  pp    := xO^.w;                                 // primer kruhu podkladu
                  IF xO^.fn > 0 THEN                            // ma nejaky podklad (podla s)
                     IF vr = 0.0 THEN
                        s := 10;
                     ELSE
                        IF FIND(xO^.fmt,'ON') > 0 THEN
                           yTx1  := xO^.fmt;                                // xO^.fmt naformatuje
                        END_IF;
                        s := INT_TO_USINT(xO^.fn);
                     END_IF;
                  END_IF;
                  _NhVal2(crc := xO^.fn > 0, txt := USINT_TO_SINT(o), fmt := USINT_TO_INT(xO^.BgC) , wT := xO^.h, wC := pp , FgT := xO^.FgC, wh:= s, grd := 11, fil:=1);

            20:  // specialne zobrazenie / check nad polom obrazkov (...struktura day)
                  // xO^.fn      :  cislo textu vypisovane od pevne definovanej pozicie
                  // xO^.FgC     :  0/1/2,3 - podla CASE
                  // xO^.BgC     :  x-ova suradnica zaciatku textu
                  // tch         :  nad niektorym z obrazkov bol dotyk
                  // xO^.w       :  velkost obrazka
                  // xO^.cf.c    :  pocet obrazkov  ( := 0 znamen ze je len jedne obrazok)
                  // xO^.h       :  vzdialenost medzi obrazkami
                  // xO^.cf.n    :  adresa premennej  ( xO^.cf.n+xO^.cf.p )
               	// xO^.Set1		: 	vybera sa len jeden objekt zo zoznamu
					
                  IF xO^.fn > 0 THEN                                                                // vypisuje sa text
                     _Nh_Lang(id :=  xO^.fn ,txt := ADR(yTx1));
                     GC_SetFgColor  (Color := _NhColor[4], GrData := xCan);                        // biela
                     GC_SetTextstyle(style   := _Nh_Sty[0], GrData := xCan);                       // formatovanie textu zlava do prava
                     GC_SetTextSize (size 	:= 24, GrData := xCan);                               // pevna vyska textu
                     GC_MoveTo      (x := USINT_TO_INT(xO^.BgC), y := xO^.y, GrData := xCan);      // pevny zaciatok textu
                     GC_WriteText   (text    := yTx1, GrData := xCan);
                  END_IF;


                  xPtD  := ADR(xO^.cf.n);                                                             // na adrese xO^.cf.n + xO^.cf.p je adresa premennej v UDINT
                  xPtB  := UDINT_TO_PTR(xPtD^);                                                       // pointer prvej bool premennej / pola
                  i     := 0; s :=  xO^.cf.c;
						IF	xO^.Set1	THEN														// viac objektov vedla seba, ale vybera sa len jeden do xPtS
                     xPtS  := UDINT_TO_PTR(xPtD^);
                  ELSIF xO^.cf.c > 0 AND xO^.h = 0 THEN                          // viac objektov na sebe, cislo objektu je ulozene v premennej, ktora je USINT
                     xPtU  := UDINT_TO_PTR(xPtD^);
                     i     := xPtU^;                                          // cislo objektu
                     s     := i;                                              // iba tento objekt ON/OFF
						END_IF;
                  WHILE i <= s DO
                     IF tch THEN //AND xA^.tch.row = row AND xA^.tch.obj = 5 THEN
                        IF xA^.tch.x1 < xO^.x + xO^.h * USINT_TO_INT(i) + xO^.w/5*3 THEN
									IF	xO^.Set1	THEN												// vybera sa cislo objektu
										xPtU^		:= i;		                          		// ostatne objekty sa vymazu
										i 			:= 0;
                        	ELSE
                           	xPtB^    	:= NOT xPtB^;                        	
									END_IF;
                           	

                           aSys.chg    := true;
                           tch      	:= 0;
                           xO^.tch  	:= 0;
                           xDev^.ok.ref  := true;                            // vseobecny refresh
								END_IF;
                     END_IF;
                     c := BOOL_TO_USINT(xPtB^);
                     CASE xO^.FgC OF
                        1 : p := _NhListObr.Day [c,i];                       // DayMode
                        2 : p := _NhListObr.Led [c,i];                       // Led G/R
                        3 : p := _NhListObr.LedR[c,i];                       // Led R/G
                        4 : p := _NhListObr.Off [BOOL_TO_INT(xPtB^)];      // zablokovat : OFF/ON
                        5 : p := _NhListObr.Dark[BOOL_TO_INT(xPtB^)];      // Dark 0/1
                        6 : p := _NhListObr.Day [1,i];                       // prepinat orazky DayMode na sebe - LEN ZAPNUTE
                        7 : p := _NhListObr.Pir [c,i];                       // DayMode
                        8 : p := _NhListObr.run [c];                         // Run 0/1
                        9 : p := _NhListObr.ko  [BOOL_TO_INT(xPtB^)];      // 1/0 OFF/ON
                       10 : p := _NhListObr.RGB [i];                       // prepinat LED : gray/R/G/B/W/A - len zapnute
                       11 : p := _NhListObr.rgbwa [1,i];                       // prepinat orazky DayMode na sebe - LEN ZAPNUTE
                       12 : p := _NhListObr.Day2 [c,i];                    // len Day/Evening/night/morning
                       13 : p := _NhListObr.Lck2 [c,i];                   	// len Unlock/lock/Light/Dark
                       14 : p := _NhListObr.man [i];                       // prepinat obrazok manual ON/OFF
					        ELSE p := _NhListObr.ok  [BOOL_TO_INT(xPtB^)];      // 0/1 ON/OFF
                     END_CASE;
                     GC_MoveTo   (x := xO^.x + xO^.h * USINT_TO_INT(i) , y := xO^.y, GrData := xCan);
                     GC_CImage   (filename := _NhFnObr(fn := p), width := xO^.w, height := xO^.w,	GrData := xCan);
                     xPtB  := xPtB  + 1;
                     i     := i     + 1;
                  END_WHILE;

            21:  // Jednoduchy check dvoch volitelnych obrazkov do bool premennej s TEXTOM
                  // xO^.fn      :  cislo textu
                  // xO^.FgC     :  farba textu
                  // xO^.BgC     :  x-suradnica zaciatku textu
                  // xO^.h       :  vyska textu vzdialenost medzi obrazkami
                  // xO^.cf.n    :  adresa premennej  ( xO^.cf.n+xO^.cf.p )
                  // xO^.fmt     :  obrazky [OFF, ON]
						IF xO^.fmt = '' THEN
							xO^.fmt := ' 35 38';					// uncheck/check
						END_IF;
                  _NhVal2(txt:=-2, nTxt:= xo^.fn, fmt:=0, wt:=xO^.h, FgT:=xO^.FgC, xy:=true, x:=USINT_TO_INT(xO^.BgC), y:=xO^.y );
                  xPtD  := ADR(xO^.cf.n);                                                             // na adrese xO^.cf.n + xO^.cf.p je adresa premennej v UDINT
                  xPtB  := UDINT_TO_PTR(xPtD^);                                                       // pointer prvej bool premennej / pola
                  IF tch THEN
                  	xPtB^    	:= NOT xPtB^;
                     tch      	:= 0;
                     xO^.tch  	:= 0;
                  END_IF;
						IF xPtB^ THEN
                    yTx1  := MID(xO^.fmt,3,4) ;
						ELSe
                    yTx1  := MID(xO^.fmt,3,1) ;
						END_IF;
                  _NhVal2(obr:=STRING_TO_INT(yTx1), wO:=xO^.w);





            22:  // prevolby pre pre regulator: HET/VEN, TVE,KOT - vykreslenie HEAT obrazkov s hodnotou nad aktivnym obrazkom
		            _Nh_FRM_Read(frm:=229);                        // obrazky pre typ NH_OBR_OPV
                  xHet  := xDev;
                  xTve  := xDev;
						ok1	:= false;
      				xPvA  := ADR(xTve^.cx.par.pva);                 // default HET,TVE,KOT,CER
						c		:= 2;													// default TVE,KOT,CER,VEN/REK
                  CASE xR^.h.cf.c OF						
                    6 : // HET
								c		:= 0;		
								ok1	:= true;
                   47 : // HEv
								c		:= 1;
								ok1	:= true;
                    7 : ;// KOT
                    8 : // TVE
                    9 : // CER
                   23 : ;// VEN,REK
						END_CASE;
						IF ok1 THEN  // 6=HET,47=HEV
							o := aCfg[xR^.h.cf.c].par;
							IF xR^.h.chk   THEN													// z webu nad regulatorm sa podhodi default par
								p := xR^.h.cf.p;
							ELSIF xO^.tch  THEN
								xDev^.al.in.cmd := 1;											// preusi Delay za svetlom {HVE}, a korektne prijme prikaz
								xDev^.al.in.par := xHet^.cf.par ;
								xDev^.al.ou.par := xHet^.cf.par ;
								p	:= xDev^.al.ou.par;              	
							ELSE
								p	:= xDev^.al.ou.par;              	
							END_IF;
							_NhxPar (cp := o , np := p,x:=-1003);								
       					pHet  	:= xPar;
                     xPvA  	:= ADR(pHet^.par.pva);
       				END_IF;
						_NH_Het_Map_Reg();
                  pp          := 0;                                                         // korekcia x-suradnice BTN
                  FOR i := 0 TO 4 DO                                                  // hlada sa dotyk
                     IF xReg^.btn[i] THEN
                        IF xO^.tch  THEN
                           IF xA^.tch.x1 < xO^.x + xO^.h * USINT_TO_INT(i) + xO^.w/5*4 THEN
	                           IF xDev^.al.CM > 99 THEN                                 // zablokovanie - vysoka/nizka teplota len pre TVE
                                 ;
                              ELSIF xO^.nTch OR xReg^.BTN[i] = false THEN
                                 ;
                              ELSIF i = 0 THEN                                         // dotyk na MAN/PRG
											xPvA^.chg		:= true;	//xPvA^.p.pv = 0;                       // ten isy btn
                                 xPvA^.p.prg 	:= true;
//                                 xPvA^.p.pv  	:= 0;
                              ELSE
											xPvA^.chg		:= xPvA^.p.pv = i-1;							// ten isty btn
                                 xPvA^.p.prg 	:= false;
                                 xPvA^.p.pv  	:= i-1;              						// off=0 pri i=1,
                              END_IF;
										tch 			:= false;
                  				xO^.tch  	:= 0;
	                           IF xR^.h.chk = false THEN                              	
//											xPvA^.Qr 	:= true;												// len pri


//											xDev^.al.in.CMD := 1;


                        		ELSE
											xPvA^.chg		:= false;
//											xPvA^.Qr 	:= false;											// pri vazbe sa nedeje nic
//											xPvA2^.Qr 	:= false;												// vyvola sa okamzity refresh											                        		
										END_IF;
									END_IF;
                        END_IF;	// koniec TCH, uz sem viac nepride
								
								IF i = 0 THEN                                                  // obrazok MAN/AUTO
                           ok := xL^.dsh < 3;                                          // bude sa zobrazovat cas do skoncenia MAN ale len pri DSH=1
                           IF xPvA^.p.prg THEN
                              s := 1;                                                  // pri PRG sa zoberie druha sada
                           ELSE
                              s := 0;
                           END_IF;
                           IF xR^.h.chk THEN                                           // pri vazbe sa nezobrazuje ziadny cas
                              ok := false;
                           ELSIF xHet^.cx.chg.toChg = T#0s THEN
                              ok := false;                                             // nezobrazi sa cas MAN
                           ELSIF xHet^.cx.chg.toChg > T#24h           THEN
                              yTx1  := '>24h';
                           ELSE
                              yTx1  := TIME_TO_STRINGF(xHet^.cx.chg.toChg,'%Th:mm');
                           END_IF;
                        ELSE 																				// navestia nad predvolbami			
                           ok := false;                                                // default sa nezobrazi navestie nad predvolbou
                           IF xPvA^.p.prg AND xR^.h.chk and ok1 THEN                     // ak HET/VEN vo vazbe a je PRG, vsetky MAN obrazky su sive
                              s := 0;                                                  // neaktivny obrazok (PV)
                           ELSIF xPvA^.p.pv = i-1 THEN                                   // vybrata predvolba (obrazok)
                              s     := 1;
                              ok    := false;
										IF xRegMod^.wht = 1 THEN
										   IF xRegMod^.req[xPvA^.p.pv] <> 0.0 THEN
										   	ok 	:= true;
	      									yTx1	:= REAL_TO_STRINGF (xRegMod^.req[xPvA^.p.pv], yFrm_229.reg[c].zn[ xReg^.Mode, 1] );
											END_IF;
										ELSIF xRegMod^.out[xPvA^.p.pv] <> 0 THEN
      									ok 	:= true;
											yTx1	:= USINT_TO_STRINGF(xRegMod^.out[xPvA^.p.pv], yFrm_229.reg[c].zn[ xReg^.Mode, 0] ) ;
										END_IF;
									ELSE
                              s := 0;                                                  // neaktivny obrazok (PV)
                           END_IF;
                        END_IF;
                        // zobrazit obrazky PV
                        _NhVal2(obr :=  yFrm_229.reg[c].mode[ xReg^.Mode, s, i] , wO := xO^.w, x := pp);
                        // zobrazit cisla v navesti
                        IF ok THEN
                           xR^.o.ob[9].wh := 0;                                                    // zablokuje nazov miestnosti
                           _NhVal2(txt := 0, fmt := 2, wT := 24, FgT := 5, x := pp, y := -39 );    // vypise cas do skoncenia MAN
                        END_IF;
						
						   END_IF;
                     pp := pp + xO^.h;
                  END_FOR;

            23:  // prepinac medzi riadkami podla zoznamu v _NhTypeMnu.mnu[i,cmd] vysledok do premennej USINT
                  // xO^.cf.c          pocet volieb (riadkov)
                  // xO^.cf.n          adresa premennej
                  // xO^.h             vyska textu
                  // xO^.fn            vzdialenot medzi riadkami (y-ova suradnica)
                  // xO^.FgC           farba textu pri zhode
                  // xO^.BgC           farba textu bezna (siva)
                  // xFmt23^.wht       cislo prveho riadka v _NhTypeMnu.mnu[wht, kde zacina menu
                  // xFmt23^.txt       cislo textu, ktore sa vypise nad vyberom
                  // xFmt23^.obj       cislo vybratej volby
                  // _NhTypeMnu.mnu[[xFmt23^.wht,0]   cislo textu 1.volby
                  // _NhTypeMnu.mnu[[xFmt23^.wht,1]   cmd/vyber, ktory sa zapisuje do premennej

(*
                  xPtD        := ADR(xO^.cf.n);
                  xPtU        := UDINT_TO_PTR(xPtD^);                               // premenna do ktorej sa ulozicislo volby (musi byt USINT)
                  xFmt23      := ADR(xO^.fmt);                                      // struktura
                  IF xFmt23^.txt > 0 THEN
                     _Nh_Lang( id := xFmt23^.txt ,txt := ADR(yTx1));
                     yTx1 := CONCAT('     ',yTx1);
                     _NhVal2( txt:=0, xy:=1, x:= x2/2, y:=xO^.y-70, fmt:=2, FgT:=4, wt:=28);
                  END_IF;
                  xFmt23^.obj := MAX(1,MIN(xFmt23^.obj,xO^.cf.c));                                              // ak sa nenajde menu, bude 1.riadok
                  yFmt23      := xFmt23^;
                  IF tch THEN                                                    // bol dotyk
                     aSys.chg          := true;
                     xPtU^             := INT_TO_USINT(_NhTypeMnu.mnu[ xFmt23^.wht - 1 + xFmt23^.obj ,1] );    // pri dotyku vyberie CMD, odpovedajuci cisla riadku, kde bol dotyk
                     xDev^.ok.ref      := true;
                     tch               := 0;
                     xO^.tch           := 0;    ///***

                  END_IF;
                  yFmt23      := xFmt23^;
                  FOR  i:= 1  TO xO^.cf.c  DO
                     IF USINT_TO_INT(xPtU^) = _NhTypeMnu.mnu[xFmt23^.wht-1 + i,1] THEN                            // naslo sa menu, ktore ma CMD z premennej
                        xFmt23^.obj := i;                                        // cislo volby s CMD
                        EXIT;
                     END_IF;
                  END_FOR;
                  pp := 0;
                  FOR  i:=1  TO xO^.cf.c  DO
                     IF xFmt23^.obj = i THEN                            // naslo sa menu, ktore ma CMD z premennej
                        xPtU^ := INT_TO_USINT(_NhTypeMnu.mnu[xFmt23^.wht-1 + i,1]);
                        o   := xO^.FgC;
                        set := 1;
                     ELSE
                        set := 0;
                        o   := xO^.BgC;
                     END_IF;
                     _Nh_Lang( id    := _NhTypeMnu.mnu[xFmt23^.wht-1 + i,0] ,txt := ADR(yTx1));
                     yTx1 := CONCAT('     ',yTx1);
                     _NhVal2( crc:=1,
                              fil   := set,
                              grd   := 1,
                              FgC   := o,
                              BgC   := o,
                              wC    := 22,             // wl=priemer gulicky, wl=hrubka kruznice
                              txt   := 0,
                              fmt   := 0,
                              wT    := xO^.h,
                              FgT   := o,
                              y     := pp, );                          // zlava do prava, to co je v yTx1
                     pp := pp + xO^.fn;

                  END_FOR;
*)

            24:  // prepinac niekolko obrazkov na sebe - dotykom sa prepinaju ukladanu sa do premennej typ bool, usint,sint
						// xO^.cf.c	: max pocet obrazkov
						// xO^.cf.n : adresa premennej ... PTR_TO_UDINT
						// xO^.fn 	: typ premennej 0=real,1:usint,4:bool, ktora urcuje obrazok.
						// xO^.Fgc  : 0 = cisla obrazkov su vo xO^.fmt
						//            1 = pole obrazkov
						// xO^.fmt	: max 3 cisla obrazkov '512 55 22'
						//

                  xPtD  := ADR(xO^.cf.n);                   // adresa premennej
                  xPtR  := UDINT_TO_PTR(xPtD^);
                  _NhKnvVal(typ := INT_TO_USINT(xO^.fn));   //  Hodnotu z premennej ulozi do 'vr'
                  IF tch THEN
                  	aSys.chg    := true;
                     xO^.tch  := 0;
                     IF vr = USINT_TO_REAL(xO^.cf.c) THEN
                        vr := 0;
                     ELSE
                        vr := vr + 1;
                     END_IF;
                     _NhKnvSet(typ := INT_TO_USINT(xO^.fn));                            // zmenu vo 'vr' ulozi do premennej
                  END_IF;
                  IF xO^.Fgc = 0 THEN                                  // cisla obrazkov su v xO^.fn (maximalne 3)
                     yTx1  := MID(xO^.fmt,3,REAL_TO_UINT(vr)*3+1) ;
                     p     := STRING_TO_INT(yTx1);
                  ELSE
                     // dorobit odkaz na pole obrazkov
                  END_IF;
                  _NhVal2(obr := p , wO := xO^.w);

            120:  // LEDs na wsb
                  xTgl  := xDev;
//                  xCfL  := ADR(xTgl^.cx.cfL);
                  p     := xO^.x;
                  FOR i := 1 TO xTgl^.cx.Cfc.nBTNs DO                              // pocet btn
                     o := 4;                                               // default je ze ziadna LED nesvieti = sivy obrazok
                     FOR ii := 1 TO 3 DO                                   // R-G-B  (orange)
                        IF xTgl^.cx.cfL.LEDs.btn[i].rgb[ii] THEN
                           o  := ii;                                       // zapamata rozsvietenu LED
									EXIT;
                        END_IF;
                     END_FOR;
                     xTgl^.cx.cfL.LEDs.btn[i].rgb  := _eBtn3;
                     IF xO^.tch AND xA^.tch.x1 <= p + xO^.h/2 THEN         // dotyk nad BTN (u WSB 1btn=Up+Dn)
                        xO^.tch  := 0;
                        tch      := 0;
                        IF o > 3 THEN                                      // nic nesviti,
                           o  := 1;                                        // po dotyku sa prepne na 1.LEd=RED
                        ELSE
                           o := o + 1;                                     // dalsia LED v poradi R-G-B
                        END_IF;
								xTgl^.cx.cfL.etSlp := -2;                                 // len prebudit ale neblikat
                     END_IF;
                     IF o < 4 THEN                                         // ak niektora z R-G-B ma svitit
								xTgl^.cx.cfL.LEDs.btn[i].rgb[o] := 1;
                     END_IF;

//								xTgl^.cx.cfL.LEDs.btn[6].rgb[2] := 1;

                     GC_MoveTo   (x := p , y := xO^.y, GrData := xCan);
                     GC_CImage   (filename := _NhFnObr(fn := USINT_TO_INT( _NhObrLeds[o] )), width := 50, height := 50,	GrData := xCan);
                     p := p + xO^.h;
                  END_FOR;
            121:  // LEDs na wsb

					IF _NhxPar (cp := aCfg[xR^.h.cf.c].par , np := xDev^.cf.par,x:=-1004) THEN
                  p     := xO^.x;
                  FOR i := 1 TO 5 DO                              // pocet btn
                     IF xO^.tch AND xA^.tch.x1 <= p + xO^.w/2 THEN         // dotyk nad BTN (u WSB 1btn=Up+Dn)
                        xO^.tch  := 0;
                        IF xPar^.rgb.lvl[i] > 0 THEN                                      // nic nesviti,
                           xPar^.rgb.lvl[i]  := 0;                                        // po dotyku sa prepne na 1.LEd=RED
                        ELSE
                           xPar^.rgb.lvl[i]  := 254;                                        // po dotyku sa prepne na 1.LEd=RED
                        END_IF;
								xDev^.al.in.val := 255.0;
								xDev^.al.in.cmd := 144;								
								xDev^.al.in.par := 0;								
                     END_IF;
							If xPar^.rgb.lvl[i] > 0 THEN
								pp := _NhListObr.rgbwa [1,i];
							ELSE
								pp := _NhListObr.rgbwa [0,i];
							END_IF;	
                     GC_MoveTo   (x := p , y := xO^.y, GrData := xCan);
                     GC_CImage   (filename := _NhFnObr(fn := pp ), width := xO^.w, height := xO^.w,	GrData := xCan);
                     p := p + xO^.h;
                  END_FOR;
					END_IF;														

           123:  // prepinac medzi riadkami - NOVA VERZIA - riadky maju odkaz na text. V texte je aj volba

                  j        := j + 1;                              // objekt je 2-radkovy, presunie sa na dali radok a na konci na dalsi
                  xOh      := xO;
						IF xOh^.btn THEN
							xOh^.tch  			:= false;
						ELSE
	                  pp       := xOh^.cf.y;
   	               xPtr     := UDINT_TO_PTR(xOh^.aVar);
      	            xPtU     := xPtr;
         	         ok2      := false;
            	      i        := xOh^.cf.rw1;	//1;
               	   WHILE true DO
                  	   IF i > xOh^.cf.rw2 THEN
                     	   EXIT;
	                     ELSIF xOh^.txt[i] > 0 THEN
   	                     _Nh_Lang( id    := xOh^.txt[i] ,txt := ADR(yTx1));
      	                  yTx2  	:= MID(yTx1,2,29);               // cislo volby je nakonci riadka
         	               kr    	:= STRING_TO_REAL(yTx2);         // do vr vlozi cislo volby
            	            vr    	:= kr;                           // zapamata si pre porovnanie
               	         o     	:= xOh^.FgC;
                  	      ok    	:= false;
									ii			:= REAL_TO_USINT(vr);			// cmd odpovedajuci riadku
									IF i <= 6 THEN
                           	xOh^.dummy1[i] := ii;
									END_IF;
									
	                        IF xOh^.tch THEN
										xOh^.Set0   := false;
										xOh^.cmd		:= ii;							// cmd odpovedajuci riadku
   	                       	xOh^.Qr 		:= true;							 	// dotyk: prenesie sa do funkcie, tam sa musi vynulovat
      	                     IF xA^.tch.y1 <= pp + xOh^.cf.h/2 THEN  	// aktualny riadok
         	                    	xDev^.ok.DevRef	:= true;				// DEV si urobi refresh
											xOh^.row  			:= i;
               	              	xOh^.tch  			:= false;
                  	           	IF _NhKnvSet(typ:=xOh^.cf.typ) THEN        // zapise to co je vo vr (hodnota volby z riadka)
		               	           	xOh^.Qs := true; //				:= xOh^.row <> i;	// zmena riadka
											ELSE
		                     	     	xOh^.Qs := false;
											END_IF;
	                           END_IF;
	                        ELSIF xOh^.Set0 THEN
                     	     	xOh^.Qs := false;
										IF ii = xOh^.cmd THEN
											xOh^.row  			:= i;
										END_IF;
									END_IF;
      	                  _NhKnvVal(typ:=xOh^.cf.typ);              // nacita do vr to co je v premennej
         	               IF kr = vr THEN
            	               o     := xOh^.BgC;
  	            	            ok    := true;
   	                     END_IF;
   	                     yTx1  := MID(yTx1,28,1);               // riadok bez volby
      	                  _NhVal2(
         	                     grd   := 1,
            	                  fil   := ok,
               	               FgC   := o,
                  	            BgC   := o,
                     	         FgT   := o,
                        	      wC    := 22,               // wl=priemer gulicky, wl=hrubka kruznice
                           	   txt   := 0,
                              	fmt   := 0,
	                              wT    := xOh^.cf.hTxt,
   	                           xy    := true,             // nastavuje x,y, ktore sa dalej poslu
      	                        x     := xOh^.cf.x + 40,      // text v riadku je za gulickou doprava
         	                     y     := pp );
            	            GC_Circle   (fill  := ok, x:= xOh^.cf.x, y:= pp, r:= 8,   GrData := xCan);  // kruznica
               	         pp := pp + xOh^.cf.h;
                  	      i := i + 1;
                     	ELSE
                        	EXIT;
	                     END_IF;
   	               END_WHILE;
							xOh^.Set0 := false;

      				END_IF;
		            tch      := false;



           124:  // prepinac medzi obrazkami - cislo volby sa uklada do USINT/SINT




           25:   // nastavenie casy/datumu pre (manual...)

                  xPtD  := ADR(xO^.cf.n);                   // v o.ob[1] je prva veta (je tam Year)
                  xTTdt := UDINT_TO_PTR(xPtD^);;            // pointer na strukturu TTecodt
                  xO2   := xO;                              // ob[0]
                  p     := xR^.o.ob[0].fn;                 // slider, ten ma fn nasmerovane na Slider
                  xS    := ADR(xB^.s[p]);
                  i     := 1;

                  IF xO^.btn  THEN                          // priznak zablokovania celej komponenty aj so sliderom
                     i           := 255;
                     xO2^.cf.c   := 0;
                  END_IF;

                  WHILE i <= 10 DO                           // ob[0..9]
                     IF i > 1 THEN
                        xO^.x := xO2^.x + xO^.fn;
                        xO^.y := xO2^.y;
                     END_IF;

                     IF xO^.wh > 0 THEN
                        IF xO^.wh = 25 THEN
                           IF xO^.nTch THEN
                              yTx1 := '';
                           ELSE
                              _NhTTdtV12(r:=i-1);                    // kontola a korekcia
                              IF xO^.tch THEN
                                 xO2^.cf.c := i;               // vybraty obj do 0-teho objektu
                                 xO^.tch   := false;
                              END_IF;
                              CASE xO^.h OF
                                1:  yTx1     := DayNamesSVK[xPtU^];
                                ;
                              ELSE  yTx1     := USINT_TO_STRINGF(xPtU^,'%02d');
                              END_CASE;
                           END_IF;
                        ELSE
                           yTx1  := xO^.fmt;
                        END_IF;
                        _NhVal2(
                              grd   := 1,
                              fil   := true,
                              crc   := i = xO2^.cf.c,
                              BgC   := xO2^.BgC,
                              FgT   := xO2^.FgC,
                              wC    := xO2^.w+35,              // wl=priemer gulicky, wl=hrubka kruznice
                              txt   := 0,
                              fmt   := 2,
                              wT    := xO2^.w );

                     END_IF;
                     i     := i     + 1;
                     xO    := xO    + SIZEOF(NH_OBJ_DAT);
                  END_WHILE;
                  IF xO2^.cf.c > 0 THEN
                     xR^.o.ob[0].wh := 13;                    // spristupni slider
                     c     := xO2^.cf.c;
                     xO    := ADR(xR^.o.ob[c]);
                     _NhTTdtV12(r:=xO2^.cf.c-1);
                     xS^.vb   := PTR_TO_UDINT(xPtU);
                  ELSE
                     xR^.o.ob[0].wh := 0;
                  END_IF;
                  j     := 111;
                  tch   := false;

          125:   	// nastavenie datum+cas   (typovy den, manual
               	// 0..4  YY.MM.YY HH:MM   platia suradnice x,y,w,h
               	// fmt je formatovane
						//		'.YY','.MM','DD','.HH','MM' - ak treba vypisovat navestia
               	// 	'.'  ,'.'  ,''  ,'.'  ,''   - ak netreba vypisovat navestia               	
						// xR^.o.ob[0].y - je suradnica, ktora urcuje riadok kde sa vykreluje
						// xR^.o.ob[0].y - je suradnica, ktora urcuje riadok kde sa vykreluje

						IF xR^.o.ob[0].fn = 0 THEN                         	// v 1.= hlavnom riadku {alebo jedinom} resetne vybraty objekt a zablokuje slider
							xR2	:= xR;
						ELSE
							p		:= xR^.o.ob[0].fn;								// ak su 2 datumy OD-DO, tak tu je cislo riadku "DO", ak ej 0 tak je len OD
							xR2	:= ADR(xB^.r[ p ]);                       // namapuje riadok DO
						END_IF;
						p		:= xR2^.o.ob[10].fn; 								// cislo slidera {jedineho}
					   xS  	:= ADR( xB^.s[ p ]);									// adresa slidera
					   IF xR^.o.ob[0].btn THEN										// zablokovana cela komponenta
							o	:= row*10;												// min.cislo pre vyber objektu v tomto radku
							IF xR2^.o.ob[0].FgC >= o AND xR2^.o.ob[0].FgC <= o+6 THEN  // 1.riadok je disable ale ma vybrate pole z tohto riadku
								xR2^.o.ob[0].FgC := 0;
							END_IF;
						ELSIF j > 6 THEN
								xO^.y := xR^.o.ob[0].y;                   	// text pred datumom sa preberie z hlavnej suradnice
								IF j=8 THEN												
									xO^.y := xO^.y + xR^.o.ob[j].y;				// text v urovni navestia sa upravi o korekciu (vacsinou -30)
								END_IF;								
	                     _NhVal2(
                              txt   := -2,
										nTxt	:= xO^.cf.n,							// cislo textu
                              fmt   := xO^.fn,
                              FgT   := xO^.FgC,
                              wT    := xO^.h );
						ELSE
							IF j > 0 THEN
								xO^.y 				:= xR^.o.ob[0].y;          // riadok sa prebera z 0 riadku, ktory je riadiaci
								xR2^.o.ob[10].y	:= xR^.o.ob[0].y+70;			// slider sa tiez prebera													
							END_IF;
							p			:= 30;   										// vzdialenost medzi cislami
	      	         xPtD  	:= ADR(xO^.cf.n);								
							xPtU		:= UDINT_TO_PTR(xPtD^);                // adresa pola v tomto riadku {j}
							IF xO^.tch THEN
								xR2^.o.ob[0].FgC	:= row * 10 + SINT_TO_USINT(j); 	// riadok * 10 + YY/MM/DD
								xR2^.o.ob[10].wh	:= 13;									
                        xS^.vb	:= PTR_TO_UDINT(xPtU);

		      	         xPtD  	:= ADR(xR^.o.ob[1].cf.n);				// adresa YY z aktualneho riadka
								xPtU2		:= UDINT_TO_PTR(xPtD^);
								_NhChkDTHH(wht:=xO^.FgC, dthh:=xPtU2 );		// prepocita YY.MM.DD HH:MM:SS
							END_IF;
							ok1 := xR2^.o.ob[0].FgC	= row * 10 + SINT_TO_USINT(j);

							yTx1  := MID(xO^.fmt,1,1);									// bodka, dvojbodka za cislom 	
							IF yTx1 <> '' THEN
	                     _NhVal2(
										xy		:= 1,
										x		:= xO^.x - p,								// pred cislom
										y		:= xO^.y,
                              txt   := 0,
                              fmt   := 2,
                              FgT   := 10,
                              wT    := xO^.w );
							END_IF;
							yTx1  := MID(xO^.fmt,2,2);									
							IF yTx1 <> '' AND												// je nejake navestie nad hodnotou
									(	xR^.o.ob[0].fn = 0 OR                     // a je to hlavny riadok
										xR2^.o.ob[0].btn) THEN							// alebo hlavny riadok sa nezobrazuje					

	                     _NhVal2(
										xy		:= 1,
										x		:= xO^.x,
										y		:= xO^.y-30,	//xR^.o.ob[8].y, //xO^.y-(xO^.w*3)/2,
                              txt   := 0,
                              fmt   := 2,
                              FgT   := 2,
                              wT    := xO^.w*10/12 );

							END_IF;
							yTx1  := USINT_TO_STRINGF(xPtU^,'%02d');			   // cislo z pola
   	               _NhVal2(
                              grd   := 1,
                              fil   := true,
                              crc   := ok1,
                              BgC   := 3,
                              FgC   := 3,
                              wC    := xO^.w*2,              // wl=priemer gulicky, wl=hrubka kruznice
                              txt   := 0,
                              fmt   := 2,
                              FgT   := 4,
                              wT    := xO^.w );
						END_IF;
						IF xR2^.o.ob[0].FgC = 0 THEN
							xR2^.o.ob[10].wh := 0;									// deaktivuje sa slider
						END_IF;
						xO^.tch  := false;
  		            tch   	:= false;
					

//						xR^.o.ob[10].wh	:= 0;							         // zablokuje aj slider, vzdy v [10]

(*
					   IF xR^.o.ob[0].btn THEN											// zablokovana cela komponenta
//							xR^.o.ob[10].wh	:= 0;							         // zablokuje aj slider, vzdy v [10]
						ELSIF xO^.btn = false  THEN                          	// priznak zablokovania tohto pola
							p			:= 30;   											// vzdialenost medzi cislami / 2
						   xS       := ADR( xB^.s[ 0 ]);
							IF xO^.tch THEN
								xR^.o.ob[0].BgC	:= SINT_TO_USINT(j);
//								xS^.vb				:= PTR_TO_UDINT(xPtU);
//								xS^.v1	
//								xS^.v2	
							END_IF;
	      	         xPtD  	:= ADR(xR^.o.ob[1].cf.n);						// adresa YY
							xPtU2		:= UDINT_TO_PTR(xPtD^);
						   xS       := ADR( xB^.s[ 0 ]);								// slider je vzdy s[0]
							ok1		:= xR^.o.ob[0].BgC = SINT_TO_USINT(j);	
							IF ok1 THEN
								IF xR^.o.ob[0].fn > 0 THEN                         // suvisi aj s inym datumom
									xB^.r[ xR^.o.ob[0].fn ].o.ob[0].BgC := 0;
								END_IF;
								sp 		:= USINT_TO_UDINT(xR^.o.ob[0].BgC)-1;		// posuv od YY
								xPtU		:= xPtU2 + sp;
								xS^.vb	:= PTR_TO_UDINT(xPtU);							// vybrate cislo pre slider - kde je kruh
								xB^.r[ xR^.o.ob[10].h ].o.ob[10].wh := 13;  		// spristupni slider


							END_IF;


(*
							IF xR^.o.ob[0].BgC > 0 THEN                           // v tomto riadku je aktivny slider = modry kruh nad cislom
								IF xR^.o.ob[0].fn > 0 THEN                         // suvisi aj s inym datumom
									xB^.r[ xR^.o.ob[0].fn ].o.ob[0].BgC := 0;
								END_IF;
								sp 		:= USINT_TO_UDINT(xR^.o.ob[0].BgC)-1;		// posuv od YY
								xPtU		:= xPtU + sp;
							   xS       := ADR( xB^.s[ 0 ]);								// slider je vzdy s[0]
								xS^.vb	:= PTR_TO_UDINT(xPtU);							// vybrate cislo pre slider - kde je kruh
								xB^.r[ xR^.o.ob[10].h ].o.ob[10].wh := 13;  		// spristupni slider
							END_IF;


	                  xPtD  	:= ADR(xO^.cf.n);                   		// aktualna adresa pre vypis
   	               xPtU 		:= UDINT_TO_PTR(xPtD^);            			// pointer na strukturu TTecodt
							IF ok1 THEN
								_NhChkDTHH(wht:=xO^.Fgc, dthh:=xPtU2);
   						END_IF;



							yTx1  := MID(xO^.fmt,1,1);									// bodka, dvojbodka za cislom 	
							IF yTx1 <> '' THEN
	                     _NhVal2(
										xy		:= 1,
										x		:= xO^.x + p,
										y		:= xO^.y,
                              txt   := 0,
                              fmt   := 2,
                              FgT   := 4,
                              wT    := xO^.w );
							END_IF;
							yTx1  := MID(xO^.fmt,2,2);									// navestie nad hodnotou
							IF yTx1 <> '' THEN							
	                     _NhVal2(
										xy		:= 1,
										x		:= xO^.x,
										y		:= xB^.r[ xR^.o.ob[10].h ].o.ob[8].y, //xO^.y-(xO^.w*3)/2,
                              txt   := 0,
                              fmt   := 2,
                              FgT   := 2,
                              wT    := xO^.w*10/12 );

							END_IF;
							yTx1  := USINT_TO_STRINGF(xPtU^,'%02d');			   // cislo z pola
   	               _NhVal2(
                              grd   := 1,
                              fil   := true,
                              crc   := xR^.o.ob[0].BgC = SINT_TO_USINT(j),
                              BgC   := 3,
                              FgC   := 3,
                              wC    := xO^.w*2,              // wl=priemer gulicky, wl=hrubka kruznice
                              txt   := 0,
                              fmt   := 2,
                              FgT   := 4,
                              wT    := xO^.w );
						END_IF;
						xO^.tch  := false;
                  tch   	:= false;
*)

(*
          126:   // nastavenie casy/datumu pre (manual...)

               	// 0..4  YY.MM.YY HH:MM   platia suradnice x,y,w,h
               	// fmt je formatovane
						//		'.YY','.MM','DD','.HH','MM' - ak treba vypisovat navestia
               	// 	'.'  ,'.'  ,''  ,'.'  ,''   - ak netreba vypisovat navestia               	
					   IF xR^.o.ob[0].btn THEN											// zablokovana cela komponenta
							xR^.o.ob[0].BgC := 0;
						ELSIF	IF xO^.tch THEN
							xR^.o.ob[0].BgC	:= SINT_TO_USINT(j);
//								xS^.vb				:= PTR_TO_UDINT(xPtU);
//								xS^.v1	
//								xS^.v2	

						END_IF;
						IF xR^.o.ob[0].BgC > 0 THEN                           // v tomto riadku je aktivny slider = modry kruh nad cislom
							IF xR^.o.ob[0].fn > 0 THEN                         // suvisi aj s inym datumom
								xB^.r[ xR^.o.ob[0].fn ].o.ob[0].BgC := 0;
							END_IF;
		               xPtD  	:= ADR(xR^.o.ob[0].cf.n);						// adresa YY
							xPtU		:= UDINT_TO_PTR(xPtD^);
							sp 		:= USINT_TO_UDINT(xR^.o.ob[0].BgC);			// posuv od YY
							xPtU		:= xPtU + sp;
						   xS       := ADR( xB^.s[ 0 ]);								// slider je vzdy s[0]
							xS^.vb	:= PTR_TO_UDINT(xPtU);							// vybrate cislo pre slider - kde je kruh

//							IF xR^.o.ob[10].h > 0 THEN                         // suvisi aj s inym datumom
//								xB^.r[ xR^.o.ob[10].h ].o.ob[10].wh := 13;  		// spristupni slider
//							END_IF;
						END_IF;
						xO^.tch  := false;
                  tch   	:= false;
*)

            26 :  // Menu = Vypist textu s pripadnym podfarbenim
                  // xO^.fn      :  cislo slidera, kde je adresa hodnoty a format
                  // xO^.cf.c    :  formatovanie textu 0...4
                  // xO^.t       :  vyska textu - popis
                  // xO^.w       :  vyska textu - hodnota
                  // xO^.FgC     :  farba textu - popis
                  // xO^.BgC     :  farba textu - hodnota
                  // xO^.cf.n    :  cislo textu - popis
                  // xS^.va      :  pointer na premennu
                  // xS^.xv      :  x-suradnica pre hodnotu
                  // xS^.fmt     :  format
                  // xS^.txt     :  formatovanie hodnoty 2=zprava do lava;

                  xPtD  := ADR(xO^.cf.n);                                              // na adrese xO^.cf.n + xO^.cf.p je adresa premennej v UDINT
                  xPtB  := UDINT_TO_PTR(xPtD^);                                        // pointer prvej bool premennej / pola
                  o := 0;
                  IF xO^.cf.c > 0 OR xPtB^ THEN
                     o := 80;
//                     _NhVal2(wh := 80);      // podfarbene menu
                  END_IF;
                  _Nh_Lang(id :=  xO^.fn ,txt := ADR(yTx1));
                  aTrim(txt := ADR(yTx1), wht := 1);
                  _NhVal2(wh := o, txt:=0, fmt := 2, wt:= xO^.h, FgT := xO^.FgC );


            27:  // Check-box 2 obrazkov - BOOL premenna so zobraznemim textu pred obrazkom

                  // xO^.fn      :  cislo textu vypisovane od pevne od x=50
                  // xO^.FgC     :  farba textu
                  // xO^.h       :  velkost textu
                  // xO^.w       :  velkost obrazka
                  // xO^.x       :  x-obrazka
                  // xO^.y       :  y-textu aj obrazka
                  // xO^.cf.n    :  adresa premennej  ( xO^.cf.n+xO^.cf.p )
                  // xO^.cf.c    :  CMD, ktoresa ma vyslat do DEV
                  // xO^.BgC     :  x-ova suradnica zaciatku textu

                  xPtD  := ADR(xO^.cf.n);                                                             // na adrese xO^.cf.n + xO^.cf.p je adresa premennej v UDINT
                  xPtB  := UDINT_TO_PTR(xPtD^);                                                       // pointer prvej bool premennej / pola
                  IF tch THEN
                     aSys.chg    := true;
                     xPtB^       := NOT xPtB^;
                     xO^.tch  := 0;                ///***
                  END_IF;
                  IF xO^.fn > 0 THEN                                                                // vypisuje sa text
                     _Nh_Lang(id :=  xO^.fn ,txt := ADR(yTx1));
                     _NhVal2( txt:=0, fmt:=0, FgT:=xO^.FgC, wt:= USINT_TO_INT(xO^.BgC), xy:=true,x:=50,y:=xO^.y-USINT_TO_INT(xO^.BgC)/2);
                  END_IF;
                  IF xPtB^ THEN
                     yTx2 := MID(xO^.fmt,3,4) ;
                  ELSE
                     yTx2 := MID(xO^.fmt,3,1) ;
                  END_IF;
                  _NhVal2( obr := STRING_TO_INT(yTx2) , wO := xO^.w);

           90:   // poklad pod DASH = roundbox
                  rb    := true;
                  _NhFrmBrwShwDSH();

           112:   // RGB vyber farby
						IF xO^.tch  THEN
			          	_NhxPar (cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-1005);
                     IF xCan^.touch.color <> _RgbBck THEN
								yRgbWA 				:= xPar^.rgb;
								rmp	:= 0;
								COLOR_TO_RGBA(color := xCan^.touch.color, R := yRgbWA.lvl[1], G := yRgbWA.lvl[2], B := yRgbWA.lvl[3], a := rmp);              // odchyti farbu
                        xPar^.rgb   		:= yRgbWA;
								IF xL^.vis THEN
									xDev^.al.in.cmd	:= 8;
									xDev^.al.in.par	:=  xF^.cf.p;
      						END_IF;
		               END_IF;
						END_IF;
						_NhVal2(obr:=xO^.fn, wo:=xO^.w);

           113:   // RGB predvolby
		          	_NhxPar (cp := aCfg[xF^.cf.c].par , np := xF^.cf.p,x:=-1005);
//							sz := RGBA_TO_COLOR(	r := xUsr^.cx.rgb[i].lvl[1],g := xUsr^.cx.rgb[i].lvl[2],	b := xUsr^.cx.rgb[i].lvl[3], a:=0);
//						yRgbWA 				:= xPar^.rgb;
			         GC_SetFillStyle      (style := 0, GrData := xCan);					
			         GC_SetLineWidth      (Width := 3,  GrData := xCan);
						p	:= xO^.x;
						IF xO^.Fgc = 0 THEN
							xO^.Bgc := 0;
						ELSE
							xO^.Fgc := xO^.Fgc - 1;	
						END_IF;

			         FOR i := 1  TO 6 DO
							IF xO^.tch  THEN
								IF _NhTchObjXYW(x:=p-xO^.fn/2, y:=xO^.y-xO^.fn/2, w:=xO^.fn, h := xO^.fn) THEN	// konkretna predvolba
									IF xA^.tch.evn = 6 THEN												// dosiahlo sa podrazanie = ulozit
										xUsr^.cx.rgb[i] := xPar^.rgb;
										xO^.tch 		:= false;
									ELSIF xA^.tch.Qf THEN												// len dotyk = vybrat
										xPar^.rgb := xUsr^.cx.rgb[i];
										xO^.tch 		:= false;
										IF xL^.vis THEN
											xDev^.al.in.cmd	:= 8;
											xDev^.al.in.par	:=  xF^.cf.p;
										END_IF;
									END_IF;
								END_IF;
								IF xO^.tch = false THEN
									xA^.tch.End := true;												// dalej zablokovat, hoci dotyk trva
									xO^.Fgc 		:= 4;
									xO^.Bgc 		:= i;
								END_IF;																	
							END_IF;
         				GC_MoveTo   (x := p, y := xO^.y , GrData := xCan);
							sz := RGBA_TO_COLOR(	r := xUsr^.cx.rgb[i].lvl[1],g := xUsr^.cx.rgb[i].lvl[2],	b := xUsr^.cx.rgb[i].lvl[3], a:=0);
            			GC_SetFgColor (Color	:= sz ,GrData := xCan);		
            			GC_SetBgColor (Color	:= sz ,GrData := xCan);		
							IF i = xO^.Bgc THEN
      						GC_CCircle   (fill  := false, r:= xO^.fn,   GrData := xCan);  // kruznica                       2000:
							END_IF;
      					GC_CCircle   (fill  := true, r:= xO^.fn/2,   GrData := xCan);  // kruznica                       2000:
							p	:= p + 80;		 	
                  END_FOR;

           100:   // data pocasia v hornom riadku

                     GC_SetTextstyle(style   := _Nh_Sty[1], GrData := xCan);                         // formatovanie textu zprava fo lava
                     GC_SetTextSize (size 	:= 26, GrData := xCan);                                 // vyska textu
                     GC_SetFillStyle(style := GFILL_STYLE_BGCOLOR, GrData := xCan);					
                     GC_SetFgColor  (Color 	:=  _NhColor[4], GrData := xCan);

							_NhxZon(nz:=2, x:=-81);
							// sumrak
							IF xZon^.cx.Dark THEN
								xR^.o.ob[ 1 ].fn := 131;                           								// oranzova sviecka	
							ELSE
								xR^.o.ob[ 1 ].fn := 130;                                                		// siva sviecka
							END_IF;
        					GC_MoveTo   (x := xR^.o.ob[1].x+98, y := xR^.o.ob[1].y, GrData := xCan);
							yTx1 := REAL_TO_STRINGF(xZon^.io[101].val,'%4.0f%%');
                 	   GC_WriteText (text   := yTx1, GrData := xCan);                                  //
							// vonkajsia teplota
                     GC_MoveTo   (x := xR^.o.ob[2].x+110, y := xR^.o.ob[2].y, GrData := xCan);
							yTx1 := REAL_TO_STRINGF(xZon^.io[100].val,'%5.1f°');
							IF xZon^.io[100].val <= xGlb^.cx.meteo.temp[0] THEN
	                     GC_SetFgColor  (Color 	:=  _NhColor[3], GrData := xCan);
							ELSIF xZon^.io[100].val >= xGlb^.cx.meteo.temp[2] THEN
       						GC_SetFgColor  (Color 	:=  _NhColor[18], GrData := xCan);
							END_IF
                     GC_WriteText (text   := yTx1, GrData := xCan);                                  //
							IF aMeteo.err = false THEN
								// rychlost vetra
	                     GC_MoveTo   (x := xR^.o.ob[3].x + 112, y := xR^.o.ob[3].y, GrData := xCan);
								yTx1 := REAL_TO_STRINGF(aMeteo.idx[0].val,'%2.0fm/s');
								IF aMeteo.idx[0].val >= xGlb^.cx.meteo.wind[1] THEN
		                     GC_SetFgColor  (Color 	:=  _NhColor[18], GrData := xCan);
									xR^.o.ob[ 3 ].fn := 263;                           								// cervena	
								ELSIF aMeteo.idx[0].val >= xGlb^.cx.meteo.temp[0] THEN
                           GC_SetFgColor  (Color 	:=  _NhColor[6], GrData := xCan);
									xR^.o.ob[ 3 ].fn := 262;                                                	// oranzova
								ELSE
		                     GC_SetFgColor  (Color 	:=  _NhColor[4], GrData := xCan);
									xR^.o.ob[ 3 ].fn := 261;                                              		// siva
								END_IF
      	               GC_WriteText (text   := yTx1, GrData := xCan);                                  //

								// vlhkost
   	     	            GC_MoveTo   (x := x2-15, y := xR^.o.ob[3].y, GrData := xCan);
								yTx1 := REAL_TO_STRINGF(aMeteo.station.relhumidity,'%4.0f%%');
	                     GC_SetFgColor  (Color 	:=  _NhColor[4], GrData := xCan);
         	        	   GC_WriteText (text   := yTx1, GrData := xCan);                                  //

							END_IF;


           101:   // smer vetra
						IF true THEN //aMeteo.err = false THEN
  	     	            GC_MoveTo   (x:=xO^.x, y:=xO^.y, GrData := xCan);
							IF xO^.btn THEN
								p		:= xO^.w/7;
								pp		:= xO^.w/3;
						      GC_CImage   (filename := _NhFnObr(fn := 378), width := xO^.w, height := xO^.w,	GrData := xCan);
      					ELSE
								p		:= xO^.w/6;
								pp		:= xO^.w/3;
							END_IF;
					      GC_SetLineStyle      (style := GLINE_CAP_ROUND + GLINE_STYLE_SOLID, GrData := xCan);
							GC_SetLineWidth (width 	:= 2, GrData := xCan);                                 // vyska textu
                     GC_SetFgColor  (Color 	:=  _NhColor[xO^.BgC], GrData := xCan);
                     GC_SetBgColor  (Color 	:=  _NhColor[xO^.FgC], GrData := xCan);
							GC_Heading(	angle :=0, GrData := xCan);										// reset 0st					
							GC_Turn(	angle := UINT_TO_REAL(aMeteo.WindDirMan360), GrData := xCan);               // natocit podla smeru z meteo
							GC_CTriangle(	fill:=1,
							       			x1	:= p,
							       			y1	:= pp,							       			
							       			x2	:= -p,
							       			y2	:= pp,							       			
							       			x3	:= 0,
							       			y3	:= -pp,				       			
												GrData := xCan);
							GC_Heading(	angle :=0.0,GrData := xCan);                        		// vratit
						END_IF;

           102:   // dashboard pocasia

(*
  	NH_OBJ_DSH {HIDDEN} :  STRUCT       // velkost: 30  vseobecny objekt  			
      wh       : USINT;                         // 0=nic,1=obrazok...2=...
		x			: INT ;                     		// 1 x-ova suradnica stredu objektu
		y			: INT ;         				      // 3 y-ova suradnica stredu objektu (default pre spodne menu)
		w			: INT := 80;            		   // 5 sirka  (pri obrazku je to aj vyska)
		dash		: INT			:= 381;      			// 7	cislo obrazkaDSH
		vMin		: REAL		:= 0.0;					// 9  minimalna hodnota
		vMax		: REAL		:= 18.0;					//	13 max.hodnota pre zobrazenie
		tx1		: STRING[3] := 'Min';				// 17 text laveho intervalu : Min,Avg, pravy je vzdy Max
		title		: INT;									// 21 cislo textu dash
		idx		: USINT;                         // 23 index na aMeteo.idx[]
		dummy		: USINT;                         // 24
//		tx2		: STRING[3] := 'Max';            // 21
		mj			: STRING[3]	:= 'm/s'; 				// 25	popis jednotky °C, %, hPa
	END_STRUCT;                      					// 30 byte
*)
						xOdsh	:= xO;
						yOdsh	:= xOdsh^;
						
						_NhVal2(obr:=xoDsh^.dash, wO:=xOdsh^.w, grd:=1,FgC:=9, BgC:=9);						
						GC_Heading(	angle :=-95, GrData := xCan);										// reset 0st					
						vr := 190.0/(xOdsh^.vMax-xOdsh^.vMin);										//kolko je na 1 stupen
						kr := LIMIT(aMeteo.idx[xOdsh^.idx].val,xOdsh^.vMin,xOdsh^.vMax);		// vlozi do intervalu
						kr := kr - xOdsh^.vMin; 															// spodna hranica = 0
						
//						 * LIMIT(aMeteo.idx[xOdsh^.idx].val,xOdsh^.vMin,xOdsh^.vMax)
						GC_Turn(	angle := vr * kr , GrData := xCan);               // natocit podla smeru z meteo
						p		:= xOdsh^.w/2;
						GC_CPolygon4(	fill:=1,
							       			x1	:= 5,
							       			y1	:= 0,							       			
							       			x2	:= -5,
							       			y2	:= 0,							       			
							       			x3	:= -5,
							       			y3	:= -p,				       			
							       			x4	:= 5,
							       			y4	:= -p,				       			
												GrData := xCan);
//						yTx1:= xOdsh^.title;	//'Vietor';
						p:= xOdsh^.w/3+15;
						// stredny kruh + nazov dasch
						_NhVal2(obr:=379, wO:=xOdsh^.w/2+5, txt:=-2, nTxt:=xOdsh^.title, fmt:=2, wt:=26, FgT:=4 );		
						// hodnota
						yTx1:= REAL_TO_STRINGF(aMeteo.idx[xOdsh^.idx].val,aMeteo.idx[xOdsh^.idx].fmt);	//'%4.0f'); 	//'6.3';																				// hodnota
						_NhVal2(y:= -30, txt:=0, fmt:=2, wt:=30, FgT:=1 );
						// jednotka
						yTx1:= xOdsh^.mj;	// string[3]'m/s';			
						_NhVal2(y:= -p, txt:=0, fmt:=2, wt:=25, FgT:=1 );
						// Min/Avg
				
						yTx1:= xOdsh^.tx1;	//mj'Max/D';
						_NhVal2(x:=-p, y:= 30, txt:=0, fmt:=2, wt:=20, FgT:=10 );
						// druha velicina
						yTx1:= 'Max';	
						_NhVal2(x:=p, y:= 30, txt:=0, fmt:=2, wt:=20, FgT:=10 );
						// hodnota Min
						yTx1:= REAL_TO_STRINGF(aMeteo.idx[xOdsh^.idx].v1, aMeteo.idx[xOdsh^.idx].fmt);	// '4.5';			
						_NhVal2(x:=-p, y:= 55, txt:=0, fmt:=2, wt:=22, FgT:=4 );
						// Hodnota Max
						yTx1:= REAL_TO_STRINGF(aMeteo.idx[xOdsh^.idx].v2, aMeteo.idx[xOdsh^.idx].fmt);	// '4.5';			
						_NhVal2(x:=p, y:= 55, txt:=0, fmt:=2, wt:=22, FgT:=4 );
						// vratit uhol
						GC_Heading(	angle :=0, GrData := xCan);										// reset 0st					



           105:   // Oznacit Days_Of_Week + sviatok + Party
						// xR^.o.ob[0].btn			// zapblokuje zobrazenie
						// xR^.o.ob[0].cf.c:			// 0: na adrese ADR(xR^.o.ob[0].cf.n) je adresa pola DayOfWeek	: NH_BTN15
															// 1: na adrese ADR(xR^.o.ob[0].cf.n) je adresa premennej z/do ktorej za zapisuje len jeden vybraty den
															//    z pola DayOfWeek: NH_BTN15 ktore je na adrese ADR(xR^.o.ob[0].fmt)

						IF xR^.o.ob[0].btn = false THEN					// riadok 0 je riadiaciu 0 odblokovane
	                  xPtD  	:= ADR(xR^.o.ob[0].cf.n); 	     	// adresa premennej: c:=0 je to adresa pola, c:=1 je premenna USINT kam sa zapisuje vysledok
							xBtn15 	:= ADR(xR^.o.ob[0].fmt);         // bool pole [1-15] pozitych je 11
							IF xR^.o.ob[0].cf.c = 1 THEN
   		               xPtU  := UDINT_TO_PTR(xPtD^);     		// premenna kam sa ma zapise vysledok {moze byt len jed vyer}
   		               xPtB   := ADR(xBtn15^[0]);     			// pointer prvej bool premennej / pola
							ELSE
   		               xPtB  := UDINT_TO_PTR(xPtD^);          // pointer prvej bool premennej / pola {mozu by ybrate vsetky}
							END_IF;
							xO^.Qr 				:= false;				   // resetne dotyk nad hociakym objektom
							xO^.Qs 				:= false;				   // resetne dotyk nad tymto objektom
							sRun  := SINT_TO_UDINT(j+1);					// riadok 0..8 prevediema na 1..8 (PO-NE)
							i		:= UDINT_TO_USINT(sRun);					// cislo dna kde bol dotyk
							xPtB	:= xPtB + sRun;
            	      IF xO^.tch THEN
	                     xR^.o.ob[0].Qr		:= true;             // v 1. riadku dotyk nad hociktorym objektom
								xO^.Qr 				:= true;					// dotyk v konkretno riadku
								IF xR^.o.ob[0].cf.c = 1 THEN 						
		                     xO^.Qs 			:= xPtU^ = i;			// v tomto riadku dotyk nad uz vybratym objektom
									xR^.o.ob[0].Qs	:= xO^.Qs;        	// v 1. riadku priznak, ze bol dotyk nad uz vybratym objektom
									// oznacenie kopirovania
									xM^.pod.cp.cpy := false;						// centralny prinak, ze mame nejaky ciel a zobrazi sa ikona COPY
					            IF xM^.set = false THEN					// dotyk nad oznacenym zdrojom kopirovania, zrusi vsetky oznacenia
										;
									ELSIF xM^.pod.cp.all THEN					// pri copy celej room znaci/oznaci
										xM^.pod.cp.dst[i] := NOT xM^.pod.cp.dst[i];									
									ELSIF xM^.pod.cp.src = i THEN			// dotyk nad oznacenym zdrojom kopirovania, zrusi vsetky oznacenia
										_NheBrw(wht:=12);
									ELSIF xM^.pod.cp.src > 0 THEN       		// je oznaceny zdroj kopirovania,
										xM^.pod.cp.dst[i] := NOT xM^.pod.cp.dst[i]; //oznaci/odznaci sa ciel
									ELSIF xO^.Qs THEN                   // dotuk nad oznacenym zdrojom zmaze vsetky oznacenia
										_NheBrw(wht:=12);
										xM^.pod.cp.src	:= i;										
									ELSE                             		// nic nie je oznacene na kopirovanie, prestavi sa typ.den
										_NheBrw(wht:=12);
										xPtU^	  			:= i;	// zapise sa do premennej									
									END_IF;										
								ELSE
		                     xR^.o.ob[0].Qs	:= xPtB^;
									xO^.Qs 			:= xPtB^;		
									xPtB^				:= NOt xPtB^;           	// zaznacuje/odznacuje s aktualne pole
								END_IF;
                  	   xO^.tch  := 0;
							END_IF;	
							IF xR^.o.ob[0].cf.c = 1 THEN 						
								IF j = 0 THEN
									xBtn15^ := _eBtn15;						// moze byt len jeden vyber
								END_IF;
								IF xPtU^ = i THEN
									xPtB^ := true;                      // toto je vybrate
								ELSE
									xPtB^ := false;								
								END_IF;
							END_IF;

				yBtn15 := xBtn15^;


							IF j > 7 THEN
								xR^.o.ob[j].y := xR^.o.ob[7].y;			// preberie suradnicu z objektu sviatok
							ELSIF j = 7 THEN
								xR^.o.ob[j].y := xR^.o.ob[0].y - 75;			// preberie suradnicu z objektu sviatok
							ELSIF j > 0 THEN
								xR^.o.ob[j].y := xR^.o.ob[0].y;        // preberie z Pondelok
							END_IF;
							IF xO^.fn > 0 THEN								// obrazky sviatok..dovolenka
								pp	:= xR^.o.ob[j].cf.n;;                	// cislo textu
  		            	   _NhVal2(obr	:= xO^.fn + BOOL_TO_INT(xPtB^),
  		               			wO		:= xO^.w,
                              grd   := 1,
                              box   := xPtB^,                   // kruh/kruznica
                              fil   := xPtB^,                	// bude vypln
                              BgC   := xO^.FgC,						// kruznica	
                              FgC   := xO^.FgC,               	// vypln
//										wL		:= 2,                      // hrubka kruznice
//									   wC    := xO^.w*20/18,              		// wl=priemer gulicky, wl=hrubka kruznice
										hB    := xO^.w*20/18,
										r		:= 10,
											);
							ELSE                                 		// dni v tyzdni, nemaju vo .fn nic
								pp	:= 201;                					// textu: den v tyzdni
  		               	_NhVal2(
                              grd   := 2,
                              crc   := true,                   // kruh/kruznica
                              fil   := xPtB^,                	// bude vypln
                              BgC   := xO^.FgC,						// kruznica	
                              FgC   := xO^.FgC,               	// vypln
										wL		:= 2,                      // hrubka kruznice
									   wC    := xO^.w,              		// wl=priemer gulicky, wl=hrubka kruznice

                              txt 	:= -2,								
										nTxt 	:= 21 + SINT_TO_INT(j),	// 21=PO,UT,ST
										fmt   := 2,
                              FgT   := xO^.BgC,						// farba textu
                              wT    := xO^.w/2 );
							END_IF;
							IF xR^.o.ob[0].cf.c = 1 THEN 									// vykresli objekty kopirovania			
				            GC_Move  (x := 24, y := -28, GrData := xCan);
					         IF xM^.pod.cp.src = i OR (xM^.pod.cp.all AND xM^.pod.cp.dst[i]) THEN				//
					            GC_CImage   (filename := _NhFnObr(fn := 44), width := 48, height := 48,	GrData := xCan);
								ELSIF xM^.pod.cp.src = 0 THEN
									;
					         ELSIF xM^.pod.cp.dst[i] THEN
				   	         GC_CImage   (filename := _NhFnObr(fn := 38), width := 45, height := 45,	GrData := xCan);
									xM^.pod.cp.cpy := true;									// centralny prinak, ze mame nejaky ciel
								END_IF;
								IF xM^.pod.cp.all = false AND xM^.pod.cp.cpy = false THEN
									xB^.r[1].o.ob[0].wh	:= 0;																	
								ELSE	 //xB^.r[1].o.ob[0].cm = 130 THEN					// menu kopirovania
									xB^.r[1].o.ob[0].wh	:= 1;
									IF xM^.pod.cp.all THEN
										xB^.r[1].o.ob[0].fn := 38;						// zeleny check
										xB^.r[1].o.ob[0].cm := 132;					// browser
									ELSE
										xB^.r[1].o.ob[0].fn := 44;              	// zlte copy
										xB^.r[1].o.ob[0].cm := 130;					// copy
									END_IF;
									xB^.r[1].o.ob[0].x	:= xR^.o.ob[6].x;       // preberie znedele
									xB^.r[1].o.ob[0].y	:=	xR^.o.ob[7].y-20;			// preberie suradnicu z objektu sviatok
					         END_IF;
							END_IF;
							IF pp > 0 AND xPtB^ AND xR^.o.ob[0].set6 THEN		// vypisuje sa text dna
  		               	_NhVal2(
										xy		:= true,
										x		:= xc,
										y		:= xR^.o.ob[7].y - xR^.o.ob[7].h,
                              txt 	:= -2,								
										nTxt 	:= pp,
										fmt   := 2,
                              FgT   := 3,						// farba textu
                              wT    := 28 );
							END_IF;
      				END_IF;	


           106:   // ikona typ.dna na Home/zone
                  xPtD  := ADR(xO^.cf.n); 	      // adresa premennej USINT;
						xPod	:= UDINT_TO_PTR(xPtD^);
						IF xPod^.Day < 8 THEN
	               	_NhVal2(wO:=xO^.w, obr:=269);					// cisty kalendar
	               	_NhVal2(
               			y		:= xO^.w/10,
                 			txt 	:= -2,								
								nTxt 	:= 21 + USINT_TO_INT(xPod^.Day-1),
                        FgT   := 3,						// farba textu
								fmt   := 2,
                        wT   := xO^.w*10/26 );
						ELSE
	               	_NhVal2(
               			wO		:= xO^.w,
               			obr	:= 275 + (3*USINT_TO_INT(xPod^.Day-8)) );
						END_IF;


           221:  // Vypist textu s hodnotou
                  // xO^.fn      :  cislo textu vypisovane od pevne od x=50
						// ak xO^.cf.c > 0
	                  // xO^.cf.c    :  cfg DEV
   	               // xO^.cf.n    :  nd DEV
                  // xO^.FgC     :  farba textu
                  // xO^.w       :  vyska textu
                  
                  // xO^.fmt     :  textova hodnota
                  // xO^.BgC     :  farba hodnoty
                  // xO^.h       :  vyska hodnoty

                  // xO^.x       :  x-obrazka
                  // xO^.y       :  y-textu aj obrazka


                  // xO^.BgC     :  x-ova suradnica zaciatku textu

                  yTx1 := '';
                  IF xO^.fn > 0 THEN
                     _Nh_Lang(id :=  xO^.fn ,txt := ADR(yTx1));
                  ELSIF xO^.cf.c > 0 THEN
                     IF _NhxPt(c:=xO^.cf.c, n:=xO^.cf.n, x:=81) THEN
                        aTrim(wht:=1,txt:=ADR(yTx1));
                        yTx1 := CONCAT(yTx1,' ',xPt^.cf.Name);
                        yTx1 := LEFT(yTx1,25);
                     END_IF;
                  END_IF;
                  IF yTx1 <> '' THEN
                     _NhVal2(txt:=0, fmt := 0, wt:= xO^.w, FgT := xO^.FgC ,xy:=true, x:=50, y:=xO^.y );
                  END_IF;
                  yTx1 := xO^.fmt;                                          // naformatuje hodnotu do textu
                  _NhVal2(txt:=0, fmt := 2, wt:= xO^.h, FgT := xO^.BgC, xy:=true, x:=x2-90, y:=xO^.y  );


           228:   // status [2] DEV v BRW,,Quick.... vsade
		            _Nh_FRM_Read(frm:=229);                        // obrazky pre typ NH_OBR_OPV
                  xHet  := xDev;
						CASE xR^.h.cf.c OF
                    6 : c:=0;
                  ELSE  c:=1;
                  END_CASE;
						o 		:= aCfg[xR^.h.cf.c].par;
						IF xR^.h.chk   THEN													// z webu nad regulatorm sa podhodi default par
							p := xR^.h.cf.p;
						ELSIF xO^.tch  THEN
							xDev^.al.in.par := xHet^.cf.par ;
							xDev^.al.ou.par := xHet^.cf.par ;
							p	:= xDev^.al.ou.par;              	
						ELSE
							p	:= xDev^.al.ou.par;              	
						END_IF;
						IF xO^.tch THEN
							xDev^.al.in.cmd := 1;
						END_IF;
						_NhxPar (cp := o , np := p,x:=-1006);								
                  pHet  	:= xPar;
                  xPvA  	:= ADR(pHet^.par.pva);
						_NH_Het_Map_Reg();
                  _Nh_Shw_ini();
                  IF xDev^.cf.typ > _Nh_TYP THEN
                     xO^.fn      := 24;
                  ELSE
                     xO^.fn      := yFrm_229.reg[c].obr1[ xReg^.Mode, xRegMod^.wht, MIN(xDev^.al.sta,3)];
                  END_IF;
                  yRn.v[0].wO    := xO^.w;
                  yRn.v[0].obr   := xO^.fn;
                  yRn.v[0].wh    := 0;
                  _Nh_Shw_Val();

           230:   // hlavny obrazok DEV podla typu.  browse
                  yRn.v[0].wO    := xO^.w;
//						xO^.fn			:=_NhObrNbr(cf:=xO^.cf.c, t:=xDev^.cf.typ);
//							_NhTypObr(cf:=xO^.cf.c, typ:=xDev^.cf.typ);
//							xO^.fn := xObrWht^.obr;

                  _Nh_Shw_ini();

//                  yRn.v[0].obr   := xO^.fn;
//                  yRn.v[0].wh 	:= INT_TO_USINT(_NhObrNbr(cf:=xO^.cf.c, t:=xDev^.cf.typ, wh:=1));

						_NhTypObr(cf:=xO^.cf.c, typ:=xDev^.cf.typ);
						xO^.fn			:= xObrWht^.obr;
	               yRn.v[0].obr   := xObrWht^.obr;
                  yRn.v[0].wh 	:= xObrWht^.wht;

						IF yRn.v[0].wh > 0 THEN
							yRn.v[0].wO := xO^.w * 20 / 24;
//							yRn.v[0].wC := xO^.w * 20 / 20;
						ELSE
	                  yRn.v[0].wO := xO^.w;						
						END_IF;
					
                  _Nh_Shw_Val();

           231:   // status [2] DEV v BRW,,Quick.... vsade

                  _Nh_FRM_Read(frm:=231);                      // funkcia naciatania do obr, ale strukturu 230
                  _Nh_Shw_ini();
						vr				:= xDev^.al.ou.val;
						vr		:= xDev^.al.OU.val;
						IF xR^.h.chk  AND aCfg[xR^.h.cf.c].ou THEN
							IF xR^.h.cf.c = 43 AND xF^.cf.c = 44 THEN
			      	      dlgr  := _Nh_DL_sha(gr:=1, nd := xF^.cf.n)-100;                    // cislo GRP - 100
								xDLs 	:= xDEv;
								vr 	:= USINT_TO_REAL(xDLs^.cx.scn.lvl[dlgr]);
							ELSIF xR^.h.cf.c = 44 AND xF^.cf.c = 43 THEN																
								dlgr  := _Nh_DL_sha(gr:=1, nd := xR^.h.cf.n)-100;                    // cislo GRP - 100
								_NhxPt(c:=xF^.cf.c, n:=xF^.cf.n,x:=-135);
								xDLs 	:= xPt;
								vr 	:= USINT_TO_REAL(xDLs^.cx.scn.lvl[dlgr]);							
							ELSIF aCfg[xO^.cf.c].par > 0 THEN
                   		IF _NhxPar(cp := aCfg[xO^.cf.c].par, np := xR^.h.cf.p ,x:=238) THEN
									vr		:= USINT_TO_REAL(xPar^.all.lvl);
								ELSE
									;
//									vr		:= xDev^.al.ou.val);
								END_IF;
							END_IF;
							IF vr > 0.0  THEN
								yRn.v[0].txt 	:= 3;													// vypise sa to co je vo vr
								yRn.v[0].wh    := 21;												// pri check, je vzdy zeleny podklad			
							ELSE
								yRn.v[0].wh  := 10;													// sivy podklad OFF
							END_IF;
						ELSE
	      				s 				:= xDev^.al.sta;
							IF s > 0 THEN
								s	:= 2;
							ELSE
								s	:= 0;
							END_IF;
							IF  yFrm_231.dev[xO^.cf.c,s] < 0 THEN
								p := yFrm_231.dev[xO^.cf.c,2] * -1  + USINT_TO_INT(xDev^.al.sta-1);
								p	:= MIN(p,50);						// opravit
								IF yFrm_231.sta[p, 0] < 0 THEN
		      	            yRn.v[0].txt   := INT_TO_SINT( yFrm_231.sta[p, 0] * -1 );
		         	         yRn.v[0].obr   := 0;
								ELSE
		               	   yRn.v[0].obr   := yFrm_231.sta[p, 0];
								END_IF;
  			               yRn.v[0].wh    := INT_TO_USINT(yFrm_231.sta[p, 1]);
(*
							ELSIF xO^.cf.c = 4 	AND vr < 100.0 THEN						// SCN nie je naplno					
	         	         yRn.v[0].obr   := 0;
								IF vr  > 0.0 THEN
			         	      yRn.v[0].wh    := 11;
								ELSE
			         	      yRn.v[0].wh    := 10;
								END_IF;					
*)
							ELSIF xO^.cf.c = 4  THEN						// SCN nie je naplno					
								yRn.v[0].obr   := 207;	
								IF vr >= 100.0 THEN
			         	      yRn.v[0].wh    := 14;
								ELSIF vr  > 0.0 THEN
			         	      yRn.v[0].wh    := 17;
								ELSE
									yRn.v[0].obr   := 0;	
									yRn.v[0].wh    := 10;
								END_IF;					

							ELSIF xO^.cf.c = 44 	AND vr < 100.0 THEN            			// DLg scen nie je naplno		
	         	         yRn.v[0].obr   := 0;
								IF vr  > 0.0 THEN
			         	      yRn.v[0].wh    := 11;
								ELSE
			         	      yRn.v[0].wh    := 10;
								END_IF;					
							ELSE
	         	         yRn.v[0].obr   := yFrm_231.dev[xO^.cf.c,s];
   	         	      yRn.v[0].wh    := INT_TO_USINT(yFrm_231.dev[xO^.cf.c,s+1]);
							END_IF;
						END_IF;
						

(*
						IF xO^.cf.c = 44 THEN														// DLg nema Check
							IF xDev^.al.ou.val >=254 THEN
								yRn.v[0].wh  := 102;													// Oranzovy ON = kompletne zapnuta scena
							END_IF;
                  ELSIF aCfg[xO^.cf.c].ou AND xR^.h.chk AND aCfg[xO^.cf.c].par > 0  THEN   // pre OUT-DEV vp vazbe
     						yRn.v[0].obr	:= 0;                                     // zrusi obrazok, aby sa nezmensoval podklad
							yRn.v[0].FgT   := 1;													// pri check, je vzdy zeleny podklad			
							IF xF^.cf.c = 44 THEN	
								yRn.v[0].wh    := 13;												// pri check, je vzdy zeleny podklad			
								{$IFDEF __NH_DALI}
	 							dlgr	:= _Nh_DL_sha(gr:=1,nd := xF^.cf.n)-100 ;				// 0..15
								xDLg	:= xDev;
								vr		:= MIN(100,USINT_TO_REAL(xDLs^.cx.scn.LVL[ dlgr ]));
								IF vr > 0.0 THEN
									yRn.v[0].txt := 3;													// vypise sa to co je vo vr
								ELSE
									yRn.v[0].wh  := 10;													// sivy podklad OFF
								END_IF;
								{$END_IF}

                     ELSIF _NhxPar(cp := aCfg[xO^.cf.c].par, np := xR^.h.cf.p ,x:=238) THEN
								yRn.v[0].wh    := 13;												// pri check, je vzdy zeleny podklad			
								vr	:= MIN(100,USINT_TO_REAL(xPar^.all.lvl));
								IF aCfg[xO^.cf.c].analog THEN
									yRn.v[0].txt := 3;													// vypise sa to co je vo vr
								ELSIF vr > 0.0 THEN
									yRn.v[0].txt := 2;													// vypise sa to co je vo vr
								ELSE
									yRn.v[0].wh  := 10;													// sivy podklad OFF
								END_IF
							END_IF;
                  END_IF;
*)
					   IF yRn.v[0].wh > 0 AND yRn.v[0].obr > 0 THEN								// obrazok ma podklad, zmensi sa
	                  yRn.v[0].wO := xO^.w*20/23;
					   END_IF;
					   
                  _Nh_Shw_Val();


           232:   // HOME-DASH, Cat/hlavny obr + CAT/status
                  _Nh_FRM_Read(frm:=232);                      // funkcia naciatania do obr, ale strukturu 230
                  p := xO^.cf.n;                                                      // cislo CAT
						_NhxRoW(nbr := xA^.sbj, zon := true);	
						_NhxZon(c:=3, nz:=xA^.sbj, x:=111);							
						IF xRoW^.cat[p] THEN																// hlavna ikona   je j=1
							c := 1;
						ELSE
							c := 0;						
						END_IF;

					   CASE p OF
                    6 : // PSN
								c := xZon^.cx.lck.stat;							
								IF xZon^.cx.lck.stat > 9 THEN								
									c := 2;
								ELSIF c = 2 AND xZon^.cx.lck.AllLocked = false THEN
									c := 10;
								END_IF;
		                  IF xL^.obj = 0 THEN
    								x4o   := ADR(xB^.r[4].o.ob[p]);
									x4o^	:= yFrm_232.psn4;
									ok		:= 0;
									IF xHoW^.BodyOu THEN
										x4o^.ok[1]  := 1;
										ok				:= 0;
									END_IF;
									IF xHoW^.BodyIn THEN
										x4o^.ok[2]  := 1;
										ok				:= 0;
									END_IF;
									_Nh_Shw_LCK_ET(sta:=xZon^.cx.lck.stat, et:=xZon^.cx.lck.et, o := 4);
									IF ok THEN
//										x4o^.wh	:= 0;									
									END_IF
								END_IF;

                  ELSE
                  ;
                  END_CASE;
				  		_Nh_Shw_ini();
						_Nh_Shw_232(o1 := xL^.obj > 0 AND j=1,  cat := p, sta := c);     	// pre j=1 hlavna ikona sa je iny obrazok
                  _Nh_Shw_Val();

           233:   // OBR Quick menu

                  _Nh_FRM_Read(frm:=233);                      // funkcia naciatania do obr, ale strukturu 230
                  _Nh_Shw_ini();
                  yRn.v[0].wO    := xO^.w;
                  yRn.v[0].obr   := yFrm_233.dev[xO^.cf.c].obr[xDev^.al.sta];
                  yRn.v[0].wh    := yFrm_233.dev[xO^.cf.c].wht[xDev^.al.sta];
                  IF yRn.v[0].wh > 0 THEN
                     yRn.v[0].wC   := 80;
                     yRn.v[0].wO   := 64;
                  ELSE
                     yRn.v[0].wO   := 80;
                  END_IF;
                     yRn.v[1].ok    := true;
                     yRn.v[1].txt   := 101;
                     yRn.v[1].wT    := 16;
//                     yRn.v[1].fmt   := 2;
                     yRn.v[1].y     := 55;   //xO^.w*10/13;

//                     xO^.w    := 64;

                  CASE xO^.cf.c OF
//                      1 :  ;// ZAS
                     222 :  ;// ZAS
//                      21 :  ;// ZAS
//                      37 :  ;// GAR/BRA
//                      42 :  ;// DLS
                  ELSE
                  ;
                  END_CASE;

                  _Nh_Shw_Val();

           234:   // ROM/ZON/PSN + teplota/status
				      _Nh_FRM_Read(frm:=231);                      // funkcia naciatania do obr, ale strukturu 230
                  _Nh_Shw_ini();
						IF xL^.obj = 50  THEN												// ZON->ACT				
							CASE j OF
                       1 : // hlavny obr
									yRn.v[0].obr   := 69;	//yFrm_231.sta[2, 0];
   		               	yRn.v[0].wh    := 0;
                       6 : // stavovy obr
           						i := 0;
									IF xR^.h.chk AND xR^.h.nd > 0 THEN
										_NhxVaz(cv:=xL^.vaz, nd := xR^.h.nd);
										IF _NhxPar(cp := aCfg[3].par, np:= xVaz^.in.p ,x:=239) THEN
											pZon 	:= xPar;

										IF  pZon^.cmd < 60 THEN
											pZon^.cmd := 60;
										ELSIF pZon^.cmd > 69 THEN
											pZon^.cmd := 60;										
										END_IF;

											i 		:=	pZon^.cmd - 60 ;
										END_IF;
										yRn.v[0].obr   := yFrm_231.sta[i, 0];
        								yRn.v[0].wh    := INT_TO_USINT(yFrm_231.sta[i, 1]);
                  			ELSE
										yRn.v[0].obr   := yFrm_231.sta[i, 0];
   			               	yRn.v[0].wh    := INT_TO_USINT(yFrm_231.sta[i, 1]);
									END_IF;
							END_CASE;
						ELSIF xL^.psn  THEN
							xRom	:= xDev;
				         xLck  := ADR(xRom^.cx.lck);
							p		:= yFrm_231.dev[xR^.h.cf.c,2];
							c		:= xLck^.stat;
							IF xLck^.stat > 9 THEN								
								c := 2;
							END_IF;
							IF c > 0 AND  p < 0 THEN
													//	1.riadok                         // 1.riadok je stat:=1
								p 					:= yFrm_231.dev[xR^.h.cf.c,2] * -1  + USINT_TO_INT(c-1);
								IF xR^.h.cf.c = 3 AND p = 2 AND xLck^.AllLocked = false THEN
									p := 10;
								END_IF;
		                  yRn.v[0].obr   := yFrm_231.sta[p, 0];
   		               yRn.v[0].wh    := INT_TO_USINT(yFrm_231.sta[p, 1]);
							ELSE
								s 					:= c * 2;														// 0: [0..1] 1: [2..3]
		                  yRn.v[0].obr   := yFrm_231.dev[xR^.h.cf.c,s];
   		               yRn.v[0].wh    := INT_TO_USINT(yFrm_231.dev[xR^.h.cf.c,s+1]);
                     END_IF;	
							
													
	                  yRn.v[0].wC 	:= xO^.w;
	                  yRn.v[0].wO 	:= xO^.w*20/24;
						ELSE
	                  yRn.v[0].obr   := 0;
   	               yRn.v[0].wh    := 100;
						END_IF;
                  _Nh_Shw_Val();




           240:   // obrazky nad DSH + domcek
                  p := xO^.w - 10;
                  CASE xO^.cf.p OF                                               // cislo CAT
                    1 : ii := 0; p := xO^.w;                                     // Domcek
                    2 : ii := 0; p := xO^.w;                                     // sviecka vnutri
                    3 : ii := 0; p := xO^.w;                                     // Okno
                    4 : ii := 0; p := xO^.w;                                     // Fotovoltaika
                    5 : ii :=22;                                                 // Dvere - oranzova
                   10 : ii := 0; p := xO^.w;                                     // Dvere - oranzova
                  ELSE
                     ii    := 23;
                  END_CASE;
                  _NhVal2( wh := ii, obr := xO^.fn, wO := p);
                  IF xO^.tch  THEN
                     xO^.tch := false;
                  END_IF;

           255:   // riadok prihlaseneho usra na webserveri
                  xR^.h.cf.n := MIN(xR^.h.cf.n,7);

                  CASE aAcc.wa[xR^.h.cf.n].state OF
                     SESSION_EMPTY  : yTx1 := 'EMPTY ';
                     SESSION_LOGIN  : yTx1 := 'LOGIN ';
                     SESSION_ACTIVE : yTx1 := 'ACTIVE';
                     SESSION_LOGOUT : yTx1 := 'LOGOUT';
                  ELSE                yTx1 := '??????';
                  END_CASE;
                  yTx2  := IPADR_TO_STRING(IPAdr := aAcc.wa[ xR^.h.cf.n ].IP );
                  aBlank(txt := ADR(yTx2), n:= 18);
                  yTx3 := LEFT(targetPage,10);
                  yTx1  := CONCAT(INT_TO_STRING(xR^.h.cf.n),'  ', yTx1,'    ',yTx2,'  ', yTx3); //111,'%d');
                  _NhVal2(   txt:=0, wT:=22, FgT:=4, fmt:=0);
                  yTx1  := LEFT(aAcc.wa[ xR^.h.cf.n ].LastFile,30);
                  _NhVal2(   txt:=0, wT:=22, FgT:=3, fmt:=0, y := 40);
         END_CASE;
      END_IF;
      j := j + 1;
   END_WHILE;
END_FUNCTION


{ $ END_IF }
