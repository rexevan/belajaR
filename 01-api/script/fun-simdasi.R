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

## Kode wilayah = 7 digit sampai level desa/kelurahan

bps_simdasi_kcda <- function(kode_wilayah, WebAPI_KEY = NULL) {
    
    if(is.null(kode_wilayah)){
        stop("kode_wilayah tidak boleh NULL")
    }
    
    if(is.null(WebAPI_KEY)) {
        WebAPI_KEY = Sys.getenv("WebAPI_KEY")
    } 
    WebAPI_KEY <- WebAPI_KEY
    
    url <- glue::glue(
        "https://webapi.bps.go.id/v1/api/interoperabilitas/datasource/simdasi/id/23/wilayah/{kode_wilayah}/key/{WebAPI_KEY}"    
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

bps_simdasi_tabel <- function(kode_wilayah, tahun, id_tabel, WebAPI_KEY = NULL) {
    
    if(is.null(kode_wilayah)){
        stop("kode_wilayah tidak boleh NULL")
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
    
    url <- glue::glue("{url_awal}wilayah/{kode_wilayah}/tahun/{tahun}/id_tabel/{id_tabel}/key/{WebAPI_KEY}/")
    
    get_url <- httr::GET(url)
    
    get_data <-
        get_url$content |>
        rawToChar() |> 
        jsonlite::fromJSON(flatten = TRUE)
    
    list_data <- get_data$data
    
    return(list_data)
}

## Data Transformation ----------------------------------------

















