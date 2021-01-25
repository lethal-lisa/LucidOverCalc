/*
 * inc/prompts.h
 * 
 * Lucid Patcher - Prompts Module Header
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
 * 
 */

#ifndef _PROMPTS_H_
#define _PROMPTS_H_

#define MIN_CCH_CMD 3
#define MAX_CCH_CMD 256

#define CMD_NONE 0
#define CMD_EXIT 1
#define CMD_HELP 2
#define CMD_VER 3

typedef unsigned short int CMDID;

CMDID scanForPromptCmd (const char* pszText);
int doPromptUser (const long cchCmd, char* pszCmd);

#endif /* _PROMPTS_H_ */

// EOF
