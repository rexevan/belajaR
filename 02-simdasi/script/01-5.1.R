library(tidyverse)
library(readxl)
library(janitor)

tahun <- paste0("tabel-5-1-1-tahun-", "*2023.*")

list.files("5.1 Luas Panen/") |> str_extract(tahun)

file_excel <- paste0("data/5.1 Luas Panen/tabel-5-1-1-tahun-",tahun,"-kabupaten-sikka-09-07-2024.xlsx")

tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25) %>%
  clean_names() %>%
  slice(-c(1:3))

tbl_1_names <- names(tbl_1)[-1]

tbl_2 <- tbl_1 %>%
pivot_longer(cols = tbl_1_names) %>%
  mutate(tahun = tahun)


tbl51 <- function(tahun) {
  tahun <- tahun
  
  file_excel <- paste0("data/5.1 Luas Panen/tabel-5-1-1-tahun-",tahun,"-kabupaten-sikka-09-07-2024.xlsx")
  
  tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25, col_types = "text") %>%
    clean_names() %>%
    slice(-c(1:3))
  
  tbl_1_names <- names(tbl_1)[-1]
  
  tbl_2 <- tbl_1 %>%
    pivot_longer(cols = tbl_1_names) %>%
    mutate(tahun = tahun)

  
  return(tbl_2)
}


t20 <- tbl51("2020")
t21 <- tbl51("2021")
t22 <- tbl51("2022")
t23 <- tbl51("2023")

t51_full <- bind_rows(t20, t21, t22, t23)

tbl_komoditas <- tibble(
name = c (
"bawang_merah_shallots_ha_ha"
,"cabai_besar_chili_big_chili_ha_ha"
,"cabai_keriting_chili_curly_chili_ha_ha"
,"cabai_rawit_chili_cayenne_pepper_ha_ha"
,"kentang_potato_ha_ha"
,"kubis_cabbage_ha_ha"
,"tomat_tomato_ha_ha"
,"bawang_putih_garlic_ha_ha"
),
nomor_komoditas = c(1:8)
)



t51_final <- t51_full %>%
  right_join(tbl_komoditas, by = "name") %>%
  pivot_wider(names_from = tahun, values_from = value) %>%
  clean_names() %>%
  arrange(kecamatan_subdistrict, nomor_komoditas)

write_excel_csv2(t51_final, "Tabel_5.1.csv")
