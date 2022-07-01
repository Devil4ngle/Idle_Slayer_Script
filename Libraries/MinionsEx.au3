#include-once
#include <File.au3>

#Region MinionsEx.au3 - #FUNCTION#
; #FUNCTION# ====================================================================================================================
; Name ..........: _CollectMinion
; Description ...: Collects all minions
; Syntax ........: _CollectMinion($LogPath)
; Parameters ....: $LogPath             - Path to the log file
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 28-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _CollectMinion($LogPath)
	;Click ascension button
	MouseClick("left", 95, 90, 1, 0)
	Sleep(400)

	;Click ascension tab
	MouseClick("left", 93, 680, 1, 0)
	Sleep(200)

	;Click ascension tree tab
	MouseClick("left", 193, 680, 1, 0)
	Sleep(200)

	;????
	MouseClick("left", 691, 680, 1, 0)
	Sleep(200)

	;Click minion tab
	MouseClick("left", 332, 680, 1, 0)
	Sleep(200)

	;Check if Daily Bonus is available
	PixelSearch(370, 410, 910, 470, 0x11AA23, 9)
	If Not @error Then
		;Click Claim All
		MouseClick("left", 320, 280, 5, 0)
		Sleep(200)
		;Click Send All
		MouseClick("left", 320, 280, 5, 0)
		Sleep(200)
		;Claim Daily Bonus
		MouseClick("left", 320, 180, 5, 0)
		Sleep(200)
		_FileWriteLog($LogPath, "Minions Collect with Daily Bonus")
	Else
		;Click Claim All
		MouseClick("left", 318, 182, 5, 0)
		Sleep(200)
		;Click Send All
		MouseClick("left", 318, 182, 5, 0)
		Sleep(200)
		_FileWriteLog($LogPath, "Minions Collect")
	EndIf

	;Click Exit
	MouseClick("left", 570, 694, 1, 0)
EndFunc   ;==>CollectMinion
#EndRegion MinionsEx.au3 - #FUNCTION#
