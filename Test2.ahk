#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#InstallMouseHook
#InstallKeybdHook
CoordMode, Pixel, Window
CoordMode, Mouse, Window

global Array := []
Array[1] := "Echo"

NumpadEnd::
    openplugin(1)
Return

openplugin(ArrayNumer){
    ;Hotkey, F13, Off
	Send, {ctrl down}{f}{ctrl up}
	Sendinput % Array[ArrayNumer]
	WinWaitActive, ExcludeText - ExcludeTitle, , 0.5 ; prevents the keystrokes from desynchronizing when ableton lags during the search query.

    MouseGetPos, posX, posY
	Sleep, 100
	Send, {down}{enter}
	SendInput, {Esc}
	SetTitleMatchMode, RegEx

	ArrayNameClean := RegExReplace(Array[ArrayNumer], "['""]+", "")
	StringLower, ArrayNameClean, ArrayNameClean

	if (ArrayNameClean = "analog" or ArrayNameClean = "collision" or ArrayNameClean = "drum rack" or ArrayNameClean = "electric" or ArrayNameClean = "external instrument" or ArrayNameClean = "impulse" or ArrayNameClean = "instrument rack" or ArrayNameClean = "operator" or ArrayNameClean = "sampler" or ArrayNameClean = "simpler" or ArrayNameClean = "tension" or ArrayNameClean = "wavetable") or (ArrayNameClean = "amp") or (ArrayNameClean = "audio effect rack") or (ArrayNameClean = "auto filter") or (ArrayNameClean = "auto pan") or (ArrayNameClean = "beat repeat") or (ArrayNameClean = "cabinet") or (ArrayNameClean = "chorus") or (ArrayNameClean = "compressor") or (ArrayNameClean = "corpus") or (ArrayNameClean = "drum buss") or (ArrayNameClean = "dynamic tube") or (ArrayNameClean = "echo") or (ArrayNameClean = "eq eight") or (ArrayNameClean = "eq three") or (ArrayNameClean = "erosion") or (ArrayNameClean = "external audio effect") or (ArrayNameClean = "filter delay") or (ArrayNameClean = "flanger") or (ArrayNameClean = "frequency shifter") or (ArrayNameClean = "gate") or (ArrayNameClean = "glue compressor") or (ArrayNameClean = "grain delay") or (ArrayNameClean = "limiter") or (ArrayNameClean = "looper") or (ArrayNameClean = "multiband dynamics") or (ArrayNameClean = "overdrive") or (ArrayNameClean = "pedal") or (ArrayNameClean = "phaser") or (ArrayNameClean = "ping pong delay") or (ArrayNameClean = "redux") or (ArrayNameClean = "resonators") or (ArrayNameClean = "reverb") or (ArrayNameClean = "saturator") or (ArrayNameClean = "simple delay") or (ArrayNameClean = "delay") or (ArrayNameClean = "spectrum") or (ArrayNameClean = "tuner") or (ArrayNameClean = "utility") or (ArrayNameClean = "vinyl distortion") or (ArrayNameClean = "vocoder") or (InStr(ArrayNameClean, ".adv") != 0){
		Click, 24, 95
        WinWaitActive, ExcludeText - ExcludeTitle, , 0.5
        MouseMove, posX, posY, 1
        ;Hotkey, F13, On
		return
	}
	else{
		WinWaitActive, ahk_class (AbletonVstPlugClass|Vst3PlugWindow),,12
		WinGetTitle, 3PartyPlugin, ahk_class (AbletonVstPlugClass|Vst3PlugWindow)
	}

	if (3PartyPlugin != "") {
		SetTitleMatchMode, 2
		WinActivate, Ableton
		SendInput, {Esc}
        Send, ^!b
		sleep, 1
		WinActivate, %3PartyPlugin%
	}
	else{
		SetTitleMatchMode, 2
	}
    ;Hotkey, F13, On
}