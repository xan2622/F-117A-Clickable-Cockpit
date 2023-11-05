#Requires AutoHotkey v2.0








	
/*
; 	Doesn't seem to work anymore
	
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


	