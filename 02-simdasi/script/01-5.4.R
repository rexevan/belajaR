# new script ----------------------------------

library(tidyverse)

lokasi_file <- "data/5.4 Produksi Tanaman/" 

tbl_komoditas_54 <- tibble(
  name = c (
    "jahe_ginger"
    ,"laos_lengkuas"
    ,"kencur_east"
    ,"kunyit_turmeric"
  ),
  no_komoditas = c(1:4)
)


source("script/01-5.x-fungsi.R")
tbl_54 <- outer_50(lokasi_file, tbl_komoditas_54) |>
  mutate(tabel = "tbl_5.4")

write_rds(tbl_54, "output/rds/tbl_54.rds")

