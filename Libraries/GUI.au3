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
#include "mp.au3"
#include <Inet.au3>


Global $bAutoBuyUpgradeState = False, _
		$bCraftSoulBonusState = False, _
		$bSkipBonusStageState = False, _
		$bCraftRagePillState = False, _
		$bCirclePortalsState = False, _
		$bNoLockpickingState = False, _
		$bBiDimensionalState = False, _
		$bDimensionalState = False, _
		$bDisableRageState = False, _
		$bAutoAscendState = False, _
		$bTogglePause = False

Global $sVersion = "3.2.8"
Global $oData
Global $iJumpSliderValue = 150, _
		$iCirclePortalsCount = 7, _
		$iAutoAscendTimer = 10, _
		$iCooldownAutoUpgrades = 600000, _
		$iTimerAutoBuy = TimerInit(), _
		$iTimerAutoAscend = TimerInit(), _
		$iTimerFocusGame = TimerInit()

Global $aSettingGlobalVariables[13] = ["iAutoAscendTimer", "bAutoAscendState", "bAutoBuyUpgradeState", "bCraftSoulBonusState", "bSkipBonusStageState", "bCraftRagePillState", "bCirclePortalsState", "iJumpSliderValue", "bNoLockpickingState", "iCirclePortalsCount", "bDimensionalState", "bBiDimensionalState", "bDisableRageState"]
Global $aSettingCheckBoxes[10] = ["bAutoAscendState", "bAutoBuyUpgradeState", "bCraftSoulBonusState", "bSkipBonusStageState", "bCraftRagePillState", "bCirclePortalsState", "bNoLockpickingState", "bBiDimensionalState", "bDimensionalState", "bDisableRageState"]

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
	Local $iIcon = GUICtrlCreatePic('', 2, 2, 16, 16, $SS_BITMAP + $SS_NOTIFY)
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
	Local $iButtonHome = GUICtrlCreatePic('', 1, 20, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonHome, 'HOME')
	GUICtrlSetOnEvent(-1, "EventButtonHomeClick")

	; Create General Button
	Local $iButtonGeneral = GUICtrlCreatePic('', 1, 44, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonGeneral, 'GENERAL')
	GUICtrlSetOnEvent(-1, "EventButtonGeneralClick")

	; Create Bonus Stage Button
	Local $iButtonBonusStage = GUICtrlCreatePic('', 1, 68, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonBonusStage, 'MINIGAMES')
	GUICtrlSetOnEvent(-1, "EventButtonMinigamesClick")

	; Create Chesthunt Button
	Local $iButtonChestHunt = GUICtrlCreatePic('', 1, 92, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonChestHunt, 'CRAFTING')
	GUICtrlSetOnEvent(-1, "EventButtonCraftingClick")

	; Create Log Button
	Local $iButtonLog = GUICtrlCreatePic('', 1, 116, 160, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonLog, 'LOG')
	GUICtrlSetOnEvent(-1, "EventButtonLogClick")

	; Create Start / Pause Button
	Global $iButtonStartStop = GUICtrlCreatePic('', 1, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonStartStop, 'STOP')
	GUICtrlSetOnEvent(-1, "Pause")

	; Create Exit Button
	Local $iButtonExit = GUICtrlCreatePic('', 81, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
	_Resource_SetToCtrlID($iButtonExit, 'EXIT')
	GUICtrlSetOnEvent(-1, "IdleClose")
	Return $hGUIForm
EndFunc   ;==>CreateGUI


Func CreateWelcomeSheet($hGUIForm, $iTabControl)
	Local $iTabHome = GUICtrlCreateTabItem("Home")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	Local $iWelcome = GUICtrlCreatePic('', 186, 36, 436, 29, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iWelcome, 'WELCOME')

	Local $iButtonGithub = GUICtrlCreatePic('', 190, 95, 160, 50, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iButtonGithub, 'GITHUB')
	GUICtrlSetOnEvent(-1, "EventButtonGithubClick")

	Local $iButtonInstructions = GUICtrlCreatePic('', 370, 95, 214, 50, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iButtonInstructions, 'INSTRUCTION')
	GUICtrlSetOnEvent(-1, "EventButtonInstructionsClick")

	Local $iButtonUpdate = GUICtrlCreatePic('', 604, 95, 160, 50, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iButtonUpdate, 'UPDATE')
	GUICtrlSetOnEvent(-1, "EventButtonUpdateClick")

	Return $iTabHome
EndFunc   ;==>CreateWelcomeSheet


Func CreateGeneralSheet($hGUIForm, $iTabControl)
	Local $iTabGeneral = GUICtrlCreateTabItem("General")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	; Create AutoBuyUpgrades Checkbox
	Global $iCheckBoxbAutoBuyUpgradeState = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iAutoUpgrade = GUICtrlCreatePic('', 207, 45, 165, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iAutoUpgrade, 'AUTOUPGRADES')
	GUICtrlSetTip(-1, "Buys upgrades except Vertical Magnet and Electric Worms. It will start after 10 sec you actived it and after that every 10 min")

	; Create CirclePortals Checkbox
	Global $iCheckBoxbCirclePortalsState = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCirclePortals = GUICtrlCreatePic('', 207, 84, 129, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCirclePortals, 'CIRCLEPORTALS')
	GUICtrlSetTip(-1, "Cycles Portals as soon the portal is ready")

	; Create Disable Rage Horde Checkbox
	Global $iCheckBoxbDisableRageState = GUICtrlCreatePic('', 181, 122, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iDisableRage = GUICtrlCreatePic('', 207, 122, 183, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iDisableRage, 'DISABLERAGE')
	GUICtrlSetTip(-1, "When Checked will not rage at Megahordes without soulbonus")

	; Create JumpRate Slider
	Local $iJumpSlider = GUICtrlCreatePic('', 400, 45, 98, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpSlider, 'JUMPRATE')

	Global $iJumpNumber = GUICtrlCreatePic('', 505, 42, 42, 22, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpNumber, 'NUM150')
	Local $iJumpUp = GUICtrlCreatePic('', 547, 42, 17, 11, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpUp, 'UPARROW')
	GUICtrlSetOnEvent(-1, "EventUpArrow")
	Local $iJumpDown = GUICtrlCreatePic('', 547, 53, 17, 11, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iJumpDown, 'DOWNARROW')
	GUICtrlSetOnEvent(-1, "EventDownArrow")

	; Create Auto Ascend
	Global $iCheckBoxbAutoAscendState = GUICtrlCreatePic('', 380, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iAutoAscend = GUICtrlCreatePic('', 400, 83, 98, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iAutoAscend, 'AUTOASCEND')
	GUICtrlSetTip(-1, "Auto Ascend after a certain amount of time. The number is in minutes")
	Global $iAutoAscendNumber = GUICtrlCreateInput($iAutoAscendTimer, 510, 83, 50, 20, $ES_NUMBER)
	GUICtrlSetOnEvent(-1, "EventAutoAscendTimer")
	Return $iTabGeneral
EndFunc   ;==>CreateGeneralSheet


Func CreateMinigamesSheet($hGUIForm, $iTabControl)
	Local $iTabMinigames = GUICtrlCreateTabItem("Minigames")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	Global $iCheckBoxbSkipBonusStageState = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iSkipBonus = GUICtrlCreatePic('', 207, 45, 160, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iSkipBonus, 'SKIPBONUS')
	GUICtrlSetTip(-1, "Skips Bonus Stages by letting the timer run out without doing anything")

	Global $iCheckBoxbNoLockpickingState = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iNoLockpicking = GUICtrlCreatePic('', 207, 84, 176, 16, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iNoLockpicking, 'NOLOCKPICKING')
	GUICtrlSetTip(-1, "Determines if you have the Divinity Lockpicking 100.")

	Return $iTabMinigames
EndFunc   ;==>CreateMinigamesSheet


Func CreateCraftingSheet($hGUIForm, $iTabControl)
	Local $iTabCrafting = GUICtrlCreateTabItem("Crafting")
	EventTabSetBkColor($hGUIForm, $iTabControl, 0x36393F)

	; Create CraftSoulBonus Checkbox
	Global $iCheckBoxbCraftSoulBonusState = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCraftComp = GUICtrlCreatePic('', 207, 45, 153, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCraftComp, 'SOULBONUS')
	GUICtrlSetTip(-1, "When there is a Horde/Mega Horde + Soul Bonus, it will craft Souls Compass")

	; Craft Bidmensional Stuff
	Global $iCheckBoxbBiDimensionalState = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCraftBiDimension = GUICtrlCreatePic('', 207, 84, 239, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCraftBiDimension, 'BIDIMENSIONAL')
	GUICtrlSetTip(-1, "Craft BiDimensional item at Megahorde and it will disable it itself after one use")

	; Craft Dimensional Stuff
	Global $iCheckBoxbDimensionalState = GUICtrlCreatePic('', 181, 124, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iCraftDimension = GUICtrlCreatePic('', 207, 124, 221, 14, $SS_BITMAP + $SS_NOTIFY)
	_Resource_SetToCtrlID($iCraftDimension, 'DIMENSIONAL')
	GUICtrlSetTip(-1, "Craft Dimensional item at Megahorde and it will disable it itself after one use")

	; Create CraftRagePill Checkbox
	Global $iCheckBoxbCraftRagePillState = GUICtrlCreatePic('', 450, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
	GUICtrlSetOnEvent(-1, "EventGlobalCheckBox")
	Local $iRage = GUICtrlCreatePic('', 476, 45, 132, 16, $SS_BITMAP + $SS_NOTIFY)
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
	SaveSettings()
EndFunc   ;==>EventAutoAscendTimer

Func EventUpArrow()
	If ($iJumpSliderValue + 10) <= 300 Then
		$iJumpSliderValue += 10
		_Resource_SetToCtrlID($iJumpNumber, 'NUM' & $iJumpSliderValue)
	EndIf
	SaveSettings()
	$oData.jumprate = $iJumpSliderValue
EndFunc   ;==>EventUpArrow

Func EventDownArrow()
	If ($iJumpSliderValue - 10) >= 0 Then
		$iJumpSliderValue -= 10
		_Resource_SetToCtrlID($iJumpNumber, 'NUM' & $iJumpSliderValue)
	EndIf
	SaveSettings()
	$oData.jumprate = $iJumpSliderValue
EndFunc   ;==>EventDownArrow

Func EventGlobalCheckBox()
	If $iCheckBoxbAutoBuyUpgradeState == @GUI_CtrlId Then
		$iCooldownAutoUpgrades = 10000
		$iTimerAutoBuy = TimerInit()
	EndIf
	SetChechBox(@GUI_CtrlId)
EndFunc   ;==>EventGlobalCheckBox

Func IdleClose()
	$oData.exitScript = 1
	Sleep(500)
	Exit
EndFunc   ;==>IdleClose

Func Pause()
	$bTogglePause = Not $bTogglePause
	If $bTogglePause Then
		ControlFocus("Idle Slayer", "", "")
		_Resource_SetToCtrlID($iButtonStartStop, 'START')
		$oData.start = 0
	Else
		ControlFocus("Idle Slayer", "", "")
		_Resource_SetToCtrlID($iButtonStartStop, 'STOP')
		$oData.start = 1
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
		_Resource_SetToCtrlID($iId, 'UNCHECKED')
	Else
		Assign($sName, True, 4)
		_Resource_SetToCtrlID($iId, 'CHECKED')
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
			_Resource_SetToCtrlID(Eval("iCheckBox" & $sElement), 'CHECKED')
		Else
			_Resource_SetToCtrlID(Eval("iCheckBox" & $sElement), 'UNCHECKED')
		EndIf
	Next
	_Resource_SetToCtrlID($iJumpNumber, 'NUM' & $iJumpSliderValue)
	GUICtrlSetData($iAutoAscendNumber, $iAutoAscendTimer)

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
		ShellExecute("powershell.exe", "-File ""IdleRunnerLogs\update.ps1""", "", "", @SW_HIDE)
		IdleClose()
	EndIf
EndFunc   ;==>EventButtonUpdateClick
