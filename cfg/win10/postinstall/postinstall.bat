echo off

:: VirtIO guest agent
D:\virtio\virtio-win-guest-tools.exe /install /passive /quite /norestart

:: Some Tools
REM msiexec /package "D:\postinstall\tools\Firefox Setup 102.12.0esr.msi" /qr
REM D:\postinstall\tools\npp.8.5.3.Installer.x64.exe /S
REM D:\postinstall\tools\Git-2.41.0-64-bit.exe /SILENT
D:\postinstall\tools\python-3.11.4-amd64.exe /passive
powershell.exe "Remove-Item $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\python*.exe"

:: Daas Environment
mkdir C:\Users\user\daas\env
xcopy /s /E /H /C /Y /I D:\postinstall\env\PSTools C:\Users\user\daas\env\pstools
setx /M PATH "C:\Users\user\AppData\Local\Programs\Python\Python311\;C:\Users\user\AppData\Local\Programs\Python\Python311\Scripts\;C:\Users\user\daas\env\;C:\Users\user\daas\env\pstools;%PATH%"
C:\Users\user\AppData\Local\Programs\Python\Python311\python -m pip install --upgrade pip
C:\Users\user\AppData\Local\Programs\Python\Python311\Scripts\pip install click

REM :: Windows features, services, powerplan
REM :: Features
REM dism /Online /Disable-Feature /FeatureName:"DirectPlay" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"LegacyComponents" /NoRestart
REM dism /Online /Enable-Feature /FeatureName:"MediaPlayback" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"Microsoft-Hyper-V-All" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"Microsoft-Hyper-V-Management-Clients" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"Microsoft-Hyper-V-Management-PowerShell" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"Microsoft-Hyper-V-Tools-All" /NoRestart
REM dism /Online /Enable-Feature /FeatureName:"Printing-Foundation-Features" /NoRestart
REM dism /Online /Enable-Feature /FeatureName:"Printing-Foundation-InternetPrinting-Client" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"Printing-Foundation-LPDPrintService" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"Printing-Foundation-LPRPortMonitor" /NoRestart
REM dism /Online /Enable-Feature /FeatureName:"Printing-PrintToPDFServices-Features" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"Printing-XPSServices-Features" /NoRestart
REM dism /Online /Enable-Feature /FeatureName:"SearchEngine-Client-Package" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"TelnetClient" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"TFTP" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"TIFFIFilter" /NoRestart
REM dism /Online /Enable-Feature /FeatureName:"WindowsMediaPlayer" /NoRestart
REM dism /Online /Disable-Feature /FeatureName:"WorkFolders-Client" /NoRestart
REM
REM :: Services
REM sc config AxInstSV start= demand
REM sc config AJRouter start= demand
REM sc config AppReadiness start= demand
REM sc config Appinfo start= demand
REM sc config ALG start= demand
REM sc config AppMgmt start= demand
REM sc config BITS start= delayed-auto
REM sc config BDESVC start= demand
REM sc config wbengine start= demand
REM sc config bthserv start= demand
REM sc config PeerDistSvc start= demand
REM sc config CDPSvc start= demand
REM sc config CertPropSvc start= demand
REM sc config KeyIso start= demand
REM sc config EventSystem start= auto
REM sc config COMSysApp start= demand
REM sc config VaultSvc start= demand
REM sc config CryptSvc start= auto
REM sc config DsSvc start= demand
REM sc config DoSvc start= delayed-auto
REM sc config DeviceAssociationService start= demand
REM sc config DeviceInstall start= demand
REM sc config DmEnrollmentSvc start= demand
REM sc config DsmSvc start= demand
REM sc config DevQueryBroker start= demand
REM sc config Dhcp start= auto
REM sc config DPS start= disabled
REM sc config WdiServiceHost start= disabled
REM sc config WdiSystemHost start= disabled
REM sc config DiagTrack start= disabled
REM sc config TrkWks start= auto
REM sc config MSDTC start= demand
REM sc config dmwappushservice start= disabled
REM sc config MapsBroker start= delayed-auto
REM sc config EFS start= demand
REM sc config EapHost start= demand
REM sc config Fax start= disabled
REM sc config fhsvc start= demand
REM sc config fdPHost start= demand
REM sc config FDResPub start= demand
REM sc config lfsvc start= demand
REM sc config hidserv start= demand
REM sc config vmickvpexchange start= disabled
REM sc config vmicguestinterface start= disabled
REM sc config vmicshutdown start= disabled
REM sc config vmicheartbeat start= disabled
REM sc config vmicrdv start= disabled
REM sc config vmictimesync start= disabled
REM sc config vmicvmsession start= disabled
REM sc config vmicvss start= disabled
REM sc config IKEEXT start= demand
REM sc config SharedAccess start= demand
REM sc config iphlpsvc start= auto
REM sc config PolicyAgent start= demand
REM sc config KtmRm start= demand
REM sc config lltdsvc start= demand
REM sc config diagnosticshub.standardcollector.service start= demand
REM sc config wlidsvc start= demand
REM sc config MSiSCSI start= demand
REM sc config swprv start= demand
REM sc config smphost start= demand
REM sc config SmsRouter start= demand
REM sc config NetTcpPortSharing start= disabled
REM sc config Netlogon start= demand
REM sc config NcdAutoSetup start= demand
REM sc config NcbService start= demand
REM sc config Netman start= demand
REM sc config NcaSvc start= demand
REM sc config netprofm start= demand
REM sc config NlaSvc start= auto
REM sc config NetSetupSvc start= demand
REM sc config nsi start= auto
REM sc config CscService start= demand
REM sc config defragsvc start= demand
REM sc config PNRPsvc start= demand
REM sc config p2psvc start= demand
REM sc config p2pimsvc start= demand
REM sc config pla start= demand
REM sc config PlugPlay start= demand
REM sc config PNRPAutoReg start= demand
REM sc config WPDBusEnum start= demand
REM sc config Power start= auto
REM sc config Spooler start= auto
REM sc config PrintNotify start= demand
REM sc config wercplsupport start= demand
REM sc config PcaSvc start= demand
REM sc config QWAVE start= demand
REM sc config RasAuto start= demand
REM sc config RasMan start= demand
REM sc config SessionEnv start= auto
REM sc config TermService start= auto
REM sc config UmRdpService start= auto
REM sc config RpcLocator start= demand
REM sc config RemoteRegistry start= disabled
REM sc config RetailDemo start= demand
REM sc config RemoteAccess start= disabled
REM sc config seclogon start= demand
REM sc config SstpSvc start= demand
REM sc config SamSs start= auto
REM sc config SensorDataService start= demand
REM sc config SensrSvc start= demand
REM sc config SensorService start= demand
REM sc config LanmanServer start= auto
REM sc config ShellHWDetection start= auto
REM sc config SCardSvr start= disabled
REM sc config ScDeviceEnum start= demand
REM sc config SCPolicySvc start= demand
REM sc config SNMPTRAP start= demand
REM sc config svsvc start= demand
REM sc config SSDPSRV start= demand
REM sc config WiaRpc start= demand
REM sc config StorSvc start= demand
REM sc config SysMain start= auto
REM sc config SENS start= auto
REM sc config lmhosts start= demand
REM sc config TapiSrv start= demand
REM sc config Themes start= disabled
REM sc config TabletInputService start= demand
REM sc config UsoSvc start= demand
REM sc config upnphost start= demand
REM sc config UserManager start= auto
REM sc config ProfSvc start= auto
REM sc config vds start= demand
REM sc config VSS start= demand
REM sc config WalletService start= demand
REM sc config WebClient start= demand
REM sc config AudioSrv start= auto
REM sc config AudioEndpointBuilder start= auto
REM sc config SDRSVC start= demand
REM sc config WbioSrvc start= demand
REM sc config wcncsvc start= demand
REM sc config Wcmsvc start= auto
REM sc config WinDefend start= auto
REM sc config WEPHOSTSVC start= demand
REM sc config WerSvc start= demand
REM sc config Wecsvc start= demand
REM sc config EventLog start= auto
REM sc config FontCache start= auto
REM sc config StiSvc start= demand
REM sc config LicenseManager start= demand
REM sc config Winmgmt start= disabled
REM sc config WMPNetworkSvc start= demand
REM sc config icssvc start= demand
REM sc config TrustedInstaller start= demand
REM sc config WpnService start= demand
REM sc config WinRM start= demand
REM sc config WSearch start= delayed-auto
REM sc config W32Time start= auto
REM sc config wuauserv start= auto
REM sc config dot3svc start= demand
REM sc config Wlansvc start= demand
REM sc config wmiApSrv start= demand
REM sc config LanmanWorkstation start= auto
REM sc config WwanSvc start= demand
REM sc config XblAuthManager start= disabled
REM sc config XblGameSave start= disabled
REM sc config XboxNetApiSvc start= disabled
REM
REM :: Powerplan
REM powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
REM powercfg -h off
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c fea3413e-7e05-4911-9a71-700331f1c294 0e796bdb-100d-47d6-a2d5-f7d2daa51f51 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c fea3413e-7e05-4911-9a71-700331f1c294 0e796bdb-100d-47d6-a2d5-f7d2daa51f51 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 02f815b5-a5cf-4c84-bf20-649d1f75d3d8 4c793e7d-a264-42e1-87d3-7a0d2f523ccd 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 02f815b5-a5cf-4c84-bf20-649d1f75d3d8 4c793e7d-a264-42e1-87d3-7a0d2f523ccd 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0d7dbae2-4294-402a-ba8e-26777e8488cd 309dce9b-bef4-4119-9921-a851fb12f0f4 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0d7dbae2-4294-402a-ba8e-26777e8488cd 309dce9b-bef4-4119-9921-a851fb12f0f4 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 94ac6d29-73ce-41a6-809f-6363ba21b47e 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 94ac6d29-73ce-41a6-809f-6363ba21b47e 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 9d7815a6-7ee4-497e-8888-515a05f02364 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 9d7815a6-7ee4-497e-8888-515a05f02364 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 a7066653-8d6c-40a8-910e-a1f54b84c7e5 2
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 a7066653-8d6c-40a8-910e-a1f54b84c7e5 2
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb 100
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb 75
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 f1fbfde2-a960-4165-9f88-50667911ce96 75
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 f1fbfde2-a960-4165-9f88-50667911ce96 50
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 2
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 2
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 34c7b99f-9a6d-4b3c-8dc7-b6693b78cef4 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 34c7b99f-9a6d-4b3c-8dc7-b6693b78cef4 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 637ea02f-bbcb-4015-8e2c-a1c7b9c0b546 3
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 637ea02f-bbcb-4015-8e2c-a1c7b9c0b546 3
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 9a66d8d7-4ff7-4ef9-b5a2-5a326ca2a469 7
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 9a66d8d7-4ff7-4ef9-b5a2-5a326ca2a469 7
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 8183ba9a-e910-48da-8769-14ae6dc1170a 10
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 8183ba9a-e910-48da-8769-14ae6dc1170a 10
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f bcded951-187b-4d05-bccc-f7e51960c258 1
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f bcded951-187b-4d05-bccc-f7e51960c258 1
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f d8742dcb-3e6a-4b3c-b3fe-374623cdcf06 3
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f d8742dcb-3e6a-4b3c-b3fe-374623cdcf06 3
REM powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f f3c5027d-cd16-4930-aa6b-90db844a8f00 3
REM powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f f3c5027d-cd16-4930-aa6b-90db844a8f00 3

:: Firewall (Allow icmp)
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow
netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol="icmpv6:8,any" dir=in action=allow

:: SSH Client and Server
powershell.exe "Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0"
powershell.exe "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"
echo D | xcopy /s /Y /I D:\postinstall\ssh\id_rsa.pub C:\ProgramData\ssh\administrators_authorized_keys
echo D | xcopy /s /Y /I D:\postinstall\ssh\sshd_config C:\ProgramData\ssh\sshd_config
echo D | xcopy /s /Y /I D:\postinstall\ssh\id_rsa.pub C:\Users\user\.ssh\authorized_keys
powershell.exe "Set-Service ssh-agent -StartupType automatic"
powershell.exe "Start-Service ssh-agent"
powershell.exe "Set-Service sshd -StartupType automatic"
powershell.exe "Start-Service sshd"

:: Windows update
:: powershell.exe -ExecutionPolicy Bypass "Install-Module PSWindowsUpdate -Confirm"
:: powershell.exe -ExecutionPolicy Bypass "Import-Module PSWindowsUpdate"
:: powershell.exe -ExecutionPolicy Bypass "Get-WindowsUpdate"
:: powershell.exe -ExecutionPolicy Bypass "Install-WindowsUpdate -AcceptAll"
:: Reboot
shutdown -f -r -t 10
::

