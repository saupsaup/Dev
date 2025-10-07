TYPE
   NH_LOG_EVN       : STRUCT   // struktura EVN-log
      evn      : STRING[3] :='   ';   			sevn 	: BYTE := 16#3b;	// globalny kod udalosti, PSN,PIR,OVL,HET,VEN,
      wht      : STRING[3] :='   ';   			swht 	: BYTE := 16#3b;	// blizsie urcenie udalosti BEG/END/STR/STP
		cfg      : STRING[3] :='   ';   			scfg 	: BYTE := 16#3b;  // ktore CFG, u dali je master
      nbr      : STRING[4] :='    ';   		snbr 	: BYTE := 16#3b;  // veta v CFG, u dali je short adresa
      rom      : STRING[3] :='   ';   			srom 	: BYTE := 16#3b;    	// veta v CFG
      eDate   	: STRING[8] :='        ';  	sdat	: BYTE := 16#3b;
      eTime   	: STRING[11] :='00:00:00.00'; stim 	: BYTE := 16#3b;
      val1    	: STRING[7] :='       ';  		sval1 : BYTE := 16#3b;	// podla udalosti, vacsinou nova hodnota	
      val2    	: STRING[7] :='       ';		sval2 : BYTE := 16#3b;  // podla udalosti, vacsinou stara hodnota	
		lck		: STRING[1] :=' ';				slock : BYTE := 16#3b;	// lock status	0..9
		subj		: STRING[2] :='  ';				sSubj : BYTE := 16#3b;	// lock status	0..9
      Cr       : BYTE   := 16#0D;
      Lf       : BYTE   := 16#0A;
	END_STRUCT;

   NH_LOG_IDX       : STRUCT   // index po dnoch
		bckAdr		: UDINT;
		dayAdr 		:	ARRAY	[1..31] OF UDINT;
	END_STRUCT;

   NH_LOG_IXD       : STRUCT   // index po dnoch
		offset		: UDINT;
	END_STRUCT;

// 2544124;1547884;2544124;1547884;2544124;1547884;2544124;1547884;2544124;1547884;2544124;1547884;2544124;1547884;2544124;1547884;2544124;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884;1547884

(*
	123456789 123456789 123456789 123456789 123456789 123456789
	wht evn cfg  nbr rom      dat     tim    val1     val2;cr
	
	PSN;Lck;ZON;   1;101,10.11.25;11:42:21;       ;       ;CR
	PSN;Unl;ZON;   1;101,       ;
	PSN;Lck;ROM;  14;101,BTN-1  ;
	PSN;Lck;ROM;  15;102,BTN-1  ;
	PSN;End;TGL;  23;BTN-1  ;PRES		
	PSN;Beg;PIR;  13;       ;       ;12.05.25;11:32:00.21
	PSN;End;PIR;  13;       ;       ;12.05.25;11:32:01.44
	PSN;Tch;TGL;  23;BTN-1  ;TCH    ;12.05.25;11:35:01.44
	PSN;Beg;TGL;  23;BTN-1  ;PRES	
	PSN;End;TGL;  23;BTN-1  ;PRES		


	TER;Chg;ROM;   3;  12.50; 11.90
	TEH;Chg;TVE;   3;  28.40; 26.90
	
	HET;Web;HET;   3;MAN    ;3;
	HET;Prg;HET;   3;On     ;3;	
	
	TGL;Tch;TGL;  23;BTN-1  ;TCH
	HET;Prg;HET;   3;On     ;3;		
*)


END_TYPE


VAR_GLOBAL CONSTANT
   eLogEvn   					{HIDDEN}	: NH_LOG_EVN;
END_VAR

VAR_GLOBAL
   yLogEvn  		{HIDDEN}	: NH_LOG_EVN;
//   yLogEvn  AT yTx2 			{HIDDEN}	: NH_LOG_EVN;
//   xLogEvn  			  		{HIDDEN} : PTR_TO NH_LOG_EVN;
	eLogIdx						: NH_LOG_IDX;
END_VAR

FUNCTION  _Nh_Log_Evn_ADD  : BOOL
	VAR_INPUT
		Enable	: BOOL;
		go1		: BOOL;		



		tsk		: INT;
      evn      : STRING[3];
      wht      : STRING[3];
		cfg      : STRING[3];
      nbr      : STRING[4];
      rom      : STRING[3];
      val1    	: STRING[7];
      val2    	: STRING[7];
//		tRTC		: DT;
		c			: USINT;
		nu			: USINT;
		vu			: USINT;
	END_VAR
	_Nh_Log_Evn_ADD	:= FALSE;
   yLogEvn       		:= eLogEvn;
(*
	CASE tsk OF
     0 : ;
    42 : ;
   251 : ;
   255 : ;
   ELSE
		RETURN;
   END_CASE;
*)

	cfg 	:= USINT_TO_STRINGF(cf,'%3u');
	nbr 	:= INT_TO_STRINGF(nd,'%4d');
	rom	:= USINT_TO_STRINGF(xDev^.cf.rom,'%3u');
	
	CASE tsk OF
	 -1 :	//
//	 		cfg 					:= USINT_TO_STRINGF(cf,'%3u');
//   		nbr 					:= INT_TO_STRINGF(nd,'%4d');
//	 		rom 					:= USINT_TO_STRINGF(xDev^.cf.rom,'%3u');
   		yLogEvn.val1 		:= val1;
   		yLogEvn.val2 		:= val2;


     0 :	// vsetko bude zadane v parametroch
   		yLogEvn.val1 		:= val1;
   		yLogEvn.val2 		:= val2;
	 15 : // PIR
   		evn 					:= aCfg[cf].CFG;	
   		cfg 					:= USINT_TO_STRINGF(cf,'%3u');
   		nbr 					:= INT_TO_STRINGF(nd,'%4d');
   		yLogEvn.rom 		:= USINT_TO_STRINGF(xDev^.cf.Rom,'%3u');
   		yLogEvn.val2 		:= Left(xDev^.cf.Name,7);
	

	 10 : // SVx
   		evn 					:= aCfg[cf].CFG;	
			IF xDev^.al.in.val > xDev^.al.ou.val THEN
				wht	:= 'ON ';
			ELSE
				wht	:= 'OFF';
			END_IF;
// 		cfg 					:= USINT_TO_STRINGF(cf,'%3u');
//   		nbr 					:= INT_TO_STRINGF(nd,'%4d');
   		yLogEvn.val1 		:= REAL_TO_STRINGF(xDev^.al.ou.val,'%7.1f');
   		yLogEvn.val2 		:= REAL_TO_STRINGF(xDev^.al.in.val,'%7.1f');

	 13 : // WSB,TLA,TGL
   		evn 					:= aCfg[cf].CFG;	
//   		cfg 					:= USINT_TO_STRINGF(cf,'%3u');
//   		nbr 					:= INT_TO_STRINGF(nd,'%4d');
   		yLogEvn.val1 		:= USINT_TO_STRINGF(xTgl^.al.cli.OutBtn,'%7d');
   		yLogEvn.rom 		:= USINT_TO_STRINGF(xDev^.cf.Rom,'%3u');
   		yLogEvn.val2 		:= Left(xTgl^.cf.Name,7);

	 31 : // ROL
	 		evn 					:= 'ROL';
			wht					:= USINT_TO_STRINGF(xRol^.cx.cmd,'%3u');
//	 		cfg 					:= USINT_TO_STRINGF(cf,'%3u');
//   		nbr 					:= INT_TO_STRINGF(nd,'%4d');
//	 		rom 					:= USINT_TO_STRINGF(xDev^.cf.rom,'%3u');
			yLogEvn.val1		:= USINT_TO_STRINGF(xRol^.cx.uRol,'%3u') + '#' + USINT_TO_STRINGF(pRol^.rol.pRol,'%3u');
			yLogEvn.val2		:= USINT_TO_STRINGF(xRol^.cx.uLam,'%3u') + '#' + USINT_TO_STRINGF(pRol^.rol.pLam,'%3u');

	 42 : // DLM,DLS,DLG
			{$IFDEF __NH_DALI}
			IF enable = false THEN
				RETURN;
			END_IF;	
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
  			{$END_IF}
	200 : // web-evn
   		evn 					:= 'WEB';	
   		wht 					:= USINT_TO_STRINGF(xL^.obj,'%3u');
   		cfg 					:= USINT_TO_STRINGF(xM^.brw.r[ xA^.tch.row ].h.cf.c,'%3u');
   		nbr 					:= INT_TO_STRINGF(xM^.brw.r[ xA^.tch.row ].h.cf.n,'%4d');
			rom					:= '   ';	
   		yLogEvn.val1 		:= SINT_TO_STRINGF(xA^.tch.row,'%7d');
   		yLogEvn.val2 		:= SINT_TO_STRINGF(xA^.tch.obj,'%7d');
			yLogEvn.subj		:= USINT_TO_STRINGF(xA^.usr,'%2d');


	251 : // aftre restart & create directory,
   		evn 					:= 'SYS';	
   		wht 					:= 'RST';
   		cfg					:= '   ';
   		nbr					:= '    ';
   		rom					:= '   ';
	255 : // close file
		   IF aSys.LogHed.fhEvn <> INVALID_HANDLE_VALUE THEN
		   	rb						:= FileClose(hFile := aSys.LogHed.fhEvn);
				aSys.LogHed.fhEvn := INVALID_HANDLE_VALUE;
			END_IF;	
			aSys.LogHed.Quite10Sec	:= 0;
			aSys.LogHed.Writes		:= 0;
			RETURN;	
   ELSE	
   ;
   END_CASE;
   IF aSys.LogHed.fhEvn = INVALID_HANDLE_VALUE THEN
		_Nh_Log_Path(wh := 100);
		aSys.LogHed.fhEvn := FileOpen(fileName := yTx1, mode := F_APPEND);
	END_IF;	
   yLogEvn.eDate 				:= aSys.LogHed.logDate;
   yLogEvn.eTime 				:= aSys.LogHed.logTime;
	IF xHom^.cx.lck.stat	= 0 THEN
		yLogEvn.lck	:=	' ';
	ELSE
		yLogEvn.lck	:=	USINT_TO_STRING(xHom^.cx.lck.stat);
	END_IF;
	yLogEvn.evn 				:= evn;	
	yLogEvn.wht 				:= wht;	
	yLogEvn.cfg					:=	cfg;
	yLogEvn.nbr 				:= nbr;
	yLogEvn.rom					:=	rom;
	IF yLogEvn.val1 = '' THEN
   	yLogEvn.val1 		:= '       ';						
	END_IF;
	IF yLogEvn.val2 = '' THEN
   	yLogEvn.val2 		:= '       ';						
	END_IF;


	fRW    						:= FileWrite(hFile := aSys.LogHed.fhEvn, adrBuf := PTR_TO_UDINT(ADR(yLogEvn)), size := SIZEOF(yLogEvn));
	aSys.LogHed.Quite10Sec 	:= 0;
	aSys.LogHed.Writes  		:= aSys.LogHed.Writes + 1;

//		   	rb						:= FileClose(hFile := aSys.LogHed.fhEvn);
//				aSys.LogHed.fhEvn := INVALID_HANDLE_VALUE;

	_Nh_Log_Evn_ADD	:= TRUE;
END_FUNCTION





TYPE
   NH_LOG_HED_MSG  {HIDDEN}  :  STRUCT             // 12
		row 		: UDINT;  						// adresa riadku, ktory sa spracovava
		size		: UDINT := 303;
//	            1   5        14       23 26         37       46 ...301,CRLF
//		yTxt := 'MSG;23.08.25;13:45:51; 1;       err;13:45:51;pohyb sss,dddd,ssss,sssssss';
		pozi		: ARRAY[1..7,0..1] OF USINT :=
							[ 	 1,  3,					// kod
								 5,  8,					// datum evetu
								14,  8,					// Cas EVN
								23,  2,					// user
								26, 10,              // status
								37,  8,              // cas odoslania/vyhodnotenia
								46,255]
				;
   END_STRUCT
	

   _NH_LOG_REC  {HIDDEN}  :  STRUCT             // 12
      wh       : USINT;
      cf       : USINT;
      nd       : INT;
      typ      : SINT;
      val      : REAL;
      hh       : USINT;
      mm       : USINT;
      ss       : USINT;
   END_STRUCT

   NH_LOG_REC  {HIDDEN} :  STRUCT
      rec      : INT;                  // pocet zaznamov
      nd       : INT;                  // aktualny zaznam
      sdc      : INT;
   END_STRUCT



END_TYPE


VAR_GLOBAL
	hedmsg : NH_LOG_HED_MSG;
END_VAR




FUNCTION _NhPathRRmmDD {HIDDEN} : BOOL  // Create and Save to string PTR yTxt^ path RR/MM/DD/ or file RRmmDD
	VAR_INPUT
		rr			: BOOL;
		mm			: BOOL;
		dd			: BOOL;
//		da			: BOOL;           // date
//		ti			: BOOL;				// time

		sufix		: STRING[4];
	END_VAR
	VAR_IN_OUT
		txt 		: STRING;
	END_VAR;	
	_NhPathRRmmDD	:= true;
	IF rr THEN
		txt	:= CONCAT(USINT_TO_STRINGF(SYSTEM_S.COUNTER_YEARS,'%02u'),sufix);
	END_IF;
	IF mm THEN
		txt	:= CONCAT(USINT_TO_STRINGF(SYSTEM_S.COUNTER_MONTHS,'%02u'),sufix);
	END_IF;
	IF dd THEN
		txt	:= CONCAT(USINT_TO_STRINGF(SYSTEM_S.COUNTER_DAYS_OF_MONTH,'%02u'),sufix);
	END_IF;
(*
	IF da THEN
		yTxt	:= CONCAT(yTxt,DATE_TO_STRINGF(aSys.NhDate,'%TDD:MM:YY'),sDir,sufix);
	END_IF;
	IF ti THEN
		yTxt	:= CONCAT(TIME_TO_STRINGF(aSys.NhTime,'%Thh:mm:ss'),sDir,sufix);
	END_IF;
*)
END_FUNCTION


FUNCTION _NhPathLOG {HIDDEN} : BOOL    // nacita/zapise do suboru
	VAR_INPUT
//		hed	: bool;				// riadiaci subor - ina pripona
		//cfg	: USINT;        	// cesta/typ LOG adresara
//		file	: SINT;          // nazov suboru v adresari
	END_VAR

RETURN;
(*
//	yTxt := '';  					// uplne vycistit
	_NhPathLOG	:= true;
	CASE cfg OF
	  46: //LOG/MSG/RR/MM/
			yTxt	:= CONCAT(_Nh_ADR_LOG,aCfg[cfg].cfg,'/');						// LOG/MSG/		
			_NhPathRRmmDD(rr:=1, mm:=1, dd:=1, slash:=1, yTxt:=yTxt);		// LOG/MSG/RR/mm/dd/
			CASE file OF
			  0 : RETURN;
           1 : yTxt := CONCAT(yTxt,'msg');
           2 : yTxt := CONCAT(yTxt,'sms');
           3 : yTxt := CONCAT(yTxt,'mal');
         END_CASE;	
         IF hed THEN
				yTxt := CONCAT(yTxt,'.HED');					// 2308_msg.HED	
			ELSE
				yTxt := CONCAT(yTxt,'.txt');			
			END_IF;	
	   6 : //LOG/HET/rom/rr/mm/dd/		rom pride v yTxt

			IF file = -1 THEN
				yTxt	:= CONCAT(_Nh_ADR_LOG,aCfg[cfg].cfg,'/',yTxt);        				// nazov suboru je nazov Het v adresati het
			ELSE
				yTxt	:= CONCAT(_Nh_ADR_LOG,aCfg[cfg].cfg,'/',yTxt,'/');
				IF file = 1 THEN																// len mesiac
					_NhPathRRmmDD(rr:=1, mm:=1, dd:=0, slash:=1, yTxt:=yTxt, sufix:='');		// LOG/HET/ rom /RR/MM/
				ELSE                                                          	// aj den
					_NhPathRRmmDD(rr:=1, mm:=1, dd:=1, slash:=1, yTxt:=yTxt, sufix:='');		// LOG/HET/ rom /RR/MM/DD
				END_IF;
			END_IF;			
			CASE file OF
				0: ;
           -1: ;
			ELSE  yTxt := CONCAT(yTxt,'het.csv');			
         END_CASE;


	  3 : //LOG/VEN/rr/mm/dd/
			yTxt	:= CONCAT(_Nh_ADR_LOG,'VEN/');						
			_NhPathRRmmDD(rr:=1, mm:=1, dd:=1, slash:=1, yTxt:=yTxt, sufix:='');		
	  43 : //LOG/DALI/rr.mm.dd/
			yTxt	:= CONCAT(_Nh_ADR_LOG,'DALI/');						
			_NhPathRRmmDD(rr:=1, mm:=1, dd:=1, slash:=1, sufix:='', yTxt:=yTxt);		
//			_NhPathRRmmDD(dd:=1, slash:=1, yTxt:=yTxt);		

   ELSE
		_NhPathLOG	:= false;
   END_CASE;
*)

END_FUNCTION



FUNCTION _NhLogHead {HIDDEN} : BOOL    // nacita/zapise do suboru
	VAR_IN_OUT
		yTxt	: STRING;
	END_VAR
	VAR_INPUT
		what	: USINT;
	END_VAR
	_NhLogHead := true;
	CASE what OF
	  0 : _NhLogHead := false;
	  1 : // MSG
			// 		DD HH:mm:SS.zz sta HH:MM:SS.z usr
			//       1   5  8        17 20  24       33
//			yTxt := '1234;';
//			yTxt 	:= UDINT_TO_STRINGF(ofset,'%5u');
			yTxt 	:= CONCAT(yTxt,';$r$n');
   END_CASE;
END_FUNCTION

FUNCTION _NhLogTime {HIDDEN} : BOOL    // nacita/zapise do suboru
	VAR_INPUT
//		user	: USINT;
	END_VAR
	_NhLogTime	:= true;
(*
	yTxt := '';
	CASE what OF
	  1 : // MSG
//		yTxt := 'MSG;23.08.25;13:45:51; 1;       err;13:45:51;';

			yTxt	:= 'MSG;';
			_NhPathRRmmDD(da:=1,ti:=1, sufix:=';', yTxt:=yTxt);						// 'MSG;23.08.25,11:32:21;'
			yTxt	:= CONCAT(yTxt,
								USINT_TO_STRINGF(user,'%2u'),';',                     // 'MSG;23.08.25,11:32:21; 1;'
								'       new;',								                  // 'MSG;23.08.25,11:32:21; 1;       new;'
								'  .  .  ;'                                           // 'MSG;23.08.25,11:32:21; 1;       new;  .  .  ;'
							);
   END_CASE;
*)
END_FUNCTION

(*
FUNCTION _NhFileClose {HIDDEN} : BOOL    // nacita/zapise do suboru
	IF fH <> INVALID_HANDLE_VALUE THEN
      rb := FileClose(hFile := fH);
	END_IF;
	fH := INVALID_HANDLE_VALUE;	
END_FUNCTION
*)

FUNCTION_BLOCK  _Nh_Cfg_Restart   // copy CFG from RBx/DBx to Mem
	VAR_INPUT
		wh			: USINT;						// 0=acfg[cx],1=aPar[cx],2=aVaz[cx]
		cx			: USINT;                // stored only for more cycles
		lg			: BOOL := TRUE;			// log activity to file
//		cycLimit	: BOOL:=TRUE;		
		init		: BOOL;
	END_VAR
	VAR_OUTPUT
		busy		: BOOL;
		done		: BOOL;
		errID		: UINT;
	END_VAR
	VAR_TEMP
		nd			: INT;
	END_VAR
	done	:= FALSE;
	IF init THEN
		init := false;
		IF _NhIsDBxCfgOk(RBx:=aSys.UseRBx) = false THEN          	// maps xDbx to wrk mem AT aObr

		END_IF;
		yDbx			:= xDbx^;
		xCfg			:= xDbx + SIZEOF(aDbx);									// in after xDbx in wrk MEM
	   aDbx.vRam   := _Ram0;                                                         // volna ram
		// nastavi prvu adresu {aCfg[1].ram} do xDbx zo zalohy, do nej sa bude dalej napocitavat
		//	xDbx^.vRam	:= xDbx^.aCfx[2] + ( USINT_TO_UDINT(xDbx^.sCfx[2]) * USINT_TO_UDINT(xDbx^.nCfx[2]));
		// nastavi aktualne adresy do riadiaceho suboru
		RETURN;
	END_IF;


	WHILE wh <= 2 DO		                              					// max record stored in DBX
		busy	:= TRUE;
		IF lg THEN
			yTx2 	:= CONCAT('.START',USINT_TO_STRINGF(wh,'%2d'),UDINT_TO_STRINGF(aDbx.vRam, '%9d') );
			_Nh1RowTxt(logRst:=1);
     	END_IF;
		WHILE cx <=	xDbx^.nCfx[wh] DO		                              // max record stored in DBX
			_NhMap(wh := wh, cx := cx);                             		// maps aCfg[cf] to xNh
			IF xNh^.siz = 0 OR xNh^.ver = 0 THEN ;
			ELSIF xDbx^.FromDBx128 AND xDbx^.aCfx[wh] + USINT_TO_UDINT(xDbx^.sCfx[wh]) > aSys.Size_DBx THEN
				errID	:= 1006;                                       	
			ELSIF _Nh_RBx_Mem(RBx:=aSys.UseRBx, aDbx := xDbx^.aCfx[wh], sDbx:=USINT_TO_UDINT(xDbx^.sCfx[wh]), aMem := PTR_TO_UDINT(xCfg) ) = FALSE THEN ;	
				errID	:= 1007;                                       	
			ELSIF xCfg^.siz = 0 OR xCfg^.rec = 0 THEN ;
			ELSIF xNh^.ImpExactVer AND xNh^.ver <> xCfg^.ver  THEN ;	
			ELSIF xNh^.ImpFullCfg AND xCfg^.siz = xNh^.siz THEN //AND xDbx^.FromDBx128 = false THEN
				xDbx^.vRam	:= xCfg^.ram;
				xNh^.ram		:= aDbx.vRam;                             		// addres of the acfg[cf ] (first rec)
				sp				:= xCfg^.siz * INT_TO_UDINT(xCfg^.rec);
				IF _Nh_RBx_Mem(aDbx := xDbx^.vRam, sDbx:=sp, aMem := PTR_TO_UDINT(ADR(mRam[aDbx.vRam])),RBx:=aSys.UseRBx ) THEN
					xNh^.rec		:= xCfg^.rec;	
					aDbx.vRam	:= aDbx.vRam 	+ sp;
					xDbx^.vRam	:= xDbx^.vRam 	+ sp;
					IF lg THEN
						yTx2 	:= CONCAT('..',xNh^.cfg,' rec:',INT_TO_STRINGF(xNh^.Rec, '%5d'),' siz:',UDINT_TO_STRINGF(aDbx.vRam-xNh^.ram, '%7d'), ' ImpFullCfg' );
						_Nh1RowTxt(logRst:=1);
   	   		END_IF;
				END_IF;
			ELSE
					xDbx^.vRam	:= xCfg^.ram;
  					xNh^.ram		:= aDbx.vRam;                             		// addres of the acfg[cf ] (first rec)
					FOR nd := 1 TO xCfg^.rec DO
			 			_NhEmpRec( wh := wh , va:= aDbx.vRam);                    					// add new rec with default data (maps xDel to this rec)
						IF xDbx^.FromDBx128 AND xDbx^.vRam + xCfg^.siz > aSys.Size_DBx THEN
//							errID	:= 1008;                                       	
							EXIT;
						END_IF;
						ok1	:= true;
						IF xNh^.ImpFullRec AND xCfg^.siz = xNh^.siz THEN
							ok1	:= _Nh_RBx_Mem(aDbx := xDbx^.vRam, sDbx:=xCfg^.siz, aMem := PTR_TO_UDINT(ADR(mRam[aDbx.vRam])),RBx:=aSys.UseRBx );
						ELSE
							offSrc	:= xDbx^.vRam;
							xDev		:= ADR(mRam[aDbx.vRam]);							// adresa aktualneho DEV - pouzije sa pre zistenie ci sa obnovuje minuly stav
							offDst	:= PTR_TO_UDINT( xDev );
							sp 		:= SIZEOF(NH_REC_OK)+SIZEOF(NH_CFG_ALL);
							rb			:=_Nh_RBx_Mem(aDbx := offSrc, sDbx := sp, aMem := offDst ,RBx:=aSys.UseRBx);
							offSrc	:= offSrc 	+ sp;
							offDst	:= offDst	+ sp;		
							IF xNh^.Imp_Al THEN
								rb	:=_Nh_RBx_Mem(aDbx := offSrc, sDbx := USINT_TO_UDINT( MIN( xCfg^.al, xNh^.al )), aMem := offDst ,RBx:=aSys.UseRBx);
							ELSIF xDev^.cf.LvlOnRst  THEN             			// obnovia sa al.i, a al.ou pre obnovenie stavu po restarte
								rb	:=_Nh_RBx_Mem(aDbx := offSrc, sDbx := SIZEOF(NH_CMD_ALL) * 2 , aMem := offDst ,RBx:=aSys.UseRBx);							
							END_IF;
							offSrc 	:= offSrc + USINT_TO_UDINT(xCfg^.al);
							offDst 	:= offDst + USINT_TO_UDINT(xNh^.al);
							IF _Nh_RBx_Mem(aDbx := offSrc, sDbx := MIN( xCfg^.cx, xNh^.cx ), aMem := offDst ,RBx:=aSys.UseRBx) THEN
								offSrc 	:= offSrc + xCfg^.cx;
								offDst 	:= offDst + xNh^.cx;
								IF _Nh_RBx_Mem(aDbx := offSrc, sDbx := USINT_TO_UDINT(MIN(xCfg^.hw,xNh^.hw)), aMem := offDst ,RBx:=aSys.UseRBx) THEN
									offSrc := offSrc + USINT_TO_UDINT(xCfg^.hw);
									offDst := offDst + USINT_TO_UDINT(xNh^.hw);
									rb	:=_Nh_RBx_Mem(aDbx := offSrc, sDbx := MIN(xCfg^.io,xNh^.io), aMem := offDst ,RBx:=aSys.UseRBx);
								END_IF;
							END_IF;
							// .me not restored
//							ok := _Nh_RBx_Mem(RBx:=aSys.UseRBx, aDbx := xDbx^.vRam, sDbx:=MIN(xCfg^.siz, xNh^.siz), aMem := PTR_TO_UDINT(ADR(mRam[aDbx.vRam])) );
						END_IF;
						IF ok1 THEN
							IF xNh^.DelAfterImp THEN
								xPt	:= ADR(mRam[aDbx.vRam]);
								xPt^.ok.Ok := false;
							END_IF;
							xNh^.rec		:= xNh^.rec 	+ 1;	
							aDbx.vRam	:= aDbx.vRam 	+ xNh^.siz;
//							aDbx.vRam	:= xNh^.ram 	+ (xNh^.siz * INT_TO_UDINT(xNh^.rec));
							xDbx^.vRam	:= xDbx^.vRam 	+ xCfg^.siz;
						END_IF;
      			END_FOR;	
					IF lg THEN
						yTx2 	:= CONCAT('..',xNh^.cfg,' rec:',INT_TO_STRINGF(xNh^.Rec, '%5d'),' siz:',UDINT_TO_STRINGF(aDbx.vRam-xNh^.ram, '%7d'),BOOL_TO_STRINGF(xNh^.DelAfterImp,'%b{ D^  }') );
						_Nh1RowTxt(logRst:=1);
   	   		END_IF;
			END_IF;
			xDbx^.aCfx[wh]	:= xDbx^.aCfx[wh] + USINT_TO_UDINT(xDbx^.sCfx[wh]);				// prepare the address of the next record in the DBX
			cx := cx + 1;	
(*
			IF cycLimit THEN
				IF aSys.RWtoFileCycle > _NH_CLUSTER * 5 THEN

				END_IF;
			END_IF;
*)		
		END_WHILE;
		IF lg THEN
			yTx2 	:= CONCAT('.End  ',USINT_TO_STRINGF(wh,'%2d'),UDINT_TO_STRINGF(aDbx.vRam, '%9d') );
			_Nh1RowTxt(logRst:=1);
     	END_IF;
		cx	:= 1;
		wh	:= wh + 1;
	END_WHILE;
	IF wh > 2 THEN
		done	:= TRUE;
		busy	:= FALSE;
	END_IF;
END_FUNCTION_BLOCK





