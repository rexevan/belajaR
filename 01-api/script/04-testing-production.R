library(stringr)
library(magrittr)

source("script/03-bikin-fungsi.R")

link <- "https://webapi.bps.go.id/v1/api/list/model/data/lang/ind/domain/0000/var/1715/key/WebAPI_KEY"
api_key <- Sys.getenv("WebAPI_KEY")



tbl_bps <- tbl_dinamis_bps(
    link_json = link,
    WebAPI_Key = api_key
    )



