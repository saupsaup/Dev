
FUNCTION_BLOCK _Nh_Copy_Dir     // copy file or directory
	VAR_INPUT
		go				: USINT;
		IniEnd		: USINT;
		IniErr		: USINT;
		IniRun		: USINT:=255;
		copy			: BOOL:=true;	// copy:=false => delete after copy  (move)
		file			: BOOL:=true ;	// dir or file
      exec        : BOOL;        // leading edge start new write/read. if a process is running, interrupt it and close the file
//      break       : BOOL;      	// immediate termination
		init			: BOOL;			// only open files an prepare for run on the next call
	END_VAR	
   VAR_OUTPUT
      done       	: BOOL;         // action is done
      busy       	: BOOL;         // action in progress
      err        	: BOOL;         // error flag
      errID      	: UDINT;        // error number
      size        : UDINT;        // data length                      {it is entered at the beginning and cannot be changed after that !!!}
      actSize    	: UDINT;        // really written
		cycSize		: UDINT; 		 // actualy Size per cycle
		cyc			: UINT;
		files			: UINT;
		allSize		: UDINT;
		_NhFileInfo	: TFileInfo;
   END_VAR
   VAR
		hDir			: HANDLE;
      hSrc        : HANDLE;
      hDst        : HANDLE;
      hLog        : HANDLE;
	   adrVar      : UDINT;       // adresa: variable/Ram/Dbx address {it is entered at the beginning and cannot be changed after that !!!}
		GoNext		: USINT;		
   END_VAR
	VAR_TEMP
//		fRW			: UDINT;
		fS				: UDINT;
	END_VAR
	done	:= false;
	CASE Go OF
     0 : RETURN;
     1 : // copy file	
			// ytx3,yTx4 contain both source and destination files, including the path
			aSys.Ini	:= IniRun;	
			files		:= 0;
			allSize	:= 0;
			file		:= true;
			IF CPU_CODE >= 2000 THEN
				IF ForceDirs(fileName:=yTx4) = false THEN
					yTx2	:= yTx4;
					Go		:= 80;
					RETURN;
				END_IF;
			END_IF;
			exec		:= true;
			cyc		:= 0;
			GoNext   :=	99;

     2 : // Start copy DIR + first file
			// ytx3,yTx4  contain only the source and destination directories without the file
			aSys.Ini	:= IniRun;	
			files		:= 0;
			allSize	:= 0;
			file		:= false;	
			hDir		:= DirOpen(dirName:=yTx3, dirInfo:=_NhFileInfo);
			IF hDir = INVALID_HANDLE_VALUE THEN
				yTx2	:= yTx3;
				Go		:= 80;
				RETURN;
			ELSIF FileExists(fileName:=yTx4) THEN	;
			ELSIF CPU_CODE >= 2000 THEN
				IF ForceDirs(fileName:=yTx4) = false THEN
					yTx2	:= yTx4;
					Go		:= 80;
					RETURN;
				END_IF;
			ELSIF DirCreate(dirName:=yTx4)  	THEN	;
			ELSE
				yTx2	:= yTx4;
				Go		:= 80;
				RETURN;
			END_IF;	
			exec		:= true;
 			GoNext	:= 12;
			cyc		:= 0;

    12 : // Next file in copy DIR

			IF DirRead(hDir:=hDir, dirInfo:=_NhFileInfo) = false THEN
				rb		:= _Nh_Log_Path(wh:=6);																	// only log DIR {to yTx3}			
				yTx2	:= CONCAT('End of dir. f:',UINT_TO_STRING(files),' s: ',UDINT_TO_STRING(allSize) )  ;
	   		_Nh_Line_RW(mode:=2, fH:=hLog, LineLen:=0);
				Go		:= 99;
				RETURN;
			END_IF;
			exec	:= true;

	  80:	// Error
			err := true;
			IF errID = 0 THEN
	        	errID := GetLastErr();   	
			   GetLastErrTxt(errCode:=errID, errMessage := yTx1);
				yTx2	:= CONCAT('err: ',UDINT_TO_STRING(errID),' msg: ',yTx1,' f: ',yTx2);
			ELSE
				yTx2	:= CONCAT('err: ',UDINT_TO_STRING(errID),' 3: ',yTx3,' 4: ',yTx4);	
			END_IF;
//			IF aSys.Debug AND err THEN
				rb		:= _Nh_Log_Path(wh:=6);															// yTx1 	:= CONCAT(aSys.ADR_RAM,'_CopyDir.log');
				_Nh_Line_RW(mode:=2, fH:=hLog, LineLen:=0);	
//   		END_IF;
			Go := 99;
			RETURN;


	  99:	// End
			rb		:= _NhFClose(fH  := hDir, dir:=TRUE);
     		IF copy = false and err = false THEN
				_Nh_Line_RW(mode:=0, fH:=hLog, LineNbr:=1);	
     			IF file  THEN
					yTx2	:= CONCAT('Delete file: ',yTx2) ;
				ELSE
		   		rb 	:= DirDelete(dirName:=yTx2);
					yTx2	:= CONCAT('Delete dir: ',yTx2) ;
				END_IF;
				_Nh_Line_RW(mode:=2, fH:=hLog, LineLen:=0);
			END_IF;

      	rb    	:= _NhFclose(fH  := hSrc);
      	rb    	:= _NhFclose(fH  := hDst);
      	rb    	:= _NhFclose(fH  := hLog);

			Go 		:= 0;
			GoNext   :=	0;
			Done  	:= true;
			Busy		:= false;
			If err THEN
				aSys.Ini	:= IniErr;
			ELSE
				aSys.Ini	:= IniEnd;
			END_IF;
			RETURN;

	 254: ;// TST
RETURN;

	 255: ;// running;	


	ELSE  // non-defined
			aSys.Ini	:= IniRun;	
			Go 		:= 99;	
			RETURN;
   END_CASE;
   IF exec THEN
		aSys.Ini	:= IniRun;			
		exec 	:= false; done := TRUE; busy := FALSE; err := TRUE; errID := 0; actSize := 0;




		IF Go < 10 THEN																	// start copy file/Dir
			rb		:= _Nh_Log_Path(wh:=6);															// yTx1 	:= CONCAT(aSys.ADR_RAM,'_CopyDir.log');
//   		yTx2:=yTx3;	_Nh_Line_RW(mode:=3, fH:=hLog, new:=TRUE, close:=true);
   		yTx2:=yTx3;	_Nh_Line_RW(mode:=1, fH:=hLog, new:=TRUE, close:=true);
xx:=0;yy:=0;zz:=0;aa:=0;bb:=0;cc:=cc+1;ff:=0;ee:=0;
   		yTx2:=yTx4;	_Nh_Line_RW(mode:=2, fH:=hLog);
		END_IF;


(*
Go		:= 254;
ff:=ff+1;
aSys.ini := 217;
RETURN;
*)

		IF goNext = 12 THEN
   		_Nh_Line_RW(mode:=0, fH:=hLog, LineNbr:=1);	yTx3	:= CONCAT(yTx2,_NhFileInfo.fileName);
   		_Nh_Line_RW(mode:=0, fH:=hLog, LineNbr:=2);	yTx4	:= CONCAT(yTx2,_NhFileInfo.fileName);



//   		yTx2 := CONCAT(UDINT_TO_STRINGF(_NhFileInfo.fileSize,'%5d '), yTx3,' -> ',yTx4);	
//   		_Nh_Line_RW(mode:=2, fH:=hLog, LineLen:=0);
			yTx2	:= CONCAT(_NhFileInfo.fileName,' ',UDINT_TO_STRING(_NhFileInfo.fileSize));
   		_Nh_Line_RW(mode:=2, fH:=hLog, LineLen:=0);
		END_IF;




      IF _NhFopen(fN:=yTx3, fH:=hSrc ,mode:=0) THEN                   	// open source file
			size	:=  FileSize(hFile := hSrc);






			IF _NhFopen(fN:=yTx4,fH:=hDst ,mode:=1)  THEN                	// open dest file
				done 		:= false; busy := TRUE; err := false;
				adrVar 	:= PTR_TO_UDINT(  ADR(mObr) ) ;							// wrk mem used for copy
			ELSE
				errID	:= 900002;			
			END_IF;
		ELSE
			errID	:= 900001;
		END_IF;
		Go 		:= 255;
		IF init THEN																		// only prepare open files/dirs
			init	:= false;
			IF busy THEN 			
				RETURN;																		// if not Err
			END_IF;	
		END_IF;
   END_IF;

   IF busy THEN
cyc:=cyc+1;
		IF aSys.mSecMax > aSys.mSecLimit THEN
			cycSize := 512;
		ELSE
			cycSize := _NH_CLUSTER;	
		END_IF;
		cycSize 	:= MIN(size - actSize, cycSize);
		fRW 		:= FileRead( hFile := hSrc, adrBuf := adrVar, size := cycSize);
		fRW 		:= FileWrite(hFile := hDst, adrBuf := adrVar, size := fRW);
     	actSize 	:= actSize + fRW;                                   // actual read/write size
		IF  actSize = size THEN
        	done := TRUE;
      ELSIF fRW <> cycSize THEN                                        // the request did not proceed correctly
         done 	:= true; err := TRUE; errID	:= 900003;
		END_IF;
	END_IF;
   IF done THEN
      rb    	:= _NhFclose(fH := hSrc);
      rb    	:= _NhFclose(fH := hDst);
		allSize	:= allSize + actSize;
		files		:= files + 1;
      IF err THEN
			GoNext	:= 80;
			files		:= 0;
		ELSIF copy = false THEN
			_Nh_Line_RW(mode:=0, fH:=hLog, LineNbr:=1);	
			IF file = false THEN
				yTx2	:= CONCAT(yTx2,_NhFileInfo.fileName);
			END_IF;
			rb 	:= FileDelete(fileName:=yTx2);
      END_IF
		Go 	:= goNext;
		done	:= false;
   END_IF;
END_FUNCTION_BLOCK

VAR_GLOBAL
	fbCopyDir		: _Nh_Copy_Dir;
END_VAR



VAR_GLOBAL CONSTANT     // konstanty pre WEBMAKER

END_VAR
TYPE
   NH_FRM_HED {HIDDEN}   : STRUCT      				// HLAVNA RIADIACA PREMENNA
      name     : STRING[5] :='_END';
		desc		: STRING[20];
      wht      : USINT;       	// 0=log/230... 1-brw,2-FRM,3-MNU,4- HOME-PG - ALL
		row		: USINT:=1;       // numbrer of Rows
		sld		: USINT;    		// number of sliders
		siz		: UDINT;
	END_STRUCT;
   NH_FRM_SAVE_MAP {HIDDEN}  : STRUCT      				// HLAVNA RIADIACA PREMENNA
      size     : UDINT;
      hed      : NH_FRM_HED;
	END_STRUCT;



  	NH_OBJ_123_CF      :  STRUCT    // prepinac medzi riadkami + vyber volby z 10 textov {2 riadky}
		x			: INT 	:= 95;                     				// x-ova suradnica stredu objektu
		y			: INT 	:= 400;         				            // y-ova suradnica stredu objektu (default pre spodne menu)
      w        : INT 	:= 490;                          // sirka
      h        : INT 	:= 53;                           // vzdialenost medzi riadkami
      hTxt     : INT 	:= 30;                           // vyska textu
		rw1		: USINT 	:= 1;                          // ktorym riadkom sa zacina
      rw2      : USINT 	:= 7;                          // ktorym riadkom konci
      typ      : USINT 	:= 1;                         // typ premennej 1=usint,3=sint
	END_STRUCT;

  	NH_OBJ_123      :  STRUCT    // prepinac medzi riadkami + vyber volby z 10 textov {2 riadky}
      // prvy riadok
      wh       : USINT  := 123;                        //
		cf			: NH_OBJ_123_CF;
      row      : USINT;                              // vybraty riadok
		CMD		: USINT;											// aky CMD je vo vybratom riadku, alebo aky CMD sa hlada v texte
      FgC      : USINT 	:= 2;                         // farba neaktivneho riadku {siva}
      BgC      : USINT 	:= 8;                         // farba aktuvneho riadku {zelena}
      aVar     : UDINT;                               // adresa premennej
      dummy1   : ARRAY[1..6] OF USINT;                // doplnenie do 30
      // bit 29
		Set0		: BOOL;                          // 29
		Set1		: BOOL;
		Set2		: BOOL;
		Set3		: BOOL;
		Set4		: BOOL;
		Set5		: BOOL;
		set6		: BOOL;
      Q        : BOOL;									  // xA^.trg.Q - musi si nulovat objekt	
		// bit 30
      Qr       : BOOL;                            // 29 zaciatok dotyku (tch = true )
      Qf       : BOOL;                            // koniec dotyku (tch = true )
      Qs       : BOOL;                            // koniec dotyku slidera alebo dotyk nad vybratym objektom
      btn      : BOOL;                            // univerzalne pouzitelny btn
      kxy      : BOOL;                            // priznak, ze uz bolavykonana korekcia xy suradnice
      nTch     : BOOL;                            // tento obj sa len zobrazuje,necaka sa dotyk
      prs      : BOOL;                            // nad tymto objektom je povoleny press
      tch      : BOOL;                             // dotyk/press bol na tomto objekte

      // druhy riadok
//		txt      : ARRAY[1..15] OF INT;                  // texty riadkov  vyberu msx 15
		wh2		: USINT;
		dummy		: USINT;
		txt		: NH_PI14;
	END_STRUCT;


   NH_RGB_LVL  {HIDDEN} : STRUCT
      lvl         : ARRAY[1..5] OF USINT  := [255,255,255,0,0];            // parametre pre 3.kanaly R/G/B/WC/WA
   END_STRUCT;


   NH_FAV {HIDDEN} :  STRUCT 					// zoznam oblubenych
 		ok				: NH_REC_OK;
      cf          : NH_CFG_ALL;
      cx          : NH_DEV_IO;                     // FAV c=user,n: -1 dash,-2quick,0=FAV vsetkych, 1.... fav usra
	END_STRUCT;
(*
   NH_CFX_MSG	{HIDDEN} :  STRUCT 		
      nbr         : USINT := 10;                  // pocet sprav
		tme  			: USINT := 60;                   // za casove obdobie
   END_STRUCT;
*)

  	NH_DEV_ALL {HIDDEN} :  STRUCT            	// default pre vsetky DEV - MAXIMALNA konfiguracia
		in				: NH_CMD_ALL;  					// vstupny prikaz
		ou				: NH_CMD_ALL;  					// vystupy prikaz
      sta         : USINT;                      // stav, podla ktoreho za vykresli obrazok s podkladom
		cm				: USINT;
   	et				: UINT;
      Qf          : BOOL;                       // impulz, ked skoncil cas : et
	   trg         : NH_TRIG;
      wsb         : BOOL;                       // priznak, ze cmd prisiel z ovladaca WSB alebo WEB
      vaz         : BOOL;                       // ma nejake in-vazby WSB,PIR,TGL...
      lst         : BOOL;                       // bit8 je nejakom DEV-liste SCN,ACT,....
      up          : BOOL := true;               // bit1 smer stmievania up=hore (po restarte zacina nadol)

      Qx          : BOOL;                       // univerzalne pouzitie - impulz, ked sa dosiahne ukoncenie casu do 0
      dummyEvn    : BOOL;                       // logovat udalost
      Off         : BOOL;                       // priroritne je priznak dlheho vypnutia, inak univerzalne,

      RUN         : USINT;                      // co sa vykona po dobehnuti casu
      ct          : USINT;                      //
      ex          : INT;                        // bezi pomocny cas - vacsinou kontroluje maximalnu dobu zopnutia
      rmp         : USINT;                      // rampa
      el          : USINT;                      // dalsi pomocny cas - zisti sa dlhe vypnutie
//      lvl         : USINT;                      // zapamatana uroven
//      par         : INT;                        // zapamatany parameter
	END_STRUCT;

  	NH_DEV_ALL_M {HIDDEN} :  STRUCT            	// default pre vsetky DEV - MAXIMALNA konfiguracia
		in				: NH_CMD_ALL;  					// vstupny prikaz
		ou				: NH_CMD_ALL;  					// vystupy prikaz
      sta         : USINT;                      // stav, podla ktoreho za vykresli obrazok s podkladom
		cm				: USINT;
   	et				: UINT;
      Qf          : BOOL;                       // impulz, ked skoncil cas : et
	   trg         : NH_TRIG;
      wsb         : BOOL;                       // priznak, ze cmd prisiel z ovladaca WSB alebo WEB
      vaz         : BOOL;                       // ma nejake in-vazby WSB,PIR,TGL...
      lst         : BOOL;                       // je nejakom DEV-liste SCN,ACT,....
      up          : BOOL := true;               // smer stmievania up=hore (po restarte zacina nadol)
	END_STRUCT;


   NH_MSG		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK := ( ok := true);
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL;                  // spolocne pre vsetky DEV  cf+io
//      cx          : NH_CFX_MSG;
	END_STRUCT;



	NH_ARR_OUT  {HIDDEN}: ARRAY[0..3] OF USINT := [  0  , 25  , 50  ,100  ];
  	NH_ARR_VAL  {HIDDEN}: ARRAY[0..3] OF REAL  := [  5.0, 20.0, 23.0, 25.0];

  	NH_POI_DAT {HIDDEN} :  STRUCT                       // struktura pre slider z viacerych casovych pointov - uchovava sa
      t        : INT := -1;                           // casova znacka (pocet   minut dna)
      o        : SINT;                                // co je v tejto casovej znacke  (hodnota/odkaz )
	END_STRUCT;
   NH_POI_OBR {HIDDEN} :  STRUCT 					
      o        : INT;                                 // obrazky k hodnotam
      c        : USINT;                               // color
	END_STRUCT;
  	NH_ARR_POI {HIDDEN} :  STRUCT                       // struktura pre slider z viacerych casovych pointov - uchovava sa
      p        : ARRAY[0..7] OF NH_POI_DAT;
	END_STRUCT;
   NH_POI_FIX	{HIDDEN} :  STRUCT      // kedy vratit na bezny kalendarny den   6 byte
		dummy			: BOOL;
      wht         : USINT;           // sposob kedy 1 = okamzite
      tme         : NH_DT_M;              // datum/cas
	END_STRUCT;
   NH_POI_DAY	{HIDDEN} :  STRUCT         // casovy program kurenia jedneho dna 		
		fff			: BOOl;
      Day         : USINT;                // vybraty den 0=Week, 1-7=(PO-NE),8=,Free,9=Full,10=Out,11=Holi/vynimka)
      Poi         : ARRAY[1..11] OF INT;
//      Fix         : NH_POI_FIX := (wht:=1);                 // zablokuje, aby sa Day kazdu min aktualizoval z Home
	END_STRUCT;

   NH_POI {HIDDEN} 	 :  STRUCT           // casovy program kurenia jedneho dna 		
 		ok          : NH_REC_OK := (ok:=1);
      cx          : NH_ARR_POI :=
                  ( p:= [  ( t :=   0,  o := 2),   // night    0:00
                           ( t := 330,  o := 3),   // morning  5:30
                           ( t := 390,  o := 0),   // day      6:30
                           ( t :=1050,  o := 1),   // evening 17:30
                           ( t :=1440,  o := 1)    // 24:0;
                   ]);
	END_STRUCT;
  	NH_ARR_OBR  {HIDDEN}  :  STRUCT     		// obrazky pre interval v NH_ARR_POI
      o        : ARRAY[0..4] OF NH_POI_OBR
                                          :=  [ ( o := 140, c := 5),   // day
                                                ( o := 142, c := 3),   // evening
                                                ( o := 144, c := 9),   // night
                                                ( o := 146, c := 8)    // morning
                                                ];
	END_STRUCT;
  	NH_POD_CFG  {HIDDEN}  :  STRUCT   // riadiaca struktura pre TIM-slider z viacerych casovych pointov - uchovava sa
      tim      : BOOL := true;                        // vypisanie casu, aj vynasacej ciary
      typ      : USINT;                               // 0=Daymode,1=Heat,2=Ven
      n        : SINT := 7;                           // maximalny pocet pointov = bodov                           ZADAVA sa
      o        : SINT := 3;                           // pocet hodnot/obrazkov vyberanych do jednotlivych pointov  ZADAVA sa
      vo       : NH_ARR_OBR;
      va       : NH_ARR_VAL;
      fm       : STRING[8]   := '';             // format hodnoty (ak jeprazdne, nevypisuje sa)
	END_STRUCT;



   NH_ROM_LCK       {HIDDEN} 	 :  STRUCT 		
      KeyCode     	: BOOL;                      // prisiel dobry kod z Klavesnice
      WebCode     	: BOOL;                      // prislo z webu
		LockRom 			: BOOL := 1;			 		  // tato miestnost/zona bude zamykana
		AllLocked		: BOOL ;			 		  		  // vsetky miestnosti su zalokovane
		FromZone 		: BOOL := 0;			 		  // ZON prepise udaje v ROM, ROM=povoli prepisat
		ChangeStat		: BOOL;							  // impulz pri zmene stavu PSN
		AllLockedOld	: BOOL ;			 		  		  // minuly stav zalokovania vsetkych miestnosti
     	Stat        	: USINT := 0;                // 0=unlock, 1=locking, 2=locked, 3=unlocking, 4=dog, 5=Narusenie, 6=Alarm
      et       		: UINT  ;                    // prebieha nejaky cas podla Lock
      tdOu        	: UINT := 10;	//60;               // odchodove oneskorenie [SEC]
      tdIn        	: UINT := 13;	//30;               // prichodove oneskorenie [SEC]
      tDog       		: UINT := 16;	//60;               // ostrazitost [sec]
      tNar  			: UINT := 30;	//300;              // Cas narusenie
      tRst  			: UINT := 0;	//300;              // Cas autoresetu bez pohybu v LVL - ALARM
		StatOld			: USINT;
		dummy				: STRING[9];
   END_STRUCT;

  	NH_CFX_ROM_LUX  {HIDDEN} :  STRUCT 	
		LuxMin			: USINT:=70;						// minimalna hodnota osvetlenia
		RolMin			: USINT:=80;						// minimalna hodnota zatienenia zaluziami
		KoefBli     	: REAL := 0.0;                // cim viac poklasne osvetleni pod 100%, pouzije sa este neviem ako ake koef
		LuxYes			: BOOL :=1;							// ovplyvneny snimacom 	
		RolYes			: BOOL :=1;							// ovplyvneny snimacom 	
   END_STRUCT;

  	NH_CFX_ROM  {HIDDEN} :  STRUCT 			// CFX MIESTNOSTI
		LuxMin_OLD	: USINT;								// len pre kompatibilitu - minimalna hodnota osvetlenia
      NoBody      : UINT  := 1800;              // pocet SEC, bez pritomnosti (Auto-nepritomnost) = vyhlasi sa klud
      BlPirOFF   	: USINT := 1;                 // cas [min] blokovania PIR po vypnuti vypinacom/z webu 255=do konca dna
      pRzv_OLD    : USINT;                      // odkial zobrat rodicovsky rozvrh: 0-Nema Rodica, 1(255)-Domcek, > 1=konkretna zona
      pDay        : NH_POI_DAY;                 // DayMode
      lck         : NH_ROM_LCK;						// uz aj lock je + string[10]
      FixDay      : NH_POI_FIX := (wht:=1);     // zablokuje, aby sa Day kazdu min aktualizoval z Home

		// nove
		LuxPar		: NH_CFX_ROM_LUX;
      Dark        : BOOL;                       // tma - musi tu byt, lebo porestarte ak je nastavene rucne by sa stratilo
		IniDefault  : BOOL;								// priznak inicializacie
      dummy       : STRING[19];


//      Fix         : NH_POI_FIX := (wht:=1);                 // zablokuje, aby sa Day kazdu min aktualizoval z Home

   END_STRUCT;

(*  posledne
  	NH_CFX_ROM  {HIDDEN} :  STRUCT 			// CFX MIESTNOSTI
		LuxMin		: USINT;								// minimalna hodnota osvetlenia
      NoBody      : UINT  := 1800;              // pocet SEC, bez pritomnosti (Auto-nepritomnost) = vyhlasi sa klud
      BlPirOFF   	: USINT := 1;                 // cas [min] blokovania PIR po vypnuti vypinacom/z webu 255=do konca dna

      pRzv        : USINT;                      // odkial zobrat rodicovsky rozvrh: 0-Nema Rodica, 1(255)-Domcek, > 1=konkretna zona
      pDay        : NH_POI_DAY;                 // DayMode
      lck         : NH_ROM_LCK;

      dummy       : STRING[19];
   END_STRUCT;
*)

   NH_ROM_MEM    {HIDDEN}  	 :  STRUCT 		
		Locked			: BOOL;								// jednoznacne povie ze je zamknute
      BodyQr      	: BOOL;                       // nova pritomnost - impulz
      BodyQ       	: BOOL;                       // pritomnost trva
      PsnQr      		: BOOL;                       // nova pritomnost - impulz
      PsnQ       		: BOOL;                       // pritomnost trva
		Light				: NH_TRIG;							// zapnutie/vypnutie/trvanie osvetlenia
      DayObr      	: SINT;                       // obrazok denneho modo 0,1,2,3 day,evening,night/morning
      BlPirOn   		: USINT := 253;              	// po restarte blokuje pir 254 cyklov
      BlPirOff    	: USINT;                      // bezi cas blokovanie PIR-ov v miestnosti po vypnuti WSB/WEB
		DarkRolLvl		: USINT; 	                  // uroven zatienenia roletami
//		refStat			: USINT;								// LOCK status z minuleho cyklu


//      tNoBody     : UINT;                       // pocet minut zostavajucich do vyhlasenia nepritomnosti
//      tLock       : UINT;                       // cas pre odchod,prichod,strazenie,koniec alarmu vbez pohybu
//      tAlarm      : UINT;                       // pocet minut do prepnutia na vyssi level ALARMU
//		cm				: USINT;								// pomocna prem. pre alarm
//		sta			: USINT;

	END_STRUCT;

   NH_ROM		{HIDDEN} :  STRUCT 		
 		ok          : NH_REC_OK := (ok:=true);
      cf          : NH_CFG_ALL := (typ:=1);
	   al				: NH_DEV_ALL;
//	   al				: NH_ROM_ALL;
      cx          : NH_CFX_ROM;
		io				: ARRAY[100..104] OF NH_VAL_IO; // TER,LUX,CO2,RH
      me          : NH_ROM_MEM;
	END_STRUCT;

  	NH_ZON_PAR 	{HIDDEN}  :  STRUCT 			// PARAMETRE MIESTNOSTI
 		ok				: NH_REC_OK;
		cmd			: USINT := 60;	
	END_STRUCT;

   NH_USR_IP  {HIDDEN} :  STRUCT          // rozsirena CFG = vacsina DEV
      IP          : STRING[16];                 // IP adresa
      x           : REAL := 1.0;
      y           : REAL := 1.13;
	END_STRUCT;

   NH_RFID {HIDDEN} : ARRAY[0..7] OF BYTE;                     // kompletny RFID kod aj 13Mhz

  	NH_USR_CX  {HIDDEN} :  STRUCT 					
      Set         : BOOL := 1;                        // moze ist do rezimu setup
      LastSet     : BOOL;
      LoginHome   : BOOL := 1;                        // pri prihlaseni ist vzdy na HomePage
      DshSet      : BOOL := 0;                        // je v rezime prestavovania DSH v browsoch
      OwnDSH      : BOOL := 1;                        // ma vlastny DSH
      OwnQCK      : BOOL := 1;                        // ma vlastny QuickMenu
      UsrRight    : USINT := 1 ;                      // right = uroven pristupu 0=ziadny 1=user, 2-spravca, 3-admin
      ZonList     : ARRAY[1..16] OF BOOL := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];  // zony, ktore moze user vidiet
      sbj         : USINT := 1;
      lng         : USINT;                            // language 0=SVK,1=ENG
      fav         : NH_DEV_IO:=  (c:= 1, n :=  0);     // default FAV
      dsh         : NH_DEV_IO := (c:= 1, n := -1);    // default DASH
      qck         : NH_DEV_IO := (c:= 1, n := -2);    // default QUICK
      ds1         : NH_DEV_IO := (c:= 1, n := -1);    // 1.DASH
      qc1         : NH_DEV_IO := (c:= 1, n := -2);    // 1.QUICK
      keyPas      : STRING[6];                        // kod z klavesnice
      IPnbr       : USINT := 1;
      IP          : ARRAY[1..3] OF NH_USR_IP ;
      rfid        : NH_RFID;
      mail        : STRING[50];                       // mail
      gsm         : STRING[15];                       // telefonne cislo
      skin        : USINT;                            // 0=svetle farby, 1= tmave farby
      msg         : ARRAY[0..7] OF BOOL;              // spravy, ktore ma dostavat
      Brw         : ARRAY[0..30] OF USINT := [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];  // typ vypisu DASH v browsi :// 0=home page, 1=riadok, 2=velky dash 3x2, 3=maly dsh 6x2

     	rgb			: ARRAY[1..6] OF NH_RGB_LVL :=     		// predvolby RGB
						[	( lvl := [255,255,255,  0,  0]),       // biela
							( lvl := [255,  0,255,  0,  0]),			// fialova
							( lvl := [  0,255,255,  0,  0]),       // azurova
							( lvl := [255,165,  0,  0,  0]),       // oranzova
							( lvl := [ 30, 40,255,  0,  0]),       // dodger blue
							( lvl := [138, 43,226,  0,  0])        // modra fialova
						 ];


//      xxx         : STRING[20];



      // [home,fav,roms,zone,act];

	END_STRUCT;
  	NH_USR {HIDDEN} :  STRUCT 					// categorie
 		ok				: NH_REC_OK  := (ok := true);
      cf          : NH_CFG_ALL := (Name := 'User');                 // cf.rom = uzivatel, cf.typ : -1,-2 Dash,quick, 0=FAV all, 1... cislo FAV usra
		cx				: NH_USR_CX;
	END_STRUCT;

  	NH_ALA_CX {HIDDEN} :  STRUCT 					// Scn,Act
		Qr				: BOOL := true;            // prvy vstyp do LVL
		Pir			: BOOL := true;            // Qr pohybu
		dogOff		: BOOL;            			// pes zalezie do budy
		alaRst      : BOOL;							// obnovenie strazenia
		dummy1		: BOOL;
		dummy2      : BOOL;	
		dummy3      : BOOL;	
		dummy4      : BOOL;	
		PirFilt		: UINT := 30;         		// pocet SEC, kolko sa caka za dalsim vykonanim
	END_STRUCT;


  	NH_ALA {HIDDEN} :  STRUCT 					// Scn,Act
 		ok				: NH_REC_OK := (ok:=1);
      cf          : NH_CFG_ALL;
		al				: NH_DEV_ALL_M;
      cx          : NH_ALA_CX;
	END_STRUCT;

  // treba dotiahnut
  	NH_ALA_PAR {HIDDEN} :  STRUCT 					// Scn,Act
		OnlyFrom			: NH_BTN8;						// len ked pride z urovne 1..7
		OnlyPir			: BOOL;							// len ak bol pohyb
		OnlyAllLock		: BOOL;							// len ked su zamknute vsetky miestnosti
		RunPirFilter	: UINT;							// spustat kazdych [s] - ak je novy pohyb
		RunMaxCount		: UINT;							// Max.pocet spusteni za donu RunMaxTime
		RunMaxTime		: UINT;	                  // doba od 1.akcie pocas ktorej sa pripocitava RunMaxCount - resetne sa 1.akciou
		tPirFilter		: UINT;							// spustat kazdych [s] - ak je novy pohyb
		tMaxCount		: UINT;							// Max.pocet spusteni za donu RunMaxTime
		tMaxTime			: UINT;	                  // doba od 1.akcie pocas ktorej sa pripocitava RunMaxCount - resetne sa 1.akciou
	END_STRUCT;


	NH_POI_DAYWRK {HIDDEN}: NH_POI := ( cx := ( p:= [         // DayMode  Jeden pracovny den
                           ( t :=   0,  o := 2),   // night    0:00
                           ( t := 330,  o := 3),   // morning  5:30 //330
                           ( t := 390,  o := 0),   // day      6:30
                           ( t :=1080,  o := 1),   // evening 18:00
                           ( t :=1380,  o := 2),   // 23:0;
                           ( t :=1440,  o := 2)    // 24:0;
                   ]));
   NH_POI_DAYFRE  {HIDDEN} : NH_POI := ( cx := ( p:= [        // sobota/nedela/sviatok
                           ( t :=   0,  o := 2),   // night    0:00
                           ( t := 450,  o := 3),   // morning  7:30  //450
                           ( t := 480,  o := 0),   // day      8:00
                           ( t :=1080,  o := 1),   // evening 18:00
                           ( t :=1440,  o := 1)    // 24:0;
                   ]));

  	NH_POI_WDAY {HIDDEN}:  STRUCT 	
      PON       : NH_POI_DAYWRK ;                  // pondelok
      UTO       : NH_POI_DAYWRK ;                  // utorok
      STR       : NH_POI_DAYWRK ;                  // streda
      STV       : NH_POI_DAYWRK ;                  // stvrtok
      PIA       : NH_POI_DAYWRK ;                  // piatok
      SOB       : NH_POI_DAYFRE ;                  // sobota
      NED       : NH_POI_DAYFRE ;                  // nedela
      FRE       : NH_POI_DAYFRE ;                  // volny den /sviatok
      ALL       : NH_POI := ( cx := ( p:= [        // plny dom (party)
                           ( t :=   0,  o := 1),   // night    0:00
                           ( t :=  60,  o := 2),    // 24:0;
                           ( t := 480,  o := 3),   // morning  8:00
                           ( t := 540,  o := 0),   // day      9:00
                           ( t :=1020,  o := 1),   // evening 21:00
                           ( t :=1440,  o := 1)    // 24:0;
                   ]));
      OUT       : NH_POI_DAYWRK ;                  // Out
      HOL       : NH_POI_DAYWRK ;                  // Holiday
   END_STRUCT;

   NH_POI_HETWRK {HIDDEN} : NH_POI := ( cx := ( p:= [       // HET  Jeden pracovny den
                           ( t :=   0,  o := 1),   // utlm     0:00
                           ( t := 360,  o := 3),   // komfort  6:00
                           ( t := 450,  o := 1),   // utlm     7:30
                           ( t := 960,  o := 3),   // komfort 16:00
                           ( t :=1380,  o := 1),   // utlm    22:30;
                           ( t :=1440,  o := 1)    // utlm    24:00;
                   ]));
   NH_POI_HETFRE {HIDDEN} : NH_POI := ( cx := ( p:= [       // HET  volny den
                           ( t :=   0,  o := 1),   // utlm     0:00
                           ( t := 420,  o := 3),   // komfort  7:00
                           ( t :=1380,  o := 1),   // utlm    23:00
                           ( t :=1440,  o := 1)    // utlm    24:00;
                   ]));
  	NH_POI_WHET  {HIDDEN} :  STRUCT 	
      PON       : NH_POI_HETWRK ;                  // pondelok
      UTO       : NH_POI_HETWRK ;
      STR       : NH_POI_HETWRK ;
      STV       : NH_POI_HETWRK ;
      PIA       : NH_POI_HETWRK ;
      SOB       : NH_POI_HETFRE ;
      NED       : NH_POI_HETFRE ;
      FRE       : NH_POI_HETFRE ;
      ALL       : NH_POI_HETFRE ;
      OUT       : NH_POI   := ( cx := ( p:= [
                           ( t :=   0,  o := 1),   // utlm     0:00
                           ( t :=1440,  o := 1)    // utlm    24:00;
                   ]));
      HOL       : NH_POI   := ( cx := ( p:= [
                           ( t :=   0,  o := 0),   // protimraz    0:00
                           ( t :=1440,  o := 0)    // protimraz    24:00;
                   ]));
   END_STRUCT;

   NH_POI_VENWRK {HIDDEN} : NH_POI := ( cx := ( p:= [       // HEV  Jeden pracovny den
                           ( t :=   0,  o := 0),   //
                           ( t := 300,  o := 3),   // 5:00
                           ( t := 315,  o := 0),   // 5:15
                           ( t := 720,  o := 3),   // 12:00
                           ( t := 735,  o := 0),   // 12:15
                           ( t :=1080,  o := 3),   // 18:00
                           ( t :=1095,  o := 0),   // 18:15
                           ( t :=1440,  o := 0)    //    24:00;
                   ]));

  	NH_POI_WVEN {HIDDEN} :  STRUCT 	
      PON       : NH_POI_VENWRK ;                  // pondelok
      UTO       : NH_POI_VENWRK ;
      STR       : NH_POI_VENWRK ;
      STV       : NH_POI_VENWRK ;
      PIA       : NH_POI_VENWRK ;
      SOB       : NH_POI_VENWRK ;
      NED       : NH_POI_VENWRK ;
      FRE       : NH_POI_VENWRK ;
      ALL       : NH_POI_VENWRK ;
      OUT       : NH_POI_VENWRK ;
      HOL       : NH_POI_VENWRK ;

   END_STRUCT;

  	
  	NH_FRM_249  {HIDDEN} :  STRUCT          // sablona typovych dni
      hed   : NH_FRM_HED := (Name:='_249',row:=1,desc:='Typove dni');
      DAY   : NH_POI_WDAY;             // DAY   : PO-NE
      HET   : NH_POI_WHET;             // HET   : PO-NE
      VEN   : NH_POI_WVEN;             // VEN   : PO-NE
   END_STRUCT;


   NH_FRM_247	{HIDDEN}   : STRUCT
      hed      : NH_FRM_HED := (Name:='_247',wht:=0,row:=2,desc:='Typ.Day+Time slider');
      txt   : ARRAY[0..2] OF INT := [555,223,223]; 										// texty v hlavicke - riadok 1		
      poi   : ARRAY[0..3] OF NH_POD_CFG :=
                              [  (),                                            // DayMode sa preberie ako default
                                 (  tim := false,  typ := 1,  n := 7,  o := 3,  // HetMode sa zadefinuje
                                     vo := ( o := [
                                                      ( o := 171,  c := 4),      // 0 - vlocka
                                                      ( o := 173,  c := 8),      // 1
                                                      ( o := 175,  c := 6),      // 2
                                                      ( o := 177,  c := 7)]),    // 3
                                   ),
                                 (  tim := false,  typ := 2,  n := 7,  o := 3,  // VEN sa zadefinuje
                                     vo := ( o := [
                                                      ( o :=  54,  c := 4),      // 0 - off
                                                      ( o := 173,  c := 8),      // 1
                                                      ( o := 175,  c := 6),      // 2
                                                      ( o := 177,  c := 7)]),    // 3
                                    ),

                                 (  tim := false,  typ := 3,  n := 4,  o := 3,  // hyst REG
                                     vo := ( o := [
                                                      ( o :=  54,  c := 4),      // 0 - off
                                                      ( o := 173,  c := 8),      // 1
                                                      ( o := 175,  c := 6),      // 2
                                                      ( o := 177,  c := 7)]),    // 3
                                    )

                               ];

   	ini 	: NH_FRM_249;
   END_STRUCT


   NH_FRM_250	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_250',desc:='HOME-Dsh/user->vz1',wht:=0,row:=8);
		vz1 : ARRAY[1..8] OF NH_VAZ :=     // FVL: ( Vaz[1] )_ - zoznam DEV k jednej hlavicke FAV
            [  (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=1)),   // SVE
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=2)),   // ZAS
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=3)),   // ROL
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=4)),   // VEN
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=5)),   // HET
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=6)),   // SEC
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=7)),   // BRA
               (  ok:= (ok:=1), in := (c:=1,n:=-1), ou := (c:=2,n:=8))    // ZAVLAZ
            ];
   END_STRUCT

   NH_FRM_251	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_251',desc:='TMP-FVL/user->vz1',wht:=0,row:=4);
		fav: ARRAY[1..4] OF NH_FAV :=     // FAV - hlavicka pre usra + 1 zdielany
            [  (  ok:= (ok:=1, stp:=1), cf := (Name:= 'Home Dash Menu',       typ :=  1), cx:=(c:=1,n:=-1)),
               (  ok:= (ok:=1, stp:=1), cf := (Name:= 'Home Quick Menu',      typ :=  2), cx:=(c:=1,n:=-2)),
               (  ok:= (ok:=1, adm:=1), cf := (Name:= 'Quick Setup Guide',    typ :=  3), cx:=(c:=1,n:= 3)),
               (  ok:= (ok:=1        ), cf := (Name:= 'Ob¾úbené všetkých',    typ :=  0), cx:=(c:=1,n:= 0))
            ];
   END_STRUCT

   NH_FRM_252	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_252',desc:='TMP-Def.Zone',wht:=0,row:=5);
		zon : ARRAY[1..5] OF NH_ROM :=     // ZON 1=domcek,2=vonkajsie zony
            [  (  cf := (Name:= 'Môj domov',       typ := 0, rom:=1)),
               (  cf := (Name:= 'Vonku',           typ := 2, rom:=1)),
               (  cf := (Name:= '1.Np',            typ := 3, rom:=1)),
               (  cf := (Name:= '2.Np',            typ := 3, rom:=1)),
               (  cf := (Name:= 'Podzemie',        typ := 3, rom:=1))
            ];
   END_STRUCT

   NH_FRM_253	{HIDDEN}   : STRUCT
      hed : NH_FRM_HED := (Name:='_253',desc:='TMP-Def.users',wht:=0,row:=5);
		usr : ARRAY[1..5] OF NH_USR :=     // 1admin + 6 usrov
            [ (  cf := (Name:= 'Admin'),     cx := (UsrRight := 3 ) ),
              (  cf := (Name:= 'User-2'),    cx := (UsrRight := 1 ) ),
              (  cf := (Name:= 'User-3'),    cx := (UsrRight := 1 ) ),
              (  cf := (Name:= 'User-4'),    cx := (UsrRight := 1 ) ),
              (  cf := (Name:= 'Spravca'),   cx := (UsrRight := 2 ) )
               ];
   END_STRUCT

   NH_FRM_254	{HIDDEN} 	  : STRUCT
      hed : NH_FRM_HED := (Name:='_254',desc:='TMP-Def.Msg-type',wht:=0,row:=3);
		msg  {HIDDEN} : ARRAY[1..3] OF NH_MSG :=     // MSG : SPRAVY
            [  (  cf := (Name:= 'Notifikácia',     typ := 0, rom:=1)),
               (  cf := (Name:= 'SMS',    			typ := 1, rom:=1)),
               (  cf := (Name:= 'Mail',            typ := 2, rom:=1))
            ];
   END_STRUCT

   NH_FRM_255	{HIDDEN} : STRUCT
      hed : NH_FRM_HED := (Name:='_255',desc:='TMP-Def.Alarm LVL',wht:=0,row:=7);
		ala : ARRAY[1..7] OF NH_ALA :=     // ALA : SPRAVY
            [  (  cf := (Name:= 'Odomknuté',     	typ := 0, rom:=1)),
               (  cf := (Name:= 'Zamykám...',    	typ := 1, rom:=1)),
               (  cf := (Name:= 'ZAMKNUTÉ',        typ := 2, rom:=1)),
               (  cf := (Name:= 'Niekto prišiel',	typ := 3, rom:=1)),
               (  cf := (Name:= 'Dunèo stráž',		typ := 4, rom:=1)),
               (  cf := (Name:= 'Dunèo trhaj',  	typ := 5, rom:=1)),
               (  cf := (Name:= 'A L A R M',   		typ := 6, rom:=1))
            ];
   END_STRUCT


   NH_LOG_IMP       : STRUCT   // struktura EVN-log
		ok				: STRING[1]:=' ';  		sok	: BYTE := 16#3b;
		cf				: STRING[3];   			s1 	: BYTE := 16#3b;
      cfg         : STRING[3];     			s2 	: BYTE := 16#3b;
      ID          : STRING[5];   			s6 	: BYTE := 16#3b;         // nacitane z exportu
  		inv			: string[1]:='0';      	s3i 	: BYTE := 16#3b;			 // on/off	
  		typ			: string[1]:='0';      	s3 	: BYTE := 16#3b;
  		typYes		: string[1]:='N';      	sy 	: BYTE := 16#3b;				// prepisuje sa typ
		d				: STRING[1]:='0';			d2 	: BYTE := 16#3b; 				//	hw.d[d]
      HWs         : STRING[8];      		sa 	: BYTE := 16#3b;
		HWtyp			: STRING[1]:= '0';		d22 	: BYTE := 16#3b;
      IO          : STRING[1];      sb 	: BYTE := 16#3b;         // I=vstup, Q=vystup, M=pamat
      MEM         : STRING[1];      sc 	: BYTE := 16#3b;         // 0=BOOL,1=REAL,
      RomID       : STRING[3]:='   ';     s7 	: BYTE := 16#3b;         // RomID, ktore sa bude hladat v xRom^.cf.ID
      Rom         : STRING[3]:='   ';     s5 	: BYTE := 16#3b;         // cislo vety rom {nd}
      typRom      : STRING[1]:=' ';    	s4 	: BYTE := 16#3b;			 // 0=admin,1=vnutorna,2=vonkajsia,3=podzemna,4=wellmess,5=sauna
      Name        : STRING[20];     s8 	: BYTE := 16#3b;
      NameCf      : STRING[20];     s81 	: BYTE := 16#3b;          		// aktualny nazov v CFG
      Cr       	: BYTE   := 16#0D;
      Lf       	: BYTE   := 16#0A;
	END_STRUCT;


   NH_FRM_500	{HIDDEN}   : STRUCT
      hed      : NH_FRM_HED := (Name:='_500',desc:='Import from CIB');
		rImp		: NH_LOG_IMP;
		eImp 		: NH_LOG_IMP;
   END_STRUCT



END_TYPE

VAR_GLOBAL
   yFrmName AT mObr  		{HIDDEN} : NH_FRM_HED;              // head of template
	yFrmData	AT mObr[34]		{HIDDEN} : USINT;	//NH_LOG_HEAD;		// data of template
	yFrm_500	AT mObr			{HIDDEN} : NH_FRM_500;					// import from NH2.exp
	yFrm_250	AT mObr			{HIDDEN} : NH_FRM_250;					// import from NH2.exp
	yImp		AT yFrmData		{HIDDEN} : NH_LOG_IMP;					// only struct import
   xFrmHed           		{HIDDEN} : PTR_TO NH_FRM_SAVE_MAP;  // head for saving

	// ladenie


END_VAR



{ $ IFDEF __NH_FRM }
	VAR_GLOBAL
	   _START_FRM_SYS : USINT := 0;
	
		_247_S : UDINT := SIZEOF(NH_FRM_247); _247 : NH_FRM_247 ;
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
	END_VAR
{ $ END_IF }


FUNCTION {HIDDEN} _NhIsObrOk : BOOL (* yTx1:=CONCAT('_',UINT_TO_STRINGF(frm,'%03u')); yTx2:=CONCAT(aSys.ADR_RAM,'FRM/',yTx1,'.FRM'); *)
	VAR_INPUT
		frm	: UINT;
	END_VAR
//	_NhIsObrOk	:= _Nh_Log_Path(wh:=7,frm:=frm);	
	yTx0 := CONCAT('_',UINT_TO_STRINGF(frm,'%03u'));
 	If yFrmName.Name = yTx0 THEN
		_NhIsObrOk := TRUE;
		RETURN;
	ELSE
		_NhIsObrOk := false;	
	END_IF;
	fH 	:= INVALID_HANDLE_VALUE;
	yTx0 	:= CONCAT(aSys.DiskHed.Disk[4].path,'FRM/',yTx0,'.FRM');							// RAM/
  	IF _NhFOpen(fN:=yTx0, fH:=fH) THEN
     	yFrmName.siz 	:= fS;	
  		yFrmName.siz 	:= FileRead  (hFile := fH, adrBuf := PTR_TO_UDINT(ADR(mObr)), size := fS );
		_NhIsObrOk		:= yFrmName.siz = fS;
		rb					:= _NhFClose(fH:=fH);
	END_IF;
END_FUNCTION


