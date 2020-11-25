/'
	
	fbcolors.bi
	
	FreeBASIC Console Mode Colors
	
		Defines the default palette used by screen modes 7, 8, 9, and 12,
	and console mode.
	
		To access intense colors Or any of the eight basic colors with
	COL_BRIGHT or COL_INTENSE.
	
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

#Pragma Once
#IfnDef __FBCONSCOLORS__
#Define __FBCONSCOLORS__

#Define COL_BLACK	&h00
#Define COL_BLUE		&h01
#Define COL_GREEN	&h02
#Define COL_CYAN		&h03
#Define COL_RED		&h04
#Define COL_PINK		&h05
#Define COL_YELLOW	&h06
#Define COL_GREY		&h07

#Define COL_INTENSE	&h08

'' Aliases:
#Define COL_BRIGHT	COL_INTENSE
#Define COL_GRAY		COL_GREY

'' Three-letter aliases:
#Define COL_BLK		COL_BLACK
#Define COL_BLU		COL_BLUE
#Define COL_GRN		COL_GREEN
#Define COL_CYN		COL_CYAN
''#Define COL_RED		COL_RED
#Define COL_PNK		COL_PINK
#Define COL_YLW		COL_YELLOW
#Define COL_GRY		COL_GREY

#Define COL_INT		COL_INTENSE
#Define COL_BRI		COL_BRIGHT

#EndIf

''EOF
