#comments-start
 AutoIt Version: 3.3.16.0
 Author: Devil4ngle, Djahnz
#comments-end

#Region Idle Runner.au3 #WRAPPER#
#AutoIt3Wrapper_Icon=Resources\Icon.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_File_Add=Resources\Icon.jpg, RT_RCDATA, ICON,0
#AutoIt3Wrapper_Res_File_Add=Resources\Welcome.jpg, RT_RCDATA, WELCOME,0
#AutoIt3Wrapper_Res_File_Add=Resources\Instructions.jpg, RT_RCDATA, INSTRUCTION,0
#AutoIt3Wrapper_Res_File_Add=Resources\CheckboxUnchecked.jpg, RT_RCDATA, UNCHECKED,0
#AutoIt3Wrapper_Res_File_Add=Resources\CheckboxChecked.jpg, RT_RCDATA, CHECKED,0
#AutoIt3Wrapper_Res_File_Add=Resources\CraftRagePill.jpg, RT_RCDATA, RAGEPILL,0
#AutoIt3Wrapper_Res_File_Add=Resources\CraftSoulBonus.jpg, RT_RCDATA, SOULBONUS,0
#AutoIt3Wrapper_Res_File_Add=Resources\AutoBuyUpgrades.jpg, RT_RCDATA, AUTOUPGRADES,0
#AutoIt3Wrapper_Res_File_Add=Resources\CirclePortals.jpg, RT_RCDATA, CIRCLEPORTALS,0
#AutoIt3Wrapper_Res_File_Add=Resources\SkipBonusStage.jpg, RT_RCDATA, SKIPBONUS,0
#AutoIt3Wrapper_Res_File_Add=Resources\Home.jpg, RT_RCDATA, HOME,0
#AutoIt3Wrapper_Res_File_Add=Resources\General.jpg, RT_RCDATA, GENERAL,0
#AutoIt3Wrapper_Res_File_Add=Resources\Minigames.jpg, RT_RCDATA, MINIGAMES,0
#AutoIt3Wrapper_Res_File_Add=Resources\Log.jpg, RT_RCDATA, LOG,0
#AutoIt3Wrapper_Res_File_Add=Resources\Stop.jpg, RT_RCDATA, STOP,0
#AutoIt3Wrapper_Res_File_Add=Resources\Start.jpg, RT_RCDATA, START,0
#AutoIt3Wrapper_Res_File_Add=Resources\Exit.jpg, RT_RCDATA, EXIT,0
#AutoIt3Wrapper_Res_File_Add=Resources\Crafting.jpg, RT_RCDATA, CRAFTING,0
#AutoIt3Wrapper_Res_File_Add=Resources\Github.jpg, RT_RCDATA, GITHUB,0
#AutoIt3Wrapper_Res_File_Add=Resources\JumpRate.jpg, RT_RCDATA, JUMPRATE,0
#AutoIt3Wrapper_Res_File_Add=Resources\UpArrow.jpg, RT_RCDATA, UPARROW,0
#AutoIt3Wrapper_Res_File_Add=Resources\DownArrow.jpg, RT_RCDATA, DOWNARROW,0
#AutoIt3Wrapper_Res_File_Add=Resources\NoLockpicking.jpg, RT_RCDATA, NOLOCKPICKING,0
#AutoIt3Wrapper_Res_File_Add=Resources\CraftBidimensionalStaff.jpg, RT_RCDATA, BIDIMENSIONAL,0
#AutoIt3Wrapper_Res_File_Add=Resources\CraftDimensionalStaff.jpg, RT_RCDATA, DIMENSIONAL,0

;Numbers
#AutoIt3Wrapper_Res_File_Add=Resources\0.jpg, RT_RCDATA, NUM0,0
#AutoIt3Wrapper_Res_File_Add=Resources\10.jpg, RT_RCDATA, NUM10,0
#AutoIt3Wrapper_Res_File_Add=Resources\20.jpg, RT_RCDATA, NUM20,0
#AutoIt3Wrapper_Res_File_Add=Resources\30.jpg, RT_RCDATA, NUM30,0
#AutoIt3Wrapper_Res_File_Add=Resources\40.jpg, RT_RCDATA, NUM40,0
#AutoIt3Wrapper_Res_File_Add=Resources\50.jpg, RT_RCDATA, NUM50,0
#AutoIt3Wrapper_Res_File_Add=Resources\60.jpg, RT_RCDATA, NUM60,0
#AutoIt3Wrapper_Res_File_Add=Resources\70.jpg, RT_RCDATA, NUM70,0
#AutoIt3Wrapper_Res_File_Add=Resources\80.jpg, RT_RCDATA, NUM80,0
#AutoIt3Wrapper_Res_File_Add=Resources\90.jpg, RT_RCDATA, NUM90,0
#AutoIt3Wrapper_Res_File_Add=Resources\100.jpg, RT_RCDATA, NUM100,0
#AutoIt3Wrapper_Res_File_Add=Resources\110.jpg, RT_RCDATA, NUM110,0
#AutoIt3Wrapper_Res_File_Add=Resources\120.jpg, RT_RCDATA, NUM120,0
#AutoIt3Wrapper_Res_File_Add=Resources\130.jpg, RT_RCDATA, NUM130,0
#AutoIt3Wrapper_Res_File_Add=Resources\140.jpg, RT_RCDATA, NUM140,0
#AutoIt3Wrapper_Res_File_Add=Resources\150.jpg, RT_RCDATA, NUM150,0
#AutoIt3Wrapper_Res_File_Add=Resources\160.jpg, RT_RCDATA, NUM160,0
#AutoIt3Wrapper_Res_File_Add=Resources\170.jpg, RT_RCDATA, NUM170,0
#AutoIt3Wrapper_Res_File_Add=Resources\180.jpg, RT_RCDATA, NUM180,0
#AutoIt3Wrapper_Res_File_Add=Resources\190.jpg, RT_RCDATA, NUM190,0
#AutoIt3Wrapper_Res_File_Add=Resources\200.jpg, RT_RCDATA, NUM200,0
#AutoIt3Wrapper_Res_File_Add=Resources\210.jpg, RT_RCDATA, NUM210,0
#AutoIt3Wrapper_Res_File_Add=Resources\220.jpg, RT_RCDATA, NUM220,0
#AutoIt3Wrapper_Res_File_Add=Resources\230.jpg, RT_RCDATA, NUM230,0
#AutoIt3Wrapper_Res_File_Add=Resources\240.jpg, RT_RCDATA, NUM240,0
#AutoIt3Wrapper_Res_File_Add=Resources\250.jpg, RT_RCDATA, NUM250,0
#AutoIt3Wrapper_Res_File_Add=Resources\260.jpg, RT_RCDATA, NUM260,0
#AutoIt3Wrapper_Res_File_Add=Resources\270.jpg, RT_RCDATA, NUM270,0
#AutoIt3Wrapper_Res_File_Add=Resources\280.jpg, RT_RCDATA, NUM280,0
#AutoIt3Wrapper_Res_File_Add=Resources\290.jpg, RT_RCDATA, NUM290,0
#AutoIt3Wrapper_Res_File_Add=Resources\300.jpg, RT_RCDATA, NUM300,0

#AutoIt3Wrapper_Run_Stop_OnError=y
#EndRegion Idle Runner.au3 #WRAPPER#

#include-once
#include "Libraries\ResourcesEx.au3"
#include "Libraries\BonusStageEx.au3"
#include "Libraries\ChestHuntEx.au3"
#include "Libraries\GUI.au3"

; Enables GUI events
Opt("GUIOnEventMode", 1)
; Disable Caps for better background
Opt("SendCapslockMode", 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode", 0)

; Set Hotkey Bindings
; Setting own hotkeys coming soon
Global $Running = False
HotKeySet("{Home}", "_Pause")
HotKeySet("{Esc}", "_IdleClose")

; Create GUI
$GUIForm = _CreateGUI()
GUISetState(@SW_SHOW)

Local $timer = TimerInit()
; Infinite Loop
While 1
	If $TogglePause Then ContinueLoop

	If WinGetTitle("[ACTIVE]") <> "Idle Runner" Then
		ControlFocus("Idle Slayer", "", "")
	EndIf

	;Jump and shoot
	ControlSend("Idle Slayer", "", "", "{Up}{Right}")
	Sleep($JumpSliderValue)

	; Silver box collect
	PixelSearch(650, 36, 650, 36, 0xFFC000)
	If Not @error Then
		_FileWriteLog($LogPath, "Silver Box Collected")
		MouseClick("left", 644, 49, 1, 0)
	EndIf

	; Close Armory full not hover over
	PixelSearch(775, 600, 775, 600, 0xB40000)
	If Not @error Then
		CloseAll()
	EndIf

	; Close Armory full hover over
	PixelSearch(775, 600, 775, 600, 0xAD0000)
	If Not @error Then
		CloseAll()
	EndIf

	; Chest-hunt
	PixelSearch(570, 742, 742, 570, 0x5B3B0A)
	If Not @error Then
		_Chesthunt($LogPath, $NoLockpickingState)
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
	PixelSearch(660, 254, 660, 254, 0xFFE737)
	If Not @error Then
		PixelSearch(638, 236, 638, 236, 0xFFBB31)
		If Not @error Then
			PixelSearch(775, 448, 775, 448, 0xFFFFFF)
			If Not @error Then
				_BonusStage($LogPath, $SkipBonusStageState)
			EndIf
		EndIf
	EndIf

	; Circle portal
	If $CirclePortalsState Then
		CirclePortals()
	EndIf

	; Auto buy upgrades
	If $AutoBuyUpgradeState Then
		If (600000 < TimerDiff($timer)) Then
			$timer = TimerInit()
			WinActivate("Idle Slayer")
			BuyEquipment()
		EndIf
	EndIf

	; Claim quests
	PixelSearch(1130, 610, 1130, 610, 0xCBCB4C)
	If Not @error Then
		ClaimQuests()
	EndIf
WEnd

Func CloseAll()
	Sleep(2000)
	PixelSearch(775, 600, 775, 600, 0xAD0000)
	If Not @error Then
		MouseClick("left", 775, 600, 1, 0)
	EndIf
	PixelSearch(775, 600, 775, 600, 0xB40000)
	If Not @error Then
		MouseClick("left", 775, 600, 1, 0)
	EndIf
EndFunc   ;==>CloseAll

Func RageWhenHorde()
	If CheckForSoulBonus() Then
		If $CraftRagePillState Then
			BuyTempItem("0x871646")
		EndIf
		If $CraftSoulBonusState Then
			BuyTempItem("0x7D55D8")
		EndIf
	EndIf
	_FileWriteLog($LogPath, "MegaHorde Rage")
	If $Dimensional Then
		BuyTempItem("0xF37C55")
		$Dimensional = False
		_Resource_SetToCtrlID($CheckBoxDimension, 'UNCHECKED')
	EndIf
	If $BiDimensional Then
		BuyTempItem("0x526629")
		$BiDimensional = False
		_Resource_SetToCtrlID($CheckBoxBiDimension, 'UNCHECKED')
	EndIf
	ControlFocus("Idle Slayer", "", "")
	ControlSend("Idle Slayer", "", "", "{e}")
EndFunc   ;==>RageWhenHorde

Func CheckForSoulBonus()
	Local $location = PixelSearch(625, 143, 629, 214, 0xA86D0A)
	If Not @error Then
		_FileWriteLog($LogPath, "MegaHorde Rage with SoulBonus")
		Return True
	EndIf
EndFunc   ;==>CheckForSoulBonus

Func BuyTempItem($hexColor)
	_FileWriteLog($LogPath, "CraftingTemp Item Active")
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
		; on this x search color
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
	Sleep(100)
EndFunc   ;==>BuyTempItem

Func CollectMinion()
	;Click ascension button
	MouseClick("left", 95, 90, 1, 0)
	Sleep(400)
	;Click ascension tab
	MouseClick("left", 93, 680, 1, 0)
	Sleep(200)
	;Click ascension tree tab
	MouseClick("left", 193, 680, 1, 0)
	Sleep(200)
	;????
	MouseClick("left", 691, 680, 1, 0)
	Sleep(200)
	;Click minion tab
	MouseClick("left", 332, 680, 1, 0)
	Sleep(200)

	;Check if Daily Bonus is available
	PixelSearch(370, 410, 910, 470, 0x11AA23, 9)
	If Not @error Then
		;Click Claim All
		MouseClick("left", 320, 280, 5, 0)
		Sleep(200)
		;Click Send All
		MouseClick("left", 320, 280, 5, 0)
		Sleep(200)
		;Claim Daily Bonus
		MouseClick("left", 320, 180, 5, 0)
		Sleep(200)
		_FileWriteLog($LogPath, "Minions Collect with Daily Bonus")
	Else
		;Click Claim All
		MouseClick("left", 318, 182, 5, 0)
		Sleep(200)
		;Click Send All
		MouseClick("left", 318, 182, 5, 0)
		Sleep(200)
		_FileWriteLog($LogPath, "Minions Collect")
	EndIf

	;Click Exit
	MouseClick("left", 570, 694, 1, 0)
EndFunc   ;==>CollectMinion

Func CirclePortals()
	_FileWriteLog($LogPath, "CirclePortals")
	;Check if portal button is visible
	Local $PortalVisible = 0
	PixelSearch(1180, 180, 1180, 180, 0x830399)
	If @error Then
		$PortalVisible += 1
	EndIf
	PixelSearch(1180, 180, 1180, 180, 0x290130)
	If @error Then
		$PortalVisible += 1
	EndIf

	If $PortalVisible == 2 Then
		Return
	EndIf

	;Check if timer is up
	PixelSearch(1154, 144, 1210, 155, 0xFFFFFF, 9)
	If @error Then
		;Click portal button
		MouseClick("left", 1180, 150, 1, 0)
		Sleep(300)

		;Select destination
		;Top of scrollbar
		MouseMove(867, 300, 0)
		Sleep(200)
		Do
			MouseWheel($MOUSE_WHEEL_UP, 20)
			;Top of searchbar
			PixelSearch(875, 275, 875, 275, 0xD6D6D6)
		Until @error
		Sleep(400)

		Local $Color = 0xFFFFFF
		Switch $CirclePortalsCount
			Case 1
				$Color = 0x72FBFF
			Case 2
				$Color = 0x510089
			Case 3
				$Color = 0x00D0FF
			Case 4
				$Color = 0x00A197
			Case 5
				$Color = 0x00017B
			Case 6
				$Color = 0xE79CC4
			Case 7
				$Color = 0x00FFBA
			Case 8
				$Color = 0xCA484D
		EndSwitch

		While 1
			$location = PixelSearch(491, 266, 491, 540, $Color)
			If @error Then
				;Check gray scroll bar is there
				PixelSearch(875, 536, 875, 536, 0xD6D6D6)
				If @error Then
					ExitLoop
				EndIf
				Sleep(10)
				;Move mouse on ScrollBar
				MouseMove(867, 300, 0)
				MouseWheel($MOUSE_WHEEL_DOWN, 1)
			Else
				;Click portal
				MouseClick("left", $location[0], $location[1], 1, 0)
				Sleep(300)
				ExitLoop
			EndIf
		WEnd

		$CirclePortalsCount += 1
		If $CirclePortalsCount > 8 Then
			$CirclePortalsCount = 1
		EndIf
		ConsoleWrite($CirclePortalsCount & @CRLF)
		Sleep(10000)

	EndIf
EndFunc   ;==>CirclePortals

Func BuyEquipment()
	_FileWriteLog($LogPath, "AutoUpgrade Active")
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

Func ClaimQuests()
	_FileWriteLog($LogPath, "Claiming quest")
	;Close Shop window if open
	MouseClick("left", 1244, 712, 1, 0)
	Sleep(150)
	;Open shop window
	MouseClick("left", 1163, 655, 1, 0)
	Sleep(150)
	;Click on armor tab
	MouseClick("left", 850, 690, 1, 0)
	;Click on upgrade tab
	MouseClick("left", 927, 683, 1, 0)
	Sleep(150)
	;Click on quest tab
	MouseClick("left", 1000, 690, 1, 0)
	Sleep(50)

	; Top of scrollbar
	MouseMove(1254, 272, 0)
	Do
		MouseWheel($MOUSE_WHEEL_UP, 20)
		;Top of searchbar
		PixelSearch(1254, 267, 1254, 267, 0xD6D6D6)
	Until @error
	Sleep(400)

	While 1
		;Check if there is any green buy boxes
		$location = PixelSearch(1160, 270, 1160, 590, 0x11AA23, 10)
		If @error Then
			;Move mouse on ScrollBar
			MouseMove(1253, 270, 0)
			MouseWheel($MOUSE_WHEEL_DOWN, 1)
			;Check gray scroll bar is there
			PixelSearch(1253, 645, 1253, 645, 0xD6D6D6)
			If @error Then
				ExitLoop
			EndIf
			Sleep(10)
		Else
			;Click Green buy box
			_FileWriteLog($LogPath, "Quest Claimed")
			MouseClick("left", $location[0], $location[1], 5, 0)
		EndIf
	WEnd

	;Close Shop
	MouseClick("left", 1244, 712, 1, 0)

EndFunc   ;==>ClaimQuests