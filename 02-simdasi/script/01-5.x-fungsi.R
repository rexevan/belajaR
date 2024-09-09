
# fungsi untuk baca data, lalu ubah ke bentuk pivot longer

convert_50 <- function(txt_path, txt_komoditas) {
  library(tidyverse)
  
  tbl_input <- txt_path |> 
    readxl::read_xlsx(skip = 3, n_max = 25) %>%
    janitor::clean_names() %>%
    slice(-c(1:3))
  
  
  tbl_output <- tbl_input |>
    select(kecamatan_subdistrict, contains(txt_komoditas)) |>
    pivot_longer(cols = -kecamatan_subdistrict, names_to = "komoditas", values_to = "nilai")
  
  return(tbl_output)
}



outer_50 <- function(lokasi_file, tbl_komoditas) {
  y <- tibble(lokasi = paste0(lokasi_file, "/", list.files(lokasi_file))) |>
    transmute(
      tahun = lokasi |> str_extract("tahun-[0-9]{4}") |> str_extract("[0-9]{4}") %>% paste0("y", .),
      a = map(.x = lokasi, .f = ~ convert_50(.x, tbl_komoditas$name))
    ) |> 
    unnest(a) |>
    pivot_wider(names_from = tahun, values_from = nilai)  |> 
    mutate(
      name = komoditas |> str_replace_all("_", " ") |> word(1, 2) |> str_replace_all(" ", "_")
    ) |>
    left_join(tbl_komoditas, join_by(name))
  
  return(y)
}