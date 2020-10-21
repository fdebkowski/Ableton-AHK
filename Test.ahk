^+w:: ; Duplicate and renames
    ;Click
    ;Send ^d
    ;Sleep, 3000
    ;lipboard =
    Send ^r
    Sleep 200
    Send ^a
    Sleep 200
    ;PixelSearch, X, Y, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xFFEDC7
    ;MouseMove, X, Y
    ;Click
    Sleep, 100
	SendInput {LCtrl down}{c down}
	Sleep 50	; This way to send Ctrl+C thanks to Shadowpheonix
	SendInput {c up}{LCtrl up}
    Sleep 1000
    ;ToolTip, clip b %clipboard%
    ;MsgBox, %cb%
    ;MsgBox, %clipboard%
    NrString =
    Length =
    Base =
    NrVar =
    Nrvar2 =
    NrString := StrSplit(clipboard, "#")
    Length := StrLen(NrString[2])
    Base := NrString[1]
    NrVar := NrString[2]
    Nrvar2 := NrVar+1
    ;k := 0
    ;ToolTip,  baza %Base%
    Send %Base%
    Send {Raw}#
    Send %Nrvar2%
    ;
    Clipboard =
Return

` & 3:: ; Duplicate and renames
    Clipboard =
    Click
    Send ^d
    Sleep, 3000
    Send ^r
    Send ^a
    Send ^c
    Sleep 100
    ClipWait, 2, 1
    ;ToolTip, clip b %clipboard%
    cb := Clipboard
    MsgBox, %cb%
    NrString := StrSplit(cb, "#")
    Length := StrLen(NrString[2])
    Base := NrString[1]
    NrVar := NrString[2]
    Nrvar2 := NrVar+1
    k := 0
    Sleep 10
    ;ToolTip,  baza %Base%
    Send %Base%
    Send {Raw}#
    Send %Nrvar2% 
Return 

    NumpadDown::

    Return

    NumpadPgdn::

    Return

    NumpadLeft::

    Return

    NumpadClear::

    Return

    NumpadRight::

    Return

    NumpadHome::

    Return

    NumpadUp::

    Return

    NumpadPgup::

    Return
