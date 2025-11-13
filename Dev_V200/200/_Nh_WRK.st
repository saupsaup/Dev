
{ $IFDEF __NH_WRK }

VAR_GLOBAL                                            // len pre ladenie
   _NhWrk      {HIDDEN} : BOOL := true ;
   { $ IF CPU_CODE > 1999  } 	
   yIdx         : ARRAY[1..30]	OF NH_IDX;


	yScn			{HIDDEN} : ARRAY[1..50]  OF NH_SCN;
   ypScn 		{HIDDEN} : ARRAY[1..20]  OF NH_SVA_PAR;
	yAct			{HIDDEN} : ARRAY[1..50]  OF NH_ACT;
//	yAla			{HIDDEN} : ARRAY[1..10]  OF NH_ALA;


//		yyVaz	{HIDDEN}	: ARRAY[1.._Nh_VAZ] OF NH_VAZ_CFG ;

		yVaz1			{HIDDEN} : ARRAY[1..50]  OF NH_VAZ;
//	  	yVaz2 		{HIDDEN} : ARRAY[1..150] OF NH_VAZ;
//		yVaz3			{HIDDEN} : ARRAY[1..50]  OF NH_VAZ;
//   	yVaz4			{HIDDEN} : ARRAY[1..80]  OF NH_VAZ;




//  		yGlb			{HIDDEN} : ARRAY[1..1]   OF NH_GLB;
	   yRom			{HIDDEN} : ARRAY[1..30]	OF NH_ROM;
   	yZon			{HIDDEN} : ARRAY[1..10]	OF NH_ROM;
	   ypZon 		{HIDDEN} : ARRAY[1..20]  OF NH_ZON_PAR;
   	yRoW        {HIDDEN} : ARRAY[1..10]  OF NH_WRK_ROM;
		yZoW        {HIDDEN} : ARRAY[1.. 7]  OF NH_WRK_ROM;
		yRol			{HIDDEN} : ARRAY[1..20]  OF NH_ROL;
   	ypRol 		{HIDDEN} : ARRAY[1..100]  OF NH_ROL_PAR;       // 12
//   	yPoi			{HIDDEN} : ARRAY[1..50]  OF NH_POI;

		yTgl			{HIDDEN} : ARRAY[1..30]  OF NH_TGL;
  		ypTgl 		{HIDDEN} : ARRAY[1..120]  OF NH_WSB_PAR;


   ySvd 			{HIDDEN} : ARRAY[1..10]  OF NH_SVD;
   pSvd 			{HIDDEN} : ARRAY[1..100]  OF NH_SVD_PAR;
  	ySva 			{HIDDEN} : ARRAY[1..10]  OF NH_SVA;  //10
  	pSva 			{HIDDEN} : ARRAY[1..40]  OF NH_SVA_PAR;
   yRgb 			{HIDDEN} : ARRAY[1..10]  OF NH_RGB;
	yyRgb 			{HIDDEN} : NH_RGB;
   pRgb 			{HIDDEN} : ARRAY[1..20]  OF NH_RGB_PAR;


	yTve			{HIDDEN} : ARRAY[1..20]  OF NH_TVE;
//	yHet			{HIDDEN} : ARRAY[1..10]  OF NH_HET;  // 20
(*

 	ypHet 		{HIDDEN} : ARRAY[1..20]  OF NH_HET_PAR;       // 10

//	yHev			{HIDDEN} : ARRAY[1..5]   OF NH_HET;  // 20

	yVen 			{HIDDEN} : ARRAY[1..10]  OF NH_TVE;
*)

(*
		yLux			{HIDDEN} : ARRAY[1..5]  OF NH_LUX;
   	yTer 			{HIDDEN} : ARRAY[1..40]  OF NH_TER;
	   yTeh 			{HIDDEN} : ARRAY[1.. 5]  OF NH_TER;
   	yTek 			{HIDDEN} : ARRAY[1.. 5]  OF NH_TER;


*)
//		yRhx			{HIDDEN} : ARRAY[1..2]  OF NH_LUX;
//	yCer			{HIDDEN} : ARRAY[1..3]	 OF NH_TVE;
//	yKot			{HIDDEN} : ARRAY[1..5]	 OF NH_TVE;
//  	yTim			{HIDDEN} : ARRAY[1..10]  OF NH_TIM;
//	yKey			{HIDDEN} : ARRAY[1..3]   OF NH_KEY;



(*
	yDls			{HIDDEN} : ARRAY[1..130]   OF NH_DLS;
	pDls			{HIDDEN} : ARRAY[1..200]   OF NH_RGB_PAR;
	yDlm			{HIDDEN} : ARRAY[1..4]   OF NH_DLM;
	yDlg			{HIDDEN} : ARRAY[1..32]   OF NH_DLG;
*)









//    	yMsg			{HIDDEN} : ARRAY[1..3] OF NH_MSG;

//	  yCat			{HIDDEN} : ARRAY[1..70]	OF NH_CAT;






      yVvo 			{HIDDEN} : ARRAY[1..4]   OF NH_VVO;


   yWsb 			{HIDDEN} : ARRAY[1..30]  OF NH_WSB;
   ypWsb 		{HIDDEN} : ARRAY[1..50]  OF NH_WSB_PAR;

   yTla 			{HIDDEN} : ARRAY[1..10]  OF NH_TLA;

//   ytGl		 {HIDDEN} : ARRAY[1..10]  OF NH_TGL;
//	yPIR			{HIDDEN} : ARRAY[1..50]  OF NH_PIR;
//   ypPir 		{HIDDEN} : ARRAY[1..10]  OF NH_PIR_PAR;

//	yCox			{HIDDEN} : ARRAY[1..10]  OF NH_LUX;


//	yDor			{HIDDEN} : ARRAY[1..10]  OF NH_DOR;

//	yFav			{HIDDEN} : ARRAY[1..10]  OF NH_FAV;
//   yZas 			{HIDDEN} : ARRAY[1..15]  OF NH_SVD;
//   pZas 			{HIDDEN} : ARRAY[1..10]  OF NH_SVD_PAR;
//	yyUsr			{HIDDEN} : ARRAY[1..7]   OF NH_USR;

//	ySmw			{HIDDEN} : ARRAY[1..10]  OF NH_SMW;

//	yGat			{HIDDEN} : ARRAY[1.. 5]  OF NH_GAT;
//	yBra			{HIDDEN} : ARRAY[1.. 5]  OF NH_GAT;
//   ypGat 		{HIDDEN} : ARRAY[1..10]  OF NH_GAT_PAR;       // 13


//	ySir			{HIDDEN} : ARRAY[1.. 5]  OF NH_SVD;
//	yBlk			{HIDDEN} : ARRAY[1.. 5]  OF NH_BLK;
//	yBlx			{HIDDEN} : ARRAY[1.. 5]  OF NH_BLX;
//	yBtn			{HIDDEN} : ARRAY[1..20]  OF NH_BTN;
(*
//	yAcl			{HIDDEN} : ARRAY[1..20]  OF NH_VAZ;
*)
//	yVcf			{HIDDEN} : ARRAY[1..150]  OF NH_VAZ_VCF;
//	ySbj			{HIDDEN} : ARRAY[1..4]  OF NH_SBJ;



   { $ ELSE  } 	

//   	yPoi			{HIDDEN} : ARRAY[1..20]  OF NH_POI;
//	   yRom			{HIDDEN} : ARRAY[1..10]	    OF NH_ROM;
//   	yZon			{HIDDEN} : ARRAY[1..10]	  OF NH_ROM;
//    yRoW        {HIDDEN} : ARRAY[1..10]    OF NH_WRK_ROM;
   { $ END_IF  } 	



END_VAR

	FUNCTION	_DevDataX {HIDDEN} : BOOL
      VAR_IN_OUT
         aNh   : NH_CFG_CFG;
         dst   : USINT;
      END_VAR
      VAR_INPUT
         n    : UDINT := 10;
      END_VAR
      memsetEx(val := 0,length := n * aNh.Siz , dest := dst ); // vycisti
      IF aNh.Ram > 0 THEN
         MemcpyEx(length := Min(n, INT_TO_UDINT(aNh.Rec)) * aNh.Siz , source := void( mRam[ aNh.Ram ]), dest := dst);
      END_IF;
      _DevDataX := true;
   END_FUNCTION

   FUNCTION	_NhDataWrk {HIDDEN} : BOOL
      VAR_INPUT
         Yes  : BOOL := true ;
      END_VAR
      IF Yes = false THEN
         RETURN;
      END_IF;
		_NhDataWrk :=  TRUE;
      { $ IF CPU_CODE > 1999  } 	
         { $IFDEF yGlb }
            _DevDataX(aNh := VOID(aCfg[25]), dst := VOID(yGlb), n :=1);
         { $END_IF }
         { $IFDEF yRom }
            _DevDataX(aNh := VOID(aCfg[ 1]), dst := VOID(yrom), n :=30);
         { $END_IF }
         { $IFDEF yPoi }
            _DevDataX(aNh := VOID(aCfg[26]), dst := VOID(yPoi), n := 50);
         { $END_IF }
      { $ ELSE  } 	
         { $IFDEF yRom }
            _DevDataX(aNh := VOID(aCfg[ 1]), dst := VOID(yrom), n :=10);
         { $END_IF }
         { $IFDEF yPoi }
            _DevDataX(aNh := VOID(aCfg[26]), dst := VOID(yPoi), n := 20);
         { $END_IF }
      { $ END_IF  } 	

      { $IFDEF yMsg }
      _DevDataX(aNh := VOID(aCfg[46]), dst := VOID(yMsg), n :=3);
      { $END_IF }

      { $IFDEF ycat }
      _DevDataX(aNh := VOID(aCfg[ 2]), dst := VOID(yCat), n :=70);
      { $END_IF }
      { $IFDEF yZon }
      _DevDataX(aNh := VOID(aCfg[ 3]), dst := VOID(yZon), n :=10);
      { $END_IF }
      { $IFDEF ypZon }
      _DevDataX(aNh := VOID(aPar[5]), dst := VOID(ypZon), n :=20);
      { $END_IF }
      { $IFDEF yHet }
      _DevDataX(aNh := VOID(aCfg[ 6]), dst := VOID(yHet));
      { $END_IF }
      { $IFDEF yHev }
      _DevDataX(aNh := VOID(aCfg[47]), dst := VOID(yHev), n:=5);
      { $END_IF }
      { $IFDEF yKot }
      _DevDataX(aNh := VOID(aCfg[ 7]), dst := VOID(yKot), n:=5);
      { $END_IF }
      { $IFDEF ytve }
      _DevDataX(aNh := VOID(aCfg[ 8]), dst := VOID(yTve), n:=20);
      { $END_IF }
      { $IFDEF ycer }
      _DevDataX(aNh := VOID(aCfg[ 9]), dst := VOID(yCer), n := 3);
      { $END_IF }
      { $IFDEF ysvd }
      _DevDataX(aNh := VOID(aCfg[10]), dst := VOID(ySvd));
      { $END_IF }
      { $IFDEF ySva }
      _DevDataX(aNh := VOID(aCfg[11]), dst := VOID(ySva));
      { $END_IF }
      { $IFDEF yVvo }
      _DevDataX(aNh := VOID(aCfg[49]), dst := VOID(yVvo), n :=4);
      { $END_IF }
      { $IFDEF yRgb }
      _DevDataX(aNh := VOID(aCfg[12]), dst := VOID(yRgb));
      { $END_IF }
      { $IFDEF ywsb }
      _DevDataX(aNh := VOID(aCfg[13]), dst := VOID(yWsb), n :=30);
      { $END_IF }
      { $IFDEF ytla }
      _DevDataX(aNh := VOID(aCfg[14]), dst := VOID(yTla));
      { $END_IF }
      { $IFDEF ypir }
      _DevDataX(aNh := VOID(aCfg[15]), dst := VOID(yPir), n :=50);
      { $END_IF }
      { $IFDEF yter }
      _DevDataX(aNh := VOID(aCfg[16]), dst := VOID(yTer), n :=40);
      { $END_IF }
      { $IFDEF yteh }
      _DevDataX(aNh := VOID(aCfg[17]), dst := VOID(yTeh), n := 5);
      { $END_IF }
      { $IFDEF ytek }
      _DevDataX(aNh := VOID(aCfg[18]), dst := VOID(yTek), n := 5);
      { $END_IF }
      { $IFDEF ylux }
      _DevDataX(aNh := VOID(aCfg[19]), dst := VOID(yLux), n := 5);
      { $END_IF }
      { $IFDEF yRhx }
      _DevDataX(aNh := VOID(aCfg[51]), dst := VOID(yRhx), n := 2);
      { $END_IF }
      { $IFDEF yfav }
      _DevDataX(aNh := VOID(aCfg[20]), dst := VOID(yFav));
      { $END_IF }
      { $IFDEF yzas }
      _DevDataX(aNh := VOID(aCfg[21]), dst := VOID(yZas), n:=15);
      { $END_IF }
      { $IFDEF yDor }
      _DevDataX(aNh := VOID(aCfg[33]), dst := VOID(yDor));
      { $END_IF }
      { $IFDEF yyUsr }
      _DevDataX(aNh := VOID(aCfg[22]), dst := VOID(yyUsr), n:=7);
      { $END_IF }
      { $IFDEF yven }
      _DevDataX(aNh := VOID(aCfg[23]), dst := VOID(yVen));
      { $END_IF }
      { $IFDEF yKey }
      _DevDataX(aNh := VOID(aCfg[24]), dst := VOID(yKey), n := 3);
      { $END_IF }
      { $IFDEF ysmw }
      _DevDataX(aNh := VOID(aCfg[45]), dst := VOID(ySmw));
      { $END_IF }
      { $IFDEF yRol }
      _DevDataX(aNh := VOID(aCfg[31]), dst := VOID(yRol), n:=20);                    //ROL
      { $END_IF }
      { $IFDEF yBra }
      _DevDataX(aNh := VOID(aCfg[37]), dst := VOID(yBra), n := 5);            //BRA - stara
      { $END_IF }
      { $IFDEF yGat }
      _DevDataX(aNh := VOID(aCfg[37]), dst := VOID(yGat), n := 5);            //BRA
      { $END_IF }
      { $IFDEF ySir }
      _DevDataX(aNh := VOID(aCfg[32]), dst := VOID(ySir), n := 5);            //SIR
      { $END_IF }
      { $IFDEF yBlk }
      _DevDataX(aNh := VOID(aCfg[35]), dst := VOID(yBlk), n := 5);            //BLK
      { $END_IF }
      { $IFDEF yBlx }
      _DevDataX(aNh := VOID(aCfg[36]), dst := VOID(yBlX), n := 5);            //BLK
      { $END_IF }
      { $IFDEF yTgl }
      _DevDataX(aNh := VOID(aCfg[40]), dst := VOID(yTgl), n :=30);
      { $END_IF }
      { $IFDEF yBtn }
      _DevDataX(aNh := VOID(aCfg[41]), dst := VOID(yBtn), n := 20);
      { $END_IF }
      { $IFDEF yDlm }
      _DevDataX(aNh := VOID(aCfg[42]), dst := VOID(yDlm), n := 4);
      { $END_IF }
      { $IFDEF yDls }
      _DevDataX(aNh := VOID(aCfg[43]), dst := VOID(yDls), n := 130);
      { $END_IF }
      { $IFDEF yDlg }
      _DevDataX(aNh := VOID(aCfg[44]), dst := VOID(yDlg), n := 32);
      { $END_IF }
      { $IFDEF yTim }
      _DevDataX(aNh := VOID(aCfg[50]), dst := VOID(yTim), n := 10);
      { $END_IF }
      { $IFDEF yScn }
      _DevDataX(aNh := VOID(aCfg[ 4]), dst := VOID(yScn), n := 50);
      { $END_IF }
      { $IFDEF yact }
      _DevDataX(aNh := VOID(aCfg[ 5]), dst := VOID(yAct), n:= 50);
      { $END_IF }
      { $IFDEF yAla }
      _DevDataX(aNh := VOID(aCfg[48]), dst := VOID(yAla));
      { $END_IF }
      { $IFDEF yVaz1 }
      _DevDataX(aNh := VOID(aVaz[ 1]), dst := VOID(yVaz1), n := 50);
      { $END_IF }
      { $IFDEF yVaz2 }
      _DevDataX(aNh := VOID(aVaz[ 2]), dst := VOID(yVaz2), n :=150);
      { $END_IF }
      { $IFDEF yVaz3 }
      _DevDataX(aNh := VOID(aVaz[ 3]), dst := VOID(yVaz3), n := 50);
      { $END_IF }
      { $IFDEF yVaz4 }
      _DevDataX(aNh := VOID(aVaz[ 4]), dst := VOID(yVaz4), n :=80);
      { $END_IF }

(*
      { $IFDEF yAcl }
      _DevDataX(aNh := VOID(aVaz[ 5]), dst := VOID(yAcl), n := 20);
      { $END_IF }
*)

      { $IFDEF pSvd }
       _DevDataX(aNh := VOID(aPar[1]), dst := VOID(pSvd), n := 100);
      { $END_IF }
      { $IFDEF pSva }
      _DevDataX(aNh := VOID(aPar[2]), dst := VOID(pSva), n := 40);
      { $END_IF }
      { $IFDEF pRgb }
      _DevDataX(aNh := VOID(aPar[3]), dst := VOID(pRgb), n:=20);
      { $END_IF }
      { $IFDEF ypWsb }
      _DevDataX(aNh := VOID(aPar[4]), dst := VOID(ypWsb), n := 50);
      { $END_IF }
      { $IFDEF ypTgl }
      _DevDataX(aNh := VOID(aPar[15]), dst := VOID(ypTgl), n := 120);
      { $END_IF }
      { $IFDEF pTla }
      _DevDataX(aNh := VOID(aPar[5]), dst := VOID(ypTla), n:=20);
      { $END_IF }
      { $IFDEF pZas }
      _DevDataX(aNh := VOID(aPar[6]), dst := VOID(pZas));
      { $END_IF }
      { $IFDEF ypPir }
      _DevDataX(aNh := VOID(aPar[7]), dst := VOID(ypPir));
      { $END_IF }
      { $IFDEF ypHEt }
      _DevDataX(aNh := VOID(aPar[9]), dst := VOID(ypHet), n := 20);
      { $END_IF }
      { $IFDEF ypScn }
      _DevDataX(aNh := VOID(aPar[10]), dst := VOID(ypScn), n := 20);
      { $END_IF }
      { $IFDEF ypRol }
      _DevDataX(aNh := VOID(aPar[12]), dst := VOID(ypRol), n:=100);
      { $END_IF }
      { $IFDEF ypGat }
      _DevDataX(aNh := VOID(aPar[13]), dst := VOID(ypGat));
      { $END_IF }
      { $IFDEF yCox }
      _DevDataX(aNh := VOID(aCfg[41]), dst := VOID(yCox), n :=10);
      { $END_IF }
      { $IFDEF pDls }
      _DevDataX(aNh := VOID(aPar[16]), dst := VOID(pDLs), n := 200);
      { $END_IF }


// WRK
      { $IFDEF yCaW }
//         memset(val := 0, length := aSys.sCaW, dest := VOID( mRam[aSys.aCaW1] ));
         MemcpyEx(length :=  aSys.sCaW  , source := void( mRam[aSys.aCaW1] ), dest := VOID(yCaW));
      { $END_IF }
      { $IFDEF yRoW }
         MemcpyEx(length :=  MIN(10,aSys.sRoW/SIZEOF(NH_WRK_ROM))  , source := void( mRam[aSys.aRoW1] ), dest := VOID(yRoW));
      { $END_IF }
      { $IFDEF yZoW }
         MemcpyEx(length :=  MIN( 7,aSys.sRoW/SIZEOF(NH_WRK_ROM))  , source := void( mRam[aSys.aZoW1] ), dest := VOID(yZoW));
      { $END_IF }

      { $IFDEF yIdx }
         memset(val := 0, length := 30 * SIZEOF(NH_IDX), dest := VOID(yIdx));
         MemcpyEx(length :=  MIN(30,USINT_TO_UDINT(aWeb.M[1].ixb[0].idx + aWeb.M[1].ixb[1].idx)) * SIZEOF(NH_IDX)  , source := void( mRam[aSys.vIx1] ), dest := VOID(yIdx));
      { $END_IF }




   END_FUNCTION

{ $ ELSE } 	
   VAR_GLOBAL                                            // len pre ladenie
      _NhWrk      {HIDDEN} : BOOL := false;
   END_VAR
{ $END_IF }






