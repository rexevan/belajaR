# new script -------------------------
library(tidyverse)

file_path <- "output/rds/"

tbl_rds <- tibble(rds = paste0(file_path, list.files(file_path))) |>
  transmute(
    rds = rds |> map(read_rds)
  ) |>
  unnest(rds) |>
  mutate(
    y2020 = y2020 |> replace_na("..."),
    y2021 = y2021 |> replace_na("..."),
    y2022 = y2022 |> replace_na("..."),
    y2023 = y2023 |> replace_na("...")
  )

write_rds(tbl_rds, "output/rds/tabel_bab_5.rds")
write_csv(tbl_rds, "output/csv/tabel_bab_5.csv")

