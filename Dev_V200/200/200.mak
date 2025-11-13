; Varování: Tento soubor je spravován vývojovým prostredím Mosaic.
; Nedoporucuje se upravovat ho rucne!

#program 200 , V2.0.0.0
;**************************************
#libname "_Nh", 20250827
;<ActionName/>	NachHouse V200
;<Programmer/>	Ing.Peter Aust
;<FirmName/>	Au Media, s.r.o.
;<Copyright/>	Au Media, s.r.o.
;**************************************
;<History>
;</History>
;**************************************
#useoption CPM = 11             ; Typ CPM: I
#useoption AlarmTime = 150      ; první výstraha [ms]
#useoption MaxCycleTime = 1200  ; maximální cyklus [ms]
#useoption MinCycleTime = 0     ; minimální cyklus [ms]
#useoption RestartOnError = 1   ; 1 minutu po tvrdé chybe bude PLC restartován

#uselib "LocalLib\StdLib_V22_20180619.mlb"
#uselib "LocalLib\SysLib_V52_20241212.mlb"
#uselib "LocalLib\CrcLib_V14_20250128.mlb"
#uselib "LocalLib\CanvasLib_V23_20190122.mlb"
#uselib "LocalLib\ToStringLib_V13_20110203.mlb"
#uselib "LocalLib\FileLib_V35_20250701.mlb"
#uselib "LocalLib\ComLib_V42_20251016.mlb"
#uselib "LocalLib\ConvertLib_V26_20240105.mlb"
#uselib "LocalLib\SfcLib_V15_20190605.mlb"
#uselib "LocalLib\EncryptLib_V14_20231018.mlb"
#uselib "LocalLib\TimeLib_V16_20230504.mlb"
#uselib "LocalLib\DataBoxLib_V18_20250410.mlb"
#uselib "LocalLib\InternetLib_V70_20241220.mlb"
#uselib "LocalLib\NotifyLib_V10_20190723.mlb"
#uselib "LocalLib\DaliLibEx_V13_20230602.mlb"
#uselib "LocalLib\XmlLibEx_V24_20240730.mlb"
#uselib "LocalLib\AstroLib_V15_20200408.mlb"
#uselib "LocalLib\RamBoxLib_V11_20250116.mlb"
#uselib "LocalLib\MeteoLib_V10_20210621.mlb"
#uselib "LocalLib\JsonBaseLib_V10_20240515.mlb"
#uselib "LocalLib\JsonLibEx_V30_20230210.mlb"
#endlibs

;**************************************
#usefile "PanelMaker\DeklarPT.mos", 'auto'
#usefile "IOConfigurator\CONFIG.ST", 'auto'
#usefile "IOConfigurator\CONFIG.HWC", 'auto'
#usefile "200.st"
#usefile "_Nh_SYS.st", 'lib'
#usefile "_Nh_TYP.st", 'lib'
#usefile "_Nh_CFG.st", 'lib'
#usefile "_Nh_GLB.st", 'lib'
#usefile "_Nh_SYS_WEB.st", 'lib'
#usefile "_Nh_LOG.st", 'lib'
#usefile "_Nh_FRM.st"
#usefile "_Nh_NOTIFY.st", 'lib'
#usefile "_Nh_Het.st", 'lib'
#usefile "_Nh_DALI.st", 'lib'
#usefile "_Nh_WRK.st", 'lib'
#usefile "_Nh_IMP_CFG.st", 'lib'
#usefile "_Nh_Web_LIB.st", 'lib'
#usefile "_Nh_Web_SHW.st", 'lib'
#usefile "_Nh_Frm_LIB.st", 'lib'
#usefile "_Nh_Frm_BRW.st", 'lib'
#usefile "_Nh_Frm_SCR.st", 'lib'
#usefile "_Nh_Frm_HOM.st", 'lib'
#usefile "_Nh_Web_HOM.st", 'lib'
#usefile "_Nh_Web_BRW.st", 'lib'
#usefile "_Nh_MNU.st", 'lib'
#usefile "_Nh_DEV.st", 'lib'
#usefile "_Nh_WEB.st", 'lib'
#usefile "_Nh_Ini.st", 'lib'
#usefile "_Nh_UTIL.st", 'lib'
#usefile "prgMain.ST", 'lib'
#usefile "200.mos"
#usefile "PanelMaker\r0_p0_CP_2000.mos", 'auto'
#usefile "200.mcf", 'auto'
