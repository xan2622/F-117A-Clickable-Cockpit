/*

----------------------------------------------------------------------------
	"F-117A Clickable Cockpit" by xan2622
	version 1.2.0
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

	ImageSearchVar01 := !ImageSearch(&Position01X, &Position01Y, DOSBox_WindowClientX, DOSBox_WindowClientY, DOSBox_WindowClientW, DOSBox_WindowClientH, "*1 E:\DONNEES_SEB\APPS\DEVELOPPEMENT\scripting\AutoHotkey\Mes Macros\F-117A\NAVAIRGND_01.png")
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

		/*
			; Displays a transparent frame over the inner area of DosBox
			; Warning: prevents to send keys while this GUI is displayed 
			myDosBoxWindow := Gui()
			myDosBoxWindow.BackColor := "Blue"
			myDosBoxWindow.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 40, myDosBoxWindow ; Set value from 1 to 255 to change opacity
			myDosBoxWindow.Show("x3 y32 w1279 h960")
			; myDosBoxWindow.Show("DOSBox_WindowClientX DOSBox_WindowClientY DOSBox_WindowClientW DOSBox_WindowClientH")

		*/

			
			
			
			; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollUp Zoom In (QWERTY: Z / QWERTZ: Y / AZERTY: W)
			myMFDZoomInMouseWheel := Gui()
			myMFDZoomInMouseWheel.BackColor := "Yellow"
			myMFDZoomInMouseWheel.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myMFDZoomInMouseWheel
			myMFDZoomInMouseWheel.Show("x298 y560 w308 h288")
			
			; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollDown Zoom Out (QWERTY: X / QWERTZ: X / AZERTY: X)
			myMFDZoomOutMouseWheel := Gui()
			myMFDZoomOutMouseWheel.BackColor := "Yellow"
			myMFDZoomOutMouseWheel.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myMFDZoomOutMouseWheel
			myMFDZoomOutMouseWheel.Show("x298 y560 w308 h288")
			
			
			
			
			; Displays a wide MAPTAC button (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
			myMFDButton := Gui()
			myMFDButton.BackColor := "Yellow"
			myMFDButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myMFDButton
			myMFDButton.Show("x322 y862 w156 h44")
			
			; Displays a MFD Zoom In button (QWERTY: Z / QWERTZ: Y / AZERTY: W)
			myMFDZoomInButton := Gui()
			myMFDZoomInButton.BackColor := "Yellow"
			myMFDZoomInButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myMFDZoomInButton
			myMFDZoomInButton.Show("x514 y867 w28 h29")
			
			; Displays a MFD Zoom Out button (QWERTY: X / QWERTZ: X / AZERTY: X)
			myMFDZoomOutButton := Gui()
			myMFDZoomOutButton.BackColor := "Yellow"
			myMFDZoomOutButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myMFDZoomOutButton
			myMFDZoomOutButton.Show("x562 y867 w28 h29")




			; Displays a CHAFF button (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
			myChaffButton := Gui()
			myChaffButton.BackColor := "Yellow"
			myChaffButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myChaffButton
			myChaffButton.Show("x14 y742 w104 h44")

			; Displays a FLARE button (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
			myFlareButton := Gui()
			myFlareButton.BackColor := "Yellow"
			myFlareButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myFlareButton
			myFlareButton.Show("x14 y790 w104 h44")

			; Displays a DECOY button (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
			myDecoyButton := Gui()
			myDecoyButton.BackColor := "Yellow"
			myDecoyButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myDecoyButton
			myDecoyButton.Show("x14 y838 w104 h44")

			; Displays a ECM button (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
			myECMButton := Gui()
			myECMButton.BackColor := "Yellow"
			myECMButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myECMButton
			myECMButton.Show("x18 y891 w116 h43")

			; Displays a IR Jammer button (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
			myIRJammerButton := Gui()
			myIRJammerButton.BackColor := "Yellow"
			myIRJammerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myIRJammerButton
			myIRJammerButton.Show("x146 y891 w108 h43")




			; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
			; the screw at the left of the NAV button 
			mySelectWeaponButton := Gui()
			mySelectWeaponButton.BackColor := "Yellow"
			mySelectWeaponButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, mySelectWeaponButton
			mySelectWeaponButton.Show("x414 y483 w44 h48")

			; Displays a wide NAVAIRGND button (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
			myNavAirGndButton := Gui()
			myNavAirGndButton.BackColor := "Yellow"
			myNavAirGndButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myNavAirGndButton
			myNavAirGndButton.Show("x478 y483 w235 h43")
		
			; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
			; the fully visible MFD button at the top of the right MFD
			myILSButton := Gui()
			myILSButton.BackColor := "Yellow"
			myILSButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myILSButton
			myILSButton.Show("x922 y526 w24 h29")
		



			; Displays a BAY button (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
			myBayButton := Gui()
			myBayButton.BackColor := "Yellow"
			myBayButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myBayButton
			myBayButton.Show("x1029 y526 w104 h44")

			; Displays an AUTOPILOT button (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
			myAutopilotButton := Gui()
			myAutopilotButton.BackColor := "Yellow"
			myAutopilotButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myAutopilotButton
			myAutopilotButton.Show("x1029 y574 w104 h44")

			; Displays a GEAR button (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
			myGearButton := Gui()
			myGearButton.BackColor := "Yellow"
			myGearButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myGearButton
			myGearButton.Show("x1029 y622 w104 h44")

			; Displays a FLAPS button (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)
			myFlapsButton := Gui()
			myFlapsButton.BackColor := "Yellow"
			myFlapsButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myFlapsButton
			myFlapsButton.Show("x1137 y574 w104 h44")

			; Displays a BRAKE button (0)
			myBrakeButton := Gui()
			myBrakeButton.BackColor := "Yellow"
			myBrakeButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myBrakeButton
			myBrakeButton.Show("x1137 y622 w104 h44")




			; Displays a Blue WAYPOINT button (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)
			myWaypointButton := Gui()
			myWaypointButton.BackColor := "Yellow"
			myWaypointButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myWaypointButton
			myWaypointButton.Show("x681 y901 w76 h43")
			
			; Displays a Ordnance button (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
			myOrdnanceButton := Gui()
			myOrdnanceButton.BackColor := "Yellow"
			myOrdnanceButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myOrdnanceButton
			myOrdnanceButton.Show("x761 y901 w76 h43")
			
			; Displays an Objectives button (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
			myObjectivesButton := Gui()
			myObjectivesButton.BackColor := "Yellow"
			myObjectivesButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myObjectivesButton
			myObjectivesButton.Show("x841 y901 w76 h43")
			
			
				; CHANGE WAYPOINT RED (F8)
				; RESET WAYPOINT (SHIFT F8)

				; LAST WaYPOINT (PgUp)
				; NEXT WaYPOINT (PgDn)
				
				; Move WAYPOINT UP (Up arrow or NumPad 8)
				; Move WAYPOINT Down (Down arrow or NumPad 2)

			
			; Displays a FLIR button (QWERTY: F6 / QWERTZ: F6 / AZERTY: F6)
			myFlirButton := Gui()
			myFlirButton.BackColor := "Yellow"
			myFlirButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myFlirButton
			myFlirButton.Show("x929 y915 w72 h43")

			
			
			
			; Displays a EJECT button (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
			; the yellow and black stripes plate located on the right side
			myEjectButton := Gui()
			myEjectButton.BackColor := "Yellow"
			myEjectButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myEjectButton
			myEjectButton.Show("x1233 y685 w40 h187")




			; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N) 
			; the 4th button at the bottom right side of the right MFD
			myNewTargetButton := Gui()
			myNewTargetButton.BackColor := "Yellow"
			myNewTargetButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myNewTargetButton
			myNewTargetButton.Show("x997 y738 w24 h29")
					
			; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 	
			; the 5th button at the bottom right side of the right MFD
			mySelectTargetButton := Gui()
			mySelectTargetButton.BackColor := "Yellow"
			mySelectTargetButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, mySelectTargetButton
			mySelectTargetButton.Show("x997 y790 w24 h29")
			
			

			
			; Changes cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C)
		;	myCockpitViewButton := Gui()
		;	myCockpitViewButton.BackColor := "Yellow"
		;	myCockpitViewButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		;	WinSetTransparent 75, myCockpitViewButton
		;	myCockpitViewButton.Show("x997 y790 w24 h29")

			
			
			; CAM Ahead (QWERTY: / / QWERTZ: / / AZERTY: !)
			; 1st MFD button from the top on the left side of the right MFD
			myCAMAheadButton := Gui()
			myCAMAheadButton.BackColor := "Yellow"
			myCAMAheadButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myCAMAheadButton
			myCAMAheadButton.Show("x645 y570 w24 h28")
			
			; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
			; 2nd MFD button from the top on the left side of the right MFD
			myCAMRearButton := Gui()
			myCAMRearButton.BackColor := "Yellow"
			myCAMRearButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myCAMRearButton
			myCAMRearButton.Show("x645 y622 w24 h29")
					
			; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
			; 3rd MFD button from the top on the left side of the right MFD
			myCAMRightButton := Gui()
			myCAMRightButton.BackColor := "Yellow"
			myCAMRightButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myCAMRightButton
			myCAMRightButton.Show("x645 y675 w24 h29")

			; CAM left (QWERTY: M / QWERTZ: M / AZERTY: ,)
			; 4th MFD button from the top on the left side of the right MFD
			myCAMLeftButton := Gui()
			myCAMLeftButton.BackColor := "Yellow"
			myCAMLeftButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myCAMLeftButton
			myCAMLeftButton.Show("x645 y738 w24 h28")
			
			; Extra CAM button 
			; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
			myExtraCAMButton := Gui()
			myExtraCAMButton.BackColor := "Yellow"
			myExtraCAMButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myExtraCAMButton
			myExtraCAMButton.Show("x761 y949 w156 h43")
			
			
			
			
			; Volume adjust (Alt V)
			
			
		
			
			; Displays an Accelerate button (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
			; the left button at the bottom of the right MFD
			myAccelerateButton := Gui()
			myAccelerateButton.BackColor := "Yellow"
			myAccelerateButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myAccelerateButton
			myAccelerateButton.Show("x829 y858 w24 h28")

			; Displays a Normal Speed button (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
			; the middle button at the bottom of the right MFD
			myNormalSpeedButton := Gui()
			myNormalSpeedButton.BackColor := "Yellow"
			myNormalSpeedButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myNormalSpeedButton
			myNormalSpeedButton.Show("x873 y858 w24 h28")
			
			; Displays a Pause button (QWERTY: ALT P / QWERTZ: ALT P / AZERTY: ALT P)
			; the right button at the bottom of the right MFD
			myPauseButton := Gui()
			myPauseButton.BackColor := "Yellow"
			myPauseButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myPauseButton
			myPauseButton.Show("x921 y858 w24 h28")
			
		
			
			
			; Toggle HUD color (F4) 
			
			
			
			
			; Displays a de-clutter HUD button (QWERTY: V / QWERTZ: V / AZERTY: V)
			; the rounded button located on the right side of LOCK button
			myDeClutterButton := Gui()
			myDeClutterButton.BackColor := "Yellow"
			myDeClutterButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myDeClutterButton
			myDeClutterButton.Show("x845 y488 w28 h29")
			
			
			
			
			; Displays a Maximum Power button (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
			; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
			myMaximumPowerButton := Gui()
			myMaximumPowerButton.BackColor := "Yellow"
			myMaximumPowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myMaximumPowerButton
			myMaximumPowerButton.Show("x262 y560 w24 h29")
			
			; Displays an Increase Throttle button (QWERTY: = / QWERTZ: ´ / AZERTY: =)
			; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
			myIncreaseThrottleButton := Gui()
			myIncreaseThrottleButton.BackColor := "Yellow"
			myIncreaseThrottleButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myIncreaseThrottleButton
			myIncreaseThrottleButton.Show("x262 y622 w24 h29")
			
			; 50% Power (detects the current speed and changes it accordingly)
			; There is room on the left side of the left MFD
				
			
			; Displays a Decrease Throttle button (QWERTY: - / QWERTZ: ß / AZERTY: ))
			; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
			myDecreaseThrottleButton := Gui()
			myDecreaseThrottleButton.BackColor := "Yellow"
			myDecreaseThrottleButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myDecreaseThrottleButton
			myDecreaseThrottleButton.Show("x262 y733 w24 h29")
			
			; Displays a No Power button (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
			myNoPowerButton := Gui()
			myNoPowerButton.BackColor := "Yellow"
			myNoPowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
			WinSetTransparent 75, myNoPowerButton
			myNoPowerButton.Show("x262 y795 w24 h29")
			
			
			
			
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
				; https://www.autohotkey.com/docs/v2/lib/CoordMode.htm
				; RelativeTo: 	Screen Window Client 
				CoordMode("Pixel", "Screen") ; Pixel: Affects PixelGetColor, PixelSearch, and ImageSearch.
				CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, and MouseClickDrag.
				
				MouseGetPos(&mouseX, &mouseY)
				
				; Zooms the MAPTAC MFD in (QWERTY: Z / QWERTZ: Y / AZERTY: W)
				myMFDZoomInMouseWheel_AreaX := 298
				myMFDZoomInMouseWheel_AreaY := 560
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
					
					; Sleep 500
					myMFDZoomInMouseWheel.Destroy()
					; ExitApp
				}	
			}

		; Mouse Wheel ScrollDown Zoom Out (QWERTY: X / QWERTZ: X / AZERTY: X)
		WheelDown::
			{
				; https://www.autohotkey.com/docs/v2/lib/CoordMode.htm
				; RelativeTo: 	Screen Window Client 
				CoordMode("Pixel", "Screen") ; Pixel: Affects PixelGetColor, PixelSearch, and ImageSearch.
				CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, and MouseClickDrag.
				
				MouseGetPos(&mouseX, &mouseY)
				
				; Zooms the MAPTAC MFD out (QWERTY: X / QWERTZ: X / AZERTY: X)
				myMFDZoomOutMouseWheel_AreaX := 298
				myMFDZoomOutMouseWheel_AreaY := 560
				myMFDZoomOutMouseWheel_AreaWidth := 308
				myMFDZoomOutMouseWheel_AreaHeight := 288
				if ((mouseX > myMFDZoomOutMouseWheel_AreaX && mouseX < myMFDZoomOutMouseWheel_AreaX+myMFDZoomOutMouseWheel_AreaWidth) && (mouseY > myMFDZoomOutMouseWheel_AreaY && mouseY < myMFDZoomOutMouseWheel_AreaY+myMFDZoomOutMouseWheel_AreaHeight)) {
					Send "{x}"		

					; Sleep 500
					myMFDZoomOutMouseWheel.Destroy()
					; ExitApp
				}
			}
			







		
		

		~LButton::
			{
				; https://www.autohotkey.com/docs/v2/lib/CoordMode.htm
				; RelativeTo: 	Screen Window Client 
				CoordMode("Pixel", "Screen") ; Pixel: Affects PixelGetColor, PixelSearch, and ImageSearch.
				CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, and MouseClickDrag.
				
				MouseGetPos(&mouseX, &mouseY)
				
				
				; Clickable areas (buttons) 

				/* 
					; Clickable Button: The Whole DOSBox/DOSBox-X window
					ButtonX := 3 
					ButtonY := 15 
					Width   := 1025 
					Height  := 960 
					if ((mouseX > ButtonX && mouseX < ButtonX+Width) && (mouseY > ButtonY && mouseY < ButtonY+Height)) {
						myDosBoxWindow.Destroy()
						ExitApp
					}				
				*/				
					
					
					
				
		
				; Toggles the MAPTAC MFD mode (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
				myMFD_ButtonX := 322
				myMFD_ButtonY := 862
				myMFD_ButtonWidth := 156
				myMFD_ButtonHeight := 44
				if ((mouseX > myMFD_ButtonX && mouseX < myMFD_ButtonX+myMFD_ButtonWidth) && (mouseY > myMFD_ButtonY && mouseY < myMFD_ButtonY+myMFD_ButtonHeight)) {
					Send "{F3}"
					myMFDButton.Destroy()
				}			
				
				; Enables MFD Zoom in (QWERTY: Z / QWERTZ: Y / AZERTY: W)
				myMFDZoomIn_ButtonX := 514
				myMFDZoomIn_ButtonY := 867 
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
					myMFDZoomInButton.Destroy()
				}				
					
				; Enables MFD Zoom out (QWERTY: X / QWERTZ: X / AZERTY: X)
				myMFDZoomOut_ButtonX := 562
				myMFDZoomOut_ButtonY := 867 
				myMFDZoomOut_ButtonWidth := 28
				myMFDZoomOut_ButtonHeight := 29
				if ((mouseX > myMFDZoomOut_ButtonX && mouseX < myMFDZoomOut_ButtonX+myMFDZoomOut_ButtonWidth) && (mouseY > myMFDZoomOut_ButtonY && mouseY < myMFDZoomOut_ButtonY+myMFDZoomOut_ButtonHeight)) {
					Send "{x}"
					myMFDZoomOutButton.Destroy()
				}
				
				

				
				; Drops a Chaff (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
				myChaff_ButtonX := 14
				myChaff_ButtonY := 742
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
					myChaffButton.Destroy()
				}
				
				; Drops a Flare (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
				myFlare_ButtonX := 14
				myFlare_ButtonY := 790
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
					myFlareButton.Destroy()
				}
				
				; Drops a Decoy (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
				myDecoy_ButtonX := 14
				myDecoy_ButtonY := 838
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
					myDecoyButton.Destroy()
				}
				
				; Toggles ECM on/off (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
				myECM_ButtonX := 18
				myECM_ButtonY := 891
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
					myECMButton.Destroy()
				}
				
				; Toggles IR Jammer on/off (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
				myIRJammer_ButtonX := 146
				myIRJammer_ButtonY := 891
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
					myIRJammerButton.Destroy()
				}
			
		


				; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
				mySelectWeapon_ButtonX := 414
				mySelectWeapon_ButtonY := 483
				mySelectWeapon_ButtonWidth := 44
				mySelectWeapon_ButtonHeight := 48
				if ((mouseX > mySelectWeapon_ButtonX && mouseX < mySelectWeapon_ButtonX+mySelectWeapon_ButtonWidth) && (mouseY > mySelectWeapon_ButtonY && mouseY < mySelectWeapon_ButtonY+mySelectWeapon_ButtonHeight)) {
					Send "{Space}"
					mySelectWeaponButton.Destroy()
				}

				; Toggle NAV AIR GND buttons (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
				myNavAirGnd_ButtonX := 478
				myNavAirGnd_ButtonY := 483
				myNavAirGnd_ButtonWidth := 235
				myNavAirGnd_ButtonHeight := 43
				if ((mouseX > myNavAirGnd_ButtonX && mouseX < myNavAirGnd_ButtonX+myNavAirGnd_ButtonWidth) && (mouseY > myNavAirGnd_ButtonY && mouseY < myNavAirGnd_ButtonY+myNavAirGnd_ButtonHeight)) {
					Send "{F2}"
					myNavAirGndButton.Destroy()
				}			
				
				; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
				; the fully visible MFD button at the top of the right MFD
				myILS_ButtonX := 922
				myILS_ButtonY := 526
				myILS_ButtonWidth := 24
				myILS_ButtonHeight := 29
				if ((mouseX > myILS_ButtonX && mouseX < myILS_ButtonX+myILS_ButtonWidth) && (mouseY > myILS_ButtonY && mouseY < myILS_ButtonY+myILS_ButtonHeight)) {
					Send "{F9}"
					myILSButton.Destroy()
				}
				
				
		
			
				; Turns BAY on/off (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
				myBay_ButtonX := 1029
				myBay_ButtonY := 526
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
					myBayButton.Destroy()
				}			
				
				; Turns AUTOPILOT nn/off (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
				myAutopilot_ButtonX := 1029
				myAutopilot_ButtonY := 574
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
					myAutopilotButton.Destroy()
				}			

				; Turns GEAR Button on/off (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
				myGear_ButtonX := 1029
				myGear_ButtonY := 622
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
					myGearButton.Destroy()
				}
		
				; Turns FLAPS on/off (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)
				myFlaps_ButtonX := 1137
				myFlaps_ButtonY := 574
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
					myFlapsButton.Destroy()
				}
				
				; Turns BRAKE on/off  (QWERTY: 0 / QWERTZ: 0 / AZERTY: à)
				myBrake_ButtonX := 1137
				myBrake_ButtonY := 622
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
					myBrakeButton.Destroy()
				}	
		
		
				
				
				; Select Blue WAYPOINT on MFD (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)
				myWaypoint_ButtonX := 681
				myWaypoint_ButtonY := 901
				myWaypoint_ButtonWidth := 76
				myWaypoint_ButtonHeight := 43
				if ((mouseX > myWaypoint_ButtonX && mouseX < myWaypoint_ButtonX+myWaypoint_ButtonWidth) && (mouseY > myWaypoint_ButtonY && mouseY < myWaypoint_ButtonY+myWaypoint_ButtonHeight)) {
					Send "{F7}"
					myWaypointButton.Destroy()
				}	
				
				; Show Ordnance on MFD (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
				myOrdnance_ButtonX := 761
				myOrdnance_ButtonY := 901
				myOrdnance_ButtonWidth := 76
				myOrdnance_ButtonHeight := 43
				if ((mouseX > myOrdnance_ButtonX && mouseX < myOrdnance_ButtonX+myOrdnance_ButtonWidth) && (mouseY > myOrdnance_ButtonY && mouseY < myOrdnance_ButtonY+myOrdnance_ButtonHeight)) {
					Send "{F5}"
					myOrdnanceButton.Destroy()
				}	
			
				; Show Objectives on MFD (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
				myObjectives_ButtonX := 841
				myObjectives_ButtonY := 901
				myObjectives_ButtonWidth := 76
				myObjectives_ButtonHeight := 43
				if ((mouseX > myObjectives_ButtonX && mouseX < myObjectives_ButtonX+myObjectives_ButtonWidth) && (mouseY > myObjectives_ButtonY && mouseY < myObjectives_ButtonY+myObjectives_ButtonHeight)) {
					Send "{F10}"
					myObjectivesButton.Destroy()
				}	
			
			
					; CHANGE WAYPOINT RED (F8)
					; RESET WAYPOINT (SHIFT F8)
					
					; LAST WaYPOINT (PgUp)
					; NEXT WaYPOINT (PgDn)
					
					; Move WAYPOINT UP (Up arrow or NumPad 8)
					; Move WAYPOINT Down (Down arrow or NumPad 2)
			
			
				; Enables FLIR on MFD (QWERTY: F6 / QWERTZ: F6 / AZERTY: F6)
				myFlir_ButtonX := 929
				myFlir_ButtonY := 915
				myFlir_ButtonWidth := 72
				myFlir_ButtonHeight := 43
				if ((mouseX > myFlir_ButtonX && mouseX < myFlir_ButtonX+myFlir_ButtonWidth) && (mouseY > myFlir_ButtonY && mouseY < myFlir_ButtonY+myFlir_ButtonHeight)) {
					Send "{F6}"
					myFlirButton.Destroy()
				}
				
				
				
				
				; Activates the EJECTION (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
				myEject_ButtonX := 1233
				myEject_ButtonY := 685
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
					myEjectButton.Destroy()
					Send "{Shift up}"
				}	
			
			
			
			
				; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N) 
				myNewTarget_ButtonX := 997
				myNewTarget_ButtonY := 738
				myNewTarget_ButtonWidth := 24
				myNewTarget_ButtonHeight := 29
				if ((mouseX > myNewTarget_ButtonX && mouseX < myNewTarget_ButtonX+myNewTarget_ButtonWidth) && (mouseY > myNewTarget_ButtonY && mouseY < myNewTarget_ButtonY+myNewTarget_ButtonHeight)) {
					Send "{n}"
					myNewTargetButton.Destroy()
				}	
				
				; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 	
				mySelectTarget_ButtonX := 997
				mySelectTarget_ButtonY := 790
				mySelectTarget_ButtonWidth := 24
				mySelectTarget_ButtonHeight := 29
				if ((mouseX > mySelectTarget_ButtonX && mouseX < mySelectTarget_ButtonX+mySelectTarget_ButtonWidth) && (mouseY > mySelectTarget_ButtonY && mouseY < mySelectTarget_ButtonY+mySelectTarget_ButtonHeight)) {
					Send "{b}"
					mySelectTargetButton.Destroy()
				}	
				
				
				
				
					; change cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C) 	
				; 	myCockpitView_ButtonX := 997
				; 	myCockpitView_ButtonY := 790
				; 	myCockpitView_ButtonWidth := 24
				; 	myCockpitView_ButtonHeight := 29
				; 	if ((mouseX > myCockpitView_ButtonX && mouseX < myCockpitView_ButtonX+myCockpitView_ButtonWidth) && (mouseY > myCockpitView_ButtonY && mouseY < myCockpitView_ButtonY+myCockpitView_ButtonHeight)) {
				; 		Send "{c}"
				; 		myCockpitViewButton.Destroy()
				; 	}	
					
				
				
				
				
				; CAM Ahead (QWERTY: / / QWERTZ: _ / AZERTY: !)
				; 1st MFD button from the top on the left side of the right MFD
				myCAMAhead_ButtonX := 645
				myCAMAhead_ButtonY := 570
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
					myCAMAheadButton.Destroy()
				}
				
				; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
				; 2nd MFD button from the top on the left side of the right MFD
				myCAMRear_ButtonX := 645
				myCAMRear_ButtonY := 622
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
					myCAMRearButton.Destroy()
				}
		
				; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
				; 3rd MFD button from the top on the left side of the right MFD
				myCAMRight_ButtonX := 645
				myCAMRight_ButtonY := 675
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
					myCAMRightButton.Destroy()
				}
				
				; CAM Left (QWERTY: M / QWERTZ: M / AZERTY: ,)
				; 4th MFD button from the top on the left side of the right MFD
				myCAMLeft_ButtonX := 645
				myCAMLeft_ButtonY := 738
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
					myCAMLeftButton.Destroy()
				}
								
				; Extra CAM button 
				; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
				myExtraCAM_ButtonX := 761
				myExtraCAM_ButtonY := 949
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
					
					myExtraCAMButton.Destroy()
				}

				
				
			
				; Volume adjust (Alt V)
				
				
				
				
				; Accelerates the game (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
				; the left button at the bottom of the right MFD
				myAccelerate_ButtonX := 829
				myAccelerate_ButtonY := 858
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
					myAccelerateButton.Destroy()
					Send "{Shift up}"
				}	
			
				; Normal game speed (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
				myNormalSpeed_ButtonX := 873
				myNormalSpeed_ButtonY := 858
				myNormalSpeed_ButtonWidth := 24
				myNormalSpeed_ButtonHeight := 28
				if ((mouseX > myNormalSpeed_ButtonX && mouseX < myNormalSpeed_ButtonX+myNormalSpeed_ButtonWidth) && (mouseY > myNormalSpeed_ButtonY && mouseY < myNormalSpeed_ButtonY+myNormalSpeed_ButtonHeight)) {
					Send "{Shift down}{X}"
					myNormalSpeedButton.Destroy()
					Send "{Shift up}"
				}	

				; Pause game (QWERTY: ALT P / QWERTZ: ALT P / AZERTY: ALT P)
				; the right button at the bottom of the right MFD
				; Find a way to click one more time on the Pause button to unpause
				myPause_ButtonX := 921
				myPause_ButtonY := 858
				myPause_ButtonWidth := 24
				myPause_ButtonHeight := 25
				if ((mouseX > myPause_ButtonX && mouseX < myPause_ButtonX+myPause_ButtonWidth) && (mouseY > myPause_ButtonY && mouseY < myPause_ButtonY+myPause_ButtonHeight)) {
					Send "{Alt down}{P}"
					myPauseButton.Destroy()
					Send "{Alt up}"
				}	
			
			
			
				; Toggle HUD color (F4) 


			

				; de-clutter HUD (QWERTY: V / QWERTZ: V / AZERTY: V)
				myDeClutter_ButtonX := 845
				myDeClutter_ButtonY := 488
				myDeClutter_ButtonWidth := 28
				myDeClutter_ButtonHeight := 29
				if ((mouseX > myDeClutter_ButtonX && mouseX < myDeClutter_ButtonX+myDeClutter_ButtonWidth) && (mouseY > myDeClutter_ButtonY && mouseY < myDeClutter_ButtonY+myDeClutter_ButtonHeight)) {
					Send "{v}"
					myDeClutterButton.Destroy()
				}	


				
			
				; Sets Maximum Power (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myMaximumPower_ButtonX := 262
				myMaximumPower_ButtonY := 560
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
					myMaximumPowerButton.Destroy()
					Send "{Shift up}"
				}	
			
				; Increases Throttle (QWERTY: = / QWERTZ: ´ / AZERTY: =)
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myIncreaseThrottle_ButtonX := 262
				myIncreaseThrottle_ButtonY := 622
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
					myIncreaseThrottleButton.Destroy()
				}	
			
				; 50% Power (detects the current speed and changes it accordingly)
				; There is room on the left side of the left MFD
				
			
				; Decreases Throttle (QWERTY: - / QWERTZ: ß / AZERTY: ))
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myDecreaseThrottle_ButtonX := 262
				myDecreaseThrottle_ButtonY := 733
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
					myDecreaseThrottleButton.Destroy()
				}	
		
				; No Power (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
				; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
				myNoPower_ButtonX := 262
				myNoPower_ButtonY := 795
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
					myNoPowerButton.Destroy()
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


	










































	
