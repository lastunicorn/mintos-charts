# ------------------------------------------------------------------------------
# Interest by month (per year)

mintos |> 
  filter(payment_type %in% c(
    "Interest received",
    "Interest received from loan repurchase",
    "Delayed interest income on transit rebuy",
    "Late fees received",
    "Interest received from pending payments")
  ) |>
  mutate(
    month_as_date = floor_date(date, "month")
  ) |> 
  group_by(month_as_date) |> 
  summarize(
    profit = sum(turnover)
  ) |> 
  add_row(
    month_as_date = generate_monthly_dates(mintos.first_year_as_date, mintos.last_year_as_date + months(11))
  ) |> 
  arrange(month_as_date) |> 
  mutate(
    year = factor(year(month_as_date)),
    month = factor(month(month_as_date))
  ) |> 
  ggplot(aes(x = month, y = profit)) +
  geom_col(width = .7) +
  geom_text(aes(label = round(profit, 2)), size = 3, vjust = -0.5) +
  facet_wrap(~ year, ncol = 1, scales = "free_x") +
  scale_x_discrete(labels = month.abb) +
  labs(
    title = "Interest amount by month (per year)",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("interest-amount-04-by-month-by-year.png")
