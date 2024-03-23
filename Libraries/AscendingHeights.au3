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

	While True
		PixelSearch(190, 125, 190, 125, 0xFFAF36)
		If Not @error Then
			WriteInLogs("Ascending Height Failed")
			ExitLoop
		EndIf

		PixelSearch(590, 590, 590, 590, 0x00A800)
		If Not @error Then MouseClick("left", 590, 590, 1, 0)

		PixelSearch(730, 385, 730, 385, 0x7A444A)
		If Not @error Then cSend(6000, 0, "d")

		$aPosPlayer = PixelSearch(375, 260, 900, 730, 0x8A3B18)
		If @error Then ContinueLoop

		$aPosPlatform = searchSafePlatform(375, 752, 900, 200, $aPosPlayer[1] + 140)
		If Not IsArray($aPosPlatform) Then ContinueLoop

		If ($aPosPlatform[0] + 40) > $aPosPlayer[0] + 25 Then
			cSend(85, 0, "d")
			$iSamePositionCount = 0
		ElseIf ($aPosPlatform[0] + 40) < $aPosPlayer[0] - 25 Then
			cSend(85, 0, "a")
			$iSamePositionCount = 0
		Else
			If $iPosPreviousX = $aPosPlatform[0] And $iPosPreviousY = $aPosPlatform[1] Then
				$iSamePositionCount += 1
				If $iSamePositionCount >= 50 Then
					$iSamePositionCount = 0
					tryToGoUp($aPosPlatform[1], $aPosPlatform[0])
				EndIf
			Else
				$iSamePositionCount = 0
			EndIf
			$iPosPreviousX = $aPosPlatform[0]
			$iPosPreviousY = $aPosPlatform[1]
		EndIf
	WEnd
EndFunc   ;==>AscendingHeightsPlay


Func searchSafePlatform($iX, $iY, $iX1, $iY2, $iYPlayerPos = 550)
	;Return searchAllPlatform($iX, $iY, $iX1, $iY2)
	Local $aPosPlatform = PixelSearch($iX, $iY, $iX1, $iY2, 0xA7ACBA)
	If Not @error Then
		While True
			PixelSearch($aPosPlatform[0] + 34, $aPosPlatform[1], $aPosPlatform[0] + 34, $aPosPlatform[1], 0xA7ACBA)
			If Not @error Then Return $aPosPlatform
			If $aPosPlatform[1] - 15 < $iYPlayerPos Then Return searchAllPlatform($iX, $iY, $iX1, $iY2)
			$aPosPlatform = PixelSearch($iX, $aPosPlatform[1] - 15, $iX1, $iY2, 0xA7ACBA)
			If @error Then Return searchAllPlatform($iX, $iY, $iX1, $iY2)
		WEnd
	EndIf
EndFunc   ;==>searchSafePlatform

Func searchAllPlatform($iX, $iY, $iX1, $iY2)
	Local $aPosPlatform = PixelSearch($iX, $iY, $iX1, $iY2, 0xA7ACBA)
	If Not @error Then
		While True
			PixelSearch($aPosPlatform[0] + 47, $aPosPlatform[1], $aPosPlatform[0] + 47, $aPosPlatform[1], 0xA7ACBA)
			If Not @error Then Return $aPosPlatform
			If $aPosPlatform[1] - 20 < $iY2 Then Return False
			$aPosPlatform = PixelSearch($iX, $aPosPlatform[1] - 20, $iX1, $iY2, 0xA7ACBA)
			If @error Then Return False
		WEnd
	EndIf
EndFunc   ;==>searchAllPlatform

Func tryToGoUp($iYPosLowerPlatform, $iXPosLowerPlatform)

	Local $aPosPlayer
	Local $aPosPlatformLow
	Local $aPosPlatform
	Local $iYPosHigherPlatform = $iYPosLowerPlatform - 15
	isPlayerGoingUp()
	While True
		$aPosPlayer = PixelSearch(375, 330, 900, 730, 0x8A3B18)
		If @error Then ExitLoop

		$aPosPlatform = searchSafePlatform(375, $iYPosHigherPlatform, 836, 450, $aPosPlayer[1] + 140)
		If $aPosPlatform == 0 Then ExitLoop

		If ($aPosPlatform[0] + 35) > $aPosPlayer[0] + 20 Then
			cSend(85, 0, "d")
		ElseIf ($aPosPlatform[0] + 35) < $aPosPlayer[0] - 20 Then
			cSend(85, 0, "a")
		Else
			Sleep(300)
			isPlayerGoingUp()
			$aPosPlatformLow = searchSafePlatform(375, 752, 900, 200)
			If Not IsArray($aPosPlatformLow) Then ExitLoop
			If $iYPosLowerPlatform == $aPosPlatformLow[1] And $iXPosLowerPlatform == $aPosPlatformLow[0] Then
				$iYPosHigherPlatform -= 15
			Else
				ExitLoop
			EndIf
		EndIf
	WEnd
EndFunc   ;==>tryToGoUp

Func isPlayerGoingUp()
	Local $aPrevPosPlayer = 0
	Local $bGoingDown = False
	Local $aPosPlayer
	While True
		$aPosPlayer = PixelSearch(375, 330, 900, 730, 0x8A3B18)
		If @error Then
			Return False
		Else
			If $aPosPlayer[1] < $aPrevPosPlayer And $bGoingDown Then Return True
			$bGoingDown = $aPosPlayer[1] > $aPrevPosPlayer
			$aPrevPosPlayer = $aPosPlayer[1]
		EndIf
		Sleep(45)
	WEnd
EndFunc   ;==>isPlayerGoingUp

