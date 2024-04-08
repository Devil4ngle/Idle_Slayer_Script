#include-once
#include "Common.au3"

;setSetting()
;AscendingHeightsPlay()


Func AscendingHeights()
	WriteInLogs("Start of Ascending Heights")
	Do
		Slider()
		Sleep(500)
		PixelSearch(660, 254, 660, 254, 0xC2F4F9)
	Until @error
	Sleep(3900)
	AscendingHeightsPlay()
EndFunc   ;==>AscendingHeights

Func AscendingHeightsPlay()
	Local $aPosPlayer
	Local $aPosPlatform
	Local $iLastCheckTime = TimerInit()
	While True
		If TimerDiff($iLastCheckTime) >= 5000 Then
			$iLastCheckTime = TimerInit()

			PixelSearch(190, 125, 190, 125, 0xFFAF36)
			If Not @error Then
				WriteInLogs("Ascending Height Failed")
				ExitLoop
			EndIf

			PixelSearch(590, 590, 590, 590, 0x00A800)
			If Not @error Then MouseClick("left", 590, 590, 1, 0)

			PixelSearch(730, 385, 730, 385, 0x7A444A)
			If Not @error Then
				cSend(6000, 0, "d")
				WriteInLogs("Ascending Height Won")
				ExitLoop
			EndIf
		EndIf

		$aPosPlayer = PixelSearch(375, 260, 900, 730, 0x633E75)
		If @error Then ContinueLoop

		$aPosPlatform = searchAllPlatformBellowPlayer($aPosPlayer[0], $aPosPlayer[1])
		If Not IsArray($aPosPlatform) Then ContinueLoop

		If ($aPosPlatform[0] + 35) > ($aPosPlayer[0] + 35) Then
			cSend(100, 0, "d")
		ElseIf ($aPosPlatform[0] + 35) < ($aPosPlayer[0] - 35) Then
			cSend(100, 0, "a")
		EndIf
	WEnd
EndFunc   ;==>AscendingHeightsPlay

Func searchAllPlatformBellowPlayer($iPlayerX, $iPlayerY)
	Local $aPosPlatform = PixelSearch(375, $iPlayerY + 50, 900, 752, 0xA7ACBA)
	If Not @error Then
		While True
			PixelSearch($aPosPlatform[0] + 4, $aPosPlatform[1], $aPosPlatform[0] + 4, $aPosPlatform[1], 0x222034)
			If @error Then Return $aPosPlatform
			If $aPosPlatform[1] + 13 > 752 Then Return False
			$aPosPlatform = PixelSearch(375, $aPosPlatform[1] + 13, 900, 752, 0xA7ACBA)
			If @error Then Return False
		WEnd
	EndIf
EndFunc   ;==>searchAllPlatformBellowPlayer
