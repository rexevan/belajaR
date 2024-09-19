library(tidyverse)

#https://github.com/ateucher/useful_code/blob/master/R/numbers2words.r
numbers2words <- function(x){
    ## Function by John Fox found here: 
    ## http://tolstoy.newcastle.edu.au/R/help/05/04/2715.html
    ## Tweaks by AJH to add commas and "and"
    ## Localization by Rexevan
    helper <- function(x){
      
      digits <- rev(strsplit(as.character(x), "")[[1]])
      nDigits <- length(digits)
      if (nDigits == 1) as.vector(ones[digits])
      else if (nDigits == 2)
        if (x <= 19) as.vector(teens[digits[1]])
      else trim(paste(tens[digits[2]],
                      Recall(as.numeric(digits[1]))))
      else if (nDigits == 3) trim(paste(ones[digits[3]], "ratus", 
                                        Recall(makeNumber(digits[2:1]))))
      else {
        nSuffix <- ((nDigits + 2) %/% 3) - 1
        if (nSuffix > length(suffixes)) stop(paste(x, "is too large!"))
        trim(paste(Recall(makeNumber(digits[
          nDigits:(3*nSuffix + 1)])),
          suffixes[nSuffix] ,
          Recall(makeNumber(digits[(3*nSuffix):1]))))
      }
    }
    trim <- function(text){
      #Tidy leading/trailing whitespace, space before comma
      text=gsub("^\ ", "", gsub("\ *$", "", gsub("\ ,",",", text)))
      #Clear any trailing " and"
      text=gsub(" and$","",text)
      #Clear any trailing comma
      gsub("\ *,$","",text)
    }  
    makeNumber <- function(...) as.numeric(paste(..., collapse=""))     
    #Disable scientific notation
    opts <- options(scipen=100) 
    on.exit(options(opts)) 
    ones <- c("", "satu", "dua", "tiga", "empat", "lima", "enam", "tujuh",
              "delapan", "sembilan") 
    names(ones) <- 0:9 
    teens <- c("sepuluh", "sebelas", "dua belas", "tiga belas", "empat belas", "lima belas",
               "enam belas", "tujuh belas", "delapan belas", "sembilan belas")
    names(teens) <- 0:9 
    tens <- c("dua puluh", "tiga puluh", "empat puluh", "lima puluh", "enam puluh", "tujuh puluh", 
              "delapan puluh", "sembilan puluh") 
    names(tens) <- 2:9 
    x <- round(x)
    suffixes <- c("ribu", "juta", "miliar", "triliun")     
    if (length(x) > 1) return(trim(sapply(x, helper)))
    helper(x)
  }
  

terbilang <- function(x) {
  y <- x |>
    numbers2words() |>
    stringr::str_replace_all("satu ratus", "seratus") |>
    stringr::str_replace_all("satu ribu", "seribu")
  
  return(y)
}



terbilang_uang <- function(x) {
    y <- x |> terbilang() |> paste0(" rupiah")
    return(y)
}

terbilang_tanggal <- function(txt_dmy) {
    
    if(!is_character(txt_dmy)) {
        stop("txt_dmy harus minimal karakter")
    }
    
    x <- txt_dmy |> as_date()
    
    txt_hari    <- x |> wday(label = TRUE, abbr = FALSE, locale = "IND") |> str_to_lower()
    txt_tanggal <- x |> day() |> terbilang()
    txt_tahun   <- x |> year() |> terbilang()
    txt_bulan   <- x |> month(label = TRUE, abbr = FALSE, locale = "IND") |> str_to_lower()
    
    y <- str_glue("{txt_hari}, tanggal {txt_tanggal}, bulan {txt_bulan}, tahun {txt_tahun}")
    
    return(y)
}
  