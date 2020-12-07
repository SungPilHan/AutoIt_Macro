Open_ARM_Workbench()
Sleep(2000)
Open_Project()
Sleep(2000)
Clean_Build()


Func Open_ARM_Workbench()
   Sleep(500)
   WinClose("[CLASS:SWT_Window0]","")
   Sleep(2000)

   Run('"C:\Program Files\ARM\Java\JRE\1.6.0.4\3\win-all\bin\javaw.exe" "-Darmroot=C:\Program Files\ARM" -jar "C:\Program Files\ARM\ARM Workbench IDE 4.0\launchers.jar" win_32-pentium',"",@SW_MAXIMIZE)
   WinWait("[CLASS:SWT_Window0]", "", 10)

   While True
	  Sleep(5000)
	  if WinExists("[CLASS:SWT_Window0]") Then
		 ExitLoop
	  EndIf
   WEnd
   Sleep(500)
EndFunc

Func Open_Project()
   Sleep(500)
   Send("!f")
   Sleep(500)
   Send("i")
   Sleep(500)
   Send("{BS}")
   Sleep(500)
   ControlSend("Import","","Edit1","existing projects into workspace")
   Sleep(500)
   ControlSend("Import","","Edit1","{Enter}")
   Sleep(500)
   Send("!n")
   Sleep(500)
   Send("!r")
   Sleep(500)
   ControlSend("폴더 찾아보기","","Edit1","a")
   Sleep(500)
   ControlSend("폴더 찾아보기","","Edit1","^a")
   Sleep(500)
   Send("{BS}")
   Sleep(500)
   ControlSend("폴더 찾아보기","","Edit1",@ScriptDir)
   Sleep(500)
   ControlSend("폴더 찾아보기","","Edit1","{Enter}")
   Sleep(500)
   Send("!f")
   Sleep(500)
EndFunc

Func Clean_Build()
   Send("^u")
   Sleep(500)
   ControlCommand("Clean","","Button1","Check")
   Sleep(500)
   ControlCommand("Clean","","Button3","Check")
   Sleep(500)
   ControlCommand("Clean","","Button4","Check")
   Sleep(500)
EndFunc