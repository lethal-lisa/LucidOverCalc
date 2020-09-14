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

'' Makes sure uTempo is a valid tempo.
Function ValidTempo (ByRef uTempo As Const UInteger) As Boolean
	
	If ((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO)) Then
		? Using "& is an invalid tempo."; uTempo
		Return(FALSE)
	EndIf
	Return(TRUE)
	
End Function

'' Calculates a logaritm with a base of dblBase multiplied by dblNumber.
Function LogBaseX (ByVal dblNumber As Double, ByVal dblBase As Double) As Double
	
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

''main:
On Error GoTo FATAL_ERROR

'' Get tempo from command line, if present.
Dim uTempo As UInteger = CUInt(Command(1))

'' Get tempo from prompting the user if command line isn't present.
Do Until ValidTempo(uTempo)
	? Using "Valid tempos are integers between & and &."; LSDJ_MIN_TEMPO; LSDJ_MAX_TEMPO
	Input "Tempo"; uTempo
Loop

'' Print out data header:
? "Tempo: "; uTempo
? "Step"; Tab(10); "Frequency (Hz)"

'' Print out data:
For iStep As Double = OFFTIME_MAX To OFFTIME_MIN Step -0.5
	? iStep; Tab(10); CalcFreq(uTempo, iStep); " Hz"
Next iStep

Err = FB_ERR_SUCCESS

FATAL_ERROR:
Scope
	
	Dim uErr As ULong = Err()
	
	If uErr Then ? Using "Fatal Error: FB RunTime error code: _&h& (&)"; Hex(uErr); uErr
	
	End(uErr)
	
End Scope

''EOF
