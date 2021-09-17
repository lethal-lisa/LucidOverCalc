/'
	
	seterror.bas
	
	Retains error codes across modules.
	
	Copyright 2020-2021 Lisa Murray
	
	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 3 of the License, or
	any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
	MA 02110-1301, USA.
	
'/

#Include "inc/seterror.bi"

Dim Shared g_uLastError As ULong

Function SetError (ByVal uError As Const ULong) As ULong
	Err = uError
	g_uLastError = uError
	Return uError
End Function

''EOF
