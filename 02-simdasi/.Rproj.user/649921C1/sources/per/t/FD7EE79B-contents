library(tidyverse)
library(readxl)
library(janitor)

tahun <- "2023"

file_excel <- paste0("5.3 Luas Panen/tabel-5-1-5-tahun-", tahun,"-kabupaten-sikka-09-07-2024.xlsx")
"5.3 Luas Panen/tabel-5-1-5-tahun-2023-kabupaten-sikka-09-07-2024.xlsx"

tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25) %>%
  clean_names() %>%
  slice(-c(1:3))

tbl_1_names <- names(tbl_1)[-1]

tbl_2 <- tbl_1 %>%
  pivot_longer(cols = tbl_1_names) %>%
  mutate(tahun = tahun)

tbl53 <- function(tahun) {
  tahun <- tahun
  
  file_excel <- paste0("5.3 Luas Panen/tabel-5-1-5-tahun-", tahun,"-kabupaten-sikka-09-07-2024.xlsx")
  
  tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25) %>%
    clean_names() %>%
    slice(-c(1:3))
  
  tbl_1_names <- names(tbl_1)[-1]
  
  tbl_2 <- tbl_1 %>%
    pivot_longer(cols = tbl_1_names) %>%
    mutate(tahun = tahun)
  
  
  return(tbl_2)
}

t20 <- tbl53("2020")
t21 <- tbl53("2021")
t22 <- tbl53("2022")
t23 <- tbl53("2023")

t53_full <- bind_rows(t20, t21, t22, t23)


tbl_komoditas <- tibble(
  name = c (
    "jahe_ginger_m2_m2"
    ,"laos_lengkuas_galanga_m2_m2"
    ,"kencur_east_indian_galangal_m2_m2"
    ,"kunyit_turmeric_m2_m2"
  ),
  nomor_komoditas = c(1:4)
)

t53_final <- t53_full %>%
  right_join(tbl_komoditas, by = "name") %>%
  pivot_wider(names_from = tahun, values_from = value) %>%
  clean_names() %>%
  arrange(kecamatan_subdistrict, nomor_komoditas)


write_excel_csv2(t53_final, "Tabel_5.3.csv")




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
  nomor_komoditas = c(1:4)
)


source("script/01-5.x-fungsi.R")
tbl_53 <- outer_50(lokasi_file, tbl_komoditas_53) |>
  mutate(tabel = "tbl_5.3")

write_rds(tbl_53, "output/rds/tbl_53.rds")






