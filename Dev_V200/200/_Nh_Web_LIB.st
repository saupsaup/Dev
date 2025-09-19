(* KNIZNICA PRE FUNKCIE WEBOVEHO ZOBRAZOVANIA WEBMAKERU *)

FUNCTION _LenPreKompilator{HIDDEN} : BOOL              // toto musi byt pred prvym pouzitim funkcii GC_  , inak kompilator vyhlasi chybu
   GC_Begin(GrData 	:= xCan);
   GC_End(GrData 		:= xCan);
END_FUNCTION





FUNCTION _NhTchPoi {HIDDEN} : BOOL    // dotyk nad obrazkom=zmeni obrazok alebo vrati ak bol dotyk nad navestim
   VAR_INPUT
      obr      : BOOL;
   END_VAR
   VAR_TEMP
      i        : SINT;
      s        : NH_ARR_POI;
   END_VAR
   _NhTchPoi   := true;
   FOR i := 0 TO xM^.pod.po.p - BOOL_TO_SINT(obr) DO                                      // pri obr sa ide len do xM^.pod.po.p -1
      IF obr  THEN
         IF xA^.tch.x1 < xM^.pod.px.xy[0,i+1] - 5 THEN                                        // zmena obrazka / hodnoty
            xArP^.p[i].o := xArP^.p[i].o + 1;
            IF xArP^.p[i].o > xM^.pod.po.cf.o THEN
               xArP^.p[i].o := 0;
            END_IF;
            IF xM^.pod.po.x > 0 THEN                                                       // ak je POI vrati suradnice
               xA^.tch.x2 := xM^.pod.px.xy[0,xM^.pod.po.x];
               xA^.tch.y2 := xM^.pod.px.xy[1,xM^.pod.po.x];
            END_IF;
            RETURN;
         END_IF;
      ELSE
         IF _NhTchXY(v := xA^.tch.x2, v1 := xM^.pod.px.xy[0,i], v2 := xM^.pod.px.xy[0,i], xy := 20 ) AND
            _NhTchXY(v := xA^.tch.y2, v1 := xM^.pod.px.xy[1,i], v2 := xM^.pod.px.xy[1,i], xy := 20 ) THEN
            IF i = 0 THEN                                                        // navestie zaciatku = clear
               s.p[0]      := xArp^.p[0];                                        // do cistej premennej sa podhodi spodna a vrchna hranica
               s.p[1]      := xArp^.p[xM^.pod.po.p];
               xArp^       := s;                                                 // prepise sa preddefinovanou premennou
               xM^.pod.po.idx  := true;

            ELSIF i = xM^.pod.po.p THEN                                              // navestie vrchnej hranice = default
               xArp^       := ePoi.cx;                                           // prevezme sa momentalne nastavena Default premenna
               xM^.pod.po.idx  := true;
               xM^.pod.po.x    := -1;
            ELSE
               xA^.tch.x2  := xM^.pod.px.xy[0,i];       // koriguje pohyb aby sa po dotyku nezmenila hodnota
               xM^.pod.po.x    := i;                   // ulozi cislo pointu, kde bol dotyk
               RETURN;
            END_IF;
         END_IF;
      END_IF;
   END_FOR;
   _NhTchPoi := false;
END_FUNCTION

FUNCTION _NhPoi01 {HIDDEN} : BOOL    // sortuje/ zindexuje pointy slidera od najmensieho po najvacsie
   ix := REAL_TO_INT(INT_TO_REAL(xA^.tch.x2 - xO^.x)/xM^.pod.px.mx);
   IF ix > xArP^.p[0].t + 1 AND ix < xArP^.p[xM^.pod.po.p].t -1 THEN                                                              // ak sa nico zmrvi dostaneme sa do default
      xArP^.p[ xM^.pod.po.cf.n ].t := ix;
      _NhPoi01 := true;
   ELSE
      _NhPoi01 := false;
   END_IF;
END_FUNCTION


FUNCTION _Nh_Poi_Map_Zom  {HIDDEN}  : BOOL
   VAR_INPUT
      zom   : BOOL;
   END_VAR
   _Nh_Poi_Map_Zom  := true;
//   xO2         := xO - SIZEOF(NH_OBJ_DAT);                     // objekt slidera je predchadzajuci objekt
   xO2         := xO + SIZEOF(NH_OBJ_DAT);                     // objekt slidera je nasledujuci objekt
	IF xM^.pod.po.x < 0 THEN
      xM^.pod.po.x    := -1;
      xM^.pod.po.zom  := false;
   ELSIF zom THEN
      xM^.pod.po.zom  := true;
      xO2^.wh     := 13;
//      xO2^.y      := xO^.y - xO^.h-60;                           // nad POI slider
      xO2^.y      := xO^.y + 50;                           // nad POI slider
      xO2^.tch    := false;                                       // aby pri prvom zobrazeni
      ix          := xO2^.fn;
      xS          := ADR(xB^.s[ ix ]);
      xS^.vb      := PTR_TO_UDINT(ADR( xArP^.p[ xM^.pod.po.x ].t ));   // slider
      xS^.xa      := xO^.x + (xO^.w)/2;                       // namapovany je aktualny objekt
   ELSE
      xM^.pod.po.x    := -1;
      xM^.pod.po.zom  := false;
      xO2^.wh 		:= 0;
   END_IF;
END_FUNCTION

FUNCTION _Nh_Poi_SLD   {HIDDEN}   : BOOL    // sortuje/ zindexuje pointy slidera od najmensieho po najvacsie
   VAR_TEMP
      npo       : BOOL;
      i,k,p     : SINT;
      s         : NH_ARR_POI;
   END_VAR
   _Nh_Poi_SLD    := true;
   IF xM^.pod.po.poi = 0 THEN                                                                     // bez pointru nevypisuje
      RETURN;
	ELSIF xM^.pod.po.poi = -1 THEN                                                                     // bez pointru nevypisuje

      xPox  := ADR(aWeb.M[ aWeb.nbr ].brw.r[10].o.ob[0].x);
      xArP  := ADR(xPox^.cx);                                                                    // pole pointrov zacina az za xDev.ok (+1)
   ELSIF _NhxPt(c := 26, n := xM^.pod.po.poi, x:=8 ) THEN
      xPox  := xPt;
      xArP  := ADR(xPox^.cx);                                                                    // pole pointrov zacina az za xDev.ok (+1)
   ELSE
      RETURN;                                                                                // neplatna veta
   END_IF;
	yPox   	:= xPox^;
   IF xM^.pod.po.p = -1 THEN                                                                     // na zaciatku inicializuje mierky a pocet aktivnych pointov
      vr := 0.0;
      xM^.pod.px.my := 0.0001;
      FOR i := 0 TO xM^.pod.po.cf.n DO
         IF xArP^.p[i].t > - 1 THEN
            vr := MAX(vr, xM^.pod.po.cf.va[ xArP^.p[i].o ]);                                      // zisti maximalnu moznu hodnotu
            xM^.pod.po.p  := i;
         END_IF;
      END_FOR;
      xM^.pod.px.mx := INT_TO_REAL(xO^.w) / INT_TO_REAL( (xArP^.p[xM^.pod.po.p].t - xArP^.p[0].t) );// 1.min = pocet bodov obrazovky
      xM^.pod.px.my := INT_TO_REAL(xO^.h-120) / vr;                                               // y-mierka sa ponizi o vysku kde budu vypisovane casove navestia
   END_IF;


	xM^.pod.po.Qf  	:= false;
   IF xO^.tch AND xA^.trg.Qr  THEN                                  // nebol dotyk na tomto objekte, ale na inom len prekreslit
      xO^.tch     := false;
      xM^.pod.po.tch  := true;
      xM^.pod.po.tpr  := 0;
      _Nh_Poi_SLD := false;                              // aby sa hned vratil naspat na xA^.trg.Q
   ELSIF xM^.pod.po.tch  = false THEN
      _Nh_Poi_SLD := false;                              // aby sa hned vratil naspat na xA^.trg.Q
   ELSIF xA^.trg.Qf THEN                                    // koniec dotyku alebo press bud ukonci akciu, alebo zacne novu
      xM^.pod.po.tch  	:= false;
      xM^.pod.po.Qf  	:= true;
      IF xM^.pod.po.prs THEN
         xM^.pod.po.prs := 0;
         _Nh_Poi_Map_Zom(zom := true);
      ELSIF _NhTchPoi() THEN                                // click/dotyk nad navestim = LUPA slider
         _Nh_Poi_Map_Zom(zom := true);
      ELSIF xA^.tch.y2 > xO^.y + 15 THEN                    // pod ciarou = zmena obrazka
			IF xM^.pod.po.zom = false THEN
	         _Nh_Poi_Map_Zom();
   	      _NhTchPoi(obr := true);
			END_IF;
      ELSIF xArP^.p[xM^.pod.po.cf.n].t < 0                      // dotyk mimo navesia a posledny POI je volny
         AND xA^.tch.y2 < xO^.y + 5                         // na zakladnej ciare
         AND xA^.tch.y2 > xO^.y - 50                        // nad zakl.ciarou
         AND _NhTchXY(v := xA^.tch.x2, v1 := xM^.pod.px.xy[0,0], v2 := xM^.pod.px.xy[0,xM^.pod.po.p], xy:= -5 )  // dotyk v intervale s odstupom od zaciatku a konca
             THEN
         xArP^.p[ xM^.pod.po.cf.n ].t := REAL_TO_INT(INT_TO_REAL(xA^.tch.x2 - xO^.x)/xM^.pod.px.mx);    // pridanie noveho pointu
         xM^.pod.po.idx  := true;
         _Nh_Poi_Map_Zom();
//      ELSE
		ELSIF xM^.pod.po.zom = false THEN	
         _Nh_Poi_Map_Zom();
      END_IF;
   ELSIF xM^.pod.po.prs THEN                                   // pohybujeme sa z bodom
      ;
   ELSIF xA^.trg.Q THEN                                     // vyhodnotenie press
      _Nh_Poi_SLD    := false;                                 // toto sem vracia dalsi cyklus
		IF xA^.tch.y2 > xO^.y +1 THEN
			;
      ELSIF xM^.pod.po.tpr < 180 THEN                               // az 4 cyklus bude ako press
         xM^.pod.po.tpr := xM^.pod.po.tpr + MIN(44,UINT_TO_USINT(aSys.mSec));
         _Nh_Poi_Map_Zom();                                    // zrusi slider zom

      ELSIF _NhTchPoi() THEN                                // len ked zistime dotyk nad navestim
         xM^.pod.po.prs  := true;
      END_IF;
   END_IF;

//   IF xM^.pod.po.zom = false THEN
//      xB^.r[1].o.ob[j+1].wh  :=  0;
//   ELSE
//      xArP^.p[xM^.pod.po.x].t := LIMIT(xArP^.p[xM^.pod.po.x].t,xArP^.p[xM^.pod.po.x-1].t+1,xArP^.p[xM^.pod.po.x+1].t-1);
//   END_IF;
//   IF xM^.pod.po.run THEN //AND xM^.pod.po.x > -1 THEN                                                   // pohybujeme s bodom


   IF xM^.pod.po.x > -1 AND xM^.pod.po.zom = false THEN                                                   // pohybujeme s bodom

         xArP^.p[xM^.pod.po.x].t := LIMIT(xArP^.p[xM^.pod.po.x].t,xArP^.p[xM^.pod.po.x-1].t+1,xArP^.p[xM^.pod.po.x+1].t-1);
         xArP^.p[xM^.pod.po.x].t := REAL_TO_INT(INT_TO_REAL(xA^.tch.x2 - xO^.x)/xM^.pod.px.mx);
         IF xArP^.p[xM^.pod.po.x].t < 2 THEN
               xArP^.p[xM^.pod.po.x].t   := -1;
               xM^.pod.po.idx  := true;
               xM^.pod.po.x    := -1;
         ELSIF xArP^.p[xM^.pod.po.x].t > 1438 THEN
               xArP^.p[xM^.pod.po.x].t   := -1;
               xM^.pod.po.idx  := true;
               xM^.pod.po.x    := -1;
         ELSIF xA^.tch.x2 < xM^.pod.px.xy[0,xM^.pod.po.x] THEN                                          // pohyb zprava do lava
            i := xM^.pod.po.x - 1;
            WHILE i > 0 AND xA^.tch.x2 <= xM^.pod.px.xy[0,i] DO                                  // zrusi vstky pointy pred ktore sa presunul
               xArP^.p[i].t   := -1;
               xM^.pod.po.x       := xM^.pod.po.x-1;                                                 // TOTO JE NUTNE ! prestavi sa point vlavo (pre pointom do podrzania)
               xM^.pod.po.idx     := true;
               i := i - 1;
            END_WHILE;
         ELSIF xA^.tch.x2 > xM^.pod.px.xy[0,xM^.pod.po.x] THEN                                       // z lava do prava
            i := xM^.pod.po.x + 1;
            WHILE i < xM^.pod.po.p AND xA^.tch.x2 >= xM^.pod.px.xy[0,i] DO                           // zrusi vstky pointy za ktore sa presunul
               xArP^.p[i].t   := -1;
               xM^.pod.po.idx  := true;

//                xM^.pod.po.x      := xM^.pod.po.x + 1;                                                // pri pohybe do prava netreba prestavovat point !!!
               i := i + 1;
            END_WHILE;
         END_IF;
   END_IF;

  // preindexovat
   IF xM^.pod.po.idx THEN
      xM^.pod.po.idx  := false;
      xM^.pod.po.p    := -1;
      FOR i := 0 TO xM^.pod.po.cf.n DO
         ix := 30000;
         p  := -1;
         FOR k := 0  TO xM^.pod.po.cf.n DO
            IF xArP^.p[k].t > -1 THEN
               IF xArP^.p[k].t < ix THEN
                  ix    := xArP^.p[k].t;
                  p     := k;
               END_IF;
            END_IF;
         END_FOR;
         IF p > -1 THEN
            xM^.pod.po.p       := xM^.pod.po.p + 1;
            s.p[xM^.pod.po.p]  := xArP^.p[p];
            xArP^.p[p].t   := xArP^.p[p].t * -1 - 1;
            IF npo AND p = xM^.pod.po.cf.n THEN                             // novy point sa oznaci ako zoom POI
               npo      := false;

//               xM^.pod.po.x := xM^.pod.po.p;


            END_IF;
         END_IF;
      END_FOR;
      FOR i := 0 TO xM^.pod.po.cf.n DO
         xArP^.p[i]  := s.p[i];
         IF s.p[i].t > -1 THEN
            xM^.pod.po.p := i;
         END_IF;
      END_FOR;
   END_IF;

////   xArP^.p[xM^.pod.po.p].o := xArP^.p[0].o;                                                        // v hoornej hranici je to iste co v spodnej (farba)

   xArP^.p[xM^.pod.po.p].o := xArP^.p[xM^.pod.po.p-1].o;                                                        // v hoornej hranici je to iste co v spodnej (farba)


   // vynasacie ciary, box,obrazky,hodnoty
   GC_SetLineStyle(style   := GLINE_STYLE_SOLID+GLINE_CAP_ROUND, GrData := xCan);
   GC_SetTextSize (size 	:= 24 , GrData := xCan);           // vyska textu
   GC_SetLineWidth(Width   := 2, GrData := xCan);
   GC_SetTextstyle(style   :=  _Nh_Sty[2], GrData := xCan);                                                     // text centrovat

(*
   // aktualny cas
   ix := xO^.x + REAL_TO_INT(INT_TO_REAL(aSys.dMin) * xM^.pod.px.mx);                           // x-suradnica aktualneho casu
*)

	IF xM^.pod.po.cf.typ = 3 THEN																						//
   	ix := xO^.x + REAL_TO_INT(30. * xM^.pod.px.mx);
      GC_SetFgColor  (Color   := _NhColor[3], GrData := xCan);                                                     // siva ciara
      GC_Line        (x1 := ix, y1 := xO^.y-3, x2 := ix , y2 := xO^.y - xO^.h/3*4 ,	GrData := xCan);                  // vynasacia ciara - aktualny cas
      // navestie pod casom
      GC_SetFillStyle(style   := GFILL_STYLE_FRAME, GrData := xCan);					
      GC_SetFgColor  (Color   := _NhColor[3], GrData := xCan);                                                     // oramovanie
      GC_SetBgColor  (Color   := _NhColor[3], GrData := xCan);                                                     // podklad pod textom
      GC_cRoundBox   (width := 280, height := 38, fill := 1, r:= 15, GrData := xCan);
//      GC_SetFgColor  (Color   := _NhColor[4], GrData := xCan);                                                          // siva ciara
//      GC_SetFillStyle(style   := GFILL_STYLE_BGCOLOR, GrData := xCan);					
		_Nh_Lang(id := 475 ,txt := ADR( yTx1 ));
//      GC_WriteText   (text := yTx1, GrData := xCan);           //

      xM^.pod.po.cf.fm := '%3.0f%%';

   ELSIF xM^.pod.po.zom = false AND xM^.pod.po.prs = false THEN                                                   			// vypis textu 'Typove dni'
	   // aktualny cas
   	ix := xO^.x + REAL_TO_INT(INT_TO_REAL(aSys.dMin) * xM^.pod.px.mx);                           // x-suradnica aktualneho casu

      GC_SetFgColor  (Color   := _NhColor[2], GrData := xCan);                                                     // siva ciara
      GC_Line        (x1 := ix, y1 := xO^.y-3, x2 := ix , y2 := xO^.y - xO^.h ,	GrData := xCan);                  // vynasacia ciara - aktualny cas
      // navestie pod casom
      GC_SetFillStyle(style   := GFILL_STYLE_FRAME, GrData := xCan);					
      GC_SetFgColor  (Color   := _NhColor[3], GrData := xCan);                                                     // oramovanie
      GC_SetBgColor  (Color   := _NhColor[3], GrData := xCan);                                                     // podklad pod textom
      GC_cRoundBox   (width := 80, height := 35, fill := 1, r:= 15, GrData := xCan);
      yTx1  := TIME_TO_STRINGF(UDINT_TO_TIME( INT_TO_UDINT(aSys.dMin) * 1000 * 60),'%Th:mm');
   END_IF;

      GC_SetFgColor  (Color   := _NhColor[4], GrData := xCan);                                                          // siva ciara
      GC_SetFillStyle(style   := GFILL_STYLE_BGCOLOR, GrData := xCan);					
      GC_WriteText   (text := yTx1, GrData := xCan);           //

   rb := false;

   IF xArP^.p[0].t < 0 OR  xArP^.p[xM^.pod.po.p].t < 0 THEN                                                              // ak sa nico zmrvi dostaneme sa do default
      xArP^       		:= ePoi.cx;
      xM^.pod.po.idx  	:= true;             // preindexovanie
      _Nh_Poi_SLD       := false;            // okamzity refresh
      xM^.pod.po.zom    := false;
      xM^.pod.po.p := -1;
      xM^.pod.po.x := -1;
   END_IF;

   FOR  i := 0 TO xM^.pod.po.p DO
      xM^.pod.px.xy[0,i] := xO^.x + REAL_TO_INT(INT_TO_REAL(xArP^.p[i].t)     * xM^.pod.px.mx);                              // x-suradnica pointu
      IF i = 0 OR i = xM^.pod.po.p THEN                                                                                  // dolna ahorna hranica
         xM^.pod.px.xy[1,i] := xO^.y - xO^.h + 25;                                                                           // default y-suradnica konca vynasacej ciary ( zaciatok a koniec)
      ELSIF xM^.pod.po.x = i THEN                                                                                        // drzime tento point a pohybujem sa
         IF xM^.pod.po.zom = false AND xM^.pod.po.prs THEN                                                                   // drzime point, pohybujeme sa
            xM^.pod.px.xy[1,i] := xO^.y - xO^.h - 35;                                                                    // ciara, ktora drzime je najjvyssi
         ELSE
            xM^.pod.px.xy[1,i] := xO^.y - xO^.h ;                                                                        // vybraty point je vyssi
         END_IF;
      ELSIF rb THEN
         xM^.pod.px.xy[1,i] := xO^.y - xO^.h + 55;                                                                       // nizsia
      ELSE
         xM^.pod.px.xy[1,i] := xO^.y - xO^.h + 90;                                                                      // vyssia ciara
      END_IF;
      // vynasacia ciara
      GC_SetFgColor  (Color   := _NhColor[ xM^.pod.po.cf.vo.o[ xArP^.p[i].o ].c ], GrData := xCan);                            // farba boxu
      GC_SetBgColor  (Color   := _NhColor[ xM^.pod.po.cf.vo.o[ xArP^.p[i].o ].c ], GrData := xCan);                            // farba boxu
      GC_Line        (x1 := xM^.pod.px.xy[0,i], y1 := xO^.y-3, x2 := xM^.pod.px.xy[0,i], y2 := xM^.pod.px.xy[1,i],	GrData := xCan);

      // graf,obrazok,hodnota
      IF i < xM^.pod.po.p THEN

         rb                := NOT rb;
         xM^.pod.px.xy[0,i+1]  := xO^.x + REAL_TO_INT(INT_TO_REAL(xArP^.p[i+1].t)   * xM^.pod.px.mx);                             // x-suradnica nasledujuceho pointu
         ndel              := REAL_TO_INT( xM^.pod.po.cf.va[ xArP^.p[i].o ] * xM^.pod.px.my);                                   // vyska boxu s hodnoty
         ndel              := MAX(1,ndel);                                                                                // ak je vyska=0, da sa min
         nnew              := xM^.pod.px.xy[0,i+1] - xM^.pod.px.xy[0,i];                                                          // sirka boxu

         // graf
         IF nnew >= 1 THEN                      // ochrana ak by  nasledujuca hranica bol amensia ako aktualna - sposobilo to zhodenie systemu
            // frebny box
            GC_RoundBox    (x := xM^.pod.px.xy[0,i],y := xO^.y - ndel, width := nnew, height := ndel, fill := 1, r:=1, GrData := xCan);
            // obrazok
				IF xM^.pod.po.zom = false THEN
	            GC_MoveTo      (x:= xM^.pod.px.xy[0,i] + nnew /2 , y:= xO^.y + 40, GrData := xCan);                                 // presun do stredu boxu (stred x bude aj pre obrazok)
   	         GC_cImage      (filename := _NhFnObr(fn :=  xM^.pod.po.cf.vo.o[ xArP^.p[i].o ].o ), width := 48, height :=  48,	GrData := xCan); // obrazok po casovou osou
      		END_IF;
            // hodnota predvolby
            IF xM^.pod.po.cf.fm <> '' THEN
               GC_MoveTo      (x:= xM^.pod.px.xy[0,i] + nnew /2 , y:= xO^.y + 85, GrData := xCan);                              // presun do stredu boxu (stred x bude aj pre obrazok)
               yTx1  := REAL_TO_STRINGF(xM^.pod.po.cf.va[ xArP^.p[i].o ] , xM^.pod.po.cf.fm);
               GC_WriteText   (text    := yTx1             , GrData := xCan);           //
            END_IF;
         ELSE
            xArP^.p[i].t := -1;               				// vymaze sa takyto bod
            xM^.pod.po.idx     := true;             		// preindexovanie
            _Nh_Poi_SLD       := false;            		// okamzity refresh
            xM^.pod.po.zom     := false;
            xM^.pod.po.x       := -1;
         END_IF;
      END_IF;

   END_FOR;


   // casove navestia
   GC_SetFillStyle(style   := GFILL_STYLE_BGCOLOR, GrData := xCan);					
   GC_SetTextstyle(style   :=  _Nh_Sty[2] + GTEXT_STYLE_FILLBG , GrData := xCan);                                       // vymaze sa podklad
   GC_SetBgColor  (Color   := _NhColor[0], GrData := xCan);                                                             // podklad pod textom
   FOR  i := 0 TO xM^.pod.po.p DO
      GC_MoveTo   (x := xM^.pod.px.xy[0,i], y := xM^.pod.px.xy[1,i], GrData := xCan);                                   // suradnica na konci vynasacej ciary
      GC_SetFgColor  (Color   := _NhColor[ xM^.pod.po.cf.vo.o[ xArP^.p[i].o ].c ], GrData := xCan);                     // farba boxu
      GC_SetFillStyle(style   := GFILL_STYLE_BGCOLOR, GrData := xCan);					

//      GC_SetFillStyle(style   := GFILL_STYLE_FRAME, GrData := xCan);					

      IF i = xM^.pod.po.x THEN                                                                                              // vykreslit LUPU
         ii := xM^.pod.po.cf.vo.o[ xArP^.p[i].o ].c;
         GC_SetBgColor  (Color   := _NhColor[ii], GrData := xCan);                            // farba boxu
         CASE ii OF
           4 : ii := 1;                                                                      // biely podklad, text cierny
           8 : ii := 1;                                                                      // zeleny podklad: farba textu cierna
           5 : ii := 1;                                                                      // zlty podklad: farba textu cierna
         ELSE  ii := 4;                                                                      // farba textu biela
         END_CASE;
         GC_SetFgColor  (Color   := _NhColor[ii], GrData := xCan);                            // farba boxu
         GC_cRoundBox   (width := 90, height := 40, fill := 1, r:= 15, GrData := xCan);
      ELSE
         GC_SetFgColor  (Color   := _NhColor[ xM^.pod.po.cf.vo.o[ xArP^.p[i].o ].c ], GrData := xCan);                            // farba boxu
         GC_SetBgColor  (Color   := _NhColor[ 0], GrData := xCan);                            // farba boxu

      END_IF;
      GC_MoveTo   (x := xM^.pod.px.xy[0,i], y := xM^.pod.px.xy[1,i], GrData := xCan);                                           // suradnica na konci vynasacej ciary
		IF xM^.pod.po.cf.typ = 3 THEN																						//
			CASE xArP^.p[i].t OF
           0 :	yTx1  := '-3.0°';   	
         30 :	yTx1  := '0.0°';   	
         50 :	yTx1  := '+2.0°';   	
         ELSE	IF xArP^.p[i].t < 30 THEN
         			yTx1  := INT_TO_STRINGF( (xArP^.p[i].t-30),'%3.1d°');   	
         		ELSE
         			yTx1  := INT_TO_STRINGF( (xArP^.p[i].t-30),'+%3.1d°');   	
         		END_IF;
         END_CASE;
		ELSE
	      yTx1  := TIME_TO_STRINGF(UDINT_TO_TIME( INT_TO_UDINT(xArP^.p[i].t) * 1000 * 60),'%Th:mm');
		END_IF;
      GC_WriteText   (text := yTx1, GrData := xCan);           //
   END_FOR;
END_FUNCTION

FUNCTION _Nh_Poi_Day  {HIDDEN}   : INT    // vrati cislo vety [25] = POI pre aktualny DayMode
   VAR_INPUT
//	   edit		: BOOL;
      Day      : USINT;                // typovy den ktory chceme ziskat.
      xPd      : PTR_TO NH_POI_DAY;
   END_VAR
	IF day < 1 OR day > 11 THEN
		xPd^.Day := SYSTEM_S.COUNTER_DAYS_OF_WEEK;
		day		:= xPd^.Day;
	END_IF;	
	_Nh_Poi_Day   	:= xPd^.poi[Day];

END_FUNCTION


FUNCTION _NhNewVaz   {HIDDEN}   : INT           // najst alebo vymazat vetu/vety, pridat 1 vetu vratane parametrov
   VAR_INPUT
      ok    : BOOL;
      par   : BOOL;
      vaz   : USINT;
      nv    : INT;
   END_VAR
   VAR_TEMP
      NewRec   : BOOL;
      p        : USINT;
   END_VAR
   yVaz.ok.ok  := true;
   yVaz.in.p   := 0;
   yVaz.ou.p   := 0;

//	NewRec      := true;


   IF ok = false THEN                                          // nwexistuje DEL-veta, bude sa pridavat
      aVaz[ vaz ].new   := 1;
      aVaz[ vaz ].nOk   := 1;                                  // na koci pridanu vetu oznaci ako platnu
      NewRec            := true;
      nv                := aVaz[ vaz ].rec + 1;                // cislo buducej novej vety
   END_IF;
   IF par THEN

      p  := aCfg[yVaz.in.c].par;                               // in-parameter

(* // dev-list zmena 9.5.23
      IF p > 0 AND yVaz.in.p = 0 THEN
         yVaz.in.p  := _NhFindDel(wh := 1, cx := p, new := true, nOk := true);
         IF yVaz.in.p = 0 THEN                                 // _NhFindDel nenasla DEL-veta, namapoval xNh a pridal .new,
            yVaz.in.p := xNh^.rec + xNh^.new;    // cislo buducej novej vety
            NewRec    := true;
         END_IF;
      END_IF;
*)
      p  := aCfg[yVaz.IN.c].par;                               // IN-parameter
      IF p > 0 AND yVaz.IN.p = 0 THEN
         IF aPar[p].grp THEN
				yVaz.IN.p  := xF^.cf.p;										///// pre SCN sa preberie par z hlavicky SCN 18.5.2025
			ELSE
            yVaz.IN.p  := _NhFindDel(wh := 1, cx := p, new := true, nOk := true);
            IF yVaz.IN.p = 0 THEN
               yVaz.IN.p := xNh^.rec + xNh^.new;

               NewRec    := true;
            END_IF;
         END_IF;
      END_IF;
      p  := aCfg[yVaz.ou.c].par;                               // ou-parameter
      IF p > 0 AND yVaz.ou.p = 0 THEN
         IF true THEN //aPar[p].grp = false OR                 ja DEV so grp sa moze spustat rozne :PIR/TGL/WSB ...a musi mat parameter pre kazdu vazbu
            yVaz.ou.p  := _NhFindDel(wh := 1, cx := p, new := true, nOk := true);
            IF yVaz.ou.p = 0 THEN
               yVaz.ou.p := xNh^.rec + xNh^.new;
               NewRec    := true;

            END_IF;
         END_IF;
      END_IF;
   END_IF;



(*
WHILE true  DO

END_WHILE;
*)




   IF NewRec THEN
      _Nh_Go_DbxToMem(ram := true, dbx := false );                   // popridava nove vety a oznaci ich za platne
   END_IF;

   IF _NhxVaz(cv := vaz, nd := nv, ok:=true) THEN                               // znova namapuje, lebo pridanim sa vstko rozhasilo
   	xVaz^       := yVaz;                                        // vlozi pripravene data s parametrami
   	_NhNewVaz   := nv;
//ok2 := 1;

	ELSE
   	_NhNewVaz   := 0;	
//ok2 := 0;
	END_IF;
(*	
	yTx2     := CONCAT(', ok: ',BOOL_TO_STRINGF(ok,'%b{Y^n}'),
							 ', NewRec: ',BOOL_TO_STRINGF(NewRec,'%b{Y^n}'),
							 ', vaz: ',	USINT_TO_STRINGF(vaz,'%3u'),
							 ', nv: ',		INT_TO_STRINGF(nv,'%3u'),
							 ', ok2: ',BOOL_TO_STRINGF(ok2,'%b{Y^n}')
							);

rb    := _Nh1RowTxt(logRst:=1, adTime:=3);
*)	
	
	_NhSysUpd(dbx:=2,file:=2);
END_FUNCTION




FUNCTION _NhDelVaz   {HIDDEN}   : BOOL           // najst alebo vymazat vetu/vety, pridat 1 vetu vratane parametrov
	// musi byt namapovane xVaz
	IF xVaz^.in.p > 0 THEN
		IF aPar[ aCfg[yVaz.in.c].par ].grp THEN				// ak je SCN v in vazbe nevymaze sa parameter, lebo patri k hlavicke
			;
		ELSE
	   	_NhFindDel(wh := 1, cx := aCfg[xVaz^.in.c].par, nx := xVaz^.in.p, ok := false );
		END_IF;
	END_IF;
 	IF xVaz^.ou.p > 0 THEN                 // ak je parameter, vymaze sa. u Dev, ktore maju parameter ale nie vo vazbe, bude p=0
    	_NhFindDel(wh := 1, cx := aCfg[xVaz^.ou.c].par, nx := xVaz^.ou.p, ok := false );
  	END_IF;
   xVaz^          := eVaz;                      // tu staci toto pre zneplatnenie a vycistenie vety
	aSys.RefCycNew	:= true;

	_NhSysUpd(dbx:=2,file:=2);

END_FUNCTION


FUNCTION _Nh_Vaz1_LOG  {HIDDEN}   : BOOL           // najst alebo vymazat vetu/vety, pridat 1 vetu vratane parametrov
	VAR_INPUT
//		adrexp	: BOOL;		
//		del		: BOOL;
		cv			: USINT;
		nv			: INT;
	END_VAR;
	yVaz := xVaz^;
	_Nh_Vaz1_LOG := true;
   yTx2  := CONCAT(			INT_TO_STRINGF (nv,'%4d')
							,';   ',BOOL_TO_STRINGF (xVaz^.ok.ok,'%b{ ^D}')								
							,';',USINT_TO_STRINGF(xVaz^.in.c,'%3d')
							,';',INT_TO_STRINGF  (xVaz^.in.n,'%4d')
							,';',INT_TO_STRINGF  (xVaz^.in.p,'%4d'));							

   yTx2  := CONCAT(	yTx2
							,'    '
							,';',USINT_TO_STRINGF(xVaz^.ou.c,'%3d')
							,';',INT_TO_STRINGF  (xVaz^.ou.n,'%4d')
							,';',INT_TO_STRINGF  (xVaz^.in.p,'%4d'));							

							_Nh_Log_Path(wh:=4,fN:='EXP');

	yTx1          := CONCAT(yTx2,'_vaz_',USINT_TO_STRING(cv),'.txt' );
	IF nv = 1 THEN
      _Nh1Rowtxt(write:=true);
	ELSE
      _Nh1Rowtxt();
	END_IF;
END_FUNCTION


FUNCTION _Nh_Vaz_LOG  {HIDDEN}   : BOOL           // najst alebo vymazat vetu/vety, pridat 1 vetu vratane parametrov
	VAR_INPUT
		adrexp	: BOOL;		
//		del		: BOOL;
		cv			: USINT;
		nv			: INT;
	END_VAR;
	yVaz := xVaz^;
	yTx3  := '   ;';
	IF cv = 3 AND xVaz^.ok.ok THEN					
		IF xVaz^.in.c <> 4 THEN                   // SCN - mozu spustat len SCN
			yTx3  := ' -D;';
			_NhDelVaz();
		END_IF;
	END_IF;
	_Nh_Vaz_LOG := true;
   yTx3  := CONCAT(  yTx3
							,USINT_TO_STRINGF(cv,'%2d')
							,';',INT_TO_STRINGF(nv,'%4d')
							,';',BOOL_TO_STRINGF(xVaz^.ok.ok,'%b{ ^D}')								
							,';',USINT_TO_STRINGF(xVaz^.in.c,'%3d')
							,';',INT_TO_STRINGF(xVaz^.in.n,'%4d'));


	yTx2  := '';
	IF xVaz^.ok.ok = false THEN
		;	
	ELSIF _NhxPt(c:=xVaz^.in.c,n:=xVaz^.in.n,err:=0 ,x:=-22) THEN
		yTx2  := xPt^.cf.Name;
	END_IF;
	aBlank(txt := ADR(yTx2), n := 20);
   yTx3  := CONCAT(	yTx3,
							';',yTx2
							,';',INT_TO_STRINGF(xVaz^.in.p,'%4d'));							


	yTx2	:= ' ';
	IF xVaz^.ok.ok = false THEN
		;
	ELSIF xVaz^.in.c = 0 THEN
		;
	ELSIF aCfg[xVaz^.in.c].par = 0 THEN
		;
	ELSIF _NhxPar(cp := aCfg[xVaz^.in.c].par, np := xVaz^.in.p ,err:=0 ,x:=-23) = false THEN
		yTx2  := '-';
	END_IF;
   yTx3  := CONCAT(	yTx3
							,';',yTx2
							,';',USINT_TO_STRINGF(xVaz^.ou.c,'%3d')
							,';',INT_TO_STRINGF(xVaz^.ou.n,'%4d'));

	yTx2  := '';
	IF xVaz^.ok.ok = false THEN
		;	
	ELSIF _NhxPt(c:=xVaz^.ou.c,n:=xVaz^.ou.n,err:=0 ,x:=-24) THEN
		If xVaz^.ou.c = 44 THEN

//			yTx1  := LEFT(xPt^.cf.Name,14);
//			xPt^.cf.Name := yTx4;
			yTx2  := xPt^.cf.Name;
//			xPt^.cf.Name := yTx4;
		ELSe	
			yTx2  := xPt^.cf.Name;
		END_IF;
	ELSE
		yTx2  := '----Err-24 !!!';
	END_IF;
	aBlank(txt := ADR(yTx2), n := 20);
   yTx3  := CONCAT(	yTx3,
							';',yTx2
							,';',INT_TO_STRINGF(xVaz^.ou.p,'%4d'));							

	yTx2	:= ' ';
	IF xVaz^.ok.ok = false THEN
		;	
	ELSIF xVaz^.ou.c = 0 THEN
		;
	ELSIF xVaz^.ou.c > _Nh_CFG THEN
		;
	ELSIF aCfg[xVaz^.ou.c].par = 0 THEN
		;
	ELSIF _NhxPar(cp := aCfg[xVaz^.ou.c].par, np := xVaz^.ou.p ,err:=0 ,x:=-25) = false THEN
		yTx2  := '-';
	END_IF;
   yTx3  := CONCAT(	yTx3
							,';',yTx2);
	If adrexp THEN
							_Nh_Log_Path(wh:=4,fN:='EXP');
 		yTx1  := CONCAT(yTx2,'_vaz_',USINT_TO_STRING(cv),'.txt' );
		yTx2	:= yTx3;
		IF nv = 1 THEN          	
	      _Nh1Rowtxt(write:=true);
		ELSE
	      _Nh1Rowtxt();
		END_IF;
	ELSE
		_Nh1RowTxt(logRst:=1);
	END_IF;
END_FUNCTION

FUNCTION _Nh_Vaz_LOG_CV  {HIDDEN}   : BOOL           // najst alebo vymazat vetu/vety, pridat 1 vetu vratane parametrov
	_Nh_Vaz_LOG_CV	:= false;
	i	:= 0;
	WHILE nd <= aVaz[cf].rec DO
		IF cf = 1 THEN
//			_Nh_Vaz1_LOG(cv:=cf,nv:=nd,adrexp:=true);
			_Nh_Vaz1_LOG(cv:=cf,nv:=nd);
		ELSE
			_Nh_Vaz_LOG(cv:=cf,nv:=nd,adrexp:=true);
		END_IF;
		xVaz 	:= xVaz + SIZEOF(NH_VAZ);
		i		:= i  + 1;
		nd		:= nd + 1;
		IF i > 3 THEN												// max 4 vety na jeden cyklus
			Exit;				
		END_IF;
	END_WHILE;
	IF nd >= aVaz[cf].rec THEN
		_Nh_Vaz_LOG_CV	:= true;
	END_IF;
END_FUNCTION	




FUNCTION _NhNextIx {HIDDEN} : BOOL         // vytvori index pre aktualny browser
   xIxB^.idx   := xIxB^.idx + 1;                        // pocet vsetkych viet v browse
   xIdx        := xIdx + SIZEOF(NH_IDX);                                 // prestavi pointer na pripadnu dalsiu vetu
END_FUNCTION

FUNCTION _NhCrIx {HIDDEN} : BOOL                // prida vetu do indexu browsu
   VAR_INPUT
      ok    : BOOL;
//      vz    : int;
   END_VAR
   _NhCrIx := 0;
   IF ok THEN
	   xIdx^.ix[aWeb.nbr]   := yIdxR;      //cf;
      _NhNextIx();
   END_IF;
END_FUNCTION



//   _NhfVaz(vaz := 1, row := false, whf := 2, del := true, all := true);          // zoznam FAV, k HET ou

FUNCTION _NhfVaz   : BOOL      // najst alebo vymazat vetu/vety, pridat 1 vetu vratane parametrov
   VAR_INPUT
//		lst	: BOOL;	
      par   : BOOL := true;   // veta ma parametre (vynimka su FAV, vazby k ZON,HET ... a ine vazby)
      del   : BOOL;           // zmazat 1 vetu
      all   : BOOL;           // zmazat vsetky vety filtra
      row   : BOOL := true;   // preberaju sa data z riadka, inak sa nevynuluje uVaz, ktore uz pride naplnene
      new   : BOOL;           // najst DEL vetu, alebo pridat
      idx   : BOOL;           // prida aj do indexu DEV pre browser
      whf   : USINT;          // 0=hlada IN+OU, 1=hlada len IN, 2=hlada len OU
      vaz   : USINT;          // v ktorych vazbach hladat ( aVaz[vaz])
   END_VAR
   VAR
      nv       : INT := 1;
//      cp       : USINT := 0;
//      NewRec   : BOOL;
      ok       : BOOL := 0;
      in       : BOOL := 0;
      oki      : BOOL := 0;
   END_VAR
   _NhfVaz     := false;
   nDel        := 0;
   IF row   THEN
      yVaz        := eVaz;                             // inicializuje sa cisty datovy zaznam
   END_IF;
//   rb := IncreaseMaxCycleTime( addTime := 500);   // plus 200 ms
   CASE vaz OF
      0:
         RETURN;
      1: // FAV,DASH,QUICK
         IF row = false THEN                          // pride napnlnene yVaz
            ;
         ELSE
            yVaz.in   := xA^.fav;
            yVaz.ou   := xR^.h.cf;

(*
            yVaz.in.c   := xA^.fav.cf;
            yVaz.in.n   := xA^.fav.nd;
            yVaz.ou.c   := xR^.h.cf.c;
            yVaz.ou.n   := xR^.h.cf.n;
*)
         END_IF;
      2: // IO
         IF row = false THEN                          // pride napnlnene yVaz
            ;
         ELSIF xR^.h.in THEN
            in      := true;
            yVaz.in := xR^.h.cf  ;
            yVaz.ou := xF^.cf  ;
            IF whf = 10 THEN
               whf := 5;                           // in hlada aj s parametrom, ou bez parametra
            END_IF;
         ELSE
            in      := false;
            yVaz.in := xF^.cf  ;
            yVaz.ou := xR^.h.cf  ;
            IF whf = 10 THEN
               whf := 6;                           // ou hlada aj s parametrom, in bez parametra
            END_IF;
         END_IF;

      3: // SCN,BLK
         IF row = false THEN                          // pride napnlnene yVaz
            ;
         ELSIF xR^.h.in THEN
            in      := true;
            yVaz.in := xR^.h.cf  ;
            yVaz.ou := xF^.cf  ;
            IF whf = 10 THEN
               whf := 5;                           // in hlada aj s parametrom, ou bez parametra
            END_IF;
         ELSE
            in      := false;
            yVaz.in := xF^.cf  ;
            yVaz.ou := xR^.h.cf  ;
            IF whf = 10 THEN
               whf := 6;                           // ou hlada aj s parametrom, in bez parametra
            END_IF;
         END_IF;

      4: // SCN + SCN-LIST
            xR^.h.in := true;                     // riadok DEV je out
            yVaz.in  := xF^.cf  ;
            yVaz.ou  := xR^.h.cf  ;
            whf 		:= 0;

(*
      5: // ACT + ACT-LIST

         IF xR^.h.cf.c = 5 THEN                      // browser ACT - v riadku je ACT, hlavicka nie je zaujimava
            xR^.h.in := true;                      // SCN je in
            yVaz.in  := xR^.h.cf  ;
         ELSE                                      // prirdadenie DEV k SCN : V hlavicke je SCN a v riadku je DEV
            xR^.h.in := false;                     // riadok DEV je out
            yVaz.in  := xF^.cf  ;
            yVaz.ou  := xR^.h.cf  ;
            whf := 0;
         END_IF;
*)
(*
      6: // TER,TEH,TEK,LUX  -> ROM,ZON,HET

      	xR^.h.in := true;                      // SCN je in
			yVaz.in  := xF^.cf  ;
         yVaz.ou  := xR^.h.cf  ;


         whf 		:= 0;
			vaz		:= 4;
         IF row = false THEN                          // pride napnlnene yVaz
            ;
         ELSIF xR^.h.in THEN
            in      := true;
            yVaz.in := xR^.h.cf  ;
            yVaz.ou := xF^.cf  ;
         ELSE
            in      := false;
            yVaz.in := xF^.cf  ;
            yVaz.ou := xR^.h.cf  ;
        	END_IF;
*)

      7: // hlada sa to co je yVaz.in v out alebo in. yVaz musi byt naplenene!!!, parameter row:=false!!!
		;
   END_CASE;

//   v1:=v1+1;
//   v2:=aVaz[ vaz ].rec;
//   v3:=0;


   WHILE nv <= aVaz[ vaz ].rec  DO
		IF _NhxVaz(cv := vaz, nd := nv, ok:=true) THEN     // naplni xVaz a vrati TRUE aj ked sa nasla DEL - veta
			ok := new AND xVaz^.ok.Ok = false;					// ked sa priadava a nsla sa 1.DEL veta
		ELSE
			ok := false;												// nenasla sa ziadna veta	

		END_IF;
      IF ok	THEN           										// ak sa pridava a nasla sa prva DEL veta
			;
      ELSIF whf = 0 THEN ok :=                           // presna zhoda IN aj OUT bez parametrov (default)
                        xVaz^.in.c = yVaz.in.c AND
                        xVaz^.in.n = yVaz.in.n AND
                        xVaz^.ou.c = yVaz.ou.c AND
                        xVaz^.ou.n = yVaz.ou.n;
      ELSIF whf = 1 THEN ok :=
                        xVaz^.in.c = yVaz.in.c AND          // len IN
                        xVaz^.in.n = yVaz.in.n;
      ELSIF whf = 2 THEN ok :=
                        xVaz^.ou.c = yVaz.ou.c AND          // len OUT
                        xVaz^.ou.n = yVaz.ou.n;
      ELSIF whf = 3 THEN
         IF xVaz^.in.c = yVaz.in.c  AND xVaz^.in.n = yVaz.in.n THEN
            ok := true;
            in := true;
         ELSE
            in := false;
            ok := xVaz^.ou.c = yVaz.in.c AND xVaz^.ou.n = yVaz.in.n;
         END_IF;
(*
      ok :=                           // to co je v IN  sa testuje aj v in aj v out
                        (xVaz^.in.c = yVaz.in.c  AND
                         xVaz^.in.n = yVaz.in.n) OR
                        (xVaz^.ou.c = yVaz.in.c  AND
                         xVaz^.ou.n = yVaz.in.n);
*)
      ELSIF whf = 4 THEN ok :=                           // in=in out=out AJ S PARAMETRAMI !!!
                         xVaz^.in   = yVaz.in  AND
                         xVaz^.ou   = yVaz.ou ;

      ELSIF whf = 5 THEN ok :=                           // IN aj s parametrom, OU bez parametra
                         xVaz^.in   = yVaz.in   AND
                         xVaz^.ou.c = yVaz.ou.c AND
                         xVaz^.ou.n = yVaz.ou.n;

      ELSIF whf = 6 THEN ok :=                           // OU aj s parametrom, IN bez parametra
                         xVaz^.ou   = yVaz.ou   AND
                         xVaz^.in.c = yVaz.in.c AND
                         xVaz^.in.n = yVaz.in.n;

      ELSIF whf = 7 THEN ok :=                           // OU aj s parametrom, IN bez parametra
                         (xVaz^.in.c = yVaz.in.c AND
                          xVaz^.in.n = yVaz.in.n      ) OR
                         (xVaz^.ou.c = yVaz.in.c AND
                          xVaz^.ou.n = yVaz.in.n      );


      END_IF;

      IF ok THEN                                   // nasla sa veta, pri new moze byt a DEL
         nDel := nv;                               // cislo vety
         IF del THEN                               // tuto vetu treba vymazat
				_NhDelVaz();
            IF all = false THEN
               EXIT;                               // vymazava sa len jedna veta, lebo vo vazbach mozu byt aj duplicity (WSB-DEV)
            END_IF;
         ELSIF new THEN
            EXIT;                                  // ok=true : najdena DEL veta,
         ELSIF idx THEN
            IF in THEN                             // ak sa hlavicka nasla v in tak riadou bude ou
               xIdx^.ix[aWeb.nbr].dev   := xVaz^.in;
            ELSE
               xIdx^.ix[aWeb.nbr].dev   := xVaz^.ou;
            END_IF;
            _NhNextIx();
            oki   := true;
         ELSE
            EXIT;
         END_IF;
      END_IF;
      nv := nv + 1;
   END_WHILE;
   IF new THEN                                                 // pridat vetu aj parametre
      _NhNewVaz(ok := ok, par := par, vaz := vaz, nv := nv);
		aSys.RefCycNew	:= true;
   END_IF;
   _NhfVaz := ok OR oki;

END_FUNCTION

FUNCTION _NhPgNav  {HIDDEN}  : BOOL  // vykresli PG-navigator (gulicky na spodnej ciare)
   _NhPgNav := true;
   IF xIxB^.n > 0 THEN
      xO    := ADR(xB^.r[0].o.ob[0]);
      xO^.x := 0;
      xO^.y := 0;
      x     := xIxB^.x1;
      xIxB^.pg := xIxB^.ix1 / xIxB^.row.rws + 1;
      IF xIxB^.ix2 = xIxB^.idx THEN
         xIxB^.pg := xIxB^.n;
      ELSIF xIxB^.ix1 > 1 AND xIxB^.ix1 <= xIxB^.row.rws THEN
         xIxB^.pg := 2;
      END_IF;
      FOR i := 1 TO xIxB^.n  DO
         ii := 2;
         IF i = xIxB^.pg THEN
            ii := 4;
         END_IF;
         rb := _NhVal2(grd := 2, wl := 8, FgC := 0, BgC := ii, crc := true, y := ky2, x := x , wC := 25, fil := true );
         x  := x + USINT_TO_INT(xIxB^.w);
      END_FOR;
   END_IF;
END_FUNCTION



FUNCTION _NhShwBtn  {HIDDEN}   : BOOL                    // vykresli button na objektoch WSB,TGL
   VAR_INPUT
      btn          : USINT;
   END_VAR
   VAR_TEMP
      ok          : BOOL := true;
      a,b         : INT;
   END_VAR
   _NhShwBtn := true;

   CASE xO^.fn OF
      102:  a  := xO^.x;                              // WSB-2
            b  := xO^.w/4;
            CASE btn OF
               1: b:=xO^.y-b;
               2: b:=xO^.y+b;
            END_CASE;
      103:  a  := xO^.w/6;                            // WSB-4
            b  := xO^.w/4;
            CASE btn OF
               1: a := xO^.x-a; b:=xO^.y-b;
               2: a := xO^.x-a; b:=xO^.y+b;
               3: a := xO^.x+a; b:=xO^.y-b;
               4: a := xO^.x+a; b:=xO^.y+b;
            END_CASE;
      104:  a  := xO^.w/8;                            // WSB-8
            b  := xO^.w/4;
            CASE btn OF
               1: a := xO^.x-2*a; b:=xO^.y-b;
               2: a := xO^.x-2*a; b:=xO^.y+b;
               3: a := xO^.x-a; b:=xO^.y-b;
               4: a := xO^.x-a; b:=xO^.y+b;
               5: a := xO^.x+a; b:=xO^.y-b;
               6: a := xO^.x+a; b:=xO^.y+b;
               7: a := xO^.x+2*a; b:=xO^.y-b;
               8: a := xO^.x+2*a; b:=xO^.y+b;

            END_CASE;

      310:  a  := xO^.w/9;                            // TGL-6
            b  := xO^.w/4;
            CASE btn OF
               1: a := xO^.x-2*a; b:=xO^.y-b;
               2: a := xO^.x-2*a; b:=xO^.y+b;
               3: a := xO^.x+a/3; b:=xO^.y-b;
               4: a := xO^.x+a/3; b:=xO^.y+b;
               5: a := xO^.x+2*a; b:=xO^.y-b;
               6: a := xO^.x+2*a; b:=xO^.y+b;
            END_CASE;

      106:  a  := xO^.x;                              // 1- tlacitko
            b  := xO^.y-xO^.w/4;
      107:  a  := xO^.w/6;                            // 2-tlacitko
            b  := xO^.w/4;
            CASE btn OF
               1: a := xO^.x-a; b:=xO^.y-b;
               2: a := xO^.x+a; b:=xO^.y-b;
            END_CASE;

      ELSE ok := false;
      END_CASE;
      IF ok THEN
         GC_SetFillStyle (style := GFILL_STYLE_BGCOLOR,              GrData := xCan);					
         GC_SetBgColor   (Color 	:= _NhColor[xO^.BgC],               GrData := xCan);
         GC_Circle       (fill := 1, x := a , y := b, r := xO^.w/7,  GrData := xCan);
      END_IF;
END_FUNCTION

FUNCTION _NhKnvVal {HIDDEN}  : BOOL                    // vrati hodnotu bodu slidera
   VAR_INPUT
      typ      : USINT;
   END_VAR
   _NhKnvVal   := true;
      CASE typ OF                                 // nacitanie hodnoty
         0: vr := xPtr^;
         1: xPtU  := xPtr; vr :=  USINT_TO_REAL(xPtU^ );
         2: xPtS  := xPtr; vr :=  SINT_TO_REAL (xPtS^ );
         3: xPtUi := xPtr; vr :=  UINT_TO_REAL (xPtUi^);
         4: xPtB  := xPtr; vr :=  BOOL_TO_REAL (xPtB^ );
         5: xPti  := xPtr; vr :=  INT_TO_REAL  (xPti^);
      END_CASE;
END_FUNCTION

FUNCTION _NhKnvSet  {HIDDEN} : BOOL    // prekonvertuje typ a zapise do premennej. Vrati TRUE ak nova hodnota <> stara hodnota
   VAR_INPUT
      set0     : BOOL;
      typ      : USINT;
   END_VAR
   IF set0 THEN
      vr := 0.0;
   END_IF;
      CASE typ OF                                   // zapis hodnoty do premennej
         0: xPtr^ := vr;
         1: xPtU  := xPtr; _NhKnvSet := xPtU^ <> REAL_TO_USINT(vr); xPtU^  := REAL_TO_USINT(vr);     // USINT
         2: xPtS  := xPtr; _NhKnvSet := xPtS^ <> REAL_TO_SINT (vr); xPtS^  := REAL_TO_SINT (vr);     // SINT
         3: xPtUi := xPtr; _NhKnvSet := xPtUi^<> REAL_TO_UINT (vr); xPtUi^ := REAL_TO_UINT (vr);     // UINT
         4: xPtB  := xPtr; _NhKnvSet := xPtB^ <> REAL_TO_BOOL (vr); xPtB^  := REAL_TO_BOOL (vr);     // BOOL
         5: xPti  := xPtr; _NhKnvSet := xPti^ <> REAL_TO_INT  (vr); xPti^  := REAL_TO_INT  (vr);     // INT
      ELSE  _NhKnvSet   := false;
      END_CASE;
END_FUNCTION

FUNCTION _NhxPtrCfN {HIDDEN} : BOOL    // namapuje premennu v xO^.cf.n do PtR a podla SET vlozi do premennej VAL
   VAR_INPUT
      set   : BOOL;                    // nastavi hodnotu VAL do premennej podla typu: typ
      typ   : USINT;                   //0=REAL,1=USINT,2=SINT,3=UINT,4=BOOL,5=INT
      val   : REAL;                    // hodnota do premennej
   END_VAR
   _NhxPtrCfN := true;
   xPtD  := ADR(xO^.cf.n);
   xPtR  := UDINT_TO_PTR(xPtD^);                          // adresa sa prevedie vzdy do pointra real, typ sa prevedie v _NhKnv...
   IF set THEN
      vr    := val;
      _NhKnvSet(typ:=typ);
   END_IF;
END_FUNCTION

FUNCTION _NhSldVal {HIDDEN}  : BOOL                    // vrati hodnotu bodu slidera
   VAR_INPUT
      va       : BOOL;        // xS^.va
      set      : BOOL;        // ulozit
   END_VAR
   _NhSldVal := false;
   IF va = false  AND xS^.vb > 0 THEN  xPtR := UDINT_TO_PTR(xS^.vb);
   ELSIF va       AND xS^.va > 0 THEN  xPtR := UDINT_TO_PTR(xS^.va);
   ELSE                          RETURN;
   END_IF;
   IF set   THEN
      vr := MAX(xS^.v1,MIN(vr,xS^.v2));               // korekcia na spodnu, alebo vrchnu hranicu
      _NhKnvSet(typ := xS^.t);
   ELSE
      _NhKnvVal(typ := xS^.t);
      vr  := MAX(xS^.v1,MIN(vr,xS^.v2));           // korekcia na spodnu, alebo vrchnu hranicu
   END_IF;
   _NhSldVal := vr > 0.0;
END_FUNCTION

FUNCTION _NhFrmBrwShwDSH  {HIDDEN} : BOOL                    // vykresli objekty riadka alebo vsetkych riadkov
   GC_SetFgColor     (Color 	:= _NhColor[xO^.FgC], GrData := xCan);
   GC_SetBgColor     (Color 	:= _NhColor[xO^.BgC], GrData := xCan);
   GC_SetLineWidth   (Width   := INT_TO_USINT(xO^.cf.n), GrData := xCan);
   GC_SetGradientStyle  (style := GFILL_STYLE_GRADIENT, color1 := _NhColor[xO^.FgC], color2 := _NhColor[xO^.BgC],  GrData := xCan);					
   GC_SetFillStyle      (style := GGRADIENT_STYLE_BAR1_3, GrData := xCan);					
   GC_MoveTo            (x:= xO^.x, y:= xO^.y  , GrData := xCan);
   GC_CRoundBox         (fill  := rb, r := xO^.fn, width := xO^.w ,height := xO^.h, GrData := xCan);              // horny modry podklad
END_FUNCTION

FUNCTION _NheBrw {HIDDEN} : BOOL         // PRQZDNY BROWSER, alebo jedne riadok
   VAR_INPUT
      wht      : USINT;
   END_VAR
   VAR_TEMP
      i        : USINT;
      _eRn     : NH_RUN_VAL2_D := (ok:=1,wh:=18);
   END_VAR
   CASE wht OF
     1:  // cele session
         memset(val := 0,length := sizeof(NH_M),  dest:=VOID( aWeb.M[ aWeb.nbr ]  ));
     2:  // cely LVL s BRW aj IXD
         memset(val := 0,length := sizeof(NH_IXB)*2+sizeof(NH_BRW),  dest:=VOID( aWeb.M[ aWeb.nbr ].ixb ) );
     3:  // len Nove LVL   (bez BRW aj be IXD)
         i := xM^.lvl;
         memset(val := 0,  length :=  sizeof(NH_LVL), dest := VOID( aWeb.M[ aWeb.nbr ].lvd[ i ]) );      // vymaze aktualne LVL
     4:  // IXB a vsetko dalej
         memset(val := 0,length := sizeof(NH_IXB) * 2 + sizeof(NH_BRW)  ,dest := VOID( aWeb.M[ aWeb.nbr ].ixb[0]) );
     5:  // len data BRW
         memset(val := 0,length := sizeof(NH_BRW) ,                  dest:=VOID( aWeb.M[ aWeb.nbr ].brw  ) ); // .r[0] ) );
     6:  // vsetko od lvl=0
         memset(val := 0,  length :=  sizeof(NH_LVL) * 4
                                    + sizeof(NH_IXB) * 2
                                    + sizeof(NH_BRW)
               ,dest := VOID( aWeb.M[ aWeb.nbr ].lvd) );
     7:  // len data BRW bez 1. vety - ta sa ponech - pre PROPERTIES
         memsetEx(val := 0,length := sizeof(NH_BRW)-sizeof(NH_ROW) ,  dest:=VOID( aWeb.M[ aWeb.nbr ].brw.r[1]  ) ); // .r[0] ) );

     8:  // Nove LVL + Ixb + r + s - ponecha data pre kopirovanie
         i := xM^.lvl;
         memset(val := 0,length :=sizeof(NH_LVL), dest := VOID( aWeb.M[ aWeb.nbr ].lvd[ i ]) );      		// vymaze aktualne LVL
         memset(val := 0,length := sizeof(NH_IXB)*2 + sizeof(NH_BRW),	dest := VOID( aWeb.M[ aWeb.nbr ].ixb[0]) );        // 2x ixb

     9:  // pod
         memset(val := 0,length :=sizeof(NH_POD), dest := VOID( aWeb.M[ aWeb.nbr ].pod) );      		// vymaze aktualne LVL
    10:  // RAM
         memsetEx(val := 0,length := _NH_RAM - aDbx.vRam - 1 ,         dest := VOID( mRam[aDbx.vRam ] ) );
    11:  memsetEx(val:=0,length := SIZEOF(NH_RUN_VAL2), dest := Void(yRn));
         yRn.v[0] := _eRn;
    12:  // pod.cp
         memset(val := 0,length :=sizeof(NH_SLD_CPY), dest := VOID( aWeb.M[ aWeb.nbr ].pod.cp) );      		// vymaze aktualne LVL

   ELSE
			;
   END_CASE;
   _NheBrw := true;
END_FUNCTION












FUNCTION _NhFreObj {HIDDEN} : SINT  //   najde volny objekt v namapovanom riadku
   _NhFreObj := 0;
   FOR j := 0 TO _RowObr DO
      xO := ADR(xR^.o.ob[j]);  // xR MISI BYT NAMAPOVANE PRED VOLANIM !!!
      IF xO^.wh = 0 THEN
         _NhFreObj := j;
         EXIT;
      END_IF;
   END_FOR;
END_FUNCTION


FUNCTION _NhSetObjBrw  {HIDDEN}  : BOOL           //   nastavi objekt
   VAR_INPUT
      wh     : USINT;                           // co je v objekte
      r      : SINT := -1;                      // cislo riadka
      ob     : SINT :=  2;                      // cislo objektu
      sl     : SINT  := -1;                     // cislo slidera priradeneho k objektu
      o1     : INT;                             // cislo obrazku OFF
      o2     : INT;                             // cislo obrazku ON
      vb     : PTR_TO USINT;                    // pointer pemennej pre bool
      txt    : INT;                             // cislo textu v _LNG
      w      : INT;
      h      : INT;                             //  vzdialenost medzi obrazkami
      x,y    : INT;
      FgC    : USINT;
      BgC    : USINT;
      c      : USINT;
      n      : INT;
      p      : INT;
      cm     : USINT;
      t      : USINT;
      v1     : REAL;                             // hodnota dolnej hranice slidera
      v2     : REAL := 100.0;                    // hodnota hornej hranice slidera
      ink    : REAL := 1.0;                     // prirastok slideru
      fmt    : STRING[15];                       // formatovanie premennej slidera
      fmo    : STRING[8];                       // pole xO^.fmt
      sld    : BOOL := true;
      tun    : BOOL;
      tep    : BOOL;                            // teplomer
      def    : BOOL := true;                    // objektu nadefinujedefault parametre
      zom    : BOOL;
      nTch   : BOOL;
      btn    : BOOL;
   END_VAR
   _NhSetObjBrw := true;
   IF sl = -1 THEN
      sl := ob;
   END_IF;
   IF r > - 1THEN
      xR    := ADR(xB^.r[ r ]);
   END_IF;
   xO       := ADR(xR^.o.ob[ ob ]);
   xS       := ADR(xB^.s[ sl  ]);
   xO^.nTch := nTch;
   xO^.wh   := wh;

   CASE wh OF
       0: xO^.wh   := 0;
         RETURN;

       1:   // LEN obrazok
//            xO^.wh      := wh;
            xO^.w       := w;
            xO^.h       := w;
            xO^.fn      := o1;
            xO^.x       := x;
            xO^.y       := y;
            xO^.cm      := cm;
            xO^.nTch    := nTch;

       3:   // obrazok s podkladom
            IF w > 0 THEN
               xO^.w       := w;
            END_IF;
            xO^.h       := h;
            IF x > 0 THEN
               xO^.x       := x;
            END_IF;
            IF y > 0 THEN
               xO^.y       := y;
            END_IF;
            xO^.fn      := o1;
            IF c > 0 THEN
               xO^.cf.c    := c;
               xO^.cf.n    := n;
            ELSE
               xO^.cf.c    := xR^.h.cf.c;
               xO^.cf.n    := xR^.h.cf.n;
            END_IF;
            xO^.cm      := cm;
            xO^.nTch    := nTch;

       4:   // obrazok s podkladom
//            xO^.wh      := wh;
            xO^.w       := w;
            xO^.h       := h;
            xO^.fn      := o1;
            xO^.cf.c    := c;
            xO^.cf.n    := n;
            xO^.cf.p    := p;
            xO^.Fgc     := FgC;
            xO^.BgC     := BgC;
            xO^.cm      := cm;
            xO^.x       := xO^.x + x;
            xO^.y       := xO^.y + y;


       6:   // vypis textu : Nazov dev, text zo suboru textov , cislo s pripadnym podfarbenim,
            xO^.x       := x;
            xO^.y       := y;
            xO^.cf.c    := c;
            xO^.cf.n    := n;             // cislo textu
            xO^.cf.p    := p;             // pocet znakov textu (len ked <>0)
            xO^.fn      := o1;            // formatovanie / centrovanie
            xO^.BgC     := BgC;           // podfarbenie textu
            IF FgC > 0 THEN               // farba textu
               xO^.FgC     := FgC;           // farba textu
            ELSE
               xO^.FgC     := 4;           // farba textu
            END_IF;
            IF h  > 0 THEN
               xO^.h       := h;          // vyska textu
            ELSE
               xO^.h       := 28;
            END_IF;
            xO^.cm      := cm;            // command


       7:   // zobrazovanie doplnujucich obrazkov nad hlavnou ikonou, alebo ionou statusu
            IF w > 0 THEN
               xO^.w       := w;
            END_IF;
            IF x > 0 THEN
               xO^.x       := x;
            ELSE
               xO^.x := xR^.o.ob[2].x-45;
            END_IF;
            IF y > 0 THEN
               xO^.y       := y;
            ELSE
               xO^.y := xR^.o.ob[2].y-10;
            END_IF;
            xO^.fn      := o1;
            xO^.cm      := cm;

       9:   // status DEV alebo vypis podla FN, ktory sa nadefinuje ON-LINE v NhBrwLib
            IF w > 0 THEN
               xO^.w       := w;
            END_IF;
            xO^.h       := h;
            xO^.x       := xO^.x + x;
            xO^.y       := xO^.y + y;
            xO^.fn      := o1;
            xO^.cm      := cm;
            xO^.nTch    := nTch;

      10:   // status DEV alebo vypis podla FN, ktory sa nadefinuje ON-LINE v NhBrwLib
            xO^.w       := w;
            xO^.x       := x;
            xO^.y       := y;
            xO^.fn      := o1;
            xO^.cm      := cm;
//            xO^.nTch    := nTch;
            xO^.FgC     := FgC;
            xO^.BgC     := BgC;

      12:   // obrazok s podkladom
            xO^.cf.c    := c;                            // nahradza wh
            xO^.w       := w;                            // velkost obrazka
            xO^.h       := h;                            // velkost kruhu
            xO^.fn      := o1;                           // cislo obr.
            xO^.Fgc     := FgC;                          // ohranicenie / kruznica
            xO^.BgC     := BgC;                          // vypln
            xO^.cm      := cm;
            xO^.x       := x;
            xO^.y       := y;
            xO^.btn     := btn;

      20: //  datum cas
         xO^.x       := x;
         xO^.y       := y;
         xO^.FgC     := FgC;
         xO^.BgC     := 0;
         xO^.cf.c    := 36;                            // vyska textu
         xO^.h       := 40;
         xO^.w       := 400;                           // cislo slidera
         xPtD        := ADR(xO^.cf.n) ;               // adresa premennej
         xPtD^       := PTR_TO_UDINT(vb) ;
         xO^.fn      := SINT_TO_INT(sl);                           // cislo slidera
         xO^.cm      := 251;                           // cislo slidera




      23: // prepinac medzi riadkami pod sebou

         xO^.wh      := 23;
         xO^.y       := y;
         IF x > 0 THEN
            xO^.x      := x;                        // vzdialenost medzi riadkami
         ELSE
            xO^.x      := 50;
         END_IF;
         IF o1 > 0 THEN
            xO^.fn      := o1;                        // vzdialenost medzi riadkami
         ELSE
            xO^.fn      := 60;
         END_IF;
         xO^.FgC     := FgC;
         xO^.BgC     := BgC;                          // farba textu
         IF h > 0 THEN
            xO^.h       := h;                         // vyska textu (obrazka)
         ELSE
            xO^.h       := 28;
         END_IF;
         IF w > 0 THEN
            xO^.w       := w;
         ELSE
            xO^.w       := x2-50-xO^.x;
         END_IF;
         xO^.prs     := false;
         IF cm > 0 THEN
            xO^.cm      := cm;                           // command
         ELSE
            xO^.cm      := 254;                           // command
         END_IF;
         xO^.cf.c    := c;                            // pocet riadkov
         xPtD        := ADR(xO^.cf.n) ;               // adresa premennej
         xPtD^       := PTR_TO_UDINT(vb) ;
         xPtU        := vb;      //UDINT_TO_PTR(xPtD^);
         xFmt23      := ADR(xO^.fmt);
         xFmt23^.wht := t;
         xFmt23^.txt := txt;
         xFmt23^.obj := xPtU^ ;                       // momentalna hodnota premennej (len pre inicializaciu)

     24: // prepinac obrazkov ulozeny vo fmt, alebo v externom odkaze

         xO^.wh   := 24;                        // kod objektu
         xO^.w    := w;                         // sirka/vyska obrazka
         IF x > 0 THEN
            xO^.x   := x;
         END_IF;
         IF y > 0 THEN
            xO^.y   := y;
         END_IF;
         IF cm > 0 THEN
            xO^.cm   := cm;
         ELSE
            xO^.cm   := 251;
         END_IF;
         xO^.fn   := USINT_TO_INT(t);           // typ premennej 'vb' 0=real,1=usint,2=sint,,4=bool
         xO^.FgC  := FgC;                       //kde su obrazky : 0= vo fmt '123123123'   // max 3
         xO^.BgC  := 0;                         // vybratlist z fmt
         xO^.cf.c := MAX(1,c);                  // pocet obrazkov
         xPtD     := ADR( xO^.cf.n) ;
         xPtD^    := PTR_TO_UDINT(vb) ;                     // adresa zoznamu DayMode
         xO^.fmt  := fmt;
         xO^.nTch := nTch;

      25: //  Typovy den, kedy ukoncit manual, ...
         xO^.x       := x;
         xO^.y       := y;
         xO^.FgC     := FgC;
         xO^.BgC     := 0;
         xO^.cf.c    := 36;                            // vyska textu
         xO^.h       := 40;
         xO^.w       := 400;
         xPtD        := ADR(xO^.cf.n) ;               // adresa premennej
         xPtD^       := PTR_TO_UDINT(vb) ;
         xO^.fn      := SINT_TO_INT(sl);              // cislo obj, kde je preddefinovany slider
         xO^.cm      := 251;

(*
         xS^.ink     := 1.0;
         xS^.t       := 2;
         xS^.v1      := 0.0;
         xS^.v2      := 60.0;
*)


       26:   // MENU = vypis textu s pripadnym podfarbenim
            xO^.x       := x;
            xO^.y       := y;
            xO^.w       := w;             // sirkadotykovej plochy
            xO^.h       := h;             // vyska textu
            xO^.cf.c    := c;             // 0=nepodfarbir,1=podfarbit
            xO^.fn      := txt;            // cislo textu
            xO^.FgC     := FgC;           // farba textu
            xO^.cm      := cm;            // command
            xPtD        := ADR(xO^.cf.n) ;               // adresa premennej
            xPtD^       := PTR_TO_UDINT(vb) ;


       27 :  // Check-box dvoch obrazkov - BOOL premenna so zobraznemim textu pred obrazkom
            xO^.x       := _Nh_O12(x=0,x2-60,x);            // x-obrazka
            xO^.w       := _Nh_O12(w=0,60,w);               // velkost obrazka
            xO^.y       := y;                               // pozicia obrazka, textu
            xO^.fn      := txt;                             // cislo textu
            xO^.FgC     := _Nh_U12(FgC=0, 4,Fgc);           // farba textu
            xO^.BgC     := _Nh_U12(BgC=0,26,BgC);           // vyska textu
            xO^.fmt     := fmt;                             // 2obrazky
            xO^.cm      := cm;                              // command
            xO^.cf.c    := c;                               // doplnujuci parameter k CM ( napr. cislo CMD, ktore sa posle do DEV)
            xPtD        := ADR(xO^.cf.n) ;                  // adresa premennej
            xPtD^       := PTR_TO_UDINT(vb) ;


    100: // slider do 200
         x     := 50;
         w     := x2 - 110;
         xO^.FgC  := 4;                                                                 // slider

         IF def THEN
            xO^.BgC  := 3;                                                                  // slider
         ELSE
            xO^.FgC  := FgC;                                                                 // slider
            xO^.BgC  := BgC;                                                                  // slider
         END_IF;
         xO^.wh   := 13;
         xO^.fn   := SINT_TO_INT(sl);
         IF cm > 0 THEN
            xO^.cm   := cm;                                                                    // slider
         ELSE
            xO^.cm   := 251;                                                                    // slider
         END_IF;
         IF h > 0 THEN
            xO^.h   := h;                                                                    // slider
         END_IF;

         xO^.x    := x;                                                                    // slider
         xO^.y    := y;                                                                    // slider
         xO^.w    := w;                                                                    // slider

         xS^.t    := t;
         xS^.v1   := v1;
         xS^.v2   := v2;
         xS^.fmt  := fmt;
         xO^.fmt  := fmo;
         xS^.ink  := ink;
         xS^.txt  := txt;
         xS^.vb   := PTR_TO_UDINT(vb);
         xS^.sld  := sld;
         xS^.tun  := tun;
         xS^.zom  := true;


(*
         xFmt23      := ADR(xO^.fmt);
         xFmt23^.wht := t;
         xFmt23^.txt := txt;
//         xFmt23^.obj := xPtU^ ;                       // momentalna hodnota premennej (len pre inicializaciu)
*)


    101: // check objekt/alebo viac objektov s textom
         IF def THEN
            x      := x2-65;                    // x-ova suradnica obrazka
            BgC    := 50;                       // x-ova suradnica textu
            w      := 50;                       // velkost obr
         END_IF;
         xO^.wh   := 20;
         xO^.fn   := txt;                       // cislo textu
         IF cm = 0 THEN
            xO^.cm   := 251;                                                                    // slider
         ELSE
            xO^.cm   := cm;                                                                    // slider
         END_IF;
         xO^.x    := x;                                                                    // slider
         xO^.y    := y;                                                                    // slider
         xO^.w    := w;                                                                    // slider
         xO^.FgC  := FgC;                                                                    // slider
         xO^.BgC  := BgC;                                                                    // slider
         xO^.cf.c := c;
         xPtD     := ADR(xO^.cf.n);
         xPtD^    := PTR_TO_UDINT(vb) ;


    200: // seria obrazkov
         xO^.wh   := 20;                     // kod objektu
         IF x <> 0 THEN
            xO^.x    := x;                     // kod objektu
         END_IF;
         IF y <> 0 THEN
            xO^.y    := y;
         END_IF;
         IF w <> 0 THEN
            xO^.w    := w;
         END_IF;
         xO^.h    := h;
         xO^.fn   := txt;
         xO^.BgC  := BgC;                    // xO^.BgC     :  x-ova suradnica zaciatku textu
         xO^.FgC  := FgC;                    // xO^.FgC     :  0/1/2,3 - podla CASE
         xO^.cf.c := c;                      // pocet obrazkov  ( 0 znamena ze je len jedne obrazok)
         xPtD     := ADR( xO^.cf.n) ;
         xPtD^    := PTR_TO_UDINT(vb) ;      // adresa zoznamu DayMode
         IF cm > 0 THEN
            xO^.cm   := cm;
         END_IF;

    219: // zobrazenie premennej z adresy

         xO^.wh      := 19;
         IF x > 0 THEN
            xO^.x       := x;
         ELSE
            xO^.x       := xO^.x + 25;                // posunie doprava
         END_IF;
         IF y > 0 THEN
            xO^.y       := y;
         END_IF;
         IF FgC = 0 THEN
            xO^.FgC     := 4;                          // farba textu default biela
         ELSE
            xO^.FgC     := FgC;                          // farba textu
         END_IF;
         xO^.BgC     := BgC;                          // styl textu (formatovanie)
         IF h > 0 THEN
            xO^.h       := h;                         // vyska textu
         ELSE
            xO^.h       := 26;
         END_IF;
         IF w > 0 THEN
            xO^.w       := w;
         ELSE
            xO^.w       := xO^.h*4;                    // sirka textu pre dotyk
         END_IF;
         IF fmt ='' THEN
            xO^.fmt  := '%5.1f°';
         ELSE
            xO^.fmt  := fmt;
         END_IF;
         xPtD     := ADR(xO^.cf.n);
         xPtD^    := PTR_TO_UDINT(vb) ;

         xO^.cf.c := t;                               // typ premennej
         xO^.cm   := cm;
         xO^.fn   := o1;
         xO^.nTch := nTch;

//               rb    := cm:=51, t:=1, o1:=33, vb := adr(xDev^.al.CM), fmt := 'ON', BgC:=2, x:= xR^.o.ob[2].x); // fmt := '%3.0f',


    221: // text s hodnotou
         xO^.wh   := 221;                                 // kod objektu    (obj = 5)
         xO^.fn   := txt;
         xO^.y    := y;
         xO^.nTch := nTch;
         IF x > 0 THEN
            xO^.x      := x;
         ELSE
            xO^.x       := 50;
         END_IF;
         IF w > 0 THEN
            xO^.w      := w;
         ELSE
            xO^.w       := 28;
         END_IF;
         IF h > 0 THEN
            xO^.h      := h;
         ELSE
            xO^.h       := 33;
         END_IF;
         IF Fgc > 0 THEN
            xO^.Fgc      := FgC;
         ELSE
            xO^.Fgc       := 2;
         END_IF;
         IF Bgc > 0 THEN
            xO^.Bgc      := BgC;
         ELSE
            xO^.Bgc       := 4;
         END_IF;
         xO^.fmt  := fmt;


    222: // obrazkov predvolieb kurenia/HET,TVE,CER,KOT
         xO^.wh   := 22;                                 // kod objektu    (obj = 5)
         xO^.w    := 48;                                 // velkost obrazku
         xO^.fn   := 1;
         xO^.cf.c := 4;                                  // pocet objektov 0..4
         xO^.cm   := 251;
         xPtD     := ADR(xO^.cf.n);
         xPtD^    := PTR_TO_UDINT(vb) ;
         xO^.fmt  := fmt;
//         xO^.x    := xR^.o.ob[5].x;

         CASE xL^.dsh OF
            1 :   xO^.h := 68;
           ELSE   xO^.h := 50;
         END_CASE;
         xR^.o.ob[ 9].wh := 0;                      // nevypisuje sa druhy riadok

    201: // 16: // obrazok BOOL 0/1
         xO^.wh   := 16;
         xO^.fn   := SINT_TO_INT(sl);
         xS^.t    := 4;
         xS^.v1   := INT_TO_REAL(o1);
         xS^.v2   := INT_TO_REAL(o2);
         xS^.vb   := PTR_TO_UDINT(vb);

    202: // veta DELETE / COPY
//         IF _NhFreObj() > 0 THEN

            xO := ADR(xR^.o.ob[1]);             // pri del sa pouzije objekt[2]

            xO^.fmt 	:= '';                     // zrusi sa text, ktory by va vypisal
            xO^.wh 	:= 4;                                 // obrazok s podkladom
            xO^.w  	:= 80;
            xO^.h  	:= kyr-10;
            xO^.x 	:= x2+36;
            xO^.y  	:= kyr/2+9;
            xO^.cf.c := 2;                      // round box
            xO^.cf.n := 0;                      // s vyplnou

            xO^.btn	:= true;							////16.6.23 - pridane pre identif. zmazania v PSN

            IF xA^.tch.del THEN
               xO^.cm   := 102;
               xO^.fn   := 58;                  // delete
               xO^.FgC  := 7;                   // cervena
               xO^.BgC  := 7;                   // cervena
            ELSIF xA^.tch.cpy  THEN
               xO^.cm   := 103;
               xO^.fn   := 45;                  // copy
               xO^.FgC  := 3;                   // azurova
               xO^.BgC  := 3;                   // azurova
            END_IF;
//         END_IF;


    251: // slider zo sablony v subore

//         _NhFrmName(read:=true, src:=ADR(xS^), cfg := aCfg[xR^.h.cf.c].frm, dsh:= xL^.dsh, wht := 1);

         xS^.vb   := PTR_TO_UDINT(vb);                                     // adresa premennej
         xO^.fn   := SINT_TO_INT(sl);                                      // do riadku dat cislo slidera
         xO^.wh   := 13;

    250: // slider
         xS^      := _eSld;
         xO^.fn   := SINT_TO_INT(sl);
         xO^.wh   := 13;
         xO^.cm   := 251;                                                                    // slider
         xO^.w    := w;                                                    // dlzka ciary slidera
         IF x <> 0 THEN
            xO^.x    := x;                                                    // zaciatok
         END_IF;
         xO^.prs  := 1;
         IF h = 0 THEN
            xO^.h    := 7;                                                    // DEV sa aj rozviecuje a LVL sa uklada do parametra
         ELSE
            xO^.h    := h;                                                    // DEV sa aj rozviecuje a LVL sa uklada do parametra
         END_IF;
         xO^.cf   := xR^.h.cf;
         IF FgC > 0 THEN
            xO^.FgC  := FgC;
         ELSE
            xO^.FgC  := 4;                                                    // biela gulicka
         END_IF;
         xS^.zom  := zom;
         xO^.nTch := nTch;
         IF xR^.h.chk AND xO^.cf.p > 0 THEN                                                 // zaskrtnuta vazba
            rb := _NhxPar(cp := aCfg[xO^.cf.c].par, np := xO^.cf.p,x:=251);             // xDev,xCfg,xPar pre aktualny riadok
            xS^.vb   := PTR_TO_UDINT(ADR(xPar^.all.lvl));                                                                    // dlzka ciary
            xS^.t    := 1;                                                 // usint
            xO^.BgC  := 8;                                                 // pri vazbach je zelena ciara
            IF xL^.vis = false THEN
               xO^.h    := 0;                                                 // len sa meni parameter, DEV je v povodnom stave
            END_IF;
         ELSE
            IF BgC > 0 THEN
               xO^.BgC  := BgC;
            ELSE
               xO^.BgC  := 5;
            END_IF;
            xS^.vb   := PTR_TO_UDINT(vb);                                                                    // dlzka ciary
            xS^.t    := t;                                                 // real
         END_IF;
         IF txt   > 0 THEN
            xS^.txt := txt;
         END_IF;
         xS^.tep := tep;                                             // po skonceni dotyku bude zobrazovat teplomer hodnoty va

      END_CASE;
END_FUNCTION

FUNCTION _NhTTdtV12  {HIDDEN} : BOOL
   VAR_INPUT
      noTxt : BOOL;
      r     : USINT;
   END_VAR
   _NhTTdtV12 := true;
//   sPtr  := INT_TO_UDINT(xO^.fn);            // posuv premennej
   sPtr  := USINT_TO_UDINT(r);            // posuv premennej
   xPtU  := UDINT_TO_PTR(xPtD^) + sPtr;                                        // pointer prvej bool premennej / pola
   CASE r OF
      0 : // year
            IF xTTdt^.year > 0 THEN
               xS^.v1 := USINT_TO_REAL(SYSTEM_S.COUNTER_YEARS);
            ELSE
               xS^.v1 := 0.0;
            END_IF;
            xS^.v2 := USINT_TO_REAL(SYSTEM_S.COUNTER_YEARS) + 5;
            xS^.txt := 216;
      1 : // month
            IF xTTdt^.year > 0 AND xTTdt^.year = SYSTEM_S.COUNTER_YEARS THEN
               xS^.v1 := USINT_TO_REAL(SYSTEM_S.COUNTER_MONTHS);
            ELSE
               xS^.v1 := 0.0;
            END_IF;
            xS^.v2 := 12.0;
            xS^.txt := 217;
      2 : // day
            CASE xO^.h OF
              1:  // dni v tyzdni
                  xS^.v1 := 1.0;
                  xS^.v2 := 7.0;
              2:  // pocet dni - (po uplynuti casu)
                  xS^.v1 := 0.0;
                  xS^.v2 := 22.0;         // len nahodne zadane, Ak je viac dni nefubguje to spravne
            ELSE
                  IF (xTTdt^.year > 0 AND xTTdt^.year  = SYSTEM_S.COUNTER_YEARS) AND
                     (xTTdt^.month> 0 AND xTTdt^.month = SYSTEM_S.COUNTER_MONTHS) THEN
                     xS^.v1 := USINT_TO_REAL(SYSTEM_S.COUNTER_DAYS_OF_MONTH);
                  ELSE
                     xS^.v1 := 0.0;
                  END_IF;
                  xS^.v2 := 31.0;
            END_CASE;
            xS^.txt := 218;
      3 : // hour
            xS^.v1 := 0.0;
            xS^.v2 := 24.0;
            xS^.txt := 219;
      4 : // min
            IF xTTdt^.hour = 24 THEN
               xS^.v1 := 0.0;
               xS^.v2 := 0.0;
            ELSE
               xS^.v1 := 0.0;
               xS^.v2 := 59.0;
            END_IF;
            xS^.txt := 220;
      5 : // sec
            xS^.v1 := 0.0;
            xS^.v2 := 59.0;
            xS^.txt := 221;
      ELSE
            xS^.txt := 0;
   END_CASE;
   If noTxt THEN
      xS^.txt := 0;
   END_IF;
   // korekcia
   IF xPtU^ < REAL_TO_USINT(xS^.v1) OR xPtU^ > REAL_TO_USINT(xS^.v2) THEN
      xPtU^ := REAL_TO_USINT(xS^.v1);

   END_IF;
END_FUNCTION

FUNCTION _NhDaysMonth  {HIDDEN} : USINT
	VAR_INPUT
		month	: USINT;
	END_VAR
	CASE month OF
     2 : _NhDaysMonth := 29;
     4 : _NhDaysMonth := 30;
     6 : _NhDaysMonth := 30;     ;
     9 : _NhDaysMonth := 30;
     11: _NhDaysMonth := 30;
   ELSE _NhDaysMonth := 31;
   END_CASE;
END_FUNCTION


FUNCTION _NhChkDTHH  {HIDDEN} : BOOL
   VAR_INPUT
		Chk	: BOOL := true;
		wht	: USINT;								// 1=YY,2=MM,3=DD...
		dthh	: PTR_TO NH_DT_M;         	// struktura datumu
   END_VAR
	_NhChkDTHH := true;
   CASE wht OF
      1 : // year
            xS^.v1 := USINT_TO_REAL(SYSTEM_S.COUNTER_YEARS)-1;
            xS^.v2 := USINT_TO_REAL(SYSTEM_S.COUNTER_YEARS) + 10;
				IF xPtU^ = REAL_TO_USINT(xS^.v1) THEN
					xPtU^ := 0;
				END_IF;
            IF xPtU^  > 0 THEN
               xPtU^ := MAX(SYSTEM_S.COUNTER_YEARS,xPtU^);
				ELSE
					Chk 	:= false;
            END_IF;
            xS^.txt := 216;
      2 : // month
(*
            IF xPtU^ > 0 AND dthh^.year = SYSTEM_S.COUNTER_YEARS THEN
               xS^.v1 := USINT_TO_REAL(SYSTEM_S.COUNTER_MONTHS);
            ELSE
               xS^.v1 := 0.0;
            END_IF;
*)
            xS^.v1 := 0.0;
            xS^.v2 := 12.0;
            xS^.txt := 217;
      3 : // day
          	xS^.v1 := 0.0;
				xS^.v2 := USINT_TO_REAL(_NhDaysMonth(month:=dthh^.month));
          xS^.txt := 218;
      4 : // hour
          xS^.v1 := 0.0;
          xS^.v2 := 23.0;
          xS^.txt := 219;
      5 : // min
          xS^.v1 := 0.0;
          xS^.v2 := 59.0;
          xS^.txt := 220;
      ELSE
	       xS^.txt := 0;
   END_CASE;
   // korekcia
   IF xPtU^ < REAL_TO_USINT(xS^.v1) OR xPtU^ > REAL_TO_USINT(xS^.v2) THEN
		IF chk THEN
	      xPtU^ := REAL_TO_USINT(xS^.v1);
		END_IF;
   END_IF;
END_FUNCTION

FUNCTION _Nh_Vaz_DEV  {HIDDEN} : BOOL                          // nastavi zoznam DEV do xF^.dev[]
		_Nh_Vaz_DEV := true;
		CASE xL^.obj OF
         50: 	_NhFilDev(			wht:=4, row:=xF^.cf.c);           // iov
			55:	_NhFilDev(lst:=1,	wht:=2, row:=xF^.cf.c);    // externe vazby
			56:	_NhFilDev(lst:=1,	wht:=1               );    // DEV priradene do DLs/rgbwa
      ELSE 		_NhFilDev(lst:=1,	wht:=3, row:=xF^.cf.c);           // lst
      END_CASE;
END_FUNCTION



FUNCTION _Nh_Vaz_CAT  {HIDDEN} : BOOL
   VAR_INPUT
      chg   : BOOL;
   END_VAR
	_Nh_Vaz_CAT := true;
   IF xU^.o[4].fn = 0 THEN
      RETURN;
   ELSE
      _Nh_Vaz_DEV();
      IF chg THEN
         xL^.fdv := xL^.fdv + 1;
         WHILE _Nh_IxC[ xL^.fdv ] > 0 DO                               // prechadza index CFG
            cf := _Nh_IxC[ xL^.fdv ];
            IF xF^.dev.n[ cf ] AND (aCfg[ cf ].rec > 0 OR aCfg[ cf ].NoRecCat) THEN            // toto dev sa ma zobrazit a ma nejaku vetu, alebo sa bez vety (SMW,BLK,TIM..)
               EXIT;
            END_IF;
            xL^.fdv := xL^.fdv + 1;
         END_WHILE;
         IF _Nh_IxC[ xL^.fdv ] = 0 THEN                                   // dosli sme na koniec DEV listu
            xL^.fdv            := 0;
         ELSE
				xF^.dev				:= eFilt_LIST;			
            xF^.dev.n[cf]     := true;                                  // aktivovat len jeno dev
				_NhTypObr(cf:=cf);
				xU^.o[4].fn	:= xObrWht^.obr;
         END_IF;
      END_IF;
      IF xL^.fdv = 0 THEN
         xU^.o[4].fn        := 10;                                         // obrazok vsetkych kategori
      END_IF;
      xU^.o[4].wh           := xU^.o[4].fn;                                // obrazok dev
   END_IF;

END_FUNCTION

FUNCTION _Nh_Vaz_ROM  {HIDDEN}  : BOOL
   VAR_INPUT
      chg   : BOOL;
   END_VAR
	_Nh_Vaz_ROM := true;
	IF xU^.o[5].fn > 0 THEN
	   IF chg  THEN
			ok := _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=45);         // koli zisteniu ROM pre dev co je v hlavicke
			IF xF^.rom = xPt^.cf.rom OR USINT_TO_INT(xF^.rom) >= aCfg[1].rec THEN
				xF^.rom := 0;			
			ELSE
				xF^.rom := xPt^.cf.rom;
			END_IF;		
		END_IF;
		xU^.o[5].fn := _Nh_O12(xF^.rom=0,16,18);
	END_IF;
END_FUNCTION

FUNCTION _Nh_Vaz_CHK    {HIDDEN}  : BOOL
   VAR_INPUT
      chg   : BOOL;
  		ini	: BOOL;
   END_VAR
	_Nh_Vaz_CHK := true;
	ok := _NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=45);         	// koli zisteniu ROM pre dev co je v hlavicke
   IF chg  THEN
//		_NhxPt(c := xF^.cf.c, n := xF^.cf.n,x:=45);         	// koli zisteniu ROM pre dev co je v hlavicke
		IF xL^.fvz = false THEN											// OFF->ON
      	xL^.fdv 			:= 0;
			_Nh_Vaz_CAT();
			xF^.rom 			:= 0;
//			_Nh_Vaz_ROM(); 												// len obrazok
		ELSIF xF^.cf.c = 5 THEN											// akcie
			xF^.rom 			:= 0;											// podhodi 0, aby dalsia fn nastavila rom ak vysia cast ma
		ELSIF ok THEN
			xF^.rom := xPt^.cf.rom;
		ELSE
			xF^.rom 			:= 0;											// podhodi 0, aby dalsia fn nastavila rom ak vysia cast ma
		END_IF;
      xL^.fvz := NOT xL^.fvz;                               // pri clicku zmeni		
//			_Nh_Vaz_ROM(chg:=chg); 										// vypne filter a prednastavi le ROM 		
		_Nh_Vaz_ROM();
	ELSIF ini THEN
		IF xL^.obj = 55 THEN
			xL^.fdv     		:= 0;                            // vsetky CAT
			xL^.fvz     		:= false;                   		// filter ON
			xF^.rom  			:= 0;                            // vsetky ROM
      	IF xDev^.al.lst THEN
				xL^.fvz     		:= true;                   		// filter ON
			ELSIF ok THEN
				xF^.rom := xPt^.cf.rom;
			END_IF;      	
		END_IF;	
   END_IF;
   xU^.o[3].fn := _Nh_O12(xL^.fvz,38,35);
	_Nh_Vaz_ROM();
END_FUNCTION

FUNCTION _Nh_Shw_Ini {HIDDEN} : BOOL
   VAR_INPUT
      clr  : BOOL;
   END_VAR
   _Nh_Shw_ini := true;
   yRn := eRn;
   IF clr THEN
      yRn.v[0].wh := 0;
   END_IF;
END_FUNCTION


FUNCTION _Nh_Shw_232  {HIDDEN} : BOOL
	VAR_INPUT
		o1		: BOOL;
		cat	: INT;
		sta	: USINT;
	END_VAR
   _Nh_Shw_232 := true;
	IF o1 THEN								
  		yRn.v[0].obr   := yFrm_232.cat[cat].obr0;
 		yRn.v[0].wh    := 0;	         														// hlavny obrazok nema podklad
	ELSIF sta > 0 AND yFrm_232.cat[cat].obr1 < 0 THEN						         // zoznam sta ak je nejaky stat
		cat				:= yFrm_232.cat[cat].obr1 * -1  + USINT_TO_INT(sta-1);
  		yRn.v[0].obr   := yFrm_232.sta[cat, 0];
   	yRn.v[0].wh    := INT_TO_USINT(yFrm_232.sta[cat, 1]);
	ELSIF sta = 0 THEN
//		sta 				:= MIN(sta*2,2);
  		yRn.v[0].obr   := yFrm_232.cat[cat].obr0;
   	yRn.v[0].wh    := yFrm_232.cat[cat].wh0;
	ELSE
  		yRn.v[0].obr   := yFrm_232.cat[cat].obr1;
   	yRn.v[0].wh    := yFrm_232.cat[cat].wh1;
	END_IF;
END_FUNCTION


//	_Nh_Shw_LCK_ET(ala:=xZon^.cx.lck.stat > 4, et:=xZon^.cx.lck.et, o := 4);
FUNCTION _Nh_Shw_LCK_ET {HIDDEN} : BOOL
	VAR_INPUT
		sta 	: USINT;
		et		: UINT;
		o  	: USINT;
	END_VAR
   _Nh_Shw_LCK_ET := true;
	IF et > 0 THEN
		x4o^.wh			:= 107;
   	x4o^.ok[o]  	:=  true;
//		ala:=xRom^.cx.lck.stat > 4
		IF sta > 5 OR sta = 4 THEN
			x4o^.Bgc[o]  	:= 8; 						// cierny/zeleny podklad = autorestart
			x4o^.Fgt[o]  	:= 1;
		ELSIF sta = 5 THEN
			x4o^.Bgc[o]  	:= 7; 						// cierny/zeleny podklad = autorestart
			x4o^.Fgt[o]  	:= 4;
		ELSE
			x4o^.Bgc[o]  	:= 5;
			x4o^.Fgt[o]  	:= 1;
		END_IF;
		IF et > 60 THEN
			et := et / 60 ;
		END_IF;
		x4o^.obr[o]  	:= UINT_TO_INT(et);
	ELSE
   	x4o^.ok[o]  	:=  false;	
	END_IF;
END_FUNCTION




FUNCTION _NhDevSetCpy {HIDDEN} : BOOL		// oznaci/odznaci xPt^.ok.cpy , alebo zisti ci je aspon 1 zaznam oznaceny
	VAR_INPUT
		set		: BOOL;				// nastavit
		chk		: BOOL;           // zistit
		cf			: USINT;
  	  	nd			: INT;
  	  	rec		: INT;
	END_VAR
	_NhDevSetCpy := false;
	WHILE nd <= rec DO
		IF _NhxPt(c:=cf, n:=nd, x:=133) THEN
			IF chk THEN
				IF xPt^.ok.cpy THEN
					_NhDevSetCpy := true;
					EXIT;
				END_IF;
			ELSIF set THEN
			
				xPt^.ok.cpy := 1;
			ELSE
				xPt^.ok.cpy := 0;
			END_IF;
		END_IF;
		nd	:= nd + 1;
 	END_WHILE;			
END_FUNCTION




FUNCTION _NhSldRolCircle {HIDDEN}  : BOOL
	VAR_INPUT
		lam		: BOOL;
	END_VAR
	_NhSldRolCircle 	:= true;
	// default hodnoty pre pohyb = sipky
	grp					:= 0;														// cislo obrazka (nepohybuje sa)
	new 					:= xRo^.rCirUpDn;										// velkost gulicky / podkladu
	del					:= new*20/12;											// velkost obrazka
  	GC_SetBgColor (Color := _NhColor[7]    , GrData := xCan);
	CASE xRol^.cx.cmd OF
     201 :	grp	:= 117;														// up
     202 :	grp	:= 118;														// Dn
     203 :	grp	:= 234;															// calibrate
				grp	:= 232;														// Dn	
				del 	:= new*2;
				new	:= 2;	
	ELSE
	END_CASE;
	IF lam THEN
		IF grp > 0 AND (xRol^.al.sta = 3 OR xRol^.al.sta = 5) THEN	// pohybuju sa lamely
      	RETURN;
		END_IF;
	ELSIF grp = 0 THEN															// ziaden pohyb ROL
		IF xRo^.SldRol	= false THEN
			_NhSldRolCircle 	:= false;
			RETURN;
		END_IF;
	ELSIF xRol^.al.sta = 4 OR xRol^.al.sta = 6 OR xRol^.cx.cmd = 203 THEN
		RETURN;
	END_IF;
	grp	:= 0;
	new 	:= xRo^.rCirSld;
	GC_SetBgColor (Color := _NhColor[4]    , GrData := xCan);
END_FUNCTION


FUNCTION _Nh_ROL_Sld {HIDDEN}  : BOOL
	yRo	:= xRo^;
	IF _NhxCfg(c := xRo^.cf.c, n := xRo^.cf.n, par := true, p := xRo^.cf.p, x:=20) = false THEN
		RETURN;
	END_IF;
	xRol	:= xDev;
	pRol	:= xPar;	
	IF xRo^.chk THEN
   	rmp		:=	8;	// check = zelena
	ELSE
		rmp		:=	3;	
	END_IF;
	ok3 	:= true;
	xPtU		:= ADR(pRol^.rol.pRol);
	xPtU2		:= ADR(pRol^.rol.pLam);

	IF xRo^.Q THEN 																// je dotyk
		IF xRo^.Qr AND xRo^.cf.p = xRol^.cf.par THEN												
			pRol^.rol.pRol	:= xRol^.cx.uRol;
			pRol^.rol.pLam	:= xRol^.cx.uLam;
		END_IF;
		ok3 := false;
		CASE  xRol^.me.CMDs OF
   			
  			71 :	// slider ROL
					// suradnica gulicky
					xRo^.yCirRol		:= LIMIT(xA^.tch.y2, xRo^.y, xRo^.y + xRo^.h);
					// prepocet suradnice na poziciu 0..100%;
					xPtU^ 			:= LIMIT( REAL_TO_USINT( 100.0*INT_TO_REAL(xRo^.yCirRol-xRo^.y)/INT_TO_REAL(xRo^.h)) ,0,100);
					IF xPtU^ > xRol^.cx.uRol THEN
						xPtU2^ := 100;
					ELSE
						xPtU2^ := 0;
					END_IF;
					//xRol^.me.CMDs         	:= 14;
  			72 :	// slider LAM
					// suradnica gulicky
					xRo^.yCirLam		:= LIMIT(xA^.tch.y2, xRo^.yLam, xRo^.yLam + xRo^.hLam);
					// prepocet suradnice na poziciu 0..100%;
					xPtU2^ 				:= LIMIT( REAL_TO_USINT( 100.0*INT_TO_REAL(xRo^.yCirLam-xRo^.yLam)/INT_TO_REAL(xRo^.hLam)) ,0,100);
      END_CASE;
		IF xRo^.Qf THEN 																// koniec dotyku

			CASE  xRol^.me.CMDs OF
			  200	: // vypnut rucne blokovanie
                	xRol^.cx.CmdWind 	:= 4;
						xRol^.me.CMDs 		:= 0;	
			  201	: // restart Winguard
                	xRol^.cx.CmdWind 	:= 4;
						xRol^.me.CMDs 		:= 0;	

	  			28 :	// info obrazok LAM - zmena krajnej polohy = ROVNAKY PRIKAZ
						;
  	  		   11 :  // info obrazok ROL - zmena krajnej polohy
						IF xRo^.chk AND xPtU^ < 50 THEN
//							xRol^.me.CMDs		:= 11;							      	// zatiahnut dolu
						ELSIF xRol^.cx.uRol >= 50 THEN
							xRol^.me.CMDs		:= 10;										// vytiahnut hore
						END_IF;
  				71 :	// slider ROL
            		xRol^.me.CMDs		:= 13;
						del := USINT_TO_INT(xPtU^)- USINT_TO_INT(xRol^.cx.uRol);	// pripravit zistenie min.posunu							
						IF xRo^.chk THEN																// pri vazbe sa nic nekontroluja ani neprestavuje						
							;
						ELSIF ABS(del) < USINT_TO_INT(xRol^.cx.cf.IgnoreReQRol) THEN   // ignorovat poziadavku <
							xRol^.me.CMDs := 0;	
						ELSIF xPtU^ < xRol^.cx.uRol  THEN                          // hore
							xPtU2^ := 0;                            						// upravi LAM   		  	
						ELSE
							xPtU2^ := 100;
						END_IF;
				72 :	// slider LAM
  						xRol^.me.CMDs		:= 13;
						del := USINT_TO_INT(xPtU2^)- USINT_TO_INT(xRol^.cx.uLam);	// pripravit zistenie min.posunu							
						IF xRo^.chk THEN																// pri vazbe sa nic nekontroluja ani neprestavuje						
							;
						ELSIF ABS(del) < USINT_TO_INT(xRol^.cx.cf.IgnoreReQLam) THEN   // ignorovat poziadavku <
							xRol^.me.CMDs := 0;	
						END_IF;
			END_CASE;
			IF xRo^.chk  THEN             														// pri vazbe sa neposiela ziadny CMD
				IF xRol^.me.CMDs = 1 THEN
						IF xRo^.chk AND xPtU^ < 50 THEN
							xRol^.me.CMDs		:= 11;							      	// zatiahnut dolu
						ELSIF xRol^.cx.uRol >= 50 THEN
							xRol^.me.CMDs		:= 10;										// vytiahnut hore
						END_IF;
				END_IF;
				CASE xRol^.me.CMDs OF
					11:   // vytiahnut
							pRol^.rol.pRol	:= 100;
							pRol^.rol.pLam	:= 100;
					10:   // vytiahnut
							pRol^.rol.pRol	:= 0;
							pRol^.rol.pLam	:= 0;
            END_CASE;
			ELSIF xRol^.me.CMDs > 0 THEN
 				xRol^.al.in.cmd	:= xRol^.me.CMDs;							
 				xRol^.al.in.par	:= 0;																// ked je par = 0, podhodi default par
			END_IF;
			xRol^.me.CMDs 			:= 0;
		END_IF;
	ELSIF xRo^.chk THEN
		;
	ELSE
		xPtU		:= ADR(xRol^.cx.uRol);
		xPtU2		:= ADR(xRol^.cx.uLam);
	END_IF;
	IF ok3 THEN
		xRo^.yCirRol	:= REAL_TO_INT(USINT_TO_REAL(xPtU^)*0.01 * INT_TO_REAL(xRo^.h)) 		+ xRo^.y;
		xRo^.yCirLam	:= REAL_TO_INT(USINT_TO_REAL(xPtU2^)*0.01 * INT_TO_REAL(xRo^.hLam)) 	+ xRo^.yLam;
	END_IF;	

	// parametre vykreslovania
	vai := _Nh_Sty[0];  // + GTEXT_STYLE_FILLBG;
	GC_SetTextstyle(style   := vai, GrData := xCan);           // formatovanie textu zlava do prava
   GC_SetFillStyle(style   := GFILL_STYLE_BGCOLOR, GrData := xCan);					
   GC_SetFgColor 	(Color := _NhColor[10]    , GrData := xCan);
   GC_SetLineWidth(Width := 1,  GrData := xCan);
   GC_Heading     (angle := 90,  GrData := xCan);
	// BOX-roleta aktivna cast
  	GC_RoundBox	(	fill := 0, r := xRo^.corner , GrData := xCan,
						x			:=	xRo^.x,
						y			:=	xRo^.y,
	  					width 	:= xRo^.w,
	  					height 	:= xRo^.h,
	  					);

  	// box nad roletou
   GC_SetBgColor (Color := _NhColor[10]    , GrData := xCan);
 	GC_RoundBox	(	fill := 1, r := 1 , GrData := xCan,
						x			:=	xRo^.x,
						y			:=	xRo^.y-xRo^.bRol,
	  					width 	:= xRo^.w,
	  					height 	:= xRo^.bRol ,
	  					);
	// vykresli lamely
	GC_SetBgColor (Color := _NhColor[rmp]    , GrData := xCan);
	grp		:= xRo^.y ;  			       									// y-pozicia  1.lamely
	
	IF xRol^.me.CMDs = 71 THEN             											// tahame slider ROL
		IF xPtU^ < xRol^.cx.uRol THEN                               // hore
			new 		:= 2;															// sirka LAM je minimalna
		ELSE
			new 		:= xRo^.wLmax;												// zatahujeme dolu lamely budu zaklopene = sirka MAX
		END_IF
	ELSE
		new := MAX(2 ,USINT_TO_INT(xPtU2^)*xRo^.wLmax/100);		// vypocitat vysku lamely	
	END_IF;
//	new := MAX(2 ,USINT_TO_INT(xRo^.pLam)*xRo^.wLmax/100);		// vypocitat vysku lamely	
	k 			:= REAL_TO_USINT(USINT_TO_REAL(xPtU^)*USINT_TO_REAL(xRo^.nLam)/100.0);	 // pocet viditelnych lamiel
	FOR i := 1 TO k DO
	 	GC_Box	(	fill := 1, GrData := xCan,
						x			:=	xRo^.x + xRo^.mLam,
						y			:=	grp,
	  					width 	:= xRo^.w - xRo^.mLam*2 ,
	  					height 	:= new,
	  					);
		grp := grp + xRo^.wLmax + 1; 												// zvacsit o plnu sirku lamely + medzery
	END_FOR;

	del	:= USINT_TO_INT(xRo^.wObr);
	IF xRo^.statRow THEN																// zobrazuje sa stavovy riadok
//   	GC_SetFgColor (Color := _NhColor[rmp]    , GrData := xCan);
   	GC_SetFgColor (Color := _NhColor[10]    , GrData := xCan);
      GC_SetTextSize (size	:= xRo^.hTxt, GrData := xCan);           // vyska textu
		// ROL
		GC_MoveTo  	(	x:=xRo^.xObrR, y:=xRo^.yObr, GrData := xCan);
	  	GC_CImage	(	fileName	:=	_NhFnObr(fn := 115), width	:= del, height := del, GrData := xCan);
		GC_MoveTo  	(	x:=xRo^.xObrR + del/2, y:=xRo^.yObr, GrData := xCan);
		GC_WriteText(	text := USINT_TO_STRINGF(xPtU^,'%3u%%') , GrData := xCan);           //
		// LAM
		GC_MoveTo  	(	x:=xRo^.xObrL, y:=xRo^.yObr, GrData := xCan);
	  	GC_CImage	(	fileName	:=	_NhFnObr(fn := 499), width	:= del, height := del, GrData := xCan);
		GC_MoveTo  	(	x:=xRo^.xObrL + del/2, y:=xRo^.yObr, GrData := xCan);
		GC_WriteText(	text := USINT_TO_STRINGF(xPtU2^,'%3u%%') , GrData := xCan);           //
	END_IF;
	IF xRo^.SldLam	THEN																// zobrazuje sa slider LAM
		IF xRo^.ShwLamUp THEN
			// obrazok otvorenej lamely
			GC_MoveTo  	(	x:=xRo^.xLam, y:=xRo^.y-xRo^.bRol/2, GrData := xCan);
	  		GC_CImage	(	fileName	:=	_NhFnObr(fn := 498), width	:= del, height := del, GrData := xCan);
			// obrazok zatvorenej lamely
			GC_MoveTo  	(	x:=xRo^.xLam, y:=xRo^.yObr, GrData := xCan);
	  		GC_CImage	(	fileName	:=	_NhFnObr(fn := 500), width	:= del, height := del, GrData := xCan);
		END_IF;
		// siva ciara slideru LAM
   	GC_SetFgColor (Color := _NhColor[10]    , GrData := xCan);
		GC_MoveTo  	(	x := xRo^.xLam, y	:=	xRo^.yLam,GrData := xCan);
		GC_LineFwd  (	length := xRo^.hLam, GrData := xCan);
   	// aktivna cast slideru LAM
   	GC_SetBgColor (Color := _NhColor[rmp]    , GrData := xCan);
	  	GC_RoundBox	(	fill := 1, r := 15 , GrData := xCan,
						x			:=	xRo^.xLam-xRo^.wSldLam/2,
						y			:=	xRo^.yLam,
	  					width 	:= xRo^.wSldLam,
	  					height 	:= xRo^.yCirLam - xRo^.yLam,
	  					);

		_NhSldRolCircle(lam:=true);								// gulicka LAM
		GC_Circle	(	fill := 1, r := new , GrData := xCan,
							x			:=	xRo^.xLam,
							y			:=	xRo^.yCirLam,
	  						);

		IF grp > 0 THEN																	// vykresli siplu pohybu / hodiny
  			GC_CImage	(	fileName	:=	_NhFnObr(fn := grp), width	:= del, height := del, GrData := xCan);
		END_IF;
	END_IF;

	IF _NhSldRolCircle() THEN											// gulicka ROL
		GC_Circle	(	fill := 1, r := new , GrData := xCan,
							x			:= xRo^.x + xRo^.w/2,
							y			:=	xRo^.yCirRol,
	  						);
		IF grp > 0 THEN																	// vykresli siplu pohybu / hodiny
  			GC_CImage	(	fileName	:=	_NhFnObr(fn := grp), width	:= del, height := del, GrData := xCan);
		END_IF;

	END_IF;
	IF xRol^.cx.CmdWind > 9 THEN                                         	// orchana proti vetru zapnuta
		GC_MoveTo  	(	x := xRo^.x, y	:=	xRo^.y,GrData := xCan);
		IF xRol^.me.dWindDn.In	THEN							// uz vietor zoslabol, len sa caka za delay pre vytiahnutie
  			GC_CImage	(	fileName	:=	_NhFnObr(fn := 264), width	:= xRo^.wObrInfo, height := xRo^.wObrInfo, GrData := xCan);
		ELSE
  			GC_CImage	(	fileName	:=	_NhFnObr(fn := 263), width	:= xRo^.wObrInfo, height := xRo^.wObrInfo, GrData := xCan);
		END_IF;
   END_IF;	
   IF xRol^.cx.etHandBlkWind > 0 THEN														// odpocitava sa cas rucneho breaku do WindGuard
		GC_MoveTo  	(	x := xRo^.x+xRo^.w, y:=	xRo^.y,GrData := xCan);
		GC_CImage	(	fileName	:=	_NhFnObr(fn := 265), width	:= xRo^.wObrInfo, height := xRo^.wObrInfo, GrData := xCan);
   END_IF;


   GC_Heading      (angle := 0,  GrData := xCan);  	
END_FUNCTION

		
