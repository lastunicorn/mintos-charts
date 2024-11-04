# ------------------------------------------------------------------------------
# Interest by day (ever)

mintos |> 
  filter(payment_type %in% c(
    "Interest received",
    "Interest received from loan repurchase",
    "Delayed interest income on transit rebuy",
    "Late fees received",
    "Interest received from pending payments")
  ) |>
  group_by(date) |> 
  arrange(date) |> 
  summarize(
    profit = sum(turnover)
  ) |> 
  ggplot(aes(x = date)) +
  geom_col(aes(y = profit)) +
  #geom_smooth(aes(y = profit), method = 'loess', formula = 'y ~ x') +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y", minor_breaks = NULL) +
  guides(x = guide_axis(angle = 60)) +
  labs(
    title = "Interest amount by day (ever)",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("interest-amount-01-by-day-ever.png")
