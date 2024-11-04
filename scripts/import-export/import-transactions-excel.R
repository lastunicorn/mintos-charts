library(readxl)
library(hms)

# ------------------------------------------------------------------------------
# Import transactions

mintos <- read_and_merge_excels(
  file.path(config.import_dir, list.files(config.import_dir, pattern = "account-statement.*\\.xlsx$"))
) |> 
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
    "Interest received from pending payments",
    "Mintos Core fee"
  ))


# ------------------------------------------------------------------------------
# Calculate important values

mintos.first_date <- min(mintos$date)
mintos.last_date <- max(mintos$date)

mintos.first_month_as_date <- floor_date(mintos.first_date, "month")
mintos.last_month_as_date <- floor_date(mintos.last_date, "month")

mintos.first_year_as_date <- floor_date(mintos.first_date, "year")
mintos.last_year_as_date <- floor_date(mintos.last_date, "year")