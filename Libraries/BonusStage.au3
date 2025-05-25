#include-once
#include "Common.au3"

Func BonusStage($bSkipBonusStageState)
	WriteInLogs("Start of BonusStage")
	Sleep(200)
	PixelSearch(200, 505, 200, 505, 0x111014)
	If Not @error Then
		$bBonusStage3 = True
	Else
		$bBonusStage3 = False
	EndIf

	Do
		Slider()
		Sleep(500)
		PixelSearch(775, 448, 775, 448, 0xFFFFFF)
	Until @error

	If $bSkipBonusStageState Then
		BonusStageDoNothing($bBonusStage3 ? 3 : 2)
		Return
	EndIf

	Sleep(3900)
	PixelSearch(454, 91, 454, 91, 0xE1E0E2)
	If Not @error Then
		If $bBonusStage3 Then
			BonusStage3SB()
		Else
			BonusStage2SB()
		EndIf
	Else
		If $bBonusStage3 Then
			BonusStage3()
		Else
			BonusStage2()
		EndIf
	EndIf
EndFunc   ;==>BonusStage

Func BonusStageDoNothing($iNumber)
	WriteInLogs("Do nothing BonusStage Active")
	Do
		Sleep(200)
	Until BonusStageFail($iNumber)
EndFunc   ;==>BonusStageDoNothing

Func BonusStageFail($iNumber)
	Local $sLogMsg = "BonusStage" & $iNumber & " Failed"

	PixelSearch(780, 600, 780, 600, 0xAD0000)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		WriteInLogs($sLogMsg)
		Return True
	EndIf
	PixelSearch(780, 600, 780, 600, 0xB40000)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		WriteInLogs($sLogMsg)
		Return True
	EndIf
	Return False
EndFunc   ;==>BonusStageFail

Func BonusStageRetry($iNumber, $bSpiritBoost)
	Local $sLogMsg = "BonusStage" & $iNumber & ($bSpiritBoost ? "SB" : "")

	PixelSearch(600, 580, 600, 580, 0x00A400)
	If Not @error Then
		MouseClick("left", 560, 600, 1, 0)
		WriteInLogs($sLogMsg & " Retry")
		Sleep(1000)
		Return True
	EndIf

	Return False
EndFunc   ;==>BonusStageRetry

Func BonusStage2Fail()
	Return BonusStageFail(2)
EndFunc   ;==>BonusStage2Fail

Func BonusStage3Fail($bSpiritBoost)
	Local $sLogMsg = GetBS3LogText($bSpiritBoost)
	Local $bRetry = BonusStageRetry(3, $bSpiritBoost)

	If $bRetry Then
		Return True
	EndIf

	; Search for Items icon
	PixelSearch(1130, 604, 1130, 604, 0x989898)
	If Not @error Then
		WriteInLogs($sLogMsg & " Failed")
		Return True
	EndIf

	; Search for Boost icon
	PixelSearch(115, 570, 125, 590, 0x09439b)
	If Not @error Then
		WriteInLogs($sLogMsg & " Failed")
		Return True
	EndIf

	; Search for Wind Rush icon
	PixelSearch(115, 570, 125, 590, 0x099b66)
	If Not @error Then
		WriteInLogs($sLogMsg & " Failed")
		Return True
	EndIf

	Return False
EndFunc   ;==>BonusStage3Fail

Func BonusStage2SB()
	WriteInLogs("BonusStage2SB")
	; Section 1 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	Sleep(200)
	;Section 1 start
	cSend(94, 1640) ;1
	cSend(47, 2072) ;2
	cSend(187, 688) ;3
	cSend(31, 672) ;4
	cSend(31, 1700) ;5
	cSend(94, 1640) ;1
	cSend(47, 2072) ;2
	cSend(187, 688) ;3
	cSend(31, 672) ;4
	cSend(31, 1700) ;5
	cSend(94, 5000) ;1
	If BonusStage2Fail() Then
		Return
	EndIf
	; Section 1 Collection
	cSend(40, 2500)
	For $iX = 1 To 19
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2SB Section 1 Complete")
	; Section 2 sync
	FindPixelUntilFound(780, 536, 780, 536, 0xBB26DF)
	; Section 2 start
	cSend(156, 719) ;1
	cSend(47, 687) ;2
	cSend(360, 1390) ;3
	cSend(485, 344) ;4
	cSend(406, 749) ;5
	cSend(78, 600) ;6
	cSend(94, 900) ;7
	cSend(109, 954) ;8
	cSend(31, 672) ;9
	cSend(515, 1344) ;10
	cSend(484, 297) ;11
	cSend(406, 749) ;12
	cSend(78, 600) ;13
	cSend(94, 900) ;14
	cSend(109, 954) ;15
	cSend(31, 672) ;16
	cSend(515, 1344) ;17
	cSend(469, 219) ;18
	cSend(297, 750) ;19
	cSend(156, 500) ;20
	cSend(110, 3000) ;21
	cSend(360, 2984) ;22
	cSend(531, 2313) ;23
	If BonusStage2Fail() Then
		Return
	EndIf
	; Section 2 Collection
	cSend(350, 1000)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2SB Section 2 Complete")
	;Stage 3 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	; Section 3 Start
	cSend(109, 1203) ;1
	cSend(31, 641) ;2
	cSend(47, 1200) ;3
	cSend(1, 3100) ;4
	;repeat
	cSend(109, 1203) ;5
	cSend(31, 641) ;6
	cSend(47, 1200) ;7
	cSend(1, 3100) ;8
	;repeat
	cSend(109, 1203) ;9
	cSend(31, 641) ;10
	cSend(47, 1200) ;11
	cSend(1, 3100) ;12
	;repeat
	cSend(109, 1203) ;13
	cSend(31, 641) ;14
	cSend(47, 5125) ;15
	If BonusStage2Fail() Then
		Return
	EndIf
	;Section 3 Collection
	cSend(900, 200)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2SB Section 3 Complete")
	;Section 4 sync
	FindPixelUntilFound(250, 472, 100, 250, 0x0D2030)
	Sleep(200)
	;Section 4 Start
	cSend(32, 2800) ;1
	cSend(31, 809) ;2
	cSend(41, 1200) ;3
	cSend(100, 900) ;4
	cSend(641, 500) ;5

	cSend(31, 850) ;6
	cSend(41, 770) ;7
	cSend(641, 400) ;8

	cSend(31, 850) ;9
	cSend(41, 870) ;10
	cSend(641, 300) ;11

	cSend(31, 850) ;12
	cSend(41, 790) ;13
	cSend(641, 400) ;14

	cSend(31, 850) ;15
	cSend(41, 840) ;16
	cSend(641, 300) ;17

	cSend(31, 850) ;18
	cSend(41, 840) ;19
	cSend(641, 300) ;20
	;Section 4 Collection
	For $iX = 1 To 23
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2SB Section 4 Complete")
EndFunc   ;==>BonusStage2SB

Func BonusStage2()
	WriteInLogs("BonusStage2")
	; Section 1 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	Sleep(200)
	;Section 1 start
	cSend(94, 1640) ;1
	cSend(32, 1218) ;2
	cSend(94, 600) ;3
	cSend(109, 1828) ;4
	cSend(63, 640) ;5
	cSend(47, 688) ;6
	cSend(78, 1906) ;7
	cSend(141, 1625) ;8
	cSend(47, 3187) ;9
	cSend(47, 734) ;10
	cSend(47, 750) ;11
	cSend(78, 1203) ;12
	cSend(110, 5000) ;13
	If BonusStage2Fail() Then
		Return
	EndIf
	; Section 1 Collection
	cSend(40, 5000)
	For $iX = 1 To 17
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2 Section 1 Complete")
	; Section 2 sync
	FindPixelUntilFound(780, 536, 780, 536, 0xBB26DF)
	; Section 2 start
	cSend(156, 719) ;1
	cSend(47, 687) ;2
	cSend(360, 1390) ;3
	cSend(485, 344) ;4
	cSend(406, 749) ;5
	cSend(78, 600) ;6
	cSend(94, 900) ;7
	cSend(109, 954) ;8
	cSend(31, 672) ;9
	cSend(515, 1344) ;10
	cSend(484, 297) ;11
	cSend(406, 749) ;12
	cSend(78, 600) ;13
	cSend(94, 900) ;14
	cSend(109, 954) ;15
	cSend(31, 672) ;16
	cSend(515, 1344) ;17
	cSend(469, 219) ;18
	cSend(297, 750) ;19
	cSend(156, 500) ;20
	cSend(110, 3000) ;21
	cSend(360, 2984) ;22
	cSend(531, 2313) ;23
	If BonusStage2Fail() Then
		Return
	EndIf
	; Section 2 Collection
	cSend(350, 1000)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2 Section 2 Complete")
	;Stage 3 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	; Section 3 Start
	cSend(109, 1203) ;1
	cSend(31, 641) ;2
	cSend(47, 1578) ;3
	cSend(47, 2437) ;4
	;repeat
	cSend(109, 1203) ;5
	cSend(31, 641) ;6
	cSend(47, 1578) ;7
	cSend(47, 2437) ;8
	;repeat
	cSend(109, 1203) ;9
	cSend(31, 641) ;10
	cSend(47, 1578) ;11
	cSend(47, 2437) ;12
	;repeat
	cSend(109, 1203) ;13
	cSend(31, 641) ;14
	cSend(47, 5125) ;15
	If BonusStage2Fail() Then
		Return
	EndIf
	;Section 3 Collection
	cSend(900, 200)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2 Section 3 Complete")
	;Section 4 sync
	FindPixelUntilFound(250, 472, 100, 250, 0x0D2030)
	Sleep(200)
	;Section 4 Start
	cSend(32, 1375) ;1
	cSend(641, 690) ;2
	cSend(41, 1375) ;3
	cSend(41, 1374) ;4
	cSend(641, 690) ;5
	cSend(41, 1373) ;6
	cSend(41, 2500) ;7
	cSend(31, 809) ;8
	cSend(41, 1375) ;9
	cSend(41, 1374) ;10
	cSend(641, 690) ;11
	cSend(41, 1373) ;12
	cSend(41, 1372) ;13
	cSend(641, 690) ;14
	cSend(41, 1371) ;15
	; extra jump just in case
	cSend(41) ;16
	;Section 4 Collection
	For $iX = 1 To 23
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStage2Fail() Then
		Return
	EndIf
	WriteInLogs("BonusStage2 Section 4 Complete")
EndFunc   ;==>BonusStage2

Func BonusStage3($iCurrentSection = 0)
	Local $iTotalSections = 4

	If $iCurrentSection == 0 Then
		WriteInLogs("BonusStage3")
	ElseIf $iCurrentSection >= 2 * $iTotalSections Then
		Return
	EndIf

	Local $iSection = Mod($iCurrentSection, $iTotalSections)

	If $iSection == 0 Then
		If Not BonusStage3Section1() Then
			BonusStage3($iCurrentSection + $iTotalSections)
			Return
		EndIf
		$iCurrentSection += 1
		$iSection = 1
	EndIf
	If $iSection == 1 Then
		If Not BonusStage3Section2() Then
			BonusStage3($iCurrentSection + $iTotalSections)
			Return
		EndIf
		$iCurrentSection += 1
		$iSection = 2
	EndIf
	If $iSection == 2 Then
		If Not BonusStage3Section3() Then
			BonusStage3($iCurrentSection + $iTotalSections)
			Return
		EndIf
		$iCurrentSection += 1
		$iSection = 3
	EndIf
	If $iSection == 3 Then
		If Not BonusStage3Section4() Then
			BonusStage3($iCurrentSection + $iTotalSections)
			Return
		EndIf
	EndIf

EndFunc   ;==>BonusStage3

Func BonusStage3SB($iCurrentSection = 0)
	Local $iTotalSections = 4

	If $iCurrentSection == 0 Then
		WriteInLogs("BonusStage3SB")
	ElseIf $iCurrentSection >= 2 * $iTotalSections Then
		Return
	EndIf

	Local $iSection = Mod($iCurrentSection, $iTotalSections)

	If $iSection == 0 Then
		If Not BonusStage3Section1(True) Then
			BonusStage3SB($iCurrentSection + $iTotalSections)
			Return
		EndIf
		$iCurrentSection += 1
		$iSection = 1
	EndIf
	If $iSection == 1 Then
		If Not BonusStage3Section2(True) Then
			BonusStage3SB($iCurrentSection + $iTotalSections)
			Return
		EndIf
		$iCurrentSection += 1
		$iSection = 2
	EndIf
	If $iSection == 2 Then
		If Not BonusStage3Section3(True) Then
			BonusStage3SB($iCurrentSection + $iTotalSections)
			Return
		EndIf
		$iCurrentSection += 1
		$iSection = 3
	EndIf
	If $iSection == 3 Then
		If Not BonusStage3Section4(True) Then
			BonusStage3SB($iCurrentSection + $iTotalSections)
			Return
		EndIf
	EndIf

EndFunc   ;==>BonusStage3SB

Func BonusStage3Section1($bSpiritBoost = False)
	; Section 1 sync
	FindPixelUntilFound(520, 200, 580, 250, 0xFFFFFF)
	Sleep(360)
	;Section 1 start
	cSend(140, 530) ;1
	cSend(70, 640) ;2
	cSend(80, 740) ;3
	cSend(150, 765) ;4
	cSend(65, 625) ;5
	cSend(65, 500) ; 6

	FindPixelUntilFound(540, 335, 555, 360, 0xFFFFFF, 700)
	cSend(150, 750) ;7
	cSend(200, 200) ;8

	FindPixelUntilFound(390, 230, 410, 250, 0xFFFFFF, 3500)
	cSend(130, 545) ;9
	cSend(70, 620) ;10
	cSend(80, 400) ;11
	FindPixelUntilFound(500, 200, 515, 250, 0xFFFFFF, 1500)

	cSend(150, 755) ;12
	cSend(65, 625) ;13
	cSend(65, 500) ;14

	FindPixelUntilFound(540, 335, 555, 360, 0xFFFFFF, 700)
	cSend(150, 740) ;15
	cSend(200, 1490) ;16

	cSend(110, 580) ;17
	cSend(65, 640) ;18
	cSend(80, 740) ;19
	cSend(150, 765) ;20

	cSend(130, 560) ;21
	cSend(70, 650) ;22

	Sleep(800)

	If CollectLootBS3($bSpiritBoost, 21) == False Then Return False
	WriteInLogs(GetBS3LogText($bSpiritBoost) & " Section 1 Complete")

	Return True
EndFunc   ;==>BonusStage3Section1

Func BonusStage3Section2($bSpiritBoost = False)
	; Section 2 sync
	FindPixelUntilFound(306, 200, 309, 275, 0xFFFFFF)
	; Section 2 start

	For $iX = 1 To 2
		cSend(80, 440) ;1
		cSend(95, 660) ;2
		cSend(105, 500) ;3

		FindPixelUntilFound(475, 445, 482, 475, 0xFFFFFF, 1000)

		cSend(79, 601) ;4
		cSend(63, 980) ;5
		cSend(82, 440) ;6
		cSend(95, 660) ;7

		cSend(48, 750) ;8
		FindPixelUntilFound(515, 265, 522, 285, 0xFFFFFF, 1200)

		cSend(63, 500) ;9
		BonusStage3WallJump(1) ; 10
		Sleep(80)
		BonusStage3WallJump(1) ; 11
		Sleep(300)
		BonusStage3WallJump(4) ; 12

		FindPixelUntilFound(306, 200, 309, 275, 0xFFFFFF, 1000)

	Next

	cSend(80, 440)
	cSend(95, 660)

	If CollectLootBS3($bSpiritBoost) == False Then Return False
	WriteInLogs(GetBS3LogText($bSpiritBoost) & " Section 2 Complete")
	Return True
EndFunc   ;==>BonusStage3Section2

Func BonusStage3Section3($bSpiritBoost = False)
	Local $bUpperWay = False
	;Stage 3 sync
	FindPixelUntilFound(280, 385, 330, 435, 0xFFFFFF)
	Sleep(600)

	For $iX = 1 To 2
		If $bUpperWay Then
			BonusStage3WallJump()
			$bUpperWay = False
		Else
			cSend(120, 100) ;1

			FindPixelUntilFound(205, 395, 215, 410, 0xFFFFFF, 780)

			cSend(95, 225) ;2
			BonusStage3WallJump() ;3
		EndIf

		Sleep(2000) ;4

		cSend(300, 500) ;5
		BonusStage3WallJump() ;6
		FindPixelUntilFound(205, 395, 215, 410, 0xFFFFFF, 900)

		If $iX < 3 Then
			cSend(95, 250) ;7
			BonusStage3WallJump(1, 715) ;8
			BonusStage3WallJump(6) ;9

			Local $bFound = FindPixelUntilFound(300, 415, 330, 435, 0xFFFFFF, $bSpiritBoost ? 1000 : 2500)
			If $bFound == False Then
				$bUpperWay = True
			Else
				Sleep(2500)
			EndIf

			Sleep(150)
		EndIf
	Next

	If CollectLootBS3($bSpiritBoost) == False Then Return False
	WriteInLogs(GetBS3LogText($bSpiritBoost) & " Section 3 Complete")
	Return True
EndFunc   ;==>BonusStage3Section3

Func BonusStage3WallJump($iCount = 5, $iSleep = 50)
	For $iX = 1 To $iCount
		cSend(30, $iSleep) ;2
	Next
EndFunc   ;==>BonusStage3WallJump

Func BonusStage3Section4($bSpiritBoost = False)
	;Section 4 sync
	FindPixelUntilFound(330, 170, 380, 195, 0xFFFFFF)
	;Section 4 Starts
	If Not $bSpiritBoost Then
		For $iX = 1 To 5
			cSend(300, 600) ;1

			cSend(300, 420) ;2

			cSend(35, 748) ;3
			cSend(35, 540) ;4
			cSend(35, 1160) ;5s
		Next
	Else
		For $iX = 1 To 14
			cSend(110, 1180) ;1
		Next

		cSend(300, 300)
	EndIf

	If CollectLootBS3($bSpiritBoost, 25, False) == False Then Return False
	WriteInLogs(GetBS3LogText($bSpiritBoost) & " Section 4 Complete")
	Return True
EndFunc   ;==>BonusStage3Section4

Func GetBS3LogText($bSpiritBoost)
	Return "BonusStage3" & ($bSpiritBoost ? "SB" : "")
EndFunc   ;==>GetBS3LogText

Func CollectLootBS3($bSpiritBoost, $iCount = 25, $bStopEarly = True)
	If BonusStage3Fail($bSpiritBoost) Then
		Return False
	EndIf
	;Section 3 Collection
	For $iX = 1 To $iCount
		; Check if next section already begins then end earlier
		If $bStopEarly = True And $iX > 8 Then
			$aPos = FindPixelUntilFound(1100, 240, 1100, 440, 0x8D87A2, 480)
			If IsArray($aPos) Then ExitLoop
		Else
			Sleep(500)
		EndIf

		cSend(0, 0)
	Next
	If BonusStage3Fail($bSpiritBoost) Then
		Return False
	EndIf

	Return True
EndFunc
