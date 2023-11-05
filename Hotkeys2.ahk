#Requires AutoHotkey v2










	; **************************************************
	; HOTKEYS
	; **************************************************

	; Global variables
	; ClickCounter: used by myExtraCAM	
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

	


	





	; Toggles the MAPTAC MFD mode (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
	myMAPTACButton_Click(*) 
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		Send "{F3}"
		WinSetTransparent 1, myMAPTACGui
	}
	
	; Enables MFD Zoom in (QWERTY: Z / QWERTZ: Y / AZERTY: W)
	myMFDZoomInButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{z}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{y}"
		} else {
			Send "{w}"
		}
		WinSetTransparent 1, myMFDZoomInGui
	}
	
	; Enables MFD Zoom out (QWERTY: X / QWERTZ: X / AZERTY: X)
	myMFDZoomOutButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		Send "{x}"
		WinSetTransparent 1, myMFDZoomOutGui
	}
	
	; Drops a Chaff (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
	myChaffButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{2}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{2}"
		} else {
			Send "{é}"
		}
		WinSetTransparent 1, myChaffGui
	}
	
	; Drops a Flare (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
	myFlareButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{1}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{1}"
		} else {
			Send "{&}"
		}
		WinSetTransparent 1, myFlareGui
	}
	
	; Drops a Decoy (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
	myDecoyButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{5}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{5}"
		} else {
			Send "{(}"
		}
		WinSetTransparent 1, myDecoyGui
	}
	
	; Toggles ECM on/off (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
	myECMButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{4}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{4}"
		} else {
			Send "{'}"
		}
		WinSetTransparent 1, myECMGui
	}
	
	; Toggles IR Jammer on/off (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
	myIRJammerButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{3}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{3}"
		} else {
			Send("`"")
		}
		WinSetTransparent 1, myIRJammerGui
	}
	
	; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
	mySelectWeaponButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		Send "{Space}"
		WinSetTransparent 1, mySelectWeaponGui
	}
	
	; Toggle NAV AIR GND buttons (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
	myNavAirGndButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		Send "{F2}"
		WinSetTransparent 1, myNavAirGndGui
	}

	; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
	; the fully visible MFD button at the top of the right MFD
	myILSButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		Send "{F9}"
		WinSetTransparent 1, myILSGui
	}

	; Turns BAY on/off (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
	myBayButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{8}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{8}"
		} else {
			Send "{_}"
		}
		WinSetTransparent 1, myBayGui
	}

	; Turns AUTOPILOT nn/off (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
	myAutopilotButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{7}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{7}"
		} else {
			Send "{è}"
		}				
		WinSetTransparent 1, myAutopilotGui
	}

	; Turns GEAR Button on/off (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
	myGearButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{6}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{6}"
		} else {
			Send "{-}"
		}		
		WinSetTransparent 1, myGearGui		
	}
	
	; Turns FLAPS on/off (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)			
	myFlapsButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{9}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{9}"
		} else {
			Send "{ç}"
		}
		WinSetTransparent 1, myFlapsGui
	}
	
	; Turns BRAKE on/off  (QWERTY: 0 / QWERTZ: 0 / AZERTY: à)
	myBrakeButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		if KeyboardLayout == "QWERTY" {
			Send "{0}"
		} else if KeyboardLayout == "QWERTZ" {
			Send "{0}"
		} else {
			Send "{à}"
		}
		WinSetTransparent 1, myBrakeGui
	}
	
	; Select Blue WAYPOINT on MFD (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)			
	myWaypointButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		Send "{F7}"
		WinSetTransparent 1, myWaypointGui
	}
	
	; Show Ordnance on MFD (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
	myOrdnanceButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}	
		Send "{F5}"
		WinSetTransparent 1, myOrdnanceGui		
	}
	
	; Show Objectives on MFD (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
	myObjectivesButton_Click(*)
	{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
		Send "{F10}"
		WinSetTransparent 1, myObjectivesGui		
	}
	
	

		; CHANGE WAYPOINT RED (F8)
		; RESET WAYPOINT (SHIFT F8)
		
		; LAST WaYPOINT (PgUp)
		; NEXT WaYPOINT (PgDn)
		
		; Move WAYPOINT UP (Up arrow or NumPad 8)
		; Move WAYPOINT Down (Down arrow or NumPad 2)

	
	
		; Enables FLIR on MFD (QWERTY: F6 / QWERTZ: F6 / AZERTY: F6)
		myFlirButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			Send "{F6}"
			WinSetTransparent 1, myFlirGui			
		}	
		
		; Activates the EJECTION (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
		myEjectButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == true {
				; To prevent unwanted aircraft ejection, the player has to press left click for 2 seconds before the hotkey is executed
				; If the button is pressed long enough, the ejection will not occur
				StartTime := A_TickCount
				While (GetKeyState("LButton", "P"))
				{
					Sleep 10
					ElapsedTime := (A_TickCount - StartTime)
					if (ElapsedTime >= 2000) {
						Send "{Shift down}{F10}"
						WinSetTransparent 1, myEjectGui
						Send "{Shift up}"
						ExitApp 
					}
				}
			}
		}
				
		; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N) 
		myNewTargetButton_Click(*)
		{
		if WinActive("ahk_exe dosbox.exe") == false {
			WinActivate("ahk_exe dosbox.exe")
		}
			Send "{n}"
			WinSetTransparent 1, myNewTargetGui			
		}
		
		; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 
		mySelectTargetButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}		
				Send "{b}"
				WinSetTransparent 1, mySelectTargetGui
		}
			
		; CAM Ahead (QWERTY: / / QWERTZ: _ / AZERTY: !)
		; 1st MFD button from the top on the left side of the right MFD
		myCAMAheadButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{/}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{_}"
			} else {
				Send "{!}"
			}
			WinSetTransparent 1, myCAMAheadGui
		}		
		
		; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
		; 2nd MFD button from the top on the left side of the right MFD
		 myCAMRearButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{>}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{>}"
			} else {
				Send "{:}"
			}	
			WinSetTransparent 1, myCAMRearGui
		}
		
		; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
		; 3rd MFD button from the top on the left side of the right MFD
		 myCAMRightButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{<}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{<}"
			} else {
				Send "{;}"
			}
			WinSetTransparent 1, myCAMRightGui
		}
		
		; CAM Left (QWERTY: M / QWERTZ: M / AZERTY: ,)
		; 4th MFD button from the top on the left side of the right MFD
		 myCAMLeftButton_Click(*)
		 {
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{m}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{m}"
			} else {
				Send "{,}"
			}	
			WinSetTransparent 1, myCAMLeftGui
		}
		
		; Extra CAM button 
		; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
		myExtraCAMButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
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
			}			
			WinSetTransparent 1, myExtraCAMGui			
		}
	
	
	

		; Volume adjust (Alt V)
	
	
	
		; Accelerates the game (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
		; the left button at the bottom of the right MFD
		myAccelerateButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{Shift down}{z}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{Shift down}{y}"
			} else {
				Send "{Shift down}{W}"
			}								
			WinSetTransparent 1, myAccelerateGui
			Send "{Shift up}"			
		}
	
		; Normal game speed (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
		myNormalSpeedButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			Send "{Shift down}{X}"
			WinSetTransparent 1, myNormalSpeedGui
			Send "{Shift up}"			
		}	
			
		; Pause game (QWERTY: ALT P / QWERTZ: ALT P / AZERTY: ALT P)
		; the right button at the bottom of the right MFD
		; Find a way to click one more time on the Pause button to unpause
		myPauseButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			Send "{Alt down}{P}"
			WinSetTransparent 1, myPauseGui
			Send "{Alt up}"
		}
		
		

		; Toggle HUD color (F4) 
		
		
	
		; Changes cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C) 	
		; the second button from the right of the top row buttons of the right MFD
		myChangeCockpitViewButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			Send "{c}"
			WinSetTransparent 1, myChangeCockpitViewGui
		}
		
		; de-clutter HUD (QWERTY: V / QWERTZ: V / AZERTY: V)
		; the first button on the right of the top row buttons of the right MFD
		myDeClutterButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			Send "{v}"
			WinSetTransparent 1, myDeClutterGui
		}	
			
		; Sets Maximum Power (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myMaximumPowerButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{Shift down}{+}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{Shift down}{`}"
			} else {
				Send "{Shift down}{=}"
			}
			WinSetTransparent 1, myMaximumPowerGui
			Send "{Shift up}"
		}
		 
		; Increases Throttle (QWERTY: = / QWERTZ: ´ / AZERTY: =)
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myIncreaseThrottleButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{=}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{´}"
			} else {
				Send "{=}"
			}
			WinSetTransparent 1, myIncreaseThrottleGui
		}	
		


		; 50% Power (detects the current speed and changes it accordingly)
		; There is room on the left side of the left MFD
	
	
	
		; Decreases Throttle (QWERTY: - / QWERTZ: ß / AZERTY: ))
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myDecreaseThrottleButton_Click(*)
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{-}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{ß}"
			} else {
				Send "{)}"
			}
			WinSetTransparent 1, myDecreaseThrottleGui
		}
		
		
		; No Power (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myNoPowerButton_Click(*)	
		{
			if WinActive("ahk_exe dosbox.exe") == false {
				WinActivate("ahk_exe dosbox.exe")
			}
			if KeyboardLayout == "QWERTY" {
				Send "{Shift down}{-}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{Shift down}{ß}"
					} else {
						Send "{Shift down}{)}"
						}			
			WinSetTransparent 1, myNoPowerGui
			Send "{Shift up}"		
		}

	
			
		
		
; ------------------------------------------------------------------
		




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









