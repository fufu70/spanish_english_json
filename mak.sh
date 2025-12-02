#!/bin/bash

RUNNING_DIR=$(pwd)

if [ ! -d workdir ]; then 
	mkdir workdir;
fi
cd workdir;
if [ ! -d spanish_data ]; then 
	git clone https://github.com/doozan/spanish_data;
else
	cd spanish_data;
	git pull;
	cd ..;
fi

if [ ! -d en-es-en-Dic ]; then 
	git clone https://github.com/mananoreboton/en-es-en-Dic;
else
	cd en-es-en-Dic;
	git pull;
	cd ..;
fi

#############################
#############################
##########SENTENCES##########
#############################
#############################
# We want to format the tsv file from the spanish_data set to be the following structure
# {"en": "...", "es": "..."},
cd $RUNNING_DIR

cat workdir/spanish_data/sentences.tsv > sentences-0.tsv
# Escape all quote characters "
sed 's/\"/\\"/g' sentences-0.tsv > sentences-1.tsv
# Append the en json element to the beginning of the file,
# so add '{"en": '
sed 's/^/  {"en": "/g' sentences-1.tsv > sentences-2.tsv
# The first tab we see is the seperator for the english and 
# spanish translations, add '", "es": "'
sed 's/\t/\", "es": \"/' sentences-2.tsv > sentences-3.tsv
# Finish the object, close the line with '"},' and remove
# the rest of the line
sed 's/\t.*/\"},/' sentences-3.tsv > sentences-4.tsv
echo "" >> sentences-4.tsv
sed 'N; $!P; $!D; $s/},/}/g' sentences-4.tsv > sentences-5.tsv
# sed '$s/,.$//' sentences-4.tsv > sentences-5.tsv
# Add the [ and ] characters to the beginning and end
# respectively
echo "[" | cat - sentences-5.tsv > sentences.json
echo "
]" >> sentences.json

# Cleanup
rm *.tsv


#############################
#############################
############VERBS############
#############################
#############################
perl xml-to-json.pl "workdir/en-es-en-Dic/src/main/resources/dic/verbs/en-es.xml" > temp-verb-en-es.json
perl xml-to-json.pl "workdir/en-es-en-Dic/src/main/resources/dic/verbs/es-en.xml" > temp-verb-es-en.json

node extract.js './temp-verb-en-es.json' 'en-es-verbs.json'
node extract.js './temp-verb-es-en.json' 'es-en-verbs.json'

rm temp-verb-en-es.json;
rm temp-verb-es-en.json;

#############################
#############################
############WORDS############
#############################
#############################
perl xml-to-json.pl "workdir/en-es-en-Dic/src/main/resources/dic/en-es.xml" > temp-word-en-es.json
perl xml-to-json.pl "workdir/en-es-en-Dic/src/main/resources/dic/es-en.xml" > temp-word-es-en.json

node extract.js './temp-word-en-es.json' 'en-es-words.json'
node extract.js './temp-word-es-en.json' 'es-en-words.json'

rm temp-word-en-es.json;
rm temp-word-es-en.json;

#############################
#############################
#######NPM PUBLISHING########
#############################
#############################

npm version patch
npm publish