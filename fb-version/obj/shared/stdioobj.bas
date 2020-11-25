/'
	
	stdioobj.bas
	
	Standard I/O Object
	
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

#Include Once "inc/shared/fberrors.bi"
#Include "inc/shared/seterror.bi"
#Include "inc/shared/stdioobj.bi"

Dim Shared g_strDbgFile As String
Dim Shared g_pstdio As STDIO_HANDLES Ptr

Constructor STDIO_HANDLES
	
	On Local Error GoTo FAIL
	
	'' Open standard output.
	This.hOut = FreeFile()
	Open Cons For Output As #This.hOut
	If Err() Then Error(Err())
	
	'' Open standard input.
	This.hIn = FreeFile()
	Open Cons For Input As #This.hIn
	If Err() Then Error(Err())
	
	'' Open standard error.
	This.hErr = FreeFile()
	Open Err As #This.hErr
	If Err() Then Error(Err())
	
	'' Open debug log.
	#If __FB_DEBUG__
		''This.strDbgFile = strDbgLog
		This.hDbg = FreeFile()
		
		If Len(g_strDbgFile) Then
			Open g_strDbgFile For Output As #This.hDbg
		Else
			Open Cons For Output As #This.hDbg
		EndIf
		
		If Err() Then Error(Err())
	#EndIf
	
	'' Set success error code.
	SetError(FB_ERR_SUCCESS)
	Return
	
	FAIL:
	Scope
		Dim uErr As ULong = Err()
		If This.hOut Then Close #This.hOut
		If This.hIn Then Close #This.hIn
		If This.hErr Then Close #This.hErr
		#If __FB_DEBUG__
			If This.hDbg Then Close #This.hDbg
		#EndIf
		SetError(uErr)
	End Scope
	
End Constructor

Destructor STDIO_HANDLES
	
	'' Close any open handles.
	If This.hOut Then Close #This.hOut
	If This.hIn Then Close #This.hIn
	If This.hErr Then Close #This.hErr
	#If __FB_DEBUG__
		If This.hDbg Then Close #This.hDbg
	#EndIf
	
End Destructor

''EOF
