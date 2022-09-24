#include <File.au3>
Func BossFight($sLogPath)
	_FileWriteLog($sLogPath, "Start of BossFight")
	Do
		Slider()
		Sleep(500)
		PixelSearch(660, 254, 660, 254, 0xFFE737)
	Until @error
	BossBattleVictor($sLogPath)
EndFunc   ;==>BossFight

Func BossBattleVictor($sLogPath)
	AdlibRegister("Shoot", 50)
	While 1
		;Dialog
		PixelSearch(272, 130, 272, 130, 0xF5B784)
		If Not @error Then
			Sleep(100)
			PixelSearch(477, 673, 477, 673, 0xF5B784)
			If Not @error Then
				_FileWriteLog($sLogPath, "Victor Lost")
				ExitLoop 1
			EndIf
			MouseClick('left', 272, 130)

		EndIf

		PixelSearch(730, 300, 755, 419, 0x151515)
		If Not @error Then
			;ConsoleWrite(' UpperAttack ')
			AdlibUnRegister("Shoot")
			FindPixelUntilFound(180, 300, 180, 419, 0x151515, 1500)
			AdlibRegister("Shoot", 50)
		EndIf

		PixelSearch(777, 420, 800, 462, 0x151515)
		If Not @error Then
			;ConsoleWrite(' DownAttack ')
			AdlibUnRegister("Shoot")
			FindPixelUntilFound(400, 420, 400, 462, 0x151515, 1500)
			ControlSend("Idle Slayer", "", "", "{Up down}")
			AdlibRegister("Shoot", 50)
			Sleep(150)
			ControlSend("Idle Slayer", "", "", "{Up up}")
		EndIf

		PixelSearch(777, 509, 800, 509, 0x151515)
		If Not @error Then
			;ConsoleWrite(' Flame ')
			AdlibUnRegister("Shoot")
			FindPixelUntilFound(400, 509, 400, 509, 0xB206B1, 1500)
			ControlSend("Idle Slayer", "", "", "{Up down}")
			AdlibRegister("Shoot", 50)
			Sleep(150)
			ControlSend("Idle Slayer", "", "", "{Up up}")
		EndIf
		;Close Boss Fight
		PixelSearch(835, 477, 835, 477, 0xFD3169)
		If Not @error Then
			Sleep(500)
			MouseClick('left', 615, 563)
			_FileWriteLog($sLogPath, "Victor Won")
			ExitLoop 1
		EndIf
	WEnd
EndFunc   ;==>BossBattleVictor

Func Shoot()
	ControlSend("Idle Slayer", "", "", "{Up}")
EndFunc   ;==>Shoot
