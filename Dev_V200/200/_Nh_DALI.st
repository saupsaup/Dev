{$IFDEF __NH_DALI}
VAR_GLOBAL CONSTANT
		_Nh_DALI_MA	{HIDDEN} : USINT	:=  2;			 									// pocet samostatnych sad vazieb aVaz[_Nh_VIO]
END_VAR

TYPE
   NH_DL_RUN  {HIDDEN} : STRUCT
      nbr         : USINT;
      nPar        : USINT;                   // poradove cislo prarametra
      End         : USINT;                   // pocet cyklov do ukoncenia FB
      mSec        : TIME;                    // trvanie [mS]
      nCyc        : UINT;                    // trvanie
      enable      : UINT;
      busy        : USINT;
      done        : USINT;
      err         : USINT;
      ErrID       : USINT;                   // posledna/aktualna chyba
      cmd         : NH_DL_CMD;              // posledny prikaz
   END_STRUCT;

   NH_DLM_GO  {HIDDEN} : STRUCT
      Ok          : BOOL;                                   // nieco sa vykonava
      ClrSha      : BOOL;                                   // zmazat
      NewSha      : BOOL;                                   // nove adrresy k existujucim
      ChkSha      : BOOL;                                   // Zistit pritomnost SHA
      QueSha      : BOOL;                                   // Nacitat vsetky parametre
      ChkGrp      : BOOL;                                   // Zistit pritomnost GRP
      QueGrp      : BOOL;                                   // Nacitat default par
      Go          : BOOL;                                   // zaradit do fronty
      sha         : USINT;                                  // nova adresa
   END_STRUCT

END_TYPE


FUNCTION _Nh_DL_sha {HIDDEN} : USINT	    // vrati cislo SHA (0..64)/ DMA (1..2) / alebo skupiny (100..115)   podla cisla vety ND
   VAR_INPUT
      ma    : BOOL;        // vrati cislo mastra, inak SHA
      gr    : BOOL;        // co je v ND - grupa (44) alebo ballast (43)
      nd    : INT;
   END_VAR
   _Nh_DL_sha := INT_TO_USINT(nd-1);								// zaznamy 1..64, 65..128, 129..  DALI 0..63
	{$IFDEF __NH_DALI}
   IF gr THEN                                     				// nd je REC skupiny 1..32,
      IF nd > 32 THEN
         IF ma THEN
            _Nh_DL_sha := 3;                           		// vrati cislo MASTAR
         ELSE
            _Nh_DL_sha := _Nh_DL_sha - 32 + 100;            // cislo 3.grupy: napr.pre prvy spupinu druheho mastra (ND:=33)  33-1-32+100 = 100
         END_IF;
      ELSIF nd > 16 THEN
         IF ma THEN
            _Nh_DL_sha := 2;                           		// vrati cislo MASTAR
         ELSE
            _Nh_DL_sha := _Nh_DL_sha - 16 + 100;            // cislo 2.grupy: napr.pre prvy spupinu druheho mastra (ND:=17)  17-1-16+100 = 100
         END_IF;
      ELSIF ma THEN
         _Nh_DL_sha := 1;  													
      ELSE
         _Nh_DL_sha := _Nh_DL_sha + 100;							// v prvom mastri : nd-1 + 100 :  1-1+100 = 100
      END_IF;
   ELSIF nd > 128 THEN
      IF ma THEN                                 				// prislo cislo ballastu v druhom mastri
         _Nh_DL_sha := 3;
      ELSE
         _Nh_DL_sha := _Nh_DL_sha - 128;							// 129-1-128 = 0	
      END_IF;
   ELSIF nd > 64 THEN
      IF ma THEN                                 				// prislo cislo ballastu v druhom mastri
         _Nh_DL_sha := 2;
      ELSE
         _Nh_DL_sha := _Nh_DL_sha - 64;							// 65-1-64 = 0	
      END_IF;
   ELSIF ma THEN
      _Nh_DL_sha := 1;                                     	// cislo prveho mastra
   END_IF;
	{$END_IF}
END_FUNCTION



	VAR_GLOBAL



	
	
	END_VAR


{$IFDEF __NH_DALI}

(*
   - Present DLs je cez prikaz 22 - status
   - Present DLg je cez prikaz 35,36 - patri do skupiny

*)




FUNCTION _Nh_DL_nd {HIDDEN} : INT	    // vrati fyzicke cislo zaznamu v ramci DLM podl SHA/grp
   VAR_INPUT
      grp   : BOOL;           // vracia ND grupy, inak  ND ballastu v
      dlm   : USINT;          // dali-master 1...
      sha   : USINT;      		// cislo ballastu 0..63 alebo grupy 0..15
   END_VAR
   IF grp THEN
      _Nh_DL_nd := USINT_TO_INT(sha + 1) + USINT_TO_INT(dlm-1)*16 ;
   ELSE
      _Nh_DL_nd := USINT_TO_INT(sha + 1) + USINT_TO_INT(dlm-1)*64 ;
   END_IF;
END_FUNCTION

FUNCTION _NhxDLm {HIDDEN} : BOOL	    // namapuje xDLm
   VAR_INPUT
      dlm   : USINT;
   END_VAR
   xDLm     := ADR( mRam[ aCfg[42].Ram + (aCfg[42].siz * USINT_TO_UDINT( dlm - 1 )) ]);
   _NhxDLm  := xDLm^.ok.ok ;
END_FUNCTION

FUNCTION _NhxDLg {HIDDEN} : BOOL	    // namapuje xDLg pre grup 0..15
   VAR_INPUT
      dlm   : USINT;
		grp	: USINT;		// 0..15
   END_VAR
   xDLg     := ADR( mRam[ aCfg[44].Ram + (aCfg[44].siz * INT_TO_UDINT( _Nh_DL_nd(grp:=true, dlm:=dlm, sha:=grp) - 1 )) ]);
	_NhxDLg  := xDLg^.ok.ok;
//   _NhxDLg  := _NhxPt(cf:=44,nd:=_Nh_DL_nd(grp:=true, dlm:=dlm, sha:=grp) ,x:=6);
//   xDLg     := xPt;
END_FUNCTION

FUNCTION _NhxDLs2 {HIDDEN} : BOOL	    // namapuje xDLg pre grup 0..15
   VAR_INPUT
      dlm   : USINT;
		sha	: USINT;
   END_VAR
   xDLs     := ADR( mRam[ aCfg[43].Ram + (aCfg[43].siz * INT_TO_UDINT( _Nh_DL_nd(grp:=false, dlm:=dlm, sha:=sha) - 1 )) ]);
	_NhxDLs2 := xDLs^.ok.ok;
//   _NhxDLg  := _NhxPt(cf:=44,nd:=_Nh_DL_nd(grp:=true, dlm:=dlm, sha:=grp) ,x:=6);
//   xDLg     := xPt;
END_FUNCTION



FUNCTION _NhxDLs {HIDDEN} : BOOL	    // namapuje xDls,DLg
   VAR_INPUT
      dlg   : BOOL;           // namapuje xDlg, nie xDls
      dev   : BOOL;
      dlm   : USINT;
      sha   : USINT;
   END_VAR
   IF sha > 99 THEN
//      _NhxPt(cf:=44,nd:= USINT_TO_INT(sha-99) + USINT_TO_INT(dlm-1)*16,x:=6);
      _NhxPt(c:=44,n:=_Nh_DL_nd(grp:=1,sha:=sha-100,dlm:=dlm),x:=6);
   ELSE
//      _NhxPt(cf:=43,nd:= USINT_TO_INT(sha+ 1) + USINT_TO_INT(dlm-1)*64,x:=7);
      _NhxPt(c:=43,n:=_Nh_DL_nd(grp:=0,sha:=sha,dlm:=dlm),x:=6);
   END_IF;
   IF    dlg THEN xDlg := xPt;
   ELSIF dev THEN xDev := xPt;
   ELSE           xDLs := xPt;
   END_IF;
//   _NhxDLs  := xDLs^.ok.ok ;
   _NhxDLs  := xPt^.ok.ok ;
END_FUNCTION


(*
FUNCTION _NH_DALI_EVN {HIDDEN} : BOOL
   VAR_INPUT
      cf    : USINT;
      nd    : INT;
      out   : USINT;
   END_VAR
   yTx3 := xDev^.cf.Name;
   aBlank(txt:=ADR(yTx3),n:=14);
   yTx2 := ' '+yTx2;
   aBlank(txt:=ADR(yTx2),n:=7);
   IF out = 0 THEN
      yTx2 := yTx2+'.0 ';
   ELSE
      yTx2 := yTx2+'.1 ';
   END_IF;
   yTx2 := CONCAT(yTx2,yTx3
         ,'; Dev:',USINT_TO_STRINGF(cf,'%3u')
         ,';',INT_TO_STRINGF(nd,'%3u')
         ,';',INT_TO_STRINGF(xDev^.al.ou.par,'%3u')
         ,';',REAL_TO_STRINGF(xDev^.al.in.val,'%6.1f')
         ,';',REAL_TO_STRINGF(vr,'%6.1f')
         ,';',USINT_TO_STRINGF(out,'%3u')
         );
   _Nh1RowTxt(adTime:=1,Nodate:=1);
END_FUNCTION
*)



FUNCTION  _Nh_DL_SHA_ADD {HIDDEN} : BOOL
   xDLm^.cx.sta.Present := true;                         // master
   IF xDLfb^.que.ErrID > 0 THEN
      xDls^.cx.sta.Err   := true;
      xDls^.cx.sta.ErrID := xDLfb^.que.ErrID;
      i := MIN(4,xDLfb^.que.ErrID);
      xDLm^.me.err.nErrS[i]   := xDLm^.me.err.nErrS[i] + 1;
   END_IF;
   xDLm^.cx.dlm.nSha       := xDLm^.cx.dlm.nSha + BOOL_TO_USINT(xDLfb^.que.Yes OR xDls^.cx.sta.Err);
   xDLs^.cx.sta.Present    := xDLfb^.que.Yes OR xDls^.cx.sta.Err;                         // slave
   xDLs^.ok.ok             := xDLfb^.que.Yes OR xDls^.cx.sta.Err;                        // DLS ked neodpoveda, vymaze sa

	IF xDLs^.cf.rom = 0 THEN					// TVE
      xDLs^.cf.rom := _NhDefRom;
   END_IF;

	IF xDLs^.cf.typ = 4 THEN					// TVE
		xDLs^.cf.cat := 39;						// setup kurenia	
		xDLs^.cx.cfg.out5inOne := true;	
	ELSIF xDLs^.cf.typ = 3 THEN         	// ZAS
		xDLs^.cf.cat := 2;	
	ELSE
		xDLs^.cf.cat := 1;	  					// svetlo
   END_IF;

END_FUNCTION

VAR_GLOBAL CONSTANT
   _NhDL_Que_Code_Nbr   {HIDDEN}     : USINT := 16;          // pocet parametrov, ktore sa dotazuju
//   _NhDL_Code_List   : ARRAY[0.._NhDL_Code_Nbr] OF USINT := [144,160,165,166,162,154,161,163,164,192,193,194,195,196,153,151,146];
                                                                         // 0                            10                 16
   _NhDL_Que_Code   {HIDDEN}  : ARRAY[0.._NhDL_Que_Code_Nbr ] OF USINT := [22,34,20,21,17,32,16,19,18,35,36,37,38,39,31,  23, 23];
//   _NhDL_Que_Code   {HIDDEN}  : ARRAY[0.._NhDL_Que_Code_Nbr ] OF USINT := [22,23,20,21,17,32,16,19,18,35,36,37,38,39,31,  23, 23];
   _NhDL_Par_Code   {HIDDEN}  : ARRAY[2..8 ] OF USINT := [20,21,17,20,16,19,18];
   _NhDL_Que_List    : ARRAY[0..5,0.._NhDL_Que_Code_Nbr] OF BOOL :=
                      [
                     // 0         5         0         5
                        1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,     // 0 Present SHA {status}
                        0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,     // 1 LVL DLs,DLg
                        0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,     // 2 Do ktorych scen patri Ballast
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,     // 3 LVL dev v Scene, ktore su tu zaskrtnute :  [0..15] (tu zaskrtnutie neznamena cislo parametra, ale cislo scheny)
                        0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,     // 4 zakladne parametre DLs bec scen
                        0,1,1,1,1,0,1,1,1,0,0,0,0,0,0,0,0,     // 5 zakladne parametre DLg bez scen an phy MIN

//                        0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,     // 3 vsetky parametre
//                        0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,     // 4 LVL grupy

//                        1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,     // 4 obnovit sceny
//                        1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,     // 3 obnovit sceny
                      ];
//   _eDLchg           : NH_DL_BAL_CHG;                 // cista premenna = bez zmeny
END_VAR



FUNCTION  _Nh_DL_Que_Done {HIDDEN} : BOOL
   VAR_INPUT
//     par   : USINT;
   END_VAR
   VAR
//      shiftedMask : BYTE;
   END_VAR
   i := xDLfb^.que.Address;
   IF i > 99 THEN
      i := i - 100;
   END_IF;

END_FUNCTION

VAR_GLOBAL
   aDali       : ARRAY[1.._Nh_DALI_MA] OF NH_DALI;
END_VAR


FUNCTION _Nh_DL_Next_CMD  {HIDDEN} : BOOL   // vymaze QueTask[0] a posunie dalsie Tasky[1..10] vyssie + prida na task[10] prazny task
   _NhMemClrPTR(size := 0, dest := ADR(i)); // aDR(i) je len ze si to ziada pointer v parametri, ked je size > 0                                                                                         // vymaze oblast xTx1,xTx2,xTx3 - vytvori cistu oblast pre CmdQ[11]
   MemcpyPtr(source := ADR(xDLfb^.cmd[2]), dest := ADR(yTx1), length := SIZEOF(NH_DL_CMD) * USINT_TO_UDINT(_NhDLtask-1));      // prekopiruje CmdQ[1..10] do cistej oblasti
   MemcpyPtr(source := ADR(yTx1), dest := ADR(xDLfb^.Cmd[1]), length := SIZEOF(NH_DL_CMD) * USINT_TO_UDINT(_NhDLtask));  // z kopie CmdQ da na Cmd[0] to co bolo v CmdQ[1] a na CmdQ[10] praznyriadok
END_FUNCTION



FUNCTION _Nh_DL_CLR_ALL {HIDDEN} : BOOL      // reset hlaviciek pri RND a QUE.1  Zaznamy sa NEVYMAZAVAJU !!!, zostanu z poslednej historie
   VAR_INPUT
      all   : BOOL;
      rnd   : BOOL;
      scn   : BOOL;
   END_VAR
	_Nh_DL_CLR_ALL := true;
   // master
   xDLm^.al.lst   := false;                                                         // priznak mastra, ze niektora zo scen ma nejake DLs
   IF all OR rnd THEN
      	rb := _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI)+SIZEOF(NH_CFX_DLM), dest:= ADR(xDLm^.cx.sta));
	   	rb := _NhMemSetPTR(size := SIZEOF(NH_DLM_ME), dest:= ADR(xDLm^.me));
   ELSIF all THEN
      	rb := _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI), dest:= ADR(xDLm^.cx.sta));
	   	rb := _NhMemSetPTR(size := SIZEOF(NH_DLM_ME), dest:= ADR(xDLm^.me));
   END_IF;
   // sceny
   IF scn THEN
      xDLm^.cx.dlm.nScn := 0;
      nd       := _Nh_DL_nd(grp:=true, dlm := dlma, sha := 0);                         // 1.cislo vety pre aktualny master
      del      := MIN( _Nh_DL_nd(grp:=true, dlm := dlma, sha := 15), aCfg[44].rec) ;    // posledne cislo vety pre aktualny master
      WHILE nd <= del DO
         _NhxPt(c := 44, n := nd, x:=8);
         xDLg  := xPt;
         _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI), dest:= ADR(xDLg^.cx.sta));
         xDLg^.al.lst   := false;                                                      // priznak, ze scena ma nejake DLs
         nd             := nd +1;
      END_WHILE;
   END_IF;
   // DLS
   nd       := _Nh_DL_nd(dlm := dlma, sha := 0);                           // 1.cislo vety pre aktualny master
   del      := MIN(_Nh_DL_nd(dlm := dlma, sha := 63), aCfg[43].rec) ;      // posledne cislo vety pre aktualny master
   WHILE nd <= del DO
      _NhxPt(c := 43, n := nd, x:=9);
      xDLs  := xPt;
      IF all then
         _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI), dest:= ADR(xDLs^.cx.sta) );  // sceny sa nezmazu
      END_IF;
      IF scn then
         _NhMemSetPTR(size := SIZEOF(NH_DLS_GRP), dest:= ADR(xDLs^.cx.scn) );
      END_IF;
      xDLs^.al.lst   := false;               // priznak, patri do nejakej DLg
      nd             := nd +1;
   END_WHILE;
END_FUNCTION


FUNCTION _Nh_DL_CHK_Task {HIDDEN}  : USINT             // vymaze QueTask[0] a posunie dalsie Tasky[1..10] vyssie + prida na task[10] prazny task
   VAR_INPUT
		Cancel   : BOOL;
		Force		: BOOL;
      tsk   	: USINT;
   END_VAR
	IF Cancel THEN
		IF Force THEN
//			xDLfb^.cmd[1].Break := true;
// 			_NhMemClrPTR(size:= USINT_TO_UDINT(_NhDLtask-1) * SIZEOF(NH_DL_CMD), dest := ADR(xDLfb^.cmd[2]));
 				_NhMemClrPTR(size:= USINT_TO_UDINT(_NhDLtask) * SIZEOF(NH_DL_CMD), dest := ADR(xDLfb^.cmd[1]));
			RETURN;
		END_IF;		
	ELSIF tsk > 0 AND tsk <= _NhDLtask THEN
   	IF xDLfb^.cmd[tsk].cmd = 0 THEN
			_Nh_DL_CHK_Task := tsk;
			RETURN;
   	END_IF;
	END_IF;
	tsk := 1;
   WHILE tsk <= _NhDLtask DO
   	IF  Cancel THEN
			IF xDLfb^.cmd[tsk].cmd > 0 THEN
				xDLfb^.cmd[tsk].Break := true;
			END_IF;
   	ELSIF  xDLfb^.cmd[tsk].cmd = 0 THEN
			_Nh_DL_CHK_Task := tsk;
			RETURN;
   	END_IF;
      tsk := tsk + 1;
   END_WHILE;
	_Nh_DL_CHK_Task := 0;
END_FUNCTION

FUNCTION _Nh_Frm_SCR_DLpar {HIDDEN} : BOOL
	_Nh_Frm_SCR_DLpar := true;
 	IF xF^.cf.c  = 42 THEN
  		dlma  := INT_TO_USINT(xF^.cf.n);
    	dlsl  := 255;
     	rst   := false;
	ELSE
		ok		:= xF^.cf.c  = 44;	
 		dlma  := _Nh_DL_sha(gr:=ok, ma:=1,nd:=xF^.cf.n);
   	dlsl  := _Nh_DL_sha(gr:=ok, ma:=0,nd:=xF^.cf.n);
	END_IF;
 	xDLs  := xDev;
  	xDLfb := ADR(aDali[dlma]) ;
END_FUNCTION

(*
FUNCTION _Nh_Write_Tx1 {HIDDEN} : BOOL
	VAR_INPUT
		fh			: HANDLE;
		offset	: UDINT;
		size		: UDINT;
	END_VAR
	IF FH > 0 THEN
		rb 	:= FileSetPos(hFile := FH, offset := offset);
      sz		:= FileWrite (hFile := FH, adrBuf := PTR_TO_UDINT(xTx1), size := size );
	END_IF;
END_FUNCTION
*)






FUNCTION  _Nh_DLS_Present {HIDDEN} : BOOL
	VAR_INPUT
		ok		: BOOL;
		map	: BOOL;
		dlm	: USINT;		
		sha	: USINT;
	END_VAR;
	_Nh_DLS_Present := true;
	IF map	THEN
		_NhxDLs(dlm := dlm, sha := sha);
	END_IF;
   xDLs^.ok.Ok 			:= ok;                         // master
   xDLs^.cx.sta.Present := ok;
END_FUNCTION


FUNCTION  _Nh_DLS_SHA_ADD {HIDDEN} : BOOL
   xDLm^.cx.sta.Present := true;                         // master
   IF xDLfb^.que.ErrID > 0 THEN
      xDls^.cx.sta.Err   := true;
      xDls^.cx.sta.ErrID := xDLfb^.que.ErrID;
      i := MIN(4,xDLfb^.que.ErrID);
      xDLm^.me.err.nErrS[i]   := xDLm^.me.err.nErrS[i] + 1;
   END_IF;
   xDLs^.cx.sta.Present    := xDLfb^.que.Yes AND NOT xDls^.cx.sta.Err;                         // slave
   xDLm^.cx.dlm.nSha       := xDLm^.cx.dlm.nSha + BOOL_TO_USINT(xDLs^.cx.sta.Present);
   xDLs^.ok.ok             := xDLfb^.que.Yes;                        	
	IF xDLs^.cf.rom = 0 THEN					
      xDLs^.cf.rom := _NhDefRom;
   END_IF;
	IF xDLs^.cf.typ = 4 THEN					// TVE
//		xDLs^.cf.cat := 5;						// komfort
		xDLs^.cf.cat := 39;						// setup kurenia	
//		xDLs^.cx.cfg.out5inOne := true;	
	ELSIF xDLs^.cf.typ = 5 THEN				// VEN
		xDLs^.cf.cat := 59;						// setup vetrania
//		xDLs^.cf.cat := 4;						// vetranie
	ELSIF xDLs^.cf.typ = 3 THEN         	// ZAS
		xDLs^.cf.cat := 2;	
	ELSE
		xDLs^.cf.cat := 1;	  					// svetlo
   END_IF;
END_FUNCTION

FUNCTION  _Nh_DLS_Que_Done {HIDDEN} : BOOL
   VAR
      shiftedMask : BYTE;
   END_VAR
	VAR_TEMP
		WebPar		: SINT := -1;
	END_VAR
   CASE xDLfb^.Que.What OF
       22:   //  22 STATUS                 Y: 1/1 Out:   4/  4
			   _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI), dest:= ADR(xDLs^.cx.sta));				
            _Nh_DLS_SHA_ADD();
       23:   //  23 BALLAST Yes/No
            _Nh_DLS_SHA_ADD();
       34:   //  34 ACTUAL_LEVEL           Y: 1/1 Out:   5/  5
//            xDls^.al.ou.Val          := _Nh_254_100(lvl := xDLfb^.que.Output);
            xDls^.al.ou.Val          := ROUND(USINT_TO_REAL(xDLfb^.que.Output) / 2.54);
            xDls^.al.in.Val          := xDls^.al.ou.Val;
				webpar := 1;						
       20:   //  20 FADE_TIME              Y: 1/1 Out:   7/115
            xDls^.me.rmp         		:= xDLfb^.que.Output;
				webpar := 2;						
       21:   //  21 FADE_RATE              Y: 1/1 Out:   3/115
				webpar := 3;						
       17:   //  17 MIN_LEVEL              Y: 1/1 Out:   1/  1
				webpar := 4;						
       32:   //  32 PHYSICAL_MINIMUM_LEVEL Y: 1/1 Out:   1/  1
				webpar := 5;						
       16:   //  16 MAX_LEVEL              Y: 1/1 Out: 222/222
				webpar := 6;						
       19:   //  19 POWER_ON_LEVEL         Y: 1/1 Out: 100/100
				webpar := 7;						
       18:   //  18 SYSTEM_FAILURE_LEVEL   Y: 1/1 Out: 200/200
				webpar := 8;						
       35:    //  35 GROUPS_0_7             Y: 1/1 Out:   0/  0
               shiftedMask := 1;
               FOR i := 0 TO 7 DO
                  xDls^.cx.scn.grp[i] := BYTE_TO_BOOL(AND(IN1 := USINT_TO_BYTE(xDLfb^.que.Output), IN2 := shiftedMask));
                  IF xDls^.cx.scn.grp[i] THEN
                     _NhxDLs(dlG:=true,   dlm := dlma, sha := i+100);         // namapuje len DLg, nie DLs
//                     xDLm^.cx.sta.nScn    := xDLm^.cx.sta.nScn + 1;
                     xDlG^.cx.sta.Present := true;                           // info pre scenu, ze ma nejaky ballast

                     xDlM^.al.lst := true;                                    // priznak pre MASTER, ze ma nejake SCENY
                     xDLG^.al.lst := true;                                    // priznak pre SCENU, ze ma nejaky list-DLS
                     xDlS^.al.lst := true;                                    // priznak pre SLAVE, ze patri do nejakej SCENY

                  END_IF;
                  shiftedMask := SHL(IN := shiftedMask,N := 1);
               END_FOR;
      36:    //  36 GROUPS_8_15            Y: 1/1 Out:   0/  0
               shiftedMask := 1;
               FOR i := 8 TO 15 DO
                  xDls^.cx.scn.grp[i] := BYTE_TO_BOOL(AND(IN1 := USINT_TO_BYTE(xDLfb^.que.Output), IN2 := shiftedMask));
                  IF xDls^.cx.scn.grp[i] THEN
                     _NhxDLs(dlG:=true,   dlm := dlma, sha := i+100);         // namapuje len DLg, nie DLs
//                     xDLm^.cx.sta.nScn    := xDLm^.cx.sta.nScn + 1;
                     xDlG^.cx.sta.Present := true;                           // info pre scenu, ze ma nejaky ballast

                     xDlM^.al.lst := true;                                    // priznak pre MASTER, ze ma nejake SCENY
                     xDLG^.al.lst := true;                                    // priznak pre SCENU, ze ma nejaky list-DLS
                     xDlS^.al.lst := true;                                    // priznak pre SLAVE, ze patri do nejakej SCENY
                  END_IF;
                  shiftedMask := SHL(IN := shiftedMask,N := 1);
               END_FOR;
      ELSE
            IF xDLfb^.Que.What < 16 THEN                                      // LVL v scene .what
               If xDLfb^.que.Yes THEN
//                  xDLs^.cx.scn.lvl[ xDLfb^.Que.What ] := xDLfb^.que.Output;
                  xDLs^.cx.scn.lvl[ xDLfb^.Que.What ] := REAL_TO_USINT(USINT_TO_REAL(xDLfb^.que.Output)/2.54);
               ELSE
                  xDLs^.cx.scn.lvl[ xDLfb^.Que.What ] := 0;
               END_IF;
            END_IF;
   END_CASE;
	IF xDLMc^.web THEN
		IF WebPar > -1 THEN
	   	xDLpar^.par[WebPar]  := xDLfb^.que.Output;
		END_IF;	
	END_IF;
END_FUNCTION


FUNCTION _Nh_DL_CMD_Free {HIDDEN}  : BOOL             // vymaze QueTask[0] a posunie dalsie Tasky[1..10] vyssie + prida na task[10] prazny task
	xDLfb^.cmdQue 		:= 0;
	_Nh_DL_CMD_Free 	:= false;
	FOR i := 1 TO _NhDLtask DO
		IF xDLfb^.cmd[i].cmd > 0 THEN
			xDLfb^.cmdQue := 	i;
		ELSIF i < _NhDLtask THEN
			_Nh_DL_CMD_Free := true;
			EXIT;
		END_IF;
   END_FOR;
	xDLfb^.cmdFull := i >= _NhDLtask;
END_FUNCTION
{$END_IF}

FUNCTION _Nh_DL_ADD_Task   {HIDDEN}    : Bool             // vymaze QueTask[0] a posunie dalsie Tasky[1..10] vyssie + prida na task[10] prazny task
   VAR_INPUT
		web  		: BOOL;
      wht   	: USINT;
      sha   	: USINT;
		sh2		: USINT;
      val   	: USINT;
      lvl   	: REAL;
      par   	: USINT;
      dlm   	: USINT;

//      out   	: UDINT;  				// pointer na premennu, kde treba nieco zapisat podla - stat:
   END_VAR
   VAR_TEMP
		ii		: USINT;
   END_VAR
	{$IFDEF __NH_DALI}

   _Nh_DL_ADD_Task := false;
   IF dlm > 0 THEN
      xDLfb       := ADR(aDali[dlm]) ;
   END_IF;
	IF _Nh_DL_CMD_Free() = false THEN 		
		RETURN;
	END_IF;
   _Nh_DL_ADD_Task 	:= true;
	ii						:= xDLfb^.cmdQue + 1;	
	xDLMc					:= ADR(xDLfb^.cmd[ ii ]);

   xDLMc^.cmd   		:= wht; 											// podhodi default
	CASE wht OF
      1:  // LVL
            xDLMc^.sh1  			:= sha;
				xDLMc^.pwr.lvl[1]  	:= MIN(254,REAL_TO_USINT(lvl*2.54));   			// reQuired LVL: pride 0..100, prevod na  0..254

				IF xDLm^.cf.LogAct AND xDev^.cf.LogAct THEN									// loguje sa master + DLs
					If xDev^.cx.all.LastCmd = 7 OR xDev^.cx.all.LastCmd = 6 THEN      // stmieva sa zo slidera/wsb
						xDLMc^.par := xDev^.cx.all.LastLvl;                           	// LVL na zaciatku stmievania
						xDLMc^.sh2 := xDev^.cx.all.LastCmd;                        		// podla toho sa vlozi text do val2 - len pre stmievanie
						IF xDev^.al.trg.Q THEN
							xDLfb^.cmd[ii].LogAct := false;                             // drzi sa WSB/slider
						ELSE
							xDLfb^.cmd[ii].LogAct := true;						
						END_IF;
					ELSE
						xDLMc^.par := REAL_TO_USINT(xDev^.al.Ou.Val);						// actual LVL, ba zaciatku
						xDLfb^.cmd[ii].LogAct:= xDLm^.cf.LogAct AND xDev^.cf.LogAct;
					END_IF;
				END_IF;	

(*
            _Nh_Log_Evn_ADD(tsk:=42, wht:='LVT',
								nu		:= sha,															// short address     (NBR), CFG:=dlma
								c		:= xDLMc^.sh2,													// stary LVL   		(ROM)
//								val2	:= '       ',
								vu 	:= xDLMc^.pwr.lvl[1]);        								// pozadovany stav 	(val1)
*)


      2:  // SetPart
            xDLMc^.par   			:= par;
            xDLMc^.sh1   			:= sha;
            xDLMc^.pwr.lvl[1]   	:= val;



//				_Nh_Log_Evn_ADD(tsk:=42, wht:='PAT',nu:= sha, vu := par);

      3:  // QUERY-pre DLs
            xDLMc^.par   			:= par;
            xDLMc^.sh1   			:= sha;
            xDLMc^.sh2   			:= MAX(sha,sh2);
            xDLMc^.web   			:= web;
            xDLMc^.AllSha 			:= sha=0 AND sh2=63 and par = 22;	// pre vymazanie mastra
				xDLMc^.Read				:= true;
	   4:  // // Add/remove grup, Change address
            xDLMc^.par   			:= par;     					//0-remove,1-AddGrp,3=prepis adresu
            xDLMc^.sh1   			:= sha;
            xDLMc^.sh2   			:= val;
      5:  // QUERY-sceny do ktorych DLs patri + LVL v scenach
            xDLMc^.sh1   			:= sha;
            xDLMc^.sh2   			:= MAX(sha,sh2);
            xDLMc^.AllSha 			:= sha=0 AND sh2=63;		// pre vymazanie mastra
				xDLMc^.Read				:= true;
      6: 	// RGBWA ON
            xDLMc^.sh1  			:= sha;
				xDLMc^.sh2  			:= REAL_TO_USINT(xDev^.al.Ou.Val);					// pridane 12.5.25 koli logu, pre zistenie stareho stavu
            xDLMc^.lvl  			:= MIN(254,REAL_TO_USINT(lvl*2.54));

				// napapuje default parameter DLg
				_NhxDLs2(dlm:=dlma, sha:=xDLMc^.sh1);										// namapuje vetu xDls
	         _NhxPar (cp := aCfg[43].par , np := xDls^.cf.par,x:=-1002);
				xRgb	:= xDev;
				xDLMc^.pwr.lvl 		:= xPar^.rgb.lvl;

				xDLMc^.par  			:= REAL_TO_USINT(xDev^.al.Ou.Val);					// pridane 12.5.25 koli logu, pre zistenie stareho stavu
				xDLfb^.cmd[ii].LogAct:= xDLm^.cf.LogAct AND xDev^.cf.LogAct;

      7:  // Scene ON
            xDLMc^.par   			:= par;                    				// cislo sceny 0..15
            xDLMc^.sh1   			:= sha;          								// pride cislo supiny 100..115

				xDLfb^.cmd[ii].LogAct:= xDLm^.cf.LogAct AND xDev^.cf.LogAct;
				xDLMc^.sh2 := REAL_TO_USINT(xDev^.al.Ou.Val);					// actual LVL
				xDLMc^.lvl := REAL_TO_USINT(xDev^.al.In.Val);					// required LVL

//			  _Nh_Log_Evn_ADD(tsk:=42, wht:='SCT',nu:= sha, c:= par, vu := 100);


     50:  // vyhladat Nove adresy z FF ballastov (ktore nemaju SHA = FF)
     51:  // prepisat adresu sh1 na sh2
            xDLMc^.sh1   			:= sha;          				// stara adresa
            xDLMc^.sh2   			:= sh2;          				// nova adresa
			  _Nh_Log_Evn_ADD(tsk:=42, wht:='RNT',nu:= sha, c:= sha, vu := sh2);
			;
     60:  // VYMAZAT 1 alebo vsetky {255} adresy
            xDLMc^.sh1   			:= sha;          				// (0..63) alebo vsetky (255)
			  _Nh_Log_Evn_ADD(tsk:=42, wht:='DLT',nu:= sha);
	END_CASE;
	{$END_IF}
END_FUNCTION 

{$IFDEF __NH_DALI}  
(*
VAR_GLOBAL
	yyTx1	: STRING[255];
	yyTx2	: STRING[255];	
END_VAR
*)

FUNCTION _Nh_LOG_DLM_CMD {HIDDEN} : BOOL
	VAR_INPUT
		dlm		: USINT;
	END_VAR
	dlm := 1;
	_Nh_LOG_DLM_CMD := true;


		(*



	IF aSys.frw_dali.FH[dlm] <> INVALID_HANDLE_VALUE  THEN

//		yTx1 := '$r$n';
//		sz	:= FileWrite(hFile:=aSys.frw_dali.FH[dlm], size := LEN(yTx1), adrBuf := PTR_TO_UDINT( xTx1) );	

		yTx1 := 	
				USINT_TO_STRINGF	(xDLMc^.cmd,'%3u')				+';'+			// 1
				UINT_TO_STRINGF	(xDLfb^.cycCMD,'%4u')			+';'+			// 5
				UINT_TO_STRINGF	(xDLfb^.et,'%5u')					+';'+			// 5
				BOOL_TO_STRINGF	(xDLfb^.break,'%b{b^ }')		+';'+		// 25
				USINT_TO_STRINGF	(xDLMc^.sh1,'%3u')				+';'+		// 25
				USINT_TO_STRINGF	(xDLMc^.sh2,'%3u')            +';'+		// 25
				USINT_TO_STRINGF	(xDLMc^.par,'%3u');
		FOR i := 1 TO 5 DO
			yTx1 := yTx1 + ';'+ USINT_TO_STRINGF	(xDLMc^.pwr.lvl[i],'%3u');
      END_FOR;


		IF xDLMc^.Read THEN
			yTx1 := yTx1 + ';' +
				BOOL_TO_STRINGF	(xDLfb^.Que.Yes,'%b{Yes^ No}') 	+ ';' +
				USINT_TO_STRINGF	(xDLfb^.Que.what,'%3u')				+ ';' +		
				USINT_TO_STRINGF	(xDLfb^.Que.output,'%3u');
		ELSIF xDLMc^.cmd = 150 THEN                                        	// hladanie novych adries
			yTx1 := yTx1 + ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.Busy,		'%b{Busy^    }') 		+ ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.Done,		'%b{Done^    }') 		+ ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.Err,		'%b{Err:^    }') 		+ ';' +
				USINT_TO_STRINGF	(xDLfb^.Rnd.ErrID,'%3u') 						+ ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.Aktiv,	'%b{Acti^    }')		+ ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.AktivErr,'%b{ActE^    }')		+ ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.NoAktiv, '%b{NoAc^    }')		+ ';' +
				USINT_TO_STRINGF	(xDLfb^.Rnd.ShortAdr,'%3u')					+ ';' +
				USINT_TO_STRINGF	(xDLfb^.Rnd.State,'%3u')                  + ';' +	
				BOOL_TO_STRINGF	(xDLfb^.BalNoSha, '%b{ New^    }');
		ELSIF xDLMc^.cmd = 160 THEN                                          // zmazanie adresy / 255
			yTx1 := yTx1 + ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.ClrAll,'%b{Yes^ No}')			+ ';' +
				BOOL_TO_STRINGF	(xDLfb^.Rnd.ClrGroupe,'%b{Yes^ No}')		+ ';' +	
				USINT_TO_STRINGF	(xDLfb^.Rnd.ErrID,'%3u'); 				
		ELSE
			yTx1 := yTx1 + ';           ';		// 25
		END_IF;
		IF xDLMc^.cmd <> 150 THEN
			yTx1 := yTx1 + '; ' +
				TIME_TO_STRINGF	(xDLfb^.tmeCMD,'%Thh:mm:ss.zzz') + ' ;' +
				xDlfb^.txt;
		ELSE
				
		END_IF;	
		yTx1 := yTx1 + '$r$n';
		sz	:= FileWrite(hFile:=aSys.frw_dali.FH[dlm], size := LEN(yTx1), adrBuf := PTR_TO_UDINT( xTx1) );	
	END_IF;
*)
END_FUNCTION

FUNCTION _NH_DLM_RUN_START  {HIDDEN}     :BOOL                                  // jeden DLM
	VAR_INPUT
		cmd		: USINT; 						// aky dalsi CMD bude nasledovat
		etMax		: UINT := 1500;          	// max cas cakania na odpoced {Done}
		ct			: USINT;                   // jednotka cakania : 0 [mSec] 1: [Sec]
	END_VAR
	_NH_DLM_RUN_START := false;
	xDLMc^.cmd 		:= cmd;						//
	xDLfb^.break 	:= false;
	xDLfb^.tmeCMD 	:= aSys.NhTime;
	xDLfb^.cycCMD 	:= 0;
	xDLfb^.et 		:= 0;
	xDLfb^.etMax	:= etMax;
	xDLfb^.ct      := ct;
	_NH_DLM_RUN_START := true;
END_FUNCTION

FUNCTION  _NH_DLM_RUN_END  {HIDDEN}      :BOOL                                  // jeden DLM
	VAR_INPUT
		NoNext	: BOOL;
		NoLog		: BOOL;
		NoRef		: BOOL;
	END_VAR
	_NH_DLM_RUN_END := true;
	IF NoLog = false THEN
		_Nh_LOG_DLM_CMD( dlm:=dlma );
	END_IF;
	xDLfb^.etMax	:= 0;
	IF NoNext = false THEN
		xDLfb^.cmdEnd	:= xDLMc^.cmd;											// ak by bol prikaz ukonceny breakom, este sa vykona tento prikaz
		memset(val := 0, length :=  USINT_TO_UINT(_NhDLtask) * SIZEOF(NH_DL_CMD), dest := VOID(yTx1));
	   MemcpyPtr(source := ADR(xDLfb^.cmd[2]), dest := ADR(yTx1), length := SIZEOF(NH_DL_CMD) * USINT_TO_UDINT(_NhDLtask-1));      // prekopiruje CmdQ[1..10] do cistej oblasti
   	MemcpyPtr(source := ADR(yTx1), dest := ADR(xDLfb^.Cmd[1]), length := SIZEOF(NH_DL_CMD) * USINT_TO_UDINT(_NhDLtask));  // z kopie CmdQ da na Cmd[0] to co bolo v CmdQ[1] a na CmdQ[10] praznyriadok
		_Nh_DL_CMD_Free();
	END_IF
	IF NoRef = false THEN
	   _NhDevRef(xR  := xDLm);
	END_IF;

END_FUNCTION

FUNCTION _NH_DLM_RUN_BUSY  {HIDDEN}      :BOOL                                  // jeden DLM
	VAR_INPUT
		done	: BOOL;
		err		: BOOL;
	END_VAR
	xDLfb^.cycCMD := xDLfb^.cycCMD + 1;
	IF _Nh_Dev_AT_UINT(t:=xDLfb^.ct, et := ADR(xDLfb^.et),etMax:=xDLfb^.etMax) THEN
		xDLfb^.break := true;
	END_IF;	
	_NH_DLM_RUN_BUSY := done OR err OR xDLfb^.break;
END_FUNCTION

FUNCTION _NH_DLM_RUN {HIDDEN}    :BOOL                                  // jeden DLM
   VAR_INPUT
      In   		: PTR_TO tC_DL_0012Sin;
      Out  		: PTR_TO tC_DL_0012Sout;
   END_VAR
   VAR
//      DLsLvL   : BOOL;
   END_VAR
	_NH_DLM_RUN := false;
	{$IFDEF __NH_DALI}
   IF dlma = 0 THEN //OR dlma > _Nh_DL_max THEN
	  RETURN;
   END_IF;
   xDLfb 		:= ADR(aDali[dlma]) ;
   xDLm 			:= ADR(aDali[dlma]) ;
   xDev 			:= ADR(aDali[dlma]) ;
   xPar			:= ADR(aCfg[43].par);    // dali DLs
	xDLMc	:= ADR(xDLfb^.cmd[1]);



	// 2. RUN
	CASE xDLMc^.cmd OF
       0: ;

     101: // LVL-running ;
	   		xDLfb^.Lvl(C_DL_ModuleIn := In,  C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.Lvl.Done, err:=xDLfb^.Lvl.err) THEN
					// takto sa urobi uplny reset FB, lebo ak by nasledoval identicky prikaz, vobec by sa nevykonal
					IF xDLfb^.Cmd[1].LogAct THEN
						CASE xDLfb^.Cmd[1].sh2 OF
                    6 : xDLfb^.txt := 'DIM-WSB';
                    7 : xDLfb^.txt := 'DIM-sld';
                  END_CASE;
	            	_Nh_Log_Evn_ADD(tsk:=42, wht:='LVE',nu:=xDLfb^.Lvl.address,
										c	:= xDLfb^.Cmd[1].par,								// old LVL
										vu	:= REAL_TO_USINT(USINT_TO_REAL(xDLfb^.Lvl.Power)/2.54),                         // new LVL
										enable	:= xDLfb^.Cmd[1].LogAct,
										val2		:= xDLfb^.txt,
										go1:=xDLfb^.Cmd[1].sh2=0);    	   									// cas prikazu
					END_IF;				
	
					_NH_DLM_RUN_END(NoRef:=true);
			      memset(val := 0, length := SIZEOF(fb_DL_Direct), dest := VOID( aDali[dlma].lvl ));
				END_IF;

     102: // SET PAR-running ;
			   xDLfb^.PAR(C_DL_ModuleIn := In,  C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.PAR.Done, err:=xDLfb^.PAR.err) THEN
	            xDlfb^.txt        := 'S-'+xDLfb^.PAR.WhatTxt;
					IF xDLfb^.PAR.What = 20 THEN											// fade time zapise do DEV
		            _NhxDLs(dlm := dlma, sha := xDLfb^.Par.Address);
						xDLs^.me.rmp := xDLfb^.PAR.Value;   						   // zapise do DEV
					END_IF;
					_NH_DLM_RUN_END(NoRef:=true);
			      memset(val := 0, length := SIZEOF(fb_DL_SetPar), dest := VOID( aDali[dlma].Par ));
            END_IF;

     103: // Query 22, .... vsetko mimo SCEN
				xDLfb^.Que(C_DL_ModuleIn := In, C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.Que.Done, err:=xDLfb^.Que.err) THEN
	            xDlfb^.txt        := 'Q-'+xDLfb^.Que.WhatTxt;
	            _NhxDLs(dlm := dlma, sha := xDLfb^.Que.Address);                  // namapuje xDLs.  hoci je aj DEL {what:=22}
					_Nh_DLS_Que_Done();
					_Nh_LOG_DLM_CMD(dlm:=dlma);
//					_NH_DLM_RUN_START(cmd := xDLMc^.cmd);
//					xDLfb^.cmdEnd				:= xDLMc^.cmd;	
					xDLMc^.sh1					:= xDLMc^.sh1 + 1;
					xDLMc^.cmd 					:= 3;
//					xDLfb^.Que.Enable			:= false;		
				END_IF;

     104: 	// Add/remove DALI-group
			   xDLfb^.gra(C_DL_ModuleIn := In,  C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.GrA.Done, err:=xDLfb^.GrA.err) THEN
					_NH_DLM_RUN_END();
			      memset(val := 0, length := SIZEOF(fb_DL_Address), dest := VOID( aDali[dlma].gra ));
            END_IF;

     105: // Query - LEN sceny
				xDLfb^.Que(C_DL_ModuleIn := In,  C_DL_ModuleOut := Out);

				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.que.Done, err:=xDLfb^.que.err) THEN
	            xDlfb^.txt        := xDLfb^.Que.WhatTxt;
	            _NhxDLs(dlm := dlma, sha := xDLfb^.Que.Address);
					_Nh_DLS_Que_Done();
					_Nh_LOG_DLM_CMD(dlm:=dlma);
					_NH_DLM_RUN_START(cmd := xDLMc^.cmd);
					ok		:= false;
					CASE xDLfb^.Que.what OF
                 35: xDLMc^.par 		:= 36;	
                 36: xDLMc^.par 		:= 0;						
							ok 				:= true;					
               ELSE  xDLMc^.par 		:= xDLMc^.par + 1;						
							ok 				:= true;
               END_CASE;
					IF ok THEN                                			// test pred zistenil LVL, ci DLs vobec patri do sceny : xDLMc^.par 			
						WHILE true DO
							IF xDLMc^.par > 15 THEN
								xDLMc^.sh1 	:= xDLMc^.sh1 + 1;
								xDLMc^.cmd 	:= 5;                       	// presunie na dalsie DLs
								EXIT;
							ELSIF xDLs^.cx.scn.grp[xDLMc^.par] THEN      // patri do skupiny
								EXIT;
							ELSE
								xDLMc^.par		:= xDLMc^.par + 1;
							END_IF;
						END_WHILE;
					END_IF;
					xDLfb^.Que.what := xDLMc^.par;							//35,36, 0..15 LEVEL
				END_IF;


     106: // RGBWA-running
	   		xDLfb^.rgbwa(C_DL_ModuleIn := In,  C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.rgbwa.Done, err:=xDLfb^.rgbwa.err) THEN
					IF xDLfb^.Cmd[1].LogAct THEN
						xPTU	:= ADR(xDLfb^.RGBWA.red);
						FOR i := 1  TO 5 DO
		            	_Nh_Log_Evn_ADD(tsk:=42, wht:='RGE',nu:=xDLfb^.rgbwa.address,
										c	:= i,														// zlozka R/G/B...
										vu	:= xDLMc^.pwr.lvl[i],                         // new LVL
										enable	:= true,
										go1:=i=1);    	   									// cas prikazu
							xPtU	:= xPtU	+ 1;					
	   	 		   END_FOR;
         		END_IF;


					_NH_DLM_RUN_END(NoRef:=true);
			      memset(val := 0, length := SIZEOF(fb_DL2_SetRBGWA), dest := VOID( aDali[dlma].RGBWA ));	
				END_IF;

     107: // Scene-on running ;
	   		xDLfb^.scn(C_DL_ModuleIn := In,  C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.scn.Done, err:=xDLfb^.scn.err) THEN

	            	_Nh_Log_Evn_ADD(tsk:=42, wht:='SCE',nu:=xDLfb^.scn.address,
										c	:= xDLfb^.Cmd[1].sh2,								// old LVL
										vu	:= xDLfb^.Cmd[1].lvl,                        // new LVL
										enable	:= xDLfb^.Cmd[1].LogAct,
										go1:=true);    	   									// cas prikazu

(*
			evn					:= 'DL1';
   		cfg 					:= USINT_TO_STRINGF(dlma,'%3u');
			nbr					:= USINT_TO_STRINGF(nu,'%4u');
			rom 					:= USINT_TO_STRINGF(c,'%3u');
   		yLogEvn.val1 		:= USINT_TO_STRINGF(vu,'%7u');
			IF go1 THEN
   			yLogEvn.val2 		:= TIME_TO_STRINGF( SUB_TIME(aSys.NhTime,xDLfb^.tmeCMD),' %Tss.zzz');
			ELSe
   			yLogEvn.val2 		:= val2;						
			END_IF;
*)


					_NH_DLM_RUN_END();
			      memset(val := 0, length := SIZEOF(fb_DL_Scene), dest := VOID( aDali[dlma].scn ));	
				END_IF;

     150: // Najst nove adresy
(*				POSTUPNOST VYHLADAVANIA
				 1. fb nastartuje pridelenie adresy v RND.ShAdr, nastavi RND.State:=1;
				 3. po 8cyc. nasleduje RND.State:= 2; - nevieme co to je
				 4. po 8cyc. nasleduje RND.State:= 3; - nevieme co to je
				 5. po 8cyc. nasleduje RND.State:=10; - nevieme co to je
				 6. po 8cyc. ak sa najde ballast, ktory nema SHA prepne sa RND.State:=4 a RND.NoAktiv=true - toto bude nova adresa
				 7. po 100cyc. je RND.State:=14 - zrejme priznak pripravy na zapis SHA
				 8. po 8cyc. je RND.State:=11 a RND.Aktiv=true - tato kombinacia ZAPISE FYZICKY SHA
				 9. hned v dalom cykle je uz RND.State:=10;  a trva dalsich 8cyc
				10. opakuje sa od bodu 6. - po 8cyc. ak sa najde ballast, ktory nema SHA prepne sa RND.State:=4 a RND.NoAktiv=true - toto bude nova adresa				
				- opakuje sa
*)
				xDLfb^.RND(C_DL_ModuleIn := In, C_DL_ModuleOut := Out);
//	_Nh_LOG_DLM_CMD(dlm:=dlma);
				IF xDLfb^.RND.NoAktiv THEN                                           // priznak, ze ballast nema ziadnu SHA
					xDLfb^.BalNoSha := true;														// najdeny ballast, ktory fyzicky nema SHA {len pri novom hladani}
				END_IF;
				xDLm^.al.ou.val			:= USINT_TO_REAL(xDLfb^.Rnd.ShAdr);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.RND.Done OR xDLfb^.RND.Aktiv, err:=xDLfb^.RND.err OR xDLfb^.RND.AktivErr) THEN
	            _NhxDLs(dlm := dlma, sha := xDLfb^.RND.ShAdr);
					xDLs^.ok.OK := true;
					IF xDLfb^.RND.Aktiv THEN														// fyzicky sa zapisala adresa do noveho Ballastu, alebo sa potvrdila existujuca SHA
						_Nh_LOG_DLM_CMD(dlm:=dlma);
						xDLMc^.sh1	:= xDLfb^.RND.ShAdr + 1 ;									// nasledujuca adrresa, ktora sa ide pridelit
						IF xDLfb^.BalNoSha THEN
							xDLfb^.NewSha	:= xDLfb^.NewSha + 1;								// toto je urcite nova adresa
						END_IF;
		            xDlfb^.txt	:= 'Ok:' 		+ USINT_TO_STRINGF(xDLfb^.Rnd.ShAdr,	'%3u') +
		            					' Next:' 	+ USINT_TO_STRINGF(xDLfb^.Rnd.ShAdr+1,	'%3u') +						
											' Nove:'  	+ USINT_TO_STRINGF(xDLfb^.NewSha,		'%3u');
						_NH_DLM_RUN_START(cmd := xDLMc^.cmd, etMax := xDLfb^.etMax);
//						xDLfb^.et 					:= 0;														// nastartovat
//						xDLfb^.etMax				:= 10000;
						xDLfb^.BalNoSha 			:= false;
						xDls^.cx.sta.Present		:= true;
					ELSE	//IF xDLfb^.RND.err OR xDLfb^.RND.Done THEN
						IF xDLfb^.RND.Done OR xDLfb^.RND.ErrID = 3 THEN			// niet co hladat				
			            xDlfb^.txt	:= 'OK. Nove adresy: ' + USINT_TO_STRING(xDLfb^.NewSha) ;
						ELSE
			            xDlfb^.txt  := 'Err: '+USINT_TO_STRING(xDLfb^.RND.ErrID)+
												BOOL_TO_STRINGF(xDLfb^.Rnd.AktivErr,'%b{ ActE^     }')+
												' SHA: ' + USINT_TO_STRING(xDLfb^.RND.ShAdr) ;

							IF xDLfb^.RND.ErrID > 0 THEN
						      xDls^.cx.sta.Err   := true;
						      xDls^.cx.sta.ErrID := xDLfb^.RND.ErrID;
						      i := MIN(4,xDLfb^.RND.ErrID);
						      xDLm^.me.err.nErrS[i]   := xDLm^.me.err.nErrS[i] + 1;
						   END_IF;
						END_IF;
						xDLfb^.BalNoSha 	:= false;
						_NH_DLM_RUN_END();
				      memset(val := 0, length := SIZEOF(fb_DL_RNDAddr), dest := VOID( aDali[dlma].RND ));	
//						xDLfb^.RND.Exec := false;
						xDLm^.al.sta	:= 0;
					END_IF;
					_NhDevRef(xR  := xDLm);
				END_IF;

     151: // pred precislovanim SHA Zisti,ci cielove SHA existuje. Ak existuje, najde volne SHA na ktore potom najskor precisluje cielove
				xDLfb^.Que(C_DL_ModuleIn := In, C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.Que.Done, err:=xDLfb^.Que.err) THEN
	            _NhxDLs(dlm := dlma, sha := xDLfb^.Que.Address);               // namapuje xDLs.  hoci je aj DEL {what:=22}
					_Nh_DLS_Que_Done();
					xDLMc^.Read			:= true;
	            xDlfb^.txt        := 'Q-Status SHA: ' + USINT_TO_STRING(xDLfb^.Que.Address);
					_Nh_LOG_DLM_CMD(dlm:=dlma);
					ok2 := false; 															// priznak pre reset Que
					IF xDLfb^.FreeSha THEN												// hlada sa volne SHA

						IF xDLs^.ok.OK = false	THEN									// toto SHA je volne
		               xDLfb^.GrA.Address  		:= xDLMc^.sh2;					// premenuje cielovu SHA
		               xDLfb^.GrA.Value  		:= xDLfb^.Que.Address;    	// na najdenu volnu SHA
							xDLfb^.gra.ShortAddr 	:= true;
							_NH_DLM_RUN_START(cmd := 152);
							ok2							:= true;
      				ELSIF xDLfb^.Que.Address > 0 THEN
							xDLfb^.Que.Address := xDLfb^.Que.Address - 1;
						ELSE																	// nie je volna SHA, koniec
							_NH_DLM_RUN_END();
							ok2							:= true;
						END_IF;								
					ELSIF xDLfb^.Que.Address = xDLMc^.sh2	THEN					// zistovalo sa ci existuje cielove SHA
						IF xDLs^.ok.OK	THEN												// cielove SHA existuje
							xDLfb^.Que.Address 		:= 63;							// v dalsom cykle zacne sa hladat volne sha od posledneho
							xDLfb^.FreeSha		      := true;                   // nastavi sa priznak hladania
						ELSE																	// neexistuje cielove sha					
		               xDLfb^.GrA.Address  		:= xDLMc^.sh1;					// tuto prepisuje
		               xDLfb^.GrA.Value  		:= xDLMc^.sh2;          	// nova adresa
							xDLfb^.gra.ShortAddr 	:= true;
							_NH_DLM_RUN_START(cmd := 152);
							ok2							:= true;
   					END_IF;
					END_IF;
					IF ok2 THEN
				      memset(val := 0, length := SIZEOF(fb_DL_Query), dest := VOID( aDali[dlma].Que ));	
					END_IF;					
				END_IF;

     152: 	// precislovanie SHA  (s kontrolou, ci existuje cielove SHA, ak ano preunie na koniec)
			   xDLfb^.gra(C_DL_ModuleIn := In,  C_DL_ModuleOut := Out);
				xDLfb^.gra.ShortAddr := false;
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.GrA.Done, err:=xDLfb^.GrA.err) THEN
					_Nh_DLS_Present(ok:=false,	map:=true,	dlm:=dlma,	sha:=xDLfb^.GrA.Address);				// del povodny SHA
					_Nh_DLS_Present(ok:=true,	map:=true,	dlm:=dlma,	sha:=xDLfb^.GrA.Value);				// new novy sha	
					xDlfb^.txt := USINT_TO_STRING(xDLfb^.gra.Address) + '->'+USINT_TO_STRING(xDLfb^.gra.Value);  						
					IF xDLfb^.GrA.Address  = xDLMc^.sh2 THEN													// teraz sa presuvala cielova SHA na volnu
						xDlfb^.txt := 'Presunute '+xDlfb^.txt;
						_Nh_LOG_DLM_CMD(dlm:=dlma);
				      memset(val := 0, length := SIZEOF(fb_DL_Address), dest := VOID( aDali[dlma].gra ));
						xDLfb^.gra.ShortAddr := true;
						xDLfb^.gra.Address 	:= xDLMc^.sh1;           										// nastavi precislovanie povodneho
						xDLfb^.gra.Value 		:= xDLMc^.sh2;
						_NH_DLM_RUN_START(cmd := xDLMc^.cmd);
					ELSE	
						xDlfb^.txt := 'PREPISANE '+xDlfb^.txt;
						_NH_DLM_RUN_END();
				      memset(val := 0, length := SIZEOF(fb_DL_Address), dest := VOID( aDali[dlma].gra ));
   				END_IF;
	         END_IF;


     160: // VYMAZAT ADRESY
   			xDLfb^.RND(C_DL_ModuleIn := In, C_DL_ModuleOut := Out);
				IF _NH_DLM_RUN_BUSY(done:=xDLfb^.RND.Done, err:=xDLfb^.RND.err) THEN
					IF xDLfb^.RND.ShAdr = 255 THEN
		            xDlfb^.txt        := 'VYMAZANE VSETKY SHA';
					ELSE
		            xDlfb^.txt        := 'VYMAZANA SHA: '+USINT_TO_STRING(xDLfb^.RND.ShAdr);
						_Nh_DLS_Present(ok:=false,	map:=true,	dlm:=dlma,	sha:=xDLfb^.RND.ShAdr);	// del
					END_IF;
					_NH_DLM_RUN_END();
			      memset(val := 0, length := SIZEOF(fb_DL_RNDAddr), dest := VOID( aDali[dlma].RND ));	
				END_IF;
   END_CASE;


	// 1. START CMD
	CASE xDLMc^.cmd OF
   	0: ;
     	1: 	// LVL-start ;
					_NH_DLM_RUN_START(cmd := 101);
  					xDLfb^.Lvl.Power        := xDLMc^.pwr.lvl[1];                              // poziadavka
   	         xDLfb^.Lvl.Address      := xDLMc^.sh1;
      	      xDLfb^.Lvl.Enable       := true;
		   		xDLfb^.Lvl(C_DL_ModuleIn := in, C_DL_ModuleOut := Out);
	            xDlfb^.txt        := 'LVL';


     	2: 	// SET PAR
					_NH_DLM_RUN_START(cmd := 102);
	            xDLfb^.PAR.Execute      := true;                                           // adresa sa vyplna do kazdeho ballastu
   	         xDLfb^.PAR.Address      := xDLMc^.sh1;                                     // adresa sa vyplna do kazdeho ballastu
      	      IF xDLMc^.par >= 100  THEN
         	      xDLfb^.PAR.What         := xDLMc^.par-100;                              // lvl pre scenu 0..15  sa posiela  ako 100..115
            	ELSE
               	xDLfb^.PAR.What         := xDLMc^.par;                // adresa sa vyplna do kazdeho ballastu
//               	xDLfb^.PAR.What         := _NhDL_Par_Code[ xDLMc^.par ];                // adresa sa vyplna do kazdeho ballastu
	            END_IF;
   	         xDLfb^.PAR.Value        := xDLMc^.pwr.lvl[1];                                     // adresa sa vyplna do kazdeho ballastu
				   xDLfb^.PAR(C_DL_ModuleIn := in, C_DL_ModuleOut := Out);
            	


     	3: 	// QUE - DLs
					IF xDLMc^.allsha THEN																			// resetnut master
				      _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI)+SIZEOF(NH_CFX_DLM), dest:= ADR(xDLm^.cx.sta));
					   _NhMemSetPTR(size := SIZEOF(NH_DLM_RND)+SIZEOF(NH_DLM_ERR), dest:= ADR(xDLm^.me));
						xDLMc^.allsha := false;
					END_IF;
					WHILE xDLMc^.sh1 <= xDLMc^.sh2 DO
						ok	:= _NhxDLs(dlm := dlma, sha := xDLMc^.sh1);
						IF xDLMc^.par = 22 THEN
							xDLs^.ok.ok := false;
							_NhMemSetPTR(size := SIZEOF(NH_CFX_DALI), dest:= ADR(xDLs^.cx.sta));
							EXIT;
						ELSIF ok THEN
							EXIT;
						ELSE
							xDLMc^.sh1 				:= xDLMc^.sh1 + 1;																	
						END_IF;
					END_WHILE;
					IF xDLMc^.sh1 <= xDLMc^.sh2 THEN				

						xDLfb^.Que.what			:= xDLMc^.par;
						xDLfb^.Que.Address		:= xDLMc^.sh1;
						xDLfb^.Que.Enable			:= true;		
						_NH_DLM_RUN_START(cmd := 103);
						xDLfb^.Que(C_DL_ModuleIn := in, C_DL_ModuleOut := Out);
						xDLm^.al.sta					:= 2;
						xDLm^.al.ou.Val				:= USINT_TO_REAL(xDLfb^.Que.Address);
						_NhDevRef(xR  := xDLm);
					ELSE							// vobec sa nevykonal 103
				      memset(val := 0, length := SIZEOF(fb_DL_Query), dest := VOID( aDali[dlma].Que ));
						_NH_DLM_RUN_END(NoLog:=true);
						xDLm^.al.sta					:= 0;
      			END_IF;

     	4: 	// Add/remove DALI-group
					_NH_DLM_RUN_START(cmd := 104);
	            CASE xDLMc^.par OF
   	           0 : // odobrat z Grupy
      	            xDLfb^.GrA.RemGroupe 	:= true;
         	         xDLfb^.GrA.value  		:= xDLMc^.sh2;                               // cislo GRP 100..115 pre skupiny 0..15
			            xDlfb^.txt        		:= 'REMOVE GROUP';
            	  1 : // pridat do GRP
               	   xDLfb^.GrA.AddToGroupe  := true;
                  	xDLfb^.GrA.value        := xDLMc^.sh2;                               // cislo GRP 100..115 pre skupiny 0..15
			            xDlfb^.txt        		:= 'ADD GROUP';
	            END_CASE;
   	         xDLfb^.GrA.Address        := xDLMc^.sh1;                                   // zdrojove DLs
				   xDLfb^.gra(C_DL_ModuleIn := in, C_DL_ModuleOut := Out);


     	5: 	// QUE - start nacitania scen pre DLs
					xDLm^.al.sta	:= 2;
					IF xDLMc^.allsha THEN																			// resetnut master
						xDLm^.cx.dlm.nScn := 0;
						xDLMc^.allsha 		:= false;
					END_IF;
					WHILE true DO
						IF xDLMc^.sh1 > xDLMc^.sh2 THEN
//							xDLfb^.Que.Enable			:= false;			
							_NH_DLM_RUN_END();
					      memset(val := 0, length := SIZEOF(fb_DL_Query), dest := VOID( aDali[dlma].Que ));
							xDLm^.al.sta	:= 0;
							EXIT;
						ELSIF _NhxDLs(dlm := dlma, sha := xDLMc^.sh1) THEN
							_NH_DLM_RUN_START(cmd := 105);
					      _NhMemSetPTR(size := SIZEOF(NH_DLS_GRP), dest:= ADR(xDLs^.cx.scn));		// v DLs vymaze data o vsetkych scenach
							xDLMc^.par					:= 35;
							xDLfb^.Que.Enable			:= true;		
							xDLfb^.Que.what			:= xDLMc^.par;
							xDLfb^.Que.Address		:= xDLMc^.sh1;
							xDLfb^.Que( C_DL_ModuleIn := in, C_DL_ModuleOut := Out);
							xDLm^.al.ou.val			:= USINT_TO_REAL(xDLfb^.Que.Address);
							EXIT;
						ELSE
							xDLMc^.sh1 				:= xDLMc^.sh1 + 1;				
						END_IF;
					END_WHILE;

      6: 	// RGBWA ON
					_NH_DLM_RUN_START(cmd := 106, etMax := 10000);
					xPTU	:= ADR(xDLfb^.RGBWA.red);
   	   	   xDLfb^.RGBWA.Set      := true;
					xDLfb^.RGBWA.power    := xDLMc^.lvl;
      		   xDLfb^.RGBWA.Address  := xDLMc^.sh1;				
					FOR i := 1  TO 5 DO
						IF xDLfb^.RGBWA.power = 0 THEN
							xPTU^ := 0;
						ELSE
							xPTU^ := xDLMc^.pwr.lvl[i];
						END_IF;
						xPtU	:= xPtU	+ 1;					
      		   END_FOR;
		   		xDLfb^.RGBWA( C_DL_ModuleIn := in, C_DL_ModuleOut := Out);
	            xDlfb^.txt        := 'Set-RGBWA';


      7: 	// Scene ON
					_NH_DLM_RUN_START(cmd := 107);
	            xDLfb^.scn.Enable      := true;                                           // adresa sa vyplna do kazdeho ballastu
	            xDLfb^.scn.Scene       := xDLMc^.par;                                           // adresa sa vyplna do kazdeho ballastu
	            xDLfb^.scn.Address     := xDLMc^.sh1;
		   		xDLfb^.scn(C_DL_ModuleIn := in, C_DL_ModuleOut := Out);
	            xDlfb^.txt        := 'Scene-LVL';

     50: 	// vyhladat nove adresy
					_NH_DLM_RUN_START(cmd := 150, etMax := 10000);
					xDlfb^.txt	:= 'Start HLADANIA';
					xDLMc^.cmd := 50;
					_Nh_LOG_DLM_CMD(dlm:=dlma);
					xDLMc^.cmd := 150;

	            xDLfb^.RND.Exec            := true;
   	         xDLfb^.RND.Auto_Man        := true;					// po najdeni, automaticky pridelit adresy
         	   xDLfb^.Rnd.ShAdr           := 0;                // treba vynulovat
					xDLfb^.RND.MaxAdr 			:= 63;
					xDLfb^.NewSha					:= 0;						// pocitadlo novych adries	
					xDLm^.al.sta					:= 3;

     51: 	// Prepisat adresu na inu

					xDLfb^.Que.what			:= 22;
					xDLfb^.Que.Address		:= xDLMc^.sh2;				// najskor zisti, ci cielove SHA je obsadene
					xDLfb^.Que.Enable			:= true;		
					_NH_DLM_RUN_START(cmd := 151);
					xDLfb^.FreeSha				:= false;
////					xDLfb^.Que(C_DL_ModuleIn := in, C_DL_ModuleOut := Out);
     60: 	// VYMAZAT VSETKY{255} / 1adresu
					_NH_DLM_RUN_START(cmd := 160);
      	      xDLfb^.RND.Clear_ShAdr     := true;					// priznak vymazania
         	   xDLfb^.Rnd.ShAdr           := xDLMc^.sh1;       // jedna adresa, 255 = vsetky vymazat
					xDLfb^.RND.MaxAdr 			:= 63;

   END_CASE;

	xDLfb^.CmdEnd	:= 0;
END_FUNCTION


{ $END_IF }



