# Spanish to English JSON

Built to provide personal repo's with a list of spanish to english words and phrases that can be used to generate questions to learn either english or spanish.

## Creditors

Leveraged the [doozan/spanish_data](https://github.com/doozan/spanish_data) dataset and converted the `sentences.tsv` over to `sentences.json` file which should be easier to digest using javascript.

## To Generate the Data

Simply run the `mak.sh` file. This will pull in the [doozan/spanish_data](https://github.com/doozan/spanish_data) repo, and convert the `tsv` to a json. 

```bash
$ ./mak.sh
```