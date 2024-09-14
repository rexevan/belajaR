

bps_dt_list2tbl <- function(data = list_data) {
    pacman::p_load(tidyverse)
    
    tambah_prefix <- function(tbl, prefix = "prefix_") {
        tbl |> tibble() |> rename_with(~ paste0(prefix, .x))
    }
    
    # ambil satu-satu tabel dari list data
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
    
    tbl_konten_arranged <- tbl_konten_joined |>
        select(
            nama_konten,
            isi_konten,
            vervar_val, var_val, turvar_val, tahun_val, turtahun_val,
            vervar_label, var_label, turvar_label, tahun_label, turtahun_label,
            everything()
        )    
    
    return(tbl_konten_arranged)
    }


bps_dt_url2list <- function(Endpoint_WebAPI, WebAPI_KEY = NULL) {

    if(is.null(WebAPI_KEY)) {
        WebAPI_KEY = Sys.getenv("WebAPI_KEY")
    } 
    
    WebAPI_KEY <- WebAPI_KEY
    
    url <- sub(x = Endpoint_WebAPI, pattern = "WebAPI_KEY", WebAPI_KEY)
    
    get_url <- httr::GET(url)
    
    get_data <-
        get_url$content |>
        rawToChar() |> 
        jsonlite::fromJSON(flatten = TRUE)
    
    get_data
}


bps_dt_get <- function(Endpoint_WebAPI, WebAPI_KEY = NULL) {
    
    if(is.null(WebAPI_KEY)) {
        WebAPI_KEY = Sys.getenv("WebAPI_KEY")
    } 
    
    WebAPI_KEY <- WebAPI_KEY
    
    list_data <- bps_dt_url2list(Endpoint_WebAPI, WebAPI_KEY)
    
    tbl_bps <- bps_dt_list2tbl(list_data)
    
    return(tbl_bps)
}


