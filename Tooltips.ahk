#Requires AutoHotkey v2
#SingleInstance Force





OnMessage(0x0200, On_WM_MOUSEMOVE)

On_WM_MOUSEMOVE(wParam, lParam, msg, Hwnd)
{
    static PrevHwnd := 0
    if (Hwnd != PrevHwnd)
    {
        Text := "", ToolTip() ; Turn off any previous tooltip.
        CurrControl := GuiCtrlFromHwnd(Hwnd)
        if CurrControl
        {
            if !CurrControl.HasProp("ToolTip")
                return ; No tooltip for this control.
            Text := CurrControl.ToolTip
            SetTimer () => ToolTip(Text), -50
            SetTimer () => ToolTip(), -2000 ; Remove the tooltip.
        }
        PrevHwnd := Hwnd
    }
}
