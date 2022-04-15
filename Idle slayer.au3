#comments-start
 AutoIt Version: 3.3.16.0
 Author:         Devil4ngle
#comments-end

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>

; Enables GUI events
Opt("GUIOnEventMode", 1)
; Disable Caps for better background
Opt("SendCapslockMode", 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode", 0)
#Region ### START Koda GUI section ### Form=d:\idle macro\github\idle-slayer-macro\idlerunner.kxf
Global $Idle = GUICreate("Idle Runner", 641, 101, 724, 880)
GUISetBkColor(0x646464)
GUISetOnEvent($GUI_EVENT_CLOSE, "IdleClose")
Global $Tab = GUICtrlCreateTab(0, 0, 640, 100)
Global $Home = GUICtrlCreateTabItem("Home")
Global $AutoBuyUpgrade = GUICtrlCreateCheckbox("AutoBuyUpgrade", 16, 32, 97, 17)
GUICtrlSetTip(-1, " Buys upgrades every 10 minutes except Vertical Magnet")
GUICtrlSetOnEvent(-1, "AutoBuyUpgradeClick")
Global $SkipBonusStage = GUICtrlCreateCheckbox("SkipBonusStage", 16, 64, 97, 17)
GUICtrlSetTip(-1, "Skips Bonus Stages by letting the timer run out without doing anything")
GUICtrlSetOnEvent(-1, "SkipBonusStageClick")
Global $CraftRagePill = GUICtrlCreateCheckbox("CraftRagePill", 128, 64, 97, 17)
GUICtrlSetTip(-1, "When Horde/Mega Horde, use Rage Pill When Rage is Down")
GUICtrlSetOnEvent(-1, "CraftRagePillClick")
Global $CraftSoulBonus = GUICtrlCreateCheckbox("CraftSoulBonus", 128, 32, 97, 17)
GUICtrlSetTip(-1, "When Horde/Mega Horde, use Souls Compass When Rage is Down")
GUICtrlSetOnEvent(-1, "CraftSoulPillClick")
Global $JumpSlider = GUICtrlCreateSlider(240, 51, 150, 30)
GUICtrlSetLimit(-1, 300, 0)
GUICtrlSetData(-1, 150)
GUICtrlSetOnEvent(-1, "JumpSliderChange")
Global $JumpRate = GUICtrlCreateLabel("JumpRate", 288, 32, 52, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
Global $Logs = GUICtrlCreateTabItem("Logs")
Global $Log = GUICtrlCreateEdit("", 16, 32, 601, 57, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
GUICtrlSetData(-1, "Log")
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
Global $AutoBuyUpgradeState = $GUI_UNCHECKED, $CraftSoulBonusState = $GUI_UNCHECKED, $SkipBonusStageState = $GUI_UNCHECKED, _
		$CraftRagePillState = $GUI_UNCHECKED, $CirclePortalsState = $GUI_UNCHECKED, $JumpSliderValue = 150

Func IdleClose()
	Exit
EndFunc   ;==>IdleClose
Func AutoBuyUpgradeClick()
	$AutoBuyUpgradeState = GUICtrlRead($AutoBuyUpgrade)
EndFunc   ;==>AutoBuyUpgradeClick
Func CirclePortalsClick()
	;$CirclePortalsState = GUICtrlRead($CirclePortals)
EndFunc   ;==>CirclePortalsClick
Func CraftRagePillClick()
	$CraftRagePillState = GUICtrlRead($CraftRagePill)
EndFunc   ;==>CraftRagePillClick
Func CraftSoulPillClick()
	$CraftSoulBonusState = GUICtrlRead($CraftSoulBonus)
EndFunc   ;==>CraftSoulPillClick
Func JumpSliderChange()
	$JumpSliderValue = GUICtrlRead($JumpSlider)
EndFunc   ;==>JumpSliderChange
Func SkipBonusStageClick()
	$SkipBonusStageState = GUICtrlRead($SkipBonusStage)
EndFunc   ;==>SkipBonusStageClick

#EndRegion ### END Koda GUI section ###

Local $timer = TimerInit()
; Infinite Loop
While 1
	If WinGetTitle("[ACTIVE]") <> "Idle Runner" Then
		ControlFocus("Idle Slayer", "", "")
	EndIf
	;Jump and shoot
	ControlSend("Idle Slayer", "", "", "{Up}{Right}")
	Sleep($JumpSliderValue)

	; Silver box collect
	PixelSearch(650, 36, 650, 36, 0xFFC000)
	If Not @error Then
		MouseClick("left", 644, 49, 1, 0)
	EndIf
	; Close Armory full not hover over
	PixelSearch(775, 600, 775, 600, 0xB40000)
	If Not @error Then
		MouseClick("left", 775, 600, 1, 0)
	EndIf

	; Close Armory full hover over
	PixelSearch(775, 600, 775, 600, 0xAD0000)
	If Not @error Then
		MouseClick("left", 775, 600, 1, 0)
	EndIf

	; Chest-hunt
	PixelSearch(598, 45, 598, 45, 0xD0C172)
	If Not @error Then
		Chesthunt()
	EndIf

	; Rage when Megahorde
	PixelSearch(419, 323, 419, 323, 0xDFDEE0)
	If Not @error Then
		RageWhenHorde()
	EndIf

	; Rage when Soul Bonus
	PixelSearch(625, 143, 629, 214, 0xA86D0A)
	If Not @error Then
		ControlSend("Idle Slayer", "", "", "{e}")
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

	If ($AutoBuyUpgradeState == $GUI_CHECKED) Then
		If (600000 < TimerDiff($timer)) Then
			$timer = TimerInit()
			WinActivate("Idle Slayer")
			BuyEquipment()
		EndIf
	EndIf

WEnd

Func RageWhenHorde()
	If CheckForSoulBonus() Then
		If $CraftRagePillState == $GUI_CHECKED Then
			BuyTempItem("0x871646")
			Sleep(100)
		EndIf
		If $CraftSoulBonusState == $GUI_CHECKED Then
			BuyTempItem("0x7D55D8")
		EndIf
	EndIf
	ControlFocus("Idle Slayer", "", "")
	ControlSend("Idle Slayer", "", "", "{e}")
EndFunc   ;==>RageWhenHorde


Func CheckForSoulBonus()
	Local $location = PixelSearch(625, 143, 629, 214, 0xA86D0A)
	If Not @error Then
		PixelSearch(688, $location[1], 688, $location[1], 0xD98E04)
		If Not @error Then
			Return False
		EndIf
		PixelSearch(697, $location[1] - 7, 697, $location[1] - 5, 0xDB8F04)
		If Not @error Then
			Return False
		EndIf
		Return True
	EndIf
EndFunc   ;==>CheckForSoulBonus

Func BuyTempItem($hexColor)
	Local $success
	;open menu
	MouseClick("left", 160, 100, 1, 0)
	Sleep(150)
	;temp item
	MouseClick("left", 260, 690, 1, 0)
	Sleep(150)
	;top of scrollbar
	MouseClick("left", 482, 150, 5, 0)
	Sleep(450)
	While 1
		$success = PixelSearch(65, 180, 65, 630, $hexColor)
		If Not @error Then
			MouseClick("left", 385, $success[1], 1, 0)
			Sleep(50)
			ExitLoop
		EndIf
		MouseWheel($MOUSE_WHEEL_DOWN, 1)
		Sleep(50)
		PixelSearch(484, 647, 484, 647, 0xD6D6D6)
		If @error Then
			ExitLoop
		EndIf
	WEnd
	MouseClick("left", 440, 690, 1, 0)
EndFunc   ;==>BuyTempItem

Func CollectMinion()
	MouseClick("left", 95, 90, 1, 0)
	Sleep(400)
	MouseClick("left", 93, 680, 1, 0)
	Sleep(200)
	MouseClick("left", 193, 680, 1, 0)
	Sleep(200)
	MouseClick("left", 691, 680, 1, 0)
	Sleep(200)
	MouseClick("left", 332, 680, 1, 0)
	Sleep(200)
	MouseClick("left", 318, 182, 5, 0)
	Sleep(200)
	MouseClick("left", 318, 182, 5, 0)
	Sleep(200)
	MouseClick("left", 570, 694, 1, 0)
EndFunc   ;==>CollectMinion

Func Chesthunt()
	Sleep(2000)
	Local $saverX = 0
	Local $saverY = 0
	Local $pixelX = 185
	Local $pixelY = 325
	; Locate saver
	For $y = 1 To 3
		For $x = 1 To 10
			PixelSearch($pixelX, $pixelY - 1, $pixelX + 5, $pixelY, 0xFFEB04)
			If Not @error Then
				$saverX = $pixelX
				$saverY = $pixelY
				ExitLoop (2)
			EndIf
			$pixelX += 95
		Next
		$pixelY += 95
		$pixelX = 185
	Next
	; Actual chest hunt
	$pixelX = 185
	$pixelY = 325
	$count = 0
	For $y = 1 To 3
		For $x = 1 To 10
			; After opening 2 chest open saver
			If $count == 2 And $saverX > 0 Then
				MouseClick("left", $saverX + 33, $saverY - 23, 1, 0)
				Sleep(550)
			EndIf
			; Skip saver no matter what
			If $pixelY == $saverY And $pixelX == $saverX Then
				; Go next line If saver is last chest
				If $x == 10 Then
					ExitLoop (1)
				Else
					$pixelX += 95
					ContinueLoop
				EndIf
			EndIf
			; Open chest
			MouseClick("left", $pixelX + 33, $pixelY - 23, 1, 0)
			Sleep(550)
			; Check if chest hunt ended
			PixelSearch(400, 695, 400, 695, 0xB40000)
			If Not @error Then
				ExitLoop (2)
			EndIf
			; if mimic wait some more
			PixelSearch(434, 211, 434, 211, 0xFF0000)
			If Not @error Then
				Sleep(1500)
			EndIf
			$pixelX += 95
			$count += 1
		Next
		$pixelY += 95
		$pixelX = 185
	Next
	; Look for close button until found
	Do
		Sleep(50)
		PixelSearch(400, 694, 400, 694, 0xB40000)
	Until Not @error
	MouseClick("left", 643, 693, 1, 0)
EndFunc   ;==>Chesthunt

Func BonusStage()
	BonusStageSlider()
	Sleep(4000)
	PixelSearch(443, 97, 443, 97, 0xFFFFFF)
	If $SkipBonusStageState == $GUI_CHECKED Then
		BonusStageDoNoting()
	Else
		If Not @error Then ;if Spirit Boost do noting untill close appear
			BonusStageSP()
		Else
			BonusStageNSP()
		EndIf
	EndIf

EndFunc   ;==>BonusStage

Func BonusStageDoNoting()
	Do
		Sleep(200)
	Until BonusStageFail()
EndFunc   ;==>BonusStageDoNoting

Func BonusStageSlider()
	;Top left
	PixelSearch(443, 560, 443, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 840, 560, 450, 560)
		Return
	EndIf

	;Bottom left
	PixelSearch(443, 620, 443, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 840, 620, 450, 620)
		Return
	EndIf

	;Top right
	PixelSearch(850, 560, 850, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 450, 560, 840, 560)
		Return
	EndIf

	;Bottom right
	PixelSearch(850, 620, 850, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 450, 620, 840, 620)
		Return
	EndIf
EndFunc   ;==>BonusStageSlider

Func BonusStageFail()
	PixelSearch(775, 600, 775, 600, 0xB40000, 10)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		Return True
	EndIf
	Return False
EndFunc   ;==>BonusStageFail

Func BonusStageNSP()
	; Section 1 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	Sleep(200)
	;Section 1 start
	cSend(94, 1640) ;1
	cSend(32, 1218) ;2
	cSend(94, 600) ;3
	cSend(109, 1828) ;4
	cSend(63, 640) ;5
	cSend(47, 688) ;6
	cSend(78, 1906) ;7
	cSend(141, 1625) ;8
	cSend(47, 3187) ;9
	cSend(47, 734) ;10
	cSend(47, 750) ;11
	cSend(78, 1203) ;12
	cSend(110, 5000) ;13
	If BonusStageFail() Then
		Return
	EndIf
	; Section 1 Collection
	cSend(40, 5000)
	For $x = 1 To 17
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
	; Section 2 sync
	FindPixelUntilFound(780, 536, 780, 536, 0xBB26DF)
	; Section 2 start
	cSend(156, 719) ;1
	cSend(47, 687) ;2
	cSend(360, 1390) ;3
	cSend(485, 344) ;4
	cSend(406, 859) ;5
	cSend(78, 600) ;6
	cSend(94, 900) ;7
	cSend(109, 954) ;8
	cSend(31, 672) ;9
	cSend(515, 1344) ;10
	cSend(484, 297) ;11
	cSend(406, 859) ;12
	cSend(78, 600) ;13
	cSend(94, 900) ;14
	cSend(109, 954) ;15
	cSend(31, 672) ;16
	cSend(515, 1344) ;17
	cSend(469, 219) ;18
	cSend(297, 1000) ;19
	cSend(156, 500) ;20
	cSend(110, 3000) ;21
	cSend(360, 2984) ;22
	cSend(531, 2313) ;23
	If BonusStageFail() Then
		Return
	EndIf
	; Section 2 Collection
	cSend(350, 1000)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
	;Stage 3 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	; Section 3 Start
	cSend(109, 1203) ;1
	cSend(31, 641) ;2
	cSend(47, 1578) ;3
	cSend(47, 2437) ;4
	;repeat
	cSend(109, 1203) ;5
	cSend(31, 641) ;6
	cSend(47, 1578) ;7
	cSend(47, 2437) ;8
	;repeat
	cSend(109, 1203) ;9
	cSend(31, 641) ;10
	cSend(47, 1578) ;11
	cSend(47, 2437) ;12
	;repeat
	cSend(109, 1203) ;13
	cSend(31, 641) ;14
	cSend(47, 5125) ;15
	If BonusStageFail() Then
		Return
	EndIf
	;Section 3 Collection
	cSend(900, 200)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
	;Section 4 sync
	FindPixelUntilFound(250, 472, 100, 250, 0x0D2030)
	Sleep(200)
	;Section 4 Start
	cSend(32, 2500) ;1
	cSend(31, 809) ;2
	cSend(41, 1375) ;3
	cSend(41, 1374) ;4
	cSend(641, 690) ;5
	cSend(41, 1373) ;6
	cSend(41, 2500) ;7
	cSend(31, 809) ;8
	cSend(41, 1375) ;9
	cSend(41, 1374) ;10
	cSend(641, 690) ;11
	cSend(41, 1373) ;12
	cSend(41, 1372) ;13
	cSend(641, 690) ;14
	cSend(41, 1371) ;15
	; extra jump just in case
	cSend(41) ;16
	;Section 4 Collection
	For $x = 1 To 23
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
EndFunc   ;==>BonusStageNSP

Func cSend($pressDelay, $postPressDelay = 0, $key = "Up")
	Send("{" & $key & " Down}")
	Sleep($pressDelay)
	Send("{" & $key & " Up}")
	Sleep($postPressDelay)
	Return
EndFunc   ;==>cSend

Func FindPixelUntilFound($x1, $y1, $x2, $y2, $hex, $timer = 15000)
	Local $time = TimerInit()
	Do
		PixelSearch($x1, $y1, $x2, $y2, $hex)
	Until Not @error Or $timer < TimerDiff($time)
EndFunc   ;==>FindPixelUntilFound

Func BuyEquipment()
	;Close Shop window if open
	MouseClick("left", 1244, 712, 1, 0)
	Sleep(150)
	;Open shop window
	MouseClick("left", 1163, 655, 1, 0)
	Sleep(150)
	;Click on armor tab
	MouseClick("left", 850, 690, 1, 0)
	Sleep(50)
	;Click Max buy
	MouseClick("left", 1180, 636, 4, 0)
	;Check if scrollbar is here if no max buy first item otherwise last item
	PixelSearch(1257, 340, 1257, 340, 0x11AA23)
	If Not @error Then
		;buy sword
		MouseClick("left", 1200, 200, 5, 0)
	Else
		;Click Bottom of scroll bar
		MouseClick("left", 1253, 592, 5, 0)
		Sleep(200)
		;Buy last item
		MouseClick("left", 1200, 550, 5, 0)
		;Click top of scroll bar
		MouseClick("left", 1253, 170, 5, 0)
		Sleep(200)
	EndIf
	;50 buy
	MouseClick("left", 1100, 636, 5, 0)
	While 1
		;Check if there is any green buy boxes
		$location = PixelSearch(1160, 170, 1160, 590, 0x11AA23, 10)
		If @error Then
			;Move mouse on ScrollBar
			MouseMove(1253, 170, 0)
			MouseWheel($MOUSE_WHEEL_DOWN, 1)
			;Check gray scroll bar is there
			PixelSearch(1253, 597, 1253, 597, 0xD6D6D6)
			If @error Then
				ExitLoop
			EndIf
			Sleep(10)
		Else
			;Click Green buy box
			MouseClick("left", $location[0], $location[1], 5, 0)
		EndIf
	WEnd
	BuyUpgrade()
EndFunc   ;==>BuyEquipment

Func BuyUpgrade()
	; Navigate to upgrade and scroll up
	MouseClick("left", 927, 683, 1, 0)
	Sleep(150)
	; Top of scrollbar
	MouseMove(1254, 172, 0)
	Do
		MouseWheel($MOUSE_WHEEL_UP, 20)
		;Top of searchbar
		PixelSearch(1254, 167, 1254, 167, 0xD6D6D6)
	Until @error
	Sleep(400)
	$somethingBought = False
	Local $y = 170
	While 1
		; Check if RandomBox Magnet is next upgrade
		PixelSearch(882, $y, 909, $y + 72, 0xF4B41B)
		If Not @error Then
			$y += 96
		EndIf
		; Check if RandomBox Magnet is next upgrade
		PixelSearch(882, $y, 909, $y + 72, 0xE478FF)
		If Not @error Then
			$y += 96
		EndIf
		PixelSearch(1180, $y, 1180, $y, 0x10A322, 9)
		If @error Then
			ExitLoop
		Else
			$somethingBought = True
			MouseClick("left", 1180, $y, 1, 0)
			Sleep(30)
		EndIf
	WEnd
	If $somethingBought Then
		BuyEquipment()
	Else
		MouseClick("left", 1222, 677, 1, 0)
	EndIf
EndFunc   ;==>BuyUpgrade

Func BonusStageSP()
	; Section 1 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	Sleep(200)
	;Section 1 start
	cSend(94, 1640) ;1
	cSend(47, 2072) ;2
	cSend(187, 688) ;3
	cSend(31, 672) ;4
	cSend(31, 1700) ;5
	cSend(94, 600) ;6
	cSend(94, 1640) ;1
	cSend(47, 2072) ;2
	cSend(187, 688) ;3
	cSend(31, 672) ;4
	cSend(31, 1700) ;5
	cSend(94, 600) ;6
	cSend(94, 5000) ;1
	If BonusStageFail() Then
		Return
	EndIf
	; Section 1 Collection
	cSend(40, 2500)
	For $x = 1 To 19
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
	; Section 2 sync
	FindPixelUntilFound(780, 536, 780, 536, 0xBB26DF)
	; Section 2 start
	cSend(156, 719) ;1
	cSend(47, 687) ;2
	cSend(360, 1390) ;3
	cSend(485, 344) ;4
	cSend(406, 859) ;5
	cSend(78, 600) ;6
	cSend(94, 900) ;7
	cSend(109, 954) ;8
	cSend(31, 672) ;9
	cSend(515, 1344) ;10
	cSend(484, 297) ;11
	cSend(406, 859) ;12
	cSend(78, 600) ;13
	cSend(94, 900) ;14
	cSend(109, 954) ;15
	cSend(31, 672) ;16
	cSend(515, 1344) ;17
	cSend(469, 219) ;18
	cSend(297, 1000) ;19
	cSend(156, 500) ;20
	cSend(110, 3000) ;21
	cSend(360, 2984) ;22
	cSend(531, 2313) ;23
	If BonusStageFail() Then
		Return
	EndIf
	; Section 2 Collection
	cSend(350, 1000)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
	;Stage 3 sync
	FindPixelUntilFound(220, 465, 220, 465, 0xA0938E)
	; Section 3 Start
	cSend(109, 1203) ;1
	cSend(31, 641) ;2
	cSend(47, 1200) ;3
	cSend(1, 3100) ;4
	;repeat
	cSend(109, 1203) ;5
	cSend(31, 641) ;6
	cSend(47, 1200) ;7
	cSend(1, 3100) ;8
	;repeat
	cSend(109, 1203) ;9
	cSend(31, 641) ;10
	cSend(47, 1200) ;11
	cSend(1, 3100) ;12
	;repeat
	cSend(109, 1203) ;13
	cSend(31, 641) ;14
	cSend(47, 5125) ;15
	If BonusStageFail() Then
		Return
	EndIf
	;Section 3 Collection
	cSend(900, 200)
	For $x = 1 To 20
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
	;Section 4 sync
	FindPixelUntilFound(250, 472, 100, 250, 0x0D2030)
	Sleep(200)
	ConsoleWrite("start")
	;Section 4 Start
	cSend(32, 2800) ;1
	cSend(31, 809) ;2
	cSend(41, 1200) ;3
	cSend(100, 900) ;4
	cSend(641, 500) ;5

	cSend(31, 850) ;6
	cSend(41, 770) ;7
	cSend(641, 400) ;8

	cSend(31, 850) ;9
	cSend(41, 870) ;10
	cSend(641, 300) ;11

	cSend(31, 850) ;12
	cSend(41, 790) ;13
	cSend(641, 400) ;14

	cSend(31, 850) ;15
	cSend(41, 840) ;16
	cSend(641, 300) ;17

	cSend(31, 850) ;18
	cSend(41, 840) ;19
	cSend(641, 300) ;20
	;Section 4 Collection
	For $x = 1 To 23
		Send("{Up}")
		Sleep(500)
	Next
	If BonusStageFail() Then
		Return
	EndIf
EndFunc   ;==>BonusStageSP
