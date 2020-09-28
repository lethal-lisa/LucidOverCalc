/'
	
	lucidoc.bi
	
	Lucid OverCalc - Main Header
	
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

#Pragma Once

'' Include headers:
#Include Once "inc/fberrors.bi"
#Include Once "inc/fbcolors.bi"

#Include "inc/exopts.bi"

'' Define UDTs and structures:
'' Parameters used at runtime:
Type RUNTIME_PARAMS
	uTempo As UInteger		'' Tempo to use.
	sngStepSize As Single	'' Step size.
	sngOffMin As Single		'' Minimum OFFtime.
	sngOffMax As Single		'' Maximum OFFtime.
	uTabsCount As UInteger	'' Whitespace between output columns.
	strNegOut As String*4	'' Negative output mode.
	bColor As Boolean		'' Color enable or disable.
End Type

'' Define constants:
#IfnDef NULL
	#Define NULL 0
#EndIf

'' Constant values used by LSDj:
Const LSDJ_MIN_TEMPO = 40		'' Min engine tempo for LSDj.
Const LSDJ_MAX_TEMPO = 295		'' Max engine tempo for LSDj.
Const LSDJ_OVERCLOCK_MULT = 2	'' LSDj software overclock multiplier.

'' Constants used by this program:
Const MAX_CLI_PARAMS = 13
Const MAX_CLI_PARAM_LEN = 12

'' Colors:
#Define DEF_COLOR 	&hFF
#Define COL_HEADER	(COL_BRIGHT Or COL_GREY)
#Define COL_GOOD		(COL_BRIGHT Or COL_GREEN)
#Define COL_WARN		(COL_BRIGHT Or COL_YELLOW)
#Define COL_ERROR 	(COL_BRIGHT Or COL_RED)

'' Define shared variables:
#If __FB_DEBUG__
	Dim Shared hDbgLog As Long	'' Debug log handle.
#EndIf
Dim Shared s_hErr As Long	'' Standard Error handle.
Dim Shared s_prtParams As RUNTIME_PARAMS Ptr	'' Parameters used at runtime.

'' Function declarations:
Declare Function SetColor (ByRef colFore As UByte = DEF_COLOR, ByRef colBack As UByte = DEF_COLOR) As ULong
Declare Sub RestoreColor (ByVal uColor As Const ULong)
Declare Function ValidTempo (ByVal uTempo As Const UInteger) As Boolean
Declare Function LogBaseX (ByVal dblNumber As Const Double, ByVal dblBase As Const Double) As Double
Declare Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
Declare Function CalcFreq (ByVal uTempo As Const UInteger, ByVal dblOffTime As Const Double) As Double

''EOF
