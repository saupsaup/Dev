FUNCTION _Nh_LoadNewPackage : BOOL
	VAR
   	rqNewProg   : BOOL;
		jak         : BOOL;
   	newPckgName : STRING := 'WWW/UPLOAD/NEW_PACK.TTR'; //http://192.168.33.200/UPLOAD/200%20v2-0-00000-00000%20PROG_PCKG%202025-09-12_16-35-57.TTR
	END_VAR
	 IF rqNewProg THEN
		jak := LoadNewPackage2( rq := rqNewProg, pckg := newPckgName);
   	rqNewProg := 0;
	END_IF;
END_FUNCTION


FUNCTION _Nh_Service_ResetToNewCfg : BOOL


END_FUNCTION

FUNCTION _Nh_Service_LoadLastOkRBx : BOOL


END_FUNCTION


 (*
 PROGRAM ExampleLoadPackage

 VAR

   rqNewProg   : BOOL;

   jak         : BOOL;

   newPckgName : STRING := 'WWW/UPLOAD/NEW_PACK.TTR';

 END_VAR




 IF rqNewProg THEN

   jak := LoadNewPackage2( rq := rqNewProg, pckg := newPckgName);

   rqNewProg := 0;

 END_IF;

END_PROGRAM
*)





