/'
	
	lucidoc.bi
	
	Lucid OverCalc - Main Header
	
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

#Pragma Once

'' Include headers:
#Include Once "inc/fberrors.bi"
#Include Once "inc/fbcolors.bi"

#Include "inc/seterror.bi"
#Include "inc/stdioobj.bi"
#Include "inc/color.bi"

#Include "inc/defcolor.bi"

#Include "inc/exopts.bi"

'' Define constants:
#IfnDef NULL
	#Define NULL 0
#EndIf

'' Constant values used by LSDj:
Enum LSDJ Explicit
	minTempo = 40
	maxTempo = 295
	overclockMult = 2
End Enum

'' Constant values used by MIDI:
Enum MIDI Explicit
	minKeyNum = 21
	maxKeyNum = 108
End Enum

'' Values for different negative output modes.
Enum NEGOUT Explicit
	ALL = 1
	HIDE
	OMIT
End Enum

'' Define UDTs and structures:
'' Parameters used at runtime:
Type RUNTIME_PARAMS
	uTempo As UInteger		'' Tempo to use.
	sngStepSize As Single	'' Step size.
	sngOffMin As Single		'' Minimum OFFtime.
	sngOffMax As Single		'' Maximum OFFtime.
	uOctShift As UByte		'' Amount of octaves to shift MIDI notes up.
	uTabsCount As UInteger	'' Whitespace between output columns.
	uNegOut As UByte		'' Negative output mode.
	bBareOut As Boolean		'' Bare output enable.
End Type


'' Define external variables:
Extern g_prtParams As RUNTIME_PARAMS Ptr	'' Runtime parameters structure.

'' Function declarations:

'' From main module lucidoc.bas:
Declare Function LogBaseX (ByVal dblBase As Const Double, ByVal dblNumber As Const Double) As Double
Declare Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
Declare Function CalcFreq (ByVal uTempo As Const UInteger, ByVal dblOffTime As Const Double) As Double

'' From module obj/messages.bas:
Declare Sub ShowHelp (ByVal hOut As Const Long)
Declare Sub ShowVersion (ByVal hOut As Const Long)
Declare Sub ShowDefaults (ByVal hOut As Const Long)

'' From module obj/input.bas:
Declare Function ParseCmdLine () As ULong
Declare Function ValidTempo (ByVal uTempo As Const UInteger) As Boolean
Declare Function GetTempo () As UInteger

'' From module obj/output.bas:
Declare Sub PrintHeader ()
Declare Sub PrintFormattedRow (ByVal iStep As Const Single, ByVal dblFreq As Const Double, ByVal uKeyNum As Const UByte)

'' From module obj/midikey.bas:
Declare Function GetMIDIKeyNum (ByVal nFreq As Const Integer) As UByte
Declare Function GetMIDIKeyFreq (ByVal uKeyNum As Const UByte) As Double 

''EOF
