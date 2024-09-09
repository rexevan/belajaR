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

lokasi_file <- "data/5.7 Produksi Buah dan Sayuran" 

tbl_komoditas_57 <- tibble(
  name = c (
     "mangga_mango"      
     ,"durian_durian"     
     ,"jeruk_siam"         
     ,"pisang_banana"      
     ,"pepaya_papaya"     
     ,"salak_snakefruit"   
    # ,"alpukat_avocado"    
    # ,"anggur_grape"       
    # ,"apel_apple"         
    # ,"belimbing_star"     
    # ,"duku_langsat"       
    # ,"jambu_air"          
    # ,"jambu_biji"         
    # ,"jengkol_jengkol"    
    # ,"jeruk_besar"        
    # ,"manggis_mangosteen" 
    # ,"markisa_konyal"     
    # ,"melinjo_gnetum"     
    # ,"nangka_cempedak"    
    # ,"nenas_pineapple"    
    # ,"petai_twisted"      
    # ,"rambutan_rambutan"  
    # ,"sawo_sapodilla"     
    # ,"sirsak_soursop"    
    # ,"sukun_breadfruit"  
  ),
  nomor_komoditas = c(1:6)
)


source("script/01-5.x-fungsi.R")
tbl_57 <- outer_50(lokasi_file, tbl_komoditas_57) |>
  mutate(tabel = "tbl_5.7")


write_rds(tbl_57, "output/rds/tbl_57.rds")











