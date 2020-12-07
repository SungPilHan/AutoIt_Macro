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
   Local $PID

   WinClose("[CLASS:SWT_Window0]","")
   Sleep(2000)

   $PID = Run('"C:\Program Files\ARM\Java\JRE\1.6.0.4\3\win-all\bin\javaw.exe" "-Darmroot=C:\Program Files\ARM" -jar "C:\Program Files\ARM\ARM Workbench IDE 4.0\launchers.jar" win_32-pentium',"",@SW_MAXIMIZE)
   If $PID == 0 Then
	  Display_Error("Can't open ARM Workbench!")
   EndIf

   WinWaitActive("[CLASS:SWT_Window0]", "Replay breakpoints are")
EndFunc

Func Clean_Build()
   Local $Error_Code

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

   $Error_Code = WinWaitClose("Building Workspace","Building",$Timeout)
   if $Error_Code == 0 Then
	  Display_Error("Build is too long!")
   EndIf

   WinClose("[CLASS:SWT_Window0]","")
EndFunc

Func Open_Project()
   Send("{F5}")
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
   ConsoleWrite($error_exp)
   Exit(1)
EndFunc