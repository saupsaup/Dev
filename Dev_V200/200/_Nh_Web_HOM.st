{ $ IFDEF __NH_WEB }

TYPE
  	_T_NhWeather {HIDDEN}:  STRUCT 			
      r  : NH_ROW_O := ( ob := [
            (wh:= 1,  x:= 30     , y:= y1 + 30,    w:= 52 , fn := 48),                             // obrazok osvetlenia
            (wh:= 21             , y:= y1 + 30,    w:= 25,  fn := 0, BgC := 4 ),                   // % Osvetlenie celeho domu
            (wh:= 1,  x:= 165    , y:= y1 + 30,    w:= 48 , fn := 256),                            // oblacik
            (wh:= 21             , y:= y1 + 30,    w:= 25,  fn := 1, BgC := 4 ),                   // % Teplota celeho domu
            (wh:= 1,  x:= 280    , y:= y1 + 30,    w:= 48 , fn := 257),
            (wh:= 21             , y:= y1 + 30,    w:= 25,  fn := 2, BgC := 4 ),                   // % Vlhkost            ()
            (wh:= 1,  x:= 410    , y:= y1 + 30,    w:= 50 , fn := 262),
            (wh:= 21             , y:= y1 + 30,    w:= 25,  fn := 3, BgC := 4 ),                   // % vietor            ()
            (),
            ()
                                             );
      s  : ARRAY[0..3] OF NH_SLD_DAT := [
            (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%5.0f%%'     , txt := 1,  xv := 130 ),  // % osvetlenia
            (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%3.0f°'      , txt := 1,  xv := 250 ),  // vonkajsia teplota
            (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%5.0f%%'     , txt := 1,  xv := 370 ),  // % vlhkosti
            (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%5.0f m/s'   , txt := 1,  xv := 520 )   // vietor
                                              ];
   END_STRUCT;
  	_T_NhDaySun {HIDDEN}:  STRUCT 			
      r  : NH_ROW_O := ( ob := [
            (wh:= 1,  x:= 40     , y:= y1 + 90,    w:= 72 , fn := 269, cm := 199),                            // prazdny kalendar
            (wh:= 0,  x:= 40     , y:= y1 + 98,    w:= 38 , FgC := 4, BgC := 0, fn := 2, h := 24, cf :=(c:=0,n:=20), ntch := 1),                 // 2
            (),
            ()

                                             );
      s  : ARRAY[0..0] OF NH_SLD_DAT := [
            (t := 0, v1 := -320.0, v2 := 320.0   , fmt := '%5.0f%%'     , txt := 1,  xv := 130 )  // % osvetlenia
                                              ];
   END_STRUCT;
END_TYPE

VAR_GLOBAL CONSTANT
      _NhWth      : _T_NhWeather;
      _NhDoW      : _T_NhDaySun;

END_VAR

FUNCTION _NhHomObj {HIDDEN} : BOOL     // HOME menu
   VAR_INPUT
      row    : USINT;
//      obj    :  SINT;
   END_VAR
   _NhHomObj   := true;
   // xR^ a xO^   uz pride namapovane
   IF row < 3 AND xO^.cf.c > 0 AND xO^.cf.c <> 2 THEN
      _NhVal2(txt := 101, xy:=true, x:=xO^.x, y:=xO^.y + xO^.w/2+13, fmt := 2, wt:= 16, FgT :=4 );
   ELSIF row = 1 AND xO^.cf.c = 2 THEN
      CASE xO^.cf.n OF
        6 : //_NhVal2(obr := xO^.fn, wo := xO^.w);
        ;
      ELSE
      ;
      END_CASE;
//      IF xO^.cf.c
   END_IF;
END_FUNCTION

FUNCTION _NhKorHom {HIDDEN} : BOOL      // podla podmienky vrati o1, alebo o2
   VAR_INPUT
      all      : BOOL;
   END_VAR
   _NhKorHom := true;
   IF all THEN
      ;
   ELSE
      FOR jj := 0 TO _RowObr DO
         IF xR^.o.ob[jj].kxy = false THEN
            xR^.o.ob[jj].y := REAL_TO_INT( INT_TO_REAL(xR^.o.ob[jj].y) * yk );
            xR^.o.ob[jj].kxy := true;
         END_IF;
      END_FOR;
   END_IF;
END_FUNCTION

{ $ END_IF }
