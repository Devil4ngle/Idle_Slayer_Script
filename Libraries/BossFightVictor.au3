#include <File.au3>

Func BossFightVictor($sLogPath)
	_FileWriteLog($sLogPath, "Start of BossFight Victor")
	Do
		Slider()
		Sleep(500)
		PixelSearch(653, 222, 653, 222, 0xFFF38F)
	Until @error
	BossBattleVictor($sLogPath)
EndFunc   ;==>BossFight

Func BossBattleVictor($sLogPath)
	ControlFocus("Idle Slayer", "", "")
	AdlibRegister("Shoot", 50)
	Sleep(5000)
	Global $bFirstStage = True
	Local $aPos, $iTimer = 2000, $hTime = TimerInit(), $hTimeEndBoss = TimerInit()
	While 1
		If $bFirstStage == False Then
			PixelSearch(1072, 150, 1072, 488, 0xFFFFFF)
			If Not @error Then
				;Send("!{PRINTSCREEN}") 
				FlameAttackVictor()
			EndIf
		EndIf
		$aPos = PixelSearch(919, 292, 919, 452, 0xFFFFFF)
		If Not @error Then
			AdlibUnRegister("Shoot")
			NormalAttackVictor($aPos)
		EndIf

		If $iTimer < TimerDiff($hTime) Then
			;Close Boss Fight
			PixelSearch(835, 477, 835, 477, 0xFD3169)
			If Not @error Then
				AdlibUnRegister("Shoot")
				Sleep(500)
				MouseClick('left', 615, 563)
				_FileWriteLog($sLogPath, "Victor Won")
				ExitLoop 1
			EndIf
			If $bFirstStage == True Then
				PixelSearch(272, 130, 272, 130, 0xF5B784)
				If Not @error Then
					;ConsoleWrite(' Dialog ')
					$bFirstStage = False
					$iTimer = 10000
					_FileWriteLog($sLogPath, "Victor Stage 2")
					AdlibRegister("Shoot", 50)
					Do
						Sleep(50)
						PixelSearch(272, 130, 272, 130, 0xF5B784)
					Until @error
					Sleep(4000)
					AdlibUnRegister("Shoot")
					ControlFocus("Idle Slayer", "", "")
				EndIf
			EndIf
			If 200000 < TimerDiff($hTimeEndBoss) Then
				AdlibUnRegister("Shoot")
				_FileWriteLog($sLogPath, "Victor Lost")
				ExitLoop 1
			EndIf

			$hTime = TimerInit()
		EndIf
	WEnd
EndFunc   ;==>BossBattleVictor

Func NormalAttackVictor($aPos)
	Local $bUpper = True
	If $aPos[1] > 370 Then
		$bUpper = False
	EndIf
	If $bUpper Then
		UpperAttackVictor()
	Else
		DownAttackVictor()
	EndIf
EndFunc   ;==>NormalAttackVictor

Func FlameAttackVictor()
	Sleep(350)
	;ConsoleWrite(' Flame ')
	ControlSend("Idle Slayer", "", "", "{Up down}")
	Sleep(100)
	ControlSend("Idle Slayer", "", "", "{Up up}")
	For $i = 0 To 17 Step +1
		Sleep(10)
		Send("{Up}")
	Next
EndFunc   ;==>FlameAttackVictor

Func DownAttackVictor()
	;ConsoleWrite(' DownAttack ')
	Sleep(200)
	If $bFirstStage Then
		AdlibRegister("Shoot", 50)
	Else
		ControlSend("Idle Slayer", "", "", "{Up down}")
		Sleep(100)
		ControlSend("Idle Slayer", "", "", "{Up up}")
		For $i = 0 To 17 Step +1
			Sleep(10)
			Send("{Up}")
		Next
	EndIf
EndFunc   ;==>DownAttackVictor

Func UpperAttackVictor()
	;ConsoleWrite(' UpperAttack ')
	Sleep(730)
	If $bFirstStage Then
		AdlibRegister("Shoot", 50)
	Else
		For $i = 0 To 14 Step +1
			Sleep(10)
			Send("{Up}")
		Next
	EndIf
EndFunc   ;==>UpperAttackVictor

Func Shoot()
	Send("{Up}")
EndFunc   ;==>Shoot
