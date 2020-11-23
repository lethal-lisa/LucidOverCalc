/'
	
	stdioobj.bi
	
	Standard I/O Object Header
	
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

'' Standard I/O handles:
Type STDIO_HANDLES
	hOut As Long	'' Standard output handle.
	hIn As Long		'' Standard input handle.
	hErr As Long	'' Standard error handle.
	#If __FB_DEBUG__
		''strDbgFile As String	'' Debug log file.
		hDbg As Long	'' Debug log handle.
	#EndIf
	Declare Constructor ''(ByRef strDbgLog As Const String = "")
	Declare Destructor
End Type

Extern g_strDbgFile As String	'' Debug log file name.
Extern g_pstdio As STDIO_HANDLES Ptr	'' Standard I/O handles structure.

''EOF
