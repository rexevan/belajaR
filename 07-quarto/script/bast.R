# Persiapan
library(tidyverse)
library(googlesheets4)

source("script/terbilang.R")
source("script/identitas-ppk.R")

Sys.getenv("BUKU_AGENDA")
Sys.getenv("EXPORT_MITRA")

#googlesheets4::gs4_deauth()
#googlesheets4::gs4_auth()

# Data
tbl_mitra <- Sys.getenv("EXPORT_MITRA") |>
  readxl::read_xlsx() |>
  janitor::clean_names() |>
  select(
    mitra.sobat_id = sobat_id,
    mitra.nik = nik, 
    mitra.nama = nama, 
    mitra.status = status_seleksi_1_terpilih_2_tidak_terpilih,
    mitra.alamat = alamat_detail,
    alamat_prov:alamat_desa
  ) |>
  filter(mitra.status == "1")


tbl_mitra |> 
  mutate(
    kd_desa = str_c(alamat_prov, alamat_kab, alamat_kec, alamat_desa),
    kd_kec  = str_c(alamat_prov, alamat_kab, alamat_kec)
  )

tbl_bast <- Sys.getenv("BUKU_AGENDA") |>
  read_sheet(sheet = "BAST") |>
  filter(bast.tanggal > "2024-10-01") |>
  filter(kegiatan.kode_sobat == "SUSENAS24") |>
  mutate(mitra.sobat_id = mitra.sobat_id |> as.character()) |>
  left_join(tbl_mitra, join_by(mitra.sobat_id))

# 
# nrow(tbl_bast)
# ## Looping
# for (i in 1:nrow(tbl_bast)){
#  rmarkdown::render(input = "mail_merge_handout.Rmd",
#  output_format = "pdf_document",
#  output_file = paste("handout_", i, ".pdf", sep=''),
#  output_dir = "output/")
# }
# 




