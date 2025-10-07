   _NH_DEV_INI(c:=c);

IF true THEN
;
EN_IF;

   FOR nd := 1 TO aCfg[cf].Rec DO
      IF _Dev_REC_BLK() THEN
         xTve  := xDev;
         xHet  := xDev;                                                    // niektore funkcie potrebuju
         IF aSys.Restart THEN
               xTve^.cx.obr.BTN  := eTve.cx.obr.BTN;                    // na zaciatku vsetky PV
               IF xTve^.hw.d[0] = 0 THEN                                // nema ziadny HW (stupen 1=ON}
                  xTve^.me.typ         := 0;
                  xTve^.cx.obr.typ     := 3;                            // sada obrazkov err
                  FOR i := 2 TO 4 DO
                     xTve^.cx.obr.BTN[i]  := 0;                         // nezobrazuju sa dalsie
                  END_FOR;
               ELSE
                  xTve^.me.pvm.pv   := 255;                             // aby sa vykonal refresh HW
                  xTve^.me.typ      := 1;                               // 1:BOOL 0-1 / 2:BOOL 0-1-2-3 / 3: REAL / 4: TECO-TV / 5:prepojenie s technologio
                  xTve^.cx.obr.typ  := 2;                               // vyberie sadu obrazko pre PV
               END_IF;
               ok := true;
               CASE cf OF
                  8: //TVE
                     CASE xTve^.cf.typ OF
                        0:                                           // BOOL  TVE  ON/OFF, NO/NC
                        1: ok := false;                              // BOOL  EL.ROHOZ   0-1-2-3   hw.d[0..3]
                        3: xTve^.me.typ := 3;                        // REAL  EL.ROHOZ  [0-10,PWM]
                        4: xTve^.me.typ := 4;                        // TECO TVE
                        5: xTve^.me.typ := 100;                      // prepojenie s technologiou TVE
                     END_CASE;
                 23: //VEN
                     CASE xTve^.cf.typ OF
                        0:  ok := false;                             // BOOL VENT         0-1-2-3   hw.d[0..3]
                        1:  ok := false;                             // BOOL REKUPERACIA  0-1-2-3   hw.d[0..3]
                        3:  xTve^.me.typ := 3;                       // REAL VENTILATOR
                        4:  xTve^.me.typ := 3;                       // REAL REKUPERACIA
                        5:  xTve^.me.typ := 101;                     // prepojenie s technologiou vetrania
                     END_CASE;
               END_CASE;
               // rozhodne ci budu obrazky 0-1-2-3 alebo len ON/OFF
               IF ok THEN
                  ;
               ELSIF xTve^.hw.d[1] = 0 AND xTve^.hw.d[2] = 0  THEN
                  xTve^.me.typ := 1;                                 // ON/OFf
               ELSE
                  xTve^.me.typ := 2;                                 // 0-1-2-3    hw.d[0..2]
               END_IF;

               IF xTve^.me.typ < 3 THEN
                  _NhTveOnOff(obr:=true);                            // nastavi pritomnost OBR pre PV podla toho ci mme HW HW
               END_IF;
         ELSIF xTve^.me.typ = 0  THEN                                // nemame HW
            ;
         ELSE  // vsetko OK, vykonava sa procedura
            xPvA  := ADR(xTve^.cx.par.pva);
            xMan  := ADR(xTve^.cx.par.MAN);
            // kontrola na akciu z WEB
            IF xPvA^.man THEN                                                    // prave sa zapol MAN, alebo potvrdil ten isty stupen
               xPvA^.man   := false;
               IF xMan^.manTyp = 0 THEN                                          // rucne sa nikdy nezmeni
                  xHet^.cx.chg.dtChg    := UINT_TO_DT(0);
               ELSE
                  _NH_HET_MAN(man := xMan, chg := ADR(xHet^.cx.chg));            // pri prepnuti na MAN zisti koniec z parametra
               END_IF;
               xTve^.me.pvm.pv   := 255;                                         // refresh HW,PV
            ELSIF xPvA^.prg AND xTve^.me.pvm.PRG = false THEN
               xTve^.me.pvm.PRG  := true;
               xTve^.me.pvm.pv   := 255;
            ELSIF SYSTEM_S.R_EDGE_10SEC THEN
               xTve^.me.pvm.pv   := 255;
            END_IF;
            IF xTve^.me.pvm.pv = 255 THEN                                        // refresh
               xTve^.cx.chg.toChg    := T#0s;
               IF xPvA^.prg = false THEN                                         // zi sa uz neskoncil manual
                  IF xTve^.cx.chg.dtChg = UINT_TO_DT(0) THEN                     // MAN sa nikdy neskonci
                     ;
                  ELSIF xTve^.cx.chg.dtChg <= aSys.NhDT THEN                     // prave sa skoncil MAN
                     xPvA^.prg   := true;
                  ELSE
                     xTve^.cx.chg.toChg    := SUB_DT_DT(IN1 := xTve^.cx.chg.dtChg, IN2 := aSys.NhDT );       // vypocita sa casu do najblizsej zmeny
                  END_IF;
               ELSE
                  xTve^.cx.chg.dtChg := UINT_TO_DT(0);
               END_IF;
            END_IF;
            // ak nie je MAN, prebera sa poziadavka z nadradeneho regulatora
            IF xPva^.prg THEN
               xPva^.pv       := xDev^.al.LVL;                                // preberie sa max LVL zadavany z regulatorov
            END_IF;

               // test vysoka/nizka teplota, obsah CO
               IF xTve^.cx.vaz.dev[0].c > 0 THEN                                 // ma snimac teploty
                  IF _NhxPt(cf:=xTve^.cx.vaz.dev[0].c, nd:=xTve^.cx.vaz.dev[0].n, x:=78) THEN      // existuje DEV teploty
                     xTve^.me.reG[0] := xPt^.al.ou.val;                          // zapise sa regulovana teplota
                     IF xTve^.me.ReG[0] = 0.0   OR                               // nula je ako ze nedava teplotu
                        xTve^.me.ReG[0] <= -40.0 OR                              // snimac ukazuje chujovinu
                        xTve^.me.ReG[0] >= 124.0 THEN                            // snimac ukazuje chujovinu
                        ;
                      ELSIF xTve^.cx.tMax > 0 AND REAL_TO_USINT(xTve^.me.ReG[0]) >= xTve^.cx.tMax THEN       // vysoka teplota
                        xDev^.al.CM    := 110;
                        xPvA^.prg      := false;
                        xPva^.pv       := 0;                                                                // vypnutie manualu
                        xTve^.cx.chg.dtChg    := UINT_TO_DT(0);
                     ELSIF xTve^.cx.tMin > 0 AND REAL_TO_USINT(xTve^.me.ReG[0]) <= xTve^.cx.tMin THEN       // nizka teplota
                        xDev^.al.CM    := 120;
                        xPvA^.prg      := false;
                        xPva^.pv       := 1;
                        xTve^.cx.chg.dtChg    := UINT_TO_DT(0);
                     ELSIF xDev^.al.CM > 0 THEN
                        xDev^.al.CM    := 0;
                        xPvA^.prg      := true;
                        xPva^.pv       := 0;                                     // ak sa skoncilo nejake obmedzenie, vypne sa
                        xTve^.cx.chg.dtChg    := UINT_TO_DT(0);
                     END_IF;
                  ELSE
                     xTve^.cx.vaz.dev[0].c := 0;
                     xDev^.al.CM           := 0;
                  END_IF;
               ELSE
                  xTve^.me.reG[0] := -0.0001;
               END_IF;


            // ak je LVL(PV) > 1, skontroluje, ci mame na to HW, inak znizi na nizsi LVL
            WHILE xPva^.pv > 1 DO
               IF xTve^.cx.obr.btn[xPva^.pv+1] THEN
                  EXIT;
               ELSE
                  xPva^.pv := xPva^.pv -1;                                    // nemame HW, znizi supen
               END_IF;
            END_WHILE;



               // je zmena PV - vyrovna s MEM a nastavi opozdenie technologie
               IF xPva^.pv <> xTve^.me.pvm.pv THEN
                  xTve^.me.pvm   := xPvA^;                                       // vyrovna pamat s poziadavkou
                  xDev^.al.el    := MAX(1,xTve^.cx.pvp.delay);                   // nastavi sa opozdenie technologie
                  _NhDevRef(xR := xHet);
               END_IF;
               CASE xDev^.al.el OF                                               // opozdenie technologie
                 0:  // nastavuje sa vystup pre browser s casom otvorenia, HW je uz nastavene
                     IF xTve^.al.ou.val <> xTve^.al.in.val THEN
                        IF xTve^.me.typ <> 4 THEN
                           IF  xTve^.cx.tRun > 0 THEN
                              _NhInkrValTst(wh:=1, cj:=2, tRun:=xTve^.cx.tRun, in:=ADR(xTve^.al.in.Val), ou:=ADR(xTve^.al.ou.Val) );
                           ELSE
                              xTve^.al.ou.val := xTve^.al.in.val;
                           END_IF;
                        ELSE                                                     // TECO-TV

                        END_IF;
                        IF xTve^.al.ou.val = xTve^.al.in.val OR SYSTEM_S.R_EDGE_1SEC THEN
                           _NhDevRef(xR := xHet);
                        END_IF;
                     END_IF;

                 1:  // posledna SEC => skoncilo opozdenie technologie, zapne sa HW fyzicky
                     xDev^.al.el := 0;                                              // za v dalsom cykle sa to prejavi v APP
                     CASE xTve^.me.typ OF
                       0:  // nema ziadnu HW adresu
                       1:  // BOOL 0-1  aj NO/NC
                           xPtB              := UDINT_TO_PTR(xTve^.hw.d[0]);
                           xPtB^             := USINT_TO_BOOL(xPva^.pv);            // zoberie sa priamo PV. je 0/1, nepotrebuje sa odcitavat LVL podla pv
                           xTve^.al.in.val   := BOOL_TO_REAL(xPtB^) * 100.0;
                           IF xTve^.cx.NO THEN
                              xPtB^ := NOT xPtB^;                                   // NO - bez napatia otvorene
                           END_IF;
                       2:  // BOOL 0-1-2-3
                           IF _NhTveOnOff(obr:=1, off:=1, lvl:=xPva^.pv) THEN       // najskor vypne vsetko pritomne a potom zapne len na PV
                              xTve^.al.in.val := xTve^.cx.pvp.pvReQ[ xPva^.pv ];
                           END_IF;
                       3:  // REAL
                           xPtR  := UDINT_TO_PTR(xTve^.hw.d[0]);
                           IF xPva^.pv = 0 THEN
                              xPtR^ := 0.0;
                           ELSE
                              xPtR^ := CEIL(xTve^.cx.pvp.pvReQ[ xPva^.pv ]);
                           END_IF;
                           xTve^.al.in.val :=  xPtR^;
                       4:  // REAL-TECO
                           IF xTve^.hw.d[1] > 0 THEN
                           ;
                           END_IF;
                     100:  // prepojenie na technologiu TVE
                     101:  // prepojenie na technologiu REKUPERACIA
                     102:  // prepojenie na technologiu KLIMA

                     END_CASE;
//                     _NhDevRef(xR := xHet);
               ELSE  xDev^.al.el := xDev^.al.el - aSys.n1Sec;
               END_CASE;

           2:  // RESET: podla HW sa akturalizuje sa podla  VAZ-DEV ....
         END_CASE;




         END_IF;


         xDev^.al.LVL   := 0;                                        // pripravi sa na dalsi cyklus, kde sa zbieraju LVL
         IF xDev^.al.IN.val > 0.0 THEN
            xDev^.al.sta := 1;
//            _Nh_Sta_Rom(rom := xDev^.cf.rom, cat := xDev^.cf.cat, x:=-101);    // stav do miestnosti
         ELSE
            xDev^.al.sta         := 0;
         END_IF;
      END_IF;
   END_FOR;

