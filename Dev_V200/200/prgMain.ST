{ $ IFNDEF _Nh_CUST_RESTART } 	                 // ak nie je definovana funkcia v uzivatelskom subore, vytvori sa pre
(*
   FUNCTION _Nh_CUST_RESTART  {HIDDEN} : BOOL
		;
   END_FUNCTION
*)
{ $ END_IF } 	

TYPE _Nh_Last_State_ON : STRUCT 		// last state PRG/CPU before restart
		lastDT:		DT; (* Comment *)
		Ini: 			USINT;
		copy:		BOOL;
		cfg:		BOOL;

	END_STRUCT
END_TYPE

VAR_GLOBAL
//DeleteFiles : DeleteSurplusFilesEx := ( delEmptyDir := true ); // delete surplus files in  given  directory
  	fb_Nh_Import_CIB		: _Nh_Import_CIB;
	fb_Nh_Cfg_Restart		: _Nh_Cfg_Restart;
	fb_Nh_Log_DBX_RW		: _Nh_Log_DBX_RW;		// write log to buffer (DBx,RBx) and read from buffer and send datagram to Pi or Write to USB/LOG
END_VAR
VAR_GLOBAL RETAIN
	_NhLastPowerOffState		: _Nh_Last_State_ON; 		// last state PRG/CPU before Power OFF
END_VAR
	
PROGRAM prgMain
   VAR
   	fbCrHet				: _Nh_Create_HET;
      { $ IFDEF __NH_WEB }
         fbWebControl   : _NhWebControl;
      { $ END_IF  } 	
		ok				: BOOL;
//    	notification 	: TWebPushNotif;
//    	webPush      	: fbWebPushService;

   END_VAR
//	rb 							:= 1;
	aSys.RWtoFileCycle		:= 0;																	// how many writes to all files in cyc
	aSys.NhTime    			:= GetTime();
  	aSys.NhDate    			:= GetDate();
  	aSys.NhDT      			:= GetDateTime();													// skoro strojovy cas zaciatku cyklu, ked sa uz zapli vsetky vystupy
  	aSys.LogHed.logTime  	:= TIME_TO_STRINGF(aSys.NhTime,'%Thh:mm:ss.zz');
  	aSys.LogHed.logDate  	:= DATE_TO_STRINGF(aSys.NhDate,'%TYY-MM-DD');



	// 1   SEC 	=  10000 SYSTEM_S.LAST_CYCLE_TIME_100US      1.0 * 10 000
	// 0,7 SEC 	=  7000 SYSTEM_S.LAST_CYCLE_TIME_100US	   	0.7 * 10 000
	// 0.001    =    10
   aSys.dMin      	:= USINT_TO_INT( SYSTEM_S.COUNTER_HOURS ) * 60 + USINT_TO_INT(SYSTEM_S.COUNTER_MINUTES);  // pocet minut v ramci dna
	aSys.rSec	   	:= UINT_TO_REAL( SYSTEM_S.LAST_CYCLE_TIME_100US ) / 10.0 ;		// REAL: doba minuleho cyklu v mS (prevod zo 100 mikrosekund)							
	aSys.mSec			:= REAL_TO_UINT( ROUND(  aSys.rSec ) );			            // UINT: doba minuleho cyklu v mS  (prevod zo 100 mikrosekund)							
//	aSys.rTime     	:= TIME_TO_REAL(aSys.NhTime);				// REAL: cas v sekundach od polnoci
	
(*
	IF System_S.F_EDGE_10SEC THEN	//System_S.F_EDGE_1MIN OR  System_S.R_EDGE_1MIN THEN				// kazdych 30sec
		aSys.LogHed.Quite10Sec := aSys.LogHed.Quite10Sec + 1;
		IF aSys.LogHed.Quite10Sec > 6 THEN														// ak nebol 1 min zapis, zavrie subor
			rb := _Nh_Log_Evn_ADD(tsk := 255);
		END_IF;
		aSys.mSecMax			:= 0;
	END_IF;
*)


 	aSys.mSecMax 	:= MAX(aSys.mSec, aSys.mSecMax);
	aSys.et50		:= aSys.et50 + SYSTEM_S.LAST_CYCLE_TIME_100US;			
	IF aSys.PULSE_BEEP THEN
		IF aSys.et_PULSE_BEEP > aSys.mSec THEN
			aSys.et_PULSE_BEEP := aSys.et_PULSE_BEEP - aSys.mSec;
		ELSE
			aSys.PULSE_BEEP 		:= 0;
			aSys.et_PULSE_BEEP 	:= 1000;					
		END_IF;
	ELSIF asys.et_PULSE_BEEP > aSys.mSec THEN
		aSys.et_PULSE_BEEP := aSys.et_PULSE_BEEP - aSys.mSec;
	ELSE
		aSys.PULSE_BEEP		:= 1;
		aSys.et_PULSE_BEEP	:= 200;
	END_IF;

	IF aSys.et50 >= 500 THEN
		aSys.et50			:= 0;
		aSys.u50ms			:= 1;
		aSys.PULSE_50MS 	:= NOT aSys.PULSE_50MS;
	ELSE
		aSys.u50ms			:= 0;
	END_IF;
	aSys.et100		:= aSys.et100 + SYSTEM_S.LAST_CYCLE_TIME_100US;			
	IF aSys.et100 >= 1000 THEN
		aSys.et100			:= 0;
		aSys.PULSE_100MS	:= NOT aSys.PULSE_100MS;
   	aSys.u100ms    	:= 1;
	ELSE
   	aSys.u100ms    := 0;
	END_IF;
	aSys.et200		:= aSys.et200 + SYSTEM_S.LAST_CYCLE_TIME_100US;			
	IF aSys.et200 >= 1900 THEN
		aSys.et200			:= 0;
		aSys.PULSE_200MS 	:= NOT aSys.PULSE_200MS;
	END_IF;
	// USINT
	aSys.n1Min     := BOOL_TO_USINT(SYSTEM_S.F_EDGE_1MIN);           // kazdu 1.Min bude = 1
	aSys.n100ms    := BOOL_TO_USINT(SYSTEM_S.F_EDGE_100MS);     //;
	aSys.n50ms     := BOOL_TO_USINT(SYSTEM_S.R_EDGE_100MS OR SYSTEM_S.F_EDGE_100MS);     //;
	// UINT
	aSys.u1Min     := BOOL_TO_UINT(SYSTEM_S.F_EDGE_1MIN);           // kazdu 1.Min bude = 1
  	aSys.i1Min     := USINT_TO_INT(aSys.n1Min);           			// MIN	: INT
	// 1. sec	
	IF SYSTEM_S.F_EDGE_1SEC THEN
   	aSys.n1Sec     := 1;           								// SEC	: USINT
  		aSys.u1Sec     := 1;           								// SEC	: UINT
	ELSE
   	aSys.n1Sec     := 0;           
  		aSys.u1Sec     := 0;           
	END_IF;
	aSys.cyc     		:= NOT aSys.Cyc;							// kazdy cyklus sa prepne
	aSys.RestCyc   	:= aSys.RestCyc + 1;



	CASE aSys.ini OF
       0:	// riadna prevadzka
			// sekvencia 3 cyklov za sebou po prechode na novu minutu, alebo natvrdo zadanim aSys.RefCycNew := true
			// 1 -> 2 -> 3 ->  0
			CASE aSys.RefCyc OF
				0:  IF aSys.RefCycNew THEN										// je zaradena nova poziadavka na restart sekvencie - zacne az ked skonci predchadzajuca sekvencia
						aSys.RefCyc		:=	1;
						aSys.RefCycNew	:= false;
					END_IF;
				3:	// obehlo 3x
					aSys.RefCyc	:=	0;						
			ELSE			
					aSys.RefCyc := aSys.RefCyc + 1;                 // rucne sa moze nastartovat hocikde v programe na (1), tu sa prida na (2)
			END_CASE;
(*
               Paradox( chan_code := CH5_uni, par_system_data := paradox_data,
                         max_zone_count  := paradox_max_zone_count);
               aSys.ExtPSN := Paradox.com_ok;
*)

(*)
            IF SYSTEM_S.F_EDGE_1DAY OR aSys.Restart THEN                   // novy den
					aSys.RefCyc	:=	1;														// v dalsom cykle nastartuje TypDay
	  				aMeteo.SunriseTime := SunTime( direction := Sunrise, zenith := Zenith_Official,
   		                       longitude := xGlb^.cx.longitude, latitude := xGlb^.cx.latitude,
      		                    utcOffset := UtcOffset_CR(), actDate := aSys.NhDate);
				  	aMeteo.SunsetTime := SunTime( direction := Sunset, zenith := Zenith_Official,
			   		             longitude := xGlb^.cx.longitude, latitude := xGlb^.cx.latitude,
               		          utcOffset := UtcOffset_CR(), actDate := aSys.NhDate);
					xHom^.ok.ref := true;
				ELSIF SYSTEM_S.F_EDGE_1MIN  THEN												// nastartuje 1.cyklus  - ma prednost pred vsetkym
					aSys.RefCyc	:=	1;                                  				// prvy cyklus kde sa skutocne zacne robit ma cislo  2, 3-4-5
					_NhSysUpd(fDbx:=true, file:=1);                                // Mem->RBx, ked bude file > 10 aj RBx->file
				ELSIF aSys.RefCyc	= 0 THEN                         	
					IF aSys.RefCycNew THEN										// je zaradena nova poziadavka na restart sekvencie - zacne az ked skonci predchadzajuca sekvencia
						aSys.RefCyc		:=	1;
						aSys.RefCycNew	:= false;
					END_IF;
				ELSIF aSys.RefCyc	> 3 THEN                         	// pocita 4 cyklov za sebou od prechodu  [2..6]
					aSys.RefCyc	:=	0;			
				ELSE
					aSys.RefCyc := aSys.RefCyc + 1;                 // rucne sa moze nastartovat hocikde v programe na (1), tu sa prida na (2)
				END_IF;
*)
            { $ IFDEF __NH_WEB }
               fbWebControl();
            { $ END_IF }                      // zobrazenie nastavenych DEV - za DEV. Ak sa nieco prestavi vo web v dalej otocke sa to prejavi v DEV
            { $ IFDEF __NH_WRK }
               _NhDataWrk();
			{ $ END_IF }

         _NhDevControl();           // fyzicke nastavenie DEV, malo buy byt prve
			fbNotify();
			fbWebPush();
            
			aSys.F_EDGE_1MIN		:= FALSE;		// vynuluje sa edge
			aSys.F_EDGE_1HOUR		:= FALSE;		// vynuluje sa edge			
			aSys.F_EDGE_1DAY		:= FALSE;		// vynuluje sa edge			
			aSys.F_EDGE_1MON		:= FALSE;		// vynuluje sa edge
			aSys.F_EDGE_1YEAR		:= FALSE;		// vynuluje sa edge
			aSys.Restart  			:= false;                     						// vynuluje sa restart, ale az ked sa prebehu prvykrat vsetky DEV


     	10:    ;  // nic
            rb             := _NhSysLogMsg(msg:='Check data: _Nh_DEV_RESTART');
		     	_Nh_DEV_RESTART();
            rb       		:= _NhSysLogMsg(eRowAfter:=1,msg:='*** KONIEC RESTARTU ***');
            _NhCloseAllFiles();
            aSys.ini       := 0;
	
		11:	// vytvori HET
				fbCrHet();
				IF aSys.ini = 0 THEN
//			      fbCrDir.go		:= -2000;
      		END_IF;
				



(*
     	49:    // este raz pootvarat vsetky subory
				_NhCloseAllFiles();
//				aSys.OpenFilesCount := OpenFilesCount();
      		aSys.ini    := 10;

*)
(*
            IF fbCrDir.Done THEN
               yTx2     	:= 'UKONCENE vytvaranie LOG adresarov [49]';
               rb       	:= _Nh1RowTxt(logRst:=1);
	            aSys.ini    := 10;
            END_IF;
            fbCrDir();
*)
     	40:    // Upload program
				yTx2           := CONCAT('start LoadNewPackage2:',yTx4);
            rb             := _Nh1RowTxt(logRst := 1, adTime:=3, EmpRow:=1);
				ok 				:= LoadNewPackage2( rq := true, pckg := yTx4);
            yTx2           := CONCAT('End LoadNewPackage2:',BOOL_TO_STRINGF(ok,'%b{Yes^No}' ));
            rb             := _Nh1RowTxt(logRst := 1, adTime:=3);
				aSys.ini			:= 0;	
     	

     	50:    // upravena ram do DBX
            _Nh_Go_MemToDBX();
            yTx2  := 'Na zaver upravena  RAM->DBX';
            rb             := _Nh1RowTxt(logRst := 1);
				aSys.ini       := 10;

		100:	// ulozit RAM do DBX a spustit zalohovanie dobrej DBX na SDC
            _NhWrkRam();                  // adresy WRK ram za poslednymi datami
            aSys.ini       := 50;



   	180:    // export VAZ[1..4]
				cf 		:= 1;
				nd			:= 1;
				_NhxVaz(cv:=cf,nd:=nd);
           	aSys.ini := 181;
   	181:    //
		    	IF _Nh_Vaz_LOG_CV() THEN
					cf 		:= 2;
					nd			:= 1;
					_NhxVaz(cv:=cf,nd:=nd);
	            aSys.ini       := 182;
		    	END_IF;
   	182:    //
		    	IF _Nh_Vaz_LOG_CV() THEN
					cf 		:= 3;
					nd			:= 1;
					_NhxVaz(cv:=cf,nd:=nd);
	            aSys.ini       := 183;
		    	END_IF;
   	183:    //
		    	IF _Nh_Vaz_LOG_CV() THEN
					cf 		:= 4;
					nd			:= 1;
					_NhxVaz(cv:=cf,nd:=nd);
            aSys.ini       := 184;
//	            aSys.ini       := 100;
		    	END_IF;
   	184:    //
	            aSys.ini       := 100;
		    	IF _Nh_Vaz_LOG_CV() THEN
	            aSys.ini       := 100;
		    	END_IF;

		190:    // skontroluje a prida POI
            _Nh_POI_INI();
(*
				IF _GoExp THEN
           		aSys.ini       := 180;  					
				ELSE
           		aSys.ini       := 100;
				END_IF;	
*)

 aSys.ini := 100;





    	200:    // otestuje vazby a ich parametre
            { $IFDEF __NH_WRK }
               _NhDataWrk();
            { $END_IF }
            _NhIniVAZ();
            aSys.ini := 190;


(*
    	210:    // skontroluje konzistenciu ROM,SBJ ....., nastartuje parametre
            _Nh_Ini_DEV_Test();
           	aSys.ini       := 213;
*)

    	213:    // otestuju sa postupne vsetky CFG prida parametre k DEV
            _Nh_Ini_PAR_Test();

    	214:    // koniec testu parametrov
            aSys.ini := 200;


(*
	 	215:    // z Nh2.ADR vytvori/aktuaizuje MIESTNOSTI a DEV, alebo len aktualizuje HW-adresy
         { $IFDEF __NH_EXP }
            fb_Nh_EXP_ALL();
         { $ ELSE  } 	
            aSys.Ini := 210;
         { $ END_IF  } 	
*)

    	217:    // len pre testovanie,
// _NhIsObrOk(frm:=260);

            { $IFDEF __NH_WRK }
               _NhDataWrk();

            { $END_IF }

////***********************

    	220:    // dorobi default vety + CAT,USR,FAV,HET ...,
            _Nh_Ini_DEFAUL_CFG();    							// dorobi default data					

//				aSys.ini := 217;
//RETURN;


            aSys.CfgRamOk  := true;
            _Nh_Go_MemToDBX();                           // ulozi aktualnu RAM do DBX
				aSys.ini := 222;

	 	222:    // START Import dev+HW address CIB
				yTx2 		:= 'START Import CIB';
				_Nh1RowTxt(logRst:=1); //,EmpRow:=1);
				fb_Nh_Import_CIB(Go:=1);
            { $IFDEF __NH_WRK }
               _NhDataWrk();
            { $END_IF }
				aSys.Ini 		:= 223;
	 	223:    // Running Import CIB
            fb_Nh_Import_CIB();
				IF fb_Nh_Import_CIB.err THEN				
					aSys.Ini 	:= 217;
				ELSIF fb_Nh_Import_CIB.done THEN
					yTx2 	:= 'END Import CIB';
					_Nh1RowTxt(logRst:=1);
					aSys.Ini 	:= 225;
   			END_IF;

    	225:    // skontroluje konzistenciu ROM,SBJ ....., nastartuje parametre



            _Nh_Ini_DEV_Test();
				aSys.exp			:= 0;
           	aSys.ini       := 213;

    	229:    // Err section 22x
				;

(*	RESTART
	250		skontroluje DBx,RBx
				_Nh_CUST_RESTART()
	251		_Nh_Create_DIR(Go:=1)
	240-242	fb_Nh_Create_FRM	COPY NH2/200/FRM/*.* -> RAM/FRM/			
	230		zisti ci mame MEM niekde zalohovanu v poradi
				1.RBx .. _NhIsDBxCfgOk(RBx:=true)
				2.File   aSys.CfgBckOk {oznaci_NhIsDBxCfgOk() }
				3.DBx	   _NhIsDBxCfgOk(), ak sa najde prekopiruje sa do RBx: DBx->RBx
	231-232	Load&Convert Old CFG->Mem (z: RBx alebo DBx)
	220		_Nh_Ini_DEFAUL_CFG() - dorobi default data
	222-223	fb_Nh_Import_CIB() :	Import dev+HW address CIB
	225		_Nh_Ini_DEV_Test()	- zakladne testy konzistencie
	213-214 	_Nh_Ini_PAR_Test();	- testy PAR + prida nove PAR
	200		_NhIniVAZ(); 			- konzistenia vazieb
	190		_Nh_POI_INI();      	- skontroluje a prida POI
	100-50	 _Nh_Go_MemToDBX(); 	- 'Na zaver upravena  RAM->DBX';
	10			_Nh_DEV_RESTART(),_NhCloseAllFiles();	- pozatvara vsetky subory na SDC a otvori _NhLangTxt
*)            			
		

	 	230:    // find CFG (aMem) in RamBox/DataBox/SDC, then copy to RamBox and then RBx->Mem
			 	IF aSys.NewDBX THEN
					aSys.CfgBckOk	:=	false;
					aSys.UseRBx	   := aSys.IS_RBx;
					rb:=_NhSysLogMsg(msg:='NEW Cfg requested !');
					aSys.Ini			:= 220;
				ELSE
					fb_Nh_Cfg_Backup.IniEnd:=230; fb_Nh_Cfg_Backup.IniErr:=239; fb_Nh_Cfg_Backup.IniRun:=255;	// predbezne
					IF aSys.IS_RBx  THEN																			// from RamBox
						IF _NhIsDBxCfgOk(RBx:=true) THEN                      						// v RBx je obraz mem
    						yTx2  		:= '->RamBOX OK.';
							aSys.UseRBx	:= true;
							aSys.Ini 	:= 231;				
						ELSIF aSys.CfgBckOk THEN      															// na zaciatku je 0, potom nastavi
    						yTx2  			:= '...No-RBx,but File.Ok.{File->RBx}';
							fb_Nh_Cfg_Backup.Go		:= 12; 																		// file->RAM, next back here
						ELSIF _NhIsDBxCfgOk(RBx:=false) THEN                      					// v DBX je obraz mem
    						yTx2  		:= '..DBX-Ok.{DBX->File}';						
							fb_Nh_Cfg_Backup.Go	:= 3;	   																// DBX->File
						ELSE
   	 					yTx2  			:= '...No RBx/DBx/File -> {Go empty: NewDBX=true}';						
							aSys.NewDBX    := true;
						END_IF;
  					ELSIF aSys.CfgBckOk THEN																	// after
  						yTx2  := '...CPU has no RamBox,but File from DBx.Ok.{now File->Mem}';
						fb_Nh_Cfg_Backup.Go:=11; fb_Nh_Cfg_Backup.IniEnd:=220;												// file->Mem
						aSys.UseRBx	:= false;
					ELSIF _NhIsDBxCfgOk(RBx:=false) THEN                      						// v DBX je obraz mem
  						yTx2  		:= '..CPU has no RamBox,but DBX-Ok.{DBX->File}';						
						fb_Nh_Cfg_Backup.Go	:= 3;	   																	// DBX->File, next back here
						aSys.UseRBx	:= true;
					ELSE
						yTx2 			:= 'CPU has no RamBox, and NOT DBX. {Go empty: NewDBX=true}';
						aSys.NewDBX := true;
					END_IF;
					rb:=_NhSysLogMsg(msg:=yTx2);
				END_IF;					
//				aSys.Ini := 226;


	 	231:    // START 1.Import CFG DBX->Mem
				yTx2 		:= CONCAT('START Load & Convert Old CFG: ',BOOL_TO_STRINGF(aSys.UseRBx,'%b{Rbx^DBX}'),'->Mem.',BOOL_TO_STRINGF(xDbx^.FromDBx128,' DBx128: %b{Y^N}') );
				_Nh1RowTxt(logRst:=1); //,EmpRow:=1);
	         fb_Nh_Cfg_Restart(init:=1, wh:=0, cx:=1);
				aSys.Ini 		:= 232;

	 	232:    // Running Load Old CFG
            fb_Nh_Cfg_Restart();
				IF fb_Nh_Cfg_Restart.done THEN
					yTx2 	:= 'END Load Old CFG';
					_Nh1RowTxt(logRst:=1);
					aSys.Ini 	:= 220;
   			END_IF;

		238:    ;	//Error section 230
		239:    ;	//Error section 230
				;



	 	240:    // aktualne formulare -> NH2/200/FRM
            { $ IFDEF __NH_FRM }
					IF fb_Nh_Create_FRM.done THEN
						yTx2 		:= 'OK. New FRM';
  		 				rb 		:= _Nh1RowTxt(logRst := 1);
		            aSys.ini := 241;
					ELSIF fb_Nh_Create_FRM.busy THEN ;
					ELSE 	fb_Nh_Create_FRM(Go:=1,all:=true);
					END_IF;
					fb_Nh_Create_FRM();
            { $ ELSE }
					aSys.ini := 241;
            { $ END_IF }

		241:    // COPY NH2/200/FRM/*.* -> RAM/FRM/
            	IF aSys.DiskHed.Disk[4].Exist THEN												// RAM exist, go copy
   					_Nh_Log_Path(wh:=24, frm:=1, wh2:=1);                                  // yTx3,yTx4
	     				yTx2 		:= CONCAT('START Copy {',yTx3,'}->{',yTx4,'}');													// START Create Dir
               	rb      	:= _Nh1RowTxt(logRst := 1);
               	fb_Nh_Copy_Dir(init:=TRUE,Go:= 2,IniRun:=255,IniEnd:=242,IniErr:=249);
            	ELSE
               	aSys.Ini := 230;
            	END_IF;
	 	242:    // End Copy
				yTx2		:= CONCAT('END   Copy  f: ',UINT_TO_STRING(fb_Nh_Copy_Dir.files),' s: ',UDINT_TO_STRING(fb_Nh_Copy_Dir.allSize) )  ;
    			rb			:= _Nh1RowTxt(logRst := 1);
      		aSys.Ini := 230;
	 	249: 	// Err Copy Dir
				;
	 	250: 	// restart
  				//          aSys.prgChange    		:= PROGRAMISCHANGED();
				rb:=_NhCloseAllFiles();                                         	
				IF CPU_CODE >= 2000 THEN
					rb 					:= ResizeRamBox( newSize := 16*1024);   	// 16MB*1024 = 16384 kByte
					aSys.Size_RBx 		:= UINT_TO_UDINT( SizeOfRamBox() ) * 1024;   							// 128 kb   (128*1024=131072 Byte)
					aSys.IS_RBx			:= aSys.Size_RBx >= 16777216;
				ELSE
					aSys.IS_RBx			:= false;
					aSys.Size_RBx 		:= 0;
//					yTx1					:= 'WWW/LOGS/';
			  	END_IF;
//				yTx1		:= 'WWW/NH2/';
//				rb:=DirCreate( dirName := yTx1 );																	// create default LOG adr
				aSys.Restart     		:= TRUE;
				aSys.RefCyc				:=	1;
//				aSys.rst.In				:= true;
				aSys.CfgBckOk			:=	FALSE;																	// flag, that BckFile no-Exiat
				aSys.Size_DBx 			:= UINT_TO_UDINT( SizeOfDataBox()) * 1024;   								// 128 kb   (128*1024=131072 Byte)
				aSys.IS_DBX				:= aSys.Size_DBx >= 131072;


//				aSys.DiskHed.USB_Ready.In	:= SYSTEM_S.USB_DISK_READY;									// vynuluje sa flag USB ready	
//				aSys.DiskHed.USB_Ready.Q	:= SYSTEM_S.USB_DISK_READY;									// vynuluje sa flag USB ready	

				aDbx.aCfx[0]   := _cfg0;
		   	aDbx.aCfx[1]   := _par0;
	   		aDbx.aCfx[2]   := _vaz0;
		   	aDbx.vRam   	:= _Ram0;                                                         // volna ram
	      	_NheRAM();                                                                    // vymaze virtualnu RAM od vRam (za CFG/PAR/VAZ...
		   	FOR i := 2  TO _Nh_Cfg DO                                                     // offset default Empty vety
    				aCfg[i].ofs   := aCfg[i-1].ofs + aCfg[i-1].siz;
	   		END_FOR;
     			FOR i := 2  TO _Nh_Par DO                                                     // offset default Empty vety
     				aPar[i].ofs   := aPar[i-1].ofs + aPar[i-1].siz ;
     			END_FOR;
				RandomU(seed := _NhSeed, init:=true);
			  	
//				rb	:= SetValueToRamBox(ramBoxAddress:=0, length:=_NH_RAM, value := 0);

//				_Nh_CUST_RESTART();                          											// nejake vlasne veci po restarte

				IF IS_COLD_RESTART_PLC 		THEN	yTx0:='COLD';
				ELSIF IS_HOT_RESTART_PLC   THEN  yTx0:='HOT';
				ELSIF IS_RESTART_PLC       THEN  yTx0:='RST';
				ELSE 						      	   yTx0:='UNKNOWN';
				END_IF;

				SYSTEM_S.F_EDGE_1DAY 	:= true;												// simulate new day for refresh day in room/het	
            aSys.Ini 					:= 251;


    	251: 	// 2.cyc After restart - create dir OK

				rb:=_NhSysLogMsg(write:=0,eRowBefore:=1,msg:=' *** '+yTx0+' RESTART ***   DBx: '+UINT_TO_STRING(SizeOfDataBox())+' kB, RBx: '+UINT_TO_STRING( SizeOfRamBox() )+BOOL_TO_STRINGF(SYSTEM_S.USB_DISK_READY, ' kB; USB:%b{Y^N}')+'   *** ');				rb:=_NhSysLogMsg(eRowAfter:=1,NoTime:=1,msg:=DT_TO_STRINGF(_NhLastPowerOffState.LastDt, '%TYY.MM.DD-hh:mm:ss.zzz ') +',Ini:='+USINT_TO_STRING(_NhLastPowerOffState.ini) );
//				_Nh_Log_Dbx_ADD(ev:='AL1',src:='PIR',key:='Pir-1',val:='On',subj:=1,rom:=101);
            aSys.Ini 				:= 241;

//            aSys.Ini 				:= 255;

	 	252:    // test
            ;
		254:    // Error
            ;
		255:    // running more like one cycle, block all function except fb_ ....
            ;
	END_CASE;

	// time events - change progtam date
	IF SYSTEM_S.F_EDGE_1DAY  THEN				   											// novy den
		aSys.F_EDGE_1DAY	:= true;														// NH event	
		aSys.F_EDGE_1MON 	:= aSys.MONTH 	<> SYSTEM_S.COUNTER_MONTHS;												// NH event		
		aSys.F_EDGE_1YEAR	:= aSys.YEAR 	<> SYSTEM_S.COUNTER_YEARS;
		aSys.YEAR 			:= SYSTEM_S.COUNTER_YEARS;								// Nh month
		aSys.MONTH 			:= SYSTEM_S.COUNTER_MONTHS;							//	Nh month
		aSys.DAY				:= SYSTEM_S.COUNTER_DAYS_OF_MONTH;					// Nh month
		aSys.RefCycNew		:= true;														// v dalsom cykle nastartuje TypDay
		aSys.YYYY_MM		:= CONCAT(USINT_TO_STRINGF(aSys.YEAR, '20%02d'),'_',USINT_TO_STRINGF(aSys.MONTH, '%02d'),'/');
		fb_Nh_Create_DIR.exec	:= aSys.F_EDGE_1MON ;							// vytvori nove adresare pre novy mesiac
	ELSIF  SYSTEM_S.F_EDGE_1MIN  THEN                   									// new min
		aSys.F_EDGE_1MIN			:= true;												// NH event		
		aSys.F_EDGE_1HOUR			:= SYSTEM_S.F_EDGE_1MIN;						// NH event		
		aSys.RefCycNew				:= true;												// v dalsom cykle nastartuje TypDay
		// after xxx seconds of error-free operation, make a CFG backup
	ELSIF aSys.RestartBck = false THEN										// este nebol urobeny backup po restarte		
		IF  aSys.ini = 0 AND SYSTEM_S.COUNTER_1SEC > 4 THEN     						// 1min after restart, create backup file
			IF _NhSysUpd(fFile:=true) THEN												// Mem->RBx, ked bude file > 10 aj RBx->file
				aSys.RestartBck 	:= true;
			END_IF;
		END_IF
	END_IF;

	fb_Nh_Create_DIR();												// test and create directories
	fb_Nh_Cfg_Backup();      	// save from mRam[] to file, or restore to mRam[] from file
	fb_Nh_Copy_Dir();
//	fb_Nh_Log_DBX_RW();		// write log to buffer (DBx,RBx) and read from buffer and send datagram to Pi or Write to USB/LOG
//	fb_Nh_PLC_DIR();
	
	_NhLastPowerOffState.LastDt	:= aSys.NhDT;
	_NhLastPowerOffState.ini 	:= aSys.ini;
//	_NhLastStateON.ini 		:= aSys.ini;
	
END_PROGRAM

