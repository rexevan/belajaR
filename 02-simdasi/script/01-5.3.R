# new script ----------------------------------

library(tidyverse)

lokasi_file <- "data/5.3 Luas Panen/" 

tbl_komoditas_53 <- tibble(
  name = c (
    "jahe_ginger"
    ,"laos_lengkuas"
    ,"kencur_east"
    ,"kunyit_turmeric"
  ),
  no_komoditas = c(1:4)
)


source("script/01-5.x-fungsi.R")
tbl_53 <- outer_50(lokasi_file, tbl_komoditas_53) |>
  mutate(tabel = "tbl_5.3")

write_rds(tbl_53, "output/rds/tbl_53.rds")






