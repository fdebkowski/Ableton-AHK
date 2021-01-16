#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#InstallMouseHook
#InstallKeybdHook

MouseGetPos,,,guideUnderCursor
WinGetTitle, WinTitle, ahk_id %guideUnderCursor%
if (InStr(WinTitle, "Ableton") != 0){
    Loop{
        Start:
        CoordMode, Pixel, Screen
        CoordMode, Mouse, Screen
        MouseGetPos, PrePosX, PrePosY
        PixelGetColor, SelColour, PrePosX, PrePosY
        LBDown := GetKeyState("LButton")
        if (SelColour = 0xA694FF and LBDown = 1){ ;col != 0x4c4c4c and col != 0x494949 and col != 0x555555 and col != 0x515151 and col != 0x4e4e4e and col != 0x4d4d4d
            Select:
            Sleep 10
            MouseGetPos, SelPosX, SelPosY
            PixelSearch, SelX1, SelY1, SelPosX, SelPosY, 0, SelPosY, 0xFFEDC7, 0, Fast
            if ErrorLevel{
                Goto, Start
            }
            PixelSearch, SelX2, SelY2, SelPosX, SelPosY, A_ScreenWidth, SelPosY, 0xFFEDC7, 0, Fast
            if ErrorLevel{
                Goto, Start
            }
            SelDeltaX := SelX2 - SelX1
            ;MsgBox, wyp is %SelDeltaX%
            ;SoundBeep, 1000, 100
            Loop{
                MouseGetPos, ActPosX, ActPosY
                PixelGetColor, ColourAct, ActPosX, ActPosY
                LBDown2 := GetKeyState("LButton")
                If (ColourAct != 0xA694FF and LBDown2 = 1){
                    BlockInput, On
                    BlockInput, MouseMove
                    Click Up
                    Click Down
                    KeyWait, Lbutton
                    PixelSearch, ActX1, ActY1, ActPosX, ActPosY, 1, ActPosY+1, 0xFFEDC7, 0, Fast
                    PixelSearch, ActX2, ActY2, ActPosX, ActPosY, A_ScreenWidth, ActPosY-1, 0xFFEDC7, 0, Fast
                    ActDeltaX := SelDeltaX -ActX2 + ActX1
                    Sleep 300
                    MouseMove, ActPosX + ActDeltaX, ActPosY, 5
                    Sleep 50
                    Click Up
                    KeyWait, LButton, L
                    MouseMove, ActPosX, ActPosY, 0
                    BlockInput, Off
                    BlockInput, MouseMoveOff
                }
                If (ColourAct = 0xA694FF and LBDown2 = 1){
                    Goto, Select
                }
            }
        }
        ;else{
        ;    MsgBox, color to %col%
        ;}
    }
}
Return


doubleclick:
Click Down
KeyWait, Lbutton
Click Up