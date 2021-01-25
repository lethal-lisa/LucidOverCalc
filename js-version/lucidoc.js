/*
 * lucidoc.js
 * 
 * Copyright 2020 Lisa Murray
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


class lsdj {
	minTempo: 40;
	maxTempo: 295;
	overclockMult: 2;
	validTempo (tempo) {
		if ((tempo < this.minTempo) || (tempo > this.maxTempo)) return false;
		return true;
	}
}

function getBaseLog (base, number) {
	return Math.log(number) / Math.log(base);
}

function calcFreq (tempo, offTime) {
	
	console.group('calcFreq');
	console.count('calcFreq');
	console.group('Input');
	console.debug('tempo = %i', tempo);
	console.debug('offTime = %f', offTime);
	console.groupEnd();
	
	let mainHz = tempo * 0.4 * lsdj.overclockMult;
	
	console.debug('mainHz = %f', mainhz);
	
	let output = 1.85 * tempo * getBaseLog(1 / tempo, offTime) + mainHz;
	
	console.groupEnd();
	
	return output;
	
}

var log = document.querySelector("#log");

// EOF
