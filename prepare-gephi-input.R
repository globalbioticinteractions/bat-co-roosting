# prepare interactions for gephi input 

# read in interactions sheet 

interactions <- read.csv("interactions.csv", strip.white =TRUE)


# filter for raw interactions 

raw_gephi <- dplyr::select(interactions, 
                           occurenceId,
                           sourceTaxonName,
                           targetTaxonName,
                           interactionTypeName,
                           localityContinent, 
                           localityCountry,
                           roostCat1)
# filter to interactions
raw_gephi <- dplyr::filter(raw_gephi, is.na(sourceTaxonName) == FALSE)
raw_gephi <- dplyr::filter(raw_gephi, is.na(targetTaxonName) == FALSE)
raw_gephi <- dplyr::filter(raw_gephi, is.na(targetTaxonName) != "")

write.csv(raw_gephi, file = "gephi_raw.csv")

# merge in taxonomy from GBIF 
gbif_taxonomy <- read.csv(file = "taxonomy.csv")

# merge for source 
gbif_gephi <- dplyr::left_join(interactions, gbif_taxonomy, by = c("referenceFileName", "sourceTaxonName" = "TaxonName"))

# rename source taxonomy from gbif 
gbif_gephi$sourceTaxonName <- gbif_gephi$scientificName_gbif

gbif_gephi <- dplyr::select(gbif_gephi, 
                           occurenceId,
                           referenceFileName,
                           sourceTaxonName,
                           targetTaxonName,
                           interactionTypeName,
                           localityContinent, 
                           localityCountry,
                           roostCat1)


# merge for target 
gbif_gephi2 <- dplyr::left_join(gbif_gephi, gbif_taxonomy, by = c("referenceFileName", "targetTaxonName" = "TaxonName"))

# rename target taxonomy from gbif 
gbif_gephi2$targetTaxonName <- gbif_gephi2$scientificName_gbif
gbif_gephi2$referenceFileName <- NULL

# filter to only taxonomically identified 
gbif_gephi2 <- dplyr::filter(gbif_gephi2, is.na(sourceTaxonName) == FALSE)
gbif_gephi2 <- dplyr::filter(gbif_gephi2, is.na(targetTaxonName) == FALSE)


write.csv(gbif_gephi2, file = "gephi_gbif.csv")



