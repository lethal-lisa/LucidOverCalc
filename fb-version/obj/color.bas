/'
	
	color.bas
	
	Lucid OverCalc - Color Module
	
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

#Include "inc/stdioobj.bi"
#Include "inc/color.bi"

Dim Shared g_colCurrent As ULong
Dim Shared g_colPrevious As ULong
Dim Shared g_colDefColor As ULong
Dim Shared g_bEnableColor As Boolean

'' Sets the console color only if ENABLE_COLOR is TRUE.
Function SetColor (ByRef colFore As UByte = DEF_COLOR, ByRef colBack As UByte = DEF_COLOR) As ULong
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByRef UByte:colFore = _&h& (&)"; Hex(colFore); colFore
		? #g_pstdio->hDbg, Using !"\tByRef UByte:colBack = _&h& (&)"; Hex(colBack); colBack
	#EndIf
	
	'' Preserve the old color.
	''Dim uOldColor As ULong = Color
	g_colCurrent = Color()
	g_colPrevious = g_colCurrent
	
	''If g_prtParams->bColor Then
	If g_bEnableColor Then
		
		'' Check for default colors, and use them if needed.
		If (colFore = DEF_COLOR) Then colFore = CUByte(LoWord(g_colDefColor))
		If (colFore = CUR_COLOR) Then colFore = CUbyte(LoWord(g_colCurrent))
		If (colBack = DEF_COLOR) Then colBack = CUByte(HiWord(g_colDefColor))
		If (colBack = CUR_COLOR) Then colBack = CUByte(HiWord(g_colCurrent))
		
		'' Set the new color.
		Color colFore, colBack
		
	EndIf
	
	'' Return the old color.
	''Return uOldColor
	Return g_colPrevious
	
End Function

'' Restores back the original color only if ENABLE_COLOR is TRUE.
Sub RestoreColor (ByVal uColor As Const ULong)
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const ULong:uColor = _&h& (&)"; Hex(uColor); uColor
	#EndIf
	
	''If g_prtParams->bColor Then Color LoWord(uColor), HiWord(uColor)
	If g_bEnableColor Then Color LoWord(uColor), HiWord(uColor)
	
End Sub

''EOF
