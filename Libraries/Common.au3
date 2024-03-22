#include-once
#include <File.au3>

Func setSetting()
	; Enables GUI events
	Opt("GUIOnEventMode", 1)
	; Disable Caps for better background
	Opt("SendCapslockMode", 0)
	; Set window Mode for PixelSearch
	Opt("PixelCoordMode", 0)
	; Set window Mode for MouseClick
	Opt("MouseCoordMode", 0)
EndFunc   ;==>setSetting

Func WriteInLogs($sMessage)
	_FileWriteLog("IdleRunnerLogs\Logs.txt", "Ascending Height Failed")
EndFunc   ;==>WriteInLogs

Func cSend($iPressDelay, $iPostPressDelay = 0, $sKey = "Up")
	Send($sKey)
	Send("{" & $sKey & " Down}")
	Sleep($iPressDelay)
	Send("{" & $sKey & " Up}")
	Sleep($iPostPressDelay)
	Return
EndFunc   ;==>cSend

Func FindPixelUntilFound($iX1, $iY1, $iX2, $iY2, $sHex, $iTimer = 15000)
	Local $hTimer = TimerInit()
	Local $aPos
	Do
		$aPos = PixelSearch($iX1, $iY1, $iX2, $iY2, $sHex)
	Until Not @error Or $iTimer < TimerDiff($hTimer)
	If $iTimer < TimerDiff($hTimer) Then
		Return False
	Else
		Return $aPos
	EndIf
EndFunc   ;==>FindPixelUntilFound


Func Slider()
	;Top left
	PixelSearch(443, 560, 443, 560, 0x007E00)
	If Not @error Then
		MouseMove(840, 560, 0)
		MouseClickDrag("left", 840, 560, 450, 560)
		Return
	EndIf

	;Bottom left
	PixelSearch(443, 620, 443, 620, 0x007E00)
	If Not @error Then
		MouseMove(840, 620, 0)
		MouseClickDrag("left", 840, 620, 450, 620)
		Return
	EndIf

	;Top right
	PixelSearch(850, 560, 850, 560, 0x007E00)
	If Not @error Then
		MouseMove(450, 560, 0)
		MouseClickDrag("left", 450, 560, 840, 560)
		Return
	EndIf

	;Bottom right
	PixelSearch(850, 620, 850, 620, 0x007E00)
	If Not @error Then
		MouseMove(450, 620, 0)
		MouseClickDrag("left", 450, 620, 840, 620)
		Return
	EndIf
EndFunc   ;==>Slider
