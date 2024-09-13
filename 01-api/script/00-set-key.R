

bps_set_key <- function(WebAPI_KEY = NULL) {
    if (is.null(WebAPI_KEY)) {
        key <- askpass::askpass("Masukkan WebAPI KEY:")
    }
    Sys.setenv(WebAPI_KEY = key)
}
