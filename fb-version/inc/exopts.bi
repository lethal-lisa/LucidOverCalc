/'
	
	exopts.bi
	
	Lucid OverCalc - Experimental and Optional Compile-time Parameters Header
	
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
#IfnDef __LOC_EXOPTS__
#Define __LOC_EXOPTS__

'' Size used to iterate through steps.
#IfnDef STEP_SIZE
	#Define STEP_SIZE 0.5
#Else
	#If __FB_DEBUG__
		#Print __FILE_NQ__: Using custom STEP_SIZE default.
		#Print STEP_SIZE = STEP_SIZE
	#EndIf
	#If (STEP_SIZE > 1) Or (STEP_SIZE < -1) Or (STEP_SIZE = 0)
		#Error STEP_SIZE is an invalid STEP_SIZE value.
	#EndIf
#EndIf

'' Controls the minimum offtime.
#IfnDef OFFTIME_MIN
	#Define OFFTIME_MIN 1
#Else
	#If __FB_DEBUG__
		#Print __FILE_NQ__: Using custom OFFTIME_MIN default.
		#Print OFFTIME_MIN = OFFTIME_MIN
	#EndIf
#EndIf

'' Controls the maximum offtime.
#IfnDef OFFTIME_MAX
	#Define OFFTIME_MAX 8
#Else
	#If __FB_DEBUG__
		#Print __FILE_NQ__: Using custom OFFTIME_MAX default.
		#Print OFFTIME_MAX = OFFTIME_MAX
	#EndIf
#EndIf

#Assert OFFTIME_MIN < OFFTIME_MAX

'' Controls the default octave-shift.
#IfnDef OCTAVE_SHIFT
	#Define OCTAVE_SHIFT 1
#Else
	#If __FB_DEBUG__
		#Print __FILE_NQ__: Using custome OCTAVE_SHIFT default.
		#Print OCTAVE_SHIFT = OCTAVE_SHIFT
	#EndIf
#EndIf

'' Value used in Tab() command to space out output.
#IfnDef TABS_COUNT
	#Define TABS_COUNT 15
#EndIf

'' Controls the negative output state.
#IfnDef NEGATIVE_OUTPUT
	#Define NEGATIVE_OUTPUT 2
#Else
	#If __FB_DEBUG__
		#Print __FILE_NQ__: Using custom NEGATIVE_OUTPUT default.
		#Print NEGATIVE_OUTPUT = NEGATIVE_OUTPUT
	#EndIf
	#If (NEGATIVE_OUTPUT < 1) Or (NEGATIVE_OUTPUT > 3)
		#Error NEGATIVE_OUTPUT is an invalid NEGATIVE_OUTPUT value.
	#EndIf
#EndIf

'' Controls bare output mode.
#IfnDef BARE_OUTPUT
	#Define BARE_OUTPUT FALSE
#Else
	#If __FB_DEBUG__
		#Print __FILE_NQ__: Using custom BARE_OUTPUT default.
		#Print BARE_OUTPUT = BARE_OUTPUT
	#EndIf
#EndIf
	
#EndIf

''EOF
