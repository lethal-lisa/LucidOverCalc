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

#If Not((NEGATIVE_OUTPUT = "all") Or (NEGATIVE_OUTPUT = "hide") Or (NEGATIVE_OUTPUT = "omit"))
	#Error NEGATIVE_OUTPUT is an invalid NEGATIVE_OUTPUT value.
#EndIf

Sub ShowHelp ()
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
	#EndIf
	
	'' Print out help to stderr.
	? #s_hErr, !"Lucid OverCalc - FreeBASIC Version\nHelp:\n"
	? #s_hErr, !"Syntax:\n\tlucidoc [{help|{ver|version}|{defs|defaults}|[<tempo>] [stepsize <stepsize>] [mintime <offtime>] [maxtime <offtime>] [enablecolor {true|false}] [tabs <tabcount>] [negativeout <outputmode>]}]\n"
	? #s_hErr, !"\thelp\t\tShow this help message."
	? #s_hErr, !"\tver, version\tShow version information."
	? #s_hErr, !"\tdefs, defaults\tShow default settings for this build of Lucid."
	? #s_hErr, !"\t<tempo>\t\tTempo to use."
	? #s_hErr, !"\tstepsize\tSet the step size to <stepsize>."
	? #s_hErr, !"\tmintime\tSets the minimum OFFtime to calculate."
	? #s_hErr, !"\tmaxtime\tSets the maximum OFFtime to calculate."
	? #s_hErr, !"\tenablecolor\tEnables colored output."
	? #s_hErr, !"\ttabs\t\tSets the amount of whitespace between output columns."
	? #s_hErr, !"\tnegativeout\tSpecifies what to do if a frequency value is negative."
	? #s_hErr, !"\t\tAvailable values for <outputmode>: ""all"" does nothing, ""hide"" shows an ""N/A"", and ""omit"" disables output entirely.";
	? #s_hErr, !"\n"
	
End Sub

Sub ShowVersion (ByVal hOut As Const Long)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const Long:hOut = _&h& (&)"; Hex(hOut); Str(hOut)
	#EndIf
	
	'' Make sure hOut is a valid handle.
	If Not(CBool(hOut)) Then Error(FB_ERR_ILLEGALINSTRUCTION)
	
	'' Print out version information.
	? #hOut, Using !"Lucid OverCalc from: & &\n"; __DATE__; __TIME__
	? #hOut, "Build Information:"
	
	'' Compiler information:
	? #hOut, Using !"\tCompiler Signature:\t&"; __FB_SIGNATURE__
	#If Len(__FB_BUILD_SHA1__)
		? #hOut, Using !"\tCompiler SHA-1:\t&"; __FB_BUILD_SHA1__
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
	
	? #hOut, !"\n"
	
End Sub

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
	? #hOut, Using !"\tMinimum OFFtime:\t&"; Str(OFFTIME_MIN) 
	? #hOut, Using !"\tMaximum OFFtime:\t&"; Str(OFFTIME_MAX)
	? #hOut, Using !"\tColor:\t\t\t&"; IIf(ENABLE_COLOR, "Enabled", "Disabled")
	? #hOut, Using !"\tColumn distance:\t&"; Str(TABS_COUNT)
	? #hOut, Using !"\tNegative output mode:\t&"; Str(NEGATIVE_OUTPUT)
	? #hOut, !"\n"
	
End Sub

'' Parses the command line.
Function ParseCmdLine (ByVal pParams As RUNTIME_PARAMS Const Ptr) As Integer
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const RUNTIME__PARAMS Ptr:pParams = @_&h&"; Hex(pParams)
	#EndIf
	
	If (pParams = NULL) Then Error(FB_ERR_NULLPTRACCESS)
	
	Dim iCmd As UInteger = 1	'' Parameter index.
	Dim strCmd As String		'' Buffer for parameter.
	Dim cchCmd As UInteger		'' Size in characters of parameter.
	Dim nValOffset As UInteger	'' Offset of "=" if one is present, zero otherwise.
	Dim pbParam As Boolean Ptr	'' Array of booleans showing which parameters have already been set.
	
	/'	pbParam index values:
		0 = "stepsize"
		1 = "mintime"
		2 = "maxtime"
		3 = "enablecolor"
		4 = "tabs"
		5 = "negativeout"
	'/
	
	pbParam = New Boolean[6]
	
	Do
		
		'' Get parameter and parameter length.
		strCmd = Command(iCmd)
		cchCmd = Len(strCmd)
		
		'' Make sure length is valid.
		If Not((cchCmd > 0) And (cchCmd <= MAX_CLI_PARAM_LEN)) Then Exit Do
		
		Select Case LCase(strCmd)
			Case "help"
				
				ShowHelp() : Error(FB_ERR_SUCCESS)
				
			Case "ver", "version"
				
				ShowVersion(s_hErr) : Error(FB_ERR_SUCCESS)
				
			Case "defs", "defaults"
				
				ShowDefaults(s_hErr) : Error(FB_ERR_SUCCESS)
				
			Case "stepsize"
				
				'' Get stepsize.
				If Not(pbParam[0]) Then
					iCmd += 1
					pParams->sngStepSize = CSng(Command(iCmd))
					pbParam[0] = TRUE
					#If __FB_DEBUG__
						? #hDbgLog, !"\t\tGot: step size."
						? #hDbgLog, Using !"\t\tpParams->sngStepSize = &"; pParams->sngStepSize
					#EndIf
				EndIf
				
			Case "mintime"
				
				'' Get minimum OFFtime
				If Not(pbParam[1]) Then
					iCmd += 1
					pParams->sngOffMin = CSng(Command(iCmd))
					pbParam[1] = TRUE
					#If __FB_DEBUG__
						? #hDbgLog, !"\t\tGot: min OFFtime."
						? #hDbgLog, Using !"\t\tpParams->sngOffMin = _&h& (&)"; Hex(pParams->sngOffMin); Str(pParams->sngOffMin)
					#EndIf
				EndIf
				
			Case "maxtime"
				
				'' Get maximum OFFtime
				If Not(pbParam[2]) Then
					iCmd += 1
					pParams->sngOffMax = CSng(Command(iCmd))
					pbParam[2] = TRUE
					#If __FB_DEBUG__
						? #hDbgLog, !"\t\tGot: max OFFtime."
						? #hDbgLog, Using !"\t\tpParams->sngOffMax = _&h& (&)"; Hex(pParams->sngOffMax); Str(pParams->sngOffMax)
					#EndIf
				End If
				
			Case "enablecolor", "tabs", "negativeout"
				
				'' TODO: Implement "enablecolor", "tabs", and "negativeout"
				? #s_hErr, Using """&"" functionality not yet implemented."; strCmd
				
			Case Else
				
				'' Assume unknown parameter is a tempo.
				pParams->uTempo = CUInt(strCmd)
				
		End Select
		
		iCmd += 1
		
	Loop While (iCmd < MAX_CLI_PARAMS)
	
	Delete[] pbParam
	
	Return iCmd
	
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
Function GetTempo (ByRef uColor As ULong) As UInteger
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #hDbgLog, Using !"\tByVal Const ULong:uColor = _&h& (&)"; Hex(uColor); uColor
	#EndIf
	
	
	Dim uTempo As UInteger
	
	'' Get tempo by prompting the user if the command line is invalid.
	Do
		
		'' Display valid tempos and prompt user.
		uColor = SetColor COL_GOOD
		? Using "Valid tempos are integers between & and &."; LSDJ_MIN_TEMPO; LSDJ_MAX_TEMPO
		RestoreColor uColor
		Input "Tempo"; uTempo
		
		'' Continue if provided tempo is valid.
		If ValidTempo(uTempo) Then Exit Do
		
		'' Issue warning about invalid tempo and prompt again.
		uColor = SetColor COL_WARN
		? Using "& is an invalid tempo."; uTempo
		RestoreColor uColor
		
	Loop
	
	Return(uTempo)
	
End Function

'' Main routine:
On Error GoTo FATAL_ERROR

'' Open debug log:
#If __FB_DEBUG__
	
	'' Get log file handle.
	hDbgLog = FreeFile()
	If Not(CBool(hDbgLog)) Then Error(FB_ERR_FILEIO)
	
	'' Open up the log file.
	Open "lucidoc.log" For Output As #hDbgLog
	If Err() Then Error(Err())
	
	'' Print out a header message to the log file.
	ShowVersion(hDbgLog)
	ShowDefaults(hDbgLog)
	? #hDbgLog, Using !"\nRun time: & &\nBegin Log:\n"; Date(); Time()
	
#EndIf

'' Open standard error.
s_hErr = FreeFile()
If Not(CBool(s_hErr)) Then Error(FB_ERR_FILEIO)
Open Err As #s_hErr
If Err() Then Error(Err())
#If __FB_DEBUG__
	? #hDbgLog, Using "Opened standard error as _&h& (&)"; Hex(s_hErr); Str(s_hErr)
#EndIf

'' Allocate space for runtime parameters.
s_prtParams = Allocate(SizeOf(RUNTIME_PARAMS))
If (s_prtParams = NULL) Then Error(FB_ERR_OUTOFMEMORY)

'' Obtain default color.
Dim uColor As ULong = Color

'' Set default parameters.
With *s_prtParams
	.sngStepSize = STEP_SIZE
	.sngOffMin = OFFTIME_MIN
	.sngOffMax = OFFTIME_MAX
	.uTabsCount = TABS_COUNT
	.strNegOut = NEGATIVE_OUTPUT
	.bColor = ENABLE_COLOR
End With

'' Parse the command line.
ParseCmdLine(s_prtParams)

'' Get tempo from user.
If Not(ValidTempo(s_prtParams->uTempo)) Then s_prtParams->uTempo = GetTempo(uColor)

'' Print out header for formatted data:
uColor = SetColor COL_HEADER
? Using "Tempo: &"; s_prtParams->uTempo
? "OFF Time"; Tab(s_prtParams->uTabsCount); "Frequency (Hz)"
RestoreColor uColor

With *s_prtParams
	
	'' Validate parameters for the For...Next loop.
	If ((.sngOffMin = .sngOffMax) OrElse (.sngStepSize = 0)) Then
		Error(FB_ERR_ILLEGALFUNCTION)
	ElseIf (.sngStepSize > 0) Then
		If (.sngOffMin > .sngOffMax) Then Swap .sngOffMin, .sngOffMax
	ElseIf (.sngStepSize < 0) Then
		If (.sngOffMin < .sngOffMax) Then Swap .sngOffMin, .sngOffMax
	End If
	
	'' TODO: Remove preprocessor statements and replace them with values in s_prtParams.
	'' Print out formatted data:
	For iStep As Double = .sngOffMin To .sngOffMax Step .sngStepSize	
		
		'' Stores the resulting frequency.
		Static dblFreq As Double
		
		'' Reset color.
		RestoreColor uColor
		
		'' Calculate next frequency in the sequence.
		dblFreq = CalcFreq(.uTempo, iStep)
		
		'' Set output color to 
		If (dblFreq < 0) Then uColor = SetColor COL_ERROR
		
		''#If NEGATIVE_OUTPUT = "hide"
		If (.strNegOut = "hide") Then
			
			'' Place an "N/A" here, and calculate the next frequency.
			If (dblFreq < 0) Then		
				? Str(iStep); Tab(.uTabsCount); "N/A"		
				Continue For
			EndIf
			
		''#ElseIf NEGATIVE_OUTPUT = "omit"
		ElseIf (.strNegOut = "omit") Then
			
			'' Skip this step.
			If (dblFreq < 0) Then Continue For
			
		EndIf
		
		'' Print out a row of frequency information.
		? Str(iStep); Tab(.uTabsCount); Str(dblFreq); " Hz"
			
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
		uColor = SetColor COL_ERROR
		? #s_hErr, Using "Fatal Error: FreeBASIC RunTime error code: _&h& (&)"; Hex(uErr); uErr
		#If __FB_DEBUG__
			? #hDbgLog, Using "Fatal Error: FreeBASIC RunTime error code: _&h& (&)"; Hex(uErr); uErr
		#EndIf
		RestoreColor uColor
	EndIf
	
	'' Close opened file handles.
	#If __FB_DEBUG__
		Close #hDbgLog
	#EndIf
	Close #s_hErr
	
	DeAllocate(s_prtParams)
	
	'' End the program.
	End(uErr)
	
End Scope

''EOF
