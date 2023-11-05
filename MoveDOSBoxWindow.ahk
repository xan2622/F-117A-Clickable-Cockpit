#Requires AutoHotkey v2





	if WinExist("ahk_exe dosbox.exe") {
			WinActivate
			
			; Get the DOSBox position and dimensions
			WinGetPos &DOSBox_WindowX, &DOSBox_WindowY , &DOSBox_WindowW, &DOSBox_WindowH, "DOSBox"
			WinGetClientPos &DOSBox_WindowClientX, &DOSBox_WindowClientY, &DOSBox_WindowClientW, &DOSBox_WindowClientH, "DOSBox"
				; MsgBox "DOSBox is at " DOSBox_WindowX "," DOSBox_WindowY " and its size is " DOSBox_WindowW "x" DOSBox_WindowH
				; MsgBox "DOSBox's client is at " DOSBox_WindowClientX "," DOSBox_WindowClientY " and its client size is " DOSBox_WindowClientW "x" DOSBox_WindowClientH		
					
			; Moves the DosBox window to 0,0 (the following line can be commented if you prefer to move the window somewhere else)
			WinMove -1, 0, ,, "DOSBox"
			
		} else if WinExist("ahk_exe dosbox-x.exe") {
			WinActivate
			
			; Get the DOSBox-X position and dimensions		
			WinGetPos &DOSBoxX_WindowX, &DOSBoxX_WindowY , &DOSBoxX_WindowW, &DOSBoxX_WindowH, "DOSBox-X"
			WinGetClientPos &DOSBoxX_WindowClientX, &DOSBoxX_WindowClientY, &DOSBoxX_WindowClientW, &DOSBoxX_WindowClientH, "DOSBox-X"
				; MsgBox "DOSBox-X is at " DOSBoxX_WindowX "," DOSBoxX_WindowY " and its size is " DOSBoxX_WindowW "x" DOSBoxX_WindowH
				; MsgBox "DOSBox-X's client is at " DOSBoxX_WindowClientX "," DOSBoxX_WindowClientY " and its client size is " DOSBoxX_WindowClientW "x" DOSBoxX_WindowClientH		

			; Moves the DosBox-X window to 0,0 (the following line can be commented if you prefer to move the window somewhere else)
			WinMove -7, -6, ,, "DOSBox-X"		
			
		} else {
			; Waits for 3 seconds for the DOSBox window to appear
			; Not sure it's wanted: makes the script lag (wait) for 3 seconds 
			/*
			WinWaitActive("ahk_exe dosbox.exe", , 3) or WinWaitActive("ahk_exe dosbox-x.exe", , 3) 
				if not WinExist("ahk_exe dosbox.exe") or WinExist("ahk_exe dosbox-x.exe") {
				MsgBox ("DOSBox/DOSBox-X window hasn't been found within 3 seconds. The AHK script will now stop.")
				ExitApp
				}
			*/	
		}









