# new script ----------------------------------

library(tidyverse)

lokasi_file <- "data/5.5 Luas Panen/" 

tbl_komoditas_55 <- tibble(
  name = c (
    "anggrek_pot"
    ,"anggrek_potong"
    ,"krisan_chrysantemum"
    ,"mawar_rose"
    ,"sedap_malam"
    ,"anthurium_bunga"
    ,"bugenvil_m2"
    ,"palem_palm"
    ,"pedang_pedangan"
    ,"pisang_pisangan"
    ,"puring_croton"
    ,"soka_ixora"
    ,"sri_rejeki"
  ),
  no_komoditas = c(1:13)
)


source("script/01-5.x-fungsi.R")
tbl_55 <- outer_50(lokasi_file, tbl_komoditas_55) |>
  mutate(tabel = "tbl_5.5")

write_rds(tbl_55, "output/rds/tbl_55.rds")

