/*
 * obj/prompts.c
 * 
 * Lucid Patcher - Prompts Module
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

#include "../inc/prompts.h"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

CMDID scanForPromptCmd (const char* pszText) {
	
	if (pszText == NULL) {
		errno = EFAULT;
		perror("Passed null pointer in scanForPromptCmd.");
		return 0;
	}
	
	char* pszTempBuff; // Temporary buffer for command text.
	size_t cchTempBuff = strlen(pszText); // Size of temporary buffer in chars.
	
	// Try to allocate temporary buffer.
	if ((pszTempBuff = calloc(cchTempBuff, sizeof(char))) == NULL) {
		perror("Failed to allocate temporary buffer for scanning for prompt commands.");
		return 0;
	}
	
	// Copy to internal buffer.
	if (strcpy(pszTempBuff, pszText) == NULL) {
		perror("Failed to copy to temporary buffer for scanning for prompt commands.");
		return 0;
	}
	
	//
	
}

int doPromptUser (const long cchCmd, char* pszCmd) {
	
	if ((cchCmd < MIN_CCH_CMD) || (pszCmd == NULL)) {
		errno = EFAULT;
		perror("Bad command string buffer.");
		return 1;
	}
	
	size_t cchCmdLen = strlen(pszCmd);
	
	// Initialize string buffer.
	if (memset(pszCmd, 0, cchCmd) == NULL) {
		perror("Couldn't clear command buffer.");
		return 1;
	}
	
	// Retrieve command.
	while (cchCmdLen < MIN_CCH_CMD) {
		printf(">>> ");
		gets(pszCmd);
		cchCmdLen = strlen(pszCmd);
	}
	
	return 0;
	
}

/* char* promptForLsdjFile (size_t cchFile, char* pszFile) {
	
	if (cchFile <= 0) return EXIT_FAILURE;
	
	printf("Enter LSDj ROM file name, or ""cancel"" to cancel: ");
	if (
	gets(pstrFile);
	
} */

/* FILE* getLsdjFile () {
	
	char* pszRomFile[FILENAME_MAX]; // Buffer for filename.
	FILE* pfRomFile; // File pointer to return.
	
	// Prompt for LSDj ROM file.
	
	
	// Attempt to open ROM file, and print error if necessary.
	if ((pfRomFile = fopen(strRomFile, "rwb")) == NULL) {
		
		// Print error message.
		perror("LSDj ROM file not found, or could not be opened.");
		// printf("errno = %d.\n", errno);
		
		errno = 0; // Clear error.
		
		// Clear filename buffer.
		memset(strRomFile, 0, (FILENAME_MAX * sizeof(char)));
		
		
		
	}
	
	// Return ROM file pointer.
	return pfRomFile;
	
} */

// EOF
