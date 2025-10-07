// aaa
VAR_GLOBAL
//	yVer	AT mRam[20000]	: NH_DBX_VER;            // verzia sa umiestni dalej do virtualne pamati. Na zaciatku sa pouzije a potom sa prepisuje datami
//   aDbx	AT mRam[0]	: NH_DBX;
   aCfg 	AT mRam[_Cfg0]	: ARRAY[1.._Nh_CFG] OF NH_CFG_CFG :=  [
			(cfg:='ROM',
                     ver:=1,
                     Siz   := SIZEOF(NH_ROM),                         // 1
                     al    := SIZEOF(NH_ROM.AL),
                     cx    := SIZEOF(NH_ROM.CX),
                     hw    := 0,                         // 1
                     io    := SIZEOF(NH_ROM.IO),                         // 1
                     me    := SIZEOF(NH_ROM.ME),                         // 1
                     cat   := 0,
                     fBr   := 14,
                     fSc   := 204,
                     mWsb  := 1,
                     mnu   := 25,
//                     wh    := 100,        // zobrazenie teploty v browse
                     ar2   := 1,
                     stp   := 0,

                     ref   := 252,
							del   := 1,								
                     imp   := 1,
							bck	:= 1,
							RomIsZone:=1,	

							NbrPoi:=1,
							),
         (cfg:='CAT',
                     ver:=0,
//                     Siz   := SIZEOF(NH_CAT),                         // 1
//                     al    := SIZEOF(NH_CAT.AL),
                     Siz   := 0,                         // 1
                     al    := 0,
                     cx    := 0,
                     hw    := 0,                         // 1
                     me    := 0,                         // 1
                     cat   := 0,
                     ar2   := 1,
                     stp   := 0,
                     fBr   := 12,
                     del   := 0,
                     ref   := 251,
							del   := 0,								
                     imp   := 0,
							bck	:= 0,	
                     ),


				(cfg:='ZON',
                     ver:=1,
                     Siz   := SIZEOF(NH_ROM),                         // 1
                     al    := SIZEOF(NH_ROM.AL),
                     cx    := SIZEOF(NH_ROM.CX),
                     hw    := 0,                         // 1
                     io    := SIZEOF(NH_ROM.IO),                         // 1
                     me    := SIZEOF(NH_ROM.ME),                         // 1
                     par   := 5,
                     fBr   := 14,
                     fSc   := 204,
                     mWsb  := 3,
                     mnu   := 24,
                     cat   := 0,
                     ar2   := 1,
                     stp   := 0,

                     ref   := 252,
							tgrp	:= 3,	
							del   := 1,								
                     imp   := 0,
							bck	:= 1,
							RomIsZone:=1,	
			            ),
			(cfg:='SCN',                                                   // 4
                     ver:=1,
                     Siz   := SIZEOF(NH_SCN),
                     al    := SIZEOF(NH_SCN.AL),
                     cx    := SIZEOF(NH_SCN.CX),
                     me    := SIZEOF(NH_SCN.ME),
                     hw    := 0,                         // 1
							cat	:= 53,
                     sld   := 0,
                     par   := 10,
                     ou    := 1,
                     lst   := 1,
                     stp   := 1,
                     del   := 1,

                     fBr   := 5,
                     fSc   := 204,
                     mWsb  := 4,
                     mnu   := 93,
//                     analog:= 0,
                     tgrp  := 4,
//							analog:=true,
							zone	:=true,
							del   := 1,								
                     imp   := 0,
							bck	:= 1,	
							Visible:=1,
					      ),
			(cfg:='ACT',                                                   // 5
                     ver:=1,
                     Siz   := SIZEOF(NH_ACT),
                     al    := SIZEOF(NH_ACT.AL),
                     cx    := 0,
                     fBr   := 5,
                     fSc   := 204,
                     par   := 0,
                     cat   := 0,
							mWsb	:= 5,	
                     mnu   := 94,
                     lst   := 1,
                     stp   := 1,
                     ou    := 0,
                     analog:= 0,
                     tgrp  := 5,
							zone	:=true,
							del   := 1,								
                     imp   := 0,
							bck	:= 1,
							RomIsZone:=1,	
							Visible:=1,
			            ),

         (cfg:='HET',                            		                    // 6
                     ver:=1,
                     Siz   := SIZEOF(NH_HET),
                     al    := SIZEOF(NH_HET.AL),
                     cx    := SIZEOF(NH_HET.CX),
                     hw    := 0,
                     me    := SIZEOF(NH_HET.ME),
                     io    := SIZEOF(NH_HET.IO),
                     fBR   := 23,
                     fSc   := 204,
                     mnu   := 28,
                     par   := 9,
          				mWsb	:= 6,
			            cat   := 5,
//                     cou   := 2,
                     sld   := 0,
//                     wh    := 100,        // zobrazenie teploty v browse
                     ou    := 0,       // ???? 23.11.2021
                     ref   := 251,
                     tgrp  := 6,
                    	lst	:= 1,
							del   := 1,								
                     imp   := 0,
							bck	:= 1,	
							ShwSta:=true,

							NbrPoi:=2,
							Imp_AL:=1,
                     ),

			(cfg:='KOT',                            	                       // 7
                     ver:=1,
                     Siz   := SIZEOF(NH_TVE),
                     al    := SIZEOF(NH_TVE.AL),
                     cx    := SIZEOF(NH_TVE.CX),
                     hw    := SIZEOF(NH_TVE.HW),
                     io    := SIZEOF(NH_TVE.IO),
                     me    := SIZEOF(NH_TVE.ME),
                     fBR   := 22,
                     mnu   := 36,
                     fSc   := 204,
                     cat   := 39,
                     sld   := 0,
                     par   := 0,
                     ou    := 1,
							del   := 0,								
                     imp   := 1,
							bck	:= 1,	
							Imp_AL:=1,
                     ),

			(cfg:='TVE',                            	                       // 8
                     ver:=1,
                     Siz   := SIZEOF(NH_TVE),
                     al    := SIZEOF(NH_TVE.AL),
                     cx    := SIZEOF(NH_TVE.CX),
                     hw    := SIZEOF(NH_TVE.HW),
                     io    := SIZEOF(NH_TVE.IO),
                     me    := SIZEOF(NH_TVE.ME),
                     fBR   := 22,
                     mnu   := 36,
                     fSc   := 204,
                     cat   := 39,
                     sld   := 0,
                     par   := 0,
                     ou    := 1,
							del   := 0,								
                     imp   := 1,
							bck	:= 1,	
							Imp_AL:=1,

                     ),
			(cfg:='CER',                               							  // 9
                     ver:=1,
                     Siz   := SIZEOF(NH_TVE),
                     al    := SIZEOF(NH_TVE.AL),
                     cx    := SIZEOF(NH_TVE.CX),
                     hw    := SIZEOF(NH_TVE.HW),
                     io    := SIZEOF(NH_TVE.IO),
                     me    := SIZEOF(NH_TVE.ME),
                     fBR   := 22,
                     mnu   := 36,
                     fSc   := 204,
                     cat   := 39,
                     sld   := 0,
                     par   := 0,
                     ou    := 1,
							del   := 0,								
                     imp   := 1,
							bck	:= 1,	
							Imp_AL:=1,

			            ),
         (cfg:='SVD',                                                      // 10
                     ver:=1,
                     Siz   := SIZEOF(NH_SVD), 		
                     al    := SIZEOF(NH_SVD.AL),
                     cx    := SIZEOF(NH_SVD.CX),
                     hw    := SIZEOF(NH_SVD.HW),
                     cat   := 1,
                     sld   := 0,
							lst	:= 1,
                     par   := 1,
                     ou    := 1,
                     fBr   := 43,
                     fSc   := 204,
                     mnu   := 45,
                     mWsb  := 10,
							ShwSta:=true,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
//                     adObr2:= 1,
			            ),
			(cfg:='SVA',                                                      // 11
                     ver:=1,
                     Siz   := SIZEOF(NH_SVA), 		
                     al    := SIZEOF(NH_SVA.AL),
                     cx    := SIZEOF(NH_SVA.CX),
                     hw    := SIZEOF(NH_SVA.HW),
                     cat   := 1,
							lst	:= 1,
                     sld   := 1,
                     par   := 2,
                     ou    := 1,
                     fBr   := 43,
                     fSc   := 204,
                     mWsb  := 11,
                     mnu   := 45,
                     analog:=true,
							ShwSta:=true,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
			            ),
			(cfg:='RGB',                                                      // 12
                     ver:=1,
                     Siz   := SIZEOF(NH_RGB),      		
                     al    := SIZEOF(NH_RGB.AL),
                     cx    := SIZEOF(NH_RGB.CX),
                     hw    := SIZEOF(NH_RGB.HW),
                     cat   := 1,
                     sld   := 1,
							lst	:= 1,
                     par   := 3,
                     ou    := 1,
                     fBr   := 43,
                     fSc   := 204,
                     mWsb  := 11,
                     mnu   := 46,
                     analog:=true,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
			(cfg:='WSB',                                                      // 13
                     ver:=1,
                     Siz   := SIZEOF(NH_WSB),      		
                     al    := SIZEOF(NH_WSB.AL),
                     cx    := SIZEOF(NH_WSB.CX),
                     hw    := SIZEOF(NH_WSB.HW),
                     me    := SIZEOF(NH_WSB.ME),
                     fSc   := 204,
                     mnu   := 27,
                     cat   := 24,
                     sld   := 0,
                     par   := 4,
                     ref   := 252,
                     body  := 1,
                     tgrp  := 13,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
							led	:= 1,
                     ),
			(cfg:='TLA',                                       			     // 14

                     ver:=1,
                     Siz   := SIZEOF(NH_TLA),      		
                     al    := SIZEOF(NH_TLA.AL),
                     cx    := SIZEOF(NH_TLA.CX),
                     hw    := SIZEOF(NH_TLA.HW),
                     me    := SIZEOF(NH_TLA.ME),
                     fSc   := 204,
                     mnu   := 27,

//                     iov   := 1,
                     cat   := 24,
                     sld   := 0,
                     par   := 4,
                     ref   := 252,
                     body  := 1,
                     tgrp  := 13,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
   	   (cfg:='PIR',                                                     // 15
                     ver:=1,
                     Siz   := SIZEOF(NH_PIR),      		
                     al    := SIZEOF(NH_PIR.AL),
                     cx    := SIZEOF(NH_PIR.CX),
                     hw    := SIZEOF(NH_PIR.HW),
                     me    := 0,	//SIZEOF(NH_PIR.ME),
                     cat   := 15,
                     fBr   := 15,
                     fSc   := 204,
                     mWsb  := 15,
                     mnu   := 56,
                     par   := 7,
                     body  := 1,
                     tgrp  := 15,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),

			(cfg:='TER',                                                      // 16
                     ver:=1,
                     Siz   := SIZEOF(NH_TER),      		
                     al    := SIZEOF(NH_TER.AL),
                     cx    := SIZEOF(NH_TER.CX),
                     hw    := SIZEOF(NH_TER.HW),
                     me    := SIZEOF(NH_TER.ME),
                     cat   := 14,
//                     wh    := 100,        // zobrazenie teploty v browse
                     par   := 0,
                     fBr   := 20,
                     fSc   := 204,
                     mnu   := 34,
                     tgrp  := 16,
							//   iov	:= 100,
							ShwSta:=false,
							analog:=true,
							zone	:=true,
                     del   := 1,
                     imp   := 1,
							bck	:= 1,	
                     ),

			(cfg:='TEH',                                                      // 17
                     ver:=1,
                     Siz   := SIZEOF(NH_TER),      		
                     al    := SIZEOF(NH_TER.AL),
                     cx    := SIZEOF(NH_TER.CX),
                     hw    := SIZEOF(NH_TER.HW),
                     me    := SIZEOF(NH_TER.ME),
//                     wh    := 100,        // zobrazenie teploty v browse
                     cat   := 39,
                     par   := 0,
                     fBr   := 20,
                     fSc   := 204,
                     mnu   := 34,
                     tgrp  := 16,
                     //iov   := 100,
							analog:=true,
                     del   := 1,
                     imp   := 1,
							bck	:= 1,	
                     ),
			(cfg:='TEK',                                                      // 18
                     ver:=1,
                     Siz   := SIZEOF(NH_TER),      		
                     al    := SIZEOF(NH_TER.AL),
                     cx    := SIZEOF(NH_TER.CX),
                     hw    := SIZEOF(NH_TER.HW),
                     me    := SIZEOF(NH_TER.ME),
//                     wh    := 100,        // zobrazenie teploty v browse
                     cat   := 39,
                     par   := 0,
                     fBr   := 20,
                     fSc   := 204,
                     mnu   := 34,
							analog:=true,
                     tgrp  := 16,
                     //  iov   := 100,
                     del   := 1,
                     imp   := 1,
							bck	:= 1,	
                     ),
			(cfg:='LUX',                                                      // 19
                     ver:=1,
                     Siz   := SIZEOF(NH_LUX), 							
                     al    := SIZEOF(NH_LUX.AL),
                     cx    := SIZEOF(NH_LUX.CX),
                     hw    := SIZEOF(NH_LUX.HW),
                     me    := SIZEOF(NH_LUX.ME),
//                     wh    := 101,        // zobrazenie % v browse
                     cat   := 16,
                     par   := 0,
                     fBr   := 20,

                     fSc   := 204,
                     mnu   := 59,

                     tgrp  := 16,
                     //  iov   := 101,
							analog:=true,
							zone	:=true,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
                                                                           // 20
	      (cfg:='FAV',
                     ver:=1,
                     Siz   := SIZEOF(NH_FAV),
                     al    := 0,
                     cx    := SIZEOF(NH_FAV.CX),
                     fav   := 0,
                     par   := 0,

                     del   := 1,
                     imp   := 0,
							bck	:= 0,	
                     ), 		

	      (cfg:='ZAS',                                                        // 21
                     ver:=1,
                     Siz   := SIZEOF(NH_SVD), 		
                     al    := SIZEOF(NH_SVD.AL),
                     cx    := SIZEOF(NH_SVD.CX),
                     hw    := SIZEOF(NH_SVD.HW),
                     cat   := 2,
							lst	:= 1,
                     par   := 1,
                     sld   := 0,
                     ou    := 1,
                     fBr   := 43,
                     fSc   := 204,
                     mnu   := 45,
                     mWsb  := 10,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	

//                     adObr2:= 1,
                     ),

			(cfg:='USR',
                     ver:=1,
                     Siz   := SIZEOF(NH_USR),  					              // 22  uzivatelia
                     al    := 0,
                     cx    := SIZEOF(NH_USR.CX),
                     stp   := 0,
                     cat   := 31,
                     par   := 0,
                     ref   := 254,

                     del   := 1,
                     imp   := 0,
							bck	:= 1,	
                     ), 		
			(cfg:='VEN',                                                      // 23 TVE pre Vetranie // ako TVE pre HET				
                     ver:=1,
                     Siz   := SIZEOF(NH_TVE),
                     al    := SIZEOF(NH_TVE.AL),
                     cx    := SIZEOF(NH_TVE.CX),
                     hw    := SIZEOF(NH_TVE.HW),
                     io    := SIZEOF(NH_TVE.IO),
                     me    := SIZEOF(NH_TVE.ME),
//							tgr	:= 101,								
							//   //  iov	:= 101,								
                     fBR   := 22,
                     mnu   := 36,
                     fSc   := 204,
                     cat   := 4,      // globalne nastavenaia/vetranie
                     sld   := 1,
                     par   := 0,
                     ou    := 1,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
							Imp_AL:=1,

                     ),
			(cfg:='KEY',                                                      // 24  klavesnice
                     ver:=1,
                     Siz   := SIZEOF(NH_KEY), 					
                     al    := SIZEOF(NH_KEY.AL),
                     cx    := SIZEOF(NH_KEY.CX),
                     hw    := SIZEOF(NH_KEY.HW),
                     me    := SIZEOF(NH_KEY.ME),
                     cat   := 25,
                     body  := 1,
                     tgrp  := 24,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
                  	
         (cfg:='GLB',
                     ver:=1,
                     Siz   := SIZEOF(NH_GLB), 				               // 25 Globana konfiguracia
                     al    := 0,
                     cx    := SIZEOF(NH_GLB.CX),
                     al    := 0,
                     cf    := 0,
                     hw    := 0,
                     me    := 0,

                     ImpFullCfg:=1,
                     ImpFullRec:=1,             // nema klasicke CFG_ALL obnovi naraz cele cfg[].siz
                     del   := 0,
                     imp   := 0,
							bck	:= 0,	
                     ),
         (cfg:='POI',
                     ver:=2,
                     Siz   := SIZEOF(NH_POI), 				               // 26   zoznam casovych pointov
                     al    := 0,
                     cx    := SIZEOF(NH_POI.CX),
                     al    := 0,
                     cf    := 0,
                     hw    := 0,
                     me    := 0,

                     ImpFullCfg:=1,
                     ImpFullRec:=1,
                     del   := 0,
                     imp   := 0,
							bck	:= 0,	
                     ),
			(cfg:='H2O',                                                   // 27
                     Siz   := SIZEOF(NH_DOR), 									
                     al    := SIZEOF(NH_DOR.AL),
                     cx    := SIZEOF(NH_DOR.CX),
                     hw    := SIZEOF(NH_DOR.HW),
							me		:= 0,
                     cat   :=47,
                     tgrp  :=16,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
			(cfg:='FIR',                                                   // 28
                     Siz   := SIZEOF(NH_DOR), 									
                     al    := SIZEOF(NH_DOR.AL),
                     cx    := SIZEOF(NH_DOR.CX),
                     hw    := SIZEOF(NH_DOR.HW),
							me		:= 0,
                     cat   :=46,
                     tgrp  :=16,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
			(cfg:='GAS',                                                   // 29
                     ver:=1,
                     Siz   := SIZEOF(NH_DOR), 									
                     al    := SIZEOF(NH_DOR.AL),
                     cx    := SIZEOF(NH_DOR.CX),
                     hw    := SIZEOF(NH_DOR.HW),
							me		:= 0,
                     cat   := 50,
                     tgrp  :=16,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
         (cfg:='MAR',                                                   // 30 horizontalne tienenie (markiza,pergola)
                     ver:=1 ,
                     Siz   := SIZEOF(NH_ROL), 				
                     al    := SIZEOF(NH_ROL.AL),
                     cx    := SIZEOF(NH_ROL.CX),
                     hw    := SIZEOF(NH_ROL.HW),
                     me    := SIZEOF(NH_ROL.ME),
                     par   := 11,
                     cat   := 3,
                     tgrp  :=31,
                     sld   := 0,
                     ou    := 1,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
 	      (cfg:='ROL',                                                    // 31 rolety = vertikalne tienenie
                     ver:=1,
                     Siz   := SIZEOF(NH_ROL), 				
                     al    := SIZEOF(NH_ROL.AL),
                     cx    := SIZEOF(NH_ROL.CX),
                     hw    := SIZEOF(NH_ROL.HW),
                     me    := SIZEOF(NH_ROL.ME),
                     par   := 12,
                     cat   := 3,
                     tgrp  :=31,
                     fBr   := 8,
                     fSc   := 204,
                     mnu   := 63,
                     mWsb  := 31,
                     sld   := 1,
                     ref   := 252,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
 	      (cfg:='SIR',                                                      // 32
                     ver:=1,
                     Siz   := SIZEOF(NH_SVD), 		
                     al    := SIZEOF(NH_SVD.AL),
                     cx    := SIZEOF(NH_SVD.CX),
                     hw    := SIZEOF(NH_SVD.HW),
                     cat   := 6,
                     sld   := 0,
							lst	:= 1,
                     par   := 1,
                     ou    := 1,
                     fBr   := 43,
                     fSc   := 204,
                     mnu   := 45,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
			(cfg:='DOR',                             									// 33
                     ver:=1,
                     Siz   := SIZEOF(NH_DOR), 									
                     al    := SIZEOF(NH_DOR.AL),
                     cx    := SIZEOF(NH_DOR.CX),
                     hw    := SIZEOF(NH_DOR.HW),
							me		:= 0,
                     cat   := 45,
                     par   := 0,
							fbr	:= 15,
                     fSc   := 204,
                     mnu   := 56,
                     body  := 1,
                     tgrp  :=16,
							//   //  iov	:=33,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
							lst	:= 1,
                     ),
			(cfg:='WIN',                     									      // 34
                     Siz   := SIZEOF(NH_DOR), 									
                     al    := SIZEOF(NH_DOR.AL),
                     cx    := SIZEOF(NH_DOR.CX),
                     hw    := SIZEOF(NH_DOR.HW),
							me		:= 0,
                     cat   := 44,
                     par   := 0,
                     body  := 1,
                     tgrp  :=16,
							//   //  iov	:= 0,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,
							lst	:= 1,								
                     ),
 	      (cfg:='BLK',                                                       // 35 BLIKAC VSEOBECNY
                     ver:=1,
                     Siz   := SIZEOF(NH_BLK),
                     al    := SIZEOF(NH_BLK.AL),
                     cx    := SIZEOF(NH_BLK.CX),
							hw		:= 0,
							io		:= 0,
                     me    := SIZEOF(NH_BLK.ME),
                     fBr   := 19,
                     fSc   := 204,
                     mnu   := 41,
                     lst   := 1,
                     stp   := 1,
                     del   := 1,
							zone	:=true,
                     NoRecCat := 1,
                     del   := 1,
                     imp   := 0,
							bck	:= 1,	
							RomIsZone:=1,
							Visible:=1,
                     ),

 	      (cfg:='BLX',                                                       // 36 blikac len pre DEV
                     ver:=1,
                     Siz   := SIZEOF(NH_BLK),
							cf		:= 0,
                     al    := 0,
                     cx    := SIZEOF(NH_BLK.CX),
							hw		:= 0,
							io		:= 0,
                     me    := SIZEOF(NH_BLK.ME),

                     NoRecCat := 1,
                     del   := 0,
                     imp   := 0,
							bck	:= 0,	
                     ),

         (cfg:='GAT',                                                   // 37 garaz,brana,branicka,zavora
                     ver:=1,
                     Siz   := SIZEOF(NH_GAT), 				
                     al    := SIZEOF(NH_GAT.AL),
                     cx    := SIZEOF(NH_GAT.CX),
                     hw    := SIZEOF(NH_GAT.HW),
							io		:= SIZEOF(NH_GAT.IO),
							me		:= SIZEOF(NH_GAT.ME),
							mWsb	:= 37,
                     fBr   := 48,
                     fSc   := 204,
                     mnu   := 53,
                     par   := 13,
							lst	:= 1,
                     cat   := 7,
                     stp   := 1,
                     sld   := 1,
                     ou    := 1,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),

         (cfg:='RFI',                                                   // 38 RFI snimace
                     Siz   := SIZEOF(NH_RFI), 									
                     al    := SIZEOF(NH_RFI.AL),
                     cx    := SIZEOF(NH_RFI.CX),
                     hw    := SIZEOF(NH_RFI.HW),
                     cat   := 27,
                     par   := 0,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
         (cfg:='RFK',                                                   // 39 RFK - karty
                     Siz   := SIZEOF(NH_RFK), 									
                     al    := 0,
                     cx    := SIZEOF(NH_RFK.CX),
                     cat   := 37,
                     par   := 0,

                     del   := 0,
                     imp   := 0,
							bck	:= 1,	
                     ),
			(cfg:='TGL',                                                     // 40 TOuch Glass
                     ver:=1,
                     Siz   := SIZEOF(NH_TGL),      		
                     al    := SIZEOF(NH_TGL.AL),
                     cx    := SIZEOF(NH_TGL.CX),
                     hw    := SIZEOF(NH_TGL.HW),
                     me    := SIZEOF(NH_TGL.ME),
                     fSc   := 204,
                     mnu   := 27,
//                     //  iov   := 1,
                     cat   := 24,
                     sld   := 0,
                     par   := 15,
//                     wsb   := 1,
                     ref   := 252,
                     body  := 1,
                     tgrp  :=13,
                     del   := 1,
                     imp   := 1,
							bck	:= 1,	
							led	:= 1,
							dis	:= 1,
                     ),
			(cfg:='COX',                                     // 41  - nanalogove snimanie CO2,CO,BUT
                     ver:=1,
                     Siz   := SIZEOF(NH_LUX), 							
                     al    := SIZEOF(NH_LUX.AL),
                     cx    := SIZEOF(NH_LUX.CX),
                     hw    := SIZEOF(NH_LUX.HW),
                     me    := SIZEOF(NH_LUX.ME),
//                     wh    := 101,        // zobrazenie % v browse
                     cat   := 48,
                     par   := 0,
                     fBr   := 20,
                     fSc   := 204,
                     mnu   := 59,
                     tgrp  := 0,
                     //  iov   := 101,
							analog:=true,
							zone	:=true,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
         (cfg:='DLM',                            		     // 42        DALI-MASTER 62
                     ver:=1,
                     Siz   := SIZEOF(NH_DLM),
                     al    := SIZEOF(NH_DLM.AL),
                     cx    := SIZEOF(NH_DLM.CX),
                     me    := SIZEOF(NH_DLM.ME),                          // vsetko je v HW
                     hw    := SIZEOF(NH_DLM.HW),
							mWsb	:= 4,
                     cat   := 35,
                     sld   := 1,
                     par   := 16,
                     ar2   := 0,
                     stp   := 0,
                     fBr   := 3,
                     fSc   := 204,
                     mnu   := 4,
                     ou    := 1,
//                     adObr2:= 1,

                     lvl254   := 1,
                     analog:=true,
                     dali     := 1,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     ),
         (cfg:='DLS',                            		     // 43        DALI-slave
                     ver:=1,
                     Siz   := SIZEOF(NH_DLS),
                     al    := SIZEOF(NH_DLS.AL),
                     cx    := SIZEOF(NH_DLS.CX),
                     me    := SIZEOF(NH_DLS.ME),
                     hw    := 0,                         // ma uplne inu srokturu, tak je 0  NH_DLS_HW
							mWsb	:=11,
                     cat   := 1,
                     sld   := 1,                            // slider sa nadefinuje sa az
//                     lst   := 1,
                     lst   := 0,
                     par   := 16,
                     ar2   := 0,
                     stp   := 1,
                     fBR   := 5,
                     fSc   := 204,
                     mnu   := 4,             // user menu - len parametre
                     ou    := 1,
//                     adObr2:= 1,

                     imp   := 0,
                     lvl254   := 1,
                     analog:=true,
                     dali     := 1,
                     del   := 0,
                     imp   := 0,
							bck	:= 1,	
                     ),
         (cfg:='DLG',                            		     // 44        DALI-Group
                     ver:=1,
                     Siz   := SIZEOF(NH_DLG),
                     al    := SIZEOF(NH_DLG.AL),                     hw    := 0,                         // ma uplne inu srokturu, tak je 0  NH_DLS_HW
                     cx    := SIZEOF(NH_DLG.CX),
                     me    := SIZEOF(NH_DLG.ME),
							mWsb	:= 4,
                     cat   := 54,
                     sld   := 1,
                     lst   := 1,
                     //scn   := 1,
                     ar2   := 0,
                     stp   := 1,
                     fBr   := 5,
                     fSc   := 204,
                     mnu   := 4,
                     par   := 16,
                     ou    := 1,
//                     adObr2:= 1,

                     imp   := 0,
                     lvl254   := 1,
                     analog:=true,
                     dali     := 1,
                     del   := 0,
                     imp   := 0,
							bck	:= 1,	
							Visible:=1,
                     ),
	      (cfg:='SMW',                                                        // 45    Smart WAY
                     ver:=1,
                     Siz   := SIZEOF(NH_SMW), 					
                     al    := SIZEOF(NH_SMW.AL),
                     cx    := 0,
                     cat   := 0,
                     par   := 0,
                     sld   := 0,

                     NoRecCat := 1,
                     del   := 0,
                     imp   := 0,
							bck	:= 0,	

                     ),

 	      (cfg:='MSG',                                                       // 46 SPRAVY
                     ver:=1,
                     Siz   := SIZEOF(NH_MSG),
                     al    := SIZEOF(NH_MSG.AL),
//                     cx    := SIZEOF(NH_MSG.CX),
                     me    := 0, 	// SIZEOF(NH_BLK.ME),
                     fBr   := 19,
//                     fSc   := 204,
//                     mna   := 41,
//                     mnu   := 41,
//                     lst   := 1,
                     stp   := 1,
                     del   := 1,

//                     NoRecCat := 1,
                     del   := 0,
                     imp   := 0,
							bck	:= 1,	
                     RomIsZone:=1,
                     ),
         (cfg:='HEV',                            		                    // 47 - regulator vetrania
                     ver:=1,
                     Siz   := SIZEOF(NH_HET),
                     al    := SIZEOF(NH_HET.AL),
                     cx    := SIZEOF(NH_HET.CX),
                     hw    := 0,
                     me    := SIZEOF(NH_HET.ME),
                     io    := SIZEOF(NH_HET.IO),
                     fBR   := 23,
                     fSc   := 204,
                     mnu   := 28,
                     par   := 9,
							mWsb	:= 6,
                     cat   := 4,
//                     cou   := 2,
                     sld   := 0,
//                     wh    := 100,        // zobrazenie teploty v browse
                     ou    := 0,       // ???? 23.11.2021
                     ref   := 251,
                     tgrp  := 6,
                    	lst	:= 1,
                     del   := 1,
                     imp   := 0,
							bck	:= 1,	
							ShwSta:=true,

							NbrPoi:=2,
							Imp_AL:=1,
                     ),
			(cfg:='ALA',                                                   // 48 - akcie zabezpecovacky
                     ver:=1,
                     Siz   := SIZEOF(NH_ALA),
                     al    := SIZEOF(NH_ALA.AL),
                     cx    := SIZEOF(NH_ALA.CX),
//                     me    := SIZEOF(NH_ACA.ME),
                     fBr   := 19,
                     fSc   := 90,
                     mnu   := 49,
                     par   :=  0,
                     cat   := 55,
                     lst   := 1,
                     stp   := 1,
                     ou    := 0,
                     tgrp  := 5,

							del   := 1,								
                     imp   := 0,
							bck	:= 1,	
				         RomIsZone:=1,
						   ),

			(cfg:='VVO',                                                   // 49 - ventil vody
                     ver:=1,
                     Siz   := SIZEOF(NH_VVO),
                     al    := SIZEOF(NH_VVO.AL),
                     cx    := SIZEOF(NH_VVO.CX),
                     hw    := SIZEOF(NH_VVO.HW),
                     cat   := 6,
                     sld   := 0,
							lst	:= 1,
                     par   := 1,
                     ou    := 1,
                     fBr   := 43,
                     fSc   := 204,
                     mnu   := 87,
							ShwSta:=true,
                     del   := 1,
                     imp   := 1,
							bck	:= 1,	
						   ),

			(cfg:='TIM',                                                   // 50 - akcie zabezpecovacky
                     ver:=1,
                     Siz   := SIZEOF(NH_TIM),
                     al    := SIZEOF(NH_TIM.AL),
                     cx    := SIZEOF(NH_TIM.CX),
                     me    := SIZEOF(NH_TIM.ME),
                     fBr   := 15,
                     fSc   := 204,
                     mnu   := 71,

                     lst   := 0,
                     stp   := 1,
                     del   := 1,
							zone	:= 1,
                     NoRecCat := 1,
                     imp   := 0,
							bck	:= 1,	
							RomIsZone:=1,
							Visible:=1,
						   ),
			(cfg:='RHX',                                     					// 51  - vlhkost - RH
                     ver:=1,
                     Siz   := SIZEOF(NH_LUX), 							
                     al    := SIZEOF(NH_LUX.AL),
                     cx    := SIZEOF(NH_LUX.CX),
                     hw    := SIZEOF(NH_LUX.HW),
                     me    := SIZEOF(NH_LUX.ME),
//                     wh    := 101,        // zobrazenie % v browse
                     cat   := 17,
                     par   := 0,
                     fBr   := 20,
                     fSc   := 204,
                     mnu   := 59,
                     tgrp  := 0,
                     //  iov   := 101,
							analog:=true,
							zone	:=true,
                     del   := 0,
                     imp   := 1,
							bck	:= 1,	
                     )


 	];

         eROM  {HIDDEN} :  NH_ROM;
//			eCAT  {HIDDEN} :  NH_OK;
			eZON  {HIDDEN} :  NH_ROM;
			eSCN  {HIDDEN} :  NH_SCN;
	      eACT  {HIDDEN} :  NH_ACT;
			eHET  {HIDDEN} :  NH_HET :=
					(cf := (cat := 5));
			eKOT  {HIDDEN} :  NH_TVE :=
					(cf := (cat := 5),
					 cx := (
 						 reg:= (	ModeFromSrc := 0,
						 			Guard 		:= 1,
 									Mode 			:= 0,
						 			Delay 		:= 0,
						 			reg := [( Wht := 0,
									 				out := [   0,   25,   50,  100],
									 				req := [ 5.0, 22.0, 26.0, 29.0]
									 			),	
											  ( Wht := 0,
											  		out := [   0,   25,   50, 100],
											  		req := [ 0.0, 25.0, 22.0, 19.0]
									 		    )
												]),
									guard := (	tDis:=22,
													val := [20,40,21,27],
												 ),
									), 		
 					);								
			eTVE  {HIDDEN} :  NH_TVE :=
					(cf := (cat := 5),
					 cx := (
 						 reg:= (	ModeFromSrc := 1,
						 			Guard 		:= 1,
 									Mode 			:= 0,
						 			Delay 		:= 0,
						 			reg := [( Wht := 0,
									 				out := [   0,  100,  100,  100],
									 				req := [ 5.0, 22.0, 26.0, 29.0]
									 			),	
											  ( Wht := 0,
											  		out := [   0,  100,  100,  100],
											  		req := [ 0.0, 25.0, 22.0, 20.0]
									 		    )
												]),
									guard := (	tDis:=17,
													val := [5,30,21,27],
												 ),
									), 		
 					);								
			eCER  {HIDDEN} :  NH_TVE:=     // 9  CER
					(cf := (cat := 5),
					 cx := (
 						 reg:= (	ModeFromSrc := 1,
						 			Guard 		:= 0,
 									Mode 			:= 0,
						 			Delay 		:= 0,
						 			reg := [( Wht := 0,
									 				out := [   0,  100,  100,  100],
									 				req := [ 5.0, 22.0, 26.0, 29.0]
									 			),	
											  ( Wht := 0,
											  		out := [   0,  100,  100,  100],
											  		req := [ 0.0, 25.0, 22.0, 20.0]
									 		    )
												]),
									guard := (	tDis:=17,
													val := [5,30,21,27],
												 ),
									), 		
 					);								
         eSVD  {HIDDEN} :  NH_SVD;    // 10
			eSVA  {HIDDEN} :  NH_SVA;
			eRGB  {HIDDEN} :  NH_RGB;
			eWSB  {HIDDEN} :  NH_WSB;
			eTLA  {HIDDEN} :  NH_TLA;
   	   ePIR  {HIDDEN} :  NH_PIR;    // 15
			eTER  {HIDDEN} :  NH_TER;
			eTEH  {HIDDEN} :  NH_TER;
			eTEK  {HIDDEN} :  NH_TER;
			eLUX  {HIDDEN} :  NH_LUX;
	      eFAV  {HIDDEN} :  NH_FAV;    // 20
	      eZAS  {HIDDEN} :  NH_SVD;
			eUSR  {HIDDEN} :  NH_USR;
			eVEN  {HIDDEN} :  NH_TVE :=
					(cf := (cat := 4),
					 cx := (
 						 reg:= (	
						  			ModeFromSrc := 0,
						 			Guard 		:= 0,
 									Mode 			:= 0,
						 			Delay 		:= 0,
						 			reg := [( Wht := 0,
									 				out := [   0,  100,  100,  100],
									 				req := [ 0.0, 25.0, 33.0, 40.0]
									 			),	
											  ( Wht := 1,
											  		out := [   0,  100,  100,  100],
											  		req := [ 0.0, 24.0, 22.5, 21.0]
									 		    )
												]),
									), 		
 					);								
			eKEY  {HIDDEN} :  NH_KEY;
	      eGLB  {HIDDEN} :  NH_GLB;     // 25
	      ePOI  {HIDDEN} :  NH_POI;     // 26
			eH2O  {HIDDEN} :  NH_DOR;
			eFIR  {HIDDEN} :  NH_DOR;
			eGAS  {HIDDEN} :  NH_DOR;
         eMAR  {HIDDEN} :  NH_ROL;     // 30
 	      eROL  {HIDDEN} :  NH_ROL;     // 31
 	      eSIR  {HIDDEN} :  NH_SVD;
			eDOR  {HIDDEN} :  NH_DOR;     // 33
			eWIN  {HIDDEN} :  NH_DOR;
 	      eBLK  {HIDDEN} :  NH_BLK;      // 35
 	      eBLX  {HIDDEN} :  NH_BLK;
 	      eGAT  {HIDDEN} :  NH_GAT;      // 37
 	      eRFI  {HIDDEN} :  NH_RFI;
 	      eRFK  {HIDDEN} :  NH_RFK;
 	      eTGL  {HIDDEN} :  NH_TGL;      // 40
			eCOX  {HIDDEN} :  NH_LUX;      // 41: RH,CO2,CO
			eDLM  {HIDDEN} :  NH_DLM;      // 42: Dali Master
			eDLS  {HIDDEN} :  NH_DLS;      // 43: Dali Slave
			eDLG  {HIDDEN} :  NH_DLG;      // 44: Dali Slave
	      eSMW  {HIDDEN} :  NH_SMW;      // 45: presunute z aCfg[25]
	      eMSG  {HIDDEN} :  NH_MSG;      // 46: SMS/MAIL/MSG
			eHEV  {HIDDEN} :  NH_HET	:=        // 47  regulator vetrania
					(cf := (cat := 4),
					 cx := (
 						 reg:= (	
						  			ModeFromSrc := 1,
						 			Guard 		:= 0,
 									Mode 			:= 0,
						 			Delay 		:= 0,

						 			reg := [( Wht := 1,
									 				out := [   0,   25,   50,  100],
									 				req := [ 0.0, 70.0, 50.0, 30.0],
													hys := [  2.0,  4.0,  6.0, 			// Dn
							 									 2.0,  4.0,  6.0],  	      // Up
									 			),	
											  ( Wht := 1,
											  		out := [   0,   25,   50,  100],
											  		req := [ 0.0, 70.0, 50.0, 40.0],
													hys := [  2.0,  4.0,  6.0, 			// Dn
							 									 2.0,  4.0,  6.0],  	      // Up

									 		    )
												]
												
												),

									), 		
 					);								


(*
				( cx := ( reg := (Mode := 0, ModeFromSrc := false,
							btn := [1,1,1,1,1,0],
							reg :=
						[( wht := 0,  pv := [( val := [ 0.0, 25.0, 50.0,100.0]),
													( val := [ 0.0, 70.0, 50.0, 30.0])]),
						 ( wht := 0,  pv := [( val := [ 5.0, 25.0, 50.0,100.0]),
													( val := [ 0.0, 70.0, 50.0, 40.0])])]),
				));	
*)
			eALA  {HIDDEN} :  NH_ALA := (ok:=(ok:=0));      // 48  akcie ALA
			eVVO  {HIDDEN} :  NH_VVO;		// 49 ventil vody	
			eTIM  {HIDDEN} :  NH_TIM;		// 50 timer + rnd + sunset
			eRHX  {HIDDEN} :  NH_LUX;     // 51: RH - vlhkost

//			eRVE  {HIDDEN} :  NH_RVE;      // 45: regulator ventilatora/rekuperacie

	aPar	{HIDDEN}	AT mRam[ _Par0 ]	: ARRAY[1.._Nh_PAR] OF NH_PAR_CFG := [
			(cfg:='SVD',Siz:=SIZEOF(NH_SVD_PAR)),	         // 1
			(cfg:='SVA',Siz:=SIZEOF(NH_SVA_PAR)),	         // 2
			(cfg:='RGB',Siz:=SIZEOF(NH_RGB_PAR)),	         // 3
			(cfg:='WSB',Siz:=SIZEOF(NH_WSB_PAR)), 	         // 4
			(cfg:='ZON',Siz:=SIZEOF(NH_ZON_PAR)),    			// 5  ZON -> ACT
			(cfg:='XX1',Siz:=SIZEOF(NH_SVD_PAR)),	         // 6
			(cfg:='PIR',Siz:=SIZEOF(NH_PIR_PAR)), 	         // 7
			(cfg:='XX2',Siz:=SIZEOF(NH_SVD_PAR)),	         // 8
			(cfg:='HET',Siz:=SIZEOF(NH_HET_PAR)),           // 9
			(cfg:='SCN',Siz:=SIZEOF(NH_SVA_PAR),grp:=1),   // 10   SCN vo vazbe in, parameter sa prebera z hlavicky (DEV-LIST k SCN)
			(cfg:='MAR',Siz:=SIZEOF(NH_ROL_PAR)),          // 11   MAR - zatial pre markizy,este nepouzite
			(cfg:='ROL',Siz:=SIZEOF(NH_ROL_PAR),ver:=1),   // 12   ROL
			(cfg:='GAT',Siz:=SIZEOF(NH_GAT_PAR)),          // 13   BRA (garaz,brana,branicka)
			(cfg:='XX3',Siz:=SIZEOF(NH_SVD_PAR)),          // 14          VOLNY = byvaly ZON (PSN prikazy)
			(cfg:='TGL',Siz:=SIZEOF(NH_WSB_PAR)),          // 15   TGL
			(cfg:='DLS',Siz:=SIZEOF(NH_RGB_PAR))           // 16   DLS,DLG,DLM
	        ];


         epSVD  {HIDDEN} :  NH_SVD_PAR;	// 1
         epSVA  {HIDDEN} :  NH_SVA_PAR;   // 2
         epRGB  {HIDDEN} :  NH_RGB_PAR;   // 3
         epWSB  {HIDDEN} :  NH_WSB_PAR;   // 4
         epZON  {HIDDEN} :  NH_ZON_PAR;   // 5
         epXX1  {HIDDEN} :  NH_SVD_PAR;   // 6
         epPIR  {HIDDEN} :  NH_PIR_PAR;   // 7
         epXX2  {HIDDEN} :  NH_SVD_PAR;   // 8
         epHET  {HIDDEN} :  NH_HET_PAR;   // 9
         epSCN  {HIDDEN} :  NH_SVA_PAR;   // 10
         epMAR  {HIDDEN} :  NH_ROL_PAR;   // 11
         epROL  {HIDDEN} :  NH_ROL_PAR ;   // 12
         epGAT  {HIDDEN} :  NH_GAT_PAR;   // 13
         epXX3  {HIDDEN} :  NH_SVD_PAR;   // 14
         epTGL  {HIDDEN} :  NH_WSB_PAR;   // 15
         epDLS  {HIDDEN} :  NH_RGB_PAR := ( all := ( lvl := 100), rgb := ( lvl := [254,254,254,254,254]));  // 16

//	aVaz	{HIDDEN}	AT mRam[ _Vaz0 ]	: ARRAY[1.._Nh_VAZ] OF NH_VAZ_CFG ;

	aVaz	{HIDDEN}	AT mRam[ _Vaz0 ]	: ARRAY[1.._Nh_VAZ] OF NH_VAZ_CFG := [
			(cfg:='VZ1'),
			(cfg:='VZ2'),
			(cfg:='VZ3'),
			(cfg:='VZ4'),
			(cfg:='VZ5',siz:=0),
			(cfg:='VZ6',siz:=0),
			(cfg:='VZ7',siz:=0),
			(cfg:='VZ8',siz:=0),
			(cfg:='VZ9',siz:=0) ];

         eVAZ  :  NH_VAZ;     // 33

(* aVaz[1]  :  HOME page (dash+qick) menu
               in.c = usr (0=default), in.n := -1 dash, -2 quick, -3...
   aVaz[2]  :  FAV
               in.c = usr (0=vsetci), in.n := cislo FAV 0=vsetci dash, -2 quick, -3...

*)
(*
	aWrk	: ARRAY[1.._Nh_WRK] OF NH_WRK := [
			(Siz := SIZEOF(NH_ROM_WRK), cfg := 1),	                // 1 = Rom
			(Siz := SIZEOF(NH_CAT_WRK), cfg := 2),	                // zatial nic, len aby sa dodrzal rom,zone
			(Siz := SIZEOF(NH_ROM_WRK), cfg := 3)	                // 3 = Zone
	        ];
*)
//	aVcf	{HIDDEN}	: ARRAY[1.._Nh_VCF] OF NH_VCF;


END_VAR



