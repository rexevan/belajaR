

json_to_tabular_simdasi_4.x <- function(file_path = file_path) {

  pacman::p_load(tidyverse)
  pacman::p_load(tidyjson)
  
  test_json <- read_json(file_path)
  
  woah <- test_json$..JSON[[1]]
  
  tbl_keterangam_data <- tibble(
    simbol = woah$keterangan_data |> unlist() |> names(),
    ket_simbol = woah$keterangan_data |> unlist()
  )
  
  tbl_kolom <- tibble(
    kolom = woah$kolom |> unlist() |> names(),
    ket_kolom = woah$kolom |> unlist()
  ) |> 
    separate(col = kolom, into = c("kode", "kolom"), sep = "\\.") |>
    pivot_wider(names_from = kolom, values_from = ket_kolom)
  
  
  tbl_data <- woah$data |> spread_all() |> as_tibble() |> 
    pivot_longer(cols = contains("variables")) |>
    separate(name, into = c("variables", "kode", "kolom"), sep = "\\.") |>
    pivot_wider(names_from = kolom, values_from = value)
  
  tbl_data_selected <- tbl_data |>
    select(document.id, label, kode_wilayah, kode, value)
  
  tbl_joined <- tbl_data |> 
    left_join(tbl_kolom, join_by(kode)) |>
    select(document.id, label, kode_wilayah, nama_variabel, value) |>
    mutate(tahun_pendidikan = "2023/2024")  
  
  return(tbl_joined)
  
}



