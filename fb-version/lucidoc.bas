/'
	
	lucidoc.bas
	
	Copyright (c) 2020 Lisa Murray
	
	Build With:
		Windows:
		>fbc -s console lucidoc.bas
		DOS:
		>fbc LUCIDOC.BAS
		Linux:
		$fbc lucidoc.bas
	
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

#Include "lucidoc.bi"

#Print __FILE_NQ__: Building...

'' Assert valid values from header:
#IfnDef __FB_MAIN__
	#Error __FILE_NQ__: This file must be the main module!
#EndIf

#Assert LSDJ_MIN_TEMPO < LSDJ_MAX_TEMPO

#If (STEP_SIZE > 1) Or (STEP_SIZE < -1)
	#Error __FILE_NQ__: Invalid STEP_SIZE value.
#EndIf

#If (TABS_COUNT < 10)
	#Error __FILE_NQ__: Invalid TABS_COUNT value.
#EndIf

#If Not((NEGATIVE_OUTPUT = "all") Or (NEGATIVE_OUTPUT = "hide") Or (NEGATIVE_OUTPUT = "omit"))
	#Error __FILE_NQ__: Invalid NEGATIVE_OUTPUT value.
#EndIf

'' Makes sure uTempo is a valid tempo.
Function ValidTempo (ByRef uTempo As Const UInteger) As Boolean
	
	If ((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO)) Then Return(FALSE)
	Return(TRUE)
	
End Function

'' Calculates a logaritm with a base of dblBase multiplied by dblNumber.
Function LogBaseX (ByVal dblNumber As Const Double, ByVal dblBase As Const Double) As Double
	
    Return(Log(dblNumber) / Log(dblBase))
    
End Function

'' Calculates the mainHz value used in the freq(step, tempo) function.
Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
	
	If (ValidTempo(uTempo) = FALSE) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	Return(uTempo * 0.4 * LSDJ_OVERCLOCK_MULT)
	
End Function

'' Implements the freq(step, tempo) function.
Function CalcFreq (ByVal uTempo As Const UInteger, ByVal uStep As Const Double) As Double
	
	If (ValidTempo(uTempo) = FALSE) Then Error(FB_ERR_ILLEGALFUNCTION)
	If ((uStep < OFFTIME_MIN) OrElse (uStep > OFFTIME_MAX)) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	Return((1.85 * uTempo * LogBaseX(uStep, (1 / uTempo))) + CalcMainHz(uTempo))
	
End Function

'' Main routine:
On Error GoTo FATAL_ERROR

#If ENABLE_COLOR
	Dim uColor As ULong	'' Stores the current color.
#EndIf
Dim uTempo As UInteger	'' Stores the tempo we're checking.
Dim dblFreq As Double	'' Stores the result frequency.

'' Get tempo from command line, if present.
uTempo = CUInt(Command(1))

'' Get tempo from prompting the user if command line isn't present.
If Not(ValidTempo(uTempo)) Then
	Do
		? Using "Valid tempos are integers between & and &."; LSDJ_MIN_TEMPO; LSDJ_MAX_TEMPO
		Input "Tempo"; uTempo
		If ValidTempo(uTempo) Then Exit Do
		
		#If ENABLE_COLOR
			uColor = Color(12, 0)
		#EndIf
		? Using "& is an invalid tempo."; uTempo
		#If ENABLE_COLOR
			Color(LoWord(uColor), HiWord(uColor))
		#EndIf
	Loop
EndIf

'' Print out header for formatted data:
? "Tempo: "; uTempo
? "Step"; Tab(TABS_COUNT); "Frequency (Hz)"

'' Print out formatted data:
For iStep As Double = OFFTIME_MAX To OFFTIME_MIN Step STEP_SIZE
	
	dblFreq = CalcFreq(uTempo, iStep)
	
	''? iStep; Tab(10); CalcFreq(uTempo, iStep); " Hz"
	#If NEGATIVE_OUTPUT = "hide"
		
		'' Place an "N/A" here, and calculate the next item.
		If (dblFreq < 0) Then
			#If ENABLE_COLOR
				uColor = Color(12, 0)
			#EndIf
			? iStep; Tab(TABS_COUNT); "N/A"
			#If ENABLE_COLOR
				Color(LoWord(uColor), HiWord(uColor))
			#EndIf
			Continue For
		EndIf
	#ElseIf NEGATIVE_OUTPUT = "omit"
		
		'' Skip this item.
		Continue For
	#EndIf
	
	'' Print out a row.
	? iStep; Tab(TABS_COUNT); dblFreq; " Hz"
	
Next iStep

Err = FB_ERR_SUCCESS

FATAL_ERROR:
Scope
	
	Dim uErr As ULong = Err()
	
	If uErr Then ? Using "Fatal Error: FB RunTime error code: _&h& (&)"; Hex(uErr); uErr
	
	End(uErr)
	
End Scope

''EOF
