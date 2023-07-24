echo off

:: VirtIO guest agent
D:\virtio\virtio-win-guest-tools.exe /install /passive /quite /norestart

:: Some Tools
msiexec /package "D:\postinstall\installer\Firefox Setup 102.12.0esr.msi" /qr
D:\postinstall\installer\npp.8.5.3.Installer.x64.exe /S
D:\postinstall\installer\Git-2.41.0-64-bit.exe /SILENT
D:\postinstall\installer\python-3.11.4-amd64.exe /passive
powershell.exe "Remove-Item $env:USERPROFILE\AppData\Local\Microsoft\WindowsApps\python*.exe"

:: Python Environment
setx /M PATH "C:\Users\user\AppData\Local\Programs\Python\Python311\;C:\Users\user\AppData\Local\Programs\Python\Python311\Scripts\;C:\Users\user\daas\env\;C:\Users\user\daas\env\api;C:\Users\user\daas\env\pstools;%PATH%"
C:\Users\user\AppData\Local\Programs\Python\Python311\python -m pip install --upgrade pip
C:\Users\user\AppData\Local\Programs\Python\Python311\Scripts\pip install click

:: Windows features, services, powerplan
:: Features
dism /Online /Disable-Feature /FeatureName:"DirectPlay" /NoRestart
dism /Online /Disable-Feature /FeatureName:"LegacyComponents" /NoRestart
dism /Online /Enable-Feature /FeatureName:"MediaPlayback" /NoRestart
dism /Online /Enable-Feature /FeatureName:"Printing-Foundation-Features" /NoRestart
dism /Online /Enable-Feature /FeatureName:"Printing-Foundation-InternetPrinting-Client" /NoRestart
dism /Online /Disable-Feature /FeatureName:"Printing-Foundation-LPDPrintService" /NoRestart
dism /Online /Disable-Feature /FeatureName:"Printing-Foundation-LPRPortMonitor" /NoRestart
dism /Online /Enable-Feature /FeatureName:"Printing-PrintToPDFServices-Features" /NoRestart
dism /Online /Disable-Feature /FeatureName:"Printing-XPSServices-Features" /NoRestart
dism /Online /Enable-Feature /FeatureName:"SearchEngine-Client-Package" /NoRestart
dism /Online /Disable-Feature /FeatureName:"TelnetClient" /NoRestart
dism /Online /Disable-Feature /FeatureName:"TFTP" /NoRestart
dism /Online /Disable-Feature /FeatureName:"TIFFIFilter" /NoRestart
dism /Online /Enable-Feature /FeatureName:"WindowsMediaPlayer" /NoRestart
dism /Online /Disable-Feature /FeatureName:"WorkFolders-Client" /NoRestart

:: Services
sc config AxInstSV start= demand
sc config AJRouter start= demand
sc config AppReadiness start= demand
sc config Appinfo start= demand
sc config ALG start= demand
sc config AppMgmt start= demand
sc config BITS start= delayed-auto
sc config BDESVC start= demand
sc config wbengine start= demand
sc config bthserv start= demand
sc config PeerDistSvc start= demand
sc config CDPSvc start= demand
sc config CertPropSvc start= demand
sc config KeyIso start= demand
sc config EventSystem start= auto
sc config COMSysApp start= demand
sc config VaultSvc start= demand
sc config CryptSvc start= auto
sc config DsSvc start= demand
sc config DoSvc start= delayed-auto
sc config DeviceAssociationService start= demand
sc config DeviceInstall start= demand
sc config DmEnrollmentSvc start= demand
sc config DsmSvc start= demand
sc config DevQueryBroker start= demand
sc config Dhcp start= auto
sc config DPS start= disabled
sc config WdiServiceHost start= disabled
sc config WdiSystemHost start= disabled
sc config DiagTrack start= disabled
sc config TrkWks start= auto
sc config MSDTC start= demand
sc config dmwappushservice start= disabled
sc config MapsBroker start= delayed-auto
sc config EFS start= demand
sc config EapHost start= demand
sc config Fax start= disabled
sc config fhsvc start= demand
sc config fdPHost start= demand
sc config FDResPub start= demand
sc config lfsvc start= demand
sc config hidserv start= demand
sc config vmickvpexchange start= disabled
sc config vmicguestinterface start= disabled
sc config vmicshutdown start= disabled
sc config vmicheartbeat start= disabled
sc config vmicrdv start= disabled
sc config vmictimesync start= disabled
sc config vmicvmsession start= disabled
sc config vmicvss start= disabled
sc config IKEEXT start= demand
sc config SharedAccess start= demand
sc config iphlpsvc start= auto
sc config PolicyAgent start= demand
sc config KtmRm start= demand
sc config lltdsvc start= demand
sc config diagnosticshub.standardcollector.service start= demand
sc config wlidsvc start= demand
sc config MSiSCSI start= demand
sc config swprv start= demand
sc config smphost start= demand
sc config SmsRouter start= demand
sc config NetTcpPortSharing start= disabled
sc config Netlogon start= demand
sc config NcdAutoSetup start= demand
sc config NcbService start= demand
sc config Netman start= demand
sc config NcaSvc start= demand
sc config netprofm start= demand
sc config NlaSvc start= auto
sc config NetSetupSvc start= demand
sc config nsi start= auto
sc config CscService start= demand
sc config defragsvc start= demand
sc config PNRPsvc start= demand
sc config p2psvc start= demand
sc config p2pimsvc start= demand
sc config pla start= demand
sc config PlugPlay start= demand
sc config PNRPAutoReg start= demand
sc config WPDBusEnum start= demand
sc config Power start= auto
sc config Spooler start= auto
sc config PrintNotify start= demand
sc config wercplsupport start= demand
sc config PcaSvc start= demand
sc config QWAVE start= demand
sc config RasAuto start= demand
sc config RasMan start= demand
sc config SessionEnv start= auto
sc config TermService start= auto
sc config UmRdpService start= auto
sc config RpcLocator start= demand
sc config RemoteRegistry start= disabled
sc config RetailDemo start= demand
sc config RemoteAccess start= disabled
sc config seclogon start= demand
sc config SstpSvc start= demand
sc config SamSs start= auto
sc config SensorDataService start= demand
sc config SensrSvc start= demand
sc config SensorService start= demand
sc config LanmanServer start= auto
sc config ShellHWDetection start= auto
sc config SCardSvr start= disabled
sc config ScDeviceEnum start= demand
sc config SCPolicySvc start= demand
sc config SNMPTRAP start= demand
sc config svsvc start= demand
sc config SSDPSRV start= demand
sc config WiaRpc start= demand
sc config StorSvc start= demand
sc config SysMain start= auto
sc config SENS start= auto
sc config lmhosts start= demand
sc config TapiSrv start= demand
sc config Themes start= disabled
sc config TabletInputService start= demand
sc config UsoSvc start= demand
sc config upnphost start= demand
sc config UserManager start= auto
sc config ProfSvc start= auto
sc config vds start= demand
sc config VSS start= demand
sc config WalletService start= demand
sc config WebClient start= demand
sc config AudioSrv start= auto
sc config AudioEndpointBuilder start= auto
sc config SDRSVC start= demand
sc config WbioSrvc start= demand
sc config wcncsvc start= demand
sc config Wcmsvc start= auto
sc config WinDefend start= auto
sc config WEPHOSTSVC start= demand
sc config WerSvc start= demand
sc config Wecsvc start= demand
sc config EventLog start= auto
sc config FontCache start= auto
sc config StiSvc start= demand
sc config LicenseManager start= demand
sc config Winmgmt start= disabled
sc config WMPNetworkSvc start= demand
sc config icssvc start= demand
sc config TrustedInstaller start= demand
sc config WpnService start= demand
sc config WinRM start= demand
sc config WSearch start= delayed-auto
sc config W32Time start= auto
sc config wuauserv start= auto
sc config dot3svc start= demand
sc config Wlansvc start= demand
sc config wmiApSrv start= demand
sc config LanmanWorkstation start= auto
sc config WwanSvc start= demand
sc config XblAuthManager start= disabled
sc config XblGameSave start= disabled
sc config XboxNetApiSvc start= disabled

:: Powerplan
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg -h off
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c fea3413e-7e05-4911-9a71-700331f1c294 0e796bdb-100d-47d6-a2d5-f7d2daa51f51 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c fea3413e-7e05-4911-9a71-700331f1c294 0e796bdb-100d-47d6-a2d5-f7d2daa51f51 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 02f815b5-a5cf-4c84-bf20-649d1f75d3d8 4c793e7d-a264-42e1-87d3-7a0d2f523ccd 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 02f815b5-a5cf-4c84-bf20-649d1f75d3d8 4c793e7d-a264-42e1-87d3-7a0d2f523ccd 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0d7dbae2-4294-402a-ba8e-26777e8488cd 309dce9b-bef4-4119-9921-a851fb12f0f4 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 0d7dbae2-4294-402a-ba8e-26777e8488cd 309dce9b-bef4-4119-9921-a851fb12f0f4 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 29f6c1db-86da-48c5-9fdb-f2b67b1f44da 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 94ac6d29-73ce-41a6-809f-6363ba21b47e 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 94ac6d29-73ce-41a6-809f-6363ba21b47e 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 9d7815a6-7ee4-497e-8888-515a05f02364 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 9d7815a6-7ee4-497e-8888-515a05f02364 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 238c9fa8-0aad-41ed-83f4-97be242c8f20 bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 a7066653-8d6c-40a8-910e-a1f54b84c7e5 2
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 4f971e89-eebd-4455-a8de-9e59040e7347 a7066653-8d6c-40a8-910e-a1f54b84c7e5 2
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 893dee8e-2bef-41e0-89c6-b55d0929964c 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 bc5038f7-23e0-4960-96da-33abaf5935ec 100
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 54533251-82be-4824-96c1-47b60b740d00 94d3a615-a899-4ac5-ae2b-e4d8f634367f 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 fbd9aa66-9553-4097-ba44-ed6e9d65eab8 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb 100
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb 75
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 f1fbfde2-a960-4165-9f88-50667911ce96 75
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 7516b95f-f776-4464-8c53-06167f40cc99 f1fbfde2-a960-4165-9f88-50667911ce96 50
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 2
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 2
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 34c7b99f-9a6d-4b3c-8dc7-b6693b78cef4 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 34c7b99f-9a6d-4b3c-8dc7-b6693b78cef4 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 637ea02f-bbcb-4015-8e2c-a1c7b9c0b546 3
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 637ea02f-bbcb-4015-8e2c-a1c7b9c0b546 3
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 9a66d8d7-4ff7-4ef9-b5a2-5a326ca2a469 7
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 9a66d8d7-4ff7-4ef9-b5a2-5a326ca2a469 7
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 8183ba9a-e910-48da-8769-14ae6dc1170a 10
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f 8183ba9a-e910-48da-8769-14ae6dc1170a 10
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f bcded951-187b-4d05-bccc-f7e51960c258 1
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f bcded951-187b-4d05-bccc-f7e51960c258 1
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f d8742dcb-3e6a-4b3c-b3fe-374623cdcf06 3
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f d8742dcb-3e6a-4b3c-b3fe-374623cdcf06 3
powercfg -setacvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f f3c5027d-cd16-4930-aa6b-90db844a8f00 3
powercfg -setdcvalueindex 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c e73a048d-bf27-4f12-9731-8b2076e8891f f3c5027d-cd16-4930-aa6b-90db844a8f00 3

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

