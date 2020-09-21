/'
	
	conscolors.bi
	
	FreeBASIC Console Mode Colors
	
		Defines the default palette used by screen modes 7, 8, 9, and 12,
	and console mode.
	
		To access intense colors Or any of the eight basic colors with
	COL_BRIGHT or COL_INTENSE.
	
'/

#Pragma Once

#Define COL_BLACK	&h00
#Define COL_BLUE		&h01
#Define COL_GREEN	&h02
#Define COL_CYAN		&h03
#Define COL_RED		&h04
#Define COL_PINK		&h05
#Define COL_YELLOW	&h06
#Define COL_GREY		&h07

#Define COL_INTENSE	&h08

'' Aliases:
#Define COL_BRIGHT	COL_INTENSE
#Define COL_GRAY		COL_GREY

'' Three-letter aliases:
#Define COL_BLK		COL_BLACK
#Define COL_BLU		COL_BLUE
#Define COL_GRN		COL_GREEN
#Define COL_CYN		COL_CYAN
''#Define COL_RED		COL_RED
#Define COL_PNK		COL_PINK
#Define COL_YLW		COL_YELLOW
#Define COL_GRY		COL_GREY

#Define COL_INT		COL_INTENSE
#Define COL_BRI		COL_BRIGHT

''EOF
