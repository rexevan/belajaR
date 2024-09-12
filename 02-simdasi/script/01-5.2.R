# new script ----------------------------------

library(tidyverse)

lokasi_file <- "data/5.2 Produksi/" 

tbl_komoditas_52 <- tibble(
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
tbl_52 <- outer_50(lokasi_file, tbl_komoditas = tbl_komoditas_52) |>
  mutate(tabel = "tbl_5.2")

write_rds(tbl_52, "output/rds/tbl_52.rds")
