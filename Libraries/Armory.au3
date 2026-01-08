#include-once
#include "Common.au3"



Func SellArmory($bArmoryExcVictorState, $bArmoryNonExcellentState , $bArmoryExcellentState)

	; Open Armory and scroll up
	; Scroll down searching red !
	; When find a red !, drag to shell
	; Depending on the choices made in the GUI, you will either sell or keep the items.

	Local $aCoord
	;Click armory button
	MouseClick("left", 169, 104, 1, 0)
	Sleep(500)
	;Click armory tab
	MouseClick("left", 359, 694, 1, 0)
	Sleep(500)
	;Exit Key Items 
	MouseClick("left", 81, 610, 1, 0)
	Sleep(500)
	;Click for scroll
	MouseClick("left", 476, 525, 1, 0)
	Sleep(500)
	;Scroll TOP
	MouseWheel("up", 50)
	Sleep(500)

	; Scroll in Armory 7 times
    For $i = 1 To 7

		; Search red !
        While 1
            ; Red pixel !
            $aCoord = PixelSearch(31, 239, 472, 500, 0xE41111)

            If Not @error Then
				WriteInLogs("SellArmory 1 New Item Found")

				; Drag to sell
				Sleep(500)
                MouseClickDrag("left", $aCoord[0], $aCoord[1]+10, 133, 618, 10)
				Sleep(500)
			

				; Check if Victor Ring
				; If GUI is checked Break if not Cancel Break
				If $bArmoryExcVictorState Then
					;Search pattern for Exc Victor Ring  0x51E294 Positions : 711,518 . 629,519 . 687,515 .
					Sleep(500) 
					PixelSearch(711, 518, 711, 518, 0x51E294)
					If Not @error Then
						PixelSearch(629, 519, 629, 519, 0x51E294)
						If Not @error Then
							PixelSearch(687, 515, 687, 515, 0x51E294)
							If Not @error Then
								WriteInLogs("SellArmory Excelent Victor Ring sold")

								;Click Break 510,578 0x00A400
								MouseClick("left", 510, 578, 1, 0)
								Sleep(500)
							EndIf
						EndIf
					EndIf
				Else
					; Dont sell 
					;Search pattern for Exc Victor Ring Positions : 711,518 . 629,519 . 687,515 .
					Sleep(500) 
					PixelSearch(711, 518, 711, 518, 0x51E294)
					If Not @error Then
						PixelSearch(629, 519, 629, 519, 0x51E294)
						If Not @error Then
							PixelSearch(687, 515, 687, 515, 0x51E294)
							If Not @error Then
								WriteInLogs("SellArmory Excelent Victor Ring wasn´t sold")

								;Click Cancel DONT SELL 676,580 0xAF0000
								MouseClick("left", 676,580, 1, 0)
							EndIf
						EndIf
					EndIf

            	EndIf

				; Check if Non-Excellent Item
				; If GUI is checked Break if not Cancel Break
				If $bArmoryNonExcellentState Then
					;Not Excelent Item (since 478,507, to 776,530)  0xFFFFFF White
					Sleep(500)
					PixelSearch(478,507, 776,530, 0xFFFFFF)
					If Not @error Then
						WriteInLogs("SellArmory Not Excelent Item sold")						

						;Click Break 510,578 0x00A400
						MouseClick("left", 510, 578, 1, 0)
						Sleep(500)
					EndIf
				Else
					;Not Excelent Item (since 478,507, to 776,530)  0xFFFFFF White
					Sleep(500)
					PixelSearch(478,507, 776,530, 0xFFFFFF)
					If Not @error Then
						WriteInLogs("SellArmory > Not Excelent Item wasn´t sold")

						;Click Cancel DONT SELL 676,580 0xAF0000
						MouseClick("left", 676,580, 1, 0)
					EndIf

            	EndIf

				; Check if Non-Excellent Item
				; If GUI is checked Break if not Cancel Break
				If $bArmoryNonExcellentState Then
					;Not Excelent Item (since 478,507, to 776,530)   0x738FE3 Blue
					Sleep(500)
					PixelSearch(478,507, 776,530, 0x738FE3)
					If Not @error Then
						WriteInLogs("SellArmory Not Excelent Item sold")

						;Click Break 510,578 0x00A400
						MouseClick("left", 510, 578, 1, 0)
						Sleep(500)
					EndIf
				Else
					;Not Excelent Item (since 478,507, to 776,530)   0x738FE3 Blue
					Sleep(500)
					PixelSearch(478,507, 776,530, 0x738FE3)
					If Not @error Then
						WriteInLogs("SellArmory > Not Excelent Item wasn´t sold")

						;Click Cancel DONT SELL 676,580 0xAF0000
						MouseClick("left", 676,580, 1, 0)
					EndIf

            	EndIf

				; Check if Excellent Item
				; If GUI is checked Break if not Cancel Break
				If $bArmoryExcellentState Then
					;Excelent Item (since 478,507, to 776,530) GREEN  0x51E294
					Sleep(500)
					PixelSearch(478,507, 776,530, 0x51E294)
					If Not @error Then
						WriteInLogs("SellArmory Excelent Item sold")

						;Click Break 510,578 0x00A400
						MouseClick("left", 510, 578, 1, 0)
						Sleep(500)
					EndIf
				Else
                	;Excelent Item (since 478,507, to 776,530) GREEN  0x51E294
					Sleep(500)
					PixelSearch(478,507, 776,530, 0x51E294)
					If Not @error Then
						WriteInLogs("SellArmory Excelent Item wasn´t sold")	

						;Click Cancel DONT SELL 676,580 0xAF0000
						MouseClick("left", 676,580, 1, 0)
						Sleep(500)
					EndIf

            	EndIf
 


            Else
                ExitLoop 
            EndIf
        WEnd  

		;Click for scroll
		MouseClick("left", 476, 525, 1, 0)
		Sleep(500)
        ; Scroll down
        MouseWheel("down", 2) 
        Sleep(500)     
        
    Next
	WriteInLogs("SellArmory Finish")
	MouseClick("left", 467, 698, 1, 0)
EndFunc   ;==>SellArmory
