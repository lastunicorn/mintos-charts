# ------------------------------------------------------------------------------
# Interest by day (per year)

mintos |> 
  filter(payment_type %in% c(
    "Interest received",
    "Interest received from loan repurchase",
    "Delayed interest income on transit rebuy",
    "Late fees received",
    "Interest received from pending payments")
  ) |>
  add_row(
    date = as.Date("2023-01-01"),
    turnover = 0
  ) |>
  add_row(
    date = as.Date("2024-12-31"),
    turnover = 0
  ) |>
  group_by(date) |> 
  arrange(date) |> 
  summarize(
    profit = sum(turnover)
  ) |> 
  mutate(
    year = year(date)
  ) |> 
  ggplot(aes(x = date)) +
  geom_col(aes(y = profit)) +
  facet_wrap(~ year, ncol = 1, scales = "free_x") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", minor_breaks = NULL) +
  labs(
    title = "Interest amount by day (per year)",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("interest-amount-by-day-per-year.png")
