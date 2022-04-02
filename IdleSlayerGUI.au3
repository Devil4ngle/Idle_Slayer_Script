#include <ButtonConstants.au3>
#include <SliderConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <GuiTab.au3>

; Create GUI
$GUIForm = GUICreate("Idle Slayer Bot", 1280, 146, 317, 0)
GUISetBkColor(0x202225)

; Create TabControl
$TabControl = GUICtrlCreateTab(160, -20, 1120, 165, BitOR($TCS_FORCELABELLEFT,$TCS_FIXEDWIDTH))
GUICtrlSetBkColor(-1, 0x2F3136)
$TabHandle = GUICtrlGetHandle($TabControl)

; Create Home Tab
$TabHome = GUICtrlCreateTabItem("Home")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)

; Welcome screen
$Label1 = GUICtrlCreateLabel("Welcome to the Idle Slayer Bot", 176, 16, 500, 50)
GUICtrlSetFont(-1, 25, 400, 0, "MS Sans Serif")
$ButtonDiscord = GUICtrlCreateButton("Discord", 226, 75, 160, 50)
$ButtonInstructions = GUICtrlCreateButton("Instructions", 390, 75, 160, 50)

; Create General Tab
$TabSheet2 = GUICtrlCreateTabItem("General")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)
$CheckBoxCraftRage = GUICtrlCreateCheckbox("Craft item when rage is active", 176, 16)
$CheckBoxBuyUpgrades = GUICtrlCreateCheckbox("Auto buy upgrades every 5 minutes", 176, 35)

$SliderBuyUpgrades = GUICtrlCreateSlider(176, 59, 150, 25, BitOR($TBS_AUTOTICKS, $TBS_FIXEDLENGTH))
GUICtrlSetLimit(-1, 30, 5)

$LabelJump = GUICtrlCreateLabel("Jump rate", 176, 91)
$SliderJump = GUICtrlCreateSlider(176, 110, 150, 25, BitOR($TBS_AUTOTICKS, $TBS_FIXEDLENGTH))
GUICtrlSetLimit(-1, 3, 0)

; Set Hotkey Bindings
; Setting own hotkeys coming soon
Global $Running = False
HotKeySet("{F4}", "StartStopScript")
HotKeySet("{F5}", "ExitScript")

; Create Bonus Stage Tab
$TabSheet3 = GUICtrlCreateTabItem("Bonus Stage")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)
$Label3 = GUICtrlCreateLabel("This is the bonus stage tab", 176, 16, 131, 17)

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
$ButtonHome = GUICtrlCreateButton("Home", 0, 0, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create General Button
$ButtonGeneral = GUICtrlCreateButton("General", 0, 24, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Bonus Stage Button
$ButtonBonusStage = GUICtrlCreateButton("Bonus Stage", 0, 48, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Chesthunt Button
$ButtonChestHunt = GUICtrlCreateButton("Chest Hunt", 0, 72, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Log Button
$ButtonLog = GUICtrlCreateButton("Log", 0, 96, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Start / Pause Button
$ButtonStartStop = GUICtrlCreateButton("Start", 0, 120, 80, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Stop Button
$ButtonExit = GUICtrlCreateButton("Exit", 80, 120, 80, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
        Case $ButtonHome
            GUICtrlSetState($TabHome, $GUI_SHOW)
        Case $ButtonGeneral
            GUICtrlSetState($TabSheet2, $GUI_SHOW)
        Case $ButtonBonusStage
            GUICtrlSetState($TabSheet3, $GUI_SHOW)
        Case $ButtonChestHunt
            GUICtrlSetState($TabSheet4, $GUI_SHOW)
        Case $ButtonLog
            GUICtrlSetState($TabSheet5, $GUI_SHOW)
        Case $ButtonStartStop
            StartStopFunc()
        Case $ButtonExit
            Exit
        Case $TabControl
            TabEvent()
        Case $SliderBuyUpgrades
            GUICtrlSetData($CheckBoxBuyUpgrades, "Auto buy upgrades every " & GUICtrlRead($SliderBuyUpgrades) & " minutes")

	EndSwitch
WEnd

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
EndFunc

Func StartStopFunc()
    If $Running Then
        $Running = False
        GUICtrlSetData($ButtonStartStop, "Start")
    Else
        $Running = True
        GUICtrlSetData($ButtonStartStop, "Stop")
    EndIf
EndFunc