#Requires AutoHotkey v2




	OnMessage(WM_MOUSEMOVE  := 0x0200, OnMouseEvent)
	OnMessage(WM_MOUSELEAVE := 0x02A3, OnMouseEvent)	





	; --------------------------------------------------		
	; OVERLAYS (displays rectangles over the cockpit buttons)
	; --------------------------------------------------

	; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollUp Zoom In (QWERTY: Z / QWERTZ: Y / AZERTY: W)
	myMFDZoomInMouseWheel := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomInMouseWheel.MarginX := myMFDZoomInMouseWheel.MarginY := 0
	myMFDZoomInMouseWheelTooltip := myMFDZoomInMouseWheel.Add("Button","w308 h288","")
	myMFDZoomInMouseWheelTooltip.TT := "Use mouse wheel up or down to zoom in/out"
	; myMFDZoomInMouseWheelTooltip.Color := "Yellow"
	; myMFDZoomInMouseWheelPicture := myMFDZoomInMouseWheel.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myMFDZoomInMouseWheel
	; WinSetTransparent 75, myMFDZoomInMouseWheelTooltip
	myMFDZoomInMouseWheel.Show()
	SetTimer((*) => windowTrack01(myMFDZoomInMouseWheel), 20)	
	windowTrack01(myMFDZoomInMouseWheel) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myMFDZoomInMouseWheel.Move(windowX + 298, windowY + 560)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays an area over the MAPTAC MFD for Mouse Wheel ScrollDown Zoom Out (QWERTY: X / QWERTZ: X / AZERTY: X)
	myMFDZoomOutMouseWheel := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomOutMouseWheel.MarginX := myMFDZoomOutMouseWheel.MarginY := 0
	myMFDZoomOutMouseWheelTooltip := myMFDZoomOutMouseWheel.Add("Button","w308 h288","")
	myMFDZoomOutMouseWheelTooltip.TT := "Use mouse wheel up or down to zoom in/out"
	; myMFDZoomOutMouseWheelTooltip.Color := "Yellow"
	; myMFDZoomOutMouseWheelPicture := myMFDZoomOutMouseWheel.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myMFDZoomOutMouseWheel
	; WinSetTransparent 75, myMFDZoomOutMouseWheelTooltip	
	myMFDZoomOutMouseWheel.Show()	
	SetTimer((*) => WindowTrack02(myMFDZoomOutMouseWheel), 20)
	WindowTrack02(myMFDZoomOutMouseWheel) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myMFDZoomOutMouseWheel.Move(windowX + 298, windowY + 560)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
		
	; Displays a wide MAPTAC button (QWERTY: F3 / QWERTZ: F3 / AZERTY: F3)
	myMAPTACGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMAPTACGui.MarginX := myMAPTACGui.MarginY := 0
	myMAPTACButton := myMAPTACGui.Add("Button","Default w156 h44","")
	myMAPTACButton.TT := "Toggle MFD between MAP and TAC view"
	; myMAPTACButton.Color := "Yellow"
	; myMAPTACButtonPicture := myMAPTACGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myMAPTACGui
	; WinSetTransparent 75, myMAPTACButtonTooltip
	myMAPTACButton.OnEvent("Click", myMAPTACButton_Click)
	myMAPTACGui.Show()	
	SetTimer((*) => WindowTrack03(myMAPTACGui), 20)
	WindowTrack03(myMAPTACGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox")
			myMAPTACGui.Move(windowX + 322, windowY + 862)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a MFD Zoom In button (QWERTY: Z / QWERTZ: Y / AZERTY: W)
	myMFDZoomInGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomInGui.MarginX := myMFDZoomInGui.MarginY := 0
	myMFDZoomInButton := myMFDZoomInGui.Add("Button","Default w28 h29","")
	myMFDZoomInButton.TT := "Zoom MFD in"
	; myMFDZoomInButton.Color := "Yellow"
	; myMFDZoomInGuiPicture := myMFDZoomInGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myMFDZoomInGui
	; WinSetTransparent 75, myMFDZoomInButton	
	myMFDZoomInButton.OnEvent("Click", myMFDZoomInButton_Click)
	myMFDZoomInGui.Show()
	SetTimer((*) => windowTrack04(myMFDZoomInGui), 20)
	windowTrack04(myMFDZoomInGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myMFDZoomInGui.Move(windowX + 514, windowY + 867)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a MFD Zoom Out button (QWERTY: X / QWERTZ: X / AZERTY: X)
	myMFDZoomOutGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMFDZoomOutGui.MarginX := myMFDZoomOutGui.MarginY := 0
	myMFDZoomOutButton := myMFDZoomOutGui.Add("Button","Default w28 h29","")
	myMFDZoomOutButton.TT := "Zoom MFD out"
	; myMFDZoomOutButton.Color := "Yellow"
	; myMFDZoomOutGuiPicture := myMFDZoomOutGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myMFDZoomOutGui
	; WinSetTransparent 75, myMFDZoomOutButton
	myMFDZoomOutButton.OnEvent("Click", myMFDZoomOutButton_Click)
	myMFDZoomOutGui.Show()
	SetTimer((*) => windowTrack05(myMFDZoomOutGui), 20)
	windowTrack05(myMFDZoomOutGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myMFDZoomOutGui.Move(windowX + 562, windowY + 867)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}

	; Displays a CHAFF button (QWERTY: 2 / QWERTZ: 2 / AZERTY: é)
	myChaffGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myChaffGui.MarginX := myChaffGui.MarginY := 0
	myChaffButton := myChaffGui.Add("Button","Default w104 h44","")
	myChaffButton.TT := "Release a CHAFF"
	; myChaffButton.Color := "Yellow"
	; myChaffGuiPicture := myChaffGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myChaffGui
	; WinSetTransparent 75, myChaffButton
	myChaffButton.OnEvent("Click", myChaffButton_Click)
	myChaffGui.Show()
	SetTimer((*) => windowTrack06(myChaffGui), 20)
	windowTrack06(myChaffGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myChaffGui.Move(windowX + 14, windowY + 742)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
		
	; Displays a FLARE button (QWERTY: 1 / QWERTZ: 1 / AZERTY: &)
	myFlareGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myFlareGui.MarginX := myFlareGui.MarginY := 0
	myFlareButton := myFlareGui.Add("Button","Default w104 h44","")
	myFlareButton.TT := "Release a FLARE"
	; myFlareButton.Color := "Yellow"
	; myFlareGuiPicture := myFlareGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myFlareGui
	; WinSetTransparent 75, myFlareButton
	myFlareButton.OnEvent("Click", myFlareButton_Click)
	myFlareGui.Show()
	SetTimer((*) => windowTrack07(myFlareGui), 20)
	windowTrack07(myFlareGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myFlareGui.Move(windowX + 14, windowY + 790)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a DECOY button (QWERTY: 5 / QWERTZ: 5 / AZERTY: ()
	myDecoyGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myDecoyGui.MarginX := myDecoyGui.MarginY := 0
	myDecoyButton := myDecoyGui.Add("Button","Default w104 h44","")
	myDecoyButton.TT := "Release a DECOY"
	; myDecoyButton.Color := "Yellow"
	; myDecoyGuiPicture := myDecoyGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myDecoyGui
	; WinSetTransparent 75, myDecoyButton
	myDecoyButton.OnEvent("Click", myDecoyButton_Click)
	myDecoyGui.Show()
	SetTimer((*) => windowTrack08(myDecoyGui), 20)
	windowTrack08(myDecoyGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myDecoyGui.Move(windowX + 14, windowY + 838)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a ECM button (QWERTY: 4 / QWERTZ: 4 / AZERTY: ')
	myECMGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myECMGui.MarginX := myECMGui.MarginY := 0
	myECMButton := myECMGui.Add("Button","Default w116 h43","")
	myECMButton.TT := "Turn ECM on/off"
	; myECMButton.Color := "Yellow"
	; myECMGuiPicture := myECMGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myECMGui
	; WinSetTransparent 75, myECMButton
	myECMButton.OnEvent("Click", myECMButton_Click)
	myECMGui.Show()
	SetTimer((*) => windowTrack09(myECMGui), 20)
	windowTrack09(myECMGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myECMGui.Move(windowX + 18, windowY + 891)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a IR Jammer button (QWERTY: 3 / QWERTZ: 3 / AZERTY: ")
	myIRJammerGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myIRJammerGui.MarginX := myIRJammerGui.MarginY := 0
	myIRJammerButton := myIRJammerGui.Add("Button","Default w108 h43","")
	myIRJammerButton.TT := "Turn IR Jammer on/off"
	; myIRJammerButton.Color := "Yellow"
	; myIRJammerGuiPicture := myIRJammerGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myIRJammerGui
	; WinSetTransparent 75, myIRJammerButton
	myIRJammerButton.OnEvent("Click", myIRJammerButton_Click)
	myIRJammerGui.Show()
	SetTimer((*) => windowTrack10(myIRJammerGui), 20)
	windowTrack10(myIRJammerGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myIRJammerGui.Move(windowX + 146, windowY + 891)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}

	; Select WEAPON (QWERTY: SPACE / QWERTZ: SPACE / AZERTY: SPACE)
	; the screw at the left of the NAV button 
	mySelectWeaponGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	mySelectWeaponGui.MarginX := mySelectWeaponGui.MarginY := 0
	mySelectWeaponButton := mySelectWeaponGui.Add("Button","Default w44 h48","")
	mySelectWeaponButton.TT := "Select Weapon"
	; mySelectWeaponButton.Color := "Yellow"
	; mySelectWeaponGuiPicture := mySelectWeaponGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, mySelectWeaponGui
	; WinSetTransparent 75, mySelectWeaponButton
	mySelectWeaponButton.OnEvent("Click", mySelectWeaponButton_Click)
	mySelectWeaponGui.Show()
	SetTimer((*) => windowTrack11(mySelectWeaponGui), 20)
	windowTrack11(mySelectWeaponGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			mySelectWeaponGui.Move(windowX + 414, windowY + 483)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a wide NAVAIRGND button (QWERTY: F2 / QWERTZ: F2 / AZERTY: F2)
	myNavAirGndGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNavAirGndGui.MarginX := myNavAirGndGui.MarginY := 0
	myNavAirGndButton := myNavAirGndGui.Add("Button","Default w235 h43","")
	myNavAirGndButton.TT := "Toggle between NAV/AIR/GND"
	; myNavAirGndButton.Color := "Yellow"
	; myNavAirGndGuiPicture := myNavAirGndGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myNavAirGndGui
	; WinSetTransparent 75, myNavAirGndButton
	myNavAirGndButton.OnEvent("Click", myNavAirGndButton_Click)
	myNavAirGndGui.Show()
	SetTimer((*) => windowTrack12(myNavAirGndGui), 20)
	windowTrack12(myNavAirGndGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myNavAirGndGui.Move(windowX + 478, windowY + 483)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Toggle ILS on/off (QWERTY: F9 / QWERTZ: F9 / AZERTY: F9)
	; the rounded button at the right of LOCK
	myILSGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myILSGui.MarginX := myILSGui.MarginY := 0
	myILSButton := myILSGui.Add("Button","Default w28 h29","")
	myILSButton.TT := "Toggle ILS on/off"
	; myILSButton.Color := "Yellow"
	; myILSGuiPicture := myILSGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myILSGui
	; WinSetTransparent 75, myILSButton
	myILSButton.OnEvent("Click", myILSButton_Click)
	myILSGui.Show()
	SetTimer((*) => windowTrack13(myILSGui), 20)
	windowTrack13(myILSGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myILSGui.Move(windowX + 845, windowY + 488)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}

	; Displays a BAY button (QWERTY: 8 / QWERTZ: 8 / AZERTY: _)
	myBayGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myBayGui.MarginX := myBayGui.MarginY := 0
	myBayButton := myBayGui.Add("Button","Default w104 h44","")
	myBayButton.TT := "Toggle BAY on/off"
	; myBayButton.Color := "Yellow"
	; myBayGuiPicture := myBayGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myBayGui
	; WinSetTransparent 75, myBayButton
	myBayButton.OnEvent("Click", myBayButton_Click)
	myBayGui.Show()
	SetTimer((*) => windowTrack14(myBayGui), 20)
	windowTrack14(myBayGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myBayGui.Move(windowX + 1029, windowY + 526)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}

	; Displays an AUTOPILOT button (QWERTY: 7 / QWERTZ: 7 / AZERTY: è)
	myAutopilotGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myAutopilotGui.MarginX := myAutopilotGui.MarginY := 0
	myAutopilotButton := myAutopilotGui.Add("Button","Default w104 h44","")
	myAutopilotButton.TT := "Toggle AUTOPILOT on/off"
	; myAutopilotButton.Color := "Yellow"
	; myAutopilotGuiPicture := myAutopilotGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myAutopilotGui
	; WinSetTransparent 75, myAutopilotButton
	myAutopilotButton.OnEvent("Click", myAutopilotButton_Click)
	myAutopilotGui.Show()
	SetTimer((*) => windowTrack15(myAutopilotGui), 20)
	windowTrack15(myAutopilotGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myAutopilotGui.Move(windowX + 1029, windowY + 574)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a GEAR button (QWERTY: 6 / QWERTZ: 6 / AZERTY: -)
	myGearGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myGearGui.MarginX := myGearGui.MarginY := 0
	myGearButton := myGearGui.Add("Button","Default w104 h44","")
	myGearButton.TT := "Toggle GEAR on/off"
	; myGearButton.Color := "Yellow"
	; myGearGuiPicture := myGearGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myGearGui
	; WinSetTransparent 75, myGearButton
	myGearButton.OnEvent("Click", myGearButton_Click)
	myGearGui.Show()
	SetTimer((*) => windowTrack16(myGearGui), 20)
	windowTrack16(myGearGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myGearGui.Move(windowX + 1029, windowY + 622)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a FLAPS button (QWERTY: 9 / QWERTZ: 9 / AZERTY: ç)
	myFlapsGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myFlapsGui.MarginX := myFlapsGui.MarginY := 0
	myFlapsButton := myFlapsGui.Add("Button","Default w104 h44","")
	myFlapsButton.TT := "Toggle FLAPS on/off"
	; myFlapsButton.Color := "Yellow"
	; myFlapsGuiPicture := myFlapsGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myFlapsGui
	; WinSetTransparent 75, myFlapsButton
	myFlapsButton.OnEvent("Click", myFlapsButton_Click)
	myFlapsGui.Show()
	SetTimer((*) => windowTrack17(myFlapsGui), 20)
	windowTrack17(myFlapsGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myFlapsGui.Move(windowX + 1137, windowY + 574)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a BRAKE button (0)
	myBrakeGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myBrakeGui.MarginX := myBrakeGui.MarginY := 0
	myBrakeButton := myBrakeGui.Add("Button","Default w104 h44","")
	myBrakeButton.TT := "Toggle BRAKES on/off"
	; myBrakeButton.Color := "Yellow"
	; myBrakeGuiPicture := myBrakeGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myBrakeGui
	; WinSetTransparent 75, myBrakeButton
	myBrakeButton.OnEvent("Click", myBrakeButton_Click)
	myBrakeGui.Show()
	SetTimer((*) => windowTrack18(myBrakeGui), 20)
	windowTrack18(myBrakeGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myBrakeGui.Move(windowX + 1137, windowY + 622)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a Blue WAYPOINT button (QWERTY: F7 / QWERTZ: F7 / AZERTY: F7)
	myWaypointGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myWaypointGui.MarginX := myWaypointGui.MarginY := 0
	myWaypointButton := myWaypointGui.Add("Button","Default w76 h43","")
	myWaypointButton.TT := "Display Blue WAYPOINT screen"
	; myWaypointButton.Color := "Yellow"
	; myWaypointGuiPicture := myWaypointGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myWaypointGui
	; WinSetTransparent 75, myWaypointButton
	myWaypointButton.OnEvent("Click", myWaypointButton_Click)
	myWaypointGui.Show()
	SetTimer((*) => windowTrack19(myWaypointGui), 20)
	windowTrack19(myWaypointGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myWaypointGui.Move(windowX + 681, windowY + 901)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}	
	
	; Displays a Ordnance button (QWERTY: F5 / QWERTZ: F5 / AZERTY: F5)
	myOrdnanceGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myOrdnanceGui.MarginX := myOrdnanceGui.MarginY := 0
	myOrdnanceButton := myOrdnanceGui.Add("Button","Default w76 h43","")
	myOrdnanceButton.TT := "Display ORDNANCE screen"
	; myOrdnanceButton.Color := "Yellow"
	; myOrdnanceGuiPicture := myOrdnanceGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myOrdnanceGui
	; WinSetTransparent 75, myOrdnanceButton
	myOrdnanceButton.OnEvent("Click", myOrdnanceButton_Click)
	myOrdnanceGui.Show()
	SetTimer((*) => windowTrack20(myOrdnanceGui), 20)
	windowTrack20(myOrdnanceGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myOrdnanceGui.Move(windowX + 761, windowY + 901)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays an Objectives button (QWERTY: F10 / QWERTZ: F10 / AZERTY: F10)
	myObjectivesGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myObjectivesGui.MarginX := myObjectivesGui.MarginY := 0
	myObjectivesButton := myObjectivesGui.Add("Button","Default w76 h43","")
	myObjectivesButton.TT := "Display OBJECTIVES screen"
	; myObjectivesButton.Color := "Yellow"
	; myObjectivesGuiPicture := myObjectivesGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myObjectivesGui
	; WinSetTransparent 75, myObjectivesButton
	myObjectivesButton.OnEvent("Click", myObjectivesButton_Click)
	myObjectivesGui.Show()
	SetTimer((*) => windowTrack21(myObjectivesGui), 20)
	windowTrack21(myObjectivesGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
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

	
	
	; Displays a FLIR button (QWERTY: F6 / QWERTZ: F6 / AZERTY: F6)
	myFlirGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myFlirGui.MarginX := myFlirGui.MarginY := 0
	myFlirButton := myFlirGui.Add("Button","Default w72 h43","")
	myFlirButton.TT := "Turn FLIR on/off"
	; myFlirButton.Color := "Yellow"
	; myFlirGuiPicture := myFlirGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myFlirGui
	; WinSetTransparent 75, myFlirButton
	myFlirButton.OnEvent("Click", myFlirButton_Click)
	myFlirGui.Show()
	SetTimer((*) => windowTrack22(myFlirGui), 20)
	windowTrack22(myFlirGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myFlirGui.Move(windowX + 929, windowY + 915)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a EJECT button (QWERTY: SHIFT F10 / QWERTZ: SHIFT F10 / AZERTY: SHIFT F10) 
	; the yellow and black stripes plate located on the right side
	myEjectGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myEjectGui.MarginX := myEjectGui.MarginY := 0
	myEjectButton := myEjectGui.Add("Button","Default w40 h187","")
	myEjectButton.TT := "Press button for 2 seconds to activate EJECTION seat"
	; myEjectButton.Color := "Yellow"
	; myEjectGuiPicture := myEjectGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myEjectGui
	; WinSetTransparent 75, myEjectButton
	myEjectButton.OnEvent("Click", myEjectButton_Click)
	myEjectGui.Show()
	SetTimer((*) => windowTrack23(myEjectGui), 20)
	windowTrack23(myEjectGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myEjectGui.Move(windowX + 1233, windowY + 685)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Designates New Target (QWERTY: N / QWERTZ: N / AZERTY: N)
	; the 4th button at the bottom right side of the right MFD
	myNewTargetGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNewTargetGui.MarginX := myNewTargetGui.MarginY := 0
	myNewTargetButton := myNewTargetGui.Add("Button","Default w24 h29","")
	myNewTargetButton.TT := "Designate new target"
	; myNewTargetButton.Color := "Yellow"
	; myNewTargetGuiPicture := myNewTargetGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myNewTargetGui
	; WinSetTransparent 75, myNewTargetButton
	myNewTargetButton.OnEvent("Click", myNewTargetButton_Click)
	myNewTargetGui.Show()
	SetTimer((*) => windowTrack24(myNewTargetGui), 20)
	windowTrack24(myNewTargetGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myNewTargetGui.Move(windowX + 997, windowY + 738)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}	
	
	; Selects Target (QWERTY: B / QWERTZ: B / AZERTY: B) 	
	; the 5th button at the bottom right side of the right MFD
	mySelectTargetGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	mySelectTargetGui.MarginX := mySelectTargetGui.MarginY := 0
	mySelectTargetButton := mySelectTargetGui.Add("Button","Default w24 h29","")
	mySelectTargetButton.TT := "Select Target"
	; mySelectTargetButton.Color := "Yellow"
	; mySelectTargetGuiPicture := mySelectTargetGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, mySelectTargetGui
	; WinSetTransparent 75, mySelectTargetButton
	mySelectTargetButton.OnEvent("Click", mySelectTargetButton_Click)
	mySelectTargetGui.Show()
	SetTimer((*) => windowTrack25(mySelectTargetGui), 20)
	windowTrack25(mySelectTargetGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			mySelectTargetGui.Move(windowX + 997, windowY + 790)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; CAM Ahead (QWERTY: / / QWERTZ: / / AZERTY: !)
	; 1st MFD button from the top on the left side of the right MFD
	myCAMAheadGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMAheadGui.MarginX := myCAMAheadGui.MarginY := 0
	myCAMAheadButton := myCAMAheadGui.Add("Button","Default w24 h28","")
	myCAMAheadButton.TT := "View CAM ahead"
	; myCAMAheadButton.Color := "Yellow"
	; myCAMAheadGuiPicture := myCAMAheadGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myCAMAheadGui
	; WinSetTransparent 75, myCAMAheadButton
	myCAMAheadButton.OnEvent("Click", myCAMAheadButton_Click)
	myCAMAheadGui.Show()
	SetTimer((*) => windowTrack26(myCAMAheadGui), 20)
	windowTrack26(myCAMAheadGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myCAMAheadGui.Move(windowX + 645, windowY + 570)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; CAM Rear (QWERTY: > / QWERTZ: > / AZERTY: :)
	; 2nd MFD button from the top on the left side of the right MFD
	myCAMRearGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMRearGui.MarginX := myCAMRearGui.MarginY := 0
	myCAMRearButton := myCAMRearGui.Add("Button","Default w24 h29","")
	myCAMRearButton.TT := "View CAM rear"
	; myCAMRearButton.Color := "Yellow"
	; myCAMRearGuiPicture := myCAMRearGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myCAMRearGui
	; WinSetTransparent 75, myCAMRearButton
	myCAMRearButton.OnEvent("Click", myCAMRearButton_Click)
	myCAMRearGui.Show()
	SetTimer((*) => windowTrack27(myCAMRearGui), 20)
	windowTrack27(myCAMRearGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myCAMRearGui.Move(windowX + 645, windowY + 622)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
		
	; CAM Right (QWERTY: < / QWERTZ: < / AZERTY: ;)
	; 3rd MFD button from the top on the left side of the right MFD
	myCAMRightGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMRightGui.MarginX := myCAMRightGui.MarginY := 0
	myCAMRightButton := myCAMRightGui.Add("Button","Default w24 h29","")
	myCAMRightButton.TT := "View CAM right"
	; myCAMRightButton.Color := "Yellow"
	; myCAMRightGuiPicture := myCAMRightGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myCAMRightGui
	; WinSetTransparent 75, myCAMRightButton
	myCAMRightButton.OnEvent("Click", myCAMRightButton_Click)
	myCAMRightGui.Show()
	SetTimer((*) => windowTrack28(myCAMRightGui), 20)
	windowTrack28(myCAMRightGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myCAMRightGui.Move(windowX + 645, windowY + 675)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}

	; CAM left (QWERTY: M / QWERTZ: M / AZERTY: ,)
	; 4th MFD button from the top on the left side of the right MFD
	myCAMLeftGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myCAMLeftGui.MarginX := myCAMLeftGui.MarginY := 0
	myCAMLeftButton := myCAMLeftGui.Add("Button","Default w24 h28","")
	myCAMLeftButton.TT := "View CAM left"
	; myCAMLeftButton.Color := "Yellow"
	; myCAMLeftGuiPicture := myCAMLeftGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myCAMLeftGui
	; WinSetTransparent 75, myCAMLeftButton
	myCAMLeftButton.OnEvent("Click", myCAMLeftButton_Click)
	myCAMLeftGui.Show()
	SetTimer((*) => windowTrack29(myCAMLeftGui), 20)
	windowTrack29(myCAMLeftGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myCAMLeftGui.Move(windowX + 645, windowY + 738)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}	
		
	; Extra CAM button 
	; Uses the wide bar below the right MFD to circle through Tracking CAMs (ahead, rear, left, right)
	myExtraCAMGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myExtraCAMGui.MarginX := myExtraCAMGui.MarginY := 0
	myExtraCAMButton := myExtraCAMGui.Add("Button","Default w156 h43","")
	myExtraCAMButton.TT := "Toggle between camera views"
	; myExtraCAMButton.Color := "Yellow"
	; myExtraCAMGuiPicture := myExtraCAMGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myExtraCAMGui
	; WinSetTransparent 75, myExtraCAMButton
	myExtraCAMButton.OnEvent("Click", myExtraCAMButton_Click)
	myExtraCAMGui.Show()
	SetTimer((*) => windowTrack30(myExtraCAMGui), 20)
	windowTrack30(myExtraCAMGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myExtraCAMGui.Move(windowX + 761, windowY + 949)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	
	
	; Volume adjust (Alt V)
	
	
		
	; Displays an Accelerate button (QWERTY: SHIFT Z / QWERTZ: SHIFT Y / AZERTY: SHIFT W)
	; the left button at the bottom of the right MFD
	myAccelerateGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myAccelerateGui.MarginX := myAccelerateGui.MarginY := 0
	myAccelerateButton := myAccelerateGui.Add("Button","Default w24 h28","")
	myAccelerateButton.TT := "Accelerate game"
	; myAccelerateButton.Color := "Yellow"
	; myAccelerateGuiPicture := myAccelerateGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myAccelerateGui
	; WinSetTransparent 75, myAccelerateButton
	myAccelerateButton.OnEvent("Click", myAccelerateButton_Click)
	myAccelerateGui.Show()
	SetTimer((*) => windowTrack31(myAccelerateGui), 20)
	windowTrack31(myAccelerateGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myAccelerateGui.Move(windowX + 829, windowY + 858)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}

	; Displays a Normal Speed button (QWERTY: SHIFT X / QWERTZ: SHIFT X / AZERTY: SHIFT X)
	; the middle button at the bottom of the right MFD
	myNormalSpeedGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNormalSpeedGui.MarginX := myNormalSpeedGui.MarginY := 0
	myNormalSpeedButton := myNormalSpeedGui.Add("Button","Default w24 h28","")
	myNormalSpeedButton.TT := "Normal game speed"
	; myNormalSpeedButton.Color := "Yellow"
	; myNormalSpeedGuiPicture := myNormalSpeedGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myNormalSpeedGui
	; WinSetTransparent 75, myNormalSpeedButton
	myNormalSpeedButton.OnEvent("Click", myNormalSpeedButton_Click)
	myNormalSpeedGui.Show()
	SetTimer((*) => windowTrack32(myNormalSpeedGui), 20)
	windowTrack32(myNormalSpeedGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myNormalSpeedGui.Move(windowX + 873, windowY + 858)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
			
	; Displays a Pause button (QWERTY: ALT P / QWERTZ: ALT P / AZERTY: ALT P)
	; the right button at the bottom of the right MFD
	myPauseGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myPauseGui.MarginX := myPauseGui.MarginY := 0
	myPauseButton := myPauseGui.Add("Button","Default w24 h28","")
	myPauseButton.TT := "Pause game"
	; myPauseButton.Color := "Yellow"
	; myPauseGuiPicture := myPauseGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myPauseGui
	; WinSetTransparent 75, myPauseButton
	myPauseButton.OnEvent("Click", myPauseButton_Click)
	myPauseGui.Show()
	SetTimer((*) => windowTrack33(myPauseGui), 20)
	windowTrack33(myPauseGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myPauseGui.Move(windowX + 921, windowY + 858)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	
	
	; Toggle HUD color (F4) 
	
	
	
	; Changes cockpit view (QWERTY: C / QWERTZ: C / AZERTY: C)
	; the second button from the right of the top row buttons of the right MFD
	myChangeCockpitViewGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myChangeCockpitViewGui.MarginX := myChangeCockpitViewGui.MarginY := 0
	myChangeCockpitViewButton := myChangeCockpitViewGui.Add("Button","Default w24 h29","")
	myChangeCockpitViewButton.TT := "Change cockpit view"
	; myChangeCockpitViewButton.Color := "Yellow"
	; myChangeCockpitViewGuiPicture := myChangeCockpitViewGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myChangeCockpitViewGui
	; WinSetTransparent 75, myChangeCockpitViewButton
	myChangeCockpitViewButton.OnEvent("Click", myChangeCockpitViewButton_Click)
	myChangeCockpitViewGui.Show()
	SetTimer((*) => windowTrack34(myChangeCockpitViewGui), 20)
	windowTrack34(myChangeCockpitViewGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox")
			myChangeCockpitViewGui.Move(windowX + 877, windowY + 526)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}

	; Displays a de-clutter HUD button (QWERTY: V / QWERTZ: V / AZERTY: V)
	; the first button on the right of the top row buttons of the right MFD
	myDeClutterGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myDeClutterGui.MarginX := myDeClutterGui.MarginY := 0
	myDeClutterButton := myDeClutterGui.Add("Button","Default w24 h29","")
	myDeClutterButton.TT := "De-Clutter HUD"
	; myDeClutterButton.Color := "Yellow"
	; myDeClutterGuiPicture := myDeClutterGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myDeClutterGui
	; WinSetTransparent 75, myDeClutterButton
	myDeClutterButton.OnEvent("Click", myDeClutterButton_Click)
	myDeClutterGui.Show()
	SetTimer((*) => windowTrack35(myDeClutterGui), 20)
	windowTrack35(myDeClutterGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox")
			myDeClutterGui.Move(windowX + 922, windowY + 526)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a Maximum Power button (QWERTY: SHIFT + / QWERTZ: SHIFT ` / AZERTY: SHIFT =)
	; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
	myMaximumPowerGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myMaximumPowerGui.MarginX := myMaximumPowerGui.MarginY := 0
	myMaximumPowerButton := myMaximumPowerGui.Add("Button","Default w24 h29","")
	myMaximumPowerButton.TT := "Maximum power"
	; myMaximumPowerButton.Color := "Yellow"
	; myMaximumPowerGuiPicture := myMaximumPowerGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myMaximumPowerGui
	; WinSetTransparent 75, myMaximumPowerButton
	myMaximumPowerButton.OnEvent("Click", myMaximumPowerButton_Click)
	myMaximumPowerGui.Show()
	SetTimer((*) => windowTrack36(myMaximumPowerGui), 20)
	windowTrack36(myMaximumPowerGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myMaximumPowerGui.Move(windowX + 262, windowY + 560)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays an Increase Throttle button (QWERTY: = / QWERTZ: ´ / AZERTY: =)
	; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
	myIncreaseThrottleGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myIncreaseThrottleGui.MarginX := myIncreaseThrottleGui.MarginY := 0
	myIncreaseThrottleButton := myIncreaseThrottleGui.Add("Button","Default w24 h29","")
	myIncreaseThrottleButton.TT := "Increase power"
	; myIncreaseThrottleButton.Color := "Yellow"
	; myIncreaseThrottleGuiPicture := myIncreaseThrottleGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myIncreaseThrottleGui
	; WinSetTransparent 75, myIncreaseThrottleButton
	myIncreaseThrottleButton.OnEvent("Click", myIncreaseThrottleButton_Click)
	myIncreaseThrottleGui.Show()
	SetTimer((*) => windowTrack37(myIncreaseThrottleGui), 20)
	windowTrack37(myIncreaseThrottleGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myIncreaseThrottleGui.Move(windowX + 262, windowY + 622)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
		
		
		
	; 50% Power (detects the current speed and changes it accordingly)
	; There is room on the left side of the left MFD
	
	
		
	; Displays a Decrease Throttle button (QWERTY: - / QWERTZ: ß / AZERTY: ))
	; the QWERTZ hotkey varies a lot depending on the type of QWERTZ keyboard layout
	myDecreaseThrottleGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myDecreaseThrottleGui.MarginX := myDecreaseThrottleGui.MarginY := 0
	myDecreaseThrottleButton := myDecreaseThrottleGui.Add("Button","Default w24 h29","")
	myDecreaseThrottleButton.TT := "Decrease power"
	; myDecreaseThrottleButton.Color := "Yellow"
	; myDecreaseThrottleGuiPicture := myDecreaseThrottleGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myDecreaseThrottleGui
	; WinSetTransparent 75, myDecreaseThrottleButton
	myDecreaseThrottleButton.OnEvent("Click", myDecreaseThrottleButton_Click)
	myDecreaseThrottleGui.Show()
	SetTimer((*) => windowTrack38(myDecreaseThrottleGui), 20)
	windowTrack38(myDecreaseThrottleGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myDecreaseThrottleGui.Move(windowX + 262, windowY + 733)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
	
	; Displays a No Power button (QWERTY: SHIFT - / QWERTZ: SHIFT ß / AZERTY: SHIFT ))
	myNoPowerGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	myNoPowerGui.MarginX := myNoPowerGui.MarginY := 0
	myNoPowerButton := myNoPowerGui.Add("Button","Default w24 h29","")
	myNoPowerButton.TT := "No power"
	; myNoPowerButton.Color := "Yellow"
	; myNoPowerGuiPicture := myNoPowerGui.Add("Picture", "x0 y0 w50 h70 vBG", "yellow.png")
	WinSetTransparent 75, myNoPowerGui
	; WinSetTransparent 75, myNoPowerButton
	myNoPowerButton.OnEvent("Click", myNoPowerButton_Click)
	myNoPowerGui.Show()
	SetTimer((*) => windowTrack39(myNoPowerGui), 20)
	windowTrack39(myNoPowerGui) {
		SetWinDelay(-1)
		CoordMode("Mouse", "Screen")		
		if WinExist("ahk_exe dosbox.exe") {
			WinGetPos(&windowX, &windowY,,, "DOSBox") 
			myNoPowerGui.Move(windowX + 262, windowY + 795)
		} else {
			; SoundBeep 750, 500
			ExitApp
		}
	}
		
	
	
	; Resupply (training) (ALT R)









