#include <File.au3>
Global $bFirstStage
Func BossFight($sLogPath)
	_FileWriteLog($sLogPath, "Start of BossFight")
	Do
		Slider()
		Sleep(500)
		PixelSearch(653, 222, 653, 222, 0xFFF38F)
	Until @error
	BossBattleVictor($sLogPath)
EndFunc   ;==>BossFight

Func BossBattleVictor($sLogPath)
	$bFirstStage = True
	AdlibRegister("Shoot", 50)
	Sleep(8600)
	Local $aPos
	Local $time = TimerInit()
	While 1
		If $bFirstStage == False Then
			PixelSearch(914, 150, 914, 488, 0xFFFFFF)
			If Not @error Then
				AdlibUnRegister("Shoot")
				FlameAttackVictor()
			EndIf
		EndIf
		$aPos = PixelSearch(902, 292, 902, 452, 0xFFFFFF)
		If Not @error Then
			AdlibUnRegister("Shoot")
			NormalAttackVictor($aPos)
		EndIf

		If 7000 < TimerDiff($time) Then
			;Close Boss Fight
			PixelSearch(835, 477, 835, 477, 0xFD3169)
			If Not @error Then
				Sleep(500)
				MouseClick('left', 615, 563)
				_FileWriteLog($sLogPath, "Victor Won")
				ExitLoop 1
			EndIf
			PixelSearch(272, 130, 272, 130, 0xF5B784)

			If Not @error Then
				;ConsoleWrite(' Dialog ')
				PixelSearch(310, 83, 310, 83, 0xB056F3)
				If Not @error Then
					AdlibRegister("Shoot", 50)
					$bFirstStage = False
					Do
						Sleep(50)
						MouseClick('left', 272, 130)
						PixelSearch(310, 83, 310, 83, 0xB056F3)
					Until @error
					_FileWriteLog($sLogPath, "Victor Stage 2")
					Sleep(4000)
					AdlibUnRegister("Shoot")
					ControlFocus("Idle Slayer", "", "")
				Else
					MouseClick('left', 272, 130)
					AdlibUnRegister("Shoot")
					_FileWriteLog($sLogPath, "Victor Lost")
					MouseClick('left', 272, 130)
					ExitLoop 1
				EndIf
			EndIf
			$time = TimerInit()
		EndIf
	WEnd
EndFunc   ;==>BossBattleVictor

Func NormalAttackVictor($aPos)
	Local $bUpper = True
	If $aPos[1] > 385 Then
		$bUpper = False
	EndIf
	If $bUpper Then
		UpperAttackVictor()
	Else
		DownAttackVictor()
	EndIf
EndFunc   ;==>NormalAttackVictor

Func FlameAttackVictor()
	Sleep(300)
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
	Sleep(700)
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
