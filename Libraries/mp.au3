;~	Author: 	wuuyi123@gmail.com
;~	Repo:		https://github.com/nomi-san/mp.au3
;~	Release:	2021-08-22

#include-once
#include "ResourcesEx.au3"

Local $__MP_hDll = Null

;~	Initialize the library.
;~  This function must be called on top-level of code.
;~  Returns
;~		0 	- Fail
;~		1 	- Success
;func _MP_Init()
;	local $sDll = @AutoItX64 ? 'Libraries/mp.x64.dll' : 'Libraries/mp.dll'
;	if not FileExists($sDll) then return 0
;;	$__MP_hDll = DllOpen($sDll)
;	if $__MP_hDll == null or $__MP_hDll == -1 then return 0
;	local $aRet = DllCall($__MP_hDll, 'int:cdecl', 'MP_Init')
;	if not IsArray($aRet) or @error then return 0
;	return $aRet[0]
;endFunc

Func _MP_Init()
	Local $sPath = "IdleRunnerLogs/mp.dll"
	Local $sDll = @AutoItX64 ? 'MP_DLL_X64' : 'MP_DLL'
	_Resource_SaveToFile($sPath, 'MP_DLL_X64')
	If Not FileExists($sPath) Then
		Local $sPath = @AutoItX64 ? 'Libraries/mp.x64.dll' : 'Libraries/mp.dll'
	EndIf
	$__MP_hDll = DllOpen($sPath)
	If $__MP_hDll = -1 Then Return 0
	Local $aRet = DllCall($__MP_hDll, 'int:cdecl', 'MP_Init')
	If Not IsArray($aRet) Or @error Then Return 0
	Return $aRet[0]
EndFunc   ;==>_MP_Init

;~	Check if current process is main.
;~  Returns
;~  	1 	- Main process
;~		0 	- Sub process
;		-99	- Error
Func _MP_IsMain()
	Local $aRet = DllCall($__MP_hDll, 'int:cdecl', 'MP_IsMain')
	If Not IsArray($aRet) Or @error Then Return -99
	Return $aRet[0]
EndFunc   ;==>_MP_IsMain

;~	Get index of current process.
;~	This function must be called on top-level of code to determine which the current process is.
;~  Returns
;~  	-1 	- Main process
;~		0+ 	- Sub process
;~		-99 - Error
Func _MP_Index()
	Local $aRet = DllCall($__MP_hDll, 'int:cdecl', 'MP_Index')
	If Not IsArray($aRet) Or @error Then Return -99
	Return $aRet[0]
EndFunc   ;==>_MP_Index

;~	Fork the main process.
;~	This function must be called in main process.
;~	Params
;~		$bSuspended	- Create and suspend.
;~	Returns
;~		0+	- Index of sub process
;~		-1	- Reach the limit (over 10 sub processes) or error
Func _MP_Fork($bSuspended = False)
	Local $aRet = DllCall($__MP_hDll, 'int:cdecl', 'MP_Fork', 'int', $bSuspended)
	If Not IsArray($aRet) Or @error Then Return -1
	Return $aRet[0]
EndFunc   ;==>_MP_Fork

;~	Wait for a sub process exits.
;~	Params
;~		$iProc	- Sub process index (from _MP_Fork()).
Func _MP_Wait($iProc)
	DllCall($__MP_hDll, 'none:cdecl', 'MP_Wait', 'int', $iProc)
EndFunc   ;==>_MP_Wait

;~	Wait for all processes exit
Func _MP_WaitAll()
	DllCall($__MP_hDll, 'none:cdecl', 'MP_WaitAll')
EndFunc   ;==>_MP_WaitAll

;~	Resume a suspended sub process.
Func _MP_Resume($iProc)
	DllCall($__MP_hDll, 'none:cdecl', 'MP_Resume', 'int', $iProc)
EndFunc   ;==>_MP_Resume

;~	Suspend a sub process.
Func _MP_Suspend($iProc)
	DllCall($__MP_hDll, 'none:cdecl', 'MP_Suspend', 'int', $iProc)
EndFunc   ;==>_MP_Suspend

;~	Get global shared data.
;~	The return value is an IDispatch object.
;~	The object properties can be accessed in any process.
Func _MP_SharedData()
	Local $aRet = DllCall($__MP_hDll, 'idispatch:cdecl', 'MP_SharedData')
	If Not IsArray($aRet) Or @error Then Return Null
	Return $aRet[0]
EndFunc   ;==>_MP_SharedData

;~	Send an integer message to sub process.
;~	This function must be called in main process.
;~	Params
;~		$iProc		- Sub process index
;~		$iMessage	- An integer message
Func _MP_SendToSub($iProc, $iMessage)
	DllCall($__MP_hDll, 'none:cdecl', 'MP_SendToSub', 'int', $iProc, 'int', $iMessage)
EndFunc   ;==>_MP_SendToSub

;~	Send an integer message to main process.
;~	This function must be called in sub process.
;~	Params
;~		$iMessage	- An integer message
Func _MP_SendToMain($iMessage)
	DllCall($__MP_hDll, 'none:cdecl', 'MP_SendToMain', 'int', $iMessage)
EndFunc   ;==>_MP_SendToMain

;~ 	Register a listenter to listen message is sent from main process.
;~ 	This function must be called in sub process.
;~	Params
;~		$fnListener	- A function has single integer argument.
;~ 	Returns
;~		A callback handler, you must call _MP_OffMain() to Remove it.
Func _MP_OnMain($fnListener)
	Local $hCallback = DllCallbackRegister($fnListener, 'none', 'int')
	DllCall($__MP_hDll, 'none:cdecl', 'MP_OnMain', 'ptr', DllCallbackGetPtr($hCallback))
	Return $hCallback
EndFunc   ;==>_MP_OnMain

;~ 	Register a listenter to listen message is sent from sub process.
;~ 	This function must be called in main process.
;~	Params
;~		$fnListener	- A function has two integer arguments
;~ 	Returns
;~		A callback handler, you must call _MP_OffSub() to Remove it.
Func _MP_OnSub($fnListener)
	Local $hCallback = DllCallbackRegister($fnListener, 'none', 'int;int')
	DllCall($__MP_hDll, 'none:cdecl', 'MP_OnSub', 'ptr', DllCallbackGetPtr($hCallback))
	Return $hCallback
EndFunc   ;==>_MP_OnSub

;~	Remove callback handler, which is returned by _MP_OnMain().
Func _MP_OffMain($hCallback)
	DllCall($__MP_hDll, 'none:cdecl', 'MP_OffMain', 'ptr', DllCallbackGetPtr($hCallback))
	DllCallbackFree($hCallback)
EndFunc   ;==>_MP_OffMain

;~	Remove callback handler, which is returned by _MP_OnSub().
Func _MP_OffSub($hCallback)
	DllCall($__MP_hDll, 'none:cdecl', 'MP_OffSub', 'ptr', DllCallbackGetPtr($hCallback))
	DllCallbackFree($hCallback)
EndFunc   ;==>_MP_OffSub
