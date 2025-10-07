{ $ IFNDEF _Nh_CUST_RESTART } 	                 // ak nie je definovana funkcia v uzivatelskom subore, vytvori sa pre
   FUNCTION _Nh_CUST_RESTART  {HIDDEN} : BOOL
		;
   END_FUNCTION
{ $ END_IF } 	

VAR_GLOBAL
  		fbImpCIB				: 	_Nh_Import_CIB;
		fbCfgRST				: 	_Nh_Cfg_Restart;
		fb_Nh_Create_DIR		: 	_Nh_Create_DIR_FB;
END_VAR

	
PROGRAM prgMain
   VAR
   	fbCrHet			: _Nh_Create_HET;

      { $ IFDEF __NH_WEB }
         fbWebControl   : _NhWebControl;
      { $ END_IF  } 	
		ok				: BOOL;
//    	notification 	: TWebPushNotif;
//    	webPush      	: fbWebPushService;

// 		DeleteFiles    : DeleteSurplusFiles := (delEmptyDir:=true );
//		DeleteFilesLog : DeleteSurplusFilesLog;

// 		DeleteFiles    : DeleteOldFiles := 		(delEmptyDir:=true, lifeTime := 0, fileMask:='*' );
//		DeleteFilesLog : DeleteOldFilesLog:=(logName := aSys.DiskInfo[1].path + 'del.log');
		DeleteFilesLog : DeleteOldFilesLog;

   END_VAR
   rb 						:= 1;
	aSys.NhTime    		:= GetTime();
   aSys.NhDate    		:= GetDate();
   aSys.NhDT      		:= GetDateTime();						// skoro strojovy cas zaciatku cyklu, ked sa uz zapli vsetky vystupy
   aSys.LogHed.logTime  := TIME_TO_STRINGF(aSys.NhTime,'%Thh:mm:ss.zz');
   aSys.LogHed.logDate  := DATE_TO_STRINGF(aSys.NhDate,'%TYY-MM-DD');

	aSys.RWtoFileCycle	:= 0;


	// 1   SEC 	=  10000 SYSTEM_S.LAST_CYCLE_TIME_100US      1.0 * 10 000
	// 0,7 SEC 	=  7000 SYSTEM_S.LAST_CYCLE_TIME_100US	   	0.7 * 10 000
	// 0.001    =    10
   aSys.dMin      := USINT_TO_INT(SYSTEM_S.COUNTER_HOURS) * 60 + USINT_TO_INT(SYSTEM_S.COUNTER_MINUTES);  // pocet minut v ramci dna
	aSys.rSec	   := UINT_TO_REAL( SYSTEM_S.LAST_CYCLE_TIME_100US) /10.0 ;		// REAL: doba minuleho cyklu v mS (prevod zo 100 mikrosekund)							
	aSys.mSec		:= REAL_TO_UINT( ROUND(  aSys.rSec ) );			            // UINT: doba minuleho cyklu v mS  (prevod zo 100 mikrosekund)							
	IF System_S.F_EDGE_10SEC THEN	//System_S.F_EDGE_1MIN OR  System_S.R_EDGE_1MIN THEN				// kazdych 30sec
		aSys.LogHed.Quite10Sec := aSys.LogHed.Quite10Sec + 1;
		IF aSys.LogHed.Quite10Sec > 6 THEN														// ak nebol 1 min zapis, zavrie subor
			rb := _Nh_Log_Evn_ADD(tsk := 255);
		END_IF;
		aSys.mSecMax			:= 0;
	END_IF;
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
   aSys.i1Sec     := USINT_TO_INT(aSys.n1Sec);                     // kazdu 1.Sec bude = 1

	aSys.RestCyc   := aSys.RestCyc + 1;

	// INT
   aSys.i1Min     := USINT_TO_INT(aSys.n1Min);           // kazdu 1.Min bude = 1
   aSys.rTime     := TIME_TO_REAL(aSys.NhTime);

   aSys.cyc     	:= NOT aSys.Cyc;


	// 1. sec	
	IF SYSTEM_S.F_EDGE_1SEC THEN
   	aSys.n1Sec     := 1;           // kazdu 1.sec bude = 1	
   	aSys.u1Sec     := 1;           // kazdu 1.sec bude = 1
	ELSE
   	aSys.n1Sec     := 0;           // kazdu 1.sec bude = 1	
   	aSys.u1Sec     := 0;           // kazdu 1.sec bude = 1
	END_IF;


	fb_Nh_Create_DIR();												// test and create directories


   CASE aSys.ini OF
       0:    // riadna prevadzka
				// sekvencia 3 cyklov za sebou po prechode na novu minutu, alebo natvrdo zadanim aSys.RefCycNew := true
				// 1 -> 2 -> 3 ->  0

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

            { $ IFDEF __NH_WEB }
               fbWebControl();
            { $ END_IF }                      // zobrazenie nastavenych DEV - za DEV. Ak sa nieco prestavi vo web v dalej otocke sa to prejavi v DEV
            { $ IFDEF __NH_WRK }
               _NhDataWrk();
				{ $ END_IF }

            _NhDevControl();           // fyzicke nastavenie DEV, malo buy byt prve

				fbNotify();
				fbWebPush();
            aSys.Restart   := false;                     						// vynuluje sa restart, ale az ked sa prebehu prvykrat vsetky DEV

				IF aSys.RestartBck = false THEN										// este nebol urobeny backup po restarte		
					IF  SUB_DT_DT(aSys.NhDT,aSys.LastRstDT) > T#1m THEN     // 1min after restart, create backup file
						aSys.RestartBck 	:= true;
						_NhSysUpd(fFile:=true);
					END_IF;
				END_IF;

//				yTx2 := 'MSG;23.08.25;13:45:51; 1;       err;13:45:51;pohyb sss,dddd,ssss,sssssss';
//    			rb		:= _Nh1RowTxt(logRst := 1);





				// check file space and delete old files if space > ...

(*
				yTx2 := CONCAT('a ',
									BOOL_TO_STRINGF(rqDelete,'%b{Y^N} '),	
									BOOL_TO_STRINGF(DeleteFiles.exec,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.busy,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.done,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.err ,'%b{Y^N} ') );
				_Nh1RowTxt(logRst:=1);
*)

//				DeleteFiles(exec := aSys.DiskHed.exec);
//				DeleteFilesLog( append := 1, fbDeleteOldFiles := DeleteFiles);				

//	fbDskMan.disk[1].Ready := true;

(*
				yTx2 := CONCAT('  ',
									BOOL_TO_STRINGF(rqDelete,'%b{Y^N} '),					
									BOOL_TO_STRINGF(DeleteFiles.exec,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.busy,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.done,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.err ,'%b{Y^N} ') );
				_Nh1RowTxt(logRst:=1);
*)
(*
				IF aSys.DiskHed.Run THEN

 					IF DeleteFiles.done OR DeleteFiles.err THEN
						i										:= aSys.DiskHed.i;
						aSys.DiskHed.Exec 				:= false;							// exec -> reset fb
						aSys.DiskHed.Disk[i].Clear 	:= false;
						aSys.DiskHed.Disk[i].busy 		:= false;
						aSys.DiskHed.Disk[i].done 		:= true;
						_Nh_Create_DIR(go:=0);

						yTx2 := CONCAT('   ',
									DeleteFiles.dirName, ' ', DeleteFiles.fileMask, ' ',
									UDINT_TO_STRINGF(DeleteFiles.lifeTime,'%5d '),
									BOOL_TO_STRINGF(aSys.DiskHed.exec,'%b{Y^N} '),					
									BOOL_TO_STRINGF(DeleteFiles.exec,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.busy,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.done,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.err ,'%b{Y^N} ') );
						_Nh1RowTxt(logRst:=1);


 					ELSIF DeleteFiles.busy THEN
						aSys.DiskHed.Disk[aSys.DiskHed.i].cyc 	:= aSys.DiskHed.Disk[aSys.DiskHed.i].cyc + 1;									
					ELSE
							aSys.DiskHed.Exec 	:= false;
							aSys.DiskHed.run		:= false;
							aSys.DiskHed.i 		:= 0;
							
							FOR i := 1  TO 4  DO
				      		IF aSys.DiskHed.Disk[i].Clear AND (aSys.DiskHed.Disk[i].done = false  OR DeleteFiles.lifeTime >= 7) THEN
									aSys.DiskHed.i					:= i;
									aSys.DiskHed.run				:= true;
									aSys.DiskHed.Exec 			:= true;

                           IF aSys.DiskHed.Disk[i].done THEN
										DeleteFiles.lifeTime	:= DeleteFiles.lifeTime / 2;
									ELSE
										DeleteFiles.lifeTime	:= 14;	//2*365;									
                           END_IF;


									aSys.DiskHed.Disk[i].cyc 	:= 0;									
									aSys.DiskHed.Disk[i].busy 	:= true;
									aSys.DiskHed.Disk[i].done 	:= false;


									DeleteFiles.testOnly 		:= true;
									DeleteFiles.dirName			:= aSys.DiskHed.Disk[i].path;
									DeleteFiles.fileMask			:='*';
//									DeleteFilesLog.LogName := aSys.DiskHed.Disk[i].path + DT_TO_STRINGF(aSys.NhDT,'%TMMDDhhmm')+'.log' ;
//									DeleteFilesLog.LogName := aSys.DiskHed.Disk[i].path + 'DEL.LOG' ;

						yTx2 := CONCAT(USINT_TO_STRINGF(i,'%2d '),
									DeleteFiles.dirName, ' ', DeleteFiles.fileMask, ' ',
									UDINT_TO_STRINGF(DeleteFiles.lifeTime,'%5d '),
									BOOL_TO_STRINGF(aSys.DiskHed.exec,'%b{Y^N} '),					
									BOOL_TO_STRINGF(DeleteFiles.exec,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.busy,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.done,'%b{Y^N} '),
									BOOL_TO_STRINGF(DeleteFiles.err ,'%b{Y^N} ') );
						_Nh1RowTxt(logRst:=1);


									EXIT;
				      		END_IF;
                  	END_FOR;			
					END_IF;
				END_IF;

*)

(*
				CASE aSys.DeleteFileMode OF
              0:	// start
						IF SYSTEM_S.COUNTER_SECONDS = 1 THEN
//						IF SYSTEM_S.COUNTER_HOURS = 1 THEN
							_Nh_Create_DIR(Go:=0);

							aSys.r1 := UDINT_TO_REAL(aSys.Size_ROT_DISK.TotalNumberOfFreeKBytes)/ UDINT_TO_REAL(aSys.Size_ROT_DISK.TotalNumberOfKBytes);
							aSys.r2 := UDINT_TO_REAL(aSys.Size_ROT_DISK.TotalNumberOfKBytes) / UDINT_TO_REAL(aSys.Size_ROT_DISK.TotalNumberOfFreeKBytes);


							aSys.DeleteFileMode 		:= 1;
            			DeleteFiles.dirName 			:= 'NH2/';
            			DeleteFiles.fileMask   		:= '*.dbx';					
							DeleteFiles.lifeTime 		:= 14;
							rqDelete	:= true;

						END_IF;
              4:  // koniec
						IF SYSTEM_S.COUNTER_SECONDS > 1 THEN
//						IF SYSTEM_S.COUNTER_HOURS > 1 THEN
							aSys.DeleteFileMode := 0;
						END_IF;
            ELSE
						rqDelete := true;
						IF DeleteFiles.done OR DeleteFiles.err THEN
                  	rqDelete := false;
							aSys.DeleteFileMode	:= aSys.DeleteFileMode + 1;
						ELSIF aSys.DeleteFileMode = 2 THEN
   						DeleteFiles.fileMask := '*.PNG';					
//							rqDelete	:= true;
							aSys.DeleteFileMode := 3;
						ELSIF aSys.DeleteFileMode = 3 THEN
							;
						END_IF;

						DeleteFiles(exec:=rqDelete);
						// log soubor se zaznamy o vymazanych souborech
						DeleteFilesLog( append := 1, fbDeleteOldFiles := DeleteFiles);


            END_CASE;
*)

     	10:    ;  // nic
            yTx2           := 'Check data: _Nh_DEV_RESTART ';
            rb             := _Nh1RowTxt(logRst := 1);
		     	_Nh_DEV_RESTART();
            yTx2           := '*** KONIEC RESTARTU ***';
//            rb             := _Nh1RowTxt(logRst := 1, adTime := 1);
            rb       		:= _Nh1RowTxt(logRst:=1, adTime:=3);
            yTx2           := '';
            rb             := _Nh1RowTxt(logRst := 1);
            _NhCloseAllFiles();
            aSys.ini       := 0;

				yTx1 				:= aSys.DiskHed.Disk[1].path + 'DEL.LOG' ;
				FileDelete(fileName := yTx1);
				DeleteFilesLog.LogName := yTx1;


//				aSys.ClearDisk[0]	:= 1;				

//				DeleteFilesLog.logName 		:= 'WWW/LOGS/DEL_20' + USINT_TO_STRING( System_S.COUNTER_YEARS) + '.LOG';


//            DeleteFiles.dirName 			:= 'WWW/'; //'NH2/';
//            DeleteFiles.fileMask   		:= '*';
//				DeleteFiles.maxSpace   		:= 1024*1024;
//				DeleteFiles.delEmptyDir 	:= true;

//				DeleteFilesLog.logName 		:= 'WWW/LOGS/DEL_20' + USINT_TO_STRING( System_S.COUNTER_YEARS) + '.LOG';
//				DeleteFilesLog.logName 		:= 'NH2/DEL_20' + USINT_TO_STRING( System_S.COUNTER_YEARS) + '.LOG';
	
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
				ok := LoadNewPackage2( rq := true, pckg := yTx4);
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
				fbImpCIB(Go:=1);
            { $IFDEF __NH_WRK }
               _NhDataWrk();
            { $END_IF }
				aSys.Ini 		:= 223;
	 223:    // Running Import CIB
            fbImpCIB();
				IF fbImpCIB.err THEN				
					aSys.Ini 	:= 217;
				ELSIF fbImpCIB.done THEN
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
	240-242	fbCrFRM	COPY NH2/200/FRM/*.* -> RAM/FRM/			
	230		zisti ci mame MEM niekde zalohovanu v poradi
				1.RBx .. _NhIsDBxCfgOk(RBx:=true)
				2.File   aSys.CfgBckOk {oznaci_NhIsDBxCfgOk() }
				3.DBx	   _NhIsDBxCfgOk(), ak sa najde prekopiruje sa do RBx: DBx->RBx
	231-232	Load&Convert Old CFG->Mem (z: RBx alebo DBx)
	220		_Nh_Ini_DEFAUL_CFG() - dorobi default data
	222-223	fbImpCIB() :	Import dev+HW address CIB
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
					yTx2 		      := 'NEW Cfg requested !';
					rb             := _Nh1RowTxt(logRst := 1);
					aSys.Ini			:= 220;
				ELSE
					rmp 				:= 230;																		// default Next
					ok2				:= false;
					IF aSys.IS_RBx  THEN																			// from RamBox
//						rb	:= SetValueToRamBox(ramBoxAddress:=0, length:=aDbx.vRam, value := 0);                         	// clear
//						rb	:= WriteToRBx      (ramBoxAddress:=0, length:=aDbx.vRam, varAddress := PTR_TO_UDINT(ADR(mRam))); // ok
						fbCfgBck.IniEnd:=230; fbCfgBck.IniErr:=239; fbCfgBck.IniRun:=255;	// predbezne
						IF _NhIsDBxCfgOk(RBx:=true) THEN                      						// v RBx je obraz mem
    						yTx2  		:= 'RamBOX OK.';
							aSys.UseRBx	:= true;
							aSys.Ini 	:= 231;				
						ELSIF aSys.CfgBckOk THEN      															// na zaciatku je 0, potom nastavi
    						yTx2  			:= '...No-RBx,but File.Ok.{File->RBx}';
							fbCfgBck.Go		:= 12; 																		// file->RAM, next back here
						ELSIF _NhIsDBxCfgOk(RBx:=false) THEN                      					// v DBX je obraz mem
    						yTx2  		:= '..DBX-Ok.{DBX->File}';						
							fbCfgBck.Go	:= 3;	   																// DBX->File
						ELSE
   	 					yTx2  			:= '...No RBx/DBx/File -> {Go empty: NewDBX=true}';						
							aSys.NewDBX    := true;
						END_IF;
  					ELSIF aSys.CfgBckOk THEN																	// after
  						yTx2  := '...CPU has no RamBox,but File from DBx.Ok.{now File->Mem}';
						fbCfgBck.Go:=11; fbCfgBck.IniEnd:=220;												// file->Mem
						aSys.UseRBx	:= false;
					ELSIF _NhIsDBxCfgOk(RBx:=false) THEN                      						// v DBX je obraz mem
  						yTx2  		:= '..CPU has no RamBox,but DBX-Ok.{DBX->File}';						
						fbCfgBck.Go	:= 3;	   																	// DBX->File, next back here
						aSys.UseRBx	:= true;
					ELSE
						yTx2 			:= 'CPU has no RamBox, and NOT DBX. {Go empty: NewDBX=true}';
						aSys.NewDBX := true;
					END_IF;
					rb 		:= _Nh1RowTxt(logRst := 1);
																							// default Next

(*

					IF ok2 THEN																// hladat v DBx

//						rb:= WriteToDBx( dataBoxAddress := 0, length := aDbx.vRam , varAddress := PTR_TO_UDINT(ADR(mRam))+100 );	// clear
//						rb:= WriteToDBx( dataBoxAddress := 0, length := aDbx.vRam , varAddress := PTR_TO_UDINT(ADR(mRam)) );     // ok

						IF _NhIsDBxCfgOk() THEN											// preberie sa DBX
							IF aSys.IS_RBx THEN
	    						yTx2  := '..DBX-Ok.{DBX->File, next File->RBx}';						
								fbCfgBck(WhatDo:=3, IniEnd:=aSys.Ini, IniErr:=239, IniRun:=255);	
							ELSE
	    						yTx2  := 'DataBOX OK.';						
								aSys.UseRBx	:= false;
							END_IF;
   					ELSIF aSys.CfgBckOk THEN
//						ELSIF Ok1 THEN
   	 					yTx2  		:= '...No-DBX,but SDC-Ok.{SDC->DBX}';											
							fbCfgBck(WhatDo:=13, IniEnd:=aSys.Ini, IniErr := 239, IniRun:=255);	
//							fbCfgBck.WhatDo := 13; fbCfgBck.IniEnd := aSys.Ini; fbCfgBck.IniRun := 255;		// SDC->DataBox, vrati sa sem
						ELSE
							yTx2  := 'No RBx+SDC+DBX => NEW data created';												
							aSys.Ini	:= 220;
						END_IF;
    					rb 	:= _Nh1RowTxt(logRst := 1);
					END_IF;
//					aSys.Ini := 231;
*)
				END_IF;					
//				aSys.Ini := 226;

//aSys.ini := 217;
//RETURN;


	 231:    // START 1.Import CFG DBX->Mem
				yTx2 		:= CONCAT('START Load & Convert Old CFG: ',BOOL_TO_STRINGF(aSys.UseRBx,'%b{Rbx^DBX}'),'->Mem.',BOOL_TO_STRINGF(xDbx^.FromDBx128,' DBx128: %b{Y^N}') );
				_Nh1RowTxt(logRst:=1); //,EmpRow:=1);
	         fbCfgRST(init:=1, wh:=0, cx:=1);
				aSys.Ini 		:= 232;

	 232:    // Running Load Old CFG
            fbCfgRST();
				IF fbCfgRST.done THEN
					yTx2 	:= 'END Load Old CFG';
					_Nh1RowTxt(logRst:=1);
					aSys.Ini 	:= 220;
   			END_IF;

	 239:    //Error section 230
				;



	 240:    // aktualne formulare -> NH2/200/FRM
            { $ IFDEF __NH_FRM }
					IF fbCrFRM.done THEN
						yTx2 		:= 'OK. New FRM';
  		 				rb 		:= _Nh1RowTxt(logRst := 1);
		            aSys.ini := 241;

//		            aSys.ini := 249;
					ELSIF fbCrFRM.busy THEN ;
					ELSE 	fbCrFRM(Go:=1,all:=true);
					END_IF;
					fbCrFRM();
            { $ ELSE }
					aSys.ini := 241;
            { $ END_IF }

	 241:    // COPY NH2/200/FRM/*.* -> RAM/FRM/
            IF aSys.DiskHed.Disk[4].ready THEN
   				_Nh_Log_Path(wh:=5, fN:='FRM');                                  // yTx3,yTx4
	     			yTx2 		:= CONCAT('START Copy {',yTx3,'}->{',yTx4,'}');													// START Create Dir
               rb      	:= _Nh1RowTxt(logRst := 1);
               fbCopyDir(init:=TRUE,Go:= 2,IniRun:=255,IniEnd:=242,IniErr:=249);
            ELSE
               aSys.Ini := 230;
            END_IF;
	 242:    // End Copy
				yTx2	:= CONCAT('END Copy. f: ',UINT_TO_STRING(fbCopyDir.files),' s: ',UDINT_TO_STRING(fbCopyDir.allSize) )  ;
    			rb		:= _Nh1RowTxt(logRst := 1);
      		aSys.Ini := 230;


	 249:    // Error of 240
			;	
	 	250:    // restart
  				//          aSys.prgChange    		:= PROGRAMISCHANGED();


//	 			yTx2 := CONCAT(' *** RESTART: ', USINT_TO_STRING(aSys.LastRstTyp), ' *** ');
				IF CPU_CODE >= 2000 THEN
					rb 				:= ResizeRamBox( newSize := 16*1024);   	// 16MB*1024 = 16384 kByte
					aSys.Size_RBx 	:= UINT_TO_UDINT( SizeOfRamBox() ) * 1024;   							// 128 kb   (128*1024=131072 Byte)
					aSys.IS_RBx		:= aSys.Size_RBx >= 16777216;
				ELSE
					aSys.IS_RBx			:= false;
					aSys.Size_RBx 		:= 0;
					yTx1 					:= 'WWW/LOGS/';
					rb						:= DirCreate(dirName := yTx1);
			  	END_IF;
	 			yTx2 					:= ' *** RESTART  *** ';
				rb						:= _Nh1RowTxt(logRst := 1, adTime := 3, EmpRow := 1, write:=TRUE );

				aSys.Restart      		:= true;
				aSys.RefCyc				:=	1;
				aSys.rst.In				:= true;
            	aSys.LastRstDT   		:= aSys.NhDT;
				aSys.CfgBckOk			:=	false;																	// flag, that BckFile no-Exiat
				aSys.Size_DBx 			:= UINT_TO_UDINT( SizeOfDataBox()) * 1024;   								// 128 kb   (128*1024=131072 Byte)
				aSys.IS_DBX				:= aSys.Size_DBx >= 131072;
				CloseAllFiles();                                         	
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
				aSys.COUNTER_MONTHS := SYSTEM_S.COUNTER_MONTHS;											// aby sa po restarte znovu nespustilo vytvaranie adresarov		

//			  rb	:= SetValueToRamBox(ramBoxAddress:=0, length:=_NH_RAM, value := 0);

				_Nh_CUST_RESTART();                          											// nejake vlasne veci po restarte
				fb_Nh_Create_DIR.exec := TRUE;												// vynuluje sa vytvaranie adresarov
            	aSys.Ini := 251;



    	251:    // Running createc Dir
//            _Nh_Create_DIR(Go:=1);
//				_Nh_Log_Evn_ADD(tsk := 251);
//            aSys.Ini := 240;
	 	252:    // test
            ;
		254:    // Error
            ;
		255:    // block all function except fbNhCrDir(),fbNhCfgfile()
            ;
	END_CASE;


//	fbCfgBck();      	// save from mRam[] to file, or restore to mRam[] from file
//	fbCopyDir();  		// copies/renames a file or the entire contents of a directory


END_PROGRAM

