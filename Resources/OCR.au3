
#CS
	FUNCTIONS
	_OCR() - the main routine
	... lots of other little functions called by _OCR or used as a library
	debugStep() - routine used to ease debugging - unfotunately output doesn't seem as stable as I'd expect - possibly something funny with AutoIt
	Mark_Rect() - used by mouseOCR to define the window to recognise
	learnFonts() - displays the characters in an autoit window then uses the OCR to automatically learn them
	learnCharsWithWord() - autolearn, but using Microsoft Word, not quite so robust, but sometimes characters in Word had different pixels despite being nominally the same typeface/style
	mouseOCR() - call this to mark an area on the screen and OCR it.
	cleanFontDataFile() - call this to remove error codes from the font data file

	EXAMPLES
		mouseOCR()
		ConsoleWrite( _OCR(210, 195, 400, 215))		; Title
		_OCR(349, 366, 714, 455)		; Part Body
		_OCR(349, 366, 714, 949)		; Entire Body
		ConsoleWrite( _OCR(0, 0, @DesktopWidth, @DesktopHeight))		; Entire Desktop

		$curText = mouseOCR()
		InputBox("", $curText, $curText)
		_OCR(20,161,1254,970,$ocrOptMatchForeground + $ocrOptMatchBrightness)			; page of text in Word
		$text = _OCR(281,84,1000,97,-0x45597C, 100)
		$blackPix = 0.1
		$text = _OCR(281,84,1000,97,-$blackPix, 100)	; NB black background can be any number between 0 and -1
		; If searchColour is +ve a pixel will be considered part of the foreground (character) if it matches the supplied (foreground) colour,
		;   if searchColour is -ve the pixel will be part of the foreground (character) if it does NOT match the supplied (background) colour

	OPTIONS (documented from approx line 134)
		Default OCR options are set with $ocrDefaultOptions (approx line 174) just above _OCR() definition
		$ocrOptDontAskForMatch,
		$ocrOptDontSaveErrors,
		$ocrOptDontSaveWindowWithFont,
		$ocrOptIgnoreUnderStrike,
		$dontMatchCharsInSplit,
		$ocrOptDontSplitBlock
		...



;learnFonts()


	HISTORY
	Optical Character Recognition system for screen text under Autoit
	2011 July, 04th civilcalc
		original code/topic started [from http://www.autoitscript.com/forum/topic/130046-autoit-ocr-without-3rd-party-software/]
	2012 Sept, 30th: David Mckenzie (dgm5555)
		civilcalc code updated and various coding bugs corrected (not usable as was)
		added _learnCharsWithWord to somewhat automate learning fonts
		and _mouseOCR to allow simpler definition of OCR zone
	2012 Oct, 29th: David Mckenzie (dgm5555)
		Almost total rewrite to improve speed and features (especially instant screen grab, fast algorithms for black/white text or backgrounds
		Redesign of fontdata file structure
	2012 Dec, 7th: David Mckenzie:-
		Bugs corrected from 121029 rewrite
		Moves mouse quickly out of the way and back when grabbing screen
		Additional options added (dontpromptuser, saveerrors, etc)
		Threshold option replaces black/white (this will skip checking the upper/lower bound if not required, and is only marginally slower than the fixed black/white version
		Improved block splitting for recognising characters without space between them
		Will now recognised multiple lines of text providing there are no vertical lines joining horizontal text lines (eg tables)
		Added some adjustment for vertical position of a character, so ' and , won't be confused so often
		   (also assume that two '' (single quotes) are a single " (double quote) as this is more likely to occur than the reverse)
		Various other bits I can't remember now.
		A number of the functions at the end are now redundant (as function calls are quite slow in AutoIt), but have been left for portability/library purposes.
	2013 Nov, 12th: David Mckenzie:-
		Added an autoclean to remove error lines from the font data file (as this gets too large it slows the OCR)
		Added option to save a log of recognised characters which could be used to directly save data, or to optomise order of characters in the font data file
		Modified default options based on the forum comments to stop trying to identify underlined characters by default

	OPTIONS FOR IMPROVEMENT
		recognise underlined characters even within a line  - eg so an isolated word will still be recognised
		recognise italics
		figure out an efficient way to check if there are tooltips/menus/etc over the space to be recognised (which currently distort checking for characters)
		see down below under problems for more thoughts.

	WHAT DOES IT DO?
	The basic concept is as follows;
	Pick a line of text to be scanned, the tighter the area, the better it performs.
	The bounding box is then shrunk to exclude any whitespace at the edges.
	If the entire row of lowermost pixels is active, then it is assumed the line has an underline
	this row will therefore be ignored.
	An array is then created with the same number of elements as the width of the selection, and
	filled with a binary representation of each column
	Pixelsearch is used to check each pixel in the first vertical line.
	If a pixel is not of the background colour (specIfied as $searchColour and variation by $searchColourVariation)
	then it is assigned a value: the uppermost pixel is considered to be worth 1, the next pixel 2, then 4, 8, 16 etc.
	Once each column is summed the next is checked.
	After the summation process any whitespace above each individual character is removed, so it can still
	be recognised If it's together with characters taller or shorter than it.
	so the character;
	pre   &    post removal of blank rows above
	01  ~~~~~
	02  ~###~  01
	04  ~#~#~  02
	08  ~###~  04
	16  ~#~#~  08
	32  ~#~#~  16
	64  ~~~~~  32
	would produce an array of 31|5|31

	the array is checked from the file $font, If it already exists, it returns the character A or it asks for a definition and saves the result.
	the database format is one line for each character/block with the saved letter/s preceding the @
	n@ 127|2|1|1|126 @

	PROBLEMS:
	It's relatively slow -
	Average is about 10msec per 5x10pixel character
	However to compensate for this it's more accurate than Tesseract or MODI based OCR for screen text.
	Characters must be divided from each other by a column of whitespace. If they are not, they will have to be learnt as pairs/triples, etc.
	Kerned fonts can thus be a bit of a nuisance (eg 'f' and 't' will often have to be learnt as a block with another character
	The script includes code which scans unrecognised blocks to see if they're made up of previously learnt characters and assumes a split
	  however this can mean some characters are recognised as components of others (eg the first half of w might be recognised as v)
	Italic fonts are also not feasible to learn with the script as it is
		A possible fix for this would be to find a tall straight letter such as |, I, l, D or B and use this to calculate the row offset (relative to base row) and compensate for this when using PixelSearch to build the array, or alternatively (but probably with more errors) just use a standard slant angle and calculate pixel corrections based on this.
	Single characters with a blank vertical line internally will be seen as two characters (eg quote {"})
	Spaces aren't always recognised correctly - depending on the size of the gap between characters.
	Underline isn't handled robustly, and some characters (eg _ or -) may be seen as if they are underlined if they are recognised alone, and are more than one pixel row thick
	Characters with the same shape, but different vertical positioning will be confused (eg {'} and {,} in some fonts
#CE

#include-once
#include <_PixelGetColor.au3>	; needed for screen capture to memory and pixel examination
#include <GUIConstantsEx.au3>	; used by learnFonts and mouseOCR for GUI windows
#include <Misc.au3>			; needed for mousepress trapping in mark_Rect called by mouseOCR
#include <WindowsConstants.au3>	; used by mark_Rect called by mouseOCR
;#include <SciTE UDF.au3>	; needed for moving to correct line in SciTE when debugging


Global $debugCode = 2
AutoItSetOption("TrayIconDebug", 1)

Global Const $blackPix = 0.1, $whitePix = 0xFFFFFF
Global Const $ocrOptMatchBackground = 0, $ocrOptMatchForeground = 1 ; Does search colour indicate a foreground or background colour

Global Const $ocrOptMatchBrightness = 8		;}	[8=experimental]
Global Const $ocrOptMatchThreshold = 16		;}   Choose which algorithm to use for selecting a pixel
Global Const $ocrOptMatchBox = 32 			;}   colour to be part of the foreground text, or the background
											;}	system will autoselect 16 or 32 depending on $searchColour and $searchColourVariation
Global Const $ocrOptMatchSphere = 64 		;}	[64=function removed, but spaceholder in case decide to reinstate]

Global Const $ocrOptTraining = 128			;} [not yet implemented, set $ocrTrainChar by passing parameter instead]
											;} 	$ocrTrainChar allows a character to be automatically associated with the first recognised character in a block of text
											;} 	If you want to operate in batch mode (and ignore any unknown characters), set $ocrTrainChar = -1
											;} 	If $ocrTrainChar is not set, then an input box will be displayed requesting the value of any unknown characters
											;} 	Opt("PixelCoordMode",$param) determines what relative coordinates are referenced (used by PixelSearch)


Global Const $ocrOptDontAskForMatch = 256			;} DONT: popup a message to ask the user if a character isn't recognised
Global Const $ocrOptDontSaveErrors = 1024			;} DONT: ask the user if a character isn't recognised

Global Const $ocrOptDontSplitBlock = 2048	; DONT: attempt to improve guesses by splitting blocks - this can be inaccurate if small characters (eg ') are allowed. You can disallow these from matching a split with $dontMatchCharsInSplit
Global Const $dontMatchCharsInSplit = "',.lI1" ; These characters are too small and tend to cause errors if matched when splitting blocks, so ignore them.

Global Const $ocrOptIgnoreUnderStrike = 4096	; DONT: learn a whole new set of characters if they have underline/strikethrough
												; (this currently
Global Const $ocrOptColourAverage = 8192 ;  calculate an average colour and use this for the threshold (assume colour represents foreground or background based on $ocrOptMatchForeground/$ocrOptMatchBackground)
											;currently not implemented as quite slow.
Global Const $ocrOptDontSaveWindowWithFont = 16384	;  DONT: record the title of a window against a newly learnt character
													; This is only for user information, and isn't used in character recognition, so only benefit would be to reduce file size
Global Const $ocrOptSaveCharacterLog = 32768	;  DO: record all characters recognised
													; This file might be useful if you wish to have a large font database and wish to sort the characters to optomise recognition speed
Global Const $ocrOptAutoCleanFontData = 65536	;  DO: automatically clean the font data file if it is too large
Global $fontFilesChecked=""				; list of font data files checked for size
Global $fontFileSizeWarning=100000		; max size before considering cleaning font files

Global Const $maxCharWidth=30		; If the system doesn't recognise a character wider than this and gets to the stage of prompting the user
									; the script will throw an error and exit
									; This reduces the risk of menus/popups/tooltips etc being on top of a region to be recognised


;; Comment out the options you wish to use.
;Defaults for learning characters
Global $ocrDefaultOptions = $ocrOptMatchForeground
;Defaults for learning characters single characters (as long as no underline or strikethrough)
;Global $ocrDefaultOptions = $ocrOptMatchForeground + $ocrOptIgnoreUnderStrike
;Defaults once learning is stable and all characters are known
;Global $ocrDefaultOptions = $ocrOptMatchForeground + $ocrOptDontAskForMatch + $ocrOptDontSaveErrors + $ocrOptAutoCleanFontData

Func _OCR($left, $top, $right, $bottom, $searchColour = 0x000000, $searchColourVariation = 100, $fontFile = "", $ocrTrainChar = "", $ocrOptions = $ocrDefaultOptions)

	; NB setting search colour <0 will make it the background colour
	;	msgbox(1,"","check ocr options")
	Local $grabWidth = 0, $grabHeight = 0
	Local $blankBlockCount = 0, $blankColCnt = 0, $avBlankWidth = 0, $newBlank = 0, $topRowInLine = 0, $bottomRowInLine = 0, $lineHeight = 0, $lineWidth = 0, $tempVal = 0
	Local $letter = "", $data = "", $dataAll = ""
	Local $charStartPos = 0, $charEndPos = 0, $leftMostCol = 0, $rightMostCol = 0
	Local $a = 0, $x = 0, $y = 0
	Local $partLetterStart = 0, $partLetterEnd = 0, $partLetterMax = 0, $partLetter = 0, $matchVal = 0
	Local $shadeVariation = 0, $shadeVariationCubed = 0, $blue2 = 0, $green2 = 0, $red2 = 0, $blue2min = 0, $blue2max = 0, $green2min = 0, $green2max = 0, $red2min = 0, $red2max = 0
	Local $blue2Thresh = 0, $green2Thresh = 0, $red2Thresh = 0

	Local $cumulativeLineHeight = 0, $cumulativeLineWidth = 0, $numberOfLines = 0
	Local $pixelCheckTime = 0, $pixelArrTime = 0, $pixelCount = 0

	Local Const $spaceBlankMult = 1.7, $spaceNonBlankMult = 0.7 ; Used to 'guess' the size of a space in the text - the higher the number the wider a gap must be to be considered a space
	$grabWidth = $right - $left + 1
	$grabHeight = $bottom - $top + 1
	Global $screenGrabArray[$grabWidth + 1][$grabHeight + 1]
	Global $rowArray[$grabHeight + 1]
	Global $columnArray[$grabWidth + 1]
	Global $columnWeightArray[$grabWidth + 1]

	; load the area of screen into memory
	; using _PixelGetColor functions cf pixelSearch results in approx 5% increase in speed using colourMatch
	;  and approx 20% using colourMatchWhite or colourMatchBlack.
	; However importantly it dramatically speeds up grabbing the screen and therefore reduces errors if the screen changes
	$hDll = DllOpen("gdi32.dll")
	$vDC = _PixelGetColor_CreateDC($hDll)
	$mousePosX = MouseGetPos(0)
	$mousePosY = MouseGetPos(1)
	MouseMove(@DesktopWidth, @DesktopHeight / 2, 0) ; move the mouse out the way so it isn't included in the screen shot
	$vRegion = _PixelGetColor_CaptureRegion($vDC, $left, $top, $right + 1, $bottom + 1, $hDll)
	MouseMove($mousePosX, $mousePosY, 0)

	; If $ocrTrainChar is supplied, then recognition not required
;	If $ocrTrainChar <> "" Then $ocrOptions = BitOR($ocrOptions, $ocrOptTraining)

	If NOT BitAND($ocrOptions, $ocrOptDontSaveWindowWithFont)  Then $saveWindowForFont = @TAB & WinGetTitle("[ACTIVE]")

	;	resetGlobals()

	;	ConsoleWrite ("Starting OCR..." & @CRLF)
	$startTime = TimerInit()
	If $fontFile = "" Then $fontFile = @ScriptDir & "\OCRFontData.txt"
	If StringInStr($fontFile, "\") = 0 Then $fontFile = @ScriptDir & "\" & $fontFile
	If Not FileExists($fontFile) Then
		FileWriteLine($fontFile, "**************************************" & @CRLF)
		FileWriteLine($fontFile, "****** AutoIt OCR Font Data **********" & @CRLF)
		FileWriteLine($fontFile, "**************************************" & @CRLF)
		FileWriteLine($fontFile, "Please note, if manually splitting character blocks only characters which touch the top row will be correct. Others should be deleted as they are incorrect and the system will have to recalculate them (eg in 'at' only the 't' values will be correct, but in WT both characters are probably OK" & @CRLF)
		FileWriteLine($fontFile, " " & @TAB & "-99" & @CRLF)
	Else
		If StringInStr($fontFilesChecked, $fontFile)=0 Then
			$fontFilesChecked = $fontFilesChecked & $fontFile		; mark current file as checked, so warning is only displayed once per run
			; Warn if font data file is large enough to cause problems
			$fontFileSize = FileGetSize ( $fontFile )
			If $fontFileSize > $fontFileSizeWarning Then
				If BitAND($ocrOptions, $ocrOptAutoCleanFontData) Then
					cleanFontDataFile($fontFile)
					$fontFileSize = FileGetSize ( $fontFile )
					If $fontFileSize > $fontFileSizeWarning Then
						MsgBox (1,"Warning", $fontFile & " size is " & $fontFileSize & ". This is likely to slow down OCR processing." & @CRLF & "Cleaning the font data file by removing 'junk' (error codes) has failed to reduce the size sufficiently" & @CRLF & "If you wish to increase the threshold size for this then adjust $fontFileSizeWarning in the global settings" & @CRLF & "If you wish to stop err generation in the font file then use $ocrOptDontSaveErrors")
					EndIf
				Else
					$runClean = MsgBox (1,"Warning", $fontFile & " size is " & $fontFileSize & ". This is likely to slow down OCR processing." & @CRLF & "It is recommended you clean the font data file and remove for 'junk' (error codes) - Press OK to continue" & @CRLF & "If you wish to increase the threshold size for this warning then adjust $fontFileSizeWarning in the global settings" & @CRLF & "If you wish to stop err generation in the font file then use $ocrOptDontSaveErrors")
					If $runClean = 1 Then
						cleanFontDataFile($fontFile)
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	$database = FileRead($fontFile) ;read database



	;debugStep(@ScriptLineNumber)

	; If searchColour is +ve a pixel will be considered part of the foreground (character) if it matches the supplied (foreground) colour,
	;   if searchColour is -ve the pixel will be part of the foreground (character) if it does NOT match the supplied (background) colour
	If $searchColour < 0 Then
		;debugStep(@ScriptLineNumber, "(back) $ocrOptions", $ocrOptions)
		If BitAND($ocrOptions, $ocrOptMatchForeground) Then
			$ocrOptions = BitXOR($ocrOptions, $ocrOptMatchForeground) ; $ocrOptMatchBackground = 0
		EndIf
		;debugStep(@ScriptLineNumber, "(back) $ocrOptions", $ocrOptions)
		$searchColour = -$searchColour
	Else
		;debugStep(@ScriptLineNumber, "(fore) $ocrOptions", $ocrOptions)
		$ocrOptions = BitOR($ocrOptions, $ocrOptMatchForeground) ; $ocrOptMatchForeground = 1
		;debugStep(@ScriptLineNumber, "(fore) $ocrOptions", $ocrOptions)
	EndIf
	$searchColour = Int($searchColour)


	; $searchColour should be passed to OCR in RGB format (AutoIt default), but it's quicker to process as BGR in the loop, so convert to this
	; before initialising for colourmatchbox
	;$debugcode = 0
	;debugStep(@ScriptLineNumber, "$ocrOptions", $ocrOptions)
	;debugStep(@ScriptLineNumber, "$searchColour", $searchColour, "colourRGBToBGR($searchColour)", colourRGBToBGR($searchColour), "$searchColourVariation", $searchColourVariation)
	colourMatchInit(colourRGBToBGR($searchColour), $searchColourVariation, $blue2, $blue2min, $blue2max, $green2, $green2min, $green2max, $red2, $red2min, $red2max, $shadeVariationCubed)
	$brightness2 = colourRGBtoBrightness($searchColour)
	$bright2min = $brightness2 - $searchColourVariation
	$bright2max = $brightness2 + $searchColourVariation

	;debugStep(@ScriptLineNumber, "grabTime", TimerDiff($startTime))

	; load the main array with the screen area looking for pixels different to the background colour
	; If you wanted to add a mask (to compensate for images/etc causing variable backgrounds) here would be the place to do it
	; get pixel colour in decimal BGR (code pulled from _PixelGetColour to reduce overhead from function call)
	;	Const $ocrOptMatchForeground = 1, $ocrOptMatchBlack = 2, $ocrOptMatchWhite = 4, $ocrOptMatchBox = 8, $ocrOptMatchSphere = 16, ocrOptLearnMode = 32

	; This section would be more concise if the options loop was inside, but then it would unnecessarily be tested 1000s of times
	;  by spreading the code out like this it is a bit quicker...
	; It's also quicker by removing the function calls
	If BitAND($ocrOptions, $ocrOptMatchForeground) Then
		If BitAND($ocrOptions, $ocrOptMatchBrightness) Then
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; This is BGR format	NB most of the other formulae are actually RGB with the colour channels misnamed, but because there
					;  is differential weighting of each colour channel they must must be correct here
					$blue1 = BitAND(BitShift($pixelColour, 16), 0xFF)
					$green1 = BitAND(BitShift($pixelColour, 8), 0xFF)
					$red1 = BitAND($pixelColour, 0xFF)

					; Essentially this is calculating 3D distance from black to white in the RGB cube. A slight weighting seems to give better conversion to grayscale (at least to my eye)
					$brightness1 = Int(Sqrt(0.11 * $blue1 ^ 2 + 0.1 * $green1 ^ 2 + 0.12 * $red1 ^ 2)*1.747)

					; registers a $pixelColour as part of a character if it's luminescence is greater or equal to reference luminescence
					If $brightness1 < $bright2min Or $brightness1 > $bright2max Then
						$pixelColour = False
					Else
						$pixelColour = True
					EndIf

					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		;debugStep(@ScriptLineNumber, "; box", 0)
		ElseIf $blue2max > 255 And $green2max >255 and $red2max>255 Then
			; Only need to test lower bounds
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; registers a $pixelColour as part of a character if it's within the bounds
					If BitAND($pixelColour, 0xFF) < $blue2min Then
						$pixelColour = False
					Else
						If BitAND(BitShift($pixelColour, 8), 0xFF) < $green2min Then
							$pixelColour = False
						Else
							If BitAND(BitShift($pixelColour, 16), 0xFF) < $red2min Then
								$pixelColour = False
							Else
								$pixelColour = True
							EndIf
						EndIf
					EndIf

					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		ElseIf $blue2min < 0 And $green2min <0 and $red2min<0 Then
			; Only need to test upper bounds
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; registers a $pixelColour as part of a character if it's within the bounds
					If BitAND($pixelColour, 0xFF) > $blue2max Then
						$pixelColour = False
					Else
						If BitAND(BitShift($pixelColour, 8), 0xFF) > $green2max Then
							$pixelColour = False
						Else
							If BitAND(BitShift($pixelColour, 16), 0xFF) > $red2max Then
								$pixelColour = False
							Else
								$pixelColour = True
							EndIf
						EndIf
					EndIf

					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		Else
			; Need to test both bounds
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; registers a $pixelColour as part of a character if it's within the bounds
					$blue1 = BitAND($pixelColour, 0xFF)
					If $blue1 < $blue2min Or $blue1 > $blue2max Then
						$pixelColour = False
					Else
						$green1 = BitAND(BitShift($pixelColour, 8), 0xFF)
						If $green1 < $green2min Or $green1 > $green2max Then
							$pixelColour = False
						Else
							$red1 = BitAND(BitShift($pixelColour, 16), 0xFF)
							If $red1 < $red2min Or $red1 > $red2max Then
								$pixelColour = False
							Else
								$pixelColour = True
							EndIf
						EndIf
					EndIf

					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		EndIf
	Else
		If BitAND($ocrOptions, $ocrOptMatchBrightness) Then
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; This is BGR format	NB most of the other formulae are actually using RGB naming (ie the colour channels are misnamed as it's actually BGR),
					;  but because there is a differential weighting the chanels must be correct here
					$blue1 = BitAND(BitShift($pixelColour, 16), 0xFF)
					$green1 = BitAND(BitShift($pixelColour, 8), 0xFF)
					$red1 = BitAND($pixelColour, 0xFF)

					; Essentially this is calculating 3D distance from black to white in the RGB cube. A slight weighting seems to give better conversion to grayscale (at least to my eye)
					$brightness1 = Int(Sqrt(0.11 * $blue1 ^ 2 + 0.1 * $green1 ^ 2 + 0.12 * $red1 ^ 2)*1.747)

					; registers a $pixelColour as part of a character if it's luminescence is greater or equal to reference luminescence
					If $brightness1 > $bright2min Or $brightness1 < $bright2max Then
						$pixelColour = False
					Else
						$pixelColour = True
					EndIf

					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		ElseIf $blue2max > 255 And $green2max >255 and $red2max>255 Then
			; Only need to test lower bounds
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; registers a $pixelColour as part of a character if equal to or outside the bounds
					If BitAND($pixelColour, 0xFF) > $blue2min Then
						If BitAND(BitShift($pixelColour, 8), 0xFF) > $green2min Then
							If BitAND(BitShift($pixelColour, 16), 0xFF) > $red2min Then
								$pixelColour = False
							Else
								$pixelColour = True
							EndIf
						Else
							$pixelColour = True
						EndIf
					Else
						$pixelColour = True
					EndIf


					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		ElseIf $blue2min < 0 And $green2min <0 and $red2min<0 Then
			; Only need to test upper bounds
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; registers a $pixelColour as part of a character if equal to or outside the bounds
					If BitAND($pixelColour, 0xFF) < $blue2max Then
						If BitAND(BitShift($pixelColour, 8), 0xFF) < $green2max Then
							If BitAND(BitShift($pixelColour, 16), 0xFF) < $red2max Then
								$pixelColour = False
							Else
								$pixelColour = True
							EndIf
						Else
							$pixelColour = True
						EndIf
					Else
						$pixelColour = True
					EndIf


					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		Else
			; Need to test both bounds
			;debugStep(@ScriptLineNumber, "background", 0)
			For $y = 0 To $grabHeight
				$rowArrayVar = 0
				For $x = 0 To $grabWidth
					$pixelColour = DllCall($hDll, "int", "GetPixel", "int", $vDC, "int", $x, "int", $y)		; returns BGR colour (so variable names incorrect), but this doesn't matter as long a reference colour is also BGR
					$pixelColour = $pixelColour[0]

					; registers a $pixelColour as part of a character if equal to or outside the bounds
					$blue1 = BitAND($pixelColour, 0xFF)
					If $blue1 > $blue2min And $blue1 < $blue2max Then
						$green1 = BitAND(BitShift($pixelColour, 8), 0xFF)
						If $green1 > $green2min And $green1 < $green2max Then
							$red1 = BitAND(BitShift($pixelColour, 16), 0xFF)
							If $red1 > $red2min And $red1 < $red2max Then
								$pixelColour = False
							Else
								$pixelColour = True
							EndIf
						Else
							$pixelColour = True
						EndIf
					Else
						$pixelColour = True
					EndIf


					$screenGrabArray[$x][$y] = $pixelColour
					; Accessing arrays in AutoIt seems to be a bit inefficient - a named variable seems to be 10-20 times faster
					$rowArrayVar = $rowArrayVar + $pixelColour ; count the active pixels in each row
				Next
				$rowArray[$y] = $rowArrayVar ; access the array just once every row
			Next
		EndIf
	EndIf

	_PixelGetColor_ReleaseRegion($vRegion)
	_PixelGetColor_ReleaseDC($vDC, $hDll)
	DllClose($hDll)
	$arrayGrabTime = TimerDiff($startTime)
	;		ConsoleWrite($pixelCheckTime & ", " & $pixelArrTime & " of " & $arrayGrabTime)
	$startTime = TimerInit()
	;debugStep(@ScriptLineNumber, "$arrayGrabTime", $arrayGrabTime)
	;	$debugCode = 1
	; Just for debugging purposes - output the array to the console
	;If $debugCode < 2 Then outputArray(0, 0, $grabWidth, $grabHeight, $screenGrabArray)

	For $y = 0 To $grabHeight

		Do ; loop repeatedly through this to ensure the tightest bounding boxes possible
			$yInit = $y
			$blankedSome = False

			; find the topmost non-blank line
			While $rowArray[$y] = 0
				$y = $y + 1
				If $y > $grabHeight Then ExitLoop 3 ; Finished iterating through all lines in the selected area, so return
			WEnd
			$topRowInLine = $y


			If $ocrTrainChar <> "" Then
				; if we're only learning one character you have to search for a non-blank row from the bottom, else you will mis-recognise characters
				;  with horizonal white space within them (eg : a colon)
				$y = $grabHeight
				While $rowArray[$y] = 0
					$y = $y - 1
					If $y < 1 Then ExitLoop
				WEnd
				$bottomRowInLine = $y
			Else
				; Assume that if not training to learn the font database then there will be enough characters to have at least one
				; pixel in each row occupied by the line, so identify the lower border of the line of text by the next blank row of pixels
				While $rowArray[$y] > 0
					$y = $y + 1
					If $y > $grabHeight Then ExitLoop
				WEnd
				$bottomRowInLine = $y - 1
			EndIf
			$lineHeight = $bottomRowInLine - $topRowInLine ; NB obscurely the first row is counted as zero so a normal person would add one to the line height count
			$cumulativeLineHeight = $cumulativeLineHeight + $lineHeight + 1
			$numberOfLines = $numberOfLines + 1
			;debugStep(@ScriptLineNumber, "$lineHeight", $lineHeight)

			;		sumPixels($grabWidth, $topRowInLine, $bottomRowInLine, $screenGrabArray, $columnArray, $columnWeightArray, $lineHeight)
			;create an array which contains the sum of the pixels in each column for the scan area
			For $x = 0 To $grabWidth
				$val = 0 ;reset the value to zero for next vertical line
				$p = 1
				For $y = $topRowInLine To $bottomRowInLine
					;scan each vertical line in the scan area looking for pixels different to the background colour
					If $screenGrabArray[$x][$y] Then $val = $val + $p ;create a value of the vertical line based on the pixels present
					$p = $p * 2
				Next
				$columnArray[$x] = $val ;load the value into the array
				$columnWeightArray[$x] = bitMin($val, $lineHeight + 1) ; now fill $columnWeightArray with the weight of the minimum bit for each column (so characters can be BitShifted to eliminate whitespace above them
			Next

			; figure out where the 'true' begin and end of the line are (ie ignore 'whitespace')
			$leftMostCol = 0
			While $columnArray[$leftMostCol] = 0
				$leftMostCol = $leftMostCol + 1
			WEnd
			$rightMostCol = $grabWidth
			While $columnArray[$rightMostCol] = 0
				$rightMostCol = $rightMostCol - 1
			WEnd
			$lineWidth = $rightMostCol - $leftMostCol + 1
			$cumulativeLineWidth = $cumulativeLineWidth + $lineWidth
			;debugStep(@ScriptLineNumber, "$lineHeight", $lineHeight, "$lineWidth", $lineWidth)
			; Just for debugging purposes - output the array to the console
			;If $debugCode < 2 Then outputArray($leftMostCol, $topRowInLine, $rightMostCol, $bottomRowInLine, $screenGrabArray)


			; If automatic training, then we don't have to bother with attempting to recognise the character
			;   so don't fiddle about with the rest, just write to the database file then return
			If $ocrTrainChar <> "" And $ocrTrainChar <> -1 Then
				$pattern = generateString($leftMostCol, $rightMostCol, $columnWeightArray, $columnArray)
				; Don't bother testing if the character already exists learn it anyway
				;				If Not StringInStr($database,$pattern) Then
				FileWriteLine($fontFile, $ocrTrainChar & $pattern & $saveWindowForFont & @CRLF)
				;				EndIf
				Return
			EndIf

			If False Then
				If BitAND($ocrOptions, $ocrOptIgnoreUnderStrike) = 0 Then
					; blank any rows which are (mostly) solid horizontal lines (these are likely to be strikethough or underline)
					For $y = $topRowInLine To $bottomRowInLine
						If $rowArray[$y] >= $lineWidth * 0.95 Then
							For $x = 0 To $grabWidth
								$screenGrabArray[$x][$y] = False
							Next
							$rowArray[$y] = 0
							$blankedSome = True
						EndIf
					Next
				EndIf
			EndIf
			If $blankedSome Then $y = $yInit
		Until $blankedSome = False
		;debugStep(@ScriptLineNumber, "$lineWidth", $lineWidth, "$lineHeight", $lineHeight)
		; Just for debugging purposes - output the array to the console
		;If $debugCode < 2 Then outputArray($leftMostCol, $topRowInLine, $rightMostCol, $bottomRowInLine, $screenGrabArray)
		;outputArray($leftMostCol, $topRowInLine, $rightMostCol, $bottomRowInLine, $screenGrabArray)

		; *** Figure out the size of a space between words ***
		; Initially figure out the average size of blanks and characters.
		;   These can be used to estimate spaces vs gaps between characters
		$nonblankBlockCount = 0
		$nonblankColCnt = 0
		$avNonBlankWidth = 0
		$newNonBlank = False
		$blankBlockCount = 0
		$blankColCnt = 0
		$avBlankWidth = 0
		$newBlank = False
		For $a = $leftMostCol To $rightMostCol
			If $columnArray[$a] > 0 Then
				$newBlank = True
				; create a running total of blanks - average size will be used for guessing the size of spaces in the text
				If $newNonBlank Then $nonblankBlockCount += 1
				$nonblankColCnt += 1
				$newNonBlank = False
			Else
				$newNonBlank = True

				; create a running total of blanks - average size will be used for guessing the size of spaces in the text
				If $newBlank Then $blankBlockCount += 1
				$blankColCnt += 1
				$newBlank = False
			EndIf
		Next
		; Setting the space size to a proportion of the average character size seems to work best, but leave other options just in case
		; a more sophisticated approach would be to retrospectively analyse the recognised characters and adjust the
		;   size of the spaces depending on kerning and the average width of characters recognised
		;   (eg i and w will skew the average and a t or f tends to have a narrower space)
		$avNonBlankWidth = ($nonblankColCnt / $nonblankBlockCount) * $spaceNonBlankMult
		$avBlankWidth = ($blankColCnt / $blankBlockCount) * $spaceBlankMult
		$spaceWidthEstimate = $avNonBlankWidth
		;debugStep(@ScriptLineNumber, "$avBlankWidth", $avBlankWidth, "$blankColCnt", $blankColCnt, "$blankBlockCount", $blankBlockCount)

		; Now step through the columns and mark spaces
		For $a = $leftMostCol To $rightMostCol
			If $columnArray[$a] > 0 Then
				$blankColCnt = 0
			Else
				; mark column as a space if it's wider than the estimated size of a space
				$blankColCnt = $blankColCnt + 1
				If $blankColCnt > $spaceWidthEstimate Then
					; we assume it's a space
					$columnArray[$a - 1] = -99
					$columnWeightArray[$a - 1] = 0
					$blankColCnt = 0
				EndIf
			EndIf
		Next


		;		searchForChars($leftMostCol, $rightMostCol, $columnArray, $data)
		;now begin searching for characters
		$charStartPos = $leftMostCol
		While $charStartPos <= $rightMostCol
			;debugStep(@ScriptLineNumber, "$charStartPos", $charStartPos, "$charEndPos", $charEndPos, "$letter", $letter, "$data", $data)
			$charEndPos = $charStartPos
			; Now move $charStartPos to the next non-blank column
			$charTempPos = $charStartPos ; Don't know why, but I'm getting an error here which means $charStartPos is reset to 0 on initiating the for loop
			For $charStartPos = $charTempPos To $rightMostCol
				;																				$tempVal = $columnArray[$charStartPos]
				;debugStep(@ScriptLineNumber, "$charStartPos", $charStartPos, "$charEndPos", $charEndPos, "$letter", $letter, "$data", $data)
				If $columnArray[$charStartPos] <> 0 Then ExitLoop
			Next
			;debugStep(@ScriptLineNumber, "$charStartPos", $charStartPos, "$charEndPos", $charEndPos, "$letter", $letter, "$data", $data)

			; find the first blank column following the current block
			For $charEndPos = $charStartPos + 1 To $rightMostCol
				If $columnArray[$charEndPos] = 0 Then ExitLoop
			Next
			; look for a complete match of a block, if not found, progressively shrink the end and attempt to dissect the block into adjoining characters
;			$debugcode = 1
			$letter = ""
			$blockStart = $charStartPos
			$blockEnd = $charEndPos
			While $charEndPos > $charStartPos
				$charEndPos = $charEndPos - 1
;				debugStep(@ScriptLineNumber, "$charStartPos", $charStartPos, "$charEndPos", $charEndPos, "$letter", $letter, "$data", $data)
				$matchLoc = checkForMatch($columnArray, $charStartPos, $charEndPos, $columnWeightArray, $database)
;				debugStep(@ScriptLineNumber, "$matchLoc", $matchLoc)
				If $matchLoc Then
					; we've found a letter/s matching the current portion, so remember this
					$tempLetter = getLetter($matchLoc, $database)
					If StringInStr($dontMatchCharsInSplit,$tempLetter) And $charEndPos < $blockEnd - 1 Then
						; don't accept match if the character/s is listed in $dontMatchCharsInSplit unless it matches an entire block
						$tempLetter = ""	; don't have to do this, but makes code a bit clearer
					Else
						$letter = $letter & $tempLetter
	;					debugStep(@ScriptLineNumber, "$tempLetter", $tempLetter, "$letter", $letter)
						$charStartPos = $charEndPos + 1
						$charEndPos = $blockEnd
					EndIf
				EndIf
				If BitAND($ocrOptions, $ocrOptDontSplitBlock) Then
					ConsoleWrite ("Warning: skipping attempt to split block - multiple characters with no gap will NOT be recognised unless explicitly learnt" & @CRLF)
					ExitLoop ; if not attempting to split block then only go through loop once
				EndIf
			WEnd

;			debugStep(@ScriptLineNumber, "$letterEnd", $letter, "$data", $data)
			; If it couldn't completely split the block and not in batch mode then ask the user for help in interpreting the block
			If BitAND($ocrOptions,$ocrOptDontAskForMatch) Then
				If Not BitAND($ocrOptions, $ocrOptDontSaveErrors) Then
					$pattern = generateString($charStartPos, $blockEnd - 1, $columnWeightArray, $columnArray)
					FileWriteLine($fontFile, "err" & @TAB & "!" & StringMid($pattern, 2) & $saveWindowForFont & @CRLF)
				EndIf
				$charStartPos = $blockEnd
			ElseIf $charStartPos < $blockEnd Then
;				debugStep(@ScriptLineNumber, "$letterManual", $letter, "$data", $data)
				If $blockEnd-$blockStart > $maxCharWidth Then
					; this block is considered too wide to be a correct character, so throw an error and exit the script
					SetError(-3)
					Return
				EndIf
				;no character recognised in database, so create an image (as a string) and ask for an input
				$image = ""
				For $y = $topRowInLine To $bottomRowInLine
					For $x = $blockStart To $blockEnd - 1
						If $screenGrabArray[$x][$y] = 1 Then
							$image = $image & "#"
						Else
							$image = $image & "~" ; use tilde as it's the same width as a # (unlike a space or a .) otherwise you get kerning of the lines of the image
						EndIf
					Next
					$image = $image & @CRLF
				Next

				; Now calculate the required size of the msgbox to display the pattern
				$boxWidth = ($blockEnd - $blockStart) * 8 + 40
				If $boxWidth < 200 Then $boxWidth = 200
				If $boxWidth > @DesktopWidth Then $boxWidth = @DesktopWidth
				$boxHeight = ($bottomRowInLine - $topRowInLine) * 13 + 120
				If $boxHeight < 500 Then $boxHeight = 500
				If $boxHeight > @DesktopHeight Then $boxHeight = @DesktopHeight
				; And display it
				$userResponse = InputBox("Unknown Character", "Please identify this pattern" & @CR & "(or just OK to skip learning it):-" & @CR & $data & @CR & @CR & $image, $letter, "", $boxWidth, $boxHeight, @DesktopWidth - $boxWidth, @DesktopHeight - $boxHeight,20)
				If @error = 1 or @error = 2 Then ;The Cancel button was pushed or Timeout.
					If Not BitAND($ocrOptions, $ocrOptDontSaveErrors) Then
						$pattern = generateString($charStartPos, $blockEnd - 1, $columnWeightArray, $columnArray)
						FileWriteLine($fontFile, "err" & @TAB & "!" & StringMid($pattern, 2) & $saveWindowForFont & @CRLF)
					EndIf
					SetError(-2)
					Return
				Else
					If $letter = $userResponse Then
						; User didn't add anything to the guess
						$pattern = generateString($charStartPos, $blockEnd - 1, $columnWeightArray, $columnArray)
						FileWriteLine($fontFile, $letter & @TAB & StringMid($pattern, 2) & $saveWindowForFont & @CRLF)
					ElseIf $letter = StringLeft($userResponse, StringLen($letter)) Then
						;The guess split letters correctly, so just write the remainder to the database
						$letter = StringMid($userResponse, StringLen($letter) + 1)
						$pattern = generateString($charStartPos, $blockEnd - 1, $columnWeightArray, $columnArray)
						FileWriteLine($fontFile, $letter & $pattern & $saveWindowForFont & @CRLF)
					Else
						;The guess was incorrect
						$letter = $userResponse
						$pattern = generateString($blockStart, $blockEnd - 1, $columnWeightArray, $columnArray)
						FileWriteLine($fontFile, $letter & $pattern & $saveWindowForFont & @CRLF)
					EndIf
					$database &= $letter & $pattern & @CRLF
				EndIf
				$charStartPos = $blockEnd
			EndIf
			;			EndIf
			$data &= $letter
			$data = StringReplace($data, "''", """") ; two single quotes together are likely to be a double quote
			$data = StringReplace($data, ",,", """") ; two commas together are likely to have been a misrecognised double quote
			$data = StringReplace($data, "  ", " ") ; two spaces together are likely to be a single space
			$letter = ""
			;			$debugCode = 2

			;debugStep(@ScriptLineNumber, "$charStartPos", $charStartPos, "$charEndPos", $charEndPos, "$letter", $letter, "$data", $data)

		WEnd

		$dataAll = $dataAll & @CRLF & $data
		;If $debugCode < 2 Then ConsoleWrite($data & @CRLF)
		;If $debugCode < 2 Then ConsoleWrite("$y=" & $y)
		$data = ""
		;		$debugCode = 1
	Next
	;$debugCode = 1
	If $debugCode < 2 Then
		$dataAll2 = StringReplace($dataAll, @CRLF, "")
		$dataAll2 = StringReplace($dataAll2, " ", "")
		ConsoleWrite("******************************************************************************" & @CRLF)
		ConsoleWrite("Entire screen block grabbed into array in " & Int($arrayGrabTime) & " msec" & @CRLF)
		ConsoleWrite("Recognised " & StringLen($dataAll2) & " characters in " & Int(TimerDiff($startTime)) & " msec" & @CRLF)
		ConsoleWrite("Average  " & Round(TimerDiff($startTime) / StringLen($dataAll2), 2) & " msec per " & Int(($cumulativeLineWidth) / StringLen($dataAll2)) & " x " & Int($cumulativeLineHeight / $numberOfLines) & " pixel character" & @CRLF)
		ConsoleWrite($dataAll & @CRLF)
	EndIf
	$debugCode = 2

	If BitAND($ocrOptions, $ocrOptSaveCharacterLog) Then
		$logFile = @ScriptDir & "\OCRCharacterLog.txt"
		FileWriteLine($logFile, $dataAll)
	EndIf

	Return StringMid($dataAll, 3) ;There's an extra @CRLF at the beginning of the string to eliminate.
EndFunc   ;==>_OCR

;***************************************************************
;*           HELPER FUNCTIONS                                  *
;***************************************************************

Func checkForMatch(ByRef $columnArray, $charStartPos, $charEndPos, ByRef $columnWeightArray, ByRef $database)
	; look in the fontfile (stored as a string in memory) for a match to the current section of the column array
	Local $matchLoc = 0
	; before searching for a match
	;																				;debugStep(@ScriptLineNumber,"$charStartPos",$charStartPos, "$charEndPos",$charEndPos)
	$matchString = generateString($charStartPos, $charEndPos, $columnWeightArray, $columnArray)
	$matchLoc = StringInStr($database, $matchString & @CR)
	if $matchLoc = 0 Then $matchLoc = StringInStr($database, $matchString & @TAB)
	Return $matchLoc
EndFunc   ;==>checkForMatch

Func generateString($charStartPos, $charEndPos, ByRef $columnWeightArray, ByRef $columnArray)
	; delete any blank rows above each letter (thus shifting the block to the top of the line)
	;  then return a string containing value of each column
	; does this by dividing all the values in the block array by the smallest pixel of any column for that character

	; find the minimum bit weight of the columns in the block
	$chrMinWeight = 999999999
	$chrMaxWeight = 0					; use the ratio ($chrMaxWeight/$chrMinWeight) to try and distinguish commas from quotes
	For $i = $charStartPos To $charEndPos
		If $chrMinWeight > $columnWeightArray[$i] Then $chrMinWeight = $columnWeightArray[$i]
		If $chrMaxWeight < $columnWeightArray[$i] Then $chrMaxWeight = $columnWeightArray[$i]
		;																							;debugStep(@ScriptLineNumber,"$chrMinWeight",$chrMinWeight, "$columnArray[$i]",$columnArray[$i], "$columnWeightArray[$i]", $columnWeightArray[$i])
	Next

	;now generate a string which can be checked against/written to the database for a match
	$matchString = @TAB
	;
	; use the ratio ($chrMaxWeight/$chrMinWeight) to try and distinguish commas from quotes (mark commas as -ve)
	; ie if the character is only in the lower part of the line then consider it a comma.
	; .-= will also incidentally be marked as -ve, but this doesn't matter
	; the ratio is important as too high and everything will be marked, or all short characters will have to be marked as +ve and -ve
	; 1.5 is probably the max possible, as above this other short characters start to get incorrectly tagged (but this will depend on typeface)
	If $chrMaxWeight < $chrMinWeight * 1.5 then $matchString &= "-"
	;
	; iterate through each column in the current block and BitShift it to eliminate whitespace above the block
	For $i = $charStartPos To $charEndPos
		If $chrMinWeight > 0 Then
			$matchString = $matchString & $columnArray[$i] / (2 ^ $chrMinWeight) & "|"
		Else
			$matchString = $matchString & $columnArray[$i] & "|"
		EndIf
	Next
	$matchString = StringLeft($matchString, StringLen($matchString) - 1) ;drop the trailing "|"
	Return $matchString
EndFunc   ;==>generateString

Func getLetter($endLoc, ByRef $database)
	; get the letter/s which are represented by a particular string in the database
	$startLoc = StringInStr($database, @LF, 0, -1, $endLoc - 1) ; first get the position of the preceeding linfeed
	Return StringMid($database, $startLoc + 1, ($endLoc - $startLoc - 1)) ; then return the letter it brackets
EndFunc   ;==>getLetter

Func colourMatchWhite($colour)
	; expects a colour in BGR or RGB format
	; assumes shade variaton of 100/256
	;																				ConsoleWrite(@ScriptLineNumber& "," &"$colour"& "," &$colour& "," &"$colour2"& "," &$colour2& "," &"$shadeVariation"& "," &$shadeVariation & @CRLF)
	If BitAND($colour, 0xFF) < 155 Then Return False
	If BitAND(BitShift($colour, 8), 0xFF) < 155 Then Return False
	If BitAND(BitShift($colour, 16), 0xFF) < 155 Then Return False
	Return True
EndFunc   ;==>colourMatchWhite

Func colourMatchBlack($colour)
	; expects a colour in BGR or RGB format
	; assumes shade variaton of 100/256
	;																				ConsoleWrite(@ScriptLineNumber& "," &"$colour"& "," &$colour& "," &"$colour2"& "," &$colour2& "," &"$shadeVariation"& "," &$shadeVariation & @CRLF)
	If BitAND($colour, 0xFF) > 100 Then Return False
	If BitAND(BitShift($colour, 8), 0xFF) > 100 Then Return False
	If BitAND(BitShift($colour, 16), 0xFF) > 100 Then Return False
	Return True
EndFunc   ;==>colourMatchBlack

Func colourMatchInit($colour, $shadeVariation, ByRef $blue2, ByRef $blue2min, ByRef $blue2max, ByRef $green2, ByRef $green2min, ByRef $green2max, ByRef $red2, ByRef $red2min, ByRef $red2max, ByRef $shadeVariationCubed)
	; Initiallisation routine for both colourMatchBox and colourMatchSphere
	; it is assumed $colour will be passed in BGR format

	; This needed for both box and sphere
	If ($shadeVariation < 0) Then $shadeVariation = -$shadeVariation

	$blue2 = BitShift(BitAND($colour, 0xFF0000), 16)
	$green2 = BitShift(BitAND($colour, 0xFF00), 8)
	$red2 = BitAND($colour, 0xFF)
	;debugStep(@ScriptLineNumber, "$blue2", $blue2, "$green2", $green2, "$red2", $red2, "$colour", $colour, "$shadeVariation", $shadeVariation)
;$debugCode = 1
	; This needed for just box
	$blue2min = $blue2 - $shadeVariation
	$blue2max = $blue2 + $shadeVariation
;	debugStep(@ScriptLineNumber, "$blue2", $blue2, "$blue2min", $blue2min, "$blue2max", $blue2max)
	$green2min = $green2 - $shadeVariation
	$green2max = $green2 + $shadeVariation
;	debugStep(@ScriptLineNumber, "$green2", $green2, "$green2min", $green2min, "$green2max", $green2max) ;
	$red2min = $red2 - $shadeVariation
	$red2max = $red2 + $shadeVariation
;	debugStep(@ScriptLineNumber, "$red2", $red2, "$red2min", $red2min, "$red2max", $red2max)
	; This needed for just sphere
	$shadeVariationCubed = $shadeVariation ^ 3
	;
EndFunc   ;==>colourMatchInit

Func colourMatchBox($colour, ByRef $blue2min, ByRef $blue2max, ByRef $green2min, ByRef $green2max, ByRef $red2min, ByRef $red2max)
	; checks if $colour matches the colour used to set up in colourMatchInit
	; match true if within the box defined in colourMatchInit
	; You need to initialise with colourMatchBoxInit prior to use
	; variable names imply RGB format, but as long as both colourMatchBoxInit colour and colourMatch colour are BGR it will still work correctly
	$blue1 = BitAND($colour, 0xFF)
	If $blue1 < $blue2min Or $blue1 > $blue2max Then Return False

	$green1 = BitAND(BitShift($colour, 8), 0xFF)
	If $green1 < $green2min Or $green1 > $green2max Then Return False

	$red1 = BitAND(BitShift($colour, 16), 0xFF)
	If $red1 < $red2min Or $red1 > $red2max Then Return False

	Return True
EndFunc   ;==>colourMatchBox

Func colourMatchSphere($colour, ByRef $blue2, ByRef $green2, ByRef $red2, ByRef $shadeVariationCubed)
	; checks if $colour matches the colour used to set up in colourMatchInit
	; instead of a box along the various colour axes, this uses a sphere
	; You need to initialise with colourMatchInit prior to use
	; variable names imply RGB format, but as long as both colourMatchBoxInit colour and colourMatch colour are BGR it will still work correctly
	$blueDiff = BitAND($colour, 0xFF) - $blue2
	$greenDiff = BitAND(BitShift($colour, 8), 0xFF) - $green2
	$redDiff = BitAND(BitShift($colour, 16), 0xFF) - $red2
	;	;debugStep(@ScriptLineNumber, "$colour",$colour,"$blueDiff",$blueDiff,"$greenDiff",$greenDiff,"$redDiff",$redDiff,"$shadeVariationCubed",$shadeVariationCubed,"diff",Int($blueDiff * $greenDiff * $redDiff ) < $shadeVariationCubed)
	$colourCubed = $blueDiff * $greenDiff * $redDiff
	If $colourCubed < 0 Then $colourCubed *= -1
	If $colourCubed < $shadeVariationCubed Then Return True

	Return False
EndFunc   ;==>colourMatchSphere

Func colourRGBToBGR($colour)
	;converts RGB <-> BGR (ie both directions)
	;	BGR value = (blue * 65536) + (green * 256) + red
	;	RGB value = (red * 65536) + (green * 256) + blue

	$blue = BitShift(BitAND($colour, 0xFF), -16)
	$green = BitAND($colour, 0xFF00)
	$red = BitAND(BitShift($colour, 16), 0xFF)

	Return $blue + $green + $red
EndFunc   ;==>colourRGBToBGR

Func colourRGBtoLuminensence($colour)
	$blue = BitAND($colour, 0xFF)
	$green = BitAND(BitShift($colour, 8), 0xFF)
	$red = BitAND(BitShift($colour, 16), 0xFF)

	$minColour = 255
	if $blue < $minColour then $minColour = $blue
	if $green < $minColour then $minColour = $green
	if $red < $minColour then $minColour = $red
	$maxColour = 0
	if $blue > $maxColour then $maxColour = $blue
	if $green > $maxColour then $maxColour = $green
	if $red > $maxColour then $maxColour = $red

	$luminescence = ( $maxColour + $minColour ) / 2
	Return $luminescence
EndFunc

Func colourRGBtoBrightness($colour)
	$red = BitAND(BitShift($colour, 16), 0xFF)
	$green = BitAND(BitShift($colour, 8), 0xFF)
	$blue = BitAND($colour, 0xFF)

	; Essentially this is calculating 3D distance from black to white in the RGB cube. A slight weighting seems to give better conversion to grayscale (at least to my eye)
	$brightness = Int(Sqrt(0.12 * $red ^ 2 + 0.1 * $green ^ 2 + 0.11 * $blue ^ 2)*1.747)
	Return $brightness
EndFunc


Func bitMin($numToCheck, $maxPower = -1)
	If $numToCheck <= 1 Then Return -1
	; returns the weight(=location) of the lowest bit set
	If $maxPower = -1 Then $maxPower = Ceiling(Log($numToCheck) / Log(2))
	For $bitCnt = 0 To $maxPower
		If BitAND($numToCheck, BitShift(1, -$bitCnt)) > 0 Then
			Return $bitCnt
		EndIf
	Next
	Return -1
EndFunc   ;==>bitMin

Func outputArray($left, $top, $right, $bottom, ByRef $screenGrabArray)
	; converts a 2 dimensional array of true/false values into a string for display as 2D pattern (eg in msgbox)
	$fontFile = @ScriptDir & "\OCRScreenGrab.txt"

	Local $y, $x
	$pixelChar = @CRLF
	For $y = $top To $bottom
		For $x = $left To $right
			If $screenGrabArray[$x][$y] = True Then
				$pixelChar &= "#"
			Else
				$pixelChar &= "~"
			EndIf
		Next
		$pixelChar &= @CRLF
	Next
	ConsoleWrite($pixelChar & @CRLF)
	FileWriteLine($fontFile, $pixelChar & @CRLF)
EndFunc   ;==>outputArray

Func patternFindGenerate($xStart = 0, $yStart = 0, $xEnd = 0, $yEnd = 0)
	If $xStart = 0 Then Mark_Rect($xStart, $yStart, $xEnd, $yEnd)

	$width = $xEnd - $xStart + 1
	$height = $yEnd - $yStart + 1

	If $height < $width Then
		$smallDimen = $height
	Else
		$smallDimen = $width
	EndIf

	$stepSize = Int(($smallDimen + 1) / 2)
	$shortChecksum = PixelChecksum($xStart, $yStart, $xStart + $width, $yStart + $height, $stepSize)
	$fullChecksum = PixelChecksum($xStart, $yStart, $xStart + $width, $yStart + $height)

	$pattern = $width & "," & $height & "," & $shortChecksum & "," & $fullChecksum

	Return $pattern
EndFunc   ;==>patternFindGenerate


Func PatternFind($xStart, $yStart, $xEnd, $yEnd, $pattern)
	;$pattern = "$width,$height,$shortChecksum,$fullChecksum"
	Dim $result[3]
	$comma1Loc = StringInStr($pattern, ",", 0, 1)
	$comma2Loc = StringInStr($pattern, ",", 0, 2)
	$comma3Loc = StringInStr($pattern, ",", 0, 3)
	$width = Int(StringLeft($pattern, $comma1Loc - 1))
	$height = Int(StringMid($pattern, $comma1Loc + 1, $comma2Loc - $comma1Loc - 1))
	$shortChecksum = Int(StringMid($pattern, $comma2Loc + 1, $comma3Loc - $comma2Loc - 1))
	$fullChecksum = Int(StringMid($pattern, $comma3Loc + 1))

	If $height < $width Then
		$smallDimen = $height
	Else
		$smallDimen = $width
	EndIf


	; Search for a match
	$stepSize = Int(($smallDimen + 1) / 2)
	For $xIter = $xStart To $xEnd + 1 - $width
		For $yIter = $yStart To $yEnd + 1 - $height
			If $shortChecksum = PixelChecksum($xIter, $yIter, $xIter + $width, $yIter + $height, $stepSize) Then
				If $fullChecksum = PixelChecksum($xIter, $yIter, $xIter + $width, $yIter + $height) Then
					$result[0] = $xIter
					$result[1] = $yIter
					Return $result
				EndIf
			EndIf
		Next
	Next

	; No match found
	$result[0] = 0
	$result[1] = 0
	Return $result
EndFunc   ;==>PatternFind


;#include-once

;#include <Misc.au3> ; needed for key press and mouse button trapping
;#include <SciTE UDF.au3> ; needed to move to current point in SciTE when stepping through code
; if you want to enable this you will have to download it from the forum, and
; uncomment the _SciTEGoToLine($LineNo) within the function

; global $debugCode=0 ; 0= print to console then display tooltip while waiting for user input; 1=don't debug; 2=print to console only (no pause);


; #  ;debugStep DESCRIPTION  # =================================================================================================
; Title .........: ;debugStep
; AutoIt Version : 3.3.8.1+
; Language ......: English
; Description ...: Function to help script debugging.
; Author(s) .....: David
;EXAMPLES
; ;debugStep()       ; Displays tooltip of variable in clipboard and waits for user (depending on $debugCode option)
; ;debugStep( @ScriptLineNumber )       ; Prints out the linenumber, tooltip, and waits (depending on $debugCode option)
; ;debugStep( [@ScriptLineNumber] [,"$v1",$v2][,"$v3",$v4]...)       ; Prints out the linenumber, variables passed, tooltip, and waits (depending on $debugCode option)

; $lineMarker is optional (and can be any value, not just @ScriptLineNumber = the current line being evaluated)
; [$v1, $v2] etc must passed as a pair with a name and it's value. They don't have to be declared in the global scope

; Tooltips will be generated for a global variable whose name is copied to the clipboard (uses the eval function).
; Non-global variables from outside the function will not be reported correctly (if at all).
; You can optionally set a global variable to control debugging and switch it on and off throughout the code.
; $debugCode = 0 (default). Print to console then wait for user input while displaying tooltip of a variable name in clipboard.
;              By default the scroll-lock key is used to move on to the next step-point,
;              and the ESC key is used to exit the entire script
; $debugCode = 1 means print to console, but don't pause
; $debugCode = 2 Skip all debugging functions (return immediately function is called)
;              This saves you having to comment out the ;debugStep call in the code
;===============================================================================================================================

;Global $debugCode = 2

Func debugStep($lineMarker = 0, $v1 = 0, $v2 = 0, $v3 = 0, $v4 = 0, $v5 = 0, $v6 = 0, $v7 = 0, $v8 = 0, $v9 = 0, $v10 = 0, $v11 = 0, $v12 = 0, $v13 = 0, $v14 = 0, $v15 = 0, $v16 = 0, $v17 = 0, $v18 = 0, $v19 = 0)

	;If $debugCode = 2 Then Return
	Local $hDll = DllOpen("user32.dll")
	Local $tooltipVar = "", $oldClip = "", $curVal = ""
	Const $RArrowKey = "27", $shiftKey = "10", $scrollKey = "91", $ESCKey = "1B", $mouseX1 = "05"


	; attempting to activating SciTE may be pausing the script in some circumstances, so disable this currently
	; ideal would be to highlight the current line in SciTE independent of the cursor...
;	_SciTEGoToLine($lineMarker)
;	Send("{home}{home}+{down}")

	If $lineMarker > 0 Then
		ConsoleWrite($lineMarker & ":") ;"Trace Line: " & $lineMarker & @CRLF)
		For $dePrintItr = 1 To @NumParams - 1 Step 2
			ConsoleWrite("    " & Eval("v" & $dePrintItr) & "=" & Eval("v" & $dePrintItr + 1) & ",") ;& @CRLF)
		Next
		ConsoleWrite(@CRLF)
	EndIf

	;If $debugCode = 1 Then Return
	If _IsPressed($scrollKey, $hDll) Then
		Sleep(50)
		DllClose($hDll)
		Return
	EndIf

	While Not _IsPressed($scrollKey, $hDll)
		; could also add some code here to assign or execute so variables could be modified on the fly within the code

		; would be nice if you could have the tooltip with the value of the currently selected variable in SciTE but ControlCommand returns blank string
		$tooltipVar = ClipGet() ; ControlCommand("[CLASS:SciTEWindow]", "", "Scintilla1", "GetCurrentSelection", "")
		$tooltipVar = StringReplace($tooltipVar, "$", "")
		If IsDeclared($tooltipVar) And $oldClip <> $tooltipVar And False Then
			$oldClip = $tooltipVar
			$curVal = Eval($tooltipVar)
			ToolTip("$" & $tooltipVar & "=" & $curVal, MouseGetPos(0) + 20, MouseGetPos(1) - 30)
		EndIf
		Sleep(50)
		If _IsPressed($ESCKey, $hDll) Then Exit
		If _IsPressed($mouseX1, $hDll) Then
			MouseClick("left", MouseGetPos(0), MouseGetPos(1), 2)
			Send("^c")
			;			_SciTEGoToLine($lineMarker)
			While _IsPressed($mouseX1, $hDll)
				Sleep(50)
			WEnd
		EndIf
	WEnd
	Sleep(500)

	DllClose($hDll)
EndFunc   ;==>debugStep

Func resetGlobals()
	$debugCode = 2
	$grabWidth = 0
	$grabHeight = 0
	$blankBlockCount = 0
	$blankColCnt = 0
	$avBlankWidth = 0
	$newBlank = 0
	$topRowInLine = 0
	$bottomRowInLine = 0
	$lineHeight = 0
	$lineWidth = 0
	$tempVal = 0
	$letter = ""
	$data = ""
	$dataAll = ""
	$charStartPos = 0
	$charEndPos = 0
	$leftMostCol = 0
	$rightMostCol = 0
	$a = 0
	$x = 0
	$y = 0
	$partLetterStart = 0
	$partLetterEnd = 0
	$partLetterMax = 0
	$partLetter = 0
	$matchVal = 0
	$shadeVariation = 0
	$shadeVariationCubed = 0
	$blue2 = 0
	$green2 = 0
	$red2 = 0
	$blue2min = 0
	$blue2max = 0
	$green2min = 0
	$green2max = 0
	$red2min = 0
	$red2max = 0
	$cumulativeLineHeight = 0
	$cumulativeLineWidth = 0
	$numberOfLines = 0
EndFunc   ;==>resetGlobals





Func Mark_Rect(ByRef $iX1, ByRef $iY1, ByRef $iX2, ByRef $iY2)
	;#include "WinAPI.au3"	; used by mark_Rect
	;#include <Misc.au3>	; used by mark_Rect
	;#include <WindowsConstants.au3>	; used by mark_Rect
	; function from Melba23 (http://www.autoitscript.com/forum/topic/135728-how-to-i-draw-one-rectangle-on-screen/)

	Local $aMouse_Pos, $hMask, $hMaster_Mask, $iTemp
	Local $UserDLL = DllOpen("user32.dll")

	; Create transparent GUI with Cross cursor
	$hCross_GUI = GUICreate("Test", @DesktopWidth, @DesktopHeight - 20, 0, 0, $WS_POPUP, $WS_EX_TOPMOST)
	WinSetTrans($hCross_GUI, "", 8)
	GUISetState(@SW_SHOW, $hCross_GUI)
	GUISetCursor(3, 1, $hCross_GUI)

	Global $hRectangle_GUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
	GUISetBkColor(0x000000)

	; Wait until mouse button pressed
	While Not _IsPressed("01", $UserDLL)
		Sleep(10)
	WEnd

	; Get first mouse position
	$aMouse_Pos = MouseGetPos()
	$iX1 = $aMouse_Pos[0]
	$iY1 = $aMouse_Pos[1]

	; Draw rectangle while mouse button pressed
	While _IsPressed("01", $UserDLL)

		$aMouse_Pos = MouseGetPos()

		$hMaster_Mask = _WinAPI_CreateRectRgn(0, 0, 0, 0)
		$hMask = _WinAPI_CreateRectRgn($iX1, $aMouse_Pos[1], $aMouse_Pos[0], $aMouse_Pos[1] + 1) ; Bottom of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		$hMask = _WinAPI_CreateRectRgn($iX1, $iY1, $iX1 + 1, $aMouse_Pos[1]) ; Left of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		$hMask = _WinAPI_CreateRectRgn($iX1 + 1, $iY1 + 1, $aMouse_Pos[0], $iY1) ; Top of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		$hMask = _WinAPI_CreateRectRgn($aMouse_Pos[0], $iY1, $aMouse_Pos[0] + 1, $aMouse_Pos[1]) ; Right of rectangle
		_WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
		_WinAPI_DeleteObject($hMask)
		; Set overall region
		_WinAPI_SetWindowRgn($hRectangle_GUI, $hMaster_Mask)

		If WinGetState($hRectangle_GUI) < 15 Then GUISetState()
		Sleep(10)

	WEnd

	; Get second mouse position
	$iX2 = $aMouse_Pos[0]
	$iY2 = $aMouse_Pos[1]

	; Set in correct order if required
	If $iX2 < $iX1 Then
		$iTemp = $iX1
		$iX1 = $iX2
		$iX2 = $iTemp
	EndIf
	If $iY2 < $iY1 Then
		$iTemp = $iY1
		$iY1 = $iY2
		$iY2 = $iTemp
	EndIf

	GUIDelete($hRectangle_GUI)
	GUIDelete($hCross_GUI)
	DllClose($UserDLL)

EndFunc   ;==>Mark_Rect


Func learnFonts($fontFile = "")
	If $fontFile = "" Then $fontFile = @ScriptDir & "\OCRFontData.txt"
	If StringInStr($fontFile, "\") = 0 Then $fontFile = @ScriptDir & "\" & $fontFile

	Local $font, $msg
	Local $searchColour = 0xFFFFFF, $searchColourVariation = 100

	Local $fontArr[5]
	$fontArr[1] = "Tahoma"
	$fontArr[0] = "Times New Roman"
	$fontArr[2] = "Arial"
	$fontArr[3] = "Calibri"
	$fontArr[4] = "Frutiger 45 Light"


	$fontGUIHWnd = GUICreate("FontGUI", 50, 50, 0, 0)
	GUISetBkColor($searchColour)

	$controlID = GUICtrlCreateLabel("1", 10, 20)
	GUISetState() ; show the window

	; Run the GUI until the fonts have been iterated through is closed
	For $fontArrIter = 0 To UBound($fontArr) - 1
		For $fontSize = 10 To 12
			ConsoleWrite("Learning: " & $fontArr[$fontArrIter] & " " & $fontSize & "pt" & @CRLF)
			FileWriteLine($fontFile, "*******************************************")
			FileWriteLine($fontFile, "******* " & $fontArr[$fontArrIter] & " " & $fontSize & "pt *******")
			FileWriteLine($fontFile, "*******************************************")
			GUICtrlSetFont($controlID, $fontSize, 400, 0, $fontArr[$fontArrIter])
			; Now iterate through all printable character (skipping chr(32)={space})
			For $iter = 33 To 126
				GUICtrlSetData($controlID, Chr($iter))
				;				msgbox(1,"","")
				$msg = GUIGetMsg()
				If $msg = $GUI_EVENT_CLOSE Then Exit
				_OCR(5, 45, 30, 70, -$searchColour, $searchColourVariation, $fontFile, Chr($iter))
			Next
		Next
	Next
EndFunc   ;==>learnFonts

;edit the x and y bounds to reflect where word draws it's characters on your system
;_learnCharsWithWord(275,300,310,340)
; For some reason the characters that Word displays aren't always recognised when the font has been learnt with characters displayed in a GUI
; When I figure out why, this will be redundant.
Func learnCharsWithWord($left = 275, $top = 300, $right = 310, $bottom = 340, $searchColour = 0xFFFFFF, $searchColourVariation = 100, $fontFile = "")
	If $fontFile = "" Then $fontFile = @ScriptDir & "\OCRFontData.txt"
	If StringInStr($fontFile, "\") = 0 Then $fontFile = @ScriptDir & "\" & $fontFile
	Local $fontArr[4]
	$fontArr[0] = "Tahoma"
	$fontArr[1] = "Times New Roman"
	$fontArr[2] = "Arial"
	$fontArr[3] = "Calibri"
	; Open Word
	$objWord = ObjCreate("Word.Application")
	$objWord.Documents.Add
	$objWord.Visible = True
	$objWord.ActiveDocument.ShowGrammaticalErrors = False
	$objWord.ActiveDocument.ShowSpellingErrors = False
	$objWord.Selection.HomeKey(6) ; wdStory = 6
	For $fontArrIter = 0 To UBound($fontArr) - 1
		For $fontSize = 10 To 12
			FileWriteLine($fontFile, "@*** " & $fontArr[$fontArrIter] & " " & $fontSize & "pt ***@")
			; Now iterate through all printable character (skipping chr(32)={space})
			For $iter = 33 To 126
				; Use the clipboard rather than directly typing so Word doesn't autocorrect lowercase to caps
				ClipPut(Chr($iter) & @CRLF & @CRLF & @CRLF & @CRLF)
				$objWord.Selection.Font.Name = $fontArr[$fontArrIter]
				$objWord.Selection.Font.Size = $fontSize
				$objWord.Selection.Paste
				;				$objWord.Selection.Paste.TypeText chr($iter) & "          "
				;				sleep(100)	;just to ensure word has time to draw the characters correctly
				_OCR($left, $top, $right, $bottom, $searchColour, $searchColourVariation, $fontFile, Chr($iter))
				$objWord.Selection.HomeKey(6, 1) ;wdLine = 5, wdExtend=1
				$objWord.Selection.Delete
			Next
		Next
	Next
	$objWord.Quit(False) ; Get rid of Word (don't save)
EndFunc   ;==>learnCharsWithWord

Func mouseOCR($ocrOptions = 68)
	Local $xStart = 0, $yStart = 0, $xEnd = 0, $yEnd = 0
	Mark_Rect($xStart, $yStart, $xEnd, $yEnd)

	ConsoleWrite(@CRLF & "Starting OCR of region:-" & @CRLF)
	ConsoleWrite("   _OCR(" & $xStart & "," & $yStart & "," & $xEnd & "," & $yEnd & ")" & @CRLF)
	$backColour = PixelGetColor($xStart,$yStart)
	ConsoleWrite("   $backColour " & $backColour & @CRLF)
	$OCRString = _OCR($xStart, $yStart, $xEnd, $yEnd, -$backColour, 50, "", "", $ocrOptMatchBackground)
	ConsoleWrite($OCRString)
	Return $OCRString
EndFunc   ;==>mouseOCR


func cleanFontDataFile($fontFile="")
	If $fontFile = "" Then $fontFile = @ScriptDir & "\OCRFontData.txt"

	Local $fileOld = FileOpen($fontFile, 0)
	Local $fileNew = FileOpen($fontFile & ".tmp", 2)

	; Check if file opened for reading OK
	If $fileOld = -1 Then
		MsgBox(0, "Error", "Unable to open data file.")
		Exit
	EndIf

	; Read in lines of text until the EOF is reached
	While 1
		Local $line = FileReadLine($fileOld)
		If @error = -1 Then ExitLoop
		If StringInStr($line,"err" & @TAB & "!")=0 then
			FileWriteLine($fileNew, $line)
		EndIf
	WEnd

	FileClose($fileOld)
	FileClose($fileNew)

	; Now replace old file with new

	FileMove ( $fontFile & ".tmp", $fontFile, 1 )
EndFunc


