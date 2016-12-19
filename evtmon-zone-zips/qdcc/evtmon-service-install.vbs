' ###########################################
'# Purpose: Create srvany evtmon registry entries
'# Author/Date: mgravlin 05/10/2010
' ###########################################

Run """C:\evtmon\Instsrv.exe"" EvtMon ""C:\evtmon\Srvany.exe"""

' ##### Variables
const HKEY_LOCAL_MACHINE = &H80000002
strComputer = "."

' ##### Create SEC Key ##### 
Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_ 
strComputer & "\root\default:StdRegProv")
 
strKeyPath = "SYSTEM\CurrentControlSet\Services\evtmon\Parameters"
oReg.CreateKey HKEY_LOCAL_MACHINE,strKeyPath

' ##### Create String value #####
strValueName = "Application"
strValue = "C:\evtmon\evtmon.exe"
oReg.SetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
Set oReg=Nothing

Sub Run(ByVal sFile)
Dim shell
    Set shell = CreateObject("WScript.Shell")
    'shell.Run Chr(34) & sFile & Chr(34), 1, false
    shell.Run sFile, 1, false
    Set shell = Nothing
End Sub