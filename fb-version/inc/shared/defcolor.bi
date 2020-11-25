
#Pragma Once

#Include "inc/shared/fbcolors.bi"

'' Controls the usage of colored output.
#IfnDef ENABLE_COLOR
	#Define ENABLE_COLOR TRUE
#Else
	#If __FB_DEBUG__
		#Print __FILE_NQ__: Using custom ENABLE_COLOR default.
		#Print ENABLE_COLOR = ENABLE_COLOR
	#EndIf
#EndIf

'' Default color theme:
#IfnDef COL_HEADER
	#Define COL_HEADER (COL_BRIGHT Or COL_GREY)
#EndIf

#IfnDef COL_GOOD
	#Define COL_GOOD (COL_BRIGHT Or COL_GREEN)
#EndIf

#IfnDef COL_WARN
	#Define COL_WARN (COL_BRIGHT Or COL_YELLOW)
#EndIf

#IfnDef COL_ERROR
	#Define COL_ERROR (COL_BRIGHT Or COL_RED)
#EndIf

'' EOF
