/*

----------------------------------------------------------------------------
	"F-117A Clickable Cockpit" by xan2622
	version 1.3.0
	Released under the GPL 3.0 license
----------------------------------------------------------------------------
 	This Autohotkey (v2) script is meant to be used alongside the game F-117A Nighthawk Stealth Fighter 2.0 
	It allows to click on the cockpit buttons with the mouse cursor.
----------------------------------------------------------------------------
	The INFO.txt file has several purposes: 
	- Give you informations about this "F-117A Clickable Cockpit" AutoHotKey v2 script.
	- It is also used as a workaround to check the current active keyboard layout, as I haven't managed to get it from the DOSBox window itself yet. 
	You may now close this Notepad window (or read further informations bellow). The AHK script only needed the Notepad window to be opened only once. 
----------------------------------------------------------------------------
	TIPS (how to use this script): 
	- This script works best once you are already on the airport runway.
	- Click once on an empty area of the DOSBox window (on the cockpit or HUD).
	- The first time the script is launched, you should see several yellow overlays over cockpit buttons. These overlays will disappear as soon as you click on buttons.
	- If you want to see the yellow overlays once more, just relaunch the AHK script.
----------------------------------------------------------------------------
 	Here are the supported (clickable) buttons: 
		Select Weapon, NAV/AIR/GND, HUD de-clutter, ILS, 
		Chaff, Flare, Decoy, ECM, IRJ, 
		MAP/TAC, MFD Zoom in, MFD Zoom out,
		WAY, WPN, GRD, FLIR, BAY, AUTO, GEAR, FLAPS, BRAKE, Eject, 
		Accelerate, Normal Speed, Pause, 
		Maximum Power, Increase Power (Throttle), Decrease Power (Throttle), No Power, 
		New Target, Select Target, 
		Tracking CAM Ahead, Tracking CAM Rear, Tracking CAM Right, Tracking CAM Left
	For convenience: 
	- it's also possible to use the mouse wheel over the MFD to zoom in/out
	- WASD keys mimic the directionnal arrow keys
	- pressing "E" fires missiles (mimicking the Enter key)
	- clicking on the wide bar below the right MFD circles between Tracking CAM Ahead / CAM Rear / CAM Right / CAM Left
----------------------------------------------------------------------------
	BUGS:
	- can't seem to reassign the Q key (A on AZERTY keyboards) to "open bay"
	- the fake cursor is misplaced if the script is directly launched by double-clicking on the .ahk file (but is fine if the script is launched from Notepad++)
	- sometimes, clicking on NAV/AIR/GND and MAP/TAC makes these buttons flicker
	- sometimes clicking on DecreaseThrottle makes it react like MaximumPower (the culpit is probably "SetKeyDelay(20, 10)". Related to Bug #1
	- sometimes, the user needs to left click once in the DOSBox windows to make clickable buttons work again
	- while using a QWERTY keyboard and clicking on the 4 buttons at the left side of the right MFD, it makes the CAM Views interfere with the From-the-Cockpit-Viewing hotkeys
	- 2 of the 3 buttons below the right MFD (Accel, Normal speed, Pause) interfere with the left MFD Zoom in/out
----------------------------------------------------------------------------
 	TODO: 
	- DONE (needs more tests): detect the user keyboard layout (QWERTY, QWERTZ, AZERTY..) and change hotkeys accordingly
	- add tooltips over cockpit buttons
	- make the yellow overlays follow the DosBox window if it's moved over the Windows desktop https://www.autohotkey.com/boards/viewtopic.php?t=55113	
	- make sure the script also works with DosBox-X (which by default displays the Windows mouse cursor but I have to make sure the image aspect ratio matches the DosBox one)
	- Replace overlays with modded cockpit buttons (ie: highlighted when hovered)
	- Detect cockpit buttons with ImageSearch (slower) instead of hardcoding them with absolute positions
	- add (convenient) extra buttons that are not in the original game: 50% Power (there's one free MFD button on the left MFD)
---------------------------------------------------------------------------- 
	Just a few info, in case that helps understanding why the script doesn't work for you: 
	My screen resolution is 3840 x 2160, 125% DPI scaling and I use an AZERTY keyboard.
 	Here are my DosBox 0.74 settings (dosbox_F117A.conf): 
		fullscreen=false
		windowresolution=1280x960
		output=openglnb
		autolock=false
		aspect=true
		scaler=normal2x
		cycles=40000
		cycleup=1000
		cycledown=1000
----------------------------------------------------------------------------------------
		
	
*/










; Replaces the current AHK script if it is launched once more
#SingleInstance Force

; Delay between keypresses
SetKeyDelay(20, 10)










; DPI support
; source: https://www.autohotkey.com/boards/viewtopic.php?f=96&t=121040
; This library must be in the same folder than this AHK script 
#include DPI.ahk

; Gets the DPI for the specified window
	WinGetDpi(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?) {
    return (hMonitor := DllCall("MonitorFromWindow", "ptr", WinExist(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?), "int", 2, "ptr") ; MONITOR_DEFAULTTONEAREST
    , DllCall("Shcore.dll\GetDpiForMonitor", "ptr", hMonitor, "int", 0, "uint*", &dpiX:=0, "uint*", &dpiY:=0), dpiX)
}










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
		WinMove -6, 1000, 1200, 560, "ahk_exe notepad.exe"
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





		













	
	/*
	
	
SearchForNAVAIRGNDButtons:
; Makes sure the initial menus are passed (joystick, sound driver, mission briefing, etc) 
; Checks if the NAV/AIR/GND buttons are displayed

	; Searches for the NAV/AIR/GND buttons
	; https://www.autohotkey.com/docs/v2/lib/CoordMode.htm
	; RelativeTo: 	Screen / Window / Client 
	CoordMode("Pixel", "Screen") ; Pixel: Affects PixelGetColor, PixelSearch, and ImageSearch.
	CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, and MouseClickDrag.

	ImageSearchVar01 := !ImageSearch(&Position01X, &Position01Y, DOSBox_WindowClientX, DOSBox_WindowClientY, DOSBox_WindowClientW, DOSBox_WindowClientH, "*1 Images\NAVAIRGND_01.png")
	ErrorLevel := ImageSearchVar01
 
 
	Switch ErrorLevel ; Checks if image is found or not
	{
		Case "2": ; A problem occured with image search.
			MsgBox("A problem occured with image search.")
			ExitApp
		
		Case "1": ; Image has not been found 
			; MsgBox("The buttons 'NAV/AIR/GND' have not been found.")
			Goto SearchForNAVAIRGNDButtons
			; ExitApp
		
		Case "0": ; Image has been found
			; MsgBox ("Image NAV/AIR/GND (and obviously DOSBox) has been found.")
			; MsgBox ("Image NAV/AIR/GND has been found at " Position01X "," Position01Y)
			; SoundBeep 750, 500			
			; MouseMove Position01X, Position01Y, 15
		
	
	}
		
	
*/

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



	
	; Enables the script only when DOSBox/DOSBox-X is active (focussed)
	; Prevents from hotkeys to be used outside the DOSBox/DOSBox-X window
	#HotIf WinActive("DOSBox") or WinActive("DOSBox-X")
	{
	

	
	
	
	




		; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
		; Bypasses DOSBox isolation by displaying a cursor
		; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


		SetWorkingDir(A_ScriptDir)

		; Create an invisible GUI that the picture is placed on:
		myGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
		WinSetExStyle("+32", myGui)
		myGui.MarginX   := myGui.MarginY := 0
		myGui.BackColor := "2B2B2C"
		WinSetTransColor(myGui.BackColor, myGui)
		ogcPictureBG := myGui.Add("Picture", "x0 y0 vBG", "cursor.png")

		SetTimer(mouseTrack, 20)
		myGui.Show("NoActivate")

		mouseTrack() {
			SetWinDelay(-1)
			; No need to define global variables in AutoHotKey 2
			CoordMode("Mouse", "Screen")
			MouseGetPos(&mouseX, &mouseY)
			myGui.Move(mouseX, mouseY)
		}







	

	
		; --------------------------------------------------		
		; OVERLAYS (displays rectangles over the cockpit buttons)
		; --------------------------------------------------
	
		; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollUp Zoom In (QWERTY: Z / QWERTZ: Y / AZERTY: W)
		/*
		myMFDZoomInMouseWheel := Gui()
		myMFDZoomInMouseWheel.BackColor := "Yellow"
		myMFDZoomInMouseWheel.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomInMouseWheel
		myMFDZoomInMouseWheel.Show("x298 y560 w308 h288")		
		*/
		myMFDZoomInMouseWheel := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myMFDZoomInMouseWheel.MarginX := myMFDZoomInMouseWheel.MarginY := 0
		myMFDZoomInMouseWheel.BackColor := "Blue"
		WinSetTransColor(myMFDZoomInMouseWheel.BackColor, myMFDZoomInMouseWheel)
		myMFDZoomInMouseWheel.Color := "Yellow"
	
		ogcPictureBG := myMFDZoomInMouseWheel.Add("Picture", "x298 y560 w308 h288 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack01(myMFDZoomInMouseWheel), 20)
		myMFDZoomInMouseWheel.Show("NoActivate")
	
		windowTrack01(myMFDZoomInMouseWheel) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myMFDZoomInMouseWheel.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}
		
		; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollDown Zoom Out (QWERTY: X / QWERTZ: X / AZERTY: X)
		/*
		myMFDZoomOutMouseWheel := Gui()
		myMFDZoomOutMouseWheel.BackColor := "Yellow"
		myMFDZoomOutMouseWheel.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomOutMouseWheel
		myMFDZoomOutMouseWheel.Show("x298 y560 w308 h288")
		*/		
		myMFDZoomOutMouseWheel := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myMFDZoomOutMouseWheel.MarginX := myMFDZoomOutMouseWheel.MarginY := 0
		myMFDZoomOutMouseWheel.BackColor := "Blue"
		WinSetTransColor(myMFDZoomOutMouseWheel.BackColor, myMFDZoomOutMouseWheel)
		myMFDZoomOutMouseWheel.Color := "Yellow"
	
		ogcPictureBG := myMFDZoomOutMouseWheel.Add("Picture", "x298 y560 w308 h288 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack02(myMFDZoomOutMouseWheel), 20)
		myMFDZoomOutMouseWheel.Show("NoActivate")
	
		windowTrack02(myMFDZoomOutMouseWheel) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myMFDZoomOutMouseWheel.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}
			
		; Displays a wide MAPTAC button (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
		/*myMAPTACButton := Gui()
		myMAPTACButton.BackColor := "Yellow"
		myMAPTACButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMAPTACButton
		myMAPTACButton.Show("x322 y862 w156 h44")
		*/
		myMAPTACButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myMAPTACButton.MarginX := myMAPTACButton.MarginY := 0
		myMAPTACButton.BackColor := "Blue"
		WinSetTransColor(myMAPTACButton.BackColor, myMAPTACButton)
		myMAPTACButton.Color := "Yellow"
	
		ogcPictureBG := myMAPTACButton.Add("Picture", "x322 y862 w156 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack03(myMAPTACButton), 20)
		myMAPTACButton.Show("NoActivate")
	
		windowTrack03(myMAPTACButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myMAPTACButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}
		
		; Displays a MFD Zoom In button (QWERTY: Z / QWERTZ: Y / AZERTY: W)
		/*
		myMFDZoomInButton := Gui()
		myMFDZoomInButton.BackColor := "Yellow"
		myMFDZoomInButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomInButton
		myMFDZoomInButton.Show("x514 y867 w28 h29")
		*/
		myMFDZoomInButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myMFDZoomInButton.MarginX := myMFDZoomInButton.MarginY := 0
		myMFDZoomInButton.BackColor := "Blue"
		WinSetTransColor(myMFDZoomInButton.BackColor, myMFDZoomInButton)
		myMFDZoomInButton.Color := "Yellow"
	
		ogcPictureBG := myMFDZoomInButton.Add("Picture", "x514 y867 w28 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack04(myMFDZoomInButton), 20)
		myMFDZoomInButton.Show("NoActivate")
	
		windowTrack04(myMFDZoomInButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myMFDZoomInButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}
		
		
		; Displays a MFD Zoom Out button (QWERTY: X / QWERTZ: X / AZERTY: X)
		/*
		myMFDZoomOutButton := Gui()
		myMFDZoomOutButton.BackColor := "Yellow"
		myMFDZoomOutButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomOutButton
		myMFDZoomOutButton.Show("x562 y867 w28 h29")
		*/
		myMFDZoomOutButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myMFDZoomOutButton.MarginX := myMFDZoomOutButton.MarginY := 0
		myMFDZoomOutButton.BackColor := "Blue"
		WinSetTransColor(myMFDZoomOutButton.BackColor, myMFDZoomOutButton)
		myMFDZoomOutButton.Color := "Yellow"
	
		ogcPictureBG := myMFDZoomOutButton.Add("Picture", "x562 y867 w28 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack05(myMFDZoomOutButton), 20)
		myMFDZoomOutButton.Show("NoActivate")
	
		windowTrack05(myMFDZoomOutButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myMFDZoomOutButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}



		; Displays a CHAFF button (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
		/*
		myChaffButton := Gui()
		myChaffButton.BackColor := "Yellow"
		myChaffButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myChaffButton
		myChaffButton.Show("x14 y742 w104 h44")
		*/
		myChaffButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myChaffButton.MarginX := myChaffButton.MarginY := 0
		myChaffButton.BackColor := "Blue"
		WinSetTransColor(myChaffButton.BackColor, myChaffButton)
		myChaffButton.Color := "Yellow"
	
		ogcPictureBG := myChaffButton.Add("Picture", "x14 y742 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack06(myChaffButton), 20)
		myChaffButton.Show("NoActivate")
	
		windowTrack06(myChaffButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myChaffButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}
			
		; Displays a FLARE button (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
		/*
		myFlareButton := Gui()
		myFlareButton.BackColor := "Yellow"
		myFlareButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myFlareButton
		myFlareButton.Show("x14 y790 w104 h44")
		*/
		myFlareButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myFlareButton.MarginX := myFlareButton.MarginY := 0
		myFlareButton.BackColor := "Blue"
		WinSetTransColor(myFlareButton.BackColor, myFlareButton)
		myFlareButton.Color := "Yellow"
	
		ogcPictureBG := myFlareButton.Add("Picture", "x14 y790 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack07(myFlareButton), 20)
		myFlareButton.Show("NoActivate")
	
		windowTrack07(myFlareButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myFlareButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		; Displays a DECOY button (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
		/*
		myDecoyButton := Gui()
		myDecoyButton.BackColor := "Yellow"
		myDecoyButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myDecoyButton
		myDecoyButton.Show("x14 y838 w104 h44")
		*/
		myDecoyButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myDecoyButton.MarginX := myDecoyButton.MarginY := 0
		myDecoyButton.BackColor := "Blue"
		WinSetTransColor(myDecoyButton.BackColor, myDecoyButton)
		myDecoyButton.Color := "Yellow"
	
		ogcPictureBG := myDecoyButton.Add("Picture", "x14 y838 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack08(myDecoyButton), 20)
		myDecoyButton.Show("NoActivate")
	
		windowTrack08(myDecoyButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myDecoyButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}		
		
		; Displays a ECM button (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
		/*
		myECMButton := Gui()
		myECMButton.BackColor := "Yellow"
		myECMButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myECMButton
		myECMButton.Show("x18 y891 w116 h43")
		*/
		myECMButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myECMButton.MarginX := myECMButton.MarginY := 0
		myECMButton.BackColor := "Blue"
		WinSetTransColor(myECMButton.BackColor, myECMButton)
		myECMButton.Color := "Yellow"
	
		ogcPictureBG := myECMButton.Add("Picture", "x18 y891 w116 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack09(myECMButton), 20)
		myECMButton.Show("NoActivate")
	
		windowTrack09(myECMButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myECMButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}		
		
		; Displays a IR Jammer button (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
		/*
		myIRJammerButton := Gui()
		myIRJammerButton.BackColor := "Yellow"
		myIRJammerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myIRJammerButton
		myIRJammerButton.Show("x146 y891 w108 h43")
		*/
		myIRJammerButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myIRJammerButton.MarginX := myIRJammerButton.MarginY := 0
		myIRJammerButton.BackColor := "Blue"
		WinSetTransColor(myIRJammerButton.BackColor, myIRJammerButton)
		myIRJammerButton.Color := "Yellow"
	
		ogcPictureBG := myIRJammerButton.Add("Picture", "x146 y891 w108 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack10(myIRJammerButton), 20)
		myIRJammerButton.Show("NoActivate")
	
		windowTrack10(myIRJammerButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myIRJammerButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}
		
		

		; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
		; the screw at the left of the NAV button 
		/*
		mySelectWeaponButton := Gui()
		mySelectWeaponButton.BackColor := "Yellow"
		mySelectWeaponButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, mySelectWeaponButton
		mySelectWeaponButton.Show("x414 y483 w44 h48")
		*/
		mySelectWeaponButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		mySelectWeaponButton.MarginX := mySelectWeaponButton.MarginY := 0
		mySelectWeaponButton.BackColor := "Blue"
		WinSetTransColor(mySelectWeaponButton.BackColor, mySelectWeaponButton)
		mySelectWeaponButton.Color := "Yellow"
	
		ogcPictureBG := mySelectWeaponButton.Add("Picture", "x414 y483 w44 h48 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack11(mySelectWeaponButton), 20)
		mySelectWeaponButton.Show("NoActivate")
	
		windowTrack11(mySelectWeaponButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				mySelectWeaponButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}		
		
		; Displays a wide NAVAIRGND button (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
		/*
		myNavAirGndButton := Gui()
		myNavAirGndButton.BackColor := "Yellow"
		myNavAirGndButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNavAirGndButton
		myNavAirGndButton.Show("x478 y483 w235 h43")
		*/
		myNavAirGndButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myNavAirGndButton.MarginX := myNavAirGndButton.MarginY := 0
		myNavAirGndButton.BackColor := "Blue"
		WinSetTransColor(myNavAirGndButton.BackColor, myNavAirGndButton)
		myNavAirGndButton.Color := "Yellow"
	
		ogcPictureBG := myNavAirGndButton.Add("Picture", "x478 y483 w235 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack12(myNavAirGndButton), 20)
		myNavAirGndButton.Show("NoActivate")
	
		windowTrack12(myNavAirGndButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myNavAirGndButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}		
		
		; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
		; the fully visible MFD button at the top of the right MFD
		/*
		myILSButton := Gui()
		myILSButton.BackColor := "Yellow"
		myILSButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myILSButton
		myILSButton.Show("x922 y526 w24 h29")
		*/
		myILSButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myILSButton.MarginX := myILSButton.MarginY := 0
		myILSButton.BackColor := "Blue"
		WinSetTransColor(myILSButton.BackColor, myILSButton)
		myILSButton.Color := "Yellow"
	
		ogcPictureBG := myILSButton.Add("Picture", "x922 y526 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack13(myILSButton), 20)
		myILSButton.Show("NoActivate")
	
		windowTrack13(myILSButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myILSButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	





		; Displays a BAY button (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
		/*
		myBayButton := Gui()
		myBayButton.BackColor := "Yellow"
		myBayButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myBayButton
		myBayButton.Show("x1029 y526 w104 h44")
		*/
		myBayButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myBayButton.MarginX := myBayButton.MarginY := 0
		myBayButton.BackColor := "Blue"
		WinSetTransColor(myBayButton.BackColor, myBayButton)
		myBayButton.Color := "Yellow"
	
		ogcPictureBG := myBayButton.Add("Picture", "x1029 y526 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack14(myBayButton), 20)
		myBayButton.Show("NoActivate")
	
		windowTrack14(myBayButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myBayButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		

		; Displays an AUTOPILOT button (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
		/*
		myAutopilotButton := Gui()
		myAutopilotButton.BackColor := "Yellow"
		myAutopilotButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myAutopilotButton
		myAutopilotButton.Show("x1029 y574 w104 h44")
		*/
		myAutopilotButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myAutopilotButton.MarginX := myAutopilotButton.MarginY := 0
		myAutopilotButton.BackColor := "Blue"
		WinSetTransColor(myAutopilotButton.BackColor, myAutopilotButton)
		myAutopilotButton.Color := "Yellow"
	
		ogcPictureBG := myAutopilotButton.Add("Picture", "x1029 y574 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack15(myAutopilotButton), 20)
		myAutopilotButton.Show("NoActivate")
	
		windowTrack15(myAutopilotButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myAutopilotButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Displays a GEAR button (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
		/*
		myGearButton := Gui()
		myGearButton.BackColor := "Yellow"
		myGearButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myGearButton
		myGearButton.Show("x1029 y622 w104 h44")
		*/
		myGearButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myGearButton.MarginX := myGearButton.MarginY := 0
		myGearButton.BackColor := "Blue"
		WinSetTransColor(myGearButton.BackColor, myGearButton)
		myGearButton.Color := "Yellow"
	
		ogcPictureBG := myGearButton.Add("Picture", "x1029 y622 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack16(myGearButton), 20)
		myGearButton.Show("NoActivate")
	
		windowTrack16(myGearButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myGearButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Displays a FLAPS button (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)
		/*
		myFlapsButton := Gui()
		myFlapsButton.BackColor := "Yellow"
		myFlapsButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myFlapsButton
		myFlapsButton.Show("x1137 y574 w104 h44")
		*/
		myFlapsButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myFlapsButton.MarginX := myFlapsButton.MarginY := 0
		myFlapsButton.BackColor := "Blue"
		WinSetTransColor(myFlapsButton.BackColor, myFlapsButton)
		myFlapsButton.Color := "Yellow"
	
		ogcPictureBG := myFlapsButton.Add("Picture", "x1137 y574 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack17(myFlapsButton), 20)
		myFlapsButton.Show("NoActivate")
	
		windowTrack17(myFlapsButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myFlapsButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Displays a BRAKE button (0)
		/*
		myBrakeButton := Gui()
		myBrakeButton.BackColor := "Yellow"
		myBrakeButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myBrakeButton
		myBrakeButton.Show("x1137 y622 w104 h44")
		*/
		myBrakeButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myBrakeButton.MarginX := myBrakeButton.MarginY := 0
		myBrakeButton.BackColor := "Blue"
		WinSetTransColor(myBrakeButton.BackColor, myBrakeButton)
		myBrakeButton.Color := "Yellow"
	
		ogcPictureBG := myBrakeButton.Add("Picture", "x1137 y622 w104 h44 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack18(myBrakeButton), 20)
		myBrakeButton.Show("NoActivate")
	
		windowTrack18(myBrakeButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myBrakeButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		



		; Displays a Blue WAYPOINT button (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)
		/*
		myWaypointButton := Gui()
		myWaypointButton.BackColor := "Yellow"
		myWaypointButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myWaypointButton
		myWaypointButton.Show("x681 y901 w76 h43")
		*/
		myWaypointButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myWaypointButton.MarginX := myWaypointButton.MarginY := 0
		myWaypointButton.BackColor := "Blue"
		WinSetTransColor(myWaypointButton.BackColor, myWaypointButton)
		myWaypointButton.Color := "Yellow"
	
		ogcPictureBG := myWaypointButton.Add("Picture", "x681 y901 w76 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack19(myWaypointButton), 20)
		myWaypointButton.Show("NoActivate")
	
		windowTrack19(myWaypointButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myWaypointButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Displays a Ordnance button (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
		/*
		myOrdnanceButton := Gui()
		myOrdnanceButton.BackColor := "Yellow"
		myOrdnanceButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myOrdnanceButton
		myOrdnanceButton.Show("x761 y901 w76 h43")
		*/
		myOrdnanceButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myOrdnanceButton.MarginX := myOrdnanceButton.MarginY := 0
		myOrdnanceButton.BackColor := "Blue"
		WinSetTransColor(myOrdnanceButton.BackColor, myOrdnanceButton)
		myOrdnanceButton.Color := "Yellow"
	
		ogcPictureBG := myOrdnanceButton.Add("Picture", "x761 y901 w76 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack20(myOrdnanceButton), 20)
		myOrdnanceButton.Show("NoActivate")
	
		windowTrack20(myOrdnanceButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myOrdnanceButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Displays an Objectives button (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
		/*
		myObjectivesButton := Gui()
		myObjectivesButton.BackColor := "Yellow"
		myObjectivesButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myObjectivesButton
		myObjectivesButton.Show("x841 y901 w76 h43")
		*/
		myObjectivesButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myObjectivesButton.MarginX := myObjectivesButton.MarginY := 0
		myObjectivesButton.BackColor := "Blue"
		WinSetTransColor(myObjectivesButton.BackColor, myObjectivesButton)
		myObjectivesButton.Color := "Yellow"
	
		ogcPictureBG := myObjectivesButton.Add("Picture", "x841 y901 w76 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack21(myObjectivesButton), 20)
		myObjectivesButton.Show("NoActivate")
	
		windowTrack21(myObjectivesButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myObjectivesButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
			; CHANGE WAYPOINT RED (F8)
			; RESET WAYPOINT (SHIFT F8)

			; LAST WaYPOINT (PgUp)
			; NEXT WaYPOINT (PgDn)
			
			; Move WAYPOINT UP (Up arrow or NumPad 8)
			; Move WAYPOINT Down (Down arrow or NumPad 2)

		
		
		; Displays a FLIR button (QWERTY: F6 / QWERTZ: F6 / AZERTY: F6)
		/*
		myFlirButton := Gui()
		myFlirButton.BackColor := "Yellow"
		myFlirButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myFlirButton
		myFlirButton.Show("x929 y915 w72 h43")
		*/
		myFlirButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myFlirButton.MarginX := myFlirButton.MarginY := 0
		myFlirButton.BackColor := "Blue"
		WinSetTransColor(myFlirButton.BackColor, myFlirButton)
		myFlirButton.Color := "Yellow"
	
		ogcPictureBG := myFlirButton.Add("Picture", "x929 y915 w72 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack22(myFlirButton), 20)
		myFlirButton.Show("NoActivate")
	
		windowTrack22(myFlirButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myFlirButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Displays a EJECT button (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
		; the yellow and black stripes plate located on the right side
		/*
		myEjectButton := Gui()
		myEjectButton.BackColor := "Yellow"
		myEjectButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myEjectButton
		myEjectButton.Show("x1233 y685 w40 h187")
		*/
		myEjectButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myEjectButton.MarginX := myEjectButton.MarginY := 0
		myEjectButton.BackColor := "Blue"
		WinSetTransColor(myEjectButton.BackColor, myEjectButton)
		myEjectButton.Color := "Yellow"
	
		ogcPictureBG := myEjectButton.Add("Picture", "x1233 y685 w40 h187 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack23(myEjectButton), 20)
		myEjectButton.Show("NoActivate")
	
		windowTrack23(myEjectButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myEjectButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	


		; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N)
		; the 4th button at the bottom right side of the right MFD
		/*
		myNewTargetButton := Gui()
		myNewTargetButton.BackColor := "Yellow"
		myNewTargetButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNewTargetButton
		myNewTargetButton.Show("x997 y738 w24 h29")
		*/
		myNewTargetButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myNewTargetButton.MarginX := myNewTargetButton.MarginY := 0
		myNewTargetButton.BackColor := "Blue"
		WinSetTransColor(myNewTargetButton.BackColor, myNewTargetButton)
		myNewTargetButton.Color := "Yellow"
	
		ogcPictureBG := myNewTargetButton.Add("Picture", "x997 y738 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack24(myNewTargetButton), 20)
		myNewTargetButton.Show("NoActivate")
	
		windowTrack24(myNewTargetButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myNewTargetButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 	
		; the 5th button at the bottom right side of the right MFD
		/*
		mySelectTargetButton := Gui()
		mySelectTargetButton.BackColor := "Yellow"
		mySelectTargetButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, mySelectTargetButton
		mySelectTargetButton.Show("x997 y790 w24 h29")
		*/
		mySelectTargetButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		mySelectTargetButton.MarginX := mySelectTargetButton.MarginY := 0
		mySelectTargetButton.BackColor := "Blue"
		WinSetTransColor(mySelectTargetButton.BackColor, mySelectTargetButton)
		mySelectTargetButton.Color := "Yellow"
	
		ogcPictureBG := mySelectTargetButton.Add("Picture", "x997 y790 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack25(mySelectTargetButton), 20)
		mySelectTargetButton.Show("NoActivate")
	
		windowTrack25(mySelectTargetButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				mySelectTargetButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	

			
			; Changes cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C)
		;	myCockpitViewButton := Gui()
		;	myCockpitViewButton.BackColor := "Yellow"
		;	myCockpitViewButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		;	WinSetTransparent 75, myCockpitViewButton
		;	myCockpitViewButton.Show("x997 y790 w24 h29")

			
		
		; CAM Ahead (QWERTY: / / QWERTZ: / / AZERTY: !)
		; 1st MFD button from the top on the left side of the right MFD
		/*
		myCAMAheadButton := Gui()
		myCAMAheadButton.BackColor := "Yellow"
		myCAMAheadButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMAheadButton
		myCAMAheadButton.Show("x645 y570 w24 h28")
		*/
		myCAMAheadButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myCAMAheadButton.MarginX := myCAMAheadButton.MarginY := 0
		myCAMAheadButton.BackColor := "Blue"
		WinSetTransColor(myCAMAheadButton.BackColor, myCAMAheadButton)
		myCAMAheadButton.Color := "Yellow"
	
		ogcPictureBG := myCAMAheadButton.Add("Picture", "x645 y570 w24 h28 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack26(myCAMAheadButton), 20)
		myCAMAheadButton.Show("NoActivate")
	
		windowTrack26(myCAMAheadButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myCAMAheadButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
		; 2nd MFD button from the top on the left side of the right MFD
		/*
		myCAMRearButton := Gui()
		myCAMRearButton.BackColor := "Yellow"
		myCAMRearButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMRearButton
		myCAMRearButton.Show("x645 y622 w24 h29")
		*/
		myCAMRearButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myCAMRearButton.MarginX := myCAMRearButton.MarginY := 0
		myCAMRearButton.BackColor := "Blue"
		WinSetTransColor(myCAMRearButton.BackColor, myCAMRearButton)
		myCAMRearButton.Color := "Yellow"
	
		ogcPictureBG := myCAMRearButton.Add("Picture", "x645 y622 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack27(myCAMRearButton), 20)
		myCAMRearButton.Show("NoActivate")
	
		windowTrack27(myCAMRearButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myCAMRearButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	

			
		; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
		; 3rd MFD button from the top on the left side of the right MFD
		/*
		myCAMRightButton := Gui()
		myCAMRightButton.BackColor := "Yellow"
		myCAMRightButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMRightButton
		myCAMRightButton.Show("x645 y675 w24 h29")
		*/
		myCAMRightButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myCAMRightButton.MarginX := myCAMRightButton.MarginY := 0
		myCAMRightButton.BackColor := "Blue"
		WinSetTransColor(myCAMRightButton.BackColor, myCAMRightButton)
		myCAMRightButton.Color := "Yellow"
	
		ogcPictureBG := myCAMRightButton.Add("Picture", "x645 y675 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack28(myCAMRightButton), 20)
		myCAMRightButton.Show("NoActivate")
	
		windowTrack28(myCAMRightButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myCAMRightButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	


		; CAM left (QWERTY: M / QWERTZ: M / AZERTY: ,)
		; 4th MFD button from the top on the left side of the right MFD
		/*
		myCAMLeftButton := Gui()
		myCAMLeftButton.BackColor := "Yellow"
		myCAMLeftButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMLeftButton
		myCAMLeftButton.Show("x645 y738 w24 h28")
		*/
		myCAMLeftButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myCAMLeftButton.MarginX := myCAMLeftButton.MarginY := 0
		myCAMLeftButton.BackColor := "Blue"
		WinSetTransColor(myCAMLeftButton.BackColor, myCAMLeftButton)
		myCAMLeftButton.Color := "Yellow"
	
		ogcPictureBG := myCAMLeftButton.Add("Picture", "x645 y738 w24 h28 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack29(myCAMLeftButton), 20)
		myCAMLeftButton.Show("NoActivate")
	
		windowTrack29(myCAMLeftButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myCAMLeftButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Extra CAM button 
		; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
		/*
		myExtraCAMButton := Gui()
		myExtraCAMButton.BackColor := "Yellow"
		myExtraCAMButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myExtraCAMButton
		myExtraCAMButton.Show("x761 y949 w156 h43")
		*/
		myExtraCAMButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myExtraCAMButton.MarginX := myExtraCAMButton.MarginY := 0
		myExtraCAMButton.BackColor := "Blue"
		WinSetTransColor(myExtraCAMButton.BackColor, myExtraCAMButton)
		myExtraCAMButton.Color := "Yellow"
	
		ogcPictureBG := myExtraCAMButton.Add("Picture", "x761 y949 w156 h43 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack30(myExtraCAMButton), 20)
		myExtraCAMButton.Show("NoActivate")
	
		windowTrack30(myExtraCAMButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myExtraCAMButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Volume adjust (Alt V)
		
		
	
		
		; Displays an Accelerate button (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
		; the left button at the bottom of the right MFD
		/*
		myAccelerateButton := Gui()
		myAccelerateButton.BackColor := "Yellow"
		myAccelerateButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myAccelerateButton
		myAccelerateButton.Show("x829 y858 w24 h28")
		*/
		myAccelerateButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myAccelerateButton.MarginX := myAccelerateButton.MarginY := 0
		myAccelerateButton.BackColor := "Blue"
		WinSetTransColor(myAccelerateButton.BackColor, myAccelerateButton)
		myAccelerateButton.Color := "Yellow"
	
		ogcPictureBG := myAccelerateButton.Add("Picture", "x829 y858 w24 h28 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack31(myAccelerateButton), 20)
		myAccelerateButton.Show("NoActivate")
	
		windowTrack31(myAccelerateButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myAccelerateButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	




		; Displays a Normal Speed button (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
		; the middle button at the bottom of the right MFD
		/*
		myNormalSpeedButton := Gui()
		myNormalSpeedButton.BackColor := "Yellow"
		myNormalSpeedButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNormalSpeedButton
		myNormalSpeedButton.Show("x873 y858 w24 h28")
		*/
		myNormalSpeedButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myNormalSpeedButton.MarginX := myNormalSpeedButton.MarginY := 0
		myNormalSpeedButton.BackColor := "Blue"
		WinSetTransColor(myNormalSpeedButton.BackColor, myNormalSpeedButton)
		myNormalSpeedButton.Color := "Yellow"
	
		ogcPictureBG := myNormalSpeedButton.Add("Picture", "x873 y858 w24 h28 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack32(myNormalSpeedButton), 20)
		myNormalSpeedButton.Show("NoActivate")
	
		windowTrack32(myNormalSpeedButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myNormalSpeedButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
				
		; Displays a Pause button (QWERTY: ALT P / QWERTZ: ALT P / AZERTY: ALT P)
		; the right button at the bottom of the right MFD
		/*
		myPauseButton := Gui()
		myPauseButton.BackColor := "Yellow"
		myPauseButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myPauseButton
		myPauseButton.Show("x921 y858 w24 h28")
		*/
		myPauseButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myPauseButton.MarginX := myPauseButton.MarginY := 0
		myPauseButton.BackColor := "Blue"
		WinSetTransColor(myPauseButton.BackColor, myPauseButton)
		myPauseButton.Color := "Yellow"
	
		ogcPictureBG := myPauseButton.Add("Picture", "x921 y858 w24 h28 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack33(myPauseButton), 20)
		myPauseButton.Show("NoActivate")
	
		windowTrack33(myPauseButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myPauseButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		
		; Toggle HUD color (F4) 
		
		
		
		
		; Displays a de-clutter HUD button (QWERTY: V / QWERTZ: V / AZERTY: V)
		; the rounded button located on the right side of LOCK button
		/*
		myDeClutterButton := Gui()
		myDeClutterButton.BackColor := "Yellow"
		myDeClutterButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myDeClutterButton
		myDeClutterButton.Show("x845 y488 w28 h29")
		*/
		myDeClutterButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myDeClutterButton.MarginX := myDeClutterButton.MarginY := 0
		myDeClutterButton.BackColor := "Blue"
		WinSetTransColor(myDeClutterButton.BackColor, myDeClutterButton)
		myDeClutterButton.Color := "Yellow"
	
		ogcPictureBG := myDeClutterButton.Add("Picture", "x845 y488 w28 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack34(myDeClutterButton), 20)
		myDeClutterButton.Show("NoActivate")
	
		windowTrack34(myDeClutterButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myDeClutterButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		; Displays a Maximum Power button (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		/*
		myMaximumPowerButton := Gui()
		myMaximumPowerButton.BackColor := "Yellow"
		myMaximumPowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMaximumPowerButton
		myMaximumPowerButton.Show("x262 y560 w24 h29")
		*/
		myMaximumPowerButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myMaximumPowerButton.MarginX := myMaximumPowerButton.MarginY := 0
		myMaximumPowerButton.BackColor := "Blue"
		WinSetTransColor(myMaximumPowerButton.BackColor, myMaximumPowerButton)
		myMaximumPowerButton.Color := "Yellow"
	
		ogcPictureBG := myMaximumPowerButton.Add("Picture", "x262 y560 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack35(myMaximumPowerButton), 20)
		myMaximumPowerButton.Show("NoActivate")
	
		windowTrack35(myMaximumPowerButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myMaximumPowerButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		
		
		
		; Displays an Increase Throttle button (QWERTY: = / QWERTZ: ´ / AZERTY: =)
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		/*
		myIncreaseThrottleButton := Gui()
		myIncreaseThrottleButton.BackColor := "Yellow"
		myIncreaseThrottleButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myIncreaseThrottleButton
		myIncreaseThrottleButton.Show("x262 y622 w24 h29")
		*/
		myIncreaseThrottleButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myIncreaseThrottleButton.MarginX := myIncreaseThrottleButton.MarginY := 0
		myIncreaseThrottleButton.BackColor := "Blue"
		WinSetTransColor(myIncreaseThrottleButton.BackColor, myIncreaseThrottleButton)
		myIncreaseThrottleButton.Color := "Yellow"
	
		ogcPictureBG := myIncreaseThrottleButton.Add("Picture", "x262 y622 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack36(myIncreaseThrottleButton), 20)
		myIncreaseThrottleButton.Show("NoActivate")
	
		windowTrack36(myIncreaseThrottleButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myIncreaseThrottleButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		
		
		; 50% Power (detects the current speed and changes it accordingly)
		; There is room on the left side of the left MFD
			
		
		
		
		; Displays a Decrease Throttle button (QWERTY: - / QWERTZ: ß / AZERTY: ))
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		/*
		myDecreaseThrottleButton := Gui()
		myDecreaseThrottleButton.BackColor := "Yellow"
		myDecreaseThrottleButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myDecreaseThrottleButton
		myDecreaseThrottleButton.Show("x262 y733 w24 h29")
		*/
		myDecreaseThrottleButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myDecreaseThrottleButton.MarginX := myDecreaseThrottleButton.MarginY := 0
		myDecreaseThrottleButton.BackColor := "Blue"
		WinSetTransColor(myDecreaseThrottleButton.BackColor, myDecreaseThrottleButton)
		myDecreaseThrottleButton.Color := "Yellow"
	
		ogcPictureBG := myDecreaseThrottleButton.Add("Picture", "x262 y733 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack37(myDecreaseThrottleButton), 20)
		myDecreaseThrottleButton.Show("NoActivate")
	
		windowTrack37(myDecreaseThrottleButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myDecreaseThrottleButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		
		; Displays a No Power button (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
		/*
		myNoPowerButton := Gui()
		myNoPowerButton.BackColor := "Yellow"
		myNoPowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNoPowerButton
		myNoPowerButton.Show("x262 y795 w24 h29")
		*/
		myNoPowerButton := Gui("-Caption +AlwaysOnTop +ToolWindow")
		myNoPowerButton.MarginX := myNoPowerButton.MarginY := 0
		myNoPowerButton.BackColor := "Blue"
		WinSetTransColor(myNoPowerButton.BackColor, myNoPowerButton)
		myNoPowerButton.Color := "Yellow"
	
		ogcPictureBG := myNoPowerButton.Add("Picture", "x262 y795 w24 h29 vBG", "yellow.png")
		WinSetTransparent 75, ogcPictureBG
	
		; SetTimer(windowTrack, 20)
		SetTimer((*) => windowTrack38(myNoPowerButton), 20)
		myNoPowerButton.Show("NoActivate")
	
		windowTrack38(myNoPowerButton) {
			SetWinDelay(-1)
			CoordMode("Mouse", "Screen")
			
			if WinExist("ahk_exe dosbox.exe") {
				WinGetPos(&windowX, &windowY,,, "DOSBox") 
				myNoPowerButton.Move(windowX, windowY)        
			} else {
			; SoundBeep 750, 500
			ExitApp
			}
		}	
		
		
		
		
		
		; Resupply (training) (ALT R)
	





		; } else {
		; MsgBox ("Hides all overlays")
		; }

































		; **************************************************
		; HOTKEYS
		; **************************************************

		; Global variables 
		ClickCounter := 0





		; Mouse Wheel ScrollUp Zoom In (QWERTY: Z / QWERTZ: Y / AZERTY: W)
		WheelUp::
			{
				CoordMode("Pixel", "Screen")
				CoordMode("Mouse", "Screen")
				
				MouseGetPos(&mouseX, &mouseY)
				WinGetPos(&windowX, &windowY,,, "DOSBox")
				
				; Zooms the MAPTAC MFD in (QWERTY: Z / QWERTZ: Y / AZERTY: W)
				myMFDZoomInMouseWheel_AreaX := 298 + windowX
				myMFDZoomInMouseWheel_AreaY := 560 + windowY
				myMFDZoomInMouseWheel_AreaWidth := 308
				myMFDZoomInMouseWheel_AreaHeight := 288
				if ((mouseX > myMFDZoomInMouseWheel_AreaX && mouseX < myMFDZoomInMouseWheel_AreaX+myMFDZoomInMouseWheel_AreaWidth) && (mouseY > myMFDZoomInMouseWheel_AreaY && mouseY < myMFDZoomInMouseWheel_AreaY+myMFDZoomInMouseWheel_AreaHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{z}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{y}"
							} else {
								Send "{w}"
								}					
					myMFDZoomInMouseWheel.Hide() 
					; ExitApp
				}	
			}

		; Mouse Wheel ScrollDown Zoom Out (QWERTY: X / QWERTZ: X / AZERTY: X)
		WheelDown::
			{
				CoordMode("Pixel", "Screen")
				CoordMode("Mouse", "Screen")
				
				MouseGetPos(&mouseX, &mouseY)
				WinGetPos(&windowX, &windowY,,, "DOSBox")
				
				; Zooms the MAPTAC MFD out (QWERTY: X / QWERTZ: X / AZERTY: X)
				myMFDZoomOutMouseWheel_AreaX := 298 + windowX
				myMFDZoomOutMouseWheel_AreaY := 560 + windowY
				myMFDZoomOutMouseWheel_AreaWidth := 308
				myMFDZoomOutMouseWheel_AreaHeight := 288
				if ((mouseX > myMFDZoomOutMouseWheel_AreaX && mouseX < myMFDZoomOutMouseWheel_AreaX+myMFDZoomOutMouseWheel_AreaWidth) && (mouseY > myMFDZoomOutMouseWheel_AreaY && mouseY < myMFDZoomOutMouseWheel_AreaY+myMFDZoomOutMouseWheel_AreaHeight)) {
					Send "{x}"
					myMFDZoomOutMouseWheel.Hide()
					; ExitApp
				}
			}
			







		
		

		~LButton::
			{
				CoordMode("Pixel", "Screen")
				CoordMode("Mouse", "Screen")
				
				MouseGetPos(&mouseX, &mouseY)
				WinGetPos(&windowX, &windowY,,, "DOSBox")
				
				; Clickable areas (buttons) 
	
				; Toggles the MAPTAC MFD mode (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
				myMAPTAC_ButtonX := 322 + windowX
				myMAPTAC_ButtonY := 862 + windowY
				myMAPTAC_ButtonWidth := 156
				myMAPTAC_ButtonHeight := 44
				if ((mouseX > myMAPTAC_ButtonX && mouseX < myMAPTAC_ButtonX+myMAPTAC_ButtonWidth) && (mouseY > myMAPTAC_ButtonY && mouseY < myMAPTAC_ButtonY+myMAPTAC_ButtonHeight)) {
					Send "{F3}"
					myMAPTACButton.Hide()
					; ExitApp
				}			
				
				; Enables MFD Zoom in (QWERTY: Z / QWERTZ: Y / AZERTY: W)
				myMFDZoomIn_ButtonX := 514 + windowX
				myMFDZoomIn_ButtonY := 867 + windowY
				myMFDZoomIn_ButtonWidth := 28
				myMFDZoomIn_ButtonHeight := 29
				if ((mouseX > myMFDZoomIn_ButtonX && mouseX < myMFDZoomIn_ButtonX+myMFDZoomIn_ButtonWidth) && (mouseY > myMFDZoomIn_ButtonY && mouseY < myMFDZoomIn_ButtonY+myMFDZoomIn_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{z}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{y}"
							} else {
								Send "{w}"
								}
					myMFDZoomInButton.Hide()
				}				
					
				; Enables MFD Zoom out (QWERTY: X / QWERTZ: X / AZERTY: X)
				myMFDZoomOut_ButtonX := 562 + windowX
				myMFDZoomOut_ButtonY := 867 + windowY
				myMFDZoomOut_ButtonWidth := 28
				myMFDZoomOut_ButtonHeight := 29
				if ((mouseX > myMFDZoomOut_ButtonX && mouseX < myMFDZoomOut_ButtonX+myMFDZoomOut_ButtonWidth) && (mouseY > myMFDZoomOut_ButtonY && mouseY < myMFDZoomOut_ButtonY+myMFDZoomOut_ButtonHeight)) {
					Send "{x}"
					myMFDZoomOutButton.Hide()
				}
				
				
				
				; Drops a Chaff (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
				myChaff_ButtonX := 14 + windowX
				myChaff_ButtonY := 742 + windowY
				myChaff_ButtonWidth := 104
				myChaff_ButtonHeight := 44
				if ((mouseX > myChaff_ButtonX && mouseX < myChaff_ButtonX+myChaff_ButtonWidth) && (mouseY > myChaff_ButtonY && mouseY < myChaff_ButtonY+myChaff_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{2}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{2}"
							} else {
								Send "{é}"
								}
					myChaffButton.Hide()
				}
				
				; Drops a Flare (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
				myFlare_ButtonX := 14 + windowX
				myFlare_ButtonY := 790 + windowY
				myFlare_ButtonWidth := 104
				myFlare_ButtonHeight := 44
				if ((mouseX > myFlare_ButtonX && mouseX < myFlare_ButtonX+myFlare_ButtonWidth) && (mouseY > myFlare_ButtonY && mouseY < myFlare_ButtonY+myFlare_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{1}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{1}"
							} else {
								Send "{&}"
								}
					myFlareButton.Hide()
				}
				
				; Drops a Decoy (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
				myDecoy_ButtonX := 14 + windowX
				myDecoy_ButtonY := 838 + windowY
				myDecoy_ButtonWidth := 104
				myDecoy_ButtonHeight := 44
				if ((mouseX > myDecoy_ButtonX && mouseX < myDecoy_ButtonX+myDecoy_ButtonWidth) && (mouseY > myDecoy_ButtonY && mouseY < myDecoy_ButtonY+myDecoy_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{5}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{5}"
							} else {
								Send "{(}"
								}				
					myDecoyButton.Hide()
				}
				
				; Toggles ECM on/off (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
				myECM_ButtonX := 18 + windowX
				myECM_ButtonY := 891 + windowY
				myECM_ButtonWidth := 116
				myECM_ButtonHeight := 43
				if ((mouseX > myECM_ButtonX && mouseX < myECM_ButtonX+myECM_ButtonWidth) && (mouseY > myECM_ButtonY && mouseY < myECM_ButtonY+myECM_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{4}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{4}"
							} else {
								Send "{'}"
								}
					myECMButton.Hide()
				}
				
				; Toggles IR Jammer on/off (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
				myIRJammer_ButtonX := 146 + windowX
				myIRJammer_ButtonY := 891 + windowY
				myIRJammer_ButtonWidth := 108
				myIRJammer_ButtonHeight := 43
				if ((mouseX > myIRJammer_ButtonX && mouseX < myIRJammer_ButtonX+myIRJammer_ButtonWidth) && (mouseY > myIRJammer_ButtonY && mouseY < myIRJammer_ButtonY+myIRJammer_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{3}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{3}"
							} else {
								Send("`"")
								}
					myIRJammerButton.Hide()
				}
			
		

				; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
				mySelectWeapon_ButtonX := 414 + windowX
				mySelectWeapon_ButtonY := 483 + windowY
				mySelectWeapon_ButtonWidth := 44
				mySelectWeapon_ButtonHeight := 48
				if ((mouseX > mySelectWeapon_ButtonX && mouseX < mySelectWeapon_ButtonX+mySelectWeapon_ButtonWidth) && (mouseY > mySelectWeapon_ButtonY && mouseY < mySelectWeapon_ButtonY+mySelectWeapon_ButtonHeight)) {
					Send "{Space}"
					mySelectWeaponButton.Hide()
				}

				; Toggle NAV AIR GND buttons (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
				myNavAirGnd_ButtonX := 478 + windowX
				myNavAirGnd_ButtonY := 483 + windowY
				myNavAirGnd_ButtonWidth := 235
				myNavAirGnd_ButtonHeight := 43
				if ((mouseX > myNavAirGnd_ButtonX && mouseX < myNavAirGnd_ButtonX+myNavAirGnd_ButtonWidth) && (mouseY > myNavAirGnd_ButtonY && mouseY < myNavAirGnd_ButtonY+myNavAirGnd_ButtonHeight)) {
					Send "{F2}"
					myNavAirGndButton.Hide()
				}			
				
				; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
				; the fully visible MFD button at the top of the right MFD
				myILS_ButtonX := 922 + windowX
				myILS_ButtonY := 526 + windowY
				myILS_ButtonWidth := 24
				myILS_ButtonHeight := 29
				if ((mouseX > myILS_ButtonX && mouseX < myILS_ButtonX+myILS_ButtonWidth) && (mouseY > myILS_ButtonY && mouseY < myILS_ButtonY+myILS_ButtonHeight)) {
					Send "{F9}"
					myILSButton.Hide()
				}
				
				
		
			
				; Turns BAY on/off (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
				myBay_ButtonX := 1029 + windowX
				myBay_ButtonY := 526 + windowY
				myBay_ButtonWidth := 104
				myBay_ButtonHeight := 44
				if ((mouseX > myBay_ButtonX && mouseX < myBay_ButtonX+myBay_ButtonWidth) && (mouseY > myBay_ButtonY && mouseY < myBay_ButtonY+myBay_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{8}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{8}"
							} else {
								Send "{_}"
								}						
					myBayButton.Hide()
				}			
				
				; Turns AUTOPILOT nn/off (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
				myAutopilot_ButtonX := 1029 + windowX
				myAutopilot_ButtonY := 574 + windowY
				myAutopilot_ButtonWidth := 104
				myAutopilot_ButtonHeight := 44
				if ((mouseX > myAutopilot_ButtonX && mouseX < myAutopilot_ButtonX+myAutopilot_ButtonWidth) && (mouseY > myAutopilot_ButtonY && mouseY < myAutopilot_ButtonY+myAutopilot_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{7}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{7}"
							} else {
								Send "{è}"
								}				
					myAutopilotButton.Hide()
				}			

				; Turns GEAR Button on/off (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
				myGear_ButtonX := 1029 + windowX
				myGear_ButtonY := 622 + windowY
				myGear_ButtonWidth := 104
				myGear_ButtonHeight := 44
				if ((mouseX > myGear_ButtonX && mouseX < myGear_ButtonX+myGear_ButtonWidth) && (mouseY > myGear_ButtonY && mouseY < myGear_ButtonY+myGear_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{6}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{6}"
							} else {
								Send "{-}"
								}		
					myGearButton.Hide()
				}
		
				; Turns FLAPS on/off (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)
				myFlaps_ButtonX := 1137 + windowX
				myFlaps_ButtonY := 574 + windowY
				myFlaps_ButtonWidth := 104
				myFlaps_ButtonHeight := 44
				if ((mouseX > myFlaps_ButtonX && mouseX < myFlaps_ButtonX+myFlaps_ButtonWidth) && (mouseY > myFlaps_ButtonY && mouseY < myFlaps_ButtonY+myFlaps_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{9}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{9}"
							} else {
								Send "{ç}"
								}
					myFlapsButton.Hide()
				}
				
				; Turns BRAKE on/off  (QWERTY: 0 / QWERTZ: 0 / AZERTY: à)
				myBrake_ButtonX := 1137 + windowX
				myBrake_ButtonY := 622 + windowY
				myBrake_ButtonWidth := 104
				myBrake_ButtonHeight := 44
				if ((mouseX > myBrake_ButtonX && mouseX < myBrake_ButtonX+myBrake_ButtonWidth) && (mouseY > myBrake_ButtonY && mouseY < myBrake_ButtonY+myBrake_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{0}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{0}"
							} else {
								Send "{à}"
								}		
					myBrakeButton.Hide()
				}	
		
		
				
				
				; Select Blue WAYPOINT on MFD (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)
				myWaypoint_ButtonX := 681 + windowX
				myWaypoint_ButtonY := 901 + windowY
				myWaypoint_ButtonWidth := 76
				myWaypoint_ButtonHeight := 43
				if ((mouseX > myWaypoint_ButtonX && mouseX < myWaypoint_ButtonX+myWaypoint_ButtonWidth) && (mouseY > myWaypoint_ButtonY && mouseY < myWaypoint_ButtonY+myWaypoint_ButtonHeight)) {
					Send "{F7}"
					myWaypointButton.Hide()
				}	
				
				; Show Ordnance on MFD (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
				myOrdnance_ButtonX := 761 + windowX
				myOrdnance_ButtonY := 901 + windowY
				myOrdnance_ButtonWidth := 76
				myOrdnance_ButtonHeight := 43
				if ((mouseX > myOrdnance_ButtonX && mouseX < myOrdnance_ButtonX+myOrdnance_ButtonWidth) && (mouseY > myOrdnance_ButtonY && mouseY < myOrdnance_ButtonY+myOrdnance_ButtonHeight)) {
					Send "{F5}"
					myOrdnanceButton.Hide()
				}	
			
				; Show Objectives on MFD (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
				myObjectives_ButtonX := 841 + windowX
				myObjectives_ButtonY := 901 + windowY
				myObjectives_ButtonWidth := 76
				myObjectives_ButtonHeight := 43
				if ((mouseX > myObjectives_ButtonX && mouseX < myObjectives_ButtonX+myObjectives_ButtonWidth) && (mouseY > myObjectives_ButtonY && mouseY < myObjectives_ButtonY+myObjectives_ButtonHeight)) {
					Send "{F10}"
					myObjectivesButton.Hide()
				}	
			
			
					; CHANGE WAYPOINT RED (F8)
					; RESET WAYPOINT (SHIFT F8)
					
					; LAST WaYPOINT (PgUp)
					; NEXT WaYPOINT (PgDn)
					
					; Move WAYPOINT UP (Up arrow or NumPad 8)
					; Move WAYPOINT Down (Down arrow or NumPad 2)
			
			
				; Enables FLIR on MFD (QWERTY: F6 / QWERTZ: F6 / AZERTY: F6)
				myFlir_ButtonX := 929 + windowX
				myFlir_ButtonY := 915 + windowY
				myFlir_ButtonWidth := 72
				myFlir_ButtonHeight := 43
				if ((mouseX > myFlir_ButtonX && mouseX < myFlir_ButtonX+myFlir_ButtonWidth) && (mouseY > myFlir_ButtonY && mouseY < myFlir_ButtonY+myFlir_ButtonHeight)) {
					Send "{F6}"
					myFlirButton.Hide()
				}
				
				
				
				
				; Activates the EJECTION (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
				myEject_ButtonX := 1233 + windowX
				myEject_ButtonY := 685 + windowY
				myEject_ButtonWidth := 40
				myEject_ButtonHeight := 187
				if ((mouseX > myEject_ButtonX && mouseX < myEject_ButtonX+myEject_ButtonWidth) && (mouseY > myEject_ButtonY && mouseY < myEject_ButtonY+myEject_ButtonHeight)) {
					
					; Todo: 
					; To prevent unwanted aircraft ejection, the player should hold left click for 3 seconds before the hotkey to be executed
					; If the button hasn't been held long enough, don't press the hotkey
					; 
					
					
					/* 				
					Send "{LButton down}"
					Sleep 3000 
					Send "{LButton up}"
					; return
					*/
					
					Send "{Shift down}{F10}"
					myEjectButton.Hide()
					Send "{Shift up}"
				}	
			
			
			
			
				; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N) 
				myNewTarget_ButtonX := 997 + windowX
				myNewTarget_ButtonY := 738 + windowY
				myNewTarget_ButtonWidth := 24
				myNewTarget_ButtonHeight := 29
				if ((mouseX > myNewTarget_ButtonX && mouseX < myNewTarget_ButtonX+myNewTarget_ButtonWidth) && (mouseY > myNewTarget_ButtonY && mouseY < myNewTarget_ButtonY+myNewTarget_ButtonHeight)) {
					Send "{n}"
					myNewTargetButton.Hide()
				}	
				
				; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 	
				mySelectTarget_ButtonX := 997 + windowX
				mySelectTarget_ButtonY := 790 + windowY
				mySelectTarget_ButtonWidth := 24
				mySelectTarget_ButtonHeight := 29
				if ((mouseX > mySelectTarget_ButtonX && mouseX < mySelectTarget_ButtonX+mySelectTarget_ButtonWidth) && (mouseY > mySelectTarget_ButtonY && mouseY < mySelectTarget_ButtonY+mySelectTarget_ButtonHeight)) {
					Send "{b}"
					mySelectTargetButton.Hide()
				}	
				
				
				
				
					; change cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C) 	
				; 	myCockpitView_ButtonX := 997
				; 	myCockpitView_ButtonY := 790
				; 	myCockpitView_ButtonWidth := 24
				; 	myCockpitView_ButtonHeight := 29
				; 	if ((mouseX > myCockpitView_ButtonX && mouseX < myCockpitView_ButtonX+myCockpitView_ButtonWidth) && (mouseY > myCockpitView_ButtonY && mouseY < myCockpitView_ButtonY+myCockpitView_ButtonHeight)) {
				; 		Send "{c}"
				; 		myCockpitViewButton.Hide()
				; 	}	
					
				
				
				
				
				; CAM Ahead (QWERTY: / / QWERTZ: _ / AZERTY: !)
				; 1st MFD button from the top on the left side of the right MFD
				myCAMAhead_ButtonX := 645 + windowX
				myCAMAhead_ButtonY := 570 + windowY
				myCAMAhead_ButtonWidth := 24
				myCAMAhead_ButtonHeight := 28
				if ((mouseX > myCAMAhead_ButtonX && mouseX < myCAMAhead_ButtonX+myCAMAhead_ButtonWidth) && (mouseY > myCAMAhead_ButtonY && mouseY < myCAMAhead_ButtonY+myCAMAhead_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{/}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{_}"
							} else {
								Send "{!}"
								}						
					myCAMAheadButton.Hide()
				}
				
				; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
				; 2nd MFD button from the top on the left side of the right MFD
				myCAMRear_ButtonX := 645 + windowX
				myCAMRear_ButtonY := 622 + windowY
				myCAMRear_ButtonWidth := 24
				myCAMRear_ButtonHeight := 29
				if ((mouseX > myCAMRear_ButtonX && mouseX < myCAMRear_ButtonX+myCAMRear_ButtonWidth) && (mouseY > myCAMRear_ButtonY && mouseY < myCAMRear_ButtonY+myCAMRear_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{>}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{>}"
							} else {
								Send "{:}"
								}	
					myCAMRearButton.Hide()
				}
		
				; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
				; 3rd MFD button from the top on the left side of the right MFD
				myCAMRight_ButtonX := 645 + windowX
				myCAMRight_ButtonY := 675 + windowY
				myCAMRight_ButtonWidth := 24
				myCAMRight_ButtonHeight := 29
				if ((mouseX > myCAMRight_ButtonX && mouseX < myCAMRight_ButtonX+myCAMRight_ButtonWidth) && (mouseY > myCAMRight_ButtonY && mouseY < myCAMRight_ButtonY+myCAMRight_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{<}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{<}"
							} else {
								Send "{;}"
								}		
					myCAMRightButton.Hide()
				}
				
				; CAM Left (QWERTY: M / QWERTZ: M / AZERTY: ,)
				; 4th MFD button from the top on the left side of the right MFD
				myCAMLeft_ButtonX := 645 + windowX
				myCAMLeft_ButtonY := 738 + windowY
				myCAMLeft_ButtonWidth := 24
				myCAMLeft_ButtonHeight := 28
				if ((mouseX > myCAMLeft_ButtonX && mouseX < myCAMLeft_ButtonX+myCAMLeft_ButtonWidth) && (mouseY > myCAMLeft_ButtonY && mouseY < myCAMLeft_ButtonY+myCAMLeft_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
						Send "{m}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{m}"
							} else {
								Send "{,}"
								}	
					myCAMLeftButton.Hide()
				}
								
				; Extra CAM button 
				; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
				myExtraCAM_ButtonX := 761 + windowX
				myExtraCAM_ButtonY := 949 + windowY
				myExtraCAM_ButtonWidth := 156
				myExtraCAM_ButtonHeight := 43
				if ((mouseX > myExtraCAM_ButtonX && mouseX < myExtraCAM_ButtonX+myExtraCAM_ButtonWidth) && (mouseY > myExtraCAM_ButtonY && mouseY < myExtraCAM_ButtonY+myExtraCAM_ButtonHeight)) {
							
					; Circles through hotkeys (ahead --> rear --> right --> left --> ahead)
							Global ClickCounter								
						
							if ClickCounter == 3 {
								ClickCounter := 0
							} else if ClickCounter !== 4 {
								ClickCounter := ClickCounter + 1
							}							

							; Ahead
							If ClickCounter == 0 {
								if KeyboardLayout == "QWERTY" {
											Send "{/}"
											} else if KeyboardLayout == "QWERTZ" {
												Send "{_}"
												} else {
													Send "{!}"
													}								
								; Tooltip("Ahead")
								; SetTimer () => ToolTip(), -1500
							}

							; Rear
							If ClickCounter == 1 {
								if KeyboardLayout == "QWERTY" {
											Send "{>}"
											} else if KeyboardLayout == "QWERTZ" {
												Send "{>}"
												} else {
													Send "{:}"
													}	
								; Tooltip("Rear")
								; SetTimer () => ToolTip(), -1500
							}
							
							; Right
							If ClickCounter == 2 {
								if KeyboardLayout == "QWERTY" {
										Send "{<}"
										} else if KeyboardLayout == "QWERTZ" {
											Send "{<}"
											} else {
												Send "{;}"
												}	
								; Tooltip("Right")
								; SetTimer () => ToolTip(), -1500
							}
							
							; Left
							If ClickCounter == 3 {
								if KeyboardLayout == "QWERTY" {
											Send "{m}"
											} else if KeyboardLayout == "QWERTZ" {
												Send "{m}"
												} else {
													Send "{,}"
													}	
								; Tooltip("Left")
								; SetTimer () => ToolTip(), -1500
							}					
					
					myExtraCAMButton.Hide()
				}

				
				
			
				; Volume adjust (Alt V)
				
				
				
				
				; Accelerates the game (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
				; the left button at the bottom of the right MFD
				myAccelerate_ButtonX := 829 + windowX
				myAccelerate_ButtonY := 858 + windowY
				myAccelerate_ButtonWidth := 24
				myAccelerate_ButtonHeight := 25
				if ((mouseX > myAccelerate_ButtonX && mouseX < myAccelerate_ButtonX+myAccelerate_ButtonWidth) && (mouseY > myAccelerate_ButtonY && mouseY < myAccelerate_ButtonY+myAccelerate_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
							Send "{Shift down}{z}"
							} else if KeyboardLayout == "QWERTZ" {
								Send "{Shift down}{y}"
								} else {
									Send "{Shift down}{W}"
									}
					myAccelerateButton.Hide()
					Send "{Shift up}"
				}	
			
				; Normal game speed (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
				myNormalSpeed_ButtonX := 873 + windowX
				myNormalSpeed_ButtonY := 858 + windowY
				myNormalSpeed_ButtonWidth := 24
				myNormalSpeed_ButtonHeight := 28
				if ((mouseX > myNormalSpeed_ButtonX && mouseX < myNormalSpeed_ButtonX+myNormalSpeed_ButtonWidth) && (mouseY > myNormalSpeed_ButtonY && mouseY < myNormalSpeed_ButtonY+myNormalSpeed_ButtonHeight)) {
					Send "{Shift down}{X}"
					myNormalSpeedButton.Hide()
					Send "{Shift up}"
				}	

				; Pause game (QWERTY: ALT P / QWERTZ: ALT P / AZERTY: ALT P)
				; the right button at the bottom of the right MFD
				; Find a way to click one more time on the Pause button to unpause
				myPause_ButtonX := 921 + windowX
				myPause_ButtonY := 858 + windowY
				myPause_ButtonWidth := 24
				myPause_ButtonHeight := 25
				if ((mouseX > myPause_ButtonX && mouseX < myPause_ButtonX+myPause_ButtonWidth) && (mouseY > myPause_ButtonY && mouseY < myPause_ButtonY+myPause_ButtonHeight)) {
					Send "{Alt down}{P}"
					myPauseButton.Hide()
					Send "{Alt up}"
				}	
			
			
			
				; Toggle HUD color (F4) 


			

				; de-clutter HUD (QWERTY: V / QWERTZ: V / AZERTY: V)
				myDeClutter_ButtonX := 845 + windowX
				myDeClutter_ButtonY := 488 + windowY
				myDeClutter_ButtonWidth := 28
				myDeClutter_ButtonHeight := 29
				if ((mouseX > myDeClutter_ButtonX && mouseX < myDeClutter_ButtonX+myDeClutter_ButtonWidth) && (mouseY > myDeClutter_ButtonY && mouseY < myDeClutter_ButtonY+myDeClutter_ButtonHeight)) {
					Send "{v}"
					myDeClutterButton.Hide()
				}	


				
			
				; Sets Maximum Power (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myMaximumPower_ButtonX := 262 + windowX
				myMaximumPower_ButtonY := 560 + windowY
				myMaximumPower_ButtonWidth := 24
				myMaximumPower_ButtonHeight := 29
				if ((mouseX > myMaximumPower_ButtonX && mouseX < myMaximumPower_ButtonX+myMaximumPower_ButtonWidth) && (mouseY > myMaximumPower_ButtonY && mouseY < myMaximumPower_ButtonY+myMaximumPower_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
							Send "{Shift down}{+}"
							} else if KeyboardLayout == "QWERTZ" {
								Send "{Shift down}{`}"
								} else {
									Send "{Shift down}{=}"
									}
					myMaximumPowerButton.Hide()
					Send "{Shift up}"
				}	
			
				; Increases Throttle (QWERTY: = / QWERTZ: ´ / AZERTY: =)
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myIncreaseThrottle_ButtonX := 262 + windowX
				myIncreaseThrottle_ButtonY := 622 + windowY
				myIncreaseThrottle_ButtonWidth := 24
				myIncreaseThrottle_ButtonHeight := 29
				if ((mouseX > myIncreaseThrottle_ButtonX && mouseX < myIncreaseThrottle_ButtonX+myIncreaseThrottle_ButtonWidth) && (mouseY > myIncreaseThrottle_ButtonY && mouseY < myIncreaseThrottle_ButtonY+myIncreaseThrottle_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
							Send "{=}"
							} else if KeyboardLayout == "QWERTZ" {
								Send "{´}"
								} else {
									Send "{=}"
									}
					myIncreaseThrottleButton.Hide()
				}	
			
			
			
				; 50% Power (detects the current speed and changes it accordingly)
				; There is room on the left side of the left MFD
				
				
			
				; Decreases Throttle (QWERTY: - / QWERTZ: ß / AZERTY: ))
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myDecreaseThrottle_ButtonX := 262 + windowX
				myDecreaseThrottle_ButtonY := 733 + windowY
				myDecreaseThrottle_ButtonWidth := 24
				myDecreaseThrottle_ButtonHeight := 29
				if ((mouseX > myDecreaseThrottle_ButtonX && mouseX < myDecreaseThrottle_ButtonX+myDecreaseThrottle_ButtonWidth) && (mouseY > myDecreaseThrottle_ButtonY && mouseY < myDecreaseThrottle_ButtonY+myDecreaseThrottle_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
							Send "{-}"
							} else if KeyboardLayout == "QWERTZ" {
								Send "{ß}"
								} else {
									Send "{)}"
									}
					myDecreaseThrottleButton.Hide()
				}	
		
				; No Power (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myNoPower_ButtonX := 262 + windowX
				myNoPower_ButtonY := 795 + windowY
				myNoPower_ButtonWidth := 24
				myNoPower_ButtonHeight := 29
				if ((mouseX > myNoPower_ButtonX && mouseX < myNoPower_ButtonX+myNoPower_ButtonWidth) && (mouseY > myNoPower_ButtonY && mouseY < myNoPower_ButtonY+myNoPower_ButtonHeight)) {
					if KeyboardLayout == "QWERTY" {
							Send "{Shift down}{-}"
							} else if KeyboardLayout == "QWERTZ" {
								Send "{Shift down}{ß}"
								} else {
									Send "{Shift down}{)}"
									}			
					myNoPowerButton.Hide()
					Send "{Shift up}"
				}
				
				
				
			
				; Resupply (training) (ALT R)




			}




		; Allows to press E to launch missiles (mimicks Enter Key)
		$e:: Enter
		
		
		
		; Currently broken, conflicts with the WASD hotkeys below
		/*
		; Allows to press Q (or A on an AZERTY keyboard) to open the missiles bay
		if (KeyboardLayout == "QWERTY") {
				$q:: 8				
			} else if (KeyboardLayout == "QWERTZ") {
				$q:: 8				
			} else {
				$a:: Send "{_}"
		}
		*/
		
		
		
		
		
		
		
		
		
		
		
		
		
		



		; Allows to use WASD keys (ZQSD on an AZERTY keyboards) for movements
	
			; Up arrow (QWERTY: W / QWERTZ: W / AZERTY: Z)		
			; Left arrow (QWERTY: A / QWERTZ: A / AZERTY: Q)
			; Down arrow (QWERTY: S / QWERTZ: S / AZERTY: S)
			; Right arrow (QWERTY: D / QWERTZ: D / AZERTY: D)						
			
			if (KeyboardLayout == "QWERTY") {
					; $q:: Send ("q")
					; $z:: Send ("z")					
					; $q:: Send "{q}"
					; $z:: Send "{z}" 
					$w:: Up
					$a:: Left
					$s:: Down
					$d:: Right
					
				} else if (KeyboardLayout == "QWERTZ") {
					; $q:: Send ("q")
					; $z:: Send ("z")					
					; $q:: Send "{q}"
					; $z:: Send "{z}" 
					$w:: Up
					$a:: Left
					$s:: Down
					$d:: Right
					
				} else {
					; $a:: Send ("a")
					; $w:: Send ("w")
					$a:: Send "{a}"
					$w:: Send "{w}"
					$z:: Up
					$q:: Left 
					$s:: Down
					$d:: Right			
				}
			



		; Exits the AHK script by right clicking or by pressing ESC
		~RButton:: ExitApp
		~Esc:: ExitApp

	





















		; //////////////////////////////////////////////////
		; TOOLTIPS
		; //////////////////////////////////////////////////

		/*

			; Chaff 
		
			; https://www.autohotkey.com/docs/v2/lib/CoordMode.htm
			; RelativeTo: 	Screen Window Client 
			CoordMode("Pixel", "Screen") ; Pixel: Affects PixelGetColor, PixelSearch, and ImageSearch.
			CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, and MouseClickDrag.
			
			MouseGetPos(&mouseX, &mouseY)
				
		
		
			myChaff_ButtonX := 14
			myChaff_ButtonY := 742
			myChaff_ButtonWidth := 104
			myChaff_ButtonHeight := 44
			if ((mouseX > myChaff_ButtonX && mouseX < myChaff_ButtonX+myChaff_ButtonWidth) && (mouseY > myChaff_ButtonY && mouseY < myChaff_ButtonY+myChaff_ButtonHeight)) {
				Tooltip("Chaff")
				SetTimer () => ToolTip(), -4000
			
			}
			
			
			
				
				
		*/
	
	

















	}


	










































	
