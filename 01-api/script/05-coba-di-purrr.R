# Coba ambil angka inflasi kota-kota se Indonesia berdasarkan sub kelompok 


# https://www.bps.go.id/id/statistics-table/2/MjI1MCMy/inflasi-tahunan--y-on-y---2022-100--menurut-kelompok-dan-sub-kelompok-01-makanan--minuman-dan-tembakau.html
# https://www.bps.go.id/id/statistics-table/2/MjI2MCMy/inflasi-tahunan--y-on-y---2022-100--menurut-kelompok-dan-sub-kelompok-11-perawatan-pribadi-dan-jasa-lainnya.html

library(tidyverse)


api_key <- "3735d1f9790242bf0462a028e8016507"


get_data_json <- function(get_url) {
    library(tidyverse)
    library(magrittr)
    y <- get_url %$%
        content |>
        rawToChar() |> 
        jsonlite::fromJSON(flatten = TRUE)
    
    return(y)
}


tbl_url <- tibble(a = 2250:2260) |>
    transmute(
        url = paste0("https://webapi.bps.go.id/v1/api/list/model/data/lang/ind/domain/0000/var/", a,"/key/", api_key)
    ) |>
    mutate(
        get_url = map(url, \(x) httr::GET(x))
    ) |>
    mutate(
        get_data = map(get_url, \(x) get_data_json(x))
    )

tbl_url


source("script/03-bikin-fungsi.R")

tbl_data <- tbl_url |> 
    transmute(
        tabular_data = map(get_data, \(x) list_to_tabular_bps(x))
    ) |>
    unnest(cols = tabular_data)


write_rds(tbl_data, "output/rds/02-inflasi-y-on-y-per-sub-kelompok-per-kota.rds")




