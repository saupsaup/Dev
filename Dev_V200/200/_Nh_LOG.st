
//_Nh_Log_Dbx_ADD(ev:='AL1',src:='PIR',key:='Pir-1',val:='On',subj:=1,rom:=101);


(*
DbxBeginAdr
	HeadAdr	#H,003,0169		*** Begin Blok-1 ***	len pre Write		
				053:DT=2025-10-20T12:34:56Z,EV=ALARM,SRC=boiler,temp=89.3
				050:DT=2025-10-20T12:34:57Z,EV=INFO,SRC=room1,hum=41.2
	HeadAdr	#H,003,0169		*** End Blok-2 ***
				053:DT=2025-10-20T12:34:56Z,EV=ALARM,SRC=boiler,temp=89.3
				->RowAdr ** adresa novej vety v bloku 1 - moze byt len jedna v aktualnom cykle zapisu
...
...
...
	HeadAdr	#H,003,0169		*** Begin Blok-2 *** - len pre citanie
				053:DT=2025-10-20T12:34:56Z,EV=ALARM,SRC=boiler,temp=89.3
				050:DT=2025-10-20T12:34:57Z,EV=INFO,SRC=room1,hum=41.2
				047:DT=2025-10-20T12:34:58Z,EV=STATE,SRC=pump,run=1
	HeadAdr	#H,003,0169		
				053:DT=2025-10-20T12:34:56Z,EV=ALARM,SRC=boiler,temp=89.3
				050:DT=2025-10-20T12:34:57Z,EV=INFO,SRC=room1,hum=41.2
				047:DT=2025-10-20T12:34:58Z,EV=STATE,SRC=pump,run=1
	HeadAdr	#H,003,0169		*** End Blok-2 ***
				047:DT=2025-10-20T12:34:58Z,EV=STATE,SRC=pump,run=1
DbxEndAdr
*)

FUNCTION  _Nh_Log_Dbx_ADD  : BOOL
	VAR_INPUT
		Pi:		BOOL:=true;		// if used raspberry Pi for Logs and Graphana			
		ev: 		STRING[3];		// kategorizacia (INFO, ALARM, STATE, ERR, …)rizácia
		src:		STRING[3];		// identifikácia pôvodu	zdroj (senzor, relé, modul, funkcia)
		key:		STRING[8];		// nazov veliciny
		val:		STRING[8];		// hodnota
		subj:		USINT;			// subjekt (user, zariadenie, funkcia)
		rom:		USINT;			// rom
	END_VAR
	VAR_TEMP
		RowLen:	INT;	
	END_VAR

	yTx0	:= DT_TO_STRINGF(aSys.NhDT,'%TYYYY-MM-DD-hh:mm:ss');
	IF Pi THEN
			//	053:DT=2025-10-20T12:34:56Z,EV=ALARM,SRC=boiler,temp=89.3
			yTx0	:= CONCAT('DT=',yTx0,',EV=',ev,',SRC=',src,',',key,'=',val,',SUBJ=',USINT_TO_STRINGF(subj,'%02u'),',ROOM=;',USINT_TO_STRINGF(rom,'%03u')); //,'$r$n');
			yTx0		:= CONCAT( INT_TO_STRINGF(LEN(yTx0),'%03u'),':',yTx0); 		
			RowLen	:= LEN(yTx0);
			// test			
			IF	aSys.LogDBx.write.HeadAdr + INT_TO_UDINT(aSys.LogDBx.write.Bytes) + USINT_TO_UDINT(aSys.LogDBx.HeadLen) + INT_TO_UDINT(RowLen)  > aSys.LogDBx.DbxEndAdr THEN // if new line fit in DBx addresss
				aSys.LogDBx.read.LastDtgrAdr	:= aSys.LogDBx.write.HeadAdr;
				aSys.LogDBx.write.HeadAdr 	:= aSys.LogDBx.DbxBeginAdr + SIZEOF(NH_LOG_HED_DBX) ;
				aSys.LogDBx.write.Rows		:= 0;

			ELSIF	aSys.LogDBx.write.Bytes + RowLen > aSys.LogDBx.DatagramLen THEN	// If new line does not exceed the length of the telegram
				aSys.LogDBx.write.HeadAdr 	:= aSys.LogDBx.write.HeadAdr + INT_TO_UDINT(aSys.LogDBx.write.Bytes);	// new datgram address (header)
				aSys.LogDBx.write.Rows		:= 0;
			END_IF;		   
			IF aSys.LogDBx.write.Rows = 0 THEN
				aSys.LogDBx.write.Bytes	:= USINT_TO_INT(aSys.LogDBx.HeadLen);
				aSys.LogDBx.write.RowAdr	:= aSys.LogDBx.write.HeadAdr + INT_TO_UDINT(aSys.LogDBx.write.Bytes);
			END_IF;
			// write row
			rb 	:= WriteToDBx( dataBoxAddress := aSys.LogDBx.write.RowAdr, length := LEN(yTx0), varAddress := PTR_TO_UDINT( ADR(yTx0)));			
			aSys.LogDBx.write.Bytes	:=	aSys.LogDBx.write.Bytes + LEN(yTx0);	// update size datagram 
			aSys.LogDBx.write.Rows		:= aSys.LogDBx.write.Rows + 1;				// update record of datagram 
			// create and write header
			yTx0	:= CONCAT('#H,',USINT_TO_STRINGF(aSys.LogDBx.write.Rows,'%03u'),',',INT_TO_STRINGF(aSys.LogDBx.write.Bytes,'%04u'),'$n');							
			rb 	:= WriteToDBx( dataBoxAddress := aSys.LogDBx.write.HeadAdr, length := LEN(yTx0), varAddress := PTR_TO_UDINT( ADR(yTx0)));			
	ELSE

	END_IF;	
(*
	IF aSys.write.buffer = aSys.write.buffer THEN
		aSys.read.LastDtgrAdr	:=  aSys.write.HeatAdr;
	END_IF;		 
*)
END_FUNCTION

FUNCTION_BLOCK	_Nh_Log_DBX_RW		// write log to buffer (DBx,RBx) and read from buffer and send datagram to Pi or Write to USB/LOG
	VAR_INPUT
//		write:				BOOL;		
//		Pi:					BOOL;
//		DatagramLen:		INT := 1200;	
//		DbxBeginAdr: 		UDINT := 0; // zaciatok dat logu
//		DbxEndAdr: 			UDINT;
	//		DataBeginAdr: 		UDINT ; // zaciatok dat logu		
	END_VAR	

	VAR
//		RowLen: 				INT;
//		LogHed:				NH_LOG_HED_DBX;
	END_VAR
(*
	IF aSys.write.buffer = aSys.write.buffer THEN
		aSys.read.LastDtgrAdr	:=  aSys.write.HeatAdr;
	END_IF;		 


	IF aSys.LogDBx.read	THEN		
		write	:= FALSE;
		// create CSV row
		yTx0	:= DT_TO_STRINGF(aSys.NhDT,'%TYYYY-MM-DD-hh:mm:ss');
		//	yTx2	:= CONCAT('DT=',yTx2,',EV=',ev,',SRC=',src,',',key,'=',REAL_TO_STRINGF(val,'%8.2f'),',SUBJ=',USINT_TO_STRINGF(subj,'%2u'),',ROOM=;',USINT_TO_STRINGF(rom,'%3u')); //,';', '$r$n');



		IF Pi THEN

		ELSE

		END_IF;	




	END_IF;		
*)

END_FUNCTION_BLOCK


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
//		go1		: BOOL;		
//		Enable	: BOOL;


      evn      : STRING[3];

		cfg      : STRING[3];
		tsk		: INT;
      wht      : STRING[3];
      nbr      : STRING[4];
      rom      : STRING[3];
      val1    	: STRING[7];
      val2    	: STRING[7];
//		tRTC		: DT;
		c			: USINT;
//		nu			: USINT;
//		vu			: USINT;
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
		_Nh_Log_Path(wh:=100);
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





///// ******* AI generated

(*
	LOG PLC -> Pi (CSV?NDJSON, ring buffer, UDP)
	- výber Databox/RAMbox podla systémovej premennej CPU_CODE (100x = DB, 200x = RAM)
	- prefix názvov: _Nh_
	- RETAIN: tailAcked, seq, lastMsg meta
	- CSV skladané priamo do bajtového POOL-u (offset/len)
	- UDP: najprv pošle CSV hlavicku „#BATCH,ver,kind,seq,tail0,len\n“, potom dátový blok (môže byt rozdelený wrapom na 2 datagramy)
	- ACK: Pi vráti „#ACK,kind,seq,tail0,len\n“ – PLC spracuje a posunie tail/tailAcked
*)

(*
)
VAR_GLOBAL CONSTANT
	_Nh_CPU_MIN_DB				: UINT := 1000;	// Databox (CP100x)
	_Nh_CPU_MAX_DB				: UINT := 1999;
	_Nh_CPU_MIN_RAM			: UINT := 2000;	// RAMbox (CP200x)
	_Nh_CPU_MAX_RAM			: UINT := 2999;

	_Nh_LOG_POOL_SIZE			: UDINT := 65536;	// APP
	_Nh_LOG_SYS_POOL_SIZE	: UDINT := 8192;	// SYS
	_Nh_FLUSH_PERIOD_MS		: UDINT := 7000;
	_Nh_UDP_MAX_CHUNK			: UINT  := 1200;

	_Nh_TX_TMP_MAX				: UINT := 128;		// docasný buffer pre CSV hlavicku / ACK
END_VAR

TYPE
	_Nh_TLogBatchHdr : STRUCT
		ver			: USINT;
		kind		: USINT;		// 0=APP, 1=SYS
		seq			: UDINT;
		tail0		: UDINT;
		sent_len	: UINT;
	END_STRUCT;

	_Nh_TLogCtrl : STRUCT
		head				: UDINT;
		tail				: UDINT;
		tailAcked		: UDINT;	// RETAIN
		lastMsgLen		: UINT;		// RETAIN (diagnostika)
		lastMsgCrc		: UINT;		// RETAIN (diagnostika)
		tmLastFlushMs	: UDINT;
	END_STRUCT;

	_Nh_THeadLog : STRUCT
		cApp			: _Nh_TLogCtrl;
		cSys			: _Nh_TLogCtrl;
		piIpAddr	: DWORD;
		piPort		: UINT;
		seq			: UDINT;		// RETAIN
		sendBusy	: BOOL;
	END_STRUCT;

	_Nh_TLogArgs : STRUCT
		evCode	: UINT;
		u1			: DINT;
		u2			: DINT;
//		sPtr		: BYTE;	 	// volitelné krátke info
		sLen		: UINT;
		isSys		: BOOL;
	END_STRUCT;

	_Nh_TPoolView : STRUCT
		pData	: BYTE;	//VPOINTER TO BYTE;
		size	: UDINT;
	END_STRUCT;

	aSys : STRUCT
		DT			: DT;						// systémový cas
		HeadLog	: _Nh_THeadLog;		// riadenie logu
	END_STRUCT;


END_TYPE

//VAR_GLOBAL RETAIN
//END_VAR

// FYZICKÉ POLE – obidve verzie; v projekte si ich môžeš "AT %" namapovat
VAR_GLOBAL
	_Nh_LOG_POOL_APP_RAM	: ARRAY[0.._Nh_LOG_POOL_SIZE-1] OF BYTE;
	_Nh_LOG_POOL_SYS_RAM	: ARRAY[0.._Nh_LOG_SYS_POOL_SIZE-1] OF BYTE;
	_Nh_LOG_POOL_APP_DB		: ARRAY[0.._Nh_LOG_POOL_SIZE-1] OF BYTE;
	_Nh_LOG_POOL_SYS_DB		: ARRAY[0.._Nh_LOG_SYS_POOL_SIZE-1] OF BYTE;

	// docasné TX/RX buffery (CSV)
	_Nh_TxTmp	: ARRAY[0.._Nh_TX_TMP_MAX-1] OF BYTE;
	_Nh_RxTmp	: ARRAY[0.._Nh_TX_TMP_MAX-1] OF BYTE;
END_VAR



// -----------------------------------------------------------------------------
// Ring helpers
// -----------------------------------------------------------------------------

FUNCTION _Nh_RingAdvance : UDINT
VAR_INPUT
		idx		: UDINT;
		step	: UDINT;
		size	: UDINT;
END_VAR
	_Nh_RingAdvance := (idx + step) MOD size;
END_FUNCTION

FUNCTION _Nh_RingDistance : UDINT
VAR_INPUT
		tail	: UDINT;
		head	: UDINT;
		size	: UDINT;
END_VAR
	_Nh_RingDistance := (head + size - tail) MOD size;
END_FUNCTION



// -----------------------------------------------------------------------------
// Pool select (CPU_CODE ? RAM/DB)
// -----------------------------------------------------------------------------

FUNCTION _Nh_GetPool : BOOL
VAR_INPUT
		isSys	: BOOL;
END_VAR
VAR_OUTPUT
		view	: _Nh_TPoolView;
END_VAR
	// Výber podla CPU_CODE (systémová premenná)
	IF (CPU_CODE >= _Nh_CPU_MIN_DB) AND (CPU_CODE <= _Nh_CPU_MAX_DB) THEN
		IF isSys THEN
			view.pData := ADR(_Nh_LOG_POOL_SYS_DB[0]);
			view.size := _Nh_LOG_SYS_POOL_SIZE;
		ELSE
			view.pData := ADR(_Nh_LOG_POOL_APP_DB[0]);
			view.size := _Nh_LOG_POOL_SIZE;
		END_IF
	ELSIF (CPU_CODE >= _Nh_CPU_MIN_RAM) AND (CPU_CODE <= _Nh_CPU_MAX_RAM) THEN
		IF isSys THEN
			view.pData := ADR(_Nh_LOG_POOL_SYS_RAM[0]);
			view.size := _Nh_LOG_SYS_POOL_SIZE;
		ELSE
			view.pData := ADR(_Nh_LOG_POOL_APP_RAM[0]);
			view.size := _Nh_LOG_POOL_SIZE;
		END_IF
	ELSE
		// fallback = RAM
		IF isSys THEN
			view.pData := ADR(_Nh_LOG_POOL_SYS_RAM[0]);
			view.size := _Nh_LOG_SYS_POOL_SIZE;
		ELSE
			view.pData := ADR(_Nh_LOG_POOL_APP_RAM[0]);
			view.size := _Nh_LOG_POOL_SIZE;
		END_IF
	END_IF
	_Nh_GetPool := TRUE;
END_FUNCTION



// -----------------------------------------------------------------------------
// Low-level pool writes + tiny CRC
// -----------------------------------------------------------------------------

FUNCTION _Nh_PoolPutB : UDINT
VAR_INPUT
		pData	: POINTER TO BYTE;
		dstIdx	: UDINT;
		size	: UDINT;
		b			: BYTE;
END_VAR
	pData[dstIdx] := b;
	_Nh_PoolPutB := _Nh_RingAdvance(idx := dstIdx, step := 1, size := size);
END_FUNCTION

FUNCTION _Nh_PoolPutInt : UDINT
VAR_INPUT
		pData	: POINTER TO BYTE;
		dstIdx	: UDINT;
		size	: UDINT;
		x			: DINT;
END_VAR
VAR
		buf		: ARRAY[0..15] OF BYTE;	// "-2147483648" max
		n,i		: INT;
		sign	: BOOL;
		tmp		: DINT;
		idx		: UDINT;
END_VAR
	idx := dstIdx;
	IF x = 0 THEN
		idx := _Nh_PoolPutB(pData := pData, dstIdx := idx, size := size, b := BYTE(48));
		_Nh_PoolPutInt := idx; RETURN;
	END_IF
	sign := (x < 0);
	IF sign THEN tmp := -x ELSE tmp := x END_IF
	n := 0;
	WHILE tmp > 0 DO
		buf[n] := BYTE(48 + (tmp MOD 10));
		tmp := tmp / 10;
		n := n + 1;
	END_WHILE
	IF sign THEN
		idx := _Nh_PoolPutB(pData := pData, dstIdx := idx, size := size, b := BYTE(45));
	END_IF
	FOR i := n-1 DOWNTO 0 DO
		idx := _Nh_PoolPutB(pData := pData, dstIdx := idx, size := size, b := buf[i]);
	END_FOR
	_Nh_PoolPutInt := idx;
END_FUNCTION

FUNCTION _Nh_Crc16Lite : UINT
VAR_INPUT
		pData		: POINTER TO BYTE;
		startIdx	: UDINT;
		size		: UDINT;
		len			: UINT;
END_VAR
VAR
		crc	: UINT;
		k		: UINT;
		idx	: UDINT;
END_VAR
	crc := 0;
	idx := startIdx;
	FOR k := 1 TO len DO
		crc := crc XOR UINT(pData[idx]);
		idx := _Nh_RingAdvance(idx := idx, step := 1, size := size);
	END_FOR
	_Nh_Crc16Lite := crc;
END_FUNCTION



// -----------------------------------------------------------------------------
// Append CSV log line (DT,evCode,u1,u2[,text]\n)
// -----------------------------------------------------------------------------

FUNCTION _Nh_Log_AppendCsv : BOOL
VAR_INPUT
		isSys	: BOOL;
		args	: _Nh_TLogArgs;
END_VAR
VAR
		view	: _Nh_TPoolView;
		c			: ^_Nh_TLogCtrl;
		idx0	: UDINT;
		idx		: UDINT;
		len		: UINT;
		i			: UINT;
		b			: BYTE;
		dtDate	: DATE;
		dtTime	: TIME_OF_DAY;
END_VAR
	IF isSys THEN c := ADR(aSys.HeadLog.cSys) ELSE c := ADR(aSys.HeadLog.cApp) END_IF;
	_Nh_GetPool(isSys := isSys, view := view);

	idx := c^.head;
	idx0 := idx;

	dtDate := DT_TO_DATE(aSys.DT);
	dtTime := DT_TO_TIME_OF_DAY(aSys.DT);

	// YYYY-MM-DD,HH:MM:SS
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, DINT(dtDate.year));
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE('-'));
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, DINT(dtDate.month));
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE('-'));
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, DINT(dtDate.day));
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(','));
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, DINT(dtTime.hour));
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(':'));
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, DINT(dtTime.minute));
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(':'));
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, DINT(dtTime.second));
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(','));

	// evCode,u1,u2
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, DINT(args.evCode));
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(','));
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, args.u1);
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(','));
	idx := _Nh_PoolPutInt(view.pData, idx, view.size, args.u2);

	// volitelný krátky text
	IF (args.sPtr <> 0) AND (args.sLen > 0) THEN
		idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(','));
		FOR i := 0 TO args.sLen-1 DO
			b := args.sPtr[i];
			IF (b = 13) OR (b = 10) THEN b := 32 END_IF
			idx := _Nh_PoolPutB(view.pData, idx, view.size, b);
		END_FOR
	END_IF

	// ukoncenie riadku
	idx := _Nh_PoolPutB(view.pData, idx, view.size, BYTE(10));

	// meta o poslednej vete
	len := UINT((idx + view.size - idx0) MOD view.size);
	c^.lastMsgLen := len;
	c^.lastMsgCrc := _Nh_Crc16Lite(pData := view.pData, startIdx := idx0, size := view.size, len := len);

	// commit HEAD
	c^.head := idx;

	_Nh_Log_AppendCsv := TRUE;
END_FUNCTION

FUNCTION _Nh_LogEvent : BOOL
VAR_INPUT
		evCode	: UINT;
		u1			: DINT;
		u2			: DINT;
		isSys		: BOOL;
END_VAR
VAR
		a : _Nh_TLogArgs;
END_VAR
	a.evCode := evCode; a.u1 := u1; a.u2 := u2; a.isSys := isSys; a.sPtr := 0; a.sLen := 0;
	_Nh_LogEvent := _Nh_Log_AppendCsv(isSys := isSys, args := a);
END_FUNCTION

FUNCTION _Nh_LogEventTxt : BOOL
VAR_INPUT
		evCode	: UINT;
		u1			: DINT;
		u2			: DINT;
		pTxt		: POINTER TO BYTE;
		lenTxt	: UINT;
		isSys		: BOOL;
END_VAR
VAR
		a : _Nh_TLogArgs;
END_VAR
	a.evCode := evCode; a.u1 := u1; a.u2 := u2; a.isSys := isSys; a.sPtr := pTxt; a.sLen := lenTxt;
	_Nh_LogEventTxt := _Nh_Log_AppendCsv(isSys := isSys, args := a);
END_FUNCTION



// -----------------------------------------------------------------------------
// UDP wiring (PLACEHOLDERS to bind to your UDP FB)
//	- _Nh_UdpSendRaw: odošle 1 datagram do aSys.HeadLog.piIpAddr:piPort
//	- _Nh_OnUdpRecv: zavolaj pri prijme; ak je to ACK CSV, posunie tail
// -----------------------------------------------------------------------------

FUNCTION _Nh_UdpSendRaw : BOOL
VAR_INPUT
		pBuf	: POINTER TO BYTE;
		len		: UINT;
END_VAR
	// TODO: TU napoj tvoj UDP klient/FB (sendto(piIpAddr, piPort, pBuf, len))
	// return TRUE ak odoslané
	_Nh_UdpSendRaw := TRUE;
END_FUNCTION

FUNCTION _Nh_UdpMakeBatchHeaderCSV : UINT
VAR_INPUT
		hdr		: _Nh_TLogBatchHdr;
		pOut	: POINTER TO BYTE;	// _Nh_TxTmp
		maxLen: UINT;							// _Nh_TX_TMP_MAX
END_VAR
VAR
		i		: UINT;
		idx	: UINT;
END_VAR
	// Zapíše: "#BATCH,ver,kind,seq,tail0,len\n"
	idx := 0;
	IF maxLen < 10 THEN _Nh_UdpMakeBatchHeaderCSV := 0; RETURN END_IF

	// helper lokálna procedúra na císlo
	// (pre jednoduchost použijeme _Nh_PoolPutInt nad docasným "pseudopoolom")
	// tu: manuálne, aby sme držali tabulky odsadenia v jednom súbore
	pOut[idx] := BYTE(35); idx := idx + 1;			// '#'
	pOut[idx] := BYTE(66); idx := idx + 1;			// 'B'
	pOut[idx] := BYTE(65); idx := idx + 1;			// 'A'
	pOut[idx] := BYTE(84); idx := idx + 1;			// 'T'
	pOut[idx] := BYTE(67); idx := idx + 1;			// 'C'
	pOut[idx] := BYTE(72); idx := idx + 1;			// 'H'
	pOut[idx] := BYTE(44); idx := idx + 1;			// ','

	// ver
	idx := _Nh_WriteUIntAsAscii(pOut := pOut, idx := idx, x := UINT(hdr.ver));			pOut[idx] := 44; idx := idx + 1;
	// kind
	idx := _Nh_WriteUIntAsAscii(pOut := pOut, idx := idx, x := UINT(hdr.kind));		pOut[idx] := 44; idx := idx + 1;
	// seq
	idx := _Nh_WriteUDIntAsAscii(pOut := pOut, idx := idx, x := hdr.seq);					pOut[idx] := 44; idx := idx + 1;
	// tail0
	idx := _Nh_WriteUDIntAsAscii(pOut := pOut, idx := idx, x := hdr.tail0);				pOut[idx] := 44; idx := idx + 1;
	// len
	idx := _Nh_WriteUIntAsAscii(pOut := pOut, idx := idx, x := hdr.sent_len);
	pOut[idx] := 10; idx := idx + 1;																		// '\n'

	_Nh_UdpMakeBatchHeaderCSV := idx;	// length
END_FUNCTION

FUNCTION _Nh_WriteUIntAsAscii : UINT
VAR_INPUT
		pOut	: POINTER TO BYTE;
		idx		: UINT;
		x			: UINT;
END_VAR
VAR
		tmp		: UINT;
		buf		: ARRAY[0..5] OF BYTE;
		n			: INT;
		i			: INT;
END_VAR
	IF x = 0 THEN
		pOut[idx] := 48; _Nh_WriteUIntAsAscii := idx + 1; RETURN;
	END_IF
	tmp := x; n := 0;
	WHILE tmp > 0 DO
		buf[n] := BYTE(48 + (tmp MOD 10));
		tmp := tmp / 10;
		n := n + 1;
	END_WHILE
	FOR i := n-1 DOWNTO 0 DO
		pOut[idx] := buf[i]; idx := idx + 1;
	END_FOR
	_Nh_WriteUIntAsAscii := idx;
END_FUNCTION

FUNCTION _Nh_WriteUDIntAsAscii : UINT
VAR_INPUT
		pOut	: POINTER TO BYTE;
		idx		: UINT;
		x			: UDINT;
END_VAR
VAR
		tmp		: UDINT;
		buf		: ARRAY[0..9] OF BYTE;
		n			: INT;
		i			: INT;
END_VAR
	IF x = 0 THEN
		pOut[idx] := 48; _Nh_WriteUDIntAsAscii := idx + 1; RETURN;
	END_IF
	tmp := x; n := 0;
	WHILE tmp > 0 DO
		buf[n] := BYTE(48 + (tmp MOD 10));
		tmp := tmp / 10;
		n := n + 1;
	END_WHILE
	FOR i := n-1 DOWNTO 0 DO
		pOut[idx] := buf[i]; idx := idx + 1;
	END_FOR
	_Nh_WriteUDIntAsAscii := idx;
END_FUNCTION

FUNCTION _Nh_UdpSendBatch : BOOL
VAR_INPUT
		hdr		: _Nh_TLogBatchHdr;
		isSys	: BOOL;
		tail	: UDINT;
		len		: UDINT;
END_VAR
VAR
		view		: _Nh_TPoolView;
		ok			: BOOL;
		headerLen: UINT;
		size		: UDINT;
		first		: UINT;
		second	: UINT;
		idx		: UDINT;
END_VAR
	// Header CSV
	headerLen := _Nh_UdpMakeBatchHeaderCSV(hdr := hdr, pOut := ADR(_Nh_TxTmp[0]), maxLen := _Nh_TX_TMP_MAX);
	IF headerLen = 0 THEN _Nh_UdpSendBatch := FALSE; RETURN END_IF

	// 1) Pošli CSV hlavicku
	ok := _Nh_UdpSendRaw(pBuf := ADR(_Nh_TxTmp[0]), len := headerLen);
	IF NOT ok THEN _Nh_UdpSendBatch := FALSE; RETURN END_IF

	// 2) Pošli dáta – rešpektuj wrap
	_Nh_GetPool(isSys := isSys, view := view);
	size := view.size;

	IF (tail + len) <= size THEN
		// jedným kusom
		ok := _Nh_UdpSendRaw(pBuf := ADR(view.pData[tail]), len := UINT(len));
		IF NOT ok THEN _Nh_UdpSendBatch := FALSE; RETURN END_IF
	ELSE
		// rozdelené: (tail..end) + (0..zvyšok)
		first := UINT(size - tail);
		second := UINT(len - first);

		ok := _Nh_UdpSendRaw(pBuf := ADR(view.pData[tail]), len := first);
		IF NOT ok THEN _Nh_UdpSendBatch := FALSE; RETURN END_IF

		ok := _Nh_UdpSendRaw(pBuf := ADR(view.pData[0]), len := second);
		IF NOT ok THEN _Nh_UdpSendBatch := FALSE; RETURN END_IF
	END_IF

	_Nh_UdpSendBatch := TRUE;
END_FUNCTION

FUNCTION _Nh_ParseAckCsv : BOOL
VAR_INPUT
		pBuf		: POINTER TO BYTE;
		len		: UINT;
END_VAR
VAR_OUTPUT
		kind		: USINT;
		seq			: UDINT;
		tail0		: UDINT;
		sent_len: UINT;
END_VAR
VAR
		i			: UINT;
		field	: USINT;	// 0..5
		accUD	: UDINT;
		accU	: UINT;
		isUd	: BOOL;
END_VAR
	// Ocakávame: "#ACK,kind,seq,tail0,len\n"
	IF len < 7 THEN _Nh_ParseAckCsv := FALSE; RETURN END_IF
	IF (pBuf[0] <> 35) OR (pBuf[1] <> 65) OR (pBuf[2] <> 67) OR (pBuf[3] <> 75) OR (pBuf[4] <> 44) THEN
		_Nh_ParseAckCsv := FALSE; RETURN;
	END_IF

	field := 1; accUD := 0; accU := 0; isUd := FALSE;
	FOR i := 5 TO len-1 DO
		IF (pBuf[i] = 44) OR (pBuf[i] = 10) THEN
			CASE field OF
				1: kind := USINT(accU);
				2: seq := accUD;
				3: tail0 := accUD;
				4: sent_len := accU;
			END_CASE
			field := field + 1;
			accUD := 0; accU := 0; isUd := FALSE;
			IF pBuf[i] = 10 THEN EXIT END_IF
		ELSE
			IF (pBuf[i] >= 48) AND (pBuf[i] <= 57) THEN
				// ak predtým bolo pole UDINT (seq, tail0)
				IF (field = 2) OR (field = 3) THEN
					isUd := TRUE; accUD := accUD * 10 + UDINT(pBuf[i] - 48);
				ELSE
					accU := accU * 10 + UINT(pBuf[i] - 48);
				END_IF
			ELSE
				_Nh_ParseAckCsv := FALSE; RETURN;
			END_IF
		END_IF
	END_FOR

	IF field < 5 THEN _Nh_ParseAckCsv := FALSE ELSE _Nh_ParseAckCsv := TRUE END_IF
END_FUNCTION

FUNCTION _Nh_OnUdpRecv : BOOL
VAR_INPUT
		pBuf	: POINTER TO BYTE;
		len		: UINT;
END_VAR
VAR
		k		: USINT;
		sq		: UDINT;
		t0		: UDINT;
		sl		: UINT;
END_VAR
	IF len = 0 THEN _Nh_OnUdpRecv := FALSE; RETURN END_IF
	IF pBuf[0] <> 35 THEN _Nh_OnUdpRecv := FALSE; RETURN END_IF	// nie CSV meta

	IF (len >= 5) AND (pBuf[1]=65) AND (pBuf[2]=67) AND (pBuf[3]=75) THEN
		// "#ACK,"
		IF _Nh_ParseAckCsv(pBuf := pBuf, len := len, kind := k, seq := sq, tail0 := t0, sent_len := sl) THEN
			_Nh_OnUdpRecv := _Nh_PLC_OnAck(kind := k, seq := sq, tail0 := t0, sent_len := sl);
			RETURN;
		END_IF
	END_IF

	_Nh_OnUdpRecv := FALSE;
END_FUNCTION



// -----------------------------------------------------------------------------
// Flush + ACK handling + Init
// -----------------------------------------------------------------------------

FUNCTION_BLOCK _Nh_fbLogFlush
VAR_INPUT
		nowMs	: UDINT;
END_VAR
VAR
		c			: ^_Nh_TLogCtrl;
		view	: _Nh_TPoolView;
		isSys	: BOOL;
		avail	: UDINT;
		take	: UINT;
		hdr		: _Nh_TLogBatchHdr;
		ok		: BOOL;
END_VAR
	IF aSys.HeadLog.sendBusy THEN RETURN END_IF

	// priorita SYS
	IF aSys.HeadLog.cSys.tail <> aSys.HeadLog.cSys.head THEN
		isSys := TRUE; c := ADR(aSys.HeadLog.cSys);
	ELSE
		IF aSys.HeadLog.cApp.tail = aSys.HeadLog.cApp.head THEN RETURN END_IF
		isSys := FALSE; c := ADR(aSys.HeadLog.cApp);
	END_IF

	IF (nowMs - c^.tmLastFlushMs) < _Nh_FLUSH_PERIOD_MS THEN RETURN END_IF

	_Nh_GetPool(isSys := isSys, view := view);
	avail := _Nh_RingDistance(tail := c^.tail, head := c^.head, size := view.size);
	IF avail = 0 THEN RETURN END_IF

	IF avail > _Nh_UDP_MAX_CHUNK THEN take := _Nh_UDP_MAX_CHUNK ELSE take := UINT(avail) END_IF

	hdr.ver := 1;
	hdr.kind := USINT(BOOL_TO_USINT(isSys));
	hdr.seq := aSys.HeadLog.seq;
	hdr.tail0 := c^.tail;
	hdr.sent_len := take;

	ok := _Nh_UdpSendBatch(hdr := hdr, isSys := isSys, tail := c^.tail, len := UDINT(take));
	IF ok THEN
		aSys.HeadLog.seq := aSys.HeadLog.seq + 1;
		aSys.HeadLog.sendBusy := TRUE;
		c^.tmLastFlushMs := nowMs;
	END_IF
END_FUNCTION_BLOCK

FUNCTION _Nh_PLC_OnAck : BOOL
VAR_INPUT
		kind		: USINT;
		seq			: UDINT;
		tail0		: UDINT;
		sent_len	: UINT;
END_VAR
VAR
		c			: ^_Nh_TLogCtrl;
		view	: _Nh_TPoolView;
		isSys	: BOOL;
END_VAR
	isSys := (kind = 1);
	IF isSys THEN c := ADR(aSys.HeadLog.cSys) ELSE c := ADR(aSys.HeadLog.cApp) END_IF

	// kontrola súladu
	IF c^.tail <> tail0 THEN _Nh_PLC_OnAck := FALSE; RETURN END_IF

	_Nh_GetPool(isSys := isSys, view := view);
	c^.tail := _Nh_RingAdvance(idx := c^.tail, step := UDINT(sent_len), size := view.size);
	c^.tailAcked := c^.tail;			// RETAIN – klúcové pre nadviazanie
	aSys.HeadLog.sendBusy := FALSE;

	_Nh_PLC_OnAck := TRUE;
END_FUNCTION

FUNCTION_BLOCK _Nh_fbLogInit
VAR_INPUT
		nowMs	: UDINT;
END_VAR
	aSys.HeadLog.cApp.head := aSys.HeadLog.cApp.tailAcked;
	aSys.HeadLog.cApp.tail := aSys.HeadLog.cApp.tailAcked;
	aSys.HeadLog.cApp.tmLastFlushMs := nowMs;

	aSys.HeadLog.cSys.head := aSys.HeadLog.cSys.tailAcked;
	aSys.HeadLog.cSys.tail := aSys.HeadLog.cSys.tailAcked;
	aSys.HeadLog.cSys.tmLastFlushMs := nowMs;

	aSys.HeadLog.sendBusy := FALSE;
	// aSys.HeadLog.seq zostáva RETAIN
END_FUNCTION_BLOCK
*)


// -----------------------------------------------------------------------------
// Použitie (príklad):
// -----------------------------------------------------------------------------
//
// 	// INIT (raz po štarte)
// 	_Nh_fbLogInit(nowMs := SysGetTickCount());
//
// 	// CYKLUS (periodicky, napr. každú smycku)
// 	_Nh_fbLogFlush(nowMs := SysGetTickCount());
//
// 	// Logovanie udalostí z tvojej procedúry
// 	_Nh_LogEvent(evCode := 101, u1 := 7, u2 := 0, isSys := FALSE);	// APP
// 	_Nh_LogEvent(evCode := 1,   u1 := 0, u2 := 0, isSys := TRUE);		// SYS priorita
//
// 	// Pri prijatí UDP z Pi volaj:
// 	// _Nh_OnUdpRecv(pBuf := ADR(rx[0]), len := rxLen);
//

