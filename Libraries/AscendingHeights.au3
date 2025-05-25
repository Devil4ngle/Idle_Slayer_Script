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
	Local $iStartTime = TimerInit() ; Timer for 4-minute timeout
	
	While True
		; Check for 4-minute timeout 
		If TimerDiff($iStartTime) >= 240000 Then
			WriteInLogs("Ascending Heights timed out after 4 minutes")
			; Press 'a' for 3 seconds
			cSend(3000, 0, "a")
			Sleep(100)
			; Press 'd' for 3 seconds
			cSend(3000, 0, "d")
			ExitLoop
		EndIf
		
		If TimerDiff($iLastCheckTime) >= 5000 Then
			$iLastCheckTime = TimerInit()

			PixelSearch(190, 125, 190, 125, 0xFFAF36)
			If Not @error Then
				WriteInLogs("Ascending Height Failed")
				ExitLoop
			EndIf

			PixelSearch(540, 560, 540, 560, 0x00A400)
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

		$aPosPlayer = PixelSearch(375, 260, 900, 730, 0x633E75)
		If @error Then ContinueLoop

		$aPosPlatform = searchAllPlatformBellowPlayer($aPosPlayer[0], $aPosPlayer[1], $bSame)
		If Not IsArray($aPosPlatform) Then ContinueLoop


		If $iPosPlatX == $aPosPlatform[0] And $iPosPlatY == $aPosPlatform[1] Then
			$iCount += 1
			If $iCount = 5 Then $bSame = True
		Else
			$iCount = 0
			$bSame = False
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

Func searchAllPlatformBellowPlayer($iPlayerX, $iPlayerY, $bSame)
	If Not $bSame Then
		Local $iLeft = $iPlayerX - 130
		Local $iRight = $iPlayerX + 130
		If $iLeft < 375 Then $iLeft = 375
		If $iRight > 900 Then $iLeft = 900

		Local $aPosPlatform = PixelSearch($iLeft, $iPlayerY + 50, $iRight, 752, 0xC0CBDC)
		If @error Then
			$aPosPlatform = PixelSearch(375, $iPlayerY + 50, 900, 752, 0xC0CBDC)
		EndIf
	Else
		$aPosPlatform = PixelSearch(375, $iPlayerY + 50, 900, 752, 0xC0CBDC)
	EndIf

	If Not @error Then
		Local $iLoopCounter = 0 ; Safety counter to prevent infinite loops
		While True
			$iLoopCounter += 1
			If $iLoopCounter > 1000 Then Return False ; Exit if too many iterations
			
			PixelSearch($aPosPlatform[0] + 6, $aPosPlatform[1], $aPosPlatform[0] + 6, $aPosPlatform[1], 0x8B9BB4)
			If @error Then Return $aPosPlatform
			If $aPosPlatform[1] + 2 > 752 Then Return False
			$aPosPlatform = PixelSearch(375, $aPosPlatform[1] + 1, 900, 752, 0xC0CBDC)
			If @error Then Return False
		WEnd
	EndIf

EndFunc   ;==>searchAllPlatformBellowPlayer