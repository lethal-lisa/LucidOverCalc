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
	#Error __FILE_NQ__: This file must be the main module!
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

'' Sets the console color only if ENABLE_COLOR is TRUE.
Function SetColor (ByRef colFore As UByte = DEF_COLOR, ByRef colBack As UByte = DEF_COLOR) As ULong
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "Calling: &/& (&)"; __FILE__; __FUNCTION__; Time()
		? #hDbgLog, Using !"\tByRef UByte:colFore = _&h& (&)"; Hex(colFore); colFore
		? #hDbgLog, Using !"\tByRef UByte:colBack = _&h& (&)"; Hex(colBack); colBack
	#EndIf
	
	'' Preserve the old color.
	Dim uColor As ULong = Color
	
	#If ENABLE_COLOR
		
		'' Check for default colors, and use them if needed.
		If (colFore = DEF_COLOR) Then colFore = CUByte(LoWord(uColor))
		If (colBack = DEF_COLOR) Then colBack = CUByte(HiWord(uColor))
		
		'' Set the new color.
		Color colFore, colBack
		
	#EndIf
	
	'' Return the old color.
	Return uColor
	
End Function

'' Restores back the original color only if ENABLE_COLOR is TRUE.
Sub RestoreColor (ByVal uColor As Const ULong)
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "Calling: &/& (&)"; __FILE__; __FUNCTION__; Time()
		? #hDbgLog, Using !"\tByVal Const ULong:uColor = _&h& (&)"; Hex(uColor); uColor
	#EndIf
	
	#If ENABLE_COLOR
		Color LoWord(uColor), HiWord(uColor)
	#EndIf
	
End Sub

'' Makes sure uTempo is a valid tempo.
Function ValidTempo (ByVal uTempo As Const UInteger) As Boolean
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "Calling: &/& (&)"; __FILE__; __FUNCTION__; Time()
		? #hDbgLog, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
	#EndIf
	
	''''If ((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO)) Then Return(FALSE)
	''''Return(TRUE)
	''Return(IIf((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO), TRUE, FALSE))
	Return Not(CBool((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO)))
	
End Function

'' Calculates a logaritm with a base of dblBase multiplied by dblNumber.
Function LogBaseX (ByVal dblNumber As Const Double, ByVal dblBase As Const Double) As Double
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "Calling: &/& (&)"; __FILE__; __FUNCTION__; Time()
		? #hDbgLog, Using !"\tByVal Const Double:dblNumber = &"; dblNumber
		? #hDbgLog, Using !"\tByVal Const Double:dblBase = &"; dblBase
	#EndIf
	
    Return(Log(dblNumber) / Log(dblBase))
    
End Function

'' Calculates the mainHz value used in the freq(step, tempo) function.
Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "Calling: &/& (&)"; __FILE__; __FUNCTION__; Time()
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
		? #hDbgLog, Using "Calling: &/& (&)"; __FILE__; __FUNCTION__; Time()
		? #hDbgLog, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
		? #hDbgLog, Using !"\tByVal Const Double:dblOffTime = &"; dblOffTime
	#EndIf
	
	'' Check for valid parameters.
	If (ValidTempo(uTempo) = FALSE) Then Error(FB_ERR_ILLEGALFUNCTION)
	If ((dblOffTime < OFFTIME_MIN) OrElse (dblOffTime > OFFTIME_MAX)) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	'' Calculate and return result.
	Return((1.85 * uTempo * LogBaseX(dblOffTime, (1 / uTempo))) + CalcMainHz(uTempo))
	
End Function

Function GetTempo (ByRef uColor As ULong) As UInteger
	
	#If __FB_DEBUG__
		? #hDbgLog, Using "Calling: &/& (&)"; __FILE__; __FUNCTION__; Time()
		? #hDbgLog, Using !"\tByVal Const ULong:uColor = _&h& (&)"; Hex(uColor); uColor
	#EndIf
	
	'' Try to get tempo from command line.
	Dim uTempo As UInteger = CUInt(Command(1))
	
	'' Get tempo by prompting the user if the command line is invalid.
	If Not(ValidTempo(uTempo)) Then
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
	EndIf
	
	Return uTempo
	
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
	? #hDbgLog, Using !"Lucid OverCalc from: & &\n"; __DATE__; __TIME__
	? #hDbgLog, "Build Information:"
	? #hDbgLog, Using !"\tCompiler Signature:\t&"; __FB_SIGNATURE__
	? #hDbgLog, Using !"\tFPU Used:\t\t&"; UCase(__FB_FPU__)
	#IfDef __FB_SSE__
		? #hDbgLog, Using !"\tFP Mode:\t\t&"; __FB_FPMODE__
	#EndIf
	#IfDef __FB_64BIT__
		? #hDbgLog, !"\t64-bit build."
	#Else
		? #hDbgLog, !"\t32-bit build."
	#EndIf
	? #hDbgLog, !"\nAdvanced Compile-time Options:"
	? #hDbgLog, Using !"\tSTEP_SIZE = &"; STEP_SIZE
	? #hDbgLog, Using !"\tTABS_COUNT = &"; TABS_COUNT
	? #hDbgLog, Using !"\tNEGATIVE_OUTPUT = &"; NEGATIVE_OUTPUT
	? #hDbgLog, Using !"\tENABLE_COLOR = &"; ENABLE_COLOR
	? #hDbgLog, Using !"\nRun time: & &\nBegin Log:\n"; Date(); Time()
	
#EndIf

Dim uColor As ULong		'' Stores the current color.
Dim uTempo As UInteger	'' Stores the tempo we're checking.
Dim dblFreq As Double	'' Stores the result frequency.

'' Obtain default color.
uColor = Color

'' Get tempo from user.
uTempo = GetTempo(uColor)

'' Print out header for formatted data:
uColor = SetColor COL_HEADER
? Using "Tempo: &"; uTempo
? "OFF Time"; Tab(TABS_COUNT); "Frequency (Hz)"
RestoreColor uColor

'' TODO: Clean up the block below.
'' Print out formatted data:
#If (STEP_SIZE < 0)
	For iStep As Double = OFFTIME_MAX To OFFTIME_MIN Step STEP_SIZE
#ElseIf (STEP_SIZE > 0)
	For iStep As Double = OFFTIME_MIN To OFFTIME_MAX Step STEP_SIZE
#EndIf
	
	'' Reset color.
	RestoreColor uColor
	
	'' Calculate next frequency in the sequence.
	dblFreq = CalcFreq(uTempo, iStep)
	
	'' Set output color to 
	If (dblFreq < 0) Then uColor = SetColor COL_ERROR
	
	#If NEGATIVE_OUTPUT = "hide"
		
		'' Place an "N/A" here, and calculate the next frequency.
		If (dblFreq < 0) Then
			? Str(iStep); Tab(TABS_COUNT); "N/A"
			Continue For
		EndIf
		
	#ElseIf NEGATIVE_OUTPUT = "omit"
		
		'' Skip this step.
		If (dblFreq < 0) Then Continue For
		
	#EndIf
	
	'' Print out a row of frequency information.
	? Str(iStep); Tab(TABS_COUNT); Str(dblFreq); " Hz"
	
Next iStep

'' Set success error code.
Err = FB_ERR_SUCCESS

FATAL_ERROR:
Scope
	
	'' Get error code.
	Dim uErr As ULong = Err()
	
	'' Print an error message if code is nonzero.
	If uErr Then
		uColor = SetColor COL_ERROR
		? Using "Fatal Error: FB RunTime error code: _&h& (&)"; Hex(uErr); uErr
		#If __FB_DEBUG__
			? #hDbgLog, Using "Fatal Error: FB RunTime error code: _&h& (&)"; Hex(uErr); uErr
		#EndIf
	EndIf
	
	'' End the program.
	#If __FB_DEBUG__
		Close #hDbgLog
	#EndIf
	End(uErr)
	
End Scope

''EOF
