/'
	
	midikey.bas
	
	Lucid OverCalc - MIDI Key Number Conversion Module
	
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

Function GetMIDIKeyNum (ByVal nFreq As Const Integer) As UByte
	Dim nRes As Integer = CUInt((12 * LogBaseX(2, (nFreq / 440))) + 49)
	If (nRes < MIDI.minKeyNum) Then
		Return MIDI.minKeyNum
	ElseIf (nRes > MIDI.maxKeyNum) Then
		Return MIDI.maxKeyNum
	Else
		Return CUByte(nRes)
	EndIf
End Function

Function GetMIDIKeyFreq (ByVal uKeyNum As Const UByte) As Integer
	Return(CInt((2 ^ (uKeyNum - 49) / 12) * 440))
End Function

Function GetClosestFreq (ByVal dblTest As Const Double, ByVal dblLo As Const Double, ByVal dblHi As Const Double) As Double
	If ((Abs(dblTest - dblLo) > Abs(dblTest - dblHi))) Then
		Return dblHi
	Else
		Return dblLo
	EndIf
End Function

''EOF
