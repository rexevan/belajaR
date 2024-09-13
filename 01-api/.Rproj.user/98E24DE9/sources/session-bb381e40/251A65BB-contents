library(tidyverse)

# Ambil dari Key akun masing-masing
# kunjungi https://webapi.bps.go.id/developer/ untuk daftar key API mu sendiri
api_key <- "3735d1f9790242bf0462a028e8016507"

# tautan dari situs web BPS 
# contoh, ini tuh dari https://sikkakab.bps.go.id/id/statistics-table/2/MjY5IzI=/andil-inflasi-y-on-y-kota-maumere--2022---100---persen-.html
link_tabel <- "https://webapi.bps.go.id/v1/api/list/model/data/lang/ind/domain/5310/var/269/key/WebAPI_KEY"

url <- paste0(
    link_tabel |> str_sub(1, -11),
    api_key
)

test <- httr::GET(url)
test$status_code

data <- test$content |>
    rawToChar() |> 
    jsonlite::fromJSON(flatten = TRUE)

names(data)

data$status
data$`data-availability`
data$vervar # kelompok digit ke-1
data$var # kelompok digit ke-2
data$turvar # kelompok digit ke-3
data$tahun # kelompok digit ke-4
data$turtahun # kelompok digit ke-5
data$datacontent
names(data$datacontent)
data$datacontent[[1]]



# tbl_jenis_header <- tibble(
#     turvar_cek = data$turvar$val |> all() > 0,
#     turtahun_cek = data$turtahun$val |> all() > 0,
#     jenis_header = 
#         case_when(0
#             turvar_cek == FALSE & turtahun_cek == FALSE ~ 1,
#             turvar_cek == TRUE  & turtahun_cek == FALSE ~ 2,
#             turvar_cek == FALSE & turtahun_cek == TRUE  ~ 3,
#             turvar_cek == TRUE  & turtahun_cek == TRUE  ~ 4
#         )
#     )

tambah_prefix <- function(tbl, prefix = "prefix_") {
    tbl |> tibble() |> rename_with(~ paste0(prefix, .x))
}


tbl_vervar <- data$vervar |> tambah_prefix("vervar_")
tbl_var <- data$var |> tambah_prefix("var_")
tbl_turvar <- data$turvar |> tambah_prefix("turvar_")
tbl_tahun <- data$tahun |> tambah_prefix("tahun_")
tbl_turtahun <- data$turtahun |> tambah_prefix("turtahun_")


tbl_konten_ori <- tibble(konten = data$datacontent) |>
    transmute(
        nama_konten = names(konten),
        isi_konten = map_dbl(konten, unlist) 
    )

# potong / separate variabel dan tahun terlebih dahulu

tahun_list <- tbl_tahun$tahun_val |> str_flatten(collapse = "|")
var_list <- tbl_var$var_val |> str_flatten(collapse = "|")


tbl_konten_parsed  <- tbl_konten_ori |>
    mutate(
         var_val = nama_konten |> str_extract(var_list),
         vervar_val = nama_konten |> str_split_i(var_val, i = 1),
         tahun_val = nama_konten |> str_split_i(var_val, i = 2) |> str_extract(tahun_list),
         turvar_val = nama_konten |> str_split_i(var_val, i = 2) |> str_split_i(tahun_val, 1),
         turtahun_val = nama_konten |> str_split_i(var_val, i = 2) |> str_split_i(tahun_val, 2)
    )

# Sekarang, join tabel separated dengan tabel-tabel var, vervar, tahun, dll.

tbl_konten_joined <- tbl_konten_parsed |>
    mutate(across(contains("_val"), ~ as.integer(.x))) |>
    left_join(tbl_var, by = join_by(var_val)) |>
    left_join(tbl_vervar, by = join_by(vervar_val)) |>
    left_join(tbl_turvar, by = join_by(turvar_val)) |>
    left_join(tbl_tahun, by = join_by(tahun_val)) |>
    left_join(tbl_turtahun, by = join_by(turtahun_val))

tbl_konten_joined


tbl_konten_arranged <- tbl_konten_joined |>
    select(
        nama_konten,
        isi_konten,
        vervar_val, var_val, turvar_val, tahun_val, turtahun_val,
        vervar_label, var_label, turvar_label, tahun_label, turtahun_label,
        everything()
    )


view(tbl_konten_arranged)
