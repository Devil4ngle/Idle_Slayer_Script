#comments-start
 AutoIt Version: 3.3.16.0
 Author:         Devil4ngle
#comments-end

; Disable Caps for better background
Opt( "SendCapslockMode" , 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode",0)

; Infinite Loop
While 1
	ControlFocus ( "Idle Slayer", "",  "")
	ControlSend ( "Idle Slayer", "", "", "{Up}{Right}{e}")
	Sleep ( 150 )
	;Silver box collect
	PixelSearch(580, 40, 580, 40, 0xFF0000)
	If Not @error Then
		MouseClick("left",644,49,1,0)
	EndIf
	
   ; Chest-hunt 
   PixelSearch(598, 45, 598, 45, 0xD0C172)
	If Not @error Then
		Chesthunt()
	EndIf


	; Collect minions 
   PixelSearch(99, 113, 99, 113, 0xFFFF7A)
	If Not @error Then
		CollectMinion()
	EndIf

	; Bonus stage
   PixelSearch(860, 670, 860, 670, 0xAC8371)
	If Not @error Then
		BonusStage()
	EndIf
WEnd

Func CollectMinion()
	MouseClick("left",95,90,1,0)
	Sleep ( 400 )
	MouseClick("left",332,680,1,0)
	Sleep ( 100 )
	MouseClick("left",318,182,1,0)
	Sleep ( 100 )
	MouseClick("left",318,182,1,0)
	Sleep ( 100 )
	MouseClick("left",570,694,1,0)
EndFunc

Func Chesthunt()
	Sleep ( 2000 )
	Local $saverX = 0
	Local $saverY = 0
	Local $pixelX = 185
	Local $pixelY = 325
	; Locate saver
	For $y=1 to 3
		For $x=1 to 10
			   PixelSearch($pixelX, $pixelY-1, $pixelX+5, $pixelY, 0xFFEB04)
			   If Not @error Then
				 	$saverX=$pixelX
					$saverY=$pixelY
					ExitLoop(2)
			   EndIf
			   $pixelX += 95
		Next
		$pixelY += 95
		$pixelX = 185
	Next
	$pixelX = 185
	$pixelY = 325
	For $y=1 to 3
		For $x=1 to 10
			; After opening 2 chest open saver
			if $x == 3 And $y ==1 And $saverX > 0 Then
				MouseClick("left",$saverX+33,$saverY-23,1,0)
				Sleep( 550 )
			EndIf 
			; Skip saver no matter what
			if $pixelY == $saverY And $pixelX == $saverX Then
				; Go next line If saver is last chest
				if $x == 10 Then
					ExitLoop(1)
				Else
					$x+=1
					$pixelX += 95
				EndIf
			EndIf
			; Open chest
			MouseClick("left",$pixelX+33,$pixelY-23,1,0)
			Sleep( 550 )
			; Check if chest hunt ended
			PixelSearch(400, 695, 400, 695, 0xB40000)
			If Not @error Then
				ExitLoop(2)
			EndIf
			; if mimic wait some more
			PixelSearch(434, 211, 434, 211, 0xFF0000)
			If Not @error Then
				Sleep( 1500 )
			EndIf
			$pixelX += 95
		Next
			$pixelY += 95
			$pixelX = 185
	Next
	; Look for close button untill found 
	Do
		Sleep( 50 )
		PixelSearch(400, 694, 400, 694, 0xB40000)
	Until Not @error
	MouseClick("left",643,693,1,0)
	; Boost and sleep 
	ControlSend ( "Idle Slayer", "", "", "{Right}")
	Sleep( 2000 )
EndFunc

Func BonusStage() 
	BonusStageSlider()
	Sleep (4000)
	PixelSearch(443, 97, 443, 97, 0xFFFFFF)
	If Not @error Then 	;if Spirit Boost do noting untill close appear
		Do
			Sleep(200)
		Until BonusStageFail() 
	Else
			;Run until block
		Do
			Sleep( 200 )
			PixelSearch(220, 465, 220, 465, 0xA0938E)
		Until Not @error
		Sleep( 200 )
		BonusStageNSP()
	EndIf
	
EndFunc

Func BonusStageSlider()
	;Top left
	PixelSearch(443, 560, 443, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left",840,560,450,560)
		Return
	EndIf

	;Bottom left
	PixelSearch(443, 620, 443, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left",840,620,450,620)
		Return
	EndIf

	;Top right
	PixelSearch(850, 560, 850, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left",450,560,840,560)
		Return
	EndIf

	;Bottom right
	PixelSearch(850, 620, 850, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left",450,620,840,620)
		Return
	EndIf
EndFunc

Func BonusStageFail()
	PixelSearch(810, 631, 810, 631, 0x723536)
	If Not @error Then
		MouseClick("left",721,577,1,0)
		Return True
	EndIf
	Return False
EndFunc

Func BonusStageNSP()
	;Section 1
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 94)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1640)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 32)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1218)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 94)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1563)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 109)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1828)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 63)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 640)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 688)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 78)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1906)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 141)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1625)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 3187)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 734)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 750)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 78)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1203)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 110)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	If BonusStageFail() Then
		Return
	EndIf
	;Section 2
	Sleep( 5094)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 46)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 6047)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 219)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 78)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1313)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 62)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 2141)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 7700)
	Do
		Sleep( 10 )
		PixelSearch(670, 149, 670, 149, 0x7A444A)
	Until Not @error
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 156)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 719)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 687)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 360)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1390)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 485)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 344)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 406)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 859)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 78)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1203)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 94)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 922)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 109)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 954)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 672)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 515)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1344)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 484)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 297)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 313)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 984)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 78)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1297)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 156)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 813)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 172)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 984)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 625)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 610)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1890)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 469)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 219)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 297)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1000)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 156)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1531)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 110)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1390)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 360)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 5984)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 531)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	;Section 3
	If BonusStageFail() Then
		Return
	EndIf
	Sleep( 2313)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 344)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1234)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 62)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 454)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 62)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1125)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 3047)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 62)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 110)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 62)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 9219)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 109)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1203)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 641)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1578)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 2437)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 110)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1297)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 656)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1625)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 2313)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 109)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1516)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 640)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1547)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1969)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 93)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1203)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 625)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	If BonusStageFail() Then
		Return
	EndIf
	;Section 4
	Sleep( 5125)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 891)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1406)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 94)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 344)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 78)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 359)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 78)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 3453)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 63)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 9062)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 32)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 4578)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 859)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1375)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1406)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 641)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 703)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1344)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1484)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 578)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 766)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1407)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 31)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1437)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 563)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 719)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 46)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1438)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1422)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 547)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 750)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 46)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1625)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 94)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 391)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 281)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 1391)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 109)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 2406)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 63)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 390)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 63)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 2672)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 62)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	Sleep( 485)
	ControlSend ( "Idle Slayer", "", "", "{Up Down}")
	Sleep( 47)
	ControlSend ( "Idle Slayer", "", "", "{Up Up}")
	If BonusStageFail() Then
		Return
	EndIf
	Sleep( 4000)
	If BonusStageFail() Then
		Return
	EndIf
EndFunc