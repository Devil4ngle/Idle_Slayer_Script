#Include-once
#include <File.au3>

#Region LogEx.au3 - #FUNCTION#
; #FUNCTION# ====================================================================================================================
; Name ..........: _LoadLog
; Description ...: Loads the Log from previous session
; Syntax ........: _LoadLog($LogPath, $Log)
; Parameters ....: $LogPath             - Path to the log file
;                  $Log                 - Edit control
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 30-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _LoadLog($LogPath, $Log)
	Sleep(100)
	Local $section1 = 0, $section2 = 0, $section3 = 0, $section4 = 0, $chesthunt = 0, $failed = 0, _
			$mClaimed = 0, $qClaimed = 0, $section1BS = 0, $section2BS = 0, $section3BS = 0, $section4BS = 0, _
			$silverboxColl = 0, $BS = 0, $BSSP = 0, $megaHordeRage = 0, $megaHordeRageSoul = 0 ;
	$file = FileOpen($LogPath, $FO_READ)
	If $file <> -1 Then
		While 1
			$line = FileReadLine($file)
			If @error = -1 Then ExitLoop
			$line = StringTrimLeft($line, 22)
			Switch $line
				Case "BonusStageBS Section 1 Complete"
					$section1BS += 1
				Case "BonusStageBS Section 2 Complete"
					$section2BS += 1
				Case "BonusStageBS Section 3 Complete"
					$section3BS += 1
				Case "BonusStageBS Section 4 Complete"
					$section4BS += 1
				Case "BonusStage Section 1 Complete"
					$section1 += 1
				Case "BonusStage Section 2 Complete"
					$section2 += 1
				Case "BonusStage Section 3 Complete"
					$section3 += 1
				Case "BonusStage Section 4 Complete"
					$section4 += 1
				Case "Silver Box Collected"
					$silverboxColl += 1
				Case "Minions Collect"
					$mClaimed += 1
				Case "Minions Collect with Daily Bonus"
					$mClaimed += 1
				Case "Chesthunt"
					$chesthunt += 1
				Case "BonusStage Failed"
					$failed += 1
				Case "BonusStage"
					$BS += 1
				Case "BonusStageSB"
					$BSSP += 1
				Case "Claiming quest"
					$qClaimed += 1
				Case "MegaHorde Rage"
					$megaHordeRage += 1
				Case "MegaHorde Rage with SoulBonus"
					$megaHordeRageSoul += 1
			EndSwitch
		WEnd
		FileClose($file)
	EndIf
	GUICtrlSetData($Log, "")
	__CustomConsole($Log, "Rage with only MegaHorde: " & $megaHordeRage - $megaHordeRageSoul)
	__CustomConsole($Log, "Rage with MegaHorde and SoulBonus: " & $megaHordeRageSoul)
	__CustomConsole($Log, "Claimed Quest: " & $qClaimed)
	__CustomConsole($Log, "Claimed Minions: " & $mClaimed)
	__CustomConsole($Log, "ChestHunts: " & $chesthunt)
	__CustomConsole($Log, "Failed Bonus Stages: " & $failed)
	__CustomConsole($Log, "BonusStage (No Spirit Boost): " & $BS)
	__CustomConsole($Log, "BonusStage (Spirit Boost): " & $BSSP)
	__CustomConsole($Log, "Section 1 Complete (No Spirit Boost): " & $section1)
	__CustomConsole($Log, "Section 2 Complete (No Spirit Boost): " & $section2)
	__CustomConsole($Log, "Section 3 Complete (No Spirit Boost): " & $section3)
	__CustomConsole($Log, "Section 4 Complete (No Spirit Boost): " & $section4)
	__CustomConsole($Log, "Section 1 Complete (Spirit Boost): " & $section1BS)
	__CustomConsole($Log, "Section 2 Complete (Spirit Boost): " & $section2BS)
	__CustomConsole($Log, "Section 3 Complete (Spirit Boost): " & $section3BS)
	__CustomConsole($Log, "Section 4 Complete (Spirit Boost): " & $section4BS, True)
EndFunc   ;==>LoadLog

; #FUNCTION# ====================================================================================================================
; Name ..........: _LoadDataLog
; Description ...: Loads the Log with instructions
; Syntax ........: _LoadDataLog($LogData)
; Parameters ....: $LogData                 - Edit control
; Return values .: 
; Author ........: Devil4angle
; Modified ......: 30-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _LoadDataLog($LogData)
	Sleep(100)
	GUICtrlSetData($LogData, "")

	If WinExists("Idle Slayer") == 1 Then
		$array = WinGetClientSize('Idle Slayer')
		ConsoleWrite($array[0])
		ConsoleWrite($array[1])

		If $array[0] == "1280" And $array[1] == "720" Then
			__CustomConsole($LogData, "Size of game is correct :" & $array[0] & "x" & $array[1] & ".")
		Else
			__CustomConsole($LogData, "Size of game is incorrect correct size is: 1280x720.")
			__CustomConsole($LogData, "Your size is: " & $array[0] & "x" & $array[1] & ".")
		EndIf
	Else
		__CustomConsole($LogData, "Idle Slayer not Active")
	EndIf
	__CustomConsole($LogData, "Only Bonus Stage 2 works otherwise skip it.")
	__CustomConsole($LogData, "Do not buy Vertical Magnet.")
	__CustomConsole($LogData, "Disable dialogue for Portal in setting.")
	__CustomConsole($LogData, "Disable parallex effect in setting.")
	__CustomConsole($LogData, "Enable rounded bulk in setting.")
	__CustomConsole($LogData, "Enable hide locked quest rewards in setting.")
	__CustomConsole($LogData, "The game must be in English.")
	__CustomConsole($LogData, "Ascension Upgrade Leadership Master is mandatory.")
	__CustomConsole($LogData, "Ascension Upgrade Safety First is mandatory.")
	__CustomConsole($LogData, "Tip: Hover over the Text-Boxes_")
	__CustomConsole($LogData, "on the Idle Runner to read what they do!", True)
EndFunc   ;==>LoadDataLog
#EndRegion LogEx.au3 - #FUNCTION#

#Region LogEx.au3 - #INTERNAL-FUNCTION#
; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CustomConsole
; Description ...: Writes to custom console
; Syntax ........: __CustomConsole($Component, $text, $append = False)
; Parameters ....: $Component             - Edit control
;                  $text                  - Text to write in console
;                  $append                - If text to append to existing line, default = False
; Modified ......: 30-06-2022
; ===============================================================================================================================
Func __CustomConsole($Component, $text, $append = False)
	If $append Then
		$text = $text & "	"
	Else
		$text = $text & @CRLF
	EndIf
	GUICtrlSetData($Component, $text, 1)
EndFunc   ;==>__CustomConsole
#EndRegion LogEx.au3 - #INTERNAL-FUNCTION#