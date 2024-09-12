# new script ------------------------
library(tidyverse)

lokasi_folder <- "data/4.x Pendidikan/json/"

source("script/01-4.x-fungsi.R")


tbl_lokasi <- tibble(
  lokasi_file = paste0(lokasi_folder, list.files(lokasi_folder))
  ) |>
  transmute(
    tabel_4.x = map(lokasi_file, json_to_tabular_simdasi_4.x)
  ) |>
  unnest(tabel_4.x)

tbl_4.x <- tbl_lokasi |>
  mutate(
    tabel = nama_variabel |> word(2, 2),
    tingkat = nama_variabel |> word(3, 3),
    kolom = nama_variabel |> word(4, 4) |> str_sub(2, -2) |> str_to_lower() |> str_replace("\\+", "\\_"),
    value = value |> str_replace_na("-")
  ) |>
  select(-nama_variabel) |>
  pivot_wider(names_from = kolom, values_from = value)


write_csv(tbl_4.x, "output/csv/tabel_bab_4_simdasi.csv")
write_rds(tbl_4.x, "output/rds/tabel_bab_4_simdasi.rds")
