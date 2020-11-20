
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
