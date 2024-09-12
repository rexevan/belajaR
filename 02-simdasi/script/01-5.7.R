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
  no_komoditas = c(1:6)
)


source("script/01-5.x-fungsi.R")
tbl_57 <- outer_50(lokasi_file, tbl_komoditas_57) |>
  mutate(tabel = "tbl_5.7")


write_rds(tbl_57, "output/rds/tbl_57.rds")











