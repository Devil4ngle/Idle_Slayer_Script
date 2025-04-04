#include-once
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <TabConstants.au3>
#include <StaticConstants.au3>
#include <GuiTab.au3>
#include <EditConstants.au3>
#include <AutoItConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <WinAPISysWin.au3>
#include "ResourcesEx.au3"
#include "Log.au3"
#include "AutoThreadV3.au3"
#include <Inet.au3>


Global $bAutoBuyUpgradeState = False, _
		$bCraftSoulBonusState = False, _
		$bSkipBonusStageState = False, _
		$bCraftRagePillState = False, _
		$bCirclePortalsState = False, _
		$bNoLockpickingState = True, _
		$bNoReinforcedCrystalSaverState = False, _
		$bBiDimensionalState = False, _
		$bDimensionalState = False, _
		$bDisableRageState = False, _
		$bAutoAscendState = False, _
		$bPerfectChestHuntState = False, _
		$bTogglePause = False

Global $sVersion = "3.4.7"
Global $iJumpSliderValue = 150, _
		$iCirclePortalsCount = 7, _
		$iAutoAscendTimer = 10, _
		$iAutoBuyTimer = 10, _
		$iAutoBuyTempTimer = 10, _
		$iTimerAutoBuy = TimerInit(), _
		$iTimerAutoAscend = TimerInit(), _
		$iTimerFocusGame = TimerInit(), _
		$iLastCheckTimeLoop = TimerInit()
Global $aSettingGlobalVariables[16] = ["iAutoBuyTimer", "iAutoAscendTimer", "bAutoAscendState", "bAutoBuyUpgradeState", "bCraftSoulBonusState", "bSkipBonusStageState", "bCraftRagePillState", "bCirclePortalsState", "iJumpSliderValue", "bNoLockpickingState", "iCirclePortalsCount", "bDimensionalState", "bBiDimensionalState", "bDisableRageState", "bNoReinforcedCrystalSaverState", "bPerfectChestHuntState"]
Global $aSettingCheckBoxes[12] = ["bAutoAscendState", "bAutoBuyUpgradeState", "bCraftSoulBonusState", "bSkipBonusStageState", "bCraftRagePillState", "bCirclePortalsState", "bNoLockpickingState", "bBiDimensionalState", "bDimensionalState", "bDisableRageState", "bNoReinforcedCrystalSaverState", "bPerfectChestHuntState"]

; #FUNCTION# ====================================================================================================================
; Return values .: Succes - A windows handle
;                  Failure - 0 if the window cannot be created and sets the @error flag to 1.
; ===============================================================================================================================
Func CreateGUI()
	; Create GUI
	Global $hGUIForm = GUICreate("Idle Runner", 898, 164, @DesktopWidth / 2 - 500, @DesktopHeight - 250, $WS_BORDER + $WS_POPUP)
	GUISetBkColor(0x202225)

	; Titlebar
	GUICtrlCreateLabel("", -1, -1, 898, 22, -1, $GUI_WS_EX_PARENTDRAG)
	GUICtrlCreateLabel("        Idle Runner v" & $sVersion, -1, -1, 900, 22, $SS_CENTERIMAGE)
	GUICtrlSetColor(-1, 0xFFFFFF)
	Local $iIcon = GUICtrlCreatePicCustom('Resources\Icon.jpg', 2, 2, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iIcon, 'ICON')

	; Create iTabControl
	Global $iTabControl = GUICtrlCreateTab(159, -4, 745, 173, BitOR($TCS_FORCELABELLEFT, $TCS_FIXEDWIDTH, $TCS_BUTTONS))
	GUICtrlSetBkColor(-1, 0x2F3136)
	GUISetOnEvent(-1, "EventTabFocus")
	Global $hTabHandle = GUICtrlGetHandle($iTabControl)

	; Create Tabs
	Global $iTabHome = CreateWelcomeSheet($hGUIForm, $iTabControl)
	Global $iTabGeneral = CreateGeneralSheet($hGUIForm, $iTabControl)
	Global $iTabMinigames = CreateMinigamesSheet($hGUIForm, $iTabControl)
	Global $iTabCrafting = CreateCraftingSheet($hGUIForm, $iTabControl)
	Global $iTabLog = CreateLogSheet($hGUIForm, $iTabControl)

	; Set Tab Focus Home
	GUICtrlSetState($iTabHome, $GUI_SHOW)
	GUICtrlCreateTabItem("")

	; Create Home Button
	Local $iButtonHome = GUICtrlCreatePicCustom('Resources\Home.jpg', 1, 20, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonHome, 'HOME')
	GUICtrlSetOnEvent(-1, "EventButtonHomeClick")

	; Create General Button
	Local $iButtonGeneral = GUICtrlCreatePicCustom('Resources\General.jpg', 1, 44, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonGeneral, 'GENERAL')
	GUICtrlSetOnEvent(-1, "EventButtonGeneralClick")

	; Create Bonus Stage Button
	Local $iButtonBonusStage = GUICtrlCreatePicCustom('Resources\Minigames.jpg', 1, 68, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonBonusStage, 'MINIGAMES')
	GUICtrlSetOnEvent(-1, "EventButtonMinigamesClick")

	; Create Chesthunt Button
	Local $iButtonChestHunt = GUICtrlCreatePicCustom('Resources\Crafting.jpg', 1, 92, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonChestHunt, 'CRAFTING')
	GUICtrlSetOnEvent(-1, "EventButtonCraftingClick")

	; Create Log Button
	Local $iButtonLog = GUICtrlCreatePicCustom('Resources\Log.jpg', 1, 116, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonLog, 'LOG')
	GUICtrlSetOnEvent(-1, "EventButtonLogClick")

	Local $iLogContextMenu = GUICtrlCreateContextMenu($iButtonLog)
	GUICtrlCreateMenuItem("Clear Logs", $iLogContextMenu)
	GUICtrlSetOnEvent(-1, "EventMenuClearLogsClick")

	; Create Start / Pause Button
	Global $iButtonStartStop = GUICtrlCreatePicCustom('Resources\Stop.jpg', 1, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonStartStop, 'STOP')
	GUICtrlSetOnEvent(-1, "Pause")

	; Create Exit Button
	Local $iButtonExit = GUICtrlCreatePicCustom('Resources\Exit.jpg', 81, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonExit, 'EXIT')
	GUICtrlSetOnEvent(-1, "IdleClose")
	Return $hGUIForm
EndFunc   ;==>CreateGUI


Func CreateWelcomeSheet($hGUIForm, $iTabControl)
	Local $iTabHome = GUICtrlCreateTabItem("Home")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	Local $iWelcome = GUICtrlCreatePicCustom('Resources\Welcome.jpg', 186, 36, 436, 29, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iWelcome, 'WELCOME')

	Local $iButtonGithub = GUICtrlCreatePicCustom('Resources\Github.jpg', 190, 95, 160, 50, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iButtonGithub, 'GITHUB')
	GUICtrlSetOnEvent(-1, "EventButtonGithubClick")

	Local $iButtonInstructions = GUICtrlCreatePicCustom('Resources\Instructions.jpg', 370, 95, 214, 50, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iButtonInstructions, 'INSTRUCTION')
	GUICtrlSetOnEvent(-1, "EventButtonInstructionsClick")

	Local $iButtonUpdate = GUICtrlCreatePicCustom('Resources\Update.jpg', 604, 95, 160, 50, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iButtonUpdate, 'UPDATE')
	GUICtrlSetOnEvent(-1, "EventButtonUpdateClick")

	Return $iTabHome
EndFunc   ;==>CreateWelcomeSheet

Func CreateGeneralSheet($hGUIForm, $iTabControl)
	Local $iTabGeneral = GUICtrlCreateTabItem("General")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	; Create CirclePortals Checkbox
	Global $iCheckBoxbCirclePortalsState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCirclePortals = GUICtrlCreatePicCustom('Resources\CirclePortals.jpg', 207, 84, 129, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCirclePortals, 'CIRCLEPORTALS')
	GUICtrlSetTip(-1, "Cycles Portals as soon the portal is ready")

	; Create Disable Rage Horde Checkbox
	Global $iCheckBoxbDisableRageState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 122, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iDisableRage = GUICtrlCreatePicCustom('Resources\DisableRage.jpg', 207, 122, 183, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iDisableRage, 'DISABLERAGE')
	GUICtrlSetTip(-1, "When Checked will not rage at Megahordes without soulbonus")

	; Create JumpRate Slider
	Local $iJumpSlider = GUICtrlCreatePicCustom('Resources\JumpRate.jpg', 181, 45, 98, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpSlider, 'JUMPRATE')

	Global $iJumpNumber = GUICtrlCreatePicCustom('Resources\150.jpg', 289, 42, 42, 22, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpNumber, 'NUM150')
	Local $iJumpUp = GUICtrlCreatePicCustom('Resources\UpArrow.jpg', 331, 42, 17, 11, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpUp, 'UPARROW')
	GUICtrlSetOnEvent(-1, "EventUpArrow")
	Local $iJumpDown = GUICtrlCreatePicCustom('Resources\DownArrow.jpg', 331, 53, 17, 11, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpDown, 'DOWNARROW')
	GUICtrlSetOnEvent(-1, "EventDownArrow")

	; Create AutoBuyUpgrades Checkbox
	Global $iCheckBoxbAutoBuyUpgradeState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 380, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iAutoUpgrade = GUICtrlCreatePicCustom('Resources\AutoBuyUpgrades.jpg', 400, 45, 165, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iAutoUpgrade, 'AUTOUPGRADES')
	GUICtrlSetTip(-1, "Buys upgrades except Vertical Magnet and Electric Worms. It will start after 10 sec you actived it and after the set number is in minutes")
	Global $iAutoBuyNumber = GUICtrlCreateInput($iAutoBuyTimer, 575, 45, 50, 20, $ES_NUMBER)
	GUICtrlSetOnEvent(-1, "EventAutoBuyTimer")
	GUICtrlSetTip(-1, "Buys Upgrades after a certain amount of time. The number is in minutes")

	; Create Auto Ascend
	Global $iCheckBoxbAutoAscendState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 380, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iAutoAscend = GUICtrlCreatePicCustom('Resources\AutoAscend.jpg', 400, 83, 98, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iAutoAscend, 'AUTOASCEND')
	GUICtrlSetTip(-1, "Auto Ascend after a certain amount of time. The number is in minutes")
	Global $iAutoAscendNumber = GUICtrlCreateInput($iAutoAscendTimer, 510, 83, 50, 20, $ES_NUMBER)
	GUICtrlSetOnEvent(-1, "EventAutoAscendTimer")
	GUICtrlSetTip(-1, "Auto Ascend after a certain amount of time. The number is in minutes")

	Return $iTabGeneral
EndFunc   ;==>CreateGeneralSheet


Func CreateMinigamesSheet($hGUIForm, $iTabControl)
	Local $iTabMinigames = GUICtrlCreateTabItem("Minigames")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	Global $iCheckBoxbSkipBonusStageState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iSkipBonus = GUICtrlCreatePicCustom('Resources\SkipBonusStage.jpg', 207, 45, 160, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iSkipBonus, 'SKIPBONUS')
	GUICtrlSetTip(-1, "Skips Bonus Stages by letting the timer run out without doing anything")

	Global $iCheckBoxbNoLockpickingState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iNoLockpicking = GUICtrlCreatePicCustom('Resources\NoLockpicking.jpg', 207, 84, 176, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iNoLockpicking, 'NOLOCKPICKING')
	GUICtrlSetTip(-1, "Determines if you have the Divinity Lockpicking 100.")

	Global $iCheckBoxbNoReinforcedCrystalSaverState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 122, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iNoReinforcedCrystalSaver = GUICtrlCreatePicCustom('Resources\NoReinforcedCrystalSaver.jpg', 207, 123, 241, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iNoReinforcedCrystalSaver, 'NOREINFORCEDCRYSTALSAVER')
	GUICtrlSetTip(-1, "Determines if you have unlocked the Permanent Item Reinforced Crystal Saver.")

	Global $iCheckBoxbPerfectChestHuntState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 480, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iPerfectChestHunt = GUICtrlCreatePicCustom('Resources\PerfectChestHunt.jpg', 506, 44, 183, 18, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iPerfectChestHunt, 'PERFECTCHESTHUNT')
	GUICtrlSetTip(-1, "Uses a riskier strategy that prioritizes Perfect Chest Hunts over resources. Strategy summary: ignores Life Saver until 2x is found. The 2x2x Dark Divinity must be turned off.")

	Return $iTabMinigames
EndFunc   ;==>CreateMinigamesSheet


Func CreateCraftingSheet($hGUIForm, $iTabControl)
	Local $iTabCrafting = GUICtrlCreateTabItem("Crafting")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	; Create CraftSoulBonus Checkbox
	Global $iCheckBoxbCraftSoulBonusState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCraftComp = GUICtrlCreatePicCustom('Resources\CraftSoulBonus.jpg', 207, 45, 153, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCraftComp, 'SOULBONUS')
	GUICtrlSetTip(-1, "When there is a Horde/Mega Horde + Soul Bonus, it will craft Souls Compass")

	; Craft Bidmensional Stuff
	Global $iCheckBoxbBiDimensionalState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCraftBiDimension = GUICtrlCreatePicCustom('Resources\CraftBidimensionalStaff.jpg', 207, 84, 239, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCraftBiDimension, 'BIDIMENSIONAL')
	GUICtrlSetTip(-1, "Craft BiDimensional item at Megahorde and it will disable it itself after one use")

	; Craft Dimensional Stuff
	Global $iCheckBoxbDimensionalState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 181, 124, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCraftDimension = GUICtrlCreatePicCustom('Resources\CraftDimensionalStaff.jpg', 207, 124, 221, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCraftDimension, 'DIMENSIONAL')
	GUICtrlSetTip(-1, "Craft Dimensional item at Megahorde and it will disable it itself after one use")

	; Create CraftRagePill Checkbox
	Global $iCheckBoxbCraftRagePillState = GUICtrlCreatePicCustom('Resources\CheckboxUnchecked.jpg', 450, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iRage = GUICtrlCreatePicCustom('Resources\CraftRagePill.jpg', 476, 45, 132, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iRage, 'RAGEPILL')
	GUICtrlSetTip(-1, "When there is Horde/Mega Horde + Soul Bonus, it will craft Rage Pill")

	Return $iTabCrafting
EndFunc   ;==>CreateCraftingSheet


Func CreateLogSheet($hGUIForm, $iTabControl)
	Local $iTabLog = GUICtrlCreateTabItem("Log")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	; Log logs
	Global $iLog = GUICtrlCreateEdit("", 175, 32, 340, 120, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL, $ES_READONLY))
	GUICtrlSetBkColor($iLog, 0x000000)
	GUICtrlSetColor($iLog, 0x4CFF00)

	; Log data
	Global $iLogData = GUICtrlCreateEdit("", 540, 32, 340, 120, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL, $ES_READONLY))
	GUICtrlSetBkColor($iLogData, 0x000000)
	GUICtrlSetColor($iLogData, 0xFFBB00)

	Return $iTabLog
EndFunc   ;==>CreateLogSheet


#Region GUI.au3 - #EVENTS#
Func EventButtonHomeClick()
	GUICtrlSetState($iTabHome, $GUI_SHOW)
EndFunc   ;==>EventButtonHomeClick

Func EventButtonGeneralClick()
	GUICtrlSetState($iTabGeneral, $GUI_SHOW)
EndFunc   ;==>EventButtonGeneralClick

Func EventButtonMinigamesClick()
	GUICtrlSetState($iTabMinigames, $GUI_SHOW)
EndFunc   ;==>EventButtonMinigamesClick

Func EventButtonCraftingClick()
	GUICtrlSetState($iTabCrafting, $GUI_SHOW)
EndFunc   ;==>EventButtonCraftingClick

Func EventButtonLogClick()
	GUICtrlSetState($iTabLog, $GUI_SHOW)
	LoadLog($iLog)
	LoadDataLog($iLogData)
EndFunc   ;==>EventButtonLogClick

Func EventMenuClearLogsClick()
	if FileExists("IdleRunnerLogs\Logs.txt") Then FileDelete("IdleRunnerLogs\Logs.txt")
	LoadLog($iLog)
EndFunc   ;==>EventMenuClearLogsClick

Func EventTabFocus()
	Local $iTabIndex = GUICtrlRead($iTabControl)
	_GUICtrlTab_SetCurFocus($hTabHandle, $iTabIndex)
EndFunc   ;==>EventTabFocus

Func EventButtonGithubClick()
	ShellExecute("https://github.com/Devil4ngle/Idle_Slayer_Script/releases")
EndFunc   ;==>EventButtonGithubClick

Func EventButtonInstructionsClick()
	ShellExecute("https://discord.gg/aEaBr77UDn")
EndFunc   ;==>EventButtonInstructionsClick

Func EventTabSetBkColor($hWnd, $hSysTab32, $sBkColor)
	; Get Tab position
	Local $aTabPos = ControlGetPos($hWnd, "", $hSysTab32)
	; Get size of user area
	Local $aTabRect = _GUICtrlTab_GetItemRect($hSysTab32, -1)
	; Create label
	GUICtrlCreateLabel("", $aTabPos[0], $aTabPos[1] + $aTabRect[3] + 4, $aTabPos[2] - 6, $aTabPos[3] - $aTabRect[3] - 7)
	; colour label
	GUICtrlSetBkColor(-1, $sBkColor)
	; Disable label
	GUICtrlSetState(-1, $GUI_DISABLE)
EndFunc   ;==>EventTabSetBkColor

Func EventAutoAscendTimer()
	$iAutoAscendTimer = GUICtrlRead($iAutoAscendNumber)
	If $iAutoAscendTimer == 0 Or $iAutoAscendTimer == "" Then
		$iAutoAscendTimer = 1
		GUICtrlSetData($iAutoAscendNumber, 1)
	EndIf
	SaveSettings()
EndFunc   ;==>EventAutoAscendTimer

Func EventAutoBuyTimer()
	$iAutoBuyTimer = GUICtrlRead($iAutoBuyNumber)
	If $iAutoBuyTimer == 0 Or $iAutoBuyTimer == "" Then
		$iAutoBuyTimer = 1
		GUICtrlSetData($iAutoBuyNumber, 1)
	EndIf
	$iAutoBuyTempTimer = $iAutoBuyTimer
	SaveSettings()
EndFunc   ;==>EventAutoBuyTimer

Func EventUpArrow()
	If ($iJumpSliderValue + 10) <= 300 Then
		$iJumpSliderValue += 10
		If Not @Compiled Then
			GUICtrlSetImage($iJumpNumber, 'Resources\' & $iJumpSliderValue & '.jpg')
		Else
			_Resource_SetToCtrlID($iJumpNumber, 'NUM' & $iJumpSliderValue)
		EndIf
	EndIf
	SaveSettings()
	SyncProcess()
EndFunc   ;==>EventUpArrow

Func EventDownArrow()
	If ($iJumpSliderValue - 10) >= 0 Then
		$iJumpSliderValue -= 10
		If Not @Compiled Then
			GUICtrlSetImage($iJumpNumber, 'Resources\' & $iJumpSliderValue & '.jpg')
		Else
			_Resource_SetToCtrlID($iJumpNumber, 'NUM' & $iJumpSliderValue)
		EndIf
	EndIf
	SaveSettings()
	SyncProcess()
EndFunc   ;==>EventDownArrow

Func EventGlobalCheckBox()
	SetChechBox(@GUI_CtrlId)
	If $iCheckBoxbAutoBuyUpgradeState == @GUI_CtrlId Then
		$iAutoBuyTempTimer = 0.15
		$iTimerAutoBuy = TimerInit()
	EndIf
EndFunc   ;==>EventGlobalCheckBox

Func IdleClose()
	Exit
EndFunc   ;==>IdleClose

Func Pause()
	$bTogglePause = Not $bTogglePause
	If $bTogglePause Then
		ControlFocus("Idle Slayer", "", "")
		If Not @Compiled Then
			GUICtrlSetImage($iButtonStartStop, 'Resources\Start.jpg')
		Else
			_Resource_SetToCtrlID($iButtonStartStop, 'START')
		EndIf
		SyncProcess(False)
	Else
		ControlFocus("Idle Slayer", "", "")
		If Not @Compiled Then
			GUICtrlSetImage($iButtonStartStop, 'Resources\Stop.jpg')
		Else
			_Resource_SetToCtrlID($iButtonStartStop, 'STOP')
		EndIf
		SyncProcess()
	EndIf
EndFunc   ;==>Pause

#EndRegion GUI.au3 - #EVENTS#
Func SetChechBox($iId)
	Local $sName
	For $sElement In $aSettingCheckBoxes
		If Eval("iCheckBox" & $sElement) == $iId Then
			$sName = $sElement
			ExitLoop
		EndIf
	Next
	If Eval($sName) Then
		Assign($sName, False, 4)
		If Not @Compiled Then
			GUICtrlSetImage($iId, 'Resources\CheckboxUnchecked.jpg')
		Else
			_Resource_SetToCtrlID($iId, 'UNCHECKED')
		EndIf
	Else
		Assign($sName, True, 4)
		If Not @Compiled Then
			GUICtrlSetImage($iId, 'Resources\CheckboxChecked.jpg')
		Else
			_Resource_SetToCtrlID($iId, 'CHECKED')
		EndIf
	EndIf
	SaveSettings()
EndFunc   ;==>SetChechBox

Func SaveSettings()
	For $sElement In $aSettingGlobalVariables ; $vElement will contain the value of the elements in the $aArray... one element at a time.
		IniWrite("IdleRunnerLogs\Settings.txt", "Settings", $sElement, Eval($sElement))
	Next
EndFunc   ;==>SaveSettings

Func LoadSettings()
	For $sElement In $aSettingGlobalVariables ; $vElement will contain the value of the elements in the $aArray... one element at a time.
		Local $sRead = IniRead("IdleRunnerLogs\Settings.txt", "Settings", $sElement, Eval($sElement))
		If IsInt(Eval($sElement)) Then
			$sRead = Number($sRead)
		EndIf
		If $sRead == "True" Then
			$sRead = True
		EndIf
		If $sRead == "False" Then
			$sRead = False
		EndIf
		Assign($sElement, $sRead, 4)
	Next

	; Refresh The checked
	For $sElement In $aSettingCheckBoxes
		If Eval($sElement) == True Then
			If Not @Compiled Then
				GUICtrlSetImage(Eval("iCheckBox" & $sElement), 'Resources\CheckboxChecked.jpg')
			Else
				_Resource_SetToCtrlID(Eval("iCheckBox" & $sElement), 'CHECKED')
			EndIf
		Else
			If Not @Compiled Then
				GUICtrlSetImage(Eval("iCheckBox" & $sElement), 'Resources\CheckboxUnchecked.jpg')
			Else
				_Resource_SetToCtrlID(Eval("iCheckBox" & $sElement), 'UNCHECKED')
			EndIf
		EndIf
	Next
	If Not @Compiled Then
		GUICtrlSetImage($iJumpNumber, 'Resources\' & $iJumpSliderValue & '.jpg')
	Else
		_Resource_SetToCtrlID($iJumpNumber, 'NUM' & $iJumpSliderValue)
	EndIf
	GUICtrlSetData($iAutoAscendNumber, $iAutoAscendTimer)
	GUICtrlSetData($iAutoBuyNumber, $iAutoBuyTimer)
	$iAutoBuyTempTimer = $iAutoBuyTimer
EndFunc   ;==>LoadSettings

Func EventButtonUpdateClick()
	Local $dData = InetRead("https://api.github.com/repos/Devil4ngle/Idle_Slayer_Script/releases/latest", 1)
	$sJsonData = BinaryToString($dData)
	If @error Then
		MsgBox($MB_OK, "Error", "Failed to retrieve release information.")
		Return False
	EndIf

	Local $iTagIndex = StringInStr($sJsonData, '"tag_name"') + StringLen('"tag_name"') + 2
	Local $sLatestTag = StringMid($sJsonData, $iTagIndex, 5)

	If $sLatestTag = $sVersion Then
		MsgBox($MB_OK, "Latest Version", "The script is up-to-date.")
	Else
		$iRes = MsgBox($MB_OKCANCEL, "Update Available", "Go on Github and Download.")
		If $iRes == $IDOK Then
			ShellExecute("https://github.com/Devil4ngle/Idle_Slayer_Script/releases")
		EndIf
	EndIf
EndFunc   ;==>EventButtonUpdateClick

Func SyncProcess($bJumpState = True)
	If $bTogglePause == True Then
		$bJumpState = False
	EndIf
	; Convert variables to strings
	$sJumpSliderValue = String($iJumpSliderValue)
	$sJumpState = String($bJumpState)
	; Send variables as a message
	_AuThread_SendMsg("JumpSliderValue:" & $sJumpSliderValue & ";JumpState:" & $sJumpState)
EndFunc   ;==>SyncProcess

Func GUICtrlCreatePicCustom($sFileName, $iLeft, $iTop, $iWidth, $iHeight, $hStyle)
	If Not @Compiled Then
		Return GUICtrlCreatePic($sFileName, $iLeft, $iTop, $iWidth, $iHeight, $hStyle)
	Else
		Return GUICtrlCreatePic('', $iLeft, $iTop, $iWidth, $iHeight, $hStyle)
	EndIf
EndFunc   ;==>GUICtrlCreatePicCustom
