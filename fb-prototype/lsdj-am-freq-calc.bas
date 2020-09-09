/'
	
	lsdj-am-freq-calc.bas
	
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

#Include "lsdj-am-freq-calc.bi"

Sub CheckExit (ByVal strPrompt As String Ptr)
	
	If (LCase(Trim(*strPrompt)) = "exit") Then Error(FB_ERR_QUITREQUEST)
	
End Sub

''makes sure puTempo is a valid tempo
Function ValidTempo (ByVal puTempo As UInteger Ptr) As Boolean
	
	If ((*puTempo < LSDJ_MIN_TEMPO) AndAlso (*puTempo > LSDJ_MAX_TEMPO)) Then
		? Using "% is an invalid tempo."; *puTempo
		Return(FALSE)
	EndIf
	Return(TRUE)
	
End Function

''obtains the tempo value from the user
Function GetTempo () As UInteger
	
	Dim strTemp As String
	Dim uTempo As UInteger
	
	Do
		? Using "Valid tempos are integers between % and %."; LSDJ_MIN_TEMPO; LSDJ_MAX_TEMPO
		Input "Input valid LSDj tempo (without overclock) or ""exit"" to exit.", uTempo
		CheckExit(@strTemp)
		uTempo = ValUInt(strTemp)
	Loop Until ValidTempo(@uTempo)
	
	Return uTempo
	
End Function

Function GetMainHz (ByVal uTempo As UInteger) As UInteger
	
	Return(uTempo * OVERCLOCK_MULT * 0.4)
	
End Function

''main:
On Error GoTo FAIL

Dim uTempo As UInteger = GetTempo()
? Using "Tempo = %"; uTempo
? Using "Overclocked tempo = %"; (uTempo * LSDJ_SOFT_OVERCLOCK)

FAIL:
If (Err() = FB_ERR_QUITREQ) Then End(FB_ERR_SUCCESS)
End(FB_ERR_SUCCESS)

''EOF
