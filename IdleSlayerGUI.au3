#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <GuiTab.au3>

#Region ### START Koda GUI section ### Form=
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
$Label1 = GUICtrlCreateLabel("This is the home tab", 176, 16, 99, 17)

; Create General Tab
$TabSheet2 = GUICtrlCreateTabItem("General")
_GUICtrlTab_SetBkColor($GUIForm, $TabControl, 0x36393F)
$Label2 = GUICtrlCreateLabel("This is the general tab", 176, 16, 108, 17)

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
$Button1 = GUICtrlCreateButton("Home", 0, 0, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create General Button
$Button2 = GUICtrlCreateButton("General", 0, 24, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Bonus Stage Button
$Button3 = GUICtrlCreateButton("Bonus Stage", 0, 48, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Chesthunt Button
$Button4 = GUICtrlCreateButton("Chest Hunt", 0, 72, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Log Button
$Button5 = GUICtrlCreateButton("Log", 0, 96, 160, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Start / Pause Button
$Button6 = GUICtrlCreateButton("Start / Pause", 0, 120, 80, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

; Create Stop Button
$Button7 = GUICtrlCreateButton("Stop", 80, 120, 80, 25)
GUICtrlSetBkColor(-1, 0x2F3136)
GUICtrlSetColor(-1, 0xFFFFFF)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
        Case $Button1
            GUICtrlSetState($TabHome, $GUI_SHOW)
        Case $Button2
            GUICtrlSetState($TabSheet2, $GUI_SHOW)
        Case $Button3
            GUICtrlSetState($TabSheet3, $GUI_SHOW)
        Case $Button4
            GUICtrlSetState($TabSheet4, $GUI_SHOW)
        Case $Button5
            GUICtrlSetState($TabSheet5, $GUI_SHOW)
        Case $TabControl
            TabEvent()

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