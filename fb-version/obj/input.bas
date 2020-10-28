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

Enum CLI_PARAMS
	MAX_CLI_PARAMS = 16
	OPT_STEPSIZE = 0
	OPT_MINTIME
	OPT_MAXTIME
	OPT_OCTSHIFT
	OPT_COLOR
	OPT_TABS
	OPT_NEGOUT
	OPT_BAREOUT
	C_OPTS
End Enum

Declare Function GetNegOutMode (ByRef strNegOut As Const String) As UByte
Declare Function CheckNegOutMode (ByVal uNegOut As Const UByte) As Boolean

Private Function CheckOption (ByVal uOption As UInteger, ByRef pbParam As Boolean Const Ptr) As Boolean
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal UInteger:uOption = _&h&"; Hex(uOption)
		? #g_pstdio->hDbg, Using !"\tByRef Boolean Const Ptr:pbParam = @_&h&"; Hex(pbParam)
	#EndIf
	
	If (pbParam = NULL) Then Error(SetError(FB_ERR_NULLPTRACCESS))
	If (uOption >= C_OPTS) Then Error(SetError(FB_ERR_ILLEGALFUNCTION))
	
	If pbParam[uOption] Then
		Return TRUE
	Else
		pbParam[uOption] = TRUE
		Return FALSE
	EndIf
	
End Function

'' Parses the command line.
Function ParseCmdLine () As ULong
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
	#EndIf
		
	On Local Error GoTo FAIL
	
	Dim iCmd As UInteger		'' Parameter index.
	Dim pbParam As Boolean Ptr	'' Array of booleans showing which parameters have already been set.
	Dim strCmd As String		'' Buffer for option string.
	
	'' Allocate space for pbParam
	pbParam = CAllocate(C_OPTS, SizeOf(Boolean))
	If (pbParam = NULL) Then Error(SetError(FB_ERR_OUTOFMEMORY))
	
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
				
			Case "version", "ver"
				
				'' Show version information and exit.
				ShowVersion(g_pstdio->hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "defaults", "defs"
				
				'' Show default settings and exit.
				ShowDefaults(g_pstdio->hOut)
				Error FB_ERR_QUITREQUEST
				
			Case "stepsize", "step"
				
				'' Get stepsize.
				If CheckOption(OPT_STEPSIZE, pbParam) Then Exit Select
				iCmd += 1
				g_prtParams->sngStepSize = CSng(Command(iCmd))
				
			Case "mintime"
				
				'' Get minimum OFF time.
				If CheckOption(OPT_MINTIME, pbParam) Then Exit Select
				iCmd += 1
				g_prtParams->sngOffMin = CSng(Command(iCmd))
				
			Case "maxtime"
				
				'' Get maximum OFF time.
				If CheckOption(OPT_MAXTIME, pbParam) Then Exit Select
				g_prtParams->sngOffMax = CSng(Command(iCmd))
				
			Case "octaveshift", "octshift"
				
				'' Get octave-shift settings.
				If CheckOption(OPT_OCTSHIFT, pbParam) Then Exit Select
				iCmd += 1
				g_prtParams->uOctShift = CUByte(Command(iCmd))
				
			Case "enablecolor", "color"
				
				'' Get color settings.
				If CheckOption(OPT_COLOR, pbParam) Then Exit Select
				iCmd += 1
				g_prtParams->bColor = CBool(Command(iCmd))
				
			Case "tabs"
				
				'' Get tab settings.
				If CheckOption(OPT_TABS, pbParam) Then Exit Select
				iCmd += 1
				g_prtParams->uTabsCount = CUInt(Command(iCmd))
				
			Case "negativeoutput", "negativeout", "negout"
				
				'' Get negative output settings.
				If CheckOption(OPT_NEGOUT, pbParam) Then Exit Select
				iCmd += 1
				g_prtParams->uNegOut = GetNegOutMode(Command(iCmd))
				If Not(CheckNegOutMode(g_prtParams->uNegOut)) Then
					? #g_pstdio->hErr, Using """&"" is not a valid negative output mode."; Command(iCmd)
					Error(SetError(FB_ERR_ILLEGALINSTRUCTION))
				EndIf
				
			Case "bareoutput", "bareout", "bare"
				
				'' Get bare output mode.
				If CheckOption(OPT_BAREOUT, pbParam) Then Exit Select
				g_prtParams->bBareOut = TRUE
				
			Case Else
				
				'' Assume any unknown parameter is a tempo.
				g_prtParams->uTempo = CUInt(strCmd)
				
		End Select
		
	Loop While (iCmd < MAX_CLI_PARAMS)
	
	SetError FB_ERR_SUCCESS
	
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
	
	'' Get tempo by prompting the user if the command line is invalid.
	Do
		
		'' Display valid tempos and prompt user.
		g_colCurrent = SetColor COL_GOOD
		? #g_pstdio->hErr, Using "Valid tempos are integers between & and &."; Str(LSDJ.minTempo); Str(LSDJ.maxTempo)
		RestoreColor g_colCurrent
		Input "Tempo? ", uTempo
		
		'' Continue if provided tempo is valid.
		If ValidTempo(uTempo) Then Exit Do
		
		'' Issue warning about invalid tempo and prompt again.
		g_colCurrent = SetColor COL_WARN
		? #g_pstdio->hErr, Using "& is an invalid tempo."; uTempo
		RestoreColor g_colCurrent
		
	Loop
	
	Return(uTempo)
	
End Function

''EOF
