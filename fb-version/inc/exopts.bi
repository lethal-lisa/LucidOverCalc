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

'' Default values for if none are defined at compile-time.
#Define DEF_STEP_SIZE		0.5
#Define DEF_OFFTIME_MIN		1
#Define DEF_OFFTIME_MAX		8
#Define DEF_TABS_COUNT		15
#Define DEF_NEGATIVE_OUTPUT	"hide"
#Define DEF_ENABLE_COLOR		TRUE

'' Size used to iterate through steps.
#IfnDef STEP_SIZE
	#Define STEP_SIZE DEF_STEP_SIZE
#EndIf

'' Controls the minimum offtime.
#IfnDef OFFTIME_MIN
	#Define OFFTIME_MIN
#EndIf

'' Controls the maximum offtime.
#IfnDef OFFTIME_MAX
	#Define OFFTIME_MAX
#EndIf

'' Value used in Tab() command to space out output.
#IfnDef TABS_COUNT
	#Define TABS_COUNT DEF_TABS_COUNT
#EndIf

'' Controls the negative output state.
#IfnDef NEGATIVE_OUTPUT
	#Define NEGATIVE_OUTPUT DEF_NEGATIVE_OUTPUT
#EndIf

'' Controls the usage of colored output.
#IfnDef ENABLE_COLOR
	#Define ENABLE_COLOR DEF_ENABLE_COLOR
#EndIf

'' Print out used values if debug mode is enabled.
#If __FB_DEBUG__
	#Print Compile-time Parameters:
	#Print STEP_SIZE = STEP_SIZE
	#Print OFFTIME_MAX = OFFTIME_MAX
	#Print OFFTIME_MIN = OFFTIME_MIN
	#Print TABS_COUNT = TABS_COUNT
	#Print NEGATIVE_OUTPUT = NEGATIVE_OUTPUT
	#Print ENABLE_COLOR = ENABLE_COLOR
#EndIf

''EOF
