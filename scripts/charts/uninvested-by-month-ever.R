# ------------------------------------------------------------------------------
# Cash drag (uninvested amount) by month (ever)

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
  arrange(month_as_date) |> 
  ggplot(aes(x = month_as_date, y = uninvested_amount)) +
  geom_col() +
  geom_text(aes(label = format(round(uninvested_amount, 2), nsmall = 2)), vjust = -0.5, size = 3) +
  guides(x = guide_axis(angle = 60)) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y", minor_breaks = NULL) +
  labs(
    title = "Cash drag average (uninvested amount) by month (ever)",
    x = "Month",
    y = "Amount (€)"
  )

save_plot("uninvested-amount-by-month-ever.png")
