#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#InstallMouseHook
#InstallKeybdHook
CoordMode, Pixel, Window
CoordMode, Mouse, Window

global Array := []
    Array[1] := "Utility"
    Array[2] := "Starter Pack 2.0"
    Array[3] := "FabFilter Pro-Q 3"
    Array[4] := "VolumeShaper4"
    Array[5] := "ValhallaRoom"
    Array[6] := "Echo"
    Array[7] := "S1 Imager"
    Array[8] := "DS 10"

#IfWinActive ahk_class Ableton Live Window Class

Loop{ ; Loop for Browser Hider
    Send, {F13} 
}
Return

` & 1:: ; Automate third party plugins
        BlockInput, MouseMove
        WinActivate, ahk_class Ableton Live Window Class
        MouseGetPos, Aut3X, Aut3Y
        ImageSearch, WrenchX, WrenchY, 0, 0, A_ScreenWidth, A_ScreenHeight, Wrench1.png
        if (ErrorLevel =1){
            ImageSearch, WrenchX, WrenchY, 0, 0, A_ScreenWidth, A_ScreenHeight, Wrench2.png
            if (ErrorLevel = 1){
                ImageSearch, WrenchX, WrenchY, 0, 0, A_ScreenWidth, A_ScreenHeight, Wrench3.png
                if (ErrorLevel = 1){
                BlockInput, MouseMoveOff
                MsgBox, Couldnt find Wrench PNG
                }
            }
        }

        ImageSearch, ConfigureX, ConfigureY, WrenchX, WrenchY, A_ScreenWidth, WrenchY+20, Configure4.png
        if (ErrorLevel = 1){
            ImageSearch, ConfigureX, ConfigureY, WrenchX, WrenchY, A_ScreenWidth, WrenchY+20, Configure3.png 
            if (ErrorLevel = 1){
                BlockInput, MouseMoveOff
                MsgBox, Couldnt find Configure PNG 
            }
            Click
            Sleep 10
            WinActivate, ahk_class Ableton Live Window Class
            Sleep 10
            ImageSearch, ConfigureX, ConfigureY, WrenchX, WrenchY, A_ScreenWidth, WrenchY+20, Configure3.png
            if (ErrorLevel = 1){
                BlockInput, MouseMoveOff
                MsgBox, Couldnt find Configure PNG
            }
            MouseMove, ConfigureX, ConfigureY, 1
            Click
            Sleep 10
            Sleep 10
            MouseMove, Aut3X, Aut3Y, 1
            BlockInput, MouseMoveOff
        }
        else{
            MouseMove, ConfigureX, ConfigureY, 1
            Click
            MouseMove, Aut3X, Aut3Y, 1
            Click
            Sleep 10
            WinActivate, ahk_class Ableton Live Window Class
            Sleep 10
            ImageSearch, ConfigureX, ConfigureY, WrenchX, WrenchY, A_ScreenWidth, WrenchY+20, Configure3.png 
            if (ErrorLevel = 1){
                BlockInput, MouseMoveOff
                MsgBox, Couldnt find Configure PNG
            }
            MouseMove, ConfigureX, ConfigureY, 1
            Click
            MouseMove, Aut3X, Aut3Y, 1
            BlockInput, MouseMoveOff
        }
Return 

Tab::+Tab ; Tab to Shift Tab for quick switching between piano roll/effects
Return

XButton2 & x::!u ; Quick show/hide all tracks
Return

XButton2 & w::^!b ;Quick Show browser
Return

XButton2 & a:: ; Quick Show Piano Roll
    MouseGetPos,,,guideUnderCursor
    WinGetTitle, WinTitle, ahk_id %guideUnderCursor%
    if(InStr(WinTitle, "Ableton") != 0){
        BlockInput, MouseMove
        MouseGetPos, xpospia, ypospia
        MouseClickDrag, Left, 906, 810, 906, 80, 1
        MouseMove, xpospia, ypospia, 1
        BlockInput, MouseMoveOff
        Loop{
            sleep 50
            while !(GetKeyState("XButton2" , "P") and GetKeyState("a" , "P")){
                sleep 50
            }
            Break
        }
        MouseGetPos, xpospia, ypospia
        BlockInput, MouseMove
        MouseClickDrag, Left, 906, 80, 906, 810, 1
        MouseMove, xpospia, ypospia, 1
        BlockInput, MouseMoveOff
    }
Return
    
XButton2 & z:: ; Fast Open Groups
    MouseGetPos,,,guideUnderCursor
    WinGetTitle, WinTitle, ahk_id %guideUnderCursor%
    if(InStr(WinTitle, "Ableton") != 0){
        MouseGetPos, OpenGroupX, OpenGroupY
        MouseMove, OpenGroupX-400, OpenGroupY, 0
        Send {LButton down}
        Send {LButton up}
        KeyWait, LButton, L
        MouseMove, OpenGroupX, OpenGroupY, 0
        Click
        Send u
    }
Return

` & 2:: ; Automate Ableton plugins
    MouseGetPos,,,guideUnderCursor
    WinGetTitle, WinTitle, ahk_id %guideUnderCursor%
    if (InStr(WinTitle, "Ableton") != 0){
        Send,{RButton}
        Send,{Down 2}
        Send,{Enter}
    }
Return

openplugin(ArrayNumber){ ; Function to open plugin copied from LES
    Hotkey, F13, Off
    Send, ^!b
	Send, {ctrl down}{f}{ctrl up}
	Sendinput % Array[ArrayNumber]
	WinWaitActive, ExcludeText - ExcludeTitle, , 0.5 ; prevents the keystrokes from desynchronizing when ableton lags during the search query.

    MouseGetPos, posX, posY
	Sleep, 100
	Send, {down}{enter}
    SetTitleMatchMode, 2
    WinGetPos, wx, wy, wWidth, wHeight, Ableton
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Screen
    PixelGetColor, titlebarcolor, (wx + 10), (wy + 38)
    If (titlebarcolor = "0xFFFFFF") || (titlebarcolor = "0xF2F2F2") || (titlebarcolor = "0x2F2F2F") || (titlebarcolor = "0xFFFFFFFF") || (titlebarcolor = "0xF2F2F2F2") || (titlebarcolor = "0x2F2F2F2F"){ ; the colours are used to detect if live is in fullscreen or in windowed mode.
        coolclicky := 43 + 48 + wy
        coolclickx := 20 + wx
    }
    Else{
        coolclicky := 43 + wy
        coolclickx := 20 + wx
    }
    sleep, 1
    Click, %coolclickx%, %coolclicky%, 1
    MouseMove, posX, posY, 0
	SendInput, {Esc}
	SetTitleMatchMode, RegEx

	ArrayNameClean := RegExReplace(Array[ArrayNumber], "['""]+", "")
	StringLower, ArrayNameClean, ArrayNameClean

	if (ArrayNameClean = "analog" or ArrayNameClean = "collision" or ArrayNameClean = "drum rack" or ArrayNameClean = "electric" or ArrayNameClean = "external instrument" or ArrayNameClean = "impulse" or ArrayNameClean = "instrument rack" or ArrayNameClean = "operator" or ArrayNameClean = "sampler" or ArrayNameClean = "simpler" or ArrayNameClean = "tension" or ArrayNameClean = "wavetable") or (ArrayNameClean = "amp") or (ArrayNameClean = "audio effect rack") or (ArrayNameClean = "auto filter") or (ArrayNameClean = "auto pan") or (ArrayNameClean = "beat repeat") or (ArrayNameClean = "cabinet") or (ArrayNameClean = "chorus") or (ArrayNameClean = "compressor") or (ArrayNameClean = "corpus") or (ArrayNameClean = "drum buss") or (ArrayNameClean = "dynamic tube") or (ArrayNameClean = "echo") or (ArrayNameClean = "eq eight") or (ArrayNameClean = "eq three") or (ArrayNameClean = "erosion") or (ArrayNameClean = "external audio effect") or (ArrayNameClean = "filter delay") or (ArrayNameClean = "flanger") or (ArrayNameClean = "frequency shifter") or (ArrayNameClean = "gate") or (ArrayNameClean = "glue compressor") or (ArrayNameClean = "grain delay") or (ArrayNameClean = "limiter") or (ArrayNameClean = "looper") or (ArrayNameClean = "multiband dynamics") or (ArrayNameClean = "overdrive") or (ArrayNameClean = "pedal") or (ArrayNameClean = "phaser") or (ArrayNameClean = "ping pong delay") or (ArrayNameClean = "redux") or (ArrayNameClean = "resonators") or (ArrayNameClean = "reverb") or (ArrayNameClean = "saturator") or (ArrayNameClean = "simple delay") or (ArrayNameClean = "delay") or (ArrayNameClean = "spectrum") or (ArrayNameClean = "tuner") or (ArrayNameClean = "utility") or (ArrayNameClean = "vinyl distortion") or (ArrayNameClean = "vocoder") or (InStr(ArrayNameClean, ".adv") != 0){
        WinWaitActive, ExcludeText - ExcludeTitle, , 0.5
        Hotkey, F13, On
		Return
	}
	else{
		WinWaitActive, ahk_class (AbletonVstPlugClass|Vst3PlugWindow),,12
		WinGetTitle, 3PartyPlugin, ahk_class (AbletonVstPlugClass|Vst3PlugWindow)
	}

	if (3PartyPlugin != "") {
		SetTitleMatchMode, 2
		WinActivate, Ableton
		SendInput, {Esc}
		sleep, 1
		WinActivate, %3PartyPlugin%
	}
	else{
		SetTitleMatchMode, 2
	}
    Hotkey, F13, On
    Return
}

; Quick plugin opening
    XButton2 & 1::
        openplugin(1)
    Return
    XButton2 & 2::
        openplugin(2)
    Return
    XButton2 & 3::
        openplugin(3)
    Return
    XButton2 & 4::
        openplugin(4)
    Return
    XButton1 & 1::
        openplugin(5)
    Return
    XButton1 & 2::
        openplugin(6)
    Return
    XButton1 & 3::
        openplugin(7)
    Return
    XButton1 & 4::
        openplugin(8)
    Return

#IfWinActive

F13:: ; Browser Hider
    CoordMode, Mouse, Screen
    Loop{
        MouseGetPos, xpos, ypos
        If (xpos>=2)
            Continue
        If (xpos<2)
            Send, ^!b
            Send, ^f
            Send {Esc}
            Break
    }
    Loop{
        MouseGetPos, xpos, ypos
        If (xpos<=575)
            Continue
        If (xpos>575)
            Send, ^!b
            Break
    }
    CoordMode, Mouse, Window
Return

XButton2 & d:: ; Show/Hide Plugin Windows
    WinActivate, ahk_class Ableton Live Window Class
    Sleep, 50
    Send ^!p
Return

^F1::Pause ; Pause Script
Return

^#\::ExitApp

; ^w:: ; Duplicate and renames ### NOT WORKING ###
;     Sleep, 100
;     Send, ^r
;     Send, ^c
;     Sleep 100
;     ClipWait, 2, 1
;     cb := Clipboard
;     Send, {Enter}
;     Send, ^d
;     Sleep, 1000
;     NrString := StrSplit(cb, "#")
;     Length := StrLen(NrString[2])
;     Base := NrString[1]
;     NrVar := NrString[2]
;     Nrvar2 := NrVar+1
;     Send, ^r
;     Send, ^a
;     Send %Base%
;     Send {Raw}#
;     Send %Nrvar2%
;     Send, {Enter}
; Return
