/*

----------------------------------------------------------------------------------------

	"F-117A Clickable Cockpit" by xan2622
	version 1.00
	Released under the GPL 3.0 license

----------------------------------------------------------------------------------------
 
	This Autohotkey (v2) script is meant to be used alongside the game F-117A Nighthawk Stealth Fighter 2.0
	It allows to click on the cockpit buttons with the mouse cursor
 
----------------------------------------------------------------------------------------
 
	Here are the supported (clickable) buttons: 
	Select Weapon, NAV/AIR/GND, HUD de-clutter, ILS, 
	Chaff, Flare, Decoy, ECM, IRJ, 
	MAP/TAC, MFD Zoom in, MFD Zoom out,
	WAY, WPN, GRD, FLIR, BAY, AUTO, GEAR, FLAPS, BRAKE, Eject, 
	Accelerate, Normal Speed, Pause, 
	Maximum Power, Increase Power, Decrease Power, No Power, 
	New Target, Select Target, 
	CAM Ahead, CAM Rear, CAM Right, CAM Left
	
 
	It's also possible to use the mouse wheel over the MFD to zoom in/out 
	For convenience, WASD keys mimic the directionnal arrow keys.

----------------------------------------------------------------------------------------
 
	BUGS:
	- the user needs to click twice on cockpit buttons: once to hide the (half transparent) yellow overlay and one more time to effectively turn on/off the cockpit button
	- the overlays need to be clicked on once to get rid of them, then it's possible to effectively click on the Cockpit button
	- sometimes, clicking on NAV/AIR/GND and MAP/TAC makes these buttons flicker
	- fix IR Jammer hotkey with french keyboard layout
	
	
 ----------------------------------------------------------------------------------------
 
	TODO: 
	- detect the user keyboard layout (QWERTY, QWERTZ, AZERTY..) and change hotkeys accordingly
	- add tooltips over cockpit buttons
	- make the yellow overlays follow the DosBox window if it's moved over the Windows desktop https://www.autohotkey.com/boards/viewtopic.php?t=55113	
	- make sure the script also work with DosBox-X (which by default displays the Windows mouse cursor but I have to make sure the image aspect ratio matches the DosBox one)
	- Display areas/buttons with 75 opacity the first time, then if clicked, show them with 1 opacity (a workaround to display the mouse cursor)
	- controversial (?): add buttons around the MFDs (by displaying images, not there in the original game) in order to group similar actions together
	- Detect cockpit buttons with ImageSearch (slower) instead of hardcoding them with absolute positions
	- add (convenient) extra buttons that are not in the original game: 50% Power (there's one free MFD button on the left MFD)
	
	
	
---------------------------------------------------------------------------------------- 
 
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


----------------------------------------------------------------------------------------
	
*/









; Replaces the current AHK script if it is launched once more
#SingleInstance Force

; Delay between keypresses
SetKeyDelay(0, 10)	





; DPI support: https://www.autohotkey.com/boards/viewtopic.php?f=96&t=121040
; This library must be in the same folder than this aHK script 
#include DPI.ahk

; Gets the DPI for the specified window
	WinGetDpi(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?) {
    return (hMonitor := DllCall("MonitorFromWindow", "ptr", WinExist(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?), "int", 2, "ptr") ; MONITOR_DEFAULTTONEAREST
    , DllCall("Shcore.dll\GetDpiForMonitor", "ptr", hMonitor, "int", 0, "uint*", &dpiX:=0, "uint*", &dpiY:=0), dpiX)
}





; Get the DOSBox/DOSBox-X position and dimensions
if WinExist("ahk_exe dosbox.exe") or WinExist("ahk_exe dosbox-x.exe")
	{
		WinActivate
		WinGetPos &DOSBox_WindowX, &DOSBox_WindowY , &DOSBox_WindowW, &DOSBox_WindowH, "DOSBox"
		WinGetClientPos &DOSBox_WindowClientX, &DOSBox_WindowClientY , &DOSBox_WindowClientW, &DOSBox_WindowClientH, "DOSBox"
		; MsgBox "DOSBox is at " DOSBox_WindowX "," DOSBox_WindowY " and its size is " DOSBox_WindowW "x" DOSBox_WindowH
		; MsgBox "DOSBox is at " DOSBox_WindowClientX "," DOSBox_WindowClientY " and its client size is " DOSBox_WindowClientW "x" DOSBox_WindowClientH

		; Moves the DosBox/DosBox-X window to 0,0 (the following line can be commented if you prefer to move the window somewhere else)
		WinMove 0, 0, ,, "DOSBox"
		
	}





; The idea would be to enable the script only when DOSBox is active (focussed)
; buggy: makes clicking buttons possible only after clicking on the DosBox Window once
; #HotIf WinActive("DOSBox")

	
	

	
/* ; ------------------------------------
		WIP CODE 




; Detect keyboard layout 
; Related:  https://www.autohotkey.com/boards/viewtopic.php?t=75421
; See also: https://www.autohotkey.com/boards/viewtopic.php?t=63062
;  
; de-DE: Germany = 0x4070407
; en-US: United States = 0x4090409
; fr=FR: French = 0x40C0409
; 
; https://en.wikipedia.org/wiki/AZERTY
; https://en.wikipedia.org/wiki/QWERTY
; https://en.wikipedia.org/wiki/QWERTZ



q::
{ 
	Focused := ControlGetClassNN(ControlGetFocus("A"))
	CtrlID := ControlGetHwnd(Focused, "A")
	ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", CtrlID, "Ptr", 0)
	InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "Ptr")
	ToolTip(Format("0x{:X}",InputLocaleID))
	Return
} 



; QWERTY (Germany, USA, 
if InputLocaleID := 0x4070407 or InputLocaleID := 0x4090409
{
	MsgBox "(The current keyboard layout is de-DE)"
	ExitApp
}


; QWERTZ (
if InputLocaleID := 
{
	MsgBox "(The current keyboard layout is )"
	ExitApp
}


; AZERTY (France)
if InputLocaleID := 0x40C0409
{
	MsgBox "(The current keyboard layout is fr-FR)"
	ExitApp
}

*/ ; ------------------------------------
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	; --------------------------------------------------
	; Displays rectangles (highlight buttons) over the game window and allows to see the mouse cursor 

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



		
		; Displays an area over the MAPTAC MFD for MouseWheel Zoom In (W)
		myMFDZoomInMouseWheel := Gui()
		myMFDZoomInMouseWheel.BackColor := "Yellow"
		myMFDZoomInMouseWheel.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomInMouseWheel
		myMFDZoomInMouseWheel.Show("x298 y560 w308 h288")
		
		; Displays an area over the MAPTAC MFD for MouseWheel Zoom Out (X)
		myMFDZoomOutMouseWheel := Gui()
		myMFDZoomOutMouseWheel.BackColor := "Yellow"
		myMFDZoomOutMouseWheel.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomOutMouseWheel
		myMFDZoomOutMouseWheel.Show("x298 y560 w308 h288")
		
		
		
		
		; Displays a wide MAPTAC button (F3)
		myMFDButton := Gui()
		myMFDButton.BackColor := "Yellow"
		myMFDButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDButton
		myMFDButton.Show("x322 y862 w156 h44")	
		
		; Displays a MFD Zoom In button (W)
		myMFDZoomInButton := Gui()
		myMFDZoomInButton.BackColor := "Yellow"
		myMFDZoomInButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomInButton
		myMFDZoomInButton.Show("x514 y867 w28 h29")	
		
		; Displays a MFD Zoom Out button (X)
		myMFDZoomOutButton := Gui()
		myMFDZoomOutButton.BackColor := "Yellow"
		myMFDZoomOutButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMFDZoomOutButton
		myMFDZoomOutButton.Show("x562 y867 w28 h29")	




		; Displays a CHAFF button (2)
		myChaffButton := Gui()
		myChaffButton.BackColor := "Yellow"
		myChaffButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myChaffButton
		myChaffButton.Show("x14 y742 w104 h44")	

		; Displays a FLARE button (1)
		myFlareButton := Gui()
		myFlareButton.BackColor := "Yellow"
		myFlareButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myFlareButton
		myFlareButton.Show("x14 y790 w104 h44")

		; Displays a DECOY button (5)
		myDecoyButton := Gui()
		myDecoyButton.BackColor := "Yellow"
		myDecoyButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myDecoyButton
		myDecoyButton.Show("x14 y838 w104 h44")	

		; Displays a ECM button (4)
		myECMButton := Gui()
		myECMButton.BackColor := "Yellow"
		myECMButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myECMButton
		myECMButton.Show("x18 y891 w116 h43")		

		; Displays a IR Jammer button (3)
		myIRJammerButton := Gui()
		myIRJammerButton.BackColor := "Yellow"
		myIRJammerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myIRJammerButton
		myIRJammerButton.Show("x146 y891 w116 h43")	




		; Select WEAPON (SPACE)
		; the screw at the left of the NAV button 
		mySelectWeaponButton := Gui()
		mySelectWeaponButton.BackColor := "Yellow"
		mySelectWeaponButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, mySelectWeaponButton
		mySelectWeaponButton.Show("x414 y483 w44 h48")

		; Displays a wide NAVAIRGND button (F2)
		myNavAirGndButton := Gui()
		myNavAirGndButton.BackColor := "Yellow"
		myNavAirGndButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNavAirGndButton
		myNavAirGndButton.Show("x478 y483 w235 h43")
	
		; Toggle ILS on/off (F9)
		; the fully visible MFD button at the top of the right MFD 
		myILSButton := Gui()
		myILSButton.BackColor := "Yellow"
		myILSButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myILSButton
		myILSButton.Show("x922 y526 w24 h29")	
	



		; Displays a BAY button (8)
		myBayButton := Gui()
		myBayButton.BackColor := "Yellow"
		myBayButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myBayButton
		myBayButton.Show("x1029 y526 w104 h44")

		; Displays an AUTOPILOT button (7)
		myAutopilotButton := Gui()
		myAutopilotButton.BackColor := "Yellow"
		myAutopilotButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myAutopilotButton
		myAutopilotButton.Show("x1029 y574 w104 h44")

		; Displays a GEAR button (6)
		myGearButton := Gui()
		myGearButton.BackColor := "Yellow"
		myGearButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myGearButton
		myGearButton.Show("x1029 y622 w104 h44")

		; Displays a FLAPS button (9)
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




		; Select WAYPOINT Blue MFD (F7)
		myWaypointButton := Gui()
		myWaypointButton.BackColor := "Yellow"
		myWaypointButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myWaypointButton
		myWaypointButton.Show("x681 y901 w76 h43")
		
		; Show Ordnance (F5)
		myOrdnanceButton := Gui()
		myOrdnanceButton.BackColor := "Yellow"
		myOrdnanceButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myOrdnanceButton
		myOrdnanceButton.Show("x761 y901 w76 h43")
		
		; Show Objectives MFD (F10)
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

		
		; FLIR (F6)
		myFlirButton := Gui()
		myFlirButton.BackColor := "Yellow"
		myFlirButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myFlirButton
		myFlirButton.Show("x929 y915 w72 h43")

		
		
		
		; EJECT BUTTON (SHIFT F10)
		; the yellow and black stripes plate located on the right side
		myEjectButton := Gui()
		myEjectButton.BackColor := "Yellow"
		myEjectButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myEjectButton
		myEjectButton.Show("x1233 y685 w40 h187")




		; Designate New Target (N)
		; the 4th button at the bottom right side of the right MFD
		myNewTargetButton := Gui()
		myNewTargetButton.BackColor := "Yellow"
		myNewTargetButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNewTargetButton
		myNewTargetButton.Show("x997 y738 w24 h29")
				
		; Select Target (B)	
		; the 5th button at the bottom right side of the right MFD
		mySelectTargetButton := Gui()
		mySelectTargetButton.BackColor := "Yellow"
		mySelectTargetButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, mySelectTargetButton
		mySelectTargetButton.Show("x997 y790 w24 h29")
		
		

		
		; change cockpit view (C)


		
		
		; CAM Ahead !
		; QWERTY /
		; 1st MFD button from the top on the left side of the right MFD
		myCAMAheadButton := Gui()
		myCAMAheadButton.BackColor := "Yellow"
		myCAMAheadButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMAheadButton
		myCAMAheadButton.Show("x645 y570 w24 h28")
		
		; CAM Rear :
		; QWERTY >
		; 2nd MFD button from the top on the left side of the right MFD
		myCAMRearButton := Gui()
		myCAMRearButton.BackColor := "Yellow"
		myCAMRearButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMRearButton
		myCAMRearButton.Show("x645 y622 w24 h29")
				
		; CAM Right ;
		; QWERTY <
		; 3rd MFD button from the top on the left side of the right MFD
		myCAMRightButton := Gui()
		myCAMRightButton.BackColor := "Yellow"
		myCAMRightButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMRightButton
		myCAMRightButton.Show("x645 y675 w24 h29")

		; CAM left ,
		; QWERTY M
		; 4th MFD button from the top on the left side of the right MFD
		myCAMLeftButton := Gui()
		myCAMLeftButton.BackColor := "Yellow"
		myCAMLeftButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myCAMLeftButton
		myCAMLeftButton.Show("x645 y738 w24 h28")
		
		
		
		
		; Volume adjust (Alt V)
		
		
	
		
		; Accelerate (SHIFT W) 
		; the left button at the bottom of the right MFD
		myAccelerateButton := Gui()
		myAccelerateButton.BackColor := "Yellow"
		myAccelerateButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myAccelerateButton
		myAccelerateButton.Show("x829 y858 w24 h28")

		; Normal Speed (SHIFT X)
		; the middle button at the bottom of the right MFD
		myNormalSpeedButton := Gui()
		myNormalSpeedButton.BackColor := "Yellow"
		myNormalSpeedButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNormalSpeedButton
		myNormalSpeedButton.Show("x873 y858 w24 h28")
		
		; Pause (ALT P)	
		; the right button at the bottom of the right MFD
		myPauseButton := Gui()
		myPauseButton.BackColor := "Yellow"
		myPauseButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myPauseButton
		myPauseButton.Show("x921 y858 w24 h28")
		
	
		
		
		; Toggle HUD color (F4) 
		
		
		
		
		; de-clutter HUD (V)
		; the rounded button located on the right side of LOCK button
		myDeClutterButton := Gui()
		myDeClutterButton.BackColor := "Yellow"
		myDeClutterButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myDeClutterButton
		myDeClutterButton.Show("x845 y488 w28 h29")		
		
		
		
		
		; Maximum Power (Shift =)
		myMaximumPowerButton := Gui()
		myMaximumPowerButton.BackColor := "Yellow"
		myMaximumPowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myMaximumPowerButton
		myMaximumPowerButton.Show("x262 y560 w24 h29")
		
		; Increase Power (=)
		myIncreasePowerButton := Gui()
		myIncreasePowerButton.BackColor := "Yellow"
		myIncreasePowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myIncreasePowerButton
		myIncreasePowerButton.Show("x262 y622 w24 h29")
		
		; 50% Power (detects the current speed and changes it accordingly)
		; There is room on the left side of the left MFD
			
		
		; Decrease Power (-)
		myDecreasePowerButton := Gui()
		myDecreasePowerButton.BackColor := "Yellow"
		myDecreasePowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myDecreasePowerButton
		myDecreasePowerButton.Show("x262 y733 w24 h29")
		
		; No Power (Shift -)
		myNoPowerButton := Gui()
		myNoPowerButton.BackColor := "Yellow"
		myNoPowerButton.Opt("+AlwaysOnTop -Caption +ToolWindow")
		WinSetTransparent 75, myNoPowerButton
		myNoPowerButton.Show("x262 y795 w24 h29")
		
		
		
		
		; Resupply (training) (ALT R)
	




























; **************************************************

; MouseScrollUp MAPTAC Zoom In (W)
WheelUp::
	{
		; https://www.autohotkey.com/docs/v2/lib/CoordMode.htm
		; RelativeTo: 	Screen Window Client 
		CoordMode("Pixel", "Screen") ; Pixel: Affects PixelGetColor, PixelSearch, and ImageSearch.
		CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, a
		
		MouseGetPos(&mouseX, &mouseY)
		
		; Zooms the MAPTAC MFD in (W)
		myMFDZoomInMouseWheel_AreaX := 298
		myMFDZoomInMouseWheel_AreaY := 560
		myMFDZoomInMouseWheel_AreaWidth := 308
		myMFDZoomInMouseWheel_AreaHeight := 288
		if ((mouseX > myMFDZoomInMouseWheel_AreaX && mouseX < myMFDZoomInMouseWheel_AreaX+myMFDZoomInMouseWheel_AreaWidth) && (mouseY > myMFDZoomInMouseWheel_AreaY && mouseY < myMFDZoomInMouseWheel_AreaY+myMFDZoomInMouseWheel_AreaHeight)) {
			SetKeyDelay(0, 10)
			Send "{w}"
			
			; Return 				
			; SoundBeep 750, 200
			; Sleep 500
			myMFDZoomInMouseWheel.Destroy()
			; ExitApp
		}	
	}

; MouseScrollDown MAPTAC Zoom Out (X)
WheelDown::
	{
		; https://www.autohotkey.com/docs/v2/lib/CoordMode.htm
		; RelativeTo: 	Screen Window Client 
		CoordMode("Pixel", "Screen") ; Pixel: Affects PixelGetColor, PixelSearch, and ImageSearch.
		CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, a
		
		MouseGetPos(&mouseX, &mouseY)
		
		; Zooms the MAPTAC MFD out (X)
		myMFDZoomOutMouseWheel_AreaX := 298
		myMFDZoomOutMouseWheel_AreaY := 560
		myMFDZoomOutMouseWheel_AreaWidth := 308
		myMFDZoomOutMouseWheel_AreaHeight := 288
		if ((mouseX > myMFDZoomOutMouseWheel_AreaX && mouseX < myMFDZoomOutMouseWheel_AreaX+myMFDZoomOutMouseWheel_AreaWidth) && (mouseY > myMFDZoomOutMouseWheel_AreaY && mouseY < myMFDZoomOutMouseWheel_AreaY+myMFDZoomOutMouseWheel_AreaHeight)) {
			SetKeyDelay(0, 10)
			Send "{x}"
			
			; Return 
			; SoundBeep 750, 200
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
		CoordMode("Mouse", "Screen") ; Mouse: Affects MouseGetPos, Click, MouseMove, MouseClick, a
		
		MouseGetPos(&mouseX, &mouseY)
		
		
		; Clickable areas (buttons) 

		/* 
			; Clickable Button: The Whole DosBox window
			ButtonX := 3 
			ButtonY := 15 
			Width   := 1025 
			Height  := 960 
			if ((mouseX > ButtonX && mouseX < ButtonX+Width) && (mouseY > ButtonY && mouseY < ButtonY+Height)) {
				myDosBoxWindow.Destroy()
				ExitApp
			}				
		*/				
			
			
			
			
	
			; Toggles the MAPTAC MFD mode (F3)
			myMFD_ButtonX := 322
			myMFD_ButtonY := 862
			myMFD_ButtonWidth := 156
			myMFD_ButtonHeight := 44
			if ((mouseX > myMFD_ButtonX && mouseX < myMFD_ButtonX+myMFD_ButtonWidth) && (mouseY > myMFD_ButtonY && mouseY < myMFD_ButtonY+myMFD_ButtonHeight)) {
				Send "{F3}"
				myMFDButton.Destroy()
			}			
			
			; Enables MFD Zoom in (W)
			myMFDZoomIn_ButtonX := 514
			myMFDZoomIn_ButtonY := 867 
			myMFDZoomIn_ButtonWidth := 28
			myMFDZoomIn_ButtonHeight := 29
			if ((mouseX > myMFDZoomIn_ButtonX && mouseX < myMFDZoomIn_ButtonX+myMFDZoomIn_ButtonWidth) && (mouseY > myMFDZoomIn_ButtonY && mouseY < myMFDZoomIn_ButtonY+myMFDZoomIn_ButtonHeight)) {
				Send "{w}"			; This needs to be Z on QWERTY keyboards 
				myMFDZoomInButton.Destroy()
			}				
				
			; Enables MFD Zoom out (X)
			myMFDZoomOut_ButtonX := 562
			myMFDZoomOut_ButtonY := 867 
			myMFDZoomOut_ButtonWidth := 28
			myMFDZoomOut_ButtonHeight := 29
			if ((mouseX > myMFDZoomOut_ButtonX && mouseX < myMFDZoomOut_ButtonX+myMFDZoomOut_ButtonWidth) && (mouseY > myMFDZoomOut_ButtonY && mouseY < myMFDZoomOut_ButtonY+myMFDZoomOut_ButtonHeight)) {
				Send "{x}"
				myMFDZoomOutButton.Destroy()
			}
			
			

			
			; Releases a Chaff (2)
			myChaff_ButtonX := 14
			myChaff_ButtonY := 742
			myChaff_ButtonWidth := 104
			myChaff_ButtonHeight := 44
			if ((mouseX > myChaff_ButtonX && mouseX < myChaff_ButtonX+myChaff_ButtonWidth) && (mouseY > myChaff_ButtonY && mouseY < myChaff_ButtonY+myChaff_ButtonHeight)) {
				Send "{é}"
				myChaffButton.Destroy()
			}				
			
			; Releases a Flare (1)
			myFlare_ButtonX := 14
			myFlare_ButtonY := 790
			myFlare_ButtonWidth := 104
			myFlare_ButtonHeight := 44
			if ((mouseX > myFlare_ButtonX && mouseX < myFlare_ButtonX+myFlare_ButtonWidth) && (mouseY > myFlare_ButtonY && mouseY < myFlare_ButtonY+myFlare_ButtonHeight)) {
				Send "{&}"
				myFlareButton.Destroy()	
			}
			
			; Releases a Decoy (5)
			myDecoy_ButtonX := 14
			myDecoy_ButtonY := 838
			myDecoy_ButtonWidth := 104
			myDecoy_ButtonHeight := 44
			if ((mouseX > myDecoy_ButtonX && mouseX < myDecoy_ButtonX+myDecoy_ButtonWidth) && (mouseY > myDecoy_ButtonY && mouseY < myDecoy_ButtonY+myDecoy_ButtonHeight)) {
				Send "{(}"
				myDecoyButton.Destroy()
			}				
			
			; Toggles ECM on/off (4)
			myECM_ButtonX := 18
			myECM_ButtonY := 891
			myECM_ButtonWidth := 116
			myECM_ButtonHeight := 43
			if ((mouseX > myECM_ButtonX && mouseX < myECM_ButtonX+myECM_ButtonWidth) && (mouseY > myECM_ButtonY && mouseY < myECM_ButtonY+myECM_ButtonHeight)) {
				Send "{'}"
				myECMButton.Destroy()
			}		
			
			; Toggles IR Jammer on/off (3)
			myIRJammer_ButtonX := 146
			myIRJammer_ButtonY := 891
			myIRJammer_ButtonWidth := 116
			myIRJammer_ButtonHeight := 43
			if ((mouseX > myIRJammer_ButtonX && mouseX < myIRJammer_ButtonX+myIRJammer_ButtonWidth) && (mouseY > myIRJammer_ButtonY && mouseY < myIRJammer_ButtonY+myIRJammer_ButtonHeight)) {

				; Send "{Raw}{"}"	; I need to find a workaround for this hotkey

				myIRJammerButton.Destroy()
			}		
		
	


			; Select WEAPON (SPACE)
			mySelectWeapon_ButtonX := 414
			mySelectWeapon_ButtonY := 483
			mySelectWeapon_ButtonWidth := 44
			mySelectWeapon_ButtonHeight := 48
			if ((mouseX > mySelectWeapon_ButtonX && mouseX < mySelectWeapon_ButtonX+mySelectWeapon_ButtonWidth) && (mouseY > mySelectWeapon_ButtonY && mouseY < mySelectWeapon_ButtonY+mySelectWeapon_ButtonHeight)) {
				Send "{Space}"
				mySelectWeaponButton.Destroy()
			}

			; Toggle NAV AIR GND buttons (F2)
			myNavAirGnd_ButtonX := 478
			myNavAirGnd_ButtonY := 483
			myNavAirGnd_ButtonWidth := 235
			myNavAirGnd_ButtonHeight := 43
			if ((mouseX > myNavAirGnd_ButtonX && mouseX < myNavAirGnd_ButtonX+myNavAirGnd_ButtonWidth) && (mouseY > myNavAirGnd_ButtonY && mouseY < myNavAirGnd_ButtonY+myNavAirGnd_ButtonHeight)) {
				Send "{F2}"
				myNavAirGndButton.Destroy()
			}			
			
			; Toggle ILS on/off (F9)
			myILS_ButtonX := 922
			myILS_ButtonY := 526
			myILS_ButtonWidth := 24
			myILS_ButtonHeight := 29
			if ((mouseX > myILS_ButtonX && mouseX < myILS_ButtonX+myILS_ButtonWidth) && (mouseY > myILS_ButtonY && mouseY < myILS_ButtonY+myILS_ButtonHeight)) {
				Send "{F9}"
				myILSButton.Destroy()
			}
			
			
	
		
			; Turns BAY on/off (8)
			myBay_ButtonX := 1029
			myBay_ButtonY := 526
			myBay_ButtonWidth := 104
			myBay_ButtonHeight := 44
			if ((mouseX > myBay_ButtonX && mouseX < myBay_ButtonX+myBay_ButtonWidth) && (mouseY > myBay_ButtonY && mouseY < myBay_ButtonY+myBay_ButtonHeight)) {
				Send "{_}"
				myBayButton.Destroy()
			}			
			
			; Turns AUTOPILOT nn/off (7)
			myAutopilot_ButtonX := 1029
			myAutopilot_ButtonY := 574
			myAutopilot_ButtonWidth := 104
			myAutopilot_ButtonHeight := 44
			if ((mouseX > myAutopilot_ButtonX && mouseX < myAutopilot_ButtonX+myAutopilot_ButtonWidth) && (mouseY > myAutopilot_ButtonY && mouseY < myAutopilot_ButtonY+myAutopilot_ButtonHeight)) {
				Send "{è}"
				myAutopilotButton.Destroy()
			}			

			; Turns GEAR Button on/off (6)
			myGear_ButtonX := 1029
			myGear_ButtonY := 622
			myGear_ButtonWidth := 104
			myGear_ButtonHeight := 44
			if ((mouseX > myGear_ButtonX && mouseX < myGear_ButtonX+myGear_ButtonWidth) && (mouseY > myGear_ButtonY && mouseY < myGear_ButtonY+myGear_ButtonHeight)) {
				Send "{-}"
				myGearButton.Destroy()
			}		
	
			; Turns FLAPS on/off (9)
			myFlaps_ButtonX := 1137
			myFlaps_ButtonY := 574
			myFlaps_ButtonWidth := 104
			myFlaps_ButtonHeight := 44
			if ((mouseX > myFlaps_ButtonX && mouseX < myFlaps_ButtonX+myFlaps_ButtonWidth) && (mouseY > myFlaps_ButtonY && mouseY < myFlaps_ButtonY+myFlaps_ButtonHeight)) {
				Send "{ç}"
				myFlapsButton.Destroy()
			}	
			
			; Turns BRAKE on/off (0)
			myBrake_ButtonX := 1137
			myBrake_ButtonY := 622
			myBrake_ButtonWidth := 104
			myBrake_ButtonHeight := 44
			if ((mouseX > myBrake_ButtonX && mouseX < myBrake_ButtonX+myBrake_ButtonWidth) && (mouseY > myBrake_ButtonY && mouseY < myBrake_ButtonY+myBrake_ButtonHeight)) {
				Send "{à}"
				myBrakeButton.Destroy()
			}	
	
	
			
			
			; Select WAYPOINT Blue MFD (F7)
			myWaypoint_ButtonX := 681
			myWaypoint_ButtonY := 901
			myWaypoint_ButtonWidth := 76
			myWaypoint_ButtonHeight := 43
			if ((mouseX > myWaypoint_ButtonX && mouseX < myWaypoint_ButtonX+myWaypoint_ButtonWidth) && (mouseY > myWaypoint_ButtonY && mouseY < myWaypoint_ButtonY+myWaypoint_ButtonHeight)) {
				Send "{F7}"
				myWaypointButton.Destroy()
			}	
			
			; Show Ordnance (F5)
			myOrdnance_ButtonX := 761
			myOrdnance_ButtonY := 901
			myOrdnance_ButtonWidth := 76
			myOrdnance_ButtonHeight := 43
			if ((mouseX > myOrdnance_ButtonX && mouseX < myOrdnance_ButtonX+myOrdnance_ButtonWidth) && (mouseY > myOrdnance_ButtonY && mouseY < myOrdnance_ButtonY+myOrdnance_ButtonHeight)) {
				Send "{F5}"
				myOrdnanceButton.Destroy()
			}	
		
			; Show Objectives MFD (F10)
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
		
		
			; FLIR (F6)
			myFlir_ButtonX := 929
			myFlir_ButtonY := 915
			myFlir_ButtonWidth := 72
			myFlir_ButtonHeight := 43
			if ((mouseX > myFlir_ButtonX && mouseX < myFlir_ButtonX+myFlir_ButtonWidth) && (mouseY > myFlir_ButtonY && mouseY < myFlir_ButtonY+myFlir_ButtonHeight)) {
				Send "{F6}"
				myFlirButton.Destroy()
			}
			
			
			
			
			; EJECT BUTTON (SHIFT F10)
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
		
		
		
		
			; Designate New Target (N)
			myNewTarget_ButtonX := 997
			myNewTarget_ButtonY := 738
			myNewTarget_ButtonWidth := 24
			myNewTarget_ButtonHeight := 29
			if ((mouseX > myNewTarget_ButtonX && mouseX < myNewTarget_ButtonX+myNewTarget_ButtonWidth) && (mouseY > myNewTarget_ButtonY && mouseY < myNewTarget_ButtonY+myNewTarget_ButtonHeight)) {
				Send "{n}"
				myNewTargetButton.Destroy()
			}	
			
			; Select Target (B)
			mySelectTarget_ButtonX := 997
			mySelectTarget_ButtonY := 790
			mySelectTarget_ButtonWidth := 24
			mySelectTarget_ButtonHeight := 29
			if ((mouseX > mySelectTarget_ButtonX && mouseX < mySelectTarget_ButtonX+mySelectTarget_ButtonWidth) && (mouseY > mySelectTarget_ButtonY && mouseY < mySelectTarget_ButtonY+mySelectTarget_ButtonHeight)) {
				Send "{b}"
				mySelectTargetButton.Destroy()
			}	
			
			
			
			
			; change cockpit view (C)
			
			
			
			
			
			; CAM Ahead !
			; QWERTY /
			myCAMAhead_ButtonX := 645
			myCAMAhead_ButtonY := 570
			myCAMAhead_ButtonWidth := 24
			myCAMAhead_ButtonHeight := 28
			if ((mouseX > myCAMAhead_ButtonX && mouseX < myCAMAhead_ButtonX+myCAMAhead_ButtonWidth) && (mouseY > myCAMAhead_ButtonY && mouseY < myCAMAhead_ButtonY+myCAMAhead_ButtonHeight)) {
				Send "{!}"
				myCAMAheadButton.Destroy()
			}			
			
			; CAM Rear :
			; QWERTY >			
			myCAMRear_ButtonX := 645
			myCAMRear_ButtonY := 622
			myCAMRear_ButtonWidth := 24
			myCAMRear_ButtonHeight := 29
			if ((mouseX > myCAMRear_ButtonX && mouseX < myCAMRear_ButtonX+myCAMRear_ButtonWidth) && (mouseY > myCAMRear_ButtonY && mouseY < myCAMRear_ButtonY+myCAMRear_ButtonHeight)) {
				Send "{:}"
				myCAMRearButton.Destroy()
			}
						
			; CAM Right ;
			; QWERTY <
			myCAMRight_ButtonX := 645
			myCAMRight_ButtonY := 675
			myCAMRight_ButtonWidth := 24
			myCAMRight_ButtonHeight := 29
			if ((mouseX > myCAMRight_ButtonX && mouseX < myCAMRight_ButtonX+myCAMRight_ButtonWidth) && (mouseY > myCAMRight_ButtonY && mouseY < myCAMRight_ButtonY+myCAMRight_ButtonHeight)) {
				Send "{;}"
				myCAMRightButton.Destroy()
			}
			
			; CAM left ,
			; QWERTY M
			myCAMLeft_ButtonX := 645
			myCAMLeft_ButtonY := 738
			myCAMLeft_ButtonWidth := 24
			myCAMLeft_ButtonHeight := 28
			if ((mouseX > myCAMLeft_ButtonX && mouseX < myCAMLeft_ButtonX+myCAMLeft_ButtonWidth) && (mouseY > myCAMLeft_ButtonY && mouseY < myCAMLeft_ButtonY+myCAMLeft_ButtonHeight)) {
				Send "{,}"
				myCAMLeftButton.Destroy()
			}
			
		
			
			
			; Volume adjust (Alt V)
			
			
			
			
			; accelerate (SHIFT W) 
			myAccelerate_ButtonX := 829
			myAccelerate_ButtonY := 858
			myAccelerate_ButtonWidth := 24
			myAccelerate_ButtonHeight := 25
			if ((mouseX > myAccelerate_ButtonX && mouseX < myAccelerate_ButtonX+myAccelerate_ButtonWidth) && (mouseY > myAccelerate_ButtonY && mouseY < myAccelerate_ButtonY+myAccelerate_ButtonHeight)) {
				Send "{Shift down}{W}"
				myAccelerateButton.Destroy()
				Send "{Shift up}"
			}	
		
			; Normal Speed (SHIFT X)
			myNormalSpeed_ButtonX := 873
			myNormalSpeed_ButtonY := 858
			myNormalSpeed_ButtonWidth := 24
			myNormalSpeed_ButtonHeight := 28
			if ((mouseX > myNormalSpeed_ButtonX && mouseX < myNormalSpeed_ButtonX+myNormalSpeed_ButtonWidth) && (mouseY > myNormalSpeed_ButtonY && mouseY < myNormalSpeed_ButtonY+myNormalSpeed_ButtonHeight)) {
				Send "{Shift down}{X}"
				myNormalSpeedButton.Destroy()
				Send "{Shift up}"
			}	

			; Pause (ALT P)
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


		

			; de-clutter HUD (V)
			myDeClutter_ButtonX := 845
			myDeClutter_ButtonY := 488
			myDeClutter_ButtonWidth := 28
			myDeClutter_ButtonHeight := 29
			if ((mouseX > myDeClutter_ButtonX && mouseX < myDeClutter_ButtonX+myDeClutter_ButtonWidth) && (mouseY > myDeClutter_ButtonY && mouseY < myDeClutter_ButtonY+myDeClutter_ButtonHeight)) {
				Send "{v}"
				myDeClutterButton.Destroy()
				Send "{Alt up}"
			}	


			
		
			; Maximum Power (Shift +)
			myMaximumPower_ButtonX := 262
			myMaximumPower_ButtonY := 560
			myMaximumPower_ButtonWidth := 24
			myMaximumPower_ButtonHeight := 29
			if ((mouseX > myMaximumPower_ButtonX && mouseX < myMaximumPower_ButtonX+myMaximumPower_ButtonWidth) && (mouseY > myMaximumPower_ButtonY && mouseY < myMaximumPower_ButtonY+myMaximumPower_ButtonHeight)) {
				Send "{Shift down}{=}"
				myMaximumPowerButton.Destroy()
				Send "{Shift up}"
			}	
		
			; Increase Power (=)
			myIncreasePower_ButtonX := 262
			myIncreasePower_ButtonY := 622
			myIncreasePower_ButtonWidth := 24
			myIncreasePower_ButtonHeight := 29
			if ((mouseX > myIncreasePower_ButtonX && mouseX < myIncreasePower_ButtonX+myIncreasePower_ButtonWidth) && (mouseY > myIncreasePower_ButtonY && mouseY < myIncreasePower_ButtonY+myIncreasePower_ButtonHeight)) {
				Send "{=}"
				myIncreasePowerButton.Destroy()
				Send "{Shift up}"
			}	
		
			; 50% Power (detects the current speed and changes it accordingly)
			; There is room on the left side of the left MFD
			
		
			; Decrease Power (-)
			myDecreasePower_ButtonX := 262
			myDecreasePower_ButtonY := 733
			myDecreasePower_ButtonWidth := 24
			myDecreasePower_ButtonHeight := 29
			if ((mouseX > myDecreasePower_ButtonX && mouseX < myDecreasePower_ButtonX+myDecreasePower_ButtonWidth) && (mouseY > myDecreasePower_ButtonY && mouseY < myDecreasePower_ButtonY+myDecreasePower_ButtonHeight)) {
				Send "{)}"
				myDecreasePowerButton.Destroy()
				Send "{Shift up}"
			}	
	
			; No Power (Shift -)
			myNoPower_ButtonX := 262
			myNoPower_ButtonY := 795
			myNoPower_ButtonWidth := 24
			myNoPower_ButtonHeight := 29
			if ((mouseX > myNoPower_ButtonX && mouseX < myNoPower_ButtonX+myNoPower_ButtonWidth) && (mouseY > myNoPower_ButtonY && mouseY < myNoPower_ButtonY+myNoPower_ButtonHeight)) {
				Send "{Shift down}{)}"
				myNoPowerButton.Destroy()
				Send "{Shift up}"
			}
			
			
			
		
			; Resupply (training) (ALT R)

















		
	}








































~RButton::
{
	ExitApp
}


















; Allows to use ZQSD keys (on an AZERTY keybord) for movements
; I need to find a way to detect the keyboard layout used in the system

~q:: Left
~z:: Up 
~s:: Down 
~d:: Right















	
