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
	Local $iSamePositionCount = 0
	Local $iPosPreviousX = 0
	Local $iPosPreviousY = 0
	Local $aPosPlayer
	Local $aPosPlatform
	Local $iLastCheckTime = 0

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

		$aPosPlatform = searchAllPlatform(375, 744, 900, 200)
		If Not IsArray($aPosPlatform) Then ContinueLoop

		If ($aPosPlatform[0] + 40) > ($aPosPlayer[0] + 35) Then
			If ($aPosPlatform[0] + 40) - ($aPosPlayer[0] + 35) > 40 Then
				;ConsoleWrite(" longd")
				Send("d")
			Else
				cSend(50, 0, "d")
			EndIf
			$iSamePositionCount = 0
		ElseIf ($aPosPlatform[0] + 40) < ($aPosPlayer[0] - 35) Then
			If ($aPosPlayer[0] - 35) - ($aPosPlatform[0] + 40) > 40 Then
				;ConsoleWrite(" longa")
				Send("a")
			Else
				cSend(50, 0, "a")
			EndIf
			$iSamePositionCount = 0
		Else
			If $iPosPreviousX = $aPosPlatform[0] And $iPosPreviousY = $aPosPlatform[1] Then
				$iSamePositionCount += 1
				If $iSamePositionCount >= 20 Then
					$iSamePositionCount = 0
					;ConsoleWrite(" EnterUp ")
					tryToGoUp($aPosPlatform[0], $aPosPlatform[1])
					;ConsoleWrite(" ExitUp ")
				EndIf
			Else
				$iSamePositionCount = 0
			EndIf
			$iPosPreviousX = $aPosPlatform[0]
			$iPosPreviousY = $aPosPlatform[1]
		EndIf
	WEnd
EndFunc   ;==>AscendingHeightsPlay

Func searchAllPlatform($iX, $iY, $iX1, $iY2)
	Local $aPosPlatform = PixelSearch($iX, $iY, $iX1, $iY2, 0xA7ACBA)
	If Not @error Then
		While True
			PixelSearch($aPosPlatform[0] + 38, $aPosPlatform[1], $aPosPlatform[0] + 38, $aPosPlatform[1], 0xA7ACBA)
			If Not @error Then Return $aPosPlatform
			If $aPosPlatform[1] - 13 < $iY2 Then Return False
			$aPosPlatform = PixelSearch($iX, $aPosPlatform[1] - 13, $iX1, $iY2, 0xA7ACBA)
			If @error Then Return False
		WEnd
	EndIf
EndFunc   ;==>searchAllPlatform



Func tryToGoUp($iXPosLowerPlatform, $iYPosLowerPlatform)
	Local $aPosPlayer
	Local $aPosPlatformLow
	Local $aPosPlatform
	Local $iYPosHigherPlatform = $iYPosLowerPlatform - 12
	If isPlayerAtLowestPoint($iXPosLowerPlatform, $iYPosLowerPlatform) == False Then Return
	While True
		$aPosPlayer = PixelSearch(375, 730, 900, 330, 0x633E75)
		If @error Then ExitLoop

		$aPosPlatform = searchAllPlatform(375, $iYPosHigherPlatform, 836, 200)
		If Not IsArray($aPosPlatform) Then ExitLoop

		; Check if the lowest platform is still the same
		If platformDoesNotExist($iXPosLowerPlatform, $iYPosLowerPlatform) Then ExitLoop

		If ($aPosPlatform[0] + 40) > $aPosPlayer[0] + 25 Then
			cSend(90, 0, "d")
		ElseIf ($aPosPlatform[0] + 40) < $aPosPlayer[0] - 25 Then
			cSend(90, 0, "a")
		Else
			If ($aPosPlayer[1] + 30 < $aPosPlatform[1]) Then
				$aPosPlatformLow = searchAllPlatform(375, 744, 900, 200)
				If Not IsArray($aPosPlatformLow) Then ExitLoop
				If $iYPosLowerPlatform == $aPosPlatformLow[1] And $iXPosLowerPlatform == $aPosPlatformLow[0] Then
					$iYPosHigherPlatform = $aPosPlatform[1] - 12
					Sleep(200)
					If isPlayerAtLowestPoint($iXPosLowerPlatform, $iYPosLowerPlatform) == False Then ExitLoop
				Else
					ExitLoop
				EndIf
			EndIf
		EndIf
	WEnd
EndFunc   ;==>tryToGoUp

Func platformDoesNotExist($iX, $iY)
	PixelSearch($iX, $iY, $iX, $iY, 0xA7ACBA)
	If @error Then Return True
	Return False
EndFunc   ;==>platformDoesNotExist


Func isPlayerAtLowestPoint($iXPosLowerPlatform, $iYPosLowerPlatform)
	Local $iLowest = 0
	Local $aPosPlayer
	Local $startTime = TimerInit()

	While TimerDiff($startTime) < 700
		$aPosPlayer = PixelSearch(375, 730, 900, 330, 0x633E75)
		If @error Then
			Return False
		Else
			If $aPosPlayer[1] > $iLowest Then
				$iLowest = $aPosPlayer[1]
			EndIf
		EndIf

		; Check if the lowest platform is still the same
		If platformDoesNotExist($iXPosLowerPlatform, $iYPosLowerPlatform) Then Return False
	WEnd

	$startTime = TimerInit()
	While TimerDiff($startTime) < 800
		$aPosPlayer = PixelSearch(375, 730, 900, 330, 0x633E75)
		If @error Then
			Return False
		Else
			If $iLowest < $aPosPlayer[1] + 90 Then Return True
		EndIf
	WEnd
	; Check if the lowest platform is still the same
	If platformDoesNotExist($iXPosLowerPlatform, $iYPosLowerPlatform) Then Return False
	Return False
EndFunc   ;==>isPlayerAtLowestPoint

