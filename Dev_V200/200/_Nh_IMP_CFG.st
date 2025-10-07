(* DEFINICIA OBRAZOVKY BROWSU/FORMULARA/MENU  KTORE SA ULOZIA A NA SD *)

TYPE



END_TYPE

VAR_GLOBAL
	xHw      	{HIDDEN} 	: PTR_TO NH_DEV_HW5;	
//   yFrmName AT mObr  		{HIDDEN} : NH_FRM_HED;              // head of template
//	yFrmData	AT mObr[34]		{HIDDEN} : USINT;	//NH_LOG_HEAD;		// data of template
	yFrm_500	AT mObr			{HIDDEN} : NH_FRM_500;					// import from NH2.exp
	yFrm_250	AT mObr			{HIDDEN} : NH_FRM_250;					// import from NH2.exp
	yImp		AT yFrmData		{HIDDEN} : NH_LOG_IMP;					// only struct import
//   xFrmHed           		{HIDDEN} : PTR_TO NH_FRM_SAVE_MAP;  // head for saving

	// ladenie


END_VAR


FUNCTION _Nh_Import_CIB_Find_ID {HIDDEN}   : BOOL
	VAR_INPUT
		ok		: BOOL;
		cf		: USINT;
		ID		: STRING[5];
	END_VAR
	nDel	:= 0;	
	_Nh_Import_CIB_Find_ID := false;
   FOR nd := 1  TO aCfg[cf].rec DO
      IF _NhxPt(c:=cf, n:=nd, ok:=ok, x:=3) THEN
	      IF xPt^.ok.ok AND xPt^.cf.ID = ID THEN
				_Nh_Import_CIB_Find_ID := true;
				EXIT;
			ELSIF nDel > 0 THEN
				;
   	   ELSIF xPt^.ok.ok=false AND xPt^.cf.ID = '' THEN
				_Nh_Import_CIB_Find_ID := true;
				nDel 	:= nd;	
				xDel	:= xPt;
	      END_IF;
		END_IF;
   END_FOR;
END_FUNCTION


FUNCTION _Nh_Import_CIB_To_MEM {HIDDEN}   : BOOL
	_Nh_Import_CIB_To_MEM := true;
	WHILE true DO
		cf	:= STRING_TO_USINT(yImp.cf);
		IF _Nh_Import_CIB_Find_ID(ok:=true, cf:=cf, ID:=yImp.ID) THEN
			IF nDel > 0 THEN
				xPt	:= xDel;
				nd		:= nDel;
				y:=y+1;
			ELSE
				x:=x+1;
			END_IF;
			xDev	:= xPt;

			xDev^.ok.ok		:= true;
			xDev^.cf.ID		:= yImp.ID;	
			xDev^.cf.idx 	:= nd;	   		
			yImp.NameCf		:= xDev^.cf.Name;	
			IF yImp.Name = '' THEN
				;
			ELSIF xDev^.cf.Name = '' THEN
				xDev^.cf.Name := yImp.Name;	   		
			END_IF;

			IF yImp.cfg <> 'ROM' THEN
				IF yImp.cfg = 'TLA'  THEN
					xDev^.cf.typ := MAX(xDev^.cf.typ,STRING_TO_SINT(yImp.Typ));	
//			 	ELSIF aSys.NewDBX THEN				
			 	ELSIF yImp.typYes = 'Y' THEN
					xDev^.cf.typ := STRING_TO_SINT(yImp.Typ);	
				END_IF;
			 	IF aSys.NewDBX THEN
	            xDev^.cf.Inv :=  STRING_TO_BOOL(yImp.inv);
				END_IF;		
           	// aktualizuju sa HW adresy
				xHw   := xDev + 1 + USINT_TO_UDINT( aCfg[cf].cf) + USINT_TO_UDINT(aCfg[cf].al) + aCfg[cf].cx;
            i     := STRING_TO_USINT(yImp.d) ;                           // pocet HW-adries  1=0, lebo sa zadina d.[0]
            xHw^.typ :=  STRING_TO_USINT(yImp.HWtyp);
//            xHw^.cfg :=  yEx1.hw.cfg;

			 	xHw^.d[i] := STRING_TO_UDINT(yImp.HWs);
				IF  yImp.RomID <> '' THEN
					IF _Nh_Import_CIB_Find_ID(cf:=1,ID:=yImp.RomID) THEN
						yImp.rom		:= INT_TO_STRINGF(nd,'%3u');	
						IF xDev^.cf.rom = 0 THEN
							xDev^.cf.rom := INT_TO_USINT(nd);
						END_IF;
					END_IF;
         	END_IF;
			ELSE	// ROM,ZON
				IF xDev^.cf.rom = 0 THEN       		// rom,zone
					xDev^.cf.rom := STRING_TO_USINT(yImp.rom);				// nadradena zona
				END_IF;
				IF aSys.NewDBX THEN
					xDev^.cf.typ := STRING_TO_SINT(yImp.TypRom);	
				END_IF;
			END_IF;			
			EXIT;
		ELSE
			z:=z+1;
			aCfg[cf].new := aCfg[cf].new + 1;
			_Nh_Go_DbxToMem(ForceRamOk:=true);
		END_IF;
	END_WHILE;
	yImp.ok := '1';
	fbLine(write:=true,seek:=fbLine.LineS);
END_FUNCTION

FUNCTION_BLOCK _Nh_Import_CIB	// kopia vsetkych, alebo modifikovanych CFG/PAR/VAZ na USB (z MEM/RAM/DBX)
	VAR_INPUT
		Go				: USINT;				
	END_VAR                        	
	VAR_OUTPUT
		Done			: BOOL;
		busy			: BOOL;
		err			: BOOL;
//		nExp			: UINT;
//		cyc			: UINT ;
	END_VAR
	VAR

	END_VAR
	done	:= false;		
	CASE Go OF
     	0:	RETURN;
     	1:		// start import
				x	:= 0;
				_Nh_FRM_Read(frm:=500);   	
				yTx2	:= CONCAT('.Import from: ',_Nh_EXP);
				_Nh1RowTxt(logRst:=1);
				yTx1		:=  _Nh_EXP;
           	fbFileRWa(init:=true,exec:=true,line:=true, adrVar:=PTR_TO_UDINT(ADR(yTx0)),fileName:=yTx1);
				IF fbFileRWa.err THEN
					Go	:= 99;         			
				ELSE
					busy	:= true;	grp:=0;
					Go		:= 11;         				
//					_Nh_Log_Path(wh:=4,fN:='EXP');
//					yTx0	:= CONCAT(yTx2, 'cib.txt');
					
					yTx0  := CONCAT( aSys.ADR_DBX,DT_TO_STRINGF(aSys.NhDT,'%Thh_mm.cib'));

					yTx2	:= CONCAT('.Import to: ',yTx0);
					_Nh1RowTxt(logRst:=1);
					fbLine(open:=true,del:=true,seek:=0,nLine:=1, aLine:=PTR_TO_UDINT(ADR(yImp)) ,sLine:=SIZEOF(yImp));
				END_IF;

		16:	// prejde DEV ine ako ROM a podla RomID zisti cislo ROM
				IF fbLine.LineS = 0 THEN
					grp:=0;x:=0;y:=0;z:=0;
					yTx2 	:= '..Start check Dev' ;
					_Nh1RowTxt(logRst:=1);
				END_IF;
				grp:=grp+1;          											// pocitadlo cyklov
				WHILE go=16 DO	// _NhMaxRWLimit() //OR _NhMaxTimeCyc()
					fbLine(write:=false,seek:=fbLine.LineS+1);
					IF fbLine.done AND yImp.cfg <> 'ROM' THEN

						_Nh_Import_CIB_To_MEM();

//						yTx2	:= CONCAT('...Dev: ',yImp.CFG,'  ',TIME_TO_STRINGF(SUB_DT_DT(GetRtc(),aSys.NhDT),'%Ts.zzz'),'  ',UDINT_TO_STRING(aSys.RWtoFileCycle) );
//						_Nh1RowTxt(logRst:=1);
						IF _NhMaxRWLimit() OR _NhMaxTimeCyc() THEN
							EXIT;
						END_IF;
					END_IF;
					IF fbLine.LineS = 0 THEN
						yTx2	:= CONCAT(	'..End   check Dev.',	TIME_TO_STRINGF(_NhGetTimeCyc(),' %Ts.zzz '),
												'cyc',INT_TO_STRINGF(grp,'%3u ' ),	
												'x:',	INT_TO_STRINGF(x,'%4u '),
												'y:',	INT_TO_STRINGF(y,'%4u '),
												'z:',	INT_TO_STRINGF(y,'%4u '),
												'rw:',  UDINT_TO_STRINGF(aSys.RWtoFileCycle,' %7u ' )
											);		
						_Nh1RowTxt(logRst:=1);
//						Go	:= 19;         			
						Go	:= 99;         			
					END_IF;
				END_WHILE;

		15:	// prejde ROM a podla RomID zapise cislo vety do ROM
				IF fbLine.LineS = 0 THEN
					grp:=0;x:=0;y:=0;z:=0;
					yTx2 	:= '..Start check ROM' ;
					_Nh1RowTxt(logRst:=1);
				END_IF;
				grp:=grp+1;
				WHILE go=15 DO
					fbLine(write:=false,seek:=fbLine.LineS+1);
					IF fbLine.done AND yImp.cfg = 'ROM' THEN
						_Nh_Import_CIB_To_MEM();


						IF _NhMaxRWLimit() OR _NhMaxTimeCyc() THEN
							EXIT;
						END_IF;
					END_IF;
					IF fbLine.LineS = 0 THEN
						yTx2	:= CONCAT(	'..End   check ROM.',TIME_TO_STRINGF(_NhGetTimeCyc(),' %Ts.zzz '),
												'cyc',INT_TO_STRINGF(grp,'%3u ' ),	
												'x:',	INT_TO_STRINGF(x,'%4u '),
												'y:',	INT_TO_STRINGF(y,'%4u '),
												'z:',	INT_TO_STRINGF(y,'%4u '),
												'rw:',  UDINT_TO_STRINGF(aSys.RWtoFileCycle,' %7u ' )
											);		
						_Nh1RowTxt(logRst:=1);
						Go	:= 16;         			
					END_IF;
				END_WHILE;

		19:	//

            { $IFDEF __NH_WRK }
               _NhDataWrk();
            { $END_IF }

		11:	// prejede /NH2.exp, vytvori z neho /RAM/EXP/cib.CSV	
//				yTx1		:=  _Nh_EXP;
				grp:=grp+1;          											// pocitadlo cyklov
				WHILE Go=11 DO	
					fbFileRWa(fileName:=yTx1);
					IF fbFileRWa.done OR fbFileRWa.err	THEN
						yTx2	:= CONCAT('.End Import.',TIME_TO_STRINGF(_NhGetTimeCyc(),' %Ts.zzz '),
													 'cyc:',  INT_TO_STRINGF(grp,'%5u '),
													 'rec:',  INT_TO_STRINGF(x,'%5u ' ),
													 'rw:',  UDINT_TO_STRINGF(aSys.RWtoFileCycle,' %7u ' )													
											);		
						_Nh1RowTxt(logRst:=1);
						fbLine.LineS:=0;
						Go := 15;		
					ELSIF fbFileRWa.row THEN
						j := FIND(yTx0,' AT %');
            		IF j > 0 THEN                                                     // len veta, ktora ma adresu
//							yTx2 	:= CONCAT(UDINT_TO_STRINGF(aSys.RWtoFileCycle,'%10u '), TIME_TO_STRING(SUB_DT_DT(GetRtc(),aSys.NhDT)),'  ',yTx0) ;
//							_Nh1RowTxt(logRst:=1);
							x			:= x + 1;
							yImp		:=  yFrm_500.eImp;
							yImp.cfg	:= MID(yTx0,3,1);
               		cf    	:= _NhGetCFG(cfg := yImp.cfg);                               // zisti ci mame taketo dev
							yImp.cf	:= USINT_TO_STRINGF(cf,'%3u');               		
							ok    := false;
               		IF cf = 0 THEN                                                // nezname CFG
								yTx2 	:= CONCAT('...Unknown cfg: ',yTx0) ;
								_Nh1RowTxt(logRst:=1);
               		ELSIF acfg[cf].imp THEN                      				// toto DEV sa importuje
								yImp.ID	:= MID(yTx0,3,5);   STRING_TO_UPPER(yImp.ID);
								yTx3					:= MID(yTx0,5,8);   STRING_TO_UPPER(yTx3);
		                  IF yTx3 = ' AT %' THEN                                 // nema priponu
//                     		yImp.TYP   := ' ';
                 			ELSE
                     		yImp.TYP   := MID(yTx3,1,2);
                  		END_IF;
                  		IF yImp.ID <> 'ROM' THEN                                   // ROM nema adresu
		                     // podla typu premennej sa ulozi zdresa oblasi
      		               IF 	FIND(yTx0,'%QB') > 0 THEN        // vystup
                              yImp.IO   := 'Q';
	                           {asm}
   	                           LEA %Y0
      	                        WR  Base0
         	   	  	         {end_asm}
            		         ELSIF 	FIND(yTx0,'%IB') > 0 THEN        // vstup
                           	yImp.IO   := 'I';
                           	{asm}
          	                  	LEA %X0
	                              WR  Base0
   	                        {end_asm}
      		               ELSIF 	FIND(yTx0,'%MB') > 0 THEN        // pamat
            	               yImp.IO   := 'M';
                           	{asm}
	                        	  LEA %R0
   	                     	  WR  Base0
      	                     {end_asm}
									END_IF;
         	            END_IF;	
	                     j     := FIND(yTx0,'AT %');                       // 'WSB_101_4 AT %IB486.0 : BOOL;
	                     yTx0  := DELETE(yTx0,j+5,1);                      // '486.0 : BOOL;
	                     j     := FIND(yTx0,' : ');
	                     yTx3  := MID(yTx0,j-1,1);                         // '486.0'
	                     j     := FIND(yTx3,'.');
	                     IF j > 0 THEN                                      // yTx3    '172.3'
                           yImp.MEM   := 'B';
                           _LangTXT   := MID(yTx3,j-1,1);                    // '172'
                           yTx3  := DELETE(yTx3,j,1);                   // '3 :'
                           sz    := (Base0 + STRING_TO_UDINT( _LangTXT ) ) * 8 + STRING_TO_UDINT( yTx3 );
   	                  ELSE
                           yImp.MEM   := 'R';
                           sz := Base0 + STRING_TO_UDINT(yTx3);         // '172'
      	               END_IF;
//         	            yImp.HW   := sz;
         	            yImp.HWs  := UDINT_TO_STRINGF(sz,'%8u');
							
	                  	// nazov, miestnost
		                  j := FIND(yTx0,'(*');                     // zaciatok poznamky
   		               IF j > 0 THEN
      		               yTx0  := DELETE(yTx0,j+2,1);           // odreze zaciatok a zostane : ' nazov DEV ; rom ; nazov miestnosti
         		            j     := FIND(yTx0,'*)');					// koniec poznamky
               	      	yTx0  := DELETE(yTx0,3,j-1);           // odreze koniec
	               	      j := FIND(yTx0,';');                   // za nazvom je cislo miestnosti			'nazov;104'
	                  	   IF j > 0 THEN
   	                  	   yImp.Name 	:= MID(yTx0,j-1,1);      	// zapise nazov         		'nazov'
	                        	yTx0        			:= DELETE(yTx0,j,1);    	// odreze zaciatok 				'104' .. ' 104'
		                     	aTrim(txt := ADR(yTx0), wht := 1);        		// zo vsetkych stran odstrani medzewry
      	                  	IF yImp.cfg = 'ROM' OR yImp.cfg = 'ZON' THEN
											yImp.TypRom	:= yTx0;  					// pripadny typ ROM -1=nezaradene
            	               	yImp.RomID  := yImp.ID;    // co zostalo je ROM
               	         	ELSE
                  	         	yImp.RomID  := yTx0;              // co zostalo je ROM
										END_IF;
							      END_IF;
            	        		aTrim(txt := ADR(yImp.Name), wht := 1);        // zo vsetkych stran odstrani medzewry
   	                  ELSE
      	                  yImp.Name  := '';
         	            END_IF;     // koniec hladania nazvu


//                        yImp.typYes	:= ' ';

				            j  := STRING_TO_SINT(yImp.TypRom);
								i	:= 1;
					         IF cf = 1 THEN
									CASE j OF
                             1 : i := 3;					// vnutorna miestnost -> 1.NP
                             2 : i := 2;					// vonkajsia miestnost -> Vonku
                             3 : i := 5;              // podzemna  miestnost -> Podzemie
									ELSE i := 1; 					// ostatne -> domcek
                           END_CASE;
									yImp.Rom 	:= USINT_TO_STRINGF(i,'%3u');
									yImp.TypRom :=  SINT_TO_STRINGF(j,'%1d');							
					         ELSIF cf = 3 THEN
									CASE j OF
                             2 : i := 2;					// vonkajsia zona -> Vonku
									ELSE 	i := 1; 					// ostatne -> domcek
                           END_CASE;
									yImp.Rom 	:= USINT_TO_STRINGF(i,'%3u');
									yImp.TypRom :=  SINT_TO_STRINGF(j,'%1d');							
				         	ELSIF yImp.typ   = 'Q' THEN                    // vystup d[0]
					            yImp.d := '1';
					         ELSIF yImp.typ   = 'Y' THEN                    // vystup d[2]
					            yImp.d := '2';
					         ELSIF yImp.typ   = 'R' THEN							
					            ;
					         ELSIF yImp.typ   = 'G' THEN
					            yImp.d  := '1';
					         ELSIF yImp.typ   = 'B' THEN
						         yImp.d := '2';
					         ELSIF yImp.typ   = 'W' THEN                    // WW
						         yImp.d := '3';
					         ELSIF yImp.typ   = 'C' THEN                    // CW
						       	yImp.d := '5';
					         ELSIF yImp.typ   = 'U' THEN                    // ROL-up
               				;
					         ELSIF yImp.typ   = 'D' THEN                    // ROL-Dn
					            yImp.d  := '1';
					         ELSIF yImp.cfg   = 'TLA' THEN                  // tlacitko bude mat typ najvacsi
                        	yImp.typYes	:= 'Y';
	            	         IF yImp.typ = '0' OR yImp.typ = ' ' THEN                                                      // zapni = vypni (inverzia),
										yImp.typ := '1';
									END_IF;
                           i := STRING_TO_USINT(yImp.typ)- 1;
						       	yImp.d := USINT_TO_STRINGF(i,'%1u');
					         ELSE  ok := true;
                        	yImp.typYes	:= 'Y';
				               CASE cf OF
				                   21 :    // ZAS
				            	         IF yImp.typ = '1' THEN                                                      // zapni = vypni (inverzia),
				         	               yImp.inv := '1';
													ok				 := false;		                                     // nema vplyv na typ, urcuje sa v SW
				   	                  END_IF;
				                   15 :    // PIR
				            	         IF yImp.typ = '0' THEN                                                      // zapni = vypni (inverzia),
				         	               yImp.inv := '1';
				   	                  END_IF;
				                    8 : ;  //TVE
				                   23 : ;  //REK
            			      END_CASE;
					         END_IF;

//					         IF i < 255 THEN
									IF yImp.MEM = 'R' THEN														// z exportu sa samo oznaci podla typu premennej R/B
						            yImp.HwTyp := '1';                                				// 0=bool,1=real
									END_IF;
//					          	xExp^.hw.d[i] := xRwa^.hw;                                		// HW adresy
//					         END_IF;
								
								fbLine(append:=true);
							ELSE
								yTx2 	:= CONCAT('..No imported: ',yTx0) ;
								_Nh1RowTxt(logRst:=1);
							END_IF;

						END_IF;
					END_IF;
					IF _NhMaxRWLimit() OR _NhMaxTimeCyc() THEN
//   					EXIT;		
					END_IF;
				END_WHILE;

//				aSys.ini := 217;
//				RETURN;
				

		99:	//	
				fbLine(close:=true,seek:=0);
				done	:= true;
				busy	:= false;
				Go		:= 0;
	END_CASE;
END_FUNCTION_BLOCK	

