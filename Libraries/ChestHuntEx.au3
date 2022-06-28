#include-once
#include <File.au3>
#include <Array.au3>
#include "Util.au3"

#Region ChestHuntEx.au3 - #FUNCTION#
; #FUNCTION# ====================================================================================================================
; Name ..........: _Chesthunt
; Description ...: Plays the Chesthunt according to parameters
; Syntax ........: _Chesthunt($LogPath, $NoLockpickingState)
; Parameters ....: $LogPath             - Path to the log file
;                  $NoLockpickingState  - State of the No Lockpicking 100 RadioButton
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 28-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _Chesthunt($LogPath, $NoLockpickingState)
    ;Write log
	_FileWriteLog($LogPath, "Chesthunt")

    ;Wait variable
    Local $extraSleep = 0
	If $NoLockpickingState Then
		$extraSleep = $extraSleep + 1000
    EndIf
    
    Sleep(2000 + $extraSleep)

    ;Locate Saver
    Local $saver = __LocateSaver($LogPath)

	; Actual chest hunt
	Local $pixelX = 185
	Local $pixelY = 325
	$count = 0
	For $y = 1 To 3
		For $x = 1 To 10
			; After opening 2 chest open saver
			If $count == 2 And $saver[0] > 0 Then
				MouseClick("left", $saver[0] + 33, $saver[1] - 23, 1, 0)
			    Sleep(550 + $extraSleep)
			EndIf

			; Skip saver no matter what
			If $pixelY == $saver[1] And $pixelX == $saver[0] Then
				; Go next line If saver is last chest
				If $x == 10 Then
					ExitLoop (1)
				Else
					$pixelX += 95
					ContinueLoop
				EndIf
			EndIf

			; Open chest
			MouseClick("left", $pixelX + 33, $pixelY - 23, 1, 0)
			Sleep(550 + $extraSleep)

			; Check if chest hunt ended
			PixelSearch(400, 695, 400, 695, 0xB40000)
			If Not @error Then
				ExitLoop (2)
			EndIf

			; if mimic wait some more
			PixelSearch(434, 211, 434, 211, 0xFF0000)
			If Not @error Then
				Sleep(1500 + $extraSleep)
			EndIf
			$pixelX += 95
			$count += 1
		Next
		$pixelY += 95
		$pixelX = 185
	Next

	; Look for close button until found
    _FindPixelUntilFound(400, 694, 400, 694, 0xB40000)
	MouseClick("left", 643, 693, 1, 0)
EndFunc   ;==>_Chesthunt
#EndRegion ChestHuntEx.au3 - #FUNCTION#

#Region ChestHuntEx.au3 - #INTERNAL FUNCTION#
; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __LocateSaver
; Description ...: Locates the Saver in the ChestHunt minigame
; Syntax ........: __LocateSaver()
; Parameters ....: $LogPath             - Path to the log file
; Return values .: Success - Array[2] of the location
;                  Failure - Null
; Modified ......: 28-06-2022
; ================================================================================================================================
Func __LocateSaver($LogPath)
	Local $pixelX = 185
	Local $pixelY = 325

    For $y = 1 To 3
		For $x = 1 To 10
			PixelSearch($pixelX, $pixelY - 1, $pixelX + 5, $pixelY, 0xFFEB04)
			If Not @error Then
                Local $array = [$pixelX, $pixelY]
				Return $array
			EndIf
			$pixelX += 95
		Next
		$pixelY += 95
		$pixelX = 185
	Next

    _FileWriteLog($LogPath, "Saver could not be found.")
    Local $array = [0, 0]
    Return $array
EndFunc   ;==>__LocateSaver
#Region ChestHuntEx.au3 - #INTERNAL FUNCTION#