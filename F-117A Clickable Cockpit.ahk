
/*

----------------------------------------------------------------------------
	"F-117A Clickable Cockpit" by xan2622:
	version 1.4.0
	Released under the GPL 3.0 license
---------------------------------------------------------------------------- 
	This Autohotkey (v2) script is meant to be used alongside the game F-117A Nighthawk Stealth Fighter 2.0 
	It allows to click on the cockpit buttons with the mouse cursor.
----------------------------------------------------------------------------
	The INFO.txt file has several purposes: 
	- To give you informations about this "F-117A Clickable Cockpit" AutoHotKey v2 script.
	- It is also used as a workaround to check the current active keyboard layout, as I haven't managed to get it from the DOSBox window nor the OS itself yet. 
	You may now close this Notepad window (or read further informations bellow). The AHK script only needed the Notepad window to be opened only once. 
----------------------------------------------------------------------------
	TIPS (how to use this script): 
	- This script works best once you are already on the airport runway.
	- The first time the script is launched, you should see several colored overlays over cockpit buttons. 
	  These overlays will disappear as soon as you click on buttons or if you press CTRL + SHIFT + ENTER
	- If you want to see the colored overlays once more, just relaunch the AHK script or press CTRL + SHIFT + ENTER.
	- Limitation: the first time you click on overlays, it won't trigger hotkeys, click one more time on the cockpit button to simulate the hotkey.
----------------------------------------------------------------------------
 	Here are the supported (clickable) buttons: 
		Chaff, Flare, Decoy, ECM, IRJ, 
		MAP/TAC, MFD Zoom in, MFD Zoom out,
		Select Weapon, NAV/AIR/GND, ILS, Cockpit View, HUD de-clutter, 
		Maximum Power, Increase Power, Decrease Power, No Power, 
		Tracking CAM Ahead, Tracking CAM Rear, Tracking CAM Right, Tracking CAM Left,
		Accelerate, Normal Speed, Pause, 		
		New Target, Select Target, 
		WAY, WPN, GRD, FLIR, BAY, AUTO, GEAR, FLAPS, BRAKE, 
		Eject (you need to press the button for 2 seconds to activate it), 

	For convenience: 
	- it's also possible to use the mouse wheel over the left MFD to zoom in/out
	- WASD keys mimic the directionnal arrow keys
	- pressing "E" fires missiles (mimicking the Enter key)
	- clicking on the wide bar below the right MFD circles between Tracking CAM Ahead / CAM Rear / CAM Right / CAM Left
	- there's a button on the left MFD that sets the throttle to 50% power
----------------------------------------------------------------------------
 	BUGS:
	- I found two ways to implement tooltips: with buttons or with half-transparent (yellow.png) pictures. 
	  The drawback with buttons is that they less reactive than clicking on pictures. As a result, for the moment, the script still uses (yellow.png) pictures for overlays.
	- Can't seem to reassign the Q key (A on AZERTY keyboards) to "open bay"
	- The fake cursor is misplaced if the script is directly launched by double-clicking on the .ahk file (but is fine if the script is launched from Notepad++)
	- Sometimes, clicking on NAV/AIR/GND and MAP/TAC (and probably other buttons) makes these buttons flicker
	- Sometimes clicking on DecreaseThrottle makes it react like MaximumPower (could the culpit be "SetKeyDelay(20, 10)"?)
	- While using a QWERTY keyboard and clicking on the 4 buttons at the left side of the right MFD, it makes the CAM Views interfere with the From-the-Cockpit-Viewing hotkeys
	- 2 of the 3 buttons below the right MFD (Accel, Normal speed, Pause) interfere with the left MFD Zoom in/out
---------------------------------------------------------------------------- 
	TODO (& ideas): 
	- DONE (needs more tests): detect the user keyboard layout (QWERTY, QWERTZ, AZERTY) and change hotkeys accordingly
	- Test the script on other computers (other DOSBox and screen resolutions...)
	- Add hotkeys on tooltips (making sure to display the hotkeys corresponding to the current keyboard layout (QWERTY, QWERTZ, AZERTY))
	- Make sure the script also works with DosBox-X (which by default displays the Windows mouse cursor but I have to make sure the image aspect ratio matches the DosBox one)
	- Replace overlays with modded cockpit buttons (ie: highlighted when hovered) ?
	- Add an option in the script to enable "mouse movements": make the aircraft follow mouse mouvements if those occur over the HUD ?
	- Reorganize some buttons (based on feedback, if any)
	- Make an alternative AHK script to detect cockpit buttons with ImageSearch (slower) instead of hardcoding them with absolute positions ?
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
----------------------------------------------------------------------------
	
*/











	#Requires AutoHotkey v2 ; Makes the script only usable by AutoHotKey 2
	#SingleInstance Force ; Replaces the current AHK script if it is launched once more
	SetKeyDelay(20, 10) ; Delay between keypresses



	

	; #Include "CheckDOSBoxWindowResolution.ahk"
	#Include "DPIsupport.ahk"
	#Include "KeyboardDetection.ahk"
	#Include "MoveDOSBoxWindow.ahk"
	; #Include "CheckIfOnRunway.ahk"




	
	CoordMode("Pixel", "Screen")
	CoordMode("Mouse", "Screen")

	CounterMouseOver := 0

	Loop {

		If WinExist("ahk_exe DOSBox.exe") {	
		
			MouseGetPos(&mouseX, &mouseY)
			WinGetPos(&windowX, &windowY, &windowW, &windowH, "ahk_exe DOSBox.exe")
			If (mouseX > windowX && mouseX < windowX + windowW && mouseY > windowY && mouseY < windowY + windowH) {
				; MsgBox("The cursor is in the GUI!")
				
				CounterMouseOver++
				If (CounterMouseOver = 1) {
					
					; Buttons as Overlays:
						; #Include "Overlays2.ahk"
						; #Include "Hotkeys2.ahk"
						; #Include "Tooltips2.ahk"	
					
					; Pictures as Overlays:
						 #Include "Overlays.ahk"
						 #Include "Hotkeys.ahk"
						 #Include "Tooltips.ahk"
					
					#Include "MouseCursor.ahk"
				
				}				
			
			} else {
				SystemCursor("Show") ; Shows the system cursor if mouse cursor is not hovering the DOSBox window
				; myCustomCursorGui.Hide() ; Hides the custom cursor (cursor.png)
				; MsgBox("Mouse is out of DOSBox window ")
				
			}
		} else {
			; MsgBox("DOSBox window doesn't exist")		
		}
	}
		Sleep(100)
	





















