library(tidyverse)
library(readxl)
library(janitor)
library(tidyr)





fun412 <- function(tingkat, tahun) {
  judul <- c(
    kecamatan = "x1"
    ,sekolah_negeri = "x2"
    ,sekolah_swasta = "x3"
    ,sekolah_total = "x4"
    ,guru_negeri = "x5"
    ,guru_swasta = "x6"
    ,guru_total = "x7"
    ,murid_negeri = "x8"
    ,murid_swasta = "x9"
    ,murid_total = "x10"
  )

  tingkatan <- c(
    TK = 1, RA = 2, SD = 3, MI = 4, SMP = 5, MTs = 6, SMA = 7, SMK = 8, MA = 9
  )
  
  tbl_excel <- paste0("4.1.2 Jumlah Sekolah/tabel-4-1-",tingkatan[tingkat],"-tahun-", tahun ,"-kabupaten-sikka-09-07-2024.xlsx") %>%
    read_xlsx(skip = 6, n_max = 22) %>%
    clean_names() %>%
    rename(all_of(judul))
  
  tbl_tingkat <- tbl_excel %>%
    pivot_longer(sekolah_negeri:murid_total, names_to = "jenis", values_to = "jumlah") %>%
    mutate(
      tingkat_nama = tingkat,
      tingkat_angka = tingkatan[tingkat], 
      TA = paste0("TA_", tahun, "_", tahun+1)
    )
  return(tbl_tingkat)
  
}

# Tingkatan ------------

tahun <- 2022
SD22 <- fun412("SD", tahun)
MI22 <- fun412("MI", tahun)
SMP22 <- fun412("SMP", tahun)
MTS22 <- fun412("MTs", tahun)
SMA22 <- fun412("SMA", tahun)
SMK22 <- fun412("SMK", tahun)
MA22 <- fun412("MA", tahun)

tahun <- 2023

SD23 <- fun412("SD", tahun)
MI23 <- fun412("MI", tahun)
SMP23 <- fun412("SMP", tahun)
MTS23 <- fun412("MTs", tahun)
SMA23 <- fun412("SMA", tahun)
SMK23 <- fun412("SMK", tahun)
MA23 <- fun412("MA", tahun)

tbl_full <- bind_rows(
  SD22, MI22, SMP22, MTS22, SMA22, SMK22, MA22,
  SD23, MI23, SMP23, MTS23, SMA23, SMK23, MA23
)

tbl412_final <- tbl_full %>%
  separate(col = jenis, into = c("tabel", "jenis"), sep = "_") %>%
  unite(jenis, TA, col = "baris", sep = "_") %>%
  pivot_wider(names_from = baris, values_from = jumlah) %>%
  select(
    kecamatan, tabel, tingkat_nama, tingkat_angka,
    negeri_TA_2022_2023, negeri_TA_2023_2024,
    swasta_TA_2022_2023, swasta_TA_2023_2024,
    total_TA_2022_2023, total_TA_2023_2024,
  ) %>%
  arrange(kecamatan, tabel, tingkat_angka)



write_excel_csv2(tbl412_final, "Tabel_412_413_414_siap.csv")


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
