#Requires AutoHotkey v2





/*	
Keyboard layout detection workaround

	The code that I borrowed to detect the keyboard layout (source below) relies on applications that feature input fields/areas (such as a text editor, a search box, etc). 
	I have tried to use this code to detect the keyboard layout directly on the DOSBox window but with no avail (even on the joystick/sound driver menus). 
	So, as a workaround, I made this script open an INFO.txt file inside Notepad to: 
	1- display informations about this script
	2- make the keyboard layout detection work 
	There is certainly a better way to detect the keyboard layout (maybe by reading a Regedit entry?) but I don't know how yet.
*/ 

Run "notepad.exe INFO.txt"
	; Sleep 1000
	WinWaitActive("ahk_exe notepad.exe", , 3)	
	if WinExist("ahk_exe notepad.exe") {	
		WinMove -6, 1000, 1600, 1000, "ahk_exe notepad.exe"
		WinActivate
		; MsgBox ("Notepad window is active")
	} else {
		MsgBox ("The keyboard layout detection has failed")
		ExitApp
		}	

/*
 source: https://www.autohotkey.com/boards/viewtopic.php?t=75421
	see also: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-language-pack-default-values?view=windows-11
	see also: https://www.autoitscript.com/autoit3/docs/appendix/OSLangCodes.htm
	https://en.wikipedia.org/wiki/AZERTY
	https://en.wikipedia.org/wiki/QWERTY
	https://en.wikipedia.org/wiki/QWERTZ
*/
	
	Focused := ControlGetClassNN(ControlGetFocus("A"))
	CtrlID := ControlGetHwnd(Focused, "A")
	ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", CtrlID, "Ptr", 0)
	InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "Ptr")
	; Sleep 1000
	; ToolTip(Format("0x{:X}",InputLocaleID))
	; Return	

	arg := (Format("0x{:X}",InputLocaleID))	
		; MsgBox (arg)		
	
	if arg == "0x40C040C" or arg == "0x80C080C" { 							; AZERTY: France, Belgium
		KeyboardLayout := "AZERTY"
		; MsgBox ("You have an " KeyboardLayout " keyboard - " arg)

	} 	else if arg == "0x41C041C" or arg == "0x4070C07" or arg == "0x4070407" or arg == "0x0AE042E" or arg == "0x0AE082E" or arg == "0x4050405" or arg == "0x40E040E" or arg == "0x4150415" or arg == "0x41B041B" or arg == "0x4072000" or arg == "0x8070807" or arg == "0x100C0810" or arg == "0x100C100C" or arg == "0x4092400" {					
		; QWERTZ: 		Albanian*, 			Autria*, 				Germany*, 			Upper Sorbia*, 			Lower Sorbia*, 			Czech*, 			Hungary*, 			Poland*, 				Slovak*, 			English Switzerland,   German Switzerland*,  Italian Switzerland*, 	French Switzerland*, 	Portuguese Switzerland
		; legacy Romanian is a QWERTZ) arg == "0x0A50418"
				
			KeyboardLayout := "QWERTZ"
			; MsgBox ("You have a " KeyboardLayout " keyboard - " arg)
		
		} 	else {															; QWERTY: all other countries
				KeyboardLayout:= "QWERTY"
				; MsgBox ("You have a " KeyboardLayout " keyboard - " arg)			
			}









