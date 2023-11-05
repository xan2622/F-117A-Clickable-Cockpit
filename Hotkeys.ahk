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
				myMFDZoomInMouseWheel.Hide()
				; Sleep 100
				if KeyboardLayout == "QWERTY" {
					Send "{z}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{y}"
				} else {
					Send "{w}"
				}					
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
				myMFDZoomOutMouseWheel.Hide()
				; Sleep 100
				Send "{x}"
			}
		}

	

	~LButton::
	{
		CoordMode("Pixel", "Screen")
		CoordMode("Mouse", "Screen")		
		MouseGetPos(&mouseX, &mouseY)
		WinGetPos(&windowX, &windowY,,, "DOSBox")
		
		; Clickable areas (rectangles) 

		; Toggles the MAPTAC MFD mode (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
		myMAPTAC_ButtonX := 322 + windowX
		myMAPTAC_ButtonY := 862 + windowY
		myMAPTAC_ButtonWidth := 156
		myMAPTAC_ButtonHeight := 44
		if ((mouseX > myMAPTAC_ButtonX && mouseX < myMAPTAC_ButtonX+myMAPTAC_ButtonWidth) && (mouseY > myMAPTAC_ButtonY && mouseY < myMAPTAC_ButtonY+myMAPTAC_ButtonHeight)) {
			myMAPTACGui.Hide()
			; Sleep 100
			Send "{F3}"
			; WinSetTransparent 100, myMAPTACGui
		}
		
		; Enables MFD Zoom in (QWERTY: Z / QWERTZ: Y / AZERTY: W)
		myMFDZoomIn_ButtonX := 514 + windowX
		myMFDZoomIn_ButtonY := 867 + windowY
		myMFDZoomIn_ButtonWidth := 28
		myMFDZoomIn_ButtonHeight := 29
		if ((mouseX > myMFDZoomIn_ButtonX && mouseX < myMFDZoomIn_ButtonX+myMFDZoomIn_ButtonWidth) && (mouseY > myMFDZoomIn_ButtonY && mouseY < myMFDZoomIn_ButtonY+myMFDZoomIn_ButtonHeight)) {
			myMFDZoomInGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{z}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{y}"
				} else {
					Send "{w}"
				}
		}
			
		; Enables MFD Zoom out (QWERTY: X / QWERTZ: X / AZERTY: X)
		myMFDZoomOut_ButtonX := 562 + windowX
		myMFDZoomOut_ButtonY := 867 + windowY
		myMFDZoomOut_ButtonWidth := 28
		myMFDZoomOut_ButtonHeight := 29
		if ((mouseX > myMFDZoomOut_ButtonX && mouseX < myMFDZoomOut_ButtonX+myMFDZoomOut_ButtonWidth) && (mouseY > myMFDZoomOut_ButtonY && mouseY < myMFDZoomOut_ButtonY+myMFDZoomOut_ButtonHeight)) {
			myMFDZoomOutGui.Hide()
			Send "{x}"
		}
		
		; Drops a Chaff (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
		myChaff_ButtonX := 14 + windowX
		myChaff_ButtonY := 742 + windowY
		myChaff_ButtonWidth := 104
		myChaff_ButtonHeight := 44
		if ((mouseX > myChaff_ButtonX && mouseX < myChaff_ButtonX+myChaff_ButtonWidth) && (mouseY > myChaff_ButtonY && mouseY < myChaff_ButtonY+myChaff_ButtonHeight)) {
			myChaffGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{2}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{2}"
				} else {
					Send "{é}"
				}
		}
		
		; Drops a Flare (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
		myFlare_ButtonX := 14 + windowX
		myFlare_ButtonY := 790 + windowY
		myFlare_ButtonWidth := 104
		myFlare_ButtonHeight := 44
		if ((mouseX > myFlare_ButtonX && mouseX < myFlare_ButtonX+myFlare_ButtonWidth) && (mouseY > myFlare_ButtonY && mouseY < myFlare_ButtonY+myFlare_ButtonHeight)) {
			myFlareGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{1}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{1}"
				} else {
					Send "{&}"
				}
		}
		
		; Drops a Decoy (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
		myDecoy_ButtonX := 14 + windowX
		myDecoy_ButtonY := 838 + windowY
		myDecoy_ButtonWidth := 104
		myDecoy_ButtonHeight := 44
		if ((mouseX > myDecoy_ButtonX && mouseX < myDecoy_ButtonX+myDecoy_ButtonWidth) && (mouseY > myDecoy_ButtonY && mouseY < myDecoy_ButtonY+myDecoy_ButtonHeight)) {
			myDecoyGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{5}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{5}"
				} else {
					Send "{(}"
				}
		}
		
		; Toggles ECM on/off (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
		myECM_ButtonX := 18 + windowX
		myECM_ButtonY := 891 + windowY
		myECM_ButtonWidth := 116
		myECM_ButtonHeight := 43
		if ((mouseX > myECM_ButtonX && mouseX < myECM_ButtonX+myECM_ButtonWidth) && (mouseY > myECM_ButtonY && mouseY < myECM_ButtonY+myECM_ButtonHeight)) {
			myECMGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{4}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{4}"
				} else {
					Send "{'}"
				}
		}
		
		; Toggles IR Jammer on/off (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
		myIRJammer_ButtonX := 146 + windowX
		myIRJammer_ButtonY := 891 + windowY
		myIRJammer_ButtonWidth := 108
		myIRJammer_ButtonHeight := 43
		if ((mouseX > myIRJammer_ButtonX && mouseX < myIRJammer_ButtonX+myIRJammer_ButtonWidth) && (mouseY > myIRJammer_ButtonY && mouseY < myIRJammer_ButtonY+myIRJammer_ButtonHeight)) {
			myIRJammerGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{3}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{3}"
				} else {
					Send("`"")
				}
		}

		; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
		mySelectWeapon_ButtonX := 414 + windowX
		mySelectWeapon_ButtonY := 483 + windowY
		mySelectWeapon_ButtonWidth := 44
		mySelectWeapon_ButtonHeight := 48
		if ((mouseX > mySelectWeapon_ButtonX && mouseX < mySelectWeapon_ButtonX+mySelectWeapon_ButtonWidth) && (mouseY > mySelectWeapon_ButtonY && mouseY < mySelectWeapon_ButtonY+mySelectWeapon_ButtonHeight)) {
			mySelectWeaponGui.Hide()
			Send "{Space}"
		}

		; Toggle NAV AIR GND buttons (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
		myNavAirGnd_ButtonX := 478 + windowX
		myNavAirGnd_ButtonY := 483 + windowY
		myNavAirGnd_ButtonWidth := 235
		myNavAirGnd_ButtonHeight := 43
		if ((mouseX > myNavAirGnd_ButtonX && mouseX < myNavAirGnd_ButtonX+myNavAirGnd_ButtonWidth) && (mouseY > myNavAirGnd_ButtonY && mouseY < myNavAirGnd_ButtonY+myNavAirGnd_ButtonHeight)) {
			myNavAirGndGui.Hide()
			Send "{F2}"
		}			
		
		; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
		; the rounded button at the right of LOCK
		myILS_ButtonX := 845 + windowX
		myILS_ButtonY := 488 + windowY
		myILS_ButtonWidth := 28
		myILS_ButtonHeight := 29
		if ((mouseX > myILS_ButtonX && mouseX < myILS_ButtonX+myILS_ButtonWidth) && (mouseY > myILS_ButtonY && mouseY < myILS_ButtonY+myILS_ButtonHeight)) {
			myILSGui.Hide()
			Send "{F9}"
		}
	
		; Turns BAY on/off (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
		myBay_ButtonX := 1029 + windowX
		myBay_ButtonY := 526 + windowY
		myBay_ButtonWidth := 104
		myBay_ButtonHeight := 44
		if ((mouseX > myBay_ButtonX && mouseX < myBay_ButtonX+myBay_ButtonWidth) && (mouseY > myBay_ButtonY && mouseY < myBay_ButtonY+myBay_ButtonHeight)) {
			myBayGui.Hide()		
			if KeyboardLayout == "QWERTY" {
				Send "{8}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{8}"
				} else {
					Send "{_}"
				}
		}			
		
		; Turns AUTOPILOT nn/off (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
		myAutopilot_ButtonX := 1029 + windowX
		myAutopilot_ButtonY := 574 + windowY
		myAutopilot_ButtonWidth := 104
		myAutopilot_ButtonHeight := 44
		if ((mouseX > myAutopilot_ButtonX && mouseX < myAutopilot_ButtonX+myAutopilot_ButtonWidth) && (mouseY > myAutopilot_ButtonY && mouseY < myAutopilot_ButtonY+myAutopilot_ButtonHeight)) {
			myAutopilotGui.Hide()		
			if KeyboardLayout == "QWERTY" {
				Send "{7}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{7}"
				} else {
					Send "{è}"
				}				
		}			

		; Turns GEAR Button on/off (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
		myGear_ButtonX := 1029 + windowX
		myGear_ButtonY := 622 + windowY
		myGear_ButtonWidth := 104
		myGear_ButtonHeight := 44
		if ((mouseX > myGear_ButtonX && mouseX < myGear_ButtonX+myGear_ButtonWidth) && (mouseY > myGear_ButtonY && mouseY < myGear_ButtonY+myGear_ButtonHeight)) {
			myGearGui.Hide()		
			if KeyboardLayout == "QWERTY" {
				Send "{6}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{6}"
				} else {
					Send "{-}"
				}
		}

		; Turns FLAPS on/off (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)
		myFlaps_ButtonX := 1137 + windowX
		myFlaps_ButtonY := 574 + windowY
		myFlaps_ButtonWidth := 104
		myFlaps_ButtonHeight := 44
		if ((mouseX > myFlaps_ButtonX && mouseX < myFlaps_ButtonX+myFlaps_ButtonWidth) && (mouseY > myFlaps_ButtonY && mouseY < myFlaps_ButtonY+myFlaps_ButtonHeight)) {
			myFlapsGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{9}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{9}"
				} else {
					Send "{ç}"
				}
		}
		
		; Turns BRAKE on/off  (QWERTY: 0 / QWERTZ: 0 / AZERTY: à)
		myBrake_ButtonX := 1137 + windowX
		myBrake_ButtonY := 622 + windowY
		myBrake_ButtonWidth := 104
		myBrake_ButtonHeight := 44
		if ((mouseX > myBrake_ButtonX && mouseX < myBrake_ButtonX+myBrake_ButtonWidth) && (mouseY > myBrake_ButtonY && mouseY < myBrake_ButtonY+myBrake_ButtonHeight)) {
			myBrakeGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{0}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{0}"
				} else {
					Send "{à}"
				}
		}				
		
		; Select Blue WAYPOINT on MFD (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)
		myWaypoint_ButtonX := 681 + windowX
		myWaypoint_ButtonY := 901 + windowY
		myWaypoint_ButtonWidth := 76
		myWaypoint_ButtonHeight := 43
		if ((mouseX > myWaypoint_ButtonX && mouseX < myWaypoint_ButtonX+myWaypoint_ButtonWidth) && (mouseY > myWaypoint_ButtonY && mouseY < myWaypoint_ButtonY+myWaypoint_ButtonHeight)) {
			myWaypointGui.Hide()			
			Send "{F7}"
		}	
		
		; Show Ordnance on MFD (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
		myOrdnance_ButtonX := 761 + windowX
		myOrdnance_ButtonY := 901 + windowY
		myOrdnance_ButtonWidth := 76
		myOrdnance_ButtonHeight := 43
		if ((mouseX > myOrdnance_ButtonX && mouseX < myOrdnance_ButtonX+myOrdnance_ButtonWidth) && (mouseY > myOrdnance_ButtonY && mouseY < myOrdnance_ButtonY+myOrdnance_ButtonHeight)) {
			myOrdnanceGui.Hide()
			Send "{F5}"
		}	
	
		; Show Objectives on MFD (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
		myObjectives_ButtonX := 841 + windowX
		myObjectives_ButtonY := 901 + windowY
		myObjectives_ButtonWidth := 76
		myObjectives_ButtonHeight := 43
		if ((mouseX > myObjectives_ButtonX && mouseX < myObjectives_ButtonX+myObjectives_ButtonWidth) && (mouseY > myObjectives_ButtonY && mouseY < myObjectives_ButtonY+myObjectives_ButtonHeight)) {
			myObjectivesGui.Hide()
			Send "{F10}"
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
			myFlirGui.Hide()
			Send "{F6}"
		}
		
		; Activates the EJECTION (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
		myEject_ButtonX := 1233 + windowX
		myEject_ButtonY := 685 + windowY
		myEject_ButtonWidth := 40
		myEject_ButtonHeight := 187
		if ((mouseX > myEject_ButtonX && mouseX < myEject_ButtonX+myEject_ButtonWidth) && (mouseY > myEject_ButtonY && mouseY < myEject_ButtonY+myEject_ButtonHeight)) {
			
			
			; To prevent unwanted aircraft ejection, the player has to press left click for 2 seconds before the hotkey is executed
			; If the button is pressed long enough, the ejection will not occur
			StartTime := A_TickCount
			While (GetKeyState("LButton", "P"))
			{
				Sleep 10
				ElapsedTime := (A_TickCount - StartTime)
				if (ElapsedTime >= 2000)
				{
					myEjectGui.Hide()
					Send "{Shift down}{F10}"
					Send "{Shift up}"
					ExitApp 
				}
			}
			
			
		}
	
		; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N) 
		myNewTarget_ButtonX := 997 + windowX
		myNewTarget_ButtonY := 738 + windowY
		myNewTarget_ButtonWidth := 24
		myNewTarget_ButtonHeight := 29
		if ((mouseX > myNewTarget_ButtonX && mouseX < myNewTarget_ButtonX+myNewTarget_ButtonWidth) && (mouseY > myNewTarget_ButtonY && mouseY < myNewTarget_ButtonY+myNewTarget_ButtonHeight)) {
			myNewTargetGui.Hide()
			Send "{n}"
		}	
		
		; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 	
		mySelectTarget_ButtonX := 997 + windowX
		mySelectTarget_ButtonY := 790 + windowY
		mySelectTarget_ButtonWidth := 24
		mySelectTarget_ButtonHeight := 29
		if ((mouseX > mySelectTarget_ButtonX && mouseX < mySelectTarget_ButtonX+mySelectTarget_ButtonWidth) && (mouseY > mySelectTarget_ButtonY && mouseY < mySelectTarget_ButtonY+mySelectTarget_ButtonHeight)) {
			mySelectTargetGui.Hide()
			Send "{b}"
		}	
		
		
		
			; change cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C) 	
		; 	myCockpitView_ButtonX := 997
		; 	myCockpitView_ButtonY := 790
		; 	myCockpitView_ButtonWidth := 24
		; 	myCockpitView_ButtonHeight := 29
		; 	if ((mouseX > myCockpitView_ButtonX && mouseX < myCockpitView_ButtonX+myCockpitView_ButtonWidth) && (mouseY > myCockpitView_ButtonY && mouseY < myCockpitView_ButtonY+myCockpitView_ButtonHeight)) {
		; 		Send "{c}"
		; 		myCockpitViewGui.Hide()
		; 	}	
			
		
		
		; CAM Ahead (QWERTY: / / QWERTZ: _ / AZERTY: !)
		; 1st MFD button from the top on the left side of the right MFD
		myCAMAhead_ButtonX := 645 + windowX
		myCAMAhead_ButtonY := 570 + windowY
		myCAMAhead_ButtonWidth := 24
		myCAMAhead_ButtonHeight := 28
		if ((mouseX > myCAMAhead_ButtonX && mouseX < myCAMAhead_ButtonX+myCAMAhead_ButtonWidth) && (mouseY > myCAMAhead_ButtonY && mouseY < myCAMAhead_ButtonY+myCAMAhead_ButtonHeight)) {
			myCAMAheadGui.Hide()		
			if KeyboardLayout == "QWERTY" {
				Send "{/}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{_}"
				} else {
					Send "{!}"
				}
		}
		
		; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
		; 2nd MFD button from the top on the left side of the right MFD
		myCAMRear_ButtonX := 645 + windowX
		myCAMRear_ButtonY := 622 + windowY
		myCAMRear_ButtonWidth := 24
		myCAMRear_ButtonHeight := 29
		if ((mouseX > myCAMRear_ButtonX && mouseX < myCAMRear_ButtonX+myCAMRear_ButtonWidth) && (mouseY > myCAMRear_ButtonY && mouseY < myCAMRear_ButtonY+myCAMRear_ButtonHeight)) {
			myCAMRearGui.Hide()		
			if KeyboardLayout == "QWERTY" {
				Send "{>}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{>}"
				} else {
					Send "{:}"
				}
		}

		; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
		; 3rd MFD button from the top on the left side of the right MFD
		myCAMRight_ButtonX := 645 + windowX
		myCAMRight_ButtonY := 675 + windowY
		myCAMRight_ButtonWidth := 24
		myCAMRight_ButtonHeight := 29
		if ((mouseX > myCAMRight_ButtonX && mouseX < myCAMRight_ButtonX+myCAMRight_ButtonWidth) && (mouseY > myCAMRight_ButtonY && mouseY < myCAMRight_ButtonY+myCAMRight_ButtonHeight)) {
			myCAMRightGui.Hide()		
			if KeyboardLayout == "QWERTY" {
				Send "{<}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{<}"
				} else {
					Send "{;}"
				}
		}
		
		; CAM Left (QWERTY: M / QWERTZ: M / AZERTY: ,)
		; 4th MFD button from the top on the left side of the right MFD
		myCAMLeft_ButtonX := 645 + windowX
		myCAMLeft_ButtonY := 738 + windowY
		myCAMLeft_ButtonWidth := 24
		myCAMLeft_ButtonHeight := 28
		if ((mouseX > myCAMLeft_ButtonX && mouseX < myCAMLeft_ButtonX+myCAMLeft_ButtonWidth) && (mouseY > myCAMLeft_ButtonY && mouseY < myCAMLeft_ButtonY+myCAMLeft_ButtonHeight)) {
			myCAMLeftGui.Hide()		
			if KeyboardLayout == "QWERTY" {
				Send "{m}"
				} else if KeyboardLayout == "QWERTZ" {
					Send "{m}"
				} else {
					Send "{,}"
				}
		}
						
		; Extra CAM button 
		; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
		myExtraCAM_ButtonX := 761 + windowX
		myExtraCAM_ButtonY := 949 + windowY
		myExtraCAM_ButtonWidth := 156
		myExtraCAM_ButtonHeight := 43
		if ((mouseX > myExtraCAM_ButtonX && mouseX < myExtraCAM_ButtonX+myExtraCAM_ButtonWidth) && (mouseY > myExtraCAM_ButtonY && mouseY < myExtraCAM_ButtonY+myExtraCAM_ButtonHeight)) {
						
			myExtraCAMGui.Hide()
			
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
		
		}

		
	
		; Volume adjust (Alt V)
		
		
		
		; Accelerates the game (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
		; the left button at the bottom of the right MFD
		myAccelerate_ButtonX := 829 + windowX
		myAccelerate_ButtonY := 858 + windowY
		myAccelerate_ButtonWidth := 24
		myAccelerate_ButtonHeight := 25
		if ((mouseX > myAccelerate_ButtonX && mouseX < myAccelerate_ButtonX+myAccelerate_ButtonWidth) && (mouseY > myAccelerate_ButtonY && mouseY < myAccelerate_ButtonY+myAccelerate_ButtonHeight)) {
			myAccelerateGui.Hide()
			if KeyboardLayout == "QWERTY" {
					Send "{Shift down}{z}"
					} else if KeyboardLayout == "QWERTZ" {
						Send "{Shift down}{y}"
					} else {
						Send "{Shift down}{W}"
					}
			Send "{Shift up}"
		}
	
		; Normal game speed (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
		myNormalSpeed_ButtonX := 873 + windowX
		myNormalSpeed_ButtonY := 858 + windowY
		myNormalSpeed_ButtonWidth := 24
		myNormalSpeed_ButtonHeight := 28
		if ((mouseX > myNormalSpeed_ButtonX && mouseX < myNormalSpeed_ButtonX+myNormalSpeed_ButtonWidth) && (mouseY > myNormalSpeed_ButtonY && mouseY < myNormalSpeed_ButtonY+myNormalSpeed_ButtonHeight)) {
			myNormalSpeedGui.Hide()
			Send "{Shift down}{X}"
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
			myPauseGui.Hide()
			Send "{Alt down}{P}"
			Send "{Alt up}"
		}	
	
	
	
		; Toggle HUD color (F4) 



		; Changes cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C)
		myChangeCockpitView_ButtonX := 877 + windowX
		myChangeCockpitView_ButtonY := 526 + windowY
		myChangeCockpitView_ButtonWidth := 24
		myChangeCockpitView_ButtonHeight := 29
		if ((mouseX > myChangeCockpitView_ButtonX && mouseX < myChangeCockpitView_ButtonX+myChangeCockpitView_ButtonWidth) && (mouseY > myChangeCockpitView_ButtonY && mouseY < myChangeCockpitView_ButtonY+myChangeCockpitView_ButtonHeight)) {
			myChangeCockpitViewGui.Hide()
			Send "{c}"
		}	
	
		; de-clutter HUD (QWERTY: V / QWERTZ: V / AZERTY: V)
		myDeClutter_ButtonX := 922 + windowX
		myDeClutter_ButtonY := 526 + windowY
		myDeClutter_ButtonWidth := 24
		myDeClutter_ButtonHeight := 29
		if ((mouseX > myDeClutter_ButtonX && mouseX < myDeClutter_ButtonX+myDeClutter_ButtonWidth) && (mouseY > myDeClutter_ButtonY && mouseY < myDeClutter_ButtonY+myDeClutter_ButtonHeight)) {
			myDeClutterGui.Hide()
			Send "{v}"
		}	
	
		; Sets Maximum Power (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myMaximumPower_ButtonX := 262 + windowX
		myMaximumPower_ButtonY := 560 + windowY
		myMaximumPower_ButtonWidth := 24
		myMaximumPower_ButtonHeight := 29
		if ((mouseX > myMaximumPower_ButtonX && mouseX < myMaximumPower_ButtonX+myMaximumPower_ButtonWidth) && (mouseY > myMaximumPower_ButtonY && mouseY < myMaximumPower_ButtonY+myMaximumPower_ButtonHeight)) {
			myMaximumPowerGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{Shift down}{+}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{Shift down}{`}"
			} else {
				Send "{Shift down}{=}"
			}
			Send "{Shift up}"
		}	
	
		; Increases Throttle (QWERTY: = / QWERTZ: ´ / AZERTY: =)
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myIncreaseThrottle_ButtonX := 262 + windowX
		myIncreaseThrottle_ButtonY := 622 + windowY
		myIncreaseThrottle_ButtonWidth := 24
		myIncreaseThrottle_ButtonHeight := 29
		if ((mouseX > myIncreaseThrottle_ButtonX && mouseX < myIncreaseThrottle_ButtonX+myIncreaseThrottle_ButtonWidth) && (mouseY > myIncreaseThrottle_ButtonY && mouseY < myIncreaseThrottle_ButtonY+myIncreaseThrottle_ButtonHeight)) {
			myIncreaseThrottleGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{=}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{´}"
			} else {
				Send "{=}"
			}		
		}	
	
		; Increases or decreases power to 50% Throttle (detects the current speed and changes it accordingly)
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myFiftyThrottle_ButtonX := 262 + windowX
		myFiftyThrottle_ButtonY := 680 + windowY
		myFiftyThrottle_ButtonWidth := 24
		myFiftyThrottle_ButtonHeight := 29
		if ((mouseX > myFiftyThrottle_ButtonX && mouseX < myFiftyThrottle_ButtonX+myFiftyThrottle_ButtonWidth) && (mouseY > myFiftyThrottle_ButtonY && mouseY < myFiftyThrottle_ButtonY+myFiftyThrottle_ButtonHeight)) {
			
			; -------------------------------------------
			Image000:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 000.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image000 has not been found.")
					Goto Image005
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 6 {
						Sleep 100
						if KeyboardLayout == "QWERTY" {
							Send "{=}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{´}"
						} else {
							Send "{=}"
						}
					}					
				}

			Image005:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 005.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image005 has not been found.")
					Goto Image010
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 5 {
						Sleep 100
						if KeyboardLayout == "QWERTY" {
							Send "{=}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{´}"
						} else {
							Send "{=}"
						}						
					}
				}
				
			Image010:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 010.png")
				Switch ErrorLevel {
					Case "2": 
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image010 has not been found.")
					Goto Image020
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 4 {
						Sleep 100
						if KeyboardLayout == "QWERTY" {
							Send "{=}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{´}"
						} else {
							Send "{=}"
						}
					}
				}

			Image020:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 020.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image020 has not been found.")
					Goto Image030
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 3 {
						if KeyboardLayout == "QWERTY" {
							Send "{=}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{´}"
						} else {
							Send "{=}"
						}
					}
				}

			Image030:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 030.png")
				Switch ErrorLevel {
					Case "2": 
					MsgBox("A problem occured with image search.")
					
					Case "1": 
					; MsgBox("Image030 has not been found.")
					Goto Image040
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 2 {
						Sleep 100
						if KeyboardLayout == "QWERTY" {
							Send "{=}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{´}"
						} else {
							Send "{=}"
						}
					}
				}

			Image040:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 040.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image040 has not been found.")
					Goto Image050
					
					Case "0":
					myFiftyThrottleGui.Hide()
					if KeyboardLayout == "QWERTY" {
						Send "{=}"
					} else if KeyboardLayout == "QWERTZ" {
						Send "{´}"
					} else {
						Send "{=}"
					}
				}
			
			Image050:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 050.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image050 has not been found.")
					Goto Image060
					
					Case "0":
					myFiftyThrottleGui.Hide()
					; Do nothing because the speed is already at 50
				}

			Image060:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 060.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image060 has not been found.")
					Goto Image070
					
					Case "0":
					myFiftyThrottleGui.Hide()					
					if KeyboardLayout == "QWERTY" {
						Send "{-}"
					} else if KeyboardLayout == "QWERTZ" {
						Send "{ß}"
					} else {
						Send "{)}"
					}
				}

			Image070:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 070.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image070 has not been found.")
					Goto Image080
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 2 {
						Sleep 100
						if KeyboardLayout == "QWERTY" {
							Send "{-}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{ß}"
						} else {
							Send "{)}"
						}
					}
				}
			
			Image080:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 080.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image080 has not been found.")
					Goto Image090
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 3 {
						Sleep 100					
						if KeyboardLayout == "QWERTY" {
							Send "{-}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{ß}"
						} else {
							Send "{)}"
						}
					}
				}

			Image090:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 090.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image090 has not been found.")
					Goto Image100
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 4 {
						Sleep 100
						if KeyboardLayout == "QWERTY" {
							Send "{-}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{ß}"
						} else {
							Send "{)}"
						}
					}
				}

			Image100:
				ErrorLevel := !ImageSearch(&Position01X, &Position01Y, windowX, windowY, (windowX + windowW), (windowY + windowH), "*10 100.png")
				Switch ErrorLevel {
					Case "2":
					MsgBox("A problem occured with image search.")
					
					Case "1":
					; MsgBox("Image100 has not been found.")
					; Goto Image000
					myFiftyThrottleGui.Hide()
					; ExitApp
					
					Case "0":
					myFiftyThrottleGui.Hide()
					loop 5 {
						Sleep 100
						if KeyboardLayout == "QWERTY" {
							Send "{-}"
						} else if KeyboardLayout == "QWERTZ" {
							Send "{ß}"
						} else {
							Send "{)}"
						}
					}
				}
		}		
		; -------------------------------------------		
	
		; Decreases Throttle (QWERTY: - / QWERTZ: ß / AZERTY: ))
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myDecreaseThrottle_ButtonX := 262 + windowX
		myDecreaseThrottle_ButtonY := 733 + windowY
		myDecreaseThrottle_ButtonWidth := 24
		myDecreaseThrottle_ButtonHeight := 29
		if ((mouseX > myDecreaseThrottle_ButtonX && mouseX < myDecreaseThrottle_ButtonX+myDecreaseThrottle_ButtonWidth) && (mouseY > myDecreaseThrottle_ButtonY && mouseY < myDecreaseThrottle_ButtonY+myDecreaseThrottle_ButtonHeight)) {
			myDecreaseThrottleGui.Hide()			
			if KeyboardLayout == "QWERTY" {
				Send "{-}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{ß}"
			} else {
				Send "{)}"
			}		
		}	

		; No Power (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
		; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
		myNoPower_ButtonX := 262 + windowX
		myNoPower_ButtonY := 795 + windowY
		myNoPower_ButtonWidth := 24
		myNoPower_ButtonHeight := 29
		if ((mouseX > myNoPower_ButtonX && mouseX < myNoPower_ButtonX+myNoPower_ButtonWidth) && (mouseY > myNoPower_ButtonY && mouseY < myNoPower_ButtonY+myNoPower_ButtonHeight)) {
			myNoPowerGui.Hide()
			if KeyboardLayout == "QWERTY" {
				Send "{Shift down}{-}"
			} else if KeyboardLayout == "QWERTZ" {
				Send "{Shift down}{ß}"
			} else {
				Send "{Shift down}{)}"
			}			
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







; Press CTRL + SHIFT + ENTER to Toggle the visibility of overlays
CounterOverlaysVisibility := 0

>^+Enter::
	{
		Global CounterOverlaysVisibility
		If CounterOverlaysVisibility == 1 {
			CounterOverlaysVisibility := 0
		} Else If CounterOverlaysVisibility !== 2 {
			CounterOverlaysVisibility := CounterOverlaysVisibility + 1
		}
		
		IF CounterOverlaysVisibility == 0 {
			; myMFDZoomInMouseWheel.Hide() 
			myMFDZoomOutMouseWheel.Hide()
			myMAPTACGui.Hide()
			myMFDZoomInGui.Hide()
			myMFDZoomInGui.Hide()
			myChaffGui.Hide()
			myFlareGui.Hide()
			myDecoyGui.Hide()
			myECMGui.Hide()
			myIRJammerGui.Hide()
			mySelectWeaponGui.Hide()
			myNavAirGndGui.Hide()
			myILSGui.Hide()
			myBayGui.Hide()
			myAutopilotGui.Hide()
			myGearGui.Hide()
			myFlapsGui.Hide()
			myBrakeGui.Hide()
			myWaypointGui.Hide()
			myOrdnanceGui.Hide()
			myObjectivesGui.Hide()
			myFlirGui.Hide()
			myEjectGui.Hide()
			myNewTargetGui.Hide()
			mySelectTargetGui.Hide()
			myCAMAheadGui.Hide()
			myCAMRearGui.Hide()
			myCAMRightGui.Hide()
			myCAMLeftGui.Hide()
			myExtraCAMGui.Hide()
			myAccelerateGui.Hide()
			myNormalSpeedGui.Hide()
			myPauseGui.Hide()
			myChangeCockpitViewGui.Hide()
			myDeClutterGui.Hide()
			myMaximumPowerGui.Hide()
			myIncreaseThrottleGui.Hide()
			myFiftyThrottleGui.Hide()
			myDecreaseThrottleGui.Hide()
			myNoPowerGui.Hide()
		} Else If CounterOverlaysVisibility == 1 {
			; myMFDZoomInMouseWheel.Show() 
			myMFDZoomOutMouseWheel.Show()
			myMAPTACGui.Show()
			myMFDZoomInGui.Show()
			myMFDZoomInGui.Show()
			myChaffGui.Show()
			myFlareGui.Show()
			myDecoyGui.Show()
			myECMGui.Show()
			myIRJammerGui.Show()
			mySelectWeaponGui.Show()
			myNavAirGndGui.Show()
			myILSGui.Show()
			myBayGui.Show()
			myAutopilotGui.Show()
			myGearGui.Show()
			myFlapsGui.Show()
			myBrakeGui.Show()
			myWaypointGui.Show()
			myOrdnanceGui.Show()
			myObjectivesGui.Show()
			myFlirGui.Show()
			myEjectGui.Show()
			myNewTargetGui.Show()
			mySelectTargetGui.Show()
			myCAMAheadGui.Show()
			myCAMRearGui.Show()
			myCAMRightGui.Show()
			myCAMLeftGui.Show()
			myExtraCAMGui.Show()
			myAccelerateGui.Show()
			myNormalSpeedGui.Show()
			myPauseGui.Show()
			myChangeCockpitViewGui.Show()
			myDeClutterGui.Show()
			myMaximumPowerGui.Show()
			myIncreaseThrottleGui.Show()
			myFiftyThrottleGui.Show()
			myDecreaseThrottleGui.Show()
			myNoPowerGui.Show()	
		}	
	}






