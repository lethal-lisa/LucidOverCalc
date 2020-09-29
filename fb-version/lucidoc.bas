/'
	
	lucidoc.bas
	
	Lucid OverCalc - Main Module
	
	Build With:
		Windows/DOS:
		>fbc lucidoc.bas
		Linux:
		$fbc lucidoc.bas
	
	Copyright (c) 2020 Lisa Murray
	
	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
	MA 02110-1301, USA.
	
'/

'$lang: "fb"
#Lang "fb"

#Include "lucidoc.bi"

'' Assert valid values from header:
#IfnDef __FB_MAIN__
	#Error __FILE_NQ__ must be the main module!
#EndIf

#Assert LSDJ_MIN_TEMPO < LSDJ_MAX_TEMPO
#Assert OFFTIME_MIN < OFFTIME_MAX

#If (STEP_SIZE > 1) Or (STEP_SIZE < -1) Or (STEP_SIZE = 0)
	#Error STEP_SIZE is an invalid STEP_SIZE value.
#EndIf

#If TABS_COUNT < DEF_TABS_COUNT
	#Error TABS_COUNT is an invalid TABS_COUNT value.
#EndIf

''#If Not((NEGATIVE_OUTPUT = "all") Or (NEGATIVE_OUTPUT = "hide") Or (NEGATIVE_OUTPUT = "omit"))
#If (NEGATIVE_OUTPUT < 1) Or (NEGATIVE_OUTPUT > 3)
	#Error NEGATIVE_OUTPUT is an invalid NEGATIVE_OUTPUT value.
#EndIf

'' Prints out a help message.
Sub ShowHelp (ByVal hOut As Const Long)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const Long:hOut = _&h& (&)"; Hex(hOut); hOut
	#EndIf
	
	'' Print out help to stderr.
	? #hOut, !"Lucid OverCalc - FreeBASIC Version\nHelp:\n"
	? #hOut, !"Syntax:\n\tlucidoc [{help|{ver|version}|{defs|defaults}|[<tempo>] [bareout] [stepsize <stepsize>] [mintime <offtime>] [maxtime <offtime>] [enablecolor {true|false}] [tabs <tabcount>] [negativeout <outputmode>]}]\n"
	? #hOut, !"\thelp\t\tShow this help message."
	? #hOut, !"\tver, version\tShow version information."
	? #hOut, !"\tdefs, defaults\tShow default settings for this build of Lucid."
	? #hOut, !"\t<tempo>\t\tTempo to use."
	? #hOut, !"\tbareout\t\tEnables ""bare"" output with fixed tab width. Use this if output is to be piped."
	? #hOut, !"\tstepsize\tSet the step size to <stepsize>."
	? #hOut, !"\tmintime\t\tSets the minimum OFFtime to calculate."
	? #hOut, !"\tmaxtime\t\tSets the maximum OFFtime to calculate."
	? #hOut, !"\tenablecolor\tEnables colored output."
	? #hOut, !"\ttabs\t\tSets the amount of whitespace between output columns."
	? #hOut, !"\tnegativeout\tSpecifies what to do if a frequency value is negative."
	? #hOut, !"\t\tAvailable values for <outputmode>: ""all"" does nothing, ""hide"" shows an ""N/A"", and ""omit"" disables output entirely."
	? #hOut, !"\n";
	
End Sub

'' Prints out version and build information.
Sub ShowVersion (ByVal hOut As Const Long)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const Long:hOut = _&h& (&)"; Hex(hOut); Str(hOut)
	#EndIf
	
	'' Make sure hOut is a valid handle.
	If Not(CBool(hOut)) Then Error(FB_ERR_ILLEGALINSTRUCTION)
	
	'' Print out version information.
	? #hOut, "Build Information:"
	? #hOut, Using !"\tBuild Date:\t\t& &"; __DATE__; __TIME__
	
	'' Compiler information:
	? #hOut, Using !"\tCompiler Signature:\t&"; __FB_SIGNATURE__
	#If Len(__FB_BUILD_SHA1__)
		? #hOut, Using !"\tCompiler SHA-1:\t\t&"; __FB_BUILD_SHA1__
	#EndIf
	? #hOut, Using !"\tCompiler Build Date:\t&"; __FB_BUILD_DATE__
	? #hOut, Using !"\tCompiler Back End:\t&"; __FB_BACKEND__
	
	'' CPU & OS information:
	? #hOut, !"\tBuild Architecture:\t";
	#IfDef __FB_ARM__
		#IfDef __FB_64BIT__
			? #hOut, !"64-bit";
		#Else
			? #hOut, !"32-bit";
		#EndIf
		? #hOut, !" ARM";
	#Else
		#IfDef __FB_64BIT__
			? #hOut, !"x86_64";
		#Else
			? #hOut, !"x86";
		#EndIf
	#EndIf
	#IfDef __FB_BIGENDIAN__
		? #hOut, " (Big";
	#Else
		? #hOut, " (Little";
	#EndIf
	? #hOut, " endian)"
	
	'' FPU information:
	#IfDef __FB_SSE__
		? #hOut, !"\tFPU Used:\t\tSSE"
		? #hOut, Using !"\tFP Mode:\t\t&"; __FB_FPMODE__
	#Else
		? #hOut, !"\tFPU Used:\t\tx87"
	#EndIf
	
	? #hOut, !"\n";
	
End Sub

'' Prints out the default settings for the build.
Sub ShowDefaults (ByVal hOut As Const Long)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const Long:hOut = _&h& (&)"; Hex(hOut); Str(hOut)
	#EndIf
	
	'' Make sure hOut is a valid handle.
	If Not(CBool(hOut)) Then Error(FB_ERR_ILLEGALINSTRUCTION)
	
	'' Print out default settings.
	? #hOut, "Default settings:"
	? #hOut, Using !"\tStep size:\t\t&"; Str(STEP_SIZE)
	? #hOut, Using !"\tMinimum OFF time:\t&"; Str(OFFTIME_MIN) 
	? #hOut, Using !"\tMaximum OFF time:\t&"; Str(OFFTIME_MAX)
	? #hOut, Using !"\tColor:\t\t\t&"; IIf(ENABLE_COLOR, "Enabled", "Disabled")
	? #hOut, Using !"\tColumn distance:\t&"; Str(TABS_COUNT)
	? #hOut, Using !"\tNegative output mode:\t&"; Str(NEGATIVE_OUTPUT)
	? #hOut, !"\n";
	
End Sub

'' Parses the command line.
Function ParseCmdLine (ByVal pParams As RUNTIME_PARAMS Const Ptr) As ULong
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const RUNTIME__PARAMS Ptr:pParams = @_&h&"; Hex(pParams)
	#EndIf
	
	#Macro INC_SET_CMD(index)
		If pbParam[index] Then Exit Select
		iCmd += 1
		pbParam[index] = TRUE
	#EndMacro
	
	On Local Error GoTo FAIL
	
	'' Make sure pParams is a valid pointer.
	If (pParams = NULL) Then Error(FB_ERR_NULLPTRACCESS)
	
	Dim iCmd As UInteger		'' Parameter index.
	Dim strCmd As String		'' Buffer for parameter.
	Dim pbParam As Boolean Ptr	'' Array of booleans showing which parameters have already been set.
	
	/'	pbParam Info:
		
			Values in pbParam are set to TRUE once a parameter has been
		checked.
		
		Index Values:
		0 = "stepsize"
		1 = "mintime"
		2 = "maxtime"
		3 = "enablecolor"
		4 = "tabs"
		5 = "negativeout"
		6 = "bareout"
	'/
	
	'' Allocate space for pbParam
	pbParam = CAllocate(7, SizeOf(Boolean))
	If (pbParam = NULL) Then Error(FB_ERR_OUTOFMEMORY)
	
	Do
		
		'' Get next parameter and convert to lowercase.
		iCmd += 1
		strCmd = LCase(Command(iCmd))
		
		#If __FB_DEBUG__
			? #hDbgLog, Using !"&:\tChecking parameter _#&"; Time(); iCmd
			? #hDbgLog, Using !"\tFound: ""&"""; strCmd
		#EndIf
		
		'' Make sure a parameter is present.
		If (Len(strCmd) <= 0) Then Exit Do
		
		Select Case strCmd
			Case "help"
				
				'' Show help and exit.
				ShowHelp(s_hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "ver", "version"
				
				'' Show version information and exit.
				ShowVersion(s_hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "defs", "defaults"
				
				'' Show default settings and exit.
				ShowDefaults(s_hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "stepsize"
				
				'' Get stepsize.
				INC_SET_CMD(0)
				pParams->sngStepSize = CSng(Command(iCmd))
				
			Case "mintime"
				
				'' Get minimum OFF time.
				INC_SET_CMD(1)
				pParams->sngOffMin = CSng(Command(iCmd))
				
			Case "maxtime"
				
				'' Get maximum OFF time.
				INC_SET_CMD(2)
				pParams->sngOffMax = CSng(Command(iCmd))
				
			Case "enablecolor"
				
				'' Get color settings.
				INC_SET_CMD(3)
				pParams->bColor = CBool(Command(iCmd))
				
			Case "tabs"
				
				'' Get tab settings.
				INC_SET_CMD(4)
				pParams->uTabsCount = CUInt(Command(iCmd))
				
			Case "negout", "negativeout"
				
				'' Get negative output settings.
				INC_SET_CMD(5)
				pParams->uNegOut = GetNegOutMode(LCase(Command(iCmd)))
				If Not(CheckNegOutMode(pParams->uNegOut)) Then
					? #s_hErr, Using """&"" is not a valid negative output mode."; Command(iCmd)
					Error FB_ERR_ILLEGALINSTRUCTION
				EndIf
				
			Case "bareout"
				
				'' Get bare output mode.
				If pbParam[6] Then Exit Select
				pbParam[6] = TRUE
				pParams->bBareOut = TRUE
				
			Case Else
				
				'' Assume any unknown parameter is a tempo.
				pParams->uTempo = CUInt(strCmd)
				
		End Select
		
	Loop While (iCmd < MAX_CLI_PARAMS)
	
	Err = FB_ERR_SUCCESS
	
	FAIL:
	If pbParam Then DeAllocate pbParam
	Return(Err())
	
End Function

'' Gets a negative output mode.
Function GetNegOutMode (ByRef strNegOut As Const String) As UByte
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByRef Const String:strNegOut = ""&"""; strNegOut
	#EndIf
	
	Select Case strNegOut
		Case "all" : Return NEGOUT.ALL
		Case "hide" : Return NEGOUT.HIDE
		Case "omit" : Return NEGOUT.OMIT
		Case Else : Return NULL
	End Select
	
End Function

'' Checks for a valid negative output mode.
Function CheckNegOutMode (ByVal uNegOut As Const UByte) As Boolean
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const UByte:uNegOut = _&h& (&)"; Hex(uNegOut); uNegOut
	#EndIf
	
	Return CBool((uNegOut >= NEGOUT.ALL) AndAlso (uNegOut <= NEGOUT.OMIT))
	
End Function

'' Sets the console color only if ENABLE_COLOR is TRUE.
Function SetColor (ByRef colFore As UByte = DEF_COLOR, ByRef colBack As UByte = DEF_COLOR) As ULong
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByRef UByte:colFore = _&h& (&)"; Hex(colFore); colFore
		? #hDbgLog, Using !"\tByRef UByte:colBack = _&h& (&)"; Hex(colBack); colBack
	#EndIf
	
	'' Preserve the old color.
	Dim uColor As ULong = Color
	
	If s_prtParams->bColor Then
		
		'' Check for default colors, and use them if needed.
		If (colFore = DEF_COLOR) Then colFore = CUByte(LoWord(uColor))
		If (colBack = DEF_COLOR) Then colBack = CUByte(HiWord(uColor))
		
		'' Set the new color.
		Color colFore, colBack
		
	EndIf
	
	'' Return the old color.
	Return uColor
	
End Function

'' Restores back the original color only if ENABLE_COLOR is TRUE.
Sub RestoreColor (ByVal uColor As Const ULong)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const ULong:uColor = _&h& (&)"; Hex(uColor); uColor
	#EndIf
	
	If s_prtParams->bColor Then	Color LoWord(uColor), HiWord(uColor)
	
End Sub

'' Makes sure uTempo is a valid tempo.
Function ValidTempo (ByVal uTempo As Const UInteger) As Boolean
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
	#EndIf
	
	Return Not(CBool((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO)))
	
End Function

'' Calculates a logaritm with a base of dblBase multiplied by dblNumber.
Function LogBaseX (ByVal dblNumber As Const Double, ByVal dblBase As Const Double) As Double
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const Double:dblNumber = &"; dblNumber
		? #hDbgLog, Using !"\tByVal Const Double:dblBase = &"; dblBase
	#EndIf
	
    Return(Log(dblNumber) / Log(dblBase))
    
End Function

'' Calculates the mainHz value used in the freq(step, tempo) function.
Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
	#EndIf
	
	'' Make sure tempo is valid.
	If (ValidTempo(uTempo) = FALSE) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	'' Calculate and return value for mainHz.
	Return(uTempo * 0.4 * LSDJ_OVERCLOCK_MULT)
	
End Function

'' Implements the freq(step, tempo) function.
Function CalcFreq (ByVal uTempo As Const UInteger, ByVal dblOffTime As Const Double) As Double
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
		? #hDbgLog, Using !"\tByVal Const Double:dblOffTime = &"; dblOffTime
	#EndIf
	
	'' Check for valid parameters.
	If (ValidTempo(uTempo) = FALSE) Then Error(FB_ERR_ILLEGALFUNCTION)
	If ((dblOffTime < OFFTIME_MIN) OrElse (dblOffTime > OFFTIME_MAX)) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	'' Calculate and return result.
	Return((1.85 * uTempo * LogBaseX(dblOffTime, (1 / uTempo))) + CalcMainHz(uTempo))
	
End Function

'' Get tempo by prompting the user.
Function GetTempo () As UInteger
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
	#EndIf
	
	Dim uTempo As UInteger	'' Temporary storage for tempo.
	Dim hIn As Long			'' Standard input handle
	
	'' Get standard input handle.
	hIn = FreeFile()
	Open Cons For Input As #hIn
	If Err() Then Error(Err())
	
	'' Get tempo by prompting the user if the command line is invalid.
	Do
		
		'' Display valid tempos and prompt user.
		s_uColor = SetColor COL_GOOD
		? #s_hErr, Using "Valid tempos are integers between & and &."; LSDJ_MIN_TEMPO; LSDJ_MAX_TEMPO
		RestoreColor s_uColor
		? #s_hErr, "Tempo? ";
		Input #hIn, uTempo
		
		'' Continue if provided tempo is valid.
		If ValidTempo(uTempo) Then Exit Do
		
		'' Issue warning about invalid tempo and prompt again.
		s_uColor = SetColor COL_WARN
		? #s_hErr, Using "& is an invalid tempo."; uTempo
		RestoreColor s_uColor
		
	Loop
	
	Close #hIn
	Return(uTempo)
	
End Function

Sub PrintHeader ()
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
	#EndIf
	
	s_uColor = SetColor COL_HEADER
	
	With *s_prtParams
		If .bBareOut Then
			? #s_hOut, Using !"Tempo: &\nOFF Time\tFrequency (Hz)"; .uTempo
		Else
			? Using "Tempo: &"; .uTempo
			? "OFF Time"; Tab(.uTabsCount); "Frequency (Hz)"
		EndIf
	End With
	
	RestoreColor s_uColor
	
End Sub

Private Sub PrintRow (ByRef strStep As Const String, ByRef strFreq As Const String)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByRef Const String:strStep = ""&"""; strStep
		? #hDbgLog, Using !"\tByRef Const String:strFreq = ""&"""; strFreq
	#EndIf
	
	If ((Len(strStep) <= 0) OrElse (Len(strFreq) <= 0)) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	If s_prtParams->bBareOut Then
		? #s_hOut, Using !"&\t\t& Hz"; strStep; strFreq
	Else
		? strStep; Tab(s_prtParams->uTabsCount); strFreq; " Hz" 
	EndIf
	
End Sub

Sub PrintFormattedRow (ByVal iStep As Const Single, ByVal dblFreq As Const Double)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const Single:iStep = &"; iStep
		? #hDbgLog, Using !"\tByVal Const Double:dblFreq = &"; dblFreq
	#EndIf
	
	'' Static storage for strings.
	Static strStep As String*6
	Static strFreq As String
	
	'' Convert parameters to strings.
	strStep = Str(iStep)
	strFreq = Str(dblFreq)
	
	'' Print output.
	If (dblFreq < 0) Then
		
		s_uColor = SetColor COL_ERROR
		
		Select Case As Const s_prtParams->uNegOut
			Case NEGOUT.ALL
				
				'' Print out the row anyways.
				PrintRow(strStep, strFreq)
				
			Case NEGOUT.HIDE
				
				'' Print out an "N/A" message.
				If s_prtParams->bBareOut Then
					? #s_hOut, Using !"&\t\tN/A"; strStep
				Else
					? strStep; Tab(s_prtParams->uTabsCount); "N/A"	
				EndIf
				
			Case NEGOUT.OMIT
				
				'' Do nothing.
				
			Case Else
				
				'' Display error message and exit.
				? #s_hErr, "Invalid negative output mode."
				Error(FB_ERR_ILLEGALINSTRUCTION)
				
		End Select
		
		RestoreColor s_uColor
		
	Else
		
		PrintRow(strStep, strFreq)
		
	EndIf
	
End Sub

'' Main routine:
On Error GoTo FATAL_ERROR

'' Open debug log:
#If __FB_DEBUG__
	
	'' Get log file handle.
	hDbgLog = FreeFile()
	If (hDbgLog = NULL) Then Error(FB_ERR_FILEIO)
	
	'' Open up the log file.
	Open "lucidoc.log" For Output As #hDbgLog
	If Err() Then Error(Err())
	
	'' Print out a header message to the log file.
	ShowVersion(hDbgLog)
	ShowDefaults(hDbgLog)
	? #hDbgLog, Using !"\nBEGIN LOG:\nFree memory: &KB\nRun time: & &\n"; Str(Fre() \ 1024); Date(); Time()
	
#EndIf

'' Open standard error and output handles.
s_hErr = FreeFile()
Open Err As #s_hErr
If Err() Then Error(Err())

s_hOut = FreeFile()
Open Cons For Output As #s_hOut
If Err() Then Error(Err())

#If __FB_DEBUG__
	? #hDbgLog, Using "Opened stderr as _&h&"; Hex(s_hErr)
	? #hDbgLog, Using "Opened stdout as _&h&"; Hex(s_hOut)
#EndIf

'' Obtain default color.
Dim uColor As ULong = Color

'' Allocate space for runtime parameters.
s_prtParams = Allocate(SizeOf(RUNTIME_PARAMS))
If (s_prtParams = NULL) Then Error(FB_ERR_OUTOFMEMORY)

#If __FB_DEBUG__
	? #hDbgLog, Using "Allocated runtime parameters: & bytes @_&h&"; SizeOf(RUNTIME_PARAMS); Hex(s_prtParams)
#EndIf 

'' Set default runtime parameters.
With *s_prtParams
	.sngStepSize = STEP_SIZE
	.sngOffMin = OFFTIME_MIN
	.sngOffMax = OFFTIME_MAX
	.uTabsCount = TABS_COUNT
	.uNegOut = NEGATIVE_OUTPUT
	.bColor = ENABLE_COLOR
	.bBareOut = BARE_OUTPUT
End With

'' Parse the command line.
Err = ParseCmdLine(s_prtParams)
If Err() Then Error(Err())

'' Get tempo from user if necessary.
If Not(ValidTempo(s_prtParams->uTempo)) Then s_prtParams->uTempo = GetTempo()

With *s_prtParams
	
	'' Validate parameters for the For...Next loop.
	If ((.sngOffMin = .sngOffMax) OrElse (.sngStepSize = 0)) Then
		Error(FB_ERR_ILLEGALFUNCTION)
	ElseIf (.sngStepSize > 0) Then
		If (.sngOffMin > .sngOffMax) Then Swap .sngOffMin, .sngOffMax
	ElseIf (.sngStepSize < 0) Then
		If (.sngOffMin < .sngOffMax) Then Swap .sngOffMin, .sngOffMax
	End If
	
	'' Print out header.
	PrintHeader()
	
	'' Print out formatted data:
	For iStep As Single = .sngOffMin To .sngOffMax Step .sngStepSize
		PrintFormattedRow(iStep, CalcFreq(.uTempo, iStep))
	Next iStep
	
End With

'' Set success error code.
Err = FB_ERR_SUCCESS

FATAL_ERROR:
Scope
	
	'' Get error code.
	Dim uErr As ULong = Err()
	
	'' Print an error message if uErr is an error code.
	If Not(CBool((uErr = FB_ERR_SUCCESS) OrElse (uErr = FB_ERR_TERMREQ) OrElse (uErr = FB_ERR_QUITREQ))) Then
		SetColor COL_ERROR
		? #s_hErr, Using "Fatal Error: FreeBASIC RunTime error code: _&h& (&)"; Hex(uErr); uErr
		#If __FB_DEBUG__
			? #hDbgLog, Using "Fatal Error: FreeBASIC RunTime error code: _&h& (&)"; Hex(uErr); uErr
		#EndIf
	EndIf
	
	'' Close opened file handles.
	#If __FB_DEBUG__
		Close #hDbgLog
	#EndIf
	Close #s_hErr
	Close #s_hOut
	
	'' Free used resources.
	If s_prtParams Then DeAllocate s_prtParams
	
	'' Restore default color.
	RestoreColor uColor
	
	'' End the program.
	End(uErr)
	
End Scope

''EOF
