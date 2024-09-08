library(stringr)
library(magrittr)

# Ambil dari Key akun masing-masing
# kunjungi https://webapi.bps.go.id/developer/ untuk daftar key API mu sendiri
api_key <- "3735d1f9790242bf0462a028e8016507"

# tautan dari situs web BPS 
link_tabel <- "https://webapi.bps.go.id/v1/api/list/model/data/lang/ind/domain/0000/var/2251/key/WebAPI_KEY"

"https://webapi.bps.go.id/v1/api/list/model/data/lang/ind/domain/0000/var/2250/key/WebAPI_KEY"
"https://webapi.bps.go.id/v1/api/list/model/data/lang/ind/domain/0000/var/2260/key/WebAPI_KEY"


url <- paste0(
    link_tabel |> str_sub(1, -11),
    api_key
)

get_url <- httr::GET(url)

get_data <- get_url %$%
    content |>
    rawToChar() |> 
    jsonlite::fromJSON(flatten = TRUE)

source("script/03-bikin-fungsi.R")

tbl_bps <- list_to_tabular_bps(get_data)

library(readr)
get_data$var$label |> str_to_lower() |> word(1, 5) |> str_remove_all(",") |> str_replace_all(" ", "-")
output_names <- paste0("output/rds/01-", topik, ".rds")
write_rds(tbl_bps, output_names)


