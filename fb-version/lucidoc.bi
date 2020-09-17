/'
	
	lucidoc.bi
	
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

#Include Once "inc/fberrors.bi"

#IfnDef NULL
	#Define NULL 0
#EndIf

'' Constant values used by LSDj:
Const LSDJ_MIN_TEMPO = 40		'' Min engine tempo for LSDj.
Const LSDJ_MAX_TEMPO = 295		'' Max engine tempo for LSDj.
Const LSDJ_OVERCLOCK_MULT = 2	'' LSDj software overclock multiplier.

'' Constants related to calculations:
Const OFFTIME_MIN = 1			'' Min value for OFFtime.
Const OFFTIME_MAX = 5			'' Max value for OFFtime.

'' Constants used by this program:
#IfnDef STEP_SIZE
	#Define STEP_SIZE -0.5		'' Size used to iterate through steps.
#EndIf
#IfnDef TABS_COUNT
	#Define TABS_COUNT 10		'' Value used in Tab() command to space out output.
#EndIf
#IfnDef NEGATIVE_OUTPUT
	#Define NEGATIVE_OUTPUT 0	'' Controls the negative output state.
#EndIf
#IfnDef USE_COLOR
	#Define USE_COLOR FALSE		'' Controls the usage of colored output.
#EndIf

'' Function declarations:
Declare Function ValidTempo (ByRef uTempo As Const UInteger) As Boolean
Declare Function LogBaseX (ByVal dblNumber As Const Double, ByVal dblBase As Const Double) As Double
Declare Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
Declare Function CalcFreq (ByVal uTempo As Const UInteger, ByVal uStep As Const Double) As Double

''EOF
