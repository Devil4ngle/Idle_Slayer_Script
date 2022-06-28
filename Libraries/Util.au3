#include-once
; #FUNCTION# =============================================================================================================
; Name ..........: _cSend
; Description ...: Control Sends keyboard inputs
; Syntax ........: _cSend($pressDelay, $postPressDelay = 0, $key = "Up")
; Parameters ....: $pressDelay           - Delay before input is pressed
;                  $postPressDelay       - Delay after input is pressed, default = 0
;                  $key                  - Key being pressed, default = "Up"
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 28-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ================================================================================================================================
Func _cSend($pressDelay, $postPressDelay = 0, $key = "Up")
	Send("{" & $key & " Down}")
	Sleep($pressDelay)
	Send("{" & $key & " Up}")
	Sleep($postPressDelay)
	Return
EndFunc   ;==>_cSend

; #FUNCTION# =============================================================================================================
; Name ..........: _FindPixelUntilFound
; Description ...: Cycles until specific pixel is found
; Syntax ........: _FindPixelUntilFound($x1, $y1, $x2, $y2, $hex, $timer = 15000)
; Parameters ....: $x1                   - Left most value
;                  $y1                   - Top most value
;                  $x2                   - Right most value
;                  $y2                   - Bottom most value
;                  $hex                  - Hex color
;                  $timer                - Maximum duration of function, default = 15000
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 28-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ================================================================================================================================
Func _FindPixelUntilFound($x1, $y1, $x2, $y2, $hex, $timer = 15000)
	Local $time = TimerInit()
	Do
		PixelSearch($x1, $y1, $x2, $y2, $hex)
	Until Not @error Or $timer < TimerDiff($time)
EndFunc   ;==>_FindPixelUntilFound

; #FUNCTION# =============================================================================================================
; Name ..........: _CloseAll
; Description ...: Closes all open windows in Idle Slayer
; Syntax ........: _CloseAll()
; Parameters ....: 
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 28-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ================================================================================================================================
Func _CloseAll()
	Sleep(2000)
	PixelSearch(775, 600, 775, 600, 0xAD0000)
	If Not @error Then
		MouseClick("left", 775, 600, 1, 0)
	EndIf
	PixelSearch(775, 600, 775, 600, 0xB40000)
	If Not @error Then
		MouseClick("left", 775, 600, 1, 0)
	EndIf
EndFunc   ;==>_CloseAll
