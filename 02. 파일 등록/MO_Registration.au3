#RequireAdmin

#include <Date.au3>

Global $Time_Value=@YEAR&"_"&@MON&"_"&@MDAY&"_"&StringReplace(_NowTime(5),":","_")
Global $EPI_File_Name="EPI_DSC-14_"&$Time_Value&"(Encrypted).epi"
Global $Timeout = 600
Global $Sleep_Time = 500

Local $TMP_PID

$TMP_PID = Open_KPMS()
Sleep(2000)
PI_Encrypt_management($TMP_PID)
Sleep(2000)
Open_EPISetCreator()
Sleep(2000)
Test_Node()
Sleep(2000)


ConsoleWrite("Running Insertion.au3"&@CRLF)

; Insertion 호출
Run("C:\Program Files\AutoIt3\AutoIt3.exe "&@ScriptDir&"\MO_Insertion.au3")

Func Open_KPMS()
   Local $PID, $Error_Code

   ConsoleWrite("Open_KPMS"&@CRLF)

   WinClose("MOP-11 v2.2.0.0")
   Sleep(2000)

   $PID = Run("cmd")
   If $PID == 0 Then
	  Display_Error("Can't execute cmd!")
   EndIf
   $Error_Code = WinWaitActive("[CLASS:ConsoleWindowClass]","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't open cmd!")
   EndIf
   Sleep($Sleep_Time)

   Send("cd C:\Users\admin\Desktop\키주입 2.3\")
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)
   Send("1.KPMS실행.bat")
   Sleep($Sleep_Time)
   Send("{Enter}")
   $Error_Code = WinWaitActive("[CLASS:#32770]","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't open KPMS!")
   EndIf

   Return $PID
EndFunc

Func PI_Encrypt_management($PID)
   Local $Error_Code

   ConsoleWrite("PI_Encrypt_management"&@CRLF)

   ControlClick("MOP-11 v2.2.0.0","","Button18")
   Sleep($Sleep_Time)
   ControlClick("MOP-11 v2.2.0.0","생성","Button13")
   $Error_Code = WinWaitActive("PI 암호화","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't do PI Encrypt!")
   EndIf
   Sleep($Sleep_Time)

   Send("{down}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send(@ScriptDir&"\{!}epi{!}.src")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send($Time_Value)
   Sleep($Sleep_Time)
   ControlClick("PI 암호화","확인","Button2")
   $Error_Code = WinWaitActive("[CLASS:#32770]","예",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't get Encrypted PI file for transfer!")
   EndIf
   Sleep($Sleep_Time)
   Send("!y")
   Sleep($Sleep_Time)

   Send("{BS}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Locate_Dir()
   Sleep($Sleep_Time)
   Send("+{tab}")
   Sleep($Sleep_Time)
   ControlSend("다른 이름으로 저장","","Edit1",$EPI_File_Name)
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)
   $Error_Code = WinWaitActive("[CLASS:#32770]","확인",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't tranfer Encrypted PI file!")
   EndIf
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)

   WinClose("MOP-11 v2.2.0.0")
   $Error_Code = WinWaitClose("MOP-11 v2.2.0.0","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't Close KPMS!")
   EndIf
   Sleep($Sleep_Time)
   ProcessClose($PID)
EndFunc

Func Open_EPISetCreator()
   Local $PID, $Error_Code

   ConsoleWrite("Open_EPISetCreator"&@CRLF)

   WinClose("EPI Set Creator ( 제작일 : 2012.07.11, Version : 0.32 )")
   Sleep(2000)

   $PID = Run("C:\EPISetCreator\EPISetCreator_v0.32(2012.07.11).exe")
   If $PID == 0 Then
	  Display_Error("Can't execute EPI Set Creator!")
   EndIf
   $Error_Code = WinWaitActive("[CLASS:#32770]","EPI Pack",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't open EPI Set Creator!")
   EndIf
   Sleep($Sleep_Time)

   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{down}")
   Sleep($Sleep_Time)
   Send("+{tab}")
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)
   Locate_Dir()
   Sleep($Sleep_Time)
   ControlSend("열기","","Edit1",$EPI_File_Name)
   Sleep($Sleep_Time)
   Send("!o")
   Sleep($Sleep_Time)
   ControlClick("EPI Set Creator ( 제작일 : 2012.07.11, Version : 0.32 )","실행","Button1")
   Sleep($Sleep_Time)

   $Error_Code = ProcessClose($PID)
   If $Error_Code == 0 Then
	  Display_Error("Can't Close EPI Set Creator!")
   EndIf
EndFunc

Func Test_Node()
   Local $PID, $Error_Code

   ConsoleWrite("Test_Node"&@CRLF)

   $PID = Run("C:\Program Files\NSRI\시험단말(PI,v1.1)\PI_PC.exe")
   If $PID == 0 Then
	  Display_Error("Can't execute Test Node!")
   EndIf
   $Error_Code = WinWaitActive("[CLASS:#32770]","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't open Test Node!")
   EndIf
   Sleep($Sleep_Time)

   ControlSend("[CLASS:#32770]","","RichEdit20A1","aa")
   Sleep($Sleep_Time)
   ControlSend("[CLASS:#32770]","","RichEdit20A2","aa")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:#32770]","","Button1")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:#32770]","","Button1")
   Sleep($Sleep_Time)
   WinWaitClose("[CLASS:#32770]","")
   WinActivate("[CLASS:AfxWnd90sd]")
   $Error_Code = WinWaitActive("[CLASS:AfxWnd90sd]","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't login Test Node!")
   EndIf
   Sleep($Sleep_Time)
   Sleep($Sleep_Time)

   ControlClick("[CLASS:AfxWnd90sd]","","Button10")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:AfxWnd90sd]","","Button15")
   $Error_Code = WinWaitActive("[CLASS:#32770]","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't regist program!")
   EndIf
   Sleep($Sleep_Time)

   ControlClick("[CLASS:#32770]","","Button1")
   Sleep($Sleep_Time)
   Locate_Dir(@ScriptDir&"\(PI)DSC-14")
   Sleep($Sleep_Time)
   ControlSend("열기","","Edit1","DSC-14.EPI")
   Sleep($Sleep_Time)
   Send("!o")
   Sleep($Sleep_Time)
   ControlSend("[CLASS:#32770]","","RichEdit20A2","개발용")
   Sleep($Sleep_Time)
   ControlSend("[CLASS:#32770]","","RichEdit20A3","DSC-14")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:#32770]","","Button2")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:#32770]","","Button1")
   $Error_Code = WinWaitClose("[CLASS:#32770]","알림 메시지",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't regist program!")
   EndIf
   Sleep($Sleep_Time)

   $Error_Code = ProcessClose($PID)
   If $Error_Code == 0 Then
	  Display_Error("Can't Close Test Node!")
   EndIf
EndFunc

Func Locate_Dir($Location = @ScriptDir)
   Local $Error_Code

   $Error_Code = WinWaitActive("[CLASS:#32770]","ShellView",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't find file!")
   EndIf
   Sleep($Sleep_Time)

   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{tab}")
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)
   Send("{BS}")
   Sleep($Sleep_Time)
   Send($Location)
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)
   Send("+{tab}")
   Sleep($Sleep_Time)
   Send("+{tab}")
   Sleep($Sleep_Time)
   Send("+{tab}")
   Sleep($Sleep_Time)
   Send("+{tab}")
EndFunc

Func Display_Error($error_exp = "Error")
   ConsoleWrite($error_exp)
   Exit(1)
EndFunc