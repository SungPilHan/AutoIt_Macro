#RequireAdmin

Global $Timeout = 600
Global $Sleep_Time = 500

Local $TMP_PID

Test_Node()
Sleep(2000)
$TMP_PID = Open_KIS()
Sleep(2000)
Insert_Key($TMP_PID)

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

   ControlClick("[CLASS:AfxWnd90sd]","","Button9")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:AfxWnd90sd]","","SysListView321","left",1,160,40)
   Sleep($Sleep_Time)
   ControlClick("[CLASS:AfxWnd90sd]","","Button17")
   WinWaitClose("[CLASS:AfxWnd90sd]","")
   WinActivate("[CLASS:#32770]")
   WinWaitActive("[CLASS:#32770]","알림 메시지")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:#32770]","","Button1")
   $Error_Code = WinWaitClose("[CLASS:#32770]","알림 메시지",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Insertion is too long!")
   EndIf
   Sleep($Sleep_Time)

   $Error_Code = ProcessClose($PID)
   If $Error_Code == 0 Then
	  Display_Error("Can't Close Test node!")
   EndIf
EndFunc

Func Open_KIS()
   Local $PID, $Error_Code

   ConsoleWrite("Open_KIS"&@CRLF)

   Sleep($Sleep_Time)
   WinClose("MOI-11 v2.2.0.2")
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

   Sleep($Sleep_Time)
   Send("cd C:\Users\admin\Desktop\키주입 2.3\")
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)
   Send("6.KIS실행.bat")
   Sleep($Sleep_Time)
   Send("{Enter}")
   Sleep($Sleep_Time)
   Send("{Enter}")
   Return $PID
EndFunc

Func Insert_Key($PID)
   Local $Error_Code

   ConsoleWrite("Insert_Key"&@CRLF)

   Sleep($Sleep_Time)
   ControlCommand("로그인","온라인","Button2","Check")
   Sleep($Sleep_Time)
   ControlClick("로그인","온라인","Button3")
   Sleep($Sleep_Time)
   ControlClick("MOI-11 v2.2.0.2","","Button17")
   Sleep($Sleep_Time)
   ControlClick("MOI-11 v2.2.0.2","재조회","Button16")
   Sleep($Sleep_Time)
   ControlClick("장비 주입시 키종류 선택","DSC-14","Button1")
   $Error_Code = WinWaitActive("[CLASS:#32770]","주입하시겠습니까",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't select Key!")
   EndIf
   Sleep($Sleep_Time)

   ControlClick("[CLASS:#32770]","","Button1")
   $Error_Code = WinWaitActive("[CLASS:#32770]","암호장비가 수신한 키를 저장하고 있습니다.",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't select Key!")
   EndIf
   Sleep($Sleep_Time)

   ControlClick("[CLASS:#32770]","확인","Button1")
   Sleep($Sleep_Time)
   ControlClick("[CLASS:#32770]","확인","Button1")
   Sleep($Sleep_Time)

   WinClose("MOI-11 v2.2.0.2")
   $Error_Code = WinWaitClose("MOI-11 v2.2.0.2","",$Timeout)
   If $Error_Code == 0 Then
	  Display_Error("Can't Close KPMS!")
   EndIf
   Sleep($Sleep_Time)
   ProcessClose($PID)
EndFunc