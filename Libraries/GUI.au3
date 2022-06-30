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
#include "LogEx.au3"

#Region GUI.au3 - #GLOBAL#
Global  $AutoBuyUpgradeState = True, _
        $CraftSoulBonusState = True, _
        $SkipBonusStageState = False, _
		$CraftRagePillState = True, _
        $CirclePortalsState = False, _
		$NoLockpickingState = False, _
        $BiDimensional = False, _
        $Dimensional = False

Global  $LogPath = "Log\Idle_Slayer_Log.txt"

Global  $JumpSliderValue = 150, _
        $CirclePortalsCount = 7
#EndRegion GUI.au3 - #GLOBAL#

#Region GUI.au3 - #FUNCTION#
; #FUNCTION# ====================================================================================================================
; Name ..........: _CreateGUI
; Description ...: Creates the GUI
; Syntax ........: _CreateGUI()
; Parameters ....: 
; Return values .: Succes - A windows handle
;                  Failure - 0 if the window cannot be created and sets the @error flag to 1.
; Author ........: Djahnz
; Modified ......: 30-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _CreateGUI()
    ; Create GUI
    $GUIForm = GUICreate("Idle Runner", 898, 164, @DesktopWidth / 2 - 500, @DesktopHeight - 250, $WS_BORDER + $WS_POPUP)
    GUISetBkColor(0x202225)

    ; Titlebar
    GUICtrlCreateLabel("", -1, -1, 898, 22, -1, $GUI_WS_EX_PARENTDRAG)
    GUICtrlCreateLabel("        Idle Runner v2.9.2", -1, -1, 900, 22, $SS_CENTERIMAGE)
    GUICtrlSetColor(-1, 0xFFFFFF)
    $Icon = GUICtrlCreatePic('', 2, 2, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($Icon, 'ICON')

    ; Create TabControl
    __CreateTabControl($GUIForm)

    ; Create Home Button
    $ButtonHome = GUICtrlCreatePic('', 1, 20, 160, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonHome, 'HOME')
    GUICtrlSetOnEvent(-1, "_Event__ButtonHomeClick")

    ; Create General Button
    $ButtonGeneral = GUICtrlCreatePic('', 1, 44, 160, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonGeneral, 'GENERAL')
    GUICtrlSetOnEvent(-1, "_Event__ButtonGeneralClick")

    ; Create Bonus Stage Button
    $ButtonBonusStage = GUICtrlCreatePic('', 1, 68, 160, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonBonusStage, 'MINIGAMES')
    GUICtrlSetOnEvent(-1, "_Event__ButtonMinigamesClick")

    ; Create Chesthunt Button
    $ButtonChestHunt = GUICtrlCreatePic('', 1, 92, 160, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonChestHunt, 'CRAFTING')
    GUICtrlSetOnEvent(-1, "_Event__ButtonCraftingClick")

    ; Create Log Button
    $ButtonLog = GUICtrlCreatePic('', 1, 116, 160, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonLog, 'LOG')
    GUICtrlSetOnEvent(-1, "_Event__ButtonLogClick")

    ; Create Start / Pause Button
    Global $ButtonStartStop = GUICtrlCreatePic('', 1, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonStartStop, 'STOP')
    GUICtrlSetOnEvent(-1, "_Pause")

    ; Create Stop Button
    $ButtonExit = GUICtrlCreatePic('', 81, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
    _Resource_SetToCtrlID($ButtonExit, 'EXIT')
    GUICtrlSetOnEvent(-1, "_IdleClose")

    Return $GUIForm
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _IdleClose
; Description ...: Closes Idle Runner
; Syntax ........: _IdleClose()
; Parameters ....: 
; Return values .: 
; Author ........: Djahnz
; Modified ......: 30-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Func _IdleClose()
	Exit
EndFunc   ;==>IdleClose

; #FUNCTION# ====================================================================================================================
; Name ..........: _Pause
; Description ...: Pauses Idle Runner
; Syntax ........: _Pause()
; Parameters ....: 
; Return values .: 
; Author ........: Djahnz
; Modified ......: 30-06-2022
; Remarks .......: 
; Related .......:
; Link ..........:
; ===============================================================================================================================
Global $TogglePause = False
Func _Pause()
	$TogglePause = Not $TogglePause
	If $TogglePause Then
		ControlFocus("Idle Slayer", "", "")
		_Resource_SetToCtrlID($ButtonStartStop, 'START')
	Else
		ControlFocus("Idle Slayer", "", "")
		_Resource_SetToCtrlID($ButtonStartStop, 'STOP')
	EndIf
EndFunc   ;==>Pause
#EndRegion GUI.au3 - #FUNCTION#

#Region GUI.au3 - #INTERNAL FUNCTION#
; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CreateTabControl
; Description ...: Creates a TabControl in the given GUI
; Syntax ........: __CreateTabControl($GUIForm)
; Parameters ....: $GUIForm             - Window handle of a GUI
; Return values .: 
; Modified ......: 30-06-2022
; ================================================================================================================================
Func __CreateTabControl($GUIForm)
    Global $TabControl = GUICtrlCreateTab(159, -4, 745, 173, BitOR($TCS_FORCELABELLEFT, $TCS_FIXEDWIDTH, $TCS_BUTTONS))
    GUICtrlSetBkColor(-1, 0x2F3136)
    GUISetOnEvent(-1, "_Event__TabFocus")
    Global $TabHandle = GUICtrlGetHandle($TabControl)

    ; Create Tabs
    Global $TabHome = __CreateWelcomeSheet($GUIForm, $TabControl)
    Global $TabGeneral = __CreateGeneralSheet($GUIForm, $TabControl)
    Global $TabMinigames = __CreateMinigamesSheet($GUIForm, $TabControl)
    Global $TabCrafting = __CreateCraftingSheet($GUIForm, $TabControl)
    Global $TabLog = __CreateLogSheet($GUIForm, $TabControl)

    ; Set Tab Focus Home
    GUICtrlSetState($TabHome, $GUI_SHOW)
    GUICtrlCreateTabItem("")
EndFunc   ;==>__CreateTabControl

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CreateWelcomeSheet
; Description ...: Creates the Home tab in the tabcontrol
; Syntax ........: __CreateWelcomeSheet($GUIForm, $TabControl)
; Parameters ....: $GUIForm             - Window handle of a GUI
;                  $TabControl          - TabControl where to add TabSheet
; Return values .: 
; Modified ......: 30-06-2022
; ================================================================================================================================
Func __CreateWelcomeSheet($GUIForm, $TabControl)
    $TabHome = GUICtrlCreateTabItem("Home")
    _Event__GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    $Welcome = GUICtrlCreatePic('', 186, 36, 436, 29, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($Welcome, 'WELCOME')

    $ButtonDiscord = GUICtrlCreatePic('', 206, 95, 160, 50, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($ButtonDiscord, 'GITHUB')
    GUICtrlSetOnEvent(-1, "_Event__ButtonGithubClick")

    $ButtonInstructions = GUICtrlCreatePic('', 390, 95, 214, 50, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($ButtonInstructions, 'INSTRUCTION')
    GUICtrlSetOnEvent(-1, "_Event__ButtonInstructionsClick")

    Return $TabHome
EndFunc   ;==>__CreateWelcomeSheet

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CreateGeneralSheet
; Description ...: Creates the General tab in the tabcontrol
; Syntax ........: __CreateGeneralSheet($GUIForm, $TabControl)
; Parameters ....: $GUIForm             - Window handle of a GUI
;                  $TabControl          - TabControl where to add TabSheet
; Return values .: 
; Modified ......: 30-06-2022
; ================================================================================================================================
Func __CreateGeneralSheet($GUIForm, $TabControl)
    $TabGeneral = GUICtrlCreateTabItem("General")
    _Event__GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    ; Create AutoBuyUpgrades Checkbox
    Global $CheckBoxAutoBuyUpgrades = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxAutoBuyUpgrades, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__AutoBuyUpgradesChecked")
    $AutoUpgrade = GUICtrlCreatePic('', 207, 45, 165, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($AutoUpgrade, 'AUTOUPGRADES')
    GUICtrlSetTip(-1, " Buys upgrades every 10 minutes except Vertical Magnet")

        ; Create CirclePortals Checkbox
    Global $CheckBoxCirclePortals = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxCirclePortals, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__CirclePortalsChecked")
    $CirclePortals = GUICtrlCreatePic('', 207, 84, 129, 14, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CirclePortals, 'CIRCLEPORTALS')
    GUICtrlSetTip(-1, "Automate portal cycle")

    ; Create JumpRate Slider
    $Jslider = GUICtrlCreatePic('', 400, 45, 98, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($Jslider, 'JUMPRATE')

    Global $JumpNumber = GUICtrlCreatePic('', 505, 42, 42, 22, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($JumpNumber, 'NUM150')
    $JumpUp = GUICtrlCreatePic('', 547, 42, 17, 11, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($JumpUp, 'UPARROW')
    GUICtrlSetOnEvent(-1, "_Event__UpArrow")
    $JumpDown = GUICtrlCreatePic('', 547, 53, 17, 11, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($JumpDown, 'DOWNARROW')
    GUICtrlSetOnEvent(-1, "_Event__DownArrow")

    Return $TabGeneral
EndFunc   ;==>__CreateGeneralSheet

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CreateMinigamesSheet
; Description ...: Creates the Minigame tab in the tabcontrol
; Syntax ........: __CreateMinigamesSheet($GUIForm, $TabControl)
; Parameters ....: $GUIForm             - Window handle of a GUI
;                  $TabControl          - TabControl where to add TabSheet
; Return values .: 
; Modified ......: 30-06-2022
; ================================================================================================================================
Func __CreateMinigamesSheet($GUIForm, $TabControl)
    $TabMinigames = GUICtrlCreateTabItem("Minigames")
    _Event__GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    Global $CheckBoxSkipBonusStage = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxSkipBonusStage, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__SkipBonusStageChecked")
    $SKIPBS = GUICtrlCreatePic('', 207, 45, 160, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($SKIPBS, 'SKIPBONUS')
    GUICtrlSetTip(-1, "Skips Bonus Stages by letting the timer run out without doing anything")

    Global $NoLockpicking = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($NoLockpicking, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__NoLockpickingChecked")
    $NPL = GUICtrlCreatePic('', 207, 84, 176, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($NPL, 'NOLOCKPICKING')
    GUICtrlSetTip(-1, "Determines if you have the Divinity Lockpicking 100")

    Return $TabMinigames
EndFunc   ;==>__CreateMinigamesSheet

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CreateCraftingSheet
; Description ...: Creates the Crafting tab in the tabcontrol
; Syntax ........: __CreateCraftingSheet($GUIForm, $TabControl)
; Parameters ....: $GUIForm             - Window handle of a GUI
;                  $TabControl          - TabControl where to add TabSheet
; Return values .: 
; Modified ......: 30-06-2022
; ================================================================================================================================
Func __CreateCraftingSheet($GUIForm, $TabControl)
    $TabCrafting = GUICtrlCreateTabItem("Crafting")
    _Event__GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    ; Create CraftSoulBonus Checkbox
    Global $CheckBoxCraftSoulBonus = GUICtrlCreatePic('', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxCraftSoulBonus, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__CraftSoulBonusChecked")
    $CraftComp = GUICtrlCreatePic('', 207, 45, 153, 14, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CraftComp, 'SOULBONUS')
    GUICtrlSetTip(-1, "When Horde/Mega Horde, use Souls Compass When Rage is Down")

    ; Craft Bidmensional Stuff
    Global $CheckBoxBiDimension = GUICtrlCreatePic('', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxBiDimension, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__BiDimensionChecked")
    $CraftBiDimension = GUICtrlCreatePic('', 207, 84, 239, 14, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CraftBiDimension, 'BIDIMENSIONAL')
    GUICtrlSetTip(-1, "Craft BiDimensional item at Megahorde and it will disable it itself after one use")

    ; Craft Dimensional Stuff
    Global $CheckBoxDimension = GUICtrlCreatePic('', 181, 124, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxDimension, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__DimensionChecked")
    $CraftDimension = GUICtrlCreatePic('', 207, 124, 221, 14, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CraftDimension, 'DIMENSIONAL')
    GUICtrlSetTip(-1, "Craft Dimensional item at Megahorde and it will disable it itself after one use")

    ; Create CraftRagePill Checkbox
    Global $CheckBoxCraftRagePill = GUICtrlCreatePic('', 450, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($CheckBoxCraftRagePill, 'UNCHECKED')
    GUICtrlSetOnEvent(-1, "_Event__CraftRagePillChecked")
    $Rage = GUICtrlCreatePic('', 476, 45, 132, 16, $SS_BITMAP + $SS_NOTIFY)
    _Resource_SetToCtrlID($Rage, 'RAGEPILL')
    GUICtrlSetTip(-1, "When Horde/Mega Horde, use Rage Pill When Rage is Down")

    Return $TabCrafting
EndFunc   ;==>__CreateCraftingSheet

; #INTERNAL FUNCTION# =============================================================================================================
; Name ..........: __CreateLogSheet
; Description ...: Creates the Log tab in the tabcontrol
; Syntax ........: __CreateLogSheet($GUIForm, $TabControl)
; Parameters ....: $GUIForm             - Window handle of a GUI
;                  $TabControl          - TabControl where to add TabSheet
; Return values .: 
; Modified ......: 30-06-2022
; ================================================================================================================================
Func __CreateLogSheet($GUIForm, $TabControl)
    $TabLog = GUICtrlCreateTabItem("Log")
    _Event__GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

    ; Log logs
    Global $Log = GUICtrlCreateEdit("", 175, 32, 340, 120, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL, $ES_READONLY))
    GUICtrlSetBkColor($Log, 0x000000)
    GUICtrlSetColor($Log, 0x4CFF00)

    ; Log data
    Global $LogData = GUICtrlCreateEdit("", 540, 32, 340, 120, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL, $ES_READONLY))
    GUICtrlSetBkColor($LogData, 0x000000)
    GUICtrlSetColor($LogData, 0xFFBB00)

    Return $TabLog
EndFunc   ;==>__CreateLogSheet
#EndRegion GUI.au3 - #INTERNAL FUNCTION#

#Region GUI.au3 - #EVENTS#
; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__ButtonHomeClick
; Description ...: Changes Tabsheet to Home
; ================================================================================================================================
Func _Event__ButtonHomeClick()
	GUICtrlSetState($TabHome, $GUI_SHOW)
EndFunc   ;==>_Event__ButtonHomeClick

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__ButtonGeneralClick
; Description ...: Changes Tabsheet to General
; ================================================================================================================================
Func _Event__ButtonGeneralClick()
	GUICtrlSetState($TabGeneral, $GUI_SHOW)
EndFunc   ;==>_Event__ButtonGeneralClick

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__ButtonMinigamesClick
; Description ...: Changes Tabsheet to Minigames
; ================================================================================================================================
Func _Event__ButtonMinigamesClick()
	GUICtrlSetState($TabMinigames, $GUI_SHOW)
EndFunc   ;==>_Event__ButtonMinigamesClick

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__ButtonCraftingClick
; Description ...: Changes Tabsheet to Crafting
; ================================================================================================================================
Func _Event__ButtonCraftingClick()
	GUICtrlSetState($TabCrafting, $GUI_SHOW)
EndFunc   ;==>_Event__ButtonCraftingClick

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__ButtonLogClick
; Description ...: Changes Tabsheet to Log
; ================================================================================================================================
Func _Event__ButtonLogClick()
	GUICtrlSetState($TabLog, $GUI_SHOW)
	_LoadLog($LogPath, $Log)
	_LoadDataLog($LogData)
EndFunc   ;==>_Event__ButtonLogClick

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__TabFocus
; Description ...: Sets focus to tabsheet once selected
; ================================================================================================================================
Func _Event__TabFocus()
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
EndFunc   ;==>_Event__TabFocus

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__ButtonGithubClick
; Description ...: Opens the github releases page in a new browser
; ================================================================================================================================
Func _Event__ButtonGithubClick()
	ShellExecute("https://github.com/Devil4ngle/Idle_Slayer_Script/releases")
EndFunc   ;==>_Event__ButtonGithubClick

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__ButtonInstructionsClick
; Description ...: Opens the instruction page in discord
; ================================================================================================================================
Func _Event__ButtonInstructionsClick()
	ShellExecute("https://discord.gg/aEaBr77UDn")
EndFunc   ;==>_Event__ButtonInstructionsClick

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__NoLockpickingChecked
; Description ...: Changes the checkstate of NoLockpicking
; ================================================================================================================================
Func _Event__NoLockpickingChecked()
	If $NoLockpickingState Then
		$NoLockpickingState = False
		_Resource_SetToCtrlID($NoLockpicking, 'UNCHECKED')
	Else
		$NoLockpickingState = True
		_Resource_SetToCtrlID($NoLockpicking, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__NoLockpickingChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__AutoBuyUpgradesChecked
; Description ...: Changes the checkstate of AutoBuyUpgrades
; ================================================================================================================================
Func _Event__AutoBuyUpgradesChecked()
	If $AutoBuyUpgradeState Then
		$AutoBuyUpgradeState = False
		_Resource_SetToCtrlID($CheckBoxAutoBuyUpgrades, 'UNCHECKED')
	Else
		$AutoBuyUpgradeState = True
		_Resource_SetToCtrlID($CheckBoxAutoBuyUpgrades, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__AutoBuyUpgradesChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__CirclePortalsChecked
; Description ...: Changes the checkstate of CirclePortal
; ================================================================================================================================
Func _Event__CirclePortalsChecked()
	If $CirclePortalsState Then
		$CirclePortalsState = False
		_Resource_SetToCtrlID($CheckBoxCirclePortals, 'UNCHECKED')
	Else
		$CirclePortalsState = True
		_Resource_SetToCtrlID($CheckBoxCirclePortals, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__CirclePortalsChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__DimensionChecked
; Description ...: Changes the checkstate of Dimensional
; ================================================================================================================================
Func _Event__DimensionChecked()
	If $Dimensional Then
		$Dimensional = False
		_Resource_SetToCtrlID($CheckBoxDimension, 'UNCHECKED')
	Else
		$Dimensional = True
		_Resource_SetToCtrlID($CheckBoxDimension, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__DimensionChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__BiDimensionChecked
; Description ...: Changes the checkstate of BiDimension
; ================================================================================================================================
Func _Event__BiDimensionChecked()
	If $BiDimensional Then
		$BiDimensional = False
		_Resource_SetToCtrlID($CheckBoxBiDimension, 'UNCHECKED')
	Else
		$BiDimensional = True
		_Resource_SetToCtrlID($CheckBoxBiDimension, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__BiDimensionChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__CraftRagePillChecked
; Description ...: Changes the checkstate of CraftRagePill
; ================================================================================================================================
Func _Event__CraftRagePillChecked()
	If $CraftRagePillState Then
		$CraftRagePillState = False
		_Resource_SetToCtrlID($CheckBoxCraftRagePill, 'UNCHECKED')
	Else
		$CraftRagePillState = True
		_Resource_SetToCtrlID($CheckBoxCraftRagePill, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__CraftRagePillChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__CraftSoulBonusChecked
; Description ...: Changes the checkstate of CraftSoulBonus
; ================================================================================================================================
Func _Event__CraftSoulBonusChecked()
	If $CraftSoulBonusState Then
		$CraftSoulBonusState = False
		_Resource_SetToCtrlID($CheckBoxCraftSoulBonus, 'UNCHECKED')
	Else
		$CraftSoulBonusState = True
		_Resource_SetToCtrlID($CheckBoxCraftSoulBonus, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__CraftSoulBonusChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__UpArrow
; Description ...: Increase value + 10
; ================================================================================================================================
Func _Event__UpArrow()
	If ($JumpSliderValue + 10) <= 300 Then
		$JumpSliderValue += 10
		_Resource_SetToCtrlID($JumpNumber, 'NUM' & $JumpSliderValue)
	EndIf
EndFunc   ;==>_Event__UpArrow

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__DownArrow
; Description ...: Decrease value + 10
; ================================================================================================================================
Func _Event__DownArrow()
	If ($JumpSliderValue - 10) >= 0 Then
		$JumpSliderValue -= 10
		_Resource_SetToCtrlID($JumpNumber, 'NUM' & $JumpSliderValue)
	EndIf
EndFunc   ;==>_Event__DownArrow

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__SkipBonusStageChecked
; Description ...: Changes the checkstate of SkipBonusStage
; ================================================================================================================================
Func _Event__SkipBonusStageChecked()
	If $SkipBonusStageState Then
		$SkipBonusStageState = False
		_Resource_SetToCtrlID($CheckBoxSkipBonusStage, 'UNCHECKED')
	Else
		$SkipBonusStageState = True
		_Resource_SetToCtrlID($CheckBoxSkipBonusStage, 'CHECKED')
	EndIf
EndFunc   ;==>_Event__SkipBonusStageChecked

; #EVENT FUNCTION# =============================================================================================================
; Name ..........: _Event__GUICtrlTab_SetBkColor
; Description ...: Makes Tab Control Color Transparent
; ================================================================================================================================
Func _Event__GUICtrlTab_SetBkColor($hWnd, $hSysTab32, $sBkColor)
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
EndFunc   ;==>_Event__GUICtrlTab_SetBkColor
#EndRegion GUI.au3 - #EVENTS#