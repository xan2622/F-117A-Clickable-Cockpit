#Requires AutoHotkey v2





; DPI support
; source: https://www.autohotkey.com/boards/viewtopic.php?f=96&t=121040
; This library must be in the same folder than this AHK script 
#include DPI.ahk

; Gets the DPI for the specified window
	WinGetDpi(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?) {
    return (hMonitor := DllCall("MonitorFromWindow", "ptr", WinExist(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?), "int", 2, "ptr") ; MONITOR_DEFAULTTONEAREST
    , DllCall("Shcore.dll\GetDpiForMonitor", "ptr", hMonitor, "int", 0, "uint*", &dpiX:=0, "uint*", &dpiY:=0), dpiX)
}

