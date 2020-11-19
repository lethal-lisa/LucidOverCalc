
#Include Once "inc/fberrors.bi"
#Include "inc/seterror.bi"
#Include "inc/stdioobj.bi"

Dim Shared g_pstdio As STDIO_HANDLES Ptr

Constructor STDIO_HANDLES (ByRef strDbgLog As Const String = "")
	
	On Local Error GoTo FAIL
	
	'' Open standard output.
	This.hOut = FreeFile()
	Open Cons For Output As #This.hOut
	If Err() Then Error(Err())
	
	'' Open standard error.
	This.hErr = FreeFile()
	Open Err As #This.hErr
	If Err() Then Error(Err())
	
	#If __FB_DEBUG__
		This.strDbgFile = strDbgLog
		This.hDbg = FreeFile()
		If Len(This.strDbgFile) Then
			Open This.strDbgFile For Output As #This.hDbg
		Else
			Open Cons For Output As #This.hDbg
		EndIf
		If Err() Then Error(Err())
	#EndIf
	
	SetError(FB_ERR_SUCCESS)
	Return
	
	FAIL:
	If This.hOut Then Close #This.hOut
	If This.hErr Then Close #This.hErr
	#If __FB_DEBUG__
		If This.hDbg Then Close #This.hDbg
	#EndIf
	SetError(Err())
	
End Constructor

Destructor STDIO_HANDLES
	
	If This.hOut Then Close #This.hOut
	If This.hErr Then Close #This.hErr
	#If __FB_DEBUG__
		If This.hDbg Then Close #This.hDbg
	#EndIf
	
End Destructor

''EOF
