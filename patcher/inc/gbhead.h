/*
 * inc/gbhead.h
 * 
 * Lucid Patcher - GB ROM Header Info Header
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

#ifndef _GBHEAD_H_
#define _GBHEAD_H_

/*
	
	GameBoy Mask ROM Layout:
	
	$0000-$00FF:	Interrupt handler information.
	$0100-$014F:	ROM header.
	$0150-$FFFF:	Game/application code.
	
	Header Layout:
	$0100-$0103:	Entry point ($00 $C3 ($50 $01)).
	$0104-$0133:	Nintendo logo.
		$0134-$0143:	Registration title.
		Or
		$0134-$013E:	Registration title.
		$013F-$0142:	Manufacturer code.
		$0134:			CGB flag.
	$0144-$0145:	Licensee code (new).
	$0146:			SGB flag.
	$0147:			Cart type.
	$0148:			ROM size (32kB Shl N).
	$0149:			RAM size.
	$014A:			Region.
	$014B:			Licensee code (old).
	$014C:			Software version.
	$014D:			Header checksum.
	$014E-$014F:	Global checksum (big endian).
	
*/

#define CGBF_FUNCTIONS 0x80
#define CGBF_PGB1 0x04
#define CGBF_PGB2 0x08
#define CGBF_CGBONLY 0x40
#define CGBF_MASK 0xCC

#define SGBF_SGBSUPPORT 0x03

#define REGION_JAPAN 0x00
#define REGION_INTERNATIONAL 0x01

#define LICENSEE_NEW 0x33

typedef struct tagGBHEAD
{
	unsigned char uEntryPoint[4];
	unsigned char uNintendoLogo[48];
	char szTitle[11];
	char strManufacturer[4];
	unsigned char uCgbFlag;
	unsigned char uLicensee[2];
	unsigned char uSgbFlag;
	unsigned char uCartType;
	unsigned char uRomSize;
	unsigned char uRamSize;
	unsigned char uRegion;
	unsigned char uOldLicensee;
	unsigned char uRomVer;
	unsigned char uHdrChkSum;
	unsigned short uGlobalChkSum;
} __attribute__((packed, aligned(4))) GBHEAD, *PGBHEAD;

#endif /* _GBHEAD_H_ */

// EOF
