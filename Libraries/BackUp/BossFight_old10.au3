#include <File.au3>
Func BossFight($sLogPath)
	_FileWriteLog($sLogPath, "Start of BossFight")
	Do
		;Slider()
		Sleep(500)
		PixelSearch(660, 254, 660, 254, 0xFFE737)
	Until @error
	BossBattleVictor($sLogPath)
EndFunc   ;==>BossFight

; Enables GUI events
Opt("GUIOnEventMode", 1)
; Disable Caps for better background
Opt("SendCapslockMode", 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode", 0)
BossBattleVictor('')
Func BossBattleVictor($sLogPath)
	;;AdlibRegister("Shoot", 50)
	Local $aPos
	Local $iCheckSum
	While 1
		;PixelSearch(272, 130, 272, 130, 0xF5B784)
		;If Not @error Then
		;	ConsoleWrite(' Dialog ')
		;	Sleep(500)
		;	PixelSearch(477, 673, 477, 673, 0xF5B784)
		;	If Not @error Then
		;		AdlibUnRegister("Shoot")
		;		_FileWriteLog($sLogPath, "Victor Lost")
		;		ExitLoop 1
		;	EndIf
		;	MouseClick('left', 272, 130)
		;EndIf

		$aPos = PixelSearch(902, 292, 902, 452, 0xFFFFFF)
		If Not @error Then
			;NormalAttackVictor($aPos)
		EndIf

		$aPos = PixelSearch(890, 102, 890, 482, 0xFFFFFF)
		 $iCheckSum = PixelChecksum(880, $aPos[1], $aPos[1] + 23, 887)
		If Not @error Then
			PixelSearch(880, $aPos[1] + 23, 880, $aPos[1] + 23, 0xFFFFFF)
			If Not @error Then
				If $iCheckSum == PixelChecksum(880, $aPos[1], $aPos[1] + 23, 887) Then
					PixelSearch(887, $aPos[1] + 6, 887, $aPos[1] + 6, 0xFFFFFF)
					If Not @error Then
						;PixelSearch(887, $aPos[1] + 6, 887, $aPos[1] + 6, 0xFFFFFF)
						ConsoleWrite($aPos[1])
						Send("!{PRINTSCREEN}")
						FlameAttackVictor()
					EndIf
				EndIf
			EndIf
		EndIf

		;PixelSearch(700, 509, 800, 509, 0x151515)
		;If Not @error Then
		;	ConsoleWrite(' Flame ')
		;	AdlibUnRegister("Shoot")
		;FindPixelUntilFound(400, 509, 400, 509, 0xB206B1, 1500)
		;	ControlSend("Idle Slayer", "", "", "{Up down}")
		;	AdlibRegister("Shoot", 50)
		;	Sleep(150)
		;	ControlSend("Idle Slayer", "", "", "{Up up}")
		;EndIf
		;Close Boss Fight
		;PixelSearch(835, 477, 835, 477, 0xFD3169)
		;If Not @error Then
		;	Sleep(500)
		;	MouseClick('left', 615, 563)
		;	_FileWriteLog($sLogPath, "Victor Won")
		;	ExitLoop 1
		;EndIf
	WEnd
EndFunc   ;==>BossBattleVictor


Func NormalAttackVictor($aPos)
	AdlibUnRegister("Shoot")
	Local $bUpper = True
	If $aPos[1] > 412 Then
		$bUpper = False
	EndIf
	If $bUpper Then
		UpperAttackVictor()
	Else
		DownAttackVictor()
	EndIf
EndFunc   ;==>NormalAttackVictor

Func FlameAttackVictor()
	AdlibUnRegister("Shoot")
	ConsoleWrite(' Flame ')
	Sleep(430)
	ControlSend("Idle Slayer", "", "", "{Up down}")
	Sleep(100)
	ControlSend("Idle Slayer", "", "", "{Up up}")
	AdlibRegister("Shoot", 50)
	;AdlibRegister("Shoot", 50)
EndFunc   ;==>FlameAttackVictor

Func DownAttackVictor()
	ConsoleWrite(' DownAttack ')
	Sleep(400)
	AdlibRegister("Shoot", 50)
EndFunc   ;==>DownAttackVictor

Func UpperAttackVictor()
	ConsoleWrite(' UpperAttack ')
	Sleep(600)
	AdlibRegister("Shoot", 50)
EndFunc   ;==>UpperAttackVictor

Func Shoot()
	;Send("{Up}")
EndFunc   ;==>Shoot

Func FindPixelUntilFound($iX1, $iY1, $iX2, $iY2, $sHex, $iTimer = 15000)
	Local $time = TimerInit()
	Do
		PixelSearch($iX1, $iY1, $iX2, $iY2, $sHex)
	Until Not @error Or $iTimer < TimerDiff($time)
EndFunc   ;==>FindPixelUntilFound
