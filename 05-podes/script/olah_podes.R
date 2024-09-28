library(tidyverse)


podes21 <- readxl::read_xlsx(Sys.getenv("DATA_PODES")) |>
  janitor::clean_names()

podes_summarise <- function(x, tbl_keterangan) {
  
  tbl_x <- podes21 |>
    select(
      contains("wil_code"),
      all_of(x)
    )
  
  tbl_summarised <- tbl_x |>
    summarise(jml_desa = n(), .by = c("wil_code_kec", all_of(x))) |>
    left_join(tbl_keterangan, x) |>
    mutate(wil_code_kec = paste0("T", wil_code_kec))
  
  return(tbl_summarised)
}


# 4.3.1  Banyaknya Desa Menurut Sumber Air Minum ---------------
# pertanyaan 507a

ket_507a <- tribble(
  ~r507a, ~r507a_ket,
  "01", "Air kemasan bermerek",
  "02", "Air isi ulang",
  "03", "Ledeng dengan meteran (PAM/PDAM)",
  "04", "Ledeng tanpa meteran",
  "05", "Sumur bor atau pompa",
  "06", "Sumur",
  "07", "Mata air",
  "08", "Sungai/danau/kolam/waduk/situ/embung/bendungan",
  "09", "Air hujan",
  "10", "Lainnya"
)

# podes_summarise("r507a", ket_507a) |>
#   write_csv("output/tbl_4.3.1_PODES21.csv")


podes_summarise("r507a", ket_507a)


# 4.3.3 Banyaknya desa menurut sumber penerangan jalan utama --------------
# pertanyaan 502c


ket_502c <- tribble(
  ~r502c, ~r502c_ket,
  "1", "Listrik diusahakan oleh pemerintah",
  "2", "Listrik diusahakan oleh non pemerintah",
  "3", "Non Listrik",
)
# 
# podes_summarise("r502c", ket_502c) |>
#   write_csv("output/tbl_4.3.3_PODES21.csv")


# 4.3.4 Banyakmya Desa menurut penggunaan fasilitas tempat buang air besar sebagaian besar keluarga 
# pertanyaan 505a


ket_r505a <- tribble(
  ~r505a, ~r05a_ket,
  "1", "Jamban Sendiri",
  "2", "Jamban Bersama",
  "3", "Jamban Umum",
  "4", "Bukan Jamban"
)


# podes_summarise("r505a", ket_r505a) |>
#   write_csv("output/tbl_4.3.4_PODES21.csv")


