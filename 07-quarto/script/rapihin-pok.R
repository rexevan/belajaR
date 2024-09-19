library(tidyverse)
library(unpivotr)

library(tidyr)

data_pok <- "data/POK/Report POK 1726702579191.xlsx"

pok_untidy <- readxl::read_xlsx(data_pok, skip = 6) |> 
    janitor::clean_names()

pok_filled <- pok_untidy |>
    fill(x1, x2, .direction = "down") |>
    group_by(x2) |>
    fill(x3, .direction = "down") |>
    group_by(x2, x3) |>
    fill(x4, .direction = "down") |>
    group_by(x2, x3, x4) |>
    fill(x5, .direction = "down") |>
    group_by(x2, x3, x4, x5) |>
    fill(x6, .direction = "down") |>
    group_by(x2, x3, x4, x5, x6) |>
    fill(x7, .direction = "down") |>
    ungroup()

pok_mutated <- pok_filled |>
    mutate(across(.cols = (x1:x7), ~ str_sub(.x, start = 2, end = -2))) |>
    mutate(across(.cols = (x2:x7), ~ replace_na(.x, ""))) |>
    mutate(across(.cols = (x2:x7), ~ str_squish(.x))) |>
    mutate(kode_anggaran = str_c(
        x1, ".", 
        x2, ".", 
        x3, ".",
        x4, ".",
        x5, ".",
        x6, ".", 
        x7) |> str_remove_all("(\\.\\.)")
    )



pok_selected <- pok_mutated |>
    select(
        kode_anggaran, 
        program_kegiatan_output_komponen_akun_detil,
        x9:sisa
    ) |>
    rename(
        ket_detil = x9,
        satuan = x11
    )


write_rds(pok_selected, "output/tbl_pok.rds")






