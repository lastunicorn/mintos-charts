# ------------------------------------------------------------------------------
# Cash drag amount by month (per year)

mintos |> 
  group_by(date) |> 
  arrange(time) |> 
  summarize(
    uninvested_amount = last(balance)
  ) |> 
  mutate(
    month_as_date = floor_date(date, "month"),
    days_in_month = lubridate::days_in_month(date)
  ) |> 
  group_by(month_as_date) |>
  summarize(
    uninvested_amount = sum(uninvested_amount) / first(days_in_month)
  ) |> 
  add_row(
    month_as_date = generate_monthly_dates(mintos.first_year_as_date, mintos.last_year_as_date + months(11))
  ) |>
  mutate(
    year = year(month_as_date),
    month = factor(month(month_as_date))
  ) |>
  arrange(month_as_date) |> 
  ggplot(aes(x = month, y = uninvested_amount)) +
  geom_col(width = .7) +
  geom_text(aes(label = format(round(uninvested_amount, 2), nsmall = 2)), vjust = -0.5, size = 3) +
  facet_wrap(~ year, ncol = 1, scales = "free_x") +
  #guides(x = guide_axis(angle = 60)) +
  #scale_x_date(date_breaks = "1 month", date_labels = "%b %Y", minor_breaks = NULL) +
  scale_x_discrete(labels = month.abb) +
  labs(
    title = "Cash drag amount by month (per year)",
    x = "Month",
    y = "Amount (€)"
  )

save_plot("uninvested-amount-04-by-month-per-year.png")
