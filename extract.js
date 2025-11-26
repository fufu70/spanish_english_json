const fs = require('fs')

// letters to fix due to perl generating weird characters
// ñ -> Ã±
// é -> Ã©
// í -> Ã­
// ó -> Ã³
// ú -> Ãº
let cleanWord = (word) => {
	word = word
		.replaceAll('Ã±', 'ñ')
		.replaceAll('Ã©', 'é')
		.replaceAll('Ã­', 'í')
		.replaceAll('Ã³', 'ó')
		.replaceAll('Ãº', 'ú');
	return word;
}

let definition = (val) => {
	try {

		return {
			word: cleanWord(val.c),
			translation: typeof val.d === 'string' ? val.d.split(',').map(d => {
				return cleanWord(d.replaceAll(', ', '').replaceAll(',', '').trim())
			}) : [],
			type: val.t
		}	
	} catch {
		console.log(val);
	}
}

let flatten = (obj) => {
	const flat = [];
	if (obj['l'] === undefined) {
		obj = obj.dic;
	}

	Object.keys(obj['l']).forEach(index => {
		Object.keys(obj['l'][index]).forEach(key => {
			const value = obj['l'][index][key]
			if (Array.isArray(value)) {
				value.forEach(val => {
					flat.push(definition(val));
				})
			} else {
				flat.push(definition(value));
			}
		});
	});
	return flat;
}

let extract = (obj) => {
	const flat = flatten(obj);
	const flatMap = flat.reduce((acc, curr) => {
		if (!acc[curr.word]) {
			acc[curr.word] = curr;	
		} else {
			try {
				acc[curr.word].translation = Array.from(new Set(acc[curr.word].translation.concat(curr.translation)));
			} catch {
				acc[curr.word] = curr;
			}
		}
		return acc;
	}, {});
	const list = Object.values(flatMap);
	const letterMap = list.reduce((acc, curr) => {
		const letter = curr.word[0];
		if (acc[letter] == undefined) {
			acc[letter] = [];
		}
		acc[letter].push(curr);
		return acc;
	}, {});
	return {
		list: list,
		map: flatMap,
		letterMap: letterMap
	}
}

let writeToFile = (extraction, file) => {
	fs.writeFile(file, extraction, (err) => {
		if (err) {
			console.error('Error writing file:', err);
		}
	});
}

ext = extract(require(process.argv[2]))
writeToFile(JSON.stringify(ext, null, 2), process.argv[3]);