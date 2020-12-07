Open_ARM_Workbench()
Sleep(2000)
Open_Project()
Sleep(2000)
Clean_Build()
Sleep(2000)
Close_ARM_Workbench()

Func Open_ARM_Workbench()
   Sleep(500)

   WinClose("[CLASS:SWT_Window0]","")
   Sleep(2000)

   Run('"C:\Program Files\ARM\Java\JRE\1.6.0.4\3\win-all\bin\javaw.exe" "-Darmroot=C:\Program Files\ARM" -jar "C:\Program Files\ARM\ARM Workbench IDE 4.0\launchers.jar" win_32-pentium',"",@SW_MAXIMIZE)
   WinWaitActive("[CLASS:SWT_Window0]", "Replay breakpoints are")
EndFunc

Func Clean_Build()
   Sleep(500)

   Send("^u")
   Sleep(500)
   ControlCommand("Clean","Clean will discard all","Button1","Check")
   Sleep(500)
   ControlCommand("Clean","Clean will discard all","Button3","Check")
   Sleep(500)
   ControlClick("Clean","Clean will discard all","Button4")

   Sleep(500)
EndFunc

Func Close_ARM_Workbench()
   WinWaitClose("Building Workspace")
   WinClose("[CLASS:SWT_Window0]","")

   Sleep(500)
EndFunc

Func Open_Project()
   Send("{F5}")
   #comments-start
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
   #comments-end
EndFunc