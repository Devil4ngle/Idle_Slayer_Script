#include-once
#include "Common.au3"

;setSetting()
;AscendingHeightsPlay()


Func AscendingHeights()
	WriteInLogs("Start of Ascending Heights")
	Do
		Slider()
		Sleep(500)
		PixelSearch(640, 240, 634, 640, 0xFFCC66)
	Until @error
	Sleep(3900)
	AscendingHeightsPlay()
EndFunc   ;==>AscendingHeights

Func AscendingHeightsPlay()
	Local $aPosPlayer
	Local $aPosPlatform
	Local $iPosPlatX = 0
	Local $iPosPlatY = 0
	Local $iCount = 0
	Local $bSame = False

	Local $iLastCheckTime = TimerInit()
	Local $iStuckTimer = TimerInit()
	While True
		If TimerDiff($iLastCheckTime) >= 5000 Then
			$iLastCheckTime = TimerInit()

			PixelSearch(190, 125, 190, 125, 0xFFAF36)
			If Not @error Then
				WriteInLogs("Ascending Height Failed")
				ExitLoop
			EndIf

			PixelSearch(560, 560, 1280, 720, 0x00A800)
			If Not @error Then
				Sleep(2000)
				MouseClick("left", 560, 570, 1, 0)
			EndIf

			PixelSearch(700, 385, 730, 385, 0x7A444A)
			If Not @error Then
				cSend(15000, 0, "d")
				WriteInLogs("Ascending Height Won")
				ExitLoop
			EndIf
		EndIf

		$aPosPlayer = PixelSearch(375, 260, 900, 730, 0x11869E, 31)
		If @error Then ContinueLoop
		$aPosPlatform = searchAllPlatformBellowPlayer($aPosPlayer[0], $aPosPlayer[1], $bSame)
		If Not IsArray($aPosPlatform) Then ContinueLoop

		; Detect if the character is stuck
		If $iPosPlatX == $aPosPlatform[0] And $iPosPlatY == $aPosPlatform[1] Then
			$iCount += 1
			If $iCount = 5 Then $bSame = True

			If TimerDiff($iStuckTimer) > 5000 Then ;
				$bSame = False
				MoveCharacterSideways($aPosPlayer[0], $aPosPlatform[0])
				$iStuckTimer = TimerInit()
			EndIf
		Else
			$iCount = 0
			$bSame = False
			$iStuckTimer = TimerInit()
		EndIf
		$iPosPlatX = $aPosPlatform[0]
		$iPosPlatY = $aPosPlatform[1]

		If ($aPosPlatform[0] + 35) > ($aPosPlayer[0] + 35) Then
			;cSend(100, 0, "d")
			MouseMove(1100, 600, 0)
			MouseDown("left")
			Sleep(100)
			MouseUp("left")
		ElseIf ($aPosPlatform[0] + 35) < ($aPosPlayer[0] - 35) Then
			;cSend(100, 0, "a")
			MouseMove(100, 600, 0)
			MouseDown("left")
			Sleep(100)
			MouseUp("left")
		EndIf
	WEnd
EndFunc   ;==>AscendingHeightsPlay

Func MoveCharacterSideways($iPlayerX, $iPlatformX)
	WriteInLogs("Unstucking Character")
	If $iPlayerX < $iPlatformX Then
		MouseMove(1100, 600, 0)
	Else
		MouseMove(100, 600, 0)
	EndIf
	MouseDown("left")
	Sleep(200)
	MouseUp("left")
EndFunc   ;==>MoveCharacterSideways

Func searchAllPlatformBellowPlayer($iPlayerX, $iPlayerY, $bSame)
	Local $aIgnoredColors = [0xAA4D5A, 0xB14F48, 0x3A4466] ; Colors to try to ignore

	If Not $bSame Then
		Local $iLeft = $iPlayerX - 130
		Local $iRight = $iPlayerX + 130
		If $iLeft < 375 Then $iLeft = 375
		If $iRight > 900 Then $iRight = 900

		Local $aPosPlatform = PixelSearch($iLeft, $iPlayerY + 50, $iRight, 752, 0x8B9BB4)
		If @error Then
			$aPosPlatform = PixelSearch(375, $iPlayerY + 50, 900, 752, 0x8B9BB4)
		EndIf
	Else
		$aPosPlatform = PixelSearch(375, $iPlayerY + 50, 900, 752, 0x8B9BB4)
	EndIf

	If Not @error Then
		While True
			; Verify if any of the platforms match the unwanted colors
			Local $bIgnorePlatform = False
			For $i = 0 To UBound($aIgnoredColors) - 1
				If PixelGetColor($aPosPlatform[0], $aPosPlatform[1]) = $aIgnoredColors[$i] Then
					$bIgnorePlatform = True
					ExitLoop
				EndIf
			Next

			If Not $bIgnorePlatform Then
				PixelSearch($aPosPlatform[0] + 4, $aPosPlatform[1], $aPosPlatform[0] + 4, $aPosPlatform[1], 0x151515)
				If @error Then Return $aPosPlatform
				If $aPosPlatform[1] + 13 > 752 Then Return False
				$aPosPlatform = PixelSearch(375, $aPosPlatform[1] + 13, 900, 752, 0x8B9BB4)
				If @error Then Return False
			Else
				$aPosPlatform = PixelSearch(375, $aPosPlatform[1] + 13, 900, 752, 0x8B9BB4)
				If @error Then Return False
			EndIf
		WEnd
	EndIf
EndFunc   ;==>searchAllPlatformBellowPlayer