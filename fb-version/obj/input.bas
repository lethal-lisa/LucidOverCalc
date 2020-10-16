/'
	
	input.bas
	
	Lucid OverCalc - Input Module
	
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
#Include "lucidoc.bi"

Declare Function GetNegOutMode (ByRef strNegOut As Const String) As UByte
Declare Function CheckNegOutMode (ByVal uNegOut As Const UByte) As Boolean

'' Parses the command line.
Function ParseCmdLine (ByVal pParams As RUNTIME_PARAMS Const Ptr) As ULong
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const RUNTIME__PARAMS Ptr:pParams = @_&h&"; Hex(pParams)
	#EndIf
	
	#Macro INC_SET_CMD(index)
		If pbParam[index] Then Exit Select
		iCmd += 1
		pbParam[index] = TRUE
	#EndMacro
	
	On Local Error GoTo FAIL
	
	'' Make sure pParams is a valid pointer.
	If (pParams = NULL) Then Error(FB_ERR_NULLPTRACCESS)
	
	Dim iCmd As UInteger		'' Parameter index.
	Dim strCmd As String		'' Buffer for parameter.
	Dim pbParam As Boolean Ptr	'' Array of booleans showing which parameters have already been set.
	
	/'	pbParam Info:
		
			Values in pbParam are set to TRUE once a parameter has been
		checked.
		
		Index Values:
		0 = "stepsize"
		1 = "mintime"
		2 = "maxtime"
		3 = "enablecolor"
		4 = "tabs"
		5 = "negativeout"
		6 = "bareout"
	'/
	
	'' Allocate space for pbParam
	pbParam = CAllocate(7, SizeOf(Boolean))
	If (pbParam = NULL) Then Error(FB_ERR_OUTOFMEMORY)
	
	Do
		
		'' Get next parameter and convert to lowercase.
		iCmd += 1
		strCmd = LCase(Command(iCmd))
		
		#If __FB_DEBUG__
			? #g_pstdio->hDbg, Using !"&:\tChecking parameter _#&"; Time(); iCmd
			? #g_pstdio->hDbg, Using !"\tFound: ""&"""; strCmd
		#EndIf
		
		'' Make sure a parameter is present.
		If (Len(strCmd) <= 0) Then Exit Do
		
		Select Case strCmd
			Case "help"
				
				'' Show help and exit.
				ShowHelp(g_pstdio->hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "ver", "version"
				
				'' Show version information and exit.
				ShowVersion(g_pstdio->hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "defs", "defaults"
				
				'' Show default settings and exit.
				ShowDefaults(g_pstdio->hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "stepsize"
				
				'' Get stepsize.
				INC_SET_CMD(0)
				pParams->sngStepSize = CSng(Command(iCmd))
				
			Case "mintime"
				
				'' Get minimum OFF time.
				INC_SET_CMD(1)
				pParams->sngOffMin = CSng(Command(iCmd))
				
			Case "maxtime"
				
				'' Get maximum OFF time.
				INC_SET_CMD(2)
				pParams->sngOffMax = CSng(Command(iCmd))
				
			Case "enablecolor"
				
				'' Get color settings.
				INC_SET_CMD(3)
				pParams->bColor = CBool(Command(iCmd))
				
			Case "tabs"
				
				'' Get tab settings.
				INC_SET_CMD(4)
				pParams->uTabsCount = CUInt(Command(iCmd))
				
			Case "negout", "negativeout"
				
				'' Get negative output settings.
				INC_SET_CMD(5)
				pParams->uNegOut = GetNegOutMode(Command(iCmd))
				If Not(CheckNegOutMode(pParams->uNegOut)) Then
					? #g_pstdio->hErr, Using """&"" is not a valid negative output mode."; Command(iCmd)
					Error FB_ERR_ILLEGALINSTRUCTION
				EndIf
				
			Case "bareout"
				
				'' Get bare output mode.
				If pbParam[6] Then Exit Select
				pbParam[6] = TRUE
				pParams->bBareOut = TRUE
				
			Case Else
				
				'' Assume any unknown parameter is a tempo.
				pParams->uTempo = CUInt(strCmd)
				
		End Select
		
	Loop While (iCmd < MAX_CLI_PARAMS)
	
	Err = FB_ERR_SUCCESS
	
	FAIL:
	If pbParam Then DeAllocate pbParam
	Return(Err())
	
End Function

'' Gets a negative output mode.
Private Function GetNegOutMode (ByRef strNegOut As Const String) As UByte
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByRef Const String:strNegOut = ""&"""; strNegOut
	#EndIf
	
	Select Case LCase(strNegOut)
		Case "all" : Return NEGOUT.ALL
		Case "hide" : Return NEGOUT.HIDE
		Case "omit" : Return NEGOUT.OMIT
		Case Else : Return NULL
	End Select
	
End Function

'' Checks for a valid negative output mode.
Private Function CheckNegOutMode (ByVal uNegOut As Const UByte) As Boolean
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const UByte:uNegOut = _&h& (&)"; Hex(uNegOut); uNegOut
	#EndIf
	
	Return CBool((uNegOut >= NEGOUT.ALL) AndAlso (uNegOut <= NEGOUT.OMIT))
	
End Function

'' Makes sure uTempo is a valid tempo.
Function ValidTempo (ByVal uTempo As Const UInteger) As Boolean
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const UInteger:uTempo = _&h& (&)"; Hex(uTempo); uTempo
	#EndIf
	
	''Return Not(CBool((uTempo < LSDJ_MIN_TEMPO) OrElse (uTempo > LSDJ_MAX_TEMPO)))
	Return Not(CBool((uTempo < LSDJ.minTempo) OrElse (uTempo > LSDJ.maxTempo)))
	
End Function

'' Get tempo by prompting the user.
Function GetTempo () As UInteger
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
	#EndIf
	
	Dim uTempo As UInteger	'' Temporary storage for tempo.
	''Dim hIn As Long			'' Standard input handle
	
	'' Get standard input handle.
	/'hIn = FreeFile()
	Open Cons For Input As #hIn
	If Err() Then Error(Err())'/
	
	'' Get tempo by prompting the user if the command line is invalid.
	Do
		
		'' Display valid tempos and prompt user.
		g_colCurrent = SetColor COL_GOOD
		? #g_pstdio->hErr, Using "Valid tempos are integers between & and &."; Str(LSDJ.minTempo); Str(LSDJ.maxTempo)
		RestoreColor g_colCurrent
		''? #g_pstdio->hErr, "Tempo? ";
		Input "Tempo? ", uTempo
		''Input #g_pstdio->hIn, uTempo
		
		
		'' Continue if provided tempo is valid.
		If ValidTempo(uTempo) Then Exit Do
		
		'' Issue warning about invalid tempo and prompt again.
		g_colCurrent = SetColor COL_WARN
		? #g_pstdio->hErr, Using "& is an invalid tempo."; uTempo
		RestoreColor g_colCurrent
		
	Loop
	
	''Close #hIn
	Return(uTempo)
	
End Function

''EOF
