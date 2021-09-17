/'
	
	fberrors.bi
	
	FreeBASIC RunTime Error Codes
	
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
#IfnDef __FBERRORS__
#Define __FBERRORS__

''FreeBASIC run time error codes
#Define FB_ERR_SUCCESS				0
#Define FB_ERR_ILLEGALFUNCTION		1
#Define FB_ERR_FILENOTFOUND			2
#Define FB_ERR_FILEIO				3
#Define FB_ERR_OUTOFMEMORY			4
#Define FB_ERR_ILLEGALRESUME			5 ''only with -ex
#Define FB_ERR_OUTOFBOUNDSARRAY		6 ''only with -exx
#Define FB_ERR_NULLPTRACCESS			7 ''only with -exx
#Define FB_ERR_NOPRIVILEGES			8
#Define FB_ERR_INTERRUPTED			9
#Define FB_ERR_ILLEGALINSTRUCTION	10
#Define FB_ERR_FLOATINGPOINT			11
#Define FB_ERR_SEGMENTATIONVIOLATION	12
#Define FB_ERR_TERMINATIONREQUEST	13
#Define FB_ERR_ABNORMALTERMINATION	14
#Define FB_ERR_QUITREQUEST			15
#Define FB_ERR_RETURNWITHOUTGOSUB	16
#Define FB_ERR_ENDOFFILE				17

''some aliases for the fbrt error codes
#Define FB_ERR_NOERROR				FB_ERR_SUCCESS
#Define FB_ERR_ILLFUNC				FB_ERR_ILLEGALFUNCTION
#Define FB_ERR_ILLRESUME				FB_ERR_ILLEGALRESUME
#Define FB_ERR_ILLINSTRUCTION		FB_ERR_ILLEGALINSTRUCTION
#Define FB_ERR_SEGVIOLATION			FB_ERR_SEGMENTATIONVIOLATION
#Define FB_ERR_TERMREQ				FB_ERR_TERMINATIONREQUEST
#Define FB_ERR_ABNORMALTERM			FB_ERR_ABNORMALTERMINATION
#Define FB_ERR_QUITREQ				FB_ERR_QUITREQUEST
#Define FB_ERR_EOF					FB_ERR_ENDOFFILE

#EndIf

''EOF
