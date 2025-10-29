{ $ IFDEF __NH_FRM }
TYPE
  	NH_brw_D1_FMT   {HIDDEN}  :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..0] OF NH_OBJ_DAT       :=
         [
      (wh:=6,  x:=x2-90, 	y:=109,     	w:=90,  	h:=26,    fn := 1,  FgC:=6, BgC:=0, cf:=(c:=254),                            ) // vypisanie hodnoty v FMT
         ];
   END_STRUCT;

  	NH_brw_D1_GATE  {HIDDEN}    :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..0] OF NH_OBJ_DAT       :=
         [
      (wh:=1,  x:=120,     y:=109,        w:=48,      fn := 66,            cm:=49,                                         ) // 5 koncovy snimac
         ];
   END_STRUCT;

 	NH_brw_LUX_D1  {HIDDEN}	  :  STRUCT          // LUX,TER,TEH
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/2,    y:=yyr/2+10,   w:=x2-16,   h:=yyr-6,   fn:=10,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=60,      y:=55,         w:=72,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2-30,   y:=40,         w:=150,     h:=28,      fn:=1,   cm:=30,  FgC:=5,                                ), // 2 status, text/zlta
      (wh:=1,  x:=60,      y:=109,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=x2-50,   y:=109,        w:=42,                  fn:=0,   cm:=81,                                         ), // 4 >>
      (wh:=13, x:=220,     y:=109,        w:=270,     h:=7,     	fn:=0,   cm:=251, FgC:=4,  BgC:=2,                       ), // 5 brw
      (wh:=20, x:=125,     y:=109,        w:=48,      h:=48,                        FgC:=4,  BgC:=2,                       ), // 6 Blk
      (wh:=24, x:=175,     y:=109,        w:=48,      h:=48,      fn:=4,            FgC:=0,  BgC:=0, cf:=(c:=1), fmt:='22022151'), // 7 manual
      (wh:=6,	x:=x2-30,	y:=70,			w:=80, 		h:=22,     	fn:=1, 	BgC:=0,FgC:=3,	cf:=(c:=254)							),	// 8 velicina v luxoch
      (wh:=6,  x:=112,     y:=70,         w:=400,     h:=24,                        FgC:=2,           cf:=(c:=252),        ), // 9 ID rom
      (wh:=6,  x:=112,     y:=40,         w:=400,     h:=29,                        FgC:=3,                                )  // 10 DEv
         ];

						// xO^.cf.c	: max pocet obrazkov
						// xO^.cf.n : adresa premennej ... PTR_TO_UDINT
						// xO^.fn 	: typ premennej 0=real,1:usint,4:bool, ktora urcuje obrazok.
						// xO^.fmt	: max 3 cisla obrazkov '512 55 22'

   END_STRUCT;

  	NH_brw_LUX_D2  {HIDDEN}  :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/4,    y:=142,        w:=x2/2-17, h:=yyr*2-13,fn:=20,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=75,      y:=70,         w:=90,                 fn:=291,  cm:=200,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2/2-30, y:=68,         w:=150,     h:=40,     fn:=1,    cm:=30,  FgC:=5,                                ), // 2
      (wh:=1,  x:=50,      y:=225,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=255,     y:=225,        w:=42,                 fn:=0,    cm:=81,                                         ), // 4 >>
      (wh:=13, x:=90,      y:=225,        w:=120,     h:=7,      fn:=1,    cm:=251, FgC:=4,  BgC:=2,                       ), // 5 slider
      (wh:=20, x:=255,     y:=170,        w:=42,                                             BgC:=2,                       ), // 6
      (Wh:=0,  x:=43,      y:=50,         w:=42,      h:=42,      nTch:=1,          FgC:=0,  BgC:=0,                       ), // 7
      (Wh:=0,  x:=118,     y:=50,         w:=42,      h:=42,      nTch:=1,          FgC:=0,  BgC:=0,                       ), // 8 cf:=(c:=1,   p:=9)
      (wh:=6,  x:=30,      y:=170,        w:=180,     h:=24,                        FgC:=2,           cf:=(c:=252),        ), // 9 cf/ID
      (wh:=6,  x:=30,      y:=135,        w:=250,     h:=29,                        FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;
  	NH_brw_LUX_D3  {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/4,    y:=yyr/2+5,    w:=x2/2-17,  h:= yyr-10,fn:=10,  cm:=252, FgC:=1,  BgC := 25                     ), // 0 priprava na oramovanie sirokeho riadka
      (wh:=230,x:=45,      y:=50,         w:=60,                  fn:=291, cm:=200,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2/2-30, y:=100,        w:=100,      h:=35,     fn:=1,   cm:=30,  FgC:=5                                 ), // 2 status, text/biela
      (wh:=1,  x:=45,      y:=100,        w:=38                                                                            ), // 3 favorite
      (wh:=0,  x:=255,     y:=100,        w:=38,                  fn:=0,   cm:=81,  FgC:=4                                 ), // Setup
      (wh:=0,  x:=90,      y:=100,        w:=95,       h :=7,     fn:=2,   cm:=251, FgC:=4,  BgC:=5,                       ), // 5 slider
      (wh:=20, x:=90,      y:=100,        w:=38,                           cm:=249,          BgC:=2                        ), // 6
      (Wh:=0,  x:=28,      y:=30,         w:=32,       h:=32,              nTch:=1, FgC:=0,  BgC:=0,                       ), // 7
      (Wh:=0,  x:=65,      y:=30,         w:=32,       h:=32,              nTch:=1, FgC:=0,  BgC:=0,                       ), // 8
      (wh:=6,  x:=85,      y:=63,         w:=150,      h:=25,                       FgC:=2,                cf :=(c:=252)   ), // ID
      (wh:=6,  x:=85,      y:=35,         w:=150,      h:=25,                       FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;

  	NH_brw_ROM_D1  {HIDDEN}   :  STRUCT          // ROM
      ob       : ARRAY[0..6] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/2,    y:=yyr/2+10,   w:=x2-16,   h:=yyr-6,   fn:=10,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=60,      y:=55,         w:=72,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=234,x:=x2-40,   y:=45,         w:=150,     h:=34,      fn:=1,   cm:=30,  FgC:=5									      ), // 2 default je tplota, ktora sa vlozi do .FN, text/biela
      (wh:=1,  x:=60,      y:=109,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=x2-60,   y:=109,        w:=42,                  fn:=8,   cm:=30,                                         ), // 4 >>
      (wh:=5,  x:=125,     y:=109,        w:=42,     h:=45,       fn:=9,                              							), // 5 list stavov
      (wh:=0,  x:=x2-60,   y:=50,         w:=64,                  fn:=24,  cm:=28			                      				)  // 6 menu setup,LIST,LOck
         ];
      D1_7      : NH_OBJ_4O1;	// := (ok:=[1,1,0,0], crc:=[1,1,0,0], Obr:=[40,40], BgC:=[1,1,1,1], txt:=[0,0,0,0], obr:=[142,131,0,1] );                // 8 = time/blkPIR na dstavom//
      D1_8      : NH_OBJ_4O1 := (obj:=6, ok:=[0,0,0,0], crc:=[0,0,0,1], FgT:= [1,0,4,0], BgC:=[10,5,7,10], txt:=[0,0,0,1], obr:=[0,0,0,0] );                // 8 = time/blkPIR na dstavom
      ob2       : ARRAY[9..10] OF NH_OBJ_DAT       :=
         [
//      (Wh:=0,  x:=80,      y:=38,         w:=38,      h:=38,      nTch:=1,          FgC:=0,  BgC:=0,                       ), // 8  wh:=4
      (wh:=6,  x:=112,     y:=75,         w:=400,     h:=24,                        FgC:=2,           cf:=(c:=251),        ), // 9 ID rom
      (wh:=6,  x:=112,     y:=42,         w:=400,     h:=30,                        FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;


  	NH_brw_ROM_D2  {HIDDEN}  :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/4,    y:=142,        w:=x2/2-17, h:=yyr*2-13,fn:=20,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=75,      y:=70,         w:=90,                 fn:=291,  cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2/2-30, y:=75,         w:=150,     h:=40,     fn:=1,    cm:=30,  FgC:=4,                                ), // 2
      (wh:=1,  x:=50,      y:=225,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=255,     y:=225,        w:=42,                 fn:=8,    cm:=32,                                         ), // 4 >>
      (wh:=0,  x:=90,      y:=225,        w:=80,      h:=7,                cm:=251, FgC:=4,  BgC:=5,                       ), // 5 slider
      (wh:=0,  x:=210,     y:=225,        w:=42,                  nTch:=1,                   BgC:=2,                       ), // 6
      (Wh:=1,  x:=43,      y:=50,         w:=42,      h:=42,      nTch:=1,          FgC:=0,  BgC:=0,                       ), // 7
      (Wh:=1,  x:=118,     y:=50,         w:=42,      h:=42,      nTch:=1,          FgC:=0,  BgC:=0,                       ), // 8 cf:=(c:=1,   p:=9)
      (wh:=6,  x:=30,      y:=170,        w:=250,     h:=24,                        FgC:=2,           cf:=(c:=251),        ), // 9 cf/ID
      (wh:=6,  x:=30,      y:=135,        w:=250,     h:=30,                        FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;
  	NH_brw_ROM_D3  {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/4,    y:=yyr/2+5,    w:=x2/2-17,  h:= yyr-10,fn:=10,  cm:=252, FgC:=1,  BgC := 25                     ), // 0 priprava na oramovanie sirokeho riadka
      (wh:=230,x:=45,      y:=50,         w:=60,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2/2-30, y:=100,        w:=100,      h:=32,     fn:=1,   cm:=30,  FgC:=4                                 ), // 2 status, text/biela
      (wh:=1,  x:=45,      y:=100,        w:=38                                                                            ), // 3 favorite
      (wh:=0,  x:=255,     y:=100,        w:=38,                           cm:=32,  FgC:=4                                 ), // Setup
      (wh:=0, x:=85,       y:=100,        w:=95,       h :=7,              cm:=251, FgC:=4,  BgC:=5,                       ), // 5 slider
      (wh:=0,  x:=210,     y:=100,        w:=38,                           cm:=249,          BgC:=2                        ), // 6 priradenie do skupiny
      (Wh:=1,  x:=28,      y:=30,         w:=32,       h:=32,              nTch:=1, FgC:=0,  BgC:=0,                       ), // 7
      (Wh:=1,  x:=65,      y:=30,         w:=32,       h:=32,              nTch:=1, FgC:=0,  BgC:=0,                       ), // 8
      (wh:=6,  x:=85,      y:=63,         w:=150,      h:=20,                       FgC:=2,                cf :=(c:=251)   ), // ID
      (wh:=6,  x:=85,      y:=35,         w:=150,      h:=30,                       FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;

  	NH_brw_ROM_D4  {HIDDEN}   :  STRUCT          // ROM
      ob       : ARRAY[0..10] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/2,    y:=yyr/2-25,   w:=x2-16,   h:=yyr/2-6, fn:=10,  cm:=0,    FgC:=1,  BgC:=1,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=50,      y:=38,         w:=50,                  fn:=291, cm:=0,                                          ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=1,  x:=x2-45,   y:=38,         w:=50,     h:=35,       fn:=35,  cm:=133,  FgC:=4									      ), // 2 default je tplota, ktora sa vlozi do .FN, text/biela
      (),
      (),
      (),
      (),
      (),
      (),
      (),
      (wh:=6,  x:=100,     y:=35,         w:=400,     h:=28,                        FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;

  	NH_brw_D1_ALL   {HIDDEN} :   STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..4] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/2,    y:=yyr/2+10,   w:=x2-16,   h:=yyr-6,   fn:=10,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=60,      y:=55,         w:=72,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2-50,   y:=50,         w:=64,                           cm:=28,  FgC:=4,                                ), // 2 status, text/biela
      (wh:=1,  x:=60,      y:=109,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=x2-50,   y:=109,        w:=42,                  fn:=23,  cm:=32,                                         )  // 4 SETUP
         ];
   END_STRUCT;

  	NH_brw_D1_SLD   {HIDDEN}  :  STRUCT          // objekty jedneho riadka  			
      ob       : NH_OBJ_DAT       :=
      (wh:=13, x:=125,     y:=109,        w:=350,     h:=7,        fn:=0,        cm:=251, FgC:=4,  BgC:=5,                       ); // 5 slider
   END_STRUCT;


  	NH_brw_D1_NAZ  {HIDDEN}   :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..1] OF NH_OBJ_DAT       :=
         [
      (wh:=6,  x:=112,     y:=70,         w:=350,     h:=25,                        FgC:=2,           cf:=(c:=252),        ), // 9 Nazov miestnosti
      (wh:=6,  x:=112,     y:=38,         w:=350,     h:=30,                        FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;
  	NH_ROW_O_D1 {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       := [
      (wh:=90, x := x2/2,    y:= yyr/2+10,  w:= x2-16,     h:= yyr-6,     fn:=10,                 FgC :=  1,  BgC := 25                         ), // priprava na oramovanie sirokeho riadka
      (wh:=1, x :=  50,     y := 54,       w := 78,                                  cm := 200,                                                ), // znak DEV + vykona prepnutie na vlastnosti
      (wh:=3, x := x2-50,   y := 50,       w := 64,                                  cm :=  28,  FgC :=  4                                     ), // status, text/biela
      (wh:=1, x := 50,      y :=113,       w := 42,                      fn:=42,     cm :=  40,                                                ), // favorite
      (wh:=1, x := x2-50,   y :=109,       w := 40                                                                                             ), // >>  / SETUP
      (         x := 125,     y :=109,       w := 48,       h := 40,                   cm := 251,  Fgc :=  4,  BgC :=  5                         ), // 5  0
      (         x := 190,     y :=109,       w := 48,                                  cm :=  44,              BgC :=  2                         ), // 6  time nad STATUS OBR v sivom kruhy
      (         x := 28,      y := 33,       w := 35,       h := 38,                                                                             ), // 7  // dark / spotrebic
      (         x := 75,      y := 33,       w := 35,       h := 38,                                                                             ), // 8  // day mode
      (wh:=6 ,x := 107,     y := 70,       w := 300,      h := 24,                               FgC :=  2,               cf :=(c := 1, p:= 30)), // 9  Nazov miestnosti/popis Cat
      (wh:=6 ,x := 108,     y := 38,       w := 300,      h := 29,                               FgC :=  3,               cf :=(        p:= 20))                   // 10 Nazov Dev
               ];
   END_STRUCT;
  	NH_ROW_O_D2 {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT      := [
      (wh:=90, x := x2/4,    y :=142,       w:= x2/2-17,  h:= yyr*2-13,   fn:=20,     cm := 252,  FgC :=  1,  BgC := 25                         ), // priprava na oramovanie sirokeho riadka
      (wh:=3, x :=  70,     y := 70,       w := 82,                                  cm := 200,                                                ), // znak DEV + vykona prepnutie na vlastnosti
      (wh:=3, x := 240,     y := 70,       w := 64,                                  cm :=  28,  FgC :=  4,                                    ), // status, text/biela
      (wh:=1, x := 50,      y :=225,       w := 42,                      fn:=42,     cm :=  40,                                                ), // favorite
      (wh:=1, x := 235,     y :=225,       w := 40                                                                                             ), // >>  / SETUP
      (         x := 100,     y :=225,       w := 48,       h := 28,                               Fgc :=  4,  BgC :=  5                         ), // 5  0
      (         x :=   9,     y :=225,       w := 48,                                  cm :=  44,              BgC :=  2                         ), // 6  time nad STATUS OBR v sivom kruhy
      (         x :=  40,     y := 45,       w := 42,       h := 43,                                                                             ), // 7  // dark / spotrebic
      (         x :=  98,     y := 45,       w := 42,       h := 43,                                                                             ), // 8  // day mode
      (wh:=6 ,x :=  30,     y :=175,       w := 300,      h := 25,                               FgC :=  2,               cf :=(c := 1, p:= 17)), // 9  Nazov miestnosti/popis Cat
      (wh:=6 ,x :=  30,     y :=140,       w := 300,      h := 29,                               FgC :=  3,               cf :=(        p:= 15))  // 10 Nazov Dev
               ];
   END_STRUCT;
  	NH_ROW_O_D3 {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT      := [
      (wh:=90, x := x2/4,    y :=yyr/2+5,   w:= x2/2-17,  h:= yyr-10,     fn:=10,     cm := 252,  FgC :=  1,  BgC := 25                         ), // priprava na oramovanie sirokeho riadka
      (wh:=3, x :=  45,     y := 45,       w := 68,                                  cm := 200,                                                ), // znak DEV + vykona prepnutie na vlastnosti
      (wh:=3, x := x2/2-45, y := 45,       w := 64,                                  cm :=  28,  FgC :=  4                                     ), // status, text/biela
      (wh:=1, x := 45,      y :=100,       w := 32,                      fn:=42,     cm :=  40,                                               ), // favorite
      (wh:=1, x := x2-50,   y :=100,       w := 40,                                                                                            ), // >>  / SETUP
      (         x := 105,     y :=100,       w := 40,       h := 28,                               Fgc :=  4,  BgC :=  5                         ), // 5  0
      (         x := 120,     y :=100,       w := 40,                                  cm :=  44,              BgC :=  2                         ), // 6  time nad STATUS OBR v sivom kruhy
      (         x :=  26,     y := 27,       w := 38,       h := 32,                                                                             ), // 7  // dark / spotrebic
      (         x :=  65,     y := 27,       w := 38,       h := 32,                                                                             ), // 8  // day mode
      (wh:=6 ,x :=  85,     y := 60,       w := 100,      h := 18,                               FgC :=  2,               cf :=(c := 1, p:= 16)), // 9  Nazov miestnosti/popis Cat
      (wh:=6 ,x :=  85,     y := 31,       w := 100,      h := 24,                               FgC :=  3,               cf :=(        p:= 15))                   // 10 Nazov Dev
               ];
   END_STRUCT;
  	NH_brw_SLD_D1   {HIDDEN}   :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/2,    y:=yyr/2+10,   w:=x2-16,   h:=yyr-6,   fn:=10,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=60,      y:=55,         w:=72,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2-50,   y:=50,         w:=64,                           cm:=28,  FgC:=4,                                ), // 2 status, text/biela
      (wh:=1,  x:=60,      y:=109,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=x2-50,   y:=109,        w:=42,                  fn:=23,  cm:=32,                                         ), // 4 SETUP
      (wh:=13, x:=125,     y:=109,        w:=350,     h:=7,                cm:=251, FgC:=4,  BgC:=5,                       ), // 5 slider
      (wh:=0,  x:=x2-110,  y:=109,        w:=48,                  fn:=39,  cm:=80, FgC:=4,   BgC:=2,                       ), // 6 list DEV
      (Wh:=0,  x:=40,      y:=38,         w:=30,                  nTch:=0,          FgC:=1,  BgC:=3,  cf:=(c:=1,   p:=9)   ), // 7  wh:=4
      (Wh:=0,  x:=87,      y:=78,         w:=30,                  nTch:=0,          FgC:=1,  BgC:=3,  cf:=(c:=1,   p:=9)   ), // 8  wh:=4
      (wh:=6,  x:=112,     y:=70,         w:=400,     h:=25,                        FgC:=10,          cf:=(c:=252),        ), // 9 Nazov miestnosti
      (wh:=6,  x:=112,     y:=38,         w:=400,     h:=30,                        FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;

  	NH_brw_SLD_D2  {HIDDEN}   :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/4,    y:=142,        w:=x2/2-17, h:=yyr*2-13,fn:=20,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=75,      y:=70,         w:=90,                 fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=235,     y:=75,         w:=85,                           cm:=28,  FgC:=4,                                ), // 2 status, text/biela
      (wh:=1,  x:=50,      y:=225,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=250,     y:=225,        w:=42,                           cm:=32,                                         ), // 4 Setup
      (wh:=13, x:=80,      y:=225,        w:=110,      h:=7,                cm:=251,  FgC:=4,  BgC:=5,                      ), // 5 slider
      (wh:=0,  x:=200,     y:=225,        w:=42,                  fn:=39,  cm:=80,           BgC:=2,                       ), // 6 list DEV
      (Wh:=0,  x:=43,      y:=50,         w:=32,                  nTch:=0,          FgC:=4,  BgC:=3,  cf:=(c:=1,   p:=9)   ), // 7
      (Wh:=0,  x:=118,     y:=90,         w:=33,                  nTch:=0,          FgC:=1,  BgC:=3,  cf:=(c:=1,   p:=9)   ), // 8
      (wh:=6,  x:=30,      y:=170,        w:=250,     h:=24,                        FgC:=10,          cf:=(c:=252),        ), // 9 Nazov miestnosti
      (wh:=6,  x:=30,      y:=135,        w:=250,     h:=28,                        FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;
  	NH_brw_SLD_D3  {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/4,    y:=yyr/2+5,    w:=x2/2-17,  h:= yyr-10,fn:=10,  cm:=252, FgC:=1,  BgC := 25                     ), // 0 priprava na oramovanie sirokeho riadka
      (wh:=230,x:=45,      y:=50,         w:=60,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2/2-45, y:=50,         w:=52,                           cm:=28,  FgC:=4                                 ), // 2 status, text/biela
      (wh:=1,  x:=45,      y:=100,        w:=38                                                                            ), // 3 favorite
      (wh:=1,  x:=250,     y:=100,        w:=38,                           cm:=32,  FgC:=4                                 ), // Setup
      (wh:=13, x:=80,      y:=100,        w:=110,       h :=7,             cm:=251, FgC:=4,  BgC:=5,                       ), // 5 slider
      (wh:=0,  x:=200,     y:=100,        w:=38,                  fn:=39,  cm:=80,          BgC:=2                        ), // 6 list DEV
      (Wh:=0,  x:=28,      y:=30,         w:=28,                    nTch:=1,        FgC:=4,  BgC:=3,       cf:=(c:=1,p:=9) ), // 7
      (Wh:=0,  x:=65,      y:=60,         w:=28,                    nTch:=1,        FgC:=1,  BgC:=3,       cf:=(c:=1,p:=9) ), // 8
      (wh:=6,  x:=88,      y:=63,         w:=150,      h := 18,                     FgC:=10,              cf :=(c:=252)    ), // Nazov miestnosti
      (wh:=6,  x:=85,      y:=35,         w:=150,      h := 22,                     FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;
  	NH_brw_SLD  {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      s       : ARRAY[0..2] OF NH_SLD_DAT       :=
         [
            (t := 0, v1 := 0.0, v2 := 100.0, zom:=0),  // slider  pre dsh=1
            (t := 0, v1 := 0.0, v2 := 100.0, zom:=0),  // slider  dsh=2
            (t := 0, v1 := 0.0, v2 := 100.0, zom:=0)   // slider  dsh=3
         ];
   END_STRUCT;
  	NH_brw_D3_ALL  {HIDDEN}	  :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..4] OF NH_OBJ_DAT       :=
         [
      	(wh:=90, x:=x2/4,    y:=yyr/2+10,   w:=x2/2-15,  h:=yyr-9,   fn:=10,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka

      (wh:=230,x:=45,      y:=50,         w:=60,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2/2-45, y:=40,         w:=52,                           cm:=28,  FgC:=4                                 ), // 2 status, text/biela
      (wh:=1,  x:=45,      y:=112,        w:=38                                                                            ), // 3 favorite
      (wh:=1,  x:=255,     y:=1112,        w:=38,                           cm:=32,  FgC:=4                                 )  // 4 Setup
         ];
   END_STRUCT;

  	NH_brw_D3_SLD  {HIDDEN}   :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..0] OF NH_OBJ_DAT       :=
         [
      (wh:=13, x:=85,      y:=100,        w:=125,       h :=7,             cm:=251, FgC:=4,  BgC:=5,                       )  // 5 slider
         ];
   END_STRUCT;
  	NH_brw_D3_NAZ  {HIDDEN}  :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..1] OF NH_OBJ_DAT       :=
         [
      (wh:=6,  x:=88,      y:=63,         w:=150,      h := 18,                     FgC:=4,               cf :=(c:=252)    ), // Nazov miestnosti
      (wh:=6,  x:=85,      y:=35,         w:=148,      h := 22,                     FgC:=3,                                )  // 10 DEv
         ];
   END_STRUCT;














  	NH_FRM_000 {HIDDEN}:  STRUCT 	// 0 defult browser		
      hed : NH_FRM_HED := (Name:='_000',wht:=1,row:=3,sld:=3);
      r  : ARRAY[0..2] OF NH_ROW_O :=
      [( ob := [


      (wh:=90, x := x2/2,    y:= yyr/2+10,  w:= x2-16,     h:= yyr-6,     fn:=10,                 FgC :=  1,  BgC := 25                         ), // priprava na oramovanie sirokeho riadka
      (wh:=1, x :=  50,     y := 54,       w := 78,                                  cm := 200,                                                ), // znak DEV + vykona prepnutie na vlastnosti
      (wh:=3, x := x2-50,   y := 50,       w := 64,                                  cm :=  28,  FgC :=  4                                     ), // status, text/biela
      (wh:=1, x := 50,      y :=113,       w := 42,                      fn:=42,     cm :=  40,                                                ), // favorite
      (wh:=1, x := x2-50,   y :=109,       w := 40                                                                                             ), // >>  / SETUP
      (         x := 125,     y :=109,       w := 48,       h := 40,                   cm := 251,  Fgc :=  4,  BgC :=  5                         ), // 5  0
      (         x := 190,     y :=109,       w := 48,                                  cm :=  44,              BgC :=  2                         ), // 6  time nad STATUS OBR v sivom kruhy
      (         x := 28,      y := 33,       w := 35,       h := 38,                                                                             ), // 7  // dark / spotrebic
      (         x := 75,      y := 33,       w := 35,       h := 38,                                                                             ), // 8  // day mode
      (wh:=6 ,x := 107,     y := 70,       w := 300,      h := 24,                               FgC :=  2,               cf :=(c := 1, p:= 30)), // 9  Nazov miestnosti/popis Cat
      (wh:=6 ,x := 108,     y := 38,       w := 300,      h := 29,                               FgC :=  3,               cf :=(        p:= 20))                   // 10 Nazov Dev
      ]),

       ( ob := [

      (wh:=90, x := x2/4,    y :=142,       w:= x2/2-17,  h:= yyr*2-13,   fn:=20,     cm := 252,  FgC :=  1,  BgC := 25                         ), // priprava na oramovanie sirokeho riadka
      (wh:=3, x :=  70,     y := 70,       w := 82,                                  cm := 200,                                                ), // znak DEV + vykona prepnutie na vlastnosti
      (wh:=3, x := 240,     y := 70,       w := 64,                                  cm :=  28,  FgC :=  4,                                    ), // status, text/biela
      (wh:=1, x := 50,      y :=225,       w := 42,                      fn:=42,     cm :=  40,                                                ), // favorite
      (wh:=1, x := 235,     y :=225,       w := 40                                                                                             ), // >>  / SETUP
      (         x := 100,     y :=225,       w := 48,       h := 28,                               Fgc :=  4,  BgC :=  5                         ), // 5  0
      (         x :=   9,     y :=225,       w := 48,                                  cm :=  44,              BgC :=  2                         ), // 6  time nad STATUS OBR v sivom kruhy
      (         x :=  40,     y := 45,       w := 42,       h := 43,                                                                             ), // 7  // dark / spotrebic
      (         x :=  98,     y := 45,       w := 42,       h := 43,                                                                             ), // 8  // day mode
      (wh:=6 ,x :=  30,     y :=175,       w := 300,      h := 25,                               FgC :=  2,               cf :=(c := 1, p:= 17)), // 9  Nazov miestnosti/popis Cat
      (wh:=6 ,x :=  30,     y :=140,       w := 300,      h := 29,                               FgC :=  3,               cf :=(        p:= 15))  // 10 Nazov Dev

      ]),

       ( ob := [

      (wh:=90, x := x2/4,    y :=yyr/2+5,   w:= x2/2-17,  h:= yyr-10,     fn:=10,     cm := 252,  FgC :=  1,  BgC := 25                         ), // priprava na oramovanie sirokeho riadka
      (wh:=3, x :=  45,     y := 45,       w := 68,                                  cm := 200,                                                ), // znak DEV + vykona prepnutie na vlastnosti
      (wh:=3, x := x2/2-45, y := 45,       w := 64,                                  cm :=  28,  FgC :=  4                                     ), // status, text/biela
      (wh:=1, x := 45,      y :=100,       w := 32,                      fn:=42,     cm :=  40,                                               ), // favorite
      (wh:=1, x := x2-50,   y :=100,       w := 40,                                                                                            ), // >>  / SETUP
      (         x := 105,     y :=100,       w := 40,       h := 28,                               Fgc :=  4,  BgC :=  5                         ), // 5  0
      (         x := 120,     y :=100,       w := 40,                                  cm :=  44,              BgC :=  2                         ), // 6  time nad STATUS OBR v sivom kruhy
      (         x :=  26,     y := 27,       w := 32,       h := 32,                                                                             ), // 7  // dark / spotrebic
      (         x :=  65,     y := 27,       w := 32,       h := 32,                                                                             ), // 8  // day mode
      (wh:=6 ,x :=  85,     y := 60,       w := 100,      h := 18,                               FgC :=  2,               cf :=(c := 1, p:= 16)), // 9  Nazov miestnosti/popis Cat
      (wh:=6 ,x :=  85,     y := 31,       w := 100,      h := 24,                               FgC :=  3,               cf :=(        p:= 15))                   // 10 Nazov Dev

      )];

      s  : ARRAY[0..2] OF NH_SLD_DAT;
(*
		 := [
            (t := 1, v1 := 0.0, v2 := 254.0, zom:=0),  // slider
            (t := 1, v1 := 0.0, v2 := 254.0, zom:=0),  // slider
            (t := 1, v1 := 0.0, v2 := 254.0, zom:=0)   // slider
              ];
*)
   END_STRUCT;

  	NH_FRM_001 {HIDDEN}:  STRUCT 	// 1 FRM-1 HW - DALI-M/S/G : slidre HW nastavenia
      hed : NH_FRM_HED := (Name:='_001',wht:=2,row:=1,sld:=9,desc:='Dali-HW-par');
      r  : ARRAY[0..0] OF NH_ROW_O := [( ob := [
            (wh:=0, cf:=(p:= 22)              ), // ActLevel                                                                         // 0
            (wh:=13, x:= 50     , y:= y1 + 100,   w:= x2-110  ,FgC := 4, BgC := 5,  fn := 1, cf:=(p:= 34)            ), // 1 ActLevel
            (wh:=13, x:= 50     , y:= y1 + 200,   w:= x2-110  ,FgC := 4, BgC := 3,  fn := 2, cf:=(p:= 20)            ), // 2 FadeTime          : usint := 3; // 20
            (wh:=13, x:= 50     , y:= y1 + 300,   w:= x2-110  ,FgC := 4, BgC := 3,  fn := 3, cf:=(p:= 21)            ), // 3 FadeRate          : usint := 7; // 21
            (wh:=13, x:= 50     , y:= y1 + 400,   w:= x2-110  ,FgC := 4, BgC := 8,  fn := 4, cf:=(p:= 17)            ), // 4 MinLevel          : usint := 1;  // 17
            (wh:=13, x:= 50     , y:= y1 + 500,   w:= x2-110  ,FgC := 4, BgC := 2,  fn := 5, cf:=(p:= 32), nTch:=1   ), // 5 PhyMinLevel       : usint; // 32 ROM               // needituje sa
            (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110  ,FgC := 4, BgC := 7,  fn := 6, cf:=(p:= 16)            ), // 6 MaxLevel          : usint := 254; // 16
            (wh:=13, x:= 50     , y:= y1 + 700,   w:= x2-110  ,FgC := 4, BgC := 3,  fn := 7, cf:=(p:= 19)            ), // 7 PowONLevel        : usint; // 19
            (wh:=13, x:= 50     , y:= y1 + 800,   w:= x2-110  ,FgC := 4, BgC := 3,  fn := 8, cf:=(p:= 18)            ),  // 8 FailLevel         : usint; // 18
            (wh:= 0, x:= xc     , y:= y1 + 960,   w:=110,h:=20,FgC := 2, BgC := 0,  fn := 2, cf:=(c:=254)            )  // 9 cislo dsl/dlma

                                                         )];
      s  : ARRAY[0..9] OF NH_SLD_DAT :=
           [
            (),                                                                    // 0
            (t := 1, v2 := 254.0   , fmt := '%3.0f'           , txt:= 362),        // 1 Aktualna uroven
            (t := 1, v2 := 15.0    , fmt := '%3.0f'           , txt:= 364),        // 2 Fade Time
            (t := 1, v2 := 15.0    , fmt := '%3.0f',v1:=1.0   , txt:= 365),        // 3 Fade rate
            (t := 1, v2 := 254.0   , fmt := '%3.0f',v1:=1.0   , txt:= 366),        // 4 Minimálna úroveò
            (t := 1, v2 := 254.0   , fmt := '%3.0f'           , txt:= 367),        // 5 Fyzická minimálna úroveò
            (t := 1, v2 := 254.0   , fmt := '%3.0f'           , txt:= 368),        // 6 Max
            (t := 1, v2 := 254.0   , fmt := '%3.0f'           , txt:= 369),        // 7 Lvl po restarte
            (t := 1, v2 := 254.0   , fmt := '%3.0f'           , txt:= 370)         // 8 Lvl po err
           ];
   END_STRUCT;

  	NH_FRM_002 {HIDDEN}:  STRUCT 	// 2 FRM-2 DALI-M : vymazat SHA, pridat NOVE SHA		
      hed : NH_FRM_HED := (Name:='_002',wht:=2,row:=1,sld:=1,Desc:='Dali-M Tools');
      r  : ARRAY[0..0] OF NH_ROW_O := [( ob := [
            (wh:=20, x:= x2-85  , y:= y1 + 150,   w:= 68     , FgC := 0, BgC :=50, fn := 371),  // 0.Vymazat VŠETKY adresy  !!!
            (wh:=20, x:= x2-85  , y:= y1 + 150,   w:= 68     , FgC := 0, BgC :=50, fn := 372),  // 1.VYMAZA túto DALI-adresu
            (wh:=20, x:= x2-85  , y:= y1 + 230,   w:= 68     , FgC := 0, BgC :=50, fn := 373),  // 2.PREPISAT túto DALI-adresu
            (wh:=13, x:= 50     , y:= y1 + 340,   w:= x2-110  ,FgC := 4, BgC := 3, fn := 0),    //  nova adresa
            (wh:=20, x:= x2-85  , y:= y1 + 400,   w:= 68     , FgC := 0, BgC :=50, fn := 374),  // 3.Vyh¾ada nové adresy
            (wh:=20, x:= x2-85  , y:= y1 + 480,   w:= 68     , FgC := 0, BgC :=50, fn := 375),  // 4.Obnovi existujúce adresy
            (wh:=20, x:= x2-85  , y:= y1 + 560,   w:= 68     , FgC := 0, BgC :=50, fn := 376),  // 5.Naèíta parametre z adries
            (wh:=20, x:= x2-85  , y:= y1 + 640,   w:= 68     , FgC := 0, BgC :=50, fn := 377),  // 6.Naèíta nastavenie scén
				(),         // fn:= 394                                                                 // 8		
            (), 			// fn:= 395																						 // 9
//		      (wh:=6,   x:= x2-30,	  y:=90,			   w:=80, h:=22, fn:=423, 	BgC:=0,FgC:=3),		 // 9 nazov: DALI adreesa
            (wh:=20, x:= x2-85  , y:= y1 + 800,   w:= 80,  FgC := 8, BgC :=50, fn := 396)   //10.Run
                                             )];

      s  : ARRAY[0..0] OF NH_SLD_DAT :=
           [
            (t := 1, v2 := 63.0    , fmt := '%3.0f'           , txt:= 411)        // 0 Nova adresa
           ];
   END_STRUCT;

	NH_FRM_003  {HIDDEN} :    STRUCT               // 5 BRW-dali-MASTER
      hed : NH_FRM_HED := (Name:='_003',wht:=1,row:=3,sld:=3);
      D1_1_4     : NH_BRW_D1_ALL                          // 0..4 : podklad/dev/stat/fav/
         := ( ob := [(),(),(),(),(cm:=247) ]);
      D1_5_SLD   : NH_BRW_D1_SLD := ( ob := ( BgC := 3));                          // 5=slider
      D1_6       : ARRAY[6..6] OF NH_OBJ_DAT ;
      D1_7       : NH_OBJ_4O1 := (obj:=1, ok:=[1,1,0,0], crc:=[1,1,1,1], FgT:= [4,1,4,1], BgC:=[10,10,7,7], txt:=[1,1,1,1], obr:=[0,0,0,0] );                // 8 = time/blkPIR na dstavom
      D1_8       : NH_OBJ_4O2;	// := (wh:=0, obj:=2  );                // 8 = time/blkPIR na dstavom
      D1_NAZ     : NH_BRW_D1_NAZ;                          // 9..10 Nazov rom + DEV
      r  : ARRAY[1..2] OF NH_ROW_O_D1;					// 2..3 row
      SL : NH_BRW_SLD;
   END_STRUCT;

   NH_FRM_004 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_004',wht:=3,desc:='DLm,DLs,Dlg menu');
      mnu      : NH_MNU := ( n:=3,   // 4 MNU-dali-MASTER pre odskok zo zakladnaje ikony , definuje 001,002
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,	frm:=9),        // SW parametre
                              (fn := 330,wh:=330,cm := 205, 	frm:=1),        // HW setup
                              (fn := 224,wh:=225,cm := 205,  frm:=2),        // tools DALI
//                              (fn :=  23,wh:= 24,cm := 205,x:=xc+90	,frm:=44),        // setup
										(fn := 348,wh:=348,cm :=  82			),				// ROM->DEV
										(fn := 124,wh:=125,cm := 205, frm:=47),			// RGBWA
                              (fn :=  23,wh:= 24,cm := 205,	frm:=61)        	// setup

                           ]);
   END_STRUCT;


  	NH_FRM_005  {HIDDEN} :    STRUCT               // 5 BRW-dali-SLAVE
      hed : NH_FRM_HED := (Name:='_005',wht:=1,row:=3,sld:=3);
      D1_ALL      : NH_BRW_D1_ALL;                          // 0..4 : podklad/dev/stat/fav/
      D1_SLD      : NH_BRW_D1_SLD := (ob:=(w:=300) );                          // 5=slider
     	D1_67       : NH_OBJ_DAT := (wh:=1, x:=x2-110,  y:=109,  w:=48, fn:=39,  cm:=80, FgC:=4,BgC:=2); // 6 list DEV
//     	D1_67       : NH_OBJ_DAT := (wh:=0, x:=125,  y:=109,  w:=50, h:=0 , FgC:=11,  BgC:=2,  fn:=0, cf:=(c:=5)); // 6 RGBWA na sebe
      D1_4o7      : NH_OBJ_4O1 := (wh:=  0,obj:=1, ok:=[1,1,0,0], crc:=[1,1,1,1], FgT:= [1,1,4,1], BgC:=[10,10,7,7], txt:=[1,1,1,1], obr:=[0,0,0,0], wxy:=[34,34,34,34] );  // 8 ballast/dali-linka
      D1_4o8      : NH_OBJ_4O2 := (wh:=107,obj:=2 );                			// 8 = time/blk
      D1_NAZ      : NH_BRW_D1_NAZ;                          // 9..10 Nazov rom + DEV

      D2 : NH_BRW_SLD_D2   := ( ob := [
         (),(),(),(),(),(w:=120),
         (wh:=0,cm:=249,x:=250,y:=170),
         (wh:=0,FgC:=4),
         (wh:=229,w:=45,x:=0,y:=-20)
               ]);
      D3_ALL      : NH_brw_D3_ALL ;                          // 0..4 : podklad/dev/stat/fav/
      D3_SLD      : NH_brw_D3_SLD;                          // 5=slider
      D3_67       : ARRAY[6..6] OF NH_OBJ_DAT ;
      D3_4o7      : NH_OBJ_4O1; //:= (obj:=1, ok:=[1,0,0,1], crc:=[1,1,1,1], FgT:= [1,1,4,1], BgC:=[10,0,7,10], txt:=[1,0,1,1], obr:=[11,0,0,2] );                // 8 = time/blkPIR na dstavom
      D3_4o8      : NH_OBJ_4O2; //:= (obj:=2  );                // 8 = time/blkPIR na dstavom
      D3_NAZ      : NH_brw_D3_NAZ;                          // 9..10 Nazov rom + DEV

      SL : NH_brw_SLD;
   END_STRUCT;

   NH_FRM_006 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_006',wht:=3);
      mnu      : NH_MNU := ( n:= 4,        // 7 MNU- zoznam DALI-slave - odskok z setup DALI MASTER
                        o := [ //fn=nevybraty, wh=vybraty
                              (fn :=  6,wh:=  0,cm :=  31),       // <
                              (fn := 157,wh:=  3,cm :=  43),          // zmena DSH
                              (fn :=  35,wh:= 38,cm := 247),          // CHK, vsetky/s vazbou/len bez vazby
                              (fn :=  10,wh:= 11,cm := 247),          // cat
                              (fn :=  16,wh:= 18,cm := 247),          // rom/1rom
                              (fn := 291,wh:=335,cm := 247),          // DALi master OFF=vsetky mastre/ ON=len master v hlavicke
                              (fn := 333,wh:=334,cm := 247),          // Dali skupiny
                              (fn :=  49,wh:=  0,cm := 247)           // ON-OFF
                           ]);
   END_STRUCT;
   NH_FRM_007 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_007',wht:=3);
      mnu      : NH_MNU := ( n:= 0,        // 7 MNU-vazby dali-SLAVE, oskok z DLS-setup
                        o := [
                              (fn :=  6,wh:=   0,cm :=  31),       // <
                              (fn :=  32,wh:= 25,cm := 101),        // pridanie DEV
                              (fn :=  35,wh:= 38,cm := 247),          // check
                              (fn :=  10,wh:= 11,cm := 34),          // 4-cat
                              (fn :=  16,wh:= 18,cm := 35),          // 5-rom/1rom
                              (fn :=   0,wh:= 40,cm := 247),          //
                              (fn :=  23,wh:= 24,cm := 247),          // setup
                              (fn :=  49,wh:= 26,cm :=  26)          // ON/OFF
                           ]);
   END_STRUCT;


  	NH_008_D1 {HIDDEN}:  STRUCT 	// 8 BRW - rolety
		D1_0_4 		: NH_brw_D1_ALL;
		D1_5_6 		: NH_OBJ_ROL :=  (
			x			:= x2-105,                     // lavy horny roh ROL -
			y			:= 30,
			w			:= 55,			      // sirka ROL
			h			:= 55,			      // vyska ROL
//			yCirRol	:= 30,      // 	suradnica gulicky ROL
//			yCirLam	:= 35,      // 	suradnivc gulicky LAM
			bRol	   := 8,	            	// vyska boxu nad roletou
			xLam		:= x2-30,				// lavy horny roh LAM slidera
			yLam		:= 30,			
			hLam		:= 50,	           	// vyska * dlzka slidera odhora nadol
			yObr		:= 109, 					// y-suradnica obrazkov a textu % pod  Rol
			xObrR		:= 130,             	// x-suradnica obrazka rolety
			xObrL		:= 299,	//300,             	// x-suradnica obrazka LAM
			wObr		:= 48,					// sirka/vyska obrazku
	      prs      := false, 	         // nad tymto objektom je povoleny press
			rCirSld	:= 10,					// r gulicky slidera
			rCirUpDn	:= 22,					// r gulicky slidera	pr izobrazeni pohyby
			wObrInfo	:= 50,
			corner	:= 0,	
			wSldLam	:= 6,						// hrubka aktivnej casi slidera
			hTxt		:= 34,					// vyska textu
			nLam		:= 6,						// pocet lamiel
			wLMax   	:= 8,                // sirka {vyska} lamely pri uplnom zaklopeni
			wLold		:= 8,						// minimalna vyska lamely pri uplnom otvoreni
			mLam		:= 4,						// bocny okraj medzi lamelou a lavym/pravym oranovanim
			SldRol	:= 0,  					// zobrazit slider ROL
			SldLam	:= true,					// zobrazit slider LAM
			tchLam	:= 0,						// povolit nastavovanie slidera LAM
			tchUpDn	:= true,					// pri dotyku len spustit zmenu smeru  CMD=1
			StatRow	:= true,					// vykresluju sa aj statusove obrazky a hodnoty pod obrazkom														
			ShwLamUp	:= 0						// vykresluju ikony nadLAM-sliderom
			);
		D1_7_7   	: ARRAY[7..7] OF NH_OBJ_DAT ;
      D1_8       : NH_OBJ_4O1    := (	obj:=2,						// kopirovanie
													ok:=[1,0,0,0],				// ktore za zobrazia
													txt:=[0,0,0,0],         // [cislo,obr,cislo]
													obr:=[500,264,0,0],     // [vlozi sa v browsi,cislo obrazka, ...]
													wxy:=[42,42,42,0],    	// [vyska textu,velkost obr,,,
													FgT:=[3,0,4,4],         // [farba textu
													crc := [0,0,0,0],			// pod obr bude kruznica
													cmd:=[0,0,0,0]    );

      D1_9_10_NAZ	: NH_brw_D1_NAZ;                          // 9..10 Nazov rom + DEV
   END_STRUCT;


  	NH_brw_D2_ALL   {HIDDEN} :   STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0..4] OF NH_OBJ_DAT       :=
         [
      (wh:=90, x:=x2/4,  y:=yyr+30,   	w:=x2/2-15,   h:=yyr*2+30,   	fn:=10,           FgC:=1,  BgC:=25,                      ), // priprava na oramovanie sirokeho riadka
      (wh:=230,x:=60,      y:=55,         w:=72,                  fn:=291, cm:=204,                                        ), // 1 znak DEV + vykona prepnutie na vlastnosti
      (wh:=231,x:=x2-50,   y:=50,         w:=64,                           cm:=28,  FgC:=4,                                ), // 2 status, text/biela
      (wh:=1,  x:=60,      y:=109,        w:=42,                           cm:=40,                                         ), // 3 favorite
      (wh:=1,  x:=x2-50,   y:=109,        w:=42,                  fn:=23,  cm:=32,                                         )  // 4 SETUP
         ];
   END_STRUCT;

  	NH_FRM_008 {HIDDEN}:  STRUCT 	// 8 BRW - rolety
      hed : NH_FRM_HED := (Name:='_008',wht:=1,row:=3,sld:=0);

		D1_0_4 		: NH_brw_D1_ALL := ( ob := [
						(),
						(),
						(wh:=0),
						(),	
						(x:=x2-80,   y:=112)		]);

		D1_5_6 		: NH_OBJ_ROL :=  (
			x			:= x2-105,                     // lavy horny roh ROL -
			y			:= 30,
			w			:= 55,			      // sirka ROL
			h			:= 55,			      // vyska ROL
//			yCirRol	:= 30,      // 	suradnica gulicky ROL
//			yCirLam	:= 35,      // 	suradnivc gulicky LAM
			bRol	   := 8,	            	// vyska boxu nad roletou
			xLam		:= x2-30,				// lavy horny roh LAM slidera
			yLam		:= 30,			
			hLam		:= 50,	           	// vyska * dlzka slidera odhora nadol
			yObr		:= 109, 					// y-suradnica obrazkov a textu % pod  Rol
			xObrR		:= 130,             	// x-suradnica obrazka rolety
			xObrL		:= 299,	//300,             	// x-suradnica obrazka LAM
			wObr		:= 48,					// sirka/vyska obrazku
	      prs      := false, 	         // nad tymto objektom je povoleny press
			rCirSld	:= 10,					// r gulicky slidera
			rCirUpDn	:= 22,					// r gulicky slidera	pr izobrazeni pohyby
			wObrInfo	:= 50,
			corner	:= 0,	
			wSldLam	:= 6,						// hrubka aktivnej casi slidera
			hTxt		:= 30,					// vyska textu
			nLam		:= 6,						// pocet lamiel
			wLMax   	:= 8,                // sirka {vyska} lamely pri uplnom zaklopeni
			wLold		:= 8,						// minimalna vyska lamely pri uplnom otvoreni
			mLam		:= 5,						// bocny okraj medzi lamelou a lavym/pravym oranovanim
			SldRol	:= 0,  					// zobrazit slider ROL
			SldLam	:= true,					// zobrazit slider LAM
			tchLam	:= 0,						// povolit nastavovanie slidera LAM
			tchUpDn	:= true,					// pri dotyku len spustit zmenu smeru  CMD=1
			StatRow	:= true,					// vykresluju sa aj statusove obrazky a hodnoty pod obrazkom														
			ShwLamUp	:= 0						// vykresluju ikony nadLAM-sliderom
			);
		D1_7_7   	: ARRAY[7..7] OF NH_OBJ_DAT ;
      D1_8       : NH_OBJ_4O1    := (	obj:=2,						// kopirovanie
													ok:=[1,0,0,0],				// ktore za zobrazia
													txt:=[0,0,0,0],         // [cislo,obr,cislo]
													obr:=[500,264,0,0],     // [vlozi sa v browsi,cislo obrazka, ...]
													wxy:=[42,42,42,0],    	// [vyska textu,velkost obr,,,
													FgT:=[3,0,4,4],         // [farba textu
													crc := [0,0,0,0],			// pod obr bude kruznica
													cmd:=[0,0,0,0]    );



      D1_9_10_NAZ	: NH_brw_D1_NAZ ;                          // 9..10 Nazov rom + DEV

	// D2
		
		D2_0_4 		: NH_brw_D2_ALL := ( ob := [
						(),
						(wh:=0),
						(wh:=0),
						(wh:=0),	
						(wh:=0)					]);

		D2_5_6 		: NH_OBJ_ROL :=  (
			x			:= 40,                     // lavy horny roh ROL -
			y			:=  80,
			w			:= 180,			      // sirka ROL
			h			:= 170,			      // vyska ROL
			bRol	   := 17,	            	// vyska boxu nad roletou
			xLam		:= x2/2-40,				// lavy horny roh LAM slidera
			yLam		:= 80,			
			hLam		:= 160,	           	// vyska * dlzka slidera odhora nadol
			yObr		:= 280, 					// y-suradnica obrazkov a textu % pod  Rol
			xObrR		:= 40,             	// x-suradnica obrazka rolety
			xObrL		:= 170,	           	// x-suradnica obrazka LAM
			wObr		:= 40,					// sirka/vyska obrazku
	      prs      := false, 	         // nad tymto objektom je povoleny press
			rCirSld	:= 15,					// r gulicky slidera
			rCirUpDn	:= 30,					// r gulicky slidera	pr izobrazeni pohyby
			wObrInfo	:= 42,
			corner	:= 0,	
			wSldLam	:= 9,						// hrubka aktivnej casi slidera
			hTxt		:= 25,					// vyska textu
			nLam		:=8,						// pocet lamiel
			wLMax   	:=17,                // sirka {vyska} lamely pri uplnom zaklopeni
			wLold		:=17,						// minimalna vyska lamely pri uplnom otvoreni
			mLam		:= 9,						// bocny okraj medzi lamelou a lavym/pravym oranovanim
			SldRol	:= 1,  					// zobrazit slider ROL
			SldLam	:= true,					// zobrazit slider LAM
			tchLam	:= 1,						// povolit nastavovanie slidera LAM
			tchUpDn	:= true,					// pri dotyku len spustit zmenu smeru  CMD=1
			StatRow	:= true,					// vykresluju sa aj statusove obrazky a hodnoty pod obrazkom														
			ShwLamUp	:= 0						// vykresluju ikony nadLAM-sliderom
			);
		D2_7_7   	: ARRAY[7..7] OF NH_OBJ_DAT ;
      D2_8       : NH_OBJ_4O1    := (	obj:=2,						// kopirovanie
													ok:=[1,0,0,0],				// ktore za zobrazia
													txt:=[0,0,0,0],         // [cislo,obr,cislo]
													obr:=[500,264,0,0],     // [vlozi sa v browsi,cislo obrazka, ...]
													wxy:=[42,42,42,0],    	// [vyska textu,velkost obr,,,
													FgT:=[3,0,4,4],         // [farba textu
													crc := [0,0,0,0],			// pod obr bude kruznica
													cmd:=[0,0,0,0]    );

		D2_9_10_NAZ	:	ARRAY[9..10] OF NH_OBJ_DAT       :=
         [
      (wh:=0,  x:=30,     y:=60,         w:=215,     h:=20,    cm:=204,            FgC:=10,           cf:=(c:=252),        ), // 9 Nazov miestnosti
      (wh:=6,  x:=30,     y:=40,         w:=215,     h:=26,    cm:=204,            FgC:=3,                                )  // 10 DEv
         ];





		// D3
		D3_0_4 		: NH_brw_D3_ALL := ( ob := [
						(),
						(wh:=0),
						(wh:=0),
						(Wh:=0),	
						(wh:=0)		]);

		D3_5_6 		: NH_OBJ_ROL :=  (
			x			:= x2/2-85,          // lavy horny roh ROL -
			y			:= 70,
			w			:= 48,			      // sirka ROL
			h			:= 55,			      // vyska ROL
			bRol	   := 8,	            	// vyska boxu nad roletou
			xLam		:= x2/2-20,				// lavy horny roh LAM slidera
			yLam		:= 70,			
			hLam		:= 50,	           	// vyska * dlzka slidera odhora nadol
			yObr		:= 112, 					// y-suradnica obrazkov a textu % pod  Rol
			xObrR		:= 27,             	// x-suradnica obrazka rolety
			xObrL		:= 121,	//300,             	// x-suradnica obrazka LAM
			wObr		:= 32,					// sirka/vyska obrazku
	      prs      := false, 	         // nad tymto objektom je povoleny press
			rCirSld	:= 10,					// r gulicky slidera
			rCirUpDn	:= 22,					// r gulicky slidera	pr izobrazeni pohyby
			wObrInfo	:= 50,
			corner	:= 0,	
			wSldLam	:= 6,						// hrubka aktivnej casi slidera
			hTxt		:= 22,					// vyska textu
			nLam		:= 6,						// pocet lamiel
			wLMax   	:= 8,                // sirka {vyska} lamely pri uplnom zaklopeni
			wLold		:= 8,						// minimalna vyska lamely pri uplnom otvoreni
			mLam		:= 5,						// bocny okraj medzi lamelou a lavym/pravym oranovanim
			SldRol	:= 0,  					// zobrazit slider ROL
			SldLam	:= true,					// zobrazit slider LAM
			tchLam	:= 0,						// povolit nastavovanie slidera LAM
			tchUpDn	:= true,					// pri dotyku len spustit zmenu smeru  CMD=1
			StatRow	:= true,					// vykresluju sa aj statusove obrazky a hodnoty pod obrazkom														
			ShwLamUp	:= 0						// vykresluju ikony nadLAM-sliderom
			);
		D3_7_7   	: ARRAY[7..7] OF NH_OBJ_DAT ;
      D3_8       : NH_OBJ_4O1    := (	obj:=2,						// kopirovanie
													ok:=[1,0,0,0],				// ktore za zobrazia
													txt:=[0,0,0,0],         // [cislo,obr,cislo]
													obr:=[500,264,0,0],     // [vlozi sa v browsi,cislo obrazka, ...]
													wxy:=[42,42,42,0],    	// [vyska textu,velkost obr,,,
													FgT:=[3,0,4,4],         // [farba textu
													crc := [0,0,0,0],			// pod obr bude kruznica
													cmd:=[0,0,0,0]    );



		D3_9_10_NAZ	:	ARRAY[9..10] OF NH_OBJ_DAT       :=
         [
      (wh:=6,  x:=25,      y:=66,         w:=165,      h := 22,     cm:=204,        FgC:=2,               cf :=(c:=252)    ), // Nazov miestnosti
      (wh:=6,  x:=25,      y:=35,         w:=220,      h := 28,     cm:=204,        FgC:=3,                                )  // 10 DEv
		  ];

   END_STRUCT;


	NH_FRM_009 {HIDDEN}:  STRUCT 	// 9 FRM parametre DLS
      hed : NH_FRM_HED := (Name:='_009',wht:=2,row:=1,sld:=8);
      r  : ARRAY[0..0] OF NH_ROW_O := [( ob := [
            (wh:=13, x:= 50     , y:= y1 +  80,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0             ), // 0 nastavit uroven na
            (wh:=13, x:= 50     , y:= y1 + 180,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 1             ), // 1 ramp ON
            (wh:=13, x:= 50     , y:= y1 + 280,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 2             ), // 2 ramp OFF
            (wh:=13, x:= 50     , y:= y1 + 380,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 3             ), // 3 vypnut po case
            (wh:=20, x:= x2-60  , y:= y1 + 420,   w:= 48     , FgC := 0, BgC :=50          , fn := 55            ), // 4  pohyb resetuje cas
            (wh:=13, x:= 50     , y:= y1 + 540,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 4             ), // 5 max cas
            (wh:=13, x:= 50     , y:= y1 + 640,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 5             ), // 6 vykonat s opozdenim
            (wh:=20, x:= x2-60  , y:= y1 + 700,   w:= 48     , FgC := 0, BgC :=50          , fn := 152           ), // 7 rucne vypnutie blokuje pir
            (wh:=13, x:= 50     , y:= y1 + 800,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 6             ), // 8 cas blokovania PIR
            (wh:=20, x:= x2-60  , y:= y1 + 850,   w:= 48     , FgC := 0, BgC :=50          , fn := 328           ), // 9 rucne vypnutie blokuje pir
            (wh:= 6, x:=xc      , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254)           )  // 10 info dali nbr {len admin}
                                             )];
      s  : ARRAY[0..7] OF NH_SLD_DAT :=
           [
//            (t := 1, v2 := 254.0   , fmt := '%3.0f %%'           , txt:= 363),        // 0 nastavit uroven na
            (t := 1, v2 := 100.0   , fmt := '%3.0f'            , txt:= 363),        // 0 nastavit uroven na
            (t := 1, v2 := 15.0    , fmt := '%4.0f'               , txt:=  67),        // 1 Zapinacia rampa
            (t := 1, v2 := 15.0    , fmt := '%4.0f'               , txt:=  68),        // 2 Vypinacia rampa
            (t := 3, v2 := 18000.0  , fmt := '1%Tm:ss.z m',ink:=1, txt:=  64),        // 3 vypnut po case - PIR  3540s = 59min
//            (t := 3, v2 := 21600.0 , fmt := 's%Th:mm h'           , txt:=  64,ink:=60.0),// 3 vypnut po case - WSB...
            (t := 3, v2 := 1440.0  , fmt := 'm%Th:mm h'           , txt:=  62),        // 4 Max.cas zapnutia
            (t := 3, v2 := 18000.0 , fmt := '1%Tm:ss.z m'         , txt:= 115),        // 5 vykont opozdene
            (t := 1, v2 := 120.0   , fmt := 'm%Th:mm h'           , txt:= 226),        // 6 cas blokovania PIR v miestnosti po vypnuti
            (t := 0, v2 := 3000.0  , fmt := '%4.0f W'             , txt:=  69)         // 7 Prikon
              ];

   END_STRUCT;
   NH_FRM_010 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_010',wht:=3,wht:=3);
      mnu      : NH_MNU := ( n:=3,           //  volne !!!!!
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,x:=xc-45  ,frm:=9),        // SW parametre
                              (fn := 330,wh:=330,cm := 205,x:=xc+45  ,frm:=1),        // hw setup
                             (fn := 224,wh:=225,cm := 205,x:=xc+135 ,frm:=40)        // tools

                           ]);
   END_STRUCT;




   // ***** DSH *****

   NH_DSH_DAT {HIDDEN}: NH_OBJ_DAT := (w:=130, wh:=232, cm:=50);
  	NH_HOM_DSH {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_DSH_DAT       :=
         [
               (wh:=0),
               (x := xc,     y:= yyc-253),   // 1.kruznica pod obr.1 prvy hore
               (x := xc+158, y:= yyc-183),   // 2.kruznica pod obr.2
               (x := xc+210, y:= yyc- 25),   // kruznica pod obr.3 - vprav v strede
               (x := xc+158, y:= yyc+133),   // kruznica pod obr.4
               (x := xc,     y:= yyc+203),   // kruznica pod obr.5 - dolu
               (x := xc-158, y:= yyc+133),   // kruznica pod obr.6
               (x := xc-210, y:= yyc- 25),   // kruznica pod obr.7 - vlavo v strede
               (x := xc-158, y:= yyc-183),   // kruznica pod obr.8
               (wh:=0),
               (wh:=0)
         ];
   END_STRUCT;

   NH_DSH_OBR : NH_OBJ_DAT := (w:=70, wh:=0, cm:=0, fn := 0);

  	NH_OBJ_4DSH {HIDDEN} :  NH_OBJ_4O2 :=
		( 	wh:=0,  obj := 1, fil := [1,1,1,1],
			txt := [0,0,0,0],
			crc := [1,1,1,1],
		 	wxy := [58,58,58,58],
		 	BgC := [3,3,3,3],
		 	FgT := [4,4,4,4]
		);  	

  	NH_HOM_LUP {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_4DSH;
   END_STRUCT;

  	NH_HOM_PUP {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_DSH_OBR       :=
         [
               (wh:=0),
               (x := xc     + 40, y:= yyc-253 - 40),   // 1.kruznica pod obr.1 prvy hore
               (x := xc+158 + 40, y:= yyc-183 - 40),   // 2.kruznica pod obr.2
               (x := xc+210 + 40, y:= yyc- 25 - 40),   // kruznica pod obr.3 - vprav v strede
               (x := xc+158 + 40, y:= yyc+133 - 40),   // kruznica pod obr.4
               (x := xc     + 40, y:= yyc+203 - 40),   // kruznica pod obr.5 - dolu
               (x := xc-158 + 40, y:= yyc+133 - 40),   // kruznica pod obr.6
               (x := xc-210 + 40, y:= yyc- 25 - 40),   // kruznica pod obr.7 - vlavo v strede
               (x := xc-158 + 40, y:= yyc-183 - 40),   // kruznica pod obr.8
               (wh:=0),
               (wh:=0)
         ];
   END_STRUCT;
  	NH_HOM_LDN {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_DSH_OBR       :=
         [
               (wh:=0),
               (x := xc     - 40, y:= yyc-253 + 40),   // 1.kruznica pod obr.1 prvy hore
               (x := xc+158 - 40, y:= yyc-183 + 40),   // 2.kruznica pod obr.2
               (x := xc+210 - 40, y:= yyc- 25 + 40),   // kruznica pod obr.3 - vprav v strede
               (x := xc+158 - 40, y:= yyc+133 + 40),   // kruznica pod obr.4
               (x := xc     - 40, y:= yyc+203 + 40),   // kruznica pod obr.5 - dolu
               (x := xc-158 - 40, y:= yyc+133 + 40),   // kruznica pod obr.6
               (x := xc-210 - 40, y:= yyc- 25 + 40),   // kruznica pod obr.7 - vlavo v strede
               (x := xc-158 - 40, y:= yyc-183 + 40),   // kruznica pod obr.8
               (wh:=0),
               (wh:=0)
         ];
   END_STRUCT;
  	NH_HOM_PDN {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_DSH_OBR       :=
         [
               (wh:=0),
               (x := xc     + 40, y:= yyc-253 + 40),   // 1.kruznica pod obr.1 prvy hore
               (x := xc+158 + 40, y:= yyc-183 + 40),   // 2.kruznica pod obr.2
               (x := xc+210 + 40, y:= yyc- 25 + 40),   // kruznica pod obr.3 - vprav v strede
               (x := xc+158 + 40, y:= yyc+133 + 40),   // kruznica pod obr.4
               (x := xc     + 40, y:= yyc+203 + 40),   // kruznica pod obr.5 - dolu
               (x := xc-158 + 40, y:= yyc+133 + 40),   // kruznica pod obr.6
               (x := xc-210 + 40, y:= yyc- 25 + 40),   // kruznica pod obr.7 - vlavo v strede
               (x := xc-158 + 40, y:= yyc-183 + 40),   // kruznica pod obr.8
               (wh:=0),
               (wh:=0)
         ];
   END_STRUCT;


   NH_QCK_DAT {HIDDEN} : NH_OBJ_DAT :=(w:=70, wh:=0, cm:=50, FgC:=4);
  	NH_HOM_QCK {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_QCK_DAT       :=
         [
               (wh:=0),
               (x := xc-220, y := yy2-65, h:=22, fn:=2 ),                  // 1 - preve zlava
               (x := xc-130, y := yy2-65, h:=22, fn:=2 ),
               (x := xc- 40, y := yy2-65, h:=22, fn:=2 ),
               (x := xc+ 50, y := yy2-65, h:=22, fn:=2 ),
               (x := xc+140, y := yy2-65, h:=22, fn:=2 ),
               (x := xc+230, y := yy2-65, h:=22, fn:=2 ),
               (x := xc+320, y := yy2-65, wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0)

         ];
   END_STRUCT;
   NH_HOM_OBJ {HIDDEN} : NH_OBJ_DAT :=(w:=70, wh:=240, cm:=0);
  	NH_HOM_HOM {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_HOM_OBJ       :=
         [
               (wh:=0),
               (x := xc    , y := yyc- 30, fn := 255, w := 180, cf:=(p:=1)),                  // domcek
               (x := xc    , y := yyc- 55, fn := 131, w := 32 , cf:=(p:=2)),                  // sviecka vnutri
               (x := xc    , y := yyc-  5, fn :=  92, w := 80 , cf:=(p:=3)),                  // okno
               (x := xc-45 , y := yyc-130, fn := 132, w := 75 , cf:=(p:=4)),                  // Fotovoltaika
               (wh:=0, x := xc-55 , y := yyc+40,  fn :=  91, w := 65 , cf:=(p:=5)),                  // Dvere
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0)

         ];
   END_STRUCT;
   NH_WHT_OBJ  {HIDDEN}: NH_OBJ_DAT :=(w:=52, wh:=1, cm:=0);
  	NH_HOM_WHT {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_WHT_OBJ       :=
         [
               (wh:=0),
               (x := x0+25  , y := y1 + 30, fn := 130, cf:=(p:=10), cm:=210),                // 1 obr: osvetlenie vonku
               (x := x0+155 , y := y1 + 30, fn := 162, cf:=(p:=10), cm:=210, w:=48),         // 2 obr: teplota vonku
               (x := xc+10  , y := y1 + 30, fn := 261, cf:=(p:=10), cm:=210),                // 3 obr: vietor
               (x := x2-106 , y := y1 + 30, fn := 257, cf:=(p:=10), cm:=210),                // 4 obr: vlhkost
               (wh:=100),																				 			// hodnoty
               (wh:=101, x:=xc+150, y:=y1+30,w:=52,Fgc:=3,BgC:=3,btn:=01),      					// orientacia vetra
//	            (wh:=6, 	 x:=x2-30,  y:=y1+70,w:=100,h:=24,fn:=1, cf:=(c:=4),FgC:=2,BgC:=0,fmt:='%TDD.MM'),  // 8 datum
//	            (wh:=6, 	 x:=x2-30,  y:=y1+100,w:=100,h:=24,fn:=1,cf:=(c:=3),FgC:=4,BgC:=0,fmt:='%Th:mm'),   	// 7 cas
               (wh:=0),
               (wh:=0)

         ];
   END_STRUCT;
  	NH_HOM_OTH {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
               (wh:=0),
               (wh:=106,x:=xc-248, y:=y1+100, 	w:= 82, 			fn := 269, cf:=(p:=10), cm:=215),                 		// 1 Typovy den
	            (wh:=6, 	x:=160,    y:=y1+84,		w:=100,	h:=26,fn:=1, cf:=(c:=248),FgC:=10,BgC:=0,fmt:='%TD.M'),  	// 2 datum
	            (wh:=6, 	x:=160,    y:=y1+118,	w:=100,	h:=24,fn:=1,cf:=(c:=247),FgC:= 4,BgC:=0,fmt:='%Th:mm'),  	// 3 cas
               (wh:=1, 	x:=x2-130, y:=y1+102, 	w:= 60, 			fn := 149 ),														// 4 obrr Sunrise/sunset
	            (wh:=6, 	x:=x2-20,  y:=y1+84 ,	w:=100,	h:=24,fn:=1,cf:=(c:=245),FgC:=10,BgC:=0,fmt:='%Th:mm'), 		// 5 Sunrise
	            (wh:=6, 	x:=x2-20,  y:=y1+118,	w:=100,	h:=24,fn:=1,cf:=(c:=246),FgC:=10,BgC:=0,fmt:='%Th:mm'), 		// 6 Sunset


               (wh:=0)
         ];
   END_STRUCT;
  	NH_EMPTY_0  {HIDDEN} :  STRUCT          // objekty jedneho riadka  			
      ob       : ARRAY[0.._RowObr] OF NH_OBJ_DAT       :=
         [
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0),
               (wh:=0)
         ];
   END_STRUCT;

  	NH_HOM_011 {HIDDEN}:  STRUCT 	
      hed : NH_FRM_HED := (Name:='_011',wht:=4,row:=9);
//      NH_EMPTY : NH_HOM_DSH ;             // 0    rezeva
      NH_EMPTY : NH_EMPTY_0  ;             // 0    rezeva
      DSH      : NH_HOM_DSH ;             // 1     DASH
      QCK      : NH_HOM_QCK ;             // 2     Quick-menu
      HOM      : NH_HOM_HOM ;             // 3     domcek s okolim
      LUP      : NH_HOM_LUP ;             // 4     objekt k DSH vlavo hore
      PUP      : NH_HOM_PUP ;             // 5     objekt k DSH vpravo hore
      LDN      : NH_HOM_LDN ;             // 6     objekt k DSH vlavo dolu
      PDN      : NH_HOM_PDN ;             // 7     objekt k DSH vpravo dolu
      WHT      : NH_HOM_WHT ;             // 8     wheater
      OTH      : NH_HOM_OTH ;             // 9     ostatne
   END_STRUCT;

   NH_ROW_012  {HIDDEN} : NH_ROW_O_D1  := ( ob :=
         [  (),
            (wh:=232 ,w:=82 ,cm:=30),
            (wh:=232 ,w:=62 ,cm:=30),
            (wh:=1),
            (wh:=1,cm:=30,fn:=8),
            (wh:=6,cm:=0,cf:=(p:=-1), x:=107,y:=44,w:=300,h:=29,FgC:=3,BgC:=0),     // 5 nazov cat
            (wh:=6,cm:=0,cf:=(p:=-1), x:=107,y:=78,w:=400,h:=24,FgC:=2,BgC:=0),     // 6 popis caty
            (wh:=0,cm:=0,cf:=(p:=-1), x:=107,y:=109,w:=300,h:=18,FgC:=2,BgC:=0),    // 7 cislo CAT/cislo lextu - len pre admina
            (wh:=0),
            (wh:=0, cm:=30),
            (wh:=0, cm:=30)
         ]);

	NH_FRM_012 {HIDDEN}:  STRUCT 	                      // 12 BRW-kategorie	
      hed : NH_FRM_HED := (Name:='_012',wht:=1,row:=3,sld:=0);
      r  : ARRAY[0..2] OF NH_ROW_012:=
      [( ob := [
         (), // priprava na oramovanie sirokeho riadka
         (x := 55       ,y := 50),     		// 1 znak DEV + vykona prepnutie na vlastnosti
         (x := x2-50    ,y := 50),     		// 2 status, text/biela
         (x := 55       ,y :=109),     		// 3 favorite
         (x := x2-50    ,y :=109, cm:=51)    // 4 >>
      ]),
       ( ob := [
         (x := x2/4     ,y :=142 ,w:= x2/2-17,h:= yyr*2-13),    // priprava na oramovanie sirokeho riadka
         (x := 75       ,y := 70),                             // 1 znak DEV + vykona prepnutie na vlastnosti
         (x := 230      ,y := 70 ,w:=80),                      // 2 status, text/biela
         (x := 50       ,y :=225),                             // 3 favorite
         (x := 230      ,y :=225),                             // 4 >>
         (x := 30       ,y :=170 ,w:=150, h:=21),              // 5 druhy text
         (x := 30       ,y :=135 ,w:=110),                     // 6 prvy text
         (               y :=225 ,w:=110)                      // 7 cislo CAT/cislotextu - len pre admina
      ]),
       ( ob := [
         (x := x2/4     ,y :=yyr/2+5 ,w:= x2/2-17,h:= yyr-10), // priprava na oramovanie sirokeho riadka
         (x := 45       ,y := 45, w:=65),                      // 1 znak DEV + vykona prepnutie na vlastnosti
         (x := x2/2-45  ,y := 40 ,w:=55),                      // 2 status, text/biela
         (x := 45       ,y :=100 ,w:=38),                      // 3 favorite
         (x := x2/2-45  ,y :=100, w:=32),                      // 4 >>
         (x := 80       ,y := 72 ,w:=130 ,h:=18),               // 5 druhy text
         (x := 80       ,y := 35 ,w:=71  ,h:=23),                // 6 prvy text
         (               y :=100 ,w:=110)                      // 7 cislo CAT/cislotextu - len pre admina
      )];
   END_STRUCT;

   NH_ROW_013  {HIDDEN} : NH_ROW_O_D1  := ( ob :=
         [  (),
            (wh:=1 ,fn:=315,w:=82  ,cm:=251),
            (wh:=1 ,fn:=66 ,w:=65  ,cm:=251),
            (wh:=1 ,fn:=42 ,cm:=40),
            (wh:=1 ,fn:=8  ,cm:=30),
            (wh:=5 ,fn:=0  ,cm:=0,h:=40,w:=40),                      // vypis stavov
            (wh:=0),
            (wh:=0),
            (wh:=0),
            (wh:=0),
            ()
         ]);
  	NH_FRM_013 {HIDDEN}:  STRUCT 	// 13 BRW-subjekty
      hed : NH_FRM_HED := (Name:='_013',wht:=1,row:=3,sld:=0); //13 USR - users (rws = pocet zaznamov, sld := cfg)
      r  : ARRAY[0..2] OF NH_ROW_013:=
      [( ob := [
         (), // priprava na oramovanie sirokeho riadka
         (x := 55       ,y := 50),     // 1 znak DEV + vykona prepnutie na vlastnosti
         (x := x2-50    ,y := 50),      // 2 status, text/biela
         (x := 55       ,y :=109),     // 3 favorite
         (x := x2-50    ,y :=109),     // 4 >>
         ()                           // 5
      ]),
       ( ob := [
         (x := x2/4     ,y :=142 ,w:= x2/2-17,h:= yyr*2-13),    // priprava na oramovanie sirokeho riadka
         (x := 75       ,y := 70),                             // 1 znak DEV + vykona prepnutie na vlastnosti
         (x := 230      ,y := 70 ,w:=80),                      // 2 status, text/biela
         (x := 50       ,y :=225),                             // 3 favorite
         (x := 230      ,y :=225),                             // 4 >>
         (),
         (),
         (),
         (),
         (),
         ()
      ]),
       ( ob := [
         (x := x2/4     ,y :=yyr/2+5 ,w:= x2/2-17,h:= yyr-10), // priprava na oramovanie sirokeho riadka
         (x := 45       ,y := 45, w:=65),                      // 1 znak DEV + vykona prepnutie na vlastnosti
         (x := x2/2-45  ,y := 40 ,w:=55),                      // 2 status, text/biela
         (x := 45       ,y :=100 ,w:=38),                      // 3 favorite
         (x := x2/2-45  ,y :=100, w:=32),                      // 4 >>
         (),
         (),
         (),
         (),
         (),
         ()
      )];
   END_STRUCT;


   // 14-BRW ROM/ZON
  	NH_FRM_014  {HIDDEN} :  STRUCT               // BRW - ROM,ZON
      hed : NH_FRM_HED := (Name:='_014',wht:=1,row:=4,sld:=0);
      D1 : NH_brw_ROM_D1;
      D2 : NH_brw_ROM_D2;
      D3 : NH_brw_ROM_D3;
      D4 : NH_brw_ROM_D4;
   END_STRUCT;

  	NH_FRM_015  {HIDDEN} :    STRUCT               // PIR,SIR,DOR,TIMer
      hed : NH_FRM_HED := (Name:='_015',wht:=1,row:=3,sld:=0);
      D1_1_4      : NH_brw_D1_ALL;                          // 0..4 : podklad/dev/stat/fav/
      D1_5_BLK    : NH_brw_D1_BLK := (wh:=20);   				// blokovanie v riadku
      D1_6_BLK    : NH_brw_D1_BLK := (wh:=0);   				// nema ziadnu fubkciu
      D1_7        : NH_OBJ_4O1 := (wh:=107, ok:= [1,1], wxy := [40,40]);              					// 7 = DayMode/Sviecka
      D1_8        : NH_OBJ_4O2 := (wh:=0, obj:=2, cmd :=[45], ok:=[1,0,0,0], crc:=[0,0,0,0]);      // 8 = Time-OFF/BlokPir
      D1_9_10NAZ  : NH_brw_D1_NAZ;                                // 9..10 Nazov rom + DEV

      r  : ARRAY[1..2] OF NH_ROW_O_D1;       // dash 2,3
   END_STRUCT;
	NH_FRM_016 {HIDDEN}:  STRUCT 	// 16 FRM - ROM/ZON  security parameter
      hed : NH_FRM_HED := (Name:='_016',wht:=2,row:=1,sld:=8);
      r  : ARRAY[0..0] OF NH_ROW_O := [( ob := [
            (wh:=20, x:= x2-60  , y:= y1 + 80,   w:= 48     , FgC := 0,  BgC :=50           , fn := 401           ), // 0 Zamykat zonu
            (wh:=13, x:= 50     , y:= y1 + 200,   w:= x2-110  ,FgC := 4, BgC := 8          , fn := 0             ), // 1 odchod.oneskorenie
            (wh:=13, x:= 50     , y:= y1 + 320,   w:= x2-110  ,FgC := 4, BgC := 6          , fn := 1             ), // 2 prichod.oneskorenie
            (wh:=13, x:= 50     , y:= y1 + 440,   w:= x2-110  ,FgC := 4, BgC := 6          , fn := 2             ), // 3 Ostrazitost
            (wh:=13, x:= 50     , y:= y1 + 560,   w:= x2-110  ,FgC := 4, BgC := 28         , fn := 3             ), // 4 Cas alarmu 1
            (wh:=13, x:= 50     , y:= y1 + 680,   w:= x2-110  ,FgC := 4, BgC := 7          , fn := 4             ), // 5 max cas

            (wh:= 0, x:= x2-60  , y:= y1 + 750,   w:= 48     , FgC := 0, BgC :=50          , fn := 420           ), // 6 prepisat do miestnosti v zone
            (wh:= 0, x:= x2-60  , y:= y1 + 750,   w:= 48     , FgC := 0, BgC :=50          , fn := 421           ), // 7 Použithodnoty z vyššej zóny

            (wh:= 0, x:= 50     , y:= y1 + 800,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 6             ), //
            (wh:= 0, x:= 50     , y:= y1 + 800,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 6             ), //
	         (wh:= 0, x:=xc      , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254)           )  // 10 info dali nbr {len admin}
                                             )];
      s  : ARRAY[0..7] OF NH_SLD_DAT :=
           [
            (t := 3, v2 := 600.0   , fmt := 's%Tm:ss m'           , txt:= 402),        // 0 odchod.oneskorenie
            (t := 3, v2 := 600.0   , fmt := 's%Tm:ss m'           , txt:= 403),        // 1 prichod.oneskorenie
            (t := 3, v2 := 600.0   , fmt := 's%Tm:ss m'           , txt:= 404),        // 2  Ostrazitost
            (t := 3, v2 := 3599.0  , fmt := 's%Tm:ss m'           , txt:= 405),			// 3 Cas alarmu 1
            (t := 3, v2 := 14400.0 , fmt := 's%Th:mm h',ink:=60.0 ,txt:= 406),			// 4

//            (t := 3, v2 := 3600.0  , fmt := 'm%Th:mm h'           , txt:=  62),        // 4 Max.cas zapnutia
//            (t := 3, v2 := 18000.0 , fmt := '1%Tm:ss.z m'         , txt:= 115),        // 5 vykont opozdene
//            (t := 1, v2 := 255.0   , fmt := 'm%Th:mm h'           , txt:= 226),        // 6 cas blokovania PIR v miestnosti po vypnuti
            (t := 0, v2 := 3000.0  , fmt := '%4.0f W'             , txt:=  69)         // 7 Prikon
              ];

   END_STRUCT;
   NH_FRM_017 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_017',desc:='MNU vazieb+list+vis',wht:=3);
      mnu      : NH_MNU := (  n := 7,				// LIST,VAZ					
								o := [			(fn :=   6,wh:=  0,cm :=  31),       // <   		
                                       (fn :=   0,wh:=  6,cm :=   0, w:=72),  // obrazok vyssej casti
                                       (fn :=  35,wh:= 38,cm :=  33),          // 3 check
                                       (fn :=  10,wh:= 11,cm :=  34),          // 4 cat
                                       (fn :=  16,wh:= 18,cm :=  35),          // 5 all.rom / 1rom
//                                       (fn := 112,wh:=113,cm :=  36),          // visible sa nahradza zretazenim
                                       (fn :=   0,wh:=  0,cm :=   0),          // visible
                                       (fn :=  39,wh:= 40,cm :=  37),          // 7-list     NESMIE SA OPRAVOVAT cm!!
                                       (fn :=  33,wh:= 34,cm :=  38)]);        // 8-play     NESMIE SA OPRAVOVAT cm!!


   END_STRUCT;
   NH_FRM_018 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_018',wht:=3);
      mnu      : NH_MNU := ( n:= 8,        // MNU - SETUP ZONE,ALARM
                        o := [
                              (fn :=  6,wh:=   0,cm :=  31),       // 1 <
                              (fn := 153,wh:=  3,cm :=  43),       // 2 dash
                              (fn :=  38,wh:= 35,cm :=  63),       // 3 check
//                              (fn :=  10,wh:= 11,cm :=  34),       // 4 cat
                              (fn :=   0,wh:=  0,cm :=   0),       // 4 cat nebude
                              (fn := 370,wh:=370,cm :=  88),       // 5 simulacie pritomnosti
                              (fn := 356,wh:=356,cm :=  87),       // 6 akcie, ktore spustaju lock/unlock
                              (fn :=  97,wh:= 97,cm :=  85),       // 7 KLA , ktore vstupuu do ZON
	                           (fn := 348,wh:=348,cm :=  85)        // 8 Rom, ktore vstupuu do ZON

                           ]);
   END_STRUCT;
   // 19-ACT,BLK
  	NH_FRM_019 {HIDDEN}  :  STRUCT
      hed : NH_FRM_HED := (Name:='_019',wht:=1,row:=3,sld:=0);
      D1 : NH_brw_SLD_D1 := (ob:= [(),(),(),(),(),(wh:=0),(wh:=1,cm:=80 )); 	//,(),(cf:=(c:=252)) );    // vypne slider a prida dev-list
      D2 : NH_brw_SLD_D2 := (ob:= [(),(),(),(),(),(wh:=0),(wh:=1,cm:=80 ));	//,(),(),(cf:=(c:=252)) );
      D3 : NH_brw_SLD_D3 := (ob:= [(),(),(),(),(),(wh:=0),(wh:=1,cm:=80 ));	//,(),(),(cf:=(c:=252))  ) ;
   END_STRUCT;

  	NH_FRM_020   {HIDDEN}  :  STRUCT               // LUX,TER,TEH,TEK
      hed : NH_FRM_HED := (Name:='_020',wht:=1,row:=3,sld:=3);
      D1 : NH_brw_LUX_D1 ;
      D2 : NH_brw_LUX_D2 ;
      D3 : NH_brw_LUX_D3 ;
      SL : NH_brw_SLD :=
            ( s := [ (v1 := -40.0,  v2 := 125.0, ink:=0.1),
                     (v1 := -40.0,  v2 := 125.0),
                     (v1 := -40.0,  v2 := 125.0)
             ]);
   END_STRUCT;

   NH_FRM_021 : STRUCT
      hed : NH_FRM_HED :=(Name:='_021',wht:=0,row:=3) ;
      D  : ARRAY[1..3] OF NH_ROW_O := [   ( ob :=[
         (Wh:=1,  x:=30,      y:=38,         w:=38,      h:=38,      nTch:=1,          FgC:=0,  BgC:=0,                      ), // 0 daymode
         (Wh:=1,  x:=80,      y:=38,         w:=38,      h:=38,      nTch:=1,          FgC:=0,  BgC:=0                       ), // 1  sviecka
         (Wh:=1,  x:=x2/2-45, y:=38,         w:=38,      h:=38,      nTch:=0,          FgC:=0,  BgC:=0,  fn := 232           ), // 2 time
         (Wh:=1,  x:=x2/2-45, y:=68,         w:=38,      h:=38,      nTch:=0,          FgC:=0,  BgC:=0,  fn := 226           )  // 3 blokovanie PIR
            ]), ( ob := [
         (Wh:=1,  x:=30,      y:=38,         w:=38,      h:=38,      nTch:=0,          FgC:=0,  BgC:=0,  fn := 232           ), // 2 time
         (Wh:=1,  x:=80,      y:=38,         w:=38,      h:=38,      nTch:=0,          FgC:=0,  BgC:=0,  fn := 226           )  // 3 blokovanie PIR
            ]), ( ob := [
         (Wh:=1,  x:=28,      y:=30,         w:=32,       h:=32,     nTch:=1,          FgC:=0,  BgC:=0,                       ), // 7
         (Wh:=1,  x:=65,      y:=30,         w:=32,       h:=32,     nTch:=1,          FgC:=0,  BgC:=0                       ) // 8
            ])];
   END_STRUCT;


	NH_FRM_022   {HIDDEN} :    STRUCT               // FRM - TVE
      hed : NH_FRM_HED := (Name:='_022',wht:=1,row:=3,sld:=0);
      D1_1_4     : NH_brw_D1_ALL := ( ob := [(),(),(),(),(cm:=76)] );
		D1_1_5	  : NH_brw_D1_GATE:= ( ob := [(wh:=0,fn:=4,cf:=(c:=1),fmt:='221220', cm:=251)]);   			// 5 MAN
      D1_1_6  	  : NH_OBJ_DAT 	:= ( wh:=22,x:=125,y:=109, fn:=1,cf:=(c:=4),h:=68,w:=48, cm:=251);          //6  auto/MAN, 0.1...3
      D1_1_7     : NH_OBJ_4O1 	:= (obj:=1, ok:=[0,0,0,0], crc:=[0,0,0,1], fil :=[0,0,0,1], txt:=[0,0,0,0], obr:=[227,234,0,410]);                          // 5=slider;
		D1_1_8	  : NH_brw_D1_FMT;                  //6] );            				// text z .Fmt {HET-teplota}
      D1_NAZ     : NH_brw_D1_NAZ;                          // 9..10 Nazov rom + DEV

      r  : ARRAY[1..2] OF NH_ROW_O_D1;
   END_STRUCT;

  	NH_FRM_023  {HIDDEN} :    STRUCT               // BRW-HET
      hed : NH_FRM_HED := (Name:='_023',wht:=1,row:=4,sld:=3);
      D1 : NH_brw_SLD_D1   := ( ob := [
         (),(wh:=228,cm:=204),
         (wh:=6,x:=x2-25,y:=38,cf:=(c:=254),BgC:=0,FgC:=4,h:=33,w:=120,fn:=1),       		// 2 teplota regulovana
         (),(cm:=32),                                                               		// 4=setup = vazby play
         (wh:=6,x:=x2-25,y:=70,cf:=(c:=254),BgC:=0,FgC:=6,h:=26,w:=120,fn:=1),       		// 5 teplota TVE
      	(wh:=1,  x:=x2-105,   y:=109,        w:=42,   fn:=39,  cm:=76),    					// 6 list - vazby TVE,KOT...
         (wh:=22,x:=125,y:=109,fn:=1,cf:=(c:=4),h:=68,w:=48, cm:=251)                      		// 7  auto/MAN, 0.1...3
               ]);
      D2 : NH_brw_SLD_D2   := ( ob := [
         (),(),(),(),(),(wh:=0),
         (wh:=1,fn:=39),  //6
         (wh:=0,FgC:=4),        // 7 cislo SCN
         (wh:=229,w:=45,x:=0,y:=-10)
               ]);
      D3 : NH_brw_SLD_D3      := ( ob := [
         (),(),(),(),(),(wh:=0),
         (wh:=1,fn:=39),  //6
         (wh:=0,FgC:=4),        // 7 cislo SCN
         (wh:=229,w:=42,x:=0,y:=0)
               ]);
      D4 : NH_brw_ROM_D4;

      SL : NH_brw_SLD;

   END_STRUCT;
   
   NH_FRM_024 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_024',wht:=3,desc:='Menu ZON');
      mnu      : NH_MNU := ( n:= 3,        // MNU - ZON
                        o := [
                              (fn :=   6,wh:=  0,cm :=  31),       // <
                              (fn :=  22,wh:= 22,cm :=   0),       //
                              (fn := 273,wh:=274,cm := 205, frm:=76),       // Typovy den
                              (fn := 130,wh:=131,cm := 205, frm:=26),       // osvetlenie/DayMode
                              (fn :=   0,wh:= 66,cm := 205),
                              (fn :=   0,wh:=191,cm :=   0),
                              (fn :=  66,wh:= 66,cm := 205, frm:=16),     // par PSN
                              (fn :=  23,wh:= 24,cm := 205, frm:=32)      // setup = typ
                           ]);
   END_STRUCT;
   NH_FRM_025 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_025',wht:=3,desc:='Menu ROM');
      mnu      : NH_MNU := ( n:= 3,        // MNU - ROM
                        o := [
                              (fn :=   6,wh:=  0,cm :=  31),       // <
                              (fn :=  18,wh:= 18,cm :=   0),       //
                              (fn := 130,wh:=131,cm := 205, frm:=26),       // osvetlenie/DayMode
                              (fn := 153,wh:=153,cm := 205, frm:=77),       // denna doba
                              (fn :=   0,wh:= 66,cm := 205),
                              (fn :=   0,wh:=191,cm :=   0),
                              (fn :=  66,wh:= 66,cm := 205, frm:=16),     // par PSN
                              (fn :=  23,wh:= 24,cm := 205, frm:=31)      // setup = typ
                           ]);
   END_STRUCT;


   NH_TD_POI : ARRAY[5..10] OF NH_OBJ_DAT :=     // Typ.Den + POI + nazov Typ.dna
          [ (wh:=15, x:= 50,     y:= y1 + 200,                       FgC := 4,  Fn :=   0,prs:=1),      // 5 OBJEKT typove dni
            (wh:=0 , x:= xc,     y:= y1 + 300, w:= 300, h:= 28,  Fn := 2, FgC := 3, cf:=(c:=250)),      // 6 nazov typoveho dna podla c vypise komponenta, do cf.n treba adresu premennej cisla typ.dna
            (wh:=14, x:= 50 ,    y:= y1 + 600, w:= x2-110, h := 200,  FgC := 4,  Fn := 315,prs:=0),     // 8 OBJEKT slider day/evening/nighy/morning
            (wh:=0 , x:= 50,     y:= y1 + 600, w:= x2-110 , FgC := 4,BgC := 5,  fn := 0, cm := 251),    // 7 slider LUPY konkretneho bodu
            (wh:=0, x:= x2-85, 	y:= y1 + 720, w:= 48     , FgC := 0, BgC :=50, fn := 224),             // 9 Sablona z Home
            (wh:=20, x:= x2-85, 	y:= y1 + 770, w:= 48     , FgC := 0, BgC :=50, fn := 225)              //10 Fix Typovy day
          ];


   NH_FRM_026  {HIDDEN} :  STRUCT 	// 26 FRM ROM sumrak
      hed : NH_FRM_HED := (Name:='_026',desc:='FRM-ROM/ZON sumrak',wht:=2,row:=1,sld:=3);
      r1    : ARRAY[0..10] OF NH_OBJ_DAT :=
         [  (wh:=20,  x:= x2- 70 , 	y:= y1 + 60,  w:= 62, Fn :=556, FgC := 5, BgC := 50),                                	// 0 text 'Sumrak v miestnosti + ikona
          	(wh:=21,  x:= x2- 70 , 	y:= y1 + 140,  w:= 45, Fn :=561, FgC := 8, BgC := 50, h:=24, cm:=89),					 // 1 ovplyvneny snimacom osvetlenia
            (wh:=221, x:= 50 ,     	y:= y1 + 200, h := 28, w:= 25 , Fn :=133, FgC :=8, BgC := 4, nTch:=1),               	// 2 text+hodnota Osvetlenie miestnosti
            (wh:=6,   x:= 50 , 		y:= y1 + 235, w:= 350, Fn := 0, FgC :=10, BgC := 0, h := 24, nTch:=1),              	// 3 nazov miestnosti/zony/snimaca
            (wh:=13,  x:= 50,      	y:= y1 + 320, w:= x2-110 , FgC := 4, BgC := 8, fn := 0, h:=250, cm := 251),         	// 4 slider osvetlenia
   	      (wh:=21,  x:= x2- 70 , 	y:= y1 + 420,  w:= 45, Fn :=565, FgC := 5, BgC := 50, h:=26, cm:=89), 						// 5 povolenie-osvetlenie z nadradenej zony
	         (wh:=21,  x:= x2- 70 , 	y:= y1 + 470,  w:= 45, Fn :=564, FgC := 5, BgC := 50, h:=26, cm:=89),  						// 6 povolenie-osvetlenie z vonkajsej zony

           	(wh:=21,  x:= x2- 70 , 	y:= y1 + 600,  w:= 45, Fn :=562, FgC := 3, BgC := 50, h:=24, cm:=89),                  // 7 ovplyvneny zaluziami
            (wh:=221, x:= 50 ,     	y:= y1 + 660, h := 28, w:= 25 , Fn :=559, FgC :=3, BgC := 4, nTch:=1),                	// 8 aktualne zatienenie zaluziami + hodnota
            (wh:=13,  x:= 50,      	y:= y1 + 760, w:= x2-110 , FgC := 4, BgC := 3, fn := 1, h:=250, cm := 251),         	// 9 slider >
            (wh:=13,  x:= 50,      	y:= y1 + 860, w:= x2-110 , FgC := 4, BgC := 2, fn := 2, h:=250, cm := 251)          	// 10 koeficient zaluzii
				];
      s  : ARRAY[0..2] OF NH_SLD_DAT :=
         [
            (t := 1, v2 := 100.0   , fmt := '%3.0f %%'               , txt:= 141),     // sumrak je  < osvetleni
            (t := 1, v2 := 100.0   , fmt := '%3.0f %%'               , txt:= 560),     // sumrak je  > zatieni
            (t := 0, v1:=1.0, v2 := 5.0   , fmt := '%4.1f', ink:=0.1       , txt:= 568)      // koeficient
         ];
   END_STRUCT;


   NH_FRM_027 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_027',wht:=3,desc:='Menu TGL');
      mnu      : NH_MNU := ( n:= 4,
                        o := [
                              (fn :=   6,wh:=  0,cm :=  31),       // <
                              (fn :=  18,wh:= 18,cm :=   0),       //
                              (fn :=  33,wh:= 34,cm := 205,frm:=90), 		// 3 Play = vyber BTN a aka akcia		CM=5
                              (fn := 204,wh:=205,cm := 205,frm:=39),   		// 4 LED TGL                    		cm:=120
                              (fn := 311,wh:=311,cm := 205,frm:=57), 		// 5 TGL-display predvolby			cm:=122
                              (fn := 311,wh:=311,cm := 205,frm:=89),			// 6 TGL-aka velicina sa ma zobrazovat	cm:=123
                              (fn :=  23,wh:= 24,cm := 205, frm:=88),     	// 7 setup click,press,hold
	                           (fn := 348,wh:=348,cm :=  82)        			// 8 Rom, ktore vstupuu do ZON

                           ]);
   END_STRUCT;
   NH_FRM_028 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_028',wht:=3);
      mnu      : NH_MNU := ( n:= 3,        // MNU-HET
                        o := [
                              (fn :=  6,wh:=   0,cm := 136),       			// 1 <
                              (fn := 183,wh:= 25,cm :=   0),       			// 2
                              (fn := 345,wh:=345,cm := 205, frm:=33),      // 3-predvolby
                              (fn := 220,wh:=221,cm := 205, frm:=30),      // 4 manual
                              (fn := 222,wh:=223,cm := 205, frm:=77),      // 5 auto
                              (fn := 190,wh:=191,cm := 205, frm:=86),    	// 6-rozdiely teplot
//                              (fn :=  0,wh:=191,cm := 205,  frm:=0),    	// 6-rozdiely teplot
                              (fn :=  77,wh:= 65,cm := 205, frm:=85),      // 8-setup
	                           (fn := 348,wh:=348,cm :=  82)        			// 7 Rom, ktore vstupuu do ZON
                           ]);
   END_STRUCT;
   NH_FRM_034 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_034',wht:=3);
      mnu      : NH_MNU := ( n:=3,
                        o := [(fn :=  6,wh:=   0,cm :=  31),(),
                              (fn :=  23,wh:= 24,cm := 205,x:=xc ,frm:=35)        // setup
                           	]);
   END_STRUCT;


   NH_FRM_029  {HIDDEN} : STRUCT      // VEN/REK setup
      hed : NH_FRM_HED := (Name:='_029',desc:='FRM-setup VEN/REK',wht:=2,row:=1,sld:=2);
      mnu   : NH_OBJ_123 := // 2 riadky
            (wh:=123,cf:=(x:= 60,     y:= y1 + 80, typ:=2, rw2:=2, h:= 50, hTxt:= 28),
                 txt:=[581,582]);                                                    // 1 rolovaci vyber textov
      ROW   : ARRAY[2..10] OF NH_OBJ_DAT :=
            [(wh:=0, x:= x2-60  , y:= y1 + 400,   w:= 48     , FgC := 0, BgC :=50, fn := 171),            	// 2 NO/NC - inv
				 (wh:=0, x:= x2-60  , y:= y1 + 450,   w:= 48     , FgC := 0, BgC :=50, fn := 419),   				// 3 Analog
				 (wh:=0, x:= x2-60  , y:= y1 + 450,   w:= 48     , FgC := 0, BgC :=50, fn := 434),            	// 4 PWM
             (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0),              // 5 cas otvorenia
             (wh:=13, x:= 50     , y:= y1 + 680,   w:= x2-110 , FgC := 4, BgC := 3, fn := 1),              // 6 opozdenie technologie
				 (wh:=0, x:= x2-60  , y:= y1 + 750,   w:= 48     , FgC := 0, BgC :=50          , fn := 228 ), // 7 Log
             (wh:=20,x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 4, BgC :=50			  	, fn := 100	), // 8 zablokovat
             (wh:=0, x:= x2-60  , y:= y1 + 860,   w:= 48     , FgC := 0, BgC :=50          , fn := 400 ) 	// 9 Externe DEV
		      ];
   	s  : ARRAY[0..1] OF NH_SLD_DAT := [
            ( t:=3, xv := x2-53, v2 :=  300.0 , fmt := 's%Tm:ss m',txt:= 167 ),      // 0 Cas otvorenia ventilu
            ( t:=1, xv := x2-53, v2 :=255.0 	 , fmt := 's%Tm:ss m',txt:= 190)   // 1 opozdenie technologie
         ];		
   END_STRUCT

   NH_DAT_TIM  {HIDDEN}  : STRUCT      // vratit na manual
      txt   : ARRAY[0..10] OF NH_OBJ_DAT :=
          [ (wh:=13,x:= 50, y:=y1+710, w:=480,FgC:=4,BgC:=3),                    // 0 slider, vo cf.c je cislo vybrateho riadka, FN v riadku znamena posuv na dalsiu premennu
            (wh:=25,x:=100, y:=y1+600, w:= 35,Fgc:=4,BgC:=3),   // 1 year. v cf.c je vybraty riadok. FN v riadku je posuv na premennu od zaciatku (YEAR)
            (wh:=25,fn:=80),               // 2 month
            (wh:=25,fn:=160),               // 3 day
            (wh:=25,fn:=290),              // 4 hour
            (wh:=25,fn:=370),              // 5 min
            (wh:=0,fn:=370),              // 6 sec
            (wh:=1,fn:= 40,fmt:='.',nTch:=1),
            (wh:=1,fn:=120,fmt:='.',nTch:=1),
            (wh:=1,fn:=330,fmt:=':',nTch:=1),
            (wh:=0,fn:=270,fmt:='.',nTch:=1)
          ];
      s  : ARRAY[0..0] OF NH_SLD_DAT :=
         [  (t:=1,v1:=1, v2:=31, zom:=0,tun:=0) ];                // slider LUPY bodu, nevypisuje sa ani text, ani hodnota

   END_STRUCT

   NH_DAT_TIM2  {HIDDEN}  : STRUCT      // vratit na manual
      txt   : ARRAY[0..10] OF NH_OBJ_DAT :=
          [ (wh:=  0,fn:=0,FgC:=0,nTch:=1,y:=y1+830),   						// 0 riadiaci obj, y:prebera sa do ostatnych riadkov
			 																					// fn:=0 znamena ze nesuvisi so ziadnym inym obj, FgC vybraty riadok
			 	(wh:=125,x:=260, w:= 28,h:=28,fmt:=' YY',FgC:=1),   			// 1 year  FgC:= typ pola YY=0,MM:=1,DD:=2,HH:=3,MM:=4 [0..FgC], Bgc:=ktore pole je vybrate pre slider
            (wh:=125,x:=320, w:= 28,h:=28,fmt:='.MM',FgC:=2),          	// 2 month
            (wh:=125,x:=380, w:= 28,h:=28,fmt:='.DD',FgC:=3),          	// 3 day
            (wh:=125,x:=460, w:= 28,h:=28,fmt:=' HH',FgC:=4),          	// 4 hour
            (wh:=125,x:=520, w:= 28,h:=28,fmt:=':MM',FgC:=5),          	// 5 min
            (wh:=  0,x:=580, w:= 28,h:=28,fmt:=':SS',FgC:=6),          	// 6 sec
            (wh:=0),
            (wh:=125, x:=50, y:=-30,   w:=200,FgC:=  3,BgC:=0, fn:=0, h:=24,cf:=(n:=533), nTch:=1), // 8 text v urovni navestie, y:=-30 je len o kolko sa ponizi y-suradnica z [0]
            (wh:=125, x:=50, 			  	w:=200,FgC:= 10,BgC:=0, fn:=0, h:=28,cf:=(n:=531), nTch:=1), // 9 text vacsinou pred datumom
//	         (wh:= 13, x:=50, y:=y1+880,w:=480,FgC:=  4,BgC:=3, fn:=0, set6:=1)    // 10 slider h:=2 znamena ze slider je v riadku 2 o[10], nevypisuje sa cislo
	         (wh:= 13, x:=50,   			w:=480,FgC:=  4,BgC:=3, fn:=0, set6:=1)    // 10 slider h:=2 znamena ze slider je v riadku 2 o[10], nevypisuje sa cislo
	         																				
			];

   END_STRUCT




//   NH_AUT_MAN {HIDDEN}  :  STRUCT 	// HOME - centralne nastavenie typ.dnea
	NH_FRM_030  {HIDDEN}  :  STRUCT 	//
      hed : NH_FRM_HED := (Name:='_030',desc:='FRM-MAN->AUT',wht:=2,row:=2,sld:=2);
		r1  	: ARRAY[0..4] OF NH_OBJ_DAT :=
			[	(),
				(wh:=6, x:=xc, y:=y1+ 50,w:=500, h:=33,cf:=(n:=150), fgC:=4, fn:=2 ),	// 1; typovy den
				(wh:=0, x:=xc, y:=y1+330,w:=500,h:=28,cf:=(n:=553), fgC:=4, fn:=2 )	// 2; riadit sa kalendarom
			];
      r1_5_6_Type : NH_OBJ_123 :=                     			// rolovacii vyber - kedy prepnut na kalendar
      	(	wh:=123,cf:=(x:= 50,     y:= y1 + 150, typ:=1, rw1:=1, rw2:=9, h:= 41, hTxt:= 28),
            txt:=[206,347,208,209,210,211,212,213,214,215]       	
			);
		r1_7_9 	: ARRAY[7..9] OF NH_OBJ_DAT;             			// len volne riadky
		r1_10 	: ARRAY[10..10] OF NH_OBJ_DAT :=             			// len info parameter
      	      [(wh:= 6, x:=xc      , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254))];  // 10 info dali nbr {len admin}

		r2	: NH_DAT_TIM2  := (txt:=                        	// zadanie datumu/casu
         [ (),(),(),(),(),(),(),(),
				(wh:=0),             										// ziadny text v urovni title
				(wh:=0)                         							// ziadny text pred datumom
			]);
	
      s  	: ARRAY[0..1] OF NH_SLD_DAT :=
         [  (t:=1,v1:=1, v2:=31, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        										// 0 slider k start
				(t := 5,v1:=1,       v2 := 1439.0  , fmt := ''          , txt :=   0, xv := x2-53, tun := 1  )    // slider LUPY bodu, nevypisuje sa ani text, ani hodnota
         ];
   END_STRUCT;
  	NH_FRM_031  {HIDDEN} :    STRUCT     //31 FRM - ROM*set typ miestnosti
      hed : NH_FRM_HED := (Name:='_031',wht:=2,row:=1,sld:=0,desc:='Typ ROM');
      txt   : ARRAY[0..0] OF NH_OBJ_DAT :=
          [(wh:=6 , x:=xc,       y:= y1 + 60,  w:= 400, h:=28, Fgc:=4, fn:=2, nTch:=1, cf:=(n:=435))];           // typ miestosti

      mnu   : NH_OBJ_123 := // 2 riadky
            (wh:=123,cf:=(x:= 100,     y:= y1 + 130, typ:=2, rw2:=7, h:= 50, hTxt:= 28),
                 txt:=[436,437,438,439,440,441,511,512]);                                                    // 1 rolovaci vyber textov
      wrk   : ARRAY[3..10] OF NH_OBJ_DAT :=
          [(wh:= 0,   x:= xc , 		y:= y1 + 690, w:= 450, Fn := 2,  FgC :=5, BgC := 0, h := 24, cf:=(c:=0,n:=563), nTch:=1),	// 3 pouzit snimac osvelenia z
           (wh:=21,  x:= x2- 70 , 	y:= y1 + 550,  w:= 45, Fn :=563, FgC := 4, BgC := 50, h:=26),    	// 4 teplotu zo zony
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 600,  w:= 45, Fn :=564, FgC := 4, BgC := 50, h:=26),     // 5 osvetlenie z vonkajsej zony
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 650,  w:= 45, Fn :=565, FgC := 4, BgC := 50, h:=26),     // 6 osvetlenie z nadradenej zony
           (wh:=21,  x:= x2- 70 , 	y:= y1 + 700,  w:= 45, Fn :=566, FgC := 4, BgC := 50, h:=26),      // 7 CO2 zo zony
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 830,  w:= 45, Fn :=566, FgC := 4, BgC := 50, h:=26),
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 875,  w:= 45, Fn :=567, FgC := 4, BgC := 50, h:=26)			
				// pred 3

			];

   END_STRUCT

//   NH_ZON_SET  {HIDDEN} : STRUCT      // ROM typ miestnosti
  	NH_FRM_032  {HIDDEN} :    STRUCT              //32 FRM - ZON*Set typ zony ....
      hed : NH_FRM_HED := (Name:='_032',wht:=2,row:=1,sld:=0,desc:='Typ ZON');

      txt   : ARRAY[0..0] OF NH_OBJ_DAT :=
          [ (wh:=6 , x:=xc,       y:= y1 + 60,  w:= 400, h:=28, Fgc:=4, fn:=2, nTch:=1, cf:=(n:=442))];           // typ miestosti
      mnu   : NH_OBJ_123 := // 2 riadky
            (wh:=123,cf:=(x:= 100,     y:= y1 + 130, typ:=2, rw2:=5, h:= 50, hTxt:= 28),
                 txt:=[443,444,445,446,447]);                                                    // 1 rolovaci vyber textov
      wrk   : ARRAY[3..10] OF NH_OBJ_DAT :=
          [(wh:= 0,  x:= xc , 		y:= y1 + 690, w:= 450, Fn := 2,  FgC :=5, BgC := 0, h := 24, cf:=(c:=0,n:=563), nTch:=1),	// 3 pouzit snimac osvelenia z
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 740,  w:= 45, Fn :=564, FgC := 4, BgC := 50, h:=22),                                    // 4
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 785,  w:= 45, Fn :=565, FgC := 4, BgC := 50, h:=22),
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 830,  w:= 45, Fn :=566, FgC := 4, BgC := 50, h:=22),
           (wh:= 0,  x:= x2- 70 , 	y:= y1 + 875,  w:= 45, Fn :=567, FgC := 4, BgC := 50, h:=22)
			];
   END_STRUCT


   NH_FRM_033  {HIDDEN} :  STRUCT 	// FRM - predvlby teploty
      hed : NH_FRM_HED := (Name:='_033',wht:=2,row:=1,sld:=5);
		PV_0_2			: ARRAY[0..2] OF NH_OBJ_DAT;
 		TX2				: NH_OBJ_DAT :=
		 		(wh:=6,  x:= x2/2   , 	y:= y1 +250, w:= 400,FgC := 4, BgC := 0, fn := 2, 	h:=33,cf:=(n:=592));   		// predvolby reguluju
		PV_4_10			: ARRAY[4..10] OF NH_OBJ_DAT;
				
      PV_SLD_XXX  	: ARRAY[0..4] OF NH_SLD_DAT :=  // definica a nazvy sliderov
         [  (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'       			   ,txt:= 83 ),     // 0 off       	txt:=cislo textu
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'      			   ,txt:= 154),     // 1 Minimum
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'      			   ,txt:= 156),     // 2 Normal	
            (t:=0,	xv := x2-53, v1 := 0.0, v2 :=100.0 , fmt := '%5.0f %%'						,txt:= 165),     // 3 Maximum
            (t:=1, 	xv := x2-53, v2 :=255.0, 				 fmt := 's%Tm:ss m'						,txt:= 190) 	  // 4 opozdenie technologie			
			];

   END_STRUCT;

	NH_FRM_035  {HIDDEN}  :  STRUCT 	//
      hed : NH_FRM_HED := (Name:='_035',desc:='FRM-TER/TEH/TEK Stp',wht:=2,row:=1,sld:=4);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=221,x:= 50	,y:= y1 + 100, w:= 25 , 	h := 30,  	FgC :=10, BgC := 5,	Fn :=132,),     			// 0 hodnota zo snimaca
            (wh:=13, x:= 50   ,y:= y1 + 220, w:= x2-110, h := 251,	FgC := 4, BgC := 3, 	fn := 0),            	// 1 Korekcia - Konverzý faktor
            (wh:=221,x:= 50	,y:= y1 + 310, w:= 25 , 	h := 30,  	FgC := 3, BgC := 5, 	fn :=149,),          	// 2 hodnota po korekcii
           	(),
            (),
            (),
            (wh:=13, x:= 50   ,y:= y1 + 500, w:= x2-110 , h := 251,	FgC := 4, BgC := 2, 	fn := 1),              	// 6 povolena zmena
            (wh:=13, x:= 50   ,y:= y1 + 600, w:= x2-110 , h := 251,	FgC := 4, BgC := 2, 	fn := 2),              	// 7 opozdnie zmeny
            (wh:=13, x:= 50   ,y:= y1 + 700, w:= x2-110 , h := 251,	FgC := 4, BgC := 2, 	fn := 3),              	// 8
			   (wh:=20, x:=x2-60 ,y:= y1 + 820, w:= 48     , 				FgC := 0, BgC :=50, 	fn := 241),	  				// 9 neposielat do room
			   (wh:=20, x:=x2-60 ,y:= y1 + 880, w:= 48     , 				FgC := 4, BgC :=50, 	fn := 100)  				//10 zablokovat

       )];
      s  : ARRAY[0..3] OF NH_SLD_DAT := [
            ( t:=0, xv := x2-53, v1:=-20.0, 	v2 := 20.0 ,  fmt := '%+5.1f °C',   txt:= 119, ink:=0.1),      	// 0 Korekcia - Konverzý faktor	
            ( t:=0, xv := x2-53, v1:=0.0, 	v2 := 10.0 ,  fmt := '%5.1f', 		txt:= 121, ink:=0.1),			// 1 povolena zmena
            ( t:=1, xv := x2-53, v1:=0.0, 	v2 := 254.0 , fmt := '%5.0f',   		txt:= 122),      					// 2 opozdenie zmeny
            ( t:=3, xv := x2-53, v1:=0.0, 	v2 := 3600.0, fmt := 's%Th:mm:ss h', 	txt:= 609)       					// 3 odoberat vzorky
			];
   END_STRUCT;

   NH_FRM_036 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_036',wht:=3);
      mnu      : NH_MNU := ( n:= 3,        // 7 MNU - TVE/VEN
                        o := [
                              (fn :=  6,wh:=   0,cm := 136),       		// < 1
                              (fn := 183,wh:= 25,cm :=   0),       		// 2
                              (fn := 344,wh:=345,cm := 205, frm:=33),  	// 3-predvolby
                              (fn := 220,wh:=221,cm := 205, frm:=30),   // 4 manual
                              (fn :=   0,wh:=191,cm :=   0, frm:= 0),   // 5-auto
                              (fn := 369,wh:=370,cm := 205, frm:=38), 	// 6-ochrana pred teplotou
	                           (fn := 348,wh:=348,cm :=  82),        		// 7-Rom, ktore vstupuu do ZON
                              (fn :=  23,wh:= 24,cm := 205, frm:=37)    // 8-setup TVE

                           ]);
   END_STRUCT;


   NH_FRM_037  {HIDDEN} : STRUCT      // TVE setup
      hed      : NH_FRM_HED := (Name:='_037',wht:=2,row:=1,sld:=2);
      mnu   : NH_OBJ_123 := // 2 riadky
            (wh:=123,cf:=(x:= 60,     y:= y1 + 80, typ:=2, rw2:=6, h:= 50, hTxt:= 28),
                 txt:=[466,467,468,469,470,471]);                                                    // 1 rolovaci vyber textov
      ROW   : ARRAY[2..10] OF NH_OBJ_DAT :=
            [(wh:=20, x:= x2-60  , y:= y1 + 400,   w:= 48     , FgC := 0, BgC :=50, fn := 171),            	// 2 NO/NC - inv
				 (wh:=0, x:= x2-60  , y:= y1 + 450,   w:= 48     , FgC := 0, BgC :=50, fn := 419),   				// 3 Analog
				 (wh:=20, x:= x2-60  , y:= y1 + 450,   w:= 48     , FgC := 0, BgC :=50, fn := 434),            	// 4 PWM
             (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0),              // 5 cas otvorenia
             (wh:=13, x:= 50     , y:= y1 + 680,   w:= x2-110 , FgC := 4, BgC := 3, fn := 1),              // 6 opozdenie technologie
				 (wh:=20, x:= x2-60  , y:= y1 + 750,   w:= 48     , FgC := 0, BgC :=50          , fn := 228 ), // 7 Log
             (wh:=20, x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 4, BgC :=50			  	, fn := 100	), // 8 zablokovat
             (wh:=20, x:= x2-60  , y:= y1 + 860,   w:= 48     , FgC := 0, BgC :=50          , fn := 400 ) 	// 9 Externe DEV
		      ];
   	s  : ARRAY[0..1] OF NH_SLD_DAT := [
            ( t:=3, xv := x2-53, v2 :=  300.0 , fmt := 's%Tm:ss m',txt:= 167 ),      // 0 Cas otvorenia ventilu
            ( t:=1, xv := x2-53, v2 :=255.0 	 , fmt := 's%Tm:ss m',txt:= 190)   // 1 opozdenie technologie
         ];		
   END_STRUCT


   NH_FRM_038  {HIDDEN}  :  STRUCT 	// FRM - predolby teploty
      hed      : NH_FRM_HED := (Name:='_038',wht:=2,row:=1,sld:=7);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
				(wh:=21, x:= x2-70  , y:= y1 + 60,  w:= 45, Fn :=598, FgC := 4, BgC := 50, 	h:=28),			 	// 0 zapnut tepelnu ochanu

           	(wh:=6 , x:=xc,       y:= y1 + 160,  w:= 400, h:=28, Fgc:=4, fn:=2, nTch:=1, cf:=(n:=47)),   	// 1 Teplotna ochrana-kurenie
            (wh:=13, x:= 50     , y:= y1 + 300,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0),              	// 2 min teplota
            (wh:=13, x:= 50     , y:= y1 + 380,   w:= x2-110 , FgC := 4, BgC := 18, fn := 1),              	// 3 max.teplotoa
            (wh:=13, x:= 50     , y:= y1 + 460,   w:= x2-110 , FgC := 4, BgC := 8, fn := 2),              	// 4 Optimalna teplota - zelena
           	
	  			(wh:=6 , x:=xc,       y:= y1 + 570,  w:= 400, h:=28, Fgc:=4, fn:=2, nTch:=1, cf:=(n:=580)),  	// 5 Teplotna ochrana-chladenie
            (wh:=13, x:= 50     , y:= y1 + 700,   w:= x2-110 , FgC := 4, BgC := 3, fn := 3),              	// 6 min teplota
            (wh:=13, x:= 50     , y:= y1 + 780,   w:= x2-110 , FgC := 4, BgC :=18, fn := 4),              	// 7 max.teplotoa
            (wh:=13, x:= 50     , y:= y1 + 900,   w:= x2-110 , FgC := 4, BgC := 3, fn := 6)             		// 8 max cas zapnutia


       )];
      s  : ARRAY[0..6] OF NH_SLD_DAT := [
            ( t:=1, xv := x2-53, v2 := 130.0 , fmt := '%5.0f°',   txt:= 169),      // 0 min.teplota
            ( t:=1, xv := x2-53, v2 := 130.0 , fmt := '%5.0f°',   txt:= 170),      // 1 max.teplota
            ( t:=1, xv := x2-53, v2 := 130.0 , fmt := '%5.0f°',   txt:= 110),      // 2 udrziavacia teplota
            ( t:=1, xv := x2-53, v2 := 30.0 , fmt := '%5.0f°',   txt:= 169),      // 3 Min
            ( t:=1, xv := x2-53, v2 := 30.0 , fmt := '%5.0f°',   txt:= 170),      // 4 Max
            ( t:=1, xv := x2-53, v2 := 130.0 , fmt := '%5.0f°',   txt:= 110),      // 5
			
            ( t:=3, xv := x2-53, v2 := 2880.0 , fmt := 'm%Th:mm h',txt:=  62)      // 6 MAx.cas zapnutia
         ];
   END_STRUCT;


   NH_FRM_039 {HIDDEN}:  STRUCT 	//39 FRM - LED WSB/TGL
      hed      : NH_FRM_HED := (Name:='_039',wht:=2,row:=2,sld:=8,desc:='FRM-LED:WSB/TGL');
      r  : ARRAY[1..2] OF NH_ROW_O := [( ob := [
            (wh:=13, x:= 50     , y:= y1 + 100,   w:= x2-110  ,FgC := 4, BgC := 5,h:=251   , fn := 0             ), // Den-intensita
            (wh:=13, x:= 50     , y:= y1 + 180,   w:= x2-110  ,FgC := 4, BgC := 3,h:=251   , fn := 1             ), // 253 znamena, ze zmenu slidera bude ukladat do nejakej BOOL premennej
            (wh:=13, x:= 50     , y:= y1 + 260,   w:= x2-110  ,FgC := 4, BgC := 9,h:=251   , fn := 2             ),
            (wh:=13, x:= 50     , y:= y1 + 340,   w:= x2-110  ,FgC := 4, BgC := 8,h:=251   , fn := 3             ),
            (wh:=13, x:= 50     , y:= y1 + 470,   w:= x2-110  ,FgC := 4, BgC := 5,h:=251   , fn := 4             ), // Den-cas uspatia
            (wh:=13, x:= 50     , y:= y1 + 550,   w:= x2-110  ,FgC := 4, BgC := 3,h:=251   , fn := 5             ),
            (wh:=13, x:= 50     , y:= y1 + 630,   w:= x2-110  ,FgC := 4, BgC := 9,h:=251   , fn := 6             ),
            (wh:=13, x:= 50     , y:= y1 + 710,   w:= x2-110  ,FgC := 4, BgC := 8,h:=251   , fn := 7             ),
//            (wh:= 0, x:= x2/2   , y:= y1 + 380,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=139),nTch:=1    ),  // 'Uspat po case'
            (wh:=20, x:= x2-60  , y:= y1 + 770,   w:= 48, Fn :=480,  FgC :=10, BgC := 50, h := 0, cf :=(c:=3), cm:=140  ),  // 8 LED nad funcnym tlacitkom
            (wh:=20, x:= x2-60  , y:= y1 + 830,   w:= 48     , FgC := 0, BgC :=50          , fn := 55            ),  // 9  pohyb resetuje cas
            (wh:=20, x:= x2-60  , y:= y1 + 880,   w:= 48     , FgC := 0, BgC :=50          , fn := 111           )   //10  zobudit pohybom
              ]), ( ob := [
            (wh:= 6, x:= x2/2   , y:= y1 +  40,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=137),nTch:=1    ),   // 'Svietivost'
            (wh:= 6, x:= x2/2   , y:= y1 + 410,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=139),nTch:=1    )  // 'Uspat po case'
              )];
      s  : ARRAY[0..7] OF NH_SLD_DAT :=
           [
            (t := 1,                fmt := '%3.0f %%'            , txt:= 28),        // 0 Den - intenzita
            (t := 1,                fmt := '%3.0f %%'            , txt:= 29),        // 1 Vecr
            (t := 1,                fmt := '%3.0f %%'            , txt:= 30),        // 2 Noc
            (t := 1,                fmt := '%3.0f %%'            , txt:= 31),        // 3 Rano
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 28),        // 4 Den - zas vypnutia
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 29),        // 5 Vecr
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 30),        // 6 Noc
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 31)         // 7 Rano

              ];

   END_STRUCT;

   NH_FRM_057 {HIDDEN}:  STRUCT 	//39 FRM - LED WSB/TGL
      hed      : NH_FRM_HED := (Name:='_057',wht:=2,row:=2,sld:=8,desc:='FRM-TGL-casy uspatia');
      r  : ARRAY[1..2] OF NH_ROW_O := [( ob := [
            (wh:=13, x:= 50     , y:= y1 + 100,   w:= x2-110  ,FgC := 4, BgC := 5,h:=251   , fn := 0             ), // Den-intensita
            (wh:=13, x:= 50     , y:= y1 + 180,   w:= x2-110  ,FgC := 4, BgC := 3,h:=251   , fn := 1             ), // 253 znamena, ze zmenu slidera bude ukladat do nejakej BOOL premennej
            (wh:=13, x:= 50     , y:= y1 + 260,   w:= x2-110  ,FgC := 4, BgC := 9,h:=251   , fn := 2             ),
            (wh:=13, x:= 50     , y:= y1 + 340,   w:= x2-110  ,FgC := 4, BgC := 8,h:=251   , fn := 3             ),
            (wh:=13, x:= 50     , y:= y1 + 470,   w:= x2-110  ,FgC := 4, BgC := 5,h:=251   , fn := 4             ), // Den-cas uspatia
            (wh:=13, x:= 50     , y:= y1 + 550,   w:= x2-110  ,FgC := 4, BgC := 3,h:=251   , fn := 5             ),
            (wh:=13, x:= 50     , y:= y1 + 630,   w:= x2-110  ,FgC := 4, BgC := 9,h:=251   , fn := 6             ),
            (wh:=13, x:= 50     , y:= y1 + 710,   w:= x2-110  ,FgC := 4, BgC := 8,h:=251   , fn := 7             ),
//            (wh:= 0, x:= x2/2   , y:= y1 + 380,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=139),nTch:=1    ),  // 'Uspat po case'
            (wh:=20, x:= x2-60  , y:= y1 + 770,   w:= 48, Fn :=480,  FgC :=10, BgC := 50, h := 0, cf :=(c:=3), cm:=140  ),  // 8 LED nad funcnym tlacitkom
            (wh:=20, x:= x2-60  , y:= y1 + 830,   w:= 48     , FgC := 0, BgC :=50          , fn := 55            ),  // 9  pohyb resetuje cas
            (wh:=20, x:= x2-60  , y:= y1 + 880,   w:= 48     , FgC := 0, BgC :=50          , fn := 111           )   //10  zobudit pohybom
              ]), ( ob := [
            (wh:= 6, x:= x2/2   , y:= y1 +  40,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=137),nTch:=1    ),   // 'Svietivost'
            (wh:= 6, x:= x2/2   , y:= y1 + 410,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=139),nTch:=1    )  // 'Uspat po case'
              )];
      s  : ARRAY[0..7] OF NH_SLD_DAT :=
           [
            (t := 1,                fmt := '%3.0f %%'            , txt:= 28),        // 0 Den - intenzita
            (t := 1,                fmt := '%3.0f %%'            , txt:= 29),        // 1 Vecr
            (t := 1,                fmt := '%3.0f %%'            , txt:= 30),        // 2 Noc
            (t := 1,                fmt := '%3.0f %%'            , txt:= 31),        // 3 Rano
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 28),        // 4 Den - zas vypnutia
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 29),        // 5 Vecr
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 30),        // 6 Noc
            (t := 1, v2 := 238.0  , fmt := '3%Tm:ss m'           , txt:= 31)         // 7 Rano

              ];

   END_STRUCT;

   NH_FRM_040  {HIDDEN} :  STRUCT 	// FRM - BLIKAC-jedna seria
      hed      : NH_FRM_HED := (Name:='_040',wht:=2,row:=1,sld:=7);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=13, x:= 50     , y:= y1 + 100,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0             ), // 0 Pocet bliknuti
            (wh:=13, x:= 50     , y:= y1 + 200,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 4             ), // 1 Cas ON
            (wh:=13, x:= 50     , y:= y1 + 300,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 5             ), // 2 Cas OFF
            (wh:=20, x:= x2-60  , y:= y1 + 380,   w:= 48     , FgC := 0, BgC :=50          , fn := 399           ), // 3 rovnaka uroven
            (wh:=13, x:= 50     , y:= y1 + 480,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 1             ), // 4 Lvl ON
            (wh:=13, x:= 50     , y:= y1 + 560,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 2             ), // 5 Lvl OFF
            (wh:=13, x:= 50     , y:= y1 + 640,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 3             ), // 6 rampa
            (wh:=13, x:= 50     , y:= y1 + 780,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 6             ), // 7 Odlozenie startu
            (wh:=20, x:= x2-60  , y:= y1 + 835,   w:= 48     , FgC := 0, BgC :=50          , fn := 59            ), // 8  Po startom vypnut
            (wh:=20, x:= x2-60  , y:= y1 + 885,   w:= 48     , FgC := 0, BgC :=50          , fn := 60            )  // 9  Na konci vypnut

              )];
      s  : ARRAY[0..6] OF NH_SLD_DAT :=
           [
            (t := 1, v1:=1.0, v2:=255.0,  fmt := '%3.0f'          , txt:= 86),                  // 0 pocet bliknuti
            (t := 1,                      fmt := '%3.0f %%'       , txt:=252),                  // 1 lvl-ON
            (t := 1,                      fmt := '%3.0f %%'       , txt:=253),                  // 2 lvl-OFF
            (t := 1,          V2:=15.0,   fmt := '%2.0f'          , txt:=364),                  // 3 rampa
            (t := 3,          v2:= 1200.0,fmt := '5%Tm:ss.zz m'   , txt:= 87,ink:=1.0),       // 4 t-On
            (t := 3,          v2:= 1200.0,fmt := '5%Tm:ss.zz m'   , txt:= 88,ink:=1.0),       // 5 t-Off
            (t := 3,          v2:= 3000.0,fmt := '1%Tm:ss.z m'    , txt:=73, ink:=1.0)          // 6 Odlozenie startu
              ];
   END_STRUCT;

   NH_FRM_041 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_041',wht:=3);
      mnu      : NH_MNU := ( n:= 3,                                // nastavenie parMWTROV
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,x:=xc-90  ,frm:=40),       // par.bliknutie jednej serie
                              (fn := 196,wh:=197,cm := 205,x:=xc	  ,frm:=42),        // pocet serii
										(fn := 348,wh:=348,cm :=  82,x:=xc+90				)			// ROM->DEV
                           ]);
   END_STRUCT;

   NH_FRM_042 {HIDDEN}  :  STRUCT 	// FRM - BLIKAC-pocet serii
      hed      : NH_FRM_HED := (Name:='_042',wht:=2,row:=1,sld:=5);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=13, x:= 50     , y:= y1 + 150,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0             ), // 0 Pocet serii
            (wh:=13, x:= 50     , y:= y1 + 250,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 1             ), // 1 LVL do dalse serie
            (wh:=13, x:= 50     , y:= y1 + 350,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 2             ), // 2 LVL do dalse serie
            (wh:=13, x:= 50     , y:= y1 + 500,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 3             )  // 3 max cas
              )];
      s  : ARRAY[0..4] OF NH_SLD_DAT :=
           [
            (t := 1, v1:=1.0, v2:=255.0,  fmt := '%3.0f'          , txt:= 89),               // 0 pocet serii
            (t := 1,                      fmt := '%3.0f %%'       , txt:=397),               // 1 lvl- Next serie
            (t := 3,          v2:=36000.0,fmt := 's%Th:mm:ss h'   , txt:=398,ink:=1.0),     // 2 t-cakanie do dalsej serie
            (t := 3, v1:=0.0, v2:= 1440.0,fmt := 'm%Th:mm h'      , txt:=62,ink:=1.0)        // 3 max.cas zapnutia

              ];
   END_STRUCT;

  	NH_FRM_043  {HIDDEN} :    STRUCT               // BRW:  SVD,SVA,RGB,ZAS,SIR,DOR,WIN,
      hed      : NH_FRM_HED := (Name:='_043',wht:=1,row:=3,sld:=3);
      D1_1_4      : NH_brw_D1_ALL;                          // 0..4 : podklad/dev/stat/fav/
      D1_5_SLD    : NH_brw_D1_SLD;   				// 5=slider
      D1_6_PIR    : NH_brw_D1_PIR;	//ARRAY[6..6] OF NH_OBJ_DAT ;
//      D1_7        : NH_OBJ_4O := (wh:= 0, obj:=1, ok:=[1,0,0,1], crc:=[1,1,1,1], FgT:= [1,1,4,1], BgC:=[10,7,7,10],  txt:=[1,0,1,1], obr:=[0,0,0,1] );                // 8 = time/blkPIR na dstavom
//      D1_8        : NH_OBJ_4O := (wh:=107, obj:=2, ok:=[1,1,0,0], crc:=[1,0,1,1], FgT:= [1,1,4,1], BgC:=[10,0,7,10], txt:=[1,0,1,1], wxy :=[34,34,34,34] ), cm:=[44];  // 8 = time/blkPIR na dstavom
      D1_7        : NH_OBJ_4O1 := (wh:=0);              														// 7 = DayMode/Sviecka
      D1_8        : NH_OBJ_4O2;	// := (wh:=107, obj:=2, cmd :=[44,45], FgT:= [1,1,4,1], BgC:=[10,0,7,10]);       // 8 = Time-OFF/BlokPir
      D1_9_10NAZ  : NH_brw_D1_NAZ;                                // 9..10 Nazov rom + DEV

      D2  : NH_ROW_O_D1;       // dash 2
      D3  : NH_ROW_O_D1;       // dash 3

      SL : NH_brw_SLD;
   END_STRUCT;

   NH_FRM_044  {HIDDEN} :  STRUCT 	// FRM - setup SVD,SVA,ZAS,SIR
      hed      : NH_FRM_HED := (Name:='_044',wht:=2,row:=1,sld:=6);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=20, x:= x2-60  , y:= y1 +  60,   w:= 48     , FgC := 4, BgC :=50          , fn := 100          ), // 0 zablokovat
            (wh:=20, x:= x2-60  , y:= y1 + 110,   w:= 48     , FgC := 0, BgC :=50          , fn := 106          ), // 1 Inverzna funkcia
            (wh:=20, x:= x2-60  , y:= y1 + 860,   w:= 48     , FgC := 0, BgC :=50          , fn := 400          ), // 2 Externe DEV
            (wh:=20, x:= x2-60  , y:= y1 + 160,   w:= 48     , FgC := 0, BgC :=50          , fn := 146          ), // 3 Obnovit LVL po restarte
            (wh:=13, x:= 50     , y:= y1 + 260,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0            ), // 4 Prikon
            (wh:=13, x:= 50     , y:= y1 + 350,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 1            ), // 5 Stmievatelne minimum
            (wh:=13, x:= 50     , y:= y1 + 440,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 2            ), // 6 Efektivne maximum
            (wh:=20, x:= x2-60  , y:= y1 + 520,   w:= 48     , FgC := 0, BgC :=50          , fn := 153          ), // 7 Vlastne stmievani
            (wh:= 0, x:= 50     , y:= y1 + 620,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 3            ), // 8 krok stmievania Fade Rate
            (wh:= 0, x:= 50     , y:= y1 + 700,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 4            ), // 9 Fade Time
            (wh:=13, x:= 50     , y:= y1 + 800,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 5            ) //10 opozdene zazatie  po vypnuti
              )];
      s  : ARRAY[0..5] OF NH_SLD_DAT :=
           [
            (t := 0,      		v2:= 3000.0 , fmt := '%4.0f W'            , txt:=  69),        // 0 Prikon
            (t := 1                       , fmt := '%3.0f %%'       		, txt:=  70),      	// 1 stmievatelne minimum
            (t := 1                       , fmt := '%3.0f %%'       		, txt:=  71),       	// 2 efektivma maximum
            (t := 1, v1:=1.0, v2:=10      , fmt := '%3.0f'        		, txt:= 365),       	// 3 krok stmievania Fade Rate
            (t := 1, v1:=1.0, v2:=10      , fmt := '%3.0f'         		, txt:= 364),       	// 4 Fade Time
            (t := 1,          v2:=50.0 	, fmt := '1%Ts.z s'           , txt:= 145)        	// 5 opozdene zazati  po vypnuti
              ];
   END_STRUCT;
   NH_FRM_045 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_045',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  // MNU-SVD,SVA,SCN
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,x:=xc-90 	,frm:=9	),        // parametre
                              (fn :=  23,wh:= 24,cm := 205,x:=xc		,frm:=44	),        // setup
										(fn := 348,wh:=348,cm :=  82,x:=xc+90				),        // ROM ->
										(fn :=   0,wh:= 73,cm := 205,x:=xc+180,frm:=91  )         // typ ZAS
                           ]);
   END_STRUCT;
   NH_FRM_046 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_046',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  // MNU-SVD,SVA,
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,x:=xc-135 	,frm:= 9),        // parametre
                              (fn := 124,wh:=125,cm := 205,x:=xc-45  	,frm:=47),        // RGB
										(fn := 348,wh:=348,cm :=  82,x:=xc+45			  ),			// ROM->DEV
                              (fn :=  23,wh:= 24,cm := 205,x:=xc+135 	,frm:=44)        // setup
                           ]);
   END_STRUCT;

   NH_FRM_047 {HIDDEN}  :  STRUCT 	// FRM - RGB
      hed      : NH_FRM_HED := (Name:='_047',wht:=2,row:=1,sld:=5);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
				(wh:=0),
            (wh:=112, x:= xc-5  , y:= y1 + 280,   w:= 500, fn := 126, prs:=true),      										// 1 RGB obrazok 6/1
            (wh:=113, x:= 100   , y:= y1 + 590,   w:= 800, fn := 42, h:= 42, prs :=true  	            ), 	// 2 predvolby
            (wh:=13, x:= 50     , y:= y1 + 660,   w:= x2-200  ,FgC := 7, BgC := 7, h := 8 , fn := 0            ), 	// 3 R
            (wh:=13, x:= 50     , y:= y1 + 720,   w:= x2-200  ,FgC := 8, BgC := 8, h := 8 , fn := 1            ), 	// 4 G
            (wh:=13, x:= 50     , y:= y1 + 780,   w:= x2-200  ,FgC := 9, BgC := 9, h := 8 , fn := 2            ), 	// 5 B
            (wh:=13, x:= 50     , y:= y1 + 840,   w:= x2-200  ,FgC := 4, BgC := 4, h := 8 , fn := 3            ), 	// 6 CW
            (wh:=13, x:= 50     , y:= y1 + 900,   w:= x2-200  ,FgC :=30, BgC :=30, h := 8 , fn := 4            ),	 	// 7 WW - amber
            (wh:= 0, x:= 50     , y:= y1 + 700,   w:= x2-110  ,FgC := 4, BgC := 3         , fn := 4            ), 	// 8
            (wh:= 0, x:= 50     , y:= y1 + 800,   w:= x2-110  ,FgC := 4, BgC := 2         , fn := 5            ) 	// 9
              )];
      s  : ARRAY[0..5] OF NH_SLD_DAT :=
           [

            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 ),        // 0 R
            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 ),        // 1 G
            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 ),        // 2 B
            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 ),        // 3 WW
            (t := 1, v2 := 255.0  , fmt := '>%3.0f', zom := 0 )         // 4 CW
              ];
   END_STRUCT;

	NH_FRM_048  {HIDDEN} :    STRUCT               // 5 BRW-dali-MASTER
      hed      : NH_FRM_HED := (Name:='_048',wht:=1,row:=3,sld:=3);
      D1_1_4     : NH_brw_D1_ALL;
		D1_1_6	  : NH_brw_D1_GATE;
      D1_6_SLD   : NH_brw_D1_SLD	:= ( ob := ( x := 170, w:=300, BgC:=7 ) );                          // 5=slider
      D1_7       : NH_OBJ_4O1 	:= (  wh:=0 );                          // 5=slider;
      D1_8       : NH_OBJ_4O2    := (  wh:=0 );
      D1_NAZ     : NH_brw_D1_NAZ;                          // 9..10 Nazov rom + DEV

      r  : ARRAY[1..2] OF NH_row_O_D1;
   	
		SL : NH_brw_SLD;
   END_STRUCT;

   NH_FRM_049 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_049',wht:=3);
      mnu      : NH_MNU := ( n:=8,                                  // MNU-SVD,SVA,
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (),
                              (),
                              (),										
                              (),										
                              (),										
                              (fn :=  23,wh:= 24,cm := 205,x:=xc ,frm:=50)        // setup - default pre ALA
                           ]);
   END_STRUCT;

   NH_FRM_050  {HIDDEN} :  STRUCT 	// FRM - setup ALA
      hed      : NH_FRM_HED := (Name:='_050',wht:=2,row:=1,sld:=1);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=20, x:= x2-60  , y:= y1 + 210,   w:= 48     , FgC := 0, BgC :=50          , fn := 450          ), // 1 Qr = prvy vstup podla LVL alarmu
            (wh:=20, x:= x2-60  , y:= y1 + 280,   w:= 48     , FgC := 0, BgC :=50          , fn := 451          ), // 2 pohyb
            (wh:=0,  x:= x2-60  , y:= y1 + 480,   w:= 48     , FgC := 0, BgC :=50          , fn := 453          ), // 4 Ostražitost ukoncena
            (wh:=0,  x:= x2-60  , y:= y1 + 560,   w:= 48     , FgC := 0, BgC :=50          , fn := 454          ), // 5 Stráženie obnovené
            (wh:=0, 	x:= x2-60  , y:= y1 + 510,   w:= 48     , FgC := 0, BgC :=50          , fn := 0            ), // 6
				(wh:=6 , x:= xc,      y:= y1 +  90,   w:= 500, h:= 28,  Fn := 2, FgC := 4,   cf:=(n:=449)),                      // 0 nazov: Tyzdenny program
            (wh:=13, x:= 50     , y:= y1 + 390,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0            )  // 8 Filter pohybu
              )];
      s  : ARRAY[0..0] OF NH_SLD_DAT :=
           [
            (t := 3,      		v2:= 300.0 , fmt := 's%Tm:ss m'            , txt:=  452)        //
              ];


   END_STRUCT;

	NH_FRM_051 {HIDDEN}:  STRUCT 	// FRM parametre GATE
      hed      : NH_FRM_HED := (Name:='_051',wht:=2,row:=1,sld:=4);
      r  : ARRAY[0..0] OF NH_ROW_O := [( ob := [
            (wh:= 0, x:= 50     , y:= y1 + 100,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0             ), // 0 otvorit na
            (wh:= 0, x:= 50     , y:= y1 + 200,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 1             ), // 1 vykonat s opozdenim
            (wh:= 0, x:= 50     , y:= y1 + 350,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 2             ), // 2 zatvorit po case
            (wh:= 0, x:= 50     , y:= y1 + 450,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 3             ), // 3 zatvorit po case pri lck
            (wh:= 0, x:= x2-60  , y:= y1 + 520,   w:= 48     , FgC := 0, BgC :=50          , fn := 55            ), // 4 pritomnost resetuje cas zatvorenia
            (wh:= 0, x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 4, BgC :=50			  , fn := 100           ), // zablokovat
				(),
				(),
				(),
				(),
            (wh:= 0, x:=xc      , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254)           )  // 10 info
				                                 )];
      s  : ARRAY[0..3] OF NH_SLD_DAT :=
           [
            (t := 1, v2 := 100.0, fmt := '%3.0f %%'            , txt:= 456),
            (t := 3, v2 := 60.0 , fmt := '%3.0f m'   	, txt:= 115),
            (t := 1, v2 := 60.0 , fmt := '%3.0f m'         		, txt:= 457),
            (t := 1, v2 := 60.0 , fmt := '%3.0f m'         		, txt:= 458)
              ];
   END_STRUCT;

	NH_FRM_052 {HIDDEN}:  STRUCT 	// FRM setup GATE
      hed      : NH_FRM_HED := (Name:='_052',wht:=2,row:=1,sld:=3);
      r  : ARRAY[0..0] OF NH_ROW_O := [( ob := [
            (wh:= 0, x:= 50     , y:= y1 + 100,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0             ), // 0 cas impulzu
            (wh:= 0, x:= 50     , y:= y1 + 200,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 1             ), // 1 reverzny cas
            (wh:= 0, x:= 50     , y:= y1 + 300,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 2             ), // 2 cas otvorenia
            (wh:= 0, x:= 50     , y:= y1 + 400,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 3             ), // 3 cas zatvorenia
            (wh:= 0, x:= x2-60  , y:= y1 + 500,   w:= 48     , FgC := 0, BgC :=50          , fn := 117           ), // 4 pouzit HW koncovy snimac
            (wh:=20, x:= x2-60  , y:= y1 + 550,   w:= 48     , FgC := 0, BgC :=50          , fn := 124  	      ), // 5 Koncovy snimac su dvere
            (wh:= 0, x:= x2-60  , y:= y1 + 600,   w:= 48     , FgC := 0, BgC :=50          , fn := 465           ), // 6 samostatne rele Open/Close
            (wh:=20, x:= x2-60  , y:= y1 + 650,   w:= 48     , FgC := 0, BgC :=50          , fn := 461           ), // 7 rele open is real
            (wh:= 0, x:= x2-60  , y:= y1 + 700,   w:= 48     , FgC := 0, BgC :=50          , fn := 462           ), // 8 rele close is real
            (wh:=20, x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 0, BgC :=50          , fn := 228           ), // 9 Log
            (wh:=20, x:= x2-60  , y:= y1 + 850,   w:= 48     , FgC := 4, BgC :=50			  , fn := 100           )  // 10 zablokovat

              )];
      s  : ARRAY[0..3] OF NH_SLD_DAT :=
           [
            (t := 1, v2 := 100.0    , fmt := '1%Ts:z s'          	, txt:= 116),
				(t := 1, v1:= 1, v2 := 100.0    , fmt := '1%Ts:z s'          	, txt:= 98),
            (t := 3, v2 := 1800.0 , fmt := '1%Tm:ss m'         	, txt:= 459),
            (t := 3, v2 := 1800.0 , fmt := '1%Tm:ss m'         	, txt:= 460)
              ];

   END_STRUCT;
   NH_FRM_053 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_053',desc:='MNU: ROM->DEV',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  				// MNU-GATE
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,x:=xc-90 ,frm:=51),        // parametre
										(fn := 348,wh:=348,cm :=  82,x:=xc   			),			// ROM->DEV
                              (fn :=  23,wh:= 24,cm := 205,x:=xc+90 ,frm:=52)        // setup

                           ]);
   END_STRUCT;
   NH_FRM_054 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_054',wht:=3);
      mnu      : NH_MNU := ( n:=8,
									o := [		(fn :=   6,wh:=  0,cm :=  31),       // <
                                       (fn :=   0,wh:=  6,cm :=   0, w:=72),  // obrazok vyssej casti
                                       (fn :=  35,wh:= 38,cm :=  33),          // 3 check
                                       (),          										// 4 cat
                                       (),          										// 5 all.rom / 1rom
                                       (),          										// 6 priradit rom
                                       (),          										// 7-list
                                       (fn := 348,wh:=348,cm :=  82)]
											);
   END_STRUCT;

	NH_FRM_055 {HIDDEN}:  STRUCT 	// FRM cfg DOR,WIN,CO2...
      hed      : NH_FRM_HED := (Name:='_055',wht:=2,row:=1,sld:=3);
      r  : ARRAY[0..0] OF NH_ROW_O := [( ob := [
            (wh:=20, x:= x2-60  , y:= y1 + 100,   w:= 48     , FgC := 0, BgC :=50          , fn := 101           ), // 0 signal je pri rozopnuti
            (wh:=13, x:= 50     , y:= y1 + 230,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 0             ), // 1 znizenie citlivosti unLOCK
            (wh:=20, x:= x2-60  , y:= y1 + 300,   w:= 48     , FgC := 0, BgC :=50          , fn := 227           ), // 2 je sucastou alarm
            (wh:=13, x:= 50     , y:= y1 + 400,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 1             ), // 3 znizenie citlivosti LOCK
            (wh:=13, x:= 50     , y:= y1 + 500,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 2             ), // 4 OFF-autoreset
            (wh:=20, x:= x2-60  , y:= y1 + 600,   w:= 48     , FgC := 0, BgC :=50          , fn := 102           ), // 5 jeden tamper
            (wh:=20, x:= x2-60  , y:= y1 + 650,   w:= 48     , FgC := 0, BgC :=50          , fn := 103           ), // 6 dvojite vyvazenie
            (wh:=20, x:= x2-60  , y:= y1 + 750,   w:= 48     , FgC := 0, BgC :=50          , fn := 228           ), // 7 Log
            (wh:=20, x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 4, BgC :=50			  , fn := 100			   ), // 8 zablokovat
            (wh:=20, x:= x2-60  , y:= y1 + 860,   w:= 48     , FgC := 0, BgC :=50          , fn := 400           ) 	// 9 Externe DEV
              )];
      s  : ARRAY[0..2] OF NH_SLD_DAT :=
           [
            (t := 1, v2 := 100.0  , fmt := '%3.0f'       		, txt:= 104),
            (t := 1, v2 := 100.0  , fmt := '%3.0f'       		, txt:= 463),
            (t := 3, v2 := 1800.0 , fmt := 's%Tm:ss m'         , txt:= 464)
              ];

   END_STRUCT;
   NH_FRM_056 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_056',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  // MNU-SVD,SVA,SCN
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (w:=72),
                              (fn :=  23,wh:= 24,cm := 205,x:=xc-45	,frm:=55	), 	// 3 setup
										(fn := 348,wh:=348,cm :=  82,x:=xc+45				)		// 4 ROM->DEV
                           ]);
   END_STRUCT;

	NH_FRM_058  {HIDDEN}  :  STRUCT 	// FRM - tune LUX,CO2,CO...
      hed      : NH_FRM_HED := (Name:='_058',wht:=2,row:=1,sld:=6);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=221,x:= 50	,y:= y1 +  60, w:= 25 , 	h := 33,  	FgC := 4, BgC := 5,	Fn :=132,),     			// 0 hodnota zo snimaca
            (wh:=13, x:= 50   ,y:= y1 + 170, w:= x2-110, h :=251,		FgC := 4, BgC := 8, 	fn := 1),            	// 1 Hodnota minimum
            (wh:=13, x:= 50   ,y:= y1 + 250, w:= x2-110, h :=251,		FgC := 4, BgC := 6, 	fn := 2),              	// 2 Hodnota maximum
				(wh:=221,x:= 50	,y:= y1 + 320, w:= 25 , 	h := 30, 	FgC := 4, BgC := 5, 	fn :=149),              // 3 hodnota 0..100%

            (wh:=13, x:= 50   ,y:= y1 + 440, w:= x2-110, h :=251,		FgC := 4, BgC := 3, 	fn := 0),            	// 4 Korekcia - Konverzý faktor
            (wh:=221,x:= 50	,y:= y1 + 480, w:= 25 , 	h := 33,  	FgC :=4,  BgC := 3, 	fn :=120,),          	// 5 hodnota po korekcii

				(wh:=13, x:= 50   ,y:= y1 + 600, w:= x2-110 ,h :=251,		FgC := 4, BgC := 2, 	fn := 3),              	// 6 povolena zmena
            (wh:=13, x:= 50   ,y:= y1 + 680, w:= x2-110 ,h :=251,		FgC := 4, BgC := 2, 	fn := 4),              	// 7 opozdnie zmeny
            (wh:=13, x:= 50   ,y:= y1 + 760, w:= x2-110 ,h :=251,  	FgC := 4, BgC := 2, 	fn := 5),              	// 8 opozdnie zmeny
			   (wh:=20, x:=x2-60 ,y:= y1 + 820, w:= 48     , 				FgC := 0, BgC :=50, 	fn := 241),	  				// 9 neposielat do room
			   (wh:=20, x:=x2-60 ,y:= y1 + 880, w:= 48     , 				FgC := 4, BgC :=50, 	fn := 100)  				//10 zablokovat
       )];

      s  : ARRAY[0..5] OF NH_SLD_DAT := [
            ( t:=0, xv := x2-53, v1:=1.0, 	v2 := 200.0,  fmt := '%5.1f',   	txt:= 148, ink:=0.1),      	// 0 Korekcia - Konverzý faktor	
            ( t:=0, xv := x2-53, v1:=-40.0, 	v2 := 1000.0, fmt := '%5.0f',   	txt:= 130),      					// 1 Hodnota minimum
            ( t:=0, xv := x2-53, v1:=-40.0, 	v2 := 1000.0, fmt := '%5.0f',   	txt:= 131),      					// 2 Hodnota maximum
            ( t:=0, xv := x2-53, v1:=0.0, 	v2 := 10.0 ,  fmt := '%5.1f', 	txt:= 121, ink:=0.1),			// 3 povolena zmena
            ( t:=1, xv := x2-53, v1:=0.0, 	v2 := 254.0 , fmt := '%5.0f',   	txt:= 122),       				// 4 opozdenie zmeny
            ( t:=3, xv := x2-53, v1:=0.0, 	v2 := 3599.0, fmt := 's%Tmm:ss m', 	txt:= 609)       			// 5 odoberat vzorky
			];

   END_STRUCT;
   NH_FRM_059 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_059',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  				// MNU-GATE
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,x:=xc-90 ,frm:=58),       	// nastavenia
										(fn := 348,wh:=348,cm :=  82,x:=xc   			),				// ROM->DEV
                              (fn :=330,wh:=330,cm := 205,x:=xc+90   ,frm:=60)       	// HW-parametre

                           ]);
   END_STRUCT;

   NH_FRM_060  {HIDDEN} : STRUCT      // HW - typ premennej
      hed      : NH_FRM_HED := (Name:='_060',wht:=2,row:=1,sld:=0);
      mnu   : NH_OBJ_123 := // 2 riadky
            (wh:=123,cf:=(x:= xc-40,     y:= y1 + 80, typ:=1, rw2:=7, h:= 50, hTxt:= 28),
                 txt:=[482,483,484,485,486,487,488]);                                                    // 1 rolovaci vyber textov
      ROW   : ARRAY[2..10] OF NH_OBJ_DAT ;
   END_STRUCT


   NH_FRM_061  {HIDDEN} :  STRUCT 	// FRM - setup SVD,SVA,ZAS,SIR
      hed      : NH_FRM_HED := (Name:='_061',wht:=2,row:=1,sld:=6);
      mnu   : NH_OBJ_123 := // 2 riadky
            (wh:=123,cf:=(x:= xc-150,     y:= y1 + 80, typ:=1, rw2:=6, h:= 50, hTxt:= 28),
                 txt:=[490,491,492,493,494,495]);                                                    // 1 rolovaci vyber textov
      ROW   : ARRAY[2..10] OF NH_OBJ_DAT := [
				(),
				(),
				(),
				(),
				(),
            (wh:=20, x:= x2-140  , y:= y1 + 700,   w:= 48     , FgC := 0, BgC :=50          , fn := 146          ), // 7 obnovit po restarte
            (wh:=20, x:= x2-140  , y:= y1 + 760,   w:= 48     , FgC := 0, BgC :=50          , fn := 506          ), // 8 RGBWA
            (wh:=20, x:= x2-140  , y:= y1 + 820,   w:= 48     , FgC := 0, BgC :=50          , fn := 228          ),  // 9 archivovat
            (wh:=20, x:= x2-140  , y:= y1 + 880,   w:= 48     , FgC := 4, BgC :=50          , fn := 100          ) //10 zablokovat

             ];

      s  : ARRAY[0..5] OF NH_SLD_DAT :=
           [
            (t := 0,      		v2:= 3000.0 , fmt := '%4.0f W'            , txt:=  69),        // 0 Prikon
            (t := 1                       , fmt := '%3.0f %%'       		, txt:=  70),      	// 1 stmievatelne minimum
            (t := 1                       , fmt := '%3.0f %%'       		, txt:=  71),       	// 2 efektivma maximum
            (t := 1, v1:=1.0, v2:=10      , fmt := '%3.0f'        		, txt:= 365),       	// 3 krok stmievania Fade Rate
            (t := 1, v1:=1.0, v2:=10      , fmt := '%3.0f'         		, txt:= 364),       	// 4 Fade Time
            (t := 1,          v2:=50.0 	, fmt := '1%Ts.z s'           , txt:= 145)        	// 5 opozdene zazati  po vypnuti
              ];
   END_STRUCT;


   NH_FRM_062 {HIDDEN}:  STRUCT 	//39 FRM - LED WSB/TGL
      hed      : NH_FRM_HED := (Name:='_062',wht:=2,row:=1,sld:=8);
      r  : ARRAY[1..2] OF NH_ROW_O := [( ob := [
            (wh:=13, x:= 50     , y:= y1 + 100,   w:= x2-110  ,FgC := 4, BgC := 7,h:=250   , fn := 0             ), // Den-intensita
            (wh:=13, x:= 50     , y:= y1 + 200,   w:= x2-110  ,FgC := 4, BgC := 8,h:=250   , fn := 1             ), // 253 znamena, ze zmenu slidera bude ukladat do nejakej BOOL premennej
            (wh:=13, x:= 50     , y:= y1 + 300,   w:= x2-110  ,FgC := 4, BgC := 9,h:=250   , fn := 2             ),
            (wh:=13, x:= 50     , y:= y1 + 400,   w:= x2-110  ,FgC := 4, BgC := 4,h:=250   , fn := 3             ),
            (wh:=13, x:= 50     , y:= y1 + 500,   w:= x2-110  ,FgC := 4, BgC :=30,h:=250   , fn := 4             ), // Den-cas uspatia
            (wh:= 0, x:= 50     , y:= y1 + 550,   w:= x2-110  ,FgC := 4, BgC := 3,h:=250   , fn := 5             ),
            (wh:= 0, x:= 50     , y:= y1 + 630,   w:= x2-110  ,FgC := 4, BgC := 9,h:=250   , fn := 6             ),
            (wh:= 0, x:= 50     , y:= y1 + 710,   w:= x2-110  ,FgC := 4, BgC := 3,h:=250   , fn := 7             ),
//            (wh:= 0, x:= x2/2   , y:= y1 + 380,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=139),nTch:=1    ),  // 'Uspat po case'
            (wh:= 0, x:= x2-60  , y:= y1 + 770,   w:= 48, Fn :=480,  FgC :=10, BgC := 50, h := 0, cf :=(c:=3), cm:=140  ),  // 8 LED nad funcnym tlacitkom
            (wh:= 0, x:= x2-60  , y:= y1 + 830,   w:= 48     , FgC := 0, BgC :=50          , fn := 55            ),  // 9  pohyb resetuje cas
            (wh:= 0, x:= x2-60  , y:= y1 + 880,   w:= 48     , FgC := 0, BgC :=50          , fn := 111           )   //10  zobudit pohybom
              ]), ( ob := [
            (wh:= 0, x:= x2/2   , y:= y1 +  40,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=137),nTch:=1    ),   // 'Svietivost'
            (wh:= 0, x:= x2/2   , y:= y1 + 410,   w:= 400    , FgC := 2, fn := 2, h:=25, cf:=(n:=139),nTch:=1    )  // 'Uspat po case'
              )];
      s  : ARRAY[0..7] OF NH_SLD_DAT :=
           [
            (t := 1, v2:=254,       fmt := '%3.0f '            , txt:= 500),        // 0 Den - intenzita
            (t := 1, v2:=254,       fmt := '%3.0f '            , txt:= 501),        // 1 Vecr
            (t := 1, v2:=254,       fmt := '%3.0f '            , txt:= 502),        // 2 Noc
            (t := 1, v2:=254,       fmt := '%3.0f '            , txt:= 503),        // 3 Rano
            (t := 1, v2:=254,       fmt := '%3.0f '            , txt:= 504)         // 4 Rano
              ];

   END_STRUCT;
   NH_FRM_063 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_063',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  				// MNU-ROL - hlavneme menu
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  85,wh:= 85,cm := 205, frm:=82),    						// nastavit roletu
                              (fn := 261,wh:=262,cm := 205, frm:=67), 	// vietor
                              (fn := 130,wh:=131,cm := 205, frm:=66),   // sumrak
                              (fn := 139,wh:=140,cm := 205),        		// Slnko
										(),
                              (fn :=  23,wh:= 24,cm := 203, frm:=81)    // setup - odskoci sadodalsieho menu o uroven dalej
                           ]);
   END_STRUCT;

   NH_FRM_064 {HIDDEN}:  STRUCT 	// FRM-ROL lvl
      hed      : NH_FRM_HED := (Name:='_064',wht:=2,row:=1,sld:=9);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
//            (wh:=0, x:= 50     , y:= y1 + 150,   w:= x2-110  ,FgC := 4, BgC := 9          , fn := 0             ), // 0 Rolete
			   (wh:=20, x:=x2-60  , y:= y1 +  60,   w:= 48     , 				FgC := 0, BgC :=50, fn := 607),	  		// 9 neposielat do room
            (wh:=0,  x:= 50    , y:= y1 + 230,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 1             ), // 1 Lamela
            (wh:=0,  x:= 50    , y:= y1 + 310,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 6             ), // 2 s opozdenim
            (wh:=6,  x:= x2/2  , y:= y1 + 150,   w:= 400    , FgC := 3, BgC := 0, fn := 2, h:=30,cf:=(n:=114)   ), // 3 text Predvolby
            (wh:=13, x:= 50    , y:= y1 + 250,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 2             ), // 4 pv1
            (wh:=13, x:= 50    , y:= y1 + 330,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 3             ), // 5 pv2
            (wh:=13, x:= 50    , y:= y1 + 410,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 4             ), // 6 pv3
            (wh:=13, x:= 50    , y:= y1 + 480,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 5             ), // 7 pv4
            (wh:=13, x:= 50    , y:= y1 + 830,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 7             ), // 8 pauza medzi predvolbami
            (wh:=13, x:= 50    , y:= y1 + 700,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 8             ), // 9 typ
            (wh:=0, x:= x2-60  , y:= y1 +  50,   w:= 48     , FgC := 0, BgC :=50          , fn := 246           ) //10 nastavit predvolenu poziciu
//            (wh:= 6, x:=xc      , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254)           )  // 10 info dali nbr {len admin}
              )];
      s  : ARRAY[0..8] OF NH_SLD_DAT :=
           [
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:= 112),        // 0 Rol
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:= 113),        // 1 LAm
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:=   0),        // 2 pv1
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:=   0),        // 3 pv2
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:=   0),        // 4 pv3
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:=   0),        // 5 pv4
            (t := 3, v2:=1800,      fmt := 's%Tm:ss m'           , txt:= 115),        // 6 opozdenie
            (t := 1, v2:=180,       fmt := '%3.0f°'              , txt:= 251),         // 7 typ uhla lamely
            (t := 1, v2:=15,        fmt := '1%Ts.z s'            , txt:= 239) // 8 pauza medzi predvolbami
              ];
   END_STRUCT;

   NH_FRM_065 {HIDDEN}:  STRUCT 	// FRM-ROL Up/dn
      hed      : NH_FRM_HED := (Name:='_065',wht:=2,row:=1,sld:=10);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
//            (wh:=6,  x:= x2/2    , y:= y1 + 50,    w:= 400    , FgC := 3, BgC := 0, fn := 2, h:=30,cf:=(n:=194)   ), // 0 text Pohyb hore
            (wh:=13, x:= 50     , y:= y1 +  80,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 0             ), // 0 Cas vytiahnutia
            (wh:=13, x:= 50     , y:= y1 + 160,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 1             ), // 1 otvorenia
            (wh:=13, x:= 50     , y:= y1 + 240,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 2             ), // 2 Opozdenie motora On/Off
            (wh:=13, x:= 50     , y:= y1 + 340,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 8             ), // 3 Opozdenie motora zmena smeru

				(wh:=13, x:= 50     , y:= y1 + 460,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 3             ), // 4 zatiahnutie
            (wh:=13, x:= 50     , y:= y1 + 540,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 4             ), // 5 zaklopenie
            (wh:=13, x:= 50     , y:= y1 + 620,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 5             ), // 6 opozdenie motora
            (wh:=13, x:= 50     , y:= y1 + 700,   w:= x2-110  ,FgC := 4, BgC := 5          , fn := 9             ), // 7 opozdenie motora zmena smeru

            (wh:=13, x:= 50     , y:= y1 + 820,   w:= x2-110  ,FgC := 3, BgC :=4          , fn := 6             ), // 8 ochranna doba - reverzia
            (wh:=13, x:= 50     , y:= y1 + 900,   w:= x2-110  ,FgC := 3, BgC :=4          , fn := 7             ), // 9 predlzit dojazd
            (wh:= 0, x:= x2-60  , y:= y1 + 830,   w:= 48     , FgC := 0, BgC :=50          , fn := 55            )  // 10
              )];
      s  : ARRAY[0..9] OF NH_SLD_DAT :=
           [
            (t := 3, v1:=500,v2:=12000,      fmt := '2%Tm:ss.z m'         	, txt:= 196, ink:=10.0),   // 0 Up Rol
            (t := 3, 			v2:=4000,     	fmt := '0%Ts.zz s'        		, txt:= 198, ink:=10.0),   // 1 Up Lam
            (t := 1, 			v2:=100,       fmt := '2%Ts.zz s'          	, txt:= 192, ink:=1.0),   // 2 Up Mot
            (t := 3, v1:=500,v2:=12000,      fmt := '2%Tm:ss.z m'         	, txt:= 197, ink:=10.0),   // 3 Dn Rol
            (t := 3, 			v2:=4000,      fmt := '0%Ts.zz s'      			, txt:= 199, ink:=10.0),   // 4 Dn Lam
            (t := 1, 			v2:=100,       fmt := '2%Ts.zz s'          	, txt:= 192, ink:=1.0),   		// 5 UpMot
            (t := 1, 			v2:=50, v1:=5, fmt := '1%Ts.z s'            	, txt:=  98),         			// 6 ochranna doba
            (t := 1, 			v2:=10,        fmt := 's%Ts s'          	   , txt:= 191),   					// 7 Predlzit dojazd
            (t := 1, 			v2:=100,       fmt := '2%Ts.zz s'          	, txt:= 240),   					//  8 opozdenie up - zmena smeru
            (t := 1, 			v2:=100,       fmt := '2%Ts.zz s'          	, txt:= 240)   					//  9 opozdenie Dn - zmena smeru
              ];
   END_STRUCT;

   NH_FRM_066 {HIDDEN}:  STRUCT 	// FRM-ROL SUMRAK
      hed      : NH_FRM_HED := (Name:='_066',wht:=2,row:=1,sld:=8);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=20, x:= x2-60  , y:= y1 +  50,   w:= 48     , FgC := 0, BgC :=50          , fn := 249           ), // 0 ovplyvnuje sumrak v miestnosti
            (wh:=13, x:= 50     , y:= y1 + 150,   w:= x2-110  ,FgC := 4, BgC := 3   		  , fn := 0             ), // 1 Rolete
            (wh:=13, x:= 50     , y:= y1 + 250,   w:= x2-110  ,FgC := 4, BgC := 3   		  , fn := 1             ), // 2 Lamela
            (wh:=13, x:= 50     , y:= y1 + 350,   w:= x2-110  ,FgC := 4, BgC := 5   		  , fn := 2             ), // 3 podiel na dark
            (wh:= 0, x:= x2/2    , y:= y1 + 370,   w:= 400    , FgC := 3, BgC := 0, fn := 2, h:=30,cf:=(n:=114)   ), // 4 text Predvolby
            (wh:= 0, x:= 50     , y:= y1 + 460,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 2             ), // 5 pv1
            (wh:= 0, x:= 50     , y:= y1 + 540,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 3             ), // 6 pv2
            (wh:= 0, x:= 50     , y:= y1 + 620,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 4             ), // 7 pv3
            (wh:= 0, x:= 50     , y:= y1 + 700,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 5             ), // 8 pv4
            (wh:= 0, x:= x2-60  , y:= y1 +  50,   w:= 48     , FgC := 0, BgC :=50          , fn := 249           ), //
            (wh:=20, x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 0, BgC :=50          , fn := 250           )  // Naklapanie lamiel HW
              )];

      s  : ARRAY[0..7] OF NH_SLD_DAT :=
           [
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:= 248),        // 0 Rol
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:= 247),        // 1 LAm
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:= 245),        // 2 podiel na Dark
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:=   0),        // 3 pv2
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:=   0),        // 4 pv3
            (t := 1, v2:=100,       fmt := '%3.0f %%'            , txt:=   0),        // 5 pv4
            (t := 3, v2:=1800,      fmt := 's%Tm:ss m'           , txt:= 115),        // 6 opozdenie
            (t := 1, v2:=180,       fmt := '%3.0f°'              , txt:= 251)         // 7 typ uhla lamely
              ];
   END_STRUCT;

   NH_FRM_067 {HIDDEN}:  STRUCT 	// FRM-ROL WIND
      hed      : NH_FRM_HED := (Name:='_067',wht:=2,row:=1,sld:=8);
      r  : ARRAY[1..1] OF NH_ROW_O := [( ob := [
            (wh:=20, x:= x2-60  ,y:= y1 +  50,   w:= 48     , FgC := 0, BgC :=50          , fn := 525           	), // 0 povolit ochranu pred vetrom
            (wh:=13, x:= 50     ,y:= y1 + 150,   w:= x2-110  ,FgC := 4, BgC :=17   		  , fn := 0             	), // 1 Silny vietor je >
            (wh:=13, x:= 50     ,y:= y1 + 230,   w:= x2-110  ,FgC := 4, BgC :=17   		  , fn := 1             	), // 2 vytiahnut po case
            (wh:=13, x:= 50     ,y:= y1 + 330,   w:= x2-110  ,FgC := 4, BgC := 8          , fn := 2             	), // 3 vratit spat po case
            (wh:=13, x:= 50     ,y:= y1 + 420,   w:= x2-110  ,FgC := 4, BgC := 8          , fn := 3             	), // 4 ak je vietor menasi ako
            (wh:=6,  x:= xc    , y:= y1 + 490,   w:= 400    , FgC := 4, BgC := 0, fn := 2, h:=28,cf:=(n:=530)   	), // 5 odlozit vratenie daymode
            (wh:=20, x:= 80  , 	y:= y1 + 540,   w:= 48, Fn :=0,  FgC :=1, BgC := 50, w:=62, h := 110, cf :=(c:=4)),	// 6 Daymode
            (wh:=20, x:= x2-60  ,y:= y1 + 610,   w:= 48     , FgC := 0, BgC :=50          , fn := 242           	), // 7 len ked fuka vietor >
            (wh:=13, x:= 50     ,y:= y1 + 710,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 4             	), // 8 smer od
            (wh:=13, x:= 50     ,y:= y1 + 790,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 5             	), // 9 smer do
            (wh:=13, x:= 50     ,y:= y1 + 900,   w:= x2-110  ,FgC := 4, BgC := 17          , fn := 6             	) //10 zablokovat rucnym zasah
              )];
      s  : ARRAY[0..7] OF NH_SLD_DAT :=
           [
            (t := 1, v2:=25,    v1:=1.0,  fmt := '%2.0f m/s'           	, txt:= 526),         // 0 silny vietor
            (t := 1, v2:=255,   v1:=1.0,  fmt := 's%Tm:ss m'           	, txt:= 527),        // 1 po akom case sa vytiahnu
            (t := 1, v2:=120,   v1:=1.0,  fmt := 'm%Th:mm h'           	, txt:= 528),        // 2 po akom èase sa vrátia
            (t := 1, v2:=25,        		fmt := '%2.0f m/s'            , txt:= 529),         // 3 ked vietor poklesne
            (t := 3, v2:=360,       		fmt := '%3.0f °'            	, txt:= 243),        // 4 WinDirFrom
            (t := 3, v2:=360,       		fmt := '%3.0f °'            	, txt:= 244),        // 5 WinDirTo
            (t := 3, v2:=360,       		fmt := 'm%Th:mm h'           	, txt:= 356),        // 6 rucny zasah blokuje
            (t := 1, v2:=180,       		fmt := '%3.0f°'              	, txt:= 251)         // 7 typ uhla lamely
              ];
   END_STRUCT;
   NH_FRM_068 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_068',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  				// MNU-GATE
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (fn := 385,wh:=385,cm := 0),
										(fn := 385,wh:=385,cm := 205,x:=xc-90, frm:=69),		// meteostanica
                              (fn := 261,wh:=262,cm := 205,x:=xc, 	frm:=80),    	// wind
                              (fn :=  23,wh:= 24,cm := 205,x:=xc+90, frm:=84)    	// setup
									]);
   END_STRUCT;

   NH_FRM_069 {HIDDEN}:  STRUCT 	// FRM-ROL lvl
      hed      : NH_FRM_HED := (Name:='_069',wht:=2,row:=1,sld:=0);
      r  : ARRAY[0..7] OF NH_OBJ_DSH := [
				(x:=xc-140,	y:=y1+180,	w:=280,	dash:=380, vMin:=  0.0, vMax:=  20.0,tx1:= 'Avg', title:=513, idx:=0, mj:='m/s'),	// rychost vetra 	
				(x:=xc+150,	y:=y1+180,	w:=280,	dash:=381, vMin:=860.0, vMax:=1090.0,tx1:= 'Min',title:=514,  idx:=1, mj:='hPa'),	// atmosfericky tlak

				(x:=xc-140,	y:=y1+400,	w:=280,	dash:=382, vMin:=-10.0, vMax:=  40.0,tx1:= 'Min', title:=515, idx:=2, mj:='°C'),		// teplota
				(x:=xc+150,	y:=y1+400,	w:=280,	dash:=382, vMin:=-10.0, vMax:=  40.0,tx1:= 'Min', title:=516, idx:=3, mj:='°C'),		// winchill - pocit.teplota

				(x:=xc-140,	y:=y1+620,	w:=280,	dash:=381, vMin:= 0.0,  vMax:= 100.0,tx1:= 'Min', title:=517, idx:=4, mj:='%'),		// relativna vlhost
				(x:=xc+150,	y:=y1+620,	w:=280,	dash:=381, vMin:= 0.0,  vMax:= 100.0,tx1:= 'Min', title:=518, idx:=5, mj:='g/m'),	// absolutna vlkost

				(x:=xc-140,	y:=y1+840,	w:=280,	dash:=380, vMin:= 0.0,  vMax:=1400.0,tx1:= 'Min', title:=519, idx:=6, mj:='W/m'),	// sl.ziarenie
				(x:=xc+150,	y:=y1+840,	w:=280,	dash:=383, vMin:= 0.0,  vMax:= 100.0,tx1:= 'Min', title:=520, idx:=7, mj:='km')		// burka
				];
      o  : ARRAY[8..10] OF NH_OBJ_DAT := [
            (wh:=101,  x:= xc        , y:= y1 + 65 ,   w:= 75     , Fgc :=3 , BgC := 3, btn:=1),       // 1 smer prudenia
            (wh:=0)    // 3 text Predvolby
              ];
   END_STRUCT;


   NH_FRM_070  {HIDDEN} : STRUCT      // ventil vody
      hed      : NH_FRM_HED := (Name:='_070',wht:=2,row:=1,sld:=1);
      mnu   : NH_OBJ_123 := // 2 riadky
            (wh:=123,cf:=(x:= xc-200,     y:= y1 + 100, typ:=1, rw2:=3, h:= 50, hTxt:= 28),
                 txt:=[521,522,523]);                                                    // 1 rolovaci vyber textov
      ROW   : ARRAY[2..10] OF NH_OBJ_DAT := [
             (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110  ,FgC := 4, BgC := 3   		   , fn := 0   ), //2 Lamela
             (wh:=20, x:= x2-60  , y:= y1 + 700,   w:= 48     , FgC := 0, BgC :=50          , fn := 146 ), // 3 obnovit stav po restarte
             (wh:=20, x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 4, BgC :=50			  	, fn := 100	) // 8 zablokovat
					];
      s  : ARRAY[0..0] OF NH_SLD_DAT :=
           [
            (t := 1, v2:=60,       fmt := '%3.0f s'            , txt:= 116)        // 0 Rol
              ];
   END_STRUCT
   NH_FRM_071 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_071',wht:=3);
      mnu      : NH_MNU := ( n:=1, 						
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn := 120,wh:=121,cm := 205, frm:=72),      // cas
                              (fn := 149,wh:=149,cm := 205, frm:=72),      // SunSet/Sunrise
                              (fn := 130,wh:=131,cm := 205, frm:=72),      // Dark/Light
                              (fn := 387,wh:=387,cm := 205, frm:=74),      // RND
//		                        (fn:= 23,wh:= 24,cm := 205, frm:=74),    		// setup
										(fn:=  0),
										(fn:=348,wh:=348,cm :=  82   			)		  	// ROM->DEV
                           ]);
   END_STRUCT;

   NH_DAYS_OF_WEEK  {HIDDEN}  : STRUCT      	// typove dni + PO-NE
      txt   : ARRAY[0..10] OF NH_OBJ_DAT :=
          [ (wh:=105,x:=70,  y:=y1+805, w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=201)),  		// 0 -> 1 PO Fgc=kruh,BgC:=text
			 	(wh:=105,x:=145,  			 w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=201)),  		// 1 -> 2 UT
			 	(wh:=105,x:=220,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=201)),   	// 2 -> 3 ST
			 	(wh:=105,x:=295,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=201)),   	// 3 -> 4 ST
			 	(wh:=105,x:=370,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=201)),   	// 4 -> 5 PI
			 	(wh:=105,x:=445,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=201)),   	// 5 -> 6 SO
			 	(wh:=105,x:=520,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=201)),   	// 6 -> 7 NE

			 	(wh:=105,x:= 70,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=202),fn:=273),   	// 7 -> 8 sviatok
			 	(wh:=105,x:=145,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=203),fn:=276),   	// 8 -> 9 party
			 	(wh:=105,x:=220,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=204),fn:=279),   	// 9 -> 10 sviatok
			 	(wh:=105,x:=295,            w:= 64,h:=64,FgC:=3,BgC:=4,cf:=(n:=205),fn:=282)   	//10 -> 11 party
			];

   END_STRUCT

   NH_FRM_072 {HIDDEN}:  STRUCT 	// FRM-TIM  0=Nacasovat,1=cyklus,2=Sunrise,3=Sunshine,4=Dark,5=Light
      hed      : NH_FRM_HED := (Name:='_072',wht:=2,row:=4,sld:=6);
      r1o0_1_Type : NH_OBJ_123 :=                     // 2 objekty
      	(	wh:=123,cf:=(x:= xc-220,     y:= y1 + 50, typ:=1, rw1:=1, rw2:=2, h:= 40, hTxt:= 28),
            txt:=[542,543,544,545,546,547]       	
			);
      r1o2_3_OnOff : NH_OBJ_123 := // On/Off/On+Off
      	(	wh:=123,cf:=(x:= xc-140,     y:= y1 + 150, typ:=1, rw2:=3, h:= 45, hTxt:= 28),
            txt:=[539,540,541]
			);
      r1o4_10  	: ARRAY[4..10] OF NH_OBJ_DAT :=
			[
            (wh:=13, x:=50    , y:= y1+ 540,w:= x2-110  ,FgC := 4, BgC := 5 , fn := 2 ), 	//2 Cas vypnutia
            (wh:=13, x:=50    , y:= y1+ 620,w:= x2-110  ,FgC := 4, BgC := 6 , fn := 3 ), 	//3 Cas zapnutia
				(wh:=0),
				(wh:=0),
				(wh:=0),
			 	(wh:=20, x:=70   , y:= y1+ 890,FgC :=13, w:=74, h := 72, cf :=(c:=3)), 			//9 Lock/Dark
			  	(wh:=20, x:=369  , y:= y1+ 730,FgC :=12, w:=48, h := 49, cf :=(c:=3))	];			//10 Daymode

		r2		: NH_DAYS_OF_WEEK;
		r3_On	: NH_DAT_TIM2:= ( txt := [          // riadok 3
						(fn:=0,FgC:=0,nTch:=1,y:=y1+320),							// fn:=0 ... hlavny {1.riadok}
						(wh:=0),
						(wh:=0),
						(wh:=0),
	      	      (wh:=125,x:=xc+130,w:= 28,h:=28,FgC:=4),          	// 4 hour
   	      	   (wh:=125,x:=xc+190,w:= 28,h:=28,FgC:=5),          	// 5 min
      	      	(wh:=  0,x:=xc+250,w:= 28,h:=28,FgC:=6),          	// 6 sec
						(wh:=0),
	   	         (wh:=0), 																			// 8 text v urovni navestie
   	   	      (wh:=125, x:=50,w:=200,FgC:=10,BgC:=0, fn:=0, h:=28,cf:=(n:=82), nTch:=1), // 9 text vacsinou pred datumom
	   	   	   (wh:=13,x:=50, y:=y1+450, w:=x2-110 ,FgC:=4, BgC:=3, fn:=1)
						]);

		r4_Off	: NH_DAT_TIM2 := ( txt := [            // riadok 4 ToDate
						(fn:=3,FgC:=0,nTch:=1,y:=y1+360),							// fn:=0 ... hlavny {1.riadok}
						(wh:=0),
						(wh:=0),
						(wh:=0),
	      	      (wh:=125,x:=xc+130,	w:= 28,h:=28,FgC:=4),          	// 4 hour
   	      	   (wh:=125,x:=xc+190, 	w:= 28,h:=28,FgC:=5),          	// 5 min
      	      	(wh:=  0,x:=xc+250,	w:= 28,h:=28,FgC:=6),          	// 6 sec
						(wh:=0),
	   	         (wh:=0), // text v urovni navestie
   	   	      (wh:=125, x:=50, y:=y1+450, 		w:=200,FgC:=10,BgC:=0, fn:=0, h:=28,cf:=(n:=83), nTch:=1), // text vacsinou pred datumom
	   	   	   (wh:=0)
						]);

      s  : ARRAY[0..5] OF NH_SLD_DAT :=
         [  (t:=1,v1:=1, v2:=31, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        	// 0 slider k start
				(t:=1,v1:=0, v2:=59, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        	// 1 slider k Stop
            (t:=3, v2:=300,      fmt := 'm%Th:mm h'           , txt:= 551),			// 2 cas vypnutia
            (t:=3, v2:=300,      fmt := 'm%Th:mm h'           , txt:= 552)          // 3 cas zapnutia
         ];
   END_STRUCT;

   NH_FRM_073 {HIDDEN}:  STRUCT 	// FRM-TIM  Nacasovat/cyklus  Sunrise/Sunshine, Datk/Light
      hed      : NH_FRM_HED := (Name:='_073',wht:=2,row:=2,sld:=6);
      r1o0_1_Type : NH_OBJ_123 :=                     // 2 objekty
      	(	wh:=123,cf:=(x:= xc-220,     y:= y1 + 50, typ:=1, rw1:=3, rw2:=4, h:= 40, hTxt:= 28),
            txt:=[542,543,544,545,546,547]       	// Typ casovaca
			);
      r1o2_3_OnOff : NH_OBJ_123 := // On/Off/On+Off
      	(	wh:=123,cf:=(x:= xc-140,     y:= y1 + 260, typ:=1, rw2:=3, h:= 45, hTxt:= 28),
            txt:=[539,540,541]
			);
      r1o4_10  	: ARRAY[4..10] OF NH_OBJ_DAT :=
			[
            (wh:=13, x:=50    , y:= y1+ 540,w:= x2-110  ,FgC := 4, BgC := 5 , fn := 2 ), 	//4 Vykonat oneskorene
            (wh:=13, x:=50    , y:= y1+ 620,w:= x2-110  ,FgC := 4, BgC := 6 , fn := 3 ), 	//5 Vypnut po case
				(wh:=0),
				(wh:=0),
				(wh:=0),
			 	(wh:=20, x:=70   , y:= y1+ 890,FgC :=13, w:=74, h := 72, cf :=(c:=3)), 			//9 Lock/Dark
			  	(wh:=20, x:=369  , y:= y1+ 730,FgC :=12, w:=48, h := 49, cf :=(c:=3))	];			//10 Daymode

		r2		: NH_DAYS_OF_WEEK;

      s  : ARRAY[0..5] OF NH_SLD_DAT :=
         [  (t:=1,v1:=1, v2:=31, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        	// 0 slider k start
				(t:=1,v1:=0, v2:=59, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        	// 1 slider k Stop
            (t:=3, v2:=600,      fmt := 'm%Th:mm h'           , txt:= 115),			// 4 vykonat oneskorene
            (t:=3, v2:=600,      fmt := 'm%Th:mm h'           , txt:=  64)          // 5 vypnut po case
         ];
   END_STRUCT;

   NH_FRM_074 {HIDDEN}:  STRUCT 	// FRM-TIM  len typ:=6: Random
      hed      : NH_FRM_HED := (Name:='_074',wht:=2,row:=2,sld:=7);
      r1o0_1_Type : NH_OBJ_123 :=                     // 2 objekty
      	(	wh:=123,cf:=(x:= xc-220,     y:= y1 + 50, typ:=1, rw1:=1, rw2:=1, h:= 40, hTxt:= 28),
            txt:=[548]       	// RND
			);
      r1o2_10  	: ARRAY[2..10] OF NH_OBJ_DAT :=
			[	(wh:=0),	// 2
            (wh:=0), //3	
            (wh:=13, x:=50    , y:= y1+ 150,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 2 ), 	//1 Interval generovnia
            (wh:=13, x:=50    , y:= y1+ 300,w:= x2-110  ,FgC := 4, BgC := 5 , fn := 3 ), 	//2 Min ON
            (wh:=13, x:=50    , y:= y1+ 400,w:= x2-110  ,FgC := 4, BgC := 6 , fn := 4 ), 	//3 Max ON
            (wh:=13, x:=50    , y:= y1+ 500,w:= x2-110  ,FgC := 4, BgC := 5 , fn := 5 ), 	//4 Min OFF
            (wh:=13, x:=50    , y:= y1+ 600,w:= x2-110  ,FgC := 4, BgC := 6 , fn := 6 ), 	//5 Max OFF
			 	(wh:=20, x:=70   , y:= y1+ 890,FgC :=13, w:=74, h := 72, cf :=(c:=3)), 			//9 Lock/Dark
			  	(wh:=20, x:=369  , y:= y1+ 730,FgC :=12, w:=48, h := 49, cf :=(c:=3))	];			//10 Daymode

		r2		: NH_DAYS_OF_WEEK;		

      s  : ARRAY[0..6] OF NH_SLD_DAT :=
         [  (t:=1,v1:=1, v2:=31, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        	// slider k start
				(t:=1,v1:=0, v2:=59, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        	// nepouzije sa
            (t:=1, v2:=255,      fmt := 's%Tm:ss m'           , txt:= 538),
            (t:=3, v2:=600,      fmt := 'm%Th:mm h'           , txt:= 534),
            (t:=3, v2:=600,      fmt := 'm%Th:mm h'           , txt:= 535),
            (t:=3, v2:=600,      fmt := 'm%Th:mm h'           , txt:= 536),
            (t:=3, v2:=600,      fmt := 'm%Th:mm h'           , txt:= 537)
         ];
   END_STRUCT;

   NH_FRM_075 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_075',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  			// MNU-typovy den HOME
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (fn := 22),
										(fn := 273,wh:=274,cm := 205,x:=xc-45, frm:=76),		// typovy den
										(fn :=  20,wh:= 22,cm :=  22,x:=xc+45, frm:=0)			// zony
                           ]);
   END_STRUCT;

   NH_FRM_076   {HIDDEN}  :  STRUCT 	// HOME - centralne nastavenie typ.dnea
      hed      : NH_FRM_HED := (Name:='_076',desc:='FRM-HOME-typovy den',wht:=2,row:=3,sld:=2);
		r1  	: ARRAY[0..4] OF NH_OBJ_DAT :=
			[	(),
				(wh:=6, x:=xc, y:=y1+ 50,w:=500, h:=33,cf:=(n:=51), fgC:=4, fn:=2 ),	// 1; typovy den
				(wh:=6, x:=xc, y:=y1+330,w:=500,h:=28,cf:=(n:=553), fgC:=4, fn:=2 )	// 2; riadit sa kalendarom
			];
      r1_5_6_Type : NH_OBJ_123 :=                     			// rolovacii vyber - kedy prepnut na kalendar
      	(	wh:=123,cf:=(x:= 50,     y:= y1 + 390, typ:=1, rw1:=1, rw2:=10, h:= 41, hTxt:= 28),
            txt:=[206,207,208,209,210,211,212,213,214,215]       	
			);
		r1_7_9 	: ARRAY[7..9] OF NH_OBJ_DAT;             			// len volne riadky
		r1_10 	: ARRAY[10..10] OF NH_OBJ_DAT :=             			// len info parameter
      	      [(wh:= 6, x:=xc      , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254))];  // 10 info dali nbr {len admin}


		r2_On	: NH_DAT_TIM2  := (txt:=                        	// zadanie datumu/casu
         [ (),(),(),(),(),(),(),(),
				(wh:=0),             										// ziadny text v urovni title
				(wh:=0)                         							// ziadny text pred datumom
			]);

		r3		: NH_DAYS_OF_WEEK  := (txt:=[( y:=y1+250, cf:=(c:=1), set6:=1 )]);

      s  	: ARRAY[0..1] OF NH_SLD_DAT :=
         [  (t:=1,v1:=1, v2:=31, fmt := '%3.0f', txt:= 116, zom:=0,tun:=0),        	// 0 slider k start
				(t := 5,v1:=1,       v2 := 1439.0  , fmt := ''          , txt :=   0, xv := x2-53, tun := 1  )                 // slider LUPY bodu, nevypisuje sa ani text, ani hodnota
         ];
   END_STRUCT;

   NH_FRM_077   {HIDDEN}  :  STRUCT 	// ROM - fazy dna rano-vecer
      hed      : NH_FRM_HED := (Name:='_077',wht:=2,row:=2,sld:=1);
		r1  	: ARRAY[0..10] OF NH_OBJ_DAT :=
			[	(wh:=0, w:=82, fn:=44, cm:=130), 																							// 0 obrazok kopirovania
				(wh:=6, x:=xc, y:=y1+ 60,w:=500, h:=33,cf:=(n:=555), fgC:=4, fn:=2 ),											// 1; text - faza dna
            (wh:=0, x:= x2- 70 , y:= y1 + 60,  w:= 62, Fn := 555,  FgC := 6, BgC := 50, h := 0, cf :=(c:=3)),  	// 2 prepinac obrazkov DayMode/On - vsetky obrazky na sebe (h:=0, cf.c>0)
				(),																																	// 3		
            (wh:=14, x:= 50 ,    y:= y1 + 600, 	w:= x2-110, h := 200,  FgC := 4,  Fn := 315,prs:=0),     			// 4 OBJEKT slider day/evening/nighy/morning
            (wh:=0 , x:= 50,      					w:= x2-110 , FgC := 4,BgC := 5,  fn := 0, cm := 251)    				// 5 slider LUPY konkretneho bodu
			];

		r2	: NH_DAYS_OF_WEEK  := (txt:=[( y:=y1+300, cf:=(c:=1), set6:=1 )]);
		
      s  : ARRAY[0..0] OF NH_SLD_DAT :=
         [  (t := 5,v1:=1,       v2 := 1439.0  , fmt := ''          , txt :=   0, xv := x2-53, tun := 1  )                 // slider LUPY bodu, nevypisuje sa ani text, ani hodnota
         ];


   END_STRUCT;


   NH_FRM_078 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_078',wht:=3);
      mnu      : NH_MNU := ( n:=0,
	  							     o := [(
                                        fn :=  1, wh :=  1, cm := 25  ), //       // logo
                                       (fn := 23, wh := 25, cm := 250  ),         // setup
                                       (fn :=  3, wh :=  0, cm := 20   ),         // home
                                       (fn := 41, wh := 42, cm := 21   ),         // FAV
                                       (fn := 16, wh := 17, cm := 22   ),         // rom
                                       (fn := 10, wh := 11, cm := 23   ),         // cat
                                       (fn := 27, wh := 28, cm := 24   ),         // act
                                       (fn := 49, wh :=  0, cm := 26   )]         // ON/OFF
                           );
   END_STRUCT;
   NH_FRM_079 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_079',wht:=3);
      mnu      : NH_MNU := ( n:=0,
	  							     o := [		(fn :=  6, wh := 44, cm := 130, w:=72  ),  // sive/zlte copy
												//	(fn :=   6,wh:=  6,cm :=  31),
                                       (fn := 38, wh := 38, cm := 133, w:=72  ),  // zeleny check
                                       (fn :=  3, wh :=  0, cm := 20   ),         // home
                                       (fn := 41, wh := 42, cm := 21   ),         // FAV
                                       (fn := 16, wh := 17, cm := 22   ),         // rom
                                       (fn := 10, wh := 11, cm := 23   ),         // cat
                                       (fn := 27, wh := 28, cm := 24   ),         // act
                                       (fn := 49, wh :=  0, cm := 26   )]         // ON/OFF
                           );

   END_STRUCT;

   NH_FRM_080  {HIDDEN} :  STRUCT 	// Meteostanica - wind
      hed      : NH_FRM_HED := (Name:='_080',wht:=2,row:=1,sld:=11);
  		r0_10 : ARRAY[0..10] OF NH_OBJ_DAT :=
		  	[	(wh:=13, x:=50    , y:= y1+ 100,w:= x2-110  ,FgC := 4, BgC := 8 , fn := 0 ), 			//  0 slaby vietor
     			(wh:=13, x:=50    , y:= y1+ 180,w:= x2-110  ,FgC := 4, BgC :=18 , fn := 1 ), 			//  1 silny vietor
				(wh:=13, x:=50    , y:= y1+ 260,w:= x2-110  ,FgC := 4, BgC := 7 , fn := 2 ), 			//  2 kriticka rychlost

			  	(wh:=20, x:= x2-60, y:= y1+ 360,w:= 48     , FgC := 0, BgC :=50, fn := 567 ), 		//  3 manual
     			(wh:=13, x:=50    , y:= y1+ 460,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 4 ), 			//  4 man-windspeed
            (wh:=13, x:=50    , y:= y1+ 540,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 5 ), 			//  5 man-winddir
            (wh:=13, x:=50    , y:= y1+ 620,w:= x2-110  ,FgC := 4, BgC := 5 , fn := 6 ), 			//  6 man-spower

			  	(wh:=20, x:= x2-60, y:= y1+ 700,w:= 48   , FgC := 0, BgC :=50, fn := 578 ), 			//  7 posielat pre rolety
     			(wh:=13, x:=50    , y:= y1+ 800,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 3 ), 			//  8 filt1r
     			(wh:=13, x:=50    , y:= y1+ 880,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 7 ) 			//  9 WindSpeedRol
     			
         ];
      s  : ARRAY[0..10] OF NH_SLD_DAT := [
				(		v2 := 50.0  , fmt := '%4.0f m/s', 	txt := 575, xv := x2-53 ),      			// 0 slaby vietor
				(		v2 := 50.0  , fmt := '%4.0f m/s', 	txt := 579, xv := x2-53 ),      			// 1 silny vietor
				(		v2 := 50.0  , fmt := '%4.0f m/s', 	txt := 576, xv := x2-53 ),     			// 2 kriticka rychost vetra
				(t:=3,v2 := 2000.0, fmt := '%4.0f', 		txt := 577, xv := x2-53 ), 				// 3 filter 1.r pre wietor
           	(		v2 := 50.0  , fmt := '%4.1f m/s', 	txt := 569, xv := x2-53,ink:=0.1 ),    // 4 man-rychlost vetra
				(t:=3,v2 := 360.0 , fmt := '%3.0f °', 		txt := 570, xv := x2-53 ), 				// 5 man-orientacia 360
				(		v2 := 1000.0, fmt := '%3.1f', 		txt := 571, xv := x2-53,ink:=0.1),      			// 6 man-spower
			 	(t:=1,v2 := 50.0  , fmt := '%4.0f m/s', 	txt := 606, xv := x2-53	)      			// 7 WindSpeedRol

         ];

   END_STRUCT;


   NH_FRM_081 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_081',wht:=3);
      mnu      : NH_MNU := ( n:=3,                                  				// MNU-ROL - submenu SETUP
                        o := [
                              (fn :=   6,wh:=  6,cm := 31),	// vrati sa na povodne menu
                              (fn := 114,wh:=114,cm :=31 ),
                              (fn := 119,wh:=115,cm := 205, frm:=65),   // parametre Up/Dn
                              (fn := 345,wh:=345,cm := 205, frm:=64),   // predvolby
                              (), 	
                              (),        		
                              (),        		
	                           (fn := 348,wh:=348,cm :=  82)        		// 7 Rom, ktore vstupuu do ZON

                           ]);
   END_STRUCT;

   NH_FRM_082 {HIDDEN}:  STRUCT 	// FRM-ROL - nastavit na poziciu
      hed      : NH_FRM_HED := (Name:='_082',wht:=2,row:=1,sld:=1,Desc:='FRM-ROL:Grafika');
		  	r1_0_4 	: ARRAY[0..4] OF NH_OBJ_DAT;
	   	r1_5_6 	: NH_OBJ_ROL;			// 2 riadky     	
		  	r1_7_10 	: ARRAY[7..10] OF NH_OBJ_DAT :=
		  	[	(wh:= 0, x:= 110, y:= y1 +826, 	w:= 150, h:=24, Fgc:=4, fn:=0, nTch:=1, cf:=(c:=254)),  				// 7 vypis realnej polohy yRol
				(wh:= 0, x:= 350, y:= y1 +826, 	w:= 150, h:=24, Fgc:=4, fn:=0, nTch:=1, cf:=(c:=254)),  				// 8 vypis realnej polohy yLam
            (wh:=13, x:= 50,  y:= y1 +900,  	w:= x2-110  ,FgC := 4, BgC := 5          , fn := 0             ),  // 9 s opozdenim
	         (wh:= 0, x:=xc  , y:= 1018, 		w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254)           )  // 10 info dali nbr {len admin}
    		];
      s  : ARRAY[0..0] OF NH_SLD_DAT :=
           [
            (t := 3, v2:=1800,      fmt := 's%Tm:ss m'           , txt:= 115)        // 6 opozdenie
              ];
   END_STRUCT;

   NH_FRM_083  {HIDDEN}  :  STRUCT 	// FRM - predolby teploty
      hed      : NH_FRM_HED := (Name:='_083',wht:=2,row:=1,sld:=3);
      r_0_3  : ARRAY[0..3] OF NH_OBJ_DAT :=
			[	(wh:=6, x:=xc, y:=y1+ 60,w:=500, h:=33,cf:=(n:=48), fgC:=4, fn:=2 ),							// 0; text nastavit predvolbu
				(wh:=0),	
	         (wh:=22,x:=145,		y:=y1+150,fn:=1,cf:=(c:=4),h:=68,w:=48, cm:=251)                 // 3  auto/MAN, 0.1...3
			];
		WHT : NH_OBJ_123 :=            // r3
	 			(wh:=123,cf:=(x:= 160,    y:=y1+250, typ:=1, rw2:=3, h:= 50, hTxt:= 28),                     // 4+5 ON/OFF
    					txt:=[599,600]);             												
      r_6_10  : ARRAY[6..10] OF NH_OBJ_DAT :=
        [   (wh:=13, x:= 50     , y:= y1 + 500,   w:= x2-110 , FgC := 4, BgC := 3, fn := 0),       // 6 delay
            (wh:=13, x:= 50     , y:= y1 + 600,   w:= x2-110 , FgC := 4, BgC := 3, fn := 1),       // 7 wait
				(wh:=0),	
				(wh:=0),	
     	      (wh:= 6, x:=xc      , y:= 1020,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254))  // 10 info par {len admin}
        ];
      s  : ARRAY[0..2] OF NH_SLD_DAT := [
            ( t:=3, xv := x2-53, v2 := 3599.0 , fmt := 's%Tm:ss m',   txt:= 602),      // 0 s opozdenim
            ( t:=3, xv := x2-53, v2 := 3599.0 , fmt := 's%Tm:ss m',   txt:= 601)      // 1 ak bude trvat pohyb
         ];
   END_STRUCT;

   NH_FRM_084  {HIDDEN} :  STRUCT 	// Meteostanica - wind
      hed      : NH_FRM_HED := (Name:='_084',wht:=2,row:=1,sld:=11);
   	r1_0_1_Type : NH_OBJ_123 :=                     			// rolovacii vyber - kedy prepnut na kalendar
      	(	wh:=123,cf:=(x:= 50,     y:= y1 +  50, typ:=1, rw1:=1, rw2:=2, h:= 41, hTxt:= 28),
            txt:=[572,573,574]       	
			);
  		r1_2_10 : ARRAY[2..10] OF NH_OBJ_DAT :=
		  	[	(wh:=13, x:=50    , y:= y1+ 300,w:= x2-110  ,FgC := 4, BgC := 8 , fn := 0 ), 			//  2 nizka teplota
				(wh:=13, x:=50    , y:= y1+ 380,w:= x2-110  ,FgC := 4, BgC := 7 , fn := 1 ), 			//  3 vysoka teplota
     			(wh:=13, x:=50    , y:= y1+ 500,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 2 ),			//  4 koef.ziarenia na osvetlenie
     			(wh:=13, x:=50    , y:= y1+ 580,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 3 ), 			//  5 100% osvetlenie
     			(wh:=13, x:=50    , y:= y1+ 680,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 4 ) 			//  6 FilsPower
         ];
      s  : ARRAY[0..10] OF NH_SLD_DAT := [
				(v1:=-10,v2 := 50.0  	,fmt := '%4.0f °', 		txt := 603, xv := x2-53  ),      		// 0 nizka teplota
				(			v2 := 50.0  	,fmt := '%4.0f °', 		txt := 295, xv := x2-53  ),      		// 1 vysoka teplota
				(v1:=1.0,v2 := 100.0  	,fmt := '%4.1f', 			txt := 605, xv := x2-53,ink:=0.1  ), 	// 2 koefTo100
				(t:=3,	v2 := 1000.0	,fmt := '%4.0f', 			txt := 604, xv := x2-53  ),     			// 3 100%  osvetlenia
				(t:=3,v2 := 2000.0, fmt := '%4.0f', 				txt := 577, xv := x2-53 ) 					// 4 FilsPower
         ];
   END_STRUCT;

   NH_FRM_085  {HIDDEN} :  STRUCT 	// Setup HET/VEN
      hed      : NH_FRM_HED := (Name:='_085',wht:=2,row:=1,sld:=11,desc:='Archivovat HET');
  		r0_10 : ARRAY[0..10] OF NH_OBJ_DAT :=
		  	[  (wh:=20, x:=x2-60 ,y:= y1 + 50, w:= 48     , 				FgC := 4, BgC :=50, 	fn := 100), //0 zablokovat
				(),
				(),	
				(),
				(wh:=20, x:=x2-60 ,y:= y1 + 430, w:= 48     , 				FgC := 0, BgC :=50, 	fn := 615),	//  4 logovat
			   (wh:=20, x:=x2-60 ,y:= y1 + 480, w:= 48     , 				FgC := 0, BgC :=50, 	fn := 614),	//  5 kazda zmena Out
			  	(wh:=13, x:=50    , y:= y1+ 580,w:= x2-110  ,FgC := 4, BgC := 8 , fn := 0 ), 					//  6 sample
			  	(wh:=13, x:=50    , y:= y1+ 660,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 1 ), 					//  7 ReQ
			  	(wh:=13, x:=50    , y:= y1+ 740,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 2 ), 					//  8 Rom
			  	(wh:=13, x:=50    , y:= y1+ 820,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 3 ), 					//  9 Het
			  	(wh:=13, x:=50    , y:= y1+ 900,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 4 ) 					// 10 Kot
         ];
      s  : ARRAY[0..10] OF NH_SLD_DAT := [
				(t:=3, v1:=1.0,	v2 := 3599.0, fmt := 's%Tm:ss m', 			txt := 609, xv := x2-53 ), 				// 0 vzorka
				(t:=1, v1:=1.0,	v2 := 255.0,  fmt := '.%4.1f°', 			txt := 610, xv := x2-53 ), 					// 1 Zmena ReQ
				(t:=1, v1:=1.0,	v2 := 255.0,  fmt := '.%4.1f°', 			txt := 611, xv := x2-53 ), 					// 2 Zmena Rom	
				(t:=1, v1:=1.0,	v2 := 255.0,  fmt := '.%4.1f°', 			txt := 612, xv := x2-53 ), 					// 3 Zmena Het
				(t:=2, v1:=1.0,	v2 := 255.0,  fmt := '.%4.1f°', 			txt := 613, xv := x2-53 ) 						// 4 ZmenaKot
         ];
   END_STRUCT;

   NH_FRM_086 {HIDDEN}:  STRUCT 	// HET-rozdiely teplot
      hed      : NH_FRM_HED := (Name:='_086',wht:=2,row:=1,sld:=2);
		r1_0_1 : ARRAY[0..1] OF NH_OBJ_DAT :=
         [	(wh:=6,  x:= x2/2  , y:= y1 + 60,   w:= 400    , FgC := 3, BgC := 0, fn := 2, h:=30,cf:=(n:=476)),  // 0
				(wh:=6,  x:= x2/2  , y:= y1 + 160,  w:= 400    , FgC := 4, BgC := 0, fn := 2, h:=30,cf:=(n:=477))  // 1
	   	]; 	// 0
      r1_2_3_Type : NH_OBJ_123 :=    			// rolovacii vyber - kedy prepnut na kalendar							// 2
      	(	wh:=123,cf:=(x:= 140,     y:= y1 + 220, typ:=1, rw1:=1, rw2:=2, h:= 41, hTxt:= 28),                       // 3
            txt:=[478,479] );
		r1_4_10 : ARRAY[4..10] OF NH_OBJ_DAT :=
      	[
            (wh:=14, x:= 50 ,    y:= y1 + 600, 	w:= x2-110, h := 200,  FgC := 4,  Fn := 315,prs:=0),     		// 4 OBJEKT slider day/evening/nighy/morning
            (wh:=0 , x:= 50,      					w:= x2-110 , FgC := 4,BgC := 5,  fn := 0, cm := 251),   			// 5 slider LUPY konkretneho bodu
			  	(wh:=13, x:=50    , y:= y1+ 850,w:= x2-110  ,FgC := 4, BgC := 3 , fn := 1 ), 								// 6 slider
				(wh:=0, x:= 50    , y:= y1 + 480,   w:= x2-110  ,FgC := 4, BgC := 2          , fn := 5             ), // 7 pv4
            (wh:=0, x:= 50    , y:= y1 + 830,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 7             ), // 8 pauza medzi predvolbami
            (wh:=0, x:= 50    , y:= y1 + 700,   w:= x2-110  ,FgC := 4, BgC := 3          , fn := 8             ), // 9 typ
            (wh:=0, x:= x2-60  , y:= y1 +  50,   w:= 48     , FgC := 0, BgC :=50          , fn := 246           ) //10 nastavit predvolenu poziciu
         ];

      s  : ARRAY[0..1] OF NH_SLD_DAT :=
         [  (t := 5, v1:=1.0,    v2 := 400.0  , fmt := ''          , txt :=   0, xv := x2-53, tun := 1  ),    // 0 slider LUPY bodu, nevypisuje sa ani text, ani hodnota
           (t := 3, v1:=1.0,    v2 := 1800.0  , fmt := 's%Tm:ss m' , txt := 609, xv := x2-53, tun := 1  )     // 1 odoberat vzorky
         ];

   END_STRUCT;

   NH_FRM_087 {HIDDEN}  :  STRUCT 	// MNU-VVO
      hed      : NH_FRM_HED := (Name:='_087',wht:=3,desc:='MNU: VVO');
      mnu      : NH_MNU := ( n:=5, 						
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
										(),
										(),
                              (fn := 23,wh:=25,cm := 205, frm:=70),      	// setup
										(fn:=348,wh:=348,cm :=  82   			)		  	// ROM->DEV
                           ]);
   END_STRUCT;

  	NH_FRM_088 {HIDDEN}:  STRUCT 	
      hed : NH_FRM_HED := (Name:='_088',wht:=2,row:=1,sld:=4,desc:='Par WSB/TLA/TGL');
  		r0_10 : ARRAY[0..10] OF NH_OBJ_DAT :=
			[	(wh:=6, x:=xc, y:=y1+ 50,w:=500, h:=30,cf:=(n:=123), fgC:=4, fn:=2 ),													// 0 text-nastavenie
            (wh:=13, x:= 50     , y:= y1 + 200,   w:= x2-110  ,FgC := 4, BgC := 3,  fn := 1            ), // 1 cakanie na dalsi click
            (wh:=13, x:= 50     , y:= y1 + 300,   w:= x2-110  ,FgC := 4, BgC := 3,  fn := 2            ), // 2 press
            (wh:=13, x:= 50     , y:= y1 + 400,   w:= x2-110  ,FgC := 4, BgC := 3,  fn := 3            ), // 3 hold
            (),
            (),
            (),
            (),
            (),
            (wh:=20,x:= x2-60  , y:= y1 + 800,   w:= 48     , FgC := 4, BgC :=50			  	, fn := 100	), 	// 9 zablokovat
            (wh:=0, x:= xc     , y:= y1 + 960,   w:=110,h:=20,FgC := 2, BgC := 0,  fn := 2, cf:=(c:=254))     // 10 cislo dsl/dlma
    		];
      s  : ARRAY[0..3] OF NH_SLD_DAT :=
           [
            (),                                                                    // 0
            (t := 1, v2 := 10.0    , fmt := '1%Ts.z s'           , txt:= 77),         // 1 cakanie na dalsi click
            (t := 1, v2 := 10.0    , fmt := '1%Ts.z s'           , txt:= 78),         // 2 press
            (t := 1, v2 := 20.0    , fmt := '1%Ts.z s'           , txt:= 79)          // 3 hold
           ];
   END_STRUCT;

  	NH_FRM_089 {HIDDEN}:  STRUCT 	
      hed : NH_FRM_HED := (Name:='_089',wht:=2,row:=1,sld:=0,desc:='TGL-Co zobrazit');
  		r0_0 : ARRAY[0..0] OF NH_OBJ_DAT :=
			[	(wh:=6, x:=xc, y:=y1+100,w:=500, h:=30,cf:=(n:=50), fgC:=4, fn:=2 ) ];													// 0 text-nastavenie
      r1_1_2_Type : NH_OBJ_123 :=    			// rolovacii vyber - kedy prepnut na kalendar							// 2
      	(	wh:=123,cf:=(x:= 100,  y:= y1 + 200, typ:=1, rw1:=1, rw2:=5, h:= 50, hTxt:= 28),                       // 3
			            txt:=[34,35,36,37,39] );
  		r0_3_10 : ARRAY[3..10] OF NH_OBJ_DAT;
   END_STRUCT;

  	NH_FRM_090 {HIDDEN}:  STRUCT 	
      hed : NH_FRM_HED := (Name:='_090',wht:=2,row:=1,sld:=0,desc:='Click/Akcia->WSB/TGL');
  		r0_7 : ARRAY[0..7] OF NH_OBJ_DAT :=
         [  (wh:= 10, x:= 110    , y:= y1 + 130,   w:= 190   , FgC := 1, BgC := 8, fn := 102, cm := 251),                       // 0 obrazok WSB
            (wh:=  8, x:= 260    , y:= y1 + 95,    w:= 70    , FgC := 1, BgC := 8, fn := 3, cf :=(c:=1,p:=35),fmt:='1' ),       // 1
            (wh:=  8, x:= 325    , y:= y1 + 95,    w:= 70    , FgC := 4, BgC := 0, fn := 3, cf :=(p:=35),fmt:='2' ),            // 2
            (wh:=  8, x:= 390    , y:= y1 + 95,    w:= 70    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='3' ),            // 3
            (wh:=  8, x:= 455    , y:= y1 + 95,    w:= 70    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='4' ),            // 4
            (wh:=  8, x:= 520    , y:= y1 + 95,    w:= 70    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='5' ),            // 5
            (wh:=  8, x:= 290    , y:= y1 +180,    w:= 90    , FgC := 8, BgC := 0, fn := 3, cf :=(p:=35),fmt:='Push' ),         // 6
            (wh:=  8, x:= 460    , y:= y1 +180,    w:= 90    , FgC := 2, BgC := 0, fn := 3, cf :=(p:=35),fmt:='Hold' )         // 7
			];
      r_8_9: NH_OBJ_123 :=    			// rolovacii vyber - kedy prepnut na kalendar							// 2
      	(	wh:=123,cf:=(x:= 100,  y:= y1 + 300, typ:=1, rw1:=1, rw2:=2, h:= 52, hTxt:= 28),                       // 3
//			            txt:=[80,181,180,179,182,188,189,178] );
			            txt:=[189,178] );
  		r_10 : ARRAY[10..10] OF NH_OBJ_DAT :=
            [(wh:=6,   x:=xc      , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254) )];
   END_STRUCT;

   NH_FRM_091  {HIDDEN} :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_091',wht:=2,row:=1,sld:=0, desc:='Setup SCN');
  		r0_0 : ARRAY[0..0] OF NH_OBJ_DAT :=
			[	(wh:=6, x:=xc, y:=y1+80,w:=500, h:=30,cf:=(n:=621), fgC:=4, fn:=2 ) ];													// 0 text-nastavenie
      mnu   : NH_OBJ_123 := // R: 1..2
            (wh:=123,cf:=(x:= xc-200,     y:= y1 + 150, typ:=1, rw2:=3, h:= 50, hTxt:= 28),
                 txt:=[622,623,624]);                                                    // 1 rolovaci vyber textov
  		r3_3 : ARRAY[3..3] OF NH_OBJ_DAT :=
			[	(wh:=6, x:=xc, y:=y1+400,w:=500, h:=30,cf:=(n:=184), fgC:=4, fn:=2 ) ];													// 0 text-nastavenie
      r4_10   : ARRAY[4..10] OF NH_OBJ_DAT := [
				(),
				(),
            (),
            (),
            (wh:=20, x:= x2-140  , y:= y1 + 820,   w:= 48     , FgC := 0, BgC :=50          , fn := 228          ),  // 8 archivovat
            (wh:=20, x:= x2-140  , y:= y1 + 880,   w:= 48     , FgC := 4, BgC :=50          , fn := 100          ),  // 9 zablokovat
            (wh:= 6, x:=xc       , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254)           )  // 10 info dali nbr {len admin}
             ];
   END_STRUCT;
   NH_FRM_092  {HIDDEN} :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_092',wht:=2,row:=1,sld:=0, desc:='Setup ACT');
  		r0_0 : ARRAY[0..0] OF NH_OBJ_DAT :=
			[	(wh:=6, x:=xc, y:=y1+80,w:=500, h:=30,cf:=(n:=620), fgC:=4, fn:=2 ) ];													// 0 text-nastavenie
      mnu   : NH_OBJ_123 := // R: 1..2
            (wh:=123,cf:=(x:= xc-200,     y:= y1 + 150, typ:=1, rw2:=3, h:= 50, hTxt:= 28),
                 txt:=[622,623,624]);                                                    // 1 rolovaci vyber textov
      r3_10   : ARRAY[3..10] OF NH_OBJ_DAT := [
				(wh:=0, x:=xc, y:=y1+100,w:=500, h:=30,cf:=(n:=50), fgC:=4, fn:=2 ),
				(),
				(),
            (),
            (),
            (wh:=20, x:= x2-140  , y:= y1 + 820,   w:= 48     , FgC := 0, BgC :=50          , fn := 228          ),  // 8 archivovat
            (wh:=20, x:= x2-140  , y:= y1 + 880,   w:= 48     , FgC := 4, BgC :=50          , fn := 100          ),  // 9 zablokovat
            (wh:= 6, x:=xc       , y:= 1015,       w:= 400, h:=20, Fgc:=2, fn:=2, nTch:=1, cf:=(c:=254)           )  // 10 info dali nbr {len admin}
             ];
   END_STRUCT;


   NH_FRM_093 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_093',wht:=3,desc:='Menu SCN');
      mnu      : NH_MNU := ( n:=3,
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  83,wh:= 84,cm := 205,x:=xc-90 	,frm:=9	),        // parametre
                              (fn :=  23,wh:= 24,cm := 205,x:=xc		,frm:=91	),        // setup
										(fn := 348,wh:=348,cm :=  82,x:=xc+90				)        // ROM ->
                           ]);
   END_STRUCT;

   NH_FRM_094 {HIDDEN}  :  STRUCT 	
      hed      : NH_FRM_HED := (Name:='_094',wht:=3,desc:='Menu ACT');
      mnu      : NH_MNU := ( n:=3,
                        o := [
                              (fn :=   6,wh:=  6,cm :=  31),
                              (),
                              (fn :=  23,wh:= 24,cm := 205,x:=xc-45	,frm:=92	),        // setup
										(fn := 348,wh:=348,cm :=  82,x:=xc+45				)        // ROM ->
                           ]);
   END_STRUCT;


















  	







END_TYPE

VAR_GLOBAL
//	yFrm_500	AT mObr			{HIDDEN} : NH_FRM_500;					// import from NH2.exp
//	yFrm_250	AT mObr			{HIDDEN} : NH_FRM_250;					// import from NH2.exp
//	yImp		AT yFrmData		{HIDDEN} : NH_LOG_IMP;					// only struct import
//   xFrmHed           		{HIDDEN} : PTR_TO NH_FRM_SAVE_MAP;  // head for saving

	// ladenie


END_VAR




	VAR_GLOBAL
   	xFrmHed           		{HIDDEN} : PTR_TO NH_FRM_SAVE_MAP;  // head for saving


	   _START_FRM_SYS : USINT := 0;
	
		_247_S : UDINT := SIZEOF(NH_FRM_247); _247 {PUBLIC} : NH_FRM_247 ;
   	_249_S : UDINT := SIZEOF(NH_FRM_249); _249 : NH_FRM_249 ;
   	_250_S : UDINT := SIZEOF(NH_FRM_250); _250 : NH_FRM_250 ;
   	_251_S : UDINT := SIZEOF(NH_FRM_251); _251 : NH_FRM_251 ;
   	_252_S : UDINT := SIZEOF(NH_FRM_252); _252 : NH_FRM_252 ;	
   	_253_S : UDINT := SIZEOF(NH_FRM_253); _253 : NH_FRM_253 ;
   	_254_S : UDINT := SIZEOF(NH_FRM_254); _254 : NH_FRM_254 ;	
   	_255_S : UDINT := SIZEOF(NH_FRM_255); _255 : NH_FRM_255 ;	
	
		_500_S : UDINT := SIZEOF(NH_FRM_500); _500 : NH_FRM_500 ;
//   	_501_S : UDINT := SIZEOF(NH_LOG_HEAD); _501 : NH_LOG_HEAD := (hed:=(Name:='_501'));

	   _END_FRM_SYS    : UDINT := 0;

	   _START_FRM_WEB : USINT := 0;
	
		_000_S : UDINT := SIZEOF(NH_FRM_000); _000 : NH_FRM_000 ;   // 0 defult browser
	   _001_S : UDINT := SIZEOF(NH_FRM_001); _001 : NH_FRM_001 ;   // 1 FRM-1 DALI-M/S/ :   slidre HW-nastavenia
	   _002_S : UDINT := SIZEOF(NH_FRM_002); _002 : NH_FRM_002 ;   // 2 FRM-2 DALI-M :      TOOLS vymazat SHA, pridat NOVE SHA
	   _003_S : UDINT := SIZEOF(NH_FRM_003); _003 : NH_FRM_003 ;   // 3 BRW-dali-MASTERr
	   _004_S : UDINT := SIZEOF(NH_FRM_004); _004 : NH_FRM_004 ;
	   _005_S : UDINT := SIZEOF(NH_FRM_005); _005 : NH_FRM_005 ;
	   _006_S : UDINT := SIZEOF(NH_FRM_006); _006 : NH_FRM_006 ;
	   _007_S : UDINT := SIZEOF(NH_FRM_007); _007 : NH_FRM_007 ;
	   _008_S : UDINT := SIZEOF(NH_FRM_008); _008 : NH_FRM_008 ;
	   _009_S : UDINT := SIZEOF(NH_FRM_009); _009 : NH_FRM_009 ;
	   _010_S : UDINT := SIZEOF(NH_FRM_010); _010 : NH_FRM_010 ;
	   _011_S : UDINT := SIZEOF(NH_HOM_011); _011 : NH_HOM_011 ;
	   _012_S : UDINT := SIZEOF(NH_FRM_012); _012 : NH_FRM_012 ;
	   _013_S : UDINT := SIZEOF(NH_FRM_013); _013 : NH_FRM_013 ;
	   _014_S : UDINT := SIZEOF(NH_FRM_014); _014 : NH_FRM_014 ;
	   _015_S : UDINT := SIZEOF(NH_FRM_015); _015 : NH_FRM_015 ;
	   _016_S : UDINT := SIZEOF(NH_FRM_016); _016 : NH_FRM_016 ;
   	_017_S : UDINT := SIZEOF(NH_FRM_017); _017 : NH_FRM_017 ;
	   _018_S : UDINT := SIZEOF(NH_FRM_018); _018 : NH_FRM_018 ;
   	_019_S : UDINT := SIZEOF(NH_FRM_019); _019 : NH_FRM_019 ;
	   _020_S : UDINT := SIZEOF(NH_FRM_020); _020 : NH_FRM_020 ;
   	_021_S : UDINT := SIZEOF(NH_FRM_021); _021 : NH_FRM_021 ;
	   _022_S : UDINT := SIZEOF(NH_FRM_022); _022 : NH_FRM_022 ;
   	_023_S : UDINT := SIZEOF(NH_FRM_023); _023 : NH_FRM_023 ;
   	_024_S : UDINT := SIZEOF(NH_FRM_024); _024 : NH_FRM_024 ;
	   _025_S : UDINT := SIZEOF(NH_FRM_025); _025 : NH_FRM_025 ;
	   _026_S : UDINT := SIZEOF(NH_FRM_026); _026 : NH_FRM_026 ;
 	  	_027_S : UDINT := SIZEOF(NH_FRM_027); _027 : NH_FRM_027 ;
	   _028_S : UDINT := SIZEOF(NH_FRM_028); _028 : NH_FRM_028 ;
   	_029_S : UDINT := SIZEOF(NH_FRM_029); _029 : NH_FRM_029 ;
	   _030_S : UDINT := SIZEOF(NH_FRM_030); _030 : NH_FRM_030 ;
   	_031_S : UDINT := SIZEOF(NH_FRM_031); _031 : NH_FRM_031 ; 		//31 FRM - ROM*set typ miestnosti
	   _032_S : UDINT := SIZEOF(NH_FRM_032); _032 : NH_FRM_032 ;
   	_033_S : UDINT := SIZEOF(NH_FRM_033); _033 : NH_FRM_033 ;
	   _034_S : UDINT := SIZEOF(NH_FRM_034); _034 : NH_FRM_034 ;
   	_035_S : UDINT := SIZEOF(NH_FRM_035); _035 : NH_FRM_035 ;
	   _036_S : UDINT := SIZEOF(NH_FRM_036); _036 : NH_FRM_036 ;
   	_037_S : UDINT := SIZEOF(NH_FRM_037); _037 : NH_FRM_037 ;
	   _038_S : UDINT := SIZEOF(NH_FRM_038); _038 : NH_FRM_038 ;
   	_039_S : UDINT := SIZEOF(NH_FRM_039); _039 : NH_FRM_039 ;
	   _040_S : UDINT := SIZEOF(NH_FRM_040); _040 : NH_FRM_040 ;
   	_041_S : UDINT := SIZEOF(NH_FRM_041); _041 : NH_FRM_041 ;
	   _042_S : UDINT := SIZEOF(NH_FRM_042); _042 : NH_FRM_042 ;
   	_043_S : UDINT := SIZEOF(NH_FRM_043); _043 : NH_FRM_043 ;
	   _044_S : UDINT := SIZEOF(NH_FRM_044); _044 : NH_FRM_044 ;
   	_045_S : UDINT := SIZEOF(NH_FRM_045); _045 : NH_FRM_045 ;
	   _046_S : UDINT := SIZEOF(NH_FRM_046); _046 : NH_FRM_046 ;
   	_047_S : UDINT := SIZEOF(NH_FRM_047); _047 : NH_FRM_047 ;
	   _048_S : UDINT := SIZEOF(NH_FRM_048); _048 : NH_FRM_048 ;
   	_049_S : UDINT := SIZEOF(NH_FRM_049); _049 : NH_FRM_049 ;
	   _050_S : UDINT := SIZEOF(NH_FRM_050); _050 : NH_FRM_050 ;
   	_051_S : UDINT := SIZEOF(NH_FRM_051); _051 : NH_FRM_051 ;
	   _052_S : UDINT := SIZEOF(NH_FRM_052); _052 : NH_FRM_052 ;
   	_053_S : UDINT := SIZEOF(NH_FRM_053); _053 : NH_FRM_053 ;
	   _054_S : UDINT := SIZEOF(NH_FRM_054); _054 : NH_FRM_054 ;
   	_055_S : UDINT := SIZEOF(NH_FRM_055); _055 : NH_FRM_055 ;
	   _056_S : UDINT := SIZEOF(NH_FRM_056); _056 : NH_FRM_056 ;
  	   _057_S : UDINT := SIZEOF(NH_FRM_057); _057 : NH_FRM_057 ;      // TGL-display
	   _058_S : UDINT := SIZEOF(NH_FRM_058); _058 : NH_FRM_058 ;
   	_059_S : UDINT := SIZEOF(NH_FRM_059); _059 : NH_FRM_059 ;
	   _060_S : UDINT := SIZEOF(NH_FRM_060); _060 : NH_FRM_060 ;
   	_061_S : UDINT := SIZEOF(NH_FRM_061); _061 : NH_FRM_061 ;
	   _062_S : UDINT := SIZEOF(NH_FRM_062); _062 : NH_FRM_062 ;
   	_063_S : UDINT := SIZEOF(NH_FRM_063); _063 : NH_FRM_063 ;
	   _064_S : UDINT := SIZEOF(NH_FRM_064); _064 : NH_FRM_064 ;
   	_065_S : UDINT := SIZEOF(NH_FRM_065); _065 : NH_FRM_065 ;
	   _066_S : UDINT := SIZEOF(NH_FRM_066); _066 : NH_FRM_066 ;                                          	
   	_067_S : UDINT := SIZEOF(NH_FRM_067); _067 : NH_FRM_067 ;
	   _068_S : UDINT := SIZEOF(NH_FRM_068); _068 : NH_FRM_068 ;
	   _069_S : UDINT := SIZEOF(NH_FRM_069); _069 : NH_FRM_069 ;
   	_070_S : UDINT := SIZEOF(NH_FRM_070); _070 : NH_FRM_070 ;
	   _071_S : UDINT := SIZEOF(NH_FRM_071); _071 : NH_FRM_071 ;
   	_072_S : UDINT := SIZEOF(NH_FRM_072); _072 : NH_FRM_072 ;
	   _073_S : UDINT := SIZEOF(NH_FRM_073); _073 : NH_FRM_073 ;
   	_074_S : UDINT := SIZEOF(NH_FRM_074); _074 : NH_FRM_074 ;
	   _075_S : UDINT := SIZEOF(NH_FRM_075); _075 : NH_FRM_075 ;
   	_076_S : UDINT := SIZEOF(NH_FRM_076); _076 : NH_FRM_076 ;
	   _077_S : UDINT := SIZEOF(NH_FRM_077); _077 : NH_FRM_077 ;
   	_078_S : UDINT := SIZEOF(NH_FRM_078); _078 : NH_FRM_078 ;
	   _079_S : UDINT := SIZEOF(NH_FRM_079); _079 : NH_FRM_079 ;
   	_080_S : UDINT := SIZEOF(NH_FRM_080); _080 : NH_FRM_080 ;
	   _081_S : UDINT := SIZEOF(NH_FRM_081); _081 : NH_FRM_081 ;
   	_082_S : UDINT := SIZEOF(NH_FRM_082); _082 : NH_FRM_082 ;
		_083_S : UDINT := SIZEOF(NH_FRM_083); _083 : NH_FRM_083 ;
	   _084_S : UDINT := SIZEOF(NH_FRM_084); _084 : NH_FRM_084 ;
   	_085_S : UDINT := SIZEOF(NH_FRM_085); _085 : NH_FRM_085 ;
	   _086_S : UDINT := SIZEOF(NH_FRM_086); _086 : NH_FRM_086 ;
	   _087_S : UDINT := SIZEOF(NH_FRM_087); _087 : NH_FRM_087 ;
	   _088_S : UDINT := SIZEOF(NH_FRM_088); _088 : NH_FRM_088 ;
	   _089_S : UDINT := SIZEOF(NH_FRM_089); _089 : NH_FRM_089 ;
	   _090_S : UDINT := SIZEOF(NH_FRM_090); _090 : NH_FRM_090 ;
	   _091_S : UDINT := SIZEOF(NH_FRM_091); _091 : NH_FRM_091 ;
	   _092_S : UDINT := SIZEOF(NH_FRM_092); _092 : NH_FRM_092 ;
	   _093_S : UDINT := SIZEOF(NH_FRM_093); _093 : NH_FRM_093 ;
	   _094_S : UDINT := SIZEOF(NH_FRM_094); _094 : NH_FRM_094 ;


	   _229_S : UDINT := SIZEOF(NH_FRM_229); _229 : NH_FRM_229;
   	_230_S : UDINT := SIZEOF(NH_FRM_230); _230 : NH_FRM_230;
	   _231_S : UDINT := SIZEOF(NH_FRM_231); _231 : NH_FRM_231;	
		_232_S : UDINT :=	SIZEOF(NH_FRM_232); _232 : NH_FRM_232;		
		_233_S : UDINT :=	SIZEOF(NH_FRM_233); _233 : NH_FRM_233;		
		_234_S : UDINT :=	SIZEOF(NH_FRM_234); _234 : NH_FRM_234;		
		_235_S : UDINT :=	SIZEOF(NH_FRM_235); _235 : NH_FRM_235;		
		_236_S : UDINT :=	SIZEOF(NH_FRM_236); _236 : NH_FRM_236;		

		_246_S : UDINT :=	SIZEOF(NH_FRM_246); _246 : NH_FRM_246;		
	//	_247_S : UDINT :=	SIZEOF(NH_FRM_247); _247 : NH_FRM_247;		
		_248_S : UDINT :=	SIZEOF(NH_FRM_248); _248 : NH_FRM_248;		
	//	_249_S : UDINT :=	SIZEOF(NH_FRM_249); _249 : NH_FRM_249;		
		_260_S : UDINT := SIZEOF(NH_FRM_260); _260 : NH_FRM_260 ;			

(*
   _0_S : UDINT := SIZEOF(NH_FRM_0); _0 : NH_FRM_0 ;
   _0_S : UDINT := SIZEOF(NH_FRM_0); _0 : NH_FRM_0 ;
   _0_S : UDINT := SIZEOF(NH_FRM_0); _0 : NH_FRM_0 ;
*)




	   _END_FRM_WEB    : UDINT := 0;


	END_VAR

	FUNCTION_BLOCK _Nh_Create_FRM
   	VAR_INPUT
         Go          : USINT;
			all			: BOOL;
   	END_VAR
   	VAR_OUTPUT
         done        : BOOL;
			busy			: BOOL;
	      cyc         : UINT;
   	   files       : UINT;
      	actSize     : UDINT;
//         expTime    	: TIME;
   		GoNext		: USINT;
		END_VAR
   	done  := false;
      CASE go OF
       0 :  RETURN;
       1 :
            xFrmHed  := ADR(_START_FRM_SYS); 		
            Go 		:= 3;
				IF all THEN
					_Nh_Log_Path(wh:=1, fN:='FRM');	
// 	           rb       := ForceDirs(fileName := yTx2);
					yTx2 		:= CONCAT('New FRM_SYS: ',yTx2);
 					rb 		:= _Nh1RowTxt(logRst := 1);
					GoNext   := 2;
   			ELSE
					GoNext   := 0;
				END_IF;
				all	:= false;
       2 :
      		GoNext	:= 0;
				{$IFDEF __NH_WEB}
					xFrmHed  := ADR(_START_FRM_WEB); 			
					_Nh_Log_Path(wh:=1, fN:='FRM');	
					yTx2 		:= CONCAT('New FRM_WEB: ',yTx2);
 					rb 		:= _Nh1RowTxt(logRst := 1);

               Go    	:= 3;
            {$ELSE}	
               Go    	:= 99;
   			{$END_IF}

       3 :
				busy		:= true;
            cyc      := 0;
            files    := 0;
            actSize  := 0;
            xFrmHed  := xFrmHed + 1;
            Go       := 4;

       4 :
      	   cyc   := cyc + 1;
				_Nh_Log_Path(wh:=1, fN:='FRM');	
            WHILE xFrmHed^.Size > 0 DO
      	      yTx3 := CONCAT(yTx2, xFrmHed^.hed.Name ,'.FRM');
         	   fH   := FileOpen(fileName := yTx3, mode := F_WRITE);
            	IF fH <> INVALID_HANDLE_VALUE THEN
               	sz       := PTR_TO_UDINT(xFrmHed) + 4;
      	         sz       := FileWrite (hFile := fH, adrBuf := sz, size := xFrmHed^.size);
         	      actSize  := actSize + sz;
            	   files    := files + 1;
               	aSys.RWtoFileCycle := aSys.RWtoFileCycle + sz;
      	      END_IF;
         	   rb       := FileClose (hFile := fH);
      	      sz       := xFrmHed^.size + 4;
         	   xFrmHed  := xFrmHed + sz;
					IF _NhMaxRWLimit() OR _NhMaxTimeCyc()  THEN
						EXIT;
					END_IF;
(*
      	      expTime  := SUB_DT_DT(GetRTC(),aSys.NhDT);
      	      IF aSys.RWtoFileCycle > 32768 OR expTime > T#0.2s THEN
         	      EXIT;
            	END_IF;
*)
      	   END_WHILE;
         	IF xFrmHed^.Size = 0 THEN
               Go       := 99;
      	   END_IF;
       99:	
				Go := GoNext;
				IF Go = 0 THEN
         	   Done := TRUE;
         	   Busy := false;         	
				END_IF;	
      END_CASE;
	END_FUNCTION_BLOCK

	VAR_GLOBAL
   	fb_Nh_Create_FRM    : _Nh_Create_FRM;
	END_VAR


{ $ END_IF }

