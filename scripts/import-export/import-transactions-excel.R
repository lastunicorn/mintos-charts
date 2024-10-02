library(readxl)
library(tidyverse)
library(hms)

# ------------------------------------------------------------------------------
# Import transactions

mintos <- read_and_merge_excels(c(
  "data-raw/2023 - account statement.xlsx",
  "data-raw/2024 - account-statement.xlsx"
)) |> 
  janitor::clean_names() |> 
  mutate(
    date = as_datetime(date),
    time = as_hms(date),
    date = as_date(date),
    turnover = as.double(turnover),
    balance = as.double(balance)
  ) |> 
  relocate(time, .after = date) |> 
  convert_to_factor(payment_type, c(
    "Deposits",
    "Investment",
    "Principal received",
    "Interest received",
    "Interest received from loan repurchase",
    "Bonus",
    "Principal received from loan repurchase",
    "Secondary market transaction",
    "Secondary market transaction - discount or premium",
    "Tax withholding",
    "Delayed interest income on transit rebuy",
    "Late fees received",
    "Interest received from pending payments"
  ))
