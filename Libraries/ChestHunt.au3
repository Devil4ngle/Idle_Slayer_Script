#include-once
#include "Common.au3"

Local Enum $eRewardChest = 0, $eMimicChest = 1, $e2xChest = 2, $eChestHuntEnd = 3, $eLifeSaverChest = 4
Local Enum $eStateNoMimic = 0, $eStateOneMimic = 1, $eStateTwoMimics = 2, $eStateOpenLifeSaver = 3, $eStateNormal = 4

Func Chesthunt($bNoLockpickingState)
	; state 0 - First chest - reward, second chest - reward: Open 12 more chests before goind for the live saver if you haven't found the 2x chest.
	; state 1 - First chest – mimic, second chest – reward: Open 14 more chests before going for the life saver if you haven’t found the 2x chest.
	; state 2 - First chest – mimic, second chest – mimic: Open 20 more chests because the risk of hitting another mimic is lower. After that, go for the life saver if you don’t find the 2x chest.
	; state 3 - First chest – mimic, second chest – 2x: Immediately open the life saver to gain 2 lives.
	; state 4 - First chest – 2x: Immediately open the life saver to gain 2 lives.
	Local $iCurrentState = $eStateNoMimic
	WriteInLogs("Chesthunt")
	If $bNoLockpickingState Then
		Sleep(4000)
	Else
		Sleep(2000)
	EndIf
	Local $iSaverX = 0
	Local $iSaverY = 0
	Local $iPixelX = 185
	Local $iPixelY = 325
	; Locate saver
	For $iY = 1 To 3
		For $iX = 1 To 10
			PixelSearch($iPixelX, $iPixelY - 1, $iPixelX + 5, $iPixelY, 0xFFEB04)
			If Not @error Then
				$iSaverX = $iPixelX
				$iSaverY = $iPixelY
				ExitLoop (2)
			EndIf
			$iPixelX += 95
		Next
		$iPixelY += 95
		$iPixelX = 185
	Next
	; Actual chest hunt
	$iPixelX = 185
	$iPixelY = 325
	Local $iCount = 0
	For $iY = 1 To 3
		For $iX = 1 To 10
			; Skip saver no matter what
			If $iPixelY == $iSaverY And $iPixelX == $iSaverX Then
				; Go next line If saver is last chest
				If $iX == 10 Then
					ExitLoop (1)
				Else
					$iPixelX += 95
					ContinueLoop
				EndIf
			EndIf

			Local $iChestResult = OpenChest($iPixelX, $iPixelY, $bNoLockpickingState)
            DebugChest($iCount, $iChestResult)

			If $iChestResult == $eChestHuntEnd Then
				ExitLoop (2)
			EndIF

			$iCurrentState = GetUpdatedState($iCount, $iCurrentState, $iChestResult)
            DebugState($iCount, $iCurrentState)

			if $iCurrentState == $eStateOpenLifeSaver Then
				$iCurrentState = OpenLifeSaver($iSaverX, $iSaverY, $bNoLockpickingState)
			EndIf

			$iPixelX += 95
			$iCount += 1
		Next
		$iPixelY += 95
		$iPixelX = 185
	Next
	; Look for close button until found
	While True
		Sleep(50)
		PixelSearch(500, 694, 500, 694, 0xB40000)
		If Not @error Then
			ExitLoop
		EndIf
		PixelSearch(457, 439, 457, 439, 0xF68F37)
		If Not @error Then
			MouseClick("left", 457, 439, 1, 0)
		EndIf
	WEnd
	MouseClick("left", 643, 693, 1, 0)
EndFunc   ;==>Chesthunt

Func DebugState($iCount, $eValue)
    Local $sWord
    Switch $eValue
        Case $eStateNoMimic
            $sWord = "NoMimic"
        Case $eStateOneMimic
            $sWord = "OneMimic"
        Case $eStateTwoMimics
            $sWord = "TwoMimics"
        Case $eStateOpenLifeSaver
            $sWord = "OpenLifeSaver"
        Case $eStateNormal
            $sWord = "Normal"
    EndSwitch
    WriteInLogs("Count: " & $iCount & "      State: " & $sWord)
EndFunc

Func DebugChest($iCount, $eValue)
    Local $sWord
    Switch $eValue
        Case $eRewardChest
            $sWord = "RewardChest"
        Case $eMimicChest
            $sWord = "MimicChest"
        Case $e2xChest
            $sWord = "2xChest"
        Case $eChestHuntEnd
            $sWord = "ChestHuntEndChest"
        Case $eLifeSaverChest
            $sWord = "LifeSaverChest"
    EndSwitch
    WriteInLogs("Count: " & $iCount & "      Chest: " & $sWord)
EndFunc

Func GetUpdatedState($iCount, $iCurrentState, $iChest)

	If $iCurrentState == $eStateNormal Or $iChest == $eLifeSaverChest Then
		Return $eStateNormal
	EndIf

    If $iChest == $e2xChest Then
        Return $eStateOpenLifeSaver
    EndIf

	Switch $iChest
		Case $eRewardChest
			If $iCurrentState == $eStateNoMimic and $iCount == 13 Then
				Return $eStateOpenLifeSaver
			EndIf

			If $iCurrentState == $eStateOneMimic and $iCount == 15 Then
				Return $eStateOpenLifeSaver
			EndIf

			If $iCurrentState == $eStateTwoMimics and $iCount == 21 Then
				Return $eStateOpenLifeSaver
			EndIf
	EndSwitch


	If $iCount == 0 Then
		Switch $iChest
			Case $eRewardChest
				Return $eStateNoMimic
			Case $eMimicChest
				Return $eStateOneMimic
		EndSwitch
	ElseIf $iCount == 1 Then
		Switch $iCurrentState
			Case $eStateNoMimic
				Switch $iChest
					Case $eRewardChest
						Return $eStateNoMimic
					Case $eMimicChest
						Return $eStateOneMimic
				EndSwitch
			Case $eStateOneMimic
				Switch $iChest
					Case $eRewardChest
						Return $eStateOneMimic
					Case $eMimicChest
						Return $eStateTwoMimics
				EndSwitch
		EndSwitch
	EndIf

    Return $iCurrentState
EndFunc   ;==>GetUpdatedState

Func OpenLifeSaver($iSaverX, $iSaverY, $bNoLockpickingState)
    MouseClick("left", $iSaverX + 33, $iSaverY - 23, 1, 0)
    If $bNoLockpickingState Then
        Sleep(1500)
    Else
        Sleep(550)
    EndIf
    Return $eLifeSaverChest
EndFunc


Func OpenChest($iPixelX, $iPixelY, $bNoLockpickingState)
    ; Open chest
    MouseClick("left", $iPixelX + 33, $iPixelY - 23, 1, 0)
    If $bNoLockpickingState Then
        Sleep(1500)
    Else
        Sleep(550)
    EndIf
    ; Check if chest hunt ended
    PixelSearch(500, 694, 500, 694, 0xB40000)
    If Not @error Then
        Return $eChestHuntEnd
    EndIf

    ; if 2 x wait some more
    PixelSearch(500, 210, 500, 210, 0x00FF00)
    If Not @error Then
        Sleep(1000)
        Return $e2xChest
    EndIf

    ; if mimic wait some more
    PixelSearch(434, 211, 434, 211, 0xFF0000)
    If Not @error Then
        If $bNoLockpickingState Then
            Sleep(2500)
        Else
            Sleep(1500)
        EndIf

        Return $eMimicChest
    EndIf

    Return $eRewardChest
EndFunc
