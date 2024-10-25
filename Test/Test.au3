#include <GDIPlus.au3>
#include <File.au3>
#include <Array.au3>
#include <WinAPI.au3>

; Enables GUI events
Opt("GUIOnEventMode", 1)
; Disable Caps for better background
Opt("SendCapslockMode", 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode", 0)
_WinAPI_SetKeyboardLayout("Idle Slayer", 0x0409)


HotKeySet("{ESC}", "Terminate")

Global $running = True

ReadImagePixels(780, 588)
ReadGamePixels(780, 588)

Func Terminate()
	$running = False
	_GDIPlus_Shutdown()
	Exit
EndFunc   ;==>Terminate


Func ReadImagePixels($iX, $iY)

	; Set the folder path
	Local $ss_path = @ScriptDir & "\ImageTest"

	; Initialize GDI+
	_GDIPlus_Startup()

	; Get list of files in the folder
	Local $fileList = _FileListToArray($ss_path, "*.png", 1)

	; Check if any files were found
	If @error Then
		MsgBox(16, "Error", "No PNG files found in the folder!")
		_GDIPlus_Shutdown()
		Exit
	EndIf

	; Process each image
	For $i = 1 To $fileList[0]
		Local $imagePath = $ss_path & "\" & $fileList[$i]

		; Load the image
		Local $hImage = _GDIPlus_ImageLoadFromFile($imagePath)
		If $hImage Then
			; Get pixel color
			Local $pixelColor = _GDIPlus_BitmapGetPixelColor($hImage, $iX, $iY)
			ConsoleWrite($fileList[$i] & " + " & $pixelColor & @CRLF)

			; Clean up
			_GDIPlus_ImageDispose($hImage)
		Else
			ConsoleWrite("Failed to load image: " & $fileList[$i] & @CRLF)
		EndIf
	Next

	; Shutdown GDI+
	_GDIPlus_Shutdown()
EndFunc   ;==>ReadImagePixels


Func ReadGamePixels($iX, $iY)
	While $running
		; Get pixel color from game window
		Local $pixelColor = PixelGetColor($iX, $iY)
		ConsoleWrite("Game Pixel + 0x" & Hex($pixelColor, 6) & @CRLF)

		; Wait 1 second before next reading
		Sleep(1000)
	WEnd
EndFunc   ;==>ReadGamePixels


Func _GDIPlus_BitmapGetPixelColor($hBitmap, $iX, $iY)
	Local $tArgb, $pArgb, $aRet
	$tArgb = DllStructCreate("dword Argb")
	$pArgb = DllStructGetPtr($tArgb)
	$aRet = DllCall($__g_hGDIPDll, "int", "GdipBitmapGetPixel", "hwnd", $hBitmap, "int", $iX, "int", $iY, "ptr", $pArgb)
	Return "0x" & Hex(DllStructGetData($tArgb, "Argb"), 6)
EndFunc   ;==>_GDIPlus_BitmapGetPixelColor
