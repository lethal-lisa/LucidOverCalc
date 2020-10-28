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

Private Function ValidMidiKey (ByVal nKeyNum As Const Integer) As UByte
	If (nKeyNum < MIDI.minKeyNum) Then Return MIDI.minKeyNum
	If (nKeyNum > MIDI.maxKeyNum) Then Return MIDI.maxKeyNum
	Return CUByte(nKeyNum)
End Function

'' TODO: Add octave-shift capability.

Function GetMIDIKeyNum (ByVal nFreq As Const Integer) As UByte
	Return ValidMidiKey(CInt(12 * LogBaseX(2, (nFreq / 440)) + 49))
End Function

Function GetMIDIKeyFreq (ByVal uKeyNum As Const UByte) As Double
	Return(((2 ^ (ValidMidiKey(uKeyNum) - 49)) / 12) * 440)
End Function

''EOF
