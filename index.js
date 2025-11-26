const sentences = require('./sentences.json')
const verb_en_es = require('./en-es-verbs.json')
const verb_es_en = require('./es-en-verbs.json')
const word_en_es = require('./en-es-words.json')
const word_es_en = require('./es-en-words.json')

// english to spanish dictionary

module.exports = {
	sentences: sentences,
	// verbs
	verbs: {
		en_es: verb_en_es,
		es_en: verb_es_en
	},
	words: {
		en_es: word_en_es,
		es_en: word_es_en
	}
};
