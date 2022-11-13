#include <File.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <Misc.au3>
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
	_GDIPlus_Startup()
	
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
		;PixelSearch(858, 170, 858, 422, 0x7E4588)
		Local $hBitmap = _ScreenCapture_Capture("", 888,100,891, 464, False)
		Local $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
		For $i = 0 To 364 Step +1
		if getBitmapGetPixel($hImage, 0, $i) == '0xFFFFFF' Then
				if getBitmapGetPixel($hImage, $i, $i+5) == '0xFFFFFF' Then

			ConsoleWrite('test')
		
		
			ExitLoop
		
				EndIf
EndIf
		Next
			;	ConsoleWrite( getBitmapGetPixel($hImage, 0, 0))
			;ConsoleWrite('test')
		;	ConsoleWrite('    ')
		;Sleep(300)
		;if getBitmapGetPixel($hImage, 1, 1) == '0xFFFFFF' Then
		;	ConsoleWrite('test')
		;EndIf
		;ConsoleWrite(getBitmapGetPixel($hImage, 1, 2)+'    ')
		;_GDIPlus_ImageDispose($hImage)
		;_WinAPI_DeleteObject($hBitmap)
		;$aPos = PixelSearch(863, 170, 863, 450, 0xCD963F)
		;If Not @error Then
		;AdlibUnRegister("Shoot")
		;ConsoleWrite(' tets ')
		;Sleep(200)
		;NormalAttackVictor($aPos)
		;Local $hBitmap = _ScreenCapture_Capture("C:\Users\isaak\Pictures\Camera Roll\img.jpg", 862,$aPos[1],863, $aPos[1], False)
		;Local $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
		;ConsoleWrite(getBitmapGetPixel($hImage, 1, 1))
		;ConsoleWrite(getBitmapGetPixel($hImage, 1, 2))
		;_GDIPlus_ImageDispose($hImage)
		;_WinAPI_DeleteObject($hBitmap)
			;AdlibUnRegister("Shoot")
			;Local $time = TimerInit()
			;Local $aPos
			;Do
			;	$aPos = PixelSearch(902, 292, 902, 452, 0xFFFFFF)
			;	If Not @error Then
			;		NormalAttackVictor($aPos)
			;	EndIf
			;	PixelSearch(914, 100, 914, 488, 0xFFFFFF)
			;	If Not @error Then
			;		FlameAttackVictor()
			;	EndIf
			;Until 400 < TimerDiff($time)
			;Sleep(800 - TimerDiff($time))
		;EndIf

		;	$aPos = PixelSearch(902, 292, 902, 452, 0xFFFFFF)
		;	If Not @error Then
		;ConsoleWrite(' Normal ')
		;NormalAttackVictor($aPos)
		;	EndIf

		;	PixelSearch(914, 100, 914, 488, 0xFFFFFF)
		;If Not @error Then
		;FlameAttackVictor()
		;	EndIf

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
	_GDIPlus_Shutdown()
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
	FindPixelUntilFound(380, 510, 410, 510, "0xB206B1", 1000)
	ConsoleWrite(' Flame ')
	ControlSend("Idle Slayer", "", "", "{Up down}")
	Sleep(100)
	ControlSend("Idle Slayer", "", "", "{Up up}")
	AdlibRegister("Shoot", 50)
	;AdlibRegister("Shoot", 50)
EndFunc   ;==>FlameAttackVictor

Func DownAttackVictor()
	ConsoleWrite(' DownAttack ')
	Sleep(500)
	AdlibRegister("Shoot", 50)
EndFunc   ;==>DownAttackVictor

Func UpperAttackVictor()
	ConsoleWrite(' UpperAttack ')
	Sleep(700)
	AdlibRegister("Shoot", 50)
EndFunc   ;==>UpperAttackVictor

Func Shoot()
	Send("{Up}")
EndFunc   ;==>Shoot

Func getBitmapGetPixel($hBitmap, $iX, $iY)
	Local $tArgb, $pArgb, $aRet
	$tArgb = DllStructCreate("dword Argb")
	$pArgb = DllStructGetPtr($tArgb)
	$aRet = DllCall($__g_hGDIPDll, "int", "GdipBitmapGetPixel", "hwnd", $hBitmap, "int", $iX, "int", $iY, "ptr", $pArgb)
     Return  "0x" &Hex(DllStructGetData($tArgb, "Argb"),6)
EndFunc   ;==>getBitmapGetPixel

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
