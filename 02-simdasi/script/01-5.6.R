# new script ----------------------------------

library(tidyverse)

lokasi_file <- "data/5.6 Produksi Tanaman/" 

tbl_komoditas_56 <- tibble(
  name = c (
    "anggrek_pot"
    ,"anggrek_potong"
    ,"krisan_chrysantemum"
    ,"mawar_rose"
    ,"sedap_malam"
    ,"anthurium_bunga"
    ,"bugenvil_pohon"
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
tbl_56 <- outer_50(lokasi_file, tbl_komoditas_56) |>
  mutate(tabel = "tbl_5.6")

write_rds(tbl_56, "output/rds/tbl_56.rds")







