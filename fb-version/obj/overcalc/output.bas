/'
	
	output.bas
	
	Lucid OverCalc - Output Module
	
	Copyright 2020 Lisa Murray
	
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

Sub PrintHeader ()
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
	#EndIf
	
	g_colCurrent = SetColor COL_HEADER
	
	With *g_prtParams
		If .bBareOut Then
			? #g_pstdio->hOut, Using !"Tempo: &\nMIDI Octave Shift: &\nOFF Time\tFrequency (Hz)\tClosest MIDI Key Number"; .uTempo; .uOctShift
		Else
			? Using "Tempo: &"; .uTempo
			? Using "MIDI Octave Shift: &"; .uOctShift
			? "OFF Time"; Tab(.uTabsCount); "Frequency (Hz)"; Tab(.uTabsCount * 3); "Closest MIDI Key Number"
		EndIf
	End With
	
	RestoreColor g_colCurrent
	
End Sub

Private Sub PrintRow (ByRef strStep As Const String, ByRef strFreq As Const String, ByRef strMidiKey As Const String)
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByRef Const String:strStep = ""&"""; strStep
		? #g_pstdio->hDbg, Using !"\tByRef Const String:strFreq = ""&"""; strFreq
		? #g_pstdio->hDbg, Using !"\tByRef Const String:strMidiKey = ""&"""; strMidiKey
	#EndIf
	
	If ((Len(strStep) <= 0) OrElse (Len(strFreq) <= 0)) Then Error(FB_ERR_ILLEGALFUNCTION)
	
	If g_prtParams->bBareOut Then
		? #g_pstdio->hOut, Using !"&\t\t& Hz\t&"; strStep; strFreq; strMidiKey
	Else
		? strStep; Tab(g_prtParams->uTabsCount); strFreq; " Hz"; Tab(g_prtParams->uTabsCount * 3); strMidiKey
	EndIf
	
End Sub

Sub PrintFormattedRow (ByVal iStep As Const Single, ByVal dblFreq As Const Double, ByVal uKeyNum As Const UByte)
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const Single:iStep = &"; iStep
		? #g_pstdio->hDbg, Using !"\tByVal Const Double:dblFreq = &"; dblFreq
		? #g_pstdio->hDbg, Using !"\tByVal Const UByte:uKeyNum = &"; uKeyNum
	#EndIf
	
	'' Static storage for strings.
	Static strStep As String*6
	Static strFreq As String
	Static strKeyNum As String
	
	'' Convert parameters to strings.
	strStep = Str(iStep)
	strFreq = Str(dblFreq)
	strKeyNum = Str(uKeyNum)
	
	'' Print output.
	If (dblFreq < 0) Then
		
		g_colCurrent = SetColor COL_ERROR
		
		Select Case As Const g_prtParams->uNegOut
			Case NEGOUT.ALL
				
				'' Print out the row anyways.
				PrintRow(strStep, strFreq, strKeyNum)
				
			Case NEGOUT.HIDE
				
				'' Print out an "N/A" message.
				If g_prtParams->bBareOut Then
					? #g_pstdio->hOut, Using !"&\t\tN/A"; strStep
				Else
					? strStep; Tab(g_prtParams->uTabsCount); "N/A"	
				EndIf
				
			Case NEGOUT.OMIT
				
				'' Do nothing.
				
			Case Else
				
				'' Display error message and exit.
				? #g_pstdio->hErr, "Invalid negative output mode."
				Error(FB_ERR_ILLEGALINSTRUCTION)
				
		End Select
		
		RestoreColor g_colCurrent
		
	Else
		
		PrintRow(strStep, strFreq, strKeyNum)
		
	EndIf
	
End Sub

''EOF
