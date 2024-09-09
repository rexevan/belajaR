library(tidyverse)
library(readxl)
library(janitor)

tbl57 <- function(tahun) {
  tahun <- tahun
  
  file_excel <- paste0("5.7 Produksi Buah dan Sayuran//tabel-5-1-13-tahun-", tahun,"-kabupaten-sikka-09-07-2024.xlsx")
  
  tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25) %>%
    clean_names() %>%
    slice(-c(1:3))
  
  tbl_1_names <- names(tbl_1)[-1]
  
  tbl_2 <- tbl_1 %>%
    pivot_longer(cols = tbl_1_names) %>%
    mutate(tahun = tahun)
  
  
  return(tbl_2)
}

t20 <- tbl57("2020")
t21 <- tbl57("2021")
t22 <- tbl57("2022")
t23 <- tbl57("2023")

t57_full <- bind_rows(t20, t21, t22, t23)


tbl_komoditas <- tibble(
  name = c (
    "mangga_mango_kw_qui"
    ,"durian_durian_kw_qui"
    ,"jeruk_siam_keprok_orange_tangerine_kw_qui"
    ,"pisang_banana_kw_qui"
    ,"pepaya_papaya_kw_qui"
    ,"salak_snakefruit_kw_qui"
    ,"alpukat_avocado_kw_qui"
    ,"jambu_biji_guava_kw_qui"
    ,"nangka_cempedak_jackfruit_kw_qui"
    ,"nenas_pineapple_kw_qui"
    ,"rambutan_rambutan_kw_qui"
    ,"salak_snakefruit_kw_qui"
    ,"sirsak_soursop_kw_qui"
  ),
  nomor_komoditas = c(1:13)
)

t57_final <- t57_full %>%
  right_join(tbl_komoditas, by = "name") %>%
  pivot_wider(names_from = tahun, values_from = value) %>%
  clean_names() %>%
  arrange(kecamatan_subdistrict, nomor_komoditas)


write_excel_csv2(t57_final, "Tabel_5.7.csv")
