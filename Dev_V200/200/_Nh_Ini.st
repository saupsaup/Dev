(* INICIALIZACNE FUNKCIE RAM A DBX PO RESTARTE, OBNOVENIE Z SDC A TESTY KONZISTENCIE  *)
(*
TYPE
  	NH_DBX_2	{HIDDEN}   :  STRUCT 			// riadiaca hlavicka DBX
      ver         : NH_DBX_VER   ;
      sCfg        : USINT := SIZEOF(NH_CFG_CFG);       // velkost vety aCfg v DBX
      sPar        : USINT := SIZEOF(NH_PAR_CFG);       // velkost vety aPar v DBX
      sVaz        : USINT := SIZEOF(NH_VAZ_CFG);       // velkost vety aVaz v DBX

      nCfg        : USINT := _Nh_CFG;              // pocet viet CFG
      nPar        : USINT := _Nh_PAR;              // pocet viet PAR
      nVio        : USINT := _Nh_VAZ;              // pocet viet VAZ
      // adresy dat
      aCfg        : UINT;                          // offset od _Dbx0  - zaciatok aCfg ulozeny v databoxe
      aPar        : UINT;                          // zaciatok aPar ulozeny v databoxe
      aVio        : UINT;                          // zaciatok aVaz ulozeny v databoxe
      vRam        : UINT;                          // aktualna velkost dat v aRam[] = posladny zaznam aVaz
      // gobalne  premenne/sablony, ktore sa obnovuju z DBX
      all         : NH_DBX_VAR;
      rezerva     : STRING[79];
//    0,ROM,ZON,CAT,SCN,FAV,USR,HET,SVD,SVA,RGB,ZAS,STY,VEN,ROL,GAR,SIR,13,WSB,TLA,KOT,TVE,CER,PIR,TER,DOR,WIN,LUX,KEY,H20,FIR,GAS,
//      ixc         : ARRAY[0..50] OF USINT := [0,3,1,2,5,4,20,22,6,10,11,12,21,23,31,32,30,13,14,8,7,9,15,16,17,18,19,24,27,28,29,38,39,0]; // SCN,SVD,SVA....
//      ixc         : ARRAY[0..50] OF USINT := [0,1,3,4,5,20,22,10,11,12,21,23,31,32,33,34,35,30,13,14,24,15,19,16,17,18,6,7,8,9,27,28,29,37,38,39,2,0]; // SCN,SVD,SVA....
	END_STRUCT;

   NH_CFG_CFG_2  {HIDDEN}:  STRUCT 					// zakladny konfiguracny subor vsetkych DEV a ich rozlozenie v RAM
      // spoloxna struktura pre xNh
		Siz         : UDINT;								// velkost jedneho zaznamu
		Ram         : UDINT;							  // adresa 1.vety vo virtualnej pamati mRam[ vRam ], kde je ulozena xCfg (nulta veta )
      Rec         : INT;                       // pocet zaznamov
		New			: INT;						     // pocet novych zanamov, ktore sa ziadaju
      nDe         : USINT;                       // pocet DEL-viet
      rDe         : INT;                       // posledna volna DEL veta
      NOk         : BOOL;                      // novopridana veta bude oznacena uz pri pridani ako platna
      ver         : USINT := 1;
		// dotial musia mut CFG,PAR,VAZ rovnake, kebo sa pouzivaju xNh^
  		cfg			: STRING[3] ;						// nazov suboru na SDC dev := xxx.***
      ofs         : UDINT;                       // offset Empty premennej od eRom
      // unikatne  pre CFG
      par         : USINT;                      // cislo parametra  (odkaz do aPar)
      al          : USINT;	// := SIZEOF(NH_DEV_ALL) ;                      // velkost specialnej cfg pre dev
      cx          : USINT;                      // velkost specialnej cfg pre dev
      // dotialto sa obnovuje DBXver=001
      cf          : USINT := SIZEOF(NH_CFG_ALL);                      // velkost hlavnej cfg
      me          : UINT;                       // velkost uzivatelskej prevadzkovej pamate
      hw          : USINT;                       // velkost HW pamate
      io      		: USINT;
      dummy5      : USINT;
      dummy6      : USINT;
      dummy7      : USINT;
      dummy8      : USINT;
      dummy9      : USINT;
      // dotialto sa obnovuje DBXver > 001
      cat         : USINT;                      // cislo cat do ktorej patri toto dev
      ref         : USINT := 251;               // druh refreshu 251-len to co je na obrazovke,252=to co je na obrazevke a predefinovat,254=novy vypis od 1.zanamu
//      cou         : USINT;                      // cislo skupiny vystupov pre prenos vstupov
      tgr         : USINT;                      // typovy predstavitel/skupina vazieb

      mna         : USINT;                      // cislo menu pre ikonu vlastnosti - administrator _042.MN0
      mnu         : USINT;                      // cislo menu pre ikonu vlastnosti - user          _042.MN0
      rExp        : USINT;                      // pocet viet v z exportu
      fBr         : USINT;                      // cislo formatoveho suboru pre pre BRW-ROW, ulozene _Nh_ADR_ROT,'/CFG/FRM/_000.
      fSc         : USINT := 200;               // cislo menu cez ktore sa dostane so _Nh_Frm_SCR = parametrov DEV
      ar2         : BOOL;                       // '>>' dvojita      sipka dalej je v obr[4] prioritou c.1
      lst         : BOOL;                       // ma ikonu DEV-listu {SCN,ACT..}
      stp         : BOOL := true;               // moze mat odskok na vazby = ikona setup (len v rezime setup)
      fav         : BOOL := true;               // ma ikonu fav
      chk         : BOOL := true;               // ma ikonu check (ak je vo vazbach)
      edn         : BOOL := true;               // moze sa editovat nazov
      sld         : BOOL;                       // DEv ma slider v riadkovom zobrazeni
      ou          : BOOL;                       // tot je vystup - kde sa nieco nastavuje
      dbx         : BOOL;                       // data boli obnovene z DBX
      sdc         : BOOL;                       // data boli obnovene z SDC
//      NoDelDBX    : BOOL;                       // pri obnoveni z DBX sa NE-oznaci ako DEL. Potom ju odznaci proces aktualizacie adries z NH2.ADR
      NoRecCat    : BOOL;                       // pri zfiltrovani kategorie sa zobrazia aj ked nemaju ziadny zaznam
      AllCFG      : BOOL;                       // z DBX neobnovuje po cf+al+cx... ale obnovi naraz cely zaznam podls velkosti SIZE
      scn         : BOOL;                       // priznak, ze ide o dev, ktore riadi viac vystupnych DEV (SCN,ACT,TIM...)  ma nejeky dev-list
      body        : BOOL;                       // tento DEV zapisuje pritomnost
      ini         : BOOL;                       // pri inicializacii boli pridane vety, treba ich popisat
      del         : BOOL;			               // je mozne mazat DEV (ON/OFF)
      bck         : BOOL := true;               // toto cfg sa zalohuje z RAM -> SDC
      imp         : BOOL := true;               // do cf sa importuju adresy  z CIB .... , ROM nebude mat adresy
      NewExp      : BOOL;                       // toto CFG ma z exportu nove data/adresy a musi sa aktualizovat
      QckStat     : BOOL;                       // v HOME-QuickMnu sa vypisuju obrazku zo stat, nie z dev
      lvl254      : BOOL;                       // dev nema max LVL 100% ale 254 = DALI            (len pre web)
      analog      : BOOL;                       // dev je 0-100% alebo 0-254                       (len pre web)
      dali      	: BOOL;                       // patri do dali
      ShwSta   	: BOOL;  		              // robrazi sa ikona cfg v ROM/ZON ak je niektore z DEV v [cf] aktivne
      zone        : BOOL;                       // moze vstupovat {davat signal} aj do zony  (TER,LUX)


   END_STRUCT;

  	NH_PAR_CFG_2  {HIDDEN}:  STRUCT 					// zakladny konfiguracny subor vsetkych parametrov
      // spoloxna struktura pre xNh
		Siz         : UDINT;								// velkost jedneho zaznamu
		Ram         : UDINT;							  // adresa 1.vety vo virtualnej pamati mRam[ vRam ], kde je ulozena xCfg (nulta veta )
      Rec         : INT;                       // pocet zaznamov
		New			: INT;						     // pocet novych zanamov, ktore sa ziadaju
      nDe         : USINT;                       // pocet DEL-viet
      rDe         : INT;                       // posledna volna DEL veta
      NOk         : BOOL;                      // novopridana veta bude oznacena uz pri pridani ako platna
      ver         : USINT := 1;


		cfg			: STRING[3] ;						// nazov suboru na SDC dev := xxx.***
      ofs         : UINT;                       // offset Empty premennej od epSvd

      // unikatne  pre PAR
      dbx         : BOOL;                       // data boli obnovene z DBX
      sdc         : BOOL;                       // data boli obnovene z SDC
//		in          : BOOL := true;					//	vo vazbe IN sa vytvara parameter, inak sa preberie z hlavicky
//		ou          : BOOL := true;					// vo vazbe OU sa vytvara parameter, inak sa preberie z hlavicky
      grp         : BOOL;                       // novy parameter sa vytvori, len ak vstupuje na pozici OUT skupinovych prikazov do SCN,ACT,TIM. Inak sa zoberie default cislo paramtra z DEV
//		New			: INT;						     // pocet novych zanamov, ktore sa ziadaju
	END_STRUCT;


  	NH_VIO_CFG_2	{HIDDEN}   :  STRUCT 			  // zakladny konfiguracny subor vazieb
		Siz         : UDINT := SIZEOF(NH_VAZ);	  // velkost jedneho zaznamu
		Ram         : UDINT;							  // adresa 1.vety vo virtualnej pamati mRam[ vRam ], kde je ulozena xCfg (nulta veta )
      Rec         : INT;                       // pocet zaznamov
		New			: INT;						     // pocet novych zanamov, ktore sa ziadaju
      nDe         : USINT;                       // pocet DEL-viet
      rDe         : INT;                       // posledna volna DEL veta
      NOk         : BOOL;                      // novopridana veta bude oznacena uz pri pridani ako platna
      ver         : USINT := 1;

      ref         : BOOL := true;              // vsetky vazby sa refreshnu (ako keby bolo cmd > 0)
	   ini         : BOOL;                      // pri restarte sa nplni DEFAULT hodnotami
   END_STRUCT;
END_TYPE

VAR_GLOBAL
	oDbx	      {HIDDEN}	   : NH_DBX_2;                                // hlavny riadiaci subor vratane organizacie DBX
   oCfg        {HIDDEN}    : NH_CFG_CFG_2;                            // konfiguracia vsetkych DEV
   oPar        {HIDDEN}    : NH_PAR_CFG_2;                            // konfiguracia vsetkych DEV
   oVio        {HIDDEN}    : NH_VIO_CFG_2;                            // konfiguracia vsetkych DEV
END_VAR
*)

VAR_GLOBAL CONSTANT
(*
  _NhQickGuide   {HIDDEN} : ARRAY[ 9..16,0..1] OF USINT :=
                    [   1,  0,                     // Vytvorit miestnost
                        2, 44,                     // Dev bezmiestnosti
                        2, 16,
                        2, 15,
                        2, 24,
                        2, 14,
                        2,  5,
                        2,  6
                    ];
END_VAR
*)

  _NhQickGuide   {HIDDEN} : ARRAY[ 9..14,0..1] OF USINT :=
                    [   2, 16,
                        2, 15,
                        2, 24,
                        2, 14,
                        2,  5,
                        2,  6
                    ];
END_VAR



FUNCTION _NhNewPAR {HIDDEN} : BOOL	    // zvysi poziadavku na novu vetu (vrati true), alebo oznaci existujucu ak je DEL (false)
   VAR_INPUT
      xP    : PTR_TO INT;                          // xCfg^.par, alebo io.p
      cp    : USINT;
		ee	: INT;
   END_VAR
   _NhNewPAR := true;                             // default nepridavaju sa nove vety

(*
	IF cp = 14 THEN
      yTx2     := CONCAT('  nd: ',INT_TO_STRING(nd), ' cp: ',USINT_TO_STRING(cp),' np: ',INT_TO_STRING(xP^)   );
      _Nh1RowTxt(logRst:=1, noTime := 1);
		
//		aSys.ini := 217;
//		RETURN;

	END_IF;
*)

   IF xP^ = 0	THEN																// nememe parameter a mal by byt
      ;
   ELSIF xP^ > aPar[cp].rec THEN                   // parameter sa este len prida, ale uz si ho nieco rezervovalo
		j := j+1;
	ELSIF _NhxPar(cp := cp, np := xP^ ,x:=ee) THEN   // uz si ho zobralo iny DEV, musi sa vytvoriy novy
		i := i + 1;
   ELSE
       _NhNewPAR   := false;                        // pridava sanew := true;
       xPar^.ok.ok := true;
		z := z + 1;
   END_IF;
   IF _NhNewPAR THEN
      aPar[cp].new   := aPar[cp].new + 1;
      aPar[cp].nOk   := true;                                        // pridane vety budu hned platne
      xP^            := aPar[cp].rec + aPar[cp].new;   // parametrom bude nova platna veta
		x				 	:= x + 1;
   END_IF;
(*
	IF cp = 14 THEN
      yTx2     := CONCAT('    j: ',SINT_TO_STRING(j), ' i:',USINT_TO_STRING(i), ' z:',INT_TO_STRING(z),' x:',INT_TO_STRING(x)   );
      _Nh1RowTxt(logRst:=1, noTime := 1);
	END_IF;
*)


END_FUNCTION


FUNCTION _Nh_Ini_PAR_Test {HIDDEN}   : BOOL	    // prejde vsetky DEV, ktore maju parametre a tieto parametre prida,a lebo od-DELETUJE
   VAR_TEMP
      cp       : USINT;
   END_VAR
   IF aSys.exp = 0 THEN
      yTx2     := 'START - _Nh_Ini_PAR_Test KONTROLA PARAMETROV :';
      _Nh1RowTxt(logRst:=1);
   END_IF;
   aSys.exp := aSys.exp + 1;
   WHILE aSys.exp <= aDbx.nCfx[0] DO                                       // prechadzaju sa typy parametrov kazdom cykle
      IF aCfg[aSys.exp].par = 0  THEN                                          // nema cf typ CFG_ALL, a tym ani parametre
         RETURN;
      END_IF;

	x	:= 0;
	y	:= 0;
	z	:= 0;
	i	:= 0;
	j	:= 0;

      cp    := aCfg[aSys.exp].par;
      FOR nd := 1 TO aCfg[ aSys.exp ].rec DO                         // prechadza len toto cfg
			IF _NhxPt( c := aSys.exp, n := nd, x:=70) OR aCfg[aSys.exp].dali THEN           // testuje len platne vety,
				IF cp = 0 THEN
               IF xPt^.cf.par > 0 THEN
						xPt^.cf.par	:= 0;                                    // grp je len pre ACT,SCN
						y				:= y + 1;	
					END_IF;
				ELSE
				   _NhNewPAR(cp := cp, xP := ADR(xPt^.cf.par), ee:=60);
				END_IF;		
			END_IF;
    	END_FOR;
     	yTx2	:= '  ' +USINT_TO_STRINGF(aSys.exp,'%3d')
		  			+ ' ' + aCfg[ aSys.exp ].cfg
					+ ' Rec: ' + INT_TO_STRINGF(aCfg[aSys.exp].rec,'%3d')
					+ ' Del: ' + INT_TO_STRINGF(y,'%3d');

		IF cp > 0 THEN
	     	yTx2	:= yTx2
						+ ' Ok: '  + INT_TO_STRINGF(z,'%3d')
						+ ' New: ' + INT_TO_STRINGF(x,'%3d')
		  				+ ' ' + aPar[cp].cfg
						+ ' ' + INT_TO_STRINGF(aPar[cp].rec,'%3d')
						+ ' D: ' + USINT_TO_STRINGF(i,'%3d');
		END_IF;
		IF aCfg[ aSys.exp ].cfg <> '' THEN
	  		rb       := _Nh1RowTxt(logRst := 1);
		END_IF;
		IF x > 0 THEN				
			_Nh_Go_DbxToMem(ram := true,dbx := false );                        // zalozi RAM->DBX, z DBX vrati do RAM s pridanim novych uz platnych viet
		END_IF;

      RETURN;
   END_WHILE;
   aSys.ini := 214;
   yTx2     := CONCAT('END - Kontola PAR Ok. aSys.ini:=', USINT_TO_STRING(aSys.ini) );
   rb       := _Nh1RowTxt(logRst := 1);
END_FUNCTION


FUNCTION _NhIniVAZ  {HIDDEN} : BOOL	    // prejde vazby a ak v IN alebo OUT je DEV, ktore neexistuje, vymaze vazbu
   VAR
      nvz    : USINT;
//      io    : USINT;
//      chg   : INT;
//      old   : INT;
      par   : INT;
      ndv   : INT;
      cp       : USINT;
   END_VAR
	yTx2     := '_NhIniVAZ     : ZACINAM KONTROLU';
 	_Nh1RowTxt(logRst:=1);

	FOR nvz := 2 TO 4 DO
		x	:= 0;
		y	:= 0;
		z	:= 0;
		i	:= 0;
		FOR ndv := 1 TO aVaz[nvz].Rec DO
         IF _NhxVaz( cv := nvz, nd := ndv) THEN                             // veta vazby je platna
				ok	:= true;

		  		IF _NhxPt(c:=xVaz^.in.c,n:=xVaz^.in.n,err:=1 ,x:=22) = false THEN
					xVaz^.ok.ok 	:= false;
					ok	   			:= false;
				ELSIF _NhxPt(c:=xVaz^.ou.c,n:=xVaz^.ou.n, err:=1 ,x:=24) = false THEN
					xVaz^.ok.ok 	:= false;
					ok	   			:= false;
				END_IF;

				IF ok THEN
					cp := aCfg[xVaz^.in.c].par;
					IF nvz = 3 THEN
						cp := 0;
					END_IF;
					IF cp = 0 THEN
						IF xVaz^.in.p > 0 THEN
							xVaz^.in.p := 0;
							y			  := y + 1;	
						END_IF;
					ELSIF xVaz^.in.p > 0 THEN
					   _NhNewPAR(cp := cp, xP := ADR(xVaz^.in.p), ee:=61);
					END_IF;
					cp := aCfg[xVaz^.OU.c].par;
					IF cp = 0 THEN
							IF xVaz^.OU.p > 0 THEN
							xVaz^.OU.p := 0;
							y			  := y + 1;	
						END_IF;
					ELSIF xVaz^.OU.p > 0 THEN
				   	_NhNewPAR(cp := cp, xP := ADR(xVaz^.OU.p), ee:=62);
					END_IF;
	         END_IF;
			END_IF;
      END_FOR;
     	yTx2	:= '   ' + USINT_TO_STRING(nvz)
		  			+ ': Rec: ' + INT_TO_STRINGF(aVaz[nvz].rec,'%3d')
					+ ' Del: ' + INT_TO_STRINGF(y,'%3d')
					+ ' Ok: '  + INT_TO_STRINGF(z,'%3d')
					+ ' New: ' + INT_TO_STRINGF(x,'%3d')
					+ ' Dupl: ' + USINT_TO_STRINGF(i,'%3d');
 		rb       := _Nh1RowTxt(logRst := 1);
		IF x > 0 THEN				
			_Nh_Go_DbxToMem(RAM := true,dbx := false );                        // zalozi RAM->DBX, z DBX vrati do RAM s pridanim novych uz platnych viet
		END_IF;
	END_FOR;

	yTx2     := '_NhIniVAZ     : KONTROLA OK.';
 	_Nh1RowTxt(logRst:=1);

END_FUNCTION

FUNCTION _Nh_Ini_Default_CFG_INI {HIDDEN}    : BOOL	    // doplni default CFG, ak este nie je
	VAR_INPUT
		vz		: BOOL;
		ver	: BOOL := true;
		nOk	: BOOL := true;
		rec	: INT;		
		cf		: USINT;
	END_VAR
   _Nh_Ini_Default_CFG_INI := false;                             // default nepridavaju sa nove vety
	IF vz	THEN
	   IF aVaz[cf].rec < rec  THEN   // ver=0: FAV,USR
   	   IF aVaz[cf].rec < rec THEN
      	   aVaz[cf].new :=  rec  - aVaz[cf].rec ;
	      END_IF;
   	   aVaz[cf].ini := TRUE;
      	aVaz[cf].nOk := nOk;
   	END_IF;
	 	aCfg[cf].ini   := aVaz[cf].ini OR ver;
	ELSE
		IF rec > aCfg[cf].rec THEN                                         // porovna sa aktulny pocet s pozadovanym
 			aCfg[cf].nOk	:= nOk;
	      aCfg[cf].new   := rec  - aCfg[cf].rec ;
   	   aCfg[cf].ini   := true;                                        // do tohto CFG sa budu pridavat detault vety
   		yTx2 := CONCAT('..',aCfg[cf].cfg,' + ',INT_TO_STRING(aCfg[cf].new) );
			rb   := _Nh1RowTxt(logRst := 1);
		END_IF;
		IF ver AND aCfg[cf].ver = 0 THEN
		 	aCfg[cf].ini   := true;
		END_IF;
	END_IF;
END_FUNCTION

FUNCTION _Nh_Ini_Default_CFG_DEF {HIDDEN} : BOOL	    // nakopiruje default sablony
	VAR_INPUT
		cf		: USINT;
		frm	: UINT;
	END_VAR
   _Nh_Ini_Default_CFG_DEF := false;                             // default nepridavaju sa nove vety
	IF aCfg[cf].ini = false THEN                                         // porovna sa aktulny pocet s pozadovanym
		RETURN;
	END_IF;
	// cele preddefinovane sablony
 	_Nh_FRM_Read(frm:=frm);               // zone
	MemCpyEx (	length := aCfg[cf].siz * MIN( USINT_TO_UDINT(yFrmName.row), INT_TO_UDINT(aCfg[cf].rec)) ,
				source := VOID( yFrmData ), dest := VOID( mRam[ aCfg[cf].ram ] ));
END_FUNCTION

FUNCTION _Nh_Ini_DEFAUL_CFG  {HIDDEN}    : BOOL	    // doplni default CFG, ak este nie je
   VAR_TEMP
      dsh,
//      zon                     : BOOL;
//      _NhCrPOI                : BOOL;
//      w                       : INT;
      cf                      : USINT;
   END_VAR
   yTx2 	:= 'START-kontroly Default udajov {_Nh_Ini_Default_DEFAUL}';
   rb   	:= _Nh1RowTxt(logRst:=1);
	// pripravi pocet novych viet
	_Nh_Ini_Default_CFG_INI(cf:= 3,rec:=USINT_TO_INT(_NH_ZONES));   // ZON 1=domov,2=vnutro,3=vonku.  Ostatne xony sa musia pridat rucne
	_Nh_Ini_Default_CFG_INI(cf:=20,rec:=4);          					// FAV defult je 4
	_Nh_Ini_Default_CFG_INI(cf:=22,rec:=USINT_TO_INT(_Nh_USR));     // USR
	_Nh_Ini_Default_CFG_INI(cf:=25,rec:=1);      							// GLB
	_Nh_Ini_Default_CFG_INI(cf:=48,rec:=7);      							// ALA
	_Nh_Ini_Default_CFG_INI(vz:=true, cf:= 1,rec:=USINT_TO_INT(_Nh_USR)*8, ver:=aCfg[20].ver=0 OR aCfg[22].ver=0); // VAZ[1]
	{$IFDEF __NH_DALI}
   IF _Nh_DALI_MA > 0 THEN
		_Nh_Ini_Default_CFG_INI(cf:=42,rec:=USINT_TO_INT(_Nh_DALI_MA), nOk:=0);      				// DLM
		_Nh_Ini_Default_CFG_INI(cf:=43,rec:=USINT_TO_INT(_Nh_DALI_MA)*64);   				// DLS
		_Nh_Ini_Default_CFG_INI(cf:=44,rec:=USINT_TO_INT(_Nh_DALI_MA)*16);   				// DLG
   END_IF;
	{$END_IF}
	// nakopirovat sablony



	_Nh_Go_DbxToMem(dbx := false, ForceRamOk:=true);         	// ulozi MEM->DBX a spat nacita este raz z DBX a prida nove vety
	_Nh_Ini_Default_CFG_DEF(cf:= 3,frm:=252);     // ZON
	_Nh_Ini_Default_CFG_DEF(cf:=20,frm:=251);     // FAV
	_Nh_Ini_Default_CFG_DEF(cf:=22,frm:=253);     // USR
//	_Nh_Ini_Default_CFG_DEF(cf:=  ,frm:=254);		// MSG
	_Nh_Ini_Default_CFG_DEF(cf:=48,frm:=255);		// ALA



   // vytvori sadu HOME-DSH pre kazeho usra
   cf := 1;
// aVaz[1].ini := 1;
   IF aVaz[1].ini THEN
		_Nh_FRM_Read(frm:=250);
		sz		:= aVaz[1].ram;
		sp		:= SIZEOF(NH_VAZ) * 8;
      FOR i := 1 TO _Nh_USR DO
         _NhxUsr(u := i );
         // fac.c je cislo usra 1..5
         xUsr^.cx.fav.c   := 1; xUsr^.cx.fav.n   := 0;            // FAV je spolocny pre vsetkych
         xUsr^.cx.dsh.c   := i;
         xUsr^.cx.qck.c   := i;
         xUsr^.cx.ds1     := xVaz^.ou;                           // cislo preveho DEV v DSH cf/nd
			FOR ii := 1 TO 8 DO
				yFrm_250.vz1[ii].in.c := i;
         END_FOR;			
			MemCpyEx (	length := sp ,
							source := VOID( yFrmData ), dest := VOID( mRam[ sz ] ));
				
			sz	:= sz + sp;
		END_FOR;			

(*


      xVaz  := ADR(mRam[aVaz[cf].ram]);
      sPtr  := aVaz[cf].Siz;
      // vycisti vsetok FVL (vazby)
      memset(val := 0, length := INT_TO_UINT(aVaz[cf].rec) * UDINT_TO_UINT(sPtr), dest := VOID( mRam[ aVaz[cf].ram ] ));
      // ku kazdemu usrovy dokopiruje sadu DSH 1..8 a u USR nastavi FAV na spolocny (c:=1,n:=0)
      FOR i := 1 TO _Nh_USR DO
         // nakopiruje 8 viet DSH
//         _Nh_FRM_Read(wht:=251, frm:=250, cfg:=1, sz := 8 * sPtr , ofs := 8 * sPtr * USINT_TO_UDINT(i-1) );
         _Nh_FRM_Read(frm:=250);
         _NhxUsr(u := i );
         // fac.c je cislo usra 1..5
         xUsr^.cx.fav.c   := 1; xUsr^.cx.fav.n   := 0;            // FAV je spolocny pre vsetkych
         xUsr^.cx.dsh.c   := i;
         xUsr^.cx.qck.c   := i;
         xUsr^.cx.ds1     := xVaz^.ou;                           // cislo preveho DEV v DSH cf/nd
         FOR nd := 1 TO 8 DO
            xVaz^.in.c  := i;                                     // preznaci usra u nakopitovanej sady
            xVaz        := xVaz + sPtr;
         END_FOR;
      END_FOR;
*)
   END_IF;
END_FUNCTION


(*
FUNCTION _Nh_Ini_Default_DEFAUL    : BOOL	    // doplni default CFG, ak este nie je
   VAR_TEMP
      ok,dsh,usr,sbj,
      zon                     : BOOL;
      _NhCrPOI                : BOOL;
      w                       : INT;
      cf                      : USINT;
   END_VAR
   yTx2 := 'START-kontroly Default udajov {_Nh_Ini_Default_DEFAUL}';
   rb   := _Nh1RowTxt(logRst:=1);
   ok := false;

   // kontrola na DEFAULT vety v CFG (pocet)
   FOR cf := 1 TO _Nh_CFG DO
      xNh      := ADR(aCfg[cf]);
      ok1      := true;                                                 // default priznak, ze pridane vety budu hned OK
      CASE cf OF                                                        // CFG s minimalnym poctom viet. pridane vety budu hned oznacene ako OK
         3: ix := USINT_TO_INT(_NH_ZONES);                              // ZON 1=domov,2=vnutro,3=vonku.  Ostatne xony sa musia pridat rucne
        20: ix := 4;                                                    // FAV defult je 4
        22: ix := USINT_TO_INT(_Nh_USR);                                // USR defult je 5
        25: ix := 1;    																// GLB
      ELSE
         ix       := 0;
         ok1      := false;
      END_CASE;
      IF ix > aCfg[cf].rec THEN                                         // porovna sa aktulny pocet s pozadovanym
         xNh^.nOk       := ok1;
         aCfg[cf].new   := ix  - aCfg[cf].rec ;
         aCfg[cf].ini   := true;                                        // do tohto CFG sa budu pridavat detault vety
         ok             := true;                                        // globalny priznak, ze aspon do jedneho CFG treba pridat default vety
		   yTx2 := CONCAT('..',aCfg[cf].cfg,' + ',INT_TO_STRING(aCfg[cf].new) );
		   rb   := _Nh1RowTxt(logRst := 1);
      END_IF;
   END_FOR;

   cf:=1;   // FAV,FVL  - zoznam DSH pre kazdeho usra
   ix := USINT_TO_INT(_Nh_USR)*8;													// kazdy user ma 8 vlastnych Dash
   IF aVaz[cf].rec < ix OR aCfg[20].ver = 0 OR aCfg[22].ver = 0 THEN   // ver=0: FAV,USR
      IF aVaz[cf].rec < ix THEN
         aVaz[cf].new :=  ix  - aVaz[cf].rec ;
      END_IF;
      aVaz[cf].ini := TRUE;
      aVaz[cf].nOk := true;
      ok           := true;
   END_IF;
   cf             := 48;                                                            // ALArm
   aCfg[cf].ini   := true;
   ix := 7;
   IF ix > aCfg[cf].rec OR aCfg[cf].ver = 0 THEN    // novy ZON alebo POI
      If ix > aCfg[cf].rec THEN
         aCfg[cf].new   :=  ix  - aCfg[cf].rec ;
         aCfg[cf].nOk   := true;
         ok             := true;
      END_IF;
   END_IF;

	{$IFDEF __NH_DALI}
   IF _Nh_DALI_MA > 0 THEN
		ix	:= USINT_TO_INT(_Nh_DALI_MA);
	   IF aCfg[42].rec < ix THEN
	      aCfg[42].new := ix - aCfg[42].rec;
			ok 				:= 1;
			aCfg[42].NOk 	:= true;
   	END_IF;

		ix	:= USINT_TO_INT(_Nh_DALI_MA) * 64;
	   IF aCfg[43].rec < ix THEN
	      aCfg[43].new := ix - aCfg[43].rec;
			ok := 1;
   	END_IF;
		ix	:= USINT_TO_INT(_Nh_DALI_MA) * 16;
	   IF aCfg[44].rec < ix THEN
	      aCfg[44].new := ix - aCfg[43].rec;
			ok 				:= 1;
			aCfg[44].NOk 	:= true;
   	END_IF;
   END_IF;
	{$END_IF}

   IF ok THEN
      _Nh_Go_DbxToMem(dbx := false);                                 // len nacita este raz z DBX a prida nove vety
      FOR cf := 1 TO _Nh_CFG DO
         IF aCfg[cf].ini THEN                                     // tu je malo DEFAULT viet
            _NhxPt( c:= cf, n := 1,x:=52);                                     // prva veta
            CASE cf OF
               3: _Nh_FRM_Read(frm:=252);               // zone
						
						


RETURN;
              20: _Nh_FRM_Read(frm:=251);               // FAV - hlavicky
              22: _Nh_FRM_Read(frm:=253);               // users
              43: ;
//              46: _Nh_FRM_Read(wht:=250, frm:=254, cfg:=cf);               // MSG
              48: _Nh_FRM_Read(frm:=255);               // ALA
            END_CASE;
         END_IF;
      END_FOR;
   END_IF;

   // vytvori sadu HOME-DSH pre kazeho usra
   cf := 1;
// aVaz[1].ini := 1;
   IF aVaz[1].ini THEN
      xVaz  := ADR(mRam[aVaz[cf].ram]);
      sPtr  := aVaz[cf].Siz;
      // vycisti vsetok FVL (vazby)
      memset(val := 0, length := INT_TO_UINT(aVaz[cf].rec) * UDINT_TO_UINT(sPtr), dest := VOID( mRam[ aVaz[cf].ram ] ));
      // ku kazdemu usrovy dokopiruje sadu DSH 1..8 a u USR nastavi FAV na spolocny (c:=1,n:=0)
      FOR i := 1 TO _Nh_USR DO
         // nakopiruje 8 viet DSH
//         _Nh_FRM_Read(wht:=251, frm:=250, cfg:=1, sz := 8 * sPtr , ofs := 8 * sPtr * USINT_TO_UDINT(i-1) );
         _Nh_FRM_Read(frm:=250);
         _NhxUsr(u := i );
         // fac.c je cislo usra 1..5
         xUsr^.cx.fav.c   := 1; xUsr^.cx.fav.n   := 0;            // FAV je spolocny pre vsetkych
         xUsr^.cx.dsh.c   := i;
         xUsr^.cx.qck.c   := i;
         xUsr^.cx.ds1     := xVaz^.ou;                           // cislo preveho DEV v DSH cf/nd
         FOR nd := 1 TO 8 DO
            xVaz^.in.c  := i;                                     // preznaci usra u nakopitovanej sady
            xVaz        := xVaz + sPtr;
         END_FOR;
      END_FOR;
   END_IF;
END_FUNCTION
*)

FUNCTION _Nh_POI_INI {HIDDEN}   : BOOL	    // urobi testy POI, prida nove, vymaze stare
   // POI
	// 23.4.24
	ix					:= 0;
	aCfg[26].ini 	:= aCfg[26].ver = 0 ; // OR (aCfg[cf].ver = 2 AND aCfg[cf].ver_dbx < 2 );	// konverzia je 1 -> 2
   yTx2  			:= 'START - _Nh_POI_INI';
	_Nh1RowTxt(logRst:=1);

	ix := _Nh_POI_INI_REC();
   If ix > aCfg[26].rec THEN
      aCfg[26].new   := ix  - aCfg[26].rec ;
		aCfg[26].nOk 	:= false;
	   yTx2  := CONCAT('..Pridane aCfg[26].new : ',INT_TO_STRING(aCfg[26].new))  ;
		_Nh1RowTxt(logRst:=1);
      _Nh_Go_DbxToMem(ram:=true, dbx:=false);                                 		// len nacita este raz z DBX a prida nove vety
	ELSE
	   yTx2  := CONCAT('.._Nh_POI_INI - Ok. Rec: ',INT_TO_STRING(aCfg[26].rec))  ;
		_Nh1RowTxt(logRst:=1);
   END_IF;

	_Nh_POI_INI_NEW(cf:=  3, del := true);								// z ZON vzdy len vymaze poi
	IF aCfg[26].ini THEN			
		// vsetky vety POI vymazat
	   yTx2  := CONCAT('.._Nh_POI_INI - DELETE  aCfg[26].rec : ',INT_TO_STRING(aCfg[26].rec))  ;
		_Nh1RowTxt(logRst:=1);
	   FOR ix := 1 TO aCfg[26].rec DO
			_NhxPt(ok:=1, c := 26, n := ix, x:=-123);             // najde aj del vetu
			xPt^.ok.ok := false;                          			// odznaci POI
		END_FOR;	
		// najskor sa musi vymazat obsah - odkaz na poi v ROM,HET,HEV - VSETKO v jednom cykle CFG 1..X
		FOR cf := 1 TO _Nh_CFG DO
			IF aCfg[cf].NbrPoi > 0 THEN
		   	yTx2  := CONCAT('.._Nh_POI_INI - DEL-poi[day]: ',aCfg[cf].cfg,' ver:',USINT_TO_STRINGF(aCfg[cf].ver,'%3d') )  ;
				_Nh1RowTxt(logRst:=1);
				_Nh_POI_INI_NEW(cf:=cf, del:=true);				// vymazat NEW,DEL ROM/HET/HEV
			END_IF;
		END_FOR;
	END_IF;
	// teraz sa skontroluju odkazy POI, bud sa pridanaju alebo sa priradia
	FOR cf := 1 TO _Nh_CFG DO
		IF aCfg[cf].NbrPoi > 0 THEN
	   	yTx2  := CONCAT('.._Nh_POI_INI - CHK-poi[day]: ',aCfg[cf].cfg,' ver:',USINT_TO_STRINGF(aCfg[cf].ver,'%3d') )  ;
			_Nh1RowTxt(logRst:=1);
			_Nh_POI_INI_NEW(cf:=cf);				// kontrola, NEW,DEL ROM/HET/HEV
		END_IF;
	END_FOR;
   yTx2  := 'END -_Nh_POI_INI';
	_Nh1RowTxt(logRst:=1);
END_FUNCTION

FUNCTION _Nh_Ini_DEV_Test  {HIDDEN}  : BOOL	    // urobi testy
      cf := 1;
      FOR nd := 1 TO aCfg[1].rec DO
         IF _NhxPt(c:=cf, n:=nd) AND xPt^.cf.typ = 0 THEN
            _NhDefRom := INT_TO_USINT(nd);
            EXIT;
         END_IF;
      END_FOR;
      _Nh_Ini_DEV_Test := true;
      ix    := 1;                                                           		// presunie sa na dalsie CFG
      cf    := _Nh_IxC[ix];                                                     	// vybrate CFG
      WHILE  cf > 0 DO                                                           // prechadza zaznamy jedneho CFG
         nd    := 1;
         WHILE  nd  <= aCfg[cf].Rec DO                                           // vsetky vety CFG
            IF _NhxPt(c := cf, n := nd,x:=53) THEN
               xDev  := xPt;
					IF aCfg[cf].body THEN
						xDev^.cf.psn := true;                                          // len docasne do 5.9.23
   				END_IF;
//               IF cf = 23 THEN //   ú xDev^.cf.cat = 0 AND aCfg[cf].cat > 0 THEN
//               IF aCfg[cf].cat > 0 AND (xDev^.cf.cat = 0 OR xDev^.cf.cat <> aCfg[cf].cat) THEN
               IF cf = 4 THEN            														// sceny
                  xDev^.cf.cat := 53;                            						// default categoria
               ELSIF cf = 44 THEN            												// DLG
                  xDev^.cf.cat := 54;                            	
               ELSIF aCfg[cf].cat > 0 AND (xDev^.cf.cat = 0 OR xDev^.cf.cat > _Nh_CAT) THEN
                  xDev^.cf.cat := aCfg[cf].cat;                            		// default categoria
               END_IF;

               IF cf = 1 THEN
						_Nh_TST_ROM();
					ELSIF cf = 3 THEN                                       				// zone ma ROM = nd
						_Nh_TST_ZON();
					ELSIF aCfg[cf].tgrp = 5 THEN                           				// ACT,ALA
                  IF xDev^.cf.rom = 0 OR xDev^.cf.rom > INT_TO_USINT(aCfg[3].rec) THEN      // kontrola na zone
                     xDev^.cf.rom := _NhDefHom; 														// domcek
                  END_IF;
					ELSIF xDev^.cf.rom = 0 THEN                                       // ostatne ako ROM nastavi na DEFault
     					xDev^.cf.rom := _NhDefRom;					
               END_IF;
            END_IF;
            nd := nd + 1;
         END_WHILE;
         ix    := ix + 1;                                                           // presunie sa na dalsie CFG
         cf    := _Nh_IxC[ix];                                                     // vybrate CFG
      END_WHILE;

END_FUNCTION



{ $IFDEF __NH_EXP2 }


VAR_GLOBAL
	yWSBx	: NH_WSB;
	yTxXa	: STRING[255];
	yTxXb	: STRING[255];
END_VAR


(*                                                                          (*
   - ROM - zmena typu miestnosti - do IO pridat za nazov typ  0=vnutorna,1=vonkajsia,2=suteren
   - TVE zmena hw.d[1] n ad[0], do d[1] sa zapisuje TECO ventil stat
         xTvTecoIn := UDINT_TO_PTR(xTve^.hw.d[1]);          // VSTAT musi mat teraz 'Q' lebo sa zapisuje do d.[1], predtym bolo hw.d[0]
         xTvTecoOu := xPtB;                  // VCONT
   - WSB,TLA d[0] bola led, teraz je d[1] 'Q',  teraz je d[0] btn d[1] LED
   - WSB - preverit LEdNbr - nezapisuje sa teraz, LED nebudu dobre
   - TGL zmenili sa adresy d[1] <-> d[0]
*)


VAR_GLOBAL CONSTANT
                           //123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
                           //PIR;1;   ;   0;   ;  0;   ;Vonku               ; ;0;X02   ;         ;         ;         ;         ;         ;         ;
   // yTx1 :=               'CFG;D;IDX;-123;rID;ROM;SBJ;Name                ;B;I;ID    ;         ;         ;         ;         ;         ;         ;$r$n';   // LEN=52
   _ExpRow {HIDDEN} : STRING[119] :=   '   ;1;   ;    ;   ;  0;   ;                    ; ; ;      ;         ;         ;         ;         ;         ;         ;';
   _ExpDev {HIDDEN} :  ARRAY[0..12,0..1] OF USINT :=
                  [  1,121,      // 0 dlzka celej vety aj s CR pre zapis. pre citanie je len 116 (bez vozika)
                    11,  4,      // 1 typ
                    20,  3,      // 2 rom - Rec
                    24,  3,      // 3 SBJ
                    28, 20,      // 4 Name
                    53,  6,      // 5 ID
                    60,  9,      // 6 HW0. Dalsie HW sa vypocita +10
                    16,  3,      // 7 RomID
                     5,  1,      // 8 del
                    51,  1,      // 9 INV
                    49,  1,      //10 blk
                     7,  3,      //11 IDX
                     1,  3       //12 CFG
                  ];
END_VAR

TYPE
   NH_EXP_RAM		{HIDDEN} :  STRUCT 		
 		ok				: NH_REC_OK := (ok:=true);
      cf          : NH_CFG_ALL;
		hw				: NH_DEV_HW5;                     // zakladna adresa HW
      c           : USINT;
      cfg         : STRING[3];
      RomID       : STRING[3];                  // ROM z exportu
	END_STRUCT;
  	NH_IMP_EXP_WRK   {HIDDEN}  :   STRUCT 			    //  strura importu z prebrateho exportu 'NH2.ADR'
      cfg         : STRING[3] ;
  		typ			: string[1] ;
      typRom      : SINT;
      Rom         : USINT;                   // cislo rom
//      ID          : STRING[6] ;              // nacitane z exportu
      ///***10.11.22
      ID          : STRING[5] ;              // nacitane z exportu

      RomID       : STRING[ 3 ] ;
      Name        : STRING[20];
      HW          : UDINT;                   // jedna adresa
      HWs         : STRING[10];
      IO          : STRING[1];               // I=vstup, Q=vystup
      MEM         : STRING[1];               // 0=BOOL,1=REAL,
      yTx         : STRING;
	END_STRUCT;
END_TYPE

VAR_GLOBAL
      yEx1     {HIDDEN} : NH_EXP_RAM;

      yExp     {HIDDEN} AT mRam[_Ram0]   : ARRAY[1..100] OF NH_EXP_RAM;

      xExp     {HIDDEN} : PTR_TO NH_EXP_RAM;                   // len adresa pointra

      xRwa     {HIDDEN} : PTR_TO NH_IMP_EXP_WRK;
      w1       {HIDDEN} :  STRING[10];
      Base0    {HIDDEN} : UDINT;
      xHw      {HIDDEN} : PTR_TO NH_DEV_HW5;
      yRwa     : NH_IMP_EXP_WRK;
//   ok43  : BOOL;
//   sz43  : UDINT := 22222;

END_VAR

FUNCTION _Nh_EXP_HW  {HIDDEN}  : BOOL
   VAR_INPUT
      MapHw     : BOOL;
   END_VAR
   IF aCfg[cf].hw > 3 THEN
      IF MapHw THEN
         xHw := xPt + 1 + USINT_TO_UDINT(aCfg[cf].cf) + USINT_TO_UDINT(aCfg[cf].al) + aCfg[cf].cx;        // posun o to co je v DBX
      END_IF;
      FOR ii := 0 TO (aCfg[cf].hw / 4) - 1 DO
         xRwa^.yTx      := UDINT_TO_STRINGF(xHw^.d[ii], '%9d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[6,1] ,_ExpDev[6,0] + (ii * 10)   );
      END_FOR;
   END_IF;
END_FUNCTION


FUNCTION _Nh_EXP_DATA  {HIDDEN}  : BOOL
   VAR_INPUT
      MapHw       : BOOL := true;
      wht         : USINT;
   END_VAR
   _Nh_EXP_DATA   := true;
   CASE wht OF
     0 : //
         memset(val := 0, length := SIZEOF(yEx1), dest := VOID(yEx1));
         yEx1           := xExp^;
         yEx1.ok.ok     := true;

     1 : // z namapovanej vety v RAM do yTx2
         yTx2           :=_ExpRow; // CONCAT(_ExpRow,'$r$n');                                                 // prazdna maska

         xRwa^.yTx      := BOOL_TO_STRING(xPt^.ok.Ok);
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[8,1] ,_ExpDev[8,0]);
         xRwa^.yTx      := SINT_TO_STRINGF(xPt^.cf.Typ,'%4d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[1,1] ,_ExpDev[1,0]);
         xRwa^.yTx      := USINT_TO_STRINGF(xPt^.cf.Rom,'%3d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[2,1] ,_ExpDev[2,0]);
         xRwa^.yTx      := USINT_TO_STRINGF(xPt^.cf.cat,'%3d');
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[3,1] ,_ExpDev[3,0]);
         xRwa^.yTx      := xPt^.cf.Name;
         aBlank(txt := ADR(xRwa^.yTx), n := USINT_TO_INT(_ExpDev[4,1]));
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[4,1] ,_ExpDev[4,0]);
         xRwa^.yTx      := xPt^.cf.ID;
         aBlank(txt := ADR(xRwa^.yTx), n := USINT_TO_INT(_ExpDev[5,1]));
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[5,1] ,_ExpDev[5,0]);
         xRwa^.yTx      := BOOL_TO_STRING(xPt^.cf.Blk);
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[10,1] ,_ExpDev[10,0]);
         xRwa^.yTx      := BOOL_TO_STRING(xPt^.cf.Inv);
         yTx2           := REPLACE(yTx2,xRwa^.yTx,_ExpDev[9,1] ,_ExpDev[9,0]);

         // prirobene 7.10.22
         yTx2        := REPLACE(yTx2,aCfg[cf].cfg,_ExpDev[12,1] ,_ExpDev[12,0]);

         _Nh_EXP_HW( MapHw := MapHw);

   END_CASE;
END_FUNCTION

FUNCTION _Nh_EXP_Find_ID {HIDDEN}   : INT
   VAR_INPUT
      Del   : BOOL := true;
      ID    : STRING[5];
   END_VAR
   _Nh_Exp_find_ID   := 0;
   ix                := 0;                        // ak sa najde cista del veta
   FOR nd := 1  TO aCfg[cf].rec DO
      _NhxPt(c := cf, n := nd,x:=3);
      IF xPt^.cf.ID = ID AND _Nh_Exp_find_ID = 0 THEN
         xPt^.ok.ok        := true;

			////???? 6.7.2023 - ak uz predtym bola tato veta, mohol uzivatel prestavit INV, tak sa zoberie co tam je
			yEx1.cf.inv := xPt^.cf.inv;

         xDev2  := xPt;
         _Nh_Exp_find_ID := nd;
         IF del = false THEN
            RETURN;
         END_IF;
      END_IF;
      IF ix = 0 AND xPt^.cf.ID = '' THEN
         ix    := nd;
         xDel  := xPt;
      END_IF;
   END_FOR;
   IF _Nh_Exp_find_ID = 0 AND del THEN
      If ix > 0 THEN
         xPt               := xDel;
         xPt^.cf           := yEx1.cf;                  // do cistej vety sa preberu vsetky dostupne udaje
         xPt^.ok.ok        := true;                     // v yTx1 bude ok false
         _Nh_Exp_find_ID   := ix;
      END_IF;
   ELSIF _Nh_Exp_find_ID > 0 THEN
      xPt := xDev2;
   END_IF;
END_FUNCTION

(*
VAR_GLOBAL
   yTx10  : STRING;
   yTx11  : STRING;
END_VAR
*)


(*
FUNCTION_BLOCK _Nh_EXP_ALL	    // z existujuceho suboru .EXP vytvori uplne novy .ADR,
   VAR_INPUT
		IniDone	: USINT := 210;
   END_VAR
   VAR
      rom      : BOOL;
      data     : BOOL;
      go       : USINT;
      mxRW     : UDINT := 1000;
      nExp     : INT;
      nBck     : USINT;
      ie       : USINT;
   END_VAR

   CASE go OF
     0 : // Start
         yTx2     := '_Nh_EXP_ALL  0: Start';
         _Nh1RowTxt(logRst:=1);
         cf    	:= 0;
         Go    	:= 20;

    20 : // rozhodne o aktualizacii HW
         IF aSys.ActHWA = false THEN
            yTx2     := '_Nh_EXP_ALL 20: Nevyzaduje sa aktualizacia HW-adries (aSys.ActHWA = false)';
            _Nh1RowTxt(logRst:=1);
            Go :=    99;
         ELSE
            Go :=    50;
         END_IF;

    50 : // otvori sa exportny subor, nastartuje hladanie najskor ROM
         yTx1  := _Nh_EXP;                                                    //'NH2.EXP';
         va    := _NH_RAM - _Ram0;
         memsetEx(val := 0, length := va, dest := VOID(mRam[_Ram0]));  // pouzije yTx1-yTx2 na cistu oblast, v ktorej vymaze 999b

         IF _NhFopen(fH := fh, fN := yTx1) THEN
            fP       := 0;                                                    // nastavi sa na zaciatok exportu
            Go       := 52;
            yTx2     := CONCAT('_Nh_EXP_ALL 50: Otvoreny subor exportu: ',yTx1);
         ELSE
            yTx2     := CONCAT('_Nh_EXP_ALL 50: NENAJDENY subor exportu: ',yTx1);
            Go       := 98;
         END_IF;
         _Nh1RowTxt(logRst:=1);
			RETURN;

    51 : // vyhodnoti exportnu vetu z NH2.EXP, najde v docasnej pamati a modifikuje, alebo prida v docasneh pamati od _Ram0

         xExp  := ADR(mRam[_Ram0]);
         FOR  ix := 1 TO nExp DO
            IF xExp^.CFG = xRwa^.CFG AND xExp^.cf.ID = xRwa^.ID THEN
               Exit;
            END_IF;
            xExp := xExp + SIZEOF(NH_EXP_RAM);
         END_FOR;
         IF ix > nExp THEN
            aCfg[cf].NewExp := true;                                          // tot cfg treba aktualizovat
            nExp        := ix;
            xExp^.ok.ok := true;
            xExp^.c     := cf;
            xExp^.cfg   := aCfg[cf].cfg;
            xExp^.cf.ID := xRwa^.ID;
         END_IF;
         IF xExp^.c = 1 THEN
            xExp^.romID   := xRwa^.ID;
         ELSIF xExp^.romID = '' AND xRwa^.romID <> '' THEN
            xExp^.romID   := xRwa^.romID;
         END_IF;
         IF xExp^.cf.Name = '' AND xRwa^.Name <> '' THEN
            xExp^.cf.Name  := xRwa^.Name;
         END_IF;
         ok       := false;                              // typ sa prepise tym co je v j
         j        := STRING_TO_SINT(xRwa^.typ);
         i        := 0;                                  // poradie HW adresy
         IF cf <> 1 THEN                                    // je DEV - najde odpoverajuci ROM
            // xRwa^.RomNbr   := INT_TO_USINT(_Nh_EXP_FIND_ID_RAM(c := 1, ID := xRwa^.ROM ));
         END_IF;
         IF cf = 1 OR cf = 3 OR xExp^.cf.DevExt THEN                            // ROM
            i  := 255;
            j  := xRwa^.TypRom;
            IF j > 10 OR j < 0 THEN
               j  := 0;
            END_IF;
				CASE j OF
              1 : xExp^.cf.Rom   := 3;                           //
              2 : xExp^.cf.Rom   := 2;                           //
            ELSE xExp^.cf.Rom    := 1;                           //
            END_CASE;
            IF aSys.NewDbx THEN
					CASE j OF
   	           1 : xExp^.cf.Rom   := 3;                           //
      	        2 : xExp^.cf.Rom   := 2;                           //
         	   ELSE xExp^.cf.Rom    := 1;                           //
            	END_CASE;
            END_IF;
				xExp^.cf.Rom := MAX(1,xExp^.cf.Rom);
            ok             := true;
         ELSIF xRwa^.typ   = 'Q' THEN                    // vystup d[0]
            i := 1;
         ELSIF xRwa^.typ   = 'Y' THEN                    // vystup d[2]
            i := 2;
         ELSIF xRwa^.typ   = 'R' THEN							
            ;
         ELSIF xRwa^.typ   = 'G' THEN
            i  := 1;
         ELSIF xRwa^.typ   = 'B' THEN
            i := 2;
         ELSIF xRwa^.typ   = 'W' THEN                    // WW
            i := 3;
         ELSIF xRwa^.typ   = 'C' THEN                    // CW
            i := 5;
         ELSIF xRwa^.typ   = 'U' THEN                    // ROL-up
               ;
         ELSIF xRwa^.typ   = 'D' THEN                    // ROL-Dn
            i  := 1;
         ELSIF xRwa^.cfg   = 'TLA' THEN                  // tlacitko bude mat typ najvacsi
            IF j = 0 THEN                                // jednotlacitko nemusi mat sufix
               j := 1;
            END_IF;
            xExp^.cf.typ   := MAX(xExp^.cf.typ, j );
				i := SINT_TO_USINT(j-1);
         ELSE  ok := true;
               CASE cf OF
                   21 :    // ZAS
                     IF j = 1 THEN                                                      // zapni = vypni (inverzia),
                        xExp^.cf.inv := true;
								ok				 := false;		                                     // nema vplyv na typ, urcuje sa v SW
                     END_IF;
                   15 :    // PIR
                     IF j = 0 THEN                                                      // zapni = vypni (inverzia)
                        xExp^.cf.inv := true;                                           // signal pri rozopnuti
                     END_IF;
                    8 : ;  //TVE
						
                   23 : ;  //REK

                  END_CASE;
         END_IF;
         IF i < 255 THEN
				IF xRwa^.MEM = 'R' THEN														// z exportu sa samo oznaci podla typu premennej R/B
	            xExp^.hw.typ := 1;                                				// 0=bool,1=real
				END_IF;
          	xExp^.hw.d[i] := xRwa^.hw;                                		// HW adresy
         END_IF;
         If ok THEN
            xExp^.cf.typ := j;                                             // typ
         END_IF;
         Go := 52;
			RETURN;

    52 : // prechadza exportny subor
         WHILE _NhRowTxtNext() DO
            j := FIND(yTx1,' AT %');
            IF j > 0 THEN                                                     // len veta, ktora ma adresu
               yTx3  := LEFT(yTx1,3);
               cf    := _NhGetCFG(cfg := yTx3);                               // zisti ci mame taketo dev
               ok    := false;
               IF cf = 0 THEN ;                                               // nezname CFG
						;
               ELSIF acfg[cf].imp OR cf=1 THEN                      				// toto DEV sa importuje
                  yTx3 := yTx1;
                  va    := _NH_RAM - SIZEOF(NH_IMP_EXP_WRK);                  // uplne na konci RAM
                  xRwa  := ADR(mRam[ va ]);
                  memset(val := 0, length := SIZEOF(NH_IMP_EXP_WRK), dest := VOID(mRam[va]));  // pouzije yTx1-yTx2 na cistu oblast, v ktorej vymaze 999b
                  xRwa^.CFG   := MID(yTx1,3,1);
                  xRwa^.ID    := MID(yTx1,3,5); STRING_TO_UPPER(xRwa^.ID);
                  xRwa^.yTx   := MID(yTx1,5,8); STRING_TO_UPPER(xRwa^.yTx);
                  IF xRwa^.yTx = ' AT %' THEN                                 // nema priponu
                     xRwa^.TYP   := ' ';
                  ELSE
                     xRwa^.TYP   := MID(xRwa^.yTx,1,2);
                  END_IF;
                  IF xRwa^.ID <> 'ROM' THEN                                   // ROM nema adresu
                     // podla typu premennej sa ulozi zdresa oblasi
                     IF 	FIND(yTx1,'%QB') > 0 THEN        // vystup
                              xRwa^.IO   := 'Q';
                           {asm}
                              LEA %Y0
                              WR  Base0
            	  	         {end_asm}
                     ELSIF 	FIND(yTx1,'%IB') > 0 THEN        // vstup
                           xRwa^.IO   := 'I';
                           {asm}
          	                  LEA %X0
                              WR  Base0
                           {end_asm}
                     ELSIF 	FIND(yTx1,'%MB') > 0 THEN        // pamat
                           xRwa^.IO   := 'M';
                           {asm}
                        	  LEA %R0
                        	  WR  Base0
                           {end_asm}
//Base0 := 0;
                     END_IF;	
                     j     := FIND(yTx1,'AT %');                       // 'WSB_101_4 AT %IB486.0 : BOOL;
                     yTx1  := DELETE(yTx1,j+5,1);                      // '486.0 : BOOL;
                     j     := FIND(yTx1,' : ');
                     yTx3  := MID(yTx1,j-1,1);                         // '486.0'
                     j     := FIND(yTx3,'.');
                     IF j > 0 THEN                                      // yTx3    '172.3'
                           xRwa^.MEM   := 'B';
                           w1    := MID(yTx3,j-1,1);                    // '172'
                           yTx3  := DELETE(yTx3,j,1);                   // '3 :'
                           sz    := (Base0 + STRING_TO_UDINT( w1 ) ) * 8 + STRING_TO_UDINT( yTx3 );
                     ELSE
                           xRwa^.MEM   := 'R';
                           sz := Base0 + STRING_TO_UDINT(yTx3);         // '172'
                     END_IF;
                     xRwa^.HW   := sz;
                  END_IF;
                  // nazov, miestnost
                  j := FIND(yTx1,'(*');                     // zaciatok poznamky
                  IF j > 0 THEN
                     yTx1  := DELETE(yTx1,j+2,1);           // odreze zaciatok a zostane : ' nazov DEV ; rom ; nazov miestnosti
                     j     := FIND(yTx1,'*)');

(*                                  // koniec poznamky
                     yTx1  := DELETE(yTx1,3,j-1);           // odreze koniec
                     j := FIND(yTx1,';');                   // za nazvom je cislo miestnosti
                     IF j > 0 THEN
                        xRwa^.Name := MID(yTx1,j-1,1);      // zapise nazov
                        yTx1        := DELETE(yTx1,j,1);    // odreze zaciatok a zostane : 'nazov miestnosti '
                        IF xRwa^.cfg = 'ROM' OR xRwa^.cfg = 'ZON' THEN
                           xRwa^.TypRom   := STRING_TO_SINT(yTx1);      // pripadny typ ROM -1=nezaradene
                           xRwa^.RomID    := xRwa^.ID;          // co zostalo je ROM
                        ELSE
                           xRwa^.RomID  := yTx1;              // co zostalo je ROM
                        END_IF;
                     ELSE
                        xRwa^.Name  := yTx1;                   // cely zbytok stringu je nazov
                     END_IF;     // koniec hladania nazvu
                     aTrim(txt := ADR(xRwa^.Name), wht := 1);        // zo vsetkych stran odstrani medzewry
                  END_IF;
                  Go    := 51 ;
                  RETURN;
               END_IF;
            END_IF;
         END_WHILE;
         rb    := _NhFclose(fh := fh);                                        // zavrie exportny subor, uvolni fH
         yTx2     := CONCAT('_Nh_EXP_ALL 52: Export spracovany. Najdene CFG: ',INT_TO_STRING(nExp));
         _Nh1RowTxt(logRst:=1);

         cf             := 1;          // zacina ROM
         nd             := 1;          // zaciatok exportu
         aCfg[cf].rExp  := 0;
         aCfg[cf].new   := 0;
         xExp           := ADR(mRam[_Ram0]);

			_NhLogPath(wh:=4,fN:='EXP');
         aSys.frw.FN    := CONCAT(yTx2, 'a.REC');               // nazov noveho suboru
         rb             := FileDelete(fileName := aSys.frw.FN);
			_NhLogPath(wh:=4,fN:='EXP');

			aSys.frw.FN    := CONCAT(yTx2, 'NH2.ADR');               // nazov noveho suboru
         rb             := FileDelete(fileName := aSys.frw.FN);
         aSys.frw.FN    := CONCAT(yTx2, 'NH2.SRT');               // nazov noveho suboru
         rb             := FileDelete(fileName := aSys.frw.FN);
         Go             := 60;


			RETURN;

    60 : // sortuje vety exportu pre rovnake CFG a vytvara NH2.ADR, pocita nove vety. prva je rom
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW DO
            IF xExp^.ok.ok THEN
               IF cf = 0 THEN
                  cf             := xExp^.c;
                  aCfg[cf].rExp  := 0;
                  aCfg[cf].new   := 0;
               END_IF;
               IF xExp^.c = cf THEN
                  xExp^.ok.ok       := false;                                       // oznaci za spracovanu
                  _Nhfrw(mode := 2, fW := xExp,  sz := SIZEOF(NH_EXP_RAM), row := false);
               END_IF;
            END_IF;
            xExp  := xExp + SIZEOF(NH_EXP_RAM);
            nd    := nd + 1;
            IF nd > nExp THEN
               IF cf = 0 THEN                                        // vsetky Cf , ktore su v exporte boli spracovane
                  yTx2  := '_Nh_EXP_ALL 60: Export zosortovany';
                  _Nh1RowTxt(logRst:=1);
                  _NhFclose(fh := aSys.frw.fH);
                  Go    := 62;
               ELSE
                  cf       := 0;
                  nd       := 1;
                  xExp     := ADR(mRam[_Ram0]);                                     // od prvej exportnej vety
               END_IF;
					RETURN;
            END_IF;
         END_WHILE;

     62 : // prvykrat obnovi DBX->RAM bez pridania viet , v DBX uz budu urcite dobre data, lebo ich vytvorila INI procedura
	         yTx2  := '_Nh_EXP_ALL 62: Vrati DBX->RAM po spracovani exportu';
   	      _Nh1RowTxt(logRst:=1);
      	   _Nh_Go_DbxToMem(dbx := false);
				go          := 63;

     63 : // oznaci za vymazane vsetky vety , ktore maju priznak import, teda budu naexportovane
         yTx2  := '_Nh_EXP_ALL 63: Oznaci DEL vety aCfg[cf].imp ';
         _Nh1RowTxt(logRst:=1);
			FOR cf := 1 TO _Nh_CFG DO
				IF aCfg[cf].imp THEN
					FOR nd := 1 TO aCfg[cf].rec DO
						_NhxPt(c:=cf, n:=nd ,x:=73);
						xPt^.ok.ok := false;
   	         END_FOR;
      		END_IF;
         END_FOR;
         go          := 64;
         nExp        := 0;
         aSys.frw.fP := BEGIN_POS;                 // dolezite nastavit na zaciatok
			RETURN;

     64 : // cita vety z exportu, hlada ju v RAM
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW * 10 DO
            nExp := nExp + 1;
            sz := SIZEOF(NH_EXP_RAM);
            IF _Nhfrw(mode := 0, fW := ADR(yEx1),  sz := sz, row := false)  THEN
               cf := yEx1.c   ;
               xPt := ADR(yEx1);
                  _NhLogPath(wh:=4,fN:='EXP');
               yTx1 := CONCAT(yTx2,'a.REC');             // subor vsetkych exportovanych DEV = to iste co je
               xHw  := ADR(yEx1.hw);
               _Nh_EXP_DATA( wht := 1, MapHw := 0);             // naplni z realnej vety RAM -> yTx2
               _Nh1RowTxt();
               IF _Nh_Exp_find_ID(ID := yEx1.cf.ID) = 0 THEN
                  aCfg[cf].new := aCfg[cf].new + 1;
					END_IF;
            ELSE
               _NhFclose(fh := aSys.frw.fH);
               Go := 66;
               RETURN;
            END_IF;
         END_WHILE;

     66 : // zalohuje modifikacie ID, a spat obnovi DBX->RAM a prida nove vety



         yTx2  := '_Nh_EXP_ALL 66: RAM->DBX , DBX->RAM prida nove vety ';
         _Nh1RowTxt(logRst:=1);



         _Nh_Go_DbxToMem(ForceRamOk := true, dbx := false);


// aSys.Ini := 217;
//	RETURN;



         go          := 70;
         aSys.frw.fP := BEGIN_POS;                 // dolezite nastavit na zaciatok
         yTx2     := '_Nh_EXP_ALL 66: Zacina Update ROM.';
         _Nh1RowTxt(logRst:=1);
         nExp  := 0;

    70 : // prechadza NH2.SRT , najskor len ROM
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW * 2 DO
            IF _Nhfrw(mode := 0, fW := ADR(yEx1),  sz := SIZEOF(NH_EXP_RAM), row := false)  THEN
               IF yEx1.c <> 1 THEN
                  aSys.frw.fP := aSys.frw.fP - aSys.frw.fR;
                  yTx2     := CONCAT('_Nh_EXP_ALL 70: Koniec Update ROM. n: ',INT_TO_STRINGF(ix,'%3d'));
                  _Nh1RowTxt(logRst:=1);
                  Go := 71;
                  RETURN;
               ELSE
                  nExp := nExp + 1;
               END_IF;
               cf    := yEx1.c;
               nd    := _Nh_Exp_find_ID(ID := yEx1.cf.ID);                                   // vzdy najskor hlada ROM
               IF nd > 0 THEN             // nasla sa veta s ID, alebo cista DEL-veta do ktorej sa prave zapisalo ID
//                  xPt^.cf := yEx1.cf;
                  xPt^.cf.typ := yEx1.cf.typ;
                  IF xPt^.cf.Name = '' THEN                                         // prazdny nazov sa pokusi nahrdit
                     xPt^.cf.Name := yEx1.cf.Name;
                  END_IF;
                  IF xPt^.cf.Rom <= 1 THEN                                         // prazdny nazov sa pokusi nahrdit
                     xPt^.cf.Rom := MAX(1, yEx1.cf.rom);
                  END_IF;
                  xPt^.ok.ok := true;                                                     // kazda vz exportu bude platna
               ELSE                                                                    // nesmie byt
                  yTx2     := CONCAT('_Nh_EXP_ALL 70: ERR!!! Nenaslo sa CFG,ID;ix: ',yEx1.CFG,';',yEx1.cf.ID,';',INT_TO_STRINGF(ix,'%3d'));
                  _Nh1RowTxt(logRst:=1);

			// ak bude problem zostane v 2177
         aSys.Ini := 217;
			RETURN;

               END_IF;
            ELSE                                                                 // vsetky vety NH2.ADR prejdene, xDEV aktualizovane
               Go := 98;
               RETURN;
            END_IF;
         END_WHILE;

    71 : // prechadza NH2.SRT pre ostatne DEV ako ROM
         aSys.frw.fA := 0;
         WHILE aSys.frw.fA < mxRW DO
            IF _Nhfrw(mode := 0, fW := ADR(yEx1),  sz := SIZEOF(NH_EXP_RAM), row := false)  THEN
               cf    := yEx1.c;
               nd := _Nh_Exp_find_ID(ID := yEx1.cf.ID);                                  // teraz sa hlada veta DEV

               IF nd > 0 THEN             // nasla sa veta s ID, alebo cista DEL-veta do ktorej sa prave zapisalo ID aj cele .cf
                  IF xPt^.cf.Name = '' THEN                                         // prazdny nazov sa pokusi nahrdit
                     xPt^.cf.Name := yEx1.cf.Name;
                  END_IF;
                  xPt^.cf.typ := yEx1.cf.typ;                                     // ?? Typ by mal byt urceny uz v IO manazeri
                  xPt^.cf.inv := yEx1.cf.inv;                                     // INV je dolezite u PIR,ZAS,TVE

                  // aktualizuju sa HW adresy
                  xHw   := xPt + 1 + USINT_TO_UDINT( aCfg[cf].cf) + USINT_TO_UDINT(aCfg[cf].al) + aCfg[cf].cx;
                  jj    := USINT_TO_SINT(aCfg[cf].hw) / 4 - 1 ;                           // pocet HW-adries  1=0, lebo sa zadina d.[0]

                  xHw^.typ :=  yEx1.hw.typ;
                  xHw^.cfg :=  yEx1.hw.cfg;
                  FOR j := 0 TO jj DO
                     xHw^.d[j] :=  yEx1.hw.d[j];
                  END_FOR;
                  xPt^.ok.ok  := true;                                              // kazda vz exportu bude platna
                  xDev        := xPt;
                  // nakoniec najde ROM. POZOR !!! zmeni sa CF, ale uz sa dalej nebude potrebovat
                  IF xPt^.cf.rom = 0 THEN                                         // prazdny nazov sa pokusi nahrdit
                     cf    := 1;
                     xDev^.cf.Rom := INT_TO_USINT(_Nh_Exp_find_ID(ID := yEx1.RomID, del := false)); // len sa najde cislo rom
                  END_IF;
               ELSE                                                                // nesmie byt
                  yTx2     := CONCAT('_Nh_EXP_ALL 71: ERR!!! Nenaslo sa CFG,ID;ix: ',yEx1.CFG,';',yEx1.cf.ID,';',INT_TO_STRINGF(ix,'%3d'));
                  _Nh1RowTxt(logRst:=1);

			// ak bude problem zostane v 2177
//         aSys.Ini := 217;
//			RETURN;

               END_IF;
            ELSE                                                                 // vsetky vety NH2.ADR prejdene, xDEV aktualizovane
               Go := 98;
               RETURN;
            END_IF;
         END_WHILE;

    90 : // cakacka pre ladenie
         aSys.Ini := 217;

    98 : // zatvori subory
         yTx2     := '_Nh_EXP_ALL 98: Koniec exportu.';
         _Nh1RowTxt(logRst:=1);
         _NhCloseAllFiles();
         Go       := 99;
    99 : // koniec
         _Nh_Go_MemToDBX();                               // ulozi aj s novymi adresami
         go       := 0;
         aSys.Ini := IniDone;
   END_CASE;
END_FUNCTION_BLOCK
*)

{ $ END_IF  } 	





