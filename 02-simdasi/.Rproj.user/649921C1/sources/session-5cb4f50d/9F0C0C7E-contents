library(tidyverse)
library(readxl)
library(janitor)

tbl54 <- function(tahun) {
  tahun <- tahun
  
  file_excel <- paste0("5.4 Produksi Tanaman/tabel-5-1-6-tahun-", tahun,"-kabupaten-sikka-09-07-2024.xlsx")
  
  tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25) %>%
    clean_names() %>%
    slice(-c(1:3))
  
  tbl_1_names <- names(tbl_1)[-1]
  
  tbl_2 <- tbl_1 %>%
    pivot_longer(cols = tbl_1_names) %>%
    mutate(tahun = tahun)
  
  
  return(tbl_2)
}

t20 <- tbl54("2020")
t21 <- tbl54("2021")
t22 <- tbl54("2022")
t23 <- tbl54("2023")

t54_full <- bind_rows(t20, t21, t22, t23)


tbl_komoditas <- tibble(
  name = c (
    "jahe_ginger_kg_kg"
    ,"laos_lengkuas_galanga_kg_kg"
    ,"kencur_east_indian_galangal_kg_kg"
    ,"kunyit_turmeric_kg_kg"
  ),
  nomor_komoditas = c(1:4)
)

t54_final <- t54_full %>%
  right_join(tbl_komoditas, by = "name") %>%
  pivot_wider(names_from = tahun, values_from = value) %>%
  clean_names() %>%
  arrange(kecamatan_subdistrict, nomor_komoditas)


write_excel_csv2(t54_final, "Tabel_5.4.csv")

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

