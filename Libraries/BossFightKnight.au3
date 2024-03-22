#include-once
#include "Common.au3"

Func BossFightKnight()
	WriteInLogs("Start of BossFight Knight")
	Do
		Slider()
		Sleep(500)
		PixelSearch(653, 222, 653, 222, 0xFFF38F)
	Until @error
	BossBattleKnight()
EndFunc   ;==>BossFightKnight

Func BossBattleKnight()
	Global $bFirstStage = True, $bDashAttack = False
	Local $aPos, $iTimer = 1000, $iAttackTimer = 1800, $hAttackTimer = TimerInit(), $hTime = TimerInit(), $hTimeEndBoss = TimerInit()

	For $i = 1 To 9 Step +1
		ShootKnight()
	Next

	While 1
		If $iAttackTimer < TimerDiff($hAttackTimer) Then
			$aPos = PixelSearch(900, 150, 900, 343, 0x2C2C2C)
			If Not @error Then
				$hAttackTimer = TimerInit()
				RangeAttackKnight($aPos)
			EndIf
			$aPos = PixelSearch(445, 210, 445, 387, 0xAF9967)
			If Not @error Then
				$hAttackTimer = TimerInit()
				CloseAttackKnight($aPos)
			EndIf

			$aPos = PixelSearch(445, 210, 445, 387, 0xD7CCB3)
			If Not @error Then
				$hAttackTimer = TimerInit()
				CloseAttackKnight($aPos)
			EndIf
		EndIf

		If $iTimer < TimerDiff($hTime) Then

			If $bFirstStage == True Then
				PixelSearch(267, 130, 272, 130, 0xF5B784)
				If Not @error Then
					;ConsoleWrite(' Dialog ')
					WriteInLogs("Knight Stage 2")
					Do
						Sleep(100)
						MouseClick("left", 1020, 420, 1, 0)
						PixelSearch(272, 130, 272, 130, 0xF5B784)
					Until @error
					ControlFocus("Idle Slayer", "", "")
					$bFirstStage = False
					$bDashAttack = True
				EndIf
			EndIf

			PixelSearch(510, 75, 510, 75, 0x000000)
			If Not @error Then
				WriteInLogs("Knight Dark stage")
				;ConsoleWrite(" Dark ")
				Local $hTimer = TimerInit()
				Do
					MouseClick('left', 1000, 328, 1, 0)
					PixelSearch(835, 477, 835, 477, 0xFD3169)
					If Not @error Then
						Sleep(500)
						MouseClick('left', 615, 563)
						WriteInLogs("Knight Won")
						ExitLoop 2
					EndIf
				Until 30000 < TimerDiff($hTimer)
				WriteInLogs("Knight Lost")
				ExitLoop 1
			EndIf

			If 200000 < TimerDiff($hTimeEndBoss) Then
				WriteInLogs("Knight Lost")
				ExitLoop 1
			EndIf

			$hTime = TimerInit()
		EndIf
	WEnd
EndFunc   ;==>BossBattleKnight

Func CloseAttackKnight($aPos)
	Sleep(700)
	Local $bUpper = True
	If $aPos[1] > 283 Then
		$bUpper = False
	EndIf
	If $bUpper Then
		UpperAttackKnight()
		If $bDashAttack == True Then
			Sleep(500)
			ControlSend("Idle Slayer", "", "", "{Up down}")
			Sleep(170)
			ControlSend("Idle Slayer", "", "", "{Up up}")
		EndIf
	Else
		DownAttackKnight()
		If $bDashAttack == True Then
			For $i = 0 To 10 Step +1
				Sleep(10)
				MouseClick("left", 1020, 420, 1, 0)
			Next
			Return
		EndIf
	EndIf
	For $i = 0 To 30 Step +1
		Sleep(10)
		MouseClick("left", 1020, 420, 1, 0)
	Next
EndFunc   ;==>CloseAttackKnight

Func RangeAttackKnight($aPos)
	Sleep(100)
	$bDashAttack = False
	Local $bUpper = True
	If $aPos[1] > 240 Then
		$bUpper = False
	EndIf
	If $bUpper Then
		UpperAttackKnight()
	Else
		DownAttackKnight()
	EndIf
	For $i = 1 To 25 Step +1
		Sleep(10)
		MouseClick("left", 1020, 420, 1, 0)
	Next
EndFunc   ;==>RangeAttackKnight

Func DownAttackKnight()
	;ConsoleWrite(' DownAttack ')
	ControlSend("Idle Slayer", "", "", "{Up down}")
	Sleep(170)
	ControlSend("Idle Slayer", "", "", "{Up up}")
EndFunc   ;==>DownAttackKnight

Func UpperAttackKnight()
	;ConsoleWrite(' UpperAttack ')
	Sleep(730)
EndFunc   ;==>UpperAttackKnight

Func ShootKnight()
	Sleep(200)
	ControlSend("Idle Slayer", "", "", "{Up down}")
	Sleep(300)
	ControlSend("Idle Slayer", "", "", "{Up up}")
	For $i = 1 To 14 Step +1
		Sleep(5)
		Send("{Up}")
	Next
EndFunc   ;==>ShootKnight
