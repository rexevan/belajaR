source("script/01-5.1.R")
source("script/01-5.2.R")
source("script/01-5.3.R")
source("script/01-5.4.R")
source("script/01-5.5.R")
source("script/01-5.6.R")
source("script/01-5.7.R")






library(tidyverse)

tbl51 <- "Tabel_5.1.csv" %>% read_csv2() %>% mutate(tabel = "5.1")
tbl52 <- "Tabel_5.2.csv" %>% read_csv2() %>% mutate(tabel = "5.2")
tbl53 <- "Tabel_5.3.csv" %>% read_csv2() %>% mutate(tabel = "5.3")
tbl54 <- "Tabel_5.4.csv" %>% read_csv2() %>% mutate(tabel = "5.4")
tbl55 <- "Tabel_5.5.csv" %>% read_csv2() %>% mutate(tabel = "5.5")
tbl56 <- "Tabel_5.6.csv" %>% read_csv2() %>% mutate(tabel = "5.6")
tbl57 <- "Tabel_5.7.csv" %>% read_csv2() %>% mutate(tabel = "5.7")


tbl5_full <- bind_rows(
  tbl51
  , tbl52
  , tbl53
  , tbl54
  , tbl55
  , tbl56
  , tbl57
) %>%
  arrange(kecamatan_subdistrict, tabel, nomor_komoditas)

write_csv2(tbl5_full, "Tabel_BAB_5_Siap.csv")

# new script -------------------------
library(tidyverse)

read_rds("output/rds/tbl_51.rds")
read_rds("output/rds/tbl_52.rds")
read_rds("output/rds/tbl_53.rds")
read_rds("output/rds/tbl_55.rds")
read_rds("output/rds/tbl_57.rds")

list.dirs("output/rds")   
list.files("output/rds/") 
