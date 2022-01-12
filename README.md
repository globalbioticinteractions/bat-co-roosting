[![Review](https://github.com/globalbioticinteractions/bat-co-roosting-database/actions/workflows/review.yml/badge.svg)](https://github.com/globalbioticinteractions/bat-co-roosting-database/actions) [![Build Status](https://app.travis-ci.com/globalbioticinteractions/bat-co-roosting-database.svg)](https://app.travis-ci.com/globalbioticinteractions/bat-co-roosting-database) [![GloBI](https://api.globalbioticinteractions.org/interaction.svg?accordingTo=globi:globalbioticinteractions/bat-co-roosting-database)](https://globalbioticinteractions.org/?accordingTo=globi:globalbioticinteractions/bat-co-roosting-database)

Configuration to help Global Biotic Interactions (GloBI, https://globalbioticinteractions.org) index: 

:warning: This is a work in progress.

Aja Sherman, Cullen Geiselman. 2021. Bat Co-Roosting Database

## Updating 
Currently, the interactions.tsv in this repository is updated manually. 

To update interactions.tsv with the most recent version in https://docs.google.com/spreadsheets/d/1vQq_DBNs86Wrtwc71JlCM4dyNPnILhdANPzQuRKOcUE/edit#gid=1008904579 take the following steps:

1. download https://docs.google.com/spreadsheets/d/1vQq_DBNs86Wrtwc71JlCM4dyNPnILhdANPzQuRKOcUE/edit#gid=1008904579 as a excel spreadsheet
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

We are working on automating this procedure, and please share ideas on how to do this by [opening an issue](../issues). 
