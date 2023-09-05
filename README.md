[![GloBI Review by Elton](../../actions/workflows/review.yml/badge.svg)](../../actions/workflows/review.yml) [![GloBI](https://api.globalbioticinteractions.org/interaction.svg?accordingTo=globi:globalbioticinteractions/bat-co-roosting-database&refutes=true&refutes=false)](https://globalbioticinteractions.org/?accordingTo=globi:globalbioticinteractions/bat-co-roosting-database)

Configuration to help Global Biotic Interactions (GloBI, https://globalbioticinteractions.org) index: 

:warning: work in progress.

Sherman, Aja C.;  Geiselman, Cullen;  Simons, Nancy B.;  Upham, Nathan S.;  Poelen, Jorrit H.;  Reeder, DeeAnn M.;  Bertolino, Sandro;  Groom, Quentin;  Phelps, Kendra;  Agosti, Donat;  Willoughby, Anna R. In Preparation. Bat-Co-Roosting Database develop by the Biodiversity-related knowledge hub on COVID-19. 

You can view the GLOBI-indexed interactions [here](https://www.globalbioticinteractions.org/browse/?accordingTo=globi%3Aglobalbioticinteractions%2Fbat-co-roosting-database&interactionType=ecologicallyRelatedTo&resultType=json).

## Questions? Ideas?
Do you have any questions, comments or ideas? Please [open an issue](../../issues), join [our slack channel](https://covid19taf.slack.com/archives/C011W4GPXDX), or attend [our weekly meetings](https://globalbioticinteractions.org/covid19). 

## Outreach 
- Watch ["What do we not know? Quantifying data gaps and biases in knowledge of bat co-roosting"](https://zenodo.org/record/6959687) presented by Aja C. Sherman at the 19th International Bat Research Confernce in Austin, Texas on August 11, 2022. 

## Updating 
Currently, the interactions.tsv in this repository is updated manually. 

To update interactions.tsv with the most recent version in https://docs.google.com/spreadsheets/d/1y5uBKvyzDQgQUtyRHvn5f20IOA7LoMho/edit#gid=691336520 take the following steps:

1. download https://docs.google.com/spreadsheets/d/1y5uBKvyzDQgQUtyRHvn5f20IOA7LoMho/edit#gid=691336520 as a excel spreadsheet
2. open downloaded spreadsheet in LibreOffice Calc 
3. select the interaction-extract tab
4. go to Menu > Edit > Find & Replace
5. check "Regular Expressions"
6. enter ```[\r\n]``` (with square brackets) in the "Find" field
7. enter ``` ``` (empty space) in the "Replace" field
8. check "All sheets"
9. select "Values" in "Search in:" options
10. now, click "Replace all" to replace all newlines and line breaks with a whitespace
11. go to "Menu > File > Save as ..."
12. select "Text CSV" and check "Edit filter settings"
13. click save
14. in Export Text File box, use "Character set" to ```UTF-8```, set "Field delimiter" to ```{Tab}```, and leave the "String delimiter" empty. 

15. click "ok" to save the current sheet as a tsv file
16. add the exported file to the github repository (e.g., interactions.tsv)

We are working on automating this procedure, and please share ideas on how to do this by [opening an issue](../../issues). 
