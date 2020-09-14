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
Const OFFTIME_MIN = 1.0			'' Min value for OFFtime.
Const OFFTIME_MAX = 5.0			'' Max value for OFFtime.

'' Constants used by this program:
Const MAX_CLI_PARAMS = 2

'' Function declarations:
Declare Function ValidTempo (ByRef uTempo As Const UInteger) As Boolean
Declare Function LogBaseX (ByVal dblNumber As Double, ByVal dblBase As Double) As Double
Declare Function CalcMainHz (ByVal uTempo As Const UInteger) As Double
Declare Function CalcFreq (ByVal uTempo As Const UInteger, ByVal uStep As Const Double) As Double

''EOF
