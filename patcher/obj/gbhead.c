/*
 * obj/gbhead.c
 * 
 * Lucid Patcher - GB ROM Header Info Module
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

#include "../inc/gbhead.h"

#include <stddef.h>
#include <errno.h>

unsigned char mkGbHdrChksum (const PGBHEAD pHdr) {
	
	if (pHdr == NULL) {
		errno = EFAULT;
		//perror("Null pointer passed in mkGbHdrChksum.");
		return 0;
	}
	
	unsigned char* pTemp = (unsigned char*) pHdr;
	unsigned long int uChkSum = 0;
	
	int iByte;
	for (iByte = 0x34; iByte < 0x4C; iByte++)
		uChkSum = uChkSum - ((unsigned char*) pHdr)[iByte] - 1;
	
	return (unsigned char)(uChkSum & 0xFF);
	
}

inline long getRomSize (const PGBHEAD pHdr) {
	
	if (pHdr == NULL) {
		errno = EFAULT;
		//perror("Null pointer passed in getRomSize.");
		return 0;
	}
	
	return (long)((32 << pHdr->uRomSize) * 1024);
	
}

// EOF
