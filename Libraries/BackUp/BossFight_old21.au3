#include <File.au3>

Func BossFight($sLogPath)
	_FileWriteLog($sLogPath, "Start of BossFight")
	Do
		Slider()
		Sleep(500)
		PixelSearch(653, 222, 653, 222, 0xFFF38F)
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
BossFight('')
;BossBattleVictor('')
Func BossBattleVictor($sLogPath)
	;Ininital Seconds
	For $i = 0 To 100 Step +1
		Sleep(50)
		Send("{Up}")
	Next
	ConsoleWrite('End')
	Sleep(400)
		For $i = 0 To 30 Step +1
		Sleep(50)
		Send("{Up}")
	Next
		ConsoleWrite('End2')
		Sleep(400)
	;;AdlibRegister("Shoot", 50)
For $i = 0 To 18 Step +1
		Sleep(10)
		Send("{Up}")
	Next

	While 1

		PixelSearch(914, 150, 914, 488, 0xFFFFFF)
		If Not @error Then
			AdlibUnRegister("Shoot")
			FlameAttackVictor()
			;Sleep(580)
		EndIf
		$aPos = PixelSearch(902, 292, 902, 452, 0xFFFFFF)
		If Not @error Then
		AdlibUnRegister("Shoot")
		NormalAttackVictor($aPos)
		EndIf
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
		;PixelSearch(858, 170, 858, 422, 0x7E4588)

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
	;FindPixelUntilFound(156,523,156,523,"0xA656FF",600)
	;FindPixelUntilFound(440, 510, 440, 510, "0xB206B1", 1000)
	Sleep(300)
	ConsoleWrite(' Flame ')
	ControlSend("Idle Slayer", "", "", "{Up down}")
	Sleep(100)
	ControlSend("Idle Slayer", "", "", "{Up up}")
	For $i = 0 To 18 Step +1
		Sleep(10)
		Send("{Up}")
	Next
	;AdlibRegister("Shoot", 50)
EndFunc   ;==>FlameAttackVictor

Func DownAttackVictor()
	ConsoleWrite(' DownAttack ')
	Sleep(200)
	ControlSend("Idle Slayer", "", "", "{Up down}")
	Sleep(100)
	ControlSend("Idle Slayer", "", "", "{Up up}")
	For $i = 0 To 18 Step +1
		Sleep(10)
		Send("{Up}")
	Next
	;AdlibRegister("Shoot", 50)
EndFunc   ;==>DownAttackVictor

Func UpperAttackVictor()
	ConsoleWrite(' UpperAttack ')
	Sleep(600)
	;AdlibRegister("Shoot", 50)
EndFunc   ;==>UpperAttackVictor

Func Shoot()
	Send("{Up}")
EndFunc   ;==>Shoot


Func FindPixelUntilFound($iX1, $iY1, $iX2, $iY2, $sHex, $iTimer = 15000)
	Local $time = TimerInit()
	Local $aPos
	Do
		$aPos = PixelSearch($iX1, $iY1, $iX2, $iY2, $sHex)
	Until Not @error Or $iTimer < TimerDiff($time)
	If $iTimer < TimerDiff($time) Then
		Return False
	Else
		Return $aPos
	EndIf
EndFunc   ;==>FindPixelUntilFound


Func Slider()
	;Top left
	PixelSearch(443, 560, 443, 560, 0x007E00)
	If Not @error Then
		MouseMove(840, 560, 0)
		MouseClickDrag("left", 840, 560, 450, 560)
		Return
	EndIf

	;Bottom left
	PixelSearch(443, 620, 443, 620, 0x007E00)
	If Not @error Then
		MouseMove(840, 620, 0)
		MouseClickDrag("left", 840, 620, 450, 620)
		Return
	EndIf

	;Top right
	PixelSearch(850, 560, 850, 560, 0x007E00)
	If Not @error Then
		MouseMove(450, 560, 0)
		MouseClickDrag("left", 450, 560, 840, 560)
		Return
	EndIf

	;Bottom right
	PixelSearch(850, 620, 850, 620, 0x007E00)
	If Not @error Then
		MouseMove(450, 620, 0)
		MouseClickDrag("left", 450, 620, 840, 620)
		Return
	EndIf
EndFunc   ;==>Slider
