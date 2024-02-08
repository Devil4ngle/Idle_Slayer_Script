#include <File.au3>

Func BonusStage($sLogPath, $bSkipBonusStageState)
	_FileWriteLog($sLogPath, "Start of BonusStage")
	Do
		Slider()
		Sleep(500)
		PixelSearch(660, 254, 660, 254, 0xFFE737)
	Until @error
	Sleep(3900)
	PixelSearch(454, 91, 454, 91, 0xE1E0E2)
	If $bSkipBonusStageState Then
		BonusStageDoNoting($sLogPath)
	Else
		If Not @error Then ;if Spirit Boost do noting untill close appear
			BonusStageSP($sLogPath)
		Else
			BonusStageNSP($sLogPath)
		EndIf
	EndIf

EndFunc   ;==>BonusStage

Func BonusStageDoNoting($sLogPath)
	_FileWriteLog($sLogPath, "Do noting BonusStage Active")
	Do
		Sleep(200)
	Until BonusStageFail($sLogPath)
EndFunc   ;==>BonusStageDoNoting

Func BonusStageFail($sLogPath)
	PixelSearch(775, 600, 775, 600, 0xB40000, 10)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		_FileWriteLog($sLogPath, "BonusStage Failed")
		Return True
	EndIf
	Return False
EndFunc   ;==>BonusStageFail

Func cSend($iPressDelay, $iPostPressDelay = 0, $sKey = "Up")
	Send("{" & $sKey & " Down}")
	Sleep($iPressDelay)
	Send("{" & $sKey & " Up}")
	Sleep($iPostPressDelay)
	Return
EndFunc   ;==>cSend

Func BonusStageSP($sLogPath)
	_FileWriteLog($sLogPath, "BonusStageSB")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	; Section 1 Collection
	cSend(40, 2500)
	For $iX = 1 To 19
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStageBS Section 1 Complete")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	; Section 2 Collection
	cSend(350, 1000)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStageBS Section 2 Complete")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	;Section 3 Collection
	cSend(900, 200)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStageBS Section 3 Complete")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStageBS Section 4 Complete")
EndFunc   ;==>BonusStageSP

Func BonusStageNSP($sLogPath)
	_FileWriteLog($sLogPath, "BonusStage")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	; Section 1 Collection
	cSend(40, 5000)
	For $iX = 1 To 17
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStage Section 1 Complete")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	; Section 2 Collection
	cSend(350, 1000)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStage Section 2 Complete")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	;Section 3 Collection
	cSend(900, 200)
	For $iX = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStage Section 3 Complete")
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
	If BonusStageFail($sLogPath) Then
		Return
	EndIf
	_FileWriteLog($sLogPath, "BonusStage Section 4 Complete")
EndFunc   ;==>BonusStageNSP
