
#Include "inc/seterror.bi"

Dim Shared g_uLastError As ULong

Function SetError (ByVal uError As Const ULong) As ULong
	Err = uError
	g_uLastError = uError
	Return uError
End Function

''EOF
