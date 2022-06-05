#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
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
#AutoIt3Wrapper_Res_File_Add=Resources\BonusStage.jpg, RT_RCDATA, BONUSSTAGE,0
#AutoIt3Wrapper_Res_File_Add=Resources\Log.jpg, RT_RCDATA, LOG,0
#AutoIt3Wrapper_Res_File_Add=Resources\Stop.jpg, RT_RCDATA, STOP,0
#AutoIt3Wrapper_Res_File_Add=Resources\Start.jpg, RT_RCDATA, START,0
#AutoIt3Wrapper_Res_File_Add=Resources\Exit.jpg, RT_RCDATA, EXIT,0
#AutoIt3Wrapper_Res_File_Add=Resources\Chesthunt.jpg, RT_RCDATA, CHESTHUNT,0
#AutoIt3Wrapper_Res_File_Add=Resources\Github.jpg, RT_RCDATA, GITHUB,0
#AutoIt3Wrapper_Res_File_Add=Resources\JumpRate.jpg, RT_RCDATA, JUMPRATE,0
#AutoIt3Wrapper_Res_File_Add=Resources\UpArrow.jpg, RT_RCDATA, UPARROW,0
#AutoIt3Wrapper_Res_File_Add=Resources\DownArrow.jpg, RT_RCDATA, DOWNARROW,0
#AutoIt3Wrapper_Res_File_Add=Resources\NoLockpicking.jpg, RT_RCDATA, NOLOCKPICKING,0

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
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#comments-start
 AutoIt Version: 3.3.16.0
 Author: Devil4ngle, Djahnz
#comments-end

#include <File.au3>
#include <ButtonConstants.au3>
#include <SliderConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <GuiTab.au3>
#include <WinAPI.au3>
#include <WinAPISysWin.au3>
#include <EditConstants.au3>
#include <AutoItConstants.au3>
#include "Resources\ResourcesEx.au3"

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
HotKeySet("{Home}", "Pause")
HotKeySet("{Esc}", "IdleClose")

; Create GUI
$GUIForm = GUICreate("Idle Runner", 898, 164, 320, 880, $WS_BORDER + $WS_POPUP)
GUISetBkColor(0x202225)

; Titlebar
GUICtrlCreateLabel("", -1, -1, 898, 22, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlCreateLabel("        Idle Runner v2.8.0", -1, -1, 900, 22, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
$Icon = GUICtrlCreatePic('', 2, 2, 16, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($Icon, 'ICON')

; Create TabControl
$TabControl = GUICtrlCreateTab(159, -4, 745, 173, BitOR($TCS_FORCELABELLEFT, $TCS_FIXEDWIDTH, $TCS_BUTTONS))
GUICtrlSetBkColor(-1, 0x2F3136)
GUISetOnEvent(-1, "TabController")
$TabHandle = GUICtrlGetHandle($TabControl)

; Create Home Tab
$TabHome = GUICtrlCreateTabItem("Home")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

; Welcome screen
$Welcome = GUICtrlCreatePic('', 186, 36, 436, 29, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($Welcome, 'WELCOME')

$ButtonDiscord = GUICtrlCreatePic('', 206, 95, 160, 50, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($ButtonDiscord, 'GITHUB')
GUICtrlSetOnEvent(-1, "ButtonGithubClick")

$ButtonInstructions = GUICtrlCreatePic('', 390, 95, 214, 50, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($ButtonInstructions, 'INSTRUCTION')
GUICtrlSetOnEvent(-1, "ButtonInstructionsClick")

; Create General Tab
$TabSheet2 = GUICtrlCreateTabItem("General")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

; Create CraftRagePill Checkbox
$CheckBoxCraftRagePill = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($CheckBoxCraftRagePill, 'UNCHECKED')
GUICtrlSetOnEvent(-1, "CraftRagePillChecked")
$Rage = GUICtrlCreatePic('', 207, 45, 132, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($Rage, 'RAGEPILL')
GUICtrlSetTip(-1, "When Horde/Mega Horde, use Rage Pill When Rage is Down")

; Create CraftSoulBonus Checkbox
$CheckBoxCraftSoulBonus = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($CheckBoxCraftSoulBonus, 'UNCHECKED')
GUICtrlSetOnEvent(-1, "CraftSoulBonusChecked")
$CraftComp = GUICtrlCreatePic('', 207, 84, 153, 14, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($CraftComp, 'SOULBONUS')
GUICtrlSetTip(-1, "When Horde/Mega Horde, use Souls Compass When Rage is Down")

; Create AutoBuyUpgrades Checkbox
$CheckBoxAutoBuyUpgrades = GUICtrlCreatePic('', 181, 122, 16, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($CheckBoxAutoBuyUpgrades, 'UNCHECKED')
GUICtrlSetOnEvent(-1, "AutoBuyUpgradesChecked")
$AutoUpgrade = GUICtrlCreatePic('', 207, 123, 165, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($AutoUpgrade, 'AUTOUPGRADES')
GUICtrlSetTip(-1, " Buys upgrades every 10 minutes except Vertical Magnet")

; Create JumpRate Slider
$Jslider = GUICtrlCreatePic('', 400, 45, 98, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($Jslider, 'JUMPRATE')

$JumpNumber = GUICtrlCreatePic('', 505, 42, 42, 22, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($JumpNumber, 'NUM150')
$JumpUp = GUICtrlCreatePic('', 547, 42, 17, 11, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($JumpUp, 'UPARROW')
GUICtrlSetOnEvent(-1, "UpArrow")
$JumpDown = GUICtrlCreatePic('', 547, 53, 17, 11, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($JumpDown, 'DOWNARROW')
GUICtrlSetOnEvent(-1, "DownArrow")

; Create CirclePortals Checkbox
$CheckBoxCirclePortals = GUICtrlCreatePic('', 611, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($CheckBoxCirclePortals, 'UNCHECKED')
GUICtrlSetOnEvent(-1, "CirclePortalsChecked")
$CirclePortals = GUICtrlCreatePic('', 637, 45, 129, 14, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($CirclePortals, 'CIRCLEPORTALS')
GUICtrlSetTip(-1, "Automate portal cycle")

; Create Bonus Stage Tab
$TabSheet3 = GUICtrlCreateTabItem("Bonus Stage")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

$CheckBoxSkipBonusStage = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($CheckBoxSkipBonusStage, 'UNCHECKED')
GUICtrlSetOnEvent(-1, "SkipBonusStageChecked")
$SKIPBS = GUICtrlCreatePic('', 207, 45, 160, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($SKIPBS, 'SKIPBONUS')

GUICtrlSetTip(-1, "Skips Bonus Stages by letting the timer run out without doing anything")

; Create Chesthunt Tab
$TabSheet4 = GUICtrlCreateTabItem("Chest Hunt")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

$NoLockpicking = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($NoLockpicking, 'UNCHECKED')
GUICtrlSetOnEvent(-1, "NoLockpickingChecked")
$NPL = GUICtrlCreatePic('', 207, 45, 176, 16, $SS_BITMAP + $SS_NOTIFY)
_Resource_SetToCtrlID($NPL, 'NOLOCKPICKING')

; Create Log Tab
$TabSheet5 = GUICtrlCreateTabItem("TabSheet5")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)
$Log = GUICtrlCreateEdit("", 180, 32, 700, 120, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL, $ES_READONLY))
GUICtrlSetBkColor($Log, 0x000000)
GUICtrlSetColor($Log, 0x4CFF00)
; Set Tab Focus Home
GUICtrlSetState($TabHome, $GUI_SHOW)
GUICtrlCreateTabItem("")

; Create Home Button
$ButtonHome = GUICtrlCreatePic('', 1, 20, 160, 24, $SS_NOTIFY + $SS_BITMAP)
_Resource_SetToCtrlID($ButtonHome, 'HOME')
GUICtrlSetOnEvent(-1, "ButtonHomeClick")

; Create General Button
$ButtonGeneral = GUICtrlCreatePic('', 1, 44, 160, 24, $SS_NOTIFY + $SS_BITMAP)
_Resource_SetToCtrlID($ButtonGeneral, 'GENERAL')
GUICtrlSetOnEvent(-1, "ButtonGeneralClick")

; Create Bonus Stage Button
$ButtonBonusStage = GUICtrlCreatePic('', 1, 68, 160, 24, $SS_NOTIFY + $SS_BITMAP)
_Resource_SetToCtrlID($ButtonBonusStage, 'BONUSSTAGE')
GUICtrlSetOnEvent(-1, "ButtonBonusStageClick")

; Create Chesthunt Button
$ButtonChestHunt = GUICtrlCreatePic('', 1, 92, 160, 24, $SS_NOTIFY + $SS_BITMAP)
_Resource_SetToCtrlID($ButtonChestHunt, 'CHESTHUNT')
GUICtrlSetOnEvent(-1, "ButtonChestHuntClick")

; Create Log Button
$ButtonLog = GUICtrlCreatePic('', 1, 116, 160, 24, $SS_NOTIFY + $SS_BITMAP)
_Resource_SetToCtrlID($ButtonLog, 'LOG')
GUICtrlSetOnEvent(-1, "ButtonLogClick")

; Create Start / Pause Button
$ButtonStartStop = GUICtrlCreatePic('', 1, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
_Resource_SetToCtrlID($ButtonStartStop, 'STOP')
GUICtrlSetOnEvent(-1, "Pause")

; Create Stop Button
$ButtonExit = GUICtrlCreatePic('', 81, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
_Resource_SetToCtrlID($ButtonExit, 'EXIT')
GUICtrlSetOnEvent(-1, "IdleClose")

GUISetState(@SW_SHOW)

Global $AutoBuyUpgradeState = False, $CraftSoulBonusState = False, $SkipBonusStageState = False, _
		$CraftRagePillState = False, $CirclePortalsState = False, $JumpSliderValue = 150, _
		$TogglePause = False, $NoLockpickingState = False, $LogPath = "Idle_Slayer_Log.txt", $CirclePortalsCount = 7

Func IdleClose()
	Exit
EndFunc   ;==>IdleClose

Func Pause()
	$TogglePause = Not $TogglePause
	If $TogglePause Then
		ControlFocus("Idle Slayer", "", "")
		_Resource_SetToCtrlID($ButtonStartStop, 'START')
	Else
		ControlFocus("Idle Slayer", "", "")
		_Resource_SetToCtrlID($ButtonStartStop, 'STOP')
	EndIf
EndFunc   ;==>Pause

Func ButtonHomeClick()
	GUICtrlSetState($TabHome, $GUI_SHOW)
EndFunc   ;==>ButtonHomeClick

Func ButtonGeneralClick()
	GUICtrlSetState($TabSheet2, $GUI_SHOW)
EndFunc   ;==>ButtonGeneralClick

Func ButtonBonusStageClick()
	GUICtrlSetState($TabSheet3, $GUI_SHOW)
EndFunc   ;==>ButtonBonusStageClick

Func ButtonChestHuntClick()
	GUICtrlSetState($TabSheet4, $GUI_SHOW)
EndFunc   ;==>ButtonChestHuntClick

Func ButtonLogClick()
	GUICtrlSetState($TabSheet5, $GUI_SHOW)
	LoadLog()
EndFunc   ;==>ButtonLogClick

Func ButtonExitClick()
	Exit
EndFunc   ;==>ButtonExitClick

Func ButtonGithubClick()
	ShellExecute("https://github.com/Devil4ngle/Idle_Slayer_Script/releases")
EndFunc   ;==>ButtonGithubClick

Func ButtonInstructionsClick()
	ShellExecute("https://discord.gg/aEaBr77UDn")
EndFunc   ;==>ButtonInstructionsClick


Func NoLockpickingChecked()
	If $NoLockpickingState Then
		$NoLockpickingState = False
		_Resource_SetToCtrlID($NoLockpicking, 'UNCHECKED')
	Else
		$NoLockpickingState = True
		_Resource_SetToCtrlID($NoLockpicking, 'CHECKED')
	EndIf
EndFunc   ;==>NoLockpickingChecked

Func AutoBuyUpgradesChecked()
	If $AutoBuyUpgradeState Then
		$AutoBuyUpgradeState = False
		_Resource_SetToCtrlID($CheckBoxAutoBuyUpgrades, 'UNCHECKED')
	Else
		$AutoBuyUpgradeState = True
		_Resource_SetToCtrlID($CheckBoxAutoBuyUpgrades, 'CHECKED')
	EndIf
EndFunc   ;==>AutoBuyUpgradesChecked

Func CirclePortalsChecked()
	If $CirclePortalsState Then
		$CirclePortalsState = False
		_Resource_SetToCtrlID($CheckBoxCirclePortals, 'UNCHECKED')
	Else
		$CirclePortalsState = True
		_Resource_SetToCtrlID($CheckBoxCirclePortals, 'CHECKED')
	EndIf
EndFunc   ;==>CirclePortalsChecked

Func CraftRagePillChecked()
	If $CraftRagePillState Then
		$CraftRagePillState = False
		_Resource_SetToCtrlID($CheckBoxCraftRagePill, 'UNCHECKED')
	Else
		$CraftRagePillState = True
		_Resource_SetToCtrlID($CheckBoxCraftRagePill, 'CHECKED')
	EndIf
EndFunc   ;==>CraftRagePillChecked

Func CraftSoulBonusChecked()
	If $CraftSoulBonusState Then
		$CraftSoulBonusState = False
		_Resource_SetToCtrlID($CheckBoxCraftSoulBonus, 'UNCHECKED')

	Else
		$CraftSoulBonusState = True
		_Resource_SetToCtrlID($CheckBoxCraftSoulBonus, 'CHECKED')

	EndIf
EndFunc   ;==>CraftSoulBonusChecked

Func UpArrow()
	If ($JumpSliderValue + 10) <= 300 Then
		$JumpSliderValue += 10
		_Resource_SetToCtrlID($JumpNumber, 'NUM' & $JumpSliderValue)
	EndIf
EndFunc   ;==>UpArrow

Func DownArrow()
	If ($JumpSliderValue - 10) >= 0 Then
		$JumpSliderValue -= 10
		_Resource_SetToCtrlID($JumpNumber, 'NUM' & $JumpSliderValue)
	EndIf
EndFunc   ;==>DownArrow

Func SkipBonusStageChecked()
	If $SkipBonusStageState Then
		$SkipBonusStageState = False
		_Resource_SetToCtrlID($CheckBoxSkipBonusStage, 'UNCHECKED')
	Else
		$SkipBonusStageState = True
		_Resource_SetToCtrlID($CheckBoxSkipBonusStage, 'CHECKED')
	EndIf
EndFunc   ;==>SkipBonusStageChecked

Func TabController()
	TabEvent()
EndFunc   ;==>TabController

Func TabEvent()
	; Set values
	Local $iTab_X = 5, $iTab_Y = 5, $iTab_Margin = 1
	; Get index of current tab
	Local $iTab_Index = GUICtrlRead($TabControl)
	; Get coordinates of TabItem
	Local $aTab_Coord = _GUICtrlTab_GetItemRect($TabHandle, $iTab_Index)
	; Get text of TabItem
	Local $sTab_Text = _GUICtrlTab_GetItemText($TabHandle, $iTab_Index)
	; Set focus
	_GUICtrlTab_SetCurFocus($TabHandle, $iTab_Index)
EndFunc   ;==>TabEvent

Func _GUICtrlTab_SetBkColor($hWnd, $hSysTab32, $sBkColor)
	; Get Tab position
	Local $aTabPos = ControlGetPos($hWnd, "", $hSysTab32)
	; Get size of user area
	Local $aTab_Rect = _GUICtrlTab_GetItemRect($hSysTab32, -1)
	; Create label
	GUICtrlCreateLabel("", $aTabPos[0], $aTabPos[1] + $aTab_Rect[3] + 4, $aTabPos[2] - 6, $aTabPos[3] - $aTab_Rect[3] - 7)
	; colour label
	GUICtrlSetBkColor(-1, $sBkColor)
	; Disable label
	GUICtrlSetState(-1, $GUI_DISABLE)
EndFunc   ;==>_GUICtrlTab_SetBkColor

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
		_FileWriteLog($LogPath, "SoulBonus Rage")
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
			Sleep(100)
		EndIf
		If $CraftSoulBonusState Then
			BuyTempItem("0x7D55D8")
		EndIf
	EndIf
	_FileWriteLog($LogPath, "MegaHorde Rage")
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

Func Chesthunt()
	_FileWriteLog($LogPath, "Chesthunt")
	If $NoLockpickingState Then
		Sleep(4000)
	Else
		Sleep(2000)
	EndIf
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
				If $NoLockpickingState Then
					Sleep(1500)
				Else
					Sleep(550)
				EndIf
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
			If $NoLockpickingState Then
				Sleep(1500)
			Else
				Sleep(550)
			EndIf
			; Check if chest hunt ended
			PixelSearch(400, 695, 400, 695, 0xB40000)
			If Not @error Then
				ExitLoop (2)
			EndIf
			; if mimic wait some more
			PixelSearch(434, 211, 434, 211, 0xFF0000)
			If Not @error Then
				If $NoLockpickingState Then
					Sleep(2500)
				Else
					Sleep(1500)
				EndIf
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
	_FileWriteLog($LogPath, "Start of BonusStage")
	Do
		BonusStageSlider()
		Sleep(500)
		PixelSearch(860, 670, 860, 670, 0xAC8371)
	Until @error
	Sleep(3500)
	PixelSearch(443, 97, 443, 97, 0xFFFFFF)
	If $SkipBonusStageState Then
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
	_FileWriteLog($LogPath, "Do noting BonusStage Active")
	Do
		Sleep(200)
	Until BonusStageFail()
EndFunc   ;==>BonusStageDoNoting

Func BonusStageSlider()
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
EndFunc   ;==>BonusStageSlider

Func BonusStageFail()
	PixelSearch(775, 600, 775, 600, 0xB40000, 10)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		_FileWriteLog($LogPath, "BonusStage Failed")
		Return True
	EndIf
	Return False
EndFunc   ;==>BonusStageFail

Func BonusStageNSP()
	_FileWriteLog($LogPath, "BonusStage")
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
	_FileWriteLog($LogPath, "BonusStage Section 1 Complete")
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
	_FileWriteLog($LogPath, "BonusStage Section 2 Complete")
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
	_FileWriteLog($LogPath, "BonusStage Section 3 Complete")
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
	_FileWriteLog($LogPath, "BonusStage Section 4 Complete")
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

Func BonusStageSP()
	_FileWriteLog($LogPath, "BonusStageSB")
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
	_FileWriteLog($LogPath, "BonusStageBS Section 1 Complete")
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
	_FileWriteLog($LogPath, "BonusStageBS Section 2 Complete")
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
	_FileWriteLog($LogPath, "BonusStageBS Section 3 Complete")
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
	_FileWriteLog($LogPath, "BonusStageBS Section 4 Complete")
EndFunc   ;==>BonusStageSP


Func LoadLog()
	Local $section1 = 0, $section2 = 0, $section3 = 0, $section4 = 0, $chesthunt = 0, $failed = 0, _
			$mClaimed = 0, $qClaimed = 0, $section1BS = 0, $section2BS = 0, $section3BS = 0, $section4BS = 0, _
			$silverboxColl = 0, $BS = 0, $BSSP = 0, $megaHordeRage = 0, $megaHordeRageSoul = 0, $rageSoulBonus = 0 ;
	$file = FileOpen($LogPath, 0)
	While 1
		$line = FileReadLine($file)
		If @error = -1 Then ExitLoop
		$line = StringTrimLeft($line, 22)
		Switch $line
			Case "BonusStageBS Section 1 Complete"
				$section1BS += 1
			Case "BonusStageBS Section 2 Complete"
				$section2BS += 1
			Case "BonusStageBS Section 3 Complete"
				$section3BS += 1
			Case "BonusStageBS Section 4 Complete"
				$section4BS += 1
			Case "BonusStage Section 1 Complete"
				$section1 += 1
			Case "BonusStage Section 2 Complete"
				$section2 += 1
			Case "BonusStage Section 3 Complete"
				$section3 += 1
			Case "BonusStage Section 4 Complete"
				$section4 += 1
			Case "Silver Box Collected"
				$silverboxColl += 1
			Case "Minions Collect"
				$mClaimed += 1
			Case "Minions Collect with Daily Bonus"
				$mClaimed += 1
			Case "Chesthunt"
				$chesthunt += 1
			Case "BonusStage Failed"
				$failed += 1
			Case "BonusStage"
				$BS += 1
			Case "BonusStageSB"
				$BSSP += 1
			Case "Claiming quest"
				$qClaimed += 1
			Case "MegaHorde Rage"
				$megaHordeRage += 1
			Case "MegaHorde Rage with SoulBonus"
				$megaHordeRageSoul += 1
			Case "SoulBonus Rage"
				$rageSoulBonus += 1

		EndSwitch
	WEnd
	FileClose($file)
	GUICtrlSetData($Log, "", 0)
	CustomConsole("Rage with only SoulBonus: " & $rageSoulBon us)
	CustomConsole("Rage with only MegaHorde: " & $megaHordeRage - $megaHordeRageSoul)
	CustomConsole("Rage with MegaHorde and SoulBonus: " & $megaHordeRageSoul)
	CustomConsole("Claimed Quest: " & $qClaimed)
	CustomConsole("Claimed Minions: " & $mClaimed)
	CustomConsole("ChestHunts: " & $chesthunt)
	CustomConsole("Failed Bonus Stages: " & $failed)
	CustomConsole("BonusStage (No Spirit Boost): " & $BS)
	CustomConsole("BonusStage (Spirit Boost): " & $BSSP)
	CustomConsole("Section 1 Complete (No Spirit Boost): " & $section1)
	CustomConsole("Section 2 Complete (No Spirit Boost): " & $section2)
	CustomConsole("Section 3 Complete (No Spirit Boost): " & $section3)
	CustomConsole("Section 4 Complete (No Spirit Boost): " & $section4)
	CustomConsole("Section 1 Complete (Spirit Boost): " & $section1BS)
	CustomConsole("Section 2 Complete (Spirit Boost): " & $section2BS)
	CustomConsole("Section 3 Complete (Spirit Boost): " & $section3BS)
	CustomConsole("Section 4 Complete (Spirit Boost): " & $section4BS, True)
EndFunc   ;==>LoadLog

Func CustomConsole($text, $append = False)
	If $append Then
		$text = $text & "	"
	Else
		$text = $text & @CRLF
	EndIf
	GUICtrlSetData($Log, $text, 1)
EndFunc   ;==>CustomConsole
