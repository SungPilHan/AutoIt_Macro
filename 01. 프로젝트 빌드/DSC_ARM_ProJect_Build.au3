#RequireAdmin

Global $Timeout = 600
Global $Sleep_Time = 500

Open_ARM_Workbench()
Sleep(2000)
Open_Project()
Sleep(2000)
Clean_Build()
Sleep(2000)
Close_ARM_Workbench()

Func Open_ARM_Workbench()
   Local $PID, $hWnd

   ConsoleWrite("Open_ARM_Workbench"&@CRLF)

   WinClose("[CLASS:SWT_Window0]","")
   Sleep(2000)

   $PID = Run('"C:\Program Files\ARM\Java\JRE\1.6.0.4\3\win-all\bin\javaw.exe" "-Darmroot=C:\Program Files\ARM" -jar "C:\Program Files\ARM\ARM Workbench IDE 4.0\launchers.jar" win_32-pentium')
   If $PID == 0 Then
	  Display_Error("Can't open ARM Workbench!")
   EndIf

   WinWait("[CLASS:SWT_Window0]", "Replay breakpoints are")
   WinActivate("[CLASS:SWT_Window0]")

   WinWaitActive("[CLASS:SWT_Window0]", "Replay breakpoints are")
EndFunc

Func Clean_Build()
   Local $Error_Code

   ConsoleWrite("Clean_Build"&@CRLF)

   Send("^u")
   $Error_Code = WinWaitActive("Clean","Clean will discard",$Timeout)
   if $Error_Code == 0 Then
	  Display_Error("Can't open Build Clean!")
   EndIf

   ControlCommand("Clean","Clean will discard all","Button1","Check")
   Sleep($Sleep_Time)
   ControlCommand("Clean","Clean will discard all","Button3","Check")
   Sleep($Sleep_Time)
   ControlClick("Clean","Clean will discard all","Button4")
EndFunc

Func Close_ARM_Workbench()
   Local $Error_Code

   ConsoleWrite("Close_ARM_Workbench"&@CRLF)

   $Error_Code = WinWaitClose("Building Workspace","Building",$Timeout)
   if $Error_Code == 0 Then
	  Display_Error("Build is too long!")
   EndIf

   Sleep($Sleep_Time)
   WinClose("[CLASS:SWT_Window0]","")
EndFunc

Func Open_Project()

   ConsoleWrite("Open_Project"&@CRLF)

   Sleep(2000)
   ControlClick("[CLASS:SWT_Window0]","Replay breakpoints are","SysTreeView322","left",1,60,10)
   Send("{F5}")
   Sleep(2000)
   ControlClick("[CLASS:SWT_Window0]","Replay breakpoints are","SysTreeView322","left",1,60,25)
   Send("{F5}")
   Sleep(2000)
   ControlClick("[CLASS:SWT_Window0]","Replay breakpoints are","SysTreeView322","left",1,60,45)
   Send("{F5}")
   Sleep(2000)
   #comments-start
   Sleep($Sleep_Time)
   Send("!f")
   Sleep($Sleep_Time)
   Send("i")
   Sleep($Sleep_Time)
   Send("{BS}")
   Sleep($Sleep_Time)
   ControlSend("Import","","Edit1","existing projects into workspace")
   Sleep($Sleep_Time)
   ControlSend("Import","","Edit1","{Enter}")
   Sleep($Sleep_Time)
   Send("!n")
   Sleep($Sleep_Time)
   Send("!r")
   Sleep($Sleep_Time)
   ControlSend("폴더 찾아보기","","Edit1","a")
   Sleep($Sleep_Time)
   ControlSend("폴더 찾아보기","","Edit1","^a")
   Sleep($Sleep_Time)
   Send("{BS}")
   Sleep($Sleep_Time)
   ControlSend("폴더 찾아보기","","Edit1",@ScriptDir)
   Sleep($Sleep_Time)
   ControlSend("폴더 찾아보기","","Edit1","{Enter}")
   Sleep($Sleep_Time)
   Send("!f")
   Sleep($Sleep_Time)
   #comments-end
EndFunc

Func Display_Error($error_exp)
   ConsoleWrite($error_exp&@CRLF)
   Exit(1)
EndFunc