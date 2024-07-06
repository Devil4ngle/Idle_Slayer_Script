#include-once
#include <File.au3>
#Region LogEx.au3 - #FUNCTION#

; #FUNCTION# ====================================================================================================================
; Description ...: Loads the Log from previous session
; Parameters ....: $iLogPath             - Path to the log file
;                  $iLog                 - Edit control
; Return values .:
; ===============================================================================================================================
Func LoadLog($iLog)
	Sleep(100)
	Local $iSection1 = 0, $iSection2 = 0, $iSection3 = 0, $iSection4 = 0, $iChesthunt = 0, $iFailed = 0, _
			$iMinionsClaimed = 0, $iQuestClaimed = 0, $iSection1BS = 0, $iSection2BS = 0, $iSection3BS = 0, $iSection4BS = 0, _
			$iSilverboxColl = 0, $iBonusStage = 0, $iBonusStageSP = 0, $iMegaHordeRage = 0, $iMegaHordeRageSoul = 0, $iBossFightVictorWon = 0, _
			$iBossFightVictor = 0, $iBossFightKnightWon = 0, $iBossFightKnight = 0, $iAscendingHeights = 0, $iAscendingHeightsFailed = 0
	Local $hFile = FileOpen("IdleRunnerLogs\Logs.txt", $FO_READ)
	If $hFile <> -1 Then
		While 1
			Local $sLine = FileReadLine($hFile)
			If @error = -1 Then ExitLoop
			$sLine = StringTrimLeft($sLine, 22)
			Switch $sLine
				Case "Start of Ascending Heights"
					$iAscendingHeights += 1
				Case "Ascending Height Failed"
					$iAscendingHeightsFailed += 1
				Case "BonusStageBS Section 1 Complete"
					$iSection1BS += 1
				Case "BonusStageBS Section 2 Complete"
					$iSection2BS += 1
				Case "BonusStageBS Section 3 Complete"
					$iSection3BS += 1
				Case "BonusStageBS Section 4 Complete"
					$iSection4BS += 1
				Case "BonusStage Section 1 Complete"
					$iSection1 += 1
				Case "BonusStage Section 2 Complete"
					$iSection2 += 1
				Case "BonusStage Section 3 Complete"
					$iSection3 += 1
				Case "BonusStage Section 4 Complete"
					$iSection4 += 1
				Case "Silver Box Collected"
					$iSilverboxColl += 1
				Case "Minions Collect"
					$iMinionsClaimed += 1
				Case "Minions Collect with Daily Bonus"
					$iMinionsClaimed += 1
				Case "Chesthunt"
					$iChesthunt += 1
				Case "BonusStage Failed"
					$iFailed += 1
				Case "BonusStage"
					$iBonusStage += 1
				Case "BonusStageSB"
					$iBonusStageSP += 1
				Case "Claiming quest"
					$iQuestClaimed += 1
				Case "MegaHorde Rage"
					$iMegaHordeRage += 1
				Case "MegaHorde Rage with SoulBonus"
					$iMegaHordeRageSoul += 1
				Case "Start of BossFight Victor"
					$iBossFightVictor += 1
				Case "Victor Won"
					$iBossFightVictorWon += 1
				Case "Start of BossFight Knight"
					$iBossFightKnight += 1
				Case "Knight Won"
					$iBossFightKnightWon += 1
			EndSwitch
		WEnd
		FileClose($hFile)
	EndIf
	GUICtrlSetData($iLog, "")
	CustomConsole($iLog, "Rage with only MegaHorde: " & $iMegaHordeRage - $iMegaHordeRageSoul)
	CustomConsole($iLog, "Rage with MegaHorde and SoulBonus: " & $iMegaHordeRageSoul)
	CustomConsole($iLog, "Claimed Quest: " & $iQuestClaimed)
	CustomConsole($iLog, "Claimed Minions: " & $iMinionsClaimed)
	CustomConsole($iLog, "ChestHunts: " & $iChesthunt)
	CustomConsole($iLog, "Collected SilverBoxes: " & $iSilverboxColl)
	CustomConsole($iLog, "Failed Bonus Stages: " & $iFailed)
	CustomConsole($iLog, "BonusStage (No Spirit Boost): " & $iBonusStage)
	CustomConsole($iLog, "BonusStage (Spirit Boost): " & $iBonusStageSP)
	CustomConsole($iLog, "Section 1 Complete (No Spirit Boost): " & $iSection1)
	CustomConsole($iLog, "Section 2 Complete (No Spirit Boost): " & $iSection2)
	CustomConsole($iLog, "Section 3 Complete (No Spirit Boost): " & $iSection3)
	CustomConsole($iLog, "Section 4 Complete (No Spirit Boost): " & $iSection4)
	CustomConsole($iLog, "Section 1 Complete (Spirit Boost): " & $iSection1BS)
	CustomConsole($iLog, "Section 2 Complete (Spirit Boost): " & $iSection2BS)
	CustomConsole($iLog, "Section 3 Complete (Spirit Boost): " & $iSection3BS)
	CustomConsole($iLog, "Section 3 Complete (Spirit Boost): " & $iSection3BS)
	CustomConsole($iLog, "Section 4 Complete (Spirit Boost): " & $iSection4BS)
	CustomConsole($iLog, "Ascending Heights Won : " & $iAscendingHeights - $iAscendingHeightsFailed)
	CustomConsole($iLog, "Ascending Heights Failed : " & $iAscendingHeightsFailed)
	CustomConsole($iLog, "Victor Fights Done: " & $iBossFightVictor)
	CustomConsole($iLog, "Victor Fights Won: " & $iBossFightVictorWon)
	CustomConsole($iLog, "Victor Fights Lost: " & $iBossFightVictor - $iBossFightVictorWon)
	CustomConsole($iLog, "Knight Fights Done: " & $iBossFightKnight)
	CustomConsole($iLog, "Knight Fights Won: " & $iBossFightKnightWon)
	CustomConsole($iLog, "Knight Fights Lost: " & $iBossFightKnight - $iBossFightKnightWon, True)
EndFunc   ;==>LoadLog

; #FUNCTION# ====================================================================================================================
; Description ...: Loads the Log with instructions
; Parameters ....: $iLogData                 - Edit control
; Return values .:
; ===============================================================================================================================
Func LoadDataLog($iLogData)
	Sleep(100)
	GUICtrlSetData($iLogData, "")

	If WinExists("Idle Slayer") == 1 Then
		Local $aArray = WinGetClientSize('Idle Slayer')
		If $aArray[0] == "1280" And $aArray[1] == "720" Then
			CustomConsole($iLogData, "Size of game is correct :" & $aArray[0] & "x" & $aArray[1] & ".")
		Else
			CustomConsole($iLogData, "Size of game is incorrect correct size is: 1280x720.")
			CustomConsole($iLogData, "Your size is: " & $aArray[0] & "x" & $aArray[1] & ".")
		EndIf
	Else
		CustomConsole($iLogData, "Idle Slayer not Active")
	EndIf
	CustomConsole($iLogData, "Only Bonus Stage 2 works otherwise skip it.")
	CustomConsole($iLogData, "Disable Hard Mode")
	CustomConsole($iLogData, "Do not buy Vertical Magnet.")
	CustomConsole($iLogData, "Disable dialogue for Portal in setting.")
	CustomConsole($iLogData, "Enable rounded bulk in setting.")
	CustomConsole($iLogData, "Enable hide locked quest rewards in setting.")
	CustomConsole($iLogData, "The game must be in English.")
	CustomConsole($iLogData, "Game must be in focus.")
	CustomConsole($iLogData, "Ascension Upgrade Leadership Master is mandatory.")
	CustomConsole($iLogData, "Ascension Upgrade Safety First is mandatory.")
	CustomConsole($iLogData, "Use Roy/Anna if for Victor and Ascending Heights.")
	CustomConsole($iLogData, "Run the script as Administrator in Windows 11.")
	CustomConsole($iLogData, "Disable custom cursor in setting.")
	CustomConsole($iLogData, "Tip: Hover over the Text-Boxes_")
	CustomConsole($iLogData, "on the Idle Runner to read what they do!", True)
EndFunc   ;==>LoadDataLog

Func CustomConsole($iComponent, $sText, $bAppend = False)
	If $bAppend Then
		$sText = $sText & "	"
	Else
		$sText = $sText & @CRLF
	EndIf
	GUICtrlSetData($iComponent, $sText, 1)
EndFunc   ;==>CustomConsole
