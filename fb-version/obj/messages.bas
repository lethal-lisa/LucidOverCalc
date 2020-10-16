/'
	
	messages.bas
	
	Lucid OverCalc - Messages Module
	
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

'' Prints out a help message.
Sub ShowHelp (ByVal hOut As Const Long)
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const Long:hOut = _&h& (&)"; Hex(hOut); hOut
	#EndIf
	
	'' Print out help to stderr.
	? #hOut, !"Lucid OverCalc - FreeBASIC Version\nHelp:\n"
	? #hOut, !"Syntax:\n\tlucidoc [{help|{ver|version}|{defs|defaults}|[<tempo>] [bareout] [stepsize <stepsize>] [mintime <offtime>] [maxtime <offtime>] [enablecolor {true|false}] [tabs <tabcount>] [negativeout <outputmode>]}]\n"
	? #hOut, !"\thelp\t\tShow this help message."
	? #hOut, !"\tver, version\tShow version information."
	? #hOut, !"\tdefs, defaults\tShow default settings for this build of Lucid."
	? #hOut, !"\t<tempo>\t\tTempo to use."
	? #hOut, !"\tbareout\t\tEnables ""bare"" output with fixed tab width. Use this if output is to be piped."
	? #hOut, !"\tstepsize\tSet the step size to <stepsize>."
	? #hOut, !"\tmintime\t\tSets the minimum OFFtime to calculate."
	? #hOut, !"\tmaxtime\t\tSets the maximum OFFtime to calculate."
	? #hOut, !"\tenablecolor\tEnables colored output."
	? #hOut, !"\ttabs\t\tSets the amount of whitespace between output columns."
	? #hOut, !"\tnegativeout\tSpecifies what to do if a frequency value is negative."
	? #hOut, !"\t\tAvailable values for <outputmode>: ""all"" does nothing, ""hide"" shows an ""N/A"", and ""omit"" disables output entirely."
	? #hOut, !"\n";
	
End Sub

'' Prints out version and build information.
Sub ShowVersion (ByVal hOut As Const Long)
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const Long:hOut = _&h& (&)"; Hex(hOut); Str(hOut)
	#EndIf
	
	'' Make sure hOut is a valid handle.
	If Not(CBool(hOut)) Then Error(FB_ERR_ILLEGALINSTRUCTION)
	
	'' Print out version information.
	? #hOut, "Build Information:"
	? #hOut, Using !"\tBuild Date:\t\t& &"; __DATE__; __TIME__
	
	'' Compiler information:
	? #hOut, Using !"\tCompiler Signature:\t&"; __FB_SIGNATURE__
	#If Len(__FB_BUILD_SHA1__)
		? #hOut, Using !"\tCompiler SHA-1:\t\t&"; __FB_BUILD_SHA1__
	#EndIf
	? #hOut, Using !"\tCompiler Build Date:\t&"; __FB_BUILD_DATE__
	? #hOut, Using !"\tCompiler Back End:\t&"; __FB_BACKEND__
	
	'' CPU & OS information:
	? #hOut, !"\tBuild Architecture:\t";
	#IfDef __FB_ARM__
		#IfDef __FB_64BIT__
			? #hOut, !"64-bit";
		#Else
			? #hOut, !"32-bit";
		#EndIf
		? #hOut, !" ARM";
	#Else
		#IfDef __FB_64BIT__
			? #hOut, !"x86_64";
		#Else
			? #hOut, !"x86";
		#EndIf
	#EndIf
	#IfDef __FB_BIGENDIAN__
		? #hOut, " (Big";
	#Else
		? #hOut, " (Little";
	#EndIf
	? #hOut, " endian)"
	
	'' FPU information:
	#IfDef __FB_SSE__
		? #hOut, !"\tFPU Used:\t\tSSE"
		? #hOut, Using !"\tFP Mode:\t\t&"; __FB_FPMODE__
	#Else
		? #hOut, !"\tFPU Used:\t\tx87"
	#EndIf
	
	? #hOut, !"\n";
	
End Sub

'' Prints out the default settings for the build.
Sub ShowDefaults (ByVal hOut As Const Long)
	
	#If __FB_DEBUG__
		? #g_pstdio->hDbg, Using "&: Calling: &/&"; Time(); __FILE__; __FUNCTION__
		? #g_pstdio->hDbg, Using !"\tByVal Const Long:hOut = _&h& (&)"; Hex(hOut); Str(hOut)
	#EndIf
	
	'' Make sure hOut is a valid handle.
	If Not(CBool(hOut)) Then Error(FB_ERR_ILLEGALINSTRUCTION)
	
	'' Print out default settings.
	? #hOut, "Default settings:"
	? #hOut, Using !"\tStep size:\t\t&"; Str(STEP_SIZE)
	? #hOut, Using !"\tMinimum OFF time:\t&"; Str(OFFTIME_MIN) 
	? #hOut, Using !"\tMaximum OFF time:\t&"; Str(OFFTIME_MAX)
	? #hOut, Using !"\tColor:\t\t\t&"; IIf(ENABLE_COLOR, "Enabled", "Disabled")
	? #hOut, Using !"\tColumn distance:\t&"; Str(TABS_COUNT)
	? #hOut, Using !"\tNegative output mode:\t&"; Str(NEGATIVE_OUTPUT)
	? #hOut, !"\n";
	
End Sub

''EOF
