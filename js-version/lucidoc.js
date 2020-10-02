
// lucidoc.js

class lsdj {
	minTempo: 40;
	maxTempo: 295;
	overclockMult: 2;
	validTempo (tempo) {
		if ((tempo < this.minTempo) || (tempo > this.maxTempo)) throw new RangeError(`${tempo} is an invalid tempo.`);
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

// EOF
