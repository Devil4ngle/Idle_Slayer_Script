#include-once
#include "GUI.au3"

#Region CraftingEx.au3 - #FUNCTION#
; #FUNCTION# ====================================================================================================================
; Name ..........: _RageWhenHorde
; Description ...: Activates temporary crafting when mega horde.
; Syntax ........: _RageWhenHorde($LogPath)
; Parameters ....: $LogPath             - Path to the log file
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 28-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _RageWhenHorde($LogPath)
	If __CheckforSoulBonus($LogPath) Then
		If $CraftRagePillState Then
			__BuyTempItem("0x871646", $LogPath)
		EndIf
		If $CraftSoulBonusState Then
			__BuyTempItem("0x7D55D8", $LogPath)
		EndIf
	EndIf
	_FileWriteLog($LogPath, "MegaHorde Rage")
	If $Dimensional Then
		__BuyTempItem("0xF37C55", $LogPath)
		$Dimensional = False
		_Resource_SetToCtrlID($CheckBoxDimension, 'UNCHECKED')
	EndIf
	If $BiDimensional Then
		__BuyTempItem("0x526629", $LogPath)
		$BiDimensional = False
		_Resource_SetToCtrlID($CheckBoxBiDimension, 'UNCHECKED')
	EndIf
	ControlFocus("Idle Slayer", "", "")
	ControlSend("Idle Slayer", "", "", "{e}")
EndFunc   ;==>_RageWhenHorde
#EndRegion CraftingEx.au3 - #FUNCTION#

#Region CraftingEx.au3 - #INTERNAL-FUNCTION#
; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CheckforSoulBonus
; Description ...: Checks if a soul bonus is active
; Syntax ........: __CheckforSoulBonus($LogPath)
; Parameters ....: $LogPath             - Path to the log file
; Modified ......: 28-06-2022
; ===============================================================================================================================
Func __CheckforSoulBonus($LogPath)
	PixelSearch(625, 143, 629, 214, 0xA86D0A)
	If Not @error Then
		_FileWriteLog($LogPath, "MegaHorde Rage with SoulBonus")
		Return True
	EndIf
EndFunc   ;==>__CheckforSoulBonus

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __BuyTempItem
; Description ...: Buys temporary crafting with specific color
; Syntax ........: __BuyTempItem($hexColor, $LogPath)
; Parameters ....: $hexColor            - Hex color of item to craft
;                  $LogPath             - Path to the log file
; Modified ......: 28-06-2022
; ===============================================================================================================================
Func __BuyTempItem($hexColor, $LogPath)
	_FileWriteLog($LogPath, "CraftingTemp Item Active")
	Local $success
	;open menu
	MouseClick("left", 160, 100, 1, 0)
	Sleep(150)
	;temp item
	MouseClick("left", 260, 690, 1, 0)
	Sleep(150)
	;top of scrollbar
	MouseClick("left", 482, 150, 5, 0)
	Sleep(450)
	While 1
		; on this x search color
		$success = PixelSearch(65, 180, 65, 630, $hexColor)
		If Not @error Then
			MouseClick("left", 385, $success[1], 1, 0)
			Sleep(50)
			ExitLoop
		EndIf
		MouseWheel($MOUSE_WHEEL_DOWN, 1)
		Sleep(50)
		PixelSearch(484, 647, 484, 647, 0xD6D6D6)
		If @error Then
			ExitLoop
		EndIf
	WEnd
	MouseClick("left", 440, 690, 1, 0)
	Sleep(100)
EndFunc   ;==>__BuyTempItem
#EndRegion CraftingEx.au3 - #INTERNAL-FUNCTION#