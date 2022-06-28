#include <GUIConstantsEx.au3>
#include <TabConstants.au3>
#include <GuiTab.au3>
#include "Libraries\ResourcesEx.au3"

Global $AutoBuyUpgradeState = True, $CraftSoulBonusState = True, $SkipBonusStageState = False, _
		$CraftRagePillState = True, $CirclePortalsState = False, $JumpSliderValue = 150, _
		$TogglePause = False, $NoLockpickingState = False, $LogPath = "Log\Idle_Slayer_Log.txt",$CirclePortalsCount = 7

Func _CreateGUI()
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
    Global $TabControl = GUICtrlCreateTab(159, -4, 745, 173, BitOR($TCS_FORCELABELLEFT, $TCS_FIXEDWIDTH, $TCS_BUTTONS))
    GUICtrlSetBkColor(-1, 0x2F3136)
    GUISetOnEvent(-1, "TabEvent")
    Global $TabHandle = GUICtrlGetHandle($TabControl)

    ; Create Home Tab
    Global $TabHome = GUICtrlCreateTabItem("Home")
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
    Global $TabSheet2 = GUICtrlCreateTabItem("General")
    _GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    ; Create CraftRagePill Checkbox
    Global $CheckBoxCraftRagePill = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxCraftRagePill, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "CraftRagePillChecked")
    $Rage = GUICtrlCreatePic('', 207, 45, 132, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($Rage, 'RAGEPILL')
    GUICtrlSetTip(-1, "When Horde/Mega Horde, use Rage Pill When Rage is Down")

    ; Create CraftSoulBonus Checkbox
    Global $CheckBoxCraftSoulBonus = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxCraftSoulBonus, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "CraftSoulBonusChecked")
    $CraftComp = GUICtrlCreatePic('', 207, 84, 153, 14, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CraftComp, 'SOULBONUS')
    GUICtrlSetTip(-1, "When Horde/Mega Horde, use Souls Compass When Rage is Down")

    ; Create AutoBuyUpgrades Checkbox
    Global $CheckBoxAutoBuyUpgrades = GUICtrlCreatePic('', 181, 122, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxAutoBuyUpgrades, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "AutoBuyUpgradesChecked")
    $AutoUpgrade = GUICtrlCreatePic('', 207, 123, 165, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($AutoUpgrade, 'AUTOUPGRADES')
    GUICtrlSetTip(-1, " Buys upgrades every 10 minutes except Vertical Magnet")

    ; Create JumpRate Slider
    $Jslider = GUICtrlCreatePic('', 400, 45, 98, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($Jslider, 'JUMPRATE')

    Global $JumpNumber = GUICtrlCreatePic('', 505, 42, 42, 22, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($JumpNumber, 'NUM150')
    $JumpUp = GUICtrlCreatePic('', 547, 42, 17, 11, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($JumpUp, 'UPARROW')
    GUICtrlSetOnEvent(-1, "UpArrow")
    $JumpDown = GUICtrlCreatePic('', 547, 53, 17, 11, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($JumpDown, 'DOWNARROW')
    GUICtrlSetOnEvent(-1, "DownArrow")

    ; Create CirclePortals Checkbox
    Global $CheckBoxCirclePortals = GUICtrlCreatePic('', 611, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxCirclePortals, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "CirclePortalsChecked")
    $CirclePortals = GUICtrlCreatePic('', 637, 45, 129, 14, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CirclePortals, 'CIRCLEPORTALS')
    GUICtrlSetTip(-1, "Automate portal cycle")

    ; Create Bonus Stage Tab
    Global $TabSheet3 = GUICtrlCreateTabItem("Bonus Stage")
    _GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    Global $CheckBoxSkipBonusStage = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxSkipBonusStage, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "SkipBonusStageChecked")
    $SKIPBS = GUICtrlCreatePic('', 207, 45, 160, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($SKIPBS, 'SKIPBONUS')

    GUICtrlSetTip(-1, "Skips Bonus Stages by letting the timer run out without doing anything")

    ; Create Chesthunt Tab
    Global $TabSheet4 = GUICtrlCreateTabItem("Chest Hunt")
    _GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    Global $NoLockpicking = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($NoLockpicking, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "NoLockpickingChecked")
    $NPL = GUICtrlCreatePic('', 207, 45, 176, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($NPL, 'NOLOCKPICKING')

    ; Create Log Tab
    Global $TabSheet5 = GUICtrlCreateTabItem("TabSheet5")
    _GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

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
    Global $ButtonStartStop = GUICtrlCreatePic('', 1, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonStartStop, 'STOP')
    GUICtrlSetOnEvent(-1, "Pause")

    ; Create Stop Button
    $ButtonExit = GUICtrlCreatePic('', 81, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonExit, 'EXIT')
    GUICtrlSetOnEvent(-1, "IdleClose")

    Return $GUIForm
EndFunc

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
EndFunc   ;==>ButtonLogClick

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