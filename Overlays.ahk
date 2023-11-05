#Requires AutoHotkey v2










	; --------------------------------------------------		
	; OVERLAYS (rectangles over the cockpit buttons)
	; --------------------------------------------------



	; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollUp Zoom In (QWERTY: Z / QWERTZ: Y / AZERTY: W)
	; x298 y560 w308 h288 
	myMFDZoomInMouseWheel := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomInMouseWheel.MarginX := myMFDZoomInMouseWheel.MarginY := 1
	myMFDZoomInMouseWheel.BackColor := "59601c"
		myPictureBG := myMFDZoomInMouseWheel.Add("Picture", "0x0100 w308 h288", "yellow.png")
		myPictureBG.Tooltip := ""
		WinSetTransparent 75, myMFDZoomInMouseWheel
	myMFDZoomInMouseWheel.Show("NoActivate")

	SetTimer((*) => windowTrack01(myMFDZoomInMouseWheel), 20)
	windowTrack01(myMFDZoomInMouseWheel) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myMFDZoomInMouseWheel.Move(windowX + 298, windowY + 560)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollDown Zoom Out (QWERTY: X / QWERTZ: X / AZERTY: X)
	; x298 y560 w308 h288 
	myMFDZoomOutMouseWheel := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomOutMouseWheel.MarginX := myMFDZoomOutMouseWheel.MarginY := 1
	myMFDZoomOutMouseWheel.BackColor := "59601c"
		myPictureBG := myMFDZoomOutMouseWheel.Add("Picture", "0x0100 w308 h288", "yellow.png")
		myPictureBG.Tooltip := "Use mouse wheel up or down to zoom in/out"
		WinSetTransparent 75, myMFDZoomOutMouseWheel
	myMFDZoomOutMouseWheel.Show("NoActivate")

	SetTimer((*) => windowTrack02(myMFDZoomOutMouseWheel), 20)
	windowTrack02(myMFDZoomOutMouseWheel) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myMFDZoomOutMouseWheel.Move(windowX + 298, windowY + 560)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Displays a wide MAPTAC rectangle (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
	; y322 y862 w156 h44	
	myMAPTACGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMAPTACGui.MarginX := myMAPTACGui.MarginY := 1
	myMAPTACGui.BackColor := "59601c"
		myPictureBG := myMAPTACGui.Add("Picture", "0x0100 w156 h44", "yellow.png")
		myPictureBG.Tooltip := "Toogle MAP/TAC view"
		WinSetTransparent 75, myMAPTACGui
	myMAPTACGui.Show("NoActivate")

	SetTimer((*) => windowTrack03(myMAPTACGui), 20)
	windowTrack03(myMAPTACGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myMAPTACGui.Move(windowX + 322, windowY + 862)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
		
	; Displays a MFD Zoom In rectangle (QWERTY: Z / QWERTZ: Y / AZERTY: W)
	; x514 y867 w28 h29 
	myMFDZoomInGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomInGui.MarginX := myMFDZoomInGui.MarginY := 1
	myMFDZoomInGui.BackColor := "59601c"
		myPictureBG := myMFDZoomInGui.Add("Picture", "0x0100 w28 h29", "yellow.png")
		myPictureBG.Tooltip := "Zoom MFD in"
		WinSetTransparent 75, myMFDZoomInGui
	myMFDZoomInGui.Show("NoActivate")

	SetTimer((*) => windowTrack04(myMFDZoomInGui), 20)
	windowTrack04(myMFDZoomInGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myMFDZoomInGui.Move(windowX + 514, windowY + 867)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a MFD Zoom Out rectangle (QWERTY: X / QWERTZ: X / AZERTY: X)
	; x562 y867 w28 h29 
	myMFDZoomOutGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomOutGui.MarginX := myMFDZoomOutGui.MarginY := 1
	myMFDZoomOutGui.BackColor := "59601c"
		myPictureBG := myMFDZoomOutGui.Add("Picture", "0x0100 w28 h29", "yellow.png")
		myPictureBG.Tooltip := "Zoom MFD out"
		WinSetTransparent 75, myMFDZoomOutGui
	myMFDZoomOutGui.Show("NoActivate")

	SetTimer((*) => windowTrack05(myMFDZoomOutGui), 20)
	windowTrack05(myMFDZoomOutGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myMFDZoomOutGui.Move(windowX + 562, windowY + 867)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}

	; Displays a CHAFF rectangle (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
	; x14 y742 w104 h44 
	myChaffGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myChaffGui.MarginX := myChaffGui.MarginY := 1
	myChaffGui.BackColor := "59601c"
		myPictureBG := myChaffGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Release a CHAFF"
		WinSetTransparent 75, myChaffGui
	myChaffGui.Show("NoActivate")

	SetTimer((*) => windowTrack06(myChaffGui), 20)
	windowTrack06(myChaffGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myChaffGui.Move(windowX + 14, windowY + 742)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
		
	; Displays a FLARE rectangle (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
	; x14 y790 w104 h44 
	myFlareGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myFlareGui.MarginX := myFlareGui.MarginY := 1
	myFlareGui.BackColor := "59601c"
		myPictureBG := myFlareGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Release a FLARE"
		WinSetTransparent 75, myFlareGui
	myFlareGui.Show("NoActivate")

	SetTimer((*) => windowTrack07(myFlareGui), 20)
	windowTrack07(myFlareGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myFlareGui.Move(windowX + 14, windowY + 790)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Displays a DECOY rectangle (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
	; x14 y838 w104 h44 
	myDecoyGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myDecoyGui.MarginX := myDecoyGui.MarginY := 1
	myDecoyGui.BackColor := "59601c"
		myPictureBG := myDecoyGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Release a DECOY"
		WinSetTransparent 75, myDecoyGui
	myDecoyGui.Show("NoActivate")

	SetTimer((*) => windowTrack08(myDecoyGui), 20)
	windowTrack08(myDecoyGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myDecoyGui.Move(windowX + 14, windowY + 838)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a ECM rectangle (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
	; x18 y891 w116 h43 
	myECMGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myECMGui.MarginX := myECMGui.MarginY := 1
	myECMGui.BackColor := "59601c"
		myPictureBG := myECMGui.Add("Picture", "0x0100 w116 h43", "yellow.png")
		myPictureBG.Tooltip := "Turn ECM on/off"
		WinSetTransparent 75, myECMGui
	myECMGui.Show("NoActivate")

	SetTimer((*) => windowTrack09(myECMGui), 20)
	windowTrack09(myECMGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myECMGui.Move(windowX + 18, windowY + 891)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}		
	
	; Displays a IR Jammer rectangle (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
	; x146 y891 w108 h43 
	myIRJammerGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myIRJammerGui.MarginX := myIRJammerGui.MarginY := 1
	myIRJammerGui.BackColor := "59601c"
		myPictureBG := myIRJammerGui.Add("Picture", "0x0100 w108 h43", "yellow.png")
		myPictureBG.Tooltip := "Turn IR Jammer on/off"
		WinSetTransparent 75, myIRJammerGui
	myIRJammerGui.Show("NoActivate")

	SetTimer((*) => windowTrack10(myIRJammerGui), 20)
	windowTrack10(myIRJammerGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myIRJammerGui.Move(windowX + 146, windowY + 891)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}

	; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
	; the screw at the left of the NAV button 
	; x414 y483 w44 h48 
	mySelectWeaponGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	mySelectWeaponGui.MarginX := mySelectWeaponGui.MarginY := 1
	mySelectWeaponGui.BackColor := "59601c"
		myPictureBG := mySelectWeaponGui.Add("Picture", "0x0100 w44 h48", "yellow.png")
		myPictureBG.Tooltip := "Select Weapon"
		WinSetTransparent 75, mySelectWeaponGui
	mySelectWeaponGui.Show("NoActivate")

	SetTimer((*) => windowTrack11(mySelectWeaponGui), 20)
	windowTrack11(mySelectWeaponGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			mySelectWeaponGui.Move(windowX + 414, windowY + 483)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Displays a wide NAVAIRGND rectangle (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
	; x478 y483 w235 h43 myNavAirGndGui
	myNavAirGndGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNavAirGndGui.MarginX := myNavAirGndGui.MarginY := 1
	myNavAirGndGui.BackColor := "59601c"
		myPictureBG := myNavAirGndGui.Add("Picture", "0x0100 w235 h43", "yellow.png")
		myPictureBG.Tooltip := "Toggle between NAV/AIR/GND"
		WinSetTransparent 75, myNavAirGndGui
	myNavAirGndGui.Show("NoActivate")

	SetTimer((*) => windowTrack12(myNavAirGndGui), 20)
	windowTrack12(myNavAirGndGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe")
			myNavAirGndGui.Move(windowX + 478, windowY + 483)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
	; the rounded button at the right of LOCK
	; x845 y488 w28 h29 myILSGui
	myILSGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myILSGui.MarginX := myILSGui.MarginY := 1
	myILSGui.BackColor := "59601c"
		myPictureBG := myILSGui.Add("Picture", "0x0100 w28 h29", "yellow.png")
		myPictureBG.Tooltip := "Toggle ILS on/off"
		WinSetTransparent 75, myILSGui
	myILSGui.Show("NoActivate")

	SetTimer((*) => windowTrack13(myILSGui), 20)
	windowTrack13(myILSGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myILSGui.Move(windowX + 845, windowY + 488)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}

	; Displays a BAY rectangle (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
	; x1029 y526 w104 h44 
	myBayGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myBayGui.MarginX := myBayGui.MarginY := 1
	myBayGui.BackColor := "59601c"
		myPictureBG := myBayGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Toggle BAY on/off"
		WinSetTransparent 75, myBayGui
	myBayGui.Show("NoActivate")

	SetTimer((*) => windowTrack14(myBayGui), 20)
	windowTrack14(myBayGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myBayGui.Move(windowX + 1029, windowY + 526)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}

	; Displays an AUTOPILOT rectangle (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
	; x1029 y574 w104 h44 
	myAutopilotGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myAutopilotGui.MarginX := myAutopilotGui.MarginY := 1
	myAutopilotGui.BackColor := "59601c"
		myPictureBG := myAutopilotGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Toggle AUTOPILOT on/off"
		WinSetTransparent 75, myAutopilotGui
	myAutopilotGui.Show("NoActivate")

	SetTimer((*) => windowTrack15(myAutopilotGui), 20)
	windowTrack15(myAutopilotGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myAutopilotGui.Move(windowX + 1029, windowY + 574)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a GEAR rectangle (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
	; x1029 y622 w104 h44 myGearGui
	myGearGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myGearGui.MarginX := myGearGui.MarginY := 1
	myGearGui.BackColor := "59601c"
		myPictureBG := myGearGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Toggle GEAR on/off"
		WinSetTransparent 75, myGearGui
	myGearGui.Show("NoActivate")

	SetTimer((*) => windowTrack16(myGearGui), 20)
	windowTrack16(myGearGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myGearGui.Move(windowX + 1029, windowY + 622)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Displays a FLAPS rectangle (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)
	; x1137 y574 w104 h44 myFlapsGui
	myFlapsGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myFlapsGui.MarginX := myFlapsGui.MarginY := 1
	myFlapsGui.BackColor := "59601c"
		myPictureBG := myFlapsGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Toggle FLAPS on/off"
		WinSetTransparent 75, myFlapsGui
	myFlapsGui.Show("NoActivate")

	SetTimer((*) => windowTrack17(myFlapsGui), 20)
	windowTrack17(myFlapsGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myFlapsGui.Move(windowX + 1137, windowY + 574)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a BRAKE rectangle (0)
	; x1137 y622 w104 h44 
	myBrakeGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myBrakeGui.MarginX := myBrakeGui.MarginY := 1
	myBrakeGui.BackColor := "59601c"
		myPictureBG := myBrakeGui.Add("Picture", "0x0100 w104 h44", "yellow.png")
		myPictureBG.Tooltip := "Toggle BRAKES on/off"
		WinSetTransparent 75, myBrakeGui
	myBrakeGui.Show("NoActivate")

	SetTimer((*) => windowTrack18(myBrakeGui), 20)
	windowTrack18(myBrakeGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myBrakeGui.Move(windowX + 1137, windowY + 622)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Displays a Blue WAYPOINT rectangle (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)
	; x681 y901 w76 h43 
	myWaypointGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myWaypointGui.MarginX := myWaypointGui.MarginY := 1
	myWaypointGui.BackColor := "59601c"
		myPictureBG := myWaypointGui.Add("Picture", "0x0100 w76 h43", "yellow.png")
		myPictureBG.Tooltip := "Display Blue WAYPOINT screen"
		WinSetTransparent 75, myWaypointGui
	myWaypointGui.Show("NoActivate")

	SetTimer((*) => windowTrack19(myWaypointGui), 20)
	windowTrack19(myWaypointGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myWaypointGui.Move(windowX + 681, windowY + 901)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a Ordnance rectangle (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
	; x761 y901 w76 h43 
	myOrdnanceGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myOrdnanceGui.MarginX := myOrdnanceGui.MarginY := 1
	myOrdnanceGui.BackColor := "59601c"
		myPictureBG := myOrdnanceGui.Add("Picture", "0x0100 w76 h43", "yellow.png")
		myPictureBG.Tooltip := "Display ORDNANCE screen"
		WinSetTransparent 75, myOrdnanceGui
	myOrdnanceGui.Show("NoActivate")

	SetTimer((*) => windowTrack20(myOrdnanceGui), 20)
	windowTrack20(myOrdnanceGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myOrdnanceGui.Move(windowX + 761, windowY + 901)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays an Objectives rectangle (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
	; x841 y901 w76 h43 
	myObjectivesGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myObjectivesGui.MarginX := myObjectivesGui.MarginY := 1
	myObjectivesGui.BackColor := "59601c"
		myPictureBG := myObjectivesGui.Add("Picture", "0x0100 w76 h43", "yellow.png")
		myPictureBG.Tooltip := "Display OBJECTIVES screen"
		WinSetTransparent 75, myObjectivesGui
	myObjectivesGui.Show("NoActivate")

	SetTimer((*) => windowTrack21(myObjectivesGui), 20)
	windowTrack21(myObjectivesGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myObjectivesGui.Move(windowX + 841, windowY + 901)        
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

	
	
	; Displays a FLIR rectangle (QWERTY: F6 / QWERTZ: F6 / AZERTY: F6)
	; x929 y915 w72 h43 
	myFlirGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myFlirGui.MarginX := myFlirGui.MarginY := 1
	myFlirGui.BackColor := "59601c"
		myPictureBG := myFlirGui.Add("Picture", "0x0100 w72 h43", "yellow.png")
		myPictureBG.Tooltip := "Turn FLIR on/off"
		WinSetTransparent 75, myFlirGui
	myFlirGui.Show("NoActivate")

	SetTimer((*) => windowTrack22(myFlirGui), 20)
	windowTrack22(myFlirGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myFlirGui.Move(windowX + 929, windowY + 915)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a EJECT rectangle (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
	; the yellow and black stripes plate located on the right side
	; x1233 y685 w40 h187 
	myEjectGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myEjectGui.MarginX := myEjectGui.MarginY := 1
	myEjectGui.BackColor := "59601c"
		myPictureBG := myEjectGui.Add("Picture", "0x0100 w40 h187", "yellow.png")
		myPictureBG.Tooltip := "Press button for 2 seconds to activate EJECTION seat"
		WinSetTransparent 75, myEjectGui
	myEjectGui.Show("NoActivate")

	SetTimer((*) => windowTrack23(myEjectGui), 20)
	windowTrack23(myEjectGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myEjectGui.Move(windowX + 1233, windowY + 685)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N)
	; the 4th button at the bottom right side of the right MFD
	; x997 y738 w24 h29 
	myNewTargetGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNewTargetGui.MarginX := myNewTargetGui.MarginY := 1
	myNewTargetGui.BackColor := "59601c"
		myPictureBG := myNewTargetGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "Designate new target"
		WinSetTransparent 75, myNewTargetGui
	myNewTargetGui.Show("NoActivate")

	SetTimer((*) => windowTrack24(myNewTargetGui), 20)
	windowTrack24(myNewTargetGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myNewTargetGui.Move(windowX + 997, windowY + 738)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 	
	; the 5th button at the bottom right side of the right MFD
	; x997 y790 w24 h29 
	mySelectTargetGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	mySelectTargetGui.MarginX := mySelectTargetGui.MarginY := 1
	mySelectTargetGui.BackColor := "59601c"
		myPictureBG := mySelectTargetGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "Select Target"
		WinSetTransparent 75, mySelectTargetGui
	mySelectTargetGui.Show("NoActivate")

	SetTimer((*) => windowTrack25(mySelectTargetGui), 20)
	windowTrack25(mySelectTargetGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			mySelectTargetGui.Move(windowX + 997, windowY + 790)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	

		
		
		; Changes cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C)
	;	myCockpitViewGui := Gui()
	;	myCockpitViewGui.BackColor := "Yellow"
	;	myCockpitViewGui.Opt("+AlwaysOnTop -Caption +ToolWindow")
	;	WinSetTransparent 75, myCockpitViewGui
	;	myCockpitViewGui.Show("x997 y790 w24 h29")

	
	
	; CAM Ahead (QWERTY: / / QWERTZ: / / AZERTY: !)
	; 1st MFD button from the top on the left side of the right MFD
	; x645 y570 w24 h28 
	myCAMAheadGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMAheadGui.MarginX := myCAMAheadGui.MarginY := 1
	myCAMAheadGui.BackColor := "59601c"
		myPictureBG := myCAMAheadGui.Add("Picture", "0x0100 w24 h28", "yellow.png")
		myPictureBG.Tooltip := "View CAM ahead"
		WinSetTransparent 75, myCAMAheadGui
	myCAMAheadGui.Show("NoActivate")

	SetTimer((*) => windowTrack26(myCAMAheadGui), 20)
	windowTrack26(myCAMAheadGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myCAMAheadGui.Move(windowX + 645, windowY + 570)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}		
	
	; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
	; 2nd MFD button from the top on the left side of the right MFD
	; x645 y622 w24 h29 
	myCAMRearGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMRearGui.MarginX := myCAMRearGui.MarginY := 1
	myCAMRearGui.BackColor := "59601c"
		myPictureBG := myCAMRearGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "View CAM rear"
		WinSetTransparent 75, myCAMRearGui
	myCAMRearGui.Show("NoActivate")

	SetTimer((*) => windowTrack27(myCAMRearGui), 20)
	windowTrack27(myCAMRearGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myCAMRearGui.Move(windowX + 645, windowY + 622)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
		
	; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
	; 3rd MFD button from the top on the left side of the right MFD
	; x645 y675 w24 h29 
	myCAMRightGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMRightGui.MarginX := myCAMRightGui.MarginY := 1
	myCAMRightGui.BackColor := "59601c"
		myPictureBG := myCAMRightGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "View CAM right"
		WinSetTransparent 75, myCAMRightGui
	myCAMRightGui.Show("NoActivate")

	SetTimer((*) => windowTrack28(myCAMRightGui), 20)
	windowTrack28(myCAMRightGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myCAMRightGui.Move(windowX + 645, windowY + 675)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}

	; CAM left (QWERTY: M / QWERTZ: M / AZERTY: ,)
	; 4th MFD button from the top on the left side of the right MFD
	; x645 y738 w24 h28 
	myCAMLeftGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMLeftGui.MarginX := myCAMLeftGui.MarginY := 1
	myCAMLeftGui.BackColor := "59601c"
		myPictureBG := myCAMLeftGui.Add("Picture", "0x0100 w24 h28", "yellow.png")
		myPictureBG.Tooltip := "View CAM left"
		WinSetTransparent 75, myCAMLeftGui
	myCAMLeftGui.Show("NoActivate")

	SetTimer((*) => windowTrack29(myCAMLeftGui), 20)
	windowTrack29(myCAMLeftGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myCAMLeftGui.Move(windowX + 645, windowY + 738)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
		
	; Extra CAM button 
	; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
	; x761 y949 w156 h43 
	myExtraCAMGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myExtraCAMGui.MarginX := myExtraCAMGui.MarginY := 1
	myExtraCAMGui.BackColor := "59601c"
		myPictureBG := myExtraCAMGui.Add("Picture", "0x0100 w156 h43", "yellow.png")
		myPictureBG.Tooltip := "Toggle between camera views"
		WinSetTransparent 75, myExtraCAMGui
	myExtraCAMGui.Show("NoActivate")

	SetTimer((*) => windowTrack30(myExtraCAMGui), 20)
	windowTrack30(myExtraCAMGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myExtraCAMGui.Move(windowX + 761, windowY + 949)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	
	
	; Volume adjust (Alt V)
	
	
		
	; Displays an Accelerate rectangle (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
	; the left button at the bottom of the right MFD
	; x829 y858 w24 h28 
	myAccelerateGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myAccelerateGui.MarginX := myAccelerateGui.MarginY := 1
	myAccelerateGui.BackColor := "59601c"
		myPictureBG := myAccelerateGui.Add("Picture", "0x0100 w24 h28", "yellow.png")
		myPictureBG.Tooltip := "Accelerate game"
		WinSetTransparent 75, myAccelerateGui
	myAccelerateGui.Show("NoActivate")

	SetTimer((*) => windowTrack31(myAccelerateGui), 20)
	windowTrack31(myAccelerateGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myAccelerateGui.Move(windowX + 829, windowY + 858)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}

	; Displays a Normal Speed rectangle (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
	; the middle button at the bottom of the right MFD
	; x873 y858 w24 h28 
	myNormalSpeedGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNormalSpeedGui.MarginX := myNormalSpeedGui.MarginY := 1
	myNormalSpeedGui.BackColor := "59601c"
		myPictureBG := myNormalSpeedGui.Add("Picture", "0x0100 w24 h28", "yellow.png")
		myPictureBG.Tooltip := "Normal game speed"
		WinSetTransparent 75, myNormalSpeedGui
	myNormalSpeedGui.Show("NoActivate")

	SetTimer((*) => windowTrack32(myNormalSpeedGui), 20)
	windowTrack32(myNormalSpeedGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myNormalSpeedGui.Move(windowX + 873, windowY + 858)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
			
	; Displays a Pause rectangle (QWERTY: ALT P / QWERTZ: ALT P / AZERTY: ALT P)
	; the right button at the bottom of the right MFD
	; x921 y858 w24 h28 
	myPauseGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myPauseGui.MarginX := myPauseGui.MarginY := 1
	myPauseGui.BackColor := "59601c"
		myPictureBG := myPauseGui.Add("Picture", "0x0100 w24 h28", "yellow.png")
		myPictureBG.Tooltip := "Pause game"
		WinSetTransparent 75, myPauseGui
	myPauseGui.Show("NoActivate")

	SetTimer((*) => windowTrack33(myPauseGui), 20)
	windowTrack33(myPauseGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myPauseGui.Move(windowX + 921, windowY + 858)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}
	
	
	
	; Toggle HUD color (F4) 
	
	
		
	; Changes cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C)
	; the second button from the right of the top row buttons of the right MFD
	; x877 y526 w24 h29 
	myChangeCockpitViewGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myChangeCockpitViewGui.MarginX := myChangeCockpitViewGui.MarginY := 1
	myChangeCockpitViewGui.BackColor := "59601c"
		myPictureBG := myChangeCockpitViewGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "Change cockpit view"
		WinSetTransparent 75, myChangeCockpitViewGui
	myChangeCockpitViewGui.Show("NoActivate")

	SetTimer((*) => windowTrack34(myChangeCockpitViewGui), 20)
	windowTrack34(myChangeCockpitViewGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myChangeCockpitViewGui.Move(windowX + 877, windowY + 526)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a de-clutter HUD rectangle (QWERTY: V / QWERTZ: V / AZERTY: V)
	; the first button on the right of the top row buttons of the right MFD
	; x922 y526 w24 h29 
	myDeClutterGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myDeClutterGui.MarginX := myDeClutterGui.MarginY := 1
	myDeClutterGui.BackColor := "59601c"
		myPictureBG := myDeClutterGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "De-Clutter HUD"
		WinSetTransparent 75, myDeClutterGui
	myDeClutterGui.Show("NoActivate")

	SetTimer((*) => windowTrack35(myDeClutterGui), 20)
	windowTrack35(myDeClutterGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myDeClutterGui.Move(windowX + 922, windowY + 526)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a Maximum Power rectangle (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
	; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
	; x262 y560 w24 h29 
	myMaximumPowerGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMaximumPowerGui.MarginX := myMaximumPowerGui.MarginY := 1
	myMaximumPowerGui.BackColor := "59601c"
		myPictureBG := myMaximumPowerGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "Maximum power"
		WinSetTransparent 75, myMaximumPowerGui
	myMaximumPowerGui.Show("NoActivate")

	SetTimer((*) => windowTrack36(myMaximumPowerGui), 20)
	windowTrack36(myMaximumPowerGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myMaximumPowerGui.Move(windowX + 262, windowY + 560)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays an Increase Throttle rectangle (QWERTY: = / QWERTZ: ´ / AZERTY: =)
	; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
	; x262 y622 w24 h29 
	myIncreaseThrottleGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myIncreaseThrottleGui.MarginX := myIncreaseThrottleGui.MarginY := 1
	myIncreaseThrottleGui.BackColor := "59601c"
		myPictureBG := myIncreaseThrottleGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "Increase power"
		WinSetTransparent 75, myIncreaseThrottleGui
	myIncreaseThrottleGui.Show("NoActivate")

	SetTimer((*) => windowTrack37(myIncreaseThrottleGui), 20)
	windowTrack37(myIncreaseThrottleGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myIncreaseThrottleGui.Move(windowX + 262, windowY + 622)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
		
	; Displays a 50% Throttle rectangle (detects the current speed and changes it accordingly)
	; x262 y680 w24 h29 
	myFiftyThrottleGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myFiftyThrottleGui.MarginX := myFiftyThrottleGui.MarginY := 1
	myFiftyThrottleGui.BackColor := "59601c"
		myPictureBG := myFiftyThrottleGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "Half power"
		WinSetTransparent 75, myFiftyThrottleGui
	myFiftyThrottleGui.Show("NoActivate")

	SetTimer((*) => windowTrack38(myFiftyThrottleGui), 20)
	windowTrack38(myFiftyThrottleGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myFiftyThrottleGui.Move(windowX + 262, windowY + 680)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a Decrease Throttle rectangle (QWERTY: - / QWERTZ: ß / AZERTY: ))
	; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
	; x262 y733 w24 h29 
	myDecreaseThrottleGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myDecreaseThrottleGui.MarginX := myDecreaseThrottleGui.MarginY := 1
	myDecreaseThrottleGui.BackColor := "59601c"
		myPictureBG := myDecreaseThrottleGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "Decrease power"
		WinSetTransparent 75, myDecreaseThrottleGui
	myDecreaseThrottleGui.Show("NoActivate")

	SetTimer((*) => windowTrack39(myDecreaseThrottleGui), 20)
	windowTrack39(myDecreaseThrottleGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myDecreaseThrottleGui.Move(windowX + 262, windowY + 733)
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
	
	; Displays a No Power rectangle (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
	; x262 y795 w24 h29 
	myNoPowerGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNoPowerGui.MarginX := myNoPowerGui.MarginY := 1
	myNoPowerGui.BackColor := "59601c"
		myPictureBG := myNoPowerGui.Add("Picture", "0x0100 w24 h29", "yellow.png")
		myPictureBG.Tooltip := "No power"
		WinSetTransparent 75, myNoPowerGui
	myNoPowerGui.Show("NoActivate")

	SetTimer((*) => windowTrack40(myNoPowerGui), 20)
	windowTrack40(myNoPowerGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "ahk_exe dosbox.exe") 
			myNoPowerGui.Move(windowX + 262, windowY + 795)        
		} else {
		; SoundBeep 750, 500
		ExitApp
		}
	}	
		
	
	
	; Resupply (training) (ALT R)









