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
#include <getopt.h>

const char g_szAppName[] = "Lucid Patcher";
const char g_szAppVer[] = "1.0";

int main (int argc, char* argv[]) {
	
	printf("%s v%s\n\n", g_szAppName, g_szAppVer);
	
	// Process command-line arguments.
	if (argc > 1) {
		
		int nOpt;
		while (1) {
			
			// Long option index.
			int nOptionIndex = 0;
			
			// Structure containing long options.
			static struct option optLongOpts[4] = {
				{ "help", no_argument, 0, 'h' },
				{ "gpl", no_argument, 0, 0 },
				{ "file", required_argument, 0, 'f' },
				{ 0, 0, 0, 0}
			};
			
			// Get options.
			if ((nOpt = getopt_long(argc, argv, "hf:", optLongOpts, &nOptionIndex)) == -1) break;
			
			// Process options.
			switch (nOpt) {
			case 0:
				// Process long options.
				if (nOptionIndex > 0) {
					switch (nOptionIndex) {
					case 1:
						printGplNotice();
						exit(EXIT_SUCCESS);
						break;
					default:
						fprintf(stderr, "option: %s (%o)\n", optLongOpts[nOptionIndex].name, nOptionIndex);
					}
				}
				break;
				
			case 'h':
				// Show help message.
				printHelp();
				exit(EXIT_SUCCESS);
				//break;
				
			case 'f':
				// Select file.
				printf("Using file: %s\n", optarg);
				break;
				
			case '?':
				// Unknown command.
				break;
				
			default:
				// Unknown getopt_long return value.
				fprintf(stderr, "%s warning: getopt_long returned 0x%x\n", argv[0], nOpt);
				exit(EXIT_FAILURE);
			}
		}
	}
	
	// Enter prompt mode.
	printf("This is %s v%s\nType \"help\" for more options.\n", g_szAppName, g_szAppVer);
	
	// Exit program.
	return EXIT_SUCCESS;
	
}

// Regurgitate the GPL3 notice.
void printGplNotice () {
	
	printf("This program is free software; you can redistribute it and/or modify\n\
it under the terms of the GNU General Public License as published by\n\
the Free Software Foundation; either version 2 of the License, or\n\
(at your option) any later version.\n\
\n");
	printf("This program is distributed in the hope that it will be useful,\n\
but WITHOUT ANY WARRANTY; without even the implied warranty of\n\
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n\
GNU General Public License for more details.\n\
\n");
	printf("You should have received a copy of the GNU General Public License\n\
along with this program; if not, write to the Free Software\n\
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,\n\
MA 02110-1301, USA.\n\n");
	
}

// Show help message.
void printHelp () {
	
	printf("Help\n");
	printf("\t-h/--help\t\tShow this help.\n");
	printf("\t--gpl\t\t\tShow the GNU GPL3 notice.\n");
	printf("\t-f/--file <file>\tSet file to use to <file>.\n");
	printf("\n");
	
}

// EOF
