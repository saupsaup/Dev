{ $ IFDEF __NH_WEB }
                       //********* BRW 200 *******************************************
// 0918188778 jencko

TYPE

  	_Pg200_1 {HIDDEN}:  STRUCT 			
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:= 13, x:= 50     , y:= y1 + 150,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0, cm := 251),
            (wh:= 13, x:= 50     , y:= y1 + 300,   w:= x2-110 , FgC := 4, BgC := 3, fn := 1, cm := 251),
            (wh:= 13, x:= 50     , y:= y1 + 450,   w:= x2-110 , FgC := 4, BgC := 3, fn := 2, cm := 251),
            (wh:= 13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 3, fn := 3, cm := 251),
            (wh:= 20, x:= x2-85  , y:= y1 + 720,   w:= 58     , FgC := 0, BgC :=50, fn := 153),  // Hardware
            (wh:=  0, x:= x2-85  , y:= y1 + 760,   w:= 58     , FgC := 0, BgC :=50, fn := 153)
              // Hardware
                                             )];
      s  : ARRAY[0..5] OF NH_SLD_DAT := [
            (t := 3, xv := x2-53, v2 := 18000.0 , fmt := '1%Tm:ss.z m'   , txt:= 64),        // vykonat oneskorene
            (t := 1, xv := x2-53, v2 := 240.0  , fmt :=  'm%Th:mm h'     , txt:=152),        // Blokovat PIR ovladacom
            (t := 1, xv := x2-53, v2 := 240.0  , fmt :=  'm%Th:mm h'     , txt:=152),        // Blokovat PIR ovladacom
            (t := 3, xv := x2-53, v2 := 1440.0  , fmt := 'm%Th:mm h'     , txt:= 62),        // Max cas zapnutia  0-12h)
            (t := 0,              v2 :=  200.0  , fmt := '%6.1f W'       , txt:= 69)           // PRIKON
            ];

   END_STRUCT;

  	_PgHETr1 {HIDDEN}:  STRUCT 			
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:= 13, x:= 50     , y:= y1 + 150,   w:= x2-110 , FgC := 4, BgC := 2, fn := 0, cm := 251, fmt := '171'),   //cf:=(c:=48,n:=171,p:=60)), // PV-0 (c=velkost obr,n=cislo obr.p= x-posun textu doprava  za obrazok)
            (wh:= 13, x:= 50     , y:= y1 + 300,   w:= x2-110 , FgC := 4, BgC := 8, fn := 1, cm := 251, fmt := '173'),   //cf:=(c:=48,n:=173,p:=60)), // PV 1
            (wh:= 13, x:= 50     , y:= y1 + 450,   w:= x2-110 , FgC := 4, BgC := 6, fn := 2, cm := 251, fmt := '175'),   //cf:=(c:=48,n:=175,p:=60)), // PV 2
            (wh:= 13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 7, fn := 3, cm := 251, fmt := '177'),   //cf:=(c:=48,n:=177,p:=60)), // PV 3
            (wh:=  0, x:= 50     , y:= y1 + 700,   w:= x2-110 , FgC := 4, BgC := 3, fn := 4, cm := 251, fmt := '123'),   //cf:=(c:=48,n:=123,p:=60)), // LVL
            (wh:=  6, x:= x2/2   , y:= y1 + 40,    w:= 400    , FgC := 3, BgC := 0, fn := 2, h :=28, cf :=(c:=0,n:=159)),          // 'Predvolby teploty'
            (wh:=  0, x:= x2/2   , y:= y1 + 40,    w:= 400    , FgC := 3, BgC := 0, fn := 2, h :=28, cf :=(c:=0,n:=160)),          // 'Predvolby výstupu k teplote'
            (wh:=  0, x:= x2/2   , y:= y1 + 40,    w:= 400    , FgC := 3, BgC := 0, fn := 2, h :=28, cf :=(c:=0,n:=161))           // 'Rozdiel teplot'
                                              )];

   END_STRUCT;

  	_PgHETs1 {HIDDEN}:  STRUCT 			
      s  : ARRAY[0..4] OF NH_SLD_DAT := [
            (        xv := x2-53, v2 := 35.0 , fmt := '%5.1f°',  ink := 0.1   , txt:= 154 ),       // teplota PV-1
            (        xv := x2-53, v2 := 35.0 , fmt := '%5.1f°',  ink := 0.1   , txt:= 155),        // teplota PV-2
            (        xv := x2-53, v2 := 35.0 , fmt := '%5.1f°',  ink := 0.1   , txt:= 156),        // teplota PV-3
            (        xv := x2-53, v2 := 35.0 , fmt := '%5.1f°',  ink := 0.1   , txt:= 157),        // teplota PV-4
            (t:=0,   xv := x2-53, v2 := 100.0, fmt := '%5.0f %%',ink := 1.0   , txt:= 158)         // skutocna uroven otvorenia
                                              ];
   END_STRUCT;

  	_PgHETr2 {HIDDEN}:  STRUCT 			
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:= 13, x:= 50     , y:= y1 + 150,   w:= x2-110 , FgC := 4, BgC := 2, fn := 0, cm := 251, fmt := '193'),   // OFF
            (wh:= 13, x:= 50     , y:= y1 + 300,   w:= x2-110 , FgC := 4, BgC := 8, fn := 1, cm := 251, fmt := '173'),   // PV 1
            (wh:= 13, x:= 50     , y:= y1 + 450,   w:= x2-110 , FgC := 4, BgC := 6, fn := 2, cm := 251, fmt := '175'),   // PV 2
            (wh:= 13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 7, fn := 3, cm := 251, fmt := '177'),   //PV 3
            (wh:=  0, x:= 50     , y:= y1 + 700,   w:= x2-110 , FgC := 4, BgC := 3, fn := 4, cm := 251, fmt := '123'),   // // LVL
            (wh:=  6, x:= x2/2   , y:= y1 + 40,    w:= 400    , FgC := 3, BgC := 0, fn := 2, h :=28, cf :=(c:=0,n:=160)),          // 'Predvolby teploty'
            (wh:=  0, x:= x2/2   , y:= y1 + 40,    w:= 400    , FgC := 3, BgC := 0, fn := 2, h :=28, cf :=(c:=0,n:=160)),          // 'Predvolby výstupu k teplote'
            (wh:=  0, x:= x2/2   , y:= y1 + 40,    w:= 400    , FgC := 3, BgC := 0, fn := 2, h :=28, cf :=(c:=0,n:=161))           // 'Rozdiel teplot'
                                              )];

   END_STRUCT;

  	_PgHETs2 {HIDDEN}:  STRUCT 			
      s  : ARRAY[0..4] OF NH_SLD_DAT := [
            (        xv := x2-53,  fmt := '%5.0f %%',  ink := 1.0   , txt:= 176 ),       // teplota PV-1
            (        xv := x2-53,  fmt := '%5.0f %%',  ink := 1.0   , txt:= 154),        // teplota PV-2
            (        xv := x2-53,  fmt := '%5.0f %%',  ink := 1.0   , txt:= 156),        // teplota PV-3
            (        xv := x2-53,  fmt := '%5.0f %%',  ink := 1.0   , txt:= 165),        // teplota PV-4
            (t:=0,   xv := x2-53,  fmt := '%5.0f %%',  ink := 1.0   , txt:= 158)         // skutocna uroven otvorenia
                                              ];
   END_STRUCT;


  	_PgTVE {HIDDEN}:  STRUCT 			      // WSB/TLA
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:= 10, x:= 120    , y:= y1 + 130,   w:= 180  , h := 1, FgC := 1, BgC := 8, fn := 103, cm := 252)                       // obrazok WSB

               )];

      s  : ARRAY[0..3] OF NH_SLD_DAT := [
            (t := 1, v2 := 20.0    , fmt := '1%Ts.zz s'     , txt:= 77),         // Dalsi click
            (t := 1, v2 := 25.0    , fmt := '1%Ts.zz s'     , txt:= 78),         // Press
            (t := 1, v2 := 50.0    , fmt := '1%Ts.zz s'     , txt:= 79)          // Hold

          ];

      sLed  : ARRAY[0..2] OF NH_SLD_DAT := [
            (t := 1, v2 :=  8.0    , fmt := '%1.0f'         , txt:= 136),        // Pocet LED
            (t := 1, v2 :=100.0    , fmt := '%3.0f %%'      , txt:= 137),        // svietivost LED
            (t := 1, v2 :=255.0    , fmt := '%3.0f s'       , txt:= 139)         // Uspat LED po case
                                              ];
   END_STRUCT;


   _Pg200_LUX {HIDDEN} : STRUCT
      r : ARRAY[1..7] OF NH_ROW_O := [( ob := [
         (wh:= 21, x:= 50 , y:= y1 +  90, h := 28, w:= 30 , Fn := 0, FgC := 4, BgC := 5, cf :=(c := 0, n:=132)), // Hodnota zo snimaca
         (wh:= 13, x:= 50 , y:= y1 + 220, w:= x2-110,h:=250,fn := 1, FgC := 4, BgC := 3, cm := 251),             // hodnota tma
         (wh:= 13, x:= 50 , y:= y1 + 350, w:= x2-110,h:=250,fn := 2, FgC := 4, BgC := 3, cm := 251),             // hodnota svetlo
         (wh:= 21, x:= 50 , y:= y1 + 450, h := 28, w:= 30 , fn := 3, FgC := 4, BgC := 5, cf :=(c := 0, n:=133)), // % Osvetlenie
         (wh:= 13, x:= 50 , y:= y1 + 600, w:= x2-110,h:=250,fn := 4, FgC := 4, BgC := 3,  cm := 251),            // koeficien na luxy
         (wh:= 21, x:= 50 , y:= y1 + 690, h := 28, w:= 30 , Fn := 5, FgC := 4, BgC := 5, cf :=(c := 0, n:=149)), // intenzita v luxoch
         (wh := 0)
                  )];
      s :  ARRAY[0..6] OF NH_SLD_DAT := [
         (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%6.0f'        , txt := 1, xv := x2-53,  ),
         (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%6.0f'        , txt:= 130, tun := 1, zom := 1,ink := 1.0 ),     // Hodnota tma
         (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%6.0f'        , txt:= 131, tun := 1, zom := 1,ink := 1.0 ),     // Hodnota svetlo
         (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%6.0f %%'     , txt := 1,  xv := x2-53 ),                       // % osvetlenia txt znamena formatovanie z prava do lava vo vypise
         (t := 0, v1 := 1.0,    v2 := 600.0   , fmt := '%6.1f'        , txt:= 148, zom := 1, ink := 0.1),               // koeficient na luxy
         (t := 0, v1 := 0.0,    v2 := 65000.0 , fmt := '%7.0f lx'     , txt := 1,  xv := x2-53)                         // vypis luxov
                ];
   END_STRUCT;


 	_Pg200_4 {HIDDEN}:  STRUCT 			
      r  : ARRAY[1..3] OF NH_ROW_O :=
         [( ob := [
            (wh:=255, x:= xc-5   , y:= y1 + 290,   w:= 500, fn := 126),      // RGB obrazok 6/1

            (wh:=8, x:= 45     , y:= y1 + 115,   w:= 48 , fn := 2, prs:=1),                // PV-1
            (wh:=8, x:= 45     , y:= y1 + 50,    w:= 48 , fn := 2, prs:=1),                //
            (wh:=8, x:= 110    , y:= y1 + 50,    w:= 48 , fn := 2, prs:=1),                //

            (wh:=8, x:= 450    , y:= y1 + 50,    w:= 48 , fn := 2, prs:=1),                //
            (wh:=8, x:= 520    , y:= y1 + 50,    w:= 48 , fn := 2, prs:=1),                //
            (wh:=8, x:= 520    , y:= y1 + 115,   w:= 48 , fn := 2, prs:=1),                //

            (wh:=8, x:= 520    , y:= y1 + 475,   w:= 48 , fn := 2, prs:=1),                //
            (wh:=8, x:= 520    , y:= y1 + 540,   w:= 48 , fn := 2, prs:=1),                //
            (wh:=8, x:= 450    , y:= y1 + 540,   w:= 48 , fn := 2, prs:=1)               // PV-9
            ]),
             ( ob := [
            (wh:=13, x:= 50     , y:= yy2 -190,   w:= x2-200 , FgC := 7, BgC := 7, fn := 0, h := 8),    // R
            (wh:=13, x:= 50     , y:= yy2 -120,   w:= x2-200 , FgC := 8, BgC := 8, fn := 1, h := 8),    // G
            (wh:=13, x:= 50     , y:= yy2 - 50,   w:= x2-200 , FgC := 9, BgC := 9, fn := 2, h := 8)     // B
            ]),
             ( ob := [
            (wh:=  0, x:= 50     , y:= yy2 -100,   w:= x2-130 , FgC := 4, BgC := 3, fn := 3, h := 7),   // jas
            (wh:=  8, x:= 65     , y:= y1 + 515,  w:= 92, fn := 2  )                                    // vysledna farba                      1/2
                                             )];
      s  : ARRAY[0..3] OF NH_SLD_DAT := [
            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 ),        // R
            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 ),        // G
            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 ),        // B
            (t := 1, v2 := 100.0  , fmt := '%5.0f %%'  , txt:= 66, zom := 0)        // JAS
                                              ];
   END_STRUCT;


(*
  	_Pg200_5 {HIDDEN}:  STRUCT 			      // WSB/TLA
      r  : ARRAY[1..2] OF NH_ROW_O :=
         [( ob := [
            (wh:= 10, x:= 110    , y:= y1 + 130,   w:= 190   , FgC := 1, BgC := 8, fn := 102, cm := 251),                       // obrazok WSB
            (wh:=  8, x:= 260    , y:= y1 + 95,    w:= 70    , FgC := 1, BgC := 8, fn := 3, cf :=(c:=1,p:=35),fmt:='1' ),              // text 'Click'
            (wh:=  8, x:= 325    , y:= y1 + 95,    w:= 70    , FgC := 4, BgC := 0, fn := 3, cf :=(p:=35),fmt:='2' ),             // 2
            (wh:=  8, x:= 390    , y:= y1 + 95,    w:= 70    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='3' ),             // 2
            (wh:=  8, x:= 455    , y:= y1 + 95,    w:= 70    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='4' ),             // 2
            (wh:=  8, x:= 520    , y:= y1 + 95,    w:= 70    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='5' ),             // 2
            (wh:=  8, x:= 290    , y:= y1 +180,    w:= 90    , FgC := 8, BgC := 0, fn := 3, cf :=(p:=35),fmt:='Push' ),             // 2
            (wh:=  8, x:= 460    , y:= y1 +180,    w:= 90    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='Hold' ),             // 2
            (wh:=  0, x:= 80     , y:= y1 +330,    w:= x2-160, FgC := 2, fn := 2, ntch:=1),                                       // ciara
            (wh:=  0, x:= xc     , y:= y1 +290,                FgC := 4, fn := 2),                                              // ciara
            (wh:= 23, x:= 120    , y:= y1 +400,    w:= x2-50-120 , FgC := 8, BgC := 2, fn := 64,h:=33, cf :=(c:=4), cm := 251)                       // akcie od btn
            ]),
          ( ob := [
            (wh:= 13, x:= 50     , y:= y1 + 220,   w:= x2-130 , FgC := 4, BgC := 3, fn := 0, cm := 251, h:=0 ),                               // cakanie dalsi click
            (wh:= 13, x:= 50     , y:= y1 + 420,   w:= x2-130 , FgC := 4, BgC := 3, fn := 1, cm := 251, h:=0),                               // stlacenie
            (wh:= 13, x:= 50     , y:= y1 + 600,   w:= x2-130 , FgC := 4, BgC := 3, fn := 2, cm := 251, h:=0),                               // dlhe podrzanie
            (wh:= 20, x:= x2-80  , y:= y1 + 700,   w:= 62     , FgC := 4, BgC :=50, fn := 100),                                        		// Zablokovat (bypas)
            (wh:= 20, x:= x2-80  , y:= y1 + 780,   w:= 62     , FgC := 0, BgC :=50, fn := 418)                                         		// TG2
(*
            (wh:= 13, x:= 50     , y:= y1 + 150,   w:= x2-130 , FgC := 4, BgC := 3, fn := 0           , cm := 251),                    // pocet LED
            (wh:= 13, x:= 50     , y:= y1 + 300,   w:= x2-130 , FgC := 4, BgC := 3, fn := 1           , cm := 251),                    // Jas LED napatie pre led 0-20 (0-2V)
            (wh:= 20, x:= 240    , y:= y1 + 400,   w:= 58     , FgC := 1, BgC :=50, fn :=138, h := 68, cf :=(c := 4 )   , cm := 252 ),      // Uspat LED : DayModeObr
            (wh:= 13, x:= 50     , y:= y1 + 550,   w:= x2-130 , FgC := 4, BgC := 3, fn := 2           , cm := 251),                    // Uspat LED po case
            (wh:= 20, x:= x2-85  , y:= y1 + 650,   w:= 58     , FgC := 0, BgC :=50, fn :=140, h :=  0,  cf :=(c := 0 ), cm := 252 ),       // Zamenit LED R-G (ceck on-OFF)

            (wh:= 0, x:= x2-85  , y:= y1 + 80,    w:= 58     , FgC := 0, BgC :=50, fn :=61, h :=  0,  cf :=(c := 0 ), cm := 252 )       // Zamenit LED R-G (ceck on-OFF)

          ])];


      sClk  : ARRAY[0..3] OF NH_SLD_DAT := [
            (t := 1, v2 := 20.0    , fmt := '1%Ts.zz s'     , txt:= 77),         // Dalsi click
            (t := 1, v2 := 25.0    , fmt := '1%Ts.zz s'     , txt:= 78),         // Press
            (t := 1, v2 := 50.0    , fmt := '1%Ts.zz s'     , txt:= 79)          // Hold

          ];

      sLed  : ARRAY[0..2] OF NH_SLD_DAT := [
            (t := 1, v2 :=  8.0    , fmt := '%1.0f'         , txt:= 136),        // Pocet LED
            (t := 1, v2 :=100.0    , fmt := '%3.0f %%'      , txt:= 137),        // svietivost LED
            (t := 1, v2 :=255.0    , fmt := '%3.0f s'       , txt:= 139)         // Uspat LED po case
                                              ];
   END_STRUCT;
*)

  	_Pg200_9 {HIDDEN}:  STRUCT 			
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
               (wh:= 20, x:= x2-80,  y:= y1 + 100,   w:= 62     , FgC :=  0, BgC :=50, fn := 101),   // Signal je pri rozopnuti
               (wh:= 20, x:= x2-80,  y:= y1 + 200,   w:= 62     , FgC :=  0, BgC :=50, fn := 102),   // Vyvaznenie 1 tamperom
               (wh:= 20, x:= x2-80,  y:= y1 + 300,   w:= 62     , FgC :=  0, BgC :=50, fn := 103),   // Vyvaznenie 2 tampermi
               (wh:= 13, x:= 50    , y:= y1 + 500,   w:= x2-130 , FgC :=  4, BgC :=3, fn := 0, cm := 251),
//               (wh:= 13, x:= 50    , y:= y1 + 600,   w:= x2-130 , FgC :=  4, BgC :=3, fn := 1, cm := 251),
               (),
               (wh:= 20, x:= x2-80,  y:= y1 + 600,   w:= 62     , FgC :=  4, BgC :=50, fn := 100),   // Zablokovat (bypas)
               (wh:= 20, x:= x2-80,  y:= y1 + 680,   w:= 62     , FgC :=  0, BgC :=50, fn := 227),   // LogEvn
               (wh:= 20, x:= x2-80,  y:= y1 + 760,   w:= 62     , FgC :=  0, BgC :=50, fn := 228),   // LogAct
            ()
                                             )];
      s  : ARRAY[0..0] OF NH_SLD_DAT := [
               (t := 1, v1:=  0.0, v2 := 50.0      , fmt := '%3.0f'   , txt:= 104)      // Filer na pocet cyklov
//               (t := 1, v1:=  0.0, v2 := 100.0     , fmt := '%3.0f'   , txt:= 104)        // Filer pre unlock / svetlo
                                              ];
   END_STRUCT;

  	_PgHETp {HIDDEN}:  STRUCT 			
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:= 13, x:= 50     , y:= y1 + 350,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0, cm := 251, cf:=(c:=48,n:=121,p:=60) ),
            (wh:=  0, x:= x2-85  , y:= y1 + 500,   w:= 58     , FgC := 0, BgC :=50, fn := 64, h :=  0,  cf :=(c := 0 ), cm := 252 )  // Pohyb resetuje Max.èas
                                             )];
      s  : ARRAY[0..0] OF NH_SLD_DAT := [
            (t := 1, xv := x2-53, v2 := 24.0 , fmt := 's%Th:mm h'   , txt:= 61)        // trvaie v hod
                                              ];
   END_STRUCT;



END_TYPE

VAR_GLOBAL CONSTANT
(*
   ePg_CHK    :  _PgHETr1 :=(
               r := [( ob := [
                  (wh:=  0, x:= x2/2   , y:= y1 +100,    w:= 28         , FgC := 3, BgC := 0, fn := 2, h :=30, cf :=(c:=0,n:=184)),       // nejaky vystredney text
                  (wh:= 23, x:= 50    , y:= y1 +200,    w:= x2-50-120  , FgC := 8, BgC := 2, fn := 64,h:=30, cf :=(c:=3)),               // prepinac
                  (wh:=0),
                  (wh:=0),
                  (wh:=0),
                  (wh:=0)
                              )]);

   ePg200_2 : _Pg200_1 := (
               r := [( ob := [
                  (h :=7),
                  (),
                  (),
                  (wh:=0),
                  ()
                  )],
                s :=  [
                  (t := 1, v2 := 100.0   , fmt := '%5.0f %%'     , txt:= 66),        // JAS
                  (t := 1, v2 := 10.0    , fmt := '%4.0f'        , txt:= 67),        // RAMPA ON
                  (t := 1, v2 := 10.0    , fmt := '%4.0f'        , txt:= 68)         // RAMPA OFF
                     ]);



   ePg_PWR : _Pg200_1 := (          // parametre DEV prikon, stmievatelne min,max, max.cas zapnutia
               r := [( ob := [
                  (wh:= 13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0),         // MAx.cas zopnutia
                  (y:=y1+150),                                                         // Cas blokovania pir
                  (y:=y1+300,                                       ),                 // Stmiev.minimum
                  (y:=y1+420,wh:=13                                 ),                  // Efektivne maximum
                  (wh:=20,y:= y1 + 670, fn := 106),
                  (wh:=20,y:= y1 + 740, fn := 100)
                  )],
            s :=  [
                (t := 3, xv := x2-53, v2 := 1440.0  , fmt := 'm%Th:mm h'     , txt:= 62),        // Max cas zapnutia  0-12h)
                (t := 0, v2 :=  200.0  , fmt := '%6.1f W'          , txt:= 69),        // PRIKON
                (t := 1, v2 := 100.0    , fmt := '%3.0f %%'        , txt:= 70),        // Stmiev.minimum
                (t := 1, v2 := 100.0    , fmt := '%3.0f %%'        , txt:= 71)         // Efektivne maximum
                     ]);

  	ePg200_3a  {HIDDEN}: _Pg200_1 := (              // parametre zazinania analogoveho svetla     			
               r := [( ob := [
                  (                                    ),                    // Opozdené zažatie
                  (                                      ),                    // zažatie po dlhom vypnuti
                  (                                             ),                          // Kratke
                  (wh:=13                                       ),                          // Dlhe vypnutie trva
                  (wh:=0 )
                  )],

            s  := [
               (t := 1, v2 := 100.0    , fmt := '5%Ts.zz s'    , txt:= 145),                    // Opozdené zažatie
               (t := 1, v2 := 200.0    , fmt := '5%Ts.zz s'    , txt:= 146),                    // Zažatie po vypnutí
               (t := 1, v2 := 100.0    , fmt := '1%Ts.z s'     , txt:= 63),                       // kratke Vypnutie je po
               (t := 1, v2 := 59.0     , fmt := 'm%Tm m'       , txt:= 147)                        // dlhe Vypnutie je po
                     ]);

   ePg200_4 : _Pg200_4;          // RGB
//   ePg200_5 : _Pg200_5;
   ePg200_8 : _Pg200_1 := (
                r := [( ob := [
               (wh:= 13, x:= 50    , y:= y1 + 150,   w:= x2-130 , FgC := 4, BgC := 3, fn := 0, cm := 251),
               (wh:= 17, x:= x2-80 , y:= y1 + 280,   w:= 62 , Fn := 73, h:=405, FgC := 2, BgC :=  0, cf :=(c := 1, n:=91), cm := 252), // Neurèený spotrebiè
               (wh:= 17, x:= x2-80 , y:= y1 + 360,   w:= 62 , Fn := 62, h:=406, FgC := 2, BgC :=  1, cf :=(c := 0, n:=92), cm := 252), // Svetlo
               (wh:= 17, x:= x2-80 , y:= y1 + 440,   w:= 62 , Fn := 61, h:=404, FgC := 2, BgC :=  3, cf :=(c := 0, n:=93), cm := 252), // Ohrievaè/klíma
               (wh:= 17, x:= x2-80 , y:= y1 + 520,   w:= 62 , Fn := 50, h:=400, FgC := 2, BgC :=  2, cf :=(c := 0, n:=94), cm := 252), // El.Okruh(stykaè)
               (wh:= 17, x:= x2-80 , y:= y1 + 600,   w:= 62 , Fn :=159, h:=160, FgC := 2, BgC := 26, cf :=(c := 0, n:=95), cm := 252), // Nabíjacia stanica
               (wh:= 16, x:= x2-80,  y:= y1 + 710,   w:= 52     , FgC := 3, h := 25, cm := 252, fn := 1)                               // Inverzné relé (OFF=ON)
                  )],
                s :=  [
               (t := 0, v2 := 2500.0   , fmt := '%6.1f W'      , txt:= 69),        // PRIKON
               (t := 4, v2 := 38.0, v1:= 35.0, xv := 50        , txt:= 96)         // Inverzné relé (OFF=ON)
                  ]);

   ePg200_9       : _Pg200_9;               // PIR


   ePg200_TER: _Pg200_1 := (             // TER
                r := [( ob := [
               (y:= y1 +  250,h:=250),                                                                  // slidre sa nezmenia
               (y:= y1 +  400,h:=250),
               (y:= y1 +  550,h:=250),
               (wh :=21, x:= 50 ,    y:= y1 +  80,   w:= 30,h := 28, Fn :=   3, FgC := 5, BgC := 5, cf :=(c := 0, n:=120)),   // teplota po korekcii
               (wh:= 20, x:= x2-85,  y:= y1 + 750,   w:= 62,         FgC :=  4,    BgC :=50, fn := 100)                // Zablokovat PIR


                  )],
                s :=  [
                (t := 0, v1:= -50.0,   v2 := 50.0    , fmt := '%+4.1f °C' , txt:= 119, tun := 1,zom := 1, ink := 0.1 ),           // Korekcia teploty
                (t := 0,               v2 := 5.0     , fmt := '%5.2f °C'     , txt:= 121,zom := 1, ink :=0.05),                  // Povolena zmena
                (t := 1,               v2 := 255.0   , fmt := '%3.0f'        , txt:= 122),                                       // Filter
                (t := 0,v1:=-200,      v2 := 200.0   , fmt := '%4.1f °C'  , txt :=   1, xv := x2-53  )                          // korigovana teplota

                     ]);
                  // xO^.fn      :  cislo slidera, kde je adresa hodnoty a format
                  // xO^.cf.c    :  formatovanie textu 0...4
                  // xO^.t       :  vyska textu - popis
                  // xO^.w       :  vyska textu - hodnota
                  // xO^.FgC     :  farba textu - popis
                  // xO^.BgC     :  farba textu - hodnota
                  // xO^.cf.n    :  cislo textu - popis


  	ePg200_LUX : _Pg200_LUX; 			



  	ePg200_VEN :  _Pg200_1 := (  			
      r  := [( ob := [
            (wh:= 13, x:= 50     , y:= y1 + 120,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0),      // nastavit vykon
            (wh:= 13, x:= 50     , y:= y1 + 240,   w:= x2-110 , FgC := 4, BgC := 3, fn := 1),      // vypnut po case
            (wh:= 20, x:= x2-85  , y:= y1 + 320,   w:= 58     , FgC := 0, BgC :=50, fn := 55),   // pritomnost resetuje cas
            (wh:= 20, x:= x2-85  , y:= y1 + 390,   w:= 58     , FgC := 0, BgC :=50, fn := 52),     // po case na povodny hodnotu
            (wh:= 13, x:= 50     , y:= y1 + 630,   w:= x2-110 , FgC := 4, BgC := 3, fn := 2),      // vykonat opozdene
            (wh:= 13, x:= 50     , y:= y1 + 750,   w:= x2-110 , FgC := 4, BgC := 3, fn := 3),       // rucne vypnutir blokue PIR
            (wh:= 0, x:= 50     , y:= y1 + 240,   w:= x2-110 , FgC := 4, BgC := 3, fn := 4)
             )],
      s  := [
            (t := 1,              v2 := 100.0   , fmt := '%5.0f %%'     , txt:= 54),               // nastavit vykon na
            (t := 3, xv := x2-53, v2 := 7200.0 , fmt := 's%Th:mm h'    , txt:= 64 ,ink:=60),        // vypnut po case        2h
            (t := 3, xv := x2-53, v2 := 6000.0  , fmt := '1%Tm:ss m'    , txt:= 115,ink:=10),      // vykonat oneskorene
            (t := 1, xv := x2-53, v2 := 120.0   , fmt := 'm%Th:mm h'    , txt:=152),        // Rucne vypnutie blokuje pir
            (t := 1,              v2 := 120.0   , fmt := 's%Tm:ss m'    , txt:= 53)        // zapnut, len ak je pritomnost >
            ]);

*)
END_VAR



FUNCTION _Nh2MnuM {HIDDEN} : BOOL         // nadefinuje spodne menu podla poctu menu a typu jednotliveho menu
   VAR_INPUT
      m  : USINT := 1;     // pocet menu  1-6 [3..8]
      n  : USINT;          // ktore menu nastavit defalt
      t1 : USINT;          // typ menu 1
      t2 : USINT;          // typ menu   END_VAR
      t3 : USINT;          // typ menu
      t4 : USINT;          // typ menu
      t5 : USINT;          // typ menu
      t6: USINT;          // typ menu

   END_VAR
   VAR_TEMP
      t  : USINT;
   END_VAR
   _Nh2MnuM := true;
   FOR i := 3 TO 8 DO
      xU^.o[i].x := _NhTypeMnu.x[m,i];
      CASE i OF
        3 :  t := t1;
        4 :  t := t2;
        5 :  t := t3;
        6 :  t := t4;
        7 :  t := t5;
        8 :  t := t6;
      END_CASE;

//                  rb := _Nh2MnuM(m:=3, n:=1, t1:=21, t2:=22, t3:=23);

      xU^.o[i].fn := _NhTypeMnu.m[t,0];   //USINT_TO_INT(_NhTypeMnu.m[t,0]);
      xU^.o[i].wh := _NhTypeMnu.m[t,1];
      xU^.o[i].cm := INT_TO_USINT(_NhTypeMnu.m[t,2]);
   END_FOR;
   xU^.n := n+2;
END_FUNCTION

FUNCTION _NhObjCfRow {HIDDEN} : BOOL                       // do riadka OBJ dooefinuje viditelnost k SLIDERU a tiez CF
   VAR_INPUT
      r        : USINT := 1;
   END_VAR
   _NhObjCfRow := true;
   xB^.r[ r ].h.nd  := 1;
   xB^.r[ r ].h.cf  := xF^.cf;
//   xIxB^.row.rws    := MAX(xIxB^.row.rws,r);
   FOR j := 0 TO _RowObr DO
      xB^.r[r].o.ob[j].cf := xB^.r[ r ].h.cf;
   END_FOR;
END_FUNCTION


FUNCTION _Nh200row {HIDDEN} : BOOL                       // do riadka OBJ dooefinuje viditelnost k SLIDERU a tiez CF
   VAR_INPUT
      NoCf     : BOOL;
      NoCfo    : BOOL;
      r        : USINT := 1;
   END_VAR
   _Nh200row := true;
   xB^.r[ r ].h.nd  := 1;
   IF NoCf = false THEN
      xB^.r[ r ].h.cf  := xF^.cf;
      xIxB^.row.rws    := MAX(xIxB^.row.rws,r);
      FOR j := 0 TO _RowObr DO
         xO := ADR(xB^.r[r].o.ob[j]);
         rb := true;
         CASE xO^.wh OF
            13 :
                  IF xL^.vis THEN
                     xO^.h    :=  7;                                                 // DEV sa aj rozviecuje
                  ELSE
                     xO^.h    :=  0;                                                 // DEV sa aj rozviecuje
                  END_IF;

            20 : rb := false;                                           // nevklada sa CFG DEV
         END_CASE;
         IF rb AND NoCfo = false THEN
            xO^.cf := xB^.r[ r ].h.cf;
         END_IF;
      END_FOR;
   END_IF;
END_FUNCTION

FUNCTION _NhBrw200 {HIDDEN}   : BOOL     // vlastnosti
   VAR_TEMP
      NewFRM      : USINT ;
      r           : USINT := 1;
      click       : USINT;
   END_VAR
   VAR_TEMP
      cmx         : USINT;
   END_VAR
   _NhBrw200   := true;

RETURN;

//   aSys.cnt    := aSys.cnt + 1;
   _NhxCfg(c := xF^.cf.c, n := xF^.cf.n, par := true, p := xF^.cf.p, x:=21 );
   IF xM^.wht >= 20 THEN                                                                   // nadefinovanie objektovstrany
      IF xM^.wht = 30 THEN                                                                   // nadefinovanie objektovstrany
         xA^.tch.cm        := xU^.o[ xU^.n ].cm;
         xL^.dsh           := 0;
         xM^.wht           := 0;
         _NheBrw( wht:= 5 );                                              // vycisti sa cely BRW

      ELSIF xM^.wht = 20 THEN
         xL^.dsh           := 0;
         xM^.wht           := -1;
         _NheBrw( wht:= 5 );                                              // vycisti sa cely BRW
         xB^.r[0].h.cf := yIO;                                             // tu je ulozeny opacny DEV z vazby
      ELSIF xM^.wht = 25 THEN                                        // len refresh uz nadefinovanych objektov
         ;
      END_IF;

      IF xA^.tch.cm = 200 THEN
         xA^.tch.cmd := 0;
         CASE xF^.cf.c OF                                           // podla CFG nadefinuje menu
            1:
               xU^ := eMn101; xU^.n := 6;                            // ROM
               xU^.o[3].fn := 0;
               xU^.o[6].cm := 100; xU^.o[6].fn := 139; xU^.o[6].wh := 86;


            3: // nieco z HOME screen
               CASE xF^.rom OF
                 199:   // zmena DayOfWeek
                        rb := _Nh2MnuM(m:=2, n:=1, t1:=15,t2:=26);
               ELSE
               ;
               END_CASE;

            4: xU^ := eMn102; xU^.n := 5;
               xU^.o[6].cm :=150;

           10: xU^ := eMn102; xU^.n := 5;                               // SVD

           11: xU^ := eMn104; xU^.n := 5;                               // SVA
               IF xL^.vaz = 15 THEN
                  xU^.n  := 4;
               END_IF;

           12: xU^ := eMn105; xU^.n := 5;                               // RGB
               IF xL^.vaz = 15 THEN
                  xU^.n  := 4;
               END_IF;

           13: // WSB
               IF xB^.r[0].h.cf.c > 0 AND xB^.r[0].h.cf.c <> xF^.cf.c then
                  rb := _Nh2MnuM(m:=3, n:=1, t1:=21, t2:=22, t3:=23);                //play/Led/Setup       33, 34,  5
               ELSE
                  rb := _Nh2MnuM(m:=2, n:=1, t1:=22, t2:=23);                         //Led/Setup
                  xU^.o[1].frm      := 39;
               END_IF;

           14: xU^ := eMnTLA; xU^.n := 4;                            // prednastavi setup
               IF xB^.r[0].h.cf.c > 0 AND xB^.r[0].h.cf.c <> xF^.cf.c THEN                          // vazba
                  xU^.n := 3;
               END_If;
               xA^.tch.obj := 0;

(*

           14: xU^ := eMnWSB; xU^.n := 5;                            // prednastavi setup
               IF xF^.cf.n <> xF^.cf.p THEN                          // vazba
                  xU^.n := 3;
               END_If;
               xA^.tch.obj := 0;
*)
(*
           15: xU^ := eMn101; xU^.n := 6;  xU^.o[6].cm := 9;                         // parameter je ten isty ako CF - zobrazi sa len setup

           16: xU^ := eMn101; xU^.n := 6;  xU^.o[6].cm := 17;        // TER
           17: xU^ := eMn101; xU^.n := 6;  xU^.o[6].cm := 17;        // TEH
           18: xU^ := eMn101; xU^.n := 6;  xU^.o[6].cm := 17;        // TEK


           19: xU^ := eMn102;                                        // LUX
               xU^.o[5].fn := 83; xU^.o[5].wh := 84; xU^.o[5].cm := 18;
               xU^.n := 6;  xU^.o[6].cm := 19;        // LUX

           21: xU^ := eMn102; xU^.n := 5;                               // SVD
           31: // ROL
               _Nh2MnuM(m:=6, n:=1, t1:=18, t2:=10, t3:=16, t4:=20, t5:=19, t6:=17);  //  tun/hand/wind.a/sun.a/set/kalib
           35: // BLK
               rb := _Nh2MnuM(m:=1, n:=1,t1:=5);  //tune
           37: // BRA
               _Nh2MnuM(m:=2, n:=1, t1:=18, t2:=24);  //  tun/hand/wind.a/sun.a/set/kalib
           40: // TGL
               IF xB^.r[0].h.cf.c > 0 AND xB^.r[0].h.cf.c <> xF^.cf.c then
//                  rb := _Nh2MnuM(m:=6, n:=1, t1:=21, t2:=22, t3:=27, t4:=28, t5:=23, t6:=31);         //play/Led/Setup/ROM       33, 34,  5
                  rb := _Nh2MnuM(m:=5, n:=1, t1:=21, t2:=22, t3:=27, t4:=28, t5:=23);         //play/Led/Setup/ROM       33, 34,  5
               ELSE
                  rb := _Nh2MnuM(m:=5, n:=1, t1:=22, t2:=27, t3:=28, t4:=23, t5:=31);                 //Led/Setup/rom
               END_IF;
         ELSE

               IF (xF^.cf.c > 6 AND xF^.cf.c < 10)                         // TVE,KOT,CER
                  OR xF^.cf.c = 23                                         // VEN
               THEN
(*
                  xTve := xDev;
                  xPvA := ADR(xTve^.cx.par.pva);
                  IF xTve^.me.typ < 3 THEN
                     _Nh2MnuM(m:=2, n:= 1, t1:=10, t2:=12);         //man/set
//                  ELSIF xTve^.al.val[100].own THEN
//                     _Nh2MnuM(m:=5, n:= 1, t1:=10, t2:=12, t3:=9, t4:=7, t5:=30 );  //man/set/pv-lvl/teplota
                  ELSE
                     _Nh2MnuM(m:=3, n:= 1, t1:=10, t2:=12, t3:=9);         //man/set/pv-lvl
                  END_IF;
               ELSE
                  xA^.tch.cmd := 31;
                  _NhBrw200   := false;
                  RETURN;
               END_IF;
*)
         END_CASE;
         xA^.tch.cm      :=    xU^.o[ xU^.n ].cm;
//	      xU^.o[2].fn := _NhObrNbr(cf := xF^.cf.c, t := xDev^.cf.typ);     // default obrazok vyssej casti
			_NhTypObr(cf:=xF^.cf.c, typ:=xDev^.cf.typ);
			xU^.o[2].fn := xObrWht^.obr;
         xU^.o[2].cm := 0;
         xU^.o[2].w  := 80;
      END_IF;

      xB^.rw            := 1;
      xR                := ADR(xB^.r[1]);
      xB^.r[ 1 ].h.nd   := 1;
      xB^.r[ 1 ].h.cf   := xF^.cf;

//      xIxB^.row.rws     := MAX(xIxB^.row.rws,1);

      xF^.typ := USINT_TO_SINT(xA^.tch.cm);                          // tu sa prideli cislo v dalsom CASE

      CASE xA^.tch.cm OF
         1: // casy opozdenia,max.zapnutie
//         2: // Level,Ramp
//         3: // Prikon, min,max
//         4: // COLOR
(*
         5: // WSB - priradenie akcie ku Clicku
            pWsb 	:= xPar;
				CASE xF^.cf.c OF
              14:	// TLA
               xTla 	:= xDev;
					xCfc	:= ADR(xTla^.cx.cfc);
            ELSE
               xTgl 	:= xDev;
					xCfc	:= ADR(xTgl^.cx.cfc);
            END_CASE;
               xB^.r[1].o  :=  ePg200_5.r[1];
//               xB^.r[1].o.ob[0].fn := _NhObrNbr(cf := xF^.cf.c, t := xDev^.cf.typ);     // default obrazok vyssej casti
					_NhTypObr(cf:=xF^.cf.c, typ:=xDev^.cf.typ);
					xB^.r[1].o.ob[0].fn := xObrWht^.obr;
               xO          := ADR(xB^.r[1].o.ob[10]);                 // prepinac akcii
               xFmt23   	:= ADR(xO^.fmt);
               CASE xB^.r[0].h.cf.c OF                               // podla vazby vyberie ponuky
                  4: xFmt23^.wht :=40; xO^.cf.c := 6; xO^.x:=70; xO^.y := xO^.y-105;    // SCN
//                  5 : xFmt23^.wht :=28; xO^.cf.c := 2;                        // ACT
                  5:	IF xDev^.cf.typ = 1 THEN											// nove akcie
								xFmt23^.wht :=20; xO^.cf.c := 8;                      // akcie roliet	
							ELSE
								xFmt23^.wht :=99; xO^.cf.c := 6;                      // akcie ostatne
							END_IF;
                  6: xFmt23^.wht := 9; xO^.cf.c := 6; xO^.y := xO^.y - 50;   // HET
                      xcfc^.Click := MAX(xCfc^.Click,3);
                 47: xFmt23^.wht := 9; xO^.cf.c := 6; xO^.y := xO^.y - 50;   // HET
                      xcfc^.Click := MAX(xCfc^.Click,3);

                 11: xFmt23^.wht := 4; xO^.cf.c := 5;                        // aj stmievat
                 42: xFmt23^.wht := 4; xO^.cf.c := 5;                        // aj stmievat
                 43: xFmt23^.wht := 4; xO^.cf.c := 5;                        // aj stmievat
                 44: xFmt23^.wht := 4; xO^.cf.c := 5;                        // aj stmievat
                 12: xFmt23^.wht := 4; xO^.cf.c := 5;
                 30: xFmt23^.wht :=20; xO^.cf.c := 6;                        // MAR
                 31: xFmt23^.wht :=20; xO^.cf.c := 8; xO^.y := xO^.y-125; xO^.x := xO^.x-60;     // ROL
                 37: xFmt23^.wht :=15; xO^.cf.c := 5;                        // BRANA,GARAZ,BRANICKA,ZAVORA
               END_CASE;

         6: // WSB - set parametre (pocet clickov, cakanie )
				CASE xF^.cf.c OF
              14:	// TLA
               xTla 	:= xDev;
					xCfc	:= ADR(xTla^.cx.cfc);
            ELSE
               xWsb 	:= xDev;
					xCfc	:= ADR(xWsb^.cx.cfc);
          	END_CASE;
			   xB^.r[1].h.nd  := 0;                            // vyradi sa prvy riadok
            FOR i := 0 TO 3 DO
               xB^.r[2].o.ob[i]  := ePg200_5.r[2].ob[i];
               xB^.s[i]          := ePg200_5.sClk[i];
            END_FOR;
            xB^.s[0].vb := PTR_TO_UDINT(ADR(xCfc^.Click));
            xB^.s[1].vb := PTR_TO_UDINT(ADR(xCfc^.Press));
            xB^.s[2].vb := PTR_TO_UDINT(ADR(xCfc^.Hold));
            xPtD  := ADR( xB^.r[2].o.ob[3].cf.n) ;
            xPtD^ := PTR_TO_UDINT(ADR(xDev^.cf.blk)) ;                           // bypas
(*
				IF xF^.cf.c = 13 THEN									// wsb ma SW vyhodnotenie Clicku - stare WSB inels
               xB^.r[2].o.ob[4]  := ePg200_5.r[2].ob[4];
	            xPtD  := ADR( xB^.r[2].o.ob[4].cf.n) ;
   	         xPtD^ := PTR_TO_UDINT(ADR(xDev^.cf.inv)) ;   // .inv = Click/pres vyhodnoti SW
				END_IF;
*)
(*
				IF xF^.cf.c = 40 THEN									// wsb ma SW vyhodnotenie Clicku - stare WSB inels
               xTgl 	:= xDev;
               xB^.r[2].o.ob[4]  := ePg200_5.r[2].ob[4];
	            xPtD  := ADR( xB^.r[2].o.ob[4].cf.n) ;
   	         xPtD^ := PTR_TO_UDINT(ADR(xTgl^.cx.cfD.TG2)) ;   // .inv = Click/pres vyhodnoti SW
				END_IF;
*)				
				
//            _Nh200row(r := 2);                              // spristupni sa 2 riadok
(*
         9: // PIR - setup

            xPir := xDev;
            xB^.r[1].o     := ePg200_9.r[1];
            xPtD  := ADR(xB^.r[1].o.ob[0].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xDev^.cf.inv)) ;            // Signal je pri rozopnuti
            xPtD  := ADR(xB^.r[1].o.ob[1].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xPir^.cx.tam1)) ;           // Vyvaznenie 1 tamperom
            xPtD  := ADR(xB^.r[1].o.ob[2].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xPir^.cx.tam2)) ;           // Vyvaznenie 2 tamperom
            xB^.s[0]       := ePg200_9.s[0]; xB^.s[0].vb := PTR_TO_UDINT(ADR(xPir^.cx.funLock));          // filter pre svetlo
//            xB^.s[1]       := ePg200_9.s[1]; xB^.s[1].vb := PTR_TO_UDINT(ADR(xPir^.cx.FilL));          // filter pre PSN

            xPtD  := ADR(xB^.r[1].o.ob[5].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xPir^.cf.blk)) ;           // blokovanie PIR
            xPtD  := ADR(xB^.r[1].o.ob[6].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xPir^.cf.psn)) ;        	//
            xPtD  := ADR(xB^.r[1].o.ob[7].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xPir^.cf.LogAct)) ;        // Logovat aktivitu


        17: // TER

            _Nh200row(r := 1);
            xTer := xDev;
            xB^.r[1].o     := ePg200_TER.r[1];
            xB^.s[0]       := ePg200_TER.s[0]; xB^.s[0].vb := PTR_TO_UDINT(ADR(xTer^.cx.kor));
            xB^.s[1]       := ePg200_TER.s[1]; xB^.s[1].vb := PTR_TO_UDINT(ADR(xTer^.cx.hys));
            xB^.s[2]       := ePg200_TER.s[2]; xB^.s[2].vb := PTR_TO_UDINT(ADR(xTer^.cx.fil));

//            xB^.r[1].o.ob[3].y  := 21;                                                            // zobrazit aktualnu teplotu
            xB^.s[3]       := ePg200_TER.s[3]; xB^.s[3].vb := PTR_TO_UDINT(ADR(xTer^.al.ou.val));         // vysledna teplota


            xPtD           := ADR(xB^.r[1].o.ob[4].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xTer^.cf.blk)) ;           // blokovanie
            xB^.ref  := true;                               // obrazovka sa bude refreshovat



        18: // LUX - povolene odchylky

                  // xO^.cf.n    :  cislo textu - popis
            xLux := xDev;
            xB^.r[1].o     := ePg200_TER.r[1];
            xB^.r[1].o.ob[0].wh  := 0;            // pouzita sablona z TER, toto netreba
            xB^.s[1]       := ePg200_TER.s[1]; xB^.s[1].vb := PTR_TO_UDINT(ADR(xLux^.cx.hys));
            xS := ADR(xB^.s[1]);
            xS^.v2 := 10.;  xS^.fmt := '%5.0f %%'; xS^.ink :=1.0;       // Povolen8 zmena
            xB^.s[2]       := ePg200_TER.s[2]; xB^.s[2].vb := PTR_TO_UDINT(ADR(xLux^.cx.fil));
            xPtD           := ADR(xB^.r[1].o.ob[4].cf.n); xPtD^ := PTR_TO_UDINT(ADR(xLux^.cf.blk)) ;           // blokovanie
            xB^.r[1].o.ob[3].wh  := 0;                                                                   // treti slider netreba, prekresluje blokovanie




        19: // LUX - HW setup

            xLux := xDev;
            xB^.r[1].o     := ePg200_LUX.r[1];
            xB^.s[0]       := ePg200_LUX.s[0]; xB^.s[0].vb := PTR_TO_UDINT(ADR(xLux^.al.in.val));
            xB^.s[1]       := ePg200_LUX.s[1]; xB^.s[1].vb := PTR_TO_UDINT(ADR(xLux^.cx.Dark));
            xB^.s[2]       := ePg200_LUX.s[2]; xB^.s[2].vb := PTR_TO_UDINT(ADR(xLux^.cx.Sun));
//            xB^.s[3]       := ePg200_LUX.s[3]; xB^.s[3].vb := PTR_TO_UDINT(ADR(xLux^.al.ou.val));
            xB^.s[3]       := ePg200_LUX.s[3]; xB^.s[3].vb := PTR_TO_UDINT(ADR(xLux^.al.ou.val));
            xB^.s[4]       := ePg200_LUX.s[4]; xB^.s[4].vb := PTR_TO_UDINT(ADR(xLux^.cx.koef));
            xB^.s[5]       := ePg200_LUX.s[5]; xB^.s[5].vb := PTR_TO_UDINT(ADR(xLux^.me.lux));
            xS := ADR(xB^.s[0]);
            IF xLux^.cf.typ = 1 THEN
               xS^.v1      := 0;  xS^.v2      := 50000;
               xB^.s[1].v1 := 0;  xB^.s[1].v2 := 50000;
               xB^.s[2].v1 := 0;  xB^.s[2].v2 := 50000;
               yTx1                 := '%7.0f lx';
            ELSE
               yTx1                 := '%6.0f';
            END_IF;
            xS^.fmt := yTx1;
            xB^.ref  := true;                               // obrazovka sa bude refreshovat
*)
(*
        20: // TVE - nastroje
            xTve := xDev;

        82: // LED-TGL
            NewFRM            := 82;
            xU^.o[xU^.n].frm  := 0;
//           xA^.tch.cmd       := 82;
  				cmd := 82;

       120: // LED-WSB
            NewFRM            := 120;
            xA^.tch.cmd       := 204;
            xU^.o[xU^.n].frm  := 39;
           _Nh_Shw_FRM();

       122: // LED-TGL
            NewFRM            := 122;
            xU^.o[xU^.n].frm  := 57;
            xA^.tch.cmd       := 204;
           _Nh_Shw_FRM();

       123: // TGL-display
            xTgl := xDev;
            _NhSetObjBrw(wh:=23, ob:=1, txt:=50, y:=y1+150, t := 81, c:= 6, cm:=0, FgC:=8, BgC:=2,  vb:=ADR(xTgl^.cx.cfd.WhtDisp) );

        150: // SCN - parametre kedy je aktivna
               xScn := xDev;
               xB^.r[1].o  := ePg_CHK.r[1];
               xO          := ADR(xB^.r[1].o.ob[1]);                 // prepinac akcii
               xFmt23      := ADR(xO^.fmt);
               xFmt23^.wht := 30; xO^.cf.c := 3;                     // _Typemenu
               xFmt23^.txt := 184;                                   // text : Scena je zapnuta, ked
               xPtD        := ADR( xB^.r[1].o.ob[1].cf.n) ;
               xPtD^       := PTR_TO_UDINT(ADR(xScn^.cf.typ)) ;         // adresa zoznamu DayMode

       198: // Nastavit cas, datum...
*)
      END_CASE;

      xA^.tch.cm := 0;

   END_IF;

IF NewFRM > 0 THEN
   ;
ELSE


   cmx            := 0;                                                         // default commad co sa posle do OUT-dev
//   aSys.cnt       := aSys.cnt + 1;

   GC_Begin(GrData := xCan);

(*
   IF xM^.wht <> 0 THEN                                                          // nadefinovanie objektov strany
       IF xB^.ref  THEN                                                          // obrazovka sa bude refreshovat
         _NhDevRef(xR := xDev);
      END_IF;


      CASE xF^.typ OF

         4: // COLOR - vyber farby
               rb    := false;

         5:    // WSB - akcia PLAY

               xWsb     := xDev;
               pWsb     := xPar;
               // prepinanie btn nad obrazkom
               xO       := ADR(xB^.r[1].o.ob[0]);
               IF xO^.tch THEN
                  pWsb^.bt := pWsb^.bt + 1;
                  xO^.tch  := false;
               END_IF;
               IF pWsb^.bt > SINT_TO_USINT(xWsb^.cf.typ) THEN                 // kontrola na max. pocet BTN
                  pWsb^.bt := 1;
               END_IF;
               xO^.FgC  := pWsb^.bt;                                  // preberie btn
               // zobrazenie a prepinanie nad click+P+H
               FOR i := 1 TO 7 DO
                  xO := ADR(xB^.r[1].o.ob[i]);
                  xO^.BgC := 0;
                  xO^.cf.p := 35;
                  IF xO^.tch OR xB^.r[1].o.ob[1].cf.c = i THEN
                     xO^.FgC := 1;
                     xO^.BgC := 8;
                     xO^.tch := 0;
                     xB^.r[1].o.ob[1].cf.c := i;
                     IF i < 6 THEN
                        yTx1 := 'Click - ';
                     ELSE
                        xO^.cf.p := 26;
//                        xO^.w := 80;
//                        yTx1 := '';
                     END_IF;
//                     yTx1 := CONCAT(yTx1,xO^.fmt,' x');
                  ELSIF i > 1 AND i < 6 AND xWsb^.cx.cfc.Click = 0 THEN
                     xO^.FgC := 1;                                         // cierna
                  ELSIF i = 6 AND xWsb^.cx.cfc.Press = 0 THEN
                     xO^.FgC := 1;                                         // cierna
                  ELSIF i = 7 AND xWsb^.cx.cfc.Hold = 0 THEN
                     xO^.FgC := 1;                                         // cierna
                  ELSIF pWsb^.cm.cmd[i] > 0 THEN
                     xO^.FgC := 8;
                  ELSE
                     xO^.FgC := 2;
                  END_IF;
               END_FOR;
               i     := xB^.r[1].o.ob[1].cf.c;
               xPtD  := ADR(xB^.r[1].o.ob[10].cf.n);
               xPtD^ := PTR_TO_UDINT(ADR(pWsb^.cm.cmd[i])) ;

//               yTx1  := 'Akcia';
//               _NhVal2(txt:=0,xy:=1,x:=xc,y:=380,fmt:=1,Fgt:=1,wt:=33);

         ELSE
            CASE xU^.o[ xU^.n ].cm OF
              13 :   xR                := ADR(xM^.brw.r[1]);
                     xPtD              := ADR(xR^.o.ob[1].cf.n);
                     xPtU              := UDINT_TO_PTR(xPtD^);                   // premenna do ktorej sa ulozicislo volby (musi byt USINT)
                     xBtn8             := ADR(xR^.o.ob[2].fmt) ;                 // check pre zobrazenie
                     xR^.o.ob[2].wh    := 25;                                    // je vidno vuber datumu/case
                     IF xA^.tch.wh = 23 THEN                                     // dotyk nad prepinacom
                        xR^.o.ob[3].wh := 0;                                     // zneviditelni slider
                        xR^.o.ob[2].BgC:= 0;                                     // zmaze zeleny kruh nad dnom
                     END_IF;
                     xBtn8^            := _eBtn8;
                     CASE xPtU^ OF
                       1 : xBtn8^[4]:=1; xBtn8^[5]:=1;                           // po uplynuti casu
                       6 : xBtn8^[1]:=1; xBtn8^[2]:=1; xBtn8^[3]:=1; xBtn8^[4]:=1; xBtn8^[5]:=1;      // k datumu
                     ELSE
                        xR^.o.ob[2].wh   := 0;                 // pri vstupe nebude slider vidiet, len bude nadefinovany
                     END_CASE;

(*
             199 : // Zmena typu dna - z Home screen
                     xR                := ADR(xM^.brw.r[1]);
                     xFmt23            := ADR(xR^.o.ob[3].cf.n);                    // z vyberu menu
                     xFmt23^.txt       := 208;                                   // vratit na kalendar
                     // zobrazenie nazvy typ.dna
                     CASE xHom^.cx.nDay.Day OF                                       // aky den je zobrazeny
                       8 : xR^.o.ob[1].cf.n  := 202;                                 // sviatok
                           xR^.o.ob[3].cf.c  :=  5;                                 // pocet riadkov menu
                           xFmt23^.wht       := 60;                                 // zaciatok menu = riadok  NH_TYPE_MNU (mnu ...)

                       9 : xR^.o.ob[1].cf.n := 203;                                 // party
                           xR^.o.ob[3].cf.c  :=  4;                                 // pocet riadkov menu
                           xFmt23^.wht       := 66;                                 // zaciatok menu = riadok  NH_TYPE_MNU (mnu ...)

                      10 : xR^.o.ob[1].cf.n := 204;                                 // mimo domu
                           xR^.o.ob[3].cf.c  :=  4;                                 // pocet riadkov menu
                           xFmt23^.wht       := 71;                                 // zaciatok menu = riadok  NH_TYPE_MNU (mnu ...)

                      11 : xR^.o.ob[1].cf.n  := 205;                                 // Dovolenka
                           xR^.o.ob[3].cf.c  :=  4;                                 // pocet riadkov menu
                           xFmt23^.wht       := 76;                                 // zaciatok menu = riadok  NH_TYPE_MNU (mnu ...)
                     ELSE
                           xR^.o.ob[1].cf.n  := 201;                                 // Dovolenka
                           xR^.o.ob[3].cf.c  :=  4;                                 // pocet riadkov menu
                           xFmt23^.wht       := 55;                                 // zaciatok menu = riadok  NH_TYPE_MNU (mnu ...)
                           xFmt23^.txt       := 209;                                // prepnut den
                     END_CASE;

                     xPtD              := ADR(xR^.o.ob[3].cf.n);                    // premenna je vo vybere menu
                     xPtU              := UDINT_TO_PTR(xPtD^);                      // premenna do ktorej sa ulozicislo volby (musi byt USINT)
                     xBtn8             := ADR(xR^.o.ob[4].fmt) ;                    // viditelnost je uz v datume
//                     xR^.o.ob[5].wh := 0;                                        // slider je pozmen vypnuty
                     CASE xPtU^ OF
                       3 : xBtn8^[1]:=1; xBtn8^[2]:=1; xBtn8^[3]:=1; xBtn8^[4]:=1; xBtn8^[5]:=1;      // zobrazi sa vsetko
                       6 : xBtn8^[1]:=1; xBtn8^[2]:=1; xBtn8^[3]:=1; xBtn8^[4]:=1; xBtn8^[5]:=1;      // zobrazi sa vsetko
                       5 : xBtn8^[1]:=1; xBtn8^[2]:=1; xBtn8^[3]:=1; xR^.o.ob[5].wh := 0; // po case
                     ELSE
                        xBtn8^         := _eBtn8;
                     END_CASE;
                     IF xA^.tch.wh = 25 THEN                                     // dotyk nad datumom sprisupni slider
                        xR^.o.ob[5].wh := 1;
                     ELSE
                        xR^.o.ob[5].wh := 0;                                     // zneviditelni slider
                        xR^.o.ob[4].BgC:= 0;                                     // zmaze zeleny kruh nad dnom
                     END_IF;
*)
(*
            END_CASE;
         END_CASE;
   END_IF;
*)

   r := 1;
   WHILE r < 5 DO                                                                       // len nenulove objekty (riadky)
      IF xB^.r[ r ].h.nd > 0 THEN
         xR    := ADR(xB^.r[ r ]);

         IF _Nh_Shw_Obj(row:=r) = false THEN
            _NhBrw200 := false;
            EXIT;
         END_IF;
      END_IF;
      r := r + 1;
   END_WHILE;
   rb := _NhShwMnu();


//   { $IFDEF __NH_WRK }
(*
      IF xM^.set THEN
         GC_SetTextstyle(style   := _Nh_Sty[2], GrData := xCan);                         // formatovanie textu zlava do prava
         GC_SetTextSize (size 	:= 18, GrData := xCan);                // vyska textu
         GC_MoveTo      (x := xc , y := ky2-20 , GrData := xCan);
         yTx2  := CONCAT(USINT_TO_STRING(xF^.cf.c),':',INT_TO_STRING(xF^.cf.n),' p:',INT_TO_STRING(xF^.cf.p) );
         GC_WriteText   (text    := yTx2, GrData := xCan);                                  //

         IF xF^.cf.c = 31 THEN    //ROL
            GC_SetTextstyle(style   := _Nh_Sty[0], GrData := xCan);                         // formatovanie textu zlava do prava
            xRol := xDev;

            yTx2  := REAL_TO_STRINGF(xRol^.cx.pLam,'%7.2f');
            GC_MoveTo      (x := 10 , y := ky2-20 , GrData := xCan);
            GC_WriteText   (text    := yTx2, GrData := xCan);                                  //
            yTx2  := REAL_TO_STRINGF(xRol^.cx.yLam,'%7.2f');
            GC_MoveTo      (x := 120 , y := ky2-20 , GrData := xCan);
            GC_WriteText   (text    := yTx2, GrData := xCan);                                  //

            yTx2  := REAL_TO_STRINGF(xRol^.cx.pBli,'%7.2f');
            GC_MoveTo      (x := xc+100 , y := ky2-20 , GrData := xCan);
            GC_WriteText   (text    := yTx2, GrData := xCan);                                  //
            yTx2  := REAL_TO_STRINGF(xRol^.cx.yBli,'%7.2f');
            GC_MoveTo      (x := xc+200 , y := ky2-20 , GrData := xCan);
            GC_WriteText   (text    := yTx2, GrData := xCan);                                  //

            yTx2  := USINT_TO_STRING(xRol^.cx.CMD);
            GC_MoveTo      (x := xc+100 , y := ky2-40 , GrData := xCan);
            GC_WriteText   (text    := yTx2, GrData := xCan);                                  //


         END_IF;
      END_IF;
*)
//   { $END_IF }

   GC_End(GrData := xCan);
END_IF;


END_FUNCTION


{ $ END_IF }



