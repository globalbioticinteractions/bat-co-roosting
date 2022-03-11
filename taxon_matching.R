# Taxonomic Integrations

# load libraries 
library(tidyverse)
library(rgbif)

# Create Reference - Taxon Name List for Expert Review 
int_db <- read.csv(file = "data/exp_lit/interaction-extract.csv", strip.white = TRUE, na.strings=c("", "NA")) # downloaded 02 March 2022
int_db <- select(int_db,occurenceId, referenceFileName, sourceTaxonName, targetTaxonName, PlantTaxonName, targetCategory)

source <- select(int_db, referenceFileName, sourceTaxonName)
names(source)[2] <- "TaxonName"
source$Category <- "bat"
target <- select(int_db, referenceFileName, targetTaxonName, targetCategory)
names(target)[2] <- "TaxonName"
names(target)[3] <- "Category"
plants <- select(int_db, referenceFileName, PlantTaxonName)
names(plants)[2] <- "TaxonName"
plants$Category <- "roost"

taxon_db <- rbind(source, target, plants) # merge all dataframes 
taxon_db <- unique(taxon_db) # remove duplicates
taxon_db <- taxon_db[rowSums(is.na(taxon_db)) == 0,] # remove NAs 
taxon_db <- taxon_db %>% dplyr::filter(TaxonName != "none")  # remove nontaxa fillers 
taxon_db$int_occurs <- "yes"
taxon_db <- taxon_db %>% pivot_wider(names_from = Category, values_from = int_occurs)
write.csv(taxon_db, file = "data/exp_lit/int_raw_taxons.csv")

# get taxons as identified by globi 
# load globi-interpreted data from terminal 
# cat data/interactions.tsv.gz | gunzip  | pv -l | mlr --tsvlite filter '$sourceNamespace == "globalbioticinteractions/bat-co-roosting-database"'  > data/bat-co-roosting.tsv

require(data.table)
globi_int <- as.data.frame(fread('data/bat-co-roosting.tsv'))

#load globi-interpreted data from https://api.globalbioticinteractions.org/interaction.csv?type=csv&limit=4096&interactionType=ecologicallyRelatedTo&accordingTo=globi%3Aglobalbioticinteractions%2Fbat-co-roosting-database&includeObservations=true&field=source_taxon_id&field=source_taxon_name&field=source_taxon_path&field=source_taxon_path_ids&field=source_specimen_occurrence_id&field=source_specimen_institution_code&field=source_specimen_collection_code&field=source_specimen_catalog_number&field=source_specimen_life_stage_id&field=source_specimen_life_stage&field=source_specimen_physiological_state_id&field=source_specimen_physiological_state&field=source_specimen_body_part_id&field=source_specimen_body_part&field=source_specimen_sex_id&field=source_specimen_sex&field=source_specimen_basis_of_record&field=interaction_type&field=target_taxon_id&field=target_taxon_name&field=target_taxon_path&field=target_taxon_path_ids&field=target_specimen_occurrence_id&field=target_specimen_institution_code&field=target_specimen_collection_code&field=target_specimen_catalog_number&field=target_specimen_life_stage_id&field=target_specimen_life_stage&field=target_specimen_physiological_state_id&field=target_specimen_physiological_state&field=target_specimen_body_part_id&field=target_specimen_body_part&field=target_specimen_sex_id&field=target_specimen_sex&field=target_specimen_basis_of_record&field=latitude&field=longitude&field=collection_time_in_unix_epoch&field=study_citation&field=study_url&field=study_source_citation&field=study_source_archive_uri
#globi_int <- read.csv(file = "data/interaction_globi.csv")
#source_gb <- select(globi_int, source_taxon_name, source_taxon_path, source_taxon_path_ids)
#names(source_gb)[1] <- "globi_taxon_name"
#names(source_gb)[2] <- "globi_taxon_path"
#names(source_gb)[3] <- "globi_taxon_path_ids"
#target_gb <- source_gp <- select(globi_int, target_taxon_name, target_taxon_path, target_taxon_path_ids)
#names(target_gb)[1] <- "globi_taxon_name"
#names(target_gb)[2] <- "globi_taxon_path"
#names(target_gb)[3] <- "globi_taxon_path_ids"
#gb_taxon_db <- rbind(source_gb, target_gb) # merge all dataframes 
#gb_taxon_db <- unique(gb_taxon_db) # remove duplicates 
# this only has interpreted data, need to bring in raw format 

# get gbif name lookup 

verbatim_taxon_names <- unique(taxon_db$TaxonName)
# make empty dataframe to append output to
gbif_match <- data.frame((matrix(ncol = 23, nrow = 0)))
gbif_fields <- c("usageKey","acceptedUsageKey","scientificName","canonicalName","rank","status","confidence","matchType","kingdom","phylum","order","family","genus","species","kingdomKey","phylumKey","classKey","orderKey","familyKey", "genusKey","speciesKey","synonym","class")
colnames(gbif_match ) <- gbif_fields 
# loop all names through for the gbif matching 
for(i in verbatim_taxon_names){
  gbif_name <- name_backbone(i,curlopts = list(verbose = TRUE))
  gbif_match <- plyr::rbind.fill(gbif_name, gbif_match)                
}
# flag these columns as gbif-interpretted 
colnames(gbif_match) <- paste(colnames(gbif_match), "gbif", sep = "_")

# merge in with taxon sheet 
taxon_interpret_db <- full_join(taxon_db, gbif_match, by = c("TaxonName" = "canonicalName_gbif"))
write.csv(taxon_interpret_db, file = "data/exp_lit/taxon_interpretation.csv")
