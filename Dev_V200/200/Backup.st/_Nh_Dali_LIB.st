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
     par   : USINT;
   END_VAR
   VAR
      shiftedMask : BYTE;
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
   // master
   xDLm^.al.lst   := false;                                                         // priznak mastra, ze niektora zo scen ma nejake DLs
   IF all OR rnd THEN
      _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI)+SIZEOF(NH_CFX_DLM), dest:= ADR(xDLm^.cx.sta));
	   _NhMemSetPTR(size := SIZEOF(NH_DLM_ME), dest:= ADR(xDLm^.me));
   ELSIF all THEN
      _NhMemSetPTR(size := SIZEOF(NH_CFX_DALI), dest:= ADR(xDLm^.cx.sta));
	   _NhMemSetPTR(size := SIZEOF(NH_DLM_ME), dest:= ADR(xDLm^.me));
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





