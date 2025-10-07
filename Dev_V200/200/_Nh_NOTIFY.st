{ $DEFINE __NH_NOTIFY }

VAR_GLOBAL CONSTANT
	_NhIpWebPush	: string [16]		:='192.168.9.175';
	_Nh_MSG	{HIDDEN} : USINT			:= 1;				// celkovy pocet formularov
	_Nh_MSG_RCV	: ARRAY[1..1] OF STRING[80] := [
	'f7ab034164f9378b1f2b65fd0554f912c0e2272f43a9d2e6fa25d377c65031cf'   	// moje
//	'.af2f65949afbc152c0d77eebb9aaf5d5cca5930cdc3057f52635c8301106c8b6',    	// Marek
//	'db9e76ae6a095bb2450409752c48b065f3cea3a5caf2f47401a3ece10ee6ea8e',	   // mamka
//	'87e08ab8c8c05dd0732292b70bf14649ed2e69ba4d363177a7d19c26196cfc21'      // Zuzka M.
	];
END_VAR

VAR_GLOBAL
	_Nh_MSG_TXT :STRING;
END_VAR

FUNCTION_BLOCK fb_NotifyIOS   {HIDDEN}
  VAR_INPUT
	 Go			  : USINT;
    ACTION       : BOOL R_EDGE;            // {ENG} request for action {CSY} poï¿½adavek na akci
    NotifyMessage : STRING := 'NachHouse';   //Foxtrot1 Notification Message';
    NotifyToken  : STRING := 'f7ab034164f9378b1f2b65fd0554f912c0e2272f43a9d2e6fa25d377c65031cf';    // moj
//    NotifyToken  : STRING := 'db9e76ae6a095bb2450409752c48b065f3cea3a5caf2f47401a3ece10ee6ea8e';     // mamka

  END_VAR

  VAR
   // z terminalu
   //http.post("http://77.236.203.179:60080/pushapi/message", "os=ios&msg="test"&id[]=f7ab034164f9378b1f2b65fd0554f912c0e2272f43a9d2e6fa25d377c65031cf)

    HttpPostName   : STRING := 'NachHouse';
    HttpPostAction : STRING := '/pushapi/message';
    HttpPostIP     : TIPadr := [77, 236, 203, 179]; // iOS Notify Server   foxtrotapi.geovap.cz:60080/pushapi/message
    HttpPort       : UINT   := 60080;
    HttpRequest   : fbHttpRequestL;
    DataOut       : THttpPostData;
    HttpPostLen   : UINT;
    Data          : THttpBuffer;
    pStr          : PTR_TO STRING[255];
   file           :   STRING := 'PUTREPLY.TXT';
   WTFSeq         : WriteToFileSeq;

	msg				: USINT;

  END_VAR

	VAR_OUTPUT
		busy		: BOOL;		
    out         : BOOL;              // {ENG} TRUE means Notification Succesfully Sent {CSY} TRUE znamenï¿½ Notifikace zaslï¿½na ï¿½spï¿½nï¿½
  	END_VAR

  	CASE Go OF
     0 : ;
     1 : msg 					:= 1;									// posle sa prvy msg
			NotifyToken 		:= _Nh_MSG_RCV[msg];
			NotifyMessage     := _Nh_MSG_TXT;
			action				:= true;
			Go 					:= 2;
   END_CASE;



    // Message Formatting
    pStr := ADR(DataOut);
    // toto su data
    pStr^ := 'os=ios&msg=';
    pStr^ := pStr^ + NotifyMessage;
    pStr^ := pStr^ + '&id[]=';
    pStr^ := pStr^ + NotifyToken;

    HttpPostLen := LEN(pStr^);

    // Message Sending
    out := 0;
    // Call Notify



	busy := false;

	HttpRequest(	Post   		:= ACTION,
	 				 	chanCode 	:= ETH1_uni0,
//	 				 	chanCode 	:= ANY_UNI,
                	IPadr  		:= HttpPostIP,
                	ACTION 		:= HttpPostAction,
                	Host   		:= HttpPostName,
                	Port   		:= HttpPort,
                	PostLen 		:= HttpPostLen,
                	Data   		:= DataOut, RecvData := Data);

	action := false;

	busy := HttpRequest.busy;

   IF HttpRequest.busy  THEN

   END_IF;


     	IF HttpRequest.Done THEN
			IF msg >= _Nh_MSG THEN
				_Nh_MSG_TXT 	:= '';
				Go 				:= 0;
			ELSE
				msg				:= msg + 1;
				NotifyToken 	:= _Nh_MSG_RCV[msg];
				action			:= true;
			END_IF;
	     out := 1;
		END_IF;

 		WTFSeq(	fileName := file,
        			srcVar 	:= void(Data),
         		write 	:= HttpRequest.DataReady,
        			close 	:= NOT HttpRequest.Busy,
         		size 		:= TO_UDINT(HttpRequest.DataLen));


//	_Nh_MSG_TXT := '';


END_FUNCTION_BLOCK


FUNCTION_BLOCK fb_NotifyWebPush    {HIDDEN}
	VAR_INPUT
		send				: BOOL;
	END_VAR		
	VAR
	 	notification 	: TWebPushNotif ;
   	webPush 			: fbWebPushService;                    // prehliadace na win/
	END_VAR
    notification.title := 'NachHouse';
	IF yTx1 <> '' THEN
	    notification.body  := yTx1;	//'Konec servisního intervalu se blíží';
	END_IF;
//    notification.body  := 'Konec servisního intervalu se blíží';
//    notification.image := 'https://bit.ly/2Lurtu7';
//    notification.icon := 'https://bit.ly/2Lkb3DH';
//    notification.icon := 'IMAGES/LEFT.PNG';
		notification.vibrate	:= '[500,110,500,110,450,110,200,110,170,40,450,110,200,110,170,40,500]';

	webPush(	send 				:= send,
            init 				:= (NOT webPush.ready) AND System_S.R_EDGE_10SEC,
            serverAddr 		:= STRING_TO_IPADR(_NhIpWebPush),
//            chanCode 		:= ETH1_uni1,
            chanCode 		:= ANY_UNI,
            notification 	:= notification);
	send := false;	

END_FUNCTION_BLOCK

VAR_GLOBAL
	fbNotify			: fb_NotifyIOS;								// iOS
	fbWebPush		: fb_NotifyWebPush;							// windows,
END_VAR
