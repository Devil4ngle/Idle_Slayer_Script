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
	Local $samePositionCount = 0
	Local $iPosPreviousX = 0
	Local $iPosPreviousY = 0

	While True
		PixelSearch(190, 125, 190, 125, 0xFFAF36)
		If Not @error Then
			WriteInLogs("Ascending Height Failed")
			ExitLoop
		EndIf

		PixelSearch(590, 590, 590, 590, 0x00A800)
		If Not @error Then
			MouseClick("left", 590, 590, 1, 0)
		EndIf

		PixelSearch(730, 385, 730, 385, 0x7A444A)
		If Not @error Then
			cSend(6000, 0, "d")
		EndIf
		$aPosPlayer = PixelSearch(375, 260, 900, 730, 0x8A3B18)
		If @error Then
			ContinueLoop
		EndIf

		$aPosPlatForm = searchSafePlatForm(375, 752, 900, 200, $aPosPlayer[1] + 140)
		If $aPosPlatForm == 0 Or IsBool($aPosPlatForm) Then
			ContinueLoop
		EndIf

		;ConsoleWrite(" Y:" &  $aPosPlatForm[1] & " Player Y:" &  $aPosPlayer[1] & @CRLF)
		;ConsoleWrite(" X:" &  $aPosPlatForm[0] & " Player X:" &  $aPosPlayer[0] & @CRLF)

		If ($aPosPlatForm[0] + 40) > $aPosPlayer[0] + 25 Then
			cSend(85, 0, "d")
			$samePositionCount = 0
		ElseIf ($aPosPlatForm[0] + 40) < $aPosPlayer[0] - 25 Then
			cSend(85, 0, "a")
			$samePositionCount = 0
		Else
			If $iPosPreviousX == $aPosPlatForm[0] And $iPosPreviousY == $aPosPlatForm[1] Then
				$samePositionCount += 1
				If $samePositionCount >= 50 Then
					$samePositionCount = 0
					;ConsoleWrite(" Same Position ")
					tryToGoUp($aPosPlatForm[1], $aPosPlatForm[0])
				EndIf
			Else
				$samePositionCount = 0
			EndIf
			$iPosPreviousX = $aPosPlatForm[0]
			$iPosPreviousY = $aPosPlatForm[1]
		EndIf
	WEnd
EndFunc   ;==>AscendingHeightsPlay


Func searchSafePlatForm($iX, $iY, $iX1, $iY2, $iYPlayerPos = 550)
	;Return searchSemiBrokenPlatForm($iX, $iY, $iX1, $iY2)
	$aPosPlatForm = PixelSearch($iX, $iY, $iX1, $iY2, 0xA7ACBA)
	If Not @error Then
		While True
			PixelSearch($aPosPlatForm[0] + 34, $aPosPlatForm[1], $aPosPlatForm[0] + 34, $aPosPlatForm[1], 0xA7ACBA)
			If Not @error Then
				Return $aPosPlatForm
			EndIf
			If $aPosPlatForm[1] - 15 < $iYPlayerPos Then
				Return searchSemiBrokenPlatForm($iX, $iY, $iX1, $iY2)
			EndIf
			$aPosPlatForm = PixelSearch($iX, $aPosPlatForm[1] - 15, $iX1, $iY2, 0xA7ACBA)
			If @error Then
				Return searchSemiBrokenPlatForm($iX, $iY, $iX1, $iY2)
			EndIf
		WEnd
	EndIf
EndFunc   ;==>searchSafePlatForm

Func searchSemiBrokenPlatForm($iX, $iY, $iX1, $iY2)
	$aPosPlatForm = PixelSearch($iX, $iY, $iX1, $iY2, 0xA7ACBA)
	If Not @error Then
		While True
			PixelSearch($aPosPlatForm[0] + 47, $aPosPlatForm[1], $aPosPlatForm[0] + 47, $aPosPlatForm[1], 0xA7ACBA)
			If Not @error Then
				Return $aPosPlatForm
			EndIf
			If $aPosPlatForm[1] - 20 < $iY2 Then
				;ConsoleWrite("Found Noting")
				Return False
			EndIf
			$aPosPlatForm = PixelSearch($iX, $aPosPlatForm[1] - 20, $iX1, $iY2, 0xA7ACBA)
			If @error Then
				;ConsoleWrite("Found Noting")
				Return False
			EndIf
		WEnd
	EndIf
EndFunc   ;==>searchSemiBrokenPlatForm

Func tryToGoUp($iYPosLowerPlatForm, $iXPosLowerPlatForm)
	$iYPosLowerPlatFormOriginal = $iYPosLowerPlatForm
	If isPlayerGoingUp() Then
		;ConsoleWrite(" Lower Safest Platform : " & $iYPosLowerPlatForm - 30)
		$aPosPlatForm = searchSafePlatForm(375, $iYPosLowerPlatForm - 15, 836, 330)
		If IsArray($aPosPlatForm) Then
			While True
				$aPosPlayer = PixelSearch(375, 330, 900, 730, 0x8A3B18)
				If @error Then
					;ConsoleWrite(" Player not found Higher ")
					ExitLoop
				EndIf
				If ($aPosPlatForm[0] + 35) > $aPosPlayer[0] + 30 Then
					cSend(85, 0, "d")
				ElseIf ($aPosPlatForm[0] + 35) < $aPosPlayer[0] - 30 Then
					cSend(85, 0, "a")
				Else
					Sleep(100)
					isPlayerGoingUp()
					$aPosPlatFormLow = searchSafePlatForm(375, 752, 900, 200)
					If $aPosPlatFormLow == 0 Or IsBool($aPosPlatForm) Then
						ExitLoop
					EndIf
					If $iYPosLowerPlatFormOriginal == $aPosPlatFormLow[1] And $iXPosLowerPlatForm == $aPosPlatFormLow[0] Then
						$iYPosLowerPlatForm = $iYPosLowerPlatForm - 15
					Else
						;ConsoleWrite(" ExitHigher ")
						ExitLoop
					EndIf
				EndIf
				$aPosPlatForm = searchSafePlatForm(375, $iYPosLowerPlatForm - 15, 836, 330)
				If $aPosPlatForm == 0 Then
					;ConsoleWrite(" ExitHigher Error ")
					ExitLoop
				EndIf
			WEnd
		EndIf
	EndIf
EndFunc   ;==>tryToGoUp

Func isPlayerGoingUp()
	Local $aPrevPosPlayer = 0
	Local $goingDown = False
	While True
		$aPosPlayer = PixelSearch(375, 330, 900, 730, 0x8A3B18)
		If @error Then
			Return False
		Else
			$errorCount = 0
			If $aPosPlayer[1] < $aPrevPosPlayer And $goingDown Then
				;ConsoleWrite(" Going up ")
				Return True
			EndIf
			$goingDown = $aPosPlayer[1] > $aPrevPosPlayer
			$aPrevPosPlayer = $aPosPlayer[1]
			Sleep(45)
		EndIf
	WEnd
EndFunc   ;==>isPlayerGoingUp
