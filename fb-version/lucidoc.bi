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

'' Define constants:
#IfnDef NULL
	#Define NULL 0
#EndIf

'' Constant values used by LSDj:
/'Const LSDJ_MIN_TEMPO = 40		'' Min engine tempo for LSDj.
Const LSDJ_MAX_TEMPO = 295		'' Max engine tempo for LSDj.
Const LSDJ_OVERCLOCK_MULT = 2	'' LSDj software overclock multiplier.'/
Enum LSDJ Explicit
	minTempo = 40
	maxTempo = 295
	overclockMult = 2
End Enum

'' Maximum count of command line parameters used by this program.
Const MAX_CLI_PARAMS = 14

'' Values for different negative output modes.
Enum NEGOUT Explicit
	ALL = 1
	HIDE
	OMIT
End Enum

'' Colors:
#Define DEF_COLOR 	&hFF
/'#Define COL_HEADER	(COL_BRIGHT Or COL_GREY)
#Define COL_GOOD		(COL_BRIGHT Or COL_GREEN)
#Define COL_WARN		(COL_BRIGHT Or COL_YELLOW)
#Define COL_ERROR 	(COL_BRIGHT Or COL_RED)'/

'' Define UDTs and structures:
'' Parameters used at runtime:
Type RUNTIME_PARAMS
	uTempo As UInteger		'' Tempo to use.
	sngStepSize As Single	'' Step size.
	sngOffMin As Single		'' Minimum OFFtime.
	sngOffMax As Single		'' Maximum OFFtime.
	uTabsCount As UInteger	'' Whitespace between output columns.
	uNegOut As UByte		'' Negative output mode.
	bColor As Boolean		'' Color enable or disable.
	bBareOut As Boolean		'' Bare output enable.
End Type

Type STDIO_HANDLES
	hOut As Long
	''hIn As Long
	''hCons As Long
	hErr As Long
	#If __FB_DEBUG__
		hDbg As Long
	#EndIf
	Declare Constructor
	Declare Destructor
End Type

'' Define shared variables:
/'#If __FB_DEBUG__
	Dim Shared g_pstdio->hDbg As Long	'' Debug log handle.
#EndIf
Dim Shared g_pstdio->hErr As Long	'' Standard Error handle.
Dim Shared g_pstdio->hOut As Long	'' Standard Output handle.
Dim Shared g_prtParams As RUNTIME_PARAMS Ptr	'' Parameters used at runtime.
Dim Shared g_colCurrent As ULong	'' Buffer for global color.'/
Extern g_prtParams As RUNTIME_PARAMS Ptr
Extern g_pstdio As STDIO_HANDLES Ptr

Extern g_colCurrent As ULong
Extern g_colDefColor As ULong

Extern g_uLastError As ULong

'' Function declarations:
Declare Function SetError (ByVal uError As Const ULong) As ULong

'' From module obj/messages.bas:
Declare Sub ShowHelp (ByVal hOut As Const Long)
Declare Sub ShowVersion (ByVal hOut As Const Long)
Declare Sub ShowDefaults (ByVal hOut As Const Long)

'' From module obj/input.bas:
Declare Function ParseCmdLine (ByVal pParams As RUNTIME_PARAMS Const Ptr) As ULong
Declare Function ValidTempo (ByVal uTempo As Const UInteger) As Boolean
Declare Function GetTempo () As UInteger

'' From module obj/color.bas:
Declare Function SetColor (ByRef colFore As UByte = DEF_COLOR, ByRef colBack As UByte = DEF_COLOR) As ULong
Declare Sub RestoreColor (ByVal uColor As Const ULong)

'' From module obj/output.bas:
Declare Sub PrintHeader ()
Declare Sub PrintFormattedRow (ByVal iStep As Const Single, ByVal dblFreq As Const Double)

Declare Function LogBaseX (ByVal dblBase As Const Double, ByVal dblNumber As Const Double) As Double
Declare Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
Declare Function CalcFreq (ByVal uTempo As Const UInteger, ByVal dblOffTime As Const Double) As Double

''EOF
