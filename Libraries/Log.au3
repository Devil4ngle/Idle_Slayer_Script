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
	Local $iBS2Section1 = 0, $iBS2Section2 = 0, $iBS2Section3 = 0, $iBS2Section4 = 0, $iBS2Failed = 0, _
			$iBS2Section1SB = 0, $iBS2Section2SB = 0, $iBS2Section3SB = 0, $iBS2Section4SB = 0, $iBonusStage2 = 0, $iBonusStage2SB = 0, _
			$iBS3Section1 = 0, $iBS3Section2 = 0, $iBS3Section3 = 0, $iBS3Section4 = 0, $iBS3Failed = 0, $iBS3FailedSB = 0, $iBS3Retried = 0, $iBS3RetriedSB = 0, _
			$iBS3Section1SB = 0, $iBS3Section2SB = 0, $iBS3Section3SB = 0, $iBS3Section4SB = 0, $iBonusStage3 = 0, $iBonusStage3SB = 0, _
			$iMinionsClaimed = 0, $iQuestClaimed = 0, $iSilverboxColl = 0, $iMegaHordeRage = 0, $iMegaHordeRageSoul = 0, $iChesthunt = 0, $iPerfectChestHunt = 0, _
			$iBossFightVictorWon = 0, $iBossFightVictor = 0, $iBossFightKnightWon = 0, $iBossFightKnight = 0, $iAscendingHeights = 0, $iAscendingHeightsFailed = 0
	Local $hFile = FileOpen("IdleRunnerLogs\Logs.txt", $FO_READ)
	If $hFile <> -1 Then
		While 1
			Local $sLine = FileReadLine($hFile)
			If @error = -1 Then ExitLoop
			$sLine = StringTrimLeft($sLine, 22)
			Switch $sLine
				Case "Silver Box Collected"
					$iSilverboxColl += 1
				Case "Minions Collect"
					$iMinionsClaimed += 1
				Case "Minions Collect with Daily Bonus"
					$iMinionsClaimed += 1
				Case "Chesthunt"
					$iChesthunt += 1
				Case "Perfect ChestHunt Completed"
					$iPerfectChestHunt += 1
				Case "Claiming quest"
					$iQuestClaimed += 1
				Case "MegaHorde Rage"
					$iMegaHordeRage += 1
				Case "MegaHorde Rage with SoulBonus"
					$iMegaHordeRageSoul += 1
				Case "BonusStage2SB Section 1 Complete"
					$iBS2Section1SB += 1
				Case "BonusStage2SB Section 2 Complete"
					$iBS2Section2SB += 1
				Case "BonusStage2SB Section 3 Complete"
					$iBS2Section3SB += 1
				Case "BonusStage2SB Section 4 Complete"
					$iBS2Section4SB += 1
				Case "BonusStage2 Section 1 Complete"
					$iBS2Section1 += 1
				Case "BonusStage2 Section 2 Complete"
					$iBS2Section2 += 1
				Case "BonusStage2 Section 3 Complete"
					$iBS2Section3 += 1
				Case "BonusStage2 Section 4 Complete"
					$iBS2Section4 += 1
				Case "BonusStage2 Failed"
					$iBS2Failed += 1
				Case "BonusStage2"
					$iBonusStage2 += 1
				Case "BonusStage2SB"
					$iBonusStage2SB += 1
				Case "BonusStage3SB Section 1 Complete"
					$iBS3Section1SB += 1
				Case "BonusStage3SB Section 2 Complete"
					$iBS3Section2SB += 1
				Case "BonusStage3SB Section 3 Complete"
					$iBS3Section3SB += 1
				Case "BonusStage3SB Section 4 Complete"
					$iBS3Section4SB += 1
				Case "BonusStage3 Section 1 Complete"
					$iBS3Section1 += 1
				Case "BonusStage3 Section 2 Complete"
					$iBS3Section2 += 1
				Case "BonusStage3 Section 3 Complete"
					$iBS3Section3 += 1
				Case "BonusStage3 Section 4 Complete"
					$iBS3Section4 += 1
				Case "BonusStage3 Failed"
					$iBS3Failed += 1
				Case "BonusStage3SB Failed"
					$iBS3FailedSB += 1
				Case "BonusStage3 Retry"
					$iBS3Retried += 1
				Case "BonusStage3SB Retry"
					$iBS3RetriedSB += 1
				Case "BonusStage3"
					$iBonusStage3 += 1
				Case "BonusStage3SB"
					$iBonusStage3SB += 1
				Case "Start of Ascending Heights"
					$iAscendingHeights += 1
				Case "Ascending Height Failed"
					$iAscendingHeightsFailed += 1
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

	Local $iBS2TotalAttempts = $iBonusStage2 + $iBonusStage2SB
	Local $iBS2TotalCompletes = $iBS2Section4 + $iBS2Section4SB
	Local $iBS2SuccessPerc = $iBS2TotalAttempts == 0 ? 0 : Round($iBS2TotalCompletes / $iBS2TotalAttempts * 100, 2)

	Local $iBS3TotalAttempts = $iBonusStage3 + $iBonusStage3SB
	Local $iBS3TotalCompletes = $iBS3Section4 + $iBS3Section4SB
	Local $iBS3SuccessPerc = $iBS3TotalAttempts == 0 ? 0 : Round($iBS3TotalCompletes / $iBS3TotalAttempts * 100, 2)

	Local $iBS3TotalFails = $iBS3Failed + $iBS3FailedSB
	Local $iBS3TotalRetried = $iBS3Retried + $iBS3RetriedSB

	GUICtrlSetData($iLog, "")
	CustomConsole($iLog, "Rage with only MegaHorde: " & $iMegaHordeRage - $iMegaHordeRageSoul)
	CustomConsole($iLog, "Rage with MegaHorde and SoulBonus: " & $iMegaHordeRageSoul)
	CustomConsole($iLog, "Claimed Quest: " & $iQuestClaimed)
	CustomConsole($iLog, "Claimed Minions: " & $iMinionsClaimed)
	CustomConsole($iLog, "ChestHunts: " & $iChesthunt)
	CustomConsole($iLog, "Perfect ChestHunts: " & $iPerfectChestHunt)
	CustomConsole($iLog, "Collected SilverBoxes: " & $iSilverboxColl)
	CustomConsole($iLog, "---------------------BONUS-STAGE-2----------------------")
	CustomConsole($iLog, "Total Attempts: " & $iBS2TotalAttempts)
	CustomConsole($iLog, "Total Completes: " & $iBS2TotalCompletes)
	CustomConsole($iLog, "Failed: " & $iBS2Failed)
	CustomConsole($iLog, "Success: " & $iBS2SuccessPerc & "%")
	CustomConsole($iLog, "BS2: Attempts (No Spirit Boost): " & $iBonusStage2)
	CustomConsole($iLog, "BS2: Attempts (Spirit Boost): " & $iBonusStage2SB)
	CustomConsole($iLog, "BS2: Completes (No Spirit Boost): " & $iBS2Section4)
	CustomConsole($iLog, "BS2: Completes (Spirit Boost): " & $iBS2Section4SB)
	CustomConsole($iLog, "BS2: Section 1 Complete (No Spirit Boost): " & $iBS2Section1)
	CustomConsole($iLog, "BS2: Section 2 Complete (No Spirit Boost): " & $iBS2Section2)
	CustomConsole($iLog, "BS2: Section 3 Complete (No Spirit Boost): " & $iBS2Section3)
	CustomConsole($iLog, "BS2: Section 4 Complete (No Spirit Boost): " & $iBS2Section4)
	CustomConsole($iLog, "BS2: Section 1 Complete (Spirit Boost): " & $iBS2Section1SB)
	CustomConsole($iLog, "BS2: Section 2 Complete (Spirit Boost): " & $iBS2Section2SB)
	CustomConsole($iLog, "BS2: Section 3 Complete (Spirit Boost): " & $iBS2Section3SB)
	CustomConsole($iLog, "BS2: Section 4 Complete (Spirit Boost): " & $iBS2Section4SB)
	CustomConsole($iLog, "---------------------BONUS-STAGE-3----------------------")
	CustomConsole($iLog, "Total Attempts: " & $iBS3TotalAttempts)
	CustomConsole($iLog, "Total Completes: " & $iBS3TotalCompletes)
	CustomConsole($iLog, "Retried: " & $iBS3TotalRetried)
	CustomConsole($iLog, "Failed: " & $iBS3TotalFails)
	CustomConsole($iLog, "Success: " & $iBS3SuccessPerc & "%")
	CustomConsole($iLog, "BS3: Attempts (No Spirit Boost): " & $iBonusStage3)
	CustomConsole($iLog, "BS3: Attempts (Spirit Boost): " & $iBonusStage3SB)
	CustomConsole($iLog, "BS3: Completes (No Spirit Boost): " & $iBS3Section4)
	CustomConsole($iLog, "BS3: Completes (Spirit Boost): " & $iBS3Section4SB)
	CustomConsole($iLog, "BS3: Section 1 Complete (No Spirit Boost): " & $iBS3Section1)
	CustomConsole($iLog, "BS3: Section 2 Complete (No Spirit Boost): " & $iBS3Section2)
	CustomConsole($iLog, "BS3: Section 3 Complete (No Spirit Boost): " & $iBS3Section3)
	CustomConsole($iLog, "BS3: Section 4 Complete (No Spirit Boost): " & $iBS3Section4)
	CustomConsole($iLog, "BS3: Section 1 Complete (Spirit Boost): " & $iBS3Section1SB)
	CustomConsole($iLog, "BS3: Section 2 Complete (Spirit Boost): " & $iBS3Section2SB)
	CustomConsole($iLog, "BS3: Section 3 Complete (Spirit Boost): " & $iBS3Section3SB)
	CustomConsole($iLog, "BS3: Section 4 Complete (Spirit Boost): " & $iBS3Section4SB)
	CustomConsole($iLog, "-------------------ASCENDING-HEIGHTS--------------------")
	CustomConsole($iLog, "Ascending Heights Won : " & $iAscendingHeights - $iAscendingHeightsFailed)
	CustomConsole($iLog, "Ascending Heights Failed : " & $iAscendingHeightsFailed)
	CustomConsole($iLog, "----------------------BOSS-FIGHTS-----------------------")
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
	CustomConsole($iLogData, "Only Bonus Stage 2 and 3 works otherwise skip it.")
	CustomConsole($iLogData, "Disable Hard Mode for Bonus Stage 2.")
	CustomConsole($iLogData, "Do not buy Vertical Magnet.")
	CustomConsole($iLogData, "Disable dialogue for Portal in setting.")
	CustomConsole($iLogData, "Enable rounded bulk in setting.")
	CustomConsole($iLogData, "Enable hide locked quest rewards in setting.")
	CustomConsole($iLogData, "The game must be in English.")
	CustomConsole($iLogData, "Game must be in focus.")
	CustomConsole($iLogData, "Ascension Upgrade Leadership Master is mandatory.")
	CustomConsole($iLogData, "Ascension Upgrade Protect is mandatory for Bonus Stage 2.")
	CustomConsole($iLogData, "Ascension Upgrade Board The Platforms is mandatory for")
	CustomConsole($iLogData, "       Bonus Stage 3.")
	CustomConsole($iLogData, "Use Roy/Anna for Victor and Ascending Heights.")
	CustomConsole($iLogData, "Run the script as Administrator in Windows 11.")
	CustomConsole($iLogData, "Disable custom cursor in setting.")
	CustomConsole($iLogData, "Tip: Hover over the Text-Boxes")
	CustomConsole($iLogData, "       on the Idle Runner to read what they do!", True)
EndFunc   ;==>LoadDataLog

Func CustomConsole($iComponent, $sText, $bAppend = False)
	If $bAppend Then
		$sText = $sText & "	"
	Else
		$sText = $sText & @CRLF
	EndIf
	GUICtrlSetData($iComponent, $sText, 1)
EndFunc   ;==>CustomConsole
