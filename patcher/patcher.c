/*
 * patcher.c
 * 
 * Lucid Patcher - Main Module
 * 
 * Copyright 2021 Lisa Murray
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 */

#include "patcher.h"

#include <stdio.h>
#include <stdlib.h>

const char g_szAppName[32] = "Lucid Patcher";
const char g_szAppVer[16] = "1.0";

int main (int argc, char* argv[]) {
	
	// Process command-line arguments.
	if (argc > 1) {
		unsigned int iArg;
		for (iArg = 1; iArg < argc; iArg++) {
			fprintf(stderr, "arg[%d] = \"%s\"\n", iArg, argv[iArg]);
			if (argv[iArg] == "-h") {
				printf"
			}
			
		}
	}
	
	// Enter prompt mode.
	printf("This is %s v%s\nType \"help\" for more options.\n", g_szAppName, g_szAppVer);
	
	// Exit program.
	return EXIT_SUCCESS;
	
}


// EOF
