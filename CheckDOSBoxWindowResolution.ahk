#Requires AutoHotkey v2

filePath := "F:\Jeux\Steam\steamapps\common\F-117A Nighthawk Stealth Fighter\dosbox_windows\dosbox_F117A.conf" ; Replace with your file path
DOSBoxWindowResolution := ""
skipNextLine := false

if FileExist(filePath) {
    fileConf := FileOpen(filePath, "r")
    while !fileConf.AtEOF {
        if (skipNextLine) {
            line := fileConf.ReadLine()
            skipNextLine := false
        }
        else {
            line := fileConf.ReadLine()
            if (SubStr(line, 1, 1) = ";") {
                continue
            }
            else if InStr(line, "windowresolution=") {
                DOSBoxWindowResolution := RegExReplace(line, ".*windowresolution=([^`r`n]*)", "$1")
                break
            }
        }
    }
    fileConf.Close()
}

DOSBoxWindowResolutionWidth := ""
DOSBoxWindowResolutionHeight := ""

if (DOSBoxWindowResolution != "") {
    ResolutionArray := StrSplit(DOSBoxWindowResolution, "x")
    DOSBoxWindowResolutionWidth := ResolutionArray[1]
    DOSBoxWindowResolutionHeight := ResolutionArray[2]
}

WidthMultiplyFactor := DOSBoxWindowResolutionWidth ? DOSBoxWindowResolutionWidth / 640 : 0
HeightMultiplyFactor := DOSBoxWindowResolutionHeight ? DOSBoxWindowResolutionHeight / 480 : 0

; MsgBox("The WidthMultiplyFactor is: " WidthMultiplyFactor "`n The HeightMultiplyFactor is: " HeightMultiplyFactor)
