# new script ------------------------
library(tidyverse)

lokasi_file <- "data/5.1 Luas Panen/" 

tbl_komoditas_51 <- tibble(
  name = c (
    "bawang_merah"
    ,"cabai_besar"
    ,"cabai_keriting"
    ,"cabai_rawit"
    ,"kentang_potato"
    ,"kubis_cabbage"
    ,"tomat_tomato"
    ,"bawang_putih"
  ),
  no_komoditas = c(1:8)
)


source("script/01-5.x-fungsi.R")
tbl_51 <- outer_50(lokasi_file, tbl_komoditas = tbl_komoditas_51) |>
  mutate(tabel = "tbl_5.1")

write_rds(tbl_51, "output/rds/tbl_51.rds")
