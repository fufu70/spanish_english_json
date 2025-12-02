# Spanish to English JSON

Built to provide personal repo's with a list of spanish to english words and phrases that can be used to generate questions to learn either english or spanish, training models (as is the case of the data from our creditors), and quick translation lookups.

## Structure

The structure of the json information reflects the structure of the data of our creditors, we have `sentences`, `verbs`, and `words`. 

```json
{
	"sentences": [...],
	"verbs": {
		"en_es": {...},
		"es_en": {...}
	},
	"words": {
		"en_es": {...},
		"es_en": {...}
	}
}
```

`sentences` is an array that contains a list of objects with keys `en` for the english version of the sentence and `es` for the spanish version of the sentence.

```json
[
	{"es": "Hola ...", "en": "Hello ..."},
	...
]
```

`verbs` and `words` are ordered around the direction in which they are translated from and to. `es_en` represents spanish words translated to english and `en_es` represents english words translated to spanish. At the root, the `verbs` and `words` have a `list` of words, a `map` of words, and a `letterMap`. 

```json
{
	"list": [...],
	"map": {...},
	"letterMap": {"a": {...}, "b": ...}
}
```


The `list` is just a flat array of all the words, where each object contains the `word` in focus, its list of possible translations, and the type of word it contains:

```json
{
	"word": "abash",
	"translation": [
		"confundir",
		"avergonzar",
		"abochornar"
	],
	"type": "{v} /əˈbæʃ/ (to make ashamed, to embarrass)"
}
```

The `map` contains the same information, but each word in focus can be picked by accessing it directly:

```javascript
console.log(map["abash"]) // Outputs {
// 	"word": "abash",
// 	"translation": [
// 		"confundir",
// 		"avergonzar",
// 		"abochornar"
// 	],
// 	"type": "{v} /əˈbæʃ/ (to make ashamed, to embarrass)"
// }
```

The `letterMap` contains a flat array of all the words that start with the selected letter:

```javascript
console.log(letterMap['E']) // Outputs "E": [
//     {
//       "word": "Earth",
//       "translation": [
//         "la Tierra",
//         "tierra {f}"
//       ],
//       "type": "{prop} /ɜː(ɹ)θ/ (third planet from the Sun)"
//     },
//	   ...
// ]
```

## Creditors

Leveraged the [doozan/spanish_data](https://github.com/doozan/spanish_data) dataset and converted the `sentences.tsv` over to `sentences.json` file which should be easier to digest using javascript.

Utilized the XML data from [mananoreboton/en-es-en-Dic](https://github.com/mananoreboton/en-es-en-Dic). mananoreboton provided spanish to english and english to spanish words and verbs. 

## To Generate the Data

Simply run the `mak.sh` file. This will pull in the [doozan/spanish_data](https://github.com/doozan/spanish_data) repo, and convert the `tsv` to a json. 

```bash
$ ./mak.sh
```