library(tidyverse)
library(readxl)
library(janitor)

tbl56 <- function(tahun) {
  tahun <- tahun
  
  file_excel <- paste0("5.6 Produksi Tanaman/tabel-5-1-10-tahun-", tahun,"-kabupaten-sikka-09-07-2024.xlsx")
  
  tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25) %>%
    clean_names() %>%
    slice(-c(1:3))
  
  tbl_1_names <- names(tbl_1)[-1]
  
  tbl_2 <- tbl_1 %>%
    pivot_longer(cols = tbl_1_names) %>%
    mutate(tahun = tahun)
  
  
  return(tbl_2)
}

t20 <- tbl56("2020")
t21 <- tbl56("2021")
t22 <- tbl56("2022")
t23 <- tbl56("2023")

t56_full <- bind_rows(t20, t21, t22, t23)


tbl_komoditas <- tibble(
  name = c (
    "anggrek_pot_orchid_potted_orchid_pohon_tree"
    ,"anggrek_potong_cut_orchid_tangkai_stalks"
    ,"krisan_chrysantemum_tangkai_stalks"
    ,"mawar_rose_tangkai_stalks"
    ,"sedap_malam_tuberose_tangkai_stalks"
    ,"anthurium_bunga_flamingo_lily_flower_tangkai_stalks"
    ,"bugenvil_pohon_tree"
    ,"palem_palm_pohon_tree"
    ,"pedang_pedangan_sanseviera_rumpun_clumps"
    ,"pisang_pisangan_heliconia_tangkai_stalks"
    ,"puring_croton_pohon_tree"
    ,"soka_ixora_pohon_tree"
    ,"sri_rejeki_aglaonema_pohon_tree"
  ),
  nomor_komoditas = c(1:13)
)

t56_final <- t56_full %>%
  right_join(tbl_komoditas, by = "name") %>%
  pivot_wider(names_from = tahun, values_from = value) %>%
  clean_names() %>%
  arrange(kecamatan_subdistrict, nomor_komoditas) %>%
  select(-na)


write_excel_csv2(t56_final, "Tabel_5.6.csv")


library(tidyverse)
library(readxl)
library(janitor)


tbl55 <- function(tahun) {
  tahun <- tahun
  
  file_excel <- paste0("5.5 Luas Panen/tabel-5-1-9-tahun-", tahun,"-kabupaten-sikka-09-07-2024.xlsx")
  
  tbl_1 <- read_xlsx(file_excel, skip = 3, n_max = 25) %>%
    clean_names() %>%
    slice(-c(1:3))
  
  tbl_1_names <- names(tbl_1)[-1]
  
  tbl_2 <- tbl_1 %>%
    pivot_longer(cols = tbl_1_names) %>%
    mutate(tahun = tahun)
  
  
  return(tbl_2)
}

t20 <- tbl55("2020")
t21 <- tbl55("2021")
t22 <- tbl55("2022")
t23 <- tbl55("2023")

t55_full <- bind_rows(t20, t21, t22, t23)


tbl_komoditas <- tibble(
  name = c (
    "anggrek_pot_orchid_potted_orchid_m2_m2"
    ,"anggrek_potong_cut_orchid_m2_m2"
    ,"krisan_chrysantemum_m2_m2"
    ,"mawar_rose_m2_m2"
    ,"sedap_malam_tuberose_m2_m2"
    ,"anthurium_bunga_flamingo_lily_flower_m2_m2"
    ,"bugenvil_m2_m2"
    ,"palem_palm_pohon_tree"
    ,"pedang_pedangan_sanseviera_m2_m2"
    ,"pisang_pisangan_heliconia_m2_m2"
    ,"puring_croton_m2_m2"
    ,"soka_ixora_m2_m2"
    ,"sri_rejeki_aglaonema_m2_m2"
  ),
  nomor_komoditas = c(1:13)
)

t55_final <- t55_full %>%
  right_join(tbl_komoditas, by = "name") %>%
  pivot_wider(names_from = tahun, values_from = value) %>%
  clean_names() %>%
  arrange(kecamatan_subdistrict, nomor_komoditas)


write_excel_csv2(t55_final, "Tabel_5.5.csv")

# new script ----------------------------------

library(tidyverse)

lokasi_file <- "data/5.6 Produksi Tanaman/" 

tbl_komoditas_56 <- tibble(
  name = c (
    "anggrek_pot"
    ,"anggrek_potong"
    ,"krisan_chrysantemum"
    ,"mawar_rose"
    ,"sedap_malam"
    ,"anthurium_bunga"
    ,"bugenvil_pohon"
    ,"palem_palm"
    ,"pedang_pedangan"
    ,"pisang_pisangan"
    ,"puring_croton"
    ,"soka_ixora"
    ,"sri_rejeki"
  ),
  no_komoditas = c(1:13)
)


source("script/01-5.x-fungsi.R")
tbl_56 <- outer_50(lokasi_file, tbl_komoditas_56) |>
  mutate(tabel = "tbl_5.6")

write_rds(tbl_56, "output/rds/tbl_56.rds")







