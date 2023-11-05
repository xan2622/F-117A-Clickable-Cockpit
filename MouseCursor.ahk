#Requires AutoHotkey v2


	


	; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	; Bypasses DOSBox isolation by displaying a cursor
	; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


	SetWorkingDir(A_ScriptDir)

	; Create an invisible GUI that the picture is placed on:
	myCustomCursorGui := Gui("-Caption +AlwaysOnTop +ToolWindow")
	WinSetExStyle("+32", myCustomCursorGui)
	myCustomCursorGui.MarginX   := myCustomCursorGui.MarginY := 0
	myCustomCursorGui.BackColor := "2B2B2C"
	WinSetTransColor(myCustomCursorGui.BackColor, myCustomCursorGui)
	ogcPictureBG := myCustomCursorGui.Add("Picture", "x0 y0 vBG", "cursor.png")

	SetTimer(mouseTrack, 20)
	myCustomCursorGui.Show("NoActivate")

	mouseTrack() {
		SetWinDelay(-1)
		; No need to define global variables in AutoHotKey 2
		CoordMode("Mouse", "Screen")
		MouseGetPos(&mouseX, &mouseY)
		myCustomCursorGui.Move(mouseX, mouseY)
	}










	; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	; HIDES THE WINDOWS MOUSE CURSOR WHEN HOVERING AHK GUI BUTTONS
	; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	; https://www.autohotkey.com/boards/viewtopic.php?style=17&t=119211&p=529038
	
	



	OnExit (*) => SystemCursor("Show")  ; Ensure the cursor is made visible when the script exits.

	SystemCursor("Toggle")  

	SystemCursor(cmd)  ; cmd = "Show|Hide|Toggle|Reload"
	{
		static visible := true, c := Map()
		static sys_cursors := [32512, 32513, 32514, 32515, 32516, 32642
							 , 32643, 32644, 32645, 32646, 32648, 32649, 32650]
		if (cmd = "Reload" or !c.Count)  ; Reload when requested or at first call.
		{
			for i, id in sys_cursors
			{
				h_cursor  := DllCall("LoadCursor", "Ptr", 0, "Ptr", id)
				h_default := DllCall("CopyImage", "Ptr", h_cursor, "UInt", 2
					, "Int", 0, "Int", 0, "UInt", 0)
				h_blank   := DllCall("CreateCursor", "Ptr", 0, "Int", 0, "Int", 0
					, "Int", 32, "Int", 32
					, "Ptr", Buffer(32*4, 0xFF)
					, "Ptr", Buffer(32*4, 0))
				c[id] := {default: h_default, blank: h_blank}
			}
		}
		switch cmd
		{
		case "Show": visible := true
		case "Hide": visible := false
		case "Toggle": visible := !visible
		default: return
		}
		for id, handles in c
		{
			h_cursor := DllCall("CopyImage"
				, "Ptr", visible ? handles.default : handles.blank
				, "UInt", 2, "Int", 0, "Int", 0, "UInt", 0)
			DllCall("SetSystemCursor", "Ptr", h_cursor, "UInt", id)
		}
	}


