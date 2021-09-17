/'
	
	lucidoc.bas
	
	Lucid OverCalc - Main Module
	
	Copyright (c) 2020-2021 Lisa Murray
	
	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 3 of the License, or
	any later version.
	
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

#Assert LSDJ.minTempo < LSDJ.maxTempo
#Assert MIDI.minKeyNum < MIDI.maxKeyNum

Dim Shared g_prtParams As RUNTIME_PARAMS Ptr

'' Calculates a logarithm with a base of dblBase multiplied by dblNumber.
Function LogBaseX (ByVal dblBase As Const Double, ByVal dblNumber As Const Double) As Double
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const Double:dblBase = &"; dblBase
		? #g_pstdio->hDbg, Using !"\tByVal Const Double:dblNumber = &"; dblNumber
	#EndIf
	
    Return(Log(dblNumber) / Log(dblBase))
    
End Function

'' Calculates the mainHz value used in the freq(step, tempo) function.
Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
	#EndIf
	
	'' Make sure tempo is valid.
	If (ValidTempo(uTempo) = FALSE) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	'' Calculate and return value for mainHz.
	Return(uTempo * 0.4 * LSDJ.overclockMult)
	
End Function

'' Implements the freq(step, tempo) function.
Function CalcFreq (ByVal uTempo As Const UInteger, ByVal dblOffTime As Const Double) As Double
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
		? #g_pstdio->hDbg, Using !"\tByVal Const Double:dblOffTime = &"; dblOffTime
	#EndIf
	
	'' Check for valid parameters.
	If (ValidTempo(uTempo) = FALSE) Then Error(FB_ERR_ILLEGALFUNCTION)
	If ((dblOffTime < OFFTIME_MIN) OrElse (dblOffTime > OFFTIME_MAX)) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	'' Calculate and return result.
	Return((1.85 * uTempo * LogBaseX((1 / uTempo), dblOffTime)) + CalcMainHz(uTempo))
	
End Function

'' Main routine:
On Error GoTo FATAL_ERROR

'' Allocate space for runtime parameters.
g_prtParams = Allocate(SizeOf(RUNTIME_PARAMS))
If (g_prtParams = NULL) Then Error(FB_ERR_OUTOFMEMORY)

'' Create standard I/O handles object.
#If __FB_DEBUG__
	g_strDbgFile = "lucidoc.log"
#EndIf
g_pstdio = New STDIO_HANDLES()
If (g_pstdio = NULL) Then Error(g_uLastError)

#If __FB_DEBUG__
	ShowVersion(g_pstdio->hDbg)
	ShowDefaults(g_pstdio->hDbg)
	? #g_pstdio->hDbg, !"\nRuntime Info:"
	? #g_pstdio->hDbg, Using !"\tRun time: & &"; Date(); Time()
	? #g_pstdio->hDbg, Using !"\tFree memory: &KB"; Str(Fre() / 1024)
	? #g_pstdio->hDbg, Using !"\tStdOut handle: _&h&\n\tStdErr handle: _&h&"; Hex(g_pstdio->hOut); Hex(g_pstdio->hErr)
	? #g_pstdio->hDbg, Using !"\tDebug log handle: _&h&"; Hex(g_pstdio->hDbg)
	? #g_pstdio->hDbg, !"\nBEGIN LOG:\n"
#EndIf

'' Obtain default color.
g_colDefColor = Color()

#If __FB_DEBUG__
	? #g_pstdio->hDbg, Using "Allocated runtime parameters: & bytes @_&h&"; SizeOf(RUNTIME_PARAMS); Hex(g_prtParams)
#EndIf

'' Set default runtime parameters.
With *g_prtParams
	.sngStepSize = STEP_SIZE
	.sngOffMin = OFFTIME_MIN
	.sngOffMax = OFFTIME_MAX
	.uOctShift = OCTAVE_SHIFT
	.uTabsCount = TABS_COUNT
	.uNegOut = NEGATIVE_OUTPUT
	''.bColor = ENABLE_COLOR
	.bBareOut = BARE_OUTPUT
End With
g_bEnableColor = ENABLE_COLOR

'' Parse the command line.
SetError(ParseCmdLine())
If Err() Then Error(Err())

'' Get tempo from user if necessary.
If Not(ValidTempo(g_prtParams->uTempo)) Then g_prtParams->uTempo = GetTempo()

With *g_prtParams
	
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
	Dim dblFreq As Double
	For iStep As Single = .sngOffMin To .sngOffMax Step .sngStepSize
		dblFreq = CalcFreq(.uTempo, iStep)
		PrintFormattedRow(iStep, dblFreq, GetMIDIKeyNum(dblFreq))
	Next iStep
	
End With

'' Set success error code.
SetError(FB_ERR_SUCCESS)

FATAL_ERROR:
Scope
	
	'' Get error code.
	Dim uErr As ULong = Err()
	
	'' Print an error message if uErr is an error code.
	If Not(CBool((uErr = FB_ERR_SUCCESS) OrElse (uErr = FB_ERR_TERMREQ) OrElse (uErr = FB_ERR_QUITREQ))) Then
		SetColor COL_ERROR
		If g_pstdio->hErr Then
			? #g_pstdio->hErr, Using "Fatal Error: FreeBASIC RunTime error code: _&h& (&)"; Hex(uErr); uErr
		Else
			? Using "Fatal Error: FreeBASIC RunTime error code: _&h& (&)"; Hex(uErr); uErr
		EndIf
		#If __FB_DEBUG__
			If g_pstdio->hDbg Then ? #g_pstdio->hDbg, Using "Fatal Error: FreeBASIC RunTime error code: _&h& (&)"; Hex(uErr); uErr
		#EndIf
	EndIf
	
	'' Restore default color.
	RestoreColor g_colDefColor
	
	'' Close opened file handles.
	If g_pstdio Then Delete g_pstdio
	
	'' Free used resources.
	If g_prtParams Then DeAllocate g_prtParams
	
	'' End the program.
	End(uErr)
	
End Scope

''EOF
