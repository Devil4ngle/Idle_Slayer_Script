#comments-start
 AutoIt Version: 3.3.16.0
 Author:         Devil4ngle
#comments-end

; Disable Caps for better background
Opt("SendCapslockMode", 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode", 0)

; Infinite Loop
While 1
	ControlFocus("Idle Slayer", "", "")
	ControlSend("Idle Slayer", "", "", "{Up}{Right}{e}")
	Sleep(150)

	; Silver box collect
	PixelSearch(580, 40, 580, 40, 0xFF0000)
	If Not @error Then
		MouseClick("left", 644, 49, 1, 0)
	EndIf

	; Chest-hunt
	PixelSearch(598, 45, 598, 45, 0xD0C172)
	If Not @error Then
		Chesthunt()
	EndIf


	; Collect minions
	PixelSearch(99, 113, 99, 113, 0xFFFF7A)
	If Not @error Then
		CollectMinion()
	EndIf

	; Bonus stage
	PixelSearch(860, 670, 860, 670, 0xAC8371)
	If Not @error Then
		BonusStage()
	EndIf
WEnd

Func CollectMinion()
	MouseClick("left", 95, 90, 1, 0)
	Sleep(400)
	MouseClick("left", 332, 680, 1, 0)
	Sleep(100)
	MouseClick("left", 318, 182, 1, 0)
	Sleep(100)
	MouseClick("left", 318, 182, 1, 0)
	Sleep(100)
	MouseClick("left", 570, 694, 1, 0)
EndFunc   ;==>CollectMinion

Func Chesthunt()
	Sleep(2000)
	Local $saverX = 0
	Local $saverY = 0
	Local $pixelX = 185
	Local $pixelY = 325
	; Locate saver
	For $y = 1 To 3
		For $x = 1 To 10
			PixelSearch($pixelX, $pixelY - 1, $pixelX + 5, $pixelY, 0xFFEB04)
			If Not @error Then
				$saverX = $pixelX
				$saverY = $pixelY
				ExitLoop (2)
			EndIf
			$pixelX += 95
		Next
		$pixelY += 95
		$pixelX = 185
	Next
	; Actual chest hunt
	$pixelX = 185
	$pixelY = 325
	For $y = 1 To 3
		For $x = 1 To 10
			; After opening 2 chest open saver
			If $x == 3 And $y == 1 And $saverX > 0 Then
				MouseClick("left", $saverX + 33, $saverY - 23, 1, 0)
				Sleep(550)
			EndIf
			; Skip saver no matter what
			If $pixelY == $saverY And $pixelX == $saverX Then
				; Go next line If saver is last chest
				If $x == 10 Then
					ExitLoop (1)
				Else
					$x += 1
					$pixelX += 95
				EndIf
			EndIf
			; Open chest
			MouseClick("left", $pixelX + 33, $pixelY - 23, 1, 0)
			Sleep(550)
			; Check if chest hunt ended
			PixelSearch(400, 695, 400, 695, 0xB40000)
			If Not @error Then
				ExitLoop (2)
			EndIf
			; if mimic wait some more
			PixelSearch(434, 211, 434, 211, 0xFF0000)
			If Not @error Then
				Sleep(1500)
			EndIf
			$pixelX += 95
		Next
		$pixelY += 95
		$pixelX = 185
	Next
	; Look for close button until found
	Do
		Sleep(50)
		PixelSearch(400, 694, 400, 694, 0xB40000)
	Until Not @error
	MouseClick("left", 643, 693, 1, 0)
	; Boost and sleep
	ControlSend("Idle Slayer", "", "", "{Right}")
	Sleep(2000)
EndFunc   ;==>Chesthunt

Func BonusStage()
	BonusStageSlider()
	Sleep(4000)
	PixelSearch(443, 97, 443, 97, 0xFFFFFF)
	If Not @error Then ;if Spirit Boost do noting untill close appear
		Do
			Sleep(200)
		Until BonusStageFail()
	Else
		;Run until block
		Do
			Sleep(200)
			PixelSearch(220, 465, 220, 465, 0xA0938E)
		Until Not @error
		Sleep(200)
		BonusStageNSP()
	EndIf

EndFunc   ;==>BonusStage

Func BonusStageSlider()
	;Top left
	PixelSearch(443, 560, 443, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 840, 560, 450, 560)
		Return
	EndIf

	;Bottom left
	PixelSearch(443, 620, 443, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 840, 620, 450, 620)
		Return
	EndIf

	;Top right
	PixelSearch(850, 560, 850, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 450, 560, 840, 560)
		Return
	EndIf

	;Bottom right
	PixelSearch(850, 620, 850, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 450, 620, 840, 620)
		Return
	EndIf
EndFunc   ;==>BonusStageSlider

Func BonusStageFail()
	PixelSearch(810, 631, 810, 631, 0x723536)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		Return True
	EndIf
	Return False
EndFunc   ;==>BonusStageFail

Func BonusStageNSP()
	;Section 1
	cSend(94, 1640)
	cSend(32, 1218)
	cSend(109, 1828)
	cSend(63, 640)
	cSend(47, 688)
	cSend(78, 1906)
	cSend(141, 1625)
	cSend(47, 3187)
	cSend(47, 734)
	cSend(47, 750)
	cSend(78, 1203)
	cSend(110)
	If BonusStageFail() Then
		Return
	EndIf
	; Section 2
	Sleep(5094)
	cSend(46, 6047)
	cSend(47, 219)
	cSend(78, 1313)
	cSend(62, 2141)
	cSend(31, 7700)
	; Stage 2 sync
	Do
		Sleep(10)
		PixelSearch(670, 149, 670, 149, 0x7A444A)
	Until Not @error
	cSend(156, 719)
	cSend(47, 687)
	cSend(360, 1390)
	cSend(485, 344)
	cSend(406, 859)
	cSend(78, 1203)
	cSend(94, 922)
	cSend(109, 954)
	cSend(31, 672)
	cSend(515, 1344)
	cSend(484, 297)
	cSend(78, 1297)
	cSend(156, 813)
	cSend(172, 984)
	cSend(31, 625)
	cSend(610, 1890)
	cSend(469, 219)
	cSend(297, 1000)
	cSend(156, 1531)
	cSend(110, 1390)
	cSend(360, 5984)
	cSend(360, 5984)
	cSend(531)
	If BonusStageFail() Then
		Return
	EndIf
	; Section 3
	Sleep(2313)
	cSend(344, 1234)
	cSend(62, 454)
	cSend(62, 1125)
	cSend(47, 3047)
	cSend(62, 110)
	cSend(62, 9219)
	cSend(109, 1203)
	cSend(31, 641)
	cSend(47, 1578)
	cSend(47, 2437)
	cSend(110, 1297)
	cSend(31, 656)
	cSend(47, 1625)
	cSend(31, 2313)
	cSend(109, 1516)
	cSend(47, 640)
	cSend(47, 1547)
	cSend(47, 1969)
	cSend(93, 1203)
	cSend(47, 625)
	cSend(47)
	If BonusStageFail() Then
		Return
	EndIf
	;Section 4
	Sleep(5125)
	cSend(891, 1406)
	cSend(94, 344)
	cSend(78, 359)
	cSend(78, 3453)
	cSend(63, 9062)
	cSend(32, 4578)
	cSend(31, 859)
	cSend(47, 1375)
	cSend(47, 1406)
	cSend(641, 703)
	cSend(31, 1344)
	cSend(47, 1484)
	cSend(578, 766)
	cSend(31, 1407)
	cSend(31, 1437)
	cSend(563, 719)
	cSend(46, 1438)
	cSend(47, 1422)
	cSend(547, 750)
	cSend(46, 1625)
	cSend(94, 391)
	cSend(281, 1391)
	cSend(109, 2406)
	cSend(63, 390)
	cSend(63, 2672)
	cSend(62, 485)
	cSend(47)
	If BonusStageFail() Then
		Return
	EndIf
	Sleep(4000)
	If BonusStageFail() Then
		Return
	EndIf
EndFunc   ;==>BonusStageNSP

Func cSend($pressDelay, $postPressDelay = 0, $key = "Up")
	ControlSend("Idle Slayer", "", "", "{" & $key & " Down}")
	Sleep($pressDelay)
	ControlSend("Idle Slayer", "", "", "{" & $key & " Up}")
	Sleep($postPressDelay)
EndFunc   ;==>cSend
