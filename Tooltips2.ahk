#Requires AutoHotkey v2
#SingleInstance Force





OnMouseEvent(wp, lp, msg, hwnd) { ; , 
    static TME_LEAVE := 0x2, onButtonHover := false
    if msg = WM_MOUSEMOVE && !onButtonHover ; && ButtonHwnd = hwnd {
    {
        TRACKMOUSEEVENT := Buffer(8 + A_PtrSize * 2)
        NumPut('UInt', TRACKMOUSEEVENT.Size,
               'UInt', TME_LEAVE,
               'Ptr', hwnd,
               'Ptr', 10, TRACKMOUSEEVENT)
        DllCall('TrackMouseEvent', 'Ptr', TRACKMOUSEEVENT)
        try
            ToolTipContents:=GuiCtrlFromHwnd(hwnd).TT, ToolTip(ToolTipContents)
        catch
            ToolTipContents:=""
    }
    if msg = WM_MOUSELEAVE {
        ToolTip() ; outside gui
    }
}

