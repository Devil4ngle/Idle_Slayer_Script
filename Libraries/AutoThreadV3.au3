
; #INDEX# =======================================================================================================================
; Title .........: AutoThreadV3
; AutoIt Version : 3.3.14.3
; Language ......: English
; Description ...: Functions that emulates and manage multithreading features from Autoit
; Author ........: KingPaic M.P
; Modified ......:
; Dll ...........:
; ===============================================================================================================================

#include-once
#include <Array.au3>
#include <File.au3>
#include <Process.au3>

#Region #VARIABLES#
; =======================================================================================================================
;MAIN WORKING PATHS FOR EXCIANGE MESSAGES
Global $_AuThread_MainPath = @TempDir & "\AutoitThread\" & @ScriptName & "\" ;[TO BE CONFIGURED !!!CAN'T!!! BE CHANGED DURING EXEC]
Global $_AuThread_WorkPath = @TempDir & "\AutoitThread\" & @ScriptName & "\" ;[TO BE CONFIGURED !!!CAN'T!!! BE CHANGED DURING EXEC]


;EXCIANGE FILES ELEMENTS
Global $_AuThread_SlaveMsgFile = "Slave.Threadmsg" ;[TO BE CONFIGURED !!!CAN'T!!! BE CHANGED DURING EXEC]
Global $_AuThread_MasterMsgFile = "Master.Threadmsg" ;[TO BE CONFIGURED !!!CAN'T!!! BE CHANGED DURING EXEC]
Global $__AuThrd_LockPrefix = ".lock" ;[TO BE CONFIGURED !!!CAN'T!!! BE CHANGED DURING EXEC]
Global $__AuThrd_ThreadClosed = "_Clo§ed" ;[TO BE CONFIGURED !!!CAN'T!!! BE CHANGED DURING EXEC]
Global $__AuThrd_DebugActive = False ;									;[TO BE CONFIGURED CAN BE CHANGED DURING EXEC]
Global $__AuThrd_MaxKbFile = 50 ;[TO BE CONFIGURED CAN BE CHANGED DURING EXEC]		SIZE AFTER CLOSE & CREATE NEW FILE
Global $__AuThrd_StartTime = TimerInit() ;							;[!DONT CHANGE DURING EXECUTION]

;PRECESS IDS/PIDS
Global $_AuThread_ImMaster = False ;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThread_Master_Pid = @AutoItPID ;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThread_CurrentSlaveAlive = 0 ;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThread_ExitIfMainNotAlive = True ;[TO BE CONFIGURED CAN BE CHANGED DURING EXEC]

;PIDs COMUNICATION
Global $_AuThread_MSGPointer ;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThread_PendingReadMSG ;												;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThread_NumberSlaveAlive = 0 ;[!!!DONT CHANGE DURING EXECUTION]

;GENERAL SW USED VARS
Dim $_AuThread_MSGPointer[2] = [1, 0] ;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThrd_MasterMsgs = ObjCreate("Scripting.Dictionary") ;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThrd_MasterPointers = ObjCreate("Scripting.Dictionary") ;[!!!DONT CHANGE DURING EXECUTION]
Global $__AuThrd_CloseRequest ;[!!!DONT CHANGE DURING EXECUTION]
Dim $__AuThrd_CloseRequest[0] ;[!!!DONT CHANGE DURING EXECUTION]
Global $_AuThrd_AliveThreadName = "" ;[!!!DONT CHANGE DURING EXECUTION]
;================================================================================================================================
#EndRegion #VARIABLES#


; USER CURRENT# =====================================================================================================================
;PRIMARY PUBLIC
;_AuThread_Startup
;_AuThread_StartThread
;_AuThread_SendMsg
;_AuThread_ReadNewMsg
;__AuThread_CheckMainAlive
;NO COMMON PUBLIC
;__AuThread_RefreshAliveThreads
;__AuThread_OnExit
;___DBG_Writeline
;================================================================================================================================

#Region #PUBLIC FUNCS#
; #PUBLIC FUNC# ===========================================================================================================
; Name...........: _AuThread_Startup
; Description ...: Startup MultyThreading system
; Fields ........: $DEBUG 				- =TRUE enable log files =FALSE no log files
;                  $EraseAllSession		- =TRUE close all previews session of same sw (deleting msg folders) =FALSE keep alive sessions using same sw.
; Author ........: King Paic
; Remarks .......: Session files is located in $_AuThread_MainPath
; =========================================================================================================================
Func _AuThread_Startup($DEBUG = False, $EraseAllSession = True)
	;sebug startup
	$__AuThrd_DebugActive = $DEBUG
	If $__AuThrd_DebugActive Then
		$_AuThread_SlaveMsgFile = $_AuThread_SlaveMsgFile & ".txt"
		$_AuThread_MasterMsgFile = $_AuThread_MasterMsgFile & ".txt"
	EndIf

	;REGISTER EXIT FUNCTION
	OnAutoItExitRegister("__AuThread_OnExit")
	;SLAVE
	If $CmdLine[0] = 4 And $CmdLine[1] = "--au-thread" Then
		$_AuThread_Master_Pid = $CmdLine[3]
		__AuThread_InitSlave($_AuThread_MainPath, $_AuThread_Master_Pid)
		AdlibRegister("__AuThread_CheckMainAlive", 500)
		If $CmdLine[4] = "false" Then
			TraySetState(2)
		EndIf
		Call($CmdLine[2])
		Exit
	Else
		;MASTER

		$_AuThread_ImMaster = True ;
		__AuThread_InitMaster($_AuThread_MainPath, $EraseAllSession)
		AdlibRegister("__AuThread_RefreshAliveThreads", 1000)

	EndIf

	Return $_AuThread_MainPath
EndFunc   ;==>_AuThread_Startup
; #PUBLIC FUNC# ===========================================================================================================
; Name...........: _AuThread_StartThread
; Description ...: Start new thread
; Fields ........: $sCallback 				- Name of func of main script where is contained single thread code
;                  $MainThreadId			- PID of master thread
;				   $MainThreadId			- show icon in icon box
; Author ........: King Paic
; Remarks .......:
; ==========================================================================================================================
Func _AuThread_StartThread($sCallback, $MainThreadId, $ShowIcon = False)
	Local $iPID
	If @Compiled Then
		$iPID = Run(@ScriptFullPath & ' --au-thread "' & $sCallback & '" "' & $MainThreadId & '" "' & $ShowIcon & '"')

	Else
		$iPID = Run(@AutoItExe & ' "' & @ScriptFullPath & '" --au-thread "' & $sCallback & '" "' & $MainThreadId & '" "' & $ShowIcon & '"')
	EndIf

	Return $iPID
EndFunc   ;==>_AuThread_StartThread
; #PUBLIC FUNC# ===========================================================================================================
; Name...........: _AuThread_SendMsg
; Description ...: Send MSG to another thread or to all threads
; Fields ........: $msg 					- Body (text) of msg
;                  $SpecificThread			- PID specific thread where send msg, if is -1 then send to all alive threads
; Author ........: King Paic
; Remarks .......:
; ==========================================================================================================================
Func _AuThread_SendMsg($msg, $SpecificThread = -1)

	If $_AuThread_ImMaster Then
		;;master msg
		;single slave msg
		If $SpecificThread <> -1 Then
			$msgfile = $_AuThread_MainPath & $SpecificThread
			If FileExists($msgfile) Then
				$msgfile = $_AuThread_MainPath & $SpecificThread & "\" & $_AuThread_MasterMsgFile
				;MsgBox(0,"",$msgfile)
				__MsgSender($msgfile, $msg, 500, "Master send MSG to " & $SpecificThread)
			EndIf
		Else
			;msg to all
			__AuThread_RefreshAliveThreads()
			For $i = 1 To $_AuThread_CurrentSlaveAlive[0]
				$msgfile = $_AuThread_WorkPath & "\" & $_AuThread_CurrentSlaveAlive[$i]
				If FileExists($_AuThread_MainPath & $_AuThread_CurrentSlaveAlive[$i]) And $_AuThread_CurrentSlaveAlive[$i] <> "" Then
					$msgfile = $_AuThread_WorkPath & $_AuThread_CurrentSlaveAlive[$i] & "\" & $_AuThread_MasterMsgFile
					__MsgSender($msgfile, $msg, 500, "Master send MSG to " & $_AuThread_CurrentSlaveAlive[$i])
					___DBG_Writeline($_AuThread_CurrentSlaveAlive[$i] & " Master Write:" & $msg)
				EndIf
			Next
		EndIf

	Else

		;;slave msg


		__MsgSender($_AuThread_WorkPath & $_AuThread_SlaveMsgFile, $msg, 500, "Slave Send Msg To Master")
	EndIf

EndFunc   ;==>_AuThread_SendMsg
; #PUBLIC FUNC# ===========================================================================================================
; Name...........: _AuThread_ReadNewMsg
; Description ...: Read his missing MSG queue from other threads
; Fields ........: $SpecificThread 			- PID of specific thread where you want read read queue, if is -1 is reading queue from all thread
; Author ........: King Paic
; Remarks .......: IS RETURNING AN ARRAY  WHERE [0] IS THE SENDER PID [1] IS THE MSG
; ==========================================================================================================================
Func _AuThread_ReadNewMsg($SpecificThread = -1)
	$SpecificThread = String($SpecificThread)
	If $_AuThread_ImMaster Then
		AdlibUnRegister("__AuThread_RefreshAliveThreads")
		__AuThread_RefreshAliveThreads()
		;;--------------------MASTER MSG READ-------------------------
		;single slave msg
		If ($SpecificThread <> -1) Then
			$slavefile = $_AuThread_WorkPath & $SpecificThread & "\" & $_AuThread_SlaveMsgFile
			If __islocked($slavefile) Then
				SetError(-1)
				Return -1
			EndIf

			$filepointer = $_AuThrd_MasterPointers.item($SpecificThread)
			$MsgQueue = __MsgReader($slavefile, $filepointer, 500, "Master read SINGLE")
			$_AuThrd_MasterPointers.item($SpecificThread) = $MsgQueue[0]
			;i read last msg because the process is closed
			__DeleteClosed_SlavePid($SpecificThread)
			If UBound($MsgQueue[1]) > 0 Then
				$_AuThrd_MasterMsgs.item($SpecificThread) = $MsgQueue[1]
				AdlibRegister("__AuThread_RefreshAliveThreads", 1000)
				Return $MsgQueue[1]
			Else
				$_AuThrd_MasterMsgs.item($SpecificThread, "")
				AdlibRegister("__AuThread_RefreshAliveThreads", 1000)
				Return ""

			EndIf

		Else
			;ALLSLAVE slave msg
			Dim $ALLMSQUEUE[0]  ;
			$NewMsgfromPid = 0
			For $i = 1 To $_AuThread_CurrentSlaveAlive[0]
				$msgfile = $_AuThread_WorkPath & $_AuThread_CurrentSlaveAlive[$i]
				If FileExists($_AuThread_MainPath & $_AuThread_CurrentSlaveAlive[$i]) Then
					$slavefile = $_AuThread_WorkPath & $_AuThread_CurrentSlaveAlive[$i] & "\" & $_AuThread_SlaveMsgFile
					If __islocked($slavefile) Then
						$_AuThrd_MasterMsgs.item($_AuThread_CurrentSlaveAlive[$i]) = -1
					EndIf
					$filepointer = $_AuThrd_MasterPointers.item($_AuThread_CurrentSlaveAlive[$i])
					$MsgQueue = __MsgReader($slavefile, $filepointer, 500, "Master read ALL")
					$_AuThrd_MasterPointers.item($_AuThread_CurrentSlaveAlive[$i]) = $MsgQueue[0]
					;i read last msg because the process is closed
					__DeleteClosed_SlavePid($_AuThread_CurrentSlaveAlive[$i])
					If UBound($MsgQueue[1]) > 0 Then
						$_AuThrd_MasterMsgs.item($_AuThread_CurrentSlaveAlive[$i]) = $MsgQueue[1]
						$NewMsgfromPid = $NewMsgfromPid + 1 ;
						ReDim $ALLMSQUEUE[$NewMsgfromPid][2]
						$ALLMSQUEUE[($NewMsgfromPid - 1)][0] = $_AuThread_CurrentSlaveAlive[$i]
						$ALLMSQUEUE[($NewMsgfromPid - 1)][1] = $MsgQueue[1]
					EndIf
				EndIf
			Next
			;no one reads
			If $NewMsgfromPid = 0 Then
				$ALLMSQUEUE = -1
			EndIf
			$_AuThread_PendingReadMSG = $ALLMSQUEUE
			AdlibRegister("__AuThread_RefreshAliveThreads", 1000)
			Return $_AuThread_PendingReadMSG
		EndIf



	Else

		;;--------------------SLAVE MSG READ-------------------------
		If __islocked($_AuThread_WorkPath & $_AuThread_MasterMsgFile) Then
			SetError(-1)
			Return -1
		EndIf
		$MsgQueue = __MsgReader($_AuThread_WorkPath & $_AuThread_MasterMsgFile, $_AuThread_MSGPointer, 500, "Slave Read")
		$_AuThread_MSGPointer = $MsgQueue[0]
		If UBound($MsgQueue[1]) > 0 Then
			Return $MsgQueue[1]
		Else
			Return ""
		EndIf

	EndIf

EndFunc   ;==>_AuThread_ReadNewMsg
; PUBLIC FUNC =============================================================================================================
; Name...........: __AuThread_CheckMainAlive
; Description ...: USED ONLY BY SLAVES is used to check if main PID is alive or not
; Fields ........: $exitifnot 			- =TRUE start safe exiting sequence =FALSE return only FALSE if noth exist or TRUE is existing
; Author ........: King Paic
; Remarks .......:
; ==========================================================================================================================
Func __AuThread_CheckMainAlive()
	If Not ProcessExists($_AuThread_Master_Pid) Then
		___DBG_Writeline("Main Die")
		If $_AuThread_ExitIfMainNotAlive Then
			__AuThread_OnExit()
		Else
			Return False
		EndIf
	EndIf
	Return True
EndFunc   ;==>__AuThread_CheckMainAlive
#EndRegion #PUBLIC FUNCS#

#Region PUBLIC BUT NO COMMON FUNCS
; NO COMMON func ===========================================================================================================
; Name...........: __AuThread_RefreshAliveThreads
; Description ...: Check and refresh the list of alive threads SLAVES
; Author ........: King Paic
; Remarks .......: $_AuThread_CurrentSlaveAlive is returning array of all PID of alive SLAVES
; ==========================================================================================================================
Func __AuThread_RefreshAliveThreads()
	Local $pathtocheck = StringLeft($_AuThread_MainPath, StringLen($_AuThread_MainPath) - 1)
	;MsgBox(0,"",$pathtocheck,0.5)
	$__AuThrd_CloseRequest = ""
	Dim $__AuThrd_CloseRequest[0]
	$_AuThread_NumberSlaveAlive = 0
	$_AuThread_CurrentSlaveAlive = _FileListToArray($pathtocheck, "*.", 2)
	Dim $_AuThrd_AliveThreadName[0]
	; _ArrayDisplay($_AuThread_CurrentSlaveAlive)
	If IsArray($_AuThread_CurrentSlaveAlive) Then
		For $i = 1 To $_AuThread_CurrentSlaveAlive[0]
			; _ArrayDisplay($_AuThread_CurrentSlaveAlive)
			;doublecheck process exist
			$processname = _ProcessGetName($_AuThread_CurrentSlaveAlive[$i])
			$dirlosed = StringInStr($_AuThread_CurrentSlaveAlive[$i], $__AuThrd_ThreadClosed) <> 0
			If (Not ProcessExists($_AuThread_CurrentSlaveAlive[$i]) Or Not ($processname = @ScriptName Or StringInStr(StringLower($processname), "autoit") <> 0) Or $dirlosed) Then
				;process closed or folder is closed
				ReDim $__AuThrd_CloseRequest[UBound($__AuThrd_CloseRequest) + 1]
				$__AuThrd_CloseRequest[UBound($__AuThrd_CloseRequest) - 1] = $_AuThread_CurrentSlaveAlive[$i]
				$_AuThread_CurrentSlaveAlive[$i] = StringReplace($_AuThread_CurrentSlaveAlive[$i], $__AuThrd_ThreadClosed, "")
			Else
				$_AuThread_NumberSlaveAlive = $_AuThread_NumberSlaveAlive + 1
				$_AuThread_CurrentSlaveAlive[$i] = StringReplace($_AuThread_CurrentSlaveAlive[$i], $__AuThrd_ThreadClosed, "")
				ReDim $_AuThrd_AliveThreadName[UBound($_AuThrd_AliveThreadName) + 1]
				$_AuThrd_AliveThreadName[UBound($_AuThrd_AliveThreadName) - 1] = $_AuThread_CurrentSlaveAlive[$i]
				;;ADDING NEW SLAVE (close when read msg*)
				If Not $_AuThrd_MasterMsgs.Exists($_AuThread_CurrentSlaveAlive[$i]) Then
					Dim $pointer[2] = [1, 0]
					$_AuThrd_MasterPointers.Add(($_AuThread_CurrentSlaveAlive[$i]), $pointer)
					$_AuThrd_MasterMsgs.Add(($_AuThread_CurrentSlaveAlive[$i]), "")
				EndIf
			EndIf
		Next
		;_ArrayDisplay($_AuThread_CurrentSlaveAlive)
	Else
		Dim $_AuThread_CurrentSlaveAlive[1] = [0]
	EndIf
	If Not IsArray($_AuThread_CurrentSlaveAlive) Then
		Dim $_AuThread_CurrentSlaveAlive[1] = [0]
	EndIf

	Return $_AuThread_CurrentSlaveAlive[0]
EndFunc   ;==>__AuThread_RefreshAliveThreads
; NO COMMON func ===========================================================================================================
; Name...........: ___DBG_Writeline
; Description ...: Write some debug string using internal debugging files
; Fields ........: 	$text 			- Text to log
;					$destfile 		- Possible different file where write log
; Author ........: King Paic
; Remarks .......:
; ==========================================================================================================================
Func ___DBG_Writeline($text, $destfile = "")
	If $__AuThrd_DebugActive Then
		ConsoleWrite($text & @CR) ;
		If $destfile = "" Then
			FileWriteLine($_AuThread_MainPath & "_Log.txt", @MSEC & "." & @SEC & "." & @MIN & "." & @HOUR & "." & @YDAY & "@" & @AutoItPID & ":		" & $text)
		Else
			FileWriteLine($_AuThread_MainPath & $destfile & "_Log.txt", @MSEC & "." & @SEC & "." & @MIN & "." & @HOUR & "." & @YDAY & "@" & @AutoItPID & ":		" & $text)
		EndIf
	EndIf
EndFunc   ;==>___DBG_Writeline
#EndRegion PUBLIC BUT NO COMMON FUNCS


; private func ===========================================================================================================
; Name...........: __AuThread_InitMaster
; Description ...: Init master therad msg system & values
; Author ........: King Paic
; Remarks .......: is form _AuThread_Startup who decide if is master o slave
; ==========================================================================================================================
Func __AuThread_InitMaster($MainPath, $eraseSesion = True)
	If $eraseSesion Then
		$rem = DirRemove($_AuThread_MainPath, 1)
		If $rem = 0 And FileExists($_AuThread_MainPath) Then
			MsgBox(16, "Can't reset folder", "I can't delete:" & $_AuThread_MainPath)
		EndIf
	EndIf
	$_AuThread_MainPath = $MainPath & @AutoItPID
	DirRemove($_AuThread_MainPath, 1)
	If Not FileExists($_AuThread_MainPath) Then
		DirCreate($_AuThread_MainPath)
	EndIf
	$_AuThread_MainPath = $_AuThread_MainPath & "\"
	$_AuThread_WorkPath = $_AuThread_MainPath
EndFunc   ;==>__AuThread_InitMaster
; private func ===========================================================================================================
; Name...........: __AuThread_InitSlave
; Description ...: Init master therad msg system & values
; Author ........: King Paic
; Remarks .......: is form _AuThread_Startup who decide if is master o slave
; ==========================================================================================================================
Func __AuThread_InitSlave($MainPath, $MasterId)
	$_AuThread_MainPath = $MainPath & $MasterId
	$_AuThread_WorkPath = $MainPath & $MasterId & "\" & @AutoItPID
	DirRemove($_AuThread_WorkPath, 1)
	;reinit if just existing foolder
	If FileExists($_AuThread_WorkPath) Then
		DirRemove($_AuThread_WorkPath, 1)
	EndIf
	;MsgBox(0,"",$_AuThread_WorkPath)
	DirCreate($_AuThread_WorkPath)
	$_AuThread_WorkPath = $_AuThread_WorkPath & "\"
	; _AuThread_SendMsg("ALIVE"&@MSEC&"."&@SEC&"."&@min&"."&@HOUR&"."&@YDAY&"@"&@AutoItPID)
EndFunc   ;==>__AuThread_InitSlave



#Region PRIVATE FUNCTION / CORE
; private func ===========================================================================================================
; Name...........: __AuThread_OnExit
; Description ...: close propely threads
; Author ........: King Paic
; Remarks .......:
; ==========================================================================================================================
Func __AuThread_OnExit()
	Local $pathtocheck = StringLeft($_AuThread_WorkPath, StringLen($_AuThread_WorkPath) - 1)
	If Not $_AuThread_ImMaster Then
		If $__AuThrd_DebugActive Then
			___DBG_Writeline(@AutoItPID & " CUTTED OF")
			_AuThread_SendMsg(@AutoItPID & "	EXIT:" & @MSEC & "." & @SEC & "." & @MIN & "." & @HOUR & "." & @YDAY & "	After:" & TimerDiff($__AuThrd_StartTime) / 1000 & "s")
			DirMove($pathtocheck, $pathtocheck & $__AuThrd_ThreadClosed, 1)
		Else
			;DirRemove($pathtocheck,1)
		EndIf
	EndIf
	Exit
	ProcessClose(@AutoItPID)
EndFunc   ;==>__AuThread_OnExit

;MESSAGE SENDER CORE
Func __MsgSender($file, $msg, $TimeForceskypIfLocked = 500, $LockReason = "")
	__WaitEndLockFile($file, $TimeForceskypIfLocked, $LockReason)
	__ResetFileIfToobig($file, $__AuThrd_MaxKbFile)
	$msg = StringReplace($msg, @CR, "§")
	$msg = StringReplace($msg, @CRLF, "§")
	FileWriteLine($file, $msg)
	__Unlock($file)
EndFunc   ;==>__MsgSender
;MAG READER CORE
Func __MsgReader($file, $curentPointer, $TimeForceskypIfLocked = 500, $LockReason = "")
	Dim $return[2] = [$curentPointer, ""] ;
	Dim $msgs[0]
	$filesize = FileGetSize($file) / 1024
	If $filesize <> $curentPointer[1] And Not @error Then

		If $filesize < $curentPointer[1] Then
			$curentPointer[0] = 1
			If IsArray($_AuThread_PendingReadMSG) Then
				ReDim $_AuThread_PendingReadMSG[0]
			Else
				Dim $_AuThread_PendingReadMSG[0]
			EndIf
		Else
			$curentPointer[1] = $filesize
			;resetted file start from begin
		EndIf

		;read all pending msg readin each line
		__WaitEndLockFile($file, $TimeForceskypIfLocked, $LockReason)
		While (True)
			$msg = FileReadLine($file, $curentPointer[0])
			If Not @error Then
				$msg = StringReplace($msg, "§", @CRLF)
				ReDim $msgs[UBound($msgs) + 1]
				$msgs[UBound($msgs) - 1] = $msg
				$curentPointer[0] = $curentPointer[0] + 1  ;
			Else
				ExitLoop
			EndIf
		WEnd
		__Unlock($file)


		$return[0] = $curentPointer
		$return[1] = $msgs
	EndIf
	Return $return
EndFunc   ;==>__MsgReader

;WAIT UNLOCK SPECIFIC FILE FOR BE WRITTEN
Func __WaitEndLockFile($file, $TimeForceskyp = 500, $reason = "")
	Local $time = TimerInit()
	Local $lockFile = $file & $__AuThrd_LockPrefix
	If $__AuThrd_DebugActive Then
		$lockFile = $lockFile & ".txt"
	EndIf
	While (FileExists($lockFile))
		If (TimerDiff($time) > $TimeForceskyp) Then
			___DBG_Writeline("!FORCE UNLOCK!		" & $file & "			" & $reason)
			FileDelete($lockFile)
			ExitLoop
		EndIf
		Sleep(10 + Random(10))
	WEnd
	FileWrite($lockFile, $reason)
EndFunc   ;==>__WaitEndLockFile

;UNLOC FILE
Func __Unlock($file)
	Local $lockFile = $file & $__AuThrd_LockPrefix
	If $__AuThrd_DebugActive Then
		$lockFile = $lockFile & ".txt"
	EndIf
	FileDelete($lockFile)
EndFunc   ;==>__Unlock

;CHECK IF FILE IS LOCKED
Func __islocked($file)
	Local $lockFile = $file & $__AuThrd_LockPrefix
	If $__AuThrd_DebugActive Then
		$lockFile = $lockFile & ".txt"
	EndIf

	Return FileExists($lockFile) Or Not FileExists($file)
EndFunc   ;==>__islocked
;RESET FILE IF IS TOO BIG
Func __ResetFileIfToobig($file, $limitkb)
	If (FileGetSize($file) / 1024) > $limitkb Then
		Return FileDelete($file)
	EndIf
	Return False
EndFunc   ;==>__ResetFileIfToobig

;DELETED FIES RELATIVE TO CLOSED PID
Func __DeleteClosed_SlavePid($pid)
	If Not $__AuThrd_DebugActive Then
		$find = _ArraySearch($__AuThrd_CloseRequest, $pid)
		; _ArrayDisplay($__AuThrd_CloseRequest)
		If $find > -1 Then
			DirRemove($_AuThread_WorkPath & $pid, 1)
			; MsgBox(0,"remove",$_AuThread_WorkPath&$pid)
			If $_AuThrd_MasterMsgs.Exists($pid) Then
				$_AuThrd_MasterMsgs.Remove($pid)
				$_AuThrd_MasterPointers.Remove($pid)
			EndIf
		EndIf

	EndIf
EndFunc   ;==>__DeleteClosed_SlavePid
#EndRegion PRIVATE FUNCTION / CORE
