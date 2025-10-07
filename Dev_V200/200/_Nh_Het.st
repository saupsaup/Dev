
TYPE

(*
   NH_HET_DIS	{HIDDEN} :  STRUCT 		    // prenos medzi HET a TGL,WSB....
		ok 			: BOOL;                 	// mame ReQ teplotu z tohto regulatora	
		chg			: BOOL;       				   // zmena ReQ
		valReQ		: REAL;                    // pozadovana velicina
		valAct		: REAL;                    // aktualna velicina
   END_STRUCT;
*)





END_TYPE






TYPE



END_TYPE


TYPE
END_TYPE

TYPE
END_TYPE








FUNCTION _Nh_PvValOut  {HIDDEN} : USINT		// nastavi vystupny stupen KURENIA/CHLADENIA podla hysterezie					
	VAR_INPUT
   	het		: BOOL;
		up			: USINT;
		pv			: USINT;
		reQ		: REAL;
		val		: REAL;	
		wht		: PTR_TO NH_HET_MODE;
  	END_VAR
//	vr	:= wht^.reQ[ pv ];
	i	:= 3;
	WHILE i >= 1 DO
		kr := wht^.hys[up,i];

(*
		IF up THEN
			kr		:= wht^.hys.up[i];
		ELSE
			kr		:= wht^.hys.dn[i];	
		END_IF;
*)
		IF het THEN														// kurenie	

(*      	
					UP                 		DN
			23.3  0.                      0.
			23.2  0.                      0.
			23.1  0.                 		1.	<= [23+0.1=23.1]
			23.0  0 --------------------- 1.
			22.9	0.                      2.	<= [23-0.1=22.9]
			22.8  0.                      2.
			22.7  0.                      2.
			22.6	0.	                     2.
			22.5  1.	<= [23-0.5=22.5]     2.
			22.4  1.                      2.
			22.3  1.                      3.	<= [23-0.7=22.3]
			22.2  1.                      3.
			22.1  1.                      3.
			22.0  2.	<= [23-1.0=22.0]     3.
			21.9  2.                      3.
			21.8  2.                      3.
			21.7  2.
			21.6  2.
			21.5  2.
			21.4  2.
			21.3  2.
			21.2  2.
			21.1  2.
			21.0  3.	<= [23-2.0=21.0]
			20.9	3.	
*)

//			IF val <= reQ - kr THEN
			IF val <= reQ + kr THEN
				EXIT;
			END_IF;
		ELSIF	pv = 0 THEN												// pri chladenie/vetrani/odvlhceni je PV=0 OFF	
			i := 1;
		ELSIF val >= reQ + kr THEN
			EXIT;
		END_IF;
		i := i-1;
	END_WHILE;
	_Nh_PvValOut := i;				
END_FUNCTION


TYPE

END_TYPE
