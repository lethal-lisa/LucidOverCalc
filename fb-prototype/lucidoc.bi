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

#Include Once "fberrors.bi"

#IfnDef NULL
	#Define NULL 0
#EndIf

Const LSDJ_MIN_TEMPO = 40		''minimum engine tempo for LSDj
Const LSDJ_MAX_TEMPO = 295		''maximum engine tempo for LSDj
Const OVERCLOCK_MULT = 2		''LSDj software overclock multiplier

''frequency of first, highest note, where length of OFF time = 1.0
''Const MAINHZ = 188

''TODO: Check OFFTIME_MAX value with infu.
Const OFFTIME_MIN = 1.0			''min value for OFFtime
Const OFFTIME_MAX = 5.0			''max value for OFFtime

''EOF
