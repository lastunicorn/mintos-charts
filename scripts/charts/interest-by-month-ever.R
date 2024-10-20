# ------------------------------------------------------------------------------
# Interest by month (ever)

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
  arrange(month_as_date) |> 
  ggplot(aes(x = month_as_date, y = profit)) +
  geom_col() +
  geom_text(aes(label = round(profit, 2)), size = 3, vjust = -0.5) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y", minor_breaks = NULL) +
  guides(x = guide_axis(angle = 60)) +
  labs(
    title = "Interest amount by month (ever)",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("interest-amount-by-month-ever.png")
