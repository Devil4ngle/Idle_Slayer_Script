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

Global $AutoBuyUpgradeState = False, $CraftSoulBonusState = False, $SkipBonusStageState = False, _
	    $CraftRagePillState = False, $CirclePortalsState = False, $JumpSliderValue = 150

Opt("GUIOnEventMode", 1)

; Set Hotkey Bindings
; Setting own hotkeys coming soon
Global $Running = False
HotKeySet("{F4}", "StartStopScript")
HotKeySet("{F5}", "ExitScript")

; Create GUI
$GUIForm = GUICreate("Idle Runner", 1280, 164, -1, -1, $WS_BORDER + $WS_POPUP)
GUISetBkColor(0x202225)

; Titlebar
GUICtrlCreateLabel("        Idle Runner", -1, -1, 1282, 22, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreatePic(@ScriptDir & '\Resources\Icon.jpg', 2, 2 , 16, 16, $SS_BITMAP + $SS_NOTIFY)

; Create TabControl
$TabControl = GUICtrlCreateTab(159, -4, 1126, 173, BitOR($TCS_FORCELABELLEFT,$TCS_FIXEDWIDTH, $TCS_BUTTONS))
GUICtrlSetBkColor(-1, 0x2F3136)
GUISetOnEvent(-1, "TabController")
$TabHandle = GUICtrlGetHandle($TabControl)

; Create Home Tab
$TabHome = GUICtrlCreateTabItem("Home")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

; Welcome screen
GUICtrlCreatePic(@ScriptDir & '\Resources\Welcome.jpg', 186, 36 , 436, 29, $SS_BITMAP + $SS_NOTIFY)

$ButtonDiscord = GUICtrlCreatePic(@ScriptDir & '\Resources\Discord.jpg', 206, 95, 160, 50, $SS_BITMAP + $SS_NOTIFY)
GUICtrlSetOnEvent(-1, "ButtonDiscordClick")

$ButtonInstructions = GUICtrlCreatePic(@ScriptDir & '\Resources\Instructions.jpg', 390, 95, 214, 50, $SS_BITMAP + $SS_NOTIFY)
GUICtrlSetOnEvent(-1, "ButtonInstructionsClick")

; Create General Tab
$TabSheet2 = GUICtrlCreateTabItem("General")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

; Create CraftRagePill Checkbox
$CheckBoxCraftRagePill = GUICtrlCreatePic(@ScriptDir & '\Resources\CheckboxUnchecked.jpg', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
GUICtrlSetOnEvent(-1, "CraftRagePillChecked")
GUICtrlCreatePic(@ScriptDir & '\Resources\CraftRagePill.jpg', 207, 45, 132, 16, $SS_BITMAP + $SS_NOTIFY)

; Create CraftSoulBonus Checkbox
$CheckBoxCraftSoulBonus = GUICtrlCreatePic(@ScriptDir & '\Resources\CheckboxUnchecked.jpg', 181, 83, 16, 16, $SS_BITMAP + $SS_NOTIFY)
GUICtrlSetOnEvent(-1, "CraftSoulBonusChecked")
GUICtrlCreatePic(@ScriptDir & '\Resources\CraftSoulBonus.jpg', 207, 84, 153, 14, $SS_BITMAP + $SS_NOTIFY)

; Create AutoBuyUpgrades Checkbox
$CheckBoxAutoBuyUpgrades = GUICtrlCreatePic(@ScriptDir & '\Resources\CheckboxUnchecked.jpg', 181, 122, 16, 16, $SS_BITMAP + $SS_NOTIFY)
GUICtrlSetOnEvent(-1, "AutoBuyUpgradesChecked")
GUICtrlCreatePic(@ScriptDir & '\Resources\AutoBuyUpgrades.jpg', 207, 123, 165, 16, $SS_BITMAP + $SS_NOTIFY)

GUICtrlCreatePic(@ScriptDir & '\Resources\JumpRate.jpg', 400, 45, 98, 16, $SS_BITMAP + $SS_NOTIFY)
$JumpSlider = GUICtrlCreateSlider(520, 33, 150, 30)
GUICtrlSetLimit(-1, 300, 0)
GUICtrlSetData(-1, 150)
GUICtrlSetOnEvent(-1, "JumpSliderChange")

; Create Bonus Stage Tab
$TabSheet3 = GUICtrlCreateTabItem("Bonus Stage")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

$CheckBoxSkipBonusStage = GUICtrlCreatePic(@ScriptDir & '\Resources\CheckboxUnchecked.jpg', 181, 44, 16, 16, $SS_BITMAP + $SS_NOTIFY)
GUICtrlSetOnEvent(-1, "SkipBonusStageChecked")
GUICtrlCreatePic(@ScriptDir & '\Resources\SkipBonusStage.jpg', 207, 45, 160, 16, $SS_BITMAP + $SS_NOTIFY)

; Create Chesthunt Tab
$TabSheet4 = GUICtrlCreateTabItem("Chest Hunt")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)
$Label4 = GUICtrlCreateLabel("This is the chesthunt tab", 176, 16, 120, 17)

; Create Log Tab
$TabSheet5 = GUICtrlCreateTabItem("TabSheet5")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)
$Label5 = GUICtrlCreateLabel("This is the log tab", 176, 16, 87, 17)

; Set Tab Focus Home
GUICtrlSetState($TabHome,$GUI_SHOW)
GUICtrlCreateTabItem("")

; Create Home Button
$ButtonHome = GUICtrlCreatePic(@ScriptDir & '\Resources\Home.jpg', 1, 20, 160, 24, $SS_NOTIFY + $SS_BITMAP)
GUICtrlSetOnEvent(-1, "ButtonHomeClick")

; Create General Button
$ButtonGeneral = GUICtrlCreatePic(@ScriptDir & '\Resources\General.jpg', 1, 44, 160, 24, $SS_NOTIFY + $SS_BITMAP)
GUICtrlSetOnEvent(-1, "ButtonGeneralClick")

; Create Bonus Stage Button
$ButtonBonusStage = GUICtrlCreatePic(@ScriptDir & '\Resources\BonusStage.jpg', 1, 68, 160, 24, $SS_NOTIFY + $SS_BITMAP)
GUICtrlSetOnEvent(-1, "ButtonBonusStageClick")

; Create Chesthunt Button
$ButtonChestHunt = GUICtrlCreatePic(@ScriptDir & '\Resources\ChestHunt.jpg', 1, 92, 160, 24, $SS_NOTIFY + $SS_BITMAP)
GUICtrlSetOnEvent(-1, "ButtonChestHuntClick")

; Create Log Button
$ButtonLog = GUICtrlCreatePic(@ScriptDir & '\Resources\Log.jpg', 1, 116, 160, 24, $SS_NOTIFY + $SS_BITMAP)
GUICtrlSetOnEvent(-1, "ButtonLogClick")

; Create Start / Pause Button
$ButtonStartStop = GUICtrlCreatePic(@ScriptDir & '\Resources\Start.jpg', 1, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
GUICtrlSetOnEvent(-1, "ButtonStartStopClick")

; Create Stop Button
$ButtonExit = GUICtrlCreatePic(@ScriptDir & '\Resources\Exit.jpg', 81, 140, 80, 24, $SS_NOTIFY + $SS_BITMAP)
GUICtrlSetOnEvent(-1, "ButtonExitClick")

GUISetState(@SW_SHOW)

While 1
    Sleep(10)
WEnd

Func ButtonHomeClick()
    GUICtrlSetState($TabHome, $GUI_SHOW)
EndFunc

Func ButtonGeneralClick()
   GUICtrlSetState($TabSheet2, $GUI_SHOW)
EndFunc

Func ButtonBonusStageClick()
    GUICtrlSetState($TabSheet3, $GUI_SHOW)
EndFunc

Func ButtonChestHuntClick()
    GUICtrlSetState($TabSheet4, $GUI_SHOW)
EndFunc

Func ButtonLogClick()
    GUICtrlSetState($TabSheet5, $GUI_SHOW)
EndFunc

Func ButtonStartStopClick()
    StartStopFunc()
EndFunc

Func ButtonExitClick()
    Exit
EndFunc

Func ButtonDiscordClick()
    ShellExecute("https://discord.com/channels/948658078256078958/948662402541559818")
EndFunc

Func ButtonInstructionsClick()
    ShellExecute("https://discord.com/channels/948658078256078958/949970104752427058")
EndFunc

Func CraftRagePillChecked()
    If $CraftRagePillState Then
        $CraftRagePillState = False
        GUICtrlSetImage($CheckBoxCraftRagePill, @ScriptDir & '\Resources\CheckboxUnchecked.jpg')
    Else
        $CraftRagePillState = True
        GUICtrlSetImage($CheckBoxCraftRagePill, @ScriptDir & '\Resources\CheckboxChecked.jpg')
    EndIf
EndFunc

Func CraftSoulBonusChecked()
    If $CraftSoulBonusState Then
        $CraftSoulBonusState = False
        GUICtrlSetImage($CheckBoxCraftSoulBonus, @ScriptDir & '\Resources\CheckboxUnchecked.jpg')
    Else
        $CraftSoulBonusState = True
        GUICtrlSetImage($CheckBoxCraftSoulBonus, @ScriptDir & '\Resources\CheckboxChecked.jpg')
    EndIf
EndFunc

Func AutoBuyUpgradesChecked()
    If $AutoBuyUpgradeState Then
        $AutoBuyUpgradeState = False
        GUICtrlSetImage($CheckBoxAutoBuyUpgrades, @ScriptDir & '\Resources\CheckboxUnchecked.jpg')
    Else
        $AutoBuyUpgradeState = True
        GUICtrlSetImage($CheckBoxAutoBuyUpgrades, @ScriptDir & '\Resources\CheckboxChecked.jpg')
    EndIf
EndFunc

Func SkipBonusStageChecked()
    If $SkipBonusStageState Then
        $SkipBonusStageState = False
        GUICtrlSetImage($CheckBoxSkipBonusStage, @ScriptDir & '\Resources\CheckboxUnchecked.jpg')
    Else
        $SkipBonusStageState = True
        GUICtrlSetImage($CheckBoxSkipBonusStage, @ScriptDir & '\Resources\CheckboxChecked.jpg')
    EndIf
EndFunc

Func JumpSliderChange()
    $JumpSliderValue = GUICtrlRead($JumpSlider)
EndFunc ;==>JumpSliderChange

Func TabController()
    TabEvent()
EndFunc

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
    _GUICtrlTab_SetCurFocus($TabHandle,$iTab_Index)
EndFunc

Func _GUICtrlTab_SetBkColor($hWnd, $hSysTab32, $sBkColor)
    ; Get Tab position
    Local $aTabPos = ControlGetPos($hWnd, "", $hSysTab32)
    ; Get size of user area
    Local $aTab_Rect = _GUICtrlTab_GetItemRect($hSysTab32, -1)
    ; Create label
    GUICtrlCreateLabel("", $aTabPos[0] + 2, $aTabPos[1] + $aTab_Rect[3] + 4, $aTabPos[2] - 6, $aTabPos[3] - $aTab_Rect[3] - 7)
    ; colour label
    GUICtrlSetBkColor(-1, $sBkColor)
    ; Disable label
    GUICtrlSetState(-1, $GUI_DISABLE)
EndFunc   ;==>_GUICtrlTab_SetBkColor

Func StartStopScript()
    StartStopFunc()
EndFunc

Func ExitScript()
    Exit
EndFunc ;==>ExitScript

Func StartStopFunc()
    If $Running Then
        $Running = False
        GUICtrlSetImage($ButtonStartStop, @ScriptDir & '\Resources\Start.jpg')
    Else
        $Running = True
        GUICtrlSetImage($ButtonStartStop, @ScriptDir & '\Resources\Stop.jpg')
    EndIf
EndFunc ;==>StartStopFunc