(* WEB: GLObalna definicia TYPY, KONSTANTY, MASKY, MENU, FILTRE VAR POUZIVANE V CANVAS  *)


{ $ IFDEF __NH_WEB }



{ $ END_IF }




VAR_GLOBAL CONSTANT
   _e_NH_IDX_ROW        {HIDDEN}	   : NH_IDX_ROW;
	  eFilt_List			:  FILT_LIST;                                                                                      // prazdny filter
	  eFilt_List_typ		:  FILT_LIST_Typ;                                                                                      // prazdny filter
	
	  eRn     {HIDDEN} 	: NH_RUN_VAL2;

     eMnH     {HIDDEN} 	: NH_MNU := (     o := [(
                                        fn :=  1, wh :=  1, cm := 25  ), //       // logo
                                       (fn := 23, wh := 25, cm := 250  ),         // setup
                                       (fn :=  3, wh :=  0, cm := 20   ),         // home
                                       (fn := 41, wh := 42, cm := 21   ),         // FAV
                                       (fn := 16, wh := 17, cm := 22   ),         // rom
                                       (fn := 10, wh := 11, cm := 23   ),         // cat
                                       (fn := 27, wh := 28, cm := 24   ),         // act
                                       (fn := 49, wh :=  0, cm := 26   )]         // ON/OFF
                           );





      eMn0     {HIDDEN} : NH_MNU := (     o := [
                                       (fn :=  1, cm := 25),         // globalne nastaveia
                                       (fn := 23, cm := 250),        // setup ON/OFF
                                       (fn := 0),                    // home
                                       (fn := 41, cm :=  21),        // FAV
                                       (fn := 16, cm :=  22),        // rom
                                       (fn := 10, cm :=  23),        // cat
                                       (fn := 27, cm :=  24),        // act
                                       (fn := 0,)]);                 // ON/OFF


      eMn1     {HIDDEN} : NH_MNU := (     o := [(fn :=  0 ),  //  <
                                       (fn :=  0 ),  //  setup
                                       (fn :=  3,          cm :=  20),         // home
                                       (fn := 41,wh := 42, cm :=  21),         // FAV
                                       (fn := 16,wh := 17, cm :=  22),         // rom
                                       (fn := 10,wh := 11, cm :=  23),         // cat
                                       (fn := 27,wh := 28, cm :=  24),         // act
                                       (fn := 49,wh := 51, cm :=  26)]);       // ON/OFF

      eMvz      {HIDDEN} : NH_MNU := (     o := [(fn :=  6,wh :=   0,cm :=  31),       // <
                                       (fn :=   0,wh :=   6,cm :=   0, w:=72),  // obrazok vyssej casti
                                       (fn :=  35,wh :=  38,cm :=  33),          // 3 check
                                       (fn :=  10,wh :=  11,cm :=  34),          // 4 cat
                                       (fn :=  16,wh :=  18,cm :=  35),          // 5 all.rom / 1rom
                                       (fn := 348,wh := 348,cm :=  82),          // 6 priradit rom
//											      (fn :=  23,wh :=  24,cm :=  82),       	// 7-tune - parametre kurenia
//                                       (fn := 112,wh := 113,cm :=  36),          // visible
                                       (fn :=  39,wh :=  40,cm :=  37),          // 7-list     NESMIE SA OPRAVOVAT cm!!
                                       (fn :=  33,wh :=  34,cm :=  38)]);        // 8-play     NESMIE SA OPRAVOVAT cm!!


      eMn101     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (),
                                       (),
                                       (),
                                       (fn :=  23,wh :=  24,cm :=   3, x := xc)]);      // setup = Nastavenie parametrov

      eMn102     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (),
                                       (),
                                       (fn := 120,wh := 121,cm :=   1),          // Time
                                       (fn :=  23,wh :=  24,cm :=   3)]);        // setup = Nastavenie parametrov

      eMn103     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn := 122,wh := 123,cm :=   2,x:=xc-90),          // Level
                                       (fn :=  23,wh :=  24,cm :=   3,x:=xc   ),        // setup
                                       (fn :=  83,wh :=  84,cm := 121,x:=xc+90)]);           // tune predradnik / RGB


      eMn104     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (),
                                       (fn := 120,wh := 121,cm :=   1),             // Time
                                       (fn := 122,wh := 123,cm :=   2),             // Level
                                       (fn :=  23,wh :=  24,cm :=   3),             // setup
                                       (fn :=  83,wh :=  84,cm := 121)]);           // tune predradnik / RGB


      eMn105     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn := 120,wh := 121,cm :=   1,x:=xc-180),          // Time
                                       (fn := 122,wh := 123,cm :=   2,x := xc-90),          // Level + Ramp ON/OFF
                                       (fn := 124,wh := 125,cm :=   4,x := xc),          // COLOR
                                       (fn :=  23,wh :=  24,cm :=   3,x := xc+90),          // setup = Nastavenie parametrov
                                       (fn :=  83,wh :=  84,cm := 121,x := xc+180)]);        // tune predradnik / RGB


      eMnTLA   {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn :=  33,wh :=  34,cm :=   5,x := 205),          // PLAY = priradenie
                                       (fn :=  23,wh :=  24,cm :=   6,x := 385)]);        // setup

      eMnWSB   {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (),
                                       (fn :=  33,wh :=  34,cm :=   5,x := 205),          // PLAY = priradenie
                                       (fn := 204,wh := 205,cm := 120,x := 295),          // LED WSB
                                       (fn :=  23,wh :=  24,cm :=   6,x := 385)]);        // setup

      eMnPIR     {HIDDEN} : NH_MNU := (   o := [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn := 215,wh := 216,cm :=  10,x := 115),          // Day
                                       (fn := 217,wh := 218,cm :=  10,x := 205),          // Evening
                                       (fn := 219,wh := 220,cm :=  10,x := 295),          // Night
                                       (fn := 221,wh := 222,cm :=  10,x := 385),          // Morning
                                       (fn :=  23,wh :=  24,cm :=   9,x := 475)]);        // setup = Nastavenie parametrov


      eMnUsr     {HIDDEN} : NH_MNU := (   o :=
                                      [(fn :=   6,wh :=   6,cm :=  31),          //  <
                                       (fn :=  32,wh :=  25,cm := 101),          //  +
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=  79,wh :=  79,cm :=  55),          // Users
                                       (fn := 285,wh := 286,cm :=  56),          // Web
                                       (fn :=   0,wh :=   0,cm :=   0),
                                       (fn :=   0,wh :=   0,cm :=   0)]);



(*
   _NhObrXYZ {HIDDEN} :  ARRAY [-10..-1,0..3] OF INT :=                 // obrazky podla nejakej podmieny (typ,stav...)
            [
//                21, 79,315, 21,             // -11 ZONE
               258, 82,  0,  0,             // -10 RH,CO2,CO
               508,216,166,507,             // -9 BRA  garaz,brana,branicka,zavora
               168,169,169,168,             // -8 SIR/STROB/
               183,184,185,186,             // -7 HET
                60, 60, 60, 60,             // -6  FAV dash/quick/FAV all/FAV user
                17, 19, 15,17,              // -5  ROM   In/OUT/pivnica
               106,107,  0,  0,             // -4  TLA   1/2
               102,103,104,105,             // -3  WSB   2/4/8/5
               100, 99,100,100,             // -2  termoventil : TVE, spirala
               161,162,  0,  0              // -1  teploty  :    miestnost,vonku //,podlaha,kotol

            ];

   // wht   :  index _NhStavDev[wht] odkial sa zoberi parametre do prikazu pre zobrazenie
   //          _NhVal2(wh := _NhStaDev[s].wht, obr := _NhStaDev[s].val);
   //             wh    - je bud podklad, alebo jednorazova prikaz, ktory nadefinuje vykreslenie
   //             obr   - ak si ho funkcia (wh) inak nespracuje, tak je to obrazok
   // val   :  ak je > 0 = cislo obrazka
   //          ak je < 0 je to odkaz na _NhObrXYZ[val], kde su obrazky podla nejakeho kriteria k DEV (vacsinou xCfg^.typ). rozduje funkcia _NhObrNbr()

   _NhObrDev  :  ARRAY [0.._Nh_CFG] OF NH_DEF_OBR :=     // definicia zakladnych obrazkov a obrazkov stavu (stav=odkaz) pre  DEV
            [
            (wht :=   0, val :=  23),      //  wht = index _NhStavDev[wht], val = cislo obrazka   ak je val < 0 potom je odkaz na _NhObrXYZ[val]
            (wht :=   1, val :=  -5),      //  1 ROM INR/EXT
            (wht :=   0, val :=  11),      //  2 CAT
            (wht :=   0, val :=  21),      //  3 ZON  stavovy obrazok sa definuje v _NhBrw6 CASE:9, hlavny obrazok:=21
            (wht :=  27, val :=  30),      //  4 SCN
            (wht :=  25, val :=  28),      //  5 ACT  0/34

//            (wht :=  29, val :=  -7),      //  6 HET
            (wht :=   0, val := 183),      //  6 HET
            (wht :=  42, val :=  95),      //  7 KOT
            (wht :=  42, val := 100),      //  8 TVE
            (wht :=   0, val := 101),      //  9 CER

            (wht :=   5, val :=  62),      // 10 SVD
            (wht :=   7, val :=  63),      // 11 SVA
            (wht :=   9, val :=  64),      // 12 RGB

            (wht :=   0, val :=  -3),      // 13 WSB     stavovy obrazok sa definuje v _NhBrw6
            (wht :=   0, val :=  -4),      // 14 TLA     stavovy obrazok sa definuje v _NhBrw6
            (wht :=  23, val :=  87),      // 15 PIR
            (wht :=   3, val :=  -1),      // 16 TER
            (wht :=   3, val := 163),      // 17 TEH
            (wht :=   3, val := 164),      // 18 TEK
            (wht :=   4, val :=  86),      // 19 LUX
            (wht :=   0, val :=  -6),      // 20 FAV
            (wht :=  11, val :=  73),      // 21 ZAS
            (wht :=   0, val :=  78),      // 22 USR
            (wht :=  30, val :=  70),      // 23 VENT
            (wht :=   0, val :=  97),      // 24 KEY
            (wht :=   0, val := 298),      // 25 SMART-WAY
            (wht :=   0, val :=   1),      // 26   POI
            (wht :=   0, val :=   1),      // 27 H2O
            (wht :=   0, val :=   1),      // 28 FIR
            (wht :=   0, val :=   1),      // 29 GAS
            (wht :=   0, val := 110),      // 30 MAR
            (wht :=  44, val := 114),      // 31 ROL
            (wht :=  30, val :=  -8),      // 32 SIR
            (wht :=  35, val :=  91),      // 33 DOR
            (wht :=  33, val :=  92),      // 34 WIN
            (wht :=   0, val := 197),      // 35 BLI
            (wht :=   0, val :=   1),      // 36   XXX
            (wht :=  50, val :=  -9),      // 37 BRA
            (wht :=   0, val :=   1),      // 38 RFI-snimace
            (wht :=   0, val :=   1),      // 39 RFK-karty
            (wht :=   0, val := 310),      // 40 TGL
            (wht :=   0, val := -10),      // 41 COX  (RH,CO2,CO)
            (wht :=   0, val := 290),      // 42 DALI-M
            (wht :=   0, val := 063),      // 43 DALI-S
            (wht :=   0, val := 029)       // 44 DALI-G
            ];

   // _NhStaDev: vykreslenie obraka podlastavu DEV vo funkcii : _NhVal2(wh := _NhStaDev[].wht, obr := _NhStaDev[].val);
   // jedno dev v _NhStaDev ma viac viet, podla stavu
   //    _NhStaDev[wht+0]  := 1.veta ked xDev^.ou.val = 0.0;
   //    _NhStaDev[wht+1]  := 2.veta ked xDev^.ou.val > 0.0;
   //    _NhStaDev[wht+2]  := 3.veta ked moze existovat ine kriterium unikatne k DEV

   // vsetko sa vyrobi v _NhShwObj() ked xO^.wh := 3


   _NhStaDev {HIDDEN} :  ARRAY [0.._Nh_CFG] OF NH_DEF_OBR :=               // zobrazenie stavy DEV (obrazky, hodnoty, ikony ,,,)
            [
            (wht :=   0, val :=  23),      //  0 nic (obrazok setup)
            (wht :=   1, val :=   0),        //  1 ROM - zobrazenie teploty
            (),                              // 2 - volne
//            (wht :=  18, val :=  66),        //  2 ZON - zobrazenie teploty
            (wht :=   1, val :=   0),        //  3 teplota miestnosti,vonku,podlahy,kotla... podla typ
            (wht :=   2, val :=   0),        //  4 LUX - zobrazenie osvetlenia
            (wht :=  10, val :=  -1),        //  5 SVD - OFF   (-1 znamena ze sa nevykresli ziadny obrazok !!!)
//            (wht :=  11, val :=   0),        //  6 SVD - ON - v zltom kruhu s gradientom
            (wht :=  17, val := 201),        //  6 SVD - ON - v zltom kruhu s gradientom
            (wht :=  10, val :=  -1),        //  7 SVA - OFF
//            (wht :=  12, val :=   0),        //  8 SVA - lvl v zltom kruhu s gradientom
            (wht :=  17, val := 201),        //  8 SVA - ON - v zltom kruhu s gradientom
            (wht :=  10, val :=  -1),        //  9 RGB - OFF
//            (wht :=  12, val :=   0),        // 10 RGB - lvl v zltom kruhu s gradientom
            (wht :=  17, val := 201),        // 10 RGB - ON - v zltom kruhu s gradientom

            (wht :=  18, val :=  73),       // 11 ZAS - NEURCENY-OFF            sivy + obrazok
            (wht :=  18, val :=  62),       // 12 ZAS - SVE-OFF                 sivy + obrazok
            (wht :=  18, val :=  50),       // 13 ZAS - STYKAC-OFF               sivy + obrazok
            (wht :=  18, val :=  61),       // 14 ZAS - HET-OFF                 sivy + obrazok
            (wht :=  18, val := 159),       // 15 ZAS - NABIJ.STANICA-OFF        sivy + obrazok
            (wht :=  18, val :=  73),       // 16 ZAS - rezerva-OFF              sivy + obrazok

            (wht :=  13, val := 202),       // 17 ZAS - NEURCENY-ON             zeleny + obrazok
            (wht :=  17, val := 201),       // 18 ZAS - SVD-ON                  zlty   + obrazok
            (wht :=  13, val := 213),       // 19 ZAS - SYKAC ON                 zeleny + obrazok
            (wht :=  13, val := 203),       // 20 ZAS - HET-ON                  zeleny + obrazok
            (wht :=  13, val := 214),       // 21 ZAS - NABIJACIA STANICA-ON    zeleny + obrazok
            (wht :=  13, val := 202),       // 22 ZAS - rezerva -ON             zeleny + obrazok

            (wht :=  10, val :=  -1),       // 23 PIR - pir je v klude, neodpocitava sa nic
            (wht :=  16, val :=  89),       // 24 PIR - prihadza signal          cierna postava v modrom

            (wht :=  18, val :=  28),       // 25 ACT - OFF sipka v sivom kruhu
            (wht :=  20, val :=  28),       // 26 ACT - ON sipka v Azurovom kruhu bez gradientu

            (wht :=  18, val :=  30),       // 27 SCN - OFF scn v sivom kruhu
            (wht :=  14, val := 207),       // 28 SCN - ON  scn v oranzovom kruhu

            (wht :=   1, val :=   0),       // 29 HET - zobrazenie teploty

            (wht :=  10, val :=  -1),       // 30 VEN - OFF
            (wht :=  13, val := 215),       // 31 VEN - ON - v modrom kruhu s gradientom

            (wht :=   4, val :=   0),       // 32 TVE - vystredene cislo v azurovom kruhu

            (wht :=  18, val :=  -1),       // 33 WIN - OFF
            (wht :=  14, val :=  92),       // 34 WIN - ON - v modrom kruhu s gradientom

            (wht :=  18, val :=  -1),       // 35 DOR - OFF
            (wht :=  14, val :=  91),       // 36 DOR - ON - v modrom kruhu s gradientom

            (wht :=  18, val :=  66),       // 37 ZON - Unlocked 0
            (wht :=  14, val :=  67),       // 38 ZON - Lock   1/2
            (wht :=  15, val :=  67),       // 39 ZON - Lock full
            (wht :=  18, val :=  66),       // 40 ZON - Locking
            (wht :=  18, val :=  66),       // 41 ZON - Unlocking

            (wht :=  10, val :=  -1),       // 42 TVE - OFF
            (wht :=  40, val :=   0),       // 43 TVE - cerveny kruh s cislo v strede

            (wht :=  18, val := 114),       // 44 ROL - OFF  0%      dn - zatiahnute     sivy
            (wht :=  14, val := 115),       // 45 ROL - viac 1-99%   up/dn - povytiahnute      oranzovy
            (wht :=  23, val := 117),       // 46 ROL - pohyb hore               cerveny
            (wht :=  23, val := 118),       // 47 ROL - pohyb dolu               cerveny
            (wht :=  90, val := 501),       // 48 ŽAL - zatienene    siva
            (wht :=  90, val := 500),       // 49 ŽAL - zodtienene   biela

            (wht :=  18, val := 509),       // 50 GAR - OFF  0%         sivy
            (wht :=  23, val := 510),       // 52 GAR - otvorene  100%  cerveny
            (wht :=  18, val := 216),       // 53 BRANA - OFF  0%         sivy
            (wht :=  15, val := 217),       // 54 BRANA - otvorene  100%  cerveny gradient
            (wht :=  18, val := 166),       // 55 BRANICKA - OFF  0%         sivy
            (wht :=  23, val := 167),       // 56 BRANICKA - otvorene  100%  cerveny
            (wht :=  21, val := 506),       // 55 BRANICKA - OFF  0%         sivy
            (wht :=  23, val := 507)        // 56 BRANICKA - otvorene  100%  cerveny

         ];


   // tito parametre sa posielaju do _NhVal2(wh := _NhStaCat[s].wht, obr := _NhStaCat[s].val);
   // wht : funkcia
   // val : obrazok
   // vsetko sa vyrobi v _NhShwObj() ked xO^.wh := 2
*)

END_VAR



VAR_GLOBAL CONSTANT

	{ $ IF _nh_Cust = 0 OR _Nh_CUST = 1} 	 // vsetko

      _ePg0   : NH_PG_HOME :=
      (
      Hom := ( ob := [
               ( wh:= 1, x := xc,     y := yyc- 30,  w := 180,  fn := 255 ),                                  // domcek
               ( wh:= 1, x := xc,     y := yyc- 55,  w :=  32,  fn := 0 ),                                   // day/night vnutri
               ( wh:= 0, x := xc+ 40, y := yyc-120,  w :=  32,  fn := 140 ),                                  // day/night vonku
               ( wh:= 1, x := xc,     y := yyc-  5,  w :=  80,  fn :=  92,   cm := 50,    cf := (c:=2, n:=17)),   // okno
               (),
//               ( x := xc+ 30, y := yc+ 90,  w :=  50,  wh := 0,  fn :=  92, h := -70, FgC := 1, BgC := 8,   cf := (c:=2, n:=18)),   // otvorene dvere ( h > 0 : vymaze aj kruh pod obrazkom)
               ( x := xc- 30, y := yyc+ 90,  w :=  50,  wh := 0,  fn := 111, h := -70, FgC := 8, BgC := 1,   cf := (c:=2, n:=23)),   // otvoreny garaz
               ( x := xc+100, y := yyc+ 20,  w :=  50,  wh := 0,  fn :=  77, h :=   0,                       cf := (c:=2, n:=24)),  // otvorena brana/branicka
               ( x := xc- 45, y := yyc-130,  w :=  75,  wh := 1,  fn := 132, h :=   0,                       cf := (c:=2, n:=11)),  // fotovoltaika

               ( wh:=4, x := xc-60, y := yyc+45, w:=58, h:=48, fn := 0, FgC := 0, BgC := 0,   cf := (c:=1, n:=1)),   // otvorene dvere ( h > 0 : vymaze aj kruh pod obrazkom)
               ( wh:=4, x := xc-60, y := yyc+45, w:=58, h:=48, fn := 91, cm := 50,   cf := (c:=2, n:=18)),   // otvorene dvere ( h > 0 : vymaze aj kruh pod obrazkom)
               (BgC := 13)
                     ]),

      dsh :=  ( ob := [

               (x := 0,      y:= 0, wh := 0),
               (x := xc,     y:= yyc-253, w := 130, wh := 2, cm:=50),   // 1.kruznica pod obr.1 prvy hore
               (x := xc+158, y:= yyc-183, w := 130, wh := 2, cm:=50),   // 2.kruznica pod obr.2
               (x := xc+210, y:= yyc- 25, w := 130, wh := 2, cm:=50),   // kruznica pod obr.3 - vprav v strede
               (x := xc+158, y:= yyc+133, w := 130, wh := 2, cm:=50),   // kruznica pod obr.4
               (x := xc,     y:= yyc+203, w := 130, wh := 2, cm:=50),   // kruznica pod obr.5 - dolu
               (x := xc-158, y:= yyc+133, w := 130, wh := 2, cm:=50),   // kruznica pod obr.6
               (x := xc-210, y:= yyc- 25, w := 130, wh := 2, cm:=50),   // kruznica pod obr.7 - vlavo v strede
               (x := xc-158, y:= yyc-183, w := 130, wh := 2, cm:=50)    // kruznica pod obr.8
                     ]),

      Qck :=  ( ob := [

               (x := xc-220, y := yy2-70, w := 64, wh := 0),                      // 1 - preve zprava
               (x := xc-220, y := yy2-65, w := 64, wh := 2, cm:=50),                      // 1 - preve zprava
               (x := xc-130, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc- 40, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc+ 50, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc+140, y := yy2-65, w := 64, wh := 2, cm:=50),
               (x := xc+230, y := yy2-65, w := 64, wh := 2, cm:=50),                      // 6 - posledne zlava
               (x := xc+320, y := yy2-65, w := 64, wh := 2, cm:=50),                      // 7 - dalej
               ()
                     ]),
      xy := [
               (),
               (x := 380, y := 275),
               (x := 490, y := 400),
               (x := 490, y := 562),
               (x := 380, y := 693),
               (x := 205, y := 693),
               (x :=  87, y := 569),
               (x :=  87, y := 400),
               (x := 200, y := 275)
               ],

      );


	{ $ END_IF } 	


	{ $ IF _Nh_CUST = 2} 	                // Futbal.stadion HE
      _ePg0 : NH_PG_HOME :=
      (
      Home := ( ob := [
               ( x := xc,    y:= yc- 20, w:= 600, wh:=1,          fn := 300 ),                    // futb.stadion
//               ( x := xc+15, y:= yc- 20, w:= 160, wh:=1,          fn := 301 ),                    // futb.stadion
               ()
                     ]),
      Dash :=  ( ob := [
               (x := xc-200, y:= yc+220, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.1 prvy hore
               (x := xc-200, y:= yc+ 65, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.2
               (x := xc-200, y:= yc-105, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.3 - vprav v strede
               (x := xc-200, y:= yc-260, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.4
               (x := xc+195, y:= yc-260, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.5 - dolu
               (x := xc+195, y:= yc-105, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.6
               (x := xc+195, y:= yc+ 65, w := 110, wh := 2 , cf := (c := 2)),   // kruznica pod obr.7 - vlavo v strede
               (x := xc+195, y:= yc+220, w := 110, wh := 2 , cf := (c := 2))    // kruznica pod obr.8
                     ]),

      Quick :=  ( ob := [

               (x := xc+320, y := y2-60, w := 64, wh := 2),
               (x := xc+230, y := y2-60, w := 64, wh := 2),
               (x := xc+140, y := y2-60, w := 64, wh := 2),
               (x := xc+ 50, y := y2-60, w := 64, wh := 2),
               (x := xc- 40, y := y2-60, w := 64, wh := 2),
               (x := xc-130, y := y2-60, w := 64, wh := 2),
               (x := xc-220, y := y2-60, w := 64, wh := 2),
               (x := xc-310, y := y2-60, w := 64, wh := 2),
               (),
               (w := 48, wh := 100)                    // weather
                     ]),

      );
	

      eMnHfs     : NH_MNU := (  n := 3,                                               // len obrazok HOME
                              o := [(fn :=  1),(fn := 0),
                                       (wh := 4, fn := 4, cm :=20, x:=xc, y:= y2+55),         // home
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 ),
                                       (wh := 0, fn := 0, cm :=0 )
                                       ]);

   { $ END_IF } 	


	{ $ IF _Nh_CUST = 3} 	                // zimny stadion HE
      _ePgHome : NH_PG_HOME;
	{ $ END_IF } 	
END_VAR

//      pHet     : ARRAY[0..1,1..4] OF USINT := [170,172,174,176, 171,173,175,177];                                       // HeatMode */1/2/3/ manual/program
//      pTve     : ARRAY[0..1,0..3] OF USINT := [ 49,172,174,176,  52,173,175,177];                                       // Tve    Off/1/2/3/ manual/program



TYPE

(*

   NH_WEB_SS	{HIDDEN}  : STRUCT
      newLogin : BOOL;
   END_STRUCT
   NH_WEB_PD	{HIDDEN}  : STRUCT
      usr      : USINT;          // prihlaseny user na stranke
      new      : BOOL;
      usage    : USINT;
   END_STRUCT
   NH_WEB_IP	{HIDDEN}  : STRUCT
      pg      : USINT;          // prihlaseny user na stranke
      ip      : TIPadr;
      new     : BOOL;
   END_STRUCT
   NH_WEB_PG	{HIDDEN}  : STRUCT
      pg      : ARRAY [1.._Nh_WEB_M] OF NH_WEB_PD;       // stav usrov
      ip      : ARRAY [1..8] OF NH_WEB_IP;             // novo prihlasena IP
      ses     : USINT;                                // pocet aktivnych session
   END_STRUCT

   NH_WEB_ACC 	{HIDDEN} : STRUCT
      wO 	   : TWebServerAccessTable;   	          // Old web acces table
      wA 	   : TWebServerAccessTable;   	          // NEW web acces table
      pgN      : NH_WEB_PG;
      pgO      : NH_WEB_PG;
      WebChg   : UINT;
   END_STRUCT

  	NH_SLD_POX {HIDDEN} :  STRUCT     // struktura pre slider z viacerych casovych pointov
      mx       : REAL;
      my       : REAL;
      xy       : ARRAY[0..1,0..7] OF INT;             // suradnica zobrazeneho casu nad vynasacou ciarou pointu 0=x,1=y
  	END_STRUCT;

  	NH_SLD_CPY  {HIDDEN}  :  STRUCT     // struktura pre slider z viacerych casovych pointov
      all      : BOOL;                                // je vybraty zdrojovy den pre kopirovanie, nemenia sa dni, len sa oznacuju do kopirovania
		chk		: BOOL;											// aspon jeden DEV je oznaceny na cpy
      cpy      : BOOL;                                // je vybraty zdrojovy den pre kopirovanie, nemenia sa dni, len sa oznacuju do kopirovania
		src		: USINT;											// zdrojovy den	
		dst		: NH_BTN15;                            // ciele kam sa bude kopirovat
  	END_STRUCT;





  	NH_OBJ_DSH {HIDDEN} :  STRUCT       // velkost: 30  vseobecny objekt  			
      wh       : USINT := 102;                  // 0=nic,1=obrazok...2=...
		x			: INT ;                     		// 1 x-ova suradnica stredu objektu
		y			: INT ;         				      // 3 y-ova suradnica stredu objektu (default pre spodne menu)
		w			: INT := 80;            		   // 5 sirka  (pri obrazku je to aj vyska)
      cm       : USINT := 251;                  // 11 command, ktory vrati pri stlaceni
		dash		: INT			:= 381;      			// 7	cislo obrazkaDSH
		vMin		: REAL		:= 0.0;					// 9  minimalna hodnota
		vMax		: REAL		:= 18.0;					//	13 max.hodnota pre zobrazenie
		tx1		: STRING[3] := 'Min';				// 17 text laveho intervalu : Min,Avg, pravy je vzdy Max
		title		: INT;									// 21 cislo textu dash
		idx		: USINT;                         // 23 index na aMeteo.idx[]
//		tx2		: STRING[3] := 'Max';            // 21
		mj			: STRING[3]; 							// 25	popis jednotky °C, %, hPa

      Qr       : BOOL;                            // 29 zaciatok dotyku (tch = true )
      Qf       : BOOL;                            // koniec dotyku (tch = true )
      Qs       : BOOL;                            // koniec dotyku slidera
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL;                            // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte
												
	END_STRUCT;                      					// 30 byte


  	NH_OBJ_124   {HIDDEN}   :  STRUCT    // prepinac medzi obrazkami, alebo chck 15 obrazkov v 2 riadkoch
      // prvy riadok
      wh       : USINT 	:= 124;
		x			: INT 	:= 60;                  	// x-ova suradnica stredu objektu 1.obrazka
		y			: INT 	:= y1+130;         			// y-ova suradnica stredu objektu 1.obrazka
      w        : INT 	:= 490;                    // velkost obrazka
      cm       : USINT 	:= 251;                  	// ... len pre kompatilititu
      h        : INT 	:= 50;                     // vzdialenost medzi obrazkami
		nObr		: USINT	:= 7;								// pocet obrazkov
		Obr1 		: USINT	:= 1;                      // cislo prveho obrazka
      aVar  	: UDINT;                           	// adresa cielovej premennej, kde sa uklada posledny vyber
      typ      : USINT 	:= 1;                     	// typ cielovej premennej 1=usint,3=sint
      aArray	: UDINT;                           	// adresa cieloveho pola
		WrkVar	: USINT;										// pomocna premenna - ak sa cislo vyberu neuklada do nejakej premennej je va adrese aVar tato premmenne,
		WrkArray	: NH_BTN15;									// pomocne pole [0..15]
      FgC      : USINT 	:= 4;                     	// oramovanie vybrateho riadka = kruznica
      BgC      : USINT 	:= 4;                     	// vypln kruznice
		// 27
		xxxx     : INT 	:= 28;                           // vyska textu
      // bit 29
		Visible	: BOOL := true;							// len zobrazit
		Enable	: BOOL := true;							// povolenie vyberat
		Chceck	: BOOL := true;                    	// vybera vsetky volby (ink len jednu a ostatne nuluje)
		Circle	: BOOL := true;							// oramovanie vyberu je kruznica
		Set4		: BOOL;                             //
		Set5		: BOOL;
		set6		: BOOL;
      Q        : BOOL;									  // xA^.trg.Q - musi si nulovat objekt	
		// bit 30
      Qr       : BOOL;                            // xA^.trg.Qr
		Qf       : BOOL;                            // xA^.trg.Qf
      Qs       : BOOL;                            // toto pouziva objekt, nenastavuje sa nikde - koniec dotyku slidera, ....
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL;                            // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte


      // druhy riadok
		xTxt		: INT 	:= 60;                  	// x-ova suradnica stredu objektu 1.obrazka
		yTxt		: INT 	:= y1+130;         			// y-ova suradnica stredu objektu 1.obrazka
      wTxt     : INT 	:= 490;                    // velkost obrazka
      hTxt     : INT 	:= 25;                     // vzdialenost medzi obrazkami
      FgTxt    : USINT 	:= 2;                     	//
	
	
		ObrOff      : ARRAY[1..8] OF INT :=        	// nevybraty obrazok obrazka
							[120,148,147,130,131,378, 33];   	// nacasovat/SunRise/SunSet/DarkOff/DarkOn/random/odpocita cas od spustenia
      ObrSet      : ARRAY[1..8] OF INT :=          // vybraty obrazok
							[121,148,147,130,131,378, 34];
      TxtSet      : ARRAY[1..8] OF INT :=          // cislo textu k vybratemu obj
							[543,544,545,546,547,548,549];
		CmdSet      : ARRAY[1..8] OF USINT;          // doplnujuci CMD co sa ma urobit po vybere, normalne nic
		Dummy9		: ARRAY[1..25] OF USINT;
		// koniec 4.riadka
	END_STRUCT;



  	NH_OBJ_ROL  {HIDDEN} :  STRUCT       // velkost: 30  ROLETY zobrazenie
      wh       : USINT 	:= 109;         			// 0         	
		x			: INT		:= 50;                  // 	lavy horny roh ROL -
		y			: INT 	:= 200;                 //
		w			: INT 	:= 430;			         // 	sirka ROL
		cm			: USINT  := 251;                 // 7	len pre kompatibilitu
		h			: INT 	:= 658;			         // 	vyska ROL
		// 11
		yCirRol	: INT;                 				// 	suradnica gulicky ROL
		yCirLam	: INT; 			         			// 	suradnivc gulicky LAM

		bRol     : INT		:= 50;	                  // 10	vyska boxu nad roletou
		xLam		: INT		:= 530;                 // 	lavy horny roh LAM slidera
		yLam		: INT 	:= 220;			
		xObrR		: INT		:= 80;                  // 	x-suradnica obrazka rolety
		wObr		: USINT	:= 60;						//	 	sirka/vyska obrazku
			cf			: NH_DEV_IO;							//23	 byte 23 	
      // byte 29
		dummy0	: BOOL;                          // byte 29
		dummy1	: BOOL;
		dummy2	: BOOL;
		dummy3	: BOOL;
		dummy4	: BOOL;
wwwWindGuardOn	: BOOL;                            // bezi ochrana pred vetrom
wwwHandBlkWind	: BOOL;							  	  // priznak rucneho blokovania WindG	
      Q        : BOOL;									  // xA^.trg.Q - musi si nulovat objekt	
		// byte 30
      Qr       : BOOL;                            // xA^.trg.Qr
		Qf       : BOOL;                            // xA^.trg.Qf
      Qs       : BOOL;                            // toto pouziva objekt, nenastavuje sa nikde - koniec dotyku slidera, ....
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL := true;                    // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte

		// obj 2 = 30 byte (0 byte )
      wh2      : USINT 	:= 0;  							//0	wh v 2 objekte                	
		rCirSld	: INT		:= 30;							// 	r gulicky slidera
		rCirUpDn	: INT		:= 35;							// 	r gulicky slidera	pri zobrazeni pohyby
		wObrInfo	: INT		:= 90;							// 	velkost info obrazka
		corner	: INT 	:= 3;	

wwwCMD		: USINT;										// 	co sa ma urobit
			wwwCMDf		: USINT;										// 	
		wSldLam	: INT 	:= 14;							//	 	hrubka aktivnej casi slidera

		hLam		: INT 	:= 615;		            // 	vyska * dlzka slidera odhora nadol
		xObrL		: INT		:= 335;	                  // 	x-suradnica obrazka LAM
		yObr		: INT		:= 900; 						// 	y-suradnica obrazkov a textu % pod  Rol



		hTxt		: USINT	:= 34;							// 	vyska textu
wwwpRol		: USINT;										// 	poziadavka na ROL v %
wwwpLam		: USINT;										// 	poziadavka na LAM v %
		// 19
		nLam		: USINT 	:= 16;							// 	pocet lamiel
		wLMax   	: INT 	:= 40;                     // 	sirka {vyska} lamely pri uplnom zaklopeni
		wLold		: INT 	:= 40;							// 	minimalna vyska lamely pri uplnom otvoreni
		mLam		: INT 	:= 10;							// 	bocny okraj medzi lamelou a lavym/pravym oranovanim
      chk    	: BOOL;                             // 28 .. odpoveda Qr
		SldRol	: BOOL := true;							// 	zobrazit slider ROL   .. odpoveda Qf
		SldLam	: BOOL := true;							// 	zobrazit slider LAM
		tchLam	: BOOL := true;							// 	povolit nastavovanie slidera LAM
		tchUpDn	: BOOL := 0;								// 	pri dotyku len spustit zmenu smeru  CMD=1 .. ma prednost pre sliderom ROL
		StatRow	: BOOL := true;							// 	vykresluju sa aj statusove obrazky a hodnoty pod obrazkom														
		ShwLamUp	: BOOL := true;							// 	vykresluju sa aj statusove obrazky a hodnoty pod obrazkom															
	END_STRUCT;                      					// 60 byte

  	NH_OBJ_4O1  {HIDDEN}    :  STRUCT		// obrazky nad ROM DayMode/Sviecka
      wh          : USINT := 107;                           // 1
      obj         : USINT := 1;                             // 2        cislo obj ku ktoremu sa vykresluju info obj
      ok          : ARRAY [1..4] OF BOOL := [1,1,0,0];      // aktivny
      fil         : ARRAY [1..4] OF BOOL := [1,1,1,1];      // vypln BgC
      txt         : ARRAY [1..4] OF BOOL;                   // text
      crc         : ARRAY [1..4] OF BOOL  := [1,1,1,1];      // podklad-kruh
      obr         : ARRAY [1..4] OF INT   := [142,131,142,144]; // cislo obrazka Day/sviecka/evening/night/
      wxy         : ARRAY [1..4] OF USINT := [40,40,40,40]; // polomer kruhu/kruznice
      BgC         : ARRAY [1..4] OF USINT := [1,1,1,1]; 		// 4,22     ak fil:=true: vypln kruhu,  ak fil:=false farba kruznice
      FgT         : ARRAY [1..4] OF USINT := [4,4,4,4];     // 4,26     farba textu
      cmd         : ARRAY [1..4] OF USINT;                  // co sa ma vykonat
   END_STRUCT;

  	NH_OBJ_4O2  {HIDDEN}  :  STRUCT 		// obrazky nad STAT	 Time/Pir			
      wh          : USINT := 107;                           // 1
      obj         : USINT := 2;                             // 2        cislo obj ku ktoremu sa vykresluju info obj
      ok          : ARRAY [1..4] OF BOOL ;      				//          aktivny
      fil         : ARRAY [1..4] OF BOOL ;      				// vypln BgC
      txt         : ARRAY [1..4] OF BOOL;                   // text
      crc         : ARRAY [1..4] OF BOOL;                   // 0        kruh
      obr         : ARRAY [1..4] OF INT := [232,226];             // cislo obrazka time/pir
      wxy         : ARRAY [1..4] OF USINT := [34,34,34,34]; // polomer kruhu/kruznice
      BgC         : ARRAY [1..4] OF USINT := [10,10,10,10]; // 4,22     ak fil:=true: vypln kruhu,  ak fil:=false farba kruznice
      FgT         : ARRAY [1..4] OF USINT := [4,4,4,4];     // 4,26     farba textu
      cmd         : ARRAY [1..4] OF USINT :=[44,45];                  // co sa ma vykonat
   END_STRUCT;




  	NH_ROW {HIDDEN} :  STRUCT              // jedne riadok			
      h        : NH_ROW_H;
      o        : NH_ROW_O;
	END_STRUCT;


 	NH_FIL {HIDDEN} :  STRUCT 		          	   // hlavicka a FILTER aktualneho browsu
      cf          : NH_DEV_IO;                  // identifikacia DEV
		dev			: FILT_LIST; 		            // hlavny filter pre DEV
		cat			: FILT_LIST; 		            // hlavny filter pre CAT
      rom         : USINT;                      // filter na rom
      typ         : SINT;                       // filter na TYP
	END_STRUCT;


  	NH_TCH {HIDDEN} :  STRUCT 			
		aObj			: UDINT;
      evn         : USINT;                            // vyhodnotene cislo udalosti
      cmd         : USINT;                            // vysledny prikaz podla udalosti 20=home screen
      cm          : USINT;                            // command z objektu
      wh          : USINT;                            // wh z objektu riadka nad ktorym bol posledny dotyk   xR^.o.ob[0].wh
      wht         : SINT;


      cmdNext       : USINT;
      xMwht        : SINT;
      col         : SINT :=  1;                       // stlpec v riadku
      row         : SINT := -1;                       // riadok, v ktorom bolo stlacenie
      obj         : SINT := -1;                       // objekt v riadku na ktorom bol stlacenie
      tme         : UINT;                             // cas podrzania
		x1,x2,y1,y2 : INT;                              // suradnice pri prvom/poslednom stlaceni alebo od zaciatku pres
      ok          : BOOL;                             // priznak vyhodnotenia az do najblizsieho noveho dotyku
//      mnu         : BOOL;                             // nove menu
//      tob         : BOOL;                             // na nejakom objekte bol dotyk
//      prs         : BOOL;                             // je press
//      Qpr         : BOOL;                             // impulz pri prvom vyhodnoteni (aj na nevybratom objekte)
//      Qpf         : BOOL;                             // impulz pri ukonceni press     (aj na nevybratom objekte)
      Q           : BOOL;                             // priznak stlacenia nad vybratym objektom
      Qr          : BOOL;                             // impulz pri 1.stlaceni nad vybratym objektom
      Qf          : BOOL;                             // impulz pri uvolneni stlacenia nad vybratym objektom
//      Qs          : BOOL;                             // impulz LEN pre slider - aktivuje sa pri Qf a sposobi este jednu otocku, aby sa odcitali posledne zapisane data - najma pri dotyky nad sliderom
      del         : BOOL;                             // priznak vymazania riadka (row)
      cpy         : BOOL;                             // priznak kopirovania riadka (row)
//      Bl          : BOOL;
      End         : BOOL;                             // uplne ukoncenie udalosti
      mnu         : BOOL;                             // dotyk bol na menu
      sld         : BOOL;                             // pohybujeme sliderom
      p1          : BOOL;                             // priznak s ktorym pracuje  program
      p2          : BOOL;                             // priznak s ktorym pracuje  program
   END_STRUCT;

   NH_TCH_WHT {HIDDEN} : STRUCT      				// HLAVNA RIADIACA PREMENNA
      n           : USINT;
      t           : ARRAY[0..5] OF NH_TCH;
   END_STRUCT;

  	NH_R_XY {HIDDEN} :  STRUCT 												
      xp          : INT := 0;                                // x-posuv celej strany
      yp          : INT := y1;                               // y-posuv celej strany
	END_STRUCT;


  	NH_SLD_POD {HIDDEN} :  STRUCT     // struktura pre slider z viacerych casovych pointov
//  		edit		: BOOL;									// priznak editacie = blokuje zmenu dna typ.dni

		edit		: NH_DEV_CF;
      btn      : BOOL;                          // bol stlaceny btn na Typ_Day
      zom      : BOOL;                          // je vybraty bod a je vyvyseny
      tch      : BOOL;                          // bol tch nad tymto obewktom
      prs      : BOOL;                          // drzime objekt = pohybujeme sa
      Qf      	: BOOL;                          // pustime objekt - impulz
      idx      : BOOL;                          // preindexovat
      day      : USINT;                         // vybraty typovy den pri editacii
      tpr      : USINT;                         // pocet cyklov  vyhodnotenie press nad navesim
		WhtPoi	: USINT;									// pre HET,HEV 0..1
//      Zon      : USINT;                         // zona, s rodicovskym rozvrhom 0,1 =Home
      poi      : int;                           // cislo vety v aCfg[26]
      p        : SINT := -1;                    // pocet pouzitych pointov :                                 VYPOCITA SA
      x        : SINT := -1;                    // vybraty point pri presuvani                               pomocne pole
      cf       : NH_POD_CFG;
   END_STRUCT;

  	NH_BRW {HIDDEN} :  STRUCT 											 // m-stranka univerzalneho browsu
      r           : ARRAY[0.._RowBrw] OF NH_ROW;             // objekty browsu znamenaju jedno DEV. Ak ma iba jedne stlpec, tak vtedy je r aj riadok
      s           : ARRAY[0.._SldNbr] OF NH_SLD_DAT;
      xy          : NH_R_XY;                                 // treba urobit korekciu xy
      rw          : USINT;                                   // aktualne naplneny pocet riadkov
      ref         : BOOL;                                   // priznak refreshovania pre brw200
      kor         : BOOL;                        // priznak, ci uz boli korigovane zlozky x,y
	END_STRUCT;

  	NH_POD {HIDDEN} :  STRUCT 											 // m-stranka univerzalneho browsu
		// toto je pre kopirovanie	
//		cf				: NH_DEV_IO;
      po          : NH_SLD_POD;
      cp          : NH_SLD_CPY;
      px          : NH_SLD_POX;
	END_STRUCT;


 	NH_LVL  {HIDDEN} : STRUCT 		           	    // hlavicka a FILTER aktualneho browsu
      //pg          : USINT;                       // typ stranky 0=home,2=FAV,ROMS,CAT,ACT,
      obj         : USINT;                       // objekt/typ stranky podla _NhDefObj
      vaz         : USINT;                       // cislo vazieb
      Naz         : STRING[20];                  // nazov v hlavicke lelvel
      Fil         : NH_FIL;                      // fitre DEV
      rw1         : NH_DEV_IO;                  // co je v prvom riadku
      obd         : USINT;                       // cislo objektu, kde je dsh
      dsh         : USINT := 0;                  // typ dsh : 0=home page, 1-riadok,2=3x2,3=6x2,
      fdv         : USINT;                       // filter len na jedno DEV - pomozne pole pre zapamatanie aktualneho vyberu
      srt         : USINT;                       // sposob sortovania
      vis         : BOOL := true;                // visible (to co sa deje na stranke da prenasa do hardware)
      brw         : BOOL;                        // je browser, inak form
      chk         : BOOL;                        // tento browser ma namiesto FAV chck
      fvz         : BOOL;                        // filter na vazby v tomto browsesa vypisuju len priradene vazby (riadchy z chk=true) (ide sa priamo po vazbach)
      psn         : BOOL;                        // zobrazuju sa ikony k zabezpecovacke
//      lst         : BOOL;                        // setup list HET,VEN,SCL,ACL....
      blR         : BOOL;                       	// nefiltruje miestnosti - zablokuje rom aj odstrani ikonu miestosti zo spodneho menu
	END_STRUCT;

  	NH_FRM_CAT {HIDDEN} :  STRUCT 			// enimane veliciny pre ROM,ZON
      cat         : ARRAY[0.._Nh_CAT]    OF BOOL;          // status kategorie - nieco je zapnute
   END_STRUCT;

  	NH_CAN {HIDDEN} :  STRUCT 											// definicie USRA + FAV a canvas s dotykom
      usr         : USINT;                                  // prihlaseny user = cislo vety v aCfg[22]usr musi byt na zaciatku, lebo od naz sa maze browser
      sbj         : USINT := 1;                                // subjekt = cislo vety ZON  aCfg[3]
      UsrRight    : USINT;
      nIP         : USINT;                                  // cislo IP v ramci usra
      fav         : NH_DEV_IO;
      cat         : NH_FRM_CAT;
      trg         : aTrg;                                   // triger pre dotyk na CANVAS
		CatOk			: BOOL;												// uz bol urobeny zoznam cat
      hom         : BOOL;                                   // vyvolat cisty Homepage
      admin       : BOOL;
      Logout      : BOOL;                                      // priznak zobrazenia Logout
      tch         : NH_TCH;                                 // udalost od dotyky/podrzania....
      yk          : REAL := 1.0;                            // korekcia y//      can 			: TCanvasData4096;
      can 			: TCanvasData6144;

//      can 			: TCanvasData4096;
//      can 			: TCanvasData;
	END_STRUCT;

  	NH_IXB {HIDDEN} :  STRUCT 											 // definicia browsu
      ix1         : USINT;                                   // cislo indexu 1.naplnenej vety v browse bez offset
      ix2         : USINT;                                   // cislo indexu naplenenej poslednej vety ( riadku browsu = rws)
      idx         : USINT;                                   // pocet viet od ix0;
      ofs         : USINT;                                   // ofset 1.vety v poli indexov  [0...8,8][8...10,2] ... 0,8
      n           : USINT;                                   // pocet stranok (bodov navigatora)
      w           : USINT := 50;                             // rozostup medzi bodmi
      pg          : USINT;                                   // cislo aktualnej stranky
      x1          : INT;                                     // x-suradnica 1.bodu
      row         : NH_DSH_OBJ;                              // pocet riadkov a stlpcov pre browser
	END_STRUCT;

  	NH_M {HIDDEN} :  STRUCT 												 // m-stranka univerzalneho browsu
      // odtialto sa maze po prihlaseni
      naz         : STRING[20];                                // editovanie nazvu v hlavicke
      lvl         : USINT;                                     // level vnorenia
      lvp         : USINT;                                     // level + pg
      lng         : USINT;                                     // jazyk
      wht         : SINT;                                      // sposob ziskania dat do browsu
      iter        : SINT;                                      // iteracia
      delay       : UINT;                                      // cakanie medzi vykreslovanim (delay)
      new         : INT := -1;                                 // ND cislo pridaneho/najdeneho/vymazaneho riadka v ramci aCfg[cf]
      set         : BOOL;                                      // povolenie setup modu
      edt         : BOOL;                                      // prebieha editacia nazvu (tit)
      rgb         : BOOL;                                      // farba preRGB sa vybera aj cez slidery
      srt         : BOOL;                                      // moze preusporiadat riadky
      frm         : BOOL;                                      // aktivny vnoreny web iFrame (prekryje / deaktivuje can)
//      ref         : BOOL;                                      // prinak refreshu webu (ze prave bol refresh)
      htx         : USINT ;                                    // ktora webova stranka je zobrazena
      htt         : STRING; // := 'https://nachhouse.atlassian.net/secure/RapidBoard.jspa?rapidView=1&projectKey=NACH&selectedIssue=NACH-13' ;                             // webova adresa 'https:/www.nachhouse.sk'
      mno         : ARRAY[1..2] OF NH_OBJ_MNU;                 // zalohovanie horneho riadka pri editacii
      mnu         : ARRAY[0..3] OF NH_MNU;                    // menu
		lvd			: ARRAY[0..3] OF NH_LVL;						  // data jednotlivych vnoreni (level=lv)
      ixb         : ARRAY[0..1] OF NH_IXB;
      brw         : NH_BRW;                                   // brows
		pod			: NH_POD;
	END_STRUCT;

  	NH_WEB  {HIDDEN}:  STRUCT 			
		M			   : ARRAY[1.._Nh_WEB_M] OF NH_M;
      A           : ARRAY[1.._Nh_WEB_M] OF NH_CAN;
      nbr         : USINT;                         // ktory aWeb[nbr] je prave aktivny
      nrf         : USINT;								// actual count refresh display
      trg         : aTrg;
      Go          : BOOL;
	END_STRUCT;

  	NH_CAT_DSC {HIDDEN}:  STRUCT 					// categorie
 		Name        : STRING[13];
      typ         : SINT := 125;                   // filter CAT=recno(), alebo ak je > 99 tak zoznam
      dev         : USINT;                          // filter dev alebo ak je > 99 tak zoznam
      obr         : USINT := 12;
      ob0         : USINT;
      ob1         : USINT;
      Dsc         : STRING[25];

	END_STRUCT;

  	NH_STP_DSC {HIDDEN}:  STRUCT 					// categorie
 		Name        : STRING[13];
//      typ         : USINT := 255;                   // filter CAT=recno(), alebo ak je > 99 tak zoznam
      typ         : SINT := 125;                   // filter CAT=recno(), alebo ak je > 99 tak zoznam
      dev         : USINT;                          // filter dev alebo ak je > 99 tak zoznam
      obr         : USINT := 23;
	END_STRUCT;

*)
END_TYPE




