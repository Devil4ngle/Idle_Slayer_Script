#include <File.au3>
#include "Util.au3"

#Region BonusStageEx.au3 - #FUNCTION#
; #FUNCTION# ====================================================================================================================
; Name ..........: _BonusStage
; Description ...: Plays the BonusStage according to parameters
; Syntax ........: _BonusStage($LogPath, $SkipBonusStageState)
; Parameters ....: $LogPath             - Path to the log file
;                  $SkipBonusStageState - State of the Skip Bonus Stage RadioButton
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 28-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _BonusStage($LogPath, $SkipBonusStageState)
    ;Write log
	_FileWriteLog($LogPath, "Start of BonusStage")

    ;Find Slider
	Do
		__BonusStageSlider()
		Sleep(500)
		PixelSearch(660, 254, 660, 254, 0xFFE737)
	Until @error
	Sleep(3900)

    ;Check if skip BonusStage
    If $SkipBonusStageState Then
		__BonusStageDoNothing($LogPath)
        Return
    EndIf

    ;Check if Spirit Boost
	PixelSearch(454, 91, 454, 91, 0xE1E0E2)
    If Not @error Then ;if Spirit Boost do noting untill close appear
        __BonusStageSP($LogPath)
        Return
    EndIf
    
    __BonusStageNSP($LogPath)
EndFunc   ;==>_BonusStage
#EndRegion BonusStageEx.au3 - #FUNCTION#

#Region BonusStageEx.au3 - #INTERNAL FUNCTION#
; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __BonusStageDoNothing
; Description ...: Sleeps until BonusStage ended
; Syntax ........: __BonusStageDoNothing($LogPath)
; Parameters ....: $LogPath             - Path to the log file
; Modified ......: 28-06-2022
; ===============================================================================================================================
Func __BonusStageDoNothing($LogPath)
    ;Write log
	_FileWriteLog($LogPath, "Do noting BonusStage Active")

    ;Wait till BonusStage Failed
	Do
		Sleep(200)
	Until __BonusStageFail($LogPath)
EndFunc   ;==>__BonusStageDoNoting

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __BonusStageSlider
; Description ...: Drags the slider to the correct position
; Syntax ........: __BonusStageSlider()
; Parameters ....: 
; Modified ......: 28-06-2022
; ================================================================================================================================
Func __BonusStageSlider()
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
EndFunc   ;==>BonusStageSlider

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __BonusStageFail
; Description ...: Checks if the BonusStage failed
; Syntax ........: __BonusStageFail($LogPath)
; Parameters ....: $LogPath             - Path to the log file
; Modified ......: 28-06-2022
; ================================================================================================================================
Func __BonusStageFail($LogPath)
	PixelSearch(775, 600, 775, 600, 0xB40000, 10)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		_FileWriteLog($LogPath, "BonusStage Failed")
		Return True
	EndIf
	Return False
EndFunc   ;==>BonusStageFail


; Syntax ........: __BonusStageNSP($LogPath)
; Parameters ....: $LogPath             - Path to the log file
; Return values .: Success - True
;                  Failure - False
; Modified ......: 28-06-2022
; ================================================================================================================================
Func __BonusStageNSP($LogPath)
_FileWriteLog($LogPath, "BonusStage")
	; Section 1 sync
	_FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	Sleep(200)

	;Section 1 start
	_cSend(94, 1640) ;1
	_cSend(32, 1218) ;2
	_cSend(94, 600) ;3
	_cSend(109, 1828) ;4
	_cSend(63, 640) ;5
	_cSend(47, 688) ;6
	_cSend(78, 1906) ;7
	_cSend(141, 1625) ;8
	_cSend(47, 3187) ;9
	_cSend(47, 734) ;10
	_cSend(47, 750) ;11
	_cSend(78, 1203) ;12
	_cSend(110, 5000) ;13
	If __BonusStageFail($LogPath) Then
		Return
	EndIf

	; Section 1 Collection
	_cSend(40, 5000)
	For $x = 1 To 17
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStage Section 1 Complete")

	; Section 2 sync
	_FindPixelUntilFound(780, 536, 780, 536, 0xBB26DF)

	; Section 2 start
	_cSend(156, 719) ;1
	_cSend(47, 687) ;2
	_cSend(360, 1390) ;3
	_cSend(485, 344) ;4
	_cSend(406, 859) ;5
	_cSend(78, 600) ;6
	_cSend(94, 900) ;7
	_cSend(109, 954) ;8
	_cSend(31, 672) ;9
	_cSend(515, 1344) ;10
	_cSend(484, 297) ;11
	_cSend(406, 859) ;12
	_cSend(78, 600) ;13
	_cSend(94, 900) ;14
	_cSend(109, 954) ;15
	_cSend(31, 672) ;16
	_cSend(515, 1344) ;17
	_cSend(469, 219) ;18
	_cSend(297, 1000) ;19
	_cSend(156, 500) ;20
	_cSend(110, 3000) ;21
	_cSend(360, 2984) ;22
	_cSend(531, 2313) ;23
	If __BonusStageFail($LogPath) Then
		Return
	EndIf

	; Section 2 Collection
	_cSend(350, 1000)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStage Section 2 Complete")

	;Stage 3 sync
	_FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)

	; Section 3 Start
	_cSend(109, 1203) ;1
	_cSend(31, 641) ;2
	_cSend(47, 1578) ;3
	_cSend(47, 2437) ;4
	;repeat
	_cSend(109, 1203) ;5
	_cSend(31, 641) ;6
	_cSend(47, 1578) ;7
	_cSend(47, 2437) ;8
	;repeat
	_cSend(109, 1203) ;9
	_cSend(31, 641) ;10
	_cSend(47, 1578) ;11
	_cSend(47, 2437) ;12
	;repeat
	_cSend(109, 1203) ;13
	_cSend(31, 641) ;14
	_cSend(47, 5125) ;15
	If __BonusStageFail($LogPath) Then
		Return
	EndIf

	;Section 3 Collection
	_cSend(900, 200)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStage Section 3 Complete")

	;Section 4 sync
	_FindPixelUntilFound(250, 472, 100, 250, 0x0D2030)
	Sleep(200)

	;Section 4 Start
	_cSend(32, 2500) ;1
	_cSend(31, 809) ;2
	_cSend(41, 1375) ;3
	_cSend(41, 1374) ;4
	_cSend(641, 690) ;5
	_cSend(41, 1373) ;6
	_cSend(41, 2500) ;7
	_cSend(31, 809) ;8
	_cSend(41, 1375) ;9
	_cSend(41, 1374) ;10
	_cSend(641, 690) ;11
	_cSend(41, 1373) ;12
	_cSend(41, 1372) ;13
	_cSend(641, 690) ;14
	_cSend(41, 1371) ;15
	; extra jump just in case
	_cSend(41) ;16

	;Section 4 Collection
	For $x = 1 To 23
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStage Section 4 Complete")
EndFunc   ;==>BonusStageNSP

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __BonusStageSlider
; Description ...: Drags the slider to the correct position
; Syntax ........: __BonusStageSlider()
; Parameters ....: 
; Modified ......: 28-06-2022
; ================================================================================================================================
Func __BonusStageSP($LogPath)
	_FileWriteLog($LogPath, "BonusStageSB")
	; Section 1 sync
	_FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	Sleep(200)

	;Section 1 start
	_cSend(94, 1640) ;1
	_cSend(47, 2072) ;2
	_cSend(187, 688) ;3
	_cSend(31, 672) ;4
	_cSend(31, 1700) ;5
	_cSend(94, 600) ;6
	_cSend(94, 1640) ;1
	_cSend(47, 2072) ;2
	_cSend(187, 688) ;3
	_cSend(31, 672) ;4
	_cSend(31, 1700) ;5
	_cSend(94, 600) ;6
	_cSend(94, 5000) ;1
	If __BonusStageFail($LogPath) Then
		Return
	EndIf

	; Section 1 Collection
	_cSend(40, 2500)
	For $x = 1 To 19
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStageBS Section 1 Complete")

	; Section 2 sync
	_FindPixelUntilFound(780, 536, 780, 536, 0xBB26DF)

	; Section 2 start
	_cSend(156, 719) ;1
	_cSend(47, 687) ;2
	_cSend(360, 1390) ;3
	_cSend(485, 344) ;4
	_cSend(406, 859) ;5
	_cSend(78, 600) ;6
	_cSend(94, 900) ;7
	_cSend(109, 954) ;8
	_cSend(31, 672) ;9
	_cSend(515, 1344) ;10
	_cSend(484, 297) ;11
	_cSend(406, 859) ;12
	_cSend(78, 600) ;13
	_cSend(94, 900) ;14
	_cSend(109, 954) ;15
	_cSend(31, 672) ;16
	_cSend(515, 1344) ;17
	_cSend(469, 219) ;18
	_cSend(297, 1000) ;19
	_cSend(156, 500) ;20
	_cSend(110, 3000) ;21
	_cSend(360, 2984) ;22
	_cSend(531, 2313) ;23
	If __BonusStageFail($LogPath) Then
		Return
	EndIf

	; Section 2 Collection
	_cSend(350, 1000)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStageBS Section 2 Complete")

	;Stage 3 sync
	_FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)

	; Section 3 Start
	_cSend(109, 1203) ;1
	_cSend(31, 641) ;2
	_cSend(47, 1200) ;3
	_cSend(1, 3100) ;4
	;repeat
	_cSend(109, 1203) ;5
	_cSend(31, 641) ;6
	_cSend(47, 1200) ;7
	_cSend(1, 3100) ;8
	;repeat
	_cSend(109, 1203) ;9
	_cSend(31, 641) ;10
	_cSend(47, 1200) ;11
	_cSend(1, 3100) ;12
	;repeat
	_cSend(109, 1203) ;13
	_cSend(31, 641) ;14
	_cSend(47, 5125) ;15
	If __BonusStageFail($LogPath) Then
		Return
	EndIf

	;Section 3 Collection
	_cSend(900, 200)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStageBS Section 3 Complete")

	;Section 4 sync
	_FindPixelUntilFound(250, 472, 100, 250, 0x0D2030)
	Sleep(200)
	ConsoleWrite("start")

	;Section 4 Start
	_cSend(32, 2800) ;1
	_cSend(31, 809) ;2
	_cSend(41, 1200) ;3
	_cSend(100, 900) ;4
	_cSend(641, 500) ;5

	_cSend(31, 850) ;6
	_cSend(41, 770) ;7
	_cSend(641, 400) ;8

	_cSend(31, 850) ;9
	_cSend(41, 870) ;10
	_cSend(641, 300) ;11

	_cSend(31, 850) ;12
	_cSend(41, 790) ;13
	_cSend(641, 400) ;14

	_cSend(31, 850) ;15
	_cSend(41, 840) ;16
	_cSend(641, 300) ;17

	_cSend(31, 850) ;18
	_cSend(41, 840) ;19
	_cSend(641, 300) ;20

	;Section 4 Collection
	For $x = 1 To 23
		Send("{Up}")
		Sleep(500)
	Next
	If __BonusStageFail($LogPath) Then
		Return
	EndIf
	_FileWriteLog($LogPath, "BonusStageBS Section 4 Complete")
EndFunc   ;==>BonusStageSP
#EndRegion BonusStageEx.au3 - #INTERNAL FUNCTION#