(* KNIZNICA PRE FUNKCIE WEBMAKERU: HomePage,autologin, presmerovanie na volnu stranku a riadenie pristupu = usermanagement, *)

{ $ IFDEF __NH_WEB }


// hlavna obrazovka



// ************************** web ****************

FUNCTION _NhTchObjOK   {HIDDEN} : BOOL                                     // dotyk nad aktivnym objektom ( cm>0) na stranke
	VAR_INPUT
		///***26.6.24 skusmo pridane pre 109
		Qr			: BOOL;						// posle hned v 1.cykle po dotyku aj CMD, cim zabezpeci refresh a prijatie xA^.tch.Qr
		obj		: BOOL := true;
		cmd		: USINT;
	END_VAR
	IF Obj THEN
   	xA^.tch.cm     := xO^.cm;	
	ELSE
		xA^.tch.cm     := cmd;
	END_IF;
	
   xA^.tch.row    := j;                               // tu sa vyplni ak by nebol browser
   xA^.tch.obj    := INT_TO_SINT(ix);
   xA^.tch.Q      := true;                            // centralny priznak, ze na nejakom objekte bol dotyk
   xA^.tch.Qr     := true;
   xO^.tch        := true;                            // priznak dotyku priamo na objekte, nuluje ho xA^.tch.Qf a do objektu uz nedojde
	xA^.tch.aObj	:= PTR_TO_UDINT( ADR(xO^) );
 	xO^.Q				:= true;									// nastavi sa Qr, zostane v objekte aj po Qf, objekt si ho spolu s Qf musi vynulovat sam
	IF Qr	THEN
		xA^.tch.CMD    := xA^.tch.cm;							// refresh v tom cykle je este xA^.tch.Qr := true
   	xO^.Qr			:= true;                         // cita sa v objekte, nuluje sa v dalsom cykle
	END_IF;
   ix             := 0;                                              // vykona sa exit s WHILE
   j              := 0;
   _NhTchObjOK       := true;


 	_Nh_Log_Evn_ADD(tsk := 200);


END_FUNCTION




FUNCTION _NhObjXY {HIDDEN}: BOOL                                     // dotyk nad aktivnym objektom ( cm>0) na stranke
   _NhObjXY := false;
   IF xA^.tch.x1 > xO^.x - x  AND
      xA^.tch.x1 < xO^.x + x  AND
      xA^.tch.y1 > xO^.y - y  AND
      xA^.tch.y1 < xO^.y + y  THEN

      _NhTchObjOK();
      _NhObjXY       := true;
   END_IF;
END_FUNCTION

FUNCTION _NhTchObj  {HIDDEN} : BOOL            // zaciatok noveho dotyky = hlada sa objekt
   VAR_TEMP
		wh2r		: BOOL;
      o        : INT;
      wh       : USINT;
//      whOld    : USINT;
	END_VAR
   _NhTchObj      := false;
   j  := USINT_TO_SINT(xM^.ixb[0].row.rws);
   WHILE _NhTchObj = false AND j > 0 AND xA^.tch.row < 0 DO
      IF xB^.r[ j ].h.nd > 0  THEN                                	// j = riadok
         xR    := ADR(xB^.r[ j ]);
         ix  	:= SINT_TO_INT(_RowObr);                              // ix = objekt; max.pocet objektov
         WHILE _NhTchObj = false AND  ix >= 0 DO                     // posupuje sa od posledneho objektu (je navrchu ) az k 0-temu, ktory je naspodku (oramovanie browsu)
				wh2r 	:=	false;
				IF ix > 0 THEN
            	xO    :=  ADR(xR^.o.ob[ix-1]);                           // predchadzajuci riadok
      			wh2r 	:= xO^.wh=123 OR  xO^.wh=109;							// preskoci aktualny riadok
				END_IF;
   			xO    :=  ADR(xR^.o.ob[ix]);					
            IF wh2r 	 THEN
					;
            ELSIF xO^.nTch OR xO^.wh =  0 THEN
					;	
            ELSIF xO^.wh = 13 THEN
            	o        		:= xO^.fn;
             	xS       		:= ADR(xB^.s[o]);
					IF xB^.s[xO^.fn].zom AND
						_NhTchObjXYW(	x	:=	xO^.x + xO^.w - 100,
											y 	:= xO^.y-50,
											w 	:= 100,					
											h	:= 30 		 )	THEN

						xB^.s[xO^.fn].tun := NOT xB^.s[xO^.fn].tun;        // zmeni tun/sld/tun...
                  _NhTchObj      := _NhTchObjOK();
                  xO^.tch   		:= false;                                           // nastavi sa okamzite dotyk
                  xA^.tch.cmd    := xA^.tch.cm;                                           // nastavi sa okamzite dotyk
						xA^.tch.end		:= true;

         		ELSIF _NhTchObjXYW(	x	:=	xO^.x-15,
												y 	:= xO^.y-10,
												w 	:= xO^.w+30,					
												h	:= 20 		 ) THEN

							IF (  xS^.bal AND xA^.tch.x1 > xS^.xv - 15 AND xA^.tch.x1 < xS^.xv + 15 ) // je zobrazena gulicka, dotyk na nej okamzite vyvola slider
                              OR
                           (  xA^.tch.x1 > xO^.x - 15 AND xA^.tch.x1 < xO^.x + 15)                // alebo dotyk okolo zaciatku
                              OR
                              xL^.brw = false   THEN

	                        _NhTchObj      := _NhTchObjOK();
  	                        xA^.tch.cmd    := xA^.tch.cm;                                           // nastavi sa okamzite dotyk
									xA^.tch.evn 	:= 6;

                     END_IF;
					END_IF;

            ELSIF xO^.wh = 14 THEN      // point-time SLIDER
            	IF xA^.tch.y1 > xO^.y - xO^.h AND                        // pod vrchom
                        xA^.tch.y1 < xO^.y + 50   AND                         // pod spodkom = obrazok
                        xA^.tch.x1 > xO^.x - 60    AND                        // pred zaciatkom
                        xA^.tch.x1 < xO^.x + xO^.w + 60    THEN               // za koncom
                        _NhTchObj      := _NhTchObjOK();


								xA^.tch.evn 	:= 6;
                        xA^.tch.cmd    := xA^.tch.cm;

						END_IF;


            ELSIF xO^.wh = 123 THEN      // vyber z volieb {riadkov} pod sebou  - NOVA VERZIA
               // tento objekt je dvojriadkovy, v druhom riadku sa vyhodnocuje WhOld z predch.riadka
               xOh := xO;
               IF xA^.tch.x1 >= xOh^.cf.x - 10                             AND     // 1.riadok zaciatok
                  xA^.tch.x1 <= xOh^.cf.x + xOh^.cf.w                         AND     // 1.riadok koniec
                  xA^.tch.y1 >= xOh^.cf.y - 20                             AND     // 1.riadok zaciatok
                  xA^.tch.y1 <= xOh^.cf.y + USINT_TO_INT(xOh^.cf.rw2)*xOh^.cf.h  THEN    // posledny riadok  (+10 je akokeby riadok naviac)

						_NhTchObj      := _NhTchObjOK(obj:=false,cmd:=205);
//                  xA^.tch.cm     := 251;
//                  xA^.tch.cm     := 205;
                  xOh^.tch       := true;                                           // priznak dotyku priamo na objekte


               END_IF;
//            ELSIF WhOld = 123 THEN       // prepinac medzi riadkami - NOVA VERZIA
               ;
            ELSIF xO^.wh = 103 THEN      // vyber z volieb {riadkov} pod sebou  - NOVA VERZIA
               ;
            ELSIF xO^.wh = 107 THEN      //  doplnujuce statusy na objektom
               IF _Nh_Web_SHW_107(tch:=true) THEN
                  _NhTchObj      := true;
               END_IF;
            ELSIF xO^.wh = 109 THEN      //  ROL * slider
            	xRo				:= xO;
               IF _NhxPt(c := xRo^.cf.c, n := xRo^.cf.n,x:=109) = false THEN
               	RETURN;
					END_IF;
               xRol 				:= xPt;
					xRol^.me.CMDs	:= 0;																		// reset
(*
					IF _NhxCfg(c := xRo^.cf.c, n := xRo^.cf.n, par := true, p := xRo^.cf.p, x:=20) = false THEN
						RETURN;
					END_IF;
*)

					del := USINT_TO_INT(xRo^.wObr);											// len prevod na INT - koli strukture

					IF xRo^.StatRow AND
						_NhTchObjXYW(		x := xRo^.xObrL - del/2 ,        				// dotyk nad ikonou LAM v stavovom riadku
												y := xRo^.yObr  - del/2 ,
												w := del,
												h := del) THEN
							_NhTchObj      := _NhTchObjOK( Qr:=true );
							xRol^.me.CMDs	:= 28;													// Lamely do opacneho smeru

					ELSIF xRo^.StatRow AND
							_NhTchObjXYW(	x := xRo^.xObrR - del/2 ,        				// dotyk nad ikonou ROL v stavovom riadku
												y := xRo^.yObr  - del/2 ,
												w := del,
												h := del) THEN
							_NhTchObj      := _NhTchObjOK( Qr:=true );
							xRol^.me.CMDs	:= 11;													// ROLETA prepnut

//					ELSIF xRol^.cx.etHandBlkWind > 0 AND														// bezi delay rucneho zasahu
					ELSIF xRol^.cx.CmdWind = 20 AND														// bezi delay rucneho zasahu
							_NhTchObjXYW(	x := xRo^.x + xRo^.w - xRo^.wObrInfo/2,		// zrusit delay rucneho zasahu
												y := xRo^.y - xRo^.wObrInfo/2,
												w := xRo^.wObrInfo,
												h := xRo^.wObrInfo) THEN
							_NhTchObj      := _NhTchObjOK( Qr:=true );
							xRol^.me.CMDs	:= 200;													// zrusit blokovanie

					ELSIF xRol^.cx.CmdWind = 10 AND												// bezi ochrana pred vetrom - restartnut
							_NhTchObjXYW(	x := xRo^.x - xRo^.wObrInfo/2,					
												y := xRo^.y - xRo^.wObrInfo/2,
												w := xRo^.wObrInfo,
												h := xRo^.wObrInfo) THEN
							_NhTchObj      := _NhTchObjOK( Qr:=true );
							xRol^.me.CMDs	:= 201;													// restart WindGuard

					ELSIF xRo^.SldLam AND xRo^.tchLam AND										// slider LAM
							_NhTchObjXYW(	x := xRo^.xLam - 10 ,
												y := xRo^.yLam - xRo^.rCirSld/2,
												w := 20,
												h := xRo^.hLam + xRo^.rCirSld) THEN
							_NhTchObj      := _NhTchObjOK( Qr:=true );
							xA^.tch.evn 	:= 6;
							xRol^.me.CMDs	:= 72;													// slider LAM

    				ELSIF _NhTchObjXYW(	x := xRo^.x  ,											// plocha rolety aj s boxom nad
												y := xRo^.y - xRo^.bRol,
												w := xRo^.w ,
												h := xRo^.h + xRo^.bRol + xRo^.rCirSld ) THEN

							_NhTchObj      := _NhTchObjOK( Qr:=true );
							IF xRo^.SldRol THEN                                         // povoleny slider
								xA^.tch.evn 	:= 6;
								xRol^.me.CMDs	:= 71;												  	// slider ROL
							ELSIF xRo^.tchUpDn  THEN                             			// povolit prepnutie
								xRol^.me.CMDs	:= 1;														// prepni
							ELSE
								xRol^.me.CMDs	:= 3;														// stop
							END_IF;
					END_IF;
					IF _NhTchObj AND xRo^.chk = false AND xRol^.cx.CMD > 200 THEN
						xA^.tch.evn 	:= 0;
						xRol^.me.CMDs	:= 3;													// restart WindGuard
      			END_IF

            ELSIF xO^.wh = 22 OR xO^.wh = 121 THEN      														//  HET/VEN : AUTO-MAN/0/1/2/3
//					IF _NhTchObjXYW(x:=xO^.x-xO^.w/2, y:=xO^.y-xO^.w/2, w:=xO^.h * 4 + xO^.w, h := xO^.w) THEN
					IF _NhTchObjXYW(x:=xO^.x-xO^.w/2, y:=xO^.y-xO^.w/2, w:=xO^.h * USINT_TO_INT(xO^.cf.c) + xO^.w, h := xO^.w) THEN
						_NhTchObj      := _NhTchObjOK();
					END_IF;

            ELSIF xO^.wh = 21  THEN
					IF _NhTchObjXYW(x:=xO^.x-xO^.w/2, y:=xO^.y-xO^.w/2, w:=xO^.w, h := xO^.w) THEN
						_NhTchObj      := _NhTchObjOK();
					END_IF;




            ELSIF xO^.wh > 0 AND xO^.nTch = false THEN

               x     := xO^.w / 2 + 9;
               y     := x;             //***

               // xO^.h : 1 - obrazok s  podfarbenim
               // 6 - vypis textu :vyska
               // 10 - obrazok WSB
               // 13 - slider
               // 16 - bool premenna
               // 17 - akcie na obrazovke k WSB
               // 19 - vypisanie hodnoty premennej : style
               // 20 - chceck nad polom obrazkov
               // 21 - vypis textu s hodnotou
               // 90 - dash h=vyska       OK
               CASE xO^.wh OF
//                 22 :   wh := 20;
                120 :   wh := 255;
               ELSE     wh := xO^.wh;
               END_CASE;

               CASE wh OF
                  0 : ;                                              // prazdny objekt
                255 :   // objekt je urceny sirkou a vyskou, vo vnutri moze mat podobejky, ktore sa identifikuju v _Nh_SHW
                        IF xA^.tch.x1 >= xO^.x - xO^.h/2          AND      // spodna hranica = zaciatok - vyska/2
                           xA^.tch.x1 <= xO^.x + xO^.w + xO^.h    AND      // horna hranica
                           xA^.tch.y1 >= xO^.y - xO^.h/2          AND      // vrch
                           xA^.tch.y1 <= xO^.y + xO^.h/2  THEN             // spodok
                           _NhTchObj := _NhTchObjOK();
                        END_IF;

                  6 :   // click nad textom formatovany je zlava do prava
                     ok := xA^.tch.y1 > xO^.y - 20 AND xA^.tch.y1 < xO^.y + 20;
                     CASE xO^.fn  OF
                       2 : // na stred
                           ok := ok AND xA^.tch.x1 > xO^.x - xO^.w/2 AND xA^.tch.x1 < xO^.x + xO^.w/2;
                       1 : // z prava do lava
                           ok := ok AND xA^.tch.x1 > xO^.x - xO^.w AND xA^.tch.x1 < xO^.x;
                       
                     ELSE  // zlaba do prava
                           ok := ok AND xA^.tch.x1 > xO^.x AND xA^.tch.x1 < xO^.x + xO^.w;

(*
                        IF xA^.tch.x1 > xO^.x           AND
                           xA^.tch.x1 < xO^.x + xO^.w   AND
                           xA^.tch.y1 > xO^.y - 20   AND
                           xA^.tch.y1 < xO^.y + 20 THEN
                           _NhTchObj      := _NhTchObjOK();
                        END_IF;
*)
                     END_CASE;
                     If ok THEN
                        _NhTchObj      := _NhTchObjOK();
                     END_If;



                 15 : // typovy DAY + PO-NE
                        xPtD  := ADR(xO^.cf.n);                                                             // na adrese xO^.cf.n + xO^.cf.p je adresa premennej v UDINT
                        xPoD  := UDINT_TO_PTR(xPtD^);

                        _Nh_FRM_Read(frm:=248);   // sablona PO-NE pre DAY,HET,VEN
                                                                       // pointer riadiacej jstruktury dna
                        xM^.pod.po.Btn := false;
                        IF    xA^.tch.y1 > xO^.y - 40 AND                                    // vrchny okraj typovyc dni
                              xA^.tch.y1 < xO^.y + 85+35 THEN                                // spodny okraj PO-NE
                           // sme v objekte
                           FOR i := 0 TO 11 DO
                              IF i > 0 AND i < 8 THEN
                                 y := xO^.y + 85;                                         // dni Pon-Ned
                              ELSE
                                 y := xO^.y;
                              END_IF;
                              IF xA^.tch.y1 < y + 40 AND                                  // nad spodkom
                                 xA^.tch.y1 > y - 40 AND                                  // pod vrchom
//                                 xA^.tch.x1 < xO^.x + _ObjDay.xDay[i]+40 THEN             // pred koncom objektu
                                 xA^.tch.x1 < xO^.x + yFrm_248.xDay[i]+40 THEN             // pred koncom objektu

                                 xM^.pod.po.Btn := xM^.pod.po.Day = i;                            // stlaceny ten isty BTN
                                 IF xM^.pod.cp.cpy THEN                                       // je oznacene kopirovanie
                                    IF xM^.pod.po.Btn = false THEN                            // vymazat vsetko ku kopirovaniu
                                       xM^.pod.cp.dst[i] := NOT xM^.pod.cp.dst[i];
                                    END_IF;
                                 ELSIF i = 0 THEN                                         // prepli sme na hlavmu ikonu prac.dni
                                    IF xPoD^.Day=0 OR xPoD^.Day > 7 THEN                  // predtym bola ina hlavna ikona
                                       xPoD^.Day := _Nh_Poi_Home_Day();                        // nastavi sa aktualny day
                                    END_IF;
                                    xM^.pod.po.Day := xPoD^.Day;
                                 ELSE

                                    IF xPoD^.Day = 0 THEN
                                       xPoD^.Day := i;                                    // prepnutie na iny den a ked je fix prepise Day
                                    END_IF;
                                    xM^.pod.po.Day := i;
                                 END_IF;
                                 _NhTchObj   := _NhTchObjOK();
                                 EXIT;
                              END_IF;
                           END_FOR;
                        END_IF;

                 10 : // akcie od WSB, typ spotrebica (v xO^.h je cislo obrazka)
                     _NhTchObj   := _NhObjXY();

                 17 : // akcie od WSB, typ spotrebica (v xO^.h je cislo obrazka)
                     _NhTchObj   := _NhObjXY();
                 19 : // text
(*
                  GTEXT_STYLE_ITALIC + GTEXT_STYLE_ALIGN_LEFT   + GTEXT_STYLE_HRIGHT  + GTEXT_STYLE_VCENTER,    // stred riadka zlava do prava
                  GTEXT_STYLE_ITALIC + GTEXT_STYLE_ALIGN_RIGHT  + GTEXT_STYLE_HLEFT   + GTEXT_STYLE_VCENTER,    // stred riadka, zprava do lava
                  GTEXT_STYLE_ITALIC + GTEXT_STYLE_ALIGN_CENTER + GTEXT_STYLE_HCENTER + GTEXT_STYLE_VCENTER,    // stred riadka, stred textu
                  GTEXT_STYLE_NORMAL + GTEXT_STYLE_ALIGN_LEFT   + GTEXT_STYLE_HRIGHT  + GTEXT_STYLE_VDOWN,       // zhora-dolu, zlava do prava
                  GTEXT_STYLE_NORMAL + GTEXT_STYLE_ALIGN_RIGHT  + GTEXT_STYLE_HRIGHT  + GTEXT_STYLE_VDOWN       // zhora-dolu, zlava do prava
*)
                     IF xO^.fn = 0 THEN
//                        y := xO^.h/2+5;
                        y := xO^.h*2  ;
                        CASE xO^.BgC OF
                          0 : x := -xO^.w/2;
                          1 : x := xO^.w/2;
                          3 : ;
                          4 : ;
                        END_CASE;
                        IF xA^.tch.y1 > xO^.y - y AND                        // pod vrchom
                           xA^.tch.y1 < xO^.y + y   AND                         // pod spodkom = obrazok
                           xA^.tch.x1+x > xO^.x - xO^.w/2    AND                        // pred zaciatkom
                           xA^.tch.x1+x < xO^.x + xO^.w/2    THEN               // za koncom
                           _NhTchObj      := _NhTchObjOK();
                        END_IF;
                     ELSE
                        _NhTchObj := _NhObjXY();
                     END_IF;

                 27 : // viac BOOL premennych v poli za sebou (DayMode+LOCK)
                        IF _NhObjXY() THEN
                           xO^.tch := 1;
                           _NhTchObj := true;
                        END_IF;

                 20 : // viac BOOL premennych v poli za sebou (DayMode+LOCK)
                     IF xO^.cf.c > 0 AND xO^.h = 0 THEN  // viac objektov na sebe, cislo objektu je ulozene v premennej, ktora je USINT, prepne na dalsi objekt
                        IF _NhObjXY() THEN
                           _NhTchObj := true;
                           xPtD  := ADR(xO^.cf.n);                                                             // na adrese xO^.cf.n + xO^.cf.p je adresa premennej v UDINT
                           xPtU  := UDINT_TO_PTR(xPtD^);
                           IF xPtU^ < xO^.cf.c THEN
                              xPtU^ := xPtU^ + 1;
                           ELSE
                              xPtU^ := 0;
                           END_IF;
                        END_IF;
                     ELSE
                        x := xO^.w/5*3;
                        IF xA^.tch.x1 > xO^.x - x  AND                            // tesne pred prvym obrazkom
                           xA^.tch.x1 < xO^.x + x + xO^.h * USINT_TO_INT(xO^.cf.c)  AND       // tesne za poslednym obrazkom
                           xA^.tch.y1 > xO^.y - x  AND
                           xA^.tch.y1 < xO^.y + x  THEN
                           _NhTchObj      := _NhTchObjOK();
                        END_IF;
                     END_IF;

                 23 :   // prepinac viac riadkov pod sebou
                        y := USINT_TO_INT(xO^.cf.c);
                        IF xA^.tch.x1 > xO^.x - 10          AND     // zaciatok komponenty
                           xA^.tch.x1 < xO^.x + xO^.w + 10  AND     // koniec
                           xA^.tch.y1 > xO^.y - 20          AND     // 1.riadok
                           xA^.tch.y1 < xO^.y + (xO^.fn * y) + 20   // posledny riadok
                                 THEN
                           _NhTchObj   := _NhTchObjOK();
                           o           := xO^.y + xO^.fn/2;
                           FOR i := 1  TO xO^.cf.c DO
                              IF xA^.tch.y1 < o THEN
                                 xFmt23      := ADR(xO^.fmt);
                                 xFmt23^.obj := i;
//                                 xA^.tch.prs := false;
                                 EXIT;
                              END_IF;
                              o := o + xO^.fn;
                           END_FOR;
                        END_IF;

//                 21 :   // prepinac viac riadkov pod sebou
//   	                  y     := x;
//	   	               _NhTchObj := _NhObjXY();

               ELSE
                  IF xO^.h <= 0 THEN
                     y     := x;
                  ELSE
                     y     := xO^.h / 2 + 9;
                  END_IF;
                  _NhTchObj := _NhObjXY();
               END_CASE;
            END_IF;
            IF _NhTchObj THEN
               RETURN;
            END_IF;
            ix       := ix - 1;
//            ix       := ix + 1;				
//            WhOld    := xO^.wh;                 // pre dvojriadkove objekty (123..)

         END_WHILE;
      END_IF;
      j := j - 1;
   END_WHILE;
END_FUNCTION



FUNCTION _NhTchMnu {HIDDEN} : BOOL      // najde riadok a v nom objekt na ktorom bol dotyk
  _NhTchMnu       := false;

  xA^.tch  := _eTch;
  aWht     := _eWht;


   xA^.tch.x1     := xCan^.touch.x;
   xA^.tch.x2     := xCan^.touch.x ;
   xA^.tch.y1     := xCan^.touch.y;
   xA^.tch.y2     := xCan^.touch.y;

   jj    := 8;                                                 // prechadzaju sa vsetky menu
   rb    := false;
   IF xM^.edt  THEN
      jj := 1;                                                                // testuje sa len CANCEL
   ELSIF xB^.rw > 0 AND xL^.brw THEN                                          // ak je browser a su naplnene nejake riadny, najskor pg navigator
      IF _NhTchXY(v := xA^.tch.y1, v1 := ky2, v2 := ky2, xy:= 30 ) THEN         // dotyk okolo  spodnej ciary
         x := xIxB^.x1;
         FOR i := 1  TO xIxB^.n DO
            IF _NhTchXY(v := xA^.tch.x1, v1 := x, v2 := x, xy := 30 ) THEN     // dotyk nad bodom
               IF xIxB^.idx > xIxB^.row.rws THEN                               // mame viac dat zaznamov ako je riadkov
                  IF i = xIxB^.n THEN                                          // posledny index
                     i := xIxB^.idx - xIxB^.row.rws + 1;
                  ELSIF i = 1 THEN                                             // 1.index
                     ;
                  ELSE
                     i := (i-1) * xIxB^.row.rws  + 1;                          // vypocita sa
                  END_IF;
               ELSE
                  i := 1;
               END_IF;
               _Nh_Map_Idx(ixb := 0, idx := i);                                  // namapuje najdeny index
               xIxB^.ix1   := i;                                               // toto asi nemusi byt
               xL^.rw1     := xIdx^.ix[aWeb.nbr].dev;                              // do 1.riadku sa vlozia data
               xA^.tch.cmd := 252;                                             // vypis a predefinovanie dat od noveho 1-veho riadka
               _NhTchMnu   := true;
               RETURN;
            END_IF;
            x := x + USINT_TO_INT(xIxB^.w);
         END_FOR;

			// dotyk na spodnej ciare mimo PG-navigator tu sa meni mierka yk:=1.0 .... yk       := MIN(xUsr^.cx.IP[1].y, 1.14) ;

		
		END_IF;
      ;
   END_IF;
   FOR j := 1  TO jj DO
      xOm  := ADR(xU^.o[j]);
      IF xOm^.fn > 0 AND  xOm^.cm > 0 AND
         _NhTchXY(v := xA^.tch.x1, v1 := xOm^.x, v2 := xOm^.x, xy:= xOm^.w/7*4 )  AND // sirka
         _NhTchXY(v := xA^.tch.y1, v1 := xOm^.y, v2 := xOm^.y, xy:= xOm^.w/7*4 )    // vyska
            THEN
         xA^.tch.obj  := j;
         xA^.tch.cm   := xOm^.cm;
         IF xL^.obj = 200 AND xA^.tch.obj > 2 THEN              // stlacene spodne menu v SETUP
            xA^.tch.cmd    := 200;
         ELSE
            xA^.tch.cmd  := xA^.tch.cm;
         END_IF;
         _NhTchMnu    := true;
         EXIT;
      END_IF;
   END_FOR;
   IF xM^.edt  THEN                                            // edituje sa nazov
      IF _NhTchMnu THEN
         xM^.new := -1;
      END_IF;
       xA^.tch.cmd      := 100;                                // aktivuje CMD editaciu okamzite
      _NhTchMnu         := true;
   ELSIF xA^.tch.x1 > xc - 150         AND                     // dotyk na nazve
         xA^.tch.x1 < xc + 150         AND
         xA^.tch.y1 > xU^.o[1].y - 20  AND                     // vyska nazvu
         xA^.tch.y1 < xU^.o[1].y + 20 THEN

      IF xF^.cf.c = 0 OR xF^.cf.n = 0 THEN                     // nazvy su z aLang
            ;
      ELSIF xM^.set THEN
         rb := aCfg[xL^.fil.cf.c].edn;                         // cfg, vratane nazvy Moj domov co je acfg[3] = zone
      END_IF;
      IF rb THEN
//			xA^.trg.Qr     := 0;
//			xA^.trg.Qf     := 0;
//			xA^.trg.Q      := 0;
         xA^.tch.cmd    := 101;                                // aktivuje CMD editaciu okamzite
         xM^.edt        := true;                               // pri modifikacii nazvu sa to oznaci hned
         _NhTchMnu      := true;
      END_IF;
   END_IF;
END_FUNCTION


FUNCTION_BLOCK _NhWebAcces   {HIDDEN}
   VAR_TEMP
      s        : USINT;
      sa       : USINT;
//      new      : STRING[14];
   END_VAR
   GetWebServerAccess(accessTable := aAcc.wA);
   IF aAcc.wA <> aAcc.wO OR SYSTEM_S.F_EDGE_1SEC THEN
      aAcc.WebChg := aAcc.WebChg + 1;                                         // pocet zmien
      memset(0, sizeof(aAcc.pgN), void(aAcc.pgN));                          // vymazat novy pg, ktorasa bude naplnat
      ii := aWeb.A[1].usr;
      FOR aWeb.nbr := 1 TO _Nh_WEB_M DO
         aWeb.A[ aWeb.nbr ].usr := 0;
      END_FOR;
      FOR s := 0 TO 7 DO
         sa    := _webState(s := aAcc.wA[s].state);
         IF sa = 3  THEN                                                      // zaujima nas len stav 3
            yTx3  := MID(aAcc.wA[s].lastFile,8,5);                            // "/002_NHM.XML" .... '_NHM.XML'
            IF yTx3 = '_NHM.XML' THEN                                           // nova stranka je Mx                           OK
               yTx3  := MID(aAcc.wA[s].lastFile,3,2);
               i := STRING_TO_USINT(yTx3);
               IF i <= _Nh_WEB_M THEN
                  aWeb.A[ i ].usr := i;
                  IF aWeb.M[ i ].naz = '' AND  aWeb.M[ i ].new < 1 THEN
                     aWeb.A[ i ].tch.cmd := 20;                   // vytvori sa nova obrazovka
                     aWeb.M[ i ].lvl     := 0;
                  END_IF;
               END_IF;
            END_IF;
         END_IF;
      END_FOR;
      IF aWeb.A[1].usr > 0 AND ii > 0 THEN
//         aWeb.A[1].usr := ii;
      END_IF;
      aAcc.wO  := aAcc.wA;                                            // vyrovna data
   END_IF;
END_FUNCTION_BLOCK

FUNCTION_BLOCK _NhWebControl    {HIDDEN}
  	VAR
      fbNhWebAcces : _NhWebAcces;
  	END_VAR
      fbNhWebAcces();                                                // riadenie pristupu na webserver
      // prechadza nadefinovane stranky
      FOR aWeb.nbr := 1 TO _Nh_WEB_M DO
//         IF aAcc.pgN.pg[aWeb.nbr].usage > 0 THEN                   // aktivna stranka
         xA       := ADR( aWeb.A[ aWeb.nbr ] );                      // dotk,canvas..
         IF xA^.usr > 0 THEN                                         // aktivna stranka
            xM       := ADR( aWeb.M[ aWeb.nbr ] );                   // zakladne data stranky
            xB       := ADR( xM^.brw );                              // browser
            xU       := ADR( xM^.mnu[ aWeb.M[aWeb.nbr].lvl ]);                            // menu
            xL       := ADR( xM^.lvd[ aWeb.M[aWeb.nbr].lvl ]);                            // data k browsu
            xCan     := ADR( aWeb.A[ aWeb.nbr ].can );               // canvas
            xA^.trg(In := xCan^.touch.y > -32767 );                  // zistenie dotyku
            _NhxUsr(u := xA^.usr );                                  // pri vstupe do session namapuje usra, potom uz v programe nikdy
            xA^.admin   := aWeb.nbr = 1;
            IF xUsr^.cx.sbj = 0 OR xUsr^.cx.sbj > INT_TO_USINT(aCfg[3].rec) THEN
               xA^.sbj     := 1;
            ELSE
               xA^.sbj     := xUsr^.cx.sbj;
            END_IF;
            xA^.admin      := aWeb.nbr    = 1;
            IF xA^.admin THEN
               xA^.UsrRight   := 9;
            ELSE
               xA^.UsrRight   := xUsr^.cx.UsrRight;
            END_IF;
            IF xUsr^.cx.IP[1].y > 1.0 THEN
               yk       := MIN(xUsr^.cx.IP[1].y, 1.14) ;
               yk       := MIN(xUsr^.cx.IP[1].y, 1.5) ;
            ELSE
               yk       := 1.0;
            END_IF;
            ky2      := REAL_TO_INT( INT_TO_REAL(yy2)*yk);
            IF xUsr^.cx.IP[1].y <> xUsr^.cx.IP[2].y THEN                                     // zmena vysky zobrazenia
               xA^.hom           := true;                                                    // vytvori sa nova obrazovka
               xUsr^.cx.IP[2].y  :=  xUsr^.cx.IP[1].y;
            END_IF;

            // VYHODNOTENIE DOTYKU - PRIRADENIE AKCIE
            // 1 - potiahnutie dolu
            // 2 - potiahnutie hore
            // 3 - potiahnutie dolava
            // 4 - potiahnutie doprava
            // 5 - dotyk
            // 6 - PRESS


				xA^.tch.Qr	:= false;
				xA^.tch.Qf	:= false;					
            IF xA^.hom THEN
               xM^.naz     := '';
               xA^.tch.cmd := 20;                                                // prekresli sa nova obrazovka
               xM^.lvl     := 0;
               xA^.hom     := false;
   			ELSIF xA^.trg.Qr THEN                                                // prvy dotyk zisti ci bol na nejakom objekte
               IF _NhTchMnu() THEN                                               // najskor skusi menu
                  xA^.tch.End := true;                                           // natvrdo ukoncit , necaka sa za Qf
                  xA^.tch.Mnu := true;                                           // natvrdo ukoncit , necaka sa za Qf
                  xA^.tch.evn := 1;                                              // kod dotyku
                  xM^.htt     := '';                                             // zrusi pripadnu externu stranku
               ELSIF _NhTchObj() THEN
(*
                  IF xA^.tch.cmd > 0 THEN                                        // prisiel fixny EVN, vzdy ma prednost
                     ;
                  ELSIF xL^.brw = false AND xO^.prs = false THEN                  // NIE-je browser, ALEBO objekt nema povoleny pres
                     xA^.tch.evn := 5;
                     xA^.tch.cmd := xA^.tch.cm;
                  END_IF;
*)
               ELSE                                                              // dotyk mimo objektu
                  xA^.tch.cm  := 254;                                            // kompletny refresh od 1. riadku
						xA^.tch.End	:= 1;
               END_IF;

				ELSIF xA^.trg.Qf THEN                                                // koniec dotyku alebo press
					xA^.tch.Qf		:= 1;
					xA^.tch.End    := 1;
					IF xA^.tch.aObj > 0 THEN
						xO					:= UDINT_TO_PTR(xA^.tch.aObj);
						xO^.Qf			:= true;
						IF xA^.tch.evn = 6 THEN
     						xA^.tch.cmd := xA^.tch.cm;
						ELSIF xA^.tch.evn = 0 THEN
///***							xA^.tch.evn := 4;
     						xA^.tch.cmd := xA^.tch.cm;
						END_IF
      			END_IF;

				ELSIF xA^.tch.cmd > 0 THEN                                           // nieco nasilne obieha dookola (rolovanie)
					IF xA^.tch.aObj > 0 THEN
						xO					:= UDINT_TO_PTR(xA^.tch.aObj);
						xO^.Qr			:= false;
//						xO^.Dummy1		:= 1;
					END_IF;
					;
            ELSIF xA^.trg.Q THEN                                                   // fyzicky pokracuje dotyk
               xA^.tch.tme := xA^.tch.tme + aSys.mSec;
               xA^.tch.x2  := xCan^.touch.x ;                                       // suradnica po posunuti
               xA^.tch.y2  := xCan^.touch.y ;
					IF xA^.tch.aObj > 0 THEN
						xO					:= UDINT_TO_PTR(xA^.tch.aObj);
						xO^.Qr			:= false;
                  IF xL^.brw = false AND xO^.prs  THEN                  // NIE-je browser, ALEBO objekt nema povoleny pres
							IF xA^.tch.tme > 800 THEN
								xA^.tch.evn := 6;
							ELSE
								xA^.tch.evn := 5;
							END_IF;
						END_IF;	
					END_IF;
               IF xA^.tch.End 	THEN                                 				// fyzicky je dotyk, ale uz je vyhodnoteny Up-Dn-Left-right
						xA^.tch.cmd := 0;
						///***28.6.24
						xO^.tch		:= false;
						IF xA^.tch.aObj > 0 THEN
							xO^.Q		:= false;
   					END_IF;
					ELSIF xA^.tch.evn = 0 THEN
                  IF xA^.tch.y2 - xA^.tch.y1 > 20 THEN                                 // dolu
                     xA^.tch.evn := 1;
//                     ok          := true;
                  ELSIF xA^.tch.y1 - xA^.tch.y2 > 20 THEN                              // hore
                     xA^.tch.evn := 2;
//                     ok          := true;
                  ELSIF xA^.tch.x1 - xA^.tch.x2 > 100 THEN                              // potiahnutie dolava
                     xA^.tch.evn := 3;
//                     ok2         := true;
                  ELSIF xA^.tch.x2 - xA^.tch.x1 > 100 THEN                              // potiahnutie doprava
                     xA^.tch.evn := 4;
//                     ok2         := true;
                  END_IF;
						IF xA^.tch.evn > 0 THEN
							xO^.tch		:= false;									////30.11.23 - pri rolovanisa zapinali objekty het/tve
///***							xA^.tch.obj	:= 0;
							xA^.tch.End := 1;
	     					xA^.tch.cmd := xA^.tch.evn;							
						END_IF;
					ELSIF xA^.tch.evn = 6 THEN
     					xA^.tch.cmd := xA^.tch.cm;
					ELSIF xA^.tch.evn = 5 THEN
     					xA^.tch.cmd := xA^.tch.cm;
					END_IF;
				ELSIF xA^.tch.End THEN                                                // koniec dotyku alebo press
					IF xA^.tch.aObj > 0 THEN
						xO					:= UDINT_TO_PTR(xA^.tch.aObj);
						xO^.tch			:= false;
						xO^.Qf			:= false;
						xO^.Q				:= false;
						xA^.tch.aObj	:= 0;
      			END_IF;
					xA^.tch.End    := 0;
					xA^.tch.Q		:= 0;
					xA^.tch.cmd 	:= 0;
				END_IF;

            IF xA^.tch.cmd > 0 THEN                            // akcia od dotyku, nieco sa ma vykonat a v dalsom kole zobrazit
//               _Nh_Web_CMD(m := aWeb.M[aWeb.nbr]);             // zisti sa co sa ma vykonat
               aWeb.go     := true;                           // aby sa nevykonalo 2x
               aWeb.trg(rst := true, in := true);              // pripravi FB aby v dalsom cykle bol Qr
            ELSE                                               // ziadna akcia
               IF xL^.obj = 0 THEN                             // HOME
                  IF xHom^.ok.ref AND SYSTEM_S.R_EDGE_1SEC THEN
                     aWeb.trg.in := true;
                     aWeb.trg.Q  := false;                           // aby sa zabezpecil Qr
                     xHom^.ok.ref := false;                    // vynuluje sa poziadavka DEV
                  END_IF;
               ELSE
                  // zabezpecit refesh FRAME a HOME SCREEN
                  ok := SYSTEM_S.R_EDGE_1SEC;
                  IF ok THEN
                     IF xU^.o[8].fn > 50 THEN                           // zapnuty filter. Browser nemusi mat nic zobrazene
                        aWeb.trg.in := true;
                        aWeb.trg.Q  := false;
                     ELSE
                        FOR  i := 0  TO xB^.rw DO                       // hlada sa zobrazene DEV pre xM stranku
                           IF xB^.r[i].h.cf.c > 0  THEN
										IF xB^.r[i].h.cf.c = 2 THEN
											;
										ELSIF	_NhxPt(c := xB^.r[i].h.cf.c, n := xB^.r[i].h.cf.n,x:=49) THEN
											IF xPt^.ok.ref THEN                       // poziadavka DEV na refresh nastartuje refresh
   	                              aWeb.trg.in := true;
      	                           aWeb.trg.Q  := false;                           // aby sa zabezpecil Qr
         	                        xPt^.ok.ref := false;                  // vynuluje sa poziadavka DEV
            	                     ok          := false;
               	               END_IF;
										END_IF;
                           END_IF;
                        END_FOR;
                        IF ok AND xHom^.ok.ref THEN                     // nebol ziadny refresh, a v celom systeme bola zmena
                           IF xU^.o[8].fn > 50 THEN                     // zapnuty ON-filter
                              aWeb.trg.in := true;
                              aWeb.trg.Q  := false;
                           END_IF;
                        END_IF;
                     END_IF;
                  END_IF;
               END_IF;
               aWeb.trg();
               IF aWeb.trg.Qr THEN
///                  aWeb.trg.cm := 2;
                  aWeb.trg.et := 400;
                  aWeb.Go     := true;
               ELSIF aWeb.trg.Qe THEN
(*
                  IF aWeb.trg.cm > 0 THEN
                     aWeb.trg.cm := aWeb.trg.cm - 1;
                     aWeb.trg.et := 650;
                  ELSE
                      aWeb.trg.in := false;
                  END_IF;
*)
                  aWeb.Go     := true;
               END_IF;
               IF aWeb.Go  THEN
                  // vymysliet typ refreshu
                  IF xU^.o[8].fn > 50 THEN                                                // zapnuty ON-filter
                     xA^.tch.cmd := 254;                                                             // uplne novy vypis
                  ELSE
                     xA^.tch.cmd := 252;
                  END_IF;
               END_IF;
            END_IF;
            IF aWeb.Go THEN
               IF xA^.tch.row > 0 THEN
                  j  := xA^.tch.row;
                  xR := ADR(xB^.r[ j ]);
                  IF xR^.h.cf.c > 0 AND xR^.h.cf.c <> 2 THEN
                     _NhxPt(c := xR^.h.cf.c, n := xR^.h.cf.n,x:=50);
                     xDev := xPt;
                  END_IF;
               END_IF;

               _Nh_Web_CMD();               
               
               aWeb.nrf := aWeb.nrf  + 1;
               aWeb.Go  := false;
            END_IF;
            xM^.frm  := xM^.htt <> '';                                                    // schova iFame = vnorena web stranka
         END_IF;
      END_FOR;

END_FUNCTION_BLOCK

