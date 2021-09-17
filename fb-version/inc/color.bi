/'
	
	color.bi
	
	Lucid - Color functionality header
	
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

#IfnDef DEF_COLOR
	#Define DEF_COLOR &hFF
#EndIf

#IfnDef CUR_COLOR
	#Define CUR_COLOR &hF7
#EndIf

#IfnDef PREV_COLOR
	#Define PREV_COLOR &hE0
#EndIf

#Assert (PREV_COLOR < CUR_COLOR) And (CUR_COLOR < DEF_COLOR) And (DEF_COLOR > &h0F)

/'Type COLOR_THEME
	colDefault As ULong
	colEmphasis As ULong
	colGood As ULong
	colWarn As ULong
	colError As ULong
End Type

Extern g_pColTheme As COLOR_THEME Ptr'/

Extern g_colCurrent As ULong	'' Buffer for current color.
Extern g_colPrevious As ULong	'' Buffer for previous color.
Extern g_colDefColor As ULong	'' Buffer for default color.
Extern g_bEnableColor As Boolean	'' Enable or disable color.

Declare Sub InitColorModule (ByVal bEnableColor As Const Boolean = TRUE)

/'	SetColor:
	
	Sets console colors only if g_bEnableColor is TRUE.
	
	Parameters:
		ByRef UByte:colFore = DEF_COLOR:
			Value for the foreground color.
		ByRef UByte:colBack = DEF_COLOR:
			Value for the background color.
		
			If either parameter is set to DEF_COLOR, the default
		console color in g_colDefColor is used. If set to CUR_COLOR, no
		changes are made. On exiting parameter values are always set to
		the values of the new colors, unless an error occurs.
	
	Return Value:
		Returns the previous color code in the same format as FB's
	Color().

'/
Declare Function SetColor (ByRef colFore As UByte = DEF_COLOR, ByRef colBack As UByte = DEF_COLOR) As ULong

/'	RestoreColor:
	
	Restores an FB-format color code only if g_bEnableColor is TRUE.
	
'/
Declare Sub RestoreColor (ByVal uColor As Const ULong)

''EOF
