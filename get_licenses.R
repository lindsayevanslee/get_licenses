library(tidyverse)
library(openxlsx)

#store package dependencies (currently only included in Imports and Suggests)
pkgs <- packageDescription("YOURPACKAGE")[c("Imports", "Suggests")] %>% 
  map(~ flatten_chr(str_split(., ",\n"))) %>% 
  flatten_chr()

#make list of licenses
license_types <- map_chr(pkgs, 
                         ~ packageDescription(., fields = "License")) %>% 
  set_names(pkgs) %>% 
  unique()

license_files <- map(pkgs, ~ readLines(system.file("LICENSE", package = . ))) %>% 
  set_names(pkgs)

#print license_files
write.xlsx(license_files, file = "license_files.xlsx")



