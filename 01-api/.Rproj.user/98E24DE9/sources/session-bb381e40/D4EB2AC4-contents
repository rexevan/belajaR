library(tidyverse)


inflasi_all <- read_rds("output/rds/02-inflasi-y-on-y-per-sub-kelompok-per-kota.rds")

inflasi_selected <- inflasi_all |>
    select(
        isi_konten, 
        contains("_label"),
        -var_label
    )

inflasi_kakbkot <- inflasi_selected |>
    rename(
        inflasi = isi_konten,
        kabkot = vervar_label,
        kelompok = turvar_label, 
        tahun = tahun_label, 
        bulan = turtahun_label
    ) |>
    mutate(kabkot = str_to_title(kabkot)) |> 
    group_by(kabkot) |>
    nest() |>
    mutate(lokasi_penyimpanan_csv = paste0("output/csv/02-inflasi-", kabkot, ".csv"))


library(magrittr)

inflasi_kakbkot %$%
    walk2(.x = data, .y = lokasi_penyimpanan_csv, .f = ~ write_csv(.x, .y))




