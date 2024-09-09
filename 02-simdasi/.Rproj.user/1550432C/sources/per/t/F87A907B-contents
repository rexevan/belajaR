library(tidyverse)
library(readxl)
library(janitor)

tbl52 <- function(tahun) {
  tahun <- tahun
  
  file_excel <- paste0("5.2 Produksi/tabel-5-1-2-tahun-", tahun, "-kabupaten-sikka-09-07-2024.xlsx")
  
  tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25, col_types = "text") %>%
    clean_names() %>%
    slice(-c(1:3))
  
  tbl_1_names <- names(tbl_1)[-1]
  
  tbl_2 <- tbl_1 %>%
    pivot_longer(cols = tbl_1_names) %>%
    mutate(tahun = tahun)
  
  
  return(tbl_2)
}


t20 <- tbl52("2020")
t21 <- tbl52("2021")
t22 <- tbl52("2022")
t23 <- tbl52("2023")

t52_full <- bind_rows(t20, t21, t22, t23)

tbl_komoditas <- tibble(
  name = c (
    "bawang_merah_shallots_kw_qui"
    ,"cabai_besar_chili_big_chili_kw_qui"
    ,"cabai_keriting_chili_curly_chili_kw_qui"
    ,"cabai_rawit_chili_cayenne_pepper_kw_qui"
    ,"kentang_potato_kw_qui"
    ,"kubis_cabbage_kw_qui"
    ,"tomat_tomato_kw_qui"
    ,"bawang_putih_garlic_kw_qui"
  ),
  nomor_komoditas = c(1:8)
)

t52_final <- t52_full %>%
  right_join(tbl_komoditas, by = "name") %>%
  pivot_wider(names_from = tahun, values_from = value) %>%
  clean_names() %>%
  arrange(kecamatan_subdistrict, nomor_komoditas)


write_excel_csv2(t52_final, "Tabel_5.2.csv")