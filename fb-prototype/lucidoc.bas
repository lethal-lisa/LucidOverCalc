/'
	
	lucidoc.bas
	
	Copyright (c) 2020 Lisa Murray
	
	Build With:
		Windows:
		>fbc -s console lucidoc.bas -x lucid.exe
		DOS:
		>fbc LUCIDOC.BAS -x LUCIDOC.EXE
		Linux:
		$fbc lucidoc.bas -x lucid
	
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

Function CheckError (ByVal uErrCode As Const ULong, ByRef bQuit As Boolean = FALSE) As ULong
	
	If ((uErrCode = FB_ERR_QUITREQ) OrElse (uErrCode = FB_ERR_TERMREQ)) Then
		bQuit = TRUE
		Return(FB_ERR_SUCCESS)
	EndIf
	
	Return(uErrCode)
	
End Function

''makes sure uTempo is a valid tempo
Function ValidTempo (ByRef uTempo As Const UInteger) As Boolean
	
	If ((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO)) Then
		? Using "& is an invalid tempo."; uTempo
		Return(FALSE)
	EndIf
	Return(TRUE)
	
End Function

Function LogBaseX (ByVal dblNumber As Double, ByVal dblBase As Double) As Double
	
    Return(Log(dblNumber) / Log(dblBase))
    
End Function

''main:
On Error GoTo FATAL_ERROR

Dim uTempo As UInteger = CUInt(Command(1))
Do Until ValidTempo(uTempo)
	? Using !"Valid tempos are integers between & and &."; LSDJ_MIN_TEMPO; LSDJ_MAX_TEMPO
	Input "Tempo"; uTempo
Loop

Dim dblMainHz As Double = (uTempo * OVERCLOCK_MULT * 0.4)

? "Step"; Tab(10); "Frequency"
For iStep As Double = OFFTIME_MAX To OFFTIME_MIN Step -0.5
	? iStep; Tab(10); (1.9 * uTempo * LogBaseX(iStep, 1 / uTempo)) + dblMainHz
Next iStep

Err = FB_ERR_SUCCESS

FATAL_ERROR:
Scope
	
	''get the error code
	Dim uErr As ULong = Err()
	
	''check for a valid error
	If (CheckError(uErr) = FB_ERR_SUCCESS) Then End(FB_ERR_SUCCESS)
	
	''print out an error message
	? Using "Fatal Error: _&h& (&)."; Hex(uErr); Str(uErr)
	
	End(uErr)
End Scope

''EOF
