
library(tidyverse)
source("script/00-set-key.R")
bps_set_key()


## Daftar Tabel DDA -------------------------

bps_simdasi_dda <- function(WebAPI_KEY = NULL) {
    
    if(is.null(WebAPI_KEY)) {
        WebAPI_KEY = Sys.getenv("WebAPI_KEY")
    } 
    WebAPI_KEY <- WebAPI_KEY
    
    url <- glue::glue(
        "https://webapi.bps.go.id/v1/api/interoperabilitas/datasource/simdasi/id/34/key/{WebAPI_KEY}"
    )
    
    get_url <- httr::GET(url)
    
    get_data <-
        get_url$content |>
        rawToChar() |> 
        jsonlite::fromJSON(flatten = TRUE)
    
    tbl_simdasi <- get_data$data$data[[2]] |> tibble()
    
    return(tbl_simdasi)
    
}


## Daftar Tabel KCDA -------------------------


bps_simdasi_kcda <- function(kode_satker = NULL, WebAPI_KEY = NULL) {
    
    if(is.null(kode_satker)){
        stop("kode_satker tidak boleh NULL")
    }
    
    if(is.null(WebAPI_KEY)) {
        WebAPI_KEY = Sys.getenv("WebAPI_KEY")
    } 
    WebAPI_KEY <- WebAPI_KEY
    
    url <- glue::glue(
        "https://webapi.bps.go.id/v1/api/interoperabilitas/datasource/simdasi/id/23/wilayah/{kode_satker}000/key/{WebAPI_KEY}"    
        )
    
    get_url <- httr::GET(url)
    
    get_data <-
        get_url$content |>
        rawToChar() |> 
        jsonlite::fromJSON(flatten = TRUE)
    
    tbl_simdasi <- get_data$data$data[[2]] |> tibble()
    
    return(tbl_simdasi)
    
}


## Mengakses tabel SIMDASI ----------------------------------

## Untuk mengakses tabel SIMDASI, kita butuh id_tabel, dan tahun 

bps_simdasi_tabel <- function(kode_satker, tahun, id_tabel, WebAPI_KEY = NULL) {
    
    if(is.null(kode_satker)){
        stop("kode_satker tidak boleh NULL")
    }
    
    if(is.null(tahun)){
        stop("tahun tidak boleh NULL")
    }
    
    if(is.null(id_tabel)){
        stop("id_tabel tidak boleh NULL")
    }
    
    if(is.null(WebAPI_KEY)) {
        WebAPI_KEY = Sys.getenv("WebAPI_KEY")
    } 
    WebAPI_KEY <- WebAPI_KEY
    
    url_awal <- "https://webapi.bps.go.id/v1/api/interoperabilitas/datasource/simdasi/id/25/"
    
    url <- glue::glue("{url_awal}wilayah/{kode_satker}000/tahun/{tahun}/id_tabel/{id_tabel}/key/{WebAPI_KEY}/")
    
    get_url <- httr::GET(url)
    
    get_data <-
        get_url$content |>
        rawToChar() |> 
        jsonlite::fromJSON(flatten = TRUE)
    
    list_data <- get_data$data
    
    return(list_data)
}



tbl_list <- bps_simdasi_tabel(kode_satker = 5310, tahun = 2023, id_tabel = "UFpWMmJZOVZlZTJnc1pXaHhDV1hPQT09") |>
    slice(2) |>
    tibble()

## Data Transformation -----------------------------------------
tbl_list

tbl_list |> select(contains("keterangan_data"))
tbl_list |> select(contains("variabel"))
tbl_list |> select(contains("kolom"))

tbl_list |> 
    select(data) |> 
    unnest(cols = data)


tbl_simdasi <- get_data$data$data[[2]] |> tibble()

tbl_simdasi
