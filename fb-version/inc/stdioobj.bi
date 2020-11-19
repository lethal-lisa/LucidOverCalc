
#Pragma Once

'' Standard I/O handles:
Type STDIO_HANDLES
	hOut As Long	'' Standard output handle.
	hErr As Long	'' Standard error handle.
	#If __FB_DEBUG__
		strDbgFile As String	'' Debug log file.
		hDbg As Long	'' Debug log handle.
	#EndIf
	Declare Constructor
	Declare Destructor
End Type

Extern g_pstdio As STDIO_HANDLES Ptr	'' Standard I/O handles structure.

''EOF
